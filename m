Return-Path: <linux-kselftest+bounces-12204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBD90E1C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D3BB2250B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD884F5EC;
	Wed, 19 Jun 2024 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOMQm38c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BBA4D9EA;
	Wed, 19 Jun 2024 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765778; cv=none; b=u0U+FrlEq15jn55/l4DI0Se/O16U/3J6OHr4sdw/0sgNBvZNKJTVu81pK30vE0JsuGRJE+tppVEX+2xUaKh0vaIiDub22ZZoXHHzG49V8HksasCvyzK1/trT9haCLJjfpLmQLzzz1g9mVfRuk26TCeHhoPGxh0BrHeGWEp8hW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765778; c=relaxed/simple;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsMz0M31UzNPlVWsUyKEKlD8Zq0fs+151IkIQBeWmlL95sVFsnTYv/Mzd8ies1fzSrvcXnVYYJzowV0szf770AvI6MlFi3i9LBaHjrabSvNtgXSyKzV9zksz6fbPA4Z0Em17ZeCm4ycQ0gUtEgeIv1LMRgiKkR5SFGdSfNXMTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOMQm38c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A36C3277B;
	Wed, 19 Jun 2024 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765777;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOMQm38cBaEr8Hem7RNQIHZrKrKmj++qsB4gAObXiuyfYmS4w5HlC4xnLbC6al496
	 xeS2c0HqAVeWlqZgIsS8mVhm70UEXdyopWpUWVu5U7XEJrXM5T/JRvqOCjeecZo7Af
	 DR4ebN8eDypeYho38QF2KiLcczdAX2ZyV3bRQjT95v2IW1uDYAsL2TY8BpVugs59r0
	 OJN9pOgCXfl0lxWYr3O7nbfSe0m4MT8CWz4YQ8vqf85tDODuf+E6LAOGlEFHY23Npv
	 5c3LLm6sAcZ1UkQfNQkF7u/J9bhrswMRCaJ2bB665JYB49bDf4CVi734oKLtLYPm+q
	 j3LhncS68fF8w==
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
Subject: [PATCH bpf-next v5 5/6] selftests/bpf: Use start_server_str in mptcp
Date: Wed, 19 Jun 2024 10:51:10 +0800
Message-ID: <036689d9095857f6b1b4b00e41c6d822bacc9870.1718765124.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
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


