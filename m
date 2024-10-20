Return-Path: <linux-kselftest+bounces-20225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DB9A561D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221B81C208E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23F199937;
	Sun, 20 Oct 2024 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CZm3AO6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322B198838;
	Sun, 20 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452200; cv=none; b=s3Y+0snF83P/JSXUwmXxZtH3GmtPPFd3Gn34nL9D4tI6XcGq5Y41hidgHTzMWcs/8biVrUcXGqYehlkPRjVggksvMeR1KOeBoiqow+RDIXyh1F1PFPKBtelNSebwc/pIRCofyS07LwRKtHneS/qnXNiSJPEv4Se76IyQNRoz3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452200; c=relaxed/simple;
	bh=royLK8HneMJIN5mi9f3zh29HK6pvTNrY2UM+X45Tveo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwqeQ5u123btaLr1IX/dmVB62v1e8vNbN5OwgkQ+CPLUDAlA9UkxLpsn5guH0/yIh0uE3rJxGpGms8xGF1nyezI4tm2ISPBfiH4WOYgwNJf8/bdhhRVRTNZGs/sAuuN7AgKf6dNMLHTxxz15IFpSCufHVt8ZnEnj9sDuVJy8Mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CZm3AO6s; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A96A8240006;
	Sun, 20 Oct 2024 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VteMgUSqlqNb/CuHG/IuBbAFCgt0Pb5LrMMxVGZroTw=;
	b=CZm3AO6ssh5vVpMZbj1vsRrJ77K1rHziW21UK5C7P0ZpAxuBoE588lmCv5/WBn/QkXedn1
	ZP52VhC4sdJANDISQlEljwrNZbKQNN+3Iy3GgrZOZ4NAYMraJGNqHdXFJt+ssP9/o0e6ga
	OhIg3KKHf3j7uWoXxjG4No2JrdiRtQqZzI8fFE8MSFzWX8K3XJj8PD2L7dAJVmW1Lsq2dG
	6mmCjtzNxd3MBCbi8lG1FTN7beZm92T4vcETzjgm+LdVTO282PnzoJizwHBgnMTzw/NmUB
	hAyRLzrkm4ZxKJJvDhyrAIZcNekCGJAz7vv61CqQwPOJKXKyeNAOknLMimmOxw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:55 +0200
Subject: [PATCH bpf-next v2 3/6] selftests/bpf: get rid of global vars in
 btf_skc_cls_ingress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-3-2db240225fed@bootlin.com>
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

There are a few global variables in btf_skc_cls_ingress.c, which are not
really used by different tests. Get rid of those global variables, by
performing the following updates:
- make srv_sa6 local to the main runner function
- make skel local to the main function, and propagate it through
  function arguments
- get rid of duration by replacing CHECK macros with the ASSERT_XXX
  macros. While updating those assert macros:
  - do not return early on asserts performing some actual tests, let the
    other tests run as well (keep the early return for parts handling
    test setup)
  - instead of converting the CHECK on skel->bss->linum, just remove it,
    since there is already a call to print_err_line after the test to
    print the failing line in the bpf program

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 87 +++++++++-------------
 1 file changed, 34 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index c88fb0e3048c81a09cf4b0b9df434cf8d4c6ff33..426c9d5402fa8fd57f233feb1f43ffe66e386b7a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -19,11 +19,7 @@
 
 #define TEST_NS "skc_cls_ingress"
 
-static struct test_btf_skc_cls_ingress *skel;
-static struct sockaddr_in6 srv_sa6;
-static __u32 duration;
-
-static struct netns_obj *prepare_netns(void)
+static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
 {
 	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
@@ -57,7 +53,7 @@ static struct netns_obj *prepare_netns(void)
 	return NULL;
 }
 
-static void reset_test(void)
+static void reset_test(struct test_btf_skc_cls_ingress *skel)
 {
 	memset(&skel->bss->srv_sa6, 0, sizeof(skel->bss->srv_sa6));
 	skel->bss->listen_tp_sport = 0;
@@ -67,16 +63,17 @@ static void reset_test(void)
 	skel->bss->linum = 0;
 }
 
-static void print_err_line(void)
+static void print_err_line(struct test_btf_skc_cls_ingress *skel)
 {
 	if (skel->bss->linum)
 		printf("bpf prog error at line %u\n", skel->bss->linum);
 }
 
