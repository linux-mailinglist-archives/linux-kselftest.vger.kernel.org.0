Return-Path: <linux-kselftest+bounces-12390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D989911861
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE42282327
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6A83CD7;
	Fri, 21 Jun 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk8FH7G1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD036839F1;
	Fri, 21 Jun 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936208; cv=none; b=mweJKtaa93ceTLfUm0zBlZcC6LJ5InzEarStQjNnwxUYuvz80/rSDc1TP6wJIp721Qwra3bBSyBup2ahpyAxL47OscItxwemPDNR8ZqcGZsgJzWFell4T81s0nidx3JsajejD5Kh+ujWvvc1pHgTiXyRDCgzds4FtuRC7Wiy+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936208; c=relaxed/simple;
	bh=4L7L69bO3cLNNHAsEHPR/xKiN1RgYuK2kpulcYkJTck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEsmUEHv4QD+2iJ5iVTAHNic54+9oSaCXkEBgmqavcYEreacwcY4cdbXzhjNk3xU3PPkhmsSnkJUf4rRmqXxBarkurDAOti3BG2eL0WzEAxrgMj9+Jx+rfYUAQ/ylze/nWBiIqIo4x5AdISOuVZ0anu8z+N76RiQEx+oZPnlhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk8FH7G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F095DC2BD10;
	Fri, 21 Jun 2024 02:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936207;
	bh=4L7L69bO3cLNNHAsEHPR/xKiN1RgYuK2kpulcYkJTck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wk8FH7G1Wwtc1fUhc7BbEPfV4g7+lcKzOdjUb0BrbwApAnhrcP99MTpkawe7CvxxL
	 e+iXxV79v2GgPPzzKr0JO3izeMdohZLYik5GYKSzknltCUkA+2+7J8UPE7i4lXOZIx
	 wD1enqt09obxOMRfsjRCodBaDKkMnpmdfFtE44dFFLjNax+loiRTv7jB/5eezHrGHV
	 ZdvBy0g540KQvcTEkYxrMWSeram9n8U/Av/qfIV7OfMVZ0nxYcbXPK5T15gCDY2bEp
	 WXDfWDW77wJEMNJfEbuzKKL9gUtOxlbD5DtqSsNbbEbiDclrHuXQhcNtL4c7tjJy94
	 MSuVQcCOboLwA==
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
Subject: [PATCH bpf-next v6 5/6] selftests/bpf: Use start_server_str in mptcp
Date: Fri, 21 Jun 2024 10:16:02 +0800
Message-ID: <16fb3e2cd60b64b5470b0e69f1aa233feaf2717c.1718932493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718932493.git.tanggeliang@kylinos.cn>
References: <cover.1718932493.git.tanggeliang@kylinos.cn>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
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


