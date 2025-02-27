Return-Path: <linux-kselftest+bounces-27747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD2A47F29
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45A1179EB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270B236426;
	Thu, 27 Feb 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H2m+s8U/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553823534E;
	Thu, 27 Feb 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662679; cv=none; b=Y5g1DoUT0wgj4OW6cU3F/gbzNVp3wYSnijdLrhj7fmpNR6cEgrvMMezsuUoz+LWqoddYs6PyxDAPbJIIig/tAFTcoO9K2CoJSIAn3qP+M6HO2etaCy5lIZ4yJDxdyn4B6+2Q17vm9ilzP0HVVnMXsPuPp4v2bXY36j0AHkoxpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662679; c=relaxed/simple;
	bh=DKsZuYXp7a2xCI0r0gWGgV3mgdjInYJgdmrS8IHqegk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9w36PunGhWp3qEKNR21HBnGnF2qs4Ceox300C1XXx5mBNh8doA/bDMxYA7UgKFubaljcHPAbzCW7l7fTr1VGSOJvyrFz/l98bty2/OCDDRVFUFBpI1m8wa040GhXHUxH4f52fTTghBjU1/gK50oCa7oqJUcTuZuB+bYa64MdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H2m+s8U/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E11843275;
	Thu, 27 Feb 2025 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmimUjnkrjgcN898sZOmnF1OBITlRE4MUHnunjSzmr8=;
	b=H2m+s8U/qRkc4dQFFDm1qDY3Gc+6R3ns0/kUYCk7/S4sMPPqUYj7I5lK14z/nKjZA/LGKO
	kWnXtWfvNHrmGVVhHT33cx5XBPs2j4LHVkc6I/Ohwtjcl7QZNJhaTELCXBXrwPeWtrumKS
	xhCHqzI4B9aIhNpzHjMGtOFbYyPPKGq0Pzx1p4I5ALoeGZmvwU+6lmi+aqadfmK/biXRk9
	yEJn/sH1COx2k7BWhj/zHkPbXB5SvaYrOJh8+S8qqVdAigqeUmgdwgEkQA8tssylQB7Mvm
	Erf4F18xlRL//rEZTkAuIvVDB28J0v4sCFCSxtmWGm1wD0XbCscc5oJGlQmDrw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:24 +0100
Subject: [PATCH bpf-next 09/10] selftests/bpf: test_tunnel: Move ip6tnl
 tunnel tests to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-9-33df5c30aa04@bootlin.com>
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

ip6tnl tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test ip6tnl tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_ipip6() and test_ip6ip6() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 59 +++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 88 ----------------------
 2 files changed, 59 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 4ca9b924efc9d47333db5faf0365add3020a91c4..2882f6329c3e300c849c771c92edc50d3eaa9bb8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -118,6 +118,9 @@
 #define IP6GENEVE_TUNL_DEV0 "ip6geneve00"
 #define IP6GENEVE_TUNL_DEV1 "ip6geneve11"
 
+#define IP6TNL_TUNL_DEV0 "ip6tnl00"
+#define IP6TNL_TUNL_DEV1 "ip6tnl11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -519,6 +522,11 @@ static void ping6_veth0(void)
 	test_ping(AF_INET6, IP6_ADDR_VETH0);
 }
 
+static void ping6_dev0(void)
+{
+	test_ping(AF_INET6, IP6_ADDR_TUNL_DEV0);
+}
+
 static void ping6_dev1(void)
 {
 	struct nstoken *nstoken;
@@ -1056,6 +1064,55 @@ static void test_ip6geneve_tunnel(void)
 	test_tunnel_kern__destroy(skel);
 }
 
