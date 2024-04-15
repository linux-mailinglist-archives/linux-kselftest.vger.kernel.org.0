Return-Path: <linux-kselftest+bounces-7940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789578A481C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DABD1F21CBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DB12B89;
	Mon, 15 Apr 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdfg+wD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35581BF53;
	Mon, 15 Apr 2024 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162748; cv=none; b=h83IwBlRNCVQ3MvlxjHtexxXZ/QcYPJJtzV/rxJBbIryGVgV/zExPTyOc2IHcm2t/fn305X+RzcHRXwvNNacKd/WolwG0ZC/pPH/meI4KBAXWdXBau1c5ORdOwsmwKllUYHuuORcDVcTddLN9N+WEYM0d6Wbczlhsf8KH7YCCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162748; c=relaxed/simple;
	bh=eEf0d+YYYSKJr8JQ0MHAhSmpH3ZHVzisAU/wx98NNtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR2iBmE8ETbzZ9hG2HWUZs+punEk0Eyvxu8+9mx35ebzC1oGYsELyt4A38ZFrWPyi+rS5QGtnF8V8m04CQQTA5Y9xTwHNxkC4J6G9+Ld0kT07gSRWtBCWR5zrfDIKfgz42MSXh4oI9HY3RbXhEDjEmtjdWfiwJgcPIoGflsPHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdfg+wD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3485C3277B;
	Mon, 15 Apr 2024 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162747;
	bh=eEf0d+YYYSKJr8JQ0MHAhSmpH3ZHVzisAU/wx98NNtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdfg+wD48J7YavJupue+qQOrKAQrYYrHy/70nDD2Zdwf0hY0MQ3BLUgvGAqA+MmGg
	 lLzxA34lBirrQC704IZHHXKj8xls5ZXvBwSEn8UFfQcflRQaHETHAvXhnjSR0sSmKX
	 Jc/W/cyYaGGGXB46nqEZz7TrQ6EF+jQz8YfRR4hXHtflzNa88Fp8btuFB0yjz0vE2U
	 sW9NZXpGrJjiTwQLiOXwGBH0wnoxx0zgg3ctA4WFMP4qyGwyunxdJGxn1SHCviK9Ei
	 jd8lvUiDAQUUMVd/ppa4bnqVEUC9JAydbZpfI7oJU8FcoBAdlqaFHyyhZ/QLHg3NdP
	 uf2m2m0ViEMWA==
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
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Use connect_to_addr in test_sock_addr
Date: Mon, 15 Apr 2024 14:31:18 +0800
Message-Id: <80583a00f977ab90b6a0753a4ca8a0eb946babc1.1713161975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713161974.git.tanggeliang@kylinos.cn>
References: <cover.1713161974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_sock_addr.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 36 ++------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 9ce5dad7468b..422255c8575e 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -940,38 +940,6 @@ static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
 	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
 }
 
-static int connect_to_server(int type, const struct sockaddr_storage *addr,
-			     socklen_t addr_len)
-{
-	int domain;
-	int fd = -1;
-
-	domain = addr->ss_family;
-
-	if (domain != AF_INET && domain != AF_INET6) {
-		log_err("Unsupported address family");
-		goto err;
-	}
-
-	fd = socket(domain, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto err;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, addr_len) == -1) {
-		log_err("Fail to connect to server");
-		goto err;
-	}
-
-	goto out;
-err:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 int init_pktinfo(int domain, struct cmsghdr *cmsg)
 {
 	struct in6_pktinfo *pktinfo6;
@@ -1156,7 +1124,7 @@ static int run_bind_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Try to connect to server just in case */
-	clientfd = connect_to_server(test->type, &expected_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &expected_addr, addr_len);
 	if (clientfd == -1)
 		goto err;
 
@@ -1188,7 +1156,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (servfd == -1)
 		goto err;
 
-	clientfd = connect_to_server(test->type, &requested_addr, addr_len);
+	clientfd = connect_to_addr(test->type, &requested_addr, addr_len);
 	if (clientfd == -1)
 		goto err;
 
-- 
2.40.1


