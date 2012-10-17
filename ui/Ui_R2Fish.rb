=begin
** Form generated from reading ui file 'r2fish.ui'
**
** Created: śr. paź 17 09:08:08 2012
**      by: Qt User Interface Compiler version 4.8.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_R2Fish
    attr_reader :actionQuit
    attr_reader :centralwidget
    attr_reader :processSettings
    attr_reader :filesFrame
    attr_reader :formLayoutWidget_2
    attr_reader :filesForm
    attr_reader :inputFileLabel
    attr_reader :ouputFileLabel
    attr_reader :inputFileControl
    attr_reader :inputFile
    attr_reader :inputFileButton
    attr_reader :outputFileControl
    attr_reader :outputFile
    attr_reader :outputFileButton
    attr_reader :toolBox
    attr_reader :encryption
    attr_reader :modeGroup
    attr_reader :formLayoutWidget_3
    attr_reader :modeForm
    attr_reader :modeLabel
    attr_reader :mode
    attr_reader :subblockLabel
    attr_reader :subblockControl
    attr_reader :subblock
    attr_reader :subblockValueLabel
    attr_reader :passwordGroup
    attr_reader :formLayoutWidget
    attr_reader :passwordForm
    attr_reader :passwordLabel
    attr_reader :passwordRetypeLabel
    attr_reader :password
    attr_reader :passwordRetype
    attr_reader :keysizeGroup
    attr_reader :formLayoutWidget_4
    attr_reader :keysizeForm
    attr_reader :keysizeLabel
    attr_reader :horizontalLayout_2
    attr_reader :keysize
    attr_reader :label
    attr_reader :decryption
    attr_reader :formLayoutWidget_5
    attr_reader :passwordForm_2
    attr_reader :passwordLabel_2
    attr_reader :password_2
    attr_reader :helpButton
    attr_reader :helpWidget
    attr_reader :helpLabel
    attr_reader :progressWidget
    attr_reader :progressBar
    attr_reader :runButton

    def setupUi(r2Fish)
    if r2Fish.objectName.nil?
        r2Fish.objectName = "r2Fish"
    end
    r2Fish.resize(522, 353)
    icon = Qt::Icon.new
    icon.addPixmap(Qt::Pixmap.new(":/tabs/1350370385_padlock-closed.png"), Qt::Icon::Normal, Qt::Icon::Off)
    r2Fish.windowIcon = icon
    @actionQuit = Qt::Action.new(r2Fish)
    @actionQuit.objectName = "actionQuit"
    @centralwidget = Qt::Widget.new(r2Fish)
    @centralwidget.objectName = "centralwidget"
    @centralwidget.enabled = true
    @processSettings = Qt::Widget.new(@centralwidget)
    @processSettings.objectName = "processSettings"
    @processSettings.geometry = Qt::Rect.new(0, 0, 521, 321)
    @filesFrame = Qt::Frame.new(@processSettings)
    @filesFrame.objectName = "filesFrame"
    @filesFrame.geometry = Qt::Rect.new(0, 0, 461, 71)
    @filesFrame.frameShape = Qt::Frame::StyledPanel
    @filesFrame.frameShadow = Qt::Frame::Raised
    @formLayoutWidget_2 = Qt::Widget.new(@filesFrame)
    @formLayoutWidget_2.objectName = "formLayoutWidget_2"
    @formLayoutWidget_2.geometry = Qt::Rect.new(10, 10, 441, 61)
    @filesForm = Qt::FormLayout.new(@formLayoutWidget_2)
    @filesForm.objectName = "filesForm"
    @filesForm.setContentsMargins(0, 0, 0, 0)
    @inputFileLabel = Qt::Label.new(@formLayoutWidget_2)
    @inputFileLabel.objectName = "inputFileLabel"

    @filesForm.setWidget(0, Qt::FormLayout::LabelRole, @inputFileLabel)

    @ouputFileLabel = Qt::Label.new(@formLayoutWidget_2)
    @ouputFileLabel.objectName = "ouputFileLabel"

    @filesForm.setWidget(1, Qt::FormLayout::LabelRole, @ouputFileLabel)

    @inputFileControl = Qt::HBoxLayout.new()
    @inputFileControl.objectName = "inputFileControl"
    @inputFile = Qt::LineEdit.new(@formLayoutWidget_2)
    @inputFile.objectName = "inputFile"
    @inputFile.enabled = true
    @inputFile.cursor = Qt::Cursor.new(Qt::PointingHandCursor)
    @inputFile.readOnly = true

    @inputFileControl.addWidget(@inputFile)

    @inputFileButton = Qt::PushButton.new(@formLayoutWidget_2)
    @inputFileButton.objectName = "inputFileButton"
    icon1 = Qt::Icon.new
    icon1.addPixmap(Qt::Pixmap.new(":/general/1350377805_save.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @inputFileButton.icon = icon1

    @inputFileControl.addWidget(@inputFileButton)


    @filesForm.setLayout(0, Qt::FormLayout::FieldRole, @inputFileControl)

    @outputFileControl = Qt::HBoxLayout.new()
    @outputFileControl.objectName = "outputFileControl"
    @outputFile = Qt::LineEdit.new(@formLayoutWidget_2)
    @outputFile.objectName = "outputFile"
    @outputFile.enabled = true
    @outputFile.cursor = Qt::Cursor.new(Qt::PointingHandCursor)
    @outputFile.readOnly = true

    @outputFileControl.addWidget(@outputFile)

    @outputFileButton = Qt::PushButton.new(@formLayoutWidget_2)
    @outputFileButton.objectName = "outputFileButton"
    @outputFileButton.icon = icon1

    @outputFileControl.addWidget(@outputFileButton)


    @filesForm.setLayout(1, Qt::FormLayout::FieldRole, @outputFileControl)

    @toolBox = Qt::ToolBox.new(@processSettings)
    @toolBox.objectName = "toolBox"
    @toolBox.geometry = Qt::Rect.new(0, 70, 521, 251)
    @encryption = Qt::Widget.new()
    @encryption.objectName = "encryption"
    @encryption.geometry = Qt::Rect.new(0, 0, 511, 185)
    @modeGroup = Qt::GroupBox.new(@encryption)
    @modeGroup.objectName = "modeGroup"
    @modeGroup.geometry = Qt::Rect.new(260, 110, 241, 91)
    @formLayoutWidget_3 = Qt::Widget.new(@modeGroup)
    @formLayoutWidget_3.objectName = "formLayoutWidget_3"
    @formLayoutWidget_3.geometry = Qt::Rect.new(10, 20, 221, 53)
    @modeForm = Qt::FormLayout.new(@formLayoutWidget_3)
    @modeForm.objectName = "modeForm"
    @modeForm.setContentsMargins(0, 0, 0, 0)
    @modeLabel = Qt::Label.new(@formLayoutWidget_3)
    @modeLabel.objectName = "modeLabel"

    @modeForm.setWidget(0, Qt::FormLayout::LabelRole, @modeLabel)

    @mode = Qt::ComboBox.new(@formLayoutWidget_3)
    @mode.objectName = "mode"
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Fixed)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = @mode.sizePolicy.hasHeightForWidth
    @mode.sizePolicy = @sizePolicy

    @modeForm.setWidget(0, Qt::FormLayout::FieldRole, @mode)

    @subblockLabel = Qt::Label.new(@formLayoutWidget_3)
    @subblockLabel.objectName = "subblockLabel"

    @modeForm.setWidget(1, Qt::FormLayout::LabelRole, @subblockLabel)

    @subblockControl = Qt::HBoxLayout.new()
    @subblockControl.objectName = "subblockControl"
    @subblock = Qt::Slider.new(@formLayoutWidget_3)
    @subblock.objectName = "subblock"
    @subblock.autoFillBackground = false
    @subblock.minimum = 1
    @subblock.maximum = 8
    @subblock.pageStep = 1
    @subblock.value = 8
    @subblock.orientation = Qt::Horizontal
    @subblock.invertedAppearance = false
    @subblock.invertedControls = false
    @subblock.tickPosition = Qt::Slider::NoTicks

    @subblockControl.addWidget(@subblock)

    @subblockValueLabel = Qt::Label.new(@formLayoutWidget_3)
    @subblockValueLabel.objectName = "subblockValueLabel"

    @subblockControl.addWidget(@subblockValueLabel)


    @modeForm.setLayout(1, Qt::FormLayout::FieldRole, @subblockControl)

    @passwordGroup = Qt::GroupBox.new(@encryption)
    @passwordGroup.objectName = "passwordGroup"
    @passwordGroup.geometry = Qt::Rect.new(10, 10, 491, 91)
    @formLayoutWidget = Qt::Widget.new(@passwordGroup)
    @formLayoutWidget.objectName = "formLayoutWidget"
    @formLayoutWidget.geometry = Qt::Rect.new(10, 20, 471, 51)
    @passwordForm = Qt::FormLayout.new(@formLayoutWidget)
    @passwordForm.objectName = "passwordForm"
    @passwordForm.setContentsMargins(0, 0, 0, 0)
    @passwordLabel = Qt::Label.new(@formLayoutWidget)
    @passwordLabel.objectName = "passwordLabel"

    @passwordForm.setWidget(0, Qt::FormLayout::LabelRole, @passwordLabel)

    @passwordRetypeLabel = Qt::Label.new(@formLayoutWidget)
    @passwordRetypeLabel.objectName = "passwordRetypeLabel"

    @passwordForm.setWidget(1, Qt::FormLayout::LabelRole, @passwordRetypeLabel)

    @password = Qt::LineEdit.new(@formLayoutWidget)
    @password.objectName = "password"
    @password.contextMenuPolicy = Qt::NoContextMenu
    @password.acceptDrops = false
    @password.echoMode = Qt::LineEdit::Password
    @password.dragEnabled = false

    @passwordForm.setWidget(0, Qt::FormLayout::FieldRole, @password)

    @passwordRetype = Qt::LineEdit.new(@formLayoutWidget)
    @passwordRetype.objectName = "passwordRetype"
    @passwordRetype.contextMenuPolicy = Qt::NoContextMenu
    @passwordRetype.acceptDrops = false
    @passwordRetype.echoMode = Qt::LineEdit::Password
    @passwordRetype.dragEnabled = false

    @passwordForm.setWidget(1, Qt::FormLayout::FieldRole, @passwordRetype)

    @keysizeGroup = Qt::GroupBox.new(@encryption)
    @keysizeGroup.objectName = "keysizeGroup"
    @keysizeGroup.geometry = Qt::Rect.new(10, 110, 241, 80)
    @formLayoutWidget_4 = Qt::Widget.new(@keysizeGroup)
    @formLayoutWidget_4.objectName = "formLayoutWidget_4"
    @formLayoutWidget_4.geometry = Qt::Rect.new(10, 20, 221, 51)
    @keysizeForm = Qt::FormLayout.new(@formLayoutWidget_4)
    @keysizeForm.objectName = "keysizeForm"
    @keysizeForm.setContentsMargins(0, 0, 0, 0)
    @keysizeLabel = Qt::Label.new(@formLayoutWidget_4)
    @keysizeLabel.objectName = "keysizeLabel"

    @keysizeForm.setWidget(0, Qt::FormLayout::LabelRole, @keysizeLabel)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @keysize = Qt::ComboBox.new(@formLayoutWidget_4)
    @keysize.objectName = "keysize"

    @horizontalLayout_2.addWidget(@keysize)

    @label = Qt::Label.new(@formLayoutWidget_4)
    @label.objectName = "label"

    @horizontalLayout_2.addWidget(@label)


    @keysizeForm.setLayout(0, Qt::FormLayout::FieldRole, @horizontalLayout_2)

    @toolBox.addItem(@encryption, icon, Qt::Application.translate("R2Fish", "Szyfrowanie", nil, Qt::Application::UnicodeUTF8))
    @decryption = Qt::Widget.new()
    @decryption.objectName = "decryption"
    @decryption.geometry = Qt::Rect.new(0, 0, 94, 24)
    @formLayoutWidget_5 = Qt::Widget.new(@decryption)
    @formLayoutWidget_5.objectName = "formLayoutWidget_5"
    @formLayoutWidget_5.geometry = Qt::Rect.new(20, 10, 471, 51)
    @passwordForm_2 = Qt::FormLayout.new(@formLayoutWidget_5)
    @passwordForm_2.objectName = "passwordForm_2"
    @passwordForm_2.fieldGrowthPolicy = Qt::FormLayout::ExpandingFieldsGrow
    @passwordForm_2.setContentsMargins(0, 0, 0, 0)
    @passwordLabel_2 = Qt::Label.new(@formLayoutWidget_5)
    @passwordLabel_2.objectName = "passwordLabel_2"

    @passwordForm_2.setWidget(0, Qt::FormLayout::LabelRole, @passwordLabel_2)

    @password_2 = Qt::LineEdit.new(@formLayoutWidget_5)
    @password_2.objectName = "password_2"
    @password_2.contextMenuPolicy = Qt::NoContextMenu
    @password_2.acceptDrops = false
    @password_2.echoMode = Qt::LineEdit::Password
    @password_2.dragEnabled = false

    @passwordForm_2.setWidget(0, Qt::FormLayout::FieldRole, @password_2)

    icon2 = Qt::Icon.new
    icon2.addPixmap(Qt::Pixmap.new(":/tabs/1350370362_padlock-open.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @toolBox.addItem(@decryption, icon2, Qt::Application.translate("R2Fish", "Odszyfrowanie", nil, Qt::Application::UnicodeUTF8))
    @helpButton = Qt::PushButton.new(@centralwidget)
    @helpButton.objectName = "helpButton"
    @helpButton.geometry = Qt::Rect.new(460, 0, 61, 71)
    @helpButton.cursor = Qt::Cursor.new(Qt::WhatsThisCursor)
    icon3 = Qt::Icon.new
    icon3.addPixmap(Qt::Pixmap.new(":/general/1350370514_help.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @helpButton.icon = icon3
    @helpButton.iconSize = Qt::Size.new(50, 50)
    @helpButton.autoDefault = true
    @helpWidget = Qt::Widget.new(@centralwidget)
    @helpWidget.objectName = "helpWidget"
    @helpWidget.geometry = Qt::Rect.new(10, 10, 501, 281)
    @helpLabel = Qt::Label.new(@helpWidget)
    @helpLabel.objectName = "helpLabel"
    @helpLabel.geometry = Qt::Rect.new(0, 0, 501, 301)
    @helpLabel.alignment = Qt::AlignLeading|Qt::AlignLeft|Qt::AlignTop
    @progressWidget = Qt::Widget.new(@centralwidget)
    @progressWidget.objectName = "progressWidget"
    @progressWidget.geometry = Qt::Rect.new(0, 320, 521, 31)
    @progressBar = Qt::ProgressBar.new(@progressWidget)
    @progressBar.objectName = "progressBar"
    @progressBar.geometry = Qt::Rect.new(0, 0, 421, 31)
    @progressBar.value = 0
    @runButton = Qt::PushButton.new(@progressWidget)
    @runButton.objectName = "runButton"
    @runButton.geometry = Qt::Rect.new(420, 0, 101, 31)
    icon4 = Qt::Icon.new
    icon4.addPixmap(Qt::Pixmap.new(":/general/1350371625_media-play.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @runButton.icon = icon4
    @runButton.autoDefault = true
    r2Fish.centralWidget = @centralwidget
    helpWidget.raise()
    processSettings.raise()
    helpButton.raise()
    progressWidget.raise()
    Qt::Widget.setTabOrder(@inputFileButton, @outputFileButton)
    Qt::Widget.setTabOrder(@outputFileButton, @password)
    Qt::Widget.setTabOrder(@password, @passwordRetype)
    Qt::Widget.setTabOrder(@passwordRetype, @keysize)
    Qt::Widget.setTabOrder(@keysize, @mode)
    Qt::Widget.setTabOrder(@mode, @subblock)
    Qt::Widget.setTabOrder(@subblock, @runButton)
    Qt::Widget.setTabOrder(@runButton, @helpButton)
    Qt::Widget.setTabOrder(@helpButton, @password_2)
    Qt::Widget.setTabOrder(@password_2, @outputFile)
    Qt::Widget.setTabOrder(@outputFile, @inputFile)

    retranslateUi(r2Fish)
    Qt::Object.connect(@subblock, SIGNAL('valueChanged(int)'), @subblockValueLabel, SLOT('setNum(int)'))
    Qt::Object.connect(@actionQuit, SIGNAL('triggered()'), r2Fish, SLOT('close()'))
    Qt::Object.connect(@inputFileButton, SIGNAL('clicked()'), r2Fish, SLOT('inputFileButton_clicked()'))
    Qt::Object.connect(@outputFileButton, SIGNAL('clicked()'), r2Fish, SLOT('outputFileButton_clicked()'))
    Qt::Object.connect(@helpButton, SIGNAL('clicked()'), r2Fish, SLOT('helpButton_clicked()'))
    Qt::Object.connect(@runButton, SIGNAL('clicked()'), r2Fish, SLOT('runButton_clicked()'))
    Qt::Object.connect(@mode, SIGNAL('currentIndexChanged(int)'), r2Fish, SLOT('mode_changed()'))

    @keysize.setCurrentIndex(2)


    Qt::MetaObject.connectSlotsByName(r2Fish)
    end # setupUi

    def setup_ui(r2Fish)
        setupUi(r2Fish)
    end

    def retranslateUi(r2Fish)
    r2Fish.windowTitle = Qt::Application.translate("R2Fish", "R2Fish", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.text = Qt::Application.translate("R2Fish", "Quit", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.toolTip = Qt::Application.translate("R2Fish", "Quit", nil, Qt::Application::UnicodeUTF8)
    @actionQuit.shortcut = Qt::Application.translate("R2Fish", "Ctrl+Q", nil, Qt::Application::UnicodeUTF8)
    @inputFileLabel.text = Qt::Application.translate("R2Fish", "Plik wej\305\233ciowy", nil, Qt::Application::UnicodeUTF8)
    @ouputFileLabel.text = Qt::Application.translate("R2Fish", "Plik wyj\305\233ciowy", nil, Qt::Application::UnicodeUTF8)
    @inputFile.text = ''
    @inputFileButton.text = ''
    @outputFileButton.text = ''
    @modeGroup.title = Qt::Application.translate("R2Fish", "Ustawienia trybu", nil, Qt::Application::UnicodeUTF8)
    @modeLabel.text = Qt::Application.translate("R2Fish", "Tryb pracy", nil, Qt::Application::UnicodeUTF8)
    @mode.insertItems(0, [Qt::Application.translate("R2Fish", "ECB", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "CBC", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "CFB", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "OFB", nil, Qt::Application::UnicodeUTF8)])
    @subblockLabel.text = Qt::Application.translate("R2Fish", "D\305\202ugo\305\233\304\207 podbloku", nil, Qt::Application::UnicodeUTF8)
    @subblockValueLabel.text = Qt::Application.translate("R2Fish", "8", nil, Qt::Application::UnicodeUTF8)
    @passwordGroup.title = Qt::Application.translate("R2Fish", "Ustawienia has\305\202a", nil, Qt::Application::UnicodeUTF8)
    @passwordLabel.text = Qt::Application.translate("R2Fish", "Has\305\202o", nil, Qt::Application::UnicodeUTF8)
    @passwordRetypeLabel.text = Qt::Application.translate("R2Fish", "Weryfikacja", nil, Qt::Application::UnicodeUTF8)
    @password.toolTip = Qt::Application.translate("R2Fish", "Has\305\202o szyfrogramu", nil, Qt::Application::UnicodeUTF8)
    @password.inputMask = ''
    @password.placeholderText = Qt::Application.translate("R2Fish", "Has\305\202o", nil, Qt::Application::UnicodeUTF8)
    @passwordRetype.toolTip = Qt::Application.translate("R2Fish", "Has\305\202o szyfrogramu", nil, Qt::Application::UnicodeUTF8)
    @passwordRetype.inputMask = ''
    @passwordRetype.placeholderText = Qt::Application.translate("R2Fish", "Powt\303\263rzenie has\305\202a w celu weryfikacji", nil, Qt::Application::UnicodeUTF8)
    @keysizeGroup.title = Qt::Application.translate("R2Fish", "Ustawienia szyfru", nil, Qt::Application::UnicodeUTF8)
    @keysizeLabel.text = Qt::Application.translate("R2Fish", "D\305\202ugo\305\233\304\207 klucza", nil, Qt::Application::UnicodeUTF8)
    @keysize.insertItems(0, [Qt::Application.translate("R2Fish", "32", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "64", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "128", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "192", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "224", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "256", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "384", nil, Qt::Application::UnicodeUTF8),
        Qt::Application.translate("R2Fish", "448", nil, Qt::Application::UnicodeUTF8)])
    @label.text = Qt::Application.translate("R2Fish", "bit\303\263w", nil, Qt::Application::UnicodeUTF8)
    @toolBox.setItemText(@toolBox.indexOf(@encryption), Qt::Application.translate("R2Fish", "Szyfrowanie", nil, Qt::Application::UnicodeUTF8))
    @passwordLabel_2.text = Qt::Application.translate("R2Fish", "Has\305\202o", nil, Qt::Application::UnicodeUTF8)
    @password_2.toolTip = Qt::Application.translate("R2Fish", "Has\305\202o szyfrogramu", nil, Qt::Application::UnicodeUTF8)
    @password_2.inputMask = ''
    @password_2.placeholderText = Qt::Application.translate("R2Fish", "Has\305\202o", nil, Qt::Application::UnicodeUTF8)
    @toolBox.setItemText(@toolBox.indexOf(@decryption), Qt::Application.translate("R2Fish", "Odszyfrowanie", nil, Qt::Application::UnicodeUTF8))
    @helpButton.text = ''
    @helpLabel.text = ''
    @runButton.toolTip = Qt::Application.translate("R2Fish", "Uruchomienie procesu (CTRL+R)", nil, Qt::Application::UnicodeUTF8)
    @runButton.text = Qt::Application.translate("R2Fish", "Uruchom", nil, Qt::Application::UnicodeUTF8)
    @runButton.shortcut = Qt::Application.translate("R2Fish", "Ctrl+R", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(r2Fish)
        retranslateUi(r2Fish)
    end

end

module Ui
    class R2Fish < Ui_R2Fish
    end
end  # module Ui

