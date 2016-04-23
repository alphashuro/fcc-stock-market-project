<add-stock>
	<style scoped>
		form {
			text-align: center;
		}
    form input {
      font-size: 1em;
      box-sizing: content-box;
      border: none;
      border-bottom: 1px solid #222;
      text-align: center;
    }
    form input:focus {
      outline: none;
    }
    form button {
      margin-left: -5px;
      background: rgba(0, 0, 0, 0.81);
      border: none;
      padding: 5px;
      color: white;
      box-sizing: border-box;
      font-size: 1em;
      cursor: pointer;
      transition: all .2s;
    }
    form button:hover {
      box-shadow: 0 0 5px black;
      transform: scale(1.1);
    }
	</style>

  <form onsubmit={ add }>
    <p>Syncs in realtime accross clients</p>
    <input type="text" name='code'/>
    <button type="submit">Add Stock</button>
  </form>

  this.add = e => {
    opts.emit('add-stock', this.code.value);
  }
</add-stock>