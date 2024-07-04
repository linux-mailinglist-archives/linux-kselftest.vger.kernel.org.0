Return-Path: <linux-kselftest+bounces-13192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DA927295
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA31F21F85
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42F1AB537;
	Thu,  4 Jul 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy182bbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA2156679;
	Thu,  4 Jul 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083638; cv=none; b=gwb6Gap314VFrIlnNc66cZGZUyL/ZUNfxkSWCuk1QyeQd6u/Hdld5e3M/8cPQfgKWlSWu2hejjC51dEmmuhcYJQceNHkivpJCosKyT2v3jIU7XUpQSEpIeTVPa69BKOSO6EHNw0pST6LOY740jHde2dkkoNiLsTXdLghkGLIzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083638; c=relaxed/simple;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwIilaNX5qFGxyMsLn3DR1db0Ymx0ksEnqddfG9f7SVMaKnl5Ga3KxnmCs7QS9RcSFOW3A1D7Yd88XVAn43kJ6IsAV1+7ZblW0UKBrg86vsKAXXpQuQkXFpQ8D1e3c3uz8jCB6/vEsi64Pf5LUl1m1cLw9z4N5A8iSOSu7UnnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy182bbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C8C3277B;
	Thu,  4 Jul 2024 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083637;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wy182bbPQ7a51xlnDxYIrYjZLWBRqz9x8Xefvqt4IHchquH+PFypnfoBy1tElBEKC
	 DSvWkDKp1ACt7rWacpDKHeGbrAjuk4cXl4RSaXPh/ZQW88YXM+QgNAjGEZlMfsmt+7
	 hJWmVFzTlRIHh8zjM+9xPyDtN1/pvID3GYw1blBIH/6eCFZR6iXiGLFyq1U8yKW8MJ
	 zb/F2QGacMliiAWLirwwBsrZgOWczmICCZiUIfeTKX5vGHgvA+6D5smjcCeAoZ1fKc
	 CP4oQRVfZ0rGuUejhqFzKH1AErscUMrMNCNAEl7OfV3V58gBXEsFzWMM4a7LREyWy1
	 ancnm9xSMO0hw==
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
Subject: [PATCH bpf-next v7 5/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Thu,  4 Jul 2024 16:59:42 +0800
Message-ID: <8f05f5acdf4871454ab052ab39dac22fe6e5d1fe.1720083019.git.tanggeliang@kylinos.cn>
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


