Return-Path: <linux-kselftest+bounces-19860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07979A11AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8A1F25487
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A662141D9;
	Wed, 16 Oct 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AGvM+fgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2320E03C;
	Wed, 16 Oct 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103750; cv=none; b=pNEkLhVmarR7KFJ7WORUiCS/OJvHUgI2ILYVQhjYMCFoTeLiapuAyL24kgqE6ht1Ak4fjm7P7EjBs0Fa0GiJUXZ0SyTISc1ewlXrNebz7l7gjSGomVIvCBkAeP78DXGTY4YH45RerVJKOSD+V9a0oEEk85XxOwC6ckmJM/BQYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103750; c=relaxed/simple;
	bh=j7qN9vq9sPaOCJU1BcGnOHODVCTLCmtSVJ7k4WEjkMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9OMA+l+ik2CtzjZ0jSSQkjAjlEscBqr8JBh8leGXtzmhUSIZJqRo1sVYCATvNgq7QxTpntaqhKLZOf9S4rBkUnEy9v6F9Ku4Hk4JOe+vlTj4N7vBGKN0mnHR2PDKwp8OEVFR0zH0K/uW8qbqqdbWIu6g2GqdfHI7soWzMgcNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AGvM+fgV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90C43C0002;
	Wed, 16 Oct 2024 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729103745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3bKzWn3vPUHMtD6lTaI/aOCLqvJ5cI7TPdh7bpW0oM=;
	b=AGvM+fgVqauSwQpK4ICn6HQgo1Cx9oiHQ9ZEJH8Si/f5yY8V77OvYNNSFKajfj6v+XxcLH
	Bjo3okbEjfWYTUguMW6c3VkQqD1Gy1P/1Vdmp8Kh38dh5/lg9+hkgi1yvlAuuABnnNK3hq
	lT4EkFQ1mAGj9YMm+gGJwdBSDOCYmtKAexz11C/WZTZdcyGgzGfU7RO+zZ0CblbbvD2phl
	VFoKm2iv/dKgV0KLA8BysntADZkdtbAVgWzW08zcfWbFUIyYPhRWW+MFGJQSDEzZzlCoPd
	i6AG+XYppWkde8h0m0QahShr9ak/39scVL5E9RcUvfUwLdi+aRIkf0C+TSvHKQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 16 Oct 2024 20:35:22 +0200
Subject: [PATCH bpf-next 1/6] selftests/bpf: factorize conn and syncookies
 tests in a single runner
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-syncookie-v1-1-3b7a0de12153@bootlin.com>
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
In-Reply-To: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
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
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org, 
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
2.46.2


