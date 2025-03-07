Return-Path: <linux-kselftest+bounces-28468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BAA5637C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7171B18952C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74F20AF9D;
	Fri,  7 Mar 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oyxt9znU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAE206F2E;
	Fri,  7 Mar 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339126; cv=none; b=Ci0nTgkRn1+BVFOdgwYE0eYOUwiB5podkAorJnN5ueJd7DBJIhB130kBGJEOZCQw2KENRH6Qzy7GfSzJGuX3JrrV40TBQtReO243hueyxFAul8mB+/7ZROWg62gdGl/PcDC8VUDnSgWBwPe3+QsSdh5+lZyg2q/C6rPMI3T9msU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339126; c=relaxed/simple;
	bh=WiVGVURCwI59ZZpRv4lQ3RvtVW+4KnPUpk3X086V73I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLmeY/FJvN3qxK34pfWyesBHyJHgKLwYkoZ9N3BU0sY7QcxF/5hzki/hSq+U8bg9OD6KwQ3K+WjX6F8Z144Kdv6aGMGFup1+hFuZMFJ7wwoq7Sbfk2zCCr4Oufl35c81aS1im9KigSFPs/JeqQbt5QPuX9FUqiBlfRjqudxL1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oyxt9znU; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA64D4333B;
	Fri,  7 Mar 2025 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741339115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I/L0b8WRRA39r/oQ0k4hUAzOD54s2lqxNL13m3ECtw=;
	b=oyxt9znU/D4uA8JeY1+pTTSAAD8l2q3RMR4syxfIcsXvtVj9/iehZS1E/ZDFQLaWa5jsZF
	ANvPK/HAjIo85+pXKaIc96m1Kz8lYm8aVa+zuGsbAcOToAFR7GlKlam63UJpQBTIvBzvc4
	Q+KtnKlNI4+eivlzxjARVjbLhQff1wNfdGQeswQn01tUde/rL+w6m/RYMnJbEXctm/RQST
	U70UGDcnzikw6SWkylBDxGtyh3R/xaCz4LiD+qz9VNSE2M0p9lGxeASBLNGmHhC8/WlbTO
	kylllH8Y9gZzDfHqY4VDeo0UtWiQhAw9jJxeU+qh/upOzp/0QnWTmNWP2uIW7Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 07 Mar 2025 10:18:24 +0100
Subject: [PATCH bpf-next 2/2] selftests/bpf: lwt_seg6local: Move test to
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-seg6local-v1-2-990fff8f180d@bootlin.com>
References: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
In-Reply-To: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtt
 hhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

test_lwt_seg6local.sh isn't used by the BPF CI.

Add a new file in the test_progs framework to migrate the tests done by
test_lwt_seg6local.sh. It uses the same network topology and the same BPF
programs located in progs/test_lwt_seg6local.c.
Use the network helpers instead of `nc` to exchange the final packet.

Remove test_lwt_seg6local.sh and its Makefile entry.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/lwt_seg6local.c       | 176 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_lwt_seg6local.sh  | 151 ------------------
 3 files changed, 176 insertions(+), 152 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e6a02d5b87d123cef7e6b41bfbc96d34083f38e1..b9203be2697db61f541291c4a26defab9b0dbee7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -100,7 +100,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
