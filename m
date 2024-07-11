Return-Path: <linux-kselftest+bounces-13537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119C92DE9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 04:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60436B218FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC45D524;
	Thu, 11 Jul 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqJotcyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB4BA29;
	Thu, 11 Jul 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666413; cv=none; b=KmuvEwLY79wu7nxAJzjvfkdozWxr7rDkF6XZZP81kg6osHv4JtoDDBuojuORiBMxpw+Rxe7SVZ7W7BwTxHraXNcvmKaHQU08gvK86EtS42N9t6G6x3FnGRZtCTD9xuY9dQ3Zlo3cCfrqYHf4J559xlMVk96TdMGtW0MjvUtTE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666413; c=relaxed/simple;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxAcuRjc7ppcEjKvZxiDM5a/fEGQ9AYa6RzWuYT6dyLHBGrcxw8GxYc4i3y8IvlRfIEGjG3OVkkirmGzEQy/MF7Bdy3BQtaT2X2rLhXNn63mK0avnNIleYeJPKU3YvV3OyqJFLFaTqs8ld72XT8hndYxkl0V7Ul8jELWqknAvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqJotcyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA06C32782;
	Thu, 11 Jul 2024 02:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720666413;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqJotcydHKivKHO/d/uLfSGhqUEXa06hbbfx5HspSyoRTMnGKtfbbqbuN6inbBlCa
	 oU/gY5Dow3Spy3KocOCXD5DFmgRd8NQ/yFuq4BHY38a+Vmx3IhIt+gtjv+x5fCk/A9
	 ZjGmr0SZepcgFQsMRJQeWi+NwkcYUaV/PpHQprSiDqCqTlfJylDe8+M1M+mNqha6us
	 LHikyI2dR9M7rUAC5dhcnNappk30gYisjbjvxNvUzvFzJzhpdw0y2cuVVFNTv9tv8u
	 l4zu08lPNDwzvJcVnzIlL/EUy/TO8j72pBDK/2iaZxWUs79HOJ+s2jx95BFbv3f3Ks
	 CHK38HrV8wOxw==
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
Subject: [PATCH bpf-next 4/5] selftests/bpf: Use connect_to_addr_str in sk_lookup
Date: Thu, 11 Jul 2024 10:52:51 +0800
Message-ID: <231bb5d9c51f35540d923ab6661b9c0e11d3d20c.1720664658.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720664658.git.tanggeliang@kylinos.cn>
References: <cover.1720664658.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the new helper connect_to_addr_str() in make_client()
instead of using local defined function make_socket() + connect(). This
local function can be dropped latter.

A new parameter "expect_errno" is added for make_client() too to allow
different "expect_errno" is passed to make_client(). It is used to check
with "errno" after invoking connect_to_addr_str().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 26 +++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..beea7866b37f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -229,25 +229,19 @@ static int make_server(int sotype, const char *ip, int port,
 	return -1;
 }
 
-static int make_client(int sotype, const char *ip, int port)
+static int make_client(int sotype, const char *ip, int port, int expect_errno)
 {
-	struct sockaddr_storage addr = {0};
-	int err, fd;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
+	int fd;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
+	fd = connect_to_addr_str(is_ipv6(ip) ? AF_INET6 : AF_INET,
+				 sotype, ip, port, NULL);
+	if (CHECK(fd < 0 && (!expect_errno || errno != expect_errno),
+		  "make_client", "connect_to_addr_str")) {
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
@@ -646,7 +640,7 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
 	if (client_fd < 0)
 		goto close;
 
@@ -1152,7 +1146,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1166,7 +1160,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


