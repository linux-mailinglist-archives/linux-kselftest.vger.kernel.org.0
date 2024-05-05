Return-Path: <linux-kselftest+bounces-9471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CD8BC03D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3430A1F2156A
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CE14A96;
	Sun,  5 May 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0fSXqgs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F617556;
	Sun,  5 May 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714908978; cv=none; b=BvlZRPY+1DQOE9XKwO8yPOiV+8ZO/5jfBFPKICFeHMNdl775INTfgJ5PQBVu9ZmHT9Pbf7JPn+wjf4LVzAUFwekhHLHu3ZJQmMR3LWKwZrkFCnIMYehCpnEhjiN60WaafROREeGmRYLSJ3inzaqBAbX4R/tGhjspjC72zvXY/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714908978; c=relaxed/simple;
	bh=stxRdDSSRuYZc/pts2D9NuorayFLNdNhEOrxagYcyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er8Pg0LV+W2OUAczOdPzE9NmLf1SMR9iURQ1dYGzLOKy1aIscR3aVZfkdqSHnVZqcG2TnZ7vpEv7YGNwLzuq5dms2FjYci1q06vy3PHBdSRLWnevEIhKCT6w0q/3MLViFrRdsgZoYn46MJFH3ZEfnhxu4UF5PGQPJ27AGGUY16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0fSXqgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7F5C113CC;
	Sun,  5 May 2024 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908978;
	bh=stxRdDSSRuYZc/pts2D9NuorayFLNdNhEOrxagYcyes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0fSXqgsOwV3RQgglfq7Om/RaRbu0qhpVoQC0PrPbL0PUlQEI4tZCWXK9nQVPldIF
	 GXPMRXKEwcIxEEBEqEcbsxgrPLXVY4mEFlrnN/xF6Qrhox8uOUw8ghsOyuAbX//Xow
	 FJtVoD0q5Ca3ySYkOFWGfrQBbIJke1hBHYZMEFk501Oa/+UEoKrNYRmeor5fkMHsGP
	 HlevWJ6BqB/YSRrNNdf2rEm1pLMc27eElDTNOa3Q/Jk1G3XD3wN8KWNcpw1izpysAw
	 11DntpQxvVS/EHflpP2byOr6JPR5o8uI+L0ijru8RQEdFHVVuFPPaN3gQ7ZyBoxwUa
	 aMmy5OUMvDkPQ==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 1/6] selftests/bpf: Add post_socket_cb for network_helper_opts
Date: Sun,  5 May 2024 19:35:08 +0800
Message-ID: <470cb82f209f055fc7fb39c66c6b090b5b7ed2b2.1714907662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714907662.git.tanggeliang@kylinos.cn>
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

__start_server() sets SO_REUSPORT through setsockopt() when the parameter
'reuseport' is set. This patch makes it more flexible by adding a function
pointer post_socket_cb, together with 'struct post_socket_opts cb_opts'
for future extension into struct network_helper_opts. Then 'reuseport'
parameter can be dropped.

Now the original start_reuseport_server() can be implemented by setting a
newly defined reuseport_cb() function pointer to post_socket_cb filed of
struct network_helper_opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 25 ++++++++++++-------
 tools/testing/selftests/bpf/network_helpers.h |  4 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 054d26e383e0..a7ab05baedb6 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -81,9 +81,8 @@ int settimeo(int fd, int timeout_ms)
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
 static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
-			  bool reuseport, const struct network_helper_opts *opts)
+			  const struct network_helper_opts *opts)
 {
-	int on = 1;
 	int fd;
 
 	fd = socket(addr->sa_family, type, opts->proto);
@@ -95,9 +94,9 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (reuseport &&
-	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
-		log_err("Failed to set SO_REUSEPORT");
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, &opts->cb_opts)) {
+		log_err("Failed to call post_socket_cb");
 		goto error_close;
 	}
 
@@ -132,7 +131,14 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, false, &opts);
+	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+}
+
+static int reuseport_cb(int fd, const struct post_socket_opts *opts)
+{
+	int on = 1;
+
+	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
 }
 
 int *start_reuseport_server(int family, int type, const char *addr_str,
@@ -140,6 +146,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 {
 	struct network_helper_opts opts = {
 		.timeout_ms = timeout_ms,
+		.post_socket_cb = reuseport_cb,
 	};
 	struct sockaddr_storage addr;
 	unsigned int nr_fds = 0;
@@ -156,7 +163,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	if (!fds)
 		return NULL;
 
-	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
+	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -165,7 +172,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		goto close_fds;
 
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
+		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -183,7 +190,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t l
 	if (!opts)
 		opts = &default_opts;
 
-	return __start_server(type, (struct sockaddr *)addr, len, 0, opts);
+	return __start_server(type, (struct sockaddr *)addr, len, opts);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c62b54daa914..887075fbf6ec 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,6 +21,8 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
 
+struct post_socket_opts {};
+
 struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
@@ -28,6 +30,8 @@ struct network_helper_opts {
 	bool noconnect;
 	int type;
 	int proto;
+	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
+	struct post_socket_opts cb_opts;
 };
 
 /* ipv4 test vector */
-- 
2.43.0


