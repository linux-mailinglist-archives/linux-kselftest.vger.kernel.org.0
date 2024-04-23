Return-Path: <linux-kselftest+bounces-8689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302A8AE25C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360B4B215A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E545F84F;
	Tue, 23 Apr 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM2sqY40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FF481D1;
	Tue, 23 Apr 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868574; cv=none; b=NBBkeuoK1IbWd2RfvGdzL2IJB+i9E77DEESmhtGU5AgBUZZ8mim/IT86SxEVGlFHFhAcrq3n/dgHzw74H24S4A5VAe6aUuCAb9RCciWGYkrWZQd7PSQdWqYHQNoGaZZJKUs4qqJ5F3uP5fovcE0bYcvPdqsMIuDez1KWU+TwxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868574; c=relaxed/simple;
	bh=r7T1ryaSxmy71ojJGkVFH92IAYzMIjXsTzzREpeiiJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRbEhV1AJKg+l21ZgKRKZ7D0dveLLeuwSlPE0852FW+HGfL+VHQplXX1neDgdjfbnaS8MZBW5LaVNbTPeiivs4W/QeE9uW6DS2mUF3J9rXtWa6p7/LDItwHV5p63UWk4DZnKm+gaeVgCDpMHFdNaygwnNodrqHx6LFMI3/Zl5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM2sqY40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4EDC3277B;
	Tue, 23 Apr 2024 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868574;
	bh=r7T1ryaSxmy71ojJGkVFH92IAYzMIjXsTzzREpeiiJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM2sqY40XUGzXZgN3NLL82cn4sKlZASFjpOjjmbVmeNYHIOFdPCBQ9gLtct+Hq6lO
	 1VOKN35gBv2mgbpfhcwfY+IB5F4Tw3CTCwOOeK6H/OT70wZ5ZtFIpdNxy0a87v8d0S
	 YOHOYC0P4/JqUSPwrtYkvC5Kvmx/KEVFm9jwui9pfBMOp0t0/jXs1jLcmd6nhYOePd
	 m+4G8mlRS7r+07TTXS1j3pp9z4Y8o4cL+Q/CaGTptCyH90bLMbTyG4/wBtc4OdspEf
	 DsBdMbs3Z16a/I/s2skjZ/IRpGw9tHSD9NtZb+DEYjLa15PDUXMknE5qwLdmEQtT9O
	 Dc0+h2IYPM31A==
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Use make_sockaddr in test_sock_addr
Date: Tue, 23 Apr 2024 18:35:31 +0800
Message-Id: <1473e189d6ca1a3925de4c5354d191a14eca0f3f.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/test_sock_addr.c | 64 +++++---------------
 1 file changed, 14 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 2e29dd9d8fc3..420675363b02 100644
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
 
@@ -757,9 +720,9 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 		return -1;
 	}
 
-	if (mk_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
-			(struct sockaddr *)&dst4_rw_addr,
-			sizeof(dst4_rw_addr)) == -1)
+	if (make_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
+			  (struct sockaddr_storage *)&dst4_rw_addr,
+			  &addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -812,6 +775,7 @@ static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test)
 static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 					 const char *rw_dst_ip)
 {
+	socklen_t addr_len = sizeof(struct sockaddr_storage);
 	struct sockaddr_in6 dst6_rw_addr;
 	struct in6_addr src6_rw_ip;
 
@@ -820,9 +784,9 @@ static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 		return -1;
 	}
 
-	if (mk_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
-			(struct sockaddr *)&dst6_rw_addr,
-			sizeof(dst6_rw_addr)) == -1)
+	if (make_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
+			  (struct sockaddr_storage *)&dst6_rw_addr,
+			  &addr_len) == -1)
 		return -1;
 
 	struct bpf_insn insns[] = {
@@ -1086,17 +1050,17 @@ static int init_addrs(const struct sock_addr_test *test,
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


