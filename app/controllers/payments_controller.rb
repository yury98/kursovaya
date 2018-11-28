class PaymentsController < ApplicationController

  before_action :set_pay, only: [ :show, :edit, :update, :paid]

  def new
    @con = Contract.find(params[:id]) if !params[:id].nil?
    @pay = Payment.new
  end

  def services_each; end

  # Для отображения статистики по услугам за указанный месяц
  def services_all
    @f = 0
    @p = 0
    @date = Date.civil(params[:month]["month(1i)"].to_i,
                       params[:month]["month(2i)"].to_i,
                       params[:month]["month(3i)"].to_i)
    @con = Contract.where(end_date: @date.to_s..'2100-09-13', podp_date: '2000-09-13'..(@date + 1.month).to_s)
    @pays = Payment.where(month: @date)
    @con.each { |n| @p += n.price }
    @pays.each { |n| @f += n.summ }
  end

  # Для отображения статистики по контрактам за указанный месяц
  def plan_all
    @f = 0
    @p = 0
    @date = Date.civil(params[:month]["month(1i)"].to_i,
                       params[:month]["month(2i)"].to_i,
                       params[:month]["month(3i)"].to_i)
    @con = Contract.where(end_date: @date.to_s..'2100-09-13', podp_date: '2000-09-13'..(@date + 1.month).to_s)
    @pays = Payment.where(month: @date)
    @con.each { |n| @p += n.price + n.price_nds }
    @pays.each { |n| @f += n.summ }
  end

  def plan_each; end

  # Для формирования печатной версии счета
  def download
    name = params[:number]
    # Удаление сущестующей печатной версии отчета с таким же именем, если он существует
    File.delete("#{Rails.root}/public/#{name}.docx") if File.file?("#{Rails.root}/public/#{name}.docx")
    pay = Payment.where(file_name: name).first
    con = Contract.where(id: pay.contract_id).first
    mas = []
    # Проверка по каждой услуге и занесение в массив

    if con.gvs == 'true'
      mass = []
      mass << 'gvs'
      mass << con.v_gvs
      mass << con.t_gvs
      mass << con.o_gvs
      mas << mass
    end
    if con.hvs == 'true'
      mass = []
      mass << 'hvs'
      mass << con.v_hvs
      mass << con.t_hvs
      mass << con.o_hvs
      mas << mass
    end
    if con.vgvs == 'true'
      mass = []
      mass << 'vgvs'
      mass << con.v_vgvs
      mass << con.t_vgvs
      mass << con.o_vgvs
      mas << mass
    end
    if con.vhvs == 'true'
      mass = []
      mass << 'vhvs'
      mass << con.v_vhvs
      mass << con.t_vhvs
      mass << con.o_vhvs
      mas << mass
    end
    if con.otop == 'true'
      mass = []
      mass << 'otop'
      mass << con.v_otop
      mass << con.t_otop
      mass << con.o_otop
      mas << mass
    end
    if con.exp == 'true'
      mass = []
      mass << 'exp'
      mass << con.v_exp
      mass << con.t_exp
      mass << con.o_exp
      mas << mass
    end
    if con.tbo == 'true'
      mass = []
      mass << 'tbo'
      mass << con.v_tbo
      mass << con.t_tbo
      mass << con.o_tbo
      mas << mass
    end
    # Сборка файла
    make_file(name, pay, mas)
    # Отправка файла
    send_file("#{Rails.root}/public/#{name}.docx")
  end

  # Простановка счета оплаченным
  def paid
    @pay.paid = true
    @pay.summ = Contract.find(@pay.contract_id).price + Contract.find(@pay.contract_id).price_nds + @pay.perep
    @pay.save
    redirect_to payments_view_path
  end

  def create
    @pay = Payment.new(pay_params)
    @pay.created_by = current_user.fio
    @pay.last_cb = current_user.fio
    @pay.file_name = @pay.number
    @pay.summ = 0
    if @pay.save
      redirect_to @pay
    else
      render :new
    end
  end

  def show; end

  def view
    @pays = Payment.all
  end

  def edit; end

  def update
    @pay.last_cb = current_user.fio
    @pay.file_name = @pay.number
    if @pay.update_attributes(pay_paramss)
      @pay.summ = 0 if @pay.paid != true
      @pay.summ = Contract.find(@pay.contract_id).price + Contract.find(@pay.contract_id).price_nds + @pay.perep if @pay.paid == true
      @pay.save
      redirect_to @pay
    else
      render :edit
    end
  end

  private

  def set_pay
    @pay = Payment.find(params[:id])
  end

  def pay_paramss
    params.require(:payment).permit(:number, :date, :month, :nazn, :perep)
  end

  def pay_params
    params.require(:payment).permit(:number, :date, :month, :contract_id, :nazn, :perep)
  end

  # Для сборки файла на основе данных из make_file
  def file(mas_info, mas_none, name, length, con, info, pay)
    # Добавляем верхнюю часть счета
    mas_none += [0, 4, 12, 14, 16, 23, 25, 26, 28, 29, 30, 32, 36, 44, 46, 48, 49, 50, 52, 53, 54, 57, 62, 64, 65, 66, 68,\
      70, 71, 72, 74, 76, 77, 78, 82, 84, 85, 86, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98]
    org = Org.where(id: con.org_id).first
    # Заполняем хэш с данными с данных об организации-поставщике услуг
    h = { '1': info.post, '5': info.address, '13': info.tel, '15': info.destination, '17': info.trans, '18': info.fil, \
      '24': info.bik, '27': info.ksch, '31': info.innkpp, '33': info.post, '37': info.address, \
      # Заполняем информацию о контракте и организации
      '45': ' №' + pay.number.to_s, '47': ' ' + pay.date.strftime('%d.%m.%Y'), '51': con.kod_p + ')', '55': con.innkpp, '56': org.full_name, '59': con.name + '  ',\
      '63': ' ' + con.podp_date.strftime('%d.%m.%Y'), '67': con.rsch, '69': con.bank, '73': con.ksch, '75': con.bik, '79': con.u_address,\
      '83': con.tel, '87': con.p_address}
    mas_info.update(h)
    mas_info.default = ''
    FileUtils.cp "#{Rails.root}/public/main#{length}.docx", "#{Rails.root}/public/#{name}.docx"
    zip = Zip::ZipFile.open("#{Rails.root}/public/#{name}.docx")
    doc = zip.find_entry("word/document.xml")
    xml = Nokogiri::XML.parse(doc.get_input_stream)
    wt = xml.root.xpath("//w:t", {"w"=>"http://schemas.openxmlformats.org/wordprocessingml/2006/main"})
