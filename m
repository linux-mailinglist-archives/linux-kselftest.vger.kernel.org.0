Return-Path: <linux-kselftest+bounces-13279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B13929423
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2EE1F22003
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6F13A265;
	Sat,  6 Jul 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8or9wjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC649811E0;
	Sat,  6 Jul 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277220; cv=none; b=VxHWEXd0pa1oFhAPCDiHjMCScMMMlItFsPcLBK8tBkIbzm5QJPqrCQjxqeNJ24lMdms7OXm4DF+64JJQumN53/xl96480JLbmO0EZb8XrluECMabCTpR6vtVvz9VSltAg8SdyPqEVDqCb886A+2oyRZRD43zIa9oqCHJ8WxRZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277220; c=relaxed/simple;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlg8A8TdH6/Jwr71DMtPdDKifRjeVL0RMUEGn+EEdOMGpHQYNldFdzOS6N+Yp4EtchK5PBPBTgw/EXIKgBmQXiJguF8z/zIGcl07CD68YSJ9WJnaNCzpzKMksTCe3OxhevPmVluU/6ZDP0MmelOS7gImogJloMnGNogHZmh40eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8or9wjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22112C3277B;
	Sat,  6 Jul 2024 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277219;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8or9wjWAzS9UaS9BoQiTLQ0gJQ0lZ3FjvK2f4+tW03DDOyboHopvj3prnkbnRbvl
	 jwPAtXBUNboTOJ2hCA0Mw1tYz45/pUP96EJWsBTB0bSCLSspK8dwPzO2X3/quEu4vA
	 SdvlirgjMqe1MImySA+DmVJc6P7I5STtI+FnIESGx/s9AAKBckyY8nOlw1MrD7mo+y
	 N0PzPXM5HOWhTGzcK9KUyPh49dU/rAHkJI9rcc4ALrlc12OG3lMszWuej6MtpoBmfG
	 IJ8Jeewy6JLaaFV3Hr5PJpWtQAGkugB5H50w5QJHpg9IxqWkDR4TuBQ5Xp66+YX7M7
	 KbXamUIWmKaMw==
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
Subject: [PATCH bpf-next v9 03/11] selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
Date: Sat,  6 Jul 2024 22:45:48 +0800
Message-ID: <ebff67fc5cc118ecd392d2c755575986dab7c34d.1720276189.git.tanggeliang@kylinos.cn>
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

Use public network helper connect_to_fd_opts() instead of open-coding it
in prog_tests/sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 32be112967a5..a794aa688ab5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -24,26 +24,16 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 	struct network_helper_opts opts = {
 		.backlog = SOMAXCONN,
 	};
-	struct sockaddr_storage addr = {0};
-	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
 	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
 	if (!ASSERT_GE(srv, 0, "start_server_str"))
 		return;
 
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
+	cli = connect_to_fd_opts(srv, SOCK_STREAM, NULL);
+	if (!ASSERT_GE(cli, 0, "connect_to_fd_opts"))
 		goto close_srv;
 
-	err = connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
 	err = bpf_map_update_elem(map, &zero, &cli, 0);
 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_cli;
-- 
2.43.0


