Return-Path: <linux-kselftest+bounces-12497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F624913165
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2841F2342B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F9441D;
	Sat, 22 Jun 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJPLFI8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDB1C32;
	Sat, 22 Jun 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019473; cv=none; b=VqAAWYrXfg/e7NBiO5ee7se0ITGu4O55/ptgD8wOuFje5c0Jg6Om5ihEM/Ivra3rwr9fXdycgH1ISi1zRkZeCKVyBVbIk8IFZi3oP4YRhH111R3Sg+R7kAhuc1sZKylnbtj0vHqZcjQ6gm1vT63RggAzfW/ismlPjHuKPVBTxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019473; c=relaxed/simple;
	bh=XqLrapib1ix299gEFLaiIbgWz0vz+XnguQVLwlJx2ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPvNp77v/U7MaNqkeGSXZfUvNoy7Px4L02USnJRsEjMed0T0H+YH7+xKAGzMG/v6ifNcnC+HpnuK0sP1Ib4GTV8aVyFRsLXrAwuzrbGMkrqU0J5G3LYyTOy7IT4IAOm9enD5R6sSTcdeSSHXR8AFXCB86LjBq46YYNtIfr1iKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJPLFI8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C224C2BBFC;
	Sat, 22 Jun 2024 01:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019472;
	bh=XqLrapib1ix299gEFLaiIbgWz0vz+XnguQVLwlJx2ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJPLFI8jI8kdn+OUKiK+inJFgfrA3cZ+iTvXTePlrvaVfwVI2xOkejYoNgQZZZiS3
	 1bI2HxP1lLROgrTdgw2AQlWon4q/ZSC8HA7Yx7qImuS5X0ygIAZaezHTbpg0EHDxLC
	 8nni3yuUKtV36/jzNT8qLFsGQMqIQoJilnUZMoVUpyQENJsAk7LIdcFXlkoSQE1tfh
	 wAnkzk8UpZw8sLcWdSMOhaecVseqf6QFvPidFs2YACpBSHMv6L3NokxdJ2zFac0lV3
	 Oi5K2cwHtnr74JagyVXcdWVoCKyKvUX67Ky8GPDqxDvulNbvMPfmT+4uZCTWpnML/c
	 6HfYbPx3Tj+Qg==
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
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Drop make_socket in sk_lookup
Date: Sat, 22 Jun 2024 09:23:47 +0800
Message-ID: <28e0e61eb4a14e86ba3463576de4838f83be900e.1719019125.git.tanggeliang@kylinos.cn>
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

Use local helper make_client() instead of using make_socket() and
connect(). Then make_socket() can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 40 +------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index d3821bf350a1..85e927381192 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,40 +108,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr, socklen_t *len)
-{
-	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
-	int err, family, fd;
-
-	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, len);
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
@@ -1210,11 +1176,9 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
-	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
-	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1244,11 +1208,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
+	client_fd = make_client(SOCK_STREAM, EXT_IP4, EXT_PORT);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, len);
+	err = 0;
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


