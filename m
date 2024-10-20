Return-Path: <linux-kselftest+bounces-20222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBB9A560D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9807D281700
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12C19755B;
	Sun, 20 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="owb7OwMK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D193078;
	Sun, 20 Oct 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452197; cv=none; b=AOkqsGcT1GFkpbt2BjmBjXVsgkSrlkk5Pgd68+m8OR5Tu6UsqOCE7yRjTU7aS0F50YYEyjM/FkrzNoL0rGPjuFnjfIo4NWe4m63auY0dpT3F9KvcWrT/x/rB1u7BZr9XZ2W9q6/Cy8+8Ua/nC+J9tbEb2I86gKWe+fbrmoK0NaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452197; c=relaxed/simple;
	bh=EV7WDa5tX91NfL++0tiBmWpaP4JcdJSqaNzvNrU6tjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqdOCrsGwpxd7s0XLeyjIFR7b5xITS6cLCZyRL7NWltkTCuD72uMgIkZOE0zu2jxcFGwaNxkp5DNgOCgfB5mCt6W3zo2qyE5BVpWnrsbRZWEQu7uIFnUTEELG4QArkYNAiHgMV1qf0aEcj8SUggwCNif0BVG/zFDKddF+u3/92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=owb7OwMK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00429240007;
	Sun, 20 Oct 2024 19:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+dzv+V5RRJG96Wj3Y7fQ5wH9bMS2sNkfqNRr/GeR/Y=;
	b=owb7OwMKRAj268dhfvkOa3xhCAw/FkM/Qu0xq64+1nKuONtnFXY1qfquzpHxpLMUrcFU7D
	1EBSgmk+n0nFdUPXJ077FyIwoRZzsu2AKSwUEwhY5PWch+jXX87dDlUsixa4QB1cZ/i/Bd
	HfsltRvyefjhhhh145qBWvhl/gQEkSr8bvFMgP2LlvOsmzvUBDH+05StFjOoSgR/JKlDU2
	whJ6DBnmnoxuoc4f5+b+AxJMIVeqt0ITl775HC2KfffxZQ26QcpjBV3XusUSbnWsHvN35U
	aRuspyupbYwqvYiWwaN0WqMDgd8gDPJjKB5eXvLSS9CszfUcf8xaRdvE018Okw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:53 +0200
Subject: [PATCH bpf-next v2 1/6] selftests/bpf: factorize conn and
 syncookies tests in a single runner
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-1-2db240225fed@bootlin.com>
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

btf_skc_cls_ingress currently describe two tests, both running a simple
tcp server and then initializing a connection to it. The sole difference
between the tests is about the tcp_syncookie configuration, and some
checks around this feature being enabled/disabled.

Share the common code between those two tests by moving the code into a
single runner, parameterized by a "gen_cookies" argument. Split the
performed checks accordingly.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 106 +++++++--------------
 1 file changed, 37 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index ef4d6a3ae4231b250f43f8f93eeca6499abeaadc..5d8d7736edc095b647ca3fbc12cac0440b60140e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -71,13 +71,14 @@ static void print_err_line(void)
 		printf("bpf prog error at line %u\n", skel->bss->linum);
 }
 