-static void run_test(bool gen_cookies)
+static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies)
 {
 	const char *tcp_syncookies = gen_cookies ? "2" : "1";
 	int listen_fd = -1, cli_fd = -1, srv_fd = -1, err;
+	struct sockaddr_in6 srv_sa6;
 	socklen_t addrlen = sizeof(srv_sa6);
 	int srv_port;
 
@@ -84,58 +81,41 @@ static void run_test(bool gen_cookies)
 		return;
 
 	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
-	if (CHECK_FAIL(listen_fd == -1))
+	if (!ASSERT_OK_FD(listen_fd, "start server"))
 		return;
 
 	err = getsockname(listen_fd, (struct sockaddr *)&srv_sa6, &addrlen);
-	if (CHECK(err, "getsockname(listen_fd)", "err:%d errno:%d\n", err,
-		  errno))
+	if (!ASSERT_OK(err, "getsockname(listen_fd)"))
 		goto done;
 	memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
 	srv_port = ntohs(srv_sa6.sin6_port);
 
 	cli_fd = connect_to_fd(listen_fd, 0);
-	if (CHECK_FAIL(cli_fd == -1))
+	if (!ASSERT_OK_FD(cli_fd, "connect client"))
 		goto done;
 
 	srv_fd = accept(listen_fd, NULL, NULL);
-	if (CHECK_FAIL(srv_fd == -1))
+	if (!ASSERT_OK_FD(srv_fd, "accept connection"))
 		goto done;
 
-	if (CHECK(skel->bss->listen_tp_sport != srv_port,
-		  "Unexpected listen tp src port",
-		  "listen_tp_sport:%u expected:%u\n",
-		  skel->bss->listen_tp_sport, srv_port))
-		goto done;
+	ASSERT_EQ(skel->bss->listen_tp_sport, srv_port, "listen tp src port");
 
 	if (!gen_cookies) {
-		if (CHECK(skel->bss->req_sk_sport != srv_port,
-			  "Unexpected req_sk src port",
-			  "req_sk_sport:%u expected:%u\n",
-			  skel->bss->req_sk_sport, srv_port))
-			goto done;
-		if (CHECK(skel->bss->gen_cookie || skel->bss->recv_cookie,
-			  "Unexpected syncookie states",
-			  "gen_cookie:%u recv_cookie:%u\n",
-			  skel->bss->gen_cookie, skel->bss->recv_cookie))
-			goto done;
+		ASSERT_EQ(skel->bss->req_sk_sport, srv_port,
+			  "request socket source port with syncookies disabled");
+		ASSERT_EQ(skel->bss->gen_cookie, 0,
+			  "generated syncookie with syncookies disabled");
+		ASSERT_EQ(skel->bss->recv_cookie, 0,
+			  "received syncookie with syncookies disabled");
 	} else {
-		if (CHECK(skel->bss->req_sk_sport,
-			  "Unexpected req_sk src port",
-			  "req_sk_sport:%u expected:0\n",
-			  skel->bss->req_sk_sport))
-			goto done;
-		if (CHECK(!skel->bss->gen_cookie ||
-			  skel->bss->gen_cookie != skel->bss->recv_cookie,
-			  "Unexpected syncookie states",
-			  "gen_cookie:%u recv_cookie:%u\n",
-			  skel->bss->gen_cookie, skel->bss->recv_cookie))
-			goto done;
+		ASSERT_EQ(skel->bss->req_sk_sport, 0,
+			  "request socket source port with syncookies enabled");
+		ASSERT_NEQ(skel->bss->gen_cookie, 0,
+			   "syncookie properly generated");
+		ASSERT_EQ(skel->bss->gen_cookie, skel->bss->recv_cookie,
+			  "matching syncookies on client and server");
 	}
 
-	CHECK(skel->bss->linum, "bpf prog detected error", "at line %u\n",
-	      skel->bss->linum);
-
 done:
 	if (listen_fd != -1)
 		close(listen_fd);
@@ -145,19 +125,19 @@ static void run_test(bool gen_cookies)
 		close(srv_fd);
 }
 
-static void test_conn(void)
+static void test_conn(struct test_btf_skc_cls_ingress *skel)
 {
-	run_test(false);
+	run_test(skel, false);
 }
 
-static void test_syncookie(void)
+static void test_syncookie(struct test_btf_skc_cls_ingress *skel)
 {
-	run_test(true);
+	run_test(skel, true);
 }
 
 struct test {
 	const char *desc;
-	void (*run)(void);
+	void (*run)(struct test_btf_skc_cls_ingress *skel);
 };
 
 #define DEF_TEST(name) { #name, test_##name }
@@ -168,25 +148,26 @@ static struct test tests[] = {
 
 void test_btf_skc_cls_ingress(void)
 {
+	struct test_btf_skc_cls_ingress *skel;
+	struct netns_obj *ns;
 	int i;
 
 	skel = test_btf_skc_cls_ingress__open_and_load();
-	struct netns_obj *ns;
-	if (CHECK(!skel, "test_btf_skc_cls_ingress__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(skel, "test_btf_skc_cls_ingress__open_and_load"))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		if (!test__start_subtest(tests[i].desc))
 			continue;
 
-		ns = prepare_netns();
+		ns = prepare_netns(skel);
 		if (!ns)
 			break;
 
-		tests[i].run();
+		tests[i].run(skel);
 
-		print_err_line();
-		reset_test();
+		print_err_line(skel);
+		reset_test(skel);
 		netns_free(ns);
 	}
 

-- 
2.47.0


