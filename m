Return-Path: <linux-kselftest+bounces-13296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA479929AD1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC451F211FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A751524F;
	Mon,  8 Jul 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6JuFKcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40183538A;
	Mon,  8 Jul 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405832; cv=none; b=j3uP8wZJXbmh6vGx7Yi/x45RgWh9kqcJSib8hRO6mTA6PQn+LA+S5/KQDRW810stiBQh9wje5rfQmEdmr/SYrsRbKHbPohTA/BuZkXVCWtx/30XDIyFnabuhKT2j5fUq0CwbUPILAsPDsIINXK3t5jcNQzIK75/kYg5c9hWl4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405832; c=relaxed/simple;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEpDpxrBi88j2Wbg88oE0cYeLvXdPDfj3+o2g7VAIQxhxpTjxgh8p5LJRvL0qIBBzA+YXQl+CoX7sBIkUEHEeuOI5kFl+kVph7S05SupwVrTVOdWekvnQk5HTCfXaZP90pdSDn5O4VbOCmc9AFEexQnPHrigdb8i6OYZFWClVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6JuFKcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB85C3277B;
	Mon,  8 Jul 2024 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405831;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6JuFKcKg1FWqh2nKb4KSB6piD37DM6ouwUy8vi29FPd2TrxbRwW3qYw0KeYqM2YQ
	 N7dbiS2lFbCDaVQcY+NIHmkRXzqRHX57VswimH7UT7YarTraF/Q3t4qBDjQCF1M6IK
	 axrFsCeKBZ11WRsuh0XjHbGmKBAtqfzHVhkWzdxUIo91CnXUhRUMX3DT0d80lfZFxD
	 8y08DBBgHhvrhXXYccUXzyDFSiwm47q7HSg7arwllA15gd8yxWEtgWJH/cN00UOffU
	 Cb3zlxbAKYZUnZRa5M+Ng1BHMGG4t0ilW80wrRCcdU2XOjaYIJDhAYQauKe9h70wN4
	 y+yhRK044UEOA==
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
Subject: [PATCH bpf-next v10 04/12] selftests/bpf: Use make_sockaddr in sockmap_ktls
Date: Mon,  8 Jul 2024 10:29:42 +0800
Message-ID: <8de45e7b849e086e4b91ee30c2896087f4e73a27.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
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


