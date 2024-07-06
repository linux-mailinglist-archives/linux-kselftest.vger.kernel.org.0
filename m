Return-Path: <linux-kselftest+bounces-13285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A7929430
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F81E1F2193F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075F13A41D;
	Sat,  6 Jul 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO5R7EEU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6329CA;
	Sat,  6 Jul 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277263; cv=none; b=qJMu75BomEcmGgi5iEgsDn9r5fAo5UT47vEq8lFAJcOnlIv06QnH2W6ZakhX6ngtl52PJjnkd/VxmclYdKnYBNSLxtp65c6atFuSJcfIovcVGNa+bAip63yK4CtzYoNiF6BBKnVzutzIbF98Q8JJfZ2goNef6BfAzhdmwXj0IW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277263; c=relaxed/simple;
	bh=3p/deRrkgPGTdGxSapLPunN1pNLrCJ3NVhjsTWR8QBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CntbU6i+GBpmjdr0sUpmoxlsRM9n6Xo9TeAu23fladjKyR/tgo1vcCWQC2dv3xfY3S/D6ZmwkBMiVp02t5g5I17p10q9vFG6s3VdxKxdI4Wt0Q0cpeysFy7eUAEjU/awx73/dzcEa7h/OWtw+AvNSwy/9XRHvNjapm4ATdEDCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO5R7EEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7D7C4AF0A;
	Sat,  6 Jul 2024 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277263;
	bh=3p/deRrkgPGTdGxSapLPunN1pNLrCJ3NVhjsTWR8QBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO5R7EEUbHGdt1K1i7Uv9unZRLFdgCFxaEMGpf24p0+OBBkB4bT3CCBbS7IcmjcF6
	 i+5yCxIvVfRuuAwiyeaVBOTmu6lIbEZ6Yo7NWkVX/8K43uBqH0v0L/G3Uth6nXe5JO
	 OEqCCCxoAKqXCNNebyCYN1XNHQ8ug5QHWrkUe+efnvhubYOBJIaPTxGU06WsJgG06O
	 BDynMH3Cv5rTzLXIaCArPUd3p/tSjoXbHFpgHdJ33cPuZMcrtwX1qvDdwJ1PGFulnp
	 1lZvntIuX4uvoGfSfck8SjdXMMnaN2us0YRxRdowgZw8M2vhLTdgQqcgCLWIyV8OR3
	 PgcEezNCpiWJw==
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
Subject: [PATCH bpf-next v9 09/11] selftests/bpf: Use start_server_str in sk_lookup
Date: Sat,  6 Jul 2024 22:45:54 +0800
Message-ID: <af827345eade439f067b121c162cedddb156e878.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720276189.git.tanggeliang@kylinos.cn>
References: <cover.1720276189.git.tanggeliang@kylinos.cn>
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
index de2466547efe..d03ea3e64a2e 100644
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
+	int err, fd;
+
+	fd = start_server_str(cb_opts.family, sotype, ip, port, &opts);
+	if (!ASSERT_GE(fd, 0, "start_server_str"))
+		return -1;
 
 	/* Late attach reuseport prog so we can have one init path */
 	if (reuseport_prog) {
-- 
2.43.0