-static void test_conn(void)
+static void run_test(bool gen_cookies)
 {
+	const char *tcp_syncookies = gen_cookies ? "2" : "1";
 	int listen_fd = -1, cli_fd = -1, srv_fd = -1, err;
 	socklen_t addrlen = sizeof(srv_sa6);
 	int srv_port;
 
-	if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", "1"))
+	if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", tcp_syncookies))
 		return;
 
 	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
@@ -99,19 +100,36 @@ static void test_conn(void)
 	if (CHECK_FAIL(srv_fd == -1))
 		goto done;
 
-	if (CHECK(skel->bss->listen_tp_sport != srv_port ||
-		  skel->bss->req_sk_sport != srv_port,
-		  "Unexpected sk src port",
-		  "listen_tp_sport:%u req_sk_sport:%u expected:%u\n",
-		  skel->bss->listen_tp_sport, skel->bss->req_sk_sport,
-		  srv_port))
+	if (CHECK(skel->bss->listen_tp_sport != srv_port,
+		  "Unexpected listen tp src port",
+		  "listen_tp_sport:%u expected:%u\n",
+		  skel->bss->listen_tp_sport, srv_port))
 		goto done;
 
-	if (CHECK(skel->bss->gen_cookie || skel->bss->recv_cookie,
-		  "Unexpected syncookie states",
-		  "gen_cookie:%u recv_cookie:%u\n",
-		  skel->bss->gen_cookie, skel->bss->recv_cookie))
-		goto done;
+	if (!gen_cookies) {
+		if (CHECK(skel->bss->req_sk_sport != srv_port,
+			  "Unexpected req_sk src port",
+			  "req_sk_sport:%u expected:%u\n",
+			  skel->bss->req_sk_sport, srv_port))
+			goto done;
+		if (CHECK(skel->bss->gen_cookie || skel->bss->recv_cookie,
+			  "Unexpected syncookie states",
+			  "gen_cookie:%u recv_cookie:%u\n",
+			  skel->bss->gen_cookie, skel->bss->recv_cookie))
+			goto done;
+	} else {
+		if (CHECK(skel->bss->req_sk_sport,
+			  "Unexpected req_sk src port",
+			  "req_sk_sport:%u expected:0\n",
+			  skel->bss->req_sk_sport))
+			goto done;
+		if (CHECK(!skel->bss->gen_cookie ||
+			  skel->bss->gen_cookie != skel->bss->recv_cookie,
+			  "Unexpected syncookie states",
+			  "gen_cookie:%u recv_cookie:%u\n",
+			  skel->bss->gen_cookie, skel->bss->recv_cookie))
+			goto done;
+	}
 
 	CHECK(skel->bss->linum, "bpf prog detected error", "at line %u\n",
 	      skel->bss->linum);
@@ -125,64 +143,14 @@ static void test_conn(void)
 		close(srv_fd);
 }
 
-static void test_syncookie(void)
+static void test_conn(void)
 {
-	int listen_fd = -1, cli_fd = -1, srv_fd = -1, err;
-	socklen_t addrlen = sizeof(srv_sa6);
-	int srv_port;
-
-	/* Enforce syncookie mode */
-	if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", "2"))
-		return;
-
-	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
-	if (CHECK_FAIL(listen_fd == -1))
-		return;
-
-	err = getsockname(listen_fd, (struct sockaddr *)&srv_sa6, &addrlen);
-	if (CHECK(err, "getsockname(listen_fd)", "err:%d errno:%d\n", err,
-		  errno))
-		goto done;
-	memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
-	srv_port = ntohs(srv_sa6.sin6_port);
-
-	cli_fd = connect_to_fd(listen_fd, 0);
-	if (CHECK_FAIL(cli_fd == -1))
-		goto done;
-
-	srv_fd = accept(listen_fd, NULL, NULL);
-	if (CHECK_FAIL(srv_fd == -1))
-		goto done;
-
-	if (CHECK(skel->bss->listen_tp_sport != srv_port,
-		  "Unexpected tp src port",
-		  "listen_tp_sport:%u expected:%u\n",
-		  skel->bss->listen_tp_sport, srv_port))
-		goto done;
-
-	if (CHECK(skel->bss->req_sk_sport,
-		  "Unexpected req_sk src port",
-		  "req_sk_sport:%u expected:0\n",
-		   skel->bss->req_sk_sport))
-		goto done;
-
-	if (CHECK(!skel->bss->gen_cookie ||
-		  skel->bss->gen_cookie != skel->bss->recv_cookie,
-		  "Unexpected syncookie states",
-		  "gen_cookie:%u recv_cookie:%u\n",
-		  skel->bss->gen_cookie, skel->bss->recv_cookie))
-		goto done;
-
-	CHECK(skel->bss->linum, "bpf prog detected error", "at line %u\n",
-	      skel->bss->linum);
+	run_test(false);
+}
 
-done:
-	if (listen_fd != -1)
-		close(listen_fd);
-	if (cli_fd != -1)
-		close(cli_fd);
-	if (srv_fd != -1)
-		close(srv_fd);
+static void test_syncookie(void)
+{
+	run_test(true);
 }
 
 struct test {

-- 
2.47.0


