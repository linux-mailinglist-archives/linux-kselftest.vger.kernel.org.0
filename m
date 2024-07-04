Return-Path: <linux-kselftest+bounces-13195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18392729B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1911C249E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D01AB909;
	Thu,  4 Jul 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia/4JBTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBE1AAE08;
	Thu,  4 Jul 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083657; cv=none; b=a4Zo+EjgToRKu+ML/4BXNEAnnom2tJq1qc8gCvGEOamsML7AHWZnhklatLko1TwGCQQRruZl3lPGHZCszwkamyhKC+3PXpxjLc4DJrpZVnyYpKT4ugSs7rSxOsbxPkHKRPAv85gJCdiERvXvREUpJa0BXo+ABop7XvDs8FmtXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083657; c=relaxed/simple;
	bh=yBpwufIyHtUyQP/wn4qffLKhfsxUhBi0F8+lFPe+2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z58ZYuT79Ciav5ymQf9VqXoUIP69q9zm2vJ/6fX2UcjzyQivqRtmc+sxUbmA4a4J0p2Kpa7ZN5xSl8IEed3chFgdlCOSrYd6REZoXbzv6vOC5dZSwlOuX7DxVFryh7Wz5au210tIUyhxMWcuiBRsDXJN7KSBWLOHKkyYwTDW5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia/4JBTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3854EC4AF11;
	Thu,  4 Jul 2024 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083656;
	bh=yBpwufIyHtUyQP/wn4qffLKhfsxUhBi0F8+lFPe+2YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ia/4JBTtcWfpkthIISV0F31R5EK2REtP2DmQOKWXvcol/yRa+1lJS9by691NDVCnO
	 /g2NkEwQnJXI6SIbl/w18l/ld0wsBYAizG7zOwf5OvmUbu3zeKnMKi3wI/CYnfuWjW
	 3gcy7vjdOozCDG6D5mSnu9y8zd6RCZv2XBdM/bKuYSe58k1VnjbQr6KCHNLrBn1YVM
	 4OESl9zzvgkLKOXCHzsSorn0RjRX8o7332x85ie4yyjOzTwPr3FGbkh6AngQS2WcXv
	 o9BC87DAadl1Uz8wX7xYg+Qbs8ZsBs6dXz0ZkAG8Y5srzfySupXEnB0PGnOEAzQ7wX
	 ZbcagxnpAiWVA==
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
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Thu,  4 Jul 2024 16:59:45 +0800
Message-ID: <04e41d6e3158b294a30ae6bf93a856b63832d65a.1720083019.git.tanggeliang@kylinos.cn>
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

Use public network helpers make_sockaddr() and connect_to_addr() instead
of using the local defined function make_socket() and connect().

This make_socket() can be dropped latter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ef4a3db34c5f..7c42ebff80a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -231,23 +231,23 @@ static int make_server(int sotype, const char *ip, int port,
 
 static int make_client(int sotype, const char *ip, int port)
 {
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	struct sockaddr_storage addr = {0};
+	socklen_t len;
 	int err, fd;
 
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
+	err = make_sockaddr(family, ip, port, &addr, &len);
+	if (!ASSERT_OK(err, "make_sockaddr"))
 		return -1;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
-		log_err("failed to connect client socket");
-		goto fail;
-	}
+	fd = connect_to_addr(sotype, &addr, len, &opts);
+	if (!ASSERT_GE(fd, 0, "connect_to_addr"))
+		return -1;
 
 	return fd;
-fail:
-	close(fd);
-	return -1;
 }
 
 static __u64 socket_cookie(int fd)
-- 
2.43.0


