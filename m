Return-Path: <linux-kselftest+bounces-12123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2890C2B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E9C1C224ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40815532B;
	Tue, 18 Jun 2024 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiY5zGr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE071386A7;
	Tue, 18 Jun 2024 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683690; cv=none; b=gAWk9L8/CaDGtn/g3KgOLxJA/J4qcm6uMMgf9F/O+bLpkuq8n2OC8f6ggspR0HmrdlBF8TIWdnxyteHQoj4nrTb8HFMI2Ho0FcFInQrGqf/0A6PMnBaoVD4qxYgXFopU+gLbRaMG6e1eG1SXOC7P0xKJCg/rZVOFpiFJTT89V5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683690; c=relaxed/simple;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfL6MboZ8azZBvPy7L/GgiNL7nOPFY68KZGw3iWYLH/X2vwL2qBv5m/v6BLAmsn3eNk/E8wNZrgSZEUAty+E9UvqmP/pVyluuphfguLBdu4/zDcLfWAjf+Rfzz4Cg/TLgquQ/ql1Rbu8vsXCyifvPSLEqGjmPZzoEfYdUqRxdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiY5zGr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE6C4AF48;
	Tue, 18 Jun 2024 04:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683690;
	bh=QDeYipd1o0V9wiiSdEf3dBRvIuDzcvSCSFdjltKsxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiY5zGr1X/TnIOkszWyDmNWOqvc4spKG03xPir5P9cqjFF81PXMOmD6Z3gqYrUss8
	 gYdCMnJrfEEOBCOquX4mqhfDS75XbLN6vm1tniPMZj/79ZGosoiDsE4MA75/Yhw6Go
	 wvzgbXn34VAlsmewuMtlr1ZpRmoMVePm/Wb896YTsekMdWUoK5GJGoM+MPzfI6K2mU
	 SUtPGrYgPgZOIu+1JVq33GeaTkDJlj67EZnNCJn45kPWGU0jtqkiTg5UVWtphclDmE
	 JpzTX4tX02XISK3x4bbWVMcn+ngjqgpe9c0eo+uJ0PhGkiDP4XTkKfcz7kivevYGe9
	 kgpgbuWVxx90g==
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
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Use start_server_str in mptcp
Date: Tue, 18 Jun 2024 12:06:55 +0800
Message-ID: <e646347ab17766fdd77739973befbe58a744b2a6.1718683292.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718683292.git.tanggeliang@kylinos.cn>
References: <cover.1718683292.git.tanggeliang@kylinos.cn>
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


