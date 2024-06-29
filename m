Return-Path: <linux-kselftest+bounces-12964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBD91CA05
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626971C21978
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51C1C36;
	Sat, 29 Jun 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbBF9FAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5094A29;
	Sat, 29 Jun 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624080; cv=none; b=ElcH6O9fuwHpxF9MB+BQK6o7+1jw7VWFmrbO+etywr49ghkDanqB1CfaM1QlqxtceJurr9rRpw1wusPO3zODq/Yux2PszkCJ/i8ck3+Tsxwh52HnRZfwGjeWrR6wN802Q2sbXv9jKsNOOtxJzNLGM8nakHTIhGK7BS6MKzeQdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624080; c=relaxed/simple;
	bh=ks9r+liag6rRVAFpIWvs+ysJLHoLzdm5zcgMD5xI51Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6Uo1FVKIl+TmszKTkpn81d7KkQ9Q326n0gLG6f17ZaOfkAw/oHl3FzInOZd6+MdH2zEesE+Fhslfk0Fvxo7jkRaACYdCfaun0LwUMP0ihox8LIb/pS3TFt/qc+9ZpmdFFESjL+2VKMAzvy0c5CuyIgnP2yBIUfjeKWoBKYmq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbBF9FAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AECC4AF0A;
	Sat, 29 Jun 2024 01:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624080;
	bh=ks9r+liag6rRVAFpIWvs+ysJLHoLzdm5zcgMD5xI51Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbBF9FAz9+S/9rtwPF4wf9r7OHdLLpC3dVna9kuR4RRgW6TzL9RHAbeJ6W85kDSMI
	 Auhv05KqC++MDWce7MzDzn347BGecduAVKv0/46pGkMzMoshATV6KCTjSCIYtQj0Qh
	 ROqmeTg+8uKw0QEkWKP2SQa+oK7tYrjWE8XLOO2dIuZcIcdoQNVhuX2gP1ucK7j+3I
	 WOfMAVXkEQeqPLwLb/cAQ4q891JQOlsTggx+4cAThrZcSm0+9pzzeaTdUI0Wyk6U4s
	 6VwUfd3PvzKzF+oqQnlXi413J6YTWkvQ36+56lx4clzkO4j7hAY4O3rrKlEk5uv4FE
	 EZVKXi0NT53/g==
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
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: Drop make_socket in sk_lookup
Date: Sat, 29 Jun 2024 09:20:19 +0800
Message-ID: <bb80131abb9eafa7c684f712d5f66589123893e5.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use local helper make_client() instead of using make_socket() and
connect(). Then make_socket() and inetaddr_len() can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 45 +------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 005776f5964e..c999cfff94e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,46 +108,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
-static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr)
-{
-	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
-	int err, family, fd;
-
-	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, NULL);
-	if (CHECK(err, "make_address", "failed\n"))
-		return -1;
-
-	fd = socket(addr->ss_family, sotype, 0);
-	if (CHECK(fd < 0, "socket", "failed\n")) {
-		log_err("failed to make socket");
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_SNDTIMEO)", "failed\n")) {
-		log_err("failed to set SNDTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_RCVTIMEO)", "failed\n")) {
-		log_err("failed to set RCVTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
 static int setsockopts(int fd, void *opts)
 {
 	struct cb_opts *co = (struct cb_opts *)opts;
@@ -1217,7 +1177,6 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
-	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
@@ -1250,11 +1209,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	client_fd = make_client(SOCK_STREAM, EXT_IP4, EXT_PORT);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


