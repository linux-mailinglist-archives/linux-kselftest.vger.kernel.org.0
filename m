Return-Path: <linux-kselftest+bounces-13221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE739280C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B9286D60
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAF12B144;
	Fri,  5 Jul 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I541pEWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF638003B;
	Fri,  5 Jul 2024 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148340; cv=none; b=ZoOAVYtuwFGEhacv2glZeRKftTgf7fcwHQ6iKsSnyDbAolKMNHqLwZGk76p/YMnrtxAGewQdjBK19eBVjbHRefYcqDoOlgpbDrjJJd25q465zjBQozhGqRfKN0gnj7/4lZQKYCqSyfqZC2EYJv+kvgk9wIVT64JxutxAFib/wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148340; c=relaxed/simple;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7wLnzIxaG0nIH1i1LC9ok9ezID986lAwjh7rAhlzD3bvxoBSUKRZurxm914m6nJ+dvOkspG14xx7XHHqiVxuTwl2gbRQe2w1iR6I597B7ArYOnXA6aU/A0kU9NKfz6OCmCsH+LJhiBPwFmXwnQqthxhEcimhVFuvNAZRIT5zHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I541pEWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1793C32781;
	Fri,  5 Jul 2024 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148339;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I541pEWTKzQjEJYp7yVnV+6IAi5JrpjY6vbyBQDQNRlx3FTiyJPyjd+M5sKb6aKl9
	 QzLnB+rPV3orChnmujuCKPbtfK9NnMhgmz3vJPsw/N8ZRTBvKmIEC78CUmT10s8UHh
	 XjqTdhNiHExDd5hERmq+1gWs80jAaU+xquOy6o1OOEql5IE5k6p1a4au54F7eRf/n/
	 zgF3yuQhG0v67hsmhnr8PdZJPWmvF9bfKHPzORgue1VJs2HSTu5Nn2DrbugmVhmzM4
	 aUvumvxLHv6nmv14xhtCuB17U/HcBjrajZDM6Ckk6HxLqo2m8re0+aKsCxHs5+4ZzT
	 8/M+RyyTNu2tA==
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
Subject: [PATCH bpf-next v8 3/9] selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
Date: Fri,  5 Jul 2024 10:58:25 +0800
Message-ID: <ebff67fc5cc118ecd392d2c755575986dab7c34d.1720147953.git.tanggeliang@kylinos.cn>
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


