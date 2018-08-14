function cb(arg, th){
    var check = th.checked;
    if (check == true){
        document.getElementById('contract_v_' + arg).readOnly = false;
        document.getElementById('contract_t_' + arg).readOnly = false;
    }
    else{
        document.getElementById('contract_v_' + arg).readOnly = true;
        document.getElementById('contract_t_' + arg).readOnly = true;
        document.getElementById('contract_v_' + arg).value = null;
        document.getElementById('contract_t_' + arg).value = null;
        document.getElementById('contract_o_' + arg).value = null;
    }
}

function price(arg){
    var n1 = document.getElementById('contract_v_' + arg).value;
    var n2 = document.getElementById('contract_t_' + arg).value;
    console.log(n1);
    document.getElementById('contract_o_' + arg).value = parseFloat(Number(n1) * Number(n2).toFixed(2));
    document.getElementById('contract_price').value = Number(document.getElementById('contract_o_gvs').value) +
        Number(document.getElementById('contract_o_hvs').value) + Number(document.getElementById('contract_o_vgvs').value) +
        Number(document.getElementById('contract_o_vhvs').value) + Number(document.getElementById('contract_o_tbo').value) +
        Number(document.getElementById('contract_o_exp').value) + Number(document.getElementById('contract_o_otop').value);
}
