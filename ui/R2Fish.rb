class R2Fish < Qt::MainWindow
  slots 'inputFileButton_clicked()', 'outputFileButton_clicked()', 
    'helpButton_clicked()',
    'runButton_clicked()',
    'mode_changed()'
  def initialize (parent = nil)
    super(parent)
    
    @ui = Ui::R2Fish.new()
    
    @ui.setup_ui(self)
    
    @ui.helpWidget().hide()
    
    @ui.subblock().setValue(8)
    self.mode_changed()
    
  end
  
  
  ## slots
  def inputFileButton_clicked(*k)
    fileName = Qt::FileDialog.getOpenFileName(self, tr("Input file"), "", "Any file (*)")
    @ui.inputFile().setText(fileName)
  end
  
  def outputFileButton_clicked(*k)
    fileName = Qt::FileDialog.getSaveFileName(self, tr("Output file"), "", "Any file (*)")
    @ui.outputFile().setText(fileName)
  end
  
  def helpButton_clicked(*k)
#    puts 'HALP! is ' + @ui.helpWidget().isVisible().to_s()
    if (!@ui.helpWidget().isVisible())
      @ui.processSettings().hide()
      
      @ui.helpLabel().setText(
        Qt::Application.translate("R2Fish", R2Fish::help(), nil, Qt::Application::UnicodeUTF8)
      )
      @ui.helpWidget().setVisible(true)
    else
      @ui.helpWidget().hide()
      @ui.processSettings().show()
    end
  end
  
  def mode_changed(*k)
    if (['CFB', 'OFB'].include?(@ui.mode().itemText(@ui.mode().currentIndex())))
      @ui.subblock().setEnabled(true)
    else
      @ui.subblock().setEnabled(false)
      @ui.subblock().setValue(8)  
    end
  end
  
  def runButton_clicked(*k)
    if (@ui.password().text() != @ui.passwordRetype().text())
      msgBox = Qt::MessageBox.new()
      msgBox.text = Qt::Application.translate("R2Fish", "Może by tak hasła równe wbić, co?", nil, Qt::Application::UnicodeUTF8)
      msgBox.icon = Qt::MessageBox::Warning
      msgBox.exec()
      return false
    end

    @ui.progressBar().cursor = Qt::Cursor.new(Qt::BusyCursor)
    
    puts 'Do magic here...'
  end
  
end