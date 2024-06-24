Return-Path: <linux-kselftest+bounces-12537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90791411B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7D91F22A42
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7BBA49;
	Mon, 24 Jun 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD7XCC/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9ED529;
	Mon, 24 Jun 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203687; cv=none; b=bGSpCpPp3N67wxO5qJWOmxKcUoby0vIDL2kGE6DxIFTzOo7OQLZX3LPflqgesgFhWm4gfvCqQdaNovFFzuxMCor4Zp/ml2SBIcukUtd86JB/KrQuwtnckuudyriUwAoR2jWEc/8FXHUXBMED7a5xf0r7vvZGoGoXEaPS/uL5VpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203687; c=relaxed/simple;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeIwpRISWYQ+WpUyafCp/n5dvg98XaTMXAYtQpHg/924b+aqoYJ3scElrBjYFkULNGYRggskSsRrns+wA2kG3UMpNH8e0ojRC3xEAbvsPQeC1jjtcuye8Gquu578QWx6D17atWi4fvmTPzRqO7T4TWwtQ1R+Pzg0BLmNXW89Urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD7XCC/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91381C32786;
	Mon, 24 Jun 2024 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203686;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SD7XCC/0nMvB0rnpCYWVU/KjSjMuL4fiKEWNfZCWFB35gXO4kn8H7yBKUX31lakNV
	 Wp6vgHIJ/IKre+4Y+2AnIGN/jpezSmC6GBFABJvsXCWHLo1BcqMouKEm/IjGrNV4PU
	 Ok8NWhSzw3lggZkcQlSCoocqRHY5lIonbTcVZpjW5TzLymhApTMytTLxn63PGafhqS
	 2L4r71lJZ9Sh1zP5pmJfqpHxHE2wV8xaKEo/FXz5KwJRBEpdxqWEpn9UJkF7j1R/9o
	 E9zChzxLgosE7NhOOxr/HlMj0EjsNoYS/nFe7yXo2kWUdRq2yxf1jJHw3P3zzDLzN0
	 JS+1ou6BXoLdQ==
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
Subject: [PATCH bpf-next v4 3/9] selftests/bpf: Use connect_to_fd in sockmap_ktls
Date: Mon, 24 Jun 2024 12:33:50 +0800
Message-ID: <8e07fd6509d105c4529d3fb57dc030337d57e47a.1719203293.git.tanggeliang@kylinos.cn>
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


