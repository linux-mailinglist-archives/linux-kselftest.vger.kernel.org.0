Return-Path: <linux-kselftest+bounces-7932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236708A480A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BA51F21F68
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D618847C;
	Mon, 15 Apr 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFJbQVlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC61CFA0;
	Mon, 15 Apr 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162696; cv=none; b=JiBPZNgl4YsGQzGvY6S/jx3paeCdtch+/CokXOYs0jw8z0xVqdCnfk7D1h1A24G+p4SQwL8vEaaRQHP0WHFHpMR0xaiRpec3HDJtfziJiOyFqEc6ILB+XvGiW5WRki/fUnPPt3aLvTUEJ6MBlUl0LYGG0M05L46UgQEtC4anWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162696; c=relaxed/simple;
	bh=lVQ27NIhN96wOrSBXkEwwp4P0gP9idgKCSLnupHHGBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmUCj932W+26FooYVcj4HcbOYZM9kTXS0wBf7Bw8QOC0UkCWvEd757S6Or02yJUdu/6qx3/m/2yZPUONQlzs5gUC/6II3RgByoIdaaaml7sUWUldgg6SMpcRAzncbG2Vs311qFlzS0M9D3TTOVIisHyeAs++PAdTfDo+XJ7GyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFJbQVlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0B1C113CC;
	Mon, 15 Apr 2024 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162695;
	bh=lVQ27NIhN96wOrSBXkEwwp4P0gP9idgKCSLnupHHGBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFJbQVlvKjOsMb0PDoUm2OyO5A0Ik3BOcTfb4AMwB33fIXYbroJ4yhrYSjNCAAkNn
	 GSXza7CABHSBvb6MmZ7IyfMtcCN5TSKUPIOcHxjQdqV0Fq7N0EsnBKpfoEaZwayPBz
	 pUspRMs15ZDEC99/QqaSKBhHQP3KhKHP8pPz1APDNNpVedSDhET2Ot4umD10KhMzQ3
	 tFTrQT05H/spx26r8HNp/at4Xz2UX+tUv+st9YnresEsKJIZi0F9640AT0E2eJf6Ue
	 CpFn+aQCXir9vzgIbRXK7WeZXDS2Ja4LgrWagiURtrZ3iSFD/IhYxrKa+JlCCRqD3s
	 dQT7l7fQRZNZQ==
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
Subject: [PATCH bpf-next v3 1/9] selftests/bpf: Update arguments of connect_to_addr
Date: Mon, 15 Apr 2024 14:31:10 +0800
Message-Id: <8f9c68db04baafd8945b8eb1454c842c4b9467d1.1713161974.git.tanggeliang@kylinos.cn>
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

Move the third argument "int type" of connect_to_addr() to the first one
which is closer to how the socket syscall is doing it. And change its
usages in sock_addr.c too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c      | 2 +-
 tools/testing/selftests/bpf/network_helpers.h      | 2 +-
 tools/testing/selftests/bpf/prog_tests/sock_addr.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 2cbf07232f17..3759948439a7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -258,7 +258,7 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
 
-int connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen, int type)
+int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen)
 {
 	int fd;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 70f4e4c92733..ac4da5fdcc95 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -54,7 +54,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
 void free_fds(int *fds, unsigned int nr_close_fds);
-int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
+int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 5fd617718991..b182667e78c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -328,7 +328,7 @@ static void test_bind(struct sock_addr_test *test)
 		goto cleanup;
 
 	/* Try to connect to server just in case */
-	client = connect_to_addr(&expected_addr, expected_addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &expected_addr, expected_addr_len);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -357,7 +357,7 @@ static void test_connect(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &addr, addr_len);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -538,7 +538,7 @@ static void test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &addr, addr_len);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
-- 
2.40.1


