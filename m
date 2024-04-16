Return-Path: <linux-kselftest+bounces-8120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6C8A680C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4091C21362
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A381272AB;
	Tue, 16 Apr 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRI3vfEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18534126F37;
	Tue, 16 Apr 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262531; cv=none; b=oO92DWlGNWbSkHVwwrZXhbQh7PuqyUB2wLEr0l3ra2MFfCLNKv4cfHzrq97m2SnITOPiIfC7ZP0JT1vmv4s0Jg0NyLgMoh9J4W26371HDKMETg1kjVKhhH7WM4IJEdmnXA5DvlBM4DRe+OVMpsupE0zQeWmsX7vYKPtR8rXhIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262531; c=relaxed/simple;
	bh=0SGNaJX4OtE+aw/WTKqwFvDrAJbNUVJ5YpY/yRg2hhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+gdSKJVR2cUjsYbIq/+TgudO0GVd2vWnkVUkj1s0CTn8OYSTqW/XfioCOvaEaufC7wlxnMlsW0MmvrHLepYk1iVPEXLE0U/MYoBLDZpQto0Htv01JDCDR27957aRJ794aZnzsiaDUQQ0sZApfr5A5akLUq/B8xjP8WwTUYtazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRI3vfEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF89FC3277B;
	Tue, 16 Apr 2024 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262530;
	bh=0SGNaJX4OtE+aw/WTKqwFvDrAJbNUVJ5YpY/yRg2hhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRI3vfEjxXyZY/UDF1HE39xYG+5JGcVQXz4sf+ndKy3oQNY2EK4BNQkAJmTY2c+qh
	 geYRnOAn2pYlIwpbNSzNgFLwvuO2NM5hWzT0PUfe9r+uSnyVvw21Dd+cjhbTSa6xBv
	 cgJmiVeHtezwOZlAv05JTbtQoOpFqFsVzct6TZAiyF4JNoXV16mN6rbi5TQC95hF47
	 tT0yKOQHtZthRbS/eYyFbeWn8eU/vadRvZyRhmFLZg0y6EKJNPXdoe13D4oA/Gc7WE
	 vqqeAPZvIiqdlBGLseyfiOjmXlHYOHxVbDW/BLQW0df0gbO2vmI19dqKNjERGEtjHU
	 j0xGgltnobwxw==
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
Subject: [PATCH bpf-next v4 12/14] selftests/bpf: Use make_sockaddr in test_sock_addr
Date: Tue, 16 Apr 2024 18:13:58 +0800
Message-Id: <3f19a4fdec7ba60ff306bbd88cc105db1079b2a5.1713262052.git.tanggeliang@kylinos.cn>
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
instead of the local defined function mk_sockaddr() in test_sock_addr.c.
This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 62 ++++----------------
 1 file changed, 12 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 422255c8575e..09503a9b4bec 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -605,44 +605,6 @@ static struct sock_addr_test tests[] = {
 	},
 };
 
-static int mk_sockaddr(int domain, const char *ip, unsigned short port,
-		       struct sockaddr *addr, socklen_t addr_len)
-{
-	struct sockaddr_in6 *addr6;
-	struct sockaddr_in *addr4;
-
-	if (domain != AF_INET && domain != AF_INET6) {
-		log_err("Unsupported address family");
-		return -1;
-	}
-
-	memset(addr, 0, addr_len);
-
-	if (domain == AF_INET) {
-		if (addr_len < sizeof(struct sockaddr_in))
-			return -1;
-		addr4 = (struct sockaddr_in *)addr;
-		addr4->sin_family = domain;
-		addr4->sin_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1) {
-			log_err("Invalid IPv4: %s", ip);
-			return -1;
-		}
-	} else if (domain == AF_INET6) {
-		if (addr_len < sizeof(struct sockaddr_in6))
-			return -1;
-		addr6 = (struct sockaddr_in6 *)addr;
-		addr6->sin6_family = domain;
-		addr6->sin6_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1) {
-			log_err("Invalid IPv6: %s", ip);
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 static int load_insns(const struct sock_addr_test *test,
 		      const struct bpf_insn *insns, size_t insns_cnt)
 {
@@ -749,6 +711,7 @@ static int recvmsg_deny_prog_load(const struct sock_addr_test *test)
 
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
+	socklen_t addr_len = sizeof(struct sockaddr_storage);
 	struct sockaddr_in dst4_rw_addr;
 	struct in_addr src4_rw_ip;
 
@@ -757,9 +720,8 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 		return -1;
 	}
 
-	if (mk_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
-			(struct sockaddr *)&dst4_rw_addr,
-			sizeof(dst4_rw_addr)) == -1)
+	if (make_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
+			  (struct sockaddr_storage *)&dst4_rw_addr, &addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -812,6 +774,7 @@ static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test)
 static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 					 const char *rw_dst_ip)
 {
+	socklen_t addr_len = sizeof(struct sockaddr_storage);
 	struct sockaddr_in6 dst6_rw_addr;
 	struct in6_addr src6_rw_ip;
 
@@ -820,9 +783,8 @@ static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 		return -1;
 	}
 
-	if (mk_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
-			(struct sockaddr *)&dst6_rw_addr,
-			sizeof(dst6_rw_addr)) == -1)
+	if (make_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
+			  (struct sockaddr_storage *)&dst6_rw_addr, &addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -1086,17 +1048,17 @@ static int init_addrs(const struct sock_addr_test *test,
 {
 	socklen_t addr_len = sizeof(struct sockaddr_storage);
 
-	if (mk_sockaddr(test->domain, test->expected_ip, test->expected_port,
-			(struct sockaddr *)expected_addr, addr_len) == -1)
+	if (make_sockaddr(test->domain, test->expected_ip, test->expected_port,
+			  expected_addr, &addr_len) == -1)
 		goto err;
 
-	if (mk_sockaddr(test->domain, test->requested_ip, test->requested_port,
-			(struct sockaddr *)requested_addr, addr_len) == -1)
+	if (make_sockaddr(test->domain, test->requested_ip, test->requested_port,
+			  requested_addr, &addr_len) == -1)
 		goto err;
 
 	if (test->expected_src_ip &&
-	    mk_sockaddr(test->domain, test->expected_src_ip, 0,
-			(struct sockaddr *)expected_src_addr, addr_len) == -1)
+	    make_sockaddr(test->domain, test->expected_src_ip, 0,
+			  expected_src_addr, &addr_len) == -1)
 		goto err;
 
 	return 0;
-- 
2.40.1


