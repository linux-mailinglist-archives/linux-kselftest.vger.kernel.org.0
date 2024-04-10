Return-Path: <linux-kselftest+bounces-7540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DD89EC07
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607A21F21C30
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B813D25C;
	Wed, 10 Apr 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRAOD7m9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C113C9D7;
	Wed, 10 Apr 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734248; cv=none; b=rbBGUQjAV/PyOWcb8LlkPljeRrGByhwLJm0w3NBU++sa6PIb5AZDoGNm9wq8KfsEa5z5q1NOX38dh+RPLPPJP7eeMjszwN1hvc/B9JTJIHFGUBpUWDAEAhmavNuFVPXWgW2jjUudHiAK6Qp2yCXiOgYOP8Ik8OUKTvSnj0+/b3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734248; c=relaxed/simple;
	bh=zgJeV6DRmGVjHX4hBjMfwVzhEFdDeZ/nyzCdaQvCHS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEWapS9/nptKxQUUT44QOE1zBieZgJVQ94yOLNhNX3BVHNQtgyU+V3l4Ip0yozASnTA1ELgSfHpLKW0nlGf/5bFmfqJ58tC8NUnXnZjo/KJrz9dXXomZzV5UR2D0EHi9O28YpPqiZI+CXSsL0M85vgl/xHaLP7eYMXXpmhQwoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRAOD7m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B9AC433C7;
	Wed, 10 Apr 2024 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734247;
	bh=zgJeV6DRmGVjHX4hBjMfwVzhEFdDeZ/nyzCdaQvCHS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRAOD7m9ARxurceey5Wd8IB0sRj8aEEEqo51FnvqDEM9SCDIRbJKUd33D77AfnWZm
	 PkoBkOOIMst8kRfggAWfdaaJTB3cIrI4hEKTRTKF3Z06zcmw+4saAlYtqhf50N/IRx
	 geCsvFFINiCQS/pKalI48Eb2uICOnbMqn96Mt3/4SD8jYz6YoURR79lpjUvnD3tdqj
	 sTnPrxXEgqTp2uZqnGCQ7qrjrJQsBmFle21i2eycZbGwQml5lxXWwgVoquyq6IecZk
	 +ImfOXeeGxjvytR6KH6Isi1LWxxR2JZbPTD4X5aCZhgBQyt8jrux1ZKGuy6Qq0W0aY
	 OGkinPwwwFCUA==
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
Subject: [PATCH bpf-next 08/14] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Wed, 10 Apr 2024 15:29:41 +0800
Message-Id: <ac291aceeb72b2a7ac7b1cd165022793094ea58f.1712733999.git.tanggeliang@kylinos.cn>
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

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_sock_addr.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 36 ++------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 8fa6bec8f7a5..743ff05e7755 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -940,38 +940,6 @@ static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
 	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
 }
 
-static int connect_to_server(int type, const struct sockaddr_storage *addr,
-			     socklen_t addr_len)
-{
-	int domain;
-	int fd = -1;
-
-	domain = addr->ss_family;
-
-	if (domain != AF_INET && domain != AF_INET6) {
-		log_err("Unsupported address family");
-		goto err;
-	}
-
-	fd = socket(domain, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto err;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, addr_len) == -1) {
-		log_err("Fail to connect to server");
-		goto err;
-	}
-
-	goto out;
-err:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 int init_pktinfo(int domain, struct cmsghdr *cmsg)
 {
 	struct in6_pktinfo *pktinfo6;
@@ -1156,7 +1124,7 @@ static int run_bind_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Try to connect to server just in case */
-	clientfd = connect_to_server(test->type, &expected_addr, addr_len);
+	clientfd = connect_to_addr(&expected_addr, addr_len, test->type);
 	if (clientfd == -1)
 		goto err;
 
@@ -1188,7 +1156,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_addr(&requested_addr, addr_len, test->type);
 	if (clientfd == -1)
 		goto err;
 
-- 
2.40.1


