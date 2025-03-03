Return-Path: <linux-kselftest+bounces-28215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD6A4E618
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EC58863BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473F28F945;
	Tue,  4 Mar 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AMb6Eg85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E426B2D4
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102956; cv=pass; b=mDT2COLFYYNmSLYe8nChWvh8YJKyKzrggpXUydQ0kF8OQ7w2ZfeYcy45al0BZ9T08RTKERlEYromxt9Kt8JOw5wlXn10XBvbkrxgu0EHV2NzVZHY9FlZTPCKY1+SEV3N9wM3yNbb73H+TWMZBYym57SA2st3VKAgqioaFnLwMGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102956; c=relaxed/simple;
	bh=te4hVjrT+OPEAMI72j7olQU/QVIQEMsFl6VKrRu98Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwMjCmjPzBOAmcKHhdR+FNiP5SyAtWsEhnnF7hilVYAIwpMeXBI4sUX9W01WXsd1+tKIj9jhyysxZbS6yvTf4zC/g8+zxghrkbdnJXoRn8HwnP/5sk1h0ByiIDcZSzV/cz/HLg/ge/tOP6ObiqGGjlpKP0wBSa99L4J3koSTzMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMb6Eg85; arc=none smtp.client-ip=217.70.183.200; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 5868640D91B6
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:42:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=AMb6Eg85
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fzc0qL9zG17x
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:41:16 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0342A42752; Tue,  4 Mar 2025 18:40:44 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMb6Eg85
X-Envelope-From: <linux-kernel+bounces-541141-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMb6Eg85
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 88D8E41B83
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:25:20 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 3E8B63064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:25:20 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F40616958A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420E1F1509;
	Mon,  3 Mar 2025 08:23:07 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268321EFFBF;
	Mon,  3 Mar 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990183; cv=none; b=taT//xid1GNnOSoVZNAw3Gw0H7dKBl6oA0LB3n1WZaiXgmpFmnPuSgdocKI+2uHv0GXtxPxtqBoOrKS9GfJMcNH7Zf7N/O8hLYKl1sq0IL1l8niE2M9jILWNs6kyUP5i131Od3e0C/GgAST2duqajef+WtrUxzyJIAsNJ89HHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990183; c=relaxed/simple;
	bh=te4hVjrT+OPEAMI72j7olQU/QVIQEMsFl6VKrRu98Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PY+7bJWzvQOj0CF8yEI7yS9g3Vghm80+O0/GirqlJLSUe901uRHhsaslyrnVH6rkvV3ciZ3W1YevLJVM1xO4zXoHZuvR9EL10//NavNWMwQgklUlL0lIBddy8j1HSb29dEPajxwb9MF/RX0htpCotC9UwyY/FS/ai7HMlgUBiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMb6Eg85; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D2C544361;
	Mon,  3 Mar 2025 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IT2zbggKiF2PrlQ3AyzmLytJhfz4wECKzTaVJe6345Y=;
	b=AMb6Eg85EFbyIFo0bGcH+7PynHCZlID0AWlf8jlKchxwTRmQRA/S6dQCCE6AyN7q2kgnvZ
	xhtsIsm24dFPibHPZMqMihinQg/ocRUGaNsiEkyK5EF8A1wozRbGOpKV+TaMNG2f8c1GPs
	2UNMGGzsTKypwOQB9W+DymF4/CS9Pwd4BtjB8GXTrrNjkYVUBn+MMBniJ1o3KUUWF2PTK/
	QX9oMLUkNoOT/teXR9nMz1wYx3nCan8YB4Sas+Zdg6Q/Ev63cxX2CX72ijBpR/0BxFTw7V
	/szkzERnhGoPIY8YLqcz+yblibpS/xRqi0ZFwj+iaIp3r/KcTugjXyC6Wc8KOw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:54 +0100
Subject: [PATCH bpf-next v2 06/10] selftests/bpf: test_tunnel: Move
 ip6erspan tunnel test to test_progs
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-6-8329f38f0678@bootlin.com>
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
X-ITU-Libra-ESVA-ID: 4Z6fzc0qL9zG17x
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707691.00343@x9tiEEdssGjp5xKu3lniAQ
X-ITU-MailScanner-SpamCheck: not spam

ip6erspan tunnels are tested in the test_tunnel.sh but not in the
test_progs framework.

Add a new test in test_progs to test ip6erspan tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_ip6erspan() from the script.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 41 +++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 58 ----------------------
 2 files changed, 41 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 1f39ebdf79c8ecab92782b63f2da5c5d7cb64159..1b1b19045282496cc287af801b384ec448cf2dc2 100644
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
@@ -916,6 +919,42 @@ static void test_erspan_tunnel(enum erspan_test test)
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
@@ -941,6 +980,8 @@ static void *test_tunnel_run_tests(void *arg)
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



