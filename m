Return-Path: <linux-kselftest+bounces-7676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC88A07DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC92286D3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001D13BAD2;
	Thu, 11 Apr 2024 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQDNQJmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13513CA83;
	Thu, 11 Apr 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814215; cv=none; b=uHHr2Enq/vNBsHdnzxKwnYqgKNJmN+IRSXpgPkeLKfO5yNYsWvY+ONgxgpOALF8L/VgPaLjRnAtZCvMLGN9FnPul0N+aOQHGoLg2Np56imO1nhHwzs89SxfdZ3IxjopJoaA45rEM1n+aPcgGnr9lgJXZMSjaPZhOgt4R+dMyT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814215; c=relaxed/simple;
	bh=Nw+jKwU0DfvkPmgZ/qYf2XlvVHgqRNhd2vibFo+Cl4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aM8FQa44KHq7bAi/7rX5jIoL98qA9uvK6dE1ZEvVa0sOk25lTCSp0YIIGaL1sIup9kUaYF5UY5tx5mpfHDbIbQNjxj22eYu4z55TLZBCKbHgmLyVT/6NpwLSIQtzLI/Wze4bepb6aBFicDmt1+iSKBjGHr8PqNd7z0VwFxkx8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQDNQJmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A864DC43394;
	Thu, 11 Apr 2024 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814214;
	bh=Nw+jKwU0DfvkPmgZ/qYf2XlvVHgqRNhd2vibFo+Cl4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQDNQJmC2d4gZWKUtrM0yQE/X9ryuY+cW5JlOZBsKHRvgl0hOF8eBvCZ1fBd1E1vp
	 Kcu4NISe7wcdYYli9Bj1S3/WwwJJPhNpdqiHoGJsaSj1iB4i7E3FgXLLtO9Pz23XXn
	 QlpTtDrXGgHvONeLBouddgyQU88otf81EXCWpUcMLtndk5MrT4Fwtdegok4iyCxXC+
	 4ktdPCoBq+GyCeAjnFyZknQFTMuPeZ+6oH42EjDlxz/NDujNMw3IRSUfRIWEfm2wJj
	 bYoxt8l1JXR5Rias09g47idg5X9QJBgnEf54mkbPZbuqfCorRsV+IlXLyjQHBXCqxE
	 IGl4yphAjoiVg==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] selftests/bpf: Add struct send_recv_arg
Date: Thu, 11 Apr 2024 13:43:11 +0800
Message-Id: <ca1dd703b796f6810985418373e750f7068b4186.1712813933.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712813933.git.tanggeliang@kylinos.cn>
References: <cover.1712813933.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Avoid setting total_bytes and stop as global variables, this patch adds
a new struct named send_recv_arg to pass arguments between threads. Put
these two variables together with fd into this struct and pass it to
server thread, so that server thread can access these two variables without
setting them as global ones.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 3da3030c9365..8f23b59574ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -20,7 +20,6 @@
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
@@ -33,13 +32,20 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
+struct send_recv_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
 static void *server(void *arg)
 {
-	int lfd = (int)(long)arg, err = 0, fd;
+	struct send_recv_arg *a = (struct send_recv_arg *)arg;
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
+	int err = 0, fd;
 
-	fd = accept(lfd, NULL, NULL);
+	fd = accept(a->fd, NULL, NULL);
 	while (fd == -1) {
 		if (errno == EINTR)
 			continue;
@@ -52,9 +58,9 @@ static void *server(void *arg)
 		goto done;
 	}
 
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
+	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
 		nr_sent = send(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
 		if (nr_sent == -1 && errno == EINTR)
 			continue;
 		if (nr_sent == -1) {
@@ -64,13 +70,13 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	ASSERT_EQ(bytes, total_bytes, "send");
+	ASSERT_EQ(bytes, a->bytes, "send");
 
 done:
 	if (fd >= 0)
 		close(fd);
 	if (err) {
-		WRITE_ONCE(stop, 1);
+		WRITE_ONCE(a->stop, 1);
 		return ERR_PTR(err);
 	}
 	return NULL;
@@ -79,18 +85,22 @@ static void *server(void *arg)
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
 	ssize_t nr_recv = 0, bytes = 0;
+	struct send_recv_arg arg = {
+		.bytes	= total_bytes,
+		.stop	= 0,
+	};
 	int lfd = -1, fd = -1;
 	pthread_t srv_thread;
 	void *thread_ret;
 	char batch[1500];
 	int err;
 
-	WRITE_ONCE(stop, 0);
-
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
+	arg.fd = lfd;
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
@@ -122,12 +132,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	err = pthread_create(&srv_thread, NULL, server, (void *)&arg);
 	if (!ASSERT_OK(err, "pthread_create"))
 		goto done;
 
 	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(stop)) {
+	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
 		nr_recv = recv(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv == -1 && errno == EINTR)
@@ -139,7 +149,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 	ASSERT_EQ(bytes, total_bytes, "recv");
 
-	WRITE_ONCE(stop, 1);
+	WRITE_ONCE(arg.stop, 1);
 	pthread_join(srv_thread, &thread_ret);
 	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 
-- 
2.40.1


