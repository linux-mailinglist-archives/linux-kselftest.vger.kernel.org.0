Return-Path: <linux-kselftest+bounces-7655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9E8A053D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4AB2862E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA95FDD2;
	Thu, 11 Apr 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMSYUceg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E66EEB5;
	Thu, 11 Apr 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797472; cv=none; b=Wkz3Y/3TdrWeqjWwgieHyS2Q0tZT3mO+H6CZRCHEVwLGp8l5c+zW2e3GFL76c7NmbxSg2MFU7zDzYgsNtGzmtbCNUYca7gTGk0nuEJxg2JtEQyWjqe4gFEu5kOVpUnPlpUy15jYQ8YHDXIoejXySaegrBtPOdzcFUbYbPUXa0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797472; c=relaxed/simple;
	bh=OeODH0klwt+6i/ftihxA/lIrmuSswUPkNOdx9aZwfUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QF0izMf5WwR1Rc2GsjxmZIMH/daj3SFgHOFM2CSRNWWYuAgZF7gr4U+iHGfkI2iCsQoBSjW+JVZE3ReDLAsLAQoYZXr5uon9qAua+8u3gQXJmvcJs5WzBQ263CFCquruI/bwaDCd7R0ZOSV6HvylAASfAItZHeKaBw4AatJaXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMSYUceg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1588FC433C7;
	Thu, 11 Apr 2024 01:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797471;
	bh=OeODH0klwt+6i/ftihxA/lIrmuSswUPkNOdx9aZwfUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMSYUcegY5kgEHrb8bQs3BbZI9+G88/ru6J5KlSk8dsQr/8vcggrGznGw8E0bYD25
	 7aHFFvhPPogco86DpG2LGtvFpaIiji3g9QUNPflAlPzsW4N2N5I/k3CVGeGpPy9n7n
	 X00LPGTx/bkFqGSzcG3CPtHoavLBIR1aB4oukaebsQpkTBvT8hTr6k4sseV8tAT/cl
	 g4cUazW0JkNM2UA4zFurmw+DWfF80L8OuiTziS4YxbqTc0DGceQI3DqSaOh8DsFvpn
	 xzX56Jn9SjNxqP5zN4i6qUl/RPicbH06PtDSjRHXCWPnKXyZmYU+ZnTnUQqQwvxniI
	 WrhKt3KwvUzvg==
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
Subject: [PATCH bpf-next v2 09/14] selftests/bpf: Add function pointer for __start_server
Date: Thu, 11 Apr 2024 09:03:17 +0800
Message-Id: <eedd84f856fe2c9101ab4b7086276e4830370839.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
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
index 91b014784dd9..2a389e8c2503 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -79,9 +79,9 @@ int settimeo(int fd, int timeout_ms)
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
 static int __start_server(int type, int protocol, const struct sockaddr *addr,
-			  socklen_t addrlen, int timeout_ms, bool reuseport)
+			  socklen_t addrlen, int timeout_ms,
+			  int *(*setsockopt)(int fd, int val), int val)
 {
-	int on = 1;
 	int fd;
 
 	fd = socket(addr->sa_family, type, protocol);
@@ -93,9 +93,8 @@ static int __start_server(int type, int protocol, const struct sockaddr *addr,
 	if (settimeo(fd, timeout_ms))
 		goto error_close;
 
-	if (reuseport &&
-	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
-		log_err("Failed to set SO_REUSEPORT");
+	if (setsockopt && setsockopt(fd, val)) {
+		log_err("Failed to set sockopt");
 		goto error_close;
 	}
 
@@ -128,7 +127,7 @@ static int start_server_proto(int family, int type, int protocol,
 		return -1;
 
 	return __start_server(type, protocol, (struct sockaddr *)&addr,
-			      addrlen, timeout_ms, false);
+			      addrlen, timeout_ms, NULL, 0);
 }
 
 int start_server(int family, int type, const char *addr_str, __u16 port,
@@ -144,6 +143,11 @@ int start_mptcp_server(int family, const char *addr_str, __u16 port,
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
@@ -163,7 +167,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		return NULL;
 
 	fds[0] = __start_server(type, 0, (struct sockaddr *)&addr, addrlen,
-				timeout_ms, true);
+				timeout_ms, (void *)setsockopt_reuse, 1);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -173,7 +177,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 
 	for (; nr_fds < nr_listens; nr_fds++) {
 		fds[nr_fds] = __start_server(type, 0, (struct sockaddr *)&addr,
-					     addrlen, timeout_ms, true);
+					     addrlen, timeout_ms, (void *)setsockopt_reuse, 1);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -187,7 +191,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 
 int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)
 {
-	return __start_server(type, 0, addr, addrlen, 0, 0);
+	return __start_server(type, 0, addr, addrlen, 0, NULL, 0);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
-- 
2.40.1


