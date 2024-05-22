Return-Path: <linux-kselftest+bounces-10567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36A8CBDB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DB528211D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9C80BFE;
	Wed, 22 May 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLTUw4Rq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184B8060D;
	Wed, 22 May 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369848; cv=none; b=GeSLS6NEgjJxd3dvp7jfvNgYq2VNDVRiLbpmwWW0LigFguNPZEPLfwH1fJlhzQ377BoSit5pQzLiNfwuLmocQtexxfe+yejY1qapopFzVjBRyFleLJOIMx2Q7usVvA655+hm3twUpw084GQiwrGvBhl/+d8+FFGFXTFzZ7ye+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369848; c=relaxed/simple;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO4FlTx4oFnsYOYuLt561aX3eLWsjfkvWYlWzykBLlmPGmE0IRUwj5iIKQUx/ZwZKCfDZ2dgS1q3lmraxH7fu3w1vtF0TUql7VFt5cPtr30v33G0VaxXDeR3CPzkTdQlKgZ+590a/SXByzHmdM4n552WKyGvPoq8uv954bsvi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLTUw4Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C803C4AF07;
	Wed, 22 May 2024 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369847;
	bh=z/rJWlSUZ4/YuGyhiu6hcQQN4WWNf6a84wS8YU3ikvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLTUw4RqI3OwYclbij2g0e3wAOP2UpxQnsLpvY6FUjFXMZpwF5v+AWjzgsX/dCSZF
	 +6XyyT90TPLV1WxA+DI4Q36KwqTvaQgpkSC3pXPxaVqnW1kQLsY7jcSMfFyC09e9g7
	 AjFAne2OU/hB/n+qfG2sLuCtJjiw/dzjY7irATVRidBpNMsn1t1j8Dl49vSCnfAGdj
	 Nwc0Am/zY1n+sS1elfNmp2Pwmp9ELVvnFqJ0Pl4giAE/y+OoL+FSQD/J3NeltdjTYp
	 000MKDyjYiHEeqjKS3cJjFbgHo/t0KU5cnwsWaadNMEsN4G8wsYV/Om7mUGi914kSB
	 q7NXhCr6qti9A==
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
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Drop struct post_socket_opts
Date: Wed, 22 May 2024 17:23:43 +0800
Message-ID: <532ae86cf0978107d6b9e80f682e0efd0a3515cb.1716369375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716369375.git.tanggeliang@kylinos.cn>
References: <cover.1716369375.git.tanggeliang@kylinos.cn>
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


