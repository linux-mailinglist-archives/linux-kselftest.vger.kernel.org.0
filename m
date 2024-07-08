Return-Path: <linux-kselftest+bounces-13304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF55929AE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BFA2811C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA281879;
	Mon,  8 Jul 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5r1sgS8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192F803;
	Mon,  8 Jul 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405880; cv=none; b=GoRzt/D3plxcNa75lWP3/sn1r6CNk1Q1ssCfP0iAPzS4XLBYhjlHTpRRMEhe6KbdpdLvYvgOefjahHwFdNNmofpjd6XJdfA5c8xBQexLInQqA6HMLl3gVXyNzR7oT/eUEvL7yytfL4j7kHgVW9LBWd9kKtwRbC1uvwF6JvtHYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405880; c=relaxed/simple;
	bh=8fDEfzWnbO0l/KBAAoAS40/0DvLfb8+vaBAwKdnfSww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seT4L/cInjocvbYCwSq1HsND1xdGp4G6c/56zpzl3lW8Mja9+fD75b3qbidH8Y+x1Q89aIRp4v9tV1y1RszJBN2d5h9X4TWq0txgp3sbQ7XT6h2CpRFgm7R6V4Jb+zhmzaKhriFMah5zv8elRslyv+NW5RZhiTF7pu/yvunyjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5r1sgS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85CAC3277B;
	Mon,  8 Jul 2024 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405880;
	bh=8fDEfzWnbO0l/KBAAoAS40/0DvLfb8+vaBAwKdnfSww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5r1sgS8SjbYYz6UB4jEjvga/ygylmhDmQECDO/+Fk8n3D7A8gOaqCEyMIpP6fDHH
	 fS26F8yKQzrpkuCogjOYOt4MsfyEf17Oq7ZqKxe+78f4K82+MsdE15J1TX7GNJYu6d
	 0FqQ3RP7E/DFae16UVgfX2jFcThjVHLUYL5eR9Q4E4lNbRUw0KT9nrEZpPJ3zZLejZ
	 QtQc+6Za8OzEGEMkra2M0LaZfFSToLxMvVtwz7GqHdknXxSZzsmD/1k+9KsYmUoewu
	 TRL1KVj4KxBHFA5u8GheGUQEU9c8V4lJkwMX1LgC4g4zdqm/ZMusgF5jARfahRG4JC
	 zMNMUN/SNJAIg==
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
Subject: [PATCH bpf-next v10 12/12] selftests/bpf: Drop make_socket in sk_lookup
Date: Mon,  8 Jul 2024 10:29:50 +0800
Message-ID: <411ddbcb2bf875b096466f0f28472f3d5bd5dd94.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use local helper make_client() in run_multi_prog_lookup() instead of using
make_socket() + connect(). Then make_socket() and inetaddr_len() can be
dropped now.

make_client() returns normal "fd" instead of "-1" when connect() fails
but "expect_errno" matched in it. So "err = -errno" is needed to get the
real error number before checking value of "err".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 45 +------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 5e013e0f8136..95307ccbfc42 100644
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
@@ -1220,7 +1180,6 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
-	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
@@ -1253,11 +1212,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	client_fd = make_client(SOCK_STREAM, EXT_IP4, EXT_PORT, t->expect_errno);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = -errno;
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