#puts wt
    wt.each_with_index do |tag, i|
      if mas_none.include? i
        tag.content
      else
        tag.content = mas_info[i.to_s.to_sym]
      end
    end
    zip.get_output_stream("word/document.xml") { |f| f << xml.to_s}
    zip.close
  end

  # Сбор данных для создания файла-счета для определнных количеств услуг
  def make_file(name, pay, mas)
    con = Contract.where(id: pay.contract_id).first
    # Хэш с названиями услуг
    names = {gvs: 'Горячая вода', hvs: 'Холодная вода', vgvs: 'Водоотведение ГВС', vhvs: 'Водоотведение', otop: 'Отопление', exp: 'Эксплуатационные расходы', tbo: 'Вывоз ТБО'}
    # Хэш с единицами измерения
    izm = {gvs: 'м3', hvs: 'м3', vgvs: 'м3', vhvs: 'м3', otop: 'Гкал', exp: 'м2', tbo: 'м3'}
    # Создаем назначение платежа
    nazn = '  (' + con.kod_p + '#' + pay.date.strftime('%m%y') + ')  ' + pay.nazn + ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') \
      + ' года ' + (con.price + con.price_nds).to_s + ', в том числе НДС ' + con.price_nds.to_s + ' по договору ' + con.name + ' от ' + con.podp_date.strftime('%d.%m.%Y')
    info = InfoAdmin.last
    if mas.length == 1
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 107, 109, 112, 114, 117, 119, 124, 144, 145]
      # Заполняем таблицу с услугами
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': mas[0][3].round(2),\
        '105': mas[0][3].round(2), '106': mas[0][3].round(2), \
        '108': con.price, '110': con.price, '111': con.price, '118': (con.price + con.price_nds).to_s, '120': (con.price + con.price_nds).to_s, '121': (con.price + con.price_nds).to_s, '113': con.price_nds.to_s,\
        '115': con.price_nds.to_s, '116': con.price_nds.to_s, \
        # Заполняем назначение платежа и ниже
                  '126': nazn, '146': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '148': con.price_name.capitalize, \
        '149': 'Директор ______________________________________  ' + info.dir, '150': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      p nazn
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 2
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 117, 119, 122, 124, 127, 129, 134, 154, 155]
      # Заполняем таблицу с услугами (1)
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем итог
                  '118': con.price, '120': con.price, '121': con.price, '128':(con.price + con.price_nds).to_s, '130':(con.price + con.price_nds).to_s, '131':(con.price + con.price_nds).to_s, '123': con.price_nds.to_s,\
      '125': con.price_nds.to_s, '126': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '136': nazn, '156': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '158': con.price_name.capitalize, \
      '159': 'Директор ______________________________________  ' + info.dir, '160': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 3
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 124, 127, 129, 132, 134, 137, 139, 144, 164, 165]
      # Заполняем таблицу с услугами (1)
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем таблицу с услугами (3)
                  '117': names[mas[2][0].to_sym], '120': izm[mas[2][0].to_sym], '121': mas[2][1], '122': mas[2][2], '123': (mas[2][3] ).round(2),\
      '125': (mas[2][3] ).round(2), '126': (mas[2][3] ).round(2), \
      # Заполняем итог
                  '128': con.price, '130': con.price, '131': con.price, '138':(con.price + con.price_nds).to_s, '140':(con.price + con.price_nds).to_s, '141':(con.price + con.price_nds).to_s, '133': con.price_nds.to_s,\
      '135': con.price_nds.to_s, '136': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '146': nazn, '166': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '168': con.price_name.capitalize, \
      '169': 'Директор ______________________________________  ' + info.dir, '170': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 4
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 124, 132, 135, 137, 140, 142, 145, 147, 152, 172, 173]
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем таблицу с услугами (3)
                  '117': names[mas[2][0].to_sym], '120': izm[mas[2][0].to_sym], '121': mas[2][1], '122': mas[2][2], '123': (mas[2][3] ).round(2),\
      '125': (mas[2][3] ).round(2), '126': (mas[2][3] ).round(2), \
      # Заполняем таблицу с услугами (4)
                  '127': names[mas[3][0].to_sym], '128': izm[mas[3][0].to_sym], '129': mas[3][1], '130': mas[3][2], '131': (mas[3][3] ).round(2),\
      '133': (mas[3][3] ).round(2), '134': (mas[3][3] ).round(2), \
      # Заполняем итог
                  '136': con.price, '138': con.price, '139': con.price, '146':(con.price + con.price_nds).to_s, '148':(con.price + con.price_nds).to_s, '149':(con.price + con.price_nds).to_s, '141': con.price_nds.to_s,\
      '143': con.price_nds.to_s, '144': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '154': nazn, '174': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '176': con.price_name.capitalize, \
      '177': 'Директор ______________________________________  ' + info.dir, '178': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 5
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 124, 132, 141, 144, 146, 149, 151, 154, 156, 161, 181, 182]
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем таблицу с услугами (3)
                  '117': names[mas[2][0].to_sym], '120': izm[mas[2][0].to_sym], '121': mas[2][1], '122': mas[2][2], '123': (mas[2][3] ).round(2),\
      '125': (mas[2][3] ).round(2), '126': (mas[2][3] ).round(2), \
      # Заполняем таблицу с услугами (4)
                  '127': names[mas[3][0].to_sym], '128': izm[mas[3][0].to_sym], '129': mas[3][1], '130': mas[3][2], '131': (mas[3][3] ).round(2),\
      '133': (mas[3][3] ).round(2), '134': (mas[3][3] ).round(2), \
      # Заполняем таблицу с услугами (5)
                  '136': names[mas[4][0].to_sym], '137': izm[mas[4][0].to_sym], '138': mas[4][1], '139': mas[4][2], '140': (mas[4][3] ).round(2),\
      '142': (mas[4][3] ).round(2), '143': (mas[4][3] ).round(2), \
      # Заполняем итог
                  '145': con.price, '147': con.price, '148': con.price, '155':(con.price + con.price_nds).to_s, '157':(con.price + con.price_nds).to_s, '158':(con.price + con.price_nds).to_s, '150': con.price_nds.to_s,\
      '152': con.price_nds.to_s, '153': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '163': nazn, '183': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '185': con.price_name.capitalize, \
      '186': 'Директор ______________________________________  ' + info.dir, '187': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 6
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 124, 132, 141, 151, 154, 156, 159, 161, 164, 166, 171, 191, 192]
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем таблицу с услугами (3)
                  '117': names[mas[2][0].to_sym], '120': izm[mas[2][0].to_sym], '121': mas[2][1], '122': mas[2][2], '123': (mas[2][3] ).round(2),\
      '125': (mas[2][3] ).round(2), '126': (mas[2][3] ).round(2), \
      # Заполняем таблицу с услугами (4)
                  '127': names[mas[3][0].to_sym], '128': izm[mas[3][0].to_sym], '129': mas[3][1], '130': mas[3][2], '131': (mas[3][3] ).round(2),\
      '133': (mas[3][3] ).round(2), '134': (mas[3][3] ).round(2), \
      # Заполняем таблицу с услугами (5)
                  '136': names[mas[4][0].to_sym], '137': izm[mas[4][0].to_sym], '138': mas[4][1], '139': mas[4][2], '140': (mas[4][3] ).round(2),\
      '142': (mas[4][3] ).round(2), '143': (mas[4][3] ).round(2), \
      # Заполняем таблицу с услугами (6)
                  '146': names[mas[5][0].to_sym], '147': izm[mas[5][0].to_sym], '148': mas[5][1], '149': mas[5][2], '150': (mas[5][3] ).round(2),\
      '152': (mas[5][3] ).round(2), '153': (mas[5][3] ).round(2), \
     # Заполняем итог
                  '155': con.price, '157': con.price, '158': con.price, '165':(con.price + con.price_nds).to_s, '167':(con.price + con.price_nds).to_s, '168':(con.price + con.price_nds).to_s, '160': con.price_nds.to_s,\
      '162': con.price_nds.to_s, '163': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '173': nazn, '193': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '195': con.price_name.capitalize, \
      '196': 'Директор ______________________________________  ' + info.dir, '197': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
    if mas.length == 7
      # Массив со словами, которые оставляем в первоначальном виде
      mas_none = [104, 114, 124, 132, 141, 150, 160, 163, 165, 168, 170, 173, 175, 180, 200, 201]
      mas_info = {'99': names[mas[0][0].to_sym], '100': izm[mas[0][0].to_sym], '101': mas[0][1], '102': mas[0][2], '103': (mas[0][3] ).round(2),\
      '105': (mas[0][3] ).round(2), '106': (mas[0][3] ).round(2), \
      # Заполняем таблицу с услугами (2)
                  '107': names[mas[1][0].to_sym], '110': izm[mas[1][0].to_sym], '111': mas[1][1], '112': mas[1][2], '113': (mas[1][3] ).round(2),\
      '115': (mas[1][3] ).round(2), '116': (mas[1][3] ).round(2), \
      # Заполняем таблицу с услугами (3)
                  '117': names[mas[2][0].to_sym], '120': izm[mas[2][0].to_sym], '121': mas[2][1], '122': mas[2][2], '123': (mas[2][3] ).round(2),\
      '125': (mas[2][3] ).round(2), '126': (mas[2][3] ).round(2), \
      # Заполняем таблицу с услугами (4)
                  '127': names[mas[3][0].to_sym], '128': izm[mas[3][0].to_sym], '129': mas[3][1], '130': mas[3][2], '131': (mas[3][3] ).round(2),\
      '133': (mas[3][3] ).round(2), '134': (mas[3][3] ).round(2), \
      # Заполняем таблицу с услугами (5)
                  '136': names[mas[4][0].to_sym], '137': izm[mas[4][0].to_sym], '138': mas[4][1], '139': mas[4][2], '140': (mas[4][3] ).round(2),\
      '142': (mas[4][3] ).round(2), '143': (mas[4][3] ).round(2), \
      # Заполняем таблицу с услугами (6)
                  '145': names[mas[5][0].to_sym], '146': izm[mas[5][0].to_sym], '147': mas[5][1], '148': mas[5][2], '149': (mas[5][3] ).round(2),\
      '151': (mas[5][3] ).round(2), '152': (mas[5][3] ).round(2), \
     # Заполняем таблицу с услугами (7)
                  '155': names[mas[6][0].to_sym], '156': izm[mas[6][0].to_sym], '157': mas[6][1], '158': mas[6][2], '159': (mas[6][3] ).round(2),\
      '161': (mas[6][3] ).round(2), '162': (mas[6][3] ).round(2), \
      # Заполняем итог
                  '164': con.price, '166': con.price, '167': con.price, '174':(con.price + con.price_nds).to_s, '176':(con.price + con.price_nds).to_s, '177':(con.price + con.price_nds).to_s, '169': con.price_nds.to_s,\
      '171': con.price_nds.to_s, '172': con.price_nds.to_s, \
      # Заполняем назначение платежа и ниже
                  '182': nazn, '202': ' за ' + Russian::strftime(pay.month, "%B").downcase + ' ' + pay.date.strftime('%Y') + ':', '204': con.price_name.capitalize, \
      '205': 'Директор ______________________________________  ' + info.dir, '206': 'Главный бухгалтер ______________________________________  ' + info.main_buh}
      file(mas_info, mas_none, name, mas.length, con, info, pay)
    end
  end
end