new file mode 100644
index 0000000000000000000000000000000000000000..3bc730b7c7fa0c4809c7c4ed6e00e7a7d12cb555
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Connects 6 network namespaces through veths.
+ * Each NS may have different IPv6 global scope addresses :
+ *
+ *          NS1            NS2             NS3              NS4               NS5             NS6
+ *      lo  veth1 <-> veth2 veth3 <-> veth4 veth5 <-> veth6 lo veth7 <-> veth8 veth9 <-> veth10 lo
+ * fb00 ::1  ::12      ::21  ::34      ::43  ::56      ::65     ::78      ::87  ::910     ::109  ::6
+ * fd00                                                                                          ::4
+ * fc42                                                     ::1
+ *
+ * All IPv6 packets going to fb00::/16 through NS2 will be encapsulated in a
+ * IPv6 header with a Segment Routing Header, with segments :
+ *	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
+ *
+ * 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
+ * - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
+ * - fd00::2 : remove the TLV, change the flags, add a tag
+ * - fd00::3 : apply an End.T action to fd00::4, through routing table 117
+ *
+ * fd00::4 is a simple Segment Routing node decapsulating the inner IPv6 packet.
+ * Each End.BPF action will validate the operations applied on the SRH by the
+ * previous BPF program in the chain, otherwise the packet is dropped.
+ *
+ * An UDP datagram is sent from fb00::1 to fb00::6. The test succeeds if this
+ * datagram can be read on NS6 when binding to fb00::6.
+ */
+
+#include "network_helpers.h"
+#include "test_progs.h"
+
+#define NETNS_BASE "lwt-seg6local-"
+#define BPF_FILE "test_lwt_seg6local.bpf.o"
+
+static void cleanup(void)
+{
+	int ns;
+
+	for (ns = 1; ns < 7; ns++)
+		SYS_NOFAIL("ip netns del %s%d", NETNS_BASE, ns);
+}
+
+static int setup(void)
+{
+	int ns;
+
+	for (ns = 1; ns < 7; ns++)
+		SYS(fail, "ip netns add %s%d", NETNS_BASE, ns);
+
+	SYS(fail, "ip -n %s6 link set dev lo up", NETNS_BASE);
+
+	for (ns = 1; ns < 6; ns++) {
+		int local_id = ns * 2 - 1;
+		int peer_id = ns * 2;
+		int next_ns = ns + 1;
+
+		SYS(fail, "ip -n %s%d link add veth%d type veth peer name veth%d netns %s%d",
+		    NETNS_BASE, ns, local_id, peer_id, NETNS_BASE, next_ns);
+
+		SYS(fail, "ip -n %s%d link set dev veth%d up", NETNS_BASE, ns, local_id);
+		SYS(fail, "ip -n %s%d link set dev veth%d up", NETNS_BASE, next_ns, peer_id);
+
+		/* All link scope addresses to veths */
+		SYS(fail, "ip -n %s%d -6 addr add fb00::%d%d/16 dev veth%d scope link",
+		    NETNS_BASE, ns, local_id, peer_id, local_id);
+		SYS(fail, "ip -n %s%d -6 addr add fb00::%d%d/16 dev veth%d scope link",
+		    NETNS_BASE, next_ns, peer_id, local_id, peer_id);
+	}
+
+
+	SYS(fail, "ip -n %s5 -6 route add fb00::109 table 117 dev veth9 scope link", NETNS_BASE);
+
+	SYS(fail, "ip -n %s1 -6 addr add fb00::1/16 dev lo", NETNS_BASE);
+	SYS(fail, "ip -n %s1 -6 route add fb00::6 dev veth1 via fb00::21", NETNS_BASE);
+
+	SYS(fail, "ip -n %s2 -6 route add fb00::6 encap bpf in obj %s sec encap_srh dev veth2",
+	    NETNS_BASE, BPF_FILE);
+	SYS(fail, "ip -n %s2 -6 route add fd00::1 dev veth3 via fb00::43 scope link", NETNS_BASE);
+
+	SYS(fail, "ip -n %s3 -6 route add fc42::1 dev veth5 via fb00::65", NETNS_BASE);
+	SYS(fail,
+	    "ip -n %s3 -6 route add fd00::1 encap seg6local action End.BPF endpoint obj %s sec add_egr_x dev veth4",
+	    NETNS_BASE, BPF_FILE);
+
+	SYS(fail,
+	    "ip -n %s4 -6 route add fd00::2 encap seg6local action End.BPF endpoint obj %s sec pop_egr dev veth6",
+	    NETNS_BASE, BPF_FILE);
+	SYS(fail, "ip -n %s4 -6 addr add fc42::1 dev lo", NETNS_BASE);
+	SYS(fail, "ip -n %s4 -6 route add fd00::3 dev veth7 via fb00::87", NETNS_BASE);
+
+	SYS(fail, "ip -n %s5 -6 route add fd00::4 table 117 dev veth9 via fb00::109", NETNS_BASE);
+	SYS(fail,
+	    "ip -n %s5 -6 route add fd00::3 encap seg6local action End.BPF endpoint obj %s sec inspect_t dev veth8",
+	    NETNS_BASE, BPF_FILE);
+
+	SYS(fail, "ip -n %s6 -6 addr add fb00::6/16 dev lo", NETNS_BASE);
+	SYS(fail, "ip -n %s6 -6 addr add fd00::4/16 dev lo", NETNS_BASE);
+
+	for (ns = 1; ns < 6; ns++)
+		SYS(fail, "ip netns exec %s%d sysctl -wq net.ipv6.conf.all.forwarding=1",
+		    NETNS_BASE, ns);
+
+	SYS(fail, "ip netns exec %s6 sysctl -wq net.ipv6.conf.all.seg6_enabled=1", NETNS_BASE);
+	SYS(fail, "ip netns exec %s6 sysctl -wq net.ipv6.conf.lo.seg6_enabled=1", NETNS_BASE);
+	SYS(fail, "ip netns exec %s6 sysctl -wq net.ipv6.conf.veth10.seg6_enabled=1", NETNS_BASE);
+
+	return 0;
+fail:
+	return -1;
+}
+
+#define SERVER_PORT 7330
+#define CLIENT_PORT 2121
+void test_lwt_seg6local(void)
+{
+	struct sockaddr_in6 server_addr = {};
+	const char *ns1 = NETNS_BASE "1";
+	const char *ns6 = NETNS_BASE "6";
+	struct nstoken *nstoken = NULL;
+	const char *foobar = "foobar";
+	ssize_t bytes;
+	int sfd, cfd;
+	char buf[7];
+
+	if (!ASSERT_OK(setup(), "setup"))
+		goto out;
+
+	nstoken = open_netns(ns6);
+	if (!ASSERT_OK_PTR(nstoken, "open ns6"))
+		goto out;
+
+	sfd = start_server_str(AF_INET6, SOCK_DGRAM, "fb00::6", SERVER_PORT, NULL);
+	if (!ASSERT_OK_FD(sfd, "start server"))
+		goto close_netns;
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(ns1);
+	if (!ASSERT_OK_PTR(nstoken, "open ns1"))
+		goto close_server;
+
+	cfd = start_server_str(AF_INET6, SOCK_DGRAM, "fb00::1", CLIENT_PORT, NULL);
+	if (!ASSERT_OK_FD(cfd, "start client"))
+		goto close_server;
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	/* Send a packet larger than MTU */
+	server_addr.sin6_family = AF_INET6;
+	server_addr.sin6_port = htons(SERVER_PORT);
+	if (!ASSERT_EQ(inet_pton(AF_INET6, "fb00::6", &server_addr.sin6_addr), 1,
+		       "build target addr"))
+		goto close_client;
+
+	bytes = sendto(cfd, foobar, sizeof(foobar), 0,
+		       (struct sockaddr *)&server_addr, sizeof(server_addr));
+	if (!ASSERT_EQ(bytes, sizeof(foobar), "send packet"))
+		goto close_client;
+
+	/* Verify we received all expected bytes */
+	bytes = read(sfd, buf, sizeof(buf));
+	if (!ASSERT_EQ(bytes, sizeof(buf), "receive packet"))
+		goto close_client;
+	ASSERT_STREQ(buf, foobar, "check udp packet");
+
+close_client:
+	close(cfd);
+close_server:
+	close(sfd);
+close_netns:
+	close_netns(nstoken);
+
+out:
+	cleanup();
+}
diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
deleted file mode 100755
index 9c74b88730ffd98f8e988a078d218ffbcd9ee95c..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ /dev/null
@@ -1,151 +0,0 @@
-#!/bin/bash
-# Connects 6 network namespaces through veths.
-# Each NS may have different IPv6 global scope addresses :
-#   NS1 ---- NS2 ---- NS3 ---- NS4 ---- NS5 ---- NS6
-# fb00::1           fd00::1  fd00::2  fd00::3  fb00::6
-#                   fc42::1           fd00::4
-#
-# All IPv6 packets going to fb00::/16 through NS2 will be encapsulated in a
-# IPv6 header with a Segment Routing Header, with segments :
-# 	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
-#
-# 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
-# - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
-# - fd00::2 : remove the TLV, change the flags, add a tag
-# - fd00::3 : apply an End.T action to fd00::4, through routing table 117
-#
-# fd00::4 is a simple Segment Routing node decapsulating the inner IPv6 packet.
-# Each End.BPF action will validate the operations applied on the SRH by the
-# previous BPF program in the chain, otherwise the packet is dropped.
-#
-# An UDP datagram is sent from fb00::1 to fb00::6. The test succeeds if this
-# datagram can be read on NS6 when binding to fb00::6.
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-BPF_FILE="test_lwt_seg6local.bpf.o"
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-readonly NS3="ns3-$(mktemp -u XXXXXX)"
-readonly NS4="ns4-$(mktemp -u XXXXXX)"
-readonly NS5="ns5-$(mktemp -u XXXXXX)"
-readonly NS6="ns6-$(mktemp -u XXXXXX)"
-
-msg="skip all tests:"
-if [ $UID != 0 ]; then
-	echo $msg please run this as root >&2
-	exit $ksft_skip
-fi
-
-TMP_FILE="/tmp/selftest_lwt_seg6local.txt"
-
-cleanup()
-{
-	if [ "$?" = "0" ]; then
-		echo "selftests: test_lwt_seg6local [PASS]";
-	else
-		echo "selftests: test_lwt_seg6local [FAILED]";
-	fi
-
-	set +e
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-	ip netns del ${NS3} 2> /dev/null
-	ip netns del ${NS4} 2> /dev/null
-	ip netns del ${NS5} 2> /dev/null
-	ip netns del ${NS6} 2> /dev/null
-	rm -f $TMP_FILE
-}
-
-set -e
-
-ip netns add ${NS1}
-ip netns add ${NS2}
-ip netns add ${NS3}
-ip netns add ${NS4}
-ip netns add ${NS5}
-ip netns add ${NS6}
-
-trap cleanup 0 2 3 6 9
-
-ip link add veth1 type veth peer name veth2
-ip link add veth3 type veth peer name veth4
-ip link add veth5 type veth peer name veth6
-ip link add veth7 type veth peer name veth8
-ip link add veth9 type veth peer name veth10
-
-ip link set veth1 netns ${NS1}
-ip link set veth2 netns ${NS2}
-ip link set veth3 netns ${NS2}
-ip link set veth4 netns ${NS3}
-ip link set veth5 netns ${NS3}
-ip link set veth6 netns ${NS4}
-ip link set veth7 netns ${NS4}
-ip link set veth8 netns ${NS5}
-ip link set veth9 netns ${NS5}
-ip link set veth10 netns ${NS6}
-
-ip netns exec ${NS1} ip link set dev veth1 up
-ip netns exec ${NS2} ip link set dev veth2 up
-ip netns exec ${NS2} ip link set dev veth3 up
-ip netns exec ${NS3} ip link set dev veth4 up
-ip netns exec ${NS3} ip link set dev veth5 up
-ip netns exec ${NS4} ip link set dev veth6 up
-ip netns exec ${NS4} ip link set dev veth7 up
-ip netns exec ${NS5} ip link set dev veth8 up
-ip netns exec ${NS5} ip link set dev veth9 up
-ip netns exec ${NS6} ip link set dev veth10 up
-ip netns exec ${NS6} ip link set dev lo up
-
-# All link scope addresses and routes required between veths
-ip netns exec ${NS1} ip -6 addr add fb00::12/16 dev veth1 scope link
-ip netns exec ${NS2} ip -6 addr add fb00::21/16 dev veth2 scope link
-ip netns exec ${NS2} ip -6 addr add fb00::34/16 dev veth3 scope link
-ip netns exec ${NS3} ip -6 addr add fb00::43/16 dev veth4 scope link
-ip netns exec ${NS3} ip -6 addr add fb00::56/16 dev veth5 scope link
-ip netns exec ${NS4} ip -6 addr add fb00::65/16 dev veth6 scope link
-ip netns exec ${NS4} ip -6 addr add fb00::78/16 dev veth7 scope link
-ip netns exec ${NS5} ip -6 addr add fb00::87/16 dev veth8 scope link
-ip netns exec ${NS5} ip -6 addr add fb00::910/16 dev veth9 scope link
-ip netns exec ${NS5} ip -6 route add fb00::109 table 117 dev veth9 scope link
-ip netns exec ${NS6} ip -6 addr add fb00::109/16 dev veth10 scope link
-
-ip netns exec ${NS1} ip -6 addr add fb00::1/16 dev lo
-ip netns exec ${NS1} ip -6 route add fb00::6 dev veth1 via fb00::21
-
-ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj ${BPF_FILE} sec encap_srh dev veth2
-ip netns exec ${NS2} ip -6 route add fd00::1 dev veth3 via fb00::43 scope link
-
-ip netns exec ${NS3} ip -6 route add fc42::1 dev veth5 via fb00::65
-ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action End.BPF endpoint obj ${BPF_FILE} sec add_egr_x dev veth4
-
-ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action End.BPF endpoint obj ${BPF_FILE} sec pop_egr dev veth6
-ip netns exec ${NS4} ip -6 addr add fc42::1 dev lo
-ip netns exec ${NS4} ip -6 route add fd00::3 dev veth7 via fb00::87
-
-ip netns exec ${NS5} ip -6 route add fd00::4 table 117 dev veth9 via fb00::109
-ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action End.BPF endpoint obj ${BPF_FILE} sec inspect_t dev veth8
-
-ip netns exec ${NS6} ip -6 addr add fb00::6/16 dev lo
-ip netns exec ${NS6} ip -6 addr add fd00::4/16 dev lo
-
-ip netns exec ${NS1} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec ${NS2} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec ${NS3} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec ${NS4} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec ${NS5} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-
-ip netns exec ${NS6} sysctl net.ipv6.conf.all.seg6_enabled=1 > /dev/null
-ip netns exec ${NS6} sysctl net.ipv6.conf.lo.seg6_enabled=1 > /dev/null
-ip netns exec ${NS6} sysctl net.ipv6.conf.veth10.seg6_enabled=1 > /dev/null
-
-ip netns exec ${NS6} nc -l -6 -u -d 7330 > $TMP_FILE &
-ip netns exec ${NS1} bash -c "echo 'foobar' | nc -w0 -6 -u -p 2121 -s fb00::1 fb00::6 7330"
-sleep 5 # wait enough time to ensure the UDP datagram arrived to the last segment
-kill -TERM $!
-
-if [[ $(< $TMP_FILE) != "foobar" ]]; then
-	exit 1
-fi
-
-exit 0

-- 
2.48.1


