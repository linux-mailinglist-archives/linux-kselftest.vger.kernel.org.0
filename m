Return-Path: <linux-kselftest+bounces-27742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B080A47F0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6031896BB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96323237A;
	Thu, 27 Feb 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GMnwhWXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F722FF44;
	Thu, 27 Feb 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662673; cv=none; b=V2txDGwXLiMEVIZK7g+tgTEH23se3CIHGZQ0a7BD7vm3Zo5s0zr7GCWiW9IG1Pck8qUvi/J/pxHwpOfvaPqmN9RDb6opwIC/5k/O7UOxEjAV7zB1lTzx33RYPb1ur7h/KxR9pn20rRz6UEdrjnihLnXszTYtVrucXyJ92s+U1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662673; c=relaxed/simple;
	bh=fun691b6s6ufJiTHPCBsV5VOsFUGDSd0dQRyCOp+iBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/LNlmC0DTkBWJOccS+tuGMJUkX97OgEQvr0SmjyNirEi8fD6PdGul2M5WFBT5SX1hlDsSB+aFHahJ65oJIeGFKxRAw7GQmrlN/I4fCFejrJ0tQ46xv+NkXMOQsh1xI31fMHusu52AWOMid4oOdfC7RrqsmoDkbgQvn6hrSjiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GMnwhWXS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 981744427E;
	Thu, 27 Feb 2025 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aF6+u3JbgJzDL1HcGVWwYeOgFN9Yk6jgWlVmioQdIDQ=;
	b=GMnwhWXSOizU+8VDtl5I2LKlk4OHGXtAt1ANYDXHr5YxS14avc6aS8jEuBXfPKso/44DVi
	kIcLa3JJXE01giz6amwF8Aie5TuYpyZTbOklkKBbNx+Ybr05lTWbnuKXeoEpx7cJ6vXyRN
	rBam4k3AjNNQZrGSVq6WKjuNqiJGt3E6014RBQHf1Crv7MoioZsdO2tQsmCpTS6yXK7r2Z
	cuf16R/mq0XHw/IPmWQJy6xTDvS478hNW27fgMv+TnkTvtnHq+8Y/waF9i2/m1cQ3Z7xXS
	g5FnXuOEVJFqbCKxk82QfHFfDiE1OCo+1BXqql5mwZEdPdDu8ZeG6MwOQZQStg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:19 +0100
Subject: [PATCH bpf-next 04/10] selftests/bpf: test_tunnel: Move ip6gre
 tunnel test to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-4-33df5c30aa04@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhug
 idqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

ip6gre tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test ip6gre tunnels. It uses the same
network topology and the same BPF programs than the script. Disable the
IPv6 DAD feature because it can take lot of time and cause some tests to
fail depending on the environment they're run on.
Remove test_ip6gre() and test_ip6gretap() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 110 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         |  95 ------------------
 2 files changed, 110 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index bd1410b90b94773ba9bc1fa378bb7139f8d4670a..f00727aedee0c283002c55a45a04a96013d39a5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -71,6 +71,8 @@
 #define IP4_ADDR2_VETH1 "172.16.1.20"
 #define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
 #define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
+#define IP6_ADDR_TUNL_DEV0 "fc80::100"
+#define IP6_ADDR_TUNL_DEV1 "fc80::200"
 
 #define IP6_ADDR_VETH0 "::11"
 #define IP6_ADDR1_VETH1 "::22"
@@ -101,11 +103,21 @@
 #define GRE_TUNL_DEV0 "gre00"
 #define GRE_TUNL_DEV1 "gre11"
 
+#define IP6GRE_TUNL_DEV0 "ip6gre00"
+#define IP6GRE_TUNL_DEV1 "ip6gre11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
 {
 	SYS(fail, "ip netns add at_ns0");
+
+	/* disable IPv6 DAD because it might take too long and fail tests */
+	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.default.accept_dad=0");
+	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.all.accept_dad=0");
+	SYS(fail, "sysctl -wq net.ipv6.conf.default.accept_dad=0");
+	SYS(fail, "sysctl -wq net.ipv6.conf.all.accept_dad=0");
+
 	SYS(fail, "ip link add veth0 address " MAC_VETH1 " type veth peer name veth1");
 	SYS(fail, "ip link set veth0 netns at_ns0");
 	SYS(fail, "ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
@@ -396,6 +408,42 @@ static void delete_tunnel(const char *dev0, const char *dev1)
 	SYS_NOFAIL("ip link delete dev %s", dev1);
 }
 
+static int set_ipv6_addr(const char *dev0, const char *dev1)
+{
+	SYS(fail, "ip -n at_ns0 addr add %s/96 dev veth0", IP6_ADDR_VETH0);
+	SYS(fail, "ip -n at_ns0 link set dev veth0 up");
+	SYS(fail, "ip addr add %s/96 dev veth1", IP6_ADDR1_VETH1);
+	SYS(fail, "ip link set dev veth1 up");
+
+	SYS(fail, "ip -n at_ns0 addr add dev %s %s/24", dev0, IP4_ADDR_TUNL_DEV0);
+	SYS(fail, "ip -n at_ns0 addr add dev %s %s/96", dev0, IP6_ADDR_TUNL_DEV0);
+	SYS(fail, "ip -n at_ns0 link set dev %s up", dev0);
+
+	SYS(fail, "ip addr add dev %s %s/24", dev1, IP4_ADDR_TUNL_DEV1);
+	SYS(fail, "ip addr add dev %s %s/96", dev1, IP6_ADDR_TUNL_DEV1);
+	SYS(fail, "ip link set dev %s up", dev1);
+	return 0;
+fail:
+	return 1;
+}
+
+static int add_ipv6_tunnel(const char *dev0, const char *dev1,
+			   const char *type, const char *opt)
+{
+	if (!type || !opt || !dev0 || !dev1)
+		return -1;
+
+	SYS(fail, "ip -n at_ns0 link add dev %s type %s %s local %s remote %s",
+	    dev0, type, opt, IP6_ADDR_VETH0, IP6_ADDR1_VETH1);
+
+	SYS(fail, "ip link add dev %s type %s external", dev1, type);
+
+	return set_ipv6_addr(dev0, dev1);
+fail:
+	return -1;
+}
+
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -423,6 +471,24 @@ static void ping_dev1(void)
 	close_netns(nstoken);
 }
 
