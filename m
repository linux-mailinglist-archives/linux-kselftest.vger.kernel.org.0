Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2464D36B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLNX2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 18:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLNX2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 18:28:08 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584549B74;
        Wed, 14 Dec 2022 15:26:25 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BFF78320016F;
        Wed, 14 Dec 2022 18:26:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Dec 2022 18:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1671060383; x=1671146783; bh=yv
        6JU9opx4TWQWD6Z2v6I1MGb71Y/3jWyXaKtRmlwEo=; b=M0VBR5o1pLChjaM1Hc
        uNKPb715Ijyi8Vpgn//F9Ik0StG0AdRAbqdwKD4YPyowrWjdF56/j1v/YthP9iN6
        ltQ66f+R/axHlobmUQHGDFJQ7i9+v0+Jub76K1iu/rXBy94uS21NXJqzcoyeufIE
        ZJfbOB2IjS7TdOU+n37Ql6ppExfMbYs+41LzwpB/IMcsuvACsClkChWWtIjOg+Vq
        bqyPmt8F7TuGjSAp5w8veiHOjEPGSX2gTsB4pzVyz/r15r2yEb8U2bO7tEt0JaFL
        xfk9AuUwAP+f/y2mZjea/Dmt09Gy4c0S6DLxMvgmfKbNBRfwZXVLzZjpy6lSgY4G
        BPXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671060383; x=1671146783; bh=yv6JU9opx4TWQ
        WD6Z2v6I1MGb71Y/3jWyXaKtRmlwEo=; b=b0r25TMe7o48HtDF3KThnGZz55t6t
        qai0wTQii5zNAlKW8M1PJiM2HxYbLUmKpF7hIM7nx3/jCiwIb/bHIUz0Nl8YUVib
        LNjTPS7knRijpGsesFQgydkcmFVaOk2WhAgrDIG5fcSPng41k2FrAAQzPN7bnux7
        BVqCwWNcpCoKeXpW6w093pJ9SMV6PAIV998sgJ4lDwTd2GxdbkycOJAtOm2g5m52
        dNBuaVMU/DUjPxYtX+AqPxr8EZuHnjW4yPDUocdcwax265YvAjANK+JcwhAY/LG8
        WldW38lL88iQoja+HK+fU0PHqgLPhwde34H/LWLVom0+l+fjV/cp6EvsQ==
X-ME-Sender: <xms:n1uaY0V3-kxb3RD1eCXF2QB1YZdW_iuGR8narLPMK0Myf7jeVOT5Mg>
    <xme:n1uaY4niXt_KWWbUEf-MqavlWgkvZLaxXPp5XVafhOMxOENVTsVafgERs4MF0pY9t
    94O5TFU0kLh9qgdNQ>
X-ME-Received: <xmr:n1uaY4bimfYfq9GRsGL8vqqbcRii3HzeNMKnii2-ux3wyqMUWkI4QzPs3HKoftUetMGJfIWR74cgNXlR9SGE2dlvI7nAt3axdvAqWeHrSaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeek
    gfffgefhtddtteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:n1uaYzVDdY3b8WVL1CSFYYvb4YHftDKruhVxMayxwSu4vbDwB8tNWQ>
    <xmx:n1uaY-n_brxJHssecVMKo4o8bpQIyIXxT4VRG9zlp8OaU7pBWNu0OA>
    <xmx:n1uaY4fo4G5pb0ctN0BeZS5F0ChtWwKjUpX5t1-5ivre2DM2wpM1fQ>
    <xmx:n1uaY40mGmKELzAXIpbvAB1oytpgSU5duR7RRA-PPDUT0sAqsxNtUA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:26:21 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     ppenkov@aviatrix.com, dbird@aviatrix.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 6/6] bpf: selftests: Add bpf_ip_check_defrag() selftest
Date:   Wed, 14 Dec 2022 16:25:33 -0700
Message-Id: <48b0ce1f1f11ba7244ec4df7e990d79c634fa52e.1671049840.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671049840.git.dxu@dxuuu.xyz>
References: <cover.1671049840.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This selftest tests 2 major scenarios: the BPF based defragmentation can
succesfully be done and that packet pointers are invalidated after calls
to the kfunc.

In the first scenario, we create a UDP client and UDP echo server. The
the server side is fairly straightforward: we attach the prog and simply
echo back the message.

The on the client side, we send fragmented packets to and expect the
reassembled message back from the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/generate_udp_fragments.py   |  52 +++
 .../bpf/prog_tests/ip_check_defrag.c          | 296 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/ip_check_defrag.c     |  83 +++++
 4 files changed, 432 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

