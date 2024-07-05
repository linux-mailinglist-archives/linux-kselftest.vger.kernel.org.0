Return-Path: <linux-kselftest+bounces-13226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3F9280CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B11F250C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAE13A412;
	Fri,  5 Jul 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcnGBD+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D7225AE;
	Fri,  5 Jul 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148362; cv=none; b=G9UZDPvU9/B85xJvnyNiwsDCtd/3kwTkNFHKS8+7i2/aUDoKxeI3IiRHon5OdQ8Vjhsmqmf3zVWoNja/5WnE6J3cyb3rlFlgllsYZneVn78Zu48da/hxnEviQL/kRjAdzXssP7+yQgZlRZb/g5Vfe5IFfAIyadBu8uLCJPw9xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148362; c=relaxed/simple;
	bh=B7hg/lyFr/T3CIqXns6zB9hcYkz6130EeWwLxus1WNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8RmneGVuXbGXAOB7xAtKBFspjjrfTOGWA6IuDPlpGliltR3kznbVp9/rzAlkFf+4m+hY7e+8hz/WVVGsQ1t1/YtXBpnXVbVAlQa848zYu6gAgMsXSrkvSyD7jDInT/k3kzPPNnKxeQqXTjsY2NP0J7R0T9HCGZCXg/jL+v9YD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcnGBD+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45670C3277B;
	Fri,  5 Jul 2024 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148362;
	bh=B7hg/lyFr/T3CIqXns6zB9hcYkz6130EeWwLxus1WNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcnGBD+9XGnefj7PhzpcE54oyqbkT9fRGwsooMSNI3t0s2NTnUQa4u9V6sQhMXGUK
	 /3DbqMlGuiNq32/pNJmzl/e6SV85nCfOQZSKkDvtI8vJo4x4FntasqHSwhUdM4ag2q
	 0bfmyoBxydmjHqVmTPqEeXNvQnguu79WbaZ5X1AFjkrP9GBn+a+gZBoIPMiCAvbaYA
	 aRAeaUhnSL/mLDORkUZJv21dZaf2JNStPdnqZSA2PqkKLaDCicxUYzaaL59QqA8r3w
	 LIPTyaYwYbt7fk/Xl0Legavdki2u1Jz5kqLzR9nNuBsisrAnonTf4PT5imRcSWi8KU
	 6SrjXPr4IKfBg==
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
Subject: [PATCH bpf-next v8 8/9] selftests/bpf: Use connect_to_addr in sk_lookup
Date: Fri,  5 Jul 2024 10:58:30 +0800
Message-ID: <52c22148c66184baf5ba09d60c06d49a8a33d743.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/sk_lookup.c      | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ef4a3db34c5f..a436ed8b34e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -231,23 +231,19 @@ static int make_server(int sotype, const char *ip, int port,
 
 static int make_client(int sotype, const char *ip, int port)
 {
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	struct sockaddr_storage addr = {0};
-	int err, fd;
+	socklen_t len;
+	int err;
 
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
-
-	return fd;
-fail:
-	close(fd);
-	return -1;
+	return connect_to_addr(sotype, &addr, len, &opts);
 }
 
 static __u64 socket_cookie(int fd)
-- 
2.43.0


