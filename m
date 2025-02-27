Return-Path: <linux-kselftest+bounces-27743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF9A47F0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37351897199
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877923314A;
	Thu, 27 Feb 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FKZVjrg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D022309AE;
	Thu, 27 Feb 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662674; cv=none; b=JO/expFrcNjWdiV0hR1O4GuXHYVaThioPoxZ/W/gjPZGM7eHE6fAZy5/Cc3AW8s+3Tp8r9dtMcWV8GcNEDwOyHC2gOgyyb1IaH7/75RtngNjCODZrz1MQGoP3mtVFGvOC9tFI1DLIe099Lcc8dsEgk7t+uP2sORPGLyi7pIHYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662674; c=relaxed/simple;
	bh=lsmfy0DK3fwMnbWk1es4mDbn1HYFuNXN3xmZ968tnjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqIkN1P/AEBkaRxw/sWBf3nsUc6RHnbocx8r7KSaeUoEB75xAbx2m+kUln1882J8YdfWKk9CW9twe+UkTR9ZzHN7rGEEEr+mxm4l8bRyeBVitOkl6PmdGFisRu7oEGAXEX2ZRQSLqenxfOqHTicmRTQtEO9JANW/ORUKWUcOJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FKZVjrg8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B56F14424D;
	Thu, 27 Feb 2025 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTJ2oNGe9xIEKrRJW6js+4c5cnKhuCMR5inXfvNyOCE=;
	b=FKZVjrg8j+aEkmA35iPi9yzkCRUHC2oG6A+RqXPkEfp4V5T4ckn/UMENBndO+lfaMUqohv
	RGh0iJ7fn5oK5vB+4oowdKvQTY/g5VGCOcfsDaGDXv4bfUzug/Cu/HM8x4akF8gNmhbUAO
	1OQias1Ow9qZBdHgM/dh5XXBXQaiwB4tjCM0+Q832Kzhph+Oe2oGG+IvgB5+AoSKFrvZ64
	tGAz+T5HVjzdffJ5ieoWNpt0VQMPniDg521iO1wG4+dEDHGMj0fkSXqALVYT5hw+HKtI31
	jXhxW959NFYWhStzUzumZLun4ReIEah9BYOSMyQ35m/WJ5Eq/r+5cIZv/NvKAg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:20 +0100
Subject: [PATCH bpf-next 05/10] selftests/bpf: test_tunnel: Move erspan
 tunnel tests to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-5-33df5c30aa04@bootlin.com>
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

erspan tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test erspan tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_erspan() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 46 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 52 ----------------------
 2 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index f00727aedee0c283002c55a45a04a96013d39a5d..c45170dc55dd93cdf613cc5798b7df78e3080661 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -106,6 +106,9 @@
 #define IP6GRE_TUNL_DEV0 "ip6gre00"
 #define IP6GRE_TUNL_DEV1 "ip6gre11"
 
+#define ERSPAN_TUNL_DEV0 "erspan00"
+#define ERSPAN_TUNL_DEV1 "erspan11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -882,6 +885,47 @@ static void test_ip6gre_tunnel(enum ip6gre_test test)
 	test_tunnel_kern__destroy(skel);
 }
 
+enum erspan_test {
+	V1,
+	V2
+};
+
+static void test_erspan_tunnel(enum erspan_test test)
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
+	case V1:
+		err = add_ipv4_tunnel(ERSPAN_TUNL_DEV0, ERSPAN_TUNL_DEV1,
+				      "erspan", "seq key 2 erspan_ver 1 erspan 123");
+		break;
+	case V2:
+		err = add_ipv4_tunnel(ERSPAN_TUNL_DEV0, ERSPAN_TUNL_DEV1,
+				      "erspan",
+				      "seq key 2 erspan_ver 2 erspan_dir egress erspan_hwid 3");
+		break;
+	}
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.erspan_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.erspan_get_tunnel);
+	if (generic_attach(ERSPAN_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping_dev0();
+	ping_dev1();
+done:
+	delete_tunnel(ERSPAN_TUNL_DEV0, ERSPAN_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -905,6 +949,8 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(gre_tunnel, GRETAP_NOKEY);
 	RUN_TEST(ip6gre_tunnel, IP6GRE);
 	RUN_TEST(ip6gre_tunnel, IP6GRETAP);
+	RUN_TEST(erspan_tunnel, V1);
+	RUN_TEST(erspan_tunnel, V2);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 367af24d2ca5263be279a1a684daac161e7ec906..e8e7839fb5b5f69a50a6f1fcd606d1cb6dee3c64 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,29 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_erspan_tunnel()
-{
-	# at_ns0 namespace
-	if [ "$1" == "v1" ]; then
-		ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE seq key 2 \
-		local 172.16.1.100 remote 172.16.1.200 \
-		erspan_ver 1 erspan 123
-	else
-		ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE seq key 2 \
-		local 172.16.1.100 remote 172.16.1.200 \
-		erspan_ver 2 erspan_dir egress erspan_hwid 3
-	fi
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip link set dev $DEV up
-	ip addr add dev $DEV 10.1.1.200/24
-}
-
 add_ip6erspan_tunnel()
 {
 
@@ -189,30 +166,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_erspan()
-{
-	TYPE=erspan
-	DEV_NS=erspan00
-	DEV=erspan11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_erspan_tunnel $1
-	attach_bpf $DEV erspan_set_tunnel erspan_get_tunnel
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
 test_ip6erspan()
 {
 	TYPE=ip6erspan
@@ -388,7 +341,6 @@ cleanup()
 	ip link del ip6ip6tnl11 2> /dev/null
 	ip link del geneve11 2> /dev/null
 	ip link del ip6geneve11 2> /dev/null
-	ip link del erspan11 2> /dev/null
 	ip link del ip6erspan11 2> /dev/null
 }
 
@@ -426,10 +378,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing ERSPAN tunnel..."
-	test_erspan v2
-	errors=$(( $errors + $? ))
-
 	echo "Testing IP6ERSPAN tunnel..."
 	test_ip6erspan v2
 	errors=$(( $errors + $? ))

-- 
2.48.1


