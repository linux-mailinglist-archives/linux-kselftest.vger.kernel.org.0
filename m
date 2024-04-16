Return-Path: <linux-kselftest+bounces-8122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215698A6810
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AD21F21B6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722921272B7;
	Tue, 16 Apr 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoPrHozl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7EE1272AA;
	Tue, 16 Apr 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262544; cv=none; b=ivfttcoV6D0VAOx4SPE+vHoV5yCMbnmphmZFOlDZtq16LRx9TZQvTb37nuuQNNUw6UOSJI40xzq2OcRsgpkCXyUpGwCPFs4JTW62eNwMuXoYWbiGRW4U+lfy8xibuXV9N4qp84rFIIEc9eulAyWRiIGNm0EBKPxUgqA9Xzdkq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262544; c=relaxed/simple;
	bh=aiwiWRr2Bq6SzRrCLCyHaPhZrNsvh6sFypke2ryaQjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hv1Rs74V4td/s6zhphEdlFOvdmZtfWZjxwPhNVW6BAdWVISqw+uiOCRS6atkLtuk+mK6FWZBEH5LbKK4FgyMesuAM/WwyOcMU4NOOApEgbcSY6ybok9Cy5Y3uVAqiD9mG8mMw55aP/IBwU5l3kfhFDoowUc6Hh0aFwMYAQYSAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoPrHozl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1457DC2BD10;
	Tue, 16 Apr 2024 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262544;
	bh=aiwiWRr2Bq6SzRrCLCyHaPhZrNsvh6sFypke2ryaQjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoPrHozl0NRPz87IB1jlqgVCqEgQXomTZEUq5XGRSk7SBHLgZpTYmI01qej+lWIDN
	 frVmUeOi57JT6jvdSEFotcBOLndBPqKFtxP+wQKCwl52EVNFvMsd6+Ncj8LOV+tlmC
	 sTdQDaf4hYSFKIyz5/S6KiY4mW3lkBDXvYBgLYiU2987E6/WJoDk6jUWtTR2pg/UF5
	 2oCb+MJmszYnywdhpj5MbdPJ9lMwjM2imR3nm/WUvMkki9hKN5XIFfLw11lt7/Z60W
	 bM+UfQMOplQW7ZHunk8BEhq4Ci1Z+FBTxwIQP9L5YQEkbG5wGHO/zqG5EvScZc+Qgs
	 YpLoMcaalvrNg==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v4 14/14] selftests/bpf: Use make_sockaddr in ip_check_defrag
Date: Tue, 16 Apr 2024 18:14:00 +0800
Message-Id: <cf2b340582b17a4337ef0910bb14e5adbdc48fa3.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper make_sockaddr() exported in network_helpers.h
instead of open-coding in test_bpf_ip_check_defrag_ok() in
prog_tests/ip_check_defrag.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/ip_check_defrag.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 284764e7179f..aafadb0ca666 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -220,21 +220,9 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	if (ipv6) {
-		struct sockaddr_in6 *c = (struct sockaddr_in6 *)&caddr;
-
-		c->sin6_family = AF_INET6;
-		inet_pton(AF_INET6, VETH0_ADDR6, &c->sin6_addr);
-		c->sin6_port = htons(CLIENT_PORT);
-		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
-	} else {
-		struct sockaddr_in *c = (struct sockaddr_in *)&caddr;
-
-		c->sin_family = AF_INET;
-		inet_pton(AF_INET, VETH0_ADDR, &c->sin_addr);
-		c->sin_port = htons(CLIENT_PORT);
-		err = bind(client_rx_fd, (struct sockaddr *)c, sizeof(*c));
-	}
+	make_sockaddr(ipv6 ? AF_INET6 : AF_INET, ipv6 ? VETH0_ADDR6 : VETH0_ADDR,
+		      CLIENT_PORT, &caddr, &caddr_len);
+	err = bind(client_rx_fd, (struct sockaddr *)&caddr, sizeof(caddr));
 	close_netns(nstoken);
 	if (!ASSERT_OK(err, "bind"))
 		goto out;
-- 
2.40.1


