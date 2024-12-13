Return-Path: <linux-kselftest+bounces-23326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017A9F1071
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A455F1887782
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E81E3DD6;
	Fri, 13 Dec 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="maGnTXiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3A1E2615;
	Fri, 13 Dec 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102459; cv=none; b=BsGTa8jSRohuwiIaW0gFFWcKwSynCaugmylU5X27Y+PKgmxhM/YzzD2L3SW7dgIpGz0Jh//T+w/Wb0/W6Jk/Uuli4K34b3IuT8MtfMuIjcQCSCMN8BrYOa4uTpb77mfaJ7yy/25d3oHjdauVWFahNfYIn9/njj5qnQTncT2qCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102459; c=relaxed/simple;
	bh=tEROG9FEgMhkIhh56A/1tu60cYnTmBUd9wjxxJBUkuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFXKjRyC/1gaowiaXicQBjwKFtgxK0vSUXI/vxiv6t4sLGU6+Jmm8ctAL6cfO7Ue+0B3YljxrX6gfEeoqzgUAa/S8jvon/bHRqceA6FcY5LHFLpa7aAw2BQASxQbcawoOBHSixwJDKKlUPurHF9OIcUudIJ/HqAAjmUMttDdxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=maGnTXiV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CDCC4000C;
	Fri, 13 Dec 2024 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734102449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnoQr8lmgsHJbaWxdhWZAL7GhSFUjuASASW2xaiay1o=;
	b=maGnTXiVs3L/ta7pGdBqc2aDc8VechLFZL17uXztZZEdHwAxoPtyOieUNe17QJNfq5gYKQ
	JIlAIK5MG43E2BQ7RMDn+466iN0vYyKLzomBvtZ8MpSPFpqPGoec8wN/ssR+S8+x/3eLcW
	Lqgq8vceefJJvILe2cy8jm6U+Xwhem87BU+1GyrWcLpOhPXf55maW5yAdTPv8txMfnT8RC
	gpQ7yMLVBMhmq7VKzD0DFJVg+E0r5Ihe1RZ0mRlS0ycsDEqlGWo93VNEKidn8QiTZm8y7K
	xiqttDsaLPkki7lCseZKqzcQ+UOM5Jehblx6lO2pjGAKwzAAixT/1vPFJOP+Fw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 13 Dec 2024 16:06:21 +0100
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Migrate test_xdp_meta.sh
 into xdp_context_test_run.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-xdp_meta-v2-2-634582725b90@bootlin.com>
References: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
In-Reply-To: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
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
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

test_xdp_meta.sh can't be used by the BPF CI.

Migrate test_xdp_meta.sh in a new test case in xdp_context_test_run.c.
It uses the same BPF programs located in progs/test_xdp_meta.c and the
same network topology.
Remove test_xdp_meta.sh and its Makefile entry.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |  1 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 87 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_meta.sh       | 58 ---------------
 3 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9e870e519c30e4a241ce05491743e1784af2bd8b..947ac47f2f6b2c59c6d7555c68c3f2c057b1c061 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -129,7 +129,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
 	test_xdp_redirect_multi.sh \
-	test_xdp_meta.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index e6a783c7f5db9c818bd354027bae7393ee3c166b..7c4156af0c299bcaf07843b880a10b4aa7737110 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -2,6 +2,14 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "test_xdp_context_test_run.skel.h"
+#include "test_xdp_meta.skel.h"
+
+#define TX_ADDR "10.0.0.1"
+#define RX_ADDR "10.0.0.2"
+#define RX_NAME "veth0"
+#define TX_NAME "veth1"
+#define TX_NETNS "xdp_context_tx"
+#define RX_NETNS "xdp_context_rx"
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
 			    __u32 data_meta, __u32 data, __u32 data_end,
@@ -103,3 +111,82 @@ void test_xdp_context_test_run(void)
 
 	test_xdp_context_test_run__destroy(skel);
 }
