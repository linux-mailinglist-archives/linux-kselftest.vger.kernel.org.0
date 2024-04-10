Return-Path: <linux-kselftest+bounces-7541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5889EC09
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3752826A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154513CFA1;
	Wed, 10 Apr 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfEkA+aN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDF13C9D7;
	Wed, 10 Apr 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734254; cv=none; b=ftpYa4F1sgK98TDViRQkm9WWaq+v5EMewnAqdIhSN4OOzpj9uWpUXBzKKC9glF9z0HU2b4imndLWEfaDHHnfEYvRE6g3Rl/oRdAwTywstlNic4nvHBUauSbYl7uyMFosOwt8Hesh1f2DW3rcB3TUMw1DMampoIjey5G66e1k0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734254; c=relaxed/simple;
	bh=FHmeh3Gxq3axYQxHKov1FbRWZQgWqcM/yndGkDGtHC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6Yn89ulay42hxLaCCqU2bPs6XKcGta/EqOCqQIYjuP76tDfc4zu07VjPK2EbS7sNp036EjJUMdXIwBRz+nTn1gecSDiArlxo8LmZIGTZ7yC2Wu/serQdq/mp8iyz4Bh9tIWPZOjpDbdfjmp1wtWy7461KoukkFDraLHqIZwwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfEkA+aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72918C43399;
	Wed, 10 Apr 2024 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734253;
	bh=FHmeh3Gxq3axYQxHKov1FbRWZQgWqcM/yndGkDGtHC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfEkA+aN1ATrwyEiHaCJCU5Tvj9QxGjxvAWiQjRDpathzE+urBOW6vLUoEZPgVr60
	 j2eIjbTqkBqEFI/KH2D1GLz7FP5OJwcNLzw6dCXXjGFqzHqUhw5g5l2rSQJkFX77t8
	 xcMUgZkwkd4g2BMXqtHOg2t7GxT8zQmzcQt8hk6hJ8D2UjltjIbTU9t/QYbIf78Y6K
	 YQrX0FaBmd7wOSWzxbokvuBeQLMuHxUuF/wwDGnzGgcJYlhGw78mm9cwJQKFmCDn9f
	 FBLTQ9fCRRcZQaMEu6goN8Z7GlWoIa5ASyrOlkbuMPwyrE1/lkf5x5EOY0OinfyUqu
	 jCn/R/EI1q+FA==
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
Subject: [PATCH bpf-next 09/14] selftests/bpf: Add function pointer for __start_server
Date: Wed, 10 Apr 2024 15:29:42 +0800
Message-Id: <e1e801640daeb4f992b8df4bdc6a415dec9a8955.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

__start_server() sets SO_REUSPORT through setsockopt() when the parameter
'reuseport' is set. This patch makes it more flexible by accepting a
function pointer named setsockopt.

Then the original start_reuseport_server() can be implemented by passing
in a newly defined setsockopt_reuse() function pointer to __start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 9fd271d5d571..ff210f0ad3ce 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -80,9 +80,9 @@ int settimeo(int fd, int timeout_ms)
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
 static int __start_server(int type, int protocol, const struct sockaddr *addr,
-			  socklen_t addrlen, int timeout_ms, bool reuseport)
+			  socklen_t addrlen, int timeout_ms,
+			  int *(*setsockopt)(int fd, int val), int val)
 {
-	int on = 1;
 	int fd;
 
 	fd = socket(addr->sa_family, type, protocol);
@@ -94,9 +94,8 @@ static int __start_server(int type, int protocol, const struct sockaddr *addr,
 	if (settimeo(fd, timeout_ms))
 		goto error_close;
 
-	if (reuseport &&
-	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
-		log_err("Failed to set SO_REUSEPORT");
+	if (setsockopt && setsockopt(fd, val)) {
+		log_err("Failed to set sockopt");
 		goto error_close;
 	}
 
@@ -129,7 +128,7 @@ static int start_server_proto(int family, int type, int protocol,
 		return -1;
 
 	return __start_server(type, protocol, (struct sockaddr *)&addr,
-			      addrlen, timeout_ms, false);
+			      addrlen, timeout_ms, NULL, 0);
 }
 
 int start_server(int family, int type, const char *addr_str, __u16 port,
@@ -145,6 +144,11 @@ int start_mptcp_server(int family, const char *addr_str, __u16 port,
 				  port, timeout_ms);
 }
 
+static int setsockopt_reuse(int fd, int on)
+{
+	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
+}
+
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
@@ -164,7 +168,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		return NULL;
 
 	fds[0] = __start_server(type, 0, (struct sockaddr *)&addr, addrlen,
-				timeout_ms, true);
+				timeout_ms, (void *)setsockopt_reuse, 1);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -174,7 +178,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 
 	for (; nr_fds < nr_listens; nr_fds++) {
 		fds[nr_fds] = __start_server(type, 0, (struct sockaddr *)&addr,
-					     addrlen, timeout_ms, true);
+					     addrlen, timeout_ms, (void *)setsockopt_reuse, 1);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -188,7 +192,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 
 int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)
 {
-	return __start_server(type, 0, addr, addrlen, 0, 0);
+	return __start_server(type, 0, addr, addrlen, 0, NULL, 0);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
-- 
2.40.1


