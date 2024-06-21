Return-Path: <linux-kselftest+bounces-12444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3E912290
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF7C1F2199F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27304171675;
	Fri, 21 Jun 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHP1sJ6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F316D33A;
	Fri, 21 Jun 2024 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966173; cv=none; b=Elf0h3P1kjTJckHXh0fkLLHL9QmbRq7Kk2veLQ001OJEo0inA2Mxg9ahsTS7ekTdpJuDmvvlylGiDsyj3pAlG1md19zEGoqaMIN8oAS/lK6nuH/Pv82yRSSfd5r5dVL0y8aDrr43px/4tKljjOLtMFW0sev78uFYgzCDXFp1+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966173; c=relaxed/simple;
	bh=1y7UwnSWe3/0q0L9cNLNBb4Omt7+3nhYnY3r1wJsGOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEunLFzweynNs85+RYN+I1MjzPW50/9+r9FKmdMZ8JW50Zwvp/RbPFoW9JE/Znq+bf819EIwNoRinibNs6M0WeMQLCk1tyPaMYe8X89BNNODgjc1RDfoB4MFztYRxhhx394a9IyrKKB0hZ6qW6+qoubcuA6PNuIL3Mqdt5Okm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHP1sJ6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E06C2BBFC;
	Fri, 21 Jun 2024 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966172;
	bh=1y7UwnSWe3/0q0L9cNLNBb4Omt7+3nhYnY3r1wJsGOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHP1sJ6ATXFnwqLlo3Kjho02rcHp0QdtDqaAoMM7IUexYP7hjUOfE3+qNKAwStq/m
	 v5mRgt5Aq27CwU1cDuVFFRzuEiqaq/1mUQk4VFwMOcHPFcVx8eDglXSBHkxUaYK+0b
	 2GwKuw6K5UKjxz/uDhzzKfmJaGMTkjrbz4hh15ed4mAjbD+XsmC4i9X6gCm4skcfNv
	 PMR3znjbM6YImYBBq72Vhoci1jstBZoH5evxXgEzQg1VPicRCXiZqu/nNDMtxOSICA
	 cciTP8ydlecjUpwDd+ZjRcXR9ynqPnjtutX5lu/PredUljZZtLBDfUWmBeQAly+KM7
	 al1tSjsD5bulA==
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
Subject: [PATCH bpf-next 6/6] selftests/bpf: Drop make_socket in sk_lookup
Date: Fri, 21 Jun 2024 18:35:29 +0800
Message-ID: <489e1543f8c4ac8feb9e90d1384af66ecb59ba82.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use public network helpers make_sockaddr() and connect_to_addr() instead of
using the local defined function make_socket() and connect().

Then make_socket() can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 50 +++----------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 0f2e8a4c1524..e4c983a00511 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -47,8 +47,6 @@
 #define INT_IP6		"fd00::2"
 #define INT_PORT	8008
 
-#define IO_TIMEOUT_SEC	3
-
 enum server {
 	SERVER_A = 0,
 	SERVER_B = 1,
@@ -108,40 +106,6 @@ static int attach_reuseport(int sock_fd, struct bpf_program *reuseport_prog)
 	return 0;
 }
 
-static int make_socket(int sotype, const char *ip, int port,
-		       struct sockaddr_storage *addr, socklen_t *len)
-{
-	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
-	int err, family, fd;
-
-	family = is_ipv6(ip) ? AF_INET6 : AF_INET;
-	err = make_sockaddr(family, ip, port, addr, len);
-	if (CHECK(err, "make_address", "failed\n"))
-		return -1;
-
-	fd = socket(addr->ss_family, sotype, 0);
-	if (CHECK(fd < 0, "socket", "failed\n")) {
-		log_err("failed to make socket");
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_SNDTIMEO)", "failed\n")) {
-		log_err("failed to set SNDTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
-	if (CHECK(err, "setsockopt(SO_RCVTIMEO)", "failed\n")) {
-		log_err("failed to set RCVTIMEO");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
 static int setsockopts(int fd, void *opts)
 {
 	struct cb_opts *co = (struct cb_opts *)opts;
@@ -224,24 +188,22 @@ static int make_server(int sotype, const char *ip, int port,
 
 static int make_client(int sotype, const char *ip, int port)
 {
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
 	struct sockaddr_storage addr = {0};
 	socklen_t len;
 	int err, fd;
 
-	fd = make_socket(sotype, ip, port, &addr, &len);
-	if (fd < 0)
+	err = make_sockaddr(family, ip, port, &addr, &len);
+	if (err)
 		return -1;
 
-	err = connect(fd, (void *)&addr, len);
-	if (CHECK(err, "make_client", "connect")) {
+	fd = connect_to_addr(sotype, &addr, len, NULL);
+	if (CHECK(fd < 0, "connect_to_addr", "connect")) {
 		log_err("failed to connect client socket");
-		goto fail;
+		return -1;
 	}
 
 	return fd;
-fail:
-	close(fd);
-	return -1;
 }
 
 static __u64 socket_cookie(int fd)
-- 
2.43.0


