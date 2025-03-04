Return-Path: <linux-kselftest+bounces-28192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CCA4D7ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67E216DCEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EC1F8AC0;
	Tue,  4 Mar 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I8PIY7Kq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68E3A8C1;
	Tue,  4 Mar 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080306; cv=none; b=GI8MnTFYQUtAs41KrngYYtlm9ZFlCZF7wY0ZyQROWWmV8lQYDfh/Gb0Y7u7z3J7d+u7Om0biaBxBbQhhiExksVawR02QHNdHmto/KKahkNbJv3k0CBkk5TKOy8tLeIHP/h1Y+qG0oOl/08tJmUMD9hmp4luj+AiDWE+dXH8HzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080306; c=relaxed/simple;
	bh=eGYnmjDUonhZJcewpHdNJEi1+uk0ORlaancKjuYAKNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=leoYGAk5AD9YLf2wMKpaAtog2qvUNe6wvhWa5Dw5HI2LfczaGTjCpsZ7C6EiJltsi1bxKvCsbGQi7D+i6IRbjRp0jW7ssYr759pNteFZpiLbGPHvLj7LPlHFjHpXCbPGLvA3KySNj8QjoRk1yH0086YZAkaYtFOAfZCccVNJpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I8PIY7Kq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B712343150;
	Tue,  4 Mar 2025 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741080294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fAo8H/u5QVDH5+JgTX8NQu76MIcjGzNUQhFEa8osIdw=;
	b=I8PIY7KqeWZjbyp4m28hh0aUOIjxSDwc5sA7AfI4E/DN2zLM4IUmlfv/cR8xQDWm1u2FCo
	kd1SLgVlOZAGmSQkGl7pyg/a8/yLgxIw8QoQnLnKZq3GEs2+vet9NzJhQUBgmLwYlVpZLl
	Qjr7kEal/fiZHBWR3QGjE7KlCoYVj81Ym/KuXWIIS48oc70QpTJXWYIvWLyJPZ5EGRHhWR
	cu5ZjbcBTEHfosJkoJ7/mKdkWV/aPKDAzPXNp5D7/WVQSgF9ydodATzFtCs1ia8JIvHjgI
	o8TcR7ONOYoiML1LPBXBqEJ8Ll2JMqVg0uWlsBhIzRlTig8uqCMz4ZbVKjjFdA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 04 Mar 2025 10:24:51 +0100
Subject: [PATCH] selftests/bpf: Move test_lwt_ip_encap to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-lwt_ip-v1-1-8fdeb9e79a56@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOLGxmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMz3ZzykvjMAt0ks0RLwxQjcwvzpDQloOKCotS0zAqwQdGxtbUA1x5
 YLlgAAAA=
X-Change-ID: 20250206-lwt_ip-b6a91d2787bf
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeffjeejgedtgeegheehjedvjeeihfejtefggfegiedtleeuudeiheefgfffleenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgro
 hhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-GND-Sasl: bastien.curutchet@bootlin.com

test_lwt_ip_encap.sh isn't used by the BPF CI.

Add a new file in the test_progs framework to migrate the tests done by
test_lwt_ip_encap.sh. It uses the same network topology and the same BPF
programs located in progs/test_lwt_ip_encap.c.
Rework the GSO part to avoid using nc and dd.

Remove test_lwt_ip_encap.sh and its Makefile entry.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   3 +-
 .../selftests/bpf/prog_tests/lwt_ip_encap.c        | 540 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   | 476 ------------------
 3 files changed, 541 insertions(+), 478 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e6a02d5b87d123cef7e6b41bfbc96d34083f38e1..df4814b5200a5a0e732b19ab3a5975957fb7cbc9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -95,7 +95,7 @@ TEST_GEN_PROGS += test_progs-cpuv4
 TEST_INST_SUBDIRS += cpuv4
 endif
 
-TEST_GEN_FILES = test_lwt_ip_encap.bpf.o test_tc_edt.bpf.o
+TEST_GEN_FILES = test_tc_edt.bpf.o
 TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
@@ -104,7 +104,6 @@ TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
-	test_lwt_ip_encap.sh \
 	test_tc_tunnel.sh \
 	test_tc_edt.sh \
 	test_xdping.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