+
+void test_xdp_context_functional(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
+	struct bpf_program *tc_prog, *xdp_prog;
+	struct test_xdp_meta *skel = NULL;
+	struct nstoken *nstoken = NULL;
+	int rx_ifindex;
+	int ret;
+
+	tx_ns = netns_new(TX_NETNS, false);
+	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
+		return;
+
+	rx_ns = netns_new(RX_NETNS, false);
+	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
+		goto close;
+
+	SYS(close, "ip link add " RX_NAME " netns " RX_NETNS
+	    " type veth peer name " TX_NAME " netns " TX_NETNS);
+
+	nstoken = open_netns(RX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
+		goto close;
+
+	SYS(close, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
+	SYS(close, "ip link set dev " RX_NAME " up");
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto close;
+
+	rx_ifindex = if_nametoindex(RX_NAME);
+	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
+		goto close;
+
+	tc_hook.ifindex = rx_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
+	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	xdp_prog = bpf_object__find_program_by_name(skel->obj, "ing_xdp");
+	if (!ASSERT_OK_PTR(xdp_prog, "open ing_xdp prog"))
+		goto close;
+
+	ret = bpf_xdp_attach(rx_ifindex,
+			     bpf_program__fd(xdp_prog),
+			     0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(TX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
+		goto close;
+
+	SYS(close, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
+	SYS(close, "ip link set dev " TX_NAME " up");
+	SYS(close, "ping -c 1 " RX_ADDR);
+
+close:
+	close_netns(nstoken);
+	test_xdp_meta__destroy(skel);
+	netns_free(rx_ns);
+	netns_free(tx_ns);
+}
+
diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh b/tools/testing/selftests/bpf/test_xdp_meta.sh
deleted file mode 100755
index 6039b92f10949d48cd9d703d6981ae8a9388e8df..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_meta.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/bin/sh
-
-BPF_FILE="test_xdp_meta.bpf.o"
-# Kselftest framework requirement - SKIP code is 4.
-readonly KSFT_SKIP=4
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-
-cleanup()
-{
-	if [ "$?" = "0" ]; then
-		echo "selftests: test_xdp_meta [PASS]";
-	else
-		echo "selftests: test_xdp_meta [FAILED]";
-	fi
-
-	set +e
-	ip link del veth1 2> /dev/null
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-}
-
-ip link set dev lo xdp off 2>/dev/null > /dev/null
-if [ $? -ne 0 ];then
-	echo "selftests: [SKIP] Could not run test without the ip xdp support"
-	exit $KSFT_SKIP
-fi
-set -e
-
-ip netns add ${NS1}
-ip netns add ${NS2}
-
-trap cleanup 0 2 3 6 9
-
-ip link add veth1 type veth peer name veth2
-
-ip link set veth1 netns ${NS1}
-ip link set veth2 netns ${NS2}
-
-ip netns exec ${NS1} ip addr add 10.1.1.11/24 dev veth1
-ip netns exec ${NS2} ip addr add 10.1.1.22/24 dev veth2
-
-ip netns exec ${NS1} tc qdisc add dev veth1 clsact
-ip netns exec ${NS2} tc qdisc add dev veth2 clsact
-
-ip netns exec ${NS1} tc filter add dev veth1 ingress bpf da obj ${BPF_FILE} sec tc
-ip netns exec ${NS2} tc filter add dev veth2 ingress bpf da obj ${BPF_FILE} sec tc
-
-ip netns exec ${NS1} ip link set dev veth1 xdp obj ${BPF_FILE} sec xdp
-ip netns exec ${NS2} ip link set dev veth2 xdp obj ${BPF_FILE} sec xdp
-
-ip netns exec ${NS1} ip link set dev veth1 up
-ip netns exec ${NS2} ip link set dev veth2 up
-
-ip netns exec ${NS1} ping -c 1 10.1.1.22
-ip netns exec ${NS2} ping -c 1 10.1.1.11
-
-exit 0

-- 
2.47.0