+enum ip6tnl_test {
+	IPIP6,
+	IP6IP6
+};
+
+static void test_ip6tnl_tunnel(enum ip6tnl_test test)
+{
+	struct test_tunnel_kern *skel;
+	int set_fd, get_fd;
+	int err;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		return;
+
+	err = add_ipv6_tunnel(IP6TNL_TUNL_DEV0, IP6TNL_TUNL_DEV1, "ip6tnl", "");
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	switch (test) {
+	case IPIP6:
+		set_fd = bpf_program__fd(skel->progs.ipip6_set_tunnel);
+		get_fd = bpf_program__fd(skel->progs.ipip6_get_tunnel);
+		break;
+	case IP6IP6:
+		set_fd = bpf_program__fd(skel->progs.ip6ip6_set_tunnel);
+		get_fd = bpf_program__fd(skel->progs.ip6ip6_get_tunnel);
+		break;
+	}
+	if (generic_attach(IP6TNL_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping6_veth0();
+	switch (test) {
+	case IPIP6:
+		ping_dev0();
+		ping_dev1();
+		break;
+	case IP6IP6:
+		ping6_dev0();
+		ping6_dev1();
+		break;
+	}
+
+done:
+	delete_tunnel(IP6TNL_TUNL_DEV0, IP6TNL_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -1085,6 +1142,8 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ip6erspan_tunnel, V2);
 	RUN_TEST(geneve_tunnel);
 	RUN_TEST(ip6geneve_tunnel);
+	RUN_TEST(ip6tnl_tunnel, IPIP6);
+	RUN_TEST(ip6tnl_tunnel, IP6IP6);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index f46628f70399e2a049859709e9db9e8419e74770..165023d1b5f70fd48ff05f0a53a332ef50e175da 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -79,28 +79,6 @@ add_ipip_tunnel()
 	ip addr add dev $DEV 10.1.1.200/24
 }
 
-add_ip6tnl_tunnel()
-{
-	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE \
-		local ::11 remote ::22
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 1::11/96
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip addr add dev $DEV 10.1.1.200/24
-	ip addr add dev $DEV 1::22/96
-	ip link set dev $DEV up
-}
-
 test_ipip()
 {
 	TYPE=ipip
@@ -126,62 +104,6 @@ test_ipip()
         echo -e ${GREEN}"PASS: $TYPE"${NC}
 }
 
-test_ipip6()
-{
-	TYPE=ip6tnl
-	DEV_NS=ipip6tnl00
-	DEV=ipip6tnl11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6tnl_tunnel
-	ip link set dev veth1 mtu 1500
-	attach_bpf $DEV ipip6_set_tunnel ipip6_get_tunnel
-	# underlay
-	ping6 $PING_ARG ::11
-	# ip4 over ip6
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
-test_ip6ip6()
-{
-	TYPE=ip6tnl
-	DEV_NS=ip6ip6tnl00
-	DEV=ip6ip6tnl11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6tnl_tunnel
-	ip link set dev veth1 mtu 1500
-	attach_bpf $DEV ip6ip6_set_tunnel ip6ip6_get_tunnel
-	# underlay
-	ping6 $PING_ARG ::11
-	# ip6 over ip6
-	ping6 $PING_ARG 1::11
-	check_err $?
-	ip netns exec at_ns0 ping6 $PING_ARG 1::22
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
-}
-
 attach_bpf()
 {
 	DEV=$1
@@ -201,8 +123,6 @@ cleanup()
 	ip netns delete at_ns0 2> /dev/null
 	ip link del veth1 2> /dev/null
 	ip link del ipip11 2> /dev/null
-	ip link del ipip6tnl11 2> /dev/null
-	ip link del ip6ip6tnl11 2> /dev/null
 }
 
 cleanup_exit()
@@ -242,14 +162,6 @@ bpf_tunnel_test()
 	test_ipip
 	errors=$(( $errors + $? ))
 
-	echo "Testing IPIP6 tunnel..."
-	test_ipip6
-	errors=$(( $errors + $? ))
-
-	echo "Testing IP6IP6 tunnel..."
-	test_ip6ip6
-	errors=$(( $errors + $? ))
-
 	return $errors
 }
 

-- 
2.48.1


