Return-Path: <linux-kselftest+bounces-27744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4426A47F13
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B521897564
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE62343AF;
	Thu, 27 Feb 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EKNu+Age"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38607231C87;
	Thu, 27 Feb 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662675; cv=none; b=dPurR0i7UdeMCI58grMLlI/Y09i223HijFVsPDxS/guGF5f5D49JimWf/bnDh6OZ/X28m3elDCnpkDvMVcU0ift52Y4mgH2cjM7koCrlRwdIg5PaBoMvj6lUMslLl7hevG5Md+SvKfl6ZFnLhzjKZNnqizSy45scdcv3QPRkk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662675; c=relaxed/simple;
	bh=HXV6FgzUPFmoA+2NdtYVC0dUoGrqxKJFiCfxreFuRHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDDIxJqobTNQ8KYrpDC6J1ghPETXFLpWi/ptk2G1w/OT2LBn0P2jVrRcBVYOT8uOX2vbwg5II2WKK+1BqYHH4VTJABftowJenqTOBqtYWFMsXKTvuQ7NiKp23mb91VGiyYuyEp5fULSYs4NQTi213qxATD+VPatuuGdFfF9P2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EKNu+Age; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDDB044253;
	Thu, 27 Feb 2025 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amRSI20L0Lvlm6N0ELhECc3/6gvBmyyQPGzSJJRVyXc=;
	b=EKNu+AgemoKzNvclrI0WIEWiCUyXhoc2uNLDu+cujIag3Ef5LhVEQWH695uzkbcLXolUZm
	mKNXVM1Nbs8yIFjZ9FRXSBGbTegCkPCyJ0+EjLGwc8ZfRiXWNlKAGBqjYlJMIBKF/0WVd2
	0yaCOE8qYWuqjhHCJA6s5PLQmAPWPrSv8pykQ1sRx2RUbSF8ZSF42y/JvRITZnpFzwT7Y4
	zRlD1msvmQ7EtMHkysrrGiahoy6BIzSfid9fibIGmA3OQVqoB2E0hJURYKPQjh+n9wEKzV
	0HSJfFO1vPj7xNA40MQN9F597hXu8JNfkxNiztLM2j4+dC04mKWPbv7egl3m9g==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:21 +0100
Subject: [PATCH bpf-next 06/10] selftests/bpf: test_tunnel: Move ip6erspan
 tunnel test to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-6-33df5c30aa04@bootlin.com>
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

ip6erspan tunnels are tested in the test_tunnel.sh but not in the
test_progs framework.

Add a new test in test_progs to test ip6erspan tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_ip6erspan() from the script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 41 +++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 58 ----------------------
 2 files changed, 41 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index c45170dc55dd93cdf613cc5798b7df78e3080661..cec0b71b5bdd6d88e7b41b99de081b5370896188 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -109,6 +109,9 @@
 #define ERSPAN_TUNL_DEV0 "erspan00"
 #define ERSPAN_TUNL_DEV1 "erspan11"
 
+#define IP6ERSPAN_TUNL_DEV0 "ip6erspan00"
+#define IP6ERSPAN_TUNL_DEV1 "ip6erspan11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -926,6 +929,42 @@ static void test_erspan_tunnel(enum erspan_test test)
 	test_tunnel_kern__destroy(skel);
 }
 
+static void test_ip6erspan_tunnel(enum erspan_test test)
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
+		err = add_ipv6_tunnel(IP6ERSPAN_TUNL_DEV0, IP6ERSPAN_TUNL_DEV1,
+				      "ip6erspan", "seq key 2 erspan_ver 1 erspan 123");
+		break;
+	case V2:
+		err = add_ipv6_tunnel(IP6ERSPAN_TUNL_DEV0, IP6ERSPAN_TUNL_DEV1,
+				      "ip6erspan",
+				      "seq key 2 erspan_ver 2 erspan_dir egress erspan_hwid 7");
+		break;
+	}
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.ip4ip6erspan_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.ip4ip6erspan_get_tunnel);
+	if (generic_attach(IP6ERSPAN_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping6_veth0();
+	ping_dev1();
+done:
+	delete_tunnel(IP6ERSPAN_TUNL_DEV0, IP6ERSPAN_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -951,6 +990,8 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ip6gre_tunnel, IP6GRETAP);
 	RUN_TEST(erspan_tunnel, V1);
 	RUN_TEST(erspan_tunnel, V2);
+	RUN_TEST(ip6erspan_tunnel, V1);
+	RUN_TEST(ip6erspan_tunnel, V2);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index e8e7839fb5b5f69a50a6f1fcd606d1cb6dee3c64..2b486df9724ddfe2fde4e9695274cc8ab0b036d4 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,36 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_ip6erspan_tunnel()
-{
-
-	# assign ipv6 address
-	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	if [ "$1" == "v1" ]; then
-		ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE seq key 2 \
-		local ::11 remote ::22 \
-		erspan_ver 1 erspan 123
-	else
-		ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE seq key 2 \
-		local ::11 remote ::22 \
-		erspan_ver 2 erspan_dir egress erspan_hwid 7
-	fi
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip addr add dev $DEV 10.1.1.200/24
-	ip link set dev $DEV up
-}
-
 add_geneve_tunnel()
 {
 	# at_ns0 namespace
@@ -166,29 +136,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_ip6erspan()
-{
-	TYPE=ip6erspan
-	DEV_NS=ip6erspan00
-	DEV=ip6erspan11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6erspan_tunnel $1
-	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
-	ping6 $PING_ARG ::11
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
 test_geneve()
 {
 	TYPE=geneve
@@ -341,7 +288,6 @@ cleanup()
 	ip link del ip6ip6tnl11 2> /dev/null
 	ip link del geneve11 2> /dev/null
 	ip link del ip6geneve11 2> /dev/null
-	ip link del ip6erspan11 2> /dev/null
 }
 
 cleanup_exit()
@@ -378,10 +324,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing IP6ERSPAN tunnel..."
-	test_ip6erspan v2
-	errors=$(( $errors + $? ))
-
 	echo "Testing GENEVE tunnel..."
 	test_geneve
 	errors=$(( $errors + $? ))

-- 
2.48.1


