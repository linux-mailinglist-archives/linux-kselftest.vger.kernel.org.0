Return-Path: <linux-kselftest+bounces-7523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A389EA81
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB89B1C222B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F202206C;
	Wed, 10 Apr 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPgzG6Eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF120309;
	Wed, 10 Apr 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729633; cv=none; b=gwWLLGippcd/7Quba0f2EjgQ36cMho+9ZTR2l1xBoWrG6IY5+WAtCO/Qi+31FdF0yHPPar61IyC1Kicv7OLoz+cK26V+mt1QM3kbtGurIYZtWOST41dhczoNwrR0EqOB1QARmcA38WEzMeKmI0QPgXN5QI/bd8YEORf1jr5CNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729633; c=relaxed/simple;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoKwpelCROQJEJY28jl7X6DBcU1UtypDBMIzF6a09or30z8IRmkNJ+6Q7BJ5yAfdiIVeu35I0qR8/ac2nFSovUh2oWvhV5SiPubhRXC1Xd9CA7UWmod5Tw0SxdTuMXC+NfaShe4jWEHzWnU6O2+C0ftr3KIUVjZPECvEpkVMCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPgzG6Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1B2C43390;
	Wed, 10 Apr 2024 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729633;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPgzG6Eumlrsop2gn+9RrP6Qy/XYnqaVlEUIZQki2mU9O1I3pZfmM2vo97iXatQIS
	 WrFBs4QgBZymHSHyWkb1wC055ZU1q4oSA5zrHrxy/KS3cJe6Ff5yAQmsDU+JcK0x/K
	 VMSuN5ep9q+IvMDnQ9v5jewHtbP8Wrt+lUGo7z5hzhQ6FTp7I8NkoDHtVOHVhai/r6
	 IZbz6jMg4DMeLulfoTpTdyHEmZd0EW6f5sxIss5HJwZaFqEmVoK0bqwU4/KPYH13Ku
	 TYAvtmXvGUJkuM+1BwqqI4kNa7bBt2FUqYQWkFj19WrK/Osa6YKcaAotecDBm0a39O
	 uF5FuOkvKIn0w==
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
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Add struct send_recv_arg
Date: Wed, 10 Apr 2024 14:13:29 +0800
Message-Id: <70e9f036964554db59de08bd8b4273e8274d4fce.1712729342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712729342.git.tanggeliang@kylinos.cn>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
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
index 077b107130f6..64f172f02a9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -21,7 +21,6 @@
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
@@ -34,13 +33,20 @@ static int settcpca(int fd, const char *tcp_ca)
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
@@ -53,9 +59,9 @@ static void *server(void *arg)
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
@@ -65,13 +71,13 @@ static void *server(void *arg)
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
@@ -80,18 +86,22 @@ static void *server(void *arg)
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
@@ -123,12 +133,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
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
@@ -140,7 +150,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 	ASSERT_EQ(bytes, total_bytes, "recv");
 
-	WRITE_ONCE(stop, 1);
+	WRITE_ONCE(arg.stop, 1);
 	pthread_join(srv_thread, &thread_ret);
 	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 
-- 
2.40.1


