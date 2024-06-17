Return-Path: <linux-kselftest+bounces-12038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AC90A885
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8312B260FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FD190699;
	Mon, 17 Jun 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAZ1uDqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CB190693;
	Mon, 17 Jun 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613223; cv=none; b=Y136ws7v9GnBdDPBRBf6pVpQV/sB+286pK6e6Dhn81BIwEAqbH02prIySmnPZu7vgR7MP7DR3RFXOYRb5N32tuOSRDJVVYxgvZb3bE4rL6VniRWHp3EOYpOWwZxn0pxi3i/pbnBCe3TK1qmUGaVElEj9XhaOYpMVaZBk7umR1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613223; c=relaxed/simple;
	bh=X/LxyGZLZ9oatWPHMAY/G5tTZCrag5nUuRKRgwlgybw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR9diyjjcbYropZvYe11YAdIKEm9hpG/4fduO9O5LK5Vk4bmo/rL53nSqeO20W3yS53j/GVZfmz9DHg6+WR2dh3M8KB+mSbfwp0Pe9ab6Mgb2ndUiyxlc/YZsemacYXRXNA2mRC4US/PN+n2Uva53m3teD+YzoN8xeG8FYXG/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAZ1uDqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED675C4AF1A;
	Mon, 17 Jun 2024 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613223;
	bh=X/LxyGZLZ9oatWPHMAY/G5tTZCrag5nUuRKRgwlgybw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAZ1uDqgPVoa6IlEYp5AdjnVmS5nhIOFmBu5rwW7nNuaIPdiSI7vrGvMterRbYi3B
	 Ru6wZh5ZY6rTGe8C0HyscfaxCskZNoVIBOx4ABAJJJZ1XNPfXPRUHjyZcz4R3HruUe
	 6fK7ROjBghK+/L3Sk6fJcjY/ca9XKn5AS7xxlGn2crbFnGjyshcY1bcucPKLBbtElD
	 k1Eu8+S9Sf5ukhDfEVb7GaS+B7X2pkqAUZGYlTgbqU/9+XDeiI5Bq0QnV/wUZDTRUK
	 pDL9KKmHi0OyL1mfk1J9XRHjGsdCtSWz09VPbNStDuOqZBrvPeboBmu/ljEoiyf6uR
	 yg/akGxyBnQtA==
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
Subject: [PATCH mptcp-next v3 3/6] selftests/bpf: Add client_socket helper
Date: Mon, 17 Jun 2024 16:33:08 +0800
Message-ID: <8be911a728dbd8dd50c55434a46cf960c51ae7c9.1718612857.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718612857.git.tanggeliang@kylinos.cn>
References: <cover.1718612857.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/network_helpers.c | 40 ++++++++++++++-----
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 028dfe9001e4..3afeddeead39 100644
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
@@ -281,22 +309,12 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 {
 	int fd;
 
-	if (!opts)
-		opts = &default_opts;
-
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


