Return-Path: <linux-kselftest+bounces-10900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7768D4639
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4C9B22069
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F44D8BE;
	Thu, 30 May 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGAEBkRy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE74D8A0;
	Thu, 30 May 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054891; cv=none; b=ExBMvcX5oCMI8O97MOCsubUBoxvpWwbTUNG0Vc/trTj1mY8CNV5NIBJPgILmUeEjrT6jci5qR8F+RGNjqxwjdD8MrVLC6LS0gnuv0eK71rxljP50AdElmHh/4oH1t8SlzSXj5w9GGoz2tgVqqfDB7PTsOqDYXFY+RYCUFMzIbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054891; c=relaxed/simple;
	bh=KA9T0bZg4RXBBfo8b/lctFViV0Hci9FcngJVKmoyRh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMi+Ki33QjqQx8iEvzxZ65ju9iYXc29We/zYHSbPMhHh+o9XDzhjBMzDwcmBMeoLFRuzM4DUf0j2a+ESagKadHzUWpqVZ1M33pY+mtwg9Lj4ADXMvFW0CjHTW/nmq6I+LVtbPpYB07UTXI4SSpAzefwgugiUNJleOuWYjFYEfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGAEBkRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8BC32789;
	Thu, 30 May 2024 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717054891;
	bh=KA9T0bZg4RXBBfo8b/lctFViV0Hci9FcngJVKmoyRh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGAEBkRya6W7uqOT4c9zyePJzwxfWsAZ/dwCpPwlQQ/QGYfdQbBIf6boewYCOx8v/
	 1N8kdAfU33hsoQ5d9zfS4a0VwVzrD9mA8u0I4m9+WpL9HPHVIr6i2ICuPWZsujsC92
	 wMqCu8fS5hl4nYn84wOccs5pe5h23PSbYlhZm946OJ5lndsOpU3jNT0FUdA3H/Yhpv
	 8vdP2fOH8dwyF7c+6WKH8mgZ+N+np287uPv+qSjbyWTXLCYC8MZ8o1KGYhEw4jmMtm
	 Tp6ofXspp5/sfJNIYjC75dFh/fdmSV/LEth+CKOv//kkdFkGB1BO+XQTPZzH+Xvtbw
	 4hltA9uUAiUNw==
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
Subject: [PATCH bpf-next 1/5] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
Date: Thu, 30 May 2024 15:41:08 +0800
Message-ID: <876ec90430865bc468e3b7f6fb2648420b075548.1717054461.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717054461.git.tanggeliang@kylinos.cn>
References: <cover.1717054461.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses connect_to_fd_opts() instead of using connect_fd_to_fd()
and settcpca() in do_test() in prog_tests/bpf_tcp_ca.c to accept a struct
network_helper_opts argument.

Then define a dctcp dedicated post_socket_cb callback stg_post_socket_cb(),
invoking both settcpca() and bpf_map_update_elem() in it, and set it in
test_dctcp(). For passing map_fd into stg_post_socket_cb() callback, a new
member map_fd is added in struct cb_opts.

Add another "const struct network_helper_opts *cli_opts" to do_test() to
separate it from the server "opts".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 61 +++++++++++--------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index ebc7d4616880..2f9d373feb0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -25,6 +25,7 @@ static int expected_stg = 0xeB9F;
 
 struct cb_opts {
 	const char *cc;
+	int map_fd;
 };
 
 static int settcpca(int fd, const char *tcp_ca)
@@ -39,9 +40,9 @@ static int settcpca(int fd, const char *tcp_ca)
 }
 
 static void do_test(const struct network_helper_opts *opts,
+		    const struct network_helper_opts *cli_opts,
 		    const struct bpf_map *sk_stg_map)
 {
-	struct cb_opts *cb_opts = (struct cb_opts *)opts->cb_opts;
 	int lfd = -1, fd = -1;
 	int err;
 
@@ -49,25 +50,9 @@ static void do_test(const struct network_helper_opts *opts,
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (!ASSERT_NEQ(fd, -1, "socket")) {
-		close(lfd);
-		return;
-	}
-
-	if (settcpca(fd, cb_opts->cc))
-		goto done;
-
-	if (sk_stg_map) {
-		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
-					  &expected_stg, BPF_NOEXIST);
-		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
-			goto done;
-	}
-
 	/* connect to server */
-	err = connect_fd_to_fd(fd, lfd, 0);
-	if (!ASSERT_NEQ(err, -1, "connect"))
+	fd = connect_to_fd_opts(lfd, cli_opts);
+	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
 		goto done;
 
 	if (sk_stg_map) {
@@ -116,7 +101,7 @@ static void test_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 
 	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked called");
 
@@ -124,6 +109,23 @@ static void test_cubic(void)
 	bpf_cubic__destroy(cubic_skel);
 }
 
+static int stg_post_socket_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+	int err;
+
+	err = settcpca(fd, cb_opts->cc);
+	if (err)
+		return err;
+
+	err = bpf_map_update_elem(cb_opts->map_fd, &fd,
+				  &expected_stg, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
+		return err;
+
+	return 0;
+}
+
 static void test_dctcp(void)
 {
 	struct cb_opts cb_opts = {
@@ -133,6 +135,10 @@ static void test_dctcp(void)
 		.post_socket_cb	= cc_cb,
 		.cb_opts	= &cb_opts,
 	};
+	struct network_helper_opts cli_opts = {
+		.post_socket_cb	= stg_post_socket_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link;
 
@@ -146,7 +152,8 @@ static void test_dctcp(void)
 		return;
 	}
 
-	do_test(&opts, dctcp_skel->maps.sk_stg_map);
+	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
+	do_test(&opts, &cli_opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
@@ -350,14 +357,14 @@ static void test_update_ca(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_update_2);
 	ASSERT_OK(err, "update_map");
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
 
@@ -386,14 +393,14 @@ static void test_update_wrong(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 	saved_ca1_cnt = skel->bss->ca1_cnt;
 	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_wrong);
 	ASSERT_ERR(err, "update_map");
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
 
 	bpf_link__destroy(link);
@@ -423,7 +430,7 @@ static void test_mixed_links(void)
 	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
 	ASSERT_OK_PTR(link, "attach_struct_ops");
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
 
 	err = bpf_link__update_map(link, skel->maps.ca_no_link);
@@ -530,7 +537,7 @@ static void test_cc_cubic(void)
 		return;
 	}
 
-	do_test(&opts, NULL);
+	do_test(&opts, &opts, NULL);
 
 	bpf_link__destroy(link);
 	bpf_cc_cubic__destroy(cc_cubic_skel);
-- 
2.43.0


