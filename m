Return-Path: <linux-kselftest+bounces-13354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E192B37E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB01F22787
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AEA154420;
	Tue,  9 Jul 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGN5wxwc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96E15383C;
	Tue,  9 Jul 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516641; cv=none; b=UY+VdPV9zs6Oz0QckSIBDkuzy1VuLU4V9i8IpcopAJtZswzmmLDXryfZsKK2bRrPjmdgHippAljSB3rtudcKhgyZPfct5Y+ZXVanla2VzC1NI+w6hu4KxYxVnsfLZ43wM1UsNCTh1SamLx4rIGDe6UFwSlnbnmjcHddcnSKxVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516641; c=relaxed/simple;
	bh=obV9apooCgZ6Dwx3T8r2jSXX7I/NFkL8m08yFMyG2Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jaz3jxcul+4HgUmPozLfAIwwh6ZWM4hBIxqlwy9vT/0q0Yd1/86sy+PT1NJsY/A3iqdvNtzUjIK+lP5qefEGAVcZxlZNl8WU6p9ws9g580Z54et2p2hYre1vBY5awS6/rdIyaApOx0pckzGRazLY9AvCDjF5URFpJFg9Bca7pa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGN5wxwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E756CC4AF0D;
	Tue,  9 Jul 2024 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516641;
	bh=obV9apooCgZ6Dwx3T8r2jSXX7I/NFkL8m08yFMyG2Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGN5wxwc+IZz5jDWLTLxRFREEqlRScoL1bGIiRBHXkkZ+aK/GmlYe/k8fQjgnPbHq
	 5IS7aMxy3oSmZ9/UA102oVo6JCeGprJ3LD/zJJwbOAYz5n/qStfWASeRm5ccqdtZBU
	 MBVcK3vP8eUGcNb7ACgZ+60QgX+m1wf/q353wJeXrE1TIVgRByE5ujLnU9cQkcjG7F
	 kXcyoFI7j3ST2/kcu7CD2pIpyYw1js3u1di6IfxcM4S4iogTK7PC9akun/1rVW08QR
	 9/NA0rb/fzKfpNJiOEog3ZaiaW769IAiKvMsRMKJ7L2w8SUT3fKmIOfGhWOEVzrhjl
	 naIytYAxQ9wvA==
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
Subject: [PATCH bpf-next v11 6/9] selftests/bpf: Use connect_fd_to_fd in sk_lookup
Date: Tue,  9 Jul 2024 17:16:22 +0800
Message-ID: <7077c277cde5a1864cdc244727162fb75c8bb9c5.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_fd_to_fd() exported in
network_helpers.h instead of using getsockname() + connect() in
run_lookup_prog() in prog_tests/sk_lookup.c. This can simplify
the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 386e482be617..ad3f943cc2bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -633,9 +633,6 @@ static void run_lookup_prog(const struct test *t)
 	 * BPF socket lookup.
 	 */
 	if (t->reuseport_has_conns) {
-		struct sockaddr_storage addr = {};
-		socklen_t len = sizeof(addr);
-
 		/* Add an extra socket to reuseport group */
 		reuse_conn_fd = make_server(t->sotype, t->listen_at.ip,
 					    t->listen_at.port,
@@ -643,12 +640,8 @@ static void run_lookup_prog(const struct test *t)
 		if (reuse_conn_fd < 0)
 			goto close;
 
-		/* Connect the extra socket to itself */
-		err = getsockname(reuse_conn_fd, (void *)&addr, &len);
-		if (CHECK(err, "getsockname", "errno %d\n", errno))
-			goto close;
-		err = connect(reuse_conn_fd, (void *)&addr, len);
-		if (CHECK(err, "connect", "errno %d\n", errno))
+		err = connect_fd_to_fd(reuse_conn_fd, reuse_conn_fd, 0);
+		if (!ASSERT_OK(err, "connect_fd_to_fd"))
 			goto close;
 	}
 
-- 
2.43.0


