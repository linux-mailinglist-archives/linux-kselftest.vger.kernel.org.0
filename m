Return-Path: <linux-kselftest+bounces-7366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC289B68E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 05:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC51C20E0C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882B1877;
	Mon,  8 Apr 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRUBN82i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A81C0DEB;
	Mon,  8 Apr 2024 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547953; cv=none; b=TEuRJPg3OIHDbzUHVqwiFn304G9o7HX+zCGrjB8nakjcJ9guY+o9tbEJtUVRPVlIecWDRSjgUIjekhAGTpoBqF+E9nsaLJHy1wSmyXD/taJevvAh981OOokHvd1dbMMRWaq/NEdIr0S6nj6O4LePvOBIOnBINxnTrtD9+gGCOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547953; c=relaxed/simple;
	bh=YxtZ+o7jIVqquLJ4Df4JmVl3GjZNVMXsuF41jlodVds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPnJzgeJOvtbRVz5Vr5C9b9PLPa3bIim0kQ/qxj9MGcI9DWWwY5iJszXto0r7TLdrUmuDOc7TqjPO6PUroKwCIko5IhIyq42ZbKG2uS8GgFTPYsva/t7014U8UXhsr+kvGaoQh7hEWEl+YE6NjKtIlY87RYWPwS/FbyLIoo9ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRUBN82i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC56C433C7;
	Mon,  8 Apr 2024 03:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712547953;
	bh=YxtZ+o7jIVqquLJ4Df4JmVl3GjZNVMXsuF41jlodVds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRUBN82idhS8v5U0WBedrqBYdRc3yg/wgoG9A38W1sqAWUsv89lqaVnFwgIU+rwyS
	 IJhPMlA3zfXBDeYK1PoPKpmkKrJXdqin6HqPv3u3H3KVK/SRVMfG5EndsxCo/rbudt
	 IxPFqBZ7HDngN52hGvKVuOaQBFCyDs8NUfRp48Ngx4uCL+TlZQM0qsF5kQ7hy89K06
	 4uPU3Bf6J6YOgjQRTJ6TOSJ4J7k7oWu+JgQqmuSto7lPtqEsCglcku+qGpsJIU5XD3
	 flARlTCmKPTPGpnJ6s5tgcp9tB/wLuimuD5diZv1pNG8GLEZ3SVUl83a4DWLsatiE+
	 7IGPIa7bYT4fw==
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Export send_recv_data helper
Date: Mon,  8 Apr 2024 11:45:31 +0800
Message-Id: <a8153ab2b82c8cd57aca2c6d44d5d327e8c7be92.1712547287.git.tanggeliang@kylinos.cn>
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

This patch extracts the code to send and receive data into a new
helper named send_recv_data() in network_helpers.c and export it
in network_helpers.h.

This helper will be used for MPTCP BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 81 +-----------------
 3 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 04175e16195a..e17d19f88a36 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -545,3 +545,88 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
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
+	ASSERT_EQ(bytes, a->bytes, "send");
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
+void send_recv_data(int lfd, int fd, uint32_t total_bytes)
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
+	if (!ASSERT_OK(err, "pthread_create"))
+		return;
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
+	ASSERT_EQ(bytes, total_bytes, "recv");
+
+	WRITE_ONCE(arg.stop, 1);
+	pthread_join(srv_thread, &thread_ret);
+	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 6457445cc6e2..5172f0b7bf6e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -76,6 +76,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+void send_recv_data(int lfd, int fd, uint32_t total_bytes);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 64f172f02a9a..3f822100c2b3 100644
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
+	send_recv_data(lfd, fd, total_bytes);
 
 done:
 	close(lfd);
-- 
2.40.1


