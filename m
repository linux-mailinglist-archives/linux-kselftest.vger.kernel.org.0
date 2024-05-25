Return-Path: <linux-kselftest+bounces-10691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9988CEED0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED01B21005
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448F4084D;
	Sat, 25 May 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVd/GRgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844E18044;
	Sat, 25 May 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638916; cv=none; b=kt2YnXCJe897qjwOVUz2wDjnhcIGOGf1QnqLL7lYbgcs2+gctYtBNiEUBoZ1kzX2uGTsXRU26fpW8cah87v5ikhNY3tuRm2YkXFa74utIolN1cedZmpapZ1A0FWtVb+rgaDOT0y7rrUxADKKFRYjgmaCjxcZ5dJtbxHm/UqXM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638916; c=relaxed/simple;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etwerl+/0AFF2vs5yHFSxAXXJATu66UpXTJFQqf/fiONBmNn+8w3tZYT7YsWt2u0DW3gV7mehFlVu3nnCfCa8xxDFtmxWYuLT34cbJmuVic7MaKLLvKfD2t77/RAfY0jwC5fxfEqIiJigxAG3qIw7+9Xb5JvPNDYjsEEUBxrcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVd/GRgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD52CC3277B;
	Sat, 25 May 2024 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638915;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVd/GRgVelizq+TR98Fn0i6XE08W/TDrwQZiIJHkqYAPpopYPwNIOfY2FL+LogQvL
	 2bEsb036fx8CAPygZeYlYBFI57bxNCnJTZK7KrO9HcNR+2TeIT2CUztlRWttQF8OzH
	 xixf/jwHcoJsLykUgUovOglOfrDu8bdywWVRXsnnVQiLkQA53Ug1onXhRS00QWykh6
	 j56oaZ8NnxtY/qe05dAm8hOY5KkQTT2DNzT/+8ejxwATyOM++WXFJe7vd3ByQI3s7c
	 fMyBedcUm17T8Gd8oXTaiOFA8jhTi5yOlVbiLvPTaw+jn7lX1iEszzFwRq9XXqq+Yp
	 J7DyoRou2O/ZA==
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
Subject: [PATCH bpf-next v5 1/7] selftests/bpf: Drop struct post_socket_opts
Date: Sat, 25 May 2024 20:08:15 +0800
Message-ID: <f8bda41c7cb9cb6979b2779f89fb3a684234304f.1716638248.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716638248.git.tanggeliang@kylinos.cn>
References: <cover.1716638248.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's not possible to have one generic/common "struct post_socket_opts"
for all tests. It's better to have the individual test define its own
callback opts struct.

So this patch drops struct post_socket_opts, and changes the second
parameter of post_socket_cb as "void *" type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c               | 2 +-
 tools/testing/selftests/bpf/network_helpers.h               | 4 +---
 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c    | 2 +-
 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c | 4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 35250e6cde7f..4d776b78929c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -133,7 +133,7 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
 }
 
-static int reuseport_cb(int fd, const struct post_socket_opts *opts)
+static int reuseport_cb(int fd, void *opts)
 {
 	int on = 1;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 883c7ea9d8d5..40011e0f584b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,8 +21,6 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
 
-struct post_socket_opts {};
-
 struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
@@ -30,7 +28,7 @@ struct network_helper_opts {
 	bool noconnect;
 	int type;
 	int proto;
-	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
+	int (*post_socket_cb)(int fd, void *opts);
 };
 
 /* ipv4 test vector */
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 1d3a20f01b60..7cd8be2780ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -70,7 +70,7 @@ static void *server_thread(void *arg)
 	return (void *)(long)err;
 }
 
-static int custom_cb(int fd, const struct post_socket_opts *opts)
+static int custom_cb(int fd, void *opts)
 {
 	char buf;
 	int err;
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index 7b5fc98838cd..aebc58c24dc5 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -139,14 +139,14 @@ static int run_test(int server_fd, int results_fd, bool xdp)
 	return ret;
 }
 
-static int v6only_true(int fd, const struct post_socket_opts *opts)
+static int v6only_true(int fd, void *opts)
 {
 	int mode = true;
 
 	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
 }
 
-static int v6only_false(int fd, const struct post_socket_opts *opts)
+static int v6only_false(int fd, void *opts)
 {
 	int mode = false;
 
-- 
2.43.0


