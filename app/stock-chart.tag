<stock-chart>
  <div id="chart" style="width:100%; height:400px;"></div>

  <script>
    this.series = [];
    
    const apiUrl = 'https://query.yahooapis.com/v1/public/yql?format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&q=';
    const buildQuery = (
      symbol,
      startDate = moment().subtract(1, 'years').toDate(),
      endDate   = new Date()) => `select * from yahoo.finance.historicaldata where symbol = "${symbol}" and startDate = "${moment(startDate).format('YYYY-MM-DD')}" and endDate = "${moment(endDate).format('YYYY-MM-DD')}"`;

    const mapStockData = data => {
      if (!data.query.results) return;
      const quotes = data.query.results.quote;
      const mapped = quotes.map(quote => ({
        name: quote.Symbol,
        data: [+new Date(quote.Date), +quote.Close]
      }));
      const series = mapped.reduce((prev, curr) => {
        const index = prev.findIndex(item => item.name === curr.name);
        if (index > -1) {
          prev[index].data.push(curr.data);
        } else {
          prev.push({
            name: curr.name,
            data: [curr.data],
            tooltip: {
              valueDecimals: 2,
            },
            color: "#"+((1<<24)*Math.random()|0).toString(16)
          });
        };
        return prev;
      }, this.series)
      for (const item of series) {
        item.data.sort((x, y) => x[0] - y[0]);
      }
      this.update({series});
    }

    fetchStock(code) {
      const query = encodeURIComponent(buildQuery(code));
      const url = apiUrl + query;
      $.getJSON(url, mapStockData);
    }

    opts.on('initial-stocks', stocks => {
      for (const code of stocks) {
        this.fetchStock(code);
      }
    });

    opts.on('add-stock', code => {
      this.fetchStock(code);
    });

    opts.on('remove-stock', code => {
      const index = this.series.findIndex(s => s.name === code);
      this.series.splice(index, 1);
      this.update();
    });

    this.on('update', () => {
      chart = new Highcharts.StockChart({
        chart: {
          renderTo: this.chart,
          type: 'line',
        },
        rangeSelector : { selected : 4 },
        title : { text : 'Stocks' },
        series : this.series,
      });
    })
  </script>
</stock-chart>

