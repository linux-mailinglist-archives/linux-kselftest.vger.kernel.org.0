Return-Path: <linux-kselftest+bounces-12958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062591C9FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353B11C21917
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A521C17;
	Sat, 29 Jun 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGSXC588"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C0184F;
	Sat, 29 Jun 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624051; cv=none; b=naUKKrk/OxN5uV3ZXR87gnJTyXWmKhspuF+JejfcXCZAdkkIWYa3gfeyVyQL/Mc5pJYTRP9ZUFCvHdiLepMCCCAGBlAFHgPhIMm3VmfJNJoGWiLbd26WhhU94C3+8Q+hRPdGy3aozUDNw0j3TSWuAzJYiaFLxOdjO/qpJMJCNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624051; c=relaxed/simple;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHxo+QcamrH/s93sij3Ike7ea/pWN6hOCKHyAYiL869fgWTI8MDmMYdACLpxsTyVX8shxevrGwNpjK5H9cIvL0hT5xm7Mt+W/MR3hl5aVZXqpKCJzxcAhJxpWgXqwLk7QMrkDV46JOwjzqZWO4hYaK5o2ZAhc/Oy0+u3CSmLKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGSXC588; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9617C32786;
	Sat, 29 Jun 2024 01:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624051;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGSXC588rnCG9YFkFrPltWMBr63icvRQHXa3VjhC1bc/bviwhjjSGh/AspQKgfNyW
	 5WCIYmD4O4eazNxiZ1SC6SCJZU3vBwEbTEqxzNMwaovcuHBPMI08IlkwuyGSxtHFx+
	 4QzObrDXt0Pdzu8jcwzn3HnX0pyi4XVlq+7npfg+Q7wjRIrpfMPdnf2utImhHejOPA
	 HMk7JbJs/QX2UnDzH+2AMY13x0DgB1IJFJ0xlCgKIAneJ4nMXLrCHpNRr3KnXb92Bg
	 06mSyjdbTg32XS2QB//93bbLleVdsuPjjyCcPH5cCk/LQjnIA0nwnykhlNNnDTgW8j
	 FxiWP/Dtj/Y5A==
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
Subject: [PATCH bpf-next v6 3/9] selftests/bpf: Use connect_to_fd in sockmap_ktls
Date: Sat, 29 Jun 2024 09:20:13 +0800
Message-ID: <98ed2cd91b180e637c8011b8d035b4d8bf57abc3.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use public network helper connect_to_fd() instead of open-coding it in
prog_tests/sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 4dc7933bb556..a6b0ed633505 100644
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
 	if (srv == -1)
 		return;
 
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
+	cli = connect_to_fd(srv, 0);
+	if (!ASSERT_GE(cli, 0, "connect_to_fd"))
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


