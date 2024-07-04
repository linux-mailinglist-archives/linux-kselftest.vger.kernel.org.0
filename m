Return-Path: <linux-kselftest+bounces-13190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDC0927291
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FCA1C24D40
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E51AB51A;
	Thu,  4 Jul 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzyAhkrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D81A4F25;
	Thu,  4 Jul 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083625; cv=none; b=FLOYgyLj16QwYA1NaXkeuxxPUeOvCokNnxC202EOTX3glMF1N7u57CLoF8WWZwiOGgIflJhq3lgS4QevbGBUCqqJ2H99Rp0kRmJ7qPgDlkWoUSJTcAAoYpyJ9oJzZTyABEJ/tqpvhGuIxIrbmwhZyNm+/cF4aD5KTboOZzyK0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083625; c=relaxed/simple;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5E9fTMqBNEhfxkUm4wmQq2w5+kn439FePALAsrwQPZJd3KeVixW0mOEYhPJzg1UibRl7iAyGOFYg/mVMbu6kONxu/7Jet+6GvcTWejPHyrWf/3PPAsYJDYDxvD6vAINWq9sAlaRKdf9/wMtV+FJqkCMZxWvyrhigRMY6hNqiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzyAhkrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9888C3277B;
	Thu,  4 Jul 2024 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083623;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzyAhkrGQQtCpKK5yM3WQfivzUjx80P6znJ0QRTS4E2T1d31unM0dnxbQE5eR4Jn8
	 +S+cuOAyPH+AinUG44coQQxXKpWK9f7niDPj4vEM2i2jVqQYoKeMG1PGkH96jhPwV1
	 Omth95rupSqxZ+3h/jHaedf/MQh5OxUZJggR2zmfw/qQsjq8NxQ7LTeRxk7iIMtu9c
	 ojzxSxBQafaKEt6nZE77V4Kq/5gMBUb5cFNyDHBNxDbHKKRYzc5QGmZZGQlksM2GXj
	 jSbLoHOmBtWn/WUehgVyl2mFLCi7mTNY3zurLGjTfqUIfLPxGz834b2oHNxxJqZRl2
	 J85K/O+gYJDNg==
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
Subject: [PATCH bpf-next v7 3/9] selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
Date: Thu,  4 Jul 2024 16:59:40 +0800
Message-ID: <79a880e0114603d720251357d918100172959120.1720083019.git.tanggeliang@kylinos.cn>
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


