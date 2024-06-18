Return-Path: <linux-kselftest+bounces-12121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C490C2AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9628303A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E81158A21;
	Tue, 18 Jun 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K39SREdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC782595;
	Tue, 18 Jun 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683676; cv=none; b=WOlUlc0IfxuQSRJ2rZZyyGJLuRYUjUDf1J2kibQRuFqTv48jbltOETDztYVknmDxpYgDQJr4Q5Ps3+ELE4MGJyfQtR/lXBVUq8+tN2MIbFTev40xGUreFJCXu18qnCdNTM3FixuAP9GWtVDoOc+lhi5/QMRg2LL+joPslO9hLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683676; c=relaxed/simple;
	bh=LgLu2BDQEqIlcROtCzfjnqir6VeDbEN4B9SGDbwbc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHMzSYr3G8J+/K+UuME0DU28hhxGDvNmXHJhLAWZNaCWOuuTJ9MhIjuRc2vqgmWrS8kPFFyuMQfNBzdISWF2yBjnAe9ypoliityUGqnskUcu731pG3nxaajFZmyaJ18J8kzKoTTCctGVeZVg46UT+iqB1oOUk407SdOXsy95p2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K39SREdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBF0C3277B;
	Tue, 18 Jun 2024 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683676;
	bh=LgLu2BDQEqIlcROtCzfjnqir6VeDbEN4B9SGDbwbc4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K39SREdOYyiSVf7CPcY+PD8radE6AEP23yN1jQVoZQwvVuMigkmF5HOPR8r/PDC8D
	 Y1HIUbQ1+i5fC1T81hSsFTjUw/gW1RdZSsn0MvkmRU8UNuhUovAbOxwQrvpjSQcnIH
	 pmoyHH8DT6XGPAhb080RT3UDo6hBUDKFDJkfuks/KmQ4fXxLQOe7+3lDC1M8NLfqpi
	 CShM4wnrex7aepoYXZLu0oLl9ZhVgwMMmu8SKF+11ZfN2NlEVe5+XDTZyFLclkAJZe
	 P3fxNVamcZuUsYl+Jmn/zdI0wXEbF0R4X5Loay42eoAkDIoOXrwBPSheXL/RNaDce9
	 +le9jJqh5cLKg==
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
Subject: [PATCH bpf-next v4 3/6] selftests/bpf: Add client_socket helper
Date: Tue, 18 Jun 2024 12:06:53 +0800
Message-ID: <7413bca7c2c345ce8eaf3e63e51506faad41926c.1718683292.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718683292.git.tanggeliang@kylinos.cn>
References: <cover.1718683292.git.tanggeliang@kylinos.cn>
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
index 16c2586c33ad..47c86987de12 100644
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


