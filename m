Return-Path: <linux-kselftest+bounces-10902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AE8D463E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1AB281458
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62C55881;
	Thu, 30 May 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhxIwDyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542154D8DE;
	Thu, 30 May 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054904; cv=none; b=FQP8xWb9qk6PiwLc8nqKm4F0ShdQrwNi3kr4vL73RpPREjfPrrbUDRhMrraNMouFWcFVl22BsYEP+FNHadkRTLhJY0XGzGs+CRxbvmY4er+spRhF4KjqyJKfGcdyctvlcfXGsMSHgiOnxhwI5gTShyG+a+r2Rpo8zDGlu11J5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054904; c=relaxed/simple;
	bh=DQyipSqdBXt7gqEo4fdmvV3F68N9CRrnGyvWa9T9RDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buDeQRPVqbdPnAM0bDrjtRBMdQxFNd6L0cFYAyJPFI2RFPrHlQwyYv8MSSegd7hQkoG2/1vvEQXa/eMqxekzRTCs1GxSrtQ6BRwYOa1Vr0a/h22aMXYjG8rISQitWc8lwq1DsYyPTyjDQa2vlxF9/Y1nRF6CLBTGPJq/6brSTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhxIwDyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976ADC4AF0D;
	Thu, 30 May 2024 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054904;
	bh=DQyipSqdBXt7gqEo4fdmvV3F68N9CRrnGyvWa9T9RDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhxIwDyLLN36mVSwETqNuz6tJCOtO+NJHbJuQskl5Y9K2RDwwGW9zGY08swF75BSQ
	 GuTQMYzuYud/P6AmkIfLdx81VuIhHntFk6yNFsPIsZ0/qrWMX1rIWaGNnl3fpJ+n/9
	 I/HLDVoHrFJ45/RCcK7aCg12AYq9fBIBMxntGvlk0LNssVbbnoufZ6CeW1qcB504oc
	 xSw+Bk5fxGjisjKNeWfq+IZMdu1UgRH1RKKCGzVYaXf1f1jMZbnwbiEsPUO927T0Il
	 X8JGJcTHNBcQ1jVBKIKDcbJNFxGeLKEthqJeBI9UrtdxHfILUfx9fy5krBc7hiC4Qs
	 PiBTVxwaNDVSQ==
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
Subject: [PATCH bpf-next 3/5] selftests/bpf: Use start_test in test_dctcp_fallback in bpf_tcp_ca
Date: Thu, 30 May 2024 15:41:10 +0800
Message-ID: <792ca3bb013fa06e618176da02d75e4f79a76733.1717054461.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717054461.git.tanggeliang@kylinos.cn>
References: <cover.1717054461.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The newly added helper start_test() can be used in test_dctcp_fallback()
too, to replace start_server_str() and connect_to_fd_opts(). In that
way, two network_helper_opts srv_opts and cli_opts are used instead of
the previously shared opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 794651ce0629..d10217169ff8 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -229,17 +229,22 @@ static void test_invalid_license(void)
 static void test_dctcp_fallback(void)
 {
 	int err, lfd = -1, cli_fd = -1, srv_fd = -1;
-	struct network_helper_opts opts = {
-		.post_socket_cb	= cc_cb,
-	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link = NULL;
 	struct cb_opts dctcp = {
 		.cc = "bpf_dctcp",
 	};
+	struct network_helper_opts srv_opts = {
+		.post_socket_cb = cc_cb,
+		.cb_opts = &dctcp,
+	};
 	struct cb_opts cubic = {
 		.cc = "cubic",
 	};
+	struct network_helper_opts cli_opts = {
+		.post_socket_cb = cc_cb,
+		.cb_opts = &cubic,
+	};
 	char srv_cc[16];
 	socklen_t cc_len = sizeof(srv_cc);
 
@@ -254,14 +259,7 @@ static void test_dctcp_fallback(void)
 	if (!ASSERT_OK_PTR(link, "dctcp link"))
 		goto done;
 
-	opts.cb_opts = &dctcp;
-	lfd = start_server_str(AF_INET6, SOCK_STREAM, "::1", 0, &opts);
-	if (!ASSERT_GE(lfd, 0, "lfd"))
-		goto done;
-
-	opts.cb_opts = &cubic;
-	cli_fd = connect_to_fd_opts(lfd, &opts);
-	if (!ASSERT_GE(cli_fd, 0, "cli_fd"))
+	if (!start_test("::1", &srv_opts, &cli_opts, &lfd, &cli_fd))
 		goto done;
 
 	srv_fd = accept(lfd, NULL, 0);
-- 
2.43.0


