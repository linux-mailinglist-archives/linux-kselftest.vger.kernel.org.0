Return-Path: <linux-kselftest+bounces-14106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3193A92B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B961F23463
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046B148847;
	Tue, 23 Jul 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii/A0ner"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC7148833;
	Tue, 23 Jul 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773374; cv=none; b=db7RrmXu+GtXjBmLJFu/qOFu+O1xZBmgW3WfSlWSAvL+Va7VEuvBjD9WFnJ5uZLBew36MgoGtdjPKg8NI6UpAUVdT6YqlW6T4tySJ5J854UL+xqZldaznd1NPEyIwTQEX5o4MN0gj7NctjTvgM5Jn68gk8vMAymgmBbNKr6TJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773374; c=relaxed/simple;
	bh=l5jLQwh0GHxuTfhViQjcXfLWAJLnjuwX6xKYGvb2no0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuSdUhffFqYfIi5AH9YoE9vOjs5m05V0wDvV/hSHNq1Qs2NmnwSc01UT+YD97gR2cNP9YjSL1MleerpVrkyu3IE2xy+atNNMn5mNPx5tQuetaVjhnZZoC5o9gueTid9hrcTeqpOyHPI40v+l3rsttms+/RPFuNnhKKFqp8D6o/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii/A0ner; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F32C4AF0F;
	Tue, 23 Jul 2024 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773374;
	bh=l5jLQwh0GHxuTfhViQjcXfLWAJLnjuwX6xKYGvb2no0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ii/A0nerdcE+HP2ErzIzzVxdY61AjJ26VNm7QnkMYhVwr8XjAp+aTSzvlfdsWfyTW
	 AOrLVnAsLj1jus/V3bhAqLKpQiCHDYLP4rtFW8u6/rPnKk+6YjRb0oMT8RFZOetbce
	 x01tOS5T8lXPJmPH5Hiw+HQV0brYmpH+B3xb61efp944Jx/xtyIqPfx39OcEzf4//h
	 PkNCmrAEp+uad1uCK9fVnM3gdAqHaHhZWnQMsZ9oVaXz8/QBVc4aa7DOfVdurFfiyx
	 otbW/Zl1dSzazoo8suAKclj8nPChesWQy+olsr04ddcb0OBlOxL8QXTuanVUOkYC7K
	 hFgx7yBytFp7g==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 04/15] selftests/bpf: Add send_to_fd_opts helper
Date: Wed, 24 Jul 2024 06:22:10 +0800
Message-ID: <d9bce26727d72a99069a42e1e74151b76663d516.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to network helpers connect_to_addr() and connect_to_fd_opts(), this
patch adds two helpers send_to_addr() send_to_fd_opts() to use sendto()
to send data. They accepts three more parameters "const void *data",
"size_t datalen" and "int flags" for the sending data. send_to_addr() is a
static function at this moment, only send_to_fd_opts() is exported.

The first user of send_to_fd_opts() is fastopen_connect() in
network_helpers.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 65 ++++++++++++-------
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 2a142d713861..311c3a559414 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -206,41 +206,62 @@ void free_fds(int *fds, unsigned int nr_close_fds)
 	}
 }
 
-int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
-		     int timeout_ms)
+static int send_to_addr(int type, const void *data, size_t datalen, int flags,
+			const struct sockaddr_storage *addr, socklen_t addrlen,
+			const struct network_helper_opts *opts)
 {
-	struct sockaddr_storage addr;
-	socklen_t addrlen = sizeof(addr);
-	struct sockaddr_in *addr_in;
 	int fd, ret;
 
-	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
-		log_err("Failed to get server addr");
+	fd = client_socket(addr->ss_family, type, opts);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
 		return -1;
 	}
 
-	addr_in = (struct sockaddr_in *)&addr;
-	fd = socket(addr_in->sin_family, SOCK_STREAM, 0);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
+	ret = sendto(fd, data, datalen, flags,
+		     (const struct sockaddr *)addr, addrlen);
+	if (ret != datalen) {
+		log_err("Failed to send to server");
+		save_errno_close(fd);
 		return -1;
 	}
 
-	if (settimeo(fd, timeout_ms))
-		goto error_close;
+	return fd;
+}
 
-	ret = sendto(fd, data, data_len, MSG_FASTOPEN, (struct sockaddr *)&addr,
-		     addrlen);
-	if (ret != data_len) {
-		log_err("sendto(data, %u) != %d\n", data_len, ret);
-		goto error_close;
+int send_to_fd_opts(int server_fd, const void *data, size_t datalen, int flags,
+		    const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen, optlen;
+	int type;
+
+	if (!opts)
+		opts = &default_opts;
+
+	optlen = sizeof(type);
+	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
+		log_err("getsockopt(SOL_TYPE)");
+		return -1;
 	}
 
-	return fd;
+	addrlen = sizeof(addr);
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
+		log_err("Failed to get server addr");
+		return -1;
+	}
 
-error_close:
-	save_errno_close(fd);
-	return -1;
+	return send_to_addr(type, data, datalen, flags, &addr, addrlen, opts);
+}
+
+int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
+		     int timeout_ms)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = timeout_ms,
+	};
+
+	return send_to_fd_opts(server_fd, data, data_len, MSG_FASTOPEN, &opts);
 }
 
 int client_socket(int family, int type,
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index cce56955371f..19210a234bc1 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -74,6 +74,8 @@ int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
+int send_to_fd_opts(int server_fd, const void *data, size_t datalen, int flags,
+		    const struct network_helper_opts *opts);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
 int make_sockaddr(int family, const char *addr_str, __u16 port,
-- 
2.43.0


