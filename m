Return-Path: <linux-kselftest+bounces-7365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016589B68D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 05:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41F31F22245
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 03:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BC187F;
	Mon,  8 Apr 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFA6FjL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611C4A2F;
	Mon,  8 Apr 2024 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547948; cv=none; b=TTzNgdwS6wmhmH4+dIf2gdjXpaMICOs0bsa0XwZDhNN3xI/BBfEB30ttHIzinC+YXm0yMSwAMRdYP0sWB/XIgGCoaZKwzgzjgqhhQ0qB1TvIQfqm388TiylrJILObkhlMYPwOuh3dpve5aNWVx0FbE/gCnhFyAgs0x7OqKYKzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547948; c=relaxed/simple;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McHr89dGDjZoeDsGNP9u0tgBajYx4A6vkmXGT/LC7ahVBSXKe2xPF3weuDZnrjLR5r/apwZPA4pf0kaxNkhzba8CQXIgqrcZo/ZmhSQ0SIKTHha6bdfx8SVEdRsK9MMnqgco0ltM1uq5d1msYib44DWQhcEbkbJSed8Mv3Cl6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFA6FjL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71344C43394;
	Mon,  8 Apr 2024 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712547947;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFA6FjL2RQ/KYaRPsai4wzHJHYDIvRB7rDBAFHcREUzq+LrJW2qwGppzYODVLxMBY
	 +TobmuuWrXM0YKbOoX+SRyushOHw2YUzal8kkwO7z+v2WYXqqHslb+i/8LczUpnRle
	 u/cUPwqn2mjnz7AvLlX/+z/TvXK+KZ/woHtN+wvFZKfa+smsZdmlB57nzy9NuHcH/G
	 cIiQRs841yBEqKdsYut/DUV8IipxMTSoFrfqUzJainlgYAvFd5aT9u7Nu/E7V3eUwB
	 xCtigfteSWf1RLV9P6XgycSqNYaVsPnLp5TMfcmgJM1G6+l7KiVoXCFuiJxCK728Eg
	 k6wnIOdVc3OQg==
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
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Add struct send_recv_arg
Date: Mon,  8 Apr 2024 11:45:30 +0800
Message-Id: <8d1ffc058f86bb0296be1a0abebd88de4553a80b.1712547287.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712547287.git.tanggeliang@kylinos.cn>
References: <cover.1712547287.git.tanggeliang@kylinos.cn>
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


