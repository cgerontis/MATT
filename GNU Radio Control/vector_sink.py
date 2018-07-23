#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: USRP to Vector 
# Author: Rich McAllister
# Generated: Mon Jun 25 10:10:02 2018
##################################################

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print "Warning: failed to XInitThreads()"

import os
import sys
sys.path.append(os.environ.get('GRC_HIER_PATH', os.path.expanduser('~/.grc_gnuradio')))

from PyQt4 import Qt
from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import qtgui
from gnuradio import uhd
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from multi_goertzel import multi_goertzel  # grc-generated hier_block
from optparse import OptionParser
import sip
import time


class vector_sink(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "USRP to Vector ")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("USRP to Vector ")
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "vector_sink")
        self.restoreGeometry(self.settings.value("geometry").toByteArray())

        ##################################################
        # Variables
        ##################################################
        self.variable_0 = variable_0 = 0
        self.samp_rate = samp_rate = int(2e6)
        self.goertzel_length = goertzel_length = 4096
        self.const = const = 2
        self.TX_freqs = TX_freqs = (1e5, 1.5e5, 2e5,2.5e5,3e5,3.5e5,4e5,4.5e5,5e5, 5.5e5, 6e5, 6.5e5,7e5,7.5e5,8e5)

        ##################################################
        # Blocks
        ##################################################
        self.my_tabs = Qt.QTabWidget()
        self.my_tabs_widget_0 = Qt.QWidget()
        self.my_tabs_layout_0 = Qt.QBoxLayout(Qt.QBoxLayout.TopToBottom, self.my_tabs_widget_0)
        self.my_tabs_grid_layout_0 = Qt.QGridLayout()
        self.my_tabs_layout_0.addLayout(self.my_tabs_grid_layout_0)
        self.my_tabs.addTab(self.my_tabs_widget_0, "Tx 1-10")
        self.my_tabs_widget_1 = Qt.QWidget()
        self.my_tabs_layout_1 = Qt.QBoxLayout(Qt.QBoxLayout.TopToBottom, self.my_tabs_widget_1)
        self.my_tabs_grid_layout_1 = Qt.QGridLayout()
        self.my_tabs_layout_1.addLayout(self.my_tabs_grid_layout_1)
        self.my_tabs.addTab(self.my_tabs_widget_1, "Tx 11-15")
        self.my_tabs_widget_2 = Qt.QWidget()
        self.my_tabs_layout_2 = Qt.QBoxLayout(Qt.QBoxLayout.TopToBottom, self.my_tabs_widget_2)
        self.my_tabs_grid_layout_2 = Qt.QGridLayout()
        self.my_tabs_layout_2.addLayout(self.my_tabs_grid_layout_2)
        self.my_tabs.addTab(self.my_tabs_widget_2, "Freq Sink")
        self.top_layout.addWidget(self.my_tabs)
        self.uhd_usrp_source_0_0 = uhd.usrp_source(
        	",".join(("", "")),
        	uhd.stream_args(
        		cpu_format="fc32",
        		channels=range(1),
        	),
        )
        self.uhd_usrp_source_0_0.set_samp_rate(samp_rate)
        self.uhd_usrp_source_0_0.set_center_freq(0, 0)
        self.uhd_usrp_source_0_0.set_gain(0, 0)
        self.qtgui_time_sink_x_0 = qtgui.time_sink_c(
        	1024, #size
        	samp_rate, #samp_rate
        	"", #name
        	1 #number of inputs
        )
        self.qtgui_time_sink_x_0.set_update_time(0.10)
        self.qtgui_time_sink_x_0.set_y_axis(-1, 1)
        
        self.qtgui_time_sink_x_0.set_y_label("Amplitude", "")
        
        self.qtgui_time_sink_x_0.enable_tags(-1, True)
        self.qtgui_time_sink_x_0.set_trigger_mode(qtgui.TRIG_MODE_FREE, qtgui.TRIG_SLOPE_POS, 0.0, 0, 0, "")
        self.qtgui_time_sink_x_0.enable_autoscale(False)
        self.qtgui_time_sink_x_0.enable_grid(False)
        self.qtgui_time_sink_x_0.enable_control_panel(False)
        
        if not True:
          self.qtgui_time_sink_x_0.disable_legend()
        
        labels = ["", "", "", "", "",
                  "", "", "", "", ""]
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "blue"]
        styles = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        markers = [-1, -1, -1, -1, -1,
                   -1, -1, -1, -1, -1]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]
        
        for i in xrange(2*1):
            if len(labels[i]) == 0:
                if(i % 2 == 0):
                    self.qtgui_time_sink_x_0.set_line_label(i, "Re{{Data {0}}}".format(i/2))
                else:
                    self.qtgui_time_sink_x_0.set_line_label(i, "Im{{Data {0}}}".format(i/2))
            else:
                self.qtgui_time_sink_x_0.set_line_label(i, labels[i])
            self.qtgui_time_sink_x_0.set_line_width(i, widths[i])
            self.qtgui_time_sink_x_0.set_line_color(i, colors[i])
            self.qtgui_time_sink_x_0.set_line_style(i, styles[i])
            self.qtgui_time_sink_x_0.set_line_marker(i, markers[i])
            self.qtgui_time_sink_x_0.set_line_alpha(i, alphas[i])
        
        self._qtgui_time_sink_x_0_win = sip.wrapinstance(self.qtgui_time_sink_x_0.pyqwidget(), Qt.QWidget)
        self.my_tabs_layout_2.addWidget(self._qtgui_time_sink_x_0_win)
        self.qtgui_number_sink_1 = qtgui.number_sink(
            gr.sizeof_float,
            0,
            qtgui.NUM_GRAPH_HORIZ,
            5
        )
        self.qtgui_number_sink_1.set_update_time(0.10)
        self.qtgui_number_sink_1.set_title("")
        
        labels = ["Signal  11", "Signal  12", "Signal  13", "Signal  14", "Signal  15",
                  "", "", "", "", ""]
        units = ["", "", "", "", "",
                 "", "", "", "", ""]
        colors = [("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"),
                  ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black")]
        factor = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        for i in xrange(5):
            self.qtgui_number_sink_1.set_min(i, -1)
            self.qtgui_number_sink_1.set_max(i, 1)
            self.qtgui_number_sink_1.set_color(i, colors[i][0], colors[i][1])
            if len(labels[i]) == 0:
                self.qtgui_number_sink_1.set_label(i, "Data {0}".format(i))
            else:
                self.qtgui_number_sink_1.set_label(i, labels[i])
            self.qtgui_number_sink_1.set_unit(i, units[i])
            self.qtgui_number_sink_1.set_factor(i, factor[i])
        
        self.qtgui_number_sink_1.enable_autoscale(False)
        self._qtgui_number_sink_1_win = sip.wrapinstance(self.qtgui_number_sink_1.pyqwidget(), Qt.QWidget)
        self.my_tabs_layout_1.addWidget(self._qtgui_number_sink_1_win)
        self.qtgui_number_sink_0 = qtgui.number_sink(
            gr.sizeof_float,
            0,
            qtgui.NUM_GRAPH_HORIZ,
            10
        )
        self.qtgui_number_sink_0.set_update_time(0.10)
        self.qtgui_number_sink_0.set_title("")
        
        labels = ["Signal 1", "Signal  2", "Signal  3", "Signal  4", "Signal  5",
                  " Signal 6", "Signal 7", "Signal 8", "Signal  9", "Signal 10"]
        units = ["", "", "", "", "",
                 "", "", "", "", ""]
        colors = [("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"),
                  ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black"), ("black", "black")]
        factor = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        for i in xrange(10):
            self.qtgui_number_sink_0.set_min(i, -1)
            self.qtgui_number_sink_0.set_max(i, 1)
            self.qtgui_number_sink_0.set_color(i, colors[i][0], colors[i][1])
            if len(labels[i]) == 0:
                self.qtgui_number_sink_0.set_label(i, "Data {0}".format(i))
            else:
                self.qtgui_number_sink_0.set_label(i, labels[i])
            self.qtgui_number_sink_0.set_unit(i, units[i])
            self.qtgui_number_sink_0.set_factor(i, factor[i])
        
        self.qtgui_number_sink_0.enable_autoscale(False)
        self._qtgui_number_sink_0_win = sip.wrapinstance(self.qtgui_number_sink_0.pyqwidget(), Qt.QWidget)
        self.my_tabs_layout_0.addWidget(self._qtgui_number_sink_0_win)
        self.qtgui_freq_sink_x_0 = qtgui.freq_sink_c(
        	1024, #size
        	firdes.WIN_BLACKMAN_hARRIS, #wintype
        	0, #fc
        	samp_rate, #bw
        	"", #name
        	1 #number of inputs
        )
        self.qtgui_freq_sink_x_0.set_update_time(0.10)
        self.qtgui_freq_sink_x_0.set_y_axis(-140, 10)
        self.qtgui_freq_sink_x_0.set_trigger_mode(qtgui.TRIG_MODE_FREE, 0.0, 0, "")
        self.qtgui_freq_sink_x_0.enable_autoscale(False)
        self.qtgui_freq_sink_x_0.enable_grid(False)
        self.qtgui_freq_sink_x_0.set_fft_average(1.0)
        self.qtgui_freq_sink_x_0.enable_control_panel(False)
        
        if not True:
          self.qtgui_freq_sink_x_0.disable_legend()
        
        if "complex" == "float" or "complex" == "msg_float":
          self.qtgui_freq_sink_x_0.set_plot_pos_half(not True)
        
        labels = ["", "", "", "", "",
                  "", "", "", "", ""]
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "dark blue"]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]
        for i in xrange(1):
            if len(labels[i]) == 0:
                self.qtgui_freq_sink_x_0.set_line_label(i, "Data {0}".format(i))
            else:
                self.qtgui_freq_sink_x_0.set_line_label(i, labels[i])
            self.qtgui_freq_sink_x_0.set_line_width(i, widths[i])
            self.qtgui_freq_sink_x_0.set_line_color(i, colors[i])
            self.qtgui_freq_sink_x_0.set_line_alpha(i, alphas[i])
        
        self._qtgui_freq_sink_x_0_win = sip.wrapinstance(self.qtgui_freq_sink_x_0.pyqwidget(), Qt.QWidget)
        self.my_tabs_layout_2.addWidget(self._qtgui_freq_sink_x_0_win)
        self.multi_goertzel_0 = multi_goertzel(
            freqs=TX_freqs,
            goertzel_size=goertzel_length,
            mult=const,
            samp_rate=samp_rate,
        )
        self.blocks_streams_to_vector_0 = blocks.streams_to_vector(gr.sizeof_float*1, 15)
        self.blocks_file_sink_0 = blocks.file_sink(gr.sizeof_float*15, sys.argv[1], False)
        self.blocks_file_sink_0.set_unbuffered(False)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_streams_to_vector_0, 0), (self.blocks_file_sink_0, 0))    
        self.connect((self.multi_goertzel_0, 0), (self.blocks_streams_to_vector_0, 0))    
        self.connect((self.multi_goertzel_0, 1), (self.blocks_streams_to_vector_0, 1))    
        self.connect((self.multi_goertzel_0, 11), (self.blocks_streams_to_vector_0, 11))    
        self.connect((self.multi_goertzel_0, 12), (self.blocks_streams_to_vector_0, 12))    
        self.connect((self.multi_goertzel_0, 13), (self.blocks_streams_to_vector_0, 13))    
        self.connect((self.multi_goertzel_0, 14), (self.blocks_streams_to_vector_0, 14))    
        self.connect((self.multi_goertzel_0, 2), (self.blocks_streams_to_vector_0, 2))    
        self.connect((self.multi_goertzel_0, 3), (self.blocks_streams_to_vector_0, 3))    
        self.connect((self.multi_goertzel_0, 4), (self.blocks_streams_to_vector_0, 4))    
        self.connect((self.multi_goertzel_0, 5), (self.blocks_streams_to_vector_0, 5))    
        self.connect((self.multi_goertzel_0, 6), (self.blocks_streams_to_vector_0, 6))    
        self.connect((self.multi_goertzel_0, 7), (self.blocks_streams_to_vector_0, 7))    
        self.connect((self.multi_goertzel_0, 8), (self.blocks_streams_to_vector_0, 8))    
        self.connect((self.multi_goertzel_0, 9), (self.blocks_streams_to_vector_0, 9))    
        self.connect((self.multi_goertzel_0, 10), (self.blocks_streams_to_vector_0, 10))    
        self.connect((self.multi_goertzel_0, 0), (self.qtgui_number_sink_0, 0))    
        self.connect((self.multi_goertzel_0, 1), (self.qtgui_number_sink_0, 1))    
        self.connect((self.multi_goertzel_0, 2), (self.qtgui_number_sink_0, 2))    
        self.connect((self.multi_goertzel_0, 3), (self.qtgui_number_sink_0, 3))    
        self.connect((self.multi_goertzel_0, 4), (self.qtgui_number_sink_0, 4))    
        self.connect((self.multi_goertzel_0, 5), (self.qtgui_number_sink_0, 5))    
        self.connect((self.multi_goertzel_0, 6), (self.qtgui_number_sink_0, 6))    
        self.connect((self.multi_goertzel_0, 7), (self.qtgui_number_sink_0, 7))    
        self.connect((self.multi_goertzel_0, 8), (self.qtgui_number_sink_0, 8))    
        self.connect((self.multi_goertzel_0, 9), (self.qtgui_number_sink_0, 9))    
        self.connect((self.multi_goertzel_0, 11), (self.qtgui_number_sink_1, 1))    
        self.connect((self.multi_goertzel_0, 12), (self.qtgui_number_sink_1, 2))    
        self.connect((self.multi_goertzel_0, 13), (self.qtgui_number_sink_1, 3))    
        self.connect((self.multi_goertzel_0, 14), (self.qtgui_number_sink_1, 4))    
        self.connect((self.multi_goertzel_0, 10), (self.qtgui_number_sink_1, 0))    
        self.connect((self.uhd_usrp_source_0_0, 0), (self.multi_goertzel_0, 0))    
        self.connect((self.uhd_usrp_source_0_0, 0), (self.qtgui_freq_sink_x_0, 0))    
        self.connect((self.uhd_usrp_source_0_0, 0), (self.qtgui_time_sink_x_0, 0))    

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "vector_sink")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()


    def get_variable_0(self):
        return self.variable_0

    def set_variable_0(self, variable_0):
        self.variable_0 = variable_0

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.qtgui_freq_sink_x_0.set_frequency_range(0, self.samp_rate)
        self.qtgui_time_sink_x_0.set_samp_rate(self.samp_rate)
        self.uhd_usrp_source_0_0.set_samp_rate(self.samp_rate)
        self.multi_goertzel_0.set_samp_rate(self.samp_rate)

    def get_goertzel_length(self):
        return self.goertzel_length

    def set_goertzel_length(self, goertzel_length):
        self.goertzel_length = goertzel_length
        self.multi_goertzel_0.set_goertzel_size(self.goertzel_length)

    def get_const(self):
        return self.const

    def set_const(self, const):
        self.const = const
        self.multi_goertzel_0.set_mult(self.const)

    def get_TX_freqs(self):
        return self.TX_freqs

    def set_TX_freqs(self, TX_freqs):
        self.TX_freqs = TX_freqs
        self.multi_goertzel_0.set_freqs(self.TX_freqs)


def main(top_block_cls=vector_sink, options=None):

    from distutils.version import StrictVersion
    if StrictVersion(Qt.qVersion()) >= StrictVersion("4.5.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def quitting():
        tb.stop()
        tb.wait()
    qapp.connect(qapp, Qt.SIGNAL("aboutToQuit()"), quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
