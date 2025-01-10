Return-Path: <linux-kselftest+bounces-24193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2429A08B8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C316A5FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A220B206;
	Fri, 10 Jan 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m5qvw/hd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E520A5E0;
	Fri, 10 Jan 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500880; cv=none; b=rYild07qlzHIrRAGMserZ6O1Dml2+7P5IDHpDz+/wDxDQGrB+jQ8cvHKDpBHcVRJOIRn14ZXMjyn5E3gkXDQL5yIjxdrEcDBrcq3IXUcqCNNS3Wm7U0kkhMG8rPcFJuzxaHBxi+sblhkdif+NBrlNee+F0sCA03FaNhHKncM8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500880; c=relaxed/simple;
	bh=GN2Qbc1lb28x8eQ48M8dy+Y0aKepYwcg26f/ws3e+bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMgfgxpdhdMTtW0tp5AIYGM8p+fizoPb5QtlW7tSVdVTHGPsQ1ol4sdhRlaHzLR3sjbX9XynK+6rtkEMEFbwcmZj8ZbU83c9XfbGNzda/XwctYnluphsYZeS1galcAdDbqHqkh2e0o6kLOKk7MZXm/BabqlJJJcKiaGtxoDbJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m5qvw/hd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AD36FF803;
	Fri, 10 Jan 2025 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736500876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRJ5E+qj2eJLXhxifaIpV4tOcmcpEz35aSDxOfGq9Ms=;
	b=m5qvw/hd0FrO69W27DBhzgUSinQJJyuAGk3vm265MPMNPqgvaHj6/cYYe5/wk1T5s/NZEb
	/gs8PUo9FTKH2XF7EW8g9kZ6Unh4pT2QUitn2lBuDK5LKBOitEnMkj3PU4mOubkGpLUgav
	znUdTUlZUyBWvMlgcAPYx2fnIPnoScp791DMDWu8sXp+IvQuyy6n/I1ZpodQrEnZ0Jgy+F
	oI0BMrriU3gvJEg0M6cP9TZxYbEiZQFvd/PiVoYTpsofkQGIw/3ztH6w9far1ctOePiotM
	g2xcoFCsj/Qms5MR9cpU9nXmQ4Z60fwzAmVn1nHI9arT1VWmDJ38IOuI0LrzMQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 10 Jan 2025 10:21:10 +0100
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Migrate
 test_xdp_redirect.sh to xdp_do_redirect.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-xdp_redirect-v2-2-b8f3ae53e894@bootlin.com>
References: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
In-Reply-To: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

test_xdp_redirect.sh can't be used by the BPF CI.

Migrate test_xdp_redirect.sh into a new test case in xdp_do_redirect.c.
It uses the same network topology and the same BPF programs located in
progs/test_xdp_redirect.c and progs/xdp_dummy.c.
Remove test_xdp_redirect.sh and its Makefile entry.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     | 165 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |  79 ----------
 3 files changed, 165 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ea9cee5de0f8df5908820c8d79a1417c26794aa5..b59aa621b06b8aecce62f7d0c7a6b5c4feb0e4fd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -100,7 +100,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_xdp_redirect.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
 	test_tunnel.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index d12f926b4b8b1fcbc2a88ef7e3bd20ef2cbbd72c..9052ed0fcf427db9ffc4ff33fbc46ab0ba561b07 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -11,6 +11,8 @@
 #include <bpf/bpf_endian.h>
 #include <uapi/linux/netdev.h>
 #include "test_xdp_do_redirect.skel.h"
+#include "test_xdp_redirect.skel.h"
+#include "xdp_dummy.skel.h"
 
 struct udp_packet {
 	struct ethhdr eth;
@@ -246,3 +248,166 @@ void test_xdp_do_redirect(void)
 	SYS_NOFAIL("ip netns del testns");
 	test_xdp_do_redirect__destroy(skel);
 }
