Return-Path: <linux-kselftest+bounces-12040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD290A889
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF341C210A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFF190662;
	Mon, 17 Jun 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js2CZoD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C8187331;
	Mon, 17 Jun 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613234; cv=none; b=UfMWiripVWMLzL/DgJbPwx/cvXrCoIM0nwFoPnfKdTTd0CWGFgFcdxAbhA/b3NUS0yYHsFTEgRLX4J3xGbxnGvefJGVLxQofQe1UKFbC2FhoQFjdP17bu8aSgl3PlxtfZeyKY07Uz5U6dfWsz4nJfKyt2yRWKbGDQDMJZvVDm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613234; c=relaxed/simple;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLZ68go6TAHH1o5+D3HJPKdrYOsUw/bikDmKtvD+73+heLCmn0V9I509jphs28xwLXpapKKXaekipenDdNIQ6/CBD6XkzdbiSedNcrihuasxEDCfLRU//gmCmeGYJiAFD1fMleXLq94VuXGsVvJo1rdi2R6NASgkWY8tPTT2LDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js2CZoD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F82C4AF1A;
	Mon, 17 Jun 2024 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613234;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=js2CZoD+Dap8Z7pwnWPMwVBO8JBzbTrRjHTPipY2pFRGZofw8XTsbObW2uCVFopE7
	 bX4BIUOp0LOa7lJOA7GTJ/R2kk5fqnPIgXJtHIbSySH4AfKBUSFeXOaR/lMHbq11CJ
	 h/6+v++VzgOAuIcSMmHduHhKXnm3Kq1v7+vuOJqI5+Kj/aGP6YWkBJRerkRjSDUKg6
	 lnjKR8UBXmEoRnUZhOCe5ueeBbukagzw/A6u/9HKz5loqlLpFiqrBMIjLHxHYzwx3I
	 uGtZGcek8pos9kRtaacZ+gqNoFUrW+K+lEDZnK/3lF8iQUWpehLRWNzPwEhhVho26h
	 FNybk9X2yMk/g==
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
Subject: [PATCH mptcp-next v3 5/6] selftests/bpf: Use start_server_str in mptcp
Date: Mon, 17 Jun 2024 16:33:10 +0800
Message-ID: <bff5cd10f720c2ae836e4240dec02af296c66b05.1718612857.git.tanggeliang@kylinos.cn>
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

Since start_server_str() is added now, it can be used in mptcp.c in
start_mptcp_server() instead of using helpers make_sockaddr() and
start_server_addr() to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 274d2e033e39..d2ca32fa3b21 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -89,13 +89,8 @@ static int start_mptcp_server(int family, const char *addr_str, __u16 port,
 		.timeout_ms	= timeout_ms,
 		.proto		= IPPROTO_MPTCP,
 	};
-	struct sockaddr_storage addr;
-	socklen_t addrlen;
 
-	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
-		return -1;
-
-	return start_server_addr(SOCK_STREAM, &addr, addrlen, &opts);
+	return start_server_str(family, SOCK_STREAM, addr_str, port, &opts);
 }
 
 static int verify_tsk(int map_fd, int client_fd)
-- 
2.43.0


