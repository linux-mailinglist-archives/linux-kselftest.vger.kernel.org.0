Return-Path: <linux-kselftest+bounces-8555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD398ABB79
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 13:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1963B2826FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A8374F7;
	Sat, 20 Apr 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brDM3Iu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C417584;
	Sat, 20 Apr 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713614210; cv=none; b=IGnxI7KxTFDVZHhJUhCLpN4I9S00TcCfdbHVlSzK0zrbVSrefdKFiGvpOdFgvI7CUw19wcQiWbRwkQyWl42NzYt1S0H86ZSPtpO6W17DtWdBQ7Y3+R2TINklVRBp11mIPTmR4dqAUneO0ec1auJCufwqkvA0jfpq24z7CDBgOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713614210; c=relaxed/simple;
	bh=jrl1Q8k60ciLPsX20sgnJKGF7MqpxZTGU0gS0o+suss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCIKF3F9iJB/x9oAtEbNTM4gzoXw/rVuWjD+YOGmtxy+8K9R1lann1shcFMDRJWyraEbAuk06E3lYlF0g8dd/JBrgq5Fn/QK0h/HBcHe1mjZ0UgrA/zcd6Vr/4ch1R7BEGKbKEVDwKFTh9MuYFuxyNR6CmuGKTlz5nL+KkHWLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brDM3Iu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2846C116B1;
	Sat, 20 Apr 2024 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713614209;
	bh=jrl1Q8k60ciLPsX20sgnJKGF7MqpxZTGU0gS0o+suss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brDM3Iu3VOoPmXI82QpJhkyYbOZli5sKX6vdrbho5Z3ONcU5fXmDbh0CS9aVYvhzA
	 4mrCLdTrtzVQBSAKsc3y+9bxZma6f3nqp3/J8QBFAmfuyXJ+Q4FI/EAZRvKNyAwqub
	 WSCQaZrvX2+hn56n7E2OC8UtblAWp6yMEkUHX3cam3aylMxlwZmY0I1exa7t7MwBZs
	 EhNOVaO5/a06p/oqAjXXvROffvhDabubo4od8FukkXWIb7O2194toF25CDibr3R/LZ
	 viKMP5mFFcQPFNfKUhnxs/K0LmyiswDyUwmFwn81gAcY7AU3Te4YPel1h88jYfzfvq
	 QQ5VkD2Z3Wfuw==
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
Subject: [PATCH bpf-next 4/5] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Sat, 20 Apr 2024 19:55:42 +0800
Message-Id: <4679faffe1366ea9924b1027662b7dc09bf1a4de.1713613543.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713613543.git.tanggeliang@kylinos.cn>
References: <cover.1713613543.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public network helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_sock_addr.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 36 ++------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index ca4fb142b7b7..2e29dd9d8fc3 100644
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
+	clientfd = connect_to_addr(test->type, &expected_addr, addr_len, NULL);
 	if (clientfd == -1)
 		goto err;
 
@@ -1188,7 +1156,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &requested_addr, addr_len, NULL);
 	if (clientfd == -1)
 		goto err;
 
-- 
2.40.1


