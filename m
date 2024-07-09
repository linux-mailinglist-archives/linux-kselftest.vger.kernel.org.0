Return-Path: <linux-kselftest+bounces-13356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68092B383
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4E1C2197D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F71552F0;
	Tue,  9 Jul 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAgejxZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B7154C18;
	Tue,  9 Jul 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516655; cv=none; b=pf6qXlSByKryWJkYjheQsdUGDGEUr3EMrd28/kphvgqJur639NJjKeurCyj3u8kGAJMSketP7LFHeGjrsGtX9ZFMPADVm3BNP41wQ6qs/98ZrHAyFhi5IdOdUAgdywUggGyn4wKA3MJCzsyzqklRYvKnhNj4KtlvRM6IMURD0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516655; c=relaxed/simple;
	bh=FTs7Ldb0HAt0X7TgHeEKPK53qGq/J14+v1OuN6qPB5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xuip9+UwpXWxgbQZfLChzfcqrfCX/QT5qZstSD4Nx2yBK0GRabmZgIkb0Kj1kOTCd8/yOVJCWHI3UWWf3kFWsYZRqHzuLTcc4mbEC47wgzXtZIfsmbb4Q+pa5sC1iksb/sUhnV5tQMzB1odnLClkNGh8G54mAhzyQxFwxMEUE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAgejxZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53ABC4AF13;
	Tue,  9 Jul 2024 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516655;
	bh=FTs7Ldb0HAt0X7TgHeEKPK53qGq/J14+v1OuN6qPB5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAgejxZMG3Aox7rmBUoTds3IqlaZDh3TXRBufiLAhbuBldWVxGx3hZQG8HdWuo48N
	 86OhDfRVXxedT8W7KnpviakTO/1I4zEIEBPn13zeXsBDCWoRw4Y00rhcQSC1U8JtJa
	 ArJ6hjWf/jnFM2wFcE94dxutBYzztgc+oVYhBO5Pa7f3AWWpesyR8z9H76f9IqfYVa
	 MB/6IcjHklMCR5OkcH/ed9uuK5JBkYZ9UOzBINI9K/gGOKKTF4vl39AJ4h7qapeJmX
	 aDBw04s6+wsE2QvLonxmL8XRB3by7gCaaVqukF9sx01XPzwKYSmOYWZIYrc23jagia
	 BJ4apggWtk6Ug==
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
Subject: [PATCH bpf-next v11 8/9] selftests/bpf: Use connect_fd_to_addr_str in sk_lookup
Date: Tue,  9 Jul 2024 17:16:24 +0800
Message-ID: <bba6495f1b268bf6581494a76e8b95af48adb620.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the new helper connect_fd_to_addr_str() in make_client()
instead of using local defined function make_socket() + connect(). This
local function can be dropped latter.

A new parameter "expect_errno" is added for make_client() too to allow
different "expect_errno" is passed to make_client(). It is used to check
with "errno" after invoking connect_fd_to_addr_str().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/sk_lookup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ad3f943cc2bd..26a1c339492e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -229,17 +229,17 @@ static int make_server(int sotype, const char *ip, int port,
 	return -1;
 }
 
-static int make_client(int sotype, const char *ip, int port)
+static int make_client(int sotype, const char *ip, int port, int expect_errno)
 {
-	struct sockaddr_storage addr = {0};
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
 	int err, fd;
 
-	fd = make_socket(sotype, ip, port, &addr);
+	fd = socket(family, sotype, 0);
 	if (fd < 0)
 		return -1;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
+	err = connect_fd_to_addr_str(fd, family, sotype, ip, port, NULL);
+	if (CHECK(err && (!expect_errno || errno != expect_errno), "make_client", "connect")) {
 		log_err("failed to connect client socket");
 		goto fail;
 	}
@@ -645,7 +645,7 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
 	if (client_fd < 0)
 		goto close;
 
@@ -1151,7 +1151,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1165,7 +1165,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


