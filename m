Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A166A4BB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjB0Txm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjB0Txh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:53:37 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B11FC5;
        Mon, 27 Feb 2023 11:53:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A9B8A3200951;
        Mon, 27 Feb 2023 14:52:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 14:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1677527557; x=1677613957; bh=kC
        /vImF3ygzXdPRqMN8FHSC+Z1VznBI2VSoBhnnxh40=; b=L43SeDFAr4a88CJ7B5
        /ddQTXKm4Cff/D9fv3+iMRdt9jZFoOfSdd4tvyK+a1kWMEKFrKU61m+ZHfVRUDOz
        M11ZX2hMFMsczWcnicRzP0FEU/QYBfK9vaRO6zWfwFarMHCSThhfrrvswmU0C2oA
        zpafWdxsEoCkUH4Bx8LaqC+QVeLZt/+Gl590n+DwuK7cFbmo6S0lFyBR7Ct85zof
        22oFrOvW1KlSJAtcvOb2hOSEjxI+w5HImk99I9VzpeGi7pY3pvuFP4JAaG8uWbU9
        SKpiTtwW0k68/mZl/2emvfXYN/sEwBfd4DlaVuwdwDAsEmW7l/bwoZaHR4v44X17
        VV/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677527557; x=1677613957; bh=kC/vImF3ygzXd
        PRqMN8FHSC+Z1VznBI2VSoBhnnxh40=; b=QlmpONWXMW+HHz5T//TDxSgjrNZx5
        E9u/RJSJElddQWU86Tpmx96fFDNUbCTGLiN39rtlhkqPr80JP6Nf+EJWDLsZ3P+k
        Jy4JYCehVt6MAwZC1IRgu64431znkHgOXBbvPFXdNbfa0pXsqT/CaDZajT0eNcuZ
        GO5j7RLHw8RmApXhKKPbFZx3Xo81TIyW7veFtr29mIOJRERi5ESgrHrh4rm0ZYJ9
        N2yIbImuvKhtKULxx68rEy8timGvXzB9TXPYCopT7eN7DxALbdnHEhrRPsQndlIL
        Viaboelp4PMeAZaQRp8id4Tx8dgvmh1BNdipbAkyH0A4a6h7NJUZtrp4Q==
X-ME-Sender: <xms:BAr9Y0g6FgD_l24VE4bp2wiOfy4PAs_V4hdeXtdgWAEnRogihj-naA>
    <xme:BAr9Y9CcKXTN0YGcdV5U88WXzcFR_yfxT1S6ybrItrPW6senSd5Ia2-X_l-mFyWXa
    2iZGN7y7rNqfBReOg>
X-ME-Received: <xmr:BAr9Y8H8ur8IUIpy_OxovKTE7IaaDL_3O4CmDAlqhstTClhZs-bOWAFoBVkPALEHsoz-UlKyUj_p4-0SGfc-UpOXf3w3ElCQe4JMQEkMlAwSQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:BAr9Y1RwgkblMM50DgKjvZv2b8UP0wMCpTcP5_LejAlLelqijxDyGQ>
    <xmx:BAr9YxwQKdgmrf34bp2rEsRx9Ac3PoYk6KhYYRhO3eARya3gbkKp1w>
    <xmx:BAr9Yz6gq5A8OQz2kf3E8NNjA5KpHRkVk1YlXm2T4Y1pxJN-Vl02kg>
    <xmx:BQr9Y2Lx8lqrK5g635lJta-38MaAjsgufH-kM17_qyj-LJLXHgCIyg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 14:52:35 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        ast@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 8/8] bpf: selftests: Add defrag selftests
Date:   Mon, 27 Feb 2023 12:51:10 -0700
Message-Id: <99ddd1e2b35f6133c1f49a0245340e1a8aaaf32f.1677526810.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677526810.git.dxu@dxuuu.xyz>
References: <cover.1677526810.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These selftests tests 2 major scenarios: the BPF based defragmentation
can successfully be done and that packet pointers are invalidated after
calls to the kfunc. The logic is similar for both ipv4 and ipv6.

