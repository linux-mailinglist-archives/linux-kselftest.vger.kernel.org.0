Return-Path: <linux-kselftest+bounces-8109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268868A67F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08B11F21C98
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147286AFE;
	Tue, 16 Apr 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNhIaJ0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B386250;
	Tue, 16 Apr 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262461; cv=none; b=tBd6LQ9PRy7oeh6wvGh95mkYB00Jw5/2JNIIq6nxmDJosSnBvqeRG1NooOeUsmDl3lCepFJsLyLOY/hrxNhGTlpBTpfmTAwY9JmHI3diX/JMMEE2Rr8ISxoj8yIOYT1pe+J1eBx0YciqyRHDrkejv2l9Kq39fnaZ+AsR+LOJWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262461; c=relaxed/simple;
	bh=rr9iJteBMSLzZtXVxnrC2eTFd0xg6hkIfIm7606fjoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8bMV3G+vdDY9roBZe57MdTNWXCzvZSIN5vdyFrit31NoNFVObBaRC6rc3cQYP4lPUMHiUR3TRKCYexMtNMCYA8B8Qxv8f0sBBM9fI7cf7e0AWeFZukrPlcYCjj+mscQ7csob9b6xux1NFpiqFFdB2RVzJDBcdcHaBVdmGlsvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNhIaJ0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07948C2BD10;
	Tue, 16 Apr 2024 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262461;
	bh=rr9iJteBMSLzZtXVxnrC2eTFd0xg6hkIfIm7606fjoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNhIaJ0IxfBmNOa2Rb4rvN3c4ffY7rX0+wREy7fsqbUPYhQ0MYQv1t4i8955tdKCG
	 DxFCHwxQepQoMS6Eu7oVHeVt2Vi3ToY0JC9hRf3/eHiA2cVu54Yn0AF39BgeHdPTO2
	 zRpWAY8HGcYKo5adudCuOWbo336NejDbOqwsrhK9F3qPVHLKbQNs7SdH/whagltpWi
	 kalPiZAzmOwEJybngg4C7vzjJSbvVstYVK26nP2O0G8KGKW6+ukrmSLlb8eQ7Mjeri
	 GN/YmXltKmMiotCAUtwSDphlI5WWvIdlEL/eYEoEOaIVr3/eIZYuu2UIJ3eQl3vFQj
	 FvTRyxD1hJ2RQ==
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
Subject: [PATCH bpf-next v4 01/14] selftests/bpf: Update arguments of connect_to_addr
Date: Tue, 16 Apr 2024 18:13:47 +0800
Message-Id: <3507e70e3e23cdccf6ca1905f9e066bcfd41337f.1713262052.git.tanggeliang@kylinos.cn>
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
index dc1fd7af9c7a..563dde8617dd 100644
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


