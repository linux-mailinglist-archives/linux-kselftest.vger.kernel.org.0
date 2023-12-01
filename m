Return-Path: <linux-kselftest+bounces-943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA38003CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCD281703
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C847C8EA;
	Fri,  1 Dec 2023 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqT0WF8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD18171B;
	Thu, 30 Nov 2023 22:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701411936; x=1732947936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQNULAQatHgdOb4jEBZidX81obMEZZpL3p3O+o5FSf0=;
  b=FqT0WF8Jtzw8Y23N13ojU8EeDHcKy29M4jci0R26JdXMDYBtLjHAlxwL
   PMMjIidCmv8g44VsZ/WfdD9ASDwaoQPhlanec66GKApg5h05egWihfRex
   +ekrqMBJjU5vJHCqJi1gjEbMlWvLSLORzUN9snxC+jnJFbXuLgb9lLx5V
   tHRS4CX9i3zAmmgN/sJcInOj8Xvu2vDrkkFlxAW+KwOChu5jlvix2JJBu
   KWlZ4moUm0YhQlp0LQd5lvZKPnIGENC0omQOrjB9ih5uYTSNM0Er7P2Xk
   9AUCND/hgrZHYm8sFDOYqlzrrJw0M/b+xRtUP5vFEg5N9BUWFU/5iSLoy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6722960"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="6722960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 22:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803945141"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="803945141"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 22:25:23 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	xdp-hints@xdp-project.net,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add txtime to xdp_hw_metadata
Date: Fri,  1 Dec 2023 14:24:21 +0800
Message-Id: <20231201062421.1074768-4-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201062421.1074768-1-yoong.siang.song@intel.com>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds txtime support to xdp_hw_metadata. User can configure the
delta of HW txtime to HW RX-time by using "-l" argument. The default delta
is set to 1 second.

This patch is tested with stmmac on Intel Tiger Lake platform. Refer to
result below, the delta between pre-determined ETF txtime and actual HW
transmit complete time is around 24 us.

$ sudo ./xdp_hw_metadata eth0
...
xsk_ring_cons__peek: 1
0x55fcb80ce7a8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100 EoP
No rx_hash err=-95
HW RX-time:   1677764507059055964 (sec:1677764507.0591) delta to User RX-time sec:0.0002 (237.548 usec)
XDP RX-time:   1677764507059280741 (sec:1677764507.0593) delta to User RX-time sec:0.0000 (12.771 usec)
0x55fcb80ce7a8: ping-pong with csum=5619 (want 8626) csum_start=34 csum_offset=6
HW RX-time:   1677764507059055964 (sec:1677764507.0591) delta to HW Txtime sec:1.0000 (1000000.000 usec)
0x55fcb80ce7a8: complete tx idx=0 addr=18
HW Txtime:   1677764508059055964 (sec:1677764508.0591) delta to HW TX-complete-time sec:0.0000 (24.235 usec)
HW TX-complete-time:   1677764508059080199 (sec:1677764508.0591) delta to User TX-complete-time sec:0.0054 (5423.263 usec)
XDP RX-time:   1677764507059280741 (sec:1677764507.0593) delta to User TX-complete-time sec:1.0052 (1005222.721 usec)
HW RX-time:   1677764507059055964 (sec:1677764507.0591) delta to HW TX-complete-time sec:1.0000 (1000024.235 usec)
0x55fcb80ce7a8: complete rx idx=128 addr=80100

$ sudo ./xdp_hw_metadata eth0 -l 10000000
...
xsk_ring_cons__peek: 1
0x5626d54de7a8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100 EoP
No rx_hash err=-95
HW RX-time:   1677764655807717783 (sec:1677764655.8077) delta to User RX-time sec:0.0002 (240.571 usec)
XDP RX-time:   1677764655807942983 (sec:1677764655.8079) delta to User RX-time sec:0.0000 (15.371 usec)
0x5626d54de7a8: ping-pong with csum=5619 (want 8626) csum_start=34 csum_offset=6
HW RX-time:   1677764655807717783 (sec:1677764655.8077) delta to HW Txtime sec:0.0100 (10000.000 usec)
0x5626d54de7a8: complete tx idx=0 addr=18
HW Txtime:   1677764655817717783 (sec:1677764655.8177) delta to HW TX-complete-time sec:0.0000 (23.965 usec)
HW TX-complete-time:   1677764655817741748 (sec:1677764655.8177) delta to User TX-complete-time sec:0.0003 (291.792 usec)
XDP RX-time:   1677764655807942983 (sec:1677764655.8079) delta to User TX-complete-time sec:0.0101 (10090.557 usec)
HW RX-time:   1677764655807717783 (sec:1677764655.8077) delta to HW TX-complete-time sec:0.0100 (10023.965 usec)
0x5626d54de7a8: complete rx idx=128 addr=80100

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3291625ba4fb..e9c3e29dc538 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -13,6 +13,7 @@
  * - UDP 9091 packets trigger TX reply
  * - TX HW timestamp is requested and reported back upon completion
  * - TX checksum is requested
+ * - HW txtime is set for transmission
  */
 
 #include <test_progs.h>
@@ -61,6 +62,8 @@ int rxq;
 bool skip_tx;
 __u64 last_hw_rx_timestamp;
 __u64 last_xdp_rx_timestamp;
+__u64 last_txtime;
+__u64 txtime_delta_to_hw_rx_timestamp = 1000000000; /* 1 second */
 
 void test__fail(void) { /* for network_helpers.c */ }
 
@@ -274,6 +277,8 @@ static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
 	if (meta->completion.tx_timestamp) {
 		__u64 ref_tstamp = gettime(clock_id);
 
+		print_tstamp_delta("HW Txtime", "HW TX-complete-time",
+				   last_txtime, meta->completion.tx_timestamp);
 		print_tstamp_delta("HW TX-complete-time", "User TX-complete-time",
 				   meta->completion.tx_timestamp, ref_tstamp);
 		print_tstamp_delta("XDP RX-time", "User TX-complete-time",
@@ -371,6 +376,13 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
 	       xsk, ntohs(udph->check), ntohs(want_csum),
 	       meta->request.csum_start, meta->request.csum_offset);
 
+	/* Set txtime for Earliest TxTime First (ETF) */
+	meta->flags |= XDP_TXMD_FLAGS_TXTIME;
+	meta->request.txtime = last_hw_rx_timestamp + txtime_delta_to_hw_rx_timestamp;
+	last_txtime = meta->request.txtime;
+	print_tstamp_delta("HW RX-time", "HW Txtime", last_hw_rx_timestamp,
+			   meta->request.txtime);
+
 	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
 	tx_desc->options |= XDP_TX_METADATA;
 	tx_desc->len = len;
@@ -595,6 +607,7 @@ static void print_usage(void)
 		"  -h    Display this help and exit\n\n"
 		"  -m    Enable multi-buffer XDP for larger MTU\n"
 		"  -r    Don't generate AF_XDP reply (rx metadata only)\n"
+		"  -l    Delta of HW Txtime to HW RX-time in ns (default: 1s)\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -605,7 +618,7 @@ static void read_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "chmr")) != -1) {
+	while ((opt = getopt(argc, argv, "chmrl:")) != -1) {
 		switch (opt) {
 		case 'c':
 			bind_flags &= ~XDP_USE_NEED_WAKEUP;
@@ -621,6 +634,9 @@ static void read_args(int argc, char *argv[])
 		case 'r':
 			skip_tx = true;
 			break;
+		case 'l':
+			txtime_delta_to_hw_rx_timestamp = atoll(optarg);
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
-- 
2.34.1


