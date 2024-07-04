Return-Path: <linux-kselftest+bounces-13191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BA927293
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3681228D813
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051F1AB52A;
	Thu,  4 Jul 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNZdpHzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F25156679;
	Thu,  4 Jul 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083631; cv=none; b=Jw9MTNeAQ6m0ImXkd0olQL0x0+OHMOzV6IAf7aX6AiDrZJfQQpLLH3cWLr+FeEWGUH6jRtSjB+IkSKLXUVYt/wEku1V6l2KCVPbORAOzocsSXmWvt/6bQOkiMsyhOg23Ga6183YNsEFQm9XA4SXI0oXOCAvQ+M4CcmGq4MPYLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083631; c=relaxed/simple;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw56BOdKaxeFgv2Dp1OJnKMQzBWDu+czuiOUXJUpbwyUv16XTmCKiKOLI1z9xZVGTHwGLF+Y5MAFZZ5MiE+7q8KpMfTiuPWE9BopS7kbgcQKfZeJKrF7rKbyJdTx+OI2gHquD0Y0+fFpQVN/+touv7e/cMdUbfmaMUx1z4HWoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNZdpHzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C955C4AF0C;
	Thu,  4 Jul 2024 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083630;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNZdpHzdXQQ9n9laDUm85qAEqNNN5FqrS1g3GaeHLOxS/ppKUI5xuoRRYI7B0ty0X
	 RRrfwxYBWIlDjWJugSXfhn5ys1t1IKr9SivcQdEhPE2aM3R/3YgHwyqqSZS8+TXv9H
	 IxRneINFtvrb5igKjMCRfMNi2QrrSoUCrF8yIrAQMYaqB01zhFOfMYzCTywYRwvmcK
	 S5McakVtCLscij7SO6jHKQlD6Tj/4W7y0X5/6A7RG+VW0ud9C3tJVFmfgtK8vKHMcV
	 3CKn/2a6UVBXLE7ifIe5DDjH4dxOX4Rb81ok+otrFmPxZc8u4mAwuO10NferOHQfDE
	 +V4Xssxa5P6PA==
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
Subject: [PATCH bpf-next v7 4/9] selftests/bpf: Use make_sockaddr in sockmap_ktls
Date: Thu,  4 Jul 2024 16:59:41 +0800
Message-ID: <cce353551aa0197a6233774d4124b6d4d09bb815.1720083019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720083019.git.tanggeliang@kylinos.cn>
References: <cover.1720083019.git.tanggeliang@kylinos.cn>
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
index a794aa688ab5..3c223601e8b6 100644
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


