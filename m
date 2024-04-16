Return-Path: <linux-kselftest+bounces-8119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E28A680B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B9CB21391
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CCE1272B7;
	Tue, 16 Apr 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtxLbKkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC4126F3A;
	Tue, 16 Apr 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262524; cv=none; b=UK+mOw2EHNGN3HCP98ezfWSI3rOlEAu0DehcM6AamqePNH6HR1xU21mOmY8rLfma56z7Av4S+rE6dnx1nROHEPFjo+my8uboApvwfP5R1lcFbRqZb7a3CklTAaU+5Yod/sbzdgHBBdymbnoAUvZpYgjrZcy51U2XSo2BcVhMr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262524; c=relaxed/simple;
	bh=eEf0d+YYYSKJr8JQ0MHAhSmpH3ZHVzisAU/wx98NNtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxglRPJPl2ftkf6bm3esSE2aqwA0PcdnWvZdgLBmdgmp8v93og7M+YwFaEbix4sipo8NHpLpM/k+X0AkmXHJFktVQm/LHjMh5sFQxSyP+tHOzFvwXh9WTRSZJGOjOoGMZm2yQsAJ/WFE4za6n0yU+2DuqYbKxLjXl02xhcbT1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtxLbKkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C522BC113CE;
	Tue, 16 Apr 2024 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262524;
	bh=eEf0d+YYYSKJr8JQ0MHAhSmpH3ZHVzisAU/wx98NNtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtxLbKkBrV1BaWGGjjDZFYuSex/VF/hroDmChy7RT1vE9fs8l/Jlj34mMYfhweQ+7
	 +WgCSFcmNbDnmEjcqljfI9owu6hRexEznD2HjzNRU9QykPOVaAKTwYIsQHE9CiSE0+
	 215dS07d+MASyf0D06uOBzeq2fnm5w6NPWTC8wY1niBe7B1TL/9kX0otLWNDDq7CBe
	 ywQl5VwLNeVyDgfyfLPNhQaLjjEPUiN6/hUwfIX2LwCl4P9MgnqUmSfE3SgQp6S7RW
	 Q+/fHrYzwGwIzoHBOmQLNnPyOJpH5/LicbNdu1Nl+/7NaFRHInv+lmsU7BZ8uxCPXD
	 F7dTr5QMtdraA==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v4 11/14] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Tue, 16 Apr 2024 18:13:57 +0800
Message-Id: <3a28a36638e0095619921b7bb2c468f61647883f.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
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
index 9ce5dad7468b..422255c8575e 100644
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
+	clientfd = connect_to_addr(test->type, &expected_addr, addr_len);
 	if (clientfd == -1)
 		goto err;
 
@@ -1188,7 +1156,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &requested_addr, addr_len);
 	if (clientfd == -1)
 		goto err;
 
-- 
2.40.1


