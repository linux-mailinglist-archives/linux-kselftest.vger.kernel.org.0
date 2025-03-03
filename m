Return-Path: <linux-kselftest+bounces-28010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAAA4B919
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B263AFEEA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F821F03E8;
	Mon,  3 Mar 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lfTKEu23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73ED1EFF83;
	Mon,  3 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990182; cv=none; b=rz3pX5+WTRpKKKy6l4hPBWMJs06j1Gr+jm4RhyaDwFE8WJQLs6F4v76OTulHbpsMhCHZTrLDA6FO6rJHz7G/lFWm3PmQ35Zns/ObUCSL83kNLu+FSpC1NsrKS4dnlT4MOU4VId4dX9fa2mqBWDPKPhPihnXYYsGBjXI3yoSW5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990182; c=relaxed/simple;
	bh=mNZmvHiQVgpqsRhlr2oWqW51B9Qhvo3sEx9KtUAxACI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCHV1BuHLKXNzDuZ0JclcE/K49HXgWWL9PFEEz5GJyMibFQoe9upbei+O8Q6CcOIwPAKeK+JLqgiqsjmKsQDS/yjNULQuOo8RUISzLf4Vo/U1owYQCqnSWDe9og8/UAprBZcFVbreM5QcAGCtQfYSidIT/ZD57XG72kZdTVNmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lfTKEu23; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BEAD44365;
	Mon,  3 Mar 2025 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCjIorC1lkAH/+AINecvErMn23JWKvUF0UnzIAbYlt4=;
	b=lfTKEu23ybo3n0ZfTz48wfGHlKcwJyc67DJv/RZpwMlWu/xFhoVCdydqrdlnrgHDCE6f0M
	DSP8XSHKAW2ZyV5oG9Hqqz5Z2FxfmjFn1oDmwdY/cE2ROdAVnguaaT7LOCET0WuBO+3aOn
	Soq3B8FgwP41kzntL9imA5LEt2Be6g7gQVei5QFUxIYJWvWmRw9/rB+temetz7vtn/y0KH
	Rk/uNcHPq5A19TxCeWsZtkMia5/443DE26HnbI5wjJhONRIV7Sjb53KlYWPTfobql11aRM
	73VpB9x/ebKUg4wdUbXAYyv9maZ5S/fGKc4hngbowIkw+FAnUt+Q+itsV32jTA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:53 +0100
Subject: [PATCH bpf-next v2 05/10] selftests/bpf: test_tunnel: Move erspan
 tunnel tests to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-5-8329f38f0678@bootlin.com>
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

erspan tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test erspan tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_erspan() from the script.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 46 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 52 ----------------------
 2 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 1aa0fa56a679a4b6fdd2f36868493b977171e965..1f39ebdf79c8ecab92782b63f2da5c5d7cb64159 100644
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
@@ -872,6 +875,47 @@ static void test_ip6gre_tunnel(enum ip6gre_test test)
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
@@ -895,6 +939,8 @@ static void *test_tunnel_run_tests(void *arg)
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


