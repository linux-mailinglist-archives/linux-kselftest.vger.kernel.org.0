Return-Path: <linux-kselftest+bounces-13870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75E93480B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBDA1C219F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B474055;
	Thu, 18 Jul 2024 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvNzvg+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0573477;
	Thu, 18 Jul 2024 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283816; cv=none; b=hKjlny0fRGTs6bauM02zO2jqtxnj9YQ9b/SPtko6e4bGoYdJ+5auKw0hyV+KQVLw7qmxlYZMWMeGNmg2jKb2WaBlmMmNG4/GXMYNDWeIw56j7RxyVe7dPgYb16/VO+u4X6gjfkO3OZTCS8k8ZIMnm1QyoJP09XcqJuSTB/lfFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283816; c=relaxed/simple;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6ArE+uGMBozWFS/TKWi8R9k4xgU6T/7nrVNLw4hs7BL8qKoCMz8e2b43dNPonIn5DfMszTesbfabY3+1XsPZ527WiEWfInvbhEG/03F/hMv0hKjCeY1FijRr7D73raphzk/nufP9v/AK4wv0M9NWRndQGoJ+D5ZSI56csKBeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvNzvg+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89695C4AF18;
	Thu, 18 Jul 2024 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283816;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvNzvg+A++u/1SUvDELhIgj3SELlcAGFGT255hPzueWB2UuYWZeTyuT7Z8hxmsW1Z
	 gNRJGixWR2tKl7sHG2NY4aWn/2NtSvLFoCh1JuSyUT1AX2EuqZfOk1vX4wKHNyrIIW
	 m3mJZcIErhdKVPE35KpP0Qvy7IkzdQAwTS7ZRbgnULd1xND9MDhpFoeUT9wdMlUQ5M
	 T+PEVWwc2EFtebqCX9SxxafLTWMPWcYrBwThG9pL++2GYCVQxPIAYa9VrGVh2EtYF+
	 VsvougAwJW6QZhC+wP08ZZ2NnCkF0KQzVOR4sg6f6FE1Jus90LiyOMuM/uLwUfxtdf
	 QJgZnlNtnESFg==
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
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Use connect_to_addr_str in sk_lookup
Date: Thu, 18 Jul 2024 14:22:32 +0800
Message-ID: <a41193347fc775f934b60ad8e2dca4cf04177127.1721282219.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721282219.git.tanggeliang@kylinos.cn>
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
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


