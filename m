Return-Path: <linux-kselftest+bounces-7524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4DD89EA86
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AD21F24C6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DEA2BAEE;
	Wed, 10 Apr 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT0Ic6nc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE436B08;
	Wed, 10 Apr 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729640; cv=none; b=a34vHk6AkuRQMAY4i8IhNcISsEivv/4Uzc/DLzSjQCKdEdytXlxhUt6K/+iluw0WVQELbyJhh32uZnlu8tHbFtebR+sxdpQpGcn6VIRqgZ0vyFft+PqMl7Im57zliGChzTrm2jJWj9+k+09hDpEULZx1wogmgnBQFfc1i/eXfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729640; c=relaxed/simple;
	bh=w+zC3cBptcMJBy/TE8m7jMBOOt1knNP/NZbw9OQbEOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEB3kE3wm7fF6lCYH/Y0RcBzp/QOrY5qlzRptysxq09K+U4nXazoZNCCNJ+Luh9it7nv7NjSR0UDn6GLkTTtgIdZ0qgRK7VUO7C44DAKH5L3iMH0o8wdRX2+2RbYwE4oxYZN45pseShQ7z17s1qJA8g1zm9C2ni8k3kqMHzTsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT0Ic6nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9310C43390;
	Wed, 10 Apr 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729640;
	bh=w+zC3cBptcMJBy/TE8m7jMBOOt1knNP/NZbw9OQbEOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GT0Ic6ncgx4nL60r1eoiv7RFw8ZGDeT4ougP2+Aw7QljY/zhemB4pK/bhMGaMkR2P
	 3Ko/eApElSdk+XLA7/eSv0kVix86w4CWr3vwO9RxVDfiWnoBhdJoD2GSntYE6Z0s85
	 sgSgOx8Yy5oxPA2+Qss3HqVsX9fbPsg4PR07pasp3PxZ/GrqH4coymuaQ8XIybF+y5
	 RWBq4LGrjMB91VSbMebkZ3Tl2NVcAn+8IVg9pHxR1K15xiopHIJP3WI0RVb+JxPv2I
	 JQ9g8WgICkS8QiCe1TW2wteIuV9RCv7C19TM/73kjPV3z+dzGjAacmnIq+oby3L4eH
	 SfI+MW0VrNrIA==
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
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Export send_recv_data helper
Date: Wed, 10 Apr 2024 14:13:30 +0800
Message-Id: <a5cfd3271d91756deca82fafbc41f17819b6e67a.1712729342.git.tanggeliang@kylinos.cn>
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

This patch extracts the code to send and receive data into a new
helper named send_recv_data() in network_helpers.c and export it
in network_helpers.h.

This helper will be used for MPTCP BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 96 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 81 +---------------
 3 files changed, 98 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 04175e16195a..137cd18ef3f2 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -545,3 +545,99 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	close(sockfd);
 	return 0;
 }
+
+struct send_recv_arg {
+	int		fd;
+	uint32_t	bytes;
+	int		stop;
+};
+
+static void *send_recv_server(void *arg)
+{
+	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	ssize_t nr_sent = 0, bytes = 0;
+	char batch[1500];
+	int err = 0, fd;
+
+	fd = accept(a->fd, NULL, NULL);
+	while (fd == -1) {
+		if (errno == EINTR)
+			continue;
+		err = -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err = -errno;
+		goto done;
+	}
+
+	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
+		nr_sent = send(fd, &batch,
+			       MIN(a->bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent == -1 && errno == EINTR)
+			continue;
+		if (nr_sent == -1) {
+			err = -errno;
+			break;
+		}
+		bytes += nr_sent;
+	}
+
+	if (bytes != a->bytes)
+		log_err("send");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(a->stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+int send_recv_data(int lfd, int fd, uint32_t total_bytes)
+{
+	ssize_t nr_recv = 0, bytes = 0;
+	struct send_recv_arg arg = {
+		.fd	= lfd,
+		.bytes	= total_bytes,
+		.stop	= 0,
+	};
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
+	if (err) {
+		log_err("pthread_create");
+		return err;
+	}
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
+		nr_recv = recv(fd, &batch,
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv == -1 && errno == EINTR)
+			continue;
+		if (nr_recv == -1)
+			break;
+		bytes += nr_recv;
+	}
+
+	if (bytes != total_bytes) {
+		log_err("recv");
+		return -1;
+	}
+
+	WRITE_ONCE(arg.stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	if (IS_ERR(thread_ret)) {
+		log_err("thread_ret");
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6457445cc6e2..70f4e4c92733 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -76,6 +76,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 64f172f02a9a..907bac46c774 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -33,75 +33,15 @@ static int settcpca(int fd, const char *tcp_ca)
 	return 0;
 }
 
-struct send_recv_arg {
-	int		fd;
-	uint32_t	bytes;
-	int		stop;
-};
-
-static void *server(void *arg)
-{
-	struct send_recv_arg *a = (struct send_recv_arg *)arg;
-	ssize_t nr_sent = 0, bytes = 0;
-	char batch[1500];
-	int err = 0, fd;
-
-	fd = accept(a->fd, NULL, NULL);
-	while (fd == -1) {
-		if (errno == EINTR)
-			continue;
-		err = -errno;
-		goto done;
-	}
-
-	if (settimeo(fd, 0)) {
-		err = -errno;
-		goto done;
-	}
-
-	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
-		nr_sent = send(fd, &batch,
-			       MIN(a->bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
-			continue;
-		if (nr_sent == -1) {
-			err = -errno;
-			break;
-		}
-		bytes += nr_sent;
-	}
-
-	ASSERT_EQ(bytes, a->bytes, "send");
-
-done:
-	if (fd >= 0)
-		close(fd);
-	if (err) {
-		WRITE_ONCE(a->stop, 1);
-		return ERR_PTR(err);
-	}
-	return NULL;
-}
-
 static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 {
-	ssize_t nr_recv = 0, bytes = 0;
-	struct send_recv_arg arg = {
-		.bytes	= total_bytes,
-		.stop	= 0,
-	};
 	int lfd = -1, fd = -1;
-	pthread_t srv_thread;
-	void *thread_ret;
-	char batch[1500];
 	int err;
 
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	arg.fd = lfd;
-
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
@@ -133,26 +73,7 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 			goto done;
 	}
 
-	err = pthread_create(&srv_thread, NULL, server, (void *)&arg);
-	if (!ASSERT_OK(err, "pthread_create"))
-		goto done;
-
-	/* recv total_bytes */
-	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
-		nr_recv = recv(fd, &batch,
-			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
-			continue;
-		if (nr_recv == -1)
-			break;
-		bytes += nr_recv;
-	}
-
-	ASSERT_EQ(bytes, total_bytes, "recv");
-
-	WRITE_ONCE(arg.stop, 1);
-	pthread_join(srv_thread, &thread_ret);
-	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
 
 done:
 	close(lfd);
-- 
2.40.1


