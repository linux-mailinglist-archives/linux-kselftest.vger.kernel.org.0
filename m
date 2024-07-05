Return-Path: <linux-kselftest+bounces-13222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C629280C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2770280FD1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625712FF96;
	Fri,  5 Jul 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQqbbg+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE491643D;
	Fri,  5 Jul 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148344; cv=none; b=RD2t9pMavPCYzld4J5ySqAF6Mprkb7gSA7PR7a3HiHkM9fYcFhd1XK8OI0731Gp7GFCI68NNfP5dUqc1ZrlbBmbL3wEx4tC6OLIG4nfRJcqZUrZyjMxJEcXjme0Noee5BQfCExei/0J6sUwykAoQ42aDtVp35007SPRaJH6Cx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148344; c=relaxed/simple;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BP7DDIm9U5/6kzbgBtqXYHdEivnh6R5Z2kk57em34v80FxyT8Zk+ZSYc47WWGo5sy0QxBbOKdre8Meb4oi31sVf3U54nSykRlsaWml1RKma1dR+10Vd1VIOZaZjAVKwuV54oDH7Uz8VzbnPxaNRzRRaeD9KAnuhXC/oUgzgMhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQqbbg+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C5FC4AF0B;
	Fri,  5 Jul 2024 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148344;
	bh=rRP0ZiPRY0W17MVOWxZwWV5aU8LBd+K/G2ydWK7Wq+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQqbbg+sk0QyTpBtSmxKzH0Rmp8QEorxtlRf5inn+QutNg9Q5QKGQRP53UVmZ52LK
	 nx8cWcax9WQCdhOikz5w/KONP3wWqQ/vdBWCq+ALwtQTt3aGq302DdPRQi/0Sn78N8
	 qGIZXpt9xTSukWt325qVTaBtQpZQFkYey1YhufRhwfD/Gh9X3IxK51sbQB3J5OLYkX
	 Q2Jc1VftlbO3YsFqLoReZuy2m7Y8X9aELSeKrIx6Bs6KYvNQBS0JKnyiRf552Cc8z6
	 PoHZW2RrjgUi08rAraFnD6oQqTiSo1xSozv1fMpg/7Zb262wFCtl03KWiNkprZkDaO
	 AAXf+8SgoyFtA==
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
Subject: [PATCH bpf-next v8 4/9] selftests/bpf: Use make_sockaddr in sockmap_ktls
Date: Fri,  5 Jul 2024 10:58:26 +0800
Message-ID: <7125742ccf22a673a9ea66fa11eed0be24301516.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
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


