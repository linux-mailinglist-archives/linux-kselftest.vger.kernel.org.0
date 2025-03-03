Return-Path: <linux-kselftest+bounces-28007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892AA4B90E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E01A18911D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADD1EF38A;
	Mon,  3 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZKs/LwAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C11E1A31;
	Mon,  3 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990179; cv=none; b=SvBO03R83FISriQYYu3p0qm/j5GvCRRqiZ8YfDA8kn/6RuxiMgK00RuFLfUyHT+MzSp2om/j7uwcJVjzcbFzR6OCqLW5hda/mN/EHfRLLiz41lqYFZ5i+Fn/BeGkti5XgZst1MhLjfvQ08btpmQAVe6c9E13Wx8sLtNhV/Bek3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990179; c=relaxed/simple;
	bh=SlnvAOHpi/pigx7YABM7JMAnlE//LI35JeQHXO5R1kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1Wmyf/vPG/Jh70+94pK2F+cNkOmlfLHfBs6K2II8UxGTFx/np8IJo/BtYCfSLrxiPK1CHgtdJsYh64ga3mGAGwMVHNE/6yCuA1a7LGMcX2TIty8CxZArUMKJhkx8JTet7AV6Lc2jCqUcgQoe+0cKrYisorEoIxzF7KCZIUmW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZKs/LwAl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E10F644356;
	Mon,  3 Mar 2025 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YIngI9G2c/hKVLTMkw3ZOdP1a1zwEvSGl7sOER1cJU=;
	b=ZKs/LwAl76Ug7dNzvHDU1KU5wzAlrbaretyVZ7AZzi7Oh1qFr8EScd531iCrWa1bpOqXW+
	D/PEi1kgSg64bKkW/JQTNdSYyQ3g2FNM21h6deLfA25DJkzt6iY8CNZLU6AyhmSdgU2YGj
	IIF64OsMaUFjp6gxR83oPQYszXFZ7sCd21PtqWdhBJ3/srj28BE9L2nhQeCQe/Iiq4Rx23
	YeWNZLSt4tYFf+XtgH/QlwW+grlj2BXNboWJeN1RaGhW++Is4LSNcxbhqGLN9b82qw2bUD
	6zVi5Z4IDg7hwkDUhfJtlHYCAqWNU8oZxkkfjHm0iweZRjqguEQuNUpb16aN5w==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:51 +0100
Subject: [PATCH bpf-next v2 03/10] selftests/bpf: test_tunnel: Move gre
 tunnel test to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-3-8329f38f0678@bootlin.com>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
In-Reply-To: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmr
 ghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

gre tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test gre tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_gre() and test_gre_no_tunnel_key() from the script.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 97 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 79 ------------------
 2 files changed, 97 insertions(+), 79 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 09e674c147bb31e239476b66eb5f57fc2b447cd9..79b0b1cd85657fa509dd297410de7dd3b4203a90 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -98,6 +98,9 @@
 #define XFRM_SPI_IN_TO_OUT 0x1
 #define XFRM_SPI_OUT_TO_IN 0x2
 
+#define GRE_TUNL_DEV0 "gre00"
+#define GRE_TUNL_DEV1 "gre11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -216,6 +219,18 @@ static int set_ipip_encap(const char *ipproto, const char *type)
 	return -1;
 }
 
+static int set_ipv4_addr(const char *dev0, const char *dev1)
+{
+	SYS(fail, "ip -n at_ns0 link set dev %s up", dev0);
+	SYS(fail, "ip -n at_ns0 addr add dev %s %s/24", dev0, IP4_ADDR_TUNL_DEV0);
+	SYS(fail, "ip link set dev %s up", dev1);
+	SYS(fail, "ip addr add dev %s %s/24", dev1, IP4_ADDR_TUNL_DEV1);
+
+	return 0;
+fail:
+	return 1;
+}
+
 static int add_ipip_tunnel(enum ipip_encap encap)
 {
 	int err;
@@ -356,6 +371,31 @@ static void delete_xfrm_tunnel(void)
 		   IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN);
 }
 
+static int add_ipv4_tunnel(const char *dev0, const char *dev1,
+			   const char *type, const char *opt)
+{
+	if (!type || !opt || !dev0 || !dev1)
+		return -1;
+
+	SYS(fail, "ip -n at_ns0 link add dev %s type %s %s local %s remote %s",
+	    dev0, type, opt, IP4_ADDR_VETH0, IP4_ADDR1_VETH1);
+
+	SYS(fail, "ip link add dev %s type %s external", dev1, type);
+
+	return set_ipv4_addr(dev0, dev1);
+fail:
+	return -1;
+}
+
+static void delete_tunnel(const char *dev0, const char *dev1)
+{
+	if (!dev0 || !dev1)
+		return;
+
+	SYS_NOFAIL("ip netns exec at_ns0 ip link delete dev %s", dev0);
+	SYS_NOFAIL("ip link delete dev %s", dev1);
+}
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -677,6 +717,59 @@ static void test_xfrm_tunnel(void)
 		test_tunnel_kern__destroy(skel);
 }
 
