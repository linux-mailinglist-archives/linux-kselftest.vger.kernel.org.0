Return-Path: <linux-kselftest+bounces-10650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E48CDFB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30A91F215E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8C1EB2A;
	Fri, 24 May 2024 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZLN3Pii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32512E4A;
	Fri, 24 May 2024 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520980; cv=none; b=igitpyr6h6k8wp8FpUQ9sYrtKTWLYuatFmcNe42zt4vG0X2DP0xP5zbmdm0TnImtVkuAAvMHAHzLZPIrYlrASqsbSIqFevQu5IIxuDaU5agBb9HVHAy0fiNcBYTZ9+8J21gohdzhnhG85F+S4Nj50KhUko9Dvmoh8u7mAZcvnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520980; c=relaxed/simple;
	bh=XubIlQa9dUdgYfINAo4rCVeAEaVUHHlfByfj9erdbmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nquj/98YXZaIAPhXgiJk42/056qWV6qbGVYxsd64r5/uYB+QcB8kWzJzNgFecgXNbgnEgu+webPh5Or8GxNQFxeyVt8nvUX09I+1gv5ZX0ZKHP1x8IWxDhuZyGF30DfQfyfHVDxTTY0MIrmOdd7PJwIjJclsB2fDZQ1zNa/yafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZLN3Pii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B28C32786;
	Fri, 24 May 2024 03:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520979;
	bh=XubIlQa9dUdgYfINAo4rCVeAEaVUHHlfByfj9erdbmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZLN3PiimnU6vqS0P/FC3HKQLVLx2h3ZgAjbF71W/JURA4Zo37h330PwfXmwTV2I2
	 ZzmSzIFHuM+Wy+wR0xuuelehkWl0/52HQA7Dg8j3TCLMyRnhcrjGXd8JDTdbxJJ+7m
	 7R50jGXmsa5yy8ZGUkIhmDRbo1oIULBcCU2NIZi4URqOessKBOg0PghP+Xyp2eRYHB
	 z0FqHaTtuPzZ7hjzS+61LYW74Zxd/UqvarSK30cRpWRYk9ovjh+CR5JrWHOpuSE+Dn
	 TPq9lzbpkPrQev9WTzO8fPJa9xARUcolRZ3pqh2OUvNeftc0Tr65oFfVpiTvQkAD6/
	 yiJt6EQE4Vw0w==
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
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
Date: Fri, 24 May 2024 11:21:53 +0800
Message-ID: <76e2826d3ff4c5d4b147923d4742ca4b96e0308b.1716520609.git.tanggeliang@kylinos.cn>
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

This patch uses connect_to_fd_opts() instead of using connect_fd_to_fd()
and settcpca() in do_test() in prog_tests/bpf_tcp_ca.c to accept a struct
network_helper_opts argument.

Then define a dctcp dedicated post_socket_cb callback stg_post_socket_cb(),
invoking both cc_cb() and bpf_map_update_elem() in it, and set it in
test_dctcp(). For passing map_fd into stg_post_socket_cb() callback, a new
member map_fd is added in struct cb_opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 123fcd5a0af6..cde796f82206 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -25,6 +25,7 @@ static int expected_stg = 0xeB9F;
 
 struct cb_opts {
 	const char *cc;
+	int map_fd;
 };
 
 static int settcpca(int fd, const char *tcp_ca)
@@ -41,7 +42,6 @@ static int settcpca(int fd, const char *tcp_ca)
 static void do_test(const struct network_helper_opts *opts,
 		    const struct bpf_map *sk_stg_map)
 {
-	struct cb_opts *co = (struct cb_opts *)opts->cb_opts;
 	int lfd = -1, fd = -1;
 	int err;
 
@@ -49,25 +49,9 @@ static void do_test(const struct network_helper_opts *opts,
 	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (!ASSERT_NEQ(fd, -1, "socket")) {
-		close(lfd);
-		return;
-	}
-
-	if (settcpca(fd, co->cc))
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
+	fd = connect_to_fd_opts(lfd, opts);
+	if (!ASSERT_NEQ(fd, -1, "connect_to_fd_opts"))
 		goto done;
 
 	if (sk_stg_map) {
@@ -125,13 +109,24 @@ static void test_cubic(void)
 	bpf_cubic__destroy(cubic_skel);
 }
 
+static int stg_post_socket_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+	int err;
+
+	err = cc_cb(fd, opts);
+	if (err)
+		return err;
+	return bpf_map_update_elem(cb_opts->map_fd, &fd, &expected_stg, BPF_NOEXIST);
+}
+
 static void test_dctcp(void)
 {
 	struct cb_opts cb_opts = {
 		.cc = "bpf_dctcp",
 	};
 	struct network_helper_opts opts = {
-		.post_socket_cb	= cc_cb,
+		.post_socket_cb	= stg_post_socket_cb,
 		.cb_opts	= &cb_opts,
 	};
 	struct bpf_dctcp *dctcp_skel;
@@ -147,6 +142,7 @@ static void test_dctcp(void)
 		return;
 	}
 
+	cb_opts.map_fd = bpf_map__fd(dctcp_skel->maps.sk_stg_map);
 	do_test(&opts, dctcp_skel->maps.sk_stg_map);
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
-- 
2.43.0


