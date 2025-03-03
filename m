Return-Path: <linux-kselftest+bounces-28223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F366AA4E973
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C945884A2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E924EA9A;
	Tue,  4 Mar 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PkLi7xYv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BE1FF1C1
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106908; cv=pass; b=lFDaOUY8tJHkGiYDkOsrlN++7VXVO7zqgD1rqlfCQQVFHt5hA376bx4paPJhan2TEDCDNkgl4WlZUor0vmAwyA3LbWvSgX+b46nASDhAISJAqA7+9cFRool3+MeoX5RR0UwC4wR/yPtBIoW9J88ADOQYvTINxF92xNnrEaMpxWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106908; c=relaxed/simple;
	bh=07qZX73BpU+mT9veMb4Uck3gRmUsykT31mKeASgrKwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UL6N8CSG+MIlg7wJS00DoEuS6aGTa5Pvr8vnGeG+A57m2wMdMmX0otnFVJbs0zkNMQpwroADKaM1+mEUq1NHYIMIgJgVUnloM7jk+NftANLH2tkGMYlrsbaHcFxJuGTIfQ5r+LA4HFCC8m8uw9ThotLp7lIbIEKDbCPtZW7TA5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkLi7xYv; arc=none smtp.client-ip=217.70.183.200; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id CD00140CEC9A
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:48:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=PkLi7xYv
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fjy29gXzG0Md
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:29:26 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B38964273B; Tue,  4 Mar 2025 18:29:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkLi7xYv
X-Envelope-From: <linux-kernel+bounces-541142-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkLi7xYv
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 7665642C7E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:25:38 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 2EC9F3064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:25:38 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DF1705DF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D781F152F;
	Mon,  3 Mar 2025 08:23:08 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CE1F03F1;
	Mon,  3 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990184; cv=none; b=jNU/wX8FLNq+ddn6BqllUcfvvmBbIxQcAWn8gqI5+i7x+8PkEQ+bKcd2ubtAY0JBhCWLsGkG2EmSj9AKFaJnaX2aEB+/h1jUF4lHbzbwilbGrSuliODe0AHH5yMuVARH+IR4obD/qC4h5l75yIUXT8ECUkWiZ6lgCU++vi74Gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990184; c=relaxed/simple;
	bh=07qZX73BpU+mT9veMb4Uck3gRmUsykT31mKeASgrKwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfcP3JeuIYry+7Ll8nv47S56U/8INbyaDfHOQPiM+R3HXF5vSznfBKvkSlTHpMbWlDA7vXIccH80qvdJVi76VoCcgl7QKvw9+VOiMwZWgR3BR9u32ky8fHzw2PfDNxl2ayYpr2sSZylwKc0vVJLbhTiOnE8VNwo6m/tPQDE86Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkLi7xYv; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5E2144362;
	Mon,  3 Mar 2025 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkKEz2Q1sPl/GCBXiAJbi9HogZ6cKJcP1m7Atzb7CkA=;
	b=PkLi7xYv0d7qtV62YswUiQt/1eD7G63QAjLQBUUh3oXjt7ibFTuHDreeVtL/xTebR9Aa1z
	7q3JWCnPmjWDJPKThYmK10w2lJ3C1dM8Lyajc4/MNi73SMXXUPOtv0jef93K6ZU3BZW4rK
	rEg9xAFPxyhox3FyZ3IlgmlSoBRP7QONE+US3dk7JapaU72rnmENVQ1XNEcq1FGlfznws0
	nNIJZnF9nJO6x/KqDN98saWLULb0CRjVH0enBN07RyFfuAOh2YoWszDtn3VwfNa21Y1ILt
	tN/FJ17dz7/LylVxobxNuWBi/HWBpqS8hl+LYfDAC9zkrJSSqhafJ1iRAnEucw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:55 +0100
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: test_tunnel: Move geneve
 tunnel test to test_progs
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-7-8329f38f0678@bootlin.com>
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fjy29gXzG0Md
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706979.1223@/X8ABa8TEgnXka/5wgvPig
X-ITU-MailScanner-SpamCheck: not spam

geneve tunnels are tested in the test_tunnel.sh but not in the test_progs
framework.

Add a new test in test_progs to test geneve tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_geneve() from the script.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 45 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 45 ----------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 1b1b19045282496cc287af801b384ec448cf2dc2..2210a1d768362634b5baa729121c460f99244756 100644
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
@@ -443,6 +446,21 @@ static int add_ipv6_tunnel(const char *dev0, const char *dev1,
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
@@ -955,6 +973,32 @@ static void test_ip6erspan_tunnel(enum erspan_test test)
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
@@ -982,6 +1026,7 @@ static void *test_tunnel_run_tests(void *arg)
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



