Return-Path: <linux-kselftest+bounces-14105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF393A929
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F201C283CEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A41494D5;
	Tue, 23 Jul 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA2k9J+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EF148827;
	Tue, 23 Jul 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773370; cv=none; b=CKEqqIL2AsO7JTgiC4nGX6OIhnS5QtDAAZ3ROZ1nQyERHntk6jLKP4MGJbf9Q2d1CXdARmn9z/U344+Ry9c5beMFQkJ8oqcA6xlcSZkU81Y/1AUTvBPrP4jL4Vj25YFio0uXHcKcTe1lmC+bOclldR7D4xvCsjFSZC5pZV8EFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773370; c=relaxed/simple;
	bh=KqMjTfdH3u15gtevijB3kg0N1GugqZKCG34zP8wwTAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDOGbUQlVwsUwYTkTYiCi+kjp8MVaAOnYCgr7iobfYZdV2RZzvd+mProkICoShHzjsX24HVdf7+kW85xaBqsO/wSrm9xOBdaxRI/rgKbD/tC8u8eCpFFHavP5dtYYQJ9eJARynHIX6BZW6mOq0hnC9kqX+xecVtLEgPIFUmuuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA2k9J+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FFC4AF11;
	Tue, 23 Jul 2024 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773369;
	bh=KqMjTfdH3u15gtevijB3kg0N1GugqZKCG34zP8wwTAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aA2k9J+RBpPquH6t/tiNY7iEvKjFI6LrEHxmUwtCF8WKySK0DzMhGyjnut9kJllWX
	 buO5qJcPgG5DGs8ejkgNrrAfol47Z4oIqk1RRK5EBsjk0GQwFIp2IQnyP39EP8x+Fw
	 peVHpfoCDikqoxQcs75jdPlhDXBVj18UHoH9BvxWdy55op/do6fOxwtT5pFE8sSPVP
	 zzJZIAK+GfuXM9DLqjCM25BdUiQcfqHhjjF4QFFN6aDnIYp8x24ESmWrBkLHIi+NR1
	 2/rOyHesbqLuBkmjzcPi7Ns8NYEx95VvlbHUr6xzhz6Af2CUyer8mfWnfHatPY8Gu3
	 Q2324fnWJbKnw==
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
Subject: [PATCH bpf-next 03/15] selftests/bpf: Use start_server_str in lwt_redirect
Date: Wed, 24 Jul 2024 06:22:09 +0800
Message-ID: <44231acb3ed09db3bca33a4b5f959f0ec476efe3.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

AF_PACKET can be passed to start_server_str() now. Use it to simplify
the code in lwt_redirect.

In this test, use sprintf() to save the "ifindex" value into addr_str
string, then pass it to the helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/lwt_redirect.c   | 21 +++++--------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 835a1d756c16..f4c54bb7e416 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -94,30 +94,19 @@ static int new_packet_sock(const char *ifname)
 {
 	int err = 0;
 	int ignore_outgoing = 1;
+	char addr_str[32];
 	int ifindex = -1;
 	int s = -1;
 
-	s = socket(AF_PACKET, SOCK_RAW, 0);
-	if (!ASSERT_GE(s, 0, "socket(AF_PACKET)"))
-		return -1;
-
 	ifindex = if_nametoindex(ifname);
-	if (!ASSERT_GE(ifindex, 0, "if_nametoindex")) {
-		close(s);
+	if (!ASSERT_GE(ifindex, 0, "if_nametoindex"))
 		return -1;
-	}
 
-	struct sockaddr_ll addr = {
-		.sll_family = AF_PACKET,
-		.sll_protocol = htons(ETH_P_IP),
-		.sll_ifindex = ifindex,
-	};
+	sprintf(addr_str, "%d", ifindex);
 
-	err = bind(s, (struct sockaddr *)&addr, sizeof(addr));
-	if (!ASSERT_OK(err, "bind(AF_PACKET)")) {
-		close(s);
+	s = start_server_str(AF_PACKET, SOCK_RAW, addr_str, 0, NULL);
+	if (!ASSERT_OK_FD(s, "start_server_str"))
 		return -1;
-	}
 
 	/* Use packet socket to capture only the ingress, so we can distinguish
 	 * the case where a regression that actually redirects the packet to
-- 
2.43.0