diff --git a/tools/testing/selftests/bpf/generate_udp_fragments.py b/tools/testing/selftests/bpf/generate_udp_fragments.py
new file mode 100755
index 000000000000..b7ee3f7b42b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/generate_udp_fragments.py
@@ -0,0 +1,52 @@
+#!/bin/env python3
+
+"""
+This script helps generate fragmented UDP packets.
+
+While it is technically possible to dynamically generate
+fragmented packets in C, it is much harder to read and write
+said code. `scapy` is relatively industry standard and really
+easy to read / write.
+
+So we choose to write this script that generates valid C code.
+"""
+
+import argparse
+from scapy.all import *
+
+def print_frags(frags):
+    for idx, frag in enumerate(frags):
+        # 10 bytes per line to keep width in check
+        chunks = [frag[i: i+10] for i in range(0, len(frag), 10)]
+        chunks_fmted = [", ".join([str(hex(b)) for b in chunk]) for chunk in chunks]
+
+        print(f"static uint8_t frag{idx}[] = {{")
+        for chunk in chunks_fmted:
+            print(f"\t{chunk},")
+        print(f"}};")
+
+
+def main(args):
+    # srcip of 0 is filled in by IP_HDRINCL
+    sip = "0.0.0.0"
+    dip = args.dst_ip
+    sport = args.src_port
+    dport = args.dst_port
+    payload = args.payload.encode()
+
+    # Disable UDP checksums to keep code simpler
+    pkt = IP(src=sip,dst=dip) / UDP(sport=sport,dport=dport,chksum=0) / Raw(load=payload)
+
+    frags = [f.build() for f in pkt.fragment(24)]
+    print_frags(frags)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser()
+    parser.add_argument("dst_ip")
+    parser.add_argument("src_port", type=int)
+    parser.add_argument("dst_port", type=int)
+    parser.add_argument("payload")
+    args = parser.parse_args()
+
+    main(args)
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
new file mode 100644
index 000000000000..ed078e8265de
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <net/if.h>
+#include <network_helpers.h>
+#include "ip_check_defrag.skel.h"
+
+/*
+ * This selftest spins up a client and an echo server, each in their own
+ * network namespace. The server will receive fragmented messages which
+ * the attached BPF prog should reassemble. We verify that reassembly
+ * occurred by checking the original (fragmented) message is received
+ * in whole.
+ *
+ * Topology:
+ * =========
+ *           NS0         |         NS1
+ *                       |
+ *         client        |       server
+ *       ----------      |     ----------
+ *       |  veth0  | --------- |  veth1  |
+ *       ----------    peer    ----------
+ *                       |
+ *                       |       with bpf
+ */
+
+#define NS0		"defrag_ns0"
+#define NS1		"defrag_ns1"
+#define VETH0		"veth0"
+#define VETH1		"veth1"
+#define VETH0_ADDR	"172.16.1.100"
+#define VETH1_ADDR	"172.16.1.200"
+#define CLIENT_PORT	48878
+#define SERVER_PORT	48879
+#define MAGIC_MESSAGE	"THIS IS THE ORIGINAL MESSAGE, PLEASE REASSEMBLE ME"
+
+static char log_buf[1024 * 1024];
+
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+#define SYS_NOFAIL(fmt, ...)					\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		system(cmd);					\
+	})
+
+/*
+ * The following fragments are generated with this script invocation:
+ *
+ *	./generate_udp_fragments $VETH1_ADDR $CLIENT_PORT $SERVER_PORT $MAGIC_MESSAGE
+ *
+ * where the `$` indicates replacement with preprocessor macro.
+ */
+static uint8_t frag0[] = {
+        0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x0, 0x40, 0x11,
+        0xac, 0xe8, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+        0xbe, 0xee, 0xbe, 0xef, 0x0, 0x3a, 0x0, 0x0, 0x54, 0x48,
+        0x49, 0x53, 0x20, 0x49, 0x53, 0x20, 0x54, 0x48, 0x45, 0x20,
+        0x4f, 0x52, 0x49, 0x47,
+};
+static uint8_t frag1[] = {
+        0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x3, 0x40, 0x11,
+        0xac, 0xe5, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+        0x49, 0x4e, 0x41, 0x4c, 0x20, 0x4d, 0x45, 0x53, 0x53, 0x41,
+        0x47, 0x45, 0x2c, 0x20, 0x50, 0x4c, 0x45, 0x41, 0x53, 0x45,
+        0x20, 0x52, 0x45, 0x41,
+};
+static uint8_t frag2[] = {
+        0x45, 0x0, 0x0, 0x1e, 0x0, 0x1, 0x0, 0x6, 0x40, 0x11,
+        0xcc, 0xf0, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+        0x53, 0x53, 0x45, 0x4d, 0x42, 0x4c, 0x45, 0x20, 0x4d, 0x45,
+};
+
+static int setup_topology(void)
+{
+	SYS("ip netns add " NS0);
+	SYS("ip netns add " NS1);
+	SYS("ip link add " VETH0 " netns " NS0 " type veth peer name " VETH1 " netns " NS1);
+	SYS("ip -net " NS0 " addr add " VETH0_ADDR "/24 dev " VETH0);
+	SYS("ip -net " NS0 " link set dev " VETH0 " up");
+	SYS("ip -net " NS1 " addr add " VETH1_ADDR "/24 dev " VETH1);
+	SYS("ip -net " NS1 " link set dev " VETH1 " up");
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void cleanup_topology(void)
+{
+	SYS_NOFAIL("test -f /var/run/netns/" NS0 " && ip netns delete " NS0);
+	SYS_NOFAIL("test -f /var/run/netns/" NS1 " && ip netns delete " NS1);
+}
+
+static int attach(struct ip_check_defrag *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
+		    .prog_fd = bpf_program__fd(skel->progs.defrag));
+	struct nstoken *nstoken;
+	int err = -1;
+
+	nstoken = open_netns(NS1);
+
+	tc_hook.ifindex = if_nametoindex(VETH1);
+	if (!ASSERT_OK(bpf_tc_hook_create(&tc_hook), "bpf_tc_hook_create"))
+		goto out;
+
+	if (!ASSERT_OK(bpf_tc_attach(&tc_hook, &tc_attach), "bpf_tc_attach"))
+		goto out;
+
+	err = 0;
+out:
+	close_netns(nstoken);
+	return err;
+}
+
+static int send_frags(int client)
+{
+	struct sockaddr_storage saddr;
+	struct sockaddr *saddr_p;
+	socklen_t saddr_len;
+	int err;
+
+	saddr_p = (struct sockaddr*)&saddr;
+	err = make_sockaddr(AF_INET, VETH1_ADDR, SERVER_PORT, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client, frag0, sizeof(frag0), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag0"))
+		return -1;
+
+	err = sendto(client, frag1, sizeof(frag1), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag1"))
+		return -1;
+
+	err = sendto(client, frag2, sizeof(frag2), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag2"))
+		return -1;
+
+	return 0;
+}
+
+void test_bpf_ip_check_defrag_ok(void)
+{
+	struct network_helper_opts rx_opts = {
+		.timeout_ms = 1000,
+		.noconnect = true,
+	};
+	struct network_helper_opts tx_ops = {
+		.timeout_ms = 1000,
+		.type = SOCK_RAW,
+		.proto = IPPROTO_RAW,
+		.noconnect = true,
+	};
+	struct ip_check_defrag *skel;
+	struct sockaddr_in caddr;
+	struct nstoken *nstoken;
+	int client_tx_fd = -1;
+	int client_rx_fd = -1;
+	socklen_t caddr_len;
+	int srv_fd = -1;
+	char buf[1024];
+	int len, err;
+
+	skel = ip_check_defrag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK(setup_topology(), "setup_topology"))
+		goto out;
+
+	if (!ASSERT_OK(attach(skel), "attach"))
+		goto out;
+
+	/* Start server in ns1 */
+	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns1"))
+		goto out;
+	srv_fd = start_server(AF_INET, SOCK_DGRAM, NULL, SERVER_PORT, 0);
+	close_netns(nstoken);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		goto out;
+
+	/* Open tx raw socket in ns0 */
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	client_tx_fd = connect_to_fd_opts(srv_fd, &tx_ops);
+	close_netns(nstoken);
+	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
+		goto out;
+
+	/* Open rx socket in ns0 */
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
+	close_netns(nstoken);
+	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
+		goto out;
+
+	/* Bind rx socket to a premeditated port */
+	memset(&caddr, 0, sizeof(caddr));
+	caddr.sin_family = AF_INET;
+	inet_pton(AF_INET, VETH0_ADDR, &caddr.sin_addr);
+	caddr.sin_port = htons(CLIENT_PORT);
+	nstoken = open_netns(NS0);
+	err = bind(client_rx_fd, (struct sockaddr *)&caddr, sizeof(caddr));
+	close_netns(nstoken);
+	if (!ASSERT_OK(err, "bind"))
+		goto out;
+
+	/* Send message in fragments */
+	if (!ASSERT_OK(send_frags(client_tx_fd), "send_frags"))
+		goto out;
+
+	if (!ASSERT_EQ(skel->bss->frags_seen, 3, "frags_seen"))
+		goto out;
+
+	if (!ASSERT_FALSE(skel->data->is_final_frag, "is_final_frag"))
+		goto out;
+
+	/* Receive reassembled msg on server and echo back to client */
+	len = recvfrom(srv_fd, buf, sizeof(buf), 0, (struct sockaddr *)&caddr, &caddr_len);
+	if (!ASSERT_GE(len, 0, "server recvfrom"))
+		goto out;
+	len = sendto(srv_fd, buf, len, 0, (struct sockaddr *)&caddr, caddr_len);
+	if (!ASSERT_GE(len, 0, "server sendto"))
+		goto out;
+
+	/* Expect reassembed message to be echoed back */
+	len = recvfrom(client_rx_fd, buf, sizeof(buf), 0, NULL, NULL);
+	if (!ASSERT_EQ(len, sizeof(MAGIC_MESSAGE) - 1, "client short read"))
+		goto out;
+
+out:
+	if (client_rx_fd != -1)
+		close(client_rx_fd);
+	if (client_tx_fd != -1)
+		close(client_tx_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	cleanup_topology();
+	ip_check_defrag__destroy(skel);
+}
+
+void test_bpf_ip_check_defrag_fail(void)
+{
+	const char *err_msg = "invalid mem access 'scalar'";
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		    .kernel_log_buf = log_buf,
+		    .kernel_log_size = sizeof(log_buf),
+		    .kernel_log_level = 1);
+	struct ip_check_defrag *skel;
+	struct bpf_program *prog;
+	int err;
+
+	skel = ip_check_defrag__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "ip_check_defrag__open_opts"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "defrag_fail");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	bpf_program__set_autoload(prog, true);
+
+	err = ip_check_defrag__load(skel);
+	if (!ASSERT_ERR(err, "ip_check_defrag__load must fail"))
+		goto out;
+
+	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
+		fprintf(stderr, "Expected: %s\n", err_msg);
+		fprintf(stderr, "Verifier: %s\n", log_buf);
+	}
+
+out:
+	ip_check_defrag__destroy(skel);
+}
+
+void test_bpf_ip_check_defrag(void)
+{
+	if (test__start_subtest("ok"))
+		test_bpf_ip_check_defrag_ok();
+	if (test__start_subtest("fail"))
+		test_bpf_ip_check_defrag_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index b394817126cf..a1d6cc1f2ef8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -26,6 +26,7 @@
 #define IPV6_AUTOFLOWLABEL	70
 
 #define TC_ACT_UNSPEC		(-1)
+#define TC_ACT_OK		0
 #define TC_ACT_SHOT		2
 
 #define SOL_TCP			6
diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
new file mode 100644
index 000000000000..71300b77a43f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+
+#define ETH_P_IP		0x0800
+#define IP_DF			0x4000
+#define IP_MF			0x2000
+#define IP_OFFSET		0x1FFF
+#define ctx_ptr(field)		(void *)(long)(field)
+
+int bpf_ip_check_defrag(struct __sk_buff *ctx, u64 netns) __ksym;
+
+volatile int frags_seen = 0;
+volatile bool is_final_frag = true;
+
+static inline bool is_frag(struct iphdr *iph)
+{
+	int offset;
+	int flags;
+
+	offset = bpf_ntohs(iph->frag_off);
+	flags = offset & ~IP_OFFSET;
+	offset &= IP_OFFSET;
+	offset <<= 3;
+
+	return (flags & IP_MF) || offset;
+}
+
+SEC("tc")
+int defrag(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct iphdr *iph;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	iph = data + sizeof(struct ethhdr);
+	if (iph + 1 > data_end)
+		return TC_ACT_SHOT;
+
+	if (!is_frag(iph))
+		return TC_ACT_OK;
+
+	frags_seen++;
+	if (bpf_ip_check_defrag(skb, BPF_F_CURRENT_NETNS))
+		return TC_ACT_SHOT;
+
+	data_end = ctx_ptr(skb->data_end);
+	data = ctx_ptr(skb->data);
+	iph = data + sizeof(struct ethhdr);
+	if (iph + 1 > data_end)
+		return TC_ACT_SHOT;
+	is_final_frag = is_frag(iph);
+
+	return TC_ACT_OK;
+}
+
+SEC("?tc")
+int defrag_fail(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct iphdr *iph;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	iph = data + sizeof(struct ethhdr);
+	if (iph + 1 > data_end)
+		return TC_ACT_SHOT;
+
+	if (bpf_ip_check_defrag(skb, BPF_F_CURRENT_NETNS))
+		return TC_ACT_SHOT;
+
+	/* Boom. Must revalidate pkt ptrs */
+	return iph->ttl ? TC_ACT_OK : TC_ACT_SHOT;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.0

