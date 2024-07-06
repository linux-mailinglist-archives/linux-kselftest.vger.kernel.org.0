Return-Path: <linux-kselftest+bounces-13284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74192942E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063D6282DAE
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2DB13A41D;
	Sat,  6 Jul 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6WLIpLE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4729CA;
	Sat,  6 Jul 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277255; cv=none; b=RxCf9BAX1XwjlOOvjv643VmLpg3UZ3VmkLAVluCHrBfMAqVwRPAZagXXu0N/C0L97idLMdvg/AW7hZuXF0F+q/Dq8PT1MjRlympoCir2/e4nku3N7cBVQBR2no+TCf93jUDiRNTT6O/A8SYvtHuFOdyZo7G+uP53P6PmefgT6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277255; c=relaxed/simple;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq57szo1vC3ta2J6NhEt/Xf+6zjZ2sPoqDQ4NrMhzfL6wUzCBNYcsOPWGNgy3MnYX8Nqb5ESjqO71wKoOMlYL6wNUjqyBrn3dxMT0biSYooaVZ7OkMBF8ZV3yK/zWA5althWpeQDqgS/bQiDQyUwPImXO6OLieIJj2P5nSawRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6WLIpLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9C8C3277B;
	Sat,  6 Jul 2024 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277255;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6WLIpLEf1my4HtXFesxjp42Am/DT/2k1aB46ArhgtyX5SwPIFbUrHJw9rFUVkaGf
	 G2NJJZbZf1LcahfO53A2bJ62qk9/Jnp1kenBHiRil8qV7UW4G9agj3pejgLp/318FR
	 bDU2cygtr9UyWgk9Yfrw74p8uy9tEr9I6oc0lgusnAsZR0lkdOkiMolty41alkHbWQ
	 d17inRbZn4Bjy+tZi+1W1JAzrPB9YnxOEbEkWGtVT3gdhM1qAZYy9pGt7p81m6TEzk
	 HEEDe5LEiR9SP/VSv+bKQtZgtsOU07xU0vcHWZOzoGISJuPehsoqyEtrnUjDR145bb
	 J4/7U2zZSJFfQ==
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
Subject: [PATCH bpf-next v9 08/11] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Sat,  6 Jul 2024 22:45:53 +0800
Message-ID: <f8dd478f3d64ba1eea5a17573fc518a8cf83adbb.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720276189.git.tanggeliang@kylinos.cn>
References: <cover.1720276189.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Server 1 fd should be closed in the error path when update_lookup_map()
fails. This patch fixes it by goto "close_srv1" instead of "detach"
lable in that case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..de2466547efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -994,7 +994,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-- 
2.43.0


