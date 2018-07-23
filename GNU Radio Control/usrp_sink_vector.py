#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Usrp Sink Vector
# Generated: Thu Jun 21 20:54:28 2018
##################################################

import os
import sys
sys.path.append(os.environ.get('GRC_HIER_PATH', os.path.expanduser('~/.grc_gnuradio')))

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import uhd
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from multi_goertzel import multi_goertzel  # grc-generated hier_block
from optparse import OptionParser
import time


class usrp_sink_vector(gr.top_block):

    def __init__(self, filename):
        gr.top_block.__init__(self, "Usrp Sink Vector")

        ##################################################
        # Variables
        ##################################################
        self.filename = filename
        self.samp_rate = samp_rate = 2e6
        self.TX_freqs = TX_freqs = (1e5, 1.5e5, 2e5,2.5e5,3e5,3.5e5,4e5,4.5e5,5e5, 5.5e5, 6e5, 6.5e5,7e5,7.5e5,8e5)

        ##################################################
        # Blocks
        ##################################################
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
        self.multi_goertzel_0 = multi_goertzel(
            freqs=self.TX_freqs,
            goertzel_size=2048,
            mult=2,
            samp_rate=int(samp_rate),
        )
        self.blocks_streams_to_vector_0 = blocks.streams_to_vector(gr.sizeof_float*1, 15)
        self.blocks_file_sink_0 = blocks.file_sink(gr.sizeof_float*15, filename, False)
        self.blocks_file_sink_0.set_unbuffered(False)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_streams_to_vector_0, 0), (self.blocks_file_sink_0, 0))
        self.connect((self.multi_goertzel_0, 0), (self.blocks_streams_to_vector_0, 0))
        self.connect((self.multi_goertzel_0, 1), (self.blocks_streams_to_vector_0, 1))
        self.connect((self.multi_goertzel_0, 10), (self.blocks_streams_to_vector_0, 10))
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
        self.connect((self.uhd_usrp_source_0_0, 0), (self.multi_goertzel_0, 0))

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.uhd_usrp_source_0_0.set_samp_rate(self.samp_rate)
        self.multi_goertzel_0.set_samp_rate(int(self.samp_rate))

    def get_TX_freqs(self):
        return self.TX_freqs

    def set_TX_freqs(self, TX_freqs):
        self.TX_freqs = TX_freqs


def main(top_block_cls=usrp_sink_vector, options=None):

    tb = top_block_cls(sys.argv[1])
    tb.start()
    tb.wait()


if __name__ == '__main__':
    main()
