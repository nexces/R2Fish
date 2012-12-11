# encoding: utf-8

class R2Fish < Qt::MainWindow
  slots 'inputFileButton_clicked()', 'outputFileButton_clicked()', 
    'helpButton_clicked()',
    'runButton_clicked()',
    'mode_changed()', 'keysize_changed()'
    
  @running = false
  
  def initialize (parent = nil)
    super(parent)
    
    @ui = Ui::R2Fish.new()
    
    @ui.setup_ui(self)
    
    @ui.helpWidget().hide()
    
#    @ui.feedbackSize().hide()
#    @ui.feedbackSizeLabel().hide()
#    @ui.feedbackSizeValueLabel().hide()
    
    keys = Array.new();
    for key in 16..56
      keys.push( Qt::Application.translate("R2Fish", (key * 8).to_s(), nil, Qt::Application::UnicodeUTF8) )
    end
    @ui.keysize().insertItems(0, keys)
            
    self.mode_changed()
    
    @ui.feedbackSize().setMaximum(8)
    @ui.feedbackSize().setValue(8)
    
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
    if (['CFB', 'OFB'].include?(@ui.mode().currentText))
      @ui.feedbackSize().setEnabled(true)
    else
      @ui.feedbackSize().setEnabled(false)
#      @ui.feedbackSize().setValue(@ui.keysize().currentText.to_i/8)  
      @ui.feedbackSize().setValue(8)  
    end
  end
  
  def keysize_changed(*k)
#    @ui.feedbackSize().setMaximum((@ui.keysize().currentText.to_i/8).to_i)
#    self.mode_changed();
  end
  
  def runButton_clicked(*k)
    p 'Run button is: ' + @ui.runButton().enabled.to_s()
    if (@ui.password().text() != @ui.passwordRetype().text())
      msgBox = Qt::MessageBox.new()
      msgBox.text = Qt::Application.translate("R2Fish", "Może by tak hasła równe wbić, co?", nil, Qt::Application::UnicodeUTF8)
      msgBox.icon = Qt::MessageBox::Warning
      msgBox.exec()
      return false
    end

    if (@ui.toolBox().currentWidget().objectName == 'encryption')
      password = @ui.password().text
    else
      password = @ui.password_2().text
    end
    
    @ui.progressBar().cursor = Qt::Cursor.new(Qt::BusyCursor)
    @ui.runButton().setEnabled(false)
    crypto(
        @ui.inputFile().text, 
        @ui.outputFile().text, 
        @ui.toolBox().currentWidget().objectName, 
        password, 
        @ui.keysize().currentText.to_i()/8,
        @ui.mode().currentText,
        @ui.feedbackSize().value,
        self)
    @ui.runButton().setEnabled(true)
  end
  
  def progress_update(current, total)
    total = 100 if total.nil?
    @ui.progressBar().value = ((current.to_i() * total) / total.to_i()).to_i()
  end
end