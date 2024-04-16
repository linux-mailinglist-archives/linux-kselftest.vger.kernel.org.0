Return-Path: <linux-kselftest+bounces-8115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14008A6800
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA621C2118B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534C126F3C;
	Tue, 16 Apr 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ1WKLFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92E86250;
	Tue, 16 Apr 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262497; cv=none; b=F3cHBBGaPncNqgqkUZ9urCNkeZ2/XQSFRuRX2TyOlVUNZnwqQMQssbobbb9w5wu+oWNJ4BqV3c+1lSPnuqQP0z50SBD8c7aHzy7Z6wa2sRvC2ivqaaINFvar1P28E4j2OhgvIZuJpCGPSg9znYYfGUuFCRxJAVXQAFCCWIvLxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262497; c=relaxed/simple;
	bh=VaFHaAeKrb+cFvQ+qjKLi/JjL2jUmftRZ42QIrUtUbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ao6gSqa01pyPN0FpIhf3G2bq9REfH2zMtCUSKLT3TlQ0EDuojpISKAc/GaEu8TFgfx/xQNmvOLfQ00Qs1u2U5zlargMlHkc+2DZAZG7q6t0zdZlmaewxMqUuEiq/l3/zBEstMPOOrMgbbrDbLOWkCIiu9KnzE4Pn3yD967CED4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ1WKLFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9744C113CE;
	Tue, 16 Apr 2024 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262497;
	bh=VaFHaAeKrb+cFvQ+qjKLi/JjL2jUmftRZ42QIrUtUbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQ1WKLFeZcyipefdBQp4mAkTP8etW/o7xOST0eTyiQqWk9CV7LZ4JO0dFb18uA8WZ
	 uz3+aON2nTdDSV5rr6GicbWtUa3/wx5QnGWIcK/bkiN/v2iI3KxJqZg7nPGnGB8tkJ
	 LruGDZ5Cek8Z4XTDoiypJCU7ajF1YqxmtJJTvyMb8rfsdUp7pJ+yIgikze6nPEIqPc
	 owQUBn2iU2DaGVQACM9pIOVrFUaabgkU2VSEg9VSTnhLbm9oKNF6+GGWDb/73jBByE
	 m+rgfroKk4yxNRH6/0nCYzQr6hqOveh0xl9Z29s0SqnAaKHCezQay1tI5Rim1DnUGA
	 mc9fjMO1bilXw==
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
Subject: [PATCH bpf-next v4 07/14] selftests/bpf: Use get_socket_local_port in sk_assign
Date: Tue, 16 Apr 2024 18:13:53 +0800
Message-Id: <68cea931420c8c26d34487979c245976531ac191.1713262052.git.tanggeliang@kylinos.cn>
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

This patch uses public helper get_socket_local_port() exported in
network_helpers.h instead of the local defined function get_port()
in prog_tests/sk_assign.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 766fc56f5fc7..c0ef210f7622 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -72,29 +72,6 @@ configure_stack(void)
 	return true;
 }
 
-static in_port_t
-get_port(int fd)
-{
-	struct sockaddr_storage ss;
-	socklen_t slen = sizeof(ss);
-	in_port_t port = 0;
-
-	if (CHECK_FAIL(getsockname(fd, (struct sockaddr *)&ss, &slen)))
-		return port;
-
-	switch (ss.ss_family) {
-	case AF_INET:
-		port = ((struct sockaddr_in *)&ss)->sin_port;
-		break;
-	case AF_INET6:
-		port = ((struct sockaddr_in6 *)&ss)->sin6_port;
-		break;
-	default:
-		CHECK(1, "Invalid address family", "%d\n", ss.ss_family);
-	}
-	return port;
-}
-
 static ssize_t
 rcv_msg(int srv_client, int type)
 {
@@ -138,7 +115,7 @@ run_test(int server_fd, const struct sockaddr *addr, socklen_t len, int type)
 		goto out;
 	}
 
-	port = get_port(srv_client);
+	port = get_socket_local_port(srv_client);
 	if (CHECK_FAIL(!port))
 		goto out;
 	/* SOCK_STREAM is connected via accept(), so the server's local address
-- 
2.40.1


