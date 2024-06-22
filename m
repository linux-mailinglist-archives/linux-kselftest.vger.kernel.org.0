Return-Path: <linux-kselftest+bounces-12496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CED913163
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE928655F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9F4A0F;
	Sat, 22 Jun 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+u+KqqY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7A4404;
	Sat, 22 Jun 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019468; cv=none; b=SVZCGgzcyg6cYCGruXAP0W19+094WMZ0h0jFzGqJmME59NqzVlTUMIQMTv5+xPUwdj3zK0+1WlYZnzTGVoslbAiXYX5hY/GyhPj4UlPgvnmCUorXiCMkahe1MnTQUCMhh1IzoW+X9BL8WhgWg9QnLZrbSRFrkiGpXaP5BrNL6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019468; c=relaxed/simple;
	bh=Uv3Veawq41cRk7HDSAwkwv8rOMzc6SdcshDahoslgfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4s5EVr69/T9cHtj1AZ4474qC3hHH76yXC825u3GnScSkZ14ZSsHXXX3eAUHKamUMCgOmcjNdF6jvvBlO2Is8uanrcxn4PPLHBUjyRU9ShDIYWfc/cuT3CabqeOzj1ZFqg9AmF77Y+wL1TxNzXeacAtM88zAuPnbgWPLS6ygwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+u+KqqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A689FC4AF0E;
	Sat, 22 Jun 2024 01:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019467;
	bh=Uv3Veawq41cRk7HDSAwkwv8rOMzc6SdcshDahoslgfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+u+KqqYo2FJiBRP4cxO2af9rnXb3x+/1oBI0i+XJINI0JQe9jfzuA4huODHgxAJa
	 wVQRZ6YR/8Yi8OwfUBYiMKETJM4D9Cj8Z6EQZBtv62R3QBVrRFhwJO26KxDud5aX7a
	 EaCAb/uebhLz0E7qe5MADNsuw8OcU85rvilDJBoPKDrlFK9T+FyrSyAnXylSwIkBg1
	 PyWTXVrVQ0tEDENuaNJtcEzVP3tSi4r01v9v7FCbYKiJkdlsw5aSm5eBIh0raAh0Nr
	 YLZ75RvIF81zNkjircBzdL+msqssNc9zqbmT42r+XYOlnup3SyNHl8+6Ld5GR9kwIJ
	 mA7467wE4NI5w==
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
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Drop inetaddr_len in sk_lookup
Date: Sat, 22 Jun 2024 09:23:46 +0800
Message-ID: <1f4b505f4a18308691cc72a9535cc4805f83965a.1719019125.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719019125.git.tanggeliang@kylinos.cn>
References: <cover.1719019125.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new parameter "len" for make_socket() to get the length
of the address by make_sockaddr(), then local helper inetaddr_len() can be
dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/sk_lookup.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ba386484f785..d3821bf350a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -108,20 +108,14 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
-{
-	return (addr->ss_family == AF_INET ? sizeof(struct sockaddr_in) :
-		addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) : 0);
-}
-
 static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr)
+		       struct sockaddr_storage *addr, socklen_t *len)
 {
 	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
 	int err, family, fd;
 
 	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, NULL);
+	err = make_sockaddr(family, ip, port, addr, len);
 	if (CHECK(err, "make_address", "failed\n"))
 		return -1;
 
@@ -1220,6 +1214,7 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
+	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1249,11 +1244,11 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst);
+	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
 	if (client_fd < 0)
 		goto out_close_server;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = connect(client_fd, (void *)&dst, len);
 	if (CHECK(err && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
 		goto out_close_client;
-- 
2.43.0


