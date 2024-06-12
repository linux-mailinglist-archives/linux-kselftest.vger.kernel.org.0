Return-Path: <linux-kselftest+bounces-11765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB190556A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A032E1F21981
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E617E478;
	Wed, 12 Jun 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu7UmvED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B017DE37;
	Wed, 12 Jun 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203292; cv=none; b=Jt9GRWcCnlDJqK3JeAzr9egfthi7KoLMJn9tLfGggx8hCgZxI092V2muxHEyMYeKZpxV03iIc77RFEvuXuvUbx9g8oQRVxdxzbpUQ1OhnWw+6bEnsp6JNRhgkJ6oRBN71aLf4j0lfSD86TXS+C3vrADnf9qaHS1N/3UF92LeVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203292; c=relaxed/simple;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV73BkO1lhyvet8+ou3W3GMN1ZjfoRDst9ZPjsLl+yjc4rSaTi3lLMQfMzlejUu+8Q5zRsLfq0CyX1cAIgMTGhTMBKqf4gasxbSxEdWxfi9GepTNV5jSEuaIvhbDuSnN5AJSyiAgFMrI5C1MkINbN+TUht9fOLs4+jTVsQebKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu7UmvED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5095C3277B;
	Wed, 12 Jun 2024 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203290;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lu7UmvED/y1SwgogW42zHKJGREBVJYgvhOipuuogJpeB1RzS5OojTK0A8DoO7OoMw
	 x9oEJkb9nSasx2jau93ZECb2QgPZBWCtCPEQFATP8Kyf/P1wP7MPFmNboanAHNOWBu
	 BCgsQHmXLCciWf78IewcLjMq/cyi5fm1HQ7ODILjFeRLhVaiPXFkr2WOb8E/sjGAVv
	 UhRSmrBvq9ooInlW51Dj/CbIH9JTnJ4JxyNUNTWThEFmwQfCZYf7Lx/PMqdw/gfOlr
	 2quSqIwFJvHjcA6JSpCj0fFM8+ehFpzlkTrR9Qv0XfThfnslWjliUknZMen8jY2xr8
	 q6Nvj1pbqHIow==
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Use start_server_str in mptcp
Date: Wed, 12 Jun 2024 22:41:05 +0800
Message-ID: <f322aa40af10c745da21f2c88c8b2a5b6d55016e.1718202986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718202986.git.tanggeliang@kylinos.cn>
References: <cover.1718202986.git.tanggeliang@kylinos.cn>
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


