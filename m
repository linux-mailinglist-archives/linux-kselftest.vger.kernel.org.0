Return-Path: <linux-kselftest+bounces-44790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B84C3472A
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7AF18C27CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3E2D46DD;
	Wed,  5 Nov 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0rmCMxde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D028A1E6
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330985; cv=none; b=ml1v+1CMjUCNj/bfhnVtRcNvGUyU6AQRouTluj4BTSNAeKSF4ulLMHUfPi246gZ6DbR7dlVuypTW2nNv/hKt70tMWqCJ2Jxgdos6I6SAV3dDMSI2Qdy4UiAFnSZ2jWWCIKACzrp7K2eT8/V6Ptrw5DiA7UtYtKX9pazHxRy2sjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330985; c=relaxed/simple;
	bh=1UFFxHLngwWlfSIzQHo3B1yiskwv5UVLi/aHpHM5Dss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkOFdiPNyOIBfgWI3xxOzb6hJPnDHYCSb+/4kHmIr+OwtvOpJfSTsSQnUfbD+vm3m1PklrXJfR0KNNkCXtkq53urF46wnWNgXEpoQ+fIu/SWmjY5vk0M8jD41U7iZJhhNfyxibDwMnvi7YrxTz4Mp7yWP0US/fNGj5P39imwgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0rmCMxde; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 749B2C0E632;
	Wed,  5 Nov 2025 08:22:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AA9060693;
	Wed,  5 Nov 2025 08:23:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DCCA10B51983;
	Wed,  5 Nov 2025 09:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762330981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=74ihADtTOc2tE2Hs2544UzjSxwkF3iKFwI1Cs+oyQf8=;
	b=0rmCMxdeXj2jNn4Uo7ghVfAyZEat//FyRC+TGEL8oZLvuPgDGR0ALHKl38fc/K0zIhx0EH
	tLOWNi3/TVADbf6xirizl4HuD8leOPvmRykDN10vmy7cME9FKAgjbY2+QrTkqMneiHkAoP
	XaetKuZcGUKvvurCWOuS5oUHslIrMixuo2Q5/527u+PtxIk8WhSEC9EOIiUjEBPIWBvO68
	oIsMQX2ZVHY+NPwYOsjVv/qbPCG1ZtoBhH3XLTssbainupZDEJwZQfA/BsRb8iMICgEmu9
	cAE7buuf2kAXB7Al6tXojrExflx2Y9xK4jCEEpj1J7GgucXHbpsasLE8Th6dxw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 05 Nov 2025 09:22:49 +0100
Subject: [PATCH bpf-next 2/2] selftests/bpf: use start_server_str rather
 than start_reuseport_server in tc_tunnel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251105-start-server-soreuseaddr-v1-2-1bbd9c1f8d65@bootlin.com>
References: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
In-Reply-To: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Now that start_server_str enforces SO_REUSEADDR, there's no need to keep
using start_reusport_server in tc_tunnel, especially since it only uses
one server at a time.

Replace start_reuseport_server with start_server_str in tc_tunnel test.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index deea90aaefad..4d29256d8714 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -69,7 +69,7 @@ struct subtest_cfg {
 	int client_egress_prog_fd;
 	int server_ingress_prog_fd;
 	char extra_decap_mod_args[TUNNEL_ARGS_MAX_LEN];
-	int *server_fd;
+	int server_fd;
 };
 
 struct connection {
@@ -135,16 +135,18 @@ static int run_server(struct subtest_cfg *cfg)
 {
 	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
 	struct nstoken *nstoken;
+	struct network_helper_opts opts = {
+		.timeout_ms = TIMEOUT_MS
+	};
 
 	nstoken = open_netns(SERVER_NS);
 	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
 		return -1;
 
-	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
-						cfg->server_addr, TEST_PORT,
-						TIMEOUT_MS, 1);
+	cfg->server_fd = start_server_str(family, SOCK_STREAM, cfg->server_addr,
+					  TEST_PORT, &opts);
 	close_netns(nstoken);
-	if (!ASSERT_OK_PTR(cfg->server_fd, "start server"))
+	if (!ASSERT_OK_FD(cfg->server_fd, "start server"))
 		return -1;
 
 	return 0;
@@ -152,7 +154,7 @@ static int run_server(struct subtest_cfg *cfg)
 
 static void stop_server(struct subtest_cfg *cfg)
 {
-	free_fds(cfg->server_fd, 1);
+	close(cfg->server_fd);
 }
 
 static int check_server_rx_data(struct subtest_cfg *cfg,
@@ -188,7 +190,7 @@ static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
 		return NULL;
 	}
 
-	server_fd = accept(*cfg->server_fd, NULL, NULL);
+	server_fd = accept(cfg->server_fd, NULL, NULL);
 	if (server_fd < 0) {
 		close(client_fd);
 		free(conn);
@@ -394,29 +396,30 @@ static void run_test(struct subtest_cfg *cfg)
 
 	/* Basic communication must work */
 	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
-		goto fail;
+		goto fail_close_server;
 
 	/* Attach encapsulation program to client */
 	if (!ASSERT_OK(configure_encapsulation(cfg), "configure encapsulation"))
-		goto fail;
+		goto fail_close_server;
 
 	/* If supported, insert kernel decap module, connection must succeed */
 	if (!cfg->expect_kern_decap_failure) {
 		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
 					"configure kernel decapsulation"))
-			goto fail;
+			goto fail_close_server;
 		if (!ASSERT_OK(send_and_test_data(cfg, true),
 			       "connect with encap prog and kern decap"))
-			goto fail;
+			goto fail_close_server;
 	}
 
 	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
 	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
-		goto fail;
+		goto fail_close_server;
 	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
 
 fail:
 	stop_server(cfg);
+fail_close_server:
 	close_netns(nstoken);
 }
 

-- 
2.51.2


