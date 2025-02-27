Return-Path: <linux-kselftest+bounces-27745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E147A47F23
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06626177BE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAF23537A;
	Thu, 27 Feb 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b0GmJKgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B6233129;
	Thu, 27 Feb 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662677; cv=none; b=rkJQJsOl8SI8uztudP6wJeSP/PtbDQs/WfLJHel2CKh+WZy+xvlrGTvOnRZcXrDKzavvwrXOCsTi2vezB1W4/E4NvzC0vMBEdobuhjhWZ0D3EMEJEbSvjApgKaoqO6xOcwS34sogO9kZ08LGxr4oWsSwNGsaM4669GP8O+amSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662677; c=relaxed/simple;
	bh=lP41jtKDmAwijKK8f1ZRJNOBkMIqet65hr9Uh11RAsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWROUXfx2ngq/i9vENM75nRx2y0A6S4MEIBIljejAv1uh1X6hAnhPlXW83NakYA21ZD8nGZVoDpew7t+Zf0JWp/gXlUVbDZIrqMccuH0UKN9xJjX4HUYtmxFfCmPP5YeQl8cQ60/hU7V+Tzs5SnEja8LJUHrC3Nq95GuuM6N/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b0GmJKgN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBE5244278;
	Thu, 27 Feb 2025 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GELwYm3BI/uedX60oz19D7S0BOcSFqrHFGg4UlBLQw=;
	b=b0GmJKgN1yY1IsuS1Kjw4SJISALeEACwFSibAiW5LDcBd7oVpRXP3MBctL54ti/Hf5ntzv
	F2hKSg1t7rRSOgwUt1WYrwUQM+ZTQhrWnpl4KzjSajOL3dHDpqpJ7euGHfkMVncXmWBSeE
	FZKRFPCcZc+lHJDO+7tNJNaD3Mg2yAWMmKMuqP8sQoHeyBXT9xFy4SFhJ5dwBve5j+7tOq
	88SbMjtb4wfVS5+9MhMPi0jNnpesWmHHmju8uVdToFPhcV8HgDDVuPwXSbmHfrhCMN6Az5
	jzAtzto5GQbtf7GJ+OIkFw/xQ69Nj11LuscLqTRuuVF6bpWw8TpzXntCkX0iew==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:22 +0100
Subject: [PATCH bpf-next 07/10] selftests/bpf: test_tunnel: Move geneve
 tunnel test to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-7-33df5c30aa04@bootlin.com>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
In-Reply-To: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhug
 idqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

geneve tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test geneve tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_geneve() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 45 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 45 ----------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cec0b71b5bdd6d88e7b41b99de081b5370896188..37676cc376dc4c1c92f8c54d3fe8e983c2ee2224 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -112,6 +112,9 @@
 #define IP6ERSPAN_TUNL_DEV0 "ip6erspan00"
 #define IP6ERSPAN_TUNL_DEV1 "ip6erspan11"
 
+#define GENEVE_TUNL_DEV0 "geneve00"
+#define GENEVE_TUNL_DEV1 "geneve11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -449,6 +452,21 @@ static int add_ipv6_tunnel(const char *dev0, const char *dev1,
 	return -1;
 }
 
+static int add_geneve_tunnel(const char *dev0, const char *dev1,
+			     const char *type, const char *opt)
+{
+	if (!type || !opt || !dev0 || !dev1)
+		return -1;
+
+	SYS(fail, "ip -n at_ns0 link add dev %s type %s id 2 %s remote %s",
+	    dev0, type, opt, IP4_ADDR1_VETH1);
+
+	SYS(fail, "ip link add dev %s type %s %s external", dev1, type, opt);
+
+	return set_ipv4_addr(dev0, dev1);
+fail:
+	return -1;
+}
 
 static int test_ping(int family, const char *addr)
 {
@@ -965,6 +983,32 @@ static void test_ip6erspan_tunnel(enum erspan_test test)
 	test_tunnel_kern__destroy(skel);
 }
 
+static void test_geneve_tunnel(void)
+{
+	struct test_tunnel_kern *skel;
+	int set_fd, get_fd;
+	int err;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		return;
+
+	err = add_geneve_tunnel(GENEVE_TUNL_DEV0, GENEVE_TUNL_DEV1,
+				"geneve", "dstport 6081");
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.geneve_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.geneve_get_tunnel);
+	if (generic_attach(GENEVE_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping_dev0();
+	ping_dev1();
+done:
+	delete_tunnel(GENEVE_TUNL_DEV0, GENEVE_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -992,6 +1036,7 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(erspan_tunnel, V2);
 	RUN_TEST(ip6erspan_tunnel, V1);
 	RUN_TEST(ip6erspan_tunnel, V2);
+	RUN_TEST(geneve_tunnel);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2b486df9724ddfe2fde4e9695274cc8ab0b036d4..7f2b1c846a72f07f578afbc9b4bb9882cabc838b 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,21 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_geneve_tunnel()
-{
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE \
-		id 2 dstport 6081 remote 172.16.1.200
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-
-	# root namespace
-	ip link add dev $DEV type $TYPE dstport 6081 external
-	ip link set dev $DEV up
-	ip addr add dev $DEV 10.1.1.200/24
-}
-
 add_ip6geneve_tunnel()
 {
 	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
@@ -136,30 +121,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_geneve()
-{
-	TYPE=geneve
-	DEV_NS=geneve00
-	DEV=geneve11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_geneve_tunnel
-	attach_bpf $DEV geneve_set_tunnel geneve_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: $TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: $TYPE"${NC}
-}
-
 test_ip6geneve()
 {
 	TYPE=geneve
@@ -286,7 +247,6 @@ cleanup()
 	ip link del ipip11 2> /dev/null
 	ip link del ipip6tnl11 2> /dev/null
 	ip link del ip6ip6tnl11 2> /dev/null
-	ip link del geneve11 2> /dev/null
 	ip link del ip6geneve11 2> /dev/null
 }
 
@@ -309,7 +269,6 @@ check()
 
 enable_debug()
 {
-	echo 'file geneve.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
 }
 
@@ -324,10 +283,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing GENEVE tunnel..."
-	test_geneve
-	errors=$(( $errors + $? ))
-
 	echo "Testing IP6GENEVE tunnel..."
 	test_ip6geneve
 	errors=$(( $errors + $? ))

-- 
2.48.1


