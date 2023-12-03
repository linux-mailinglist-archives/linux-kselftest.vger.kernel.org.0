Return-Path: <linux-kselftest+bounces-1030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0778025C2
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 17:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507381C20971
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8B1642B;
	Sun,  3 Dec 2023 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbX2ippj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510A106;
	Sun,  3 Dec 2023 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701622354; x=1733158354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EA2ji1tKwR3xZ86ktJFvtkVW0seRxPfhzpnrXQXAqB4=;
  b=KbX2ippj1PaACm0L/STZvJXEIuCSVeRW3+51NiiqUGhFG3aU8WmuMnng
   n6pBUbdggDWh9pGZsZsWHpeaGXq9jyehvVv7c7L41zSxqW1HHbzVQQoow
   3KuRXjeRpzQXXAPdSOicV0AgAW0EDQi5drmGC4t+X+07cOFHL76UhBtS4
   M+mdWwooQ1FxhppcWaCQqS5IhCZQO1dOo6UsEtjgIueOXHdeFxowwVglS
   LPP6MD4Ua8h9ghHiVIuyPeAysmW/99Jz9wQmJwX1lQtgvxavqc0ERmdqX
   ScWPmZP1CIbl7Gfj+jrjQWLlgJf3c/gv2bBNmqYK/hAkB30y2MKQWZHgM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="706864"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="706864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 08:52:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="799345527"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="799345527"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2023 08:52:24 -0800
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add Launch Time request to xdp_hw_metadata
Date: Mon,  4 Dec 2023 00:51:29 +0800
Message-Id: <20231203165129.1740512-4-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203165129.1740512-1-yoong.siang.song@intel.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds Launch Time hw offload request to xdp_hw_metadata. User can
configure the delta of HW launch time to HW RX-time by using "-l" argument.
The default delta is set to 0.1 second.

This patch is tested with stmmac on Intel Tiger Lake platform. Refer to
result below, the delta between pre-determined launch time and actual HW
transmit complete time is around 24 us.

$ sudo ./xdp_hw_metadata eth0
...
xsk_ring_cons__peek: 1
0x55e577c3a7a8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100 EoP
No rx_hash err=-95
HW RX-time:   1677762523393813392 (sec:1677762523.3938) delta to User RX-time sec:0.0003 (259.290 usec)
XDP RX-time:   1677762523394050576 (sec:1677762523.3941) delta to User RX-time sec:0.0000 (22.106 usec)
0x55e577c3a7a8: ping-pong with csum=5619 (want 8626) csum_start=34 csum_offset=6
HW RX-time:   1677762523393813392 (sec:1677762523.3938) delta to HW Launch-time sec:0.1000 (100000.000 usec)
0x55e577c3a7a8: complete tx idx=0 addr=18
HW Launch-time:   1677762523493813392 (sec:1677762523.4938) delta to HW TX-complete-time sec:0.0000 (24.181 usec)
HW TX-complete-time:   1677762523493837573 (sec:1677762523.4938) delta to User TX-complete-time sec:0.0007 (737.636 usec)
XDP RX-time:   1677762523394050576 (sec:1677762523.3941) delta to User TX-complete-time sec:0.1005 (100524.633 usec)
HW RX-time:   1677762523393813392 (sec:1677762523.3938) delta to HW TX-complete-time sec:0.1000 (100024.181 usec)
0x55e577c3a7a8: complete rx idx=128 addr=80100

