Return-Path: <linux-kselftest+bounces-25628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3DAA268FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 01:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6062D165675
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FA78C9C;
	Tue,  4 Feb 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqlgiC+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366661FFE;
	Tue,  4 Feb 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630210; cv=none; b=qS4ZPkakL4WPx1GIBh5A0chd6kbItT0uWWuzEARHh8lB5FgypbT22dKTF/d39jWGZKLmxx8wA5mwVtprxlUVTdfZ57/ryGB3W9caVacWctYbEQmhnA69AJONMzAg6prtd9xJ/MV9tVXqn+eUjaj1D60QIFfk11lM9MGOqu166A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630210; c=relaxed/simple;
	bh=ehFvC2zODM35kBmLLk307Ksy3lkn58MvCjgksxr7PfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlqYWuIR0Utrh8DBYpCpGMPIz27XECwLHiZ54tQhTAYHIlms/uLfhm4/XS/j/ZkOxgi1IwlavxKFBUifL/lKLWTRs0La3kiAmMFMZPb9GxS0MWmJrU6IkRWkrP4+FN6wSkviq+oW9xM/v1mG/jX6Z6rQFXZh+3OgfrmdIJrYGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqlgiC+R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738630208; x=1770166208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehFvC2zODM35kBmLLk307Ksy3lkn58MvCjgksxr7PfM=;
  b=EqlgiC+RYb3m7Aj+PlfyFgTfREgo3ZUrQPELECvGwbxID2o0HP1wP0py
   e5f/dgIm1RhVEiF7zls2VSZ+D0T/BM6RHqvdVAa+QmTVTf9URMi3R2NSF
   qCp9XI1nXa1S20o+8G59ZF47Mc/8XJQLthSZ0ATEVCfb2lJ/xD2prFwM8
   cT9MDatEcgblDYCEY616624bP9GGstR+0f59WxpzRSTQhSnVTXr3xSwx2
   w+uaNDdrtM48PEg7TRVlJKEdM9zOMQSI6RviEGgi5tNrcBl52K7Hpyi5/
   W+itpIWHg/zfLmr0xpjXe0OWd/mFw/LQ+J4nUgR+W/BbZnLnafGniVODz
   w==;
X-CSE-ConnectionGUID: zAqWwsE7Q/mDTo1xNWiF9A==
X-CSE-MsgGUID: QDxLhyRXRWawwvmDtREVSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39296480"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="39296480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 16:50:07 -0800
X-CSE-ConnectionGUID: voCgiHyERWWfWtGKRERL0g==
X-CSE-MsgGUID: Hny0PVd+Rpe0lziVXfu6Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115605269"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa005.jf.intel.com with ESMTP; 03 Feb 2025 16:49:55 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v7 2/5] selftests/bpf: Add launch time request to xdp_hw_metadata
Date: Tue,  4 Feb 2025 08:49:04 +0800
Message-Id: <20250204004907.789330-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204004907.789330-1-yoong.siang.song@intel.com>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add launch time hardware offload request to xdp_hw_metadata. Users can
configure the delta of launch time relative to HW RX-time using the "-l"
argument. By default, the delta is set to 0 ns, which means the launch time
is disabled. By setting the delta to a non-zero value, the launch time
hardware offload feature will be enabled and requested. Additionally, users
can configure the Tx Queue to be enabled with the launch time hardware
offload using the "-L" argument. By default, Tx Queue 0 will be used.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 168 +++++++++++++++++-
 1 file changed, 163 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f7b15d6c6ed..3d8de0d4c96a 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -13,6 +13,7 @@
  * - UDP 9091 packets trigger TX reply
  * - TX HW timestamp is requested and reported back upon completion
  * - TX checksum is requested
+ * - TX launch time HW offload is requested for transmission
  */
 
 #include <test_progs.h>
@@ -37,6 +38,15 @@
 #include <time.h>
 #include <unistd.h>
 #include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <linux/pkt_sched.h>
+#include <linux/pkt_cls.h>
+#include <linux/ethtool.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
 
 #include "xdp_metadata.h"
 
@@ -64,6 +74,18 @@ int rxq;
 bool skip_tx;
 __u64 last_hw_rx_timestamp;
 __u64 last_xdp_rx_timestamp;
+__u64 last_launch_time;
+__u64 launch_time_delta_to_hw_rx_timestamp;
+int launch_time_queue;
+
+#define run_command(cmd, ...)					\
+({								\
+	char command[1024];					\
+	memset(command, 0, sizeof(command));			\
+	snprintf(command, sizeof(command), cmd, ##__VA_ARGS__);	\
+	fprintf(stderr, "Running: %s\n", command);		\
+	system(command);					\
+})
 
 void test__fail(void) { /* for network_helpers.c */ }
 
@@ -298,6 +320,12 @@ static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
 	if (meta->completion.tx_timestamp) {
 		__u64 ref_tstamp = gettime(clock_id);
 
+		if (launch_time_delta_to_hw_rx_timestamp) {
+			print_tstamp_delta("HW Launch-time",
+					   "HW TX-complete-time",
+					   last_launch_time,
+					   meta->completion.tx_timestamp);
+		}
 		print_tstamp_delta("HW TX-complete-time", "User TX-complete-time",
 				   meta->completion.tx_timestamp, ref_tstamp);
 		print_tstamp_delta("XDP RX-time", "User TX-complete-time",
@@ -395,6 +423,17 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
 	       xsk, ntohs(udph->check), ntohs(want_csum),
 	       meta->request.csum_start, meta->request.csum_offset);
 
+	/* Set the value of launch time */
+	if (launch_time_delta_to_hw_rx_timestamp) {
+		meta->flags |= XDP_TXMD_FLAGS_LAUNCH_TIME;
+		meta->request.launch_time = last_hw_rx_timestamp +
+					    launch_time_delta_to_hw_rx_timestamp;
+		last_launch_time = meta->request.launch_time;
+		print_tstamp_delta("HW RX-time", "HW Launch-time",
+				   last_hw_rx_timestamp,
+				   meta->request.launch_time);
+	}
+
 	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
 	tx_desc->options |= XDP_TX_METADATA;
 	tx_desc->len = len;
@@ -407,6 +446,7 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds[rxq + 1];
 	__u64 comp_addr;
+	__u64 deadline;
 	__u64 addr;
 	__u32 idx = 0;
 	int ret;
@@ -477,9 +517,15 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 					if (ret)
 						printf("kick_tx ret=%d\n", ret);
 
-					for (int j = 0; j < 500; j++) {
+					/* wait 1 second + cover launch time */
+					deadline = gettime(clock_id) +
+						   NANOSEC_PER_SEC +
+						   launch_time_delta_to_hw_rx_timestamp;
+					while (true) {
 						if (complete_tx(xsk, clock_id))
 							break;
+						if (gettime(clock_id) >= deadline)
+							break;
 						usleep(10);
 					}
 				}
@@ -608,6 +654,10 @@ static void print_usage(void)
 		"  -h    Display this help and exit\n\n"
 		"  -m    Enable multi-buffer XDP for larger MTU\n"
 		"  -r    Don't generate AF_XDP reply (rx metadata only)\n"
+		"  -l    Delta of launch time relative to HW RX-time in ns\n"
+		"        default: 0 ns (launch time request is disabled)\n"
+		"  -L    Tx Queue to be enabled with launch time offload\n"
+		"        default: 0 (Tx Queue 0)\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -618,7 +668,7 @@ static void read_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "chmr")) != -1) {
+	while ((opt = getopt(argc, argv, "chmrl:L:")) != -1) {
 		switch (opt) {
 		case 'c':
 			bind_flags &= ~XDP_USE_NEED_WAKEUP;
@@ -634,6 +684,12 @@ static void read_args(int argc, char *argv[])
 		case 'r':
 			skip_tx = true;
 			break;
+		case 'l':
+			launch_time_delta_to_hw_rx_timestamp = atoll(optarg);
+			break;
+		case 'L':
+			launch_time_queue = atoll(optarg);
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
@@ -657,23 +713,118 @@ static void read_args(int argc, char *argv[])
 		error(-1, errno, "Invalid interface name");
 }
 
+void clean_existing_configurations(void)
+{
+	/* Check and delete root qdisc if exists */
+	if (run_command("sudo tc qdisc show dev %s | grep -q 'qdisc mqprio 8001:'", ifname) == 0)
+		run_command("sudo tc qdisc del dev %s root", ifname);
+
+	/* Check and delete ingress qdisc if exists */
+	if (run_command("sudo tc qdisc show dev %s | grep -q 'qdisc ingress ffff:'", ifname) == 0)
+		run_command("sudo tc qdisc del dev %s ingress", ifname);
+
+	/* Check and delete ethtool filters if any exist */
+	if (run_command("sudo ethtool -n %s | grep -q 'Filter:'", ifname) == 0) {
+		run_command("sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 sudo ethtool -N %s delete >&2",
+			    ifname, ifname);
+	}
+}
+
+#define MAX_TC 16
+
 int main(int argc, char *argv[])
 {
 	clockid_t clock_id = CLOCK_TAI;
+	struct bpf_program *prog;
 	int server_fd = -1;
+	size_t map_len = 0;
+	size_t que_len = 0;
+	char *buf = NULL;
+	char *map = NULL;
+	char *que = NULL;
+	char *tmp = NULL;
+	int tc = 0;
 	int ret;
 	int i;
 
-	struct bpf_program *prog;
-
 	read_args(argc, argv);
 
 	rxq = rxq_num(ifname);
-
 	printf("rxq: %d\n", rxq);
 
+	if (launch_time_queue >= rxq || launch_time_queue < 0)
+		error(1, 0, "Invalid launch_time_queue.");
+
+	clean_existing_configurations();
+	sleep(1);
+
+	/* Enable tx and rx hardware timestamping */
 	hwtstamp_enable(ifname);
 
+	/* Prepare priority to traffic class map for tc-mqprio */
+	for (i = 0; i < MAX_TC; i++) {
+		if (i < rxq)
+			tc = i;
+
+		if (asprintf(&buf, "%d ", tc) == -1) {
+			printf("Failed to malloc buf for tc map.\n");
+			goto free_mem;
+		}
+
+		map_len += strlen(buf);
+		tmp = realloc(map, map_len + 1);
+		if (!tmp) {
+			printf("Failed to realloc tc map.\n");
+			goto free_mem;
+		}
+		map = tmp;
+		strcat(map, buf);
+		free(buf);
+		buf = NULL;
+	}
+
+	/* Prepare traffic class to hardware queue map for tc-mqprio */
+	for (i = 0; i <= tc; i++) {
+		if (asprintf(&buf, "1@%d ", i) == -1) {
+			printf("Failed to malloc buf for tc queues.\n");
+			goto free_mem;
+		}
+
+		que_len += strlen(buf);
+		tmp = realloc(que, que_len + 1);
+		if (!tmp) {
+			printf("Failed to realloc tc queues.\n");
+			goto free_mem;
+		}
+		que = tmp;
+		strcat(que, buf);
+		free(buf);
+		buf = NULL;
+	}
+
+	/* Add mqprio qdisc */
+	run_command("sudo tc qdisc add dev %s handle 8001: parent root mqprio num_tc %d map %squeues %shw 0",
+		    ifname, tc + 1, map, que);
+
+	/* To test launch time, send UDP packet with VLAN priority 1 to port 9091 */
+	if (launch_time_delta_to_hw_rx_timestamp) {
+		/* Enable launch time hardware offload on launch_time_queue */
+		run_command("sudo tc qdisc replace dev %s parent 8001:%d etf offload clockid CLOCK_TAI delta 500000",
+			    ifname, launch_time_queue + 1);
+		sleep(1);
+
+		/* Route incoming packet with VLAN priority 1 into launch_time_queue */
+		if (run_command("sudo ethtool -N %s flow-type ether vlan 0x2000 vlan-mask 0x1FFF action %d",
+				ifname, launch_time_queue)) {
+			run_command("sudo tc qdisc add dev %s ingress", ifname);
+			run_command("sudo tc filter add dev %s parent ffff: protocol 802.1Q flower vlan_prio 1 hw_tc %d",
+				    ifname, launch_time_queue);
+		}
+
+		/* Enable VLAN tag stripping offload */
+		run_command("sudo ethtool -K %s rxvlan on", ifname);
+	}
+
 	rx_xsk = malloc(sizeof(struct xsk) * rxq);
 	if (!rx_xsk)
 		error(1, ENOMEM, "malloc");
@@ -733,4 +884,11 @@ int main(int argc, char *argv[])
 	cleanup();
 	if (ret)
 		error(1, -ret, "verify_metadata");
+
+	clean_existing_configurations();
+
+free_mem:
+	free(buf);
+	free(map);
+	free(que);
 }
-- 
2.34.1


