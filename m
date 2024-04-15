Return-Path: <linux-kselftest+bounces-7936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D48A4812
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877852820AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E76139;
	Mon, 15 Apr 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGwxwatN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004314A84;
	Mon, 15 Apr 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162722; cv=none; b=cxMduys9z1rZKLeR0RqRT25NOMPy4j89Q4SE7N2BkGYtbMCYsYOJM44xiUEvFsolL2F5TlwvYR+UMgRnV7PO5alBYgJsAAY8eeKs0/fiHfMct1S4NHS1UAyaWz27mFJ4V3x51zS2XXEfxV6YvWOatjU0CJAnrO73THPMoiNT21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162722; c=relaxed/simple;
	bh=54jFizVFFf8NBRR2CCv6ylZ9Ap71aVlDuz+dvVztuuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THyup5VElaZkPhcN6TZ3Xqbfhc2NbR3rwMHYtqL/qcRW28F9m62tBUzAP2o6xSlEj3mLK3EXPW2ni//kNlZFa7i5CE9GozSdgkBN16Jj3E6iZHt04EcJk98xm6p6Xf1mydJs2HFU9SsrSzNPYR0zybafFJdZ/nEnQTpZSH7lNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGwxwatN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A4C2BD11;
	Mon, 15 Apr 2024 06:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162721;
	bh=54jFizVFFf8NBRR2CCv6ylZ9Ap71aVlDuz+dvVztuuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGwxwatNr0mDNPv963n/RBppSt2KmWo+qgwv3bON1HqiZvx+cPmukaAU8dEh1jmaf
	 zIFWg0tSJtrazm39KzfJ3A0KidIlfqTpKerCm8Rjj+QHvCp0go/GcoJfv5Pr1sREUo
	 D13lUJTahVXCtIgC/Uim2OFq9QEFo+tZA16TVYONuvG0flD1QbmjkLfjaAMx0bc/8I
	 gt9y8T4F7xHtVb0UW6P8lB3mA1hj6aYlSooYxKeQTiH+kyABEE+3GA+4vVyfTu8rX1
	 CzhCJFWg0R8Fu6duzxuL4PB/TROvudZ2vzWNTAe6FC03BX27bYisrZ3PWmXjRmpS9F
	 RPvBiHnD4e2hQ==
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
Subject: [PATCH bpf-next v3 5/9] selftests/bpf: Use start_server_addr in sk_assign
Date: Mon, 15 Apr 2024 14:31:14 +0800
Message-Id: <ad9c8b295c37e654e387c407a041b0eb1790151d.1713161975.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/sk_assign.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

The code that sets SO_RCVTIMEO timeout as timeo_sec (3s) can be dropped,
since start_server_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 33 +++----------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 1374b626a985..70c1a5893830 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "test_progs.h"
+#include "network_helpers.h"
 
 #define BIND_PORT 1234
 #define CONNECT_PORT 4321
@@ -73,30 +74,6 @@ configure_stack(void)
 	return true;
 }
 
-static int
-start_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd;
-
-	fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		goto out;
-	if (CHECK_FAIL(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec,
-				  timeo_optlen)))
-		goto close_out;
-	if (CHECK_FAIL(bind(fd, addr, len) == -1))
-		goto close_out;
-	if (type == SOCK_STREAM && CHECK_FAIL(listen(fd, 128) == -1))
-		goto close_out;
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int
 connect_to_server(const struct sockaddr *addr, socklen_t len, int type)
 {
@@ -302,15 +279,15 @@ void test_sk_assign(void)
 
 	for (i = 0; i < ARRAY_SIZE(tests) && !READ_ONCE(stop); i++) {
 		struct test_sk_cfg *test = &tests[i];
-		const struct sockaddr *addr;
+		const struct sockaddr_storage *addr;
 		const int zero = 0;
 		int err;
 
 		if (!test__start_subtest(test->name))
 			continue;
 		prepare_addr(test->addr, test->family, BIND_PORT, false);
-		addr = (const struct sockaddr *)test->addr;
-		server = start_server(addr, test->len, test->type);
+		addr = (const struct sockaddr_storage *)test->addr;
+		server = start_server_addr(test->type, addr, test->len);
 		if (server == -1)
 			goto close;
 
@@ -323,7 +300,7 @@ void test_sk_assign(void)
 		/* connect to unbound ports */
 		prepare_addr(test->addr, test->family, CONNECT_PORT,
 			     test->rewrite_addr);
-		if (run_test(server, addr, test->len, test->type))
+		if (run_test(server, test->addr, test->len, test->type))
 			goto close;
 
 		close(server);
-- 
2.40.1