In the first scenario, we create a UDP client and UDP echo server. The
the server side is fairly straightforward: we attach the prog and simply
echo back the message.

The on the client side, we send fragmented packets to and expect the
reassembled message back from the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/generate_udp_fragments.py   |  90 +++++
 .../selftests/bpf/ip_check_defrag_frags.h     |  57 +++
 .../bpf/prog_tests/ip_check_defrag.c          | 327 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/ip_check_defrag.c     | 133 +++++++
 6 files changed, 610 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77a..979af1611139 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -558,7 +558,8 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c xsk.c
+			 cap_helpers.c test_loader.c xsk.c 		\
+			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/generate_udp_fragments.py b/tools/testing/selftests/bpf/generate_udp_fragments.py
new file mode 100755
index 000000000000..2b8a1187991c
--- /dev/null
+++ b/tools/testing/selftests/bpf/generate_udp_fragments.py
@@ -0,0 +1,90 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+This script helps generate fragmented UDP packets.
+
+While it is technically possible to dynamically generate
+fragmented packets in C, it is much harder to read and write
+said code. `scapy` is relatively industry standard and really
+easy to read / write.
+
+So we choose to write this script that generates a valid C
+header. Rerun script and commit generated file after any
+modifications.
+"""
+
+import argparse
+import os
+
+from scapy.all import *
+
+
+# These constants must stay in sync with `ip_check_defrag.c`
+VETH1_ADDR = "172.16.1.200"
+VETH0_ADDR6 = "fc00::100"
+VETH1_ADDR6 = "fc00::200"
+CLIENT_PORT = 48878
+SERVER_PORT = 48879
+MAGIC_MESSAGE = "THIS IS THE ORIGINAL MESSAGE, PLEASE REASSEMBLE ME"
+
+
+def print_header(f):
+    f.write("// SPDX-License-Identifier: GPL-2.0\n")
+    f.write("/* DO NOT EDIT -- this file is generated */\n")
+    f.write("\n")
+    f.write("#ifndef _IP_CHECK_DEFRAG_FRAGS_H\n")
+    f.write("#define _IP_CHECK_DEFRAG_FRAGS_H\n")
+    f.write("\n")
+    f.write("#include <stdint.h>\n")
+    f.write("\n")
+
+
+def print_frags(f, frags, v6):
+    for idx, frag in enumerate(frags):
+        # 10 bytes per line to keep width in check
+        chunks = [frag[i : i + 10] for i in range(0, len(frag), 10)]
+        chunks_fmted = [", ".join([str(hex(b)) for b in chunk]) for chunk in chunks]
+        suffix = "6" if v6 else ""
+
+        f.write(f"static uint8_t frag{suffix}_{idx}[] = {{\n")
+        for chunk in chunks_fmted:
+            f.write(f"\t{chunk},\n")
+        f.write(f"}};\n")
+
+
+def print_trailer(f):
+    f.write("\n")
+    f.write("#endif /* _IP_CHECK_DEFRAG_FRAGS_H */\n")
+
+
+def main(f):
+    # srcip of 0 is filled in by IP_HDRINCL
+    sip = "0.0.0.0"
+    sip6 = VETH0_ADDR6
+    dip = VETH1_ADDR
+    dip6 = VETH1_ADDR6
+    sport = CLIENT_PORT
+    dport = SERVER_PORT
+    payload = MAGIC_MESSAGE.encode()
+
+    # Disable UDPv4 checksums to keep code simpler
+    pkt = IP(src=sip,dst=dip) / UDP(sport=sport,dport=dport,chksum=0) / Raw(load=payload)
+    # UDPv6 requires a checksum
+    # Also pin the ipv6 fragment header ID, otherwise it's a random value
+    pkt6 = IPv6(src=sip6,dst=dip6) / IPv6ExtHdrFragment(id=0xBEEF) / UDP(sport=sport,dport=dport) / Raw(load=payload)
+
+    frags = [f.build() for f in pkt.fragment(24)]
+    frags6 = [f.build() for f in fragment6(pkt6, 72)]
+
+    print_header(f)
+    print_frags(f, frags, False)
+    print_frags(f, frags6, True)
+    print_trailer(f)
+
+
+if __name__ == "__main__":
+    dir = os.path.dirname(os.path.realpath(__file__))
+    header = f"{dir}/ip_check_defrag_frags.h"
+    with open(header, "w") as f:
+        main(f)
diff --git a/tools/testing/selftests/bpf/ip_check_defrag_frags.h b/tools/testing/selftests/bpf/ip_check_defrag_frags.h
new file mode 100644
index 000000000000..70ab7e9fa22b
--- /dev/null
+++ b/tools/testing/selftests/bpf/ip_check_defrag_frags.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* DO NOT EDIT -- this file is generated */
+
+#ifndef _IP_CHECK_DEFRAG_FRAGS_H
+#define _IP_CHECK_DEFRAG_FRAGS_H
+
+#include <stdint.h>
+
+static uint8_t frag_0[] = {
+	0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x0, 0x40, 0x11,
+	0xac, 0xe8, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0xbe, 0xee, 0xbe, 0xef, 0x0, 0x3a, 0x0, 0x0, 0x54, 0x48,
+	0x49, 0x53, 0x20, 0x49, 0x53, 0x20, 0x54, 0x48, 0x45, 0x20,
+	0x4f, 0x52, 0x49, 0x47,
+};
+static uint8_t frag_1[] = {
+	0x45, 0x0, 0x0, 0x2c, 0x0, 0x1, 0x20, 0x3, 0x40, 0x11,
+	0xac, 0xe5, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0x49, 0x4e, 0x41, 0x4c, 0x20, 0x4d, 0x45, 0x53, 0x53, 0x41,
+	0x47, 0x45, 0x2c, 0x20, 0x50, 0x4c, 0x45, 0x41, 0x53, 0x45,
+	0x20, 0x52, 0x45, 0x41,
+};
+static uint8_t frag_2[] = {
+	0x45, 0x0, 0x0, 0x1e, 0x0, 0x1, 0x0, 0x6, 0x40, 0x11,
+	0xcc, 0xf0, 0x0, 0x0, 0x0, 0x0, 0xac, 0x10, 0x1, 0xc8,
+	0x53, 0x53, 0x45, 0x4d, 0x42, 0x4c, 0x45, 0x20, 0x4d, 0x45,
+};
+static uint8_t frag6_0[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x20, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x1, 0x0, 0x0, 0xbe, 0xef, 0xbe, 0xee,
+	0xbe, 0xef, 0x0, 0x3a, 0xd0, 0xf8, 0x54, 0x48, 0x49, 0x53,
+	0x20, 0x49, 0x53, 0x20, 0x54, 0x48, 0x45, 0x20, 0x4f, 0x52,
+	0x49, 0x47,
+};
+static uint8_t frag6_1[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x20, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x19, 0x0, 0x0, 0xbe, 0xef, 0x49, 0x4e,
+	0x41, 0x4c, 0x20, 0x4d, 0x45, 0x53, 0x53, 0x41, 0x47, 0x45,
+	0x2c, 0x20, 0x50, 0x4c, 0x45, 0x41, 0x53, 0x45, 0x20, 0x52,
+	0x45, 0x41,
+};
+static uint8_t frag6_2[] = {
+	0x60, 0x0, 0x0, 0x0, 0x0, 0x12, 0x2c, 0x40, 0xfc, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x1, 0x0, 0xfc, 0x0, 0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0,
+	0x11, 0x0, 0x0, 0x30, 0x0, 0x0, 0xbe, 0xef, 0x53, 0x53,
+	0x45, 0x4d, 0x42, 0x4c, 0x45, 0x20, 0x4d, 0x45,
+};
+
+#endif /* _IP_CHECK_DEFRAG_FRAGS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
new file mode 100644
index 000000000000..c79c4096aab4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <net/if.h>
+#include <network_helpers.h>
+#include "ip_check_defrag.skel.h"
+#include "ip_check_defrag_frags.h"
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
+#define VETH0_ADDR6	"fc00::100"
+/* The following constants must stay in sync with `generate_udp_fragments.py` */
+#define VETH1_ADDR	"172.16.1.200"
+#define VETH1_ADDR6	"fc00::200"
+#define CLIENT_PORT	48878
+#define SERVER_PORT	48879
+#define MAGIC_MESSAGE	"THIS IS THE ORIGINAL MESSAGE, PLEASE REASSEMBLE ME"
+
+static char log_buf[1024 * 1024];
+
+static int setup_topology(bool ipv6)
+{
+	bool veth0_up;
+	bool veth1_up;
+	int i;
+
+	SYS(fail, "ip netns add " NS0);
+	SYS(fail, "ip netns add " NS1);
+	SYS(fail, "ip link add " VETH0 " netns " NS0 " type veth peer name " VETH1 " netns " NS1);
+	if (ipv6) {
+		SYS(fail, "ip -6 -net " NS0 " addr add " VETH0_ADDR6 "/64 dev " VETH0 " nodad");
+		SYS(fail, "ip -6 -net " NS1 " addr add " VETH1_ADDR6 "/64 dev " VETH1 " nodad");
+	} else {
+		SYS(fail, "ip -net " NS0 " addr add " VETH0_ADDR "/24 dev " VETH0);
+		SYS(fail, "ip -net " NS1 " addr add " VETH1_ADDR "/24 dev " VETH1);
+	}
+	SYS(fail, "ip -net " NS0 " link set dev " VETH0 " up");
+	SYS(fail, "ip -net " NS1 " link set dev " VETH1 " up");
+
+	/* Wait for up to 5s for links to come up */
+	for (i = 0; i < 50; ++i) {
+		veth0_up = !system("ip -net " NS0 " link show " VETH0 " | grep 'state UP'");
+		veth1_up = !system("ip -net " NS1 " link show " VETH1 " | grep 'state UP'");
+		if (veth0_up && veth1_up)
+			break;
+		usleep(100000);
+	}
+
+	if (!ASSERT_TRUE((veth0_up && veth1_up), "ifaces up"))
+		goto fail;
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
+	saddr_p = (struct sockaddr *)&saddr;
+	err = make_sockaddr(AF_INET, VETH1_ADDR, SERVER_PORT, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client, frag_0, sizeof(frag_0), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_0"))
+		return -1;
+
+	err = sendto(client, frag_1, sizeof(frag_1), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_1"))
+		return -1;
+
+	err = sendto(client, frag_2, sizeof(frag_2), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag_2"))
+		return -1;
+
+	return 0;
+}
+
+static int send_frags6(int client)
+{
+	struct sockaddr_storage saddr;
+	struct sockaddr *saddr_p;
+	socklen_t saddr_len;
+	int err;
+
+	saddr_p = (struct sockaddr *)&saddr;
+	/* Port needs to be set to 0 for raw ipv6 socket for some reason */
+	err = make_sockaddr(AF_INET6, VETH1_ADDR6, 0, &saddr, &saddr_len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		return -1;
+
+	err = sendto(client, frag6_0, sizeof(frag6_0), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_0"))
+		return -1;
+
+	err = sendto(client, frag6_1, sizeof(frag6_1), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_1"))
+		return -1;
+
+	err = sendto(client, frag6_2, sizeof(frag6_2), 0, saddr_p, saddr_len);
+	if (!ASSERT_GE(err, 0, "sendto frag6_2"))
+		return -1;
+
+	return 0;
+}
+
+void test_bpf_ip_check_defrag_ok(bool ipv6)
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
+	struct sockaddr_storage caddr;
+	struct ip_check_defrag *skel;
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
+	if (!ASSERT_OK(setup_topology(ipv6), "setup_topology"))
+		goto out;
+
+	if (!ASSERT_OK(attach(skel), "attach"))
+		goto out;
+
+	/* Start server in ns1 */
+	nstoken = open_netns(NS1);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns1"))
+		goto out;
+	srv_fd = start_server(ipv6 ? AF_INET6 : AF_INET, SOCK_DGRAM, NULL, SERVER_PORT, 0);
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
+	nstoken = open_netns(NS0);
+	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
+		goto out;
+	if (ipv6) {
+		struct sockaddr_in6 *c = (struct sockaddr_in6 *)&caddr;
+
+		c->sin6_family = AF_INET6;
+		inet_pton(AF_INET6, VETH0_ADDR6, &c->sin6_addr);
+		c->sin6_port = htons(CLIENT_PORT);
+		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
+	} else {
+		struct sockaddr_in *c = (struct sockaddr_in *)&caddr;
+
+		c->sin_family = AF_INET;
+		inet_pton(AF_INET, VETH0_ADDR, &c->sin_addr);
+		c->sin_port = htons(CLIENT_PORT);
+		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
+	}
+	close_netns(nstoken);
+	if (!ASSERT_OK(err, "bind"))
+		goto out;
+
+	/* Send message in fragments */
+	if (ipv6) {
+		if (!ASSERT_OK(send_frags6(client_tx_fd), "send_frags6"))
+			goto out;
+	} else {
+		if (!ASSERT_OK(send_frags(client_tx_fd), "send_frags"))
+			goto out;
+	}
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
+	if (test__start_subtest("ok-v4"))
+		test_bpf_ip_check_defrag_ok(false);
+	if (test__start_subtest("ok-v6"))
+		test_bpf_ip_check_defrag_ok(true);
+	if (test__start_subtest("fail"))
+		test_bpf_ip_check_defrag_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index cfed4df490f3..fde688b8af16 100644
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
index 000000000000..5978fd2dd479
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+
+#define BPF_F_CURRENT_NETNS	(-1)
+#define ETH_P_IP		0x0800
+#define ETH_P_IPV6		0x86DD
+#define IP_DF			0x4000
+#define IP_MF			0x2000
+#define IP_OFFSET		0x1FFF
+#define NEXTHDR_FRAGMENT	44
+#define ctx_ptr(field)		(void *)(long)(field)
+
+int bpf_ip_check_defrag(struct __sk_buff *ctx, u64 netns) __ksym;
+int bpf_ipv6_frag_rcv(struct __sk_buff *ctx, u64 netns) __ksym;
+
+volatile int frags_seen = 0;
+volatile bool is_final_frag = true;
+
+static bool is_frag_v4(struct iphdr *iph)
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
+static bool is_frag_v6(struct ipv6hdr *ip6h)
+{
+	/* Simplifying assumption that there are no extension headers
+	 * between fixed header and fragmentation header. This assumption
+	 * is only valid in this test case. It saves us the hassle of
+	 * searching all potential extension headers.
+	 */
+	return ip6h->nexthdr == NEXTHDR_FRAGMENT;
+}
+
+static int defrag_v4(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct iphdr *iph;
+
+	iph = data + sizeof(struct ethhdr);
+	if (iph + 1 > data_end)
+		return TC_ACT_SHOT;
+
+	if (!is_frag_v4(iph))
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
+	is_final_frag = is_frag_v4(iph);
+
+	return TC_ACT_OK;
+}
+
+static int defrag_v6(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ipv6hdr *ip6h;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if (ip6h + 1 > data_end)
+		return TC_ACT_SHOT;
+
+	if (!is_frag_v6(ip6h))
+		return TC_ACT_OK;
+
+	frags_seen++;
+	if (bpf_ipv6_frag_rcv(skb, BPF_F_CURRENT_NETNS))
+		return TC_ACT_SHOT;
+
+	data_end = ctx_ptr(skb->data_end);
+	data = ctx_ptr(skb->data);
+	ip6h = data + sizeof(struct ethhdr);
+	if (ip6h + 1 > data_end)
+		return TC_ACT_SHOT;
+	is_final_frag = is_frag_v6(ip6h);
+
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int defrag(struct __sk_buff *skb)
+{
+	switch (bpf_ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		return defrag_v4(skb);
+	case ETH_P_IPV6:
+		return defrag_v6(skb);
+	default:
+		return TC_ACT_OK;
+	}
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
2.39.1