$ sudo ./xdp_hw_metadata eth0 -l 10000000
...
poll: 1 (0) skip=17 fail=0 redir=17
xsk_ring_cons__peek: 1
0x558336d397a8: rx_desc[15]->addr=9e100 addr=9e100 comp_addr=9e100 EoP
No rx_hash err=-95
HW RX-time:   1677762699254666655 (sec:1677762699.2547) delta to User RX-time sec:0.0003 (256.928 usec)
XDP RX-time:   1677762699254901232 (sec:1677762699.2549) delta to User RX-time sec:0.0000 (22.351 usec)
0x558336d397a8: ping-pong with csum=5619 (want 8626) csum_start=34 csum_offset=6
HW RX-time:   1677762699254666655 (sec:1677762699.2547) delta to HW Launch-time sec:0.0100 (10000.000 usec)
0x558336d397a8: complete tx idx=15 addr=f018
HW Launch-time:   1677762699264666655 (sec:1677762699.2647) delta to HW TX-complete-time sec:0.0000 (24.307 usec)
HW TX-complete-time:   1677762699264690962 (sec:1677762699.2647) delta to User TX-complete-time sec:0.0003 (309.901 usec)
XDP RX-time:   1677762699254901232 (sec:1677762699.2549) delta to User TX-complete-time sec:0.0101 (10099.631 usec)
HW RX-time:   1677762699254666655 (sec:1677762699.2547) delta to HW TX-complete-time sec:0.0100 (10024.307 usec)
0x558336d397a8: complete rx idx=143 addr=9e100

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3291625ba4fb..3e238bb310b7 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -13,6 +13,7 @@
  * - UDP 9091 packets trigger TX reply
  * - TX HW timestamp is requested and reported back upon completion
  * - TX checksum is requested
+ * - HW launch time is set for transmission
  */
 
 #include <test_progs.h>
@@ -61,6 +62,8 @@ int rxq;
 bool skip_tx;
 __u64 last_hw_rx_timestamp;
 __u64 last_xdp_rx_timestamp;
+__u64 last_launch_time;
+__u64 launch_time_delta_to_hw_rx_timestamp = 100000000; /* 0.1 second */
 
 void test__fail(void) { /* for network_helpers.c */ }
 
@@ -274,6 +277,8 @@ static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
 	if (meta->completion.tx_timestamp) {
 		__u64 ref_tstamp = gettime(clock_id);
 
+		print_tstamp_delta("HW Launch-time", "HW TX-complete-time",
+				   last_launch_time, meta->completion.tx_timestamp);
 		print_tstamp_delta("HW TX-complete-time", "User TX-complete-time",
 				   meta->completion.tx_timestamp, ref_tstamp);
 		print_tstamp_delta("XDP RX-time", "User TX-complete-time",
@@ -371,6 +376,14 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
 	       xsk, ntohs(udph->check), ntohs(want_csum),
 	       meta->request.csum_start, meta->request.csum_offset);
 
+	/* Set the value of launch time */
+	meta->flags |= XDP_TXMD_FLAGS_LAUNCH_TIME;
+	meta->request.launch_time = last_hw_rx_timestamp +
+				    launch_time_delta_to_hw_rx_timestamp;
+	last_launch_time = meta->request.launch_time;
+	print_tstamp_delta("HW RX-time", "HW Launch-time", last_hw_rx_timestamp,
+			   meta->request.launch_time);
+
 	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
 	tx_desc->options |= XDP_TX_METADATA;
 	tx_desc->len = len;
@@ -595,6 +608,7 @@ static void print_usage(void)
 		"  -h    Display this help and exit\n\n"
 		"  -m    Enable multi-buffer XDP for larger MTU\n"
 		"  -r    Don't generate AF_XDP reply (rx metadata only)\n"
+		"  -l    Delta of HW Launch-time to HW RX-time in ns (default: 0.1s)\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -605,7 +619,7 @@ static void read_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "chmr")) != -1) {
+	while ((opt = getopt(argc, argv, "chmrl:")) != -1) {
 		switch (opt) {
 		case 'c':
 			bind_flags &= ~XDP_USE_NEED_WAKEUP;
@@ -621,6 +635,9 @@ static void read_args(int argc, char *argv[])
 		case 'r':
 			skip_tx = true;
 			break;
+		case 'l':
+			launch_time_delta_to_hw_rx_timestamp = atoll(optarg);
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
-- 
2.34.1


