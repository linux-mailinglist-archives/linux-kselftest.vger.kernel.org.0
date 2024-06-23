Return-Path: <linux-kselftest+bounces-12510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E7913734
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72475B221FC
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA312393;
	Sun, 23 Jun 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7QCLyvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806314C6C;
	Sun, 23 Jun 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105673; cv=none; b=XtD8aM5uvk4gz0SuBG5NqV8iyyTXCmdhNLW93gaH/SVIxhwyxT3VkQJApJggFCxMFyoOVCVicqrlof8+HTkiB5t/xeS2gLpx2FbU7Usm1gSOmfYdKvMqT/T7wRmNWwDyBYR5/pK/ENZG38cDej2F/iQIxrw5E2RdsLHOCreVSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105673; c=relaxed/simple;
	bh=XqLrapib1ix299gEFLaiIbgWz0vz+XnguQVLwlJx2ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p67k8OQGHwkmx/raIdg6R4rzXLwVsREKTivoGd91oZFW3Ht1csYOx1dwFSPSquHW5T6SFU/FMUzbTTabne+l1VyMAK8Fpr9GA3gMUt5SIrpluaYS9H41ViJ8Ix/0wFFRgLfi3ECnnlXqcbuFIWEPq4Bnu/5LJ+TT7w8muMvoVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7QCLyvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857FAC4AF0A;
	Sun, 23 Jun 2024 01:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105673;
	bh=XqLrapib1ix299gEFLaiIbgWz0vz+XnguQVLwlJx2ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7QCLyvLCx/e7DCkVFYAV6HM4r/5jd5BQXQxu6dBCcizPYCr8UaCvFl3SUqAf/od8
	 cEmD+T3dUiw+l/Ek4jHq0bsja16+UfGJTxtS6wzivRFHFMHUpEhgKR+SGzDgC3W6y5
	 ZgDnGxhD55fd0UnrO2pRL1PLF4W5oC7BQhrbXv5LpuHqJmUXUHYy1AiNVfEHtWOUEn
	 eFxcCJfV/PtAn2PlBcMnXNQO/6M+unCL7oAeqROFwwr2jkOGZGYg3i3ywd1fI7xIAU
	 F3ducxwGpcfN1kllbAyL2Ja4Bliuid5bNvyGiit1t7GNVty35mCcaFb7SKOsn82PeZ
	 KL82k1sGez++A==
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
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Drop make_socket in sk_lookup
Date: Sun, 23 Jun 2024 09:20:02 +0800
Message-ID: <b8a00c236cd6e360f42c33bf9afa9e2cb2806f01.1719105178.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719105178.git.tanggeliang@kylinos.cn>
References: <cover.1719105178.git.tanggeliang@kylinos.cn>
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