+enum gre_test {
+	GRE,
+	GRE_NOKEY,
+	GRETAP,
+	GRETAP_NOKEY,
+};
+
+static void test_gre_tunnel(enum gre_test test)
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
+	case GRE:
+		err = add_ipv4_tunnel(GRE_TUNL_DEV0, GRE_TUNL_DEV1, "gre", "seq");
+		set_fd = bpf_program__fd(skel->progs.gre_set_tunnel_no_key);
+		get_fd = bpf_program__fd(skel->progs.gre_get_tunnel);
+		break;
+	case GRE_NOKEY:
+		err = add_ipv4_tunnel(GRE_TUNL_DEV0, GRE_TUNL_DEV1, "gre", "seq key 2");
+		set_fd = bpf_program__fd(skel->progs.gre_set_tunnel);
+		get_fd = bpf_program__fd(skel->progs.gre_get_tunnel);
+		break;
+	case GRETAP:
+		err = add_ipv4_tunnel(GRE_TUNL_DEV0, GRE_TUNL_DEV1, "gretap", "seq");
+		set_fd = bpf_program__fd(skel->progs.gre_set_tunnel_no_key);
+		get_fd = bpf_program__fd(skel->progs.gre_get_tunnel);
+		break;
+	case GRETAP_NOKEY:
+		err = add_ipv4_tunnel(GRE_TUNL_DEV0, GRE_TUNL_DEV1, "gretap", "seq key 2");
+		set_fd = bpf_program__fd(skel->progs.gre_set_tunnel);
+		get_fd = bpf_program__fd(skel->progs.gre_get_tunnel);
+		break;
+	}
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	if (generic_attach(GRE_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping_dev0();
+	ping_dev1();
+
+done:
+	delete_tunnel(GRE_TUNL_DEV0, GRE_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -694,6 +787,10 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ipip_tunnel, FOU);
 	RUN_TEST(ipip_tunnel, GUE);
 	RUN_TEST(xfrm_tunnel);
+	RUN_TEST(gre_tunnel, GRE);
+	RUN_TEST(gre_tunnel, GRE_NOKEY);
+	RUN_TEST(gre_tunnel, GRETAP);
+	RUN_TEST(gre_tunnel, GRETAP_NOKEY);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index d9661b9988ba907e023ef9bc58d96a0155f58326..48ac9cb2092f6aa34aa59b3b0c51465390965707 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,26 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_gre_tunnel()
-{
-	tun_key=
-	if [ -n "$1" ]; then
-		tun_key="key $1"
-	fi
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-        ip link add dev $DEV_NS type $TYPE seq $tun_key \
-		local 172.16.1.100 remote 172.16.1.200
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-
-	# root namespace
-	ip link add dev $DEV type $TYPE $tun_key external
-	ip link set dev $DEV up
-	ip addr add dev $DEV 10.1.1.200/24
-}
-
 add_ip6gretap_tunnel()
 {
 
@@ -234,54 +214,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_gre()
-{
-	TYPE=gretap
-	DEV_NS=gretap00
-	DEV=gretap11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_gre_tunnel 2
-	attach_bpf $DEV gre_set_tunnel gre_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
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
-test_gre_no_tunnel_key()
-{
-	TYPE=gre
-	DEV_NS=gre00
-	DEV=gre11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_gre_tunnel
-	attach_bpf $DEV gre_set_tunnel_no_key gre_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
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
 test_ip6gre()
 {
 	TYPE=ip6gre
@@ -538,8 +470,6 @@ cleanup()
 	ip link del ipip11 2> /dev/null
 	ip link del ipip6tnl11 2> /dev/null
 	ip link del ip6ip6tnl11 2> /dev/null
-	ip link del gretap11 2> /dev/null
-	ip link del gre11 2> /dev/null
 	ip link del ip6gre11 2> /dev/null
 	ip link del ip6gretap11 2> /dev/null
 	ip link del geneve11 2> /dev/null
@@ -567,7 +497,6 @@ check()
 
 enable_debug()
 {
-	echo 'file ip_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ip6_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file geneve.c +p' > /sys/kernel/debug/dynamic_debug/control
 	echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
@@ -584,14 +513,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing GRE tunnel..."
-	test_gre
-	errors=$(( $errors + $? ))
-
-	echo "Testing GRE tunnel (without tunnel keys)..."
-	test_gre_no_tunnel_key
-	errors=$(( $errors + $? ))
-
 	echo "Testing IP6GRE tunnel..."
 	test_ip6gre
 	errors=$(( $errors + $? ))

-- 
2.48.1