+static void ping6_veth0(void)
+{
+	test_ping(AF_INET6, IP6_ADDR_VETH0);
+}
+
+static void ping6_dev1(void)
+{
+	struct nstoken *nstoken;
+
+	/* ping from at_ns0 namespace test */
+	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		return;
+
+	test_ping(AF_INET, IP6_ADDR_TUNL_DEV1);
+	close_netns(nstoken);
+}
+
 static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
@@ -774,6 +840,48 @@ static void test_gre_tunnel(enum gre_test test)
 	test_tunnel_kern__destroy(skel);
 }
 
+enum ip6gre_test {
+	IP6GRE,
+	IP6GRETAP
+};
+
+static void test_ip6gre_tunnel(enum ip6gre_test test)
+{
+	struct test_tunnel_kern *skel;
+	int set_fd, get_fd;
+	int err;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		return;
+
+	switch (test) {
+	case IP6GRE:
+		err = add_ipv6_tunnel(IP6GRE_TUNL_DEV0, IP6GRE_TUNL_DEV1,
+				      "ip6gre", "flowlabel 0xbcdef key 2");
+		break;
+	case IP6GRETAP:
+		err = add_ipv6_tunnel(IP6GRE_TUNL_DEV0, IP6GRE_TUNL_DEV1,
+				      "ip6gretap", "flowlabel 0xbcdef key 2");
+		break;
+	}
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.ip6gretap_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.ip6gretap_get_tunnel);
+	if (generic_attach(IP6GRE_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping6_veth0();
+	ping6_dev1();
+	ping_dev0();
+	ping_dev1();
+done:
+	delete_tunnel(IP6GRE_TUNL_DEV0, IP6GRE_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -795,6 +903,8 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(gre_tunnel, GRE_NOKEY);
 	RUN_TEST(gre_tunnel, GRETAP);
 	RUN_TEST(gre_tunnel, GRETAP_NOKEY);
+	RUN_TEST(ip6gre_tunnel, IP6GRE);
+	RUN_TEST(ip6gre_tunnel, IP6GRETAP);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 48ac9cb2092f6aa34aa59b3b0c51465390965707..367af24d2ca5263be279a1a684daac161e7ec906 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,31 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_ip6gretap_tunnel()
-{
-
-	# assign ipv6 address
-	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE seq flowlabel 0xbcdef key 2 \
-		local ::11 remote ::22
-
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip addr add dev $DEV_NS fc80::100/96
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip addr add dev $DEV 10.1.1.200/24
-	ip addr add dev $DEV fc80::200/24
-	ip link set dev $DEV up
-}
-
 add_erspan_tunnel()
 {
 	# at_ns0 namespace
@@ -214,65 +189,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_ip6gre()
-{
-	TYPE=ip6gre
-	DEV_NS=ip6gre00
-	DEV=ip6gre11
-	ret=0
-
-	check $TYPE
-	config_device
-	# reuse the ip6gretap function
-	add_ip6gretap_tunnel
-	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
-	# underlay
-	ping6 $PING_ARG ::11
-	# overlay: ipv4 over ipv6
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
-	check_err $?
-	cleanup
-
-        if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: $TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: $TYPE"${NC}
-}
-
-test_ip6gretap()
-{
-	TYPE=ip6gretap
-	DEV_NS=ip6gretap00
-	DEV=ip6gretap11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6gretap_tunnel
-	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
-	# underlay
-	ping6 $PING_ARG ::11
-	# overlay: ipv4 over ipv6
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
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
 test_erspan()
 {
 	TYPE=erspan
@@ -470,8 +386,6 @@ cleanup()
 	ip link del ipip11 2> /dev/null
 	ip link del ipip6tnl11 2> /dev/null
 	ip link del ip6ip6tnl11 2> /dev/null
-	ip link del ip6gre11 2> /dev/null
-	ip link del ip6gretap11 2> /dev/null
 	ip link del geneve11 2> /dev/null
 	ip link del ip6geneve11 2> /dev/null
 	ip link del erspan11 2> /dev/null
@@ -497,7 +411,6 @@ check()
 
 enable_debug()
 {
-	echo 'file ip6_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file geneve.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
 }
@@ -513,14 +426,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing IP6GRE tunnel..."
-	test_ip6gre
-	errors=$(( $errors + $? ))
-
-	echo "Testing IP6GRETAP tunnel..."
-	test_ip6gretap
-	errors=$(( $errors + $? ))
-
 	echo "Testing ERSPAN tunnel..."
 	test_erspan v2
 	errors=$(( $errors + $? ))

-- 
2.48.1


