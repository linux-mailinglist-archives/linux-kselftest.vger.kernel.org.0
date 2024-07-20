Return-Path: <linux-kselftest+bounces-13961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC12293810B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB66B213C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517AB12BF24;
	Sat, 20 Jul 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuDDiTXK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38D5CDE9;
	Sat, 20 Jul 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475645; cv=none; b=IN43IaEC2SttDU74EHTc57drBMW+qOVszGQ8+7EtqGOMAxzn4mR0bHTm9q3H7Y4uLyGsUIYrsh8+diFiFGJw13Taq46Wjxe0BkZ2jR8VIYrKi30kaPnbPeo7BVFIJrezqc4S5Tl/n7AIJv1fn8XzYSVACPTqLeqhYsDa6dlA1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475645; c=relaxed/simple;
	bh=qtkq8RbpDkRkY4VVcTna6668JvN2OQ1kXkufYfP8GgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ1V/Agi7F0tZBRK3NWH6urf9XRJNKL9m73goeOWENw4O3fT5cuPg5GYg1leZ6sNAbDfFYX6ZLXkuyNk7UrHv5hIsHh2gpsXfQ1MdEaZn7oI4YOfOogdL+wr2kp7hSnyCDnOdJtfN+ZsmCLK2w8gZ5YscSgky/7luwKsXONU6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuDDiTXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4935FC4AF0E;
	Sat, 20 Jul 2024 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475645;
	bh=qtkq8RbpDkRkY4VVcTna6668JvN2OQ1kXkufYfP8GgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuDDiTXKfG89pUiC11GSfJIo9NA+dIJg/+vxp4fJmU0Az3j0Jsn/xUuk5iWTiBX6I
	 uilcoudhYBgEAfRysoymA460H0xJdAI7qKEGre66N+6WkuvBC7sdhqNq1gVAqqRdU1
	 vjyAT2ZjOu3gEEoeKshPUEGIObXnPvqLMdgxtzHFICnEd3qyWFi3CT/xZRzY+lFLlO
	 57rRirl3tlvn5fb4dnyBeIRDhgR5rkHtfNDA6cC46svLJd6RXEQ8RQchjzIXnzbKZu
	 zW1nFgOAP7k4q5okyBhK9O8z5qvj4aPUkudH8VyOOmtgoS8nYM/juNB0e20lpovBuy
	 KpTGv1Osns8aA==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/4] selftests/bpf: Drop make_client in sk_lookup
Date: Sat, 20 Jul 2024 19:40:03 +0800
Message-ID: <058199d7ab46802249dae066ca22c98f6be508ee.1721475357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the new helper connect_to_addr_str() in sk_lookup.c to
create the client socket and connect to the server, instead of using local
defined function make_client(). This local function can be dropped then.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 34 ++++---------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..9510a3f83787 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -229,27 +229,6 @@ static int make_server(int sotype, const char *ip, int port,
 	return -1;
 }
 
-static int make_client(int sotype, const char *ip, int port)
-{
-	struct sockaddr_storage addr = {0};
-	int err, fd;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
-
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
-		log_err("failed to connect client socket");
-		goto fail;
-	}
-
-	return fd;
-fail:
-	close(fd);
-	return -1;
-}
-
 static __u64 socket_cookie(int fd)
 {
 	__u64 cookie;
@@ -646,8 +625,9 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
-	if (client_fd < 0)
+	client_fd = connect_to_addr_str(is_ipv6(t->connect_to.ip) ? AF_INET6 : AF_INET,
+					t->sotype, t->connect_to.ip, t->connect_to.port, NULL);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_addr_str"))
 		goto close;
 
 	if (t->sotype == SOCK_STREAM)
@@ -1152,8 +1132,8 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
-	if (connected_fd < 0)
+	connected_fd = connect_to_addr_str(AF_INET, sotype, EXT_IP4, EXT_PORT, NULL);
+	if (!ASSERT_OK_FD(connected_fd, "connect_to_addr_str"))
 		goto out_close_server;
 
 	/* Put a connected socket in redirect map */
@@ -1166,8 +1146,8 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
-	if (client_fd < 0)
+	client_fd = connect_to_addr_str(AF_INET, sotype, EXT_IP4, EXT_PORT, NULL);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_addr_str"))
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
 		send_byte(client_fd);
-- 
2.43.0