new file mode 100644
index 0000000000000000000000000000000000000000..61fcded43b46cab7775237c6d85de07b5df7d87e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <netinet/in.h>
+
+#include "network_helpers.h"
+#include "test_progs.h"
+
+#define BPF_FILE "test_lwt_ip_encap.bpf.o"
+
+#define NETNS_NAME_SIZE	32
+#define NETNS_BASE	"ns-lwt-ip-encap"
+
+#define IP4_ADDR_1 "172.16.1.100"
+#define IP4_ADDR_2 "172.16.2.100"
+#define IP4_ADDR_3 "172.16.3.100"
+#define IP4_ADDR_4 "172.16.4.100"
+#define IP4_ADDR_5 "172.16.5.100"
+#define IP4_ADDR_6 "172.16.6.100"
+#define IP4_ADDR_7 "172.16.7.100"
+#define IP4_ADDR_8 "172.16.8.100"
+#define IP4_ADDR_GRE "172.16.16.100"
+
+#define IP4_ADDR_SRC IP4_ADDR_1
+#define IP4_ADDR_DST IP4_ADDR_4
+
+#define IP6_ADDR_1 "fb01::1"
+#define IP6_ADDR_2 "fb02::1"
+#define IP6_ADDR_3 "fb03::1"
+#define IP6_ADDR_4 "fb04::1"
+#define IP6_ADDR_5 "fb05::1"
+#define IP6_ADDR_6 "fb06::1"
+#define IP6_ADDR_7 "fb07::1"
+#define IP6_ADDR_8 "fb08::1"
+#define IP6_ADDR_GRE "fb10::1"
+
+#define IP6_ADDR_SRC IP6_ADDR_1
+#define IP6_ADDR_DST IP6_ADDR_4
+
+/* Setup/topology:
+ *
+ *    NS1             NS2             NS3
+ *   veth1 <---> veth2   veth3 <---> veth4 (the top route)
+ *   veth5 <---> veth6   veth7 <---> veth8 (the bottom route)
+ *
+ *   Each vethN gets IP[4|6]_ADDR_N address.
+ *
+ *   IP*_ADDR_SRC = IP*_ADDR_1
+ *   IP*_ADDR_DST = IP*_ADDR_4
+ *
+ *   All tests test pings from IP*_ADDR__SRC to IP*_ADDR_DST.
+ *
+ *   By default, routes are configured to allow packets to go
+ *   IP*_ADDR_1 <=> IP*_ADDR_2 <=> IP*_ADDR_3 <=> IP*_ADDR_4 (the top route).
+ *
+ *   A GRE device is installed in NS3 with IP*_ADDR_GRE, and
+ *   NS1/NS2 are configured to route packets to IP*_ADDR_GRE via IP*_ADDR_8
+ *   (the bottom route).
+ *
+ * Tests:
+ *
+ *   1. Routes NS2->IP*_ADDR_DST are brought down, so the only way a ping
+ *      from IP*_ADDR_SRC to IP*_ADDR_DST can work is via IP*_ADDR_GRE.
+ *
+ *   2a. In an egress test, a bpf LWT_XMIT program is installed on veth1
+ *       that encaps the packets with an IP/GRE header to route to IP*_ADDR_GRE.
+ *
+ *       ping: SRC->[encap at veth1:egress]->GRE:decap->DST
+ *       ping replies go DST->SRC directly
+ *
+ *   2b. In an ingress test, a bpf LWT_IN program is installed on veth2
+ *       that encaps the packets with an IP/GRE header to route to IP*_ADDR_GRE.
+ *
+ *       ping: SRC->[encap at veth2:ingress]->GRE:decap->DST
+ *       ping replies go DST->SRC directly
+ */
+
+static int create_ns(char *name, size_t name_sz)
+{
+	if (!name)
+		goto fail;
+
+	if (!ASSERT_OK(append_tid(name, name_sz), "append TID"))
+		goto fail;
+
+	SYS(fail, "ip netns add %s", name);
+
+	/* rp_filter gets confused by what these tests are doing, so disable it */
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv4.conf.all.rp_filter=0", name);
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv4.conf.default.rp_filter=0", name);
+	/* Disable IPv6 DAD because it sometimes takes too long and fails tests */
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv6.conf.all.accept_dad=0", name);
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv6.conf.default.accept_dad=0", name);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int set_top_addr(const char *ns1, const char *ns2, const char *ns3)
+{
+	SYS(fail, "ip -n %s    a add %s/24  dev veth1", ns1, IP4_ADDR_1);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth2", ns2, IP4_ADDR_2);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth3", ns2, IP4_ADDR_3);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth4", ns3, IP4_ADDR_4);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth1", ns1, IP6_ADDR_1);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth2", ns2, IP6_ADDR_2);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth3", ns2, IP6_ADDR_3);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth4", ns3, IP6_ADDR_4);
+
+	SYS(fail, "ip -n %s link set dev veth1 up", ns1);
+	SYS(fail, "ip -n %s link set dev veth2 up", ns2);
+	SYS(fail, "ip -n %s link set dev veth3 up", ns2);
+	SYS(fail, "ip -n %s link set dev veth4 up", ns3);
+
+	return 0;
+fail:
+	return 1;
+}
+
+static int set_bottom_addr(const char *ns1, const char *ns2, const char *ns3)
+{
+	SYS(fail, "ip -n %s    a add %s/24  dev veth5", ns1, IP4_ADDR_5);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth6", ns2, IP4_ADDR_6);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth7", ns2, IP4_ADDR_7);
+	SYS(fail, "ip -n %s    a add %s/24  dev veth8", ns3, IP4_ADDR_8);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth5", ns1, IP6_ADDR_5);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth6", ns2, IP6_ADDR_6);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth7", ns2, IP6_ADDR_7);
+	SYS(fail, "ip -n %s -6 a add %s/128 dev veth8", ns3, IP6_ADDR_8);
+
+	SYS(fail, "ip -n %s link set dev veth5 up", ns1);
+	SYS(fail, "ip -n %s link set dev veth6 up", ns2);
+	SYS(fail, "ip -n %s link set dev veth7 up", ns2);
+	SYS(fail, "ip -n %s link set dev veth8 up", ns3);
+
+	return 0;
+fail:
+	return 1;
+}
+
+static int configure_vrf(const char *ns1, const char *ns2)
+{
+	if (!ns1 || !ns2)
+		goto fail;
+
+	SYS(fail, "ip -n %s link add red type vrf table 1001", ns1);
+	SYS(fail, "ip -n %s link set red up", ns1);
+	SYS(fail, "ip -n %s route add table 1001 unreachable default metric 8192", ns1);
+	SYS(fail, "ip -n %s -6 route add table 1001 unreachable default metric 8192", ns1);
+	SYS(fail, "ip -n %s link set veth1 vrf red", ns1);
+	SYS(fail, "ip -n %s link set veth5 vrf red", ns1);
+
+	SYS(fail, "ip -n %s link add red type vrf table 1001", ns2);
+	SYS(fail, "ip -n %s link set red up", ns2);
+	SYS(fail, "ip -n %s route add table 1001 unreachable default metric 8192", ns2);
+	SYS(fail, "ip -n %s -6 route add table 1001 unreachable default metric 8192", ns2);
+	SYS(fail, "ip -n %s link set veth2 vrf red", ns2);
+	SYS(fail, "ip -n %s link set veth3 vrf red", ns2);
+	SYS(fail, "ip -n %s link set veth6 vrf red", ns2);
+	SYS(fail, "ip -n %s link set veth7 vrf red", ns2);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int configure_ns1(const char *ns1, const char *vrf)
+{
+	struct nstoken *nstoken = NULL;
+
+	if (!ns1 || !vrf)
+		goto fail;
+
+	nstoken = open_netns(ns1);
+	if (!ASSERT_OK_PTR(nstoken, "open ns1"))
+		goto fail;
+
+	/* Top route */
+	SYS(fail, "ip    route add %s/32  dev veth1 %s", IP4_ADDR_2, vrf);
+	SYS(fail, "ip    route add default dev veth1 via %s %s", IP4_ADDR_2, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth1 %s", IP6_ADDR_2, vrf);
+	SYS(fail, "ip -6 route add default dev veth1 via %s %s", IP6_ADDR_2, vrf);
+	/* Bottom route */
+	SYS(fail, "ip    route add %s/32  dev veth5 %s", IP4_ADDR_6, vrf);
+	SYS(fail, "ip    route add %s/32  dev veth5 via  %s %s", IP4_ADDR_7, IP4_ADDR_6, vrf);
+	SYS(fail, "ip    route add %s/32  dev veth5 via  %s %s", IP4_ADDR_8, IP4_ADDR_6, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth5 %s", IP6_ADDR_6, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth5 via  %s %s", IP6_ADDR_7, IP6_ADDR_6, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth5 via  %s %s", IP6_ADDR_8, IP6_ADDR_6, vrf);
+
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
+static int configure_ns2(const char *ns2, const char *vrf)
+{
+	struct nstoken *nstoken = NULL;
+
+	if (!ns2 || !vrf)
+		goto fail;
+
+	nstoken = open_netns(ns2);
+	if (!ASSERT_OK_PTR(nstoken, "open ns2"))
+		goto fail;
+
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv4.ip_forward=1", ns2);
+	SYS(fail, "ip netns exec %s sysctl -wq net.ipv6.conf.all.forwarding=1", ns2);
+
+	/* Top route */
+	SYS(fail, "ip    route add %s/32  dev veth2 %s", IP4_ADDR_1, vrf);
+	SYS(fail, "ip    route add %s/32  dev veth3 %s", IP4_ADDR_4, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth2 %s", IP6_ADDR_1, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth3 %s", IP6_ADDR_4, vrf);
+	/* Bottom route */
+	SYS(fail, "ip    route add %s/32  dev veth6 %s", IP4_ADDR_5, vrf);
+	SYS(fail, "ip    route add %s/32  dev veth7 %s", IP4_ADDR_8, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth6 %s", IP6_ADDR_5, vrf);
+	SYS(fail, "ip -6 route add %s/128 dev veth7 %s", IP6_ADDR_8, vrf);
+
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
+static int configure_ns3(const char *ns3)
+{
+	struct nstoken *nstoken = NULL;
+
+	if (!ns3)
+		goto fail;
+
+	nstoken = open_netns(ns3);
+	if (!ASSERT_OK_PTR(nstoken, "open ns3"))
+		goto fail;
+
+	/* Top route */
+	SYS(fail, "ip    route add %s/32  dev veth4", IP4_ADDR_3);
+	SYS(fail, "ip    route add %s/32  dev veth4 via  %s", IP4_ADDR_1, IP4_ADDR_3);
+	SYS(fail, "ip    route add %s/32  dev veth4 via  %s", IP4_ADDR_2, IP4_ADDR_3);
+	SYS(fail, "ip -6 route add %s/128 dev veth4", IP6_ADDR_3);
+	SYS(fail, "ip -6 route add %s/128 dev veth4 via  %s", IP6_ADDR_1, IP6_ADDR_3);
+	SYS(fail, "ip -6 route add %s/128 dev veth4 via  %s", IP6_ADDR_2, IP6_ADDR_3);
+	/* Bottom route */
+	SYS(fail, "ip    route add %s/32  dev veth8", IP4_ADDR_7);
+	SYS(fail, "ip    route add %s/32  dev veth8 via  %s", IP4_ADDR_5, IP4_ADDR_7);
+	SYS(fail, "ip    route add %s/32  dev veth8 via  %s", IP4_ADDR_6, IP4_ADDR_7);
+	SYS(fail, "ip -6 route add %s/128 dev veth8", IP6_ADDR_7);
+	SYS(fail, "ip -6 route add %s/128 dev veth8 via  %s", IP6_ADDR_5, IP6_ADDR_7);
+	SYS(fail, "ip -6 route add %s/128 dev veth8 via  %s", IP6_ADDR_6, IP6_ADDR_7);
+
+	/* Configure IPv4 GRE device */
+	SYS(fail, "ip tunnel add gre_dev mode gre remote %s local %s ttl 255",
+	    IP4_ADDR_1, IP4_ADDR_GRE);
+	SYS(fail, "ip link set gre_dev up");
+	SYS(fail, "ip a add %s dev gre_dev", IP4_ADDR_GRE);
+
+	/* Configure IPv6 GRE device */
+	SYS(fail, "ip tunnel add gre6_dev mode ip6gre remote %s local %s ttl 255",
+	    IP6_ADDR_1, IP6_ADDR_GRE);
+	SYS(fail, "ip link set gre6_dev up");
+	SYS(fail, "ip a add %s dev gre6_dev", IP6_ADDR_GRE);
+
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
+static int setup_network(char *ns1, char *ns2, char *ns3, const char *vrf)
+{
+	if (!ns1 || !ns2 || !ns3 || !vrf)
+		goto fail;
+
+	SYS(fail, "ip -n %s link add veth1 type veth peer name veth2 netns %s", ns1, ns2);
+	SYS(fail, "ip -n %s link add veth3 type veth peer name veth4 netns %s", ns2, ns3);
+	SYS(fail, "ip -n %s link add veth5 type veth peer name veth6 netns %s", ns1, ns2);
+	SYS(fail, "ip -n %s link add veth7 type veth peer name veth8 netns %s", ns2, ns3);
+
+	if (vrf[0]) {
+		if (!ASSERT_OK(configure_vrf(ns1, ns2), "configure vrf"))
+			goto fail;
+	}
+	if (!ASSERT_OK(set_top_addr(ns1, ns2, ns3), "set top addresses"))
+		goto fail;
+
+	if (!ASSERT_OK(set_bottom_addr(ns1, ns2, ns3), "set bottom addresses"))
+		goto fail;
+
+	if (!ASSERT_OK(configure_ns1(ns1, vrf), "configure ns1 routes"))
+		goto fail;
+
+	if (!ASSERT_OK(configure_ns2(ns2, vrf), "configure ns2 routes"))
+		goto fail;
+
+	if (!ASSERT_OK(configure_ns3(ns3), "configure ns3 routes"))
+		goto fail;
+
+	/* Link bottom route to the GRE tunnels */
+	SYS(fail, "ip -n %s route add %s/32 dev veth5 via %s %s",
+	    ns1, IP4_ADDR_GRE, IP4_ADDR_6, vrf);
+	SYS(fail, "ip -n %s route add %s/32 dev veth7 via %s %s",
+	    ns2, IP4_ADDR_GRE, IP4_ADDR_8, vrf);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth5 via %s %s",
+	    ns1, IP6_ADDR_GRE, IP6_ADDR_6, vrf);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth7 via %s %s",
+	    ns2, IP6_ADDR_GRE, IP6_ADDR_8, vrf);
+
+	return 0;
+fail:
+	return -1;
+}
+
+int remove_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
+{
+	SYS(fail, "ip -n %s route del %s dev veth5 %s", ns1, IP4_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s route del %s dev veth7 %s", ns2, IP4_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s -6 route del %s/128 dev veth5 %s", ns1, IP6_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s -6 route del %s/128 dev veth7 %s", ns2, IP6_ADDR_GRE, vrf);
+
+	return 0;
+fail:
+	return -1;
+}
+
+int add_unreachable_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
+{
+	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns1, IP4_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns2, IP4_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns1, IP6_ADDR_GRE, vrf);
+	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns2, IP6_ADDR_GRE, vrf);
+
+	return 0;
+fail:
+	return -1;
+}
+
+#define GSO_SIZE 5000
+#define GSO_TCP_PORT 9000
+/* This tests the fix from commit ea0371f78799 ("net: fix GSO in bpf_lwt_push_ip_encap") */
+static int test_gso_fix(const char *ns1, const char *ns3, int family)
+{
+	const char *ip_addr = family == AF_INET ? IP4_ADDR_DST : IP6_ADDR_DST;
+	char gso_packet[GSO_SIZE] = {};
+	struct nstoken *nstoken = NULL;
+	int sfd, cfd, afd;
+	ssize_t bytes;
+	int ret = -1;
+
+	if (!ns1 || !ns3)
+		return ret;
+
+	nstoken = open_netns(ns3);
+	if (!ASSERT_OK_PTR(nstoken, "open ns3"))
+		return ret;
+
+	sfd = start_server_str(family, SOCK_STREAM, ip_addr, GSO_TCP_PORT, NULL);
+	if (!ASSERT_OK_FD(sfd, "start server"))
+		goto close_netns;
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(ns1);
+	if (!ASSERT_OK_PTR(nstoken, "open ns1"))
+		goto close_server;
+
+	cfd = connect_to_addr_str(family, SOCK_STREAM, ip_addr, GSO_TCP_PORT, NULL);
+	if (!ASSERT_OK_FD(cfd, "connect to server"))
+		goto close_server;
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	afd = accept(sfd, NULL, NULL);
+	if (!ASSERT_OK_FD(afd, "accept"))
+		goto close_client;
+
+	/* Send a packet larger than MTU */
+	bytes = send(cfd, gso_packet, GSO_SIZE, 0);
+	if (!ASSERT_EQ(bytes, GSO_SIZE, "send packet"))
+		goto close_accept;
+
+	/* Verify we received all expected bytes */
+	bytes = read(afd, gso_packet, GSO_SIZE);
+	if (!ASSERT_EQ(bytes, GSO_SIZE, "receive packet"))
+		goto close_accept;
+
+	ret = 0;
+
+close_accept:
+	close(afd);
+close_client:
+	close(cfd);
+close_server:
+	close(sfd);
+close_netns:
+	close_netns(nstoken);
+
+	return ret;
+}
+
+static int check_ping_ok(const char *ns1)
+{
+	SYS(fail, "ip netns exec %s ping -c 1 -W1 -I veth1 %s > /dev/null", ns1, IP4_ADDR_DST);
+	SYS(fail, "ip netns exec %s ping6 -c 1 -W1 -I veth1 %s > /dev/null", ns1, IP6_ADDR_DST);
+	return 0;
+fail:
+	return -1;
+}
+
+static int check_ping_fails(const char *ns1)
+{
+	int ret;
+
+	ret = SYS_NOFAIL("ip netns exec %s ping -c 1 -W1 -I veth1 %s", ns1, IP4_ADDR_DST);
+	if (!ret)
+		return -1;
+
+	ret = SYS_NOFAIL("ip netns exec %s ping6 -c 1 -W1 -I veth1 %s", ns1, IP6_ADDR_DST);
+	if (!ret)
+		return -1;
+
+	return 0;
+}
+
+#define EGRESS true
+#define INGRESS false
+#define IPV4_ENCAP true
+#define IPV6_ENCAP false
+static void lwt_ip_encap(bool ipv4_encap, bool egress, const char *vrf)
+{
+	char ns1[NETNS_NAME_SIZE] = NETNS_BASE "-1-";
+	char ns2[NETNS_NAME_SIZE] = NETNS_BASE "-2-";
+	char ns3[NETNS_NAME_SIZE] = NETNS_BASE "-3-";
+	char *sec = ipv4_encap ?  "encap_gre" : "encap_gre6";
+
+	if (!vrf)
+		return;
+
+	if (!ASSERT_OK(create_ns(ns1, NETNS_NAME_SIZE), "create ns1"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns2, NETNS_NAME_SIZE), "create ns2"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns3, NETNS_NAME_SIZE), "create ns3"))
+		goto out;
+
+	if (!ASSERT_OK(setup_network(ns1, ns2, ns3, vrf), "setup network"))
+		goto out;
+
+	/* By default, pings work */
+	if (!ASSERT_OK(check_ping_ok(ns1), "ping OK"))
+		goto out;
+
+	/* Remove NS2->DST routes, ping fails */
+	SYS(out, "ip -n %s    route del %s/32  dev veth3 %s", ns2, IP4_ADDR_DST, vrf);
+	SYS(out, "ip -n %s -6 route del %s/128 dev veth3 %s", ns2, IP6_ADDR_DST, vrf);
+	if (!ASSERT_OK(check_ping_fails(ns1), "ping expected fail"))
+		goto out;
+
+	/* Install replacement routes (LWT/eBPF), pings succeed */
+	if (egress) {
+		SYS(out, "ip -n %s route add %s encap bpf xmit obj %s sec %s dev veth1 %s",
+		    ns1, IP4_ADDR_DST, BPF_FILE, sec, vrf);
+		SYS(out, "ip -n %s -6 route add %s encap bpf xmit obj %s sec %s dev veth1 %s",
+		    ns1, IP6_ADDR_DST, BPF_FILE, sec, vrf);
+	} else {
+		SYS(out, "ip -n %s route add %s encap bpf in obj %s sec %s dev veth2 %s",
+		    ns2, IP4_ADDR_DST, BPF_FILE, sec, vrf);
+		SYS(out, "ip -n %s -6 route add %s encap bpf in obj %s sec %s dev veth2 %s",
+		    ns2, IP6_ADDR_DST, BPF_FILE, sec, vrf);
+	}
+
+	if (!ASSERT_OK(check_ping_ok(ns1), "ping OK"))
+		goto out;
+
+	/* Skip GSO tests with VRF: VRF routing needs properly assigned
+	 * source IP/device, which is easy to do with ping but hard with TCP.
+	 */
+	if (egress && !vrf[0]) {
+		if (!ASSERT_OK(test_gso_fix(ns1, ns3, AF_INET), "test GSO"))
+			goto out;
+	}
+
+	/* Negative test: remove routes to GRE devices: ping fails */
+	if (!ASSERT_OK(remove_routes_to_gredev(ns1, ns2, vrf), "remove routes to gredev"))
+		goto out;
+	if (!ASSERT_OK(check_ping_fails(ns1), "ping expected fail"))
+		goto out;
+
+	/* Another negative test */
+	if (!ASSERT_OK(add_unreachable_routes_to_gredev(ns1, ns2, vrf),
+		       "add unreachable routes"))
+		goto out;
+	ASSERT_OK(check_ping_fails(ns1), "ping expected fail");
+
+out:
+	SYS_NOFAIL("ip netns del %s", ns1);
+	SYS_NOFAIL("ip netns del %s", ns2);
+	SYS_NOFAIL("ip netns del %s", ns3);
+}
+
+void test_lwt_ip_encap_vrf_ipv6(void)
+{
+	if (test__start_subtest("egress"))
+		lwt_ip_encap(IPV6_ENCAP, EGRESS, "vrf red");
+
+	if (test__start_subtest("ingress"))
+		lwt_ip_encap(IPV6_ENCAP, INGRESS, "vrf red");
+}
+
+void test_lwt_ip_encap_vrf_ipv4(void)
+{
+	if (test__start_subtest("egress"))
+		lwt_ip_encap(IPV4_ENCAP, EGRESS, "vrf red");
+
+	if (test__start_subtest("ingress"))
+		lwt_ip_encap(IPV4_ENCAP, INGRESS, "vrf red");
+}
+
+void test_lwt_ip_encap_ipv6(void)
+{
+	if (test__start_subtest("egress"))
+		lwt_ip_encap(IPV6_ENCAP, EGRESS, "");
+
+	if (test__start_subtest("ingress"))
+		lwt_ip_encap(IPV6_ENCAP, INGRESS, "");
+}
+
+void test_lwt_ip_encap_ipv4(void)
+{
+	if (test__start_subtest("egress"))
+		lwt_ip_encap(IPV4_ENCAP, EGRESS, "");
+
+	if (test__start_subtest("ingress"))
+		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
+}
diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
deleted file mode 100755
index 1e565f47aca940d8dc7235d823c48537d7a708b8..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ /dev/null
@@ -1,476 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Setup/topology:
-#
-#    NS1             NS2             NS3
-#   veth1 <---> veth2   veth3 <---> veth4 (the top route)
-#   veth5 <---> veth6   veth7 <---> veth8 (the bottom route)
-#
-#   each vethN gets IPv[4|6]_N address
-#
-#   IPv*_SRC = IPv*_1
-#   IPv*_DST = IPv*_4
-#
-#   all tests test pings from IPv*_SRC to IPv*_DST
-#
-#   by default, routes are configured to allow packets to go
-#   IP*_1 <=> IP*_2 <=> IP*_3 <=> IP*_4 (the top route)
-#
-#   a GRE device is installed in NS3 with IPv*_GRE, and
-#   NS1/NS2 are configured to route packets to IPv*_GRE via IP*_8
-#   (the bottom route)
-#
-# Tests:
-#
-#   1. routes NS2->IPv*_DST are brought down, so the only way a ping
-#      from IP*_SRC to IP*_DST can work is via IPv*_GRE
-#
-#   2a. in an egress test, a bpf LWT_XMIT program is installed on veth1
-#       that encaps the packets with an IP/GRE header to route to IPv*_GRE
-#
-#       ping: SRC->[encap at veth1:egress]->GRE:decap->DST
-#       ping replies go DST->SRC directly
-#
-#   2b. in an ingress test, a bpf LWT_IN program is installed on veth2
-#       that encaps the packets with an IP/GRE header to route to IPv*_GRE
-#
-#       ping: SRC->[encap at veth2:ingress]->GRE:decap->DST
-#       ping replies go DST->SRC directly
-
-BPF_FILE="test_lwt_ip_encap.bpf.o"
-if [[ $EUID -ne 0 ]]; then
-	echo "This script must be run as root"
-	echo "FAIL"
-	exit 1
-fi
-
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-readonly NS3="ns3-$(mktemp -u XXXXXX)"
-
-readonly IPv4_1="172.16.1.100"
-readonly IPv4_2="172.16.2.100"
-readonly IPv4_3="172.16.3.100"
-readonly IPv4_4="172.16.4.100"
-readonly IPv4_5="172.16.5.100"
-readonly IPv4_6="172.16.6.100"
-readonly IPv4_7="172.16.7.100"
-readonly IPv4_8="172.16.8.100"
-readonly IPv4_GRE="172.16.16.100"
-
-readonly IPv4_SRC=$IPv4_1
-readonly IPv4_DST=$IPv4_4
-
-readonly IPv6_1="fb01::1"
-readonly IPv6_2="fb02::1"
-readonly IPv6_3="fb03::1"
-readonly IPv6_4="fb04::1"
-readonly IPv6_5="fb05::1"
-readonly IPv6_6="fb06::1"
-readonly IPv6_7="fb07::1"
-readonly IPv6_8="fb08::1"
-readonly IPv6_GRE="fb10::1"
-
-readonly IPv6_SRC=$IPv6_1
-readonly IPv6_DST=$IPv6_4
-
-TEST_STATUS=0
-TESTS_SUCCEEDED=0
-TESTS_FAILED=0
-
-TMPFILE=""
-
-process_test_results()
-{
-	if [[ "${TEST_STATUS}" -eq 0 ]] ; then
-		echo "PASS"
-		TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+1))
-	else
-		echo "FAIL"
-		TESTS_FAILED=$((TESTS_FAILED+1))
-	fi
-}
-
-print_test_summary_and_exit()
-{
-	echo "passed tests: ${TESTS_SUCCEEDED}"
-	echo "failed tests: ${TESTS_FAILED}"
-	if [ "${TESTS_FAILED}" -eq "0" ] ; then
-		exit 0
-	else
-		exit 1
-	fi
-}
-
-setup()
-{
-	set -e  # exit on error
-	TEST_STATUS=0
-
-	# create devices and namespaces
-	ip netns add "${NS1}"
-	ip netns add "${NS2}"
-	ip netns add "${NS3}"
-
-	# rp_filter gets confused by what these tests are doing, so disable it
-	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.default.rp_filter=0
-	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.default.rp_filter=0
-	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.default.rp_filter=0
-
-	# disable IPv6 DAD because it sometimes takes too long and fails tests
-	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.default.accept_dad=0
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.default.accept_dad=0
-	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.default.accept_dad=0
-
-	ip link add veth1 type veth peer name veth2
-	ip link add veth3 type veth peer name veth4
-	ip link add veth5 type veth peer name veth6
-	ip link add veth7 type veth peer name veth8
-
-	ip netns exec ${NS2} sysctl -wq net.ipv4.ip_forward=1
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip link set veth1 netns ${NS1}
-	ip link set veth2 netns ${NS2}
-	ip link set veth3 netns ${NS2}
-	ip link set veth4 netns ${NS3}
-	ip link set veth5 netns ${NS1}
-	ip link set veth6 netns ${NS2}
-	ip link set veth7 netns ${NS2}
-	ip link set veth8 netns ${NS3}
-
-	if [ ! -z "${VRF}" ] ; then
-		ip -netns ${NS1} link add red type vrf table 1001
-		ip -netns ${NS1} link set red up
-		ip -netns ${NS1} route add table 1001 unreachable default metric 8192
-		ip -netns ${NS1} -6 route add table 1001 unreachable default metric 8192
-		ip -netns ${NS1} link set veth1 vrf red
-		ip -netns ${NS1} link set veth5 vrf red
-
-		ip -netns ${NS2} link add red type vrf table 1001
-		ip -netns ${NS2} link set red up
-		ip -netns ${NS2} route add table 1001 unreachable default metric 8192
-		ip -netns ${NS2} -6 route add table 1001 unreachable default metric 8192
-		ip -netns ${NS2} link set veth2 vrf red
-		ip -netns ${NS2} link set veth3 vrf red
-		ip -netns ${NS2} link set veth6 vrf red
-		ip -netns ${NS2} link set veth7 vrf red
-	fi
-
-	# configure addesses: the top route (1-2-3-4)
-	ip -netns ${NS1}    addr add ${IPv4_1}/24  dev veth1
-	ip -netns ${NS2}    addr add ${IPv4_2}/24  dev veth2
-	ip -netns ${NS2}    addr add ${IPv4_3}/24  dev veth3
-	ip -netns ${NS3}    addr add ${IPv4_4}/24  dev veth4
-	ip -netns ${NS1} -6 addr add ${IPv6_1}/128 nodad dev veth1
-	ip -netns ${NS2} -6 addr add ${IPv6_2}/128 nodad dev veth2
-	ip -netns ${NS2} -6 addr add ${IPv6_3}/128 nodad dev veth3
-	ip -netns ${NS3} -6 addr add ${IPv6_4}/128 nodad dev veth4
-
-	# configure addresses: the bottom route (5-6-7-8)
-	ip -netns ${NS1}    addr add ${IPv4_5}/24  dev veth5
-	ip -netns ${NS2}    addr add ${IPv4_6}/24  dev veth6
-	ip -netns ${NS2}    addr add ${IPv4_7}/24  dev veth7
-	ip -netns ${NS3}    addr add ${IPv4_8}/24  dev veth8
-	ip -netns ${NS1} -6 addr add ${IPv6_5}/128 nodad dev veth5
-	ip -netns ${NS2} -6 addr add ${IPv6_6}/128 nodad dev veth6
-	ip -netns ${NS2} -6 addr add ${IPv6_7}/128 nodad dev veth7
-	ip -netns ${NS3} -6 addr add ${IPv6_8}/128 nodad dev veth8
-
-	ip -netns ${NS1} link set dev veth1 up
-	ip -netns ${NS2} link set dev veth2 up
-	ip -netns ${NS2} link set dev veth3 up
-	ip -netns ${NS3} link set dev veth4 up
-	ip -netns ${NS1} link set dev veth5 up
-	ip -netns ${NS2} link set dev veth6 up
-	ip -netns ${NS2} link set dev veth7 up
-	ip -netns ${NS3} link set dev veth8 up
-
-	# configure routes: IP*_SRC -> veth1/IP*_2 (= top route) default;
-	# the bottom route to specific bottom addresses
-
-	# NS1
-	# top route
-	ip -netns ${NS1}    route add ${IPv4_2}/32  dev veth1 ${VRF}
-	ip -netns ${NS1}    route add default dev veth1 via ${IPv4_2} ${VRF}  # go top by default
-	ip -netns ${NS1} -6 route add ${IPv6_2}/128 dev veth1 ${VRF}
-	ip -netns ${NS1} -6 route add default dev veth1 via ${IPv6_2} ${VRF}  # go top by default
-	# bottom route
-	ip -netns ${NS1}    route add ${IPv4_6}/32  dev veth5 ${VRF}
-	ip -netns ${NS1}    route add ${IPv4_7}/32  dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS1}    route add ${IPv4_8}/32  dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_6}/128 dev veth5 ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_7}/128 dev veth5 via ${IPv6_6} ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_8}/128 dev veth5 via ${IPv6_6} ${VRF}
-
-	# NS2
-	# top route
-	ip -netns ${NS2}    route add ${IPv4_1}/32  dev veth2 ${VRF}
-	ip -netns ${NS2}    route add ${IPv4_4}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_1}/128 dev veth2 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_4}/128 dev veth3 ${VRF}
-	# bottom route
-	ip -netns ${NS2}    route add ${IPv4_5}/32  dev veth6 ${VRF}
-	ip -netns ${NS2}    route add ${IPv4_8}/32  dev veth7 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_5}/128 dev veth6 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_8}/128 dev veth7 ${VRF}
-
-	# NS3
-	# top route
-	ip -netns ${NS3}    route add ${IPv4_3}/32  dev veth4
-	ip -netns ${NS3}    route add ${IPv4_1}/32  dev veth4 via ${IPv4_3}
-	ip -netns ${NS3}    route add ${IPv4_2}/32  dev veth4 via ${IPv4_3}
-	ip -netns ${NS3} -6 route add ${IPv6_3}/128 dev veth4
-	ip -netns ${NS3} -6 route add ${IPv6_1}/128 dev veth4 via ${IPv6_3}
-	ip -netns ${NS3} -6 route add ${IPv6_2}/128 dev veth4 via ${IPv6_3}
-	# bottom route
-	ip -netns ${NS3}    route add ${IPv4_7}/32  dev veth8
-	ip -netns ${NS3}    route add ${IPv4_5}/32  dev veth8 via ${IPv4_7}
-	ip -netns ${NS3}    route add ${IPv4_6}/32  dev veth8 via ${IPv4_7}
-	ip -netns ${NS3} -6 route add ${IPv6_7}/128 dev veth8
-	ip -netns ${NS3} -6 route add ${IPv6_5}/128 dev veth8 via ${IPv6_7}
-	ip -netns ${NS3} -6 route add ${IPv6_6}/128 dev veth8 via ${IPv6_7}
-
-	# configure IPv4 GRE device in NS3, and a route to it via the "bottom" route
-	ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_1} local ${IPv4_GRE} ttl 255
-	ip -netns ${NS3} link set gre_dev up
-	ip -netns ${NS3} addr add ${IPv4_GRE} dev gre_dev
-	ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS2} route add ${IPv4_GRE}/32 dev veth7 via ${IPv4_8} ${VRF}
-
-
-	# configure IPv6 GRE device in NS3, and a route to it via the "bottom" route
-	ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_1} local ${IPv6_GRE} ttl 255
-	ip -netns ${NS3} link set gre6_dev up
-	ip -netns ${NS3} -6 addr add ${IPv6_GRE} nodad dev gre6_dev
-	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_GRE}/128 dev veth7 via ${IPv6_8} ${VRF}
-
-	TMPFILE=$(mktemp /tmp/test_lwt_ip_encap.XXXXXX)
-
-	sleep 1  # reduce flakiness
-	set +e
-}
-
-cleanup()
-{
-	if [ -f ${TMPFILE} ] ; then
-		rm ${TMPFILE}
-	fi
-
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-	ip netns del ${NS3} 2> /dev/null
-}
-
-trap cleanup EXIT
-
-remove_routes_to_gredev()
-{
-	ip -netns ${NS1} route del ${IPv4_GRE} dev veth5 ${VRF}
-	ip -netns ${NS2} route del ${IPv4_GRE} dev veth7 ${VRF}
-	ip -netns ${NS1} -6 route del ${IPv6_GRE}/128 dev veth5 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_GRE}/128 dev veth7 ${VRF}
-}
-
-add_unreachable_routes_to_gredev()
-{
-	ip -netns ${NS1} route add unreachable ${IPv4_GRE}/32 ${VRF}
-	ip -netns ${NS2} route add unreachable ${IPv4_GRE}/32 ${VRF}
-	ip -netns ${NS1} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
-	ip -netns ${NS2} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
-}
-
-test_ping()
-{
-	local readonly PROTO=$1
-	local readonly EXPECTED=$2
-	local RET=0
-
-	if [ "${PROTO}" == "IPv4" ] ; then
-		ip netns exec ${NS1} ping  -c 1 -W 1 -I veth1 ${IPv4_DST} 2>&1 > /dev/null
-		RET=$?
-	elif [ "${PROTO}" == "IPv6" ] ; then
-		ip netns exec ${NS1} ping6 -c 1 -W 1 -I veth1 ${IPv6_DST} 2>&1 > /dev/null
-		RET=$?
-	else
-		echo "    test_ping: unknown PROTO: ${PROTO}"
-		TEST_STATUS=1
-	fi
-
-	if [ "0" != "${RET}" ]; then
-		RET=1
-	fi
-
-	if [ "${EXPECTED}" != "${RET}" ] ; then
-		echo "    test_ping failed: expected: ${EXPECTED}; got ${RET}"
-		TEST_STATUS=1
-	fi
-}
-
-test_gso()
-{
-	local readonly PROTO=$1
-	local readonly PKT_SZ=5000
-	local IP_DST=""
-	: > ${TMPFILE}  # trim the capture file
-
-	# check that nc is present
-	command -v nc >/dev/null 2>&1 || \
-		{ echo >&2 "nc is not available: skipping TSO tests"; return; }
-
-	# listen on port 9000, capture TCP into $TMPFILE
-	if [ "${PROTO}" == "IPv4" ] ; then
-		IP_DST=${IPv4_DST}
-		ip netns exec ${NS3} bash -c \
-			"nc -4 -l -p 9000 > ${TMPFILE} &"
-	elif [ "${PROTO}" == "IPv6" ] ; then
-		IP_DST=${IPv6_DST}
-		ip netns exec ${NS3} bash -c \
-			"nc -6 -l -p 9000 > ${TMPFILE} &"
-		RET=$?
-	else
-		echo "    test_gso: unknown PROTO: ${PROTO}"
-		TEST_STATUS=1
-	fi
-	sleep 1  # let nc start listening
-
-	# send a packet larger than MTU
-	ip netns exec ${NS1} bash -c \
-		"dd if=/dev/zero bs=$PKT_SZ count=1 > /dev/tcp/${IP_DST}/9000 2>/dev/null"
-	sleep 2 # let the packet get delivered
-
-	# verify we received all expected bytes
-	SZ=$(stat -c %s ${TMPFILE})
-	if [ "$SZ" != "$PKT_SZ" ] ; then
-		echo "    test_gso failed: ${PROTO}"
-		TEST_STATUS=1
-	fi
-}
-
-test_egress()
-{
-	local readonly ENCAP=$1
-	echo "starting egress ${ENCAP} encap test ${VRF}"
-	setup
-
-	# by default, pings work
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# remove NS2->DST routes, ping fails
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# install replacement routes (LWT/eBPF), pings succeed
-	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
-			${BPF_FILE} sec encap_gre dev veth1 ${VRF}
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
-			${BPF_FILE} sec encap_gre dev veth1 ${VRF}
-	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
-			${BPF_FILE} sec encap_gre6 dev veth1 ${VRF}
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
-			${BPF_FILE} sec encap_gre6 dev veth1 ${VRF}
-	else
-		echo "    unknown encap ${ENCAP}"
-		TEST_STATUS=1
-	fi
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# skip GSO tests with VRF: VRF routing needs properly assigned
-	# source IP/device, which is easy to do with ping and hard with dd/nc.
-	if [ -z "${VRF}" ] ; then
-		test_gso IPv4
-		test_gso IPv6
-	fi
-
-	# a negative test: remove routes to GRE devices: ping fails
-	remove_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# another negative test
-	add_unreachable_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	cleanup
-	process_test_results
-}
-
-test_ingress()
-{
-	local readonly ENCAP=$1
-	echo "starting ingress ${ENCAP} encap test ${VRF}"
-	setup
-
-	# need to wait a bit for IPv6 to autoconf, otherwise
-	# ping6 sometimes fails with "unable to bind to address"
-
-	# by default, pings work
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# remove NS2->DST routes, pings fail
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# install replacement routes (LWT/eBPF), pings succeed
-	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
-			${BPF_FILE} sec encap_gre dev veth2 ${VRF}
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
-			${BPF_FILE} sec encap_gre dev veth2 ${VRF}
-	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
-			${BPF_FILE} sec encap_gre6 dev veth2 ${VRF}
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
-			${BPF_FILE} sec encap_gre6 dev veth2 ${VRF}
-	else
-		echo "FAIL: unknown encap ${ENCAP}"
-		TEST_STATUS=1
-	fi
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# a negative test: remove routes to GRE devices: ping fails
-	remove_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# another negative test
-	add_unreachable_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	cleanup
-	process_test_results
-}
-
-VRF=""
-test_egress IPv4
-test_egress IPv6
-test_ingress IPv4
-test_ingress IPv6
-
-VRF="vrf red"
-test_egress IPv4
-test_egress IPv6
-test_ingress IPv4
-test_ingress IPv6
-
-print_test_summary_and_exit

---
base-commit: 5fd21aaac37919abc5c5d0df1eb06a9f02518f27
change-id: 20250206-lwt_ip-b6a91d2787bf

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


