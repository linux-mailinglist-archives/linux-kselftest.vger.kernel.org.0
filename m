Return-Path: <linux-kselftest+bounces-13227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F009280D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2916B23905
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D313A88B;
	Fri,  5 Jul 2024 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGgH1JCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013A224D5;
	Fri,  5 Jul 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148367; cv=none; b=i6xvqnnUzH1J+iBR4/zyYdChI3l+KmN2v94YrHSiOt3NrwiktGcteeMOxLegvibiu6SMGvCZ+khYrpS0ltgg5XfDx/Fb7VbVPJqFtOJNGGy1o8Tk3T8JjsOmG+BX61SYZ4gHyahAj4Tx7JF0ih8oubNxm6tdpbV1AcYpXfKCJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148367; c=relaxed/simple;
	bh=kA/m27sKB231+X3zvUUlslhNKjZRSzqGNK+eksVxZH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsWQK87m+hpJAOt/7YNZco2QeYOT5pHIITk5vdxfKYB9b7NjgthZIiktwCtTYMey1gONqO9KgWhMvYI/JPdftg0LyowIeNmVYsszPFFFni+awQVzaLPH/w+GmdbH6kXvH+u1YoLV7nbYgEHVmEnFX7eU/jLqRTOmCXnYEuD2IA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGgH1JCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2421C4AF0B;
	Fri,  5 Jul 2024 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148366;
	bh=kA/m27sKB231+X3zvUUlslhNKjZRSzqGNK+eksVxZH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGgH1JCN+i3FRlaE7KTwuGUdusseaNNEkSa/28gnxaOaW/OpKQD6ERtTxt1h0jWgP
	 Ku8MKVH6PpIlTpyFitPgAbYbvbTS2d52K5BD91GFzx6htolvDcziasrsJyimRjvKi2
	 t8SWE8JLPmft+e0n9ycIeNrGEcA3GFFI54GlkLEuRXdJUP4+28G79NisE/m/A5gdMc
	 P7UOIJY+84KUORfne8JVMMuC4J1W6vCpscefZyPlkmQyQi72j1YlQsoLPxYk5sdwX0
	 5gq7wK8gnaXFdgL6QP/TB3oAmWNkAWix0F3L+g5wghxc8L5LsnF/rd33EiNhG78x3p
	 VZs7Epgewcu/Q==
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
Subject: [PATCH bpf-next v8 9/9] selftests/bpf: Drop make_socket in sk_lookup
Date: Fri,  5 Jul 2024 10:58:31 +0800
Message-ID: <8eb2034f81a493fc3688759f59104b6e7fd6a91e.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
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
index a436ed8b34e0..c18bdcd1099e 100644
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
@@ -1228,7 +1188,6 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
-	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
@@ -1261,11 +1220,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
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


