Return-Path: <linux-kselftest+bounces-12538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B319191411D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D1B1C21680
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFABCA6F;
	Mon, 24 Jun 2024 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBmMieM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622FC8FF;
	Mon, 24 Jun 2024 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203692; cv=none; b=HOpyvFTfb+QU7Sf4KmZXuNHcefUSWlJwtbZWEkM9U9r2jo0EzTZX+zuhWB2WB4E0qJ0oj67aCqb8O58yPL0AQifkxniD7M9gXGl8slCMapui9jQbU1dkeKDSyoSpCkUXnZrmhl/OThruO5zIOR9h2AIiUdStaMrqdu3QVMZcsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203692; c=relaxed/simple;
	bh=QDEh2CYMbBuWgLm2dE1VLkBeQTd6vXFkfnNF78tpSvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKo6jUYXHvNUSzcl+k4hpKmetod3m+d11Z/CoNAAr7AEQxkP3jvpJjrMPYWaGAN8F0pPS6qqZ97fcYMnKVHorl6ScfqG21t3lHUbckwQ3+B2mU3qHRr1+RtDgJgEzh60jBK5bIe84ZXIsVtCbSDAh8ybcN5Lcu6xTRONrntA4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBmMieM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEA1C2BBFC;
	Mon, 24 Jun 2024 04:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203691;
	bh=QDEh2CYMbBuWgLm2dE1VLkBeQTd6vXFkfnNF78tpSvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPBmMieMC1Zbf+SSuCKJ9pX3OGnZAONyMBbq9rv16ocf9ln/TdZw1DfWwj1m4OiJw
	 6XhMW44XtZ6NQ5DpufQYtXCG0lOvpVLB35NEHoEV6h5T7LEwupJTWt/9KRt/ewOiBw
	 0OEK66g5khKIp85i4LyJTPVrHkUyt6OGF8faqa7VToLKXpnJsVrmWunBX3RLOim/kn
	 94ePu6UwGyB5OEBPojfaHnEToN+ufWXlXOuWIwj+E/OpOxGOJLbvlSpeq6Oatk38vc
	 MJWybva7aaS+UMzmFXILgv6vgjLlezSqHEvithmPAbnx3fTCckfpHmKqDqAgW8wlLW
	 Knpi11q8xb6sA==
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
Subject: [PATCH bpf-next v4 4/9] selftests/bpf: Use make_sockaddr in sockmap_ktls
Date: Mon, 24 Jun 2024 12:33:51 +0800
Message-ID: <7f6985c0ad1c031662ff677b6b4be5f51f920c4a.1719203293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
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


