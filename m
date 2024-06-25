Return-Path: <linux-kselftest+bounces-12612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2346915E48
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF25283681
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6A145B12;
	Tue, 25 Jun 2024 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8vRIstA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A9145B07;
	Tue, 25 Jun 2024 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294189; cv=none; b=XLPaey6zxbv5wRx4QUaM9uLt9hvox7obGpQuBFhxD0Sli6BKFwOGJYiEPXHTfMNe+iJV5Kn2hBLFiUmWgYhOh042H0rBKYySxkIyXtVG8Bmm0RiNU7QCSxVlRgcjcW56bMo2DW64vyk2V9iVyoTzrW3Me7JXkzrtDEVSrFikbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294189; c=relaxed/simple;
	bh=gUn5BqWp3IVfT5rD93Pb9hRJDCSQq98aPl6Spd2KWGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRQAqbb1uWLPnRe4htOyKwKR/5CSWjfda41fIgQNjcBpHlxdi22mCvvg3mC82wQcGfNba7v6Vu0tsxb4xRnndXvRKOcNvC3QCmousLZzGKkT0UgDOVBYUgdt1ziSg/brDc6ifu0Gz9Y2JLe8l5h4miTRmvywQNtV+Fq9mE+HuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8vRIstA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADEDC4AF0B;
	Tue, 25 Jun 2024 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294188;
	bh=gUn5BqWp3IVfT5rD93Pb9hRJDCSQq98aPl6Spd2KWGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8vRIstAzifUqhM3ziONznU3MTKv+Xva1YKK8brDPGCaQaWp8gDYuttTNNnO1OvKV
	 +T6/hxebD+OLAB4zoPE+hkIctpB+xEzmMrIUav3MHu+XnxnxRkKEOy5f01ToY949t+
	 MIZem/Gez110PR54TMs2H9eEoBMaVXALLhuNHyUyP1T1K3Rt3xk/IerlwKCtNaOreM
	 fqrXuWwQj0eyLtx8FeV6/nnjZe0TzKU/Izt6BmopizC5QLPSkENrldVApf21aHEHfW
	 IfCWbGGAoNOpyGDnv2EU3tDSBH9RVpE5SXFV5w0InNDUuJi+970davJFyOUnTh1MIc
	 doIFRv/1VPTxQ==
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
Subject: [PATCH bpf-next v5 4/9] selftests/bpf: Use make_sockaddr in sockmap_ktls
Date: Tue, 25 Jun 2024 13:42:31 +0800
Message-ID: <d1f6d6f0db4b5fe9dbff690ed5201ae5210f2c27.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper make_sockaddr() exported in network_helpers.h
instead of open-coding in sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c      | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index a6b0ed633505..34fdb1cf10f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -59,23 +59,11 @@ static void test_sockmap_ktls_update_fails_when_sock_has_ulp(int family, int map
 {
 	struct sockaddr_storage addr = {};
 	socklen_t len = sizeof(addr);
-	struct sockaddr_in6 *v6;
-	struct sockaddr_in *v4;
 	int err, s, zero = 0;
 
-	switch (family) {
-	case AF_INET:
-		v4 = (struct sockaddr_in *)&addr;
-		v4->sin_family = AF_INET;
-		break;
-	case AF_INET6:
-		v6 = (struct sockaddr_in6 *)&addr;
-		v6->sin6_family = AF_INET6;
-		break;
-	default:
-		PRINT_FAIL("unsupported socket family %d", family);
+	err = make_sockaddr(family, NULL, 0, &addr, &len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
 		return;
-	}
 
 	s = socket(family, SOCK_STREAM, 0);
 	if (!ASSERT_GE(s, 0, "socket"))
-- 
2.43.0


