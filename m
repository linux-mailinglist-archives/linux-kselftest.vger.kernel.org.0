Return-Path: <linux-kselftest+bounces-7649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB58A052F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4931F238DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D05FDC8;
	Thu, 11 Apr 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctBpuiSE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E73201;
	Thu, 11 Apr 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797432; cv=none; b=JfyPw/+z9iJktYimMOOTtFvFs6LeIWGCctYFehAgznk6CERWgLY+IGw0v15RNobWkypbg6dN2FFJ/zqoGdRVX/G3vuw/aDv8az00CNB/D69pxrEuvdDMLKEsYFXw/np1kVGtIGh0lZuZ2JOSVYYckvXGPSYRRqdDT3J7WmWfIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797432; c=relaxed/simple;
	bh=UoddJk6fHo9GNGgLLytEAkLLAyBEiqpzG4m+11ozUEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5xaaknP7NNNCERToUmTcy6IYE32wpwQwxq+WVUvSMsqvgqLgU+gCPp5yAICrSr+6uSt2sEuQftxOXRB45z44AeO16PmX1kWEjjMf2p/U+HUybJ1KqOYe1wWMxS+JEWzqY1GWcCK5ucgOwhItUGRic9zfdM9YAeWjDnA4IA3TJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctBpuiSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B79CC433F1;
	Thu, 11 Apr 2024 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797432;
	bh=UoddJk6fHo9GNGgLLytEAkLLAyBEiqpzG4m+11ozUEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctBpuiSEdwBBYB/XB0RjiaBlAsjFIV7r72r5dphV2PkC7jHqnzm3pz5AqOgPELQst
	 JUsyaZYp2kTT8kk7yE/QIXAWd8CI6jX+m0BkJK4t30UJrOqRT0RLCuzQXTqtL3a7dv
	 q/D2jsQcj3QUc7x10Ietj7CnuPyFYUPh8Fs0AujBgC8ib9aKAPt0PGdcmbx9znO6er
	 /3msrx048zic0UsRD4NFABCrP3d0cayQUdM+NZhBPRJjkkgLp3cmtRCv5+gXKNFNDc
	 Uf1BDMbsdBB69tq3hzvM83zDYrD3qL5wZTkojRuKjVVcsflb3V2TWyXdehes934DWc
	 Twm5I9mXU1Ftw==
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
Subject: [PATCH bpf-next v2 03/14] selftests/bpf: Use connect_to_addr in cls_redirect
Date: Thu, 11 Apr 2024 09:03:11 +0800
Message-Id: <2a7bcd02707cedc3f9c2a52f81f531500f1d5edd.1712796967.git.tanggeliang@kylinos.cn>
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
in prog_tests/cls_redirect.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 013051555ce6..4b185b608fae 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -36,22 +36,6 @@ struct tuple {
 	struct addr_port dst;
 };
 
-static int connect_to_server(const struct sockaddr *addr, socklen_t len,
-			     int type)
-{
-	int fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		return -1;
-	if (CHECK_FAIL(connect(fd, addr, len)))
-		goto err;
-
-	return fd;
-
-err:
-	close(fd);
-	return -1;
-}
-
 static bool fill_addr_port(const struct sockaddr *sa, struct addr_port *ap)
 {
 	const struct sockaddr_in6 *in6;
@@ -89,7 +73,7 @@ static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 	if (CHECK_FAIL(getsockname(*server, sa, &slen)))
 		goto close_server;
 
-	*conn = connect_to_server(sa, slen, type);
+	*conn = connect_to_addr((struct sockaddr_storage *)sa, slen, type);
 	if (*conn < 0)
 		goto close_server;
 
-- 
2.40.1


