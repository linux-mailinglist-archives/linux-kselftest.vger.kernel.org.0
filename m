Return-Path: <linux-kselftest+bounces-12202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527AE90E1C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7D7B2245B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5634D8DF;
	Wed, 19 Jun 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQVuP8zQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429242ABB;
	Wed, 19 Jun 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765767; cv=none; b=q1dsZP2b2oy5L+jGHdFt2Hnb1MIGXfquGf6oceE6kAkbhqXMoWGjqgin6ZzU37SW5ry0/mlU6FsG141TOCf9ScO9P5BXrodtjfle1KCtEXoUjPGek0vBpQFSa09fpWihwRA1/hhGOjYcT+3fZmZ4glvRfa+D2yLO3O3V5wEiYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765767; c=relaxed/simple;
	bh=PsvGsQRKKJSGgKv34KevE6AMJOozWFIM3+f7hsgwmnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+bm26GVEGJkIGBnPSNbs7fAFCOkU48KCD8ioc+4/DZxeceQtZYF6aunatbhPnknNTEuuDpajM9oACFx4k9m4rGpIQsRxYiHgEkmEzixLj4D8xj00wXhsL4cKk9BJ/V+l2hw0L6W7PPY1cYtxauTJXh163mMw7z7abkn9wl8W1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQVuP8zQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA7C4AF1D;
	Wed, 19 Jun 2024 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765766;
	bh=PsvGsQRKKJSGgKv34KevE6AMJOozWFIM3+f7hsgwmnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQVuP8zQS33KyAJ+1mcfrub4fqhK0wNvpp3M4kDLeI3UrG9cERlUn5OHx48WV7GVr
	 2hN1/XYCYqjjp2pQGRARMRydMW8YPEK1mxpMapZs0uL8eOzi0EhWb8RUpWNQ4qztdZ
	 Mx37C9cz+b5A146xx5EguKVwM9Vs+zg2B0EyH09FQm3UQ9HWhV86iezAIXHS0O2h/m
	 qYr3jU8B0Krcv4Xc6L6hOry2FvpKKcuU8OkJASaUUdJ3D8zOFa/ZK2b0nTyWlWeYH2
	 bVL7rHTrBNQu6c/6WtT5fbuRns/kHKUbqzDd7jfoCBBoaf8ESXjeylj+qUCUM9RI1d
	 Z/pTZcuvsPMDg==
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
Subject: [PATCH bpf-next v5 3/6] selftests/bpf: Add client_socket helper
Date: Wed, 19 Jun 2024 10:51:08 +0800
Message-ID: <1ce930a1587977be1c6cfe576ec45f159553123f.1718765123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts a new helper client_socket() from connect_to_fd_opts()
to create the client socket, but don't connect to the server. Then
connect_to_fd_opts() can be implemented using client_socket() and
connect_fd_to_addr(). This helper can be used in connect_to_addr() too,
and make "noconnect" opts useless.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 37 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 5d1b4f165def..5f8214e2880d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -249,6 +249,34 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 	return -1;
 }
 
+int client_socket(int family, int type,
+		  const struct network_helper_opts *opts)
+{
+	int fd;
+
+	if (!opts)
+		opts = &default_opts;
+
+	fd = socket(family, type, opts->proto);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
+		return -1;
+	}
+
+	if (settimeo(fd, opts->timeout_ms))
+		goto error_close;
+
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
+		goto error_close;
+
+	return fd;
+
+error_close:
+	save_errno_close(fd);
+	return -1;
+}
+
 static int connect_fd_to_addr(int fd,
 			      const struct sockaddr_storage *addr,
 			      socklen_t addrlen, const bool must_fail)
@@ -284,19 +312,12 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (!opts)
 		opts = &default_opts;
 
-	fd = socket(addr->ss_family, type, opts->proto);
+	fd = client_socket(addr->ss_family, type, opts);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
 	}
 
-	if (settimeo(fd, opts->timeout_ms))
-		goto error_close;
-
-	if (opts->post_socket_cb &&
-	    opts->post_socket_cb(fd, opts->cb_opts))
-		goto error_close;
-
 	if (!opts->noconnect)
 		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
 			goto error_close;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c92bed35dfe2..e89eadfb02d6 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -57,6 +57,8 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
+int client_socket(int family, int type,
+		  const struct network_helper_opts *opts);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.43.0


