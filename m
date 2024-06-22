Return-Path: <linux-kselftest+bounces-12493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C528891315D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802CC282F8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059881FA5;
	Sat, 22 Jun 2024 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j64VBEv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE5441D;
	Sat, 22 Jun 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019454; cv=none; b=WU+VNBxUPnMvpi22DD7C4pHDnjCNi1y98sRZsuGbZGqoMcpg6hUrjZ44BHN6NPEdO1Cf1zIRN+C2KSfa5XhB/71K+Ut2+IjBuG3/kQV8GV+D+kkRwstS9zSpooj3A9x9XqY749a55froruNRkp0f3Ye9Kpc1qTnl0GuFWcu0iEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019454; c=relaxed/simple;
	bh=/lxFmWi7jg1WBjAVIvKF5h+VNV6it5HMrFyR1RnRPCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1vLazGWzT88bT2DcFoJ9K7Fdlhe+laFawR2qlW3gJ2VZ8Yp28zRtW/8fPUkbXgezsZvZRGQzWwrZGpNFUDqRXjqC29kRmTZG6YaL3ANdyTEw8s6D7dWiEoHVvD/0uW/sOzlMLh0zAG2X6NO25PieQvA0Fj/dsVAAw/8URjEQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j64VBEv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76923C2BBFC;
	Sat, 22 Jun 2024 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019454;
	bh=/lxFmWi7jg1WBjAVIvKF5h+VNV6it5HMrFyR1RnRPCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j64VBEv/jmnT/8YDUccQ+neJMKje6gBz6YEBPRORpxCKH50aL9XQiduDpqmQ00QZe
	 VfPVMXTJFCZj/faSCR5wl8XfQcd+N+rtSWVmfku+wKUftdtrk0Ch1MFYT8PNoCmd/0
	 Xpe0WFKqh69DdUnG6igjbR0wGEDkKotxlj/nsKJ7UItGbVY59zzu3OaQPSKqZnjve/
	 nGX3B9daw8zSqjQIxfQZDJ3BjalpVkxYEIvrD/wE1BPqXut4aBYU7fIXN0OTRdnevy
	 IkccEjpUHPAxvAYGDXsDTjZP97rRMauSCI4S6SsmtPSCVu510kcneki9+HfTctKXLG
	 Lzvx/SWPqfAGA==
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
Subject: [PATCH bpf-next v2 3/7] selftests/bpf: Use start_server_str in sk_lookup
Date: Sat, 22 Jun 2024 09:23:43 +0800
Message-ID: <a4bad442edde3ed2fb1d9313aed96e49d82b5a04.1719019125.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719019125.git.tanggeliang@kylinos.cn>
References: <cover.1719019125.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper start_server_addr() in make_server() in
prog_tests/sk_lookup.c to avoid duplicate code.

Add a helper setsockopts() to set SOL_CUSTOM sockopt looply, set
it to setsockopt pointer of struct network_helper_opts, and pass it to
start_server_addr().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 57 +++++++++++--------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..ba73b56f4484 100644
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
@@ -190,19 +191,27 @@ static int make_server(int sotype, const char *ip, int port,
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


