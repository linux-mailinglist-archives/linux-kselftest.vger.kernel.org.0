Return-Path: <linux-kselftest+bounces-10092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD38C2F4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240D3283ED2
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A943AAB;
	Sat, 11 May 2024 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnJ38I6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFA4204E;
	Sat, 11 May 2024 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397407; cv=none; b=rKhont5ycENI0cIvnoqqvsqV00GOscec9Dc6qpSnLCtrW0Lwk2kuTRp6Moures6JvV769wyyAlefwb+WzhSrrD1u2twJsQsKy63Y7RYyprS1nObmVhaqlLiBcquRB8Uicv0Uro2YR6OxXgqlF6fwPeoipZPmIxJ9PrWyT+2HWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397407; c=relaxed/simple;
	bh=98zZ/NjyeaFDtoVqxPBN/26Bl1zmbL3inBDa1Mvxads=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFQ0TNcrURIiC49Q2CgGKFE0X0qgJhlS9oEAgLfS52YQWAGQBUQZ2AESZm1vBLv5j6G9R3MHhPzNBt29rTI3R6G7eeP0fjpAQjSZUzHYPavsKkBCUugVUrFpdFCTVK5Nuh/086F1gvAgd4zclVCQurnjR7i3znbnPUHuW2Vu8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnJ38I6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064AC2BD10;
	Sat, 11 May 2024 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715397407;
	bh=98zZ/NjyeaFDtoVqxPBN/26Bl1zmbL3inBDa1Mvxads=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnJ38I6X1RQKUCX4LJOohvbhpiSsCQULSt61nmOLWcZws71AafnOX4OGbgev2NlaD
	 NvYAS+pxfFxVU7TlybDjvB+Qj19w0sh0+pJla4PWAUFIEcKa3YQ0LQLO6JH6Esu3cn
	 gXadvgTGX0oshk/b0AfCEoi92IvBI0rWRKP1LqC+vguDPRFet7WPJ5G83zZfyEjPgX
	 d8J+4Emu56AJxakQJdd8w6FPJB6uXBeWS6h74ajB/ATN+aPwo4+40MjUDuN/Yw9XOW
	 aUGuaFi9xep3vb2LKzcmXfOgb3uodX2leSZbm5r3paEUe/YtuMDuNDqrWov0mVq2MW
	 h6Dl1qXKgDdPQ==
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
Subject: [PATCH bpf-next 1/4] selftests/bpf: Use post_socket_cb in connect_to_fd_opts
Date: Sat, 11 May 2024 11:16:25 +0800
Message-ID: <14f54f651baef131c38262246f75768bff02ab00.1715396405.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715396405.git.tanggeliang@kylinos.cn>
References: <cover.1715396405.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since the post_socket_cb() callback is added in struct network_helper_opts,
it's make sense to use it not only in __start_server(), but also in
connect_to_fd_opts(). Then it can be used to set TCP_CONGESTION sockopt.

Add a post_socket_opts type member cb_opts into struct network_helper_opts,
then cc can be moved into struct post_socket_opts from network_helper_opts.
Define a new callback cc_cb() to set TCP_CONGESTION sockopt, and set it to
post_socket_cb pointer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c       | 5 ++---
 tools/testing/selftests/bpf/network_helpers.h       | 6 ++++--
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 9 ++++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 35250e6cde7f..d97f8a669b38 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -338,9 +338,8 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (opts->cc && opts->cc[0] &&
-	    setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
-		       strlen(opts->cc) + 1))
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, &opts->cb_opts))
 		goto error_close;
 
 	if (!opts->noconnect)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 883c7ea9d8d5..e44a6e5d8344 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,16 +21,18 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
 
-struct post_socket_opts {};
+struct post_socket_opts {
+	const char *cc;
+};
 
 struct network_helper_opts {
-	const char *cc;
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
 	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);
+	struct post_socket_opts cb_opts;
 };
 
 /* ipv4 test vector */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 907bac46c774..4eedc161b5b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -80,6 +80,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	close(fd);
 }
 
+static int cc_cb(int fd, const struct post_socket_opts *opts)
+{
+	return setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
+			  strlen(opts->cc) + 1);
+}
+
 static void test_cubic(void)
 {
 	struct bpf_cubic *cubic_skel;
@@ -171,7 +177,8 @@ static void test_dctcp_fallback(void)
 {
 	int err, lfd = -1, cli_fd = -1, srv_fd = -1;
 	struct network_helper_opts opts = {
-		.cc = "cubic",
+		.cb_opts.cc = "cubic",
+		.post_socket_cb = cc_cb,
 	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link = NULL;
-- 
2.43.0


