Return-Path: <linux-kselftest+bounces-7654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B38A053C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC0DB22330
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B4604C8;
	Thu, 11 Apr 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBfUu4ve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C15FDD1;
	Thu, 11 Apr 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797465; cv=none; b=s0rC+Cz+0CpMgqBrJbQbNO2boj9npKghxWjp1XHxGBPmQ+0jKqkWTbDfRJW/wWf7/VYKwbxp9EhblGGfaRzA/aD8JP0ldcNNGbx8dGosiSMtwqgBYSY6cSEeNO/ODbphEnuAQ3K7e8h8LCry/UPbi+GzuxSmI1gMqV9oTle7vjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797465; c=relaxed/simple;
	bh=zgJeV6DRmGVjHX4hBjMfwVzhEFdDeZ/nyzCdaQvCHS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdUe+sMss8ZOmgULtPEnS8uZAp49uU2C/p3ap1Qu9KC6KVNPZo7qNGQ7F/tR4rK0VADuGUDwLUNDhqhcfmXeAFrqfs+ozBshNrAQ5koKepoycb60l9fXBIAPIgZBZP2FRyE+BhNV003hsM0RSP1O0QuL0c32YQjvD3MSAuu4OfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBfUu4ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6C9C433F1;
	Thu, 11 Apr 2024 01:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797465;
	bh=zgJeV6DRmGVjHX4hBjMfwVzhEFdDeZ/nyzCdaQvCHS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBfUu4veL3LNkzDIgc2ezyU1JGsupM1VcrzvWC5LwQSnCTRcreJTwZG8u01ECYb8T
	 eKalrWr1qF+h32rktWowcujcwR/SCb/spY+YxYB0Ah60ow/g6jru1a6yXyAZ7hhE+W
	 hwHjFZ4eZlTCbj0EBKdrSCeXQyPVtJalgJceLETtmN/SCwYomo33BPPX1NZD6R1nPt
	 GdWxO7mb4mTT1cvrs3/vxei1nflBocGgqjC9lZLZ1GzVi5K5k7INbfxa2+PlHToLUA
	 HFMCyszvGpeMu3m/DAbF/e9un50+LRw+JIhun9q0o8ShWmrLMX6urVcYggMS66iTQp
	 M0l23p3gfwXTA==
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
Subject: [PATCH bpf-next v2 08/14] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Thu, 11 Apr 2024 09:03:16 +0800
Message-Id: <7d5d626203c07fbc092df66cc2efea56f9bd3c25.1712796967.git.tanggeliang@kylinos.cn>
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


