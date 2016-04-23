<stock-list>
  <style scoped>
    ul {
      list-style: none;
      display: flex;
      flex-direction: row;
    }
    li {
      width: 200px;
      height: 100px;
      background: #20B7D4;
      color: white;
      text-shadow: 0 0 5px black;
      padding: 20px;
      position: relative;
      margin-right: 10px;
    }
    li button {
      background: #7B1616;
      color: white;
      border: none;
      position: absolute;
      top: 5;
      right: 5;
      cursor: pointer;
      padding: 8px;
    }
  </style>

  <ul>
    <li each={ code in stocks }>
      <h4>{ code }</h4>
      <button onclick={ parent.remove }>X</button>
    </li>
  </ul>

  <script>
    this.stocks = [];

    opts.on('initial-stocks', stocks => {
      this.stocks = stocks;
      this.update();
    });

    remove({item}) {
      opts.emit('remove-stock', item.code);
    };

    opts.on('add-stock', code => {
      this.stocks.push(code);
      this.update();
    });

    opts.on('remove-stock', code => {
      const index = this.stocks.indexOf(code);
      this.stocks.splice(index, 1);
      this.update();
    });
  </script>
</stock-list>