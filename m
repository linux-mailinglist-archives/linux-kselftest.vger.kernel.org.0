Return-Path: <linux-kselftest+bounces-12614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B2915E4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598601C2250C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5823145B14;
	Tue, 25 Jun 2024 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctP2oMjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9ED143C67;
	Tue, 25 Jun 2024 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294198; cv=none; b=gHtDlIdGdifIa8xhkC6tApwmlPW5p/rbC577i2EWTTpG0O3y/PDqJ0zbcC6+yiF0kmF4heqgBbfsD4wdmNuCWRb+gPDUZAEHSXxgwTVd3ZU0rWU4UAd9Duh2c1wJH6ugWMs0Bp+7LtNAAKP6Jq3vxIeGRQ8ykWL6m0e7GLSXVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294198; c=relaxed/simple;
	bh=BmXh2PAjRTCFTJ8N15OQguMjGuxD0TicPhk0j6l7l/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9fNpvXfVYf0wTFYojOthXIGYEHG6IBkw7jE5uwxG5zGgFK3CcjtSdnc9QibUqijvp/8yl01yc2YE23kiUAMh6lTPMC3fyGVWfOZTi106vE9PKxGr9hgNygTNeuiTxFathepXtEgWV9WXil/87rM87ZPyJg+nLh3Eik4wUplSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctP2oMjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF97C4AF0B;
	Tue, 25 Jun 2024 05:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294198;
	bh=BmXh2PAjRTCFTJ8N15OQguMjGuxD0TicPhk0j6l7l/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctP2oMjLhGnba4BTpRXvJTrAr7wlDdFyXxcHRxHo1ButE3AEWUyfYduoQ9f9kwl3W
	 8vGXdnAL3DoNE8Mgrnuj8AZ1WQJ1c1tuwhiyQBCpg3EWCkG7yZIEtb7uysC9EqjGdE
	 H+PyK0KjxJtzENRUp6K9l1S4If+oLcNW/Nh4wV206iAGMiOCI/Gv+vxI7v/Cth4I8z
	 MxS/j0u75/9AmXhQeb4A/6fRrDY2A7epWbzebVkDJ1NsctUOpU6Z7CF3OpeoMiZXOQ
	 sjni8js8fE+nYCZU96tbV53jVwKs19V7MTN0U3zjzBELxu08C9aB+F5EOzt5BoUVdW
	 nMntJO5ms/nRA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 6/9] selftests/bpf: Use start_server_str in sk_lookup
Date: Tue, 25 Jun 2024 13:42:33 +0800
Message-ID: <244b5ac86c177f9f9c38304e07a1e3cc0d9bb92d.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper start_server_addr() instead of local
defined function make_server() in prog_tests/sk_lookup.c to avoid
duplicate code.

Add a helper setsockopts() to set SOL_CUSTOM sockopt looply, set
it to setsockopt pointer of struct network_helper_opts, and pass it
to start_server_addr().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 58 +++++++++++--------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index de2466547efe..91cba3bc784d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -77,6 +77,12 @@ struct test {
 	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
 };
 
+struct cb_opts {
+	int family;
+	int sotype;
+	bool reuseport;
+};
+
 static __u32 duration;		/* for CHECK macro */
 
 static bool is_ipv6(const char *ip)
@@ -142,19 +148,14 @@ static int make_socket(int sotype, const char *ip, int port,
 	return fd;
 }
 
-static int make_server(int sotype, const char *ip, int port,
-		       struct bpf_program *reuseport_prog)
+static int setsockopts(int fd, void *opts)
 {
-	struct sockaddr_storage addr = {0};
+	struct cb_opts *co = (struct cb_opts *)opts;
 	const int one = 1;
-	int err, fd = -1;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
+	int err = 0;
 
 	/* Enabled for UDPv6 sockets for IPv4-mapped IPv6 to work. */
-	if (sotype == SOCK_DGRAM) {
+	if (co->sotype == SOCK_DGRAM) {
 		err = setsockopt(fd, SOL_IP, IP_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IP_RECVORIGDSTADDR)", "failed\n")) {
@@ -163,7 +164,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_DGRAM && addr.ss_family == AF_INET6) {
+	if (co->sotype == SOCK_DGRAM && co->family == AF_INET6) {
 		err = setsockopt(fd, SOL_IPV6, IPV6_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IPV6_RECVORIGDSTADDR)", "failed\n")) {
@@ -172,7 +173,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_STREAM) {
+	if (co->sotype == SOCK_STREAM) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEADDR)", "failed\n")) {
@@ -181,7 +182,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (reuseport_prog) {
+	if (co->reuseport) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEPORT)", "failed\n")) {
@@ -190,19 +191,28 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	err = bind(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "bind", "failed\n")) {
-		log_err("failed to bind listen socket");
-		goto fail;
-	}
+fail:
+	return err;
+}
 
-	if (sotype == SOCK_STREAM) {
-		err = listen(fd, SOMAXCONN);
-		if (CHECK(err, "make_server", "listen")) {
-			log_err("failed to listen on port %d", port);
-			goto fail;
-		}
-	}
+static int make_server(int sotype, const char *ip, int port,
+		       struct bpf_program *reuseport_prog)
+{
+	struct cb_opts cb_opts = {
+		.family = is_ipv6(ip) ? AF_INET6 : AF_INET,
+		.sotype = sotype,
+		.reuseport = reuseport_prog,
+	};
+	struct network_helper_opts opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
+	int err, fd = -1;
+
+	fd = start_server_str(cb_opts.family, sotype, ip, port, &opts);
+	if (CHECK(fd < 0, "start_server_addr", "failed\n"))
+		return -1;
 
 	/* Late attach reuseport prog so we can have one init path */
 	if (reuseport_prog) {
-- 
2.43.0


