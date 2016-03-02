var $toastlast = null;
var $toast;

var app = {
    scrollUp: function () {
        $("html, body").animate({
            scrollTop: 0
        }, 900);
    },
    notificacoes: function () {
        if (!jQuery().toastr) {
            return;
        }
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "positionClass": "toast-top-right",
            "showDuration": "1000",
            "hideDuration": "1000",
            "timeOut": "5000000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut",
            "onclick": null
        }
    },
    ajax: function (actionUrl, type, data, cbSuccess, cbError) {
        if (event)
            event.preventDefault();
        $.ajax({
            url: actionUrl,
            type: type,
            data: data,
            success: function (result) {
                cbSuccess(result);
                //console.log(result);
                //$("#steps").html(result);
                //startScripts();
            },
            error: function (result) {
                cbError(result);
            }
        });
    },
    checkClassFieldsError: function (cls) {
        var errors = '';
        $('.' + cls).removeClass('input-validation-error');
        $('.' + cls).each(function () {
            if (!$(this).is(':hidden')) {
                if ($(this).is('select') && $(this)[0].selectedIndex==0) {
                    errors += '<li>The ' + $(this).data('name') + ' field is required.</li>'
                    $(this).addClass('input-validation-error');
                }
                //else if ($(this).is('img') && $(this).attr('src') == '') {
                //    errors += '<li>The ' + $(this).data('name') + ' field is required.</li>'
                //}                    
                else if ($(this).val().length == 0) {
                    errors += '<li>The ' + $(this).data('name') + ' field is required.</li>'
                    $(this).addClass('input-validation-error');
                }
            }
            //else if ($(this).is('img') && $(this).attr('src') == '') {
            //    errors += '<li>The ' + $(this).data('name') + ' field is required.</li>'
            //}
        });
        if (errors.length > 0)
            notificacaoError('Error', errors);
        return errors.length == 0;
    }
}

function notificacaoSucesso(Titulo, Mensagem, Link, Texto) {
    //Remove o Ãºltimo
    getLastToast();

    if (Link) {
        $(Link + ' .modal-body').html(Texto);
        modalNotificacao(Link);
    }

    if (Titulo && Mensagem) {
        $toast = toastr.success(Mensagem, Titulo);
    } else if (Titulo) {
        $toast = toastr.success('Seus dados foram atualizados com sucesso', Titulo);
    } else if (Mensagem) {
        $toast = toastr.success(Mensagem, 'Dados Atualizados');
    } else {
        $toast = toastr.success('Seus dados foram atualizados com sucesso', 'Dados Atualizados');
    }

    $toastlast = $toast;
    return false;
}
function notificacaoError(Titulo, Mensagem, Link, Texto) {
    //Remove o Ãºltimo
    getLastToast();

    if (Link) {
        $(Link + ' .modal-body').html(Texto);
        modalNotificacao(Link);
    }

    if (Titulo && Mensagem) {
        $toast = toastr.error(Mensagem, Titulo);
    } else if (Titulo) {
        $toast = toastr.error('Seus dados nÃ£o foram atualizados. Tente novamente', Titulo);
    } else if (Mensagem) {
        $toast = toastr.error(Mensagem, 'Dados nÃ£o Atualizados');
    } else {
        $toast = toastr.error('Seus dados nÃ£o foram atualizados. Tente novamente', 'Dados nÃ£o Atualizados');
    }

    $toastlast = $toast;
    return false;
}
function notificacaoInfo(Titulo, Mensagem, Link, Texto) {
    //Remove o Ãºltimo
    getLastToast();

    if (Link) {
        $(Link + ' .modal-body').html(Texto);
        modalNotificacao(Link);
    }

    $toast = toastr.info(Mensagem, Titulo);

    $toastlast = $toast;
    return false;
}
function notificacaoAlerta(Titulo, Mensagem, Link, Texto) {
    //Remove o Ãºltimo
    getLastToast();

    if (Link) {
        $(Link + ' .modal-body').html(Texto);
        modalNotificacao(Link);
    }

    $toast = toastr.warning(Mensagem, Titulo);


    $toastlast = $toast;
    return false;
}
function getLastToast() {
    if ($toastlast) {
        toastr.clear($toastlast);
    }
    //reset click
    toastr.options.onclick = null;
}
function modalNotificacao(Link) {
    toastr.options.onclick = function () {
        $(Link).modal()
    };
}

String.prototype.replaceAll = function (de, para) {
    var str = this;
    var pos = str.indexOf(de);
    while (pos > -1) {
        str = str.replace(de, para);
        pos = str.indexOf(de);
    }
    return (str);
}