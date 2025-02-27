Return-Path: <linux-kselftest+bounces-27746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B7A47F26
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52B4178EF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0212356C9;
	Thu, 27 Feb 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nTWPSL5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFFB233D72;
	Thu, 27 Feb 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662678; cv=none; b=SaFeYHU+ikUFGCGu7mSOhkgickiNH2coi8fGrhYrNUQ/NRqiz3rK0Bca43WmIU4kcHmEG0oYACMAi1O+IzXnU6YTK1n6GWQozYiQB3oifrhjd0sDMiAmrM+DxUakztQgLhnxPOg//0BEWSn6ympiYUlwrp4wPfOr4yVPwOqVZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662678; c=relaxed/simple;
	bh=VfMs72jz+lndoj14ciu3T3C0409yv4JP7HRYErXqcgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZCzlZrkdjL+Zr2pHVDjowgUZEfADwZRU0qhPmJcA1ZP+KQ0RlCge3YkcU4D5ZQcq6YjbOsxwYy1HJUyNzV6JfcRi2lqmt2WX8EnMCrozZcBxv7IJMta2YogetCnngsI0TabFxVPXXciwxaUuHSD9yJ+GzLWvNat8crseSUunWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nTWPSL5r; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0DCE44280;
	Thu, 27 Feb 2025 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdgUzjI6HtyqMy1x5tEldnjIad0opXkeFjRCBok/HGE=;
	b=nTWPSL5rTUWAjrpkcBsvYz8lXwfRfNeFZ+mhILqClgmmVAKSWhVvZpAzJNrAL65vX9/sm0
	6Hr5Y8J+MB/qgls/8eI8I6leSV5is86yJX2AR1AuuQ40PHEVasaU7mkfBCB4HO72ERFRT3
	PQfxh5QXBp02ewAzGTaCyC3BWYE/fNXN7HPGfj+GpX8DOHlOAKJAKNEZ4oMI0b1n1SQzZK
	37z1T4ywSyW4foeAk5geWoD0G1m18jqQ8X/z3ORVNKPX+mi8TscWVP/yG41oYfGQ4vjxaK
	IG0LAyWnNge0MZR80rvYUkbJFs0XK8SE8slFBBXstd1F4vPJGeSycHB9gZ+GqA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:23 +0100
Subject: [PATCH bpf-next 08/10] selftests/bpf: test_tunnel: Move ip6geneve
 tunnel test to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-8-33df5c30aa04@bootlin.com>
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

ip6geneve tunnels are tested in the test_tunnel.sh but not in the
test_progs framework.

Add a new test in test_progs to test ip6geneve tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_ip6geneve() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 48 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 49 ----------------------
 2 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 37676cc376dc4c1c92f8c54d3fe8e983c2ee2224..4ca9b924efc9d47333db5faf0365add3020a91c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -115,6 +115,9 @@
 #define GENEVE_TUNL_DEV0 "geneve00"
 #define GENEVE_TUNL_DEV1 "geneve11"
 
+#define IP6GENEVE_TUNL_DEV0 "ip6geneve00"
+#define IP6GENEVE_TUNL_DEV1 "ip6geneve11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -468,6 +471,22 @@ static int add_geneve_tunnel(const char *dev0, const char *dev1,
 	return -1;
 }
 
+static int add_ip6geneve_tunnel(const char *dev0, const char *dev1,
+			     const char *type, const char *opt)
+{
+	if (!type || !opt || !dev0 || !dev1)
+		return -1;
+
+	SYS(fail, "ip -n at_ns0 link add dev %s type %s id 22 %s remote %s",
+	    dev0, type, opt, IP6_ADDR1_VETH1);
+
+	SYS(fail, "ip link add dev %s type %s %s external", dev1, type, opt);
+
+	return set_ipv6_addr(dev0, dev1);
+fail:
+	return -1;
+}
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -1009,6 +1028,34 @@ static void test_geneve_tunnel(void)
 	delete_tunnel(GENEVE_TUNL_DEV0, GENEVE_TUNL_DEV1);
 	test_tunnel_kern__destroy(skel);
 }
+
+static void test_ip6geneve_tunnel(void)
+{
+	struct test_tunnel_kern *skel;
+	int set_fd, get_fd;
+	int err;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		return;
+
+	err = add_ip6geneve_tunnel(IP6GENEVE_TUNL_DEV0, IP6GENEVE_TUNL_DEV1,
+				   "geneve", "");
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.ip6geneve_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.ip6geneve_get_tunnel);
+	if (generic_attach(IP6GENEVE_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping_dev0();
+	ping_dev1();
+done:
+	delete_tunnel(IP6GENEVE_TUNL_DEV0, IP6GENEVE_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -1037,6 +1084,7 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ip6erspan_tunnel, V1);
 	RUN_TEST(ip6erspan_tunnel, V2);
 	RUN_TEST(geneve_tunnel);
+	RUN_TEST(ip6geneve_tunnel);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 7f2b1c846a72f07f578afbc9b4bb9882cabc838b..f46628f70399e2a049859709e9db9e8419e74770 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,26 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_ip6geneve_tunnel()
-{
-	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE id 22 \
-		remote ::22     # geneve has no local option
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip addr add dev $DEV 10.1.1.200/24
-	ip link set dev $DEV up
-}
-
 add_ipip_tunnel()
 {
 	# at_ns0 namespace
@@ -121,30 +101,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_ip6geneve()
-{
-	TYPE=geneve
-	DEV_NS=ip6geneve00
-	DEV=ip6geneve11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6geneve_tunnel
-	attach_bpf $DEV ip6geneve_set_tunnel ip6geneve_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
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
 test_ipip()
 {
 	TYPE=ipip
@@ -247,7 +203,6 @@ cleanup()
 	ip link del ipip11 2> /dev/null
 	ip link del ipip6tnl11 2> /dev/null
 	ip link del ip6ip6tnl11 2> /dev/null
-	ip link del ip6geneve11 2> /dev/null
 }
 
 cleanup_exit()
@@ -283,10 +238,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing IP6GENEVE tunnel..."
-	test_ip6geneve
-	errors=$(( $errors + $? ))
-
 	echo "Testing IPIP tunnel..."
 	test_ipip
 	errors=$(( $errors + $? ))

-- 
2.48.1


