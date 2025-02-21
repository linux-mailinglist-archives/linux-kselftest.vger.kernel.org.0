Return-Path: <linux-kselftest+bounces-27151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500FBA3F153
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D747A7012
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93656205AC0;
	Fri, 21 Feb 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bY5LrwCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BE204C0F;
	Fri, 21 Feb 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132313; cv=none; b=cREPDAnDagunS9ANnSumYcKTtYfZVQ/FdCZSZ3jgCD6HcMRZR9vwLhpZ4WTjigIWvyPl6GSQLDYGf7GeQpvtt/8YcCzCH/dRQ46a9w9sE2Fzm7JgYrfHVY76j7iTKvj3Kpq1coMDfHok85zfr7ite6xJSMU1PLw0UaRmbNgJkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132313; c=relaxed/simple;
	bh=yv243jXDvfRKwEJ1pdvMXxfwOCDkz9fa8acf/tNUFVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhZiJH2/b6vQyPsn8ktN7r0SP9tUxpS7PgyBjcldcJMRuYLGupKW+rFnRFAC1beNaP0QVMiciEp64JSuenORuWCx5ZKerOcGTLI3ygIBa3NKaQPPpwZ3M3rZg48LZrHNMIJcQWiQBPFYXQ99ioMpdRrRBZdCF5hHUyHTB0p/R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bY5LrwCI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA311433C9;
	Fri, 21 Feb 2025 10:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740132303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBad+FwQjfZMKLdjYlf6Kj3LLklK5ogo+ra4Rmdc98c=;
	b=bY5LrwCI4dfTM4Lr0ZYXIbLZV0n3wCGrPFqcoME6Vy8lrVyLHV1Q1G3X8UnmfLpNKR6oEx
	u3bxiI0aR5eUtaR+wp/0PlNTFY7GQ+tomNdMHuFNFZzU6Au6dzWqMhFql2T7JtyMEJyyFC
	zEGdEbXRx/kAHfV/ahKyGWZTy6KyDD1BzP7LnDJFuYR/ja4aMqrnJ1gsdwXNIo/KVQOiZa
	z5fA+ecMq3hrLGH0S0UeKBR0/Pjkoix+qw/TkBeryJkecvWAfl4nHz5v/k3quiswZSJZk1
	zGX+5OmckkTGZPkOyKdRRIPpKTBYlGF6Os86umITX+/V23YHxiPY82L1ed5GPA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 21 Feb 2025 11:04:58 +0100
Subject: [PATCH bpf-next 2/2] selftests/bpf: Migrate test_xdp_vlan.sh into
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-xdp_vlan-v1-2-7d29847169af@bootlin.com>
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
In-Reply-To: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihi
 iekjeesghhmrghilhdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

test_xdp_vlan.sh isn't used by the BPF CI.

Migrate test_xdp_vlan.sh in prog_tests/xdp_vlan.c.
It uses the same BPF programs located in progs/test_xdp_vlan.c and the
same network topology.
Remove test_xdp_vlan*.sh and their Makefile entries.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   4 +-
 tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  | 175 ++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_vlan.sh       | 233 ---------------------
 .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |   9 -
 .../selftests/bpf/test_xdp_vlan_mode_native.sh     |   9 -
 5 files changed, 176 insertions(+), 254 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5dc9c84ed30f6e5a46572a9e428f692a79623469..09c1f731b8280696c729e3c87020ef749fee9dcb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -103,8 +103,6 @@ TEST_PROGS := test_kmod.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
-	test_xdp_vlan_mode_generic.sh \
-	test_xdp_vlan_mode_native.sh \
 	test_lwt_ip_encap.sh \
 	test_tc_tunnel.sh \
 	test_tc_edt.sh \
@@ -118,7 +116,7 @@ TEST_PROGS := test_kmod.sh \
 
 TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh \
-	test_xdp_vlan.sh test_bpftool.py
+	test_bpftool.py
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 	bpf_test_modorder_y.ko
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
new file mode 100644
index 0000000000000000000000000000000000000000..18dd25344de768aa83a162a0c091f28a4e5f505e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Network topology:
+ *  -----------        -----------
+ *  |  NS1    |        |   NS2   |
+ *  | veth0  -|--------|- veth0  |
+ *  -----------        -----------
+ *
+ */
+
+#define _GNU_SOURCE
+#include <net/if.h>
+#include <uapi/linux/if_link.h>
+
+#include "network_helpers.h"
+#include "test_progs.h"
+#include "test_xdp_vlan.skel.h"
+
+
+#define VETH_NAME	"veth0"
+#define NS_MAX_SIZE	32
+#define NS1_NAME	"ns-xdp-vlan-1-"
+#define NS2_NAME	"ns-xdp-vlan-2-"
+#define NS1_IP_ADDR	"100.64.10.1"
+#define NS2_IP_ADDR	"100.64.10.2"
+#define VLAN_ID		4011
+
+static int setup_network(char *ns1, char *ns2)
+{
+	if (!ASSERT_OK(append_tid(ns1, NS_MAX_SIZE), "create ns1 name"))
+		goto fail;
+	if (!ASSERT_OK(append_tid(ns2, NS_MAX_SIZE), "create ns2 name"))
+		goto fail;
+
+	SYS(fail, "ip netns add %s", ns1);
+	SYS(fail, "ip netns add %s", ns2);
+	SYS(fail, "ip -n %s link add %s type veth peer name %s netns %s",
+	    ns1, VETH_NAME, VETH_NAME, ns2);
+
+	/* NOTICE: XDP require VLAN header inside packet payload
+	 *  - Thus, disable VLAN offloading driver features
+	 */
+	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns1, VETH_NAME);
+	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns2, VETH_NAME);
+
+	/* NS1 configuration */
+	SYS(fail, "ip -n %s addr add %s/24 dev %s", ns1, NS1_IP_ADDR, VETH_NAME);
+	SYS(fail, "ip -n %s link set %s up", ns1, VETH_NAME);
+
+	/* NS2 configuration */
+	SYS(fail, "ip -n %s link add link %s name %s.%d type vlan id %d",
+	    ns2, VETH_NAME, VETH_NAME, VLAN_ID, VLAN_ID);
+	SYS(fail, "ip -n %s addr add %s/24 dev %s.%d", ns2, NS2_IP_ADDR, VETH_NAME, VLAN_ID);
+	SYS(fail, "ip -n %s link set %s up", ns2, VETH_NAME);
+	SYS(fail, "ip -n %s link set %s.%d up", ns2, VETH_NAME, VLAN_ID);
+
+	/* At this point ping should fail because VLAN tags are only used by NS2 */
+	return !SYS_NOFAIL("ip netns exec %s ping -W 1 -c1 %s", ns2, NS1_IP_ADDR);
+
+fail:
+	return -1;
+}
+
+static void cleanup_network(const char *ns1, const char *ns2)
+{
+	SYS_NOFAIL("ip netns del %s", ns1);
+	SYS_NOFAIL("ip netns del %s", ns2);
+}
+
+static void xdp_vlan(struct bpf_program *xdp, struct bpf_program *tc, u32 flags)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	char ns1[NS_MAX_SIZE] = NS1_NAME;
+	char ns2[NS_MAX_SIZE] = NS2_NAME;
+	struct nstoken *nstoken = NULL;
+	int interface;
+	int ret;
+
+	if (!ASSERT_OK(setup_network(ns1, ns2), "setup network"))
+		goto cleanup;
+
+	nstoken = open_netns(ns1);
+	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
+		goto cleanup;
+
+	interface = if_nametoindex(VETH_NAME);
+	if (!ASSERT_NEQ(interface, 0, "get interface index"))
+		goto cleanup;
+
+	ret = bpf_xdp_attach(interface, bpf_program__fd(xdp), flags, NULL);
+	if (!ASSERT_OK(ret, "attach xdp_vlan_change"))
+		goto cleanup;
+
+	tc_hook.ifindex = interface;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto detach_xdp;
+
+	/* Now we'll use BPF programs to pop/push the VLAN tags */
+	tc_opts.prog_fd = bpf_program__fd(tc);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto detach_xdp;
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	/* Now the namespaces can reach each-other, test with pings */
+	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns1, NS2_IP_ADDR);
+	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns2, NS1_IP_ADDR);
+
+
+detach_tc:
+	bpf_tc_detach(&tc_hook, &tc_opts);
+detach_xdp:
+	bpf_xdp_detach(interface, flags, NULL);
+cleanup:
+	close_netns(nstoken);
+	cleanup_network(ns1, ns2);
+}
+
+/* First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
+ * egress use TC to add back VLAN tag 4011
+ */
+void test_xdp_vlan_change(void)
+{
+	struct test_xdp_vlan *skel;
+
+	skel = test_xdp_vlan__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "xdp_vlan__open_and_load"))
+		return;
+
+	if (test__start_subtest("0"))
+		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push, 0);
+
+	if (test__start_subtest("DRV_MODE"))
+		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push,
+			 XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("SKB_MODE"))
+		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push,
+			 XDP_FLAGS_SKB_MODE);
+
+	test_xdp_vlan__destroy(skel);
+}
+
+/* Second test: XDP prog fully remove vlan header
+ *
+ * Catch kernel bug for generic-XDP, that doesn't allow us to
+ * remove a VLAN header, because skb->protocol still contain VLAN
+ * ETH_P_8021Q indication, and this cause overwriting of our changes.
+ */
+void test_xdp_vlan_remove(void)
+{
+	struct test_xdp_vlan *skel;
+
+	skel = test_xdp_vlan__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "xdp_vlan__open_and_load"))
+		return;
+
+	if (test__start_subtest("0"))
+		xdp_vlan(skel->progs.xdp_vlan_remove_outer2, skel->progs.tc_vlan_push, 0);
+
+	if (test__start_subtest("DRV_MODE"))
+		xdp_vlan(skel->progs.xdp_vlan_remove_outer2, skel->progs.tc_vlan_push,
+			 XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("SKB_MODE"))
+		xdp_vlan(skel->progs.xdp_vlan_remove_outer2, skel->progs.tc_vlan_push,
+			 XDP_FLAGS_SKB_MODE);
+
+	test_xdp_vlan__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh b/tools/testing/selftests/bpf/test_xdp_vlan.sh
deleted file mode 100755
index 7f672a040b312952679348721a5a17b8703cfc4b..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
+++ /dev/null
@@ -1,233 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Author: Jesper Dangaard Brouer <hawk@kernel.org>
-
-# Kselftest framework requirement - SKIP code is 4.
-readonly KSFT_SKIP=4
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-
-# Allow wrapper scripts to name test
-if [ -z "$TESTNAME" ]; then
-    TESTNAME=xdp_vlan
-fi
-
-# Default XDP mode
-XDP_MODE=xdpgeneric
-
-usage() {
-  echo "Testing XDP + TC eBPF VLAN manipulations: $TESTNAME"
-  echo ""
-  echo "Usage: $0 [-vfh]"
-  echo "  -v | --verbose : Verbose"
-  echo "  --flush        : Flush before starting (e.g. after --interactive)"
-  echo "  --interactive  : Keep netns setup running after test-run"
-  echo "  --mode=XXX     : Choose XDP mode (xdp | xdpgeneric | xdpdrv)"
-  echo ""
-}
-
-valid_xdp_mode()
-{
-	local mode=$1
-
-	case "$mode" in
-		xdpgeneric | xdpdrv | xdp)
-			return 0
-			;;
-		*)
-			return 1
-	esac
-}
-
-cleanup()
-{
-	local status=$?
-
-	if [ "$status" = "0" ]; then
-		echo "selftests: $TESTNAME [PASS]";
-	else
-		echo "selftests: $TESTNAME [FAILED]";
-	fi
-
-	if [ -n "$INTERACTIVE" ]; then
-		echo "Namespace setup still active explore with:"
-		echo " ip netns exec ${NS1} bash"
-		echo " ip netns exec ${NS2} bash"
-		exit $status
-	fi
-
-	set +e
-	ip link del veth1 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-}
-
-# Using external program "getopt" to get --long-options
-OPTIONS=$(getopt -o hvfi: \
-    --long verbose,flush,help,interactive,debug,mode: -- "$@")
-if (( $? != 0 )); then
-    usage
-    echo "selftests: $TESTNAME [FAILED] Error calling getopt, unknown option?"
-    exit 2
-fi
-eval set -- "$OPTIONS"
-
-##  --- Parse command line arguments / parameters ---
-while true; do
-	case "$1" in
-	    -v | --verbose)
-		export VERBOSE=yes
-		shift
-		;;
-	    -i | --interactive | --debug )
-		INTERACTIVE=yes
-		shift
-		;;
-	    -f | --flush )
-		cleanup
-		shift
-		;;
-	    --mode )
-		shift
-		XDP_MODE=$1
-		shift
-		;;
-	    -- )
-		shift
-		break
-		;;
-	    -h | --help )
-		usage;
-		echo "selftests: $TESTNAME [SKIP] usage help info requested"
-		exit $KSFT_SKIP
-		;;
-	    * )
-		shift
-		break
-		;;
-	esac
-done
-
-if [ "$EUID" -ne 0 ]; then
-	echo "selftests: $TESTNAME [FAILED] need root privileges"
-	exit 1
-fi
-
-valid_xdp_mode $XDP_MODE
-if [ $? -ne 0 ]; then
-	echo "selftests: $TESTNAME [FAILED] unknown XDP mode ($XDP_MODE)"
-	exit 1
-fi
-
-ip link set dev lo xdpgeneric off 2>/dev/null > /dev/null
-if [ $? -ne 0 ]; then
-	echo "selftests: $TESTNAME [SKIP] need ip xdp support"
-	exit $KSFT_SKIP
-fi
-
-# Interactive mode likely require us to cleanup netns
-if [ -n "$INTERACTIVE" ]; then
-	ip link del veth1 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-fi
-
-# Exit on failure
-set -e
-
-# Some shell-tools dependencies
-which ip > /dev/null
-which tc > /dev/null
-which ethtool > /dev/null
-
-# Make rest of shell verbose, showing comments as doc/info
-if [ -n "$VERBOSE" ]; then
-    set -v
-fi
-
-# Create two namespaces
-ip netns add ${NS1}
-ip netns add ${NS2}
-
-# Run cleanup if failing or on kill
-trap cleanup 0 2 3 6 9
-
-# Create veth pair
-ip link add veth1 type veth peer name veth2
-
-# Move veth1 and veth2 into the respective namespaces
-ip link set veth1 netns ${NS1}
-ip link set veth2 netns ${NS2}
-
-# NOTICE: XDP require VLAN header inside packet payload
-#  - Thus, disable VLAN offloading driver features
-#  - For veth REMEMBER TX side VLAN-offload
-#
-# Disable rx-vlan-offload (mostly needed on ns1)
-ip netns exec ${NS1} ethtool -K veth1 rxvlan off
-ip netns exec ${NS2} ethtool -K veth2 rxvlan off
-#
-# Disable tx-vlan-offload (mostly needed on ns2)
-ip netns exec ${NS2} ethtool -K veth2 txvlan off
-ip netns exec ${NS1} ethtool -K veth1 txvlan off
-
-export IPADDR1=100.64.41.1
-export IPADDR2=100.64.41.2
-
-# In ns1/veth1 add IP-addr on plain net_device
-ip netns exec ${NS1} ip addr add ${IPADDR1}/24 dev veth1
-ip netns exec ${NS1} ip link set veth1 up
-
-# In ns2/veth2 create VLAN device
-export VLAN=4011
-export DEVNS2=veth2
-ip netns exec ${NS2} ip link add link $DEVNS2 name $DEVNS2.$VLAN type vlan id $VLAN
-ip netns exec ${NS2} ip addr add ${IPADDR2}/24 dev $DEVNS2.$VLAN
-ip netns exec ${NS2} ip link set $DEVNS2 up
-ip netns exec ${NS2} ip link set $DEVNS2.$VLAN up
-
-# Bringup lo in netns (to avoids confusing people using --interactive)
-ip netns exec ${NS1} ip link set lo up
-ip netns exec ${NS2} ip link set lo up
-
-# At this point, the hosts cannot reach each-other,
-# because ns2 are using VLAN tags on the packets.
-
-ip netns exec ${NS2} sh -c 'ping -W 1 -c 1 100.64.41.1 || echo "Success: First ping must fail"'
-
-
-# Now we can use the test_xdp_vlan.c program to pop/push these VLAN tags
-# ----------------------------------------------------------------------
-# In ns1: ingress use XDP to remove VLAN tags
-export DEVNS1=veth1
-export BPF_FILE=test_xdp_vlan.bpf.o
-
-# First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
-export XDP_PROG=xdp_vlan_change
-ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE program $XDP_PROG
-
-# In ns1: egress use TC to add back VLAN tag 4011
-#  (del cmd)
-#  tc qdisc del dev $DEVNS1 clsact 2> /dev/null
-#
-ip netns exec ${NS1} tc qdisc add dev $DEVNS1 clsact
-ip netns exec ${NS1} tc filter add dev $DEVNS1 egress \
-  prio 1 handle 1 bpf da obj $BPF_FILE program tc_vlan_push
-
-# Now the namespaces can reach each-other, test with ping:
-ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1
-ip netns exec ${NS1} ping -i 0.2 -W 2 -c 2 $IPADDR2
-
-# Second test: Replace xdp prog, that fully remove vlan header
-#
-# Catch kernel bug for generic-XDP, that does didn't allow us to
-# remove a VLAN header, because skb->protocol still contain VLAN
-# ETH_P_8021Q indication, and this cause overwriting of our changes.
-#
-export XDP_PROG=xdp_vlan_remove_outer2
-ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE off
-ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE program $XDP_PROG
-
-# Now the namespaces should still be able reach each-other, test with ping:
-ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1
-ip netns exec ${NS1} ping -i 0.2 -W 2 -c 2 $IPADDR2
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan_mode_generic.sh b/tools/testing/selftests/bpf/test_xdp_vlan_mode_generic.sh
deleted file mode 100755
index c515326d6d59c64fe225fee82463dd43d5ae004e..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_vlan_mode_generic.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# Exit on failure
-set -e
-
-# Wrapper script to test generic-XDP
-export TESTNAME=xdp_vlan_mode_generic
-./test_xdp_vlan.sh --mode=xdpgeneric
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan_mode_native.sh b/tools/testing/selftests/bpf/test_xdp_vlan_mode_native.sh
deleted file mode 100755
index 5cf7ce1f16c162f6596cfdd14fc214b86271ad7e..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_vlan_mode_native.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# Exit on failure
-set -e
-
-# Wrapper script to test native-XDP
-export TESTNAME=xdp_vlan_mode_native
-./test_xdp_vlan.sh --mode=xdpdrv

-- 
2.48.1


