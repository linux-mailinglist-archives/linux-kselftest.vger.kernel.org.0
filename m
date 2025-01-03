Return-Path: <linux-kselftest+bounces-23854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB325A00778
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD06163E3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BB1F9F49;
	Fri,  3 Jan 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LQ0A/nqv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52661F943F;
	Fri,  3 Jan 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899024; cv=none; b=Xbz9I0npymywVXFZQPdNNKoNJiAzLy06QGRroO71r6u9rbfUBrtD3uBgeP6I2TD8agoT3wrWPVp8HirCreLYbioW7s+yVBwfdRj/n12cl3OI9nR+5iz9gFRk+cXlkzvrSglOjVmQJaij3MgtYhr02Cfn2GpqPoUpbCZYD9YFldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899024; c=relaxed/simple;
	bh=CJe2t/7o1G7i+S+gsuJ2iD3w8FhGydZ48bdNdgOE+8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQVCWnqOmEADw4MACLa2lw4jVoYwzSoxM3jhhspTDtW9QD1oAJnOBPf8YNqwGeLA7sPrD9Se/TRvzQw2hBZ7dZVdOwBNB0ETqJOENGy+2r9287xWcRO5emWL14GbKIJP0cVoGqKjuUbIPCPVgJbnnVYVmjWv3s/nigdZLy5fRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LQ0A/nqv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DEDF40002;
	Fri,  3 Jan 2025 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735899014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH5gRiAYurltjt9E9EyfwQ+W2ICDQnjVf5eBzZvYrPY=;
	b=LQ0A/nqvMmgdikU7MjrvO7AvaaMj4T+/vt8OY763iwvgKDZmNDYjjRezpDcgLkpuUGW3n6
	xcddcH4hrDf0G9UK5RJMQi9jix7zvejxRk7pWma3s1SYkVk2kLobDiSMCqj47z4+GKCeB9
	bpsUJb6MxNpt3iXb1BZ8OoKNgGCxsWnowsk2WF3fUsyM77BTTSXTVo+ck7coGttkxeB2aG
	G1P9rwOTiiGhze1TAHpDUECE7EDoitdxpNaz13UIex0O1tGckco2HQYDUnuxMv1W4hvyfC
	Uy1efKrqo9iWKgnBTYsxZ++5BtvP77+BYjj2qJEvVUNdoCBlI8GTc/fGoqOm1Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 03 Jan 2025 11:10:10 +0100
Subject: [PATCH 2/3] selftests/bpf: Migrate test_xdp_redirect.sh to
 xdp_do_redirect.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
In-Reply-To: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
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

Migrate test_xdp_redirect.sh into two new test cases in
xdp_do_redirect.c. They use the same network topology and the same BPF
programs located in progs/test_xdp_redirect.c and progs/xdp_dummy.c.
Remove test_xdp_redirect.sh and its Makefile entry.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     | 193 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |  79 ---------
 3 files changed, 193 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9e870e519c30e4a241ce05491743e1784af2bd8b..3cf571ccbde6e13535c1d199759221804710b9ff 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -127,7 +127,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_xdp_redirect.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
 	test_tunnel.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index d12f926b4b8b1fcbc2a88ef7e3bd20ef2cbbd72c..47b0ea84ae57b2c6ba3388ba865bfdf4bbe2146c 100644
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
@@ -246,3 +248,194 @@ void test_xdp_do_redirect(void)
 	SYS_NOFAIL("ip netns del testns");
 	test_xdp_do_redirect__destroy(skel);
 }
+
+#define NS_NB		3
+#define NS0		"NS0"
+#define NS1		"NS1"
+#define NS2		"NS2"
+#define IPV4_NETWORK	"10.1.1"
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
+	struct nstoken *nstoken = NULL;
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
+		nstoken = open_netns(NS0);
+		if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+			goto fail;
+
+		SYS(fail, "ip link add veth%d index %d%d%d type veth peer name veth0 netns %s",
+		    i, i, i, i, ns_name);
+		SYS(fail, "ip link set veth%d up", i);
+		close_netns(nstoken);
+
+		nstoken = open_netns(ns_name);
+		if (!ASSERT_OK_PTR(nstoken, "open ns"))
+			goto fail;
+
+		SYS(fail, "ip addr add %s.%d/24 dev veth0", IPV4_NETWORK, i);
+		SYS(fail, "ip link set veth0 up");
+		close_netns(nstoken);
+	}
+
+	return 0;
+
+fail:
+	close_netns(nstoken);
+	cleanup(data);
+	return -1;
+}
+
+static void ping_test(struct test_data *data)
+{
+	struct bpf_program *prog_to_111, *prog_to_222, *dummy_prog;
+	struct test_xdp_redirect *skel = NULL;
+	struct xdp_dummy *skel_dummy = NULL;
+	struct nstoken *nstoken = NULL;
+	int i, ret;
+
+	skel_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skel_dummy, "open and load xdp_dummy skeleton"))
+		goto close;
+
+	dummy_prog = bpf_object__find_program_by_name(skel_dummy->obj, "xdp_dummy_prog");
+	if (!ASSERT_OK_PTR(dummy_prog, "get dummy_prog"))
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
+				     bpf_program__fd(dummy_prog),
+				     data->xdp_flags, NULL);
+		if (!ASSERT_GE(ret, 0, "bpf_xdp_attach dummy_prog"))
+			goto close;
+
+		close_netns(nstoken);
+	}
+
+	skel = test_xdp_redirect__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto close;
+
+	prog_to_111 = bpf_object__find_program_by_name(skel->obj, "xdp_redirect_to_111");
+	if (!ASSERT_OK_PTR(prog_to_111, "get redirect_to_111 prog"))
+		goto close;
+
+	prog_to_222 = bpf_object__find_program_by_name(skel->obj, "xdp_redirect_to_222");
+	if (!ASSERT_OK_PTR(prog_to_222, "get redirect_to_222 prog"))
+		goto close;
+
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto close;
+
+	ret = bpf_xdp_attach(if_nametoindex("veth2"),
+			     bpf_program__fd(prog_to_111),
+			     data->xdp_flags, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	ret = bpf_xdp_attach(if_nametoindex("veth1"),
+			     bpf_program__fd(prog_to_222),
+			     data->xdp_flags, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
+		goto close;
+
+	SYS(close, "ping -c 1 %s.2", IPV4_NETWORK);
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(NS2);
+	if (!ASSERT_OK_PTR(nstoken, "open NS2"))
+		goto close;
+
+	SYS(close, "ping -c 1 %s.1", IPV4_NETWORK);
+
+close:
+	close_netns(nstoken);
+	xdp_dummy__destroy(skel_dummy);
+	test_xdp_redirect__destroy(skel);
+}
+
+
+void test_xdp_generic_redirect_ping(void)
+{
+	struct test_data data = {};
+
+	if (ping_setup(&data) < 0)
+		return;
+
+	data.xdp_flags = XDP_FLAGS_SKB_MODE;
+	ping_test(&data);
+	cleanup(&data);
+}
+
+void test_xdp_drv_redirect_ping(void)
+{
+	struct test_data data = {};
+
+	if (ping_setup(&data) < 0)
+		return;
+
+	data.xdp_flags = XDP_FLAGS_DRV_MODE;
+	ping_test(&data);
+	cleanup(&data);
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


