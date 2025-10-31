Return-Path: <linux-kselftest+bounces-44513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4FC23FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3D458014F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621D330B1B;
	Fri, 31 Oct 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k3w+Tc2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D832E732
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901322; cv=none; b=DBQcW5emPE6g3EY8ZuIBjc7IPBbkdRusjSMowtfw9pDKmJRdfnPuwol2lB+vnWxjdUfMKvTtpja1XWwm2c2xCIsMBALw/Dd2xf0dJl4mAiiv7/lLOU1LqIjYVR/dXY0P0zaYMqT8xgLUiMUSDLHv1YDk/LvNRjv+3jLIiGuQBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901322; c=relaxed/simple;
	bh=pMUGzYjbOegFHkT1FuYNVbyBzYCy/Ejns06DI02dhcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrlC+xTDj4/Y2zlYrmB7c8ZxPhd62Rf190RC/w44X/sbKF53X9hzGcHIWs/WpVzjiCKiqpC55enUTaVaKtasuU6YolgJ8ErxIys9Q4u872DH27vwuk+soIlHbUIOA7pA1OqvTo6a1bHxao20gCZahgzg6XqVu9GhWbgXK2Ud1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k3w+Tc2/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE48F4E4142B;
	Fri, 31 Oct 2025 09:01:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92B7160704;
	Fri, 31 Oct 2025 09:01:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7BEE11810848;
	Fri, 31 Oct 2025 10:01:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761901317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OV3wcdNzU1YfXWJ7DsorNSNJWoONphM2tAJI5bX7CJo=;
	b=k3w+Tc2/LyqKRzh1F8MYwVSx5Bxpx9fY2jfwXYZsifPPCvZ1EPX48l88hxNgeQDiJ8I57J
	Rycs1WbQDn97olU+mvf5877HinAi/sAGpgFU1vyhNR5t1dpsvW+0gme1Qb6ZaQxnNlp7RP
	Bf+PX6Q8sowyJ7TLXZvraxD5oNlkWyLZ/EOGwMnDzIb0abGstJMc7RPxJrGaxtLbck+qxz
	RNa5En15rOzkAgQuzibPgvQkRUT6dbRrH9AMudxxUUS5Tiae9lJWIasRFplRPDgN/edpOA
	ljzOqea+BcIrCped1Tzw+C1q9ZUvFVPnA66J41U66Mktbaock+Tw+rnjdJe9ig==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 10:01:43 +0100
Subject: [PATCH bpf-next 3/3] selftests/bpf: use start_server_str rather
 than start_reuseport_server in tc_tunnel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_tunnel_improv-v1-3-0ffe44d27eda@bootlin.com>
References: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
In-Reply-To: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

test_tc_tunnel currently uses start_reuseport_server because it needs to
frequently start and stop the server, so we need SO_REUSEPORT to avoid
getting errors on server restart due to the socket being in TIME_WAIT
state. But the test is only using one server at a time, so it is a bit
confusing to use this API.

Replace start_reuseport with start_sever_str, and provided the relevant
callback to set SO_REUSEPORT.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 24 +++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index deea90aaefad..8e3fe6dc6221 100644
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
@@ -131,20 +131,30 @@ static void set_subtest_addresses(struct subtest_cfg *cfg)
 	}
 }
 
+static int reuseport_cb(int fd, void *opts)
+{
+	int one = 1;
+
+	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
+}
+
 static int run_server(struct subtest_cfg *cfg)
 {
 	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
+	struct network_helper_opts opts = {
+		.timeout_ms = TIMEOUT_MS,
+		.post_socket_cb	= reuseport_cb,
+	};
 	struct nstoken *nstoken;
 
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
@@ -152,7 +162,7 @@ static int run_server(struct subtest_cfg *cfg)
 
 static void stop_server(struct subtest_cfg *cfg)
 {
-	free_fds(cfg->server_fd, 1);
+	close(cfg->server_fd);
 }
 
 static int check_server_rx_data(struct subtest_cfg *cfg,
@@ -188,7 +198,7 @@ static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
 		return NULL;
 	}
 
-	server_fd = accept(*cfg->server_fd, NULL, NULL);
+	server_fd = accept(cfg->server_fd, NULL, NULL);
 	if (server_fd < 0) {
 		close(client_fd);
 		free(conn);

-- 
2.51.1.dirty


