Return-Path: <linux-kselftest+bounces-7476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24089D75F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB341F24E4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063083CD9;
	Tue,  9 Apr 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZtZOkGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3E82D7F;
	Tue,  9 Apr 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660268; cv=none; b=rn7pKNHqE3kB2WvQVFyoDQyRPfgYhA+TGSUwDwfKHa2SJVQZKCfVE6qneGoToK//4vVkYUlCaGjcgRiAs4O7gOxliaT7u3T4EmiRoupsMbJfzT+MYFCDNkbRQhxAhEzxfhav1xJqawIMJWoRKqQtRLb/l42auyp+jXRmCmJzg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660268; c=relaxed/simple;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJAw1ck7UF+gZCTFlNkjrDTVcUw426dJ4fjn9pozlZTUA9Em4G3RSonQxkmh6k+r1xW3631HiRQgTpFimpaIW9TbQxgVwvlwIQH9Xsl3WlJ4XySWY2cjf3gpgkjbG+6uNrlXBs4Sr6DUxGGQWnUzAjwPz+fENIpsq10OAOeEBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZtZOkGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BBC433B2;
	Tue,  9 Apr 2024 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712660268;
	bh=ZS6Ft5i8Dr7yUuNXwy5mu3ymuNubjt/vAswNcv6k4D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZtZOkGy3anWWuRAybFnqfRx0ExbGVJ5HtC9n32MI+eBHU/6d8Dpvf0ibcnhI2c0M
	 rv3c12ILMQWSZQoyBr+HXNSGRLMHpCOxWDXHWPZCToFyyJavvf+yPl5uKA4RYKWOKf
	 o62EWKsyzak5+s5p3IWkKRL2uJb/JZBrWulQMsJnX0KKO2SoNLalyn7JgJTRSYVcdB
	 Flk8sNHjL1yi/1ts1JRPoIrwdNdzL3mi7eIuRMR60WPpbY+9MfVtVpPmwCMqULDANq
	 BtV7SDrI8gfAn1738ddfLZwJ7gAfnvltaeRq/Ui1aSKLzKvosNugtTw4FhLBeCtPWX
	 xF7e/xrtwTbAA==
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
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Add struct send_recv_arg
Date: Tue,  9 Apr 2024 18:57:23 +0800
Message-Id: <58ec6760f622c778f493ba4a61581de7b2e112b5.1712659575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712659575.git.tanggeliang@kylinos.cn>
References: <cover.1712659575.git.tanggeliang@kylinos.cn>
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


