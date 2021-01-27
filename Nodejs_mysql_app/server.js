// Požadované soubory
const express = require("express");
const path = require("path");
const app = express();
const mysql = require("mysql");
// Soubor s uloženými dotazy
const dotazy = require("./sqls");


// Nastavení výchozího enginu pro stránky
app.set("view engine", "ejs");

//Lokalizace ss souboru
app.use("/css", express.static(path.resolve(__dirname, "css")));

// Nastavení připojení v MySQL databázi
const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "1234",
    database: "sql_databaze"
});

// Router na domovskou stránku, v našem případě index.ejs
app.get("/", (req, res) => {
    res.render("index");
});

// Router na tabulku zákaznící
app.get("/zakaznici", (req, res) => {
    let data = {};
    //Připojí se k databázi
        connection.connect(() => {
                console.log("Fetching data from database...")
                //Pomocí SQL dotazu se vybere požadovaná tabulka
                connection.query(dotazy.zakaznici, (err, result) => {
                    data = {data: result};
                    //Její obsah se vrátí pomocí objektu do vyrenderované stránky s tabulkou zákaznící (zakaznici.ejs)
                   res.render("zakaznici", data);
                   console.log("Loaded!");
                });
    });
    
})

// Router na tabulku objednavky
app.get("/objednavky", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.objednavky, (err, result) => {
                    data = {data: result};
                   res.render("objednavky", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku produkty
app.get("/produkty", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.produkty, (err, result) => {
                    data = {data: result};
                   res.render("produkty", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku dopravci
app.get("/dopravci", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.dopravci, (err, result) => {
                    data = {data: result};
                   res.render("dopravci", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku s objednaným zbožím
app.get("/objednane-zbozi", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.objednane_zbozi, (err, result) => {
                    data = {data: result};
                   res.render("objednaneZbozi", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku se statusy objednávek
app.get("/statusy-objednavek", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.statusy_objedavek, (err, result) => {
                    data = {data: result};
                   res.render("statusyObjednavek", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu docházející produkty
app.get("/dochazejici-produkty", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.dochazejici_produkty, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_dochazejiciProdukty", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu dospělí zákaznící
app.get("/dospeli-zakaznici", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.dospeli_zakaznici, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_dospeliZakaznici", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu mladí zákaznící
app.get("/mladi-zakaznici", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.mladi_zakaznici, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_mladiZakaznici", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu nejdražší objednávka
app.get("/nejdrazsi-objednavka", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.nejdrazsi_objednavka, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_nejdrazsiObjednavka", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu nejlevnejsi objednávka
app.get("/nejlevnejsi-objednavka", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.nejlevnejsi_objednavka, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_nejlevnejsiObjednavka", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu objednávky k odeslání
app.get("/objednavky-k-odeslani", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.objednavky_k_odeslani, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_objednavkyKOdeslani", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu odeslané objednávky
app.get("/odeslane-objednavky", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.odeslane_objednavky, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_odeslaneObjednavky", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu poslední objednávka
app.get("/posledni-objednavka", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.posledni_objednavka, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_posledniObjednavka", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu tržby
app.get("/trzby", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.trzby, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_trzby", data);
                   console.log("Loaded!");
                });
    });

})

// Router na tabulku z dotazu zákazníci a zboží
app.get("/zakaznici-a-zbozi", (req, res) => {
    let data = {};
        connection.connect(() => {
                console.log("Fetching data from database...")
                connection.query(dotazy.pohledy.zakaznici_a_zbozi, (err, result) => {
                    data = {data: result};
                   res.render("dotaz_zakazniciAZbozi", data);
                   console.log("Loaded!");
                });
    });

})






// Aplikace bude na sděleném portu
app.listen(3000, () => {
    //Vypíše se do konzole, že je server správně spuštěný
    console.log("Server is running on port 3000...");
})