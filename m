Return-Path: <linux-kselftest+bounces-13774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE459323AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA82CB237E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA556199223;
	Tue, 16 Jul 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MRc5TR7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF5198857;
	Tue, 16 Jul 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124830; cv=none; b=Kspw3b3lzJBPrTKw3Ts57TcKW1LT/sXIl05YrKK1pAgPzCpRe+PZHtlGizQg1EqdxmqDRs7agyzblVBWZSJbzc6uSg74qcF8roXvbqgIEInnRAMoc58LqjQNWuDBgDBM6VljJ4naHANrVt2NZxy6dkmqCYcV30A9ScIJlxbd4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124830; c=relaxed/simple;
	bh=NIGhcIKBUIyqUfosSK4nzHtlf9PoWN1j/FF5uPrtLPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBu0GoXGdAmc4UBHf55AqOEjakLgdctkuFDttFpLGZa5OYMRagwbNEtpHb98uZ4PNfifbYXhCpMPDU2ZbIksvP3eYnL+neZ0VqGY2SHA4kjDWwzbg9ZMtUmxp50AYvMpwQ7HNDDmw7QrcWSsBwuUy3tAtWM42jCkDlRgsnB7WqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MRc5TR7x; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08519FF803;
	Tue, 16 Jul 2024 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721124826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XTCAFFzDK1Em3oTEske9liNPu+vp0Q1u6Eiu90lASk=;
	b=MRc5TR7x5OEvhqDIyA/Yizwi36d8MEtX93QwOlq1h8b1Tm6KxAnZEX3jlgWQ+vyOPcX760
	SYE0j6YxBHjvR4bPPDzq/hSXFPaU3y+u16K1MyTaciFpklwhU5PC2/Py5W9V8jgbD4uNjb
	aTssiMs94aB6eJhjGyzxkILFsxiwhjl6l+S5H6/rLVaQ4f/lQlN/OPIHTKmSt94yw/hUGY
	4gVzfM0pVcclBC9Dg0SMtyNA0YRJtrz5Keg3rmsoqxVJEEU58waXtWADocKVQpRvm5veo8
	uUNRHCPFJeBBvOYtSwq8V0PmxRhev2x9D74+hfgCUSp7YWaQSrUQ8oF0YA8v0Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 16 Jul 2024 12:13:29 +0200
Subject: [PATCH v3 2/2] selftests/bpf: integrate test_xdp_veth into
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240716-convert_test_xdp_veth-v3-2-7b01389e3cb3@bootlin.com>
References: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
In-Reply-To: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

test_xdp_veth.sh tests that XDP return codes work as expected, by bringing
up multiple veth pairs isolated in different namespaces, attaching specific
xdp programs to each interface, and ensuring that the whole chain allows to
ping one end interface from the first one. The test runs well but is
currently not integrated in test_progs, which prevents it from being run
automatically in the CI infrastructure.

Rewrite it as a C test relying on libbpf to allow running it in the CI
infrastructure. The new code brings up the same network infrastructure and
reuses the same eBPF programs as test_xdp_veth.sh, for which skeletons are
already generated by the bpf tests makefile.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
The new code has been tested in an aarch64 qemu instance:
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

I have also checked that some minor alterations in the network
configuration (altering the redirect map, or not loading one of the xdp
programs) make the test fail.

On my testing setup, the test takes a bit more than 3 seconds to run on
average.

Changes in v3:
- fix doc style in the new test
- collect acked-by tag

Changes in v2:
- fix many formatting issues raised by checkpatch
- use static namespaces instead of random ones
- use SYS_NOFAIL instead of snprintf() + system ()
- squashed the new test addition patch and the old test removal patch
---
 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 211 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 ------------
 3 files changed, 211 insertions(+), 122 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a7932bead77d..2864a0dc04d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -117,7 +117,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
-	test_xdp_veth.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
new file mode 100644
index 000000000000..18ca8971c532
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Create 3 namespaces with 3 veth peers, and forward packets in-between using
+ * native XDP
+ *
+ *                      XDP_TX
+ * NS1(veth11)        NS2(veth22)        NS3(veth33)
+ *      |                  |                  |
+ *      |                  |                  |
+ *   (veth1,            (veth2,            (veth3,
+ *   id:111)            id:122)            id:133)
+ *     ^ |                ^ |                ^ |
+ *     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
+ *     | ------------------ ------------------ |
+ *     -----------------------------------------
+ *                    XDP_REDIRECT
+ */
+
+#define _GNU_SOURCE
+#include <net/if.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "xdp_dummy.skel.h"
+#include "xdp_redirect_map.skel.h"
+#include "xdp_tx.skel.h"
+
+#define VETH_PAIRS_COUNT	3
+#define NS_SUFFIX_LEN		6
+#define VETH_NAME_MAX_LEN	16
+#define IP_SRC				"10.1.1.11"
+#define IP_DST				"10.1.1.33"
+#define IP_CMD_MAX_LEN		128
+
+struct skeletons {
+	struct xdp_dummy *xdp_dummy;
+	struct xdp_tx *xdp_tx;
+	struct xdp_redirect_map *xdp_redirect_maps;
+};
+
+struct veth_configuration {
+	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
+	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
+	const char *namespace; /* Namespace for the remote veth */
+	char next_veth[VETH_NAME_MAX_LEN]; /* Local interface to redirect traffic to */
+	char *remote_addr; /* IP address of the remote veth */
+};
+
+static struct veth_configuration config[VETH_PAIRS_COUNT] = {
+	{
+		.local_veth = "veth1",
+		.remote_veth = "veth11",
+		.next_veth = "veth2",
+		.remote_addr = IP_SRC,
+		.namespace = "ns-veth11"
+	},
+	{
+		.local_veth = "veth2",
+		.remote_veth = "veth22",
+		.next_veth = "veth3",
+		.remote_addr = NULL,
+		.namespace = "ns-veth22"
+	},
+	{
+		.local_veth = "veth3",
+		.remote_veth = "veth33",
+		.next_veth = "veth1",
+		.remote_addr = IP_DST,
+		.namespace = "ns-veth33"
+	}
+};
+
+static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
+{
+	struct bpf_program *local_prog, *remote_prog;
+	struct bpf_link **local_link, **remote_link;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+	int interface;
+
+	switch (index) {
+	case 0:
+		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_0;
+		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_0;
+		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
+		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
+		break;
+	case 1:
+		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_1;
+		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_1;
+		remote_prog = skeletons->xdp_tx->progs.xdp_tx;
+		remote_link = &skeletons->xdp_tx->links.xdp_tx;
+		break;
+	case 2:
+		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_2;
+		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_2;
+		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
+		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
+		break;
+	}
+	interface = if_nametoindex(config[index].local_veth);
+	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
+		return -1;
+	link = bpf_program__attach_xdp(local_prog, interface);
+	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
+		return -1;
+	*local_link = link;
+	nstoken = open_netns(config[index].namespace);
+	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
+		return -1;
+	interface = if_nametoindex(config[index].remote_veth);
+	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
+		return -1;
+	link = bpf_program__attach_xdp(remote_prog, interface);
+	*remote_link = link;
+	close_netns(nstoken);
+	if (!ASSERT_OK_PTR(link, "attach xdp program to remote veth"))
+		return -1;
+
+	return 0;
+}
+
+static int configure_network(struct skeletons *skeletons)
+{
+	int interface_id;
+	int map_fd;
+	int err;
+	int i = 0;
+
+	/* First create and configure all interfaces */
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		SYS(fail, "ip netns add %s", config[i].namespace);
+		SYS(fail, "ip link add %s type veth peer name %s netns %s",
+		    config[i].local_veth, config[i].remote_veth, config[i].namespace);
+		SYS(fail, "ip link set dev %s up", config[i].local_veth);
+		if (config[i].remote_addr)
+			SYS(fail, "ip -n %s addr add %s/24 dev %s",	config[i].namespace,
+			    config[i].remote_addr, config[i].remote_veth);
+		SYS(fail, "ip -n %s link set dev %s up", config[i].namespace,
+		    config[i].remote_veth);
+	}
+
+	/* Then configure the redirect map and attach programs to interfaces */
+	map_fd = bpf_map__fd(skeletons->xdp_redirect_maps->maps.tx_port);
+	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
+		goto fail;
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		interface_id = if_nametoindex(config[i].next_veth);
+		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
+			goto fail;
+		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
+		if (!ASSERT_OK(err, "configure interface redirection through map"))
+			goto fail;
+		if (attach_programs_to_veth_pair(skeletons, i))
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	return -1;
+}
+
+static void cleanup_network(void)
+{
+	int i;
+
+	/* Deleting namespaces is enough to automatically remove veth pairs as well
+	 */
+	for (i = 0; i < VETH_PAIRS_COUNT; i++)
+		SYS_NOFAIL("ip netns del %s", config[i].namespace);
+}
+
+static int check_ping(struct skeletons *skeletons)
+{
+	/* Test: if all interfaces are properly configured, we must be able to ping
+	 * veth33 from veth11
+	 */
+	return SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
+					  config[0].namespace, IP_DST);
+}
+
+void test_xdp_veth_redirect(void)
+{
+	struct skeletons skeletons = {};
+
+	skeletons.xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
+		return;
+
+	skeletons.xdp_tx = xdp_tx__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_tx, "xdp_tx__open_and_load"))
+		goto destroy_xdp_dummy;
+
+	skeletons.xdp_redirect_maps = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_maps, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_tx;
+
+	if (configure_network(&skeletons))
+		goto destroy_xdp_redirect_map;
+
+	ASSERT_OK(check_ping(&skeletons), "ping");
+
+destroy_xdp_redirect_map:
+	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);
+destroy_xdp_tx:
+	xdp_tx__destroy(skeletons.xdp_tx);
+destroy_xdp_dummy:
+	xdp_dummy__destroy(skeletons.xdp_dummy);
+
+	cleanup_network();
+}
diff --git a/tools/testing/selftests/bpf/test_xdp_veth.sh b/tools/testing/selftests/bpf/test_xdp_veth.sh
deleted file mode 100755
index 5211ca9a0239..000000000000
--- a/tools/testing/selftests/bpf/test_xdp_veth.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Create 3 namespaces with 3 veth peers, and
-# forward packets in-between using native XDP
-#
-#                      XDP_TX
-# NS1(veth11)        NS2(veth22)        NS3(veth33)
-#      |                  |                  |
-#      |                  |                  |
-#   (veth1,            (veth2,            (veth3,
-#   id:111)            id:122)            id:133)
-#     ^ |                ^ |                ^ |
-#     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
-#     | ------------------ ------------------ |
-#     -----------------------------------------
-#                    XDP_REDIRECT
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-TESTNAME=xdp_veth
-BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
-BPF_DIR=$BPF_FS/test_$TESTNAME
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-readonly NS3="ns3-$(mktemp -u XXXXXX)"
-
-_cleanup()
-{
-	set +e
-	ip link del veth1 2> /dev/null
-	ip link del veth2 2> /dev/null
-	ip link del veth3 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-	ip netns del ${NS3} 2> /dev/null
-	rm -rf $BPF_DIR 2> /dev/null
-}
-
-cleanup_skip()
-{
-	echo "selftests: $TESTNAME [SKIP]"
-	_cleanup
-
-	exit $ksft_skip
-}
-
-cleanup()
-{
-	if [ "$?" = 0 ]; then
-		echo "selftests: $TESTNAME [PASS]"
-	else
-		echo "selftests: $TESTNAME [FAILED]"
-	fi
-	_cleanup
-}
-
-if [ $(id -u) -ne 0 ]; then
-	echo "selftests: $TESTNAME [SKIP] Need root privileges"
-	exit $ksft_skip
-fi
-
-if ! ip link set dev lo xdp off > /dev/null 2>&1; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without the ip xdp support"
-	exit $ksft_skip
-fi
-
-if [ -z "$BPF_FS" ]; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpffs mounted"
-	exit $ksft_skip
-fi
-
-if ! bpftool version > /dev/null 2>&1; then
-	echo "selftests: $TESTNAME [SKIP] Could not run test without bpftool"
-	exit $ksft_skip
-fi
-
-set -e
-
-trap cleanup_skip EXIT
-
-ip netns add ${NS1}
-ip netns add ${NS2}
-ip netns add ${NS3}
-
-ip link add veth1 index 111 type veth peer name veth11 netns ${NS1}
-ip link add veth2 index 122 type veth peer name veth22 netns ${NS2}
-ip link add veth3 index 133 type veth peer name veth33 netns ${NS3}
-
-ip link set veth1 up
-ip link set veth2 up
-ip link set veth3 up
-
-ip -n ${NS1} addr add 10.1.1.11/24 dev veth11
-ip -n ${NS3} addr add 10.1.1.33/24 dev veth33
-
-ip -n ${NS1} link set dev veth11 up
-ip -n ${NS2} link set dev veth22 up
-ip -n ${NS3} link set dev veth33 up
-
-mkdir $BPF_DIR
-bpftool prog loadall \
-	xdp_redirect_map.bpf.o $BPF_DIR/progs type xdp \
-	pinmaps $BPF_DIR/maps
-bpftool map update pinned $BPF_DIR/maps/tx_port key 0 0 0 0 value 122 0 0 0
-bpftool map update pinned $BPF_DIR/maps/tx_port key 1 0 0 0 value 133 0 0 0
-bpftool map update pinned $BPF_DIR/maps/tx_port key 2 0 0 0 value 111 0 0 0
-ip link set dev veth1 xdp pinned $BPF_DIR/progs/xdp_redirect_map_0
-ip link set dev veth2 xdp pinned $BPF_DIR/progs/xdp_redirect_map_1
-ip link set dev veth3 xdp pinned $BPF_DIR/progs/xdp_redirect_map_2
-
-ip -n ${NS1} link set dev veth11 xdp obj xdp_dummy.bpf.o sec xdp
-ip -n ${NS2} link set dev veth22 xdp obj xdp_tx.bpf.o sec xdp
-ip -n ${NS3} link set dev veth33 xdp obj xdp_dummy.bpf.o sec xdp
-
-trap cleanup EXIT
-
-ip netns exec ${NS1} ping -c 1 -W 1 10.1.1.33
-
-exit 0

-- 
2.45.2


