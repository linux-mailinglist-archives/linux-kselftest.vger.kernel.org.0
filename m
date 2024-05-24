Return-Path: <linux-kselftest+bounces-10646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729398CDFB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DCEB21358
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BDBE47;
	Fri, 24 May 2024 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKd2KeLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB491BF53;
	Fri, 24 May 2024 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520943; cv=none; b=eP/gJLdLuPEo2G3R1M8u3yr2YYFVDWZDvjNc6aYS4K3DxGEHqPV7bXScqAL1A9jqu45KNqEYxRWFPLa4NChzcHEe3pLNtlfpEBy26QdgGVcJZOc6c3UnmGzSDB7Q3dz24PAPpuC/zNrML4ZDI3cS9oBjJSg0RVgHzGHxueB3CZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520943; c=relaxed/simple;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB/eh6qYi2VZxGGlgTW29dsEMKw1VbLXGPmcLW2R/z/lILXglJe17Z88eIzgyho7cZuesLbp2KYGRvnneEdobtptRwJL0duFSnWvFFvhyp0xt4ViwRLBHS+DurzAuuqKhBKgrnyws3YthOYgOUPtPLY/RzUp0REAKGUiDbTj9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKd2KeLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C339C4AF07;
	Fri, 24 May 2024 03:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520942;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKd2KeLSaP8qNgqdu8PUYki8jmah2GN8vEw7MEMleKEfHTG0dX6qI1RaEbjF6Sa8q
	 l0CWgru/8Kz4eIoeaj3aT4LmPotNB96QaAl/NvWq9Ms0RE3ODC9PQcYFVSsdCbSAsX
	 lWuhl4lQ08ginOzvrLvA851KLxane6D2r7TP8vOVvMkdLgAJ9qUP3hMafQrifxRBGp
	 VvFcLTxVcJnf7FUgbGr3ArSMVtC/sgYU14IsyFK9ii3gyEnRI1It+o11K0O/MjHJrA
	 fEqbKZ+c1lflRTrl4EbjlhHYY4X9UifVAOP8MZd/00RP87BCNURVKQiWAzozKyQSNV
	 GCxAShM+JU3+w==
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
Subject: [PATCH bpf-next v4 1/6] selftests/bpf: Drop struct post_socket_opts
Date: Fri, 24 May 2024 11:21:49 +0800
Message-ID: <d58f5a0905679adbbbe6308e865150886391c168.1716520609.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716520609.git.tanggeliang@kylinos.cn>
References: <cover.1716520609.git.tanggeliang@kylinos.cn>
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