+
+#define NS_NB		3
+#define NS0		"NS0"
+#define NS1		"NS1"
+#define NS2		"NS2"
+#define IPV4_NETWORK	"10.1.1"
+#define VETH1_INDEX	111
+#define VETH2_INDEX	222
+
+struct test_data {
+	struct netns_obj *ns[NS_NB];
+	u32 xdp_flags;
+};
+
+static void cleanup(struct test_data *data)
+{
+	int i;
+
+	for (i = 0; i < NS_NB; i++)
+		netns_free(data->ns[i]);
+}
+
+/**
+ * ping_setup -
+ * Create two veth peers and forward packets in-between using XDP
+ *
+ *    ------------           ------------
+ *    |    NS1   |           |    NS2   |
+ *    |   veth0  |           |   veth0  |
+ *    | 10.1.1.1 |           | 10.1.1.2 |
+ *    -----|------           ------|-----
+ *         |                       |
+ *         |                       |
+ *    -----|-----------------------|-------
+ *    |  veth1                   veth2    |
+ *    | (id:111)                (id:222)  |
+ *    |    |                        |     |
+ *    |    ----- xdp forwarding -----     |
+ *    |                                   |
+ *    |               NS0                 |
+ *    -------------------------------------
+ */
+static int ping_setup(struct test_data *data)
+{
+	int i;
+
+	data->ns[0] = netns_new(NS0, false);
+	if (!ASSERT_OK_PTR(data->ns[0], "create ns"))
+		return -1;
+
+	for (i = 1; i < NS_NB; i++) {
+		char ns_name[4] = {};
+
+		snprintf(ns_name, 4, "NS%d", i);
+		data->ns[i] = netns_new(ns_name, false);
+		if (!ASSERT_OK_PTR(data->ns[i], "create ns"))
+			goto fail;
+
+		SYS(fail,
+		    "ip -n %s link add veth%d index %d%d%d type veth peer name veth0 netns %s",
+		    NS0, i, i, i, i, ns_name);
+		SYS(fail, "ip -n %s link set veth%d up", NS0, i);
+
+		SYS(fail, "ip -n %s addr add %s.%d/24 dev veth0", ns_name, IPV4_NETWORK, i);
+		SYS(fail, "ip -n %s link set veth0 up", ns_name);
+	}
+
+	return 0;
+
+fail:
+	cleanup(data);
+	return -1;
+}
+
+static void ping_test(struct test_data *data)
+{
+	struct test_xdp_redirect *skel = NULL;
+	struct xdp_dummy *skel_dummy = NULL;
+	struct nstoken *nstoken = NULL;
+	int i, ret;
+
+	skel_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skel_dummy, "open and load xdp_dummy skeleton"))
+		goto close;
+
+	for (i = 1; i < NS_NB; i++) {
+		char ns_name[4] = {};
+
+		snprintf(ns_name, 4, "NS%d", i);
+		nstoken = open_netns(ns_name);
+		if (!ASSERT_OK_PTR(nstoken, "open ns"))
+			goto close;
+
+		ret = bpf_xdp_attach(if_nametoindex("veth0"),
+				     bpf_program__fd(skel_dummy->progs.xdp_dummy_prog),
+				     data->xdp_flags, NULL);
+		if (!ASSERT_GE(ret, 0, "bpf_xdp_attach dummy_prog"))
+			goto close;
+
+		close_netns(nstoken);
+		nstoken = NULL;
+	}
+
+	skel = test_xdp_redirect__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto close;
+
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto close;
+
+	ret = bpf_xdp_attach(VETH2_INDEX,
+			     bpf_program__fd(skel->progs.xdp_redirect_to_111),
+			     data->xdp_flags, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	ret = bpf_xdp_attach(VETH1_INDEX,
+			     bpf_program__fd(skel->progs.xdp_redirect_to_222),
+			     data->xdp_flags, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
+		goto close;
+
+	SYS(close, "ping -c 1 %s.2", IPV4_NETWORK);
+
+close:
+	close_netns(nstoken);
+	xdp_dummy__destroy(skel_dummy);
+	test_xdp_redirect__destroy(skel);
+}
+
+
+static void xdp_redirect_ping(u32 xdp_flags)
+{
+	struct test_data data = {};
+
+	if (ping_setup(&data) < 0)
+		return;
+
+	data.xdp_flags = xdp_flags;
+	ping_test(&data);
+	cleanup(&data);
+}
+
+void test_xdp_index_redirect(void)
+{
+	if (test__start_subtest("noflag"))
+		xdp_redirect_ping(0);
+
+	if (test__start_subtest("drvflag"))
+		xdp_redirect_ping(XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("skbflag"))
+		xdp_redirect_ping(XDP_FLAGS_SKB_MODE);
+}
+
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
deleted file mode 100755
index 3c61a1c22b084aa5ca824ec5e8057aa2fee12b71..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
+++ /dev/null
@@ -1,79 +0,0 @@
-#!/bin/bash
-# Create 2 namespaces with two veth peers, and
-# forward packets in-between using generic XDP
-#
-# NS1(veth11)     NS2(veth22)
-#     |               |
-#     |               |
-#   (veth1, ------ (veth2,
-#   id:111)         id:222)
-#     | xdp forwarding |
-#     ------------------
-
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-ret=0
-
-setup()
-{
-
-	local xdpmode=$1
-
-	ip netns add ${NS1}
-	ip netns add ${NS2}
-
-	ip link add veth1 index 111 type veth peer name veth11 netns ${NS1}
-	ip link add veth2 index 222 type veth peer name veth22 netns ${NS2}
-
-	ip link set veth1 up
-	ip link set veth2 up
-	ip -n ${NS1} link set dev veth11 up
-	ip -n ${NS2} link set dev veth22 up
-
-	ip -n ${NS1} addr add 10.1.1.11/24 dev veth11
-	ip -n ${NS2} addr add 10.1.1.22/24 dev veth22
-}
-
-cleanup()
-{
-	ip link del veth1 2> /dev/null
-	ip link del veth2 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-}
-
-test_xdp_redirect()
-{
-	local xdpmode=$1
-
-	setup
-
-	ip link set dev veth1 $xdpmode off &> /dev/null
-	if [ $? -ne 0 ];then
-		echo "selftests: test_xdp_redirect $xdpmode [SKIP]"
-		return 0
-	fi
-
-	ip -n ${NS1} link set veth11 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
-	ip -n ${NS2} link set veth22 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
-	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_222 &> /dev/null
-	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_111 &> /dev/null
-
-	if ip netns exec ${NS1} ping -c 1 10.1.1.22 &> /dev/null &&
-	   ip netns exec ${NS2} ping -c 1 10.1.1.11 &> /dev/null; then
-		echo "selftests: test_xdp_redirect $xdpmode [PASS]";
-	else
-		ret=1
-		echo "selftests: test_xdp_redirect $xdpmode [FAILED]";
-	fi
-
-	cleanup
-}
-
-set -e
-trap cleanup 2 3 6 9
-
-test_xdp_redirect xdpgeneric
-test_xdp_redirect xdpdrv
-
-exit $ret

-- 
2.47.1


