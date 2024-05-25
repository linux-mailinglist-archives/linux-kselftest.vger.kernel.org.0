Return-Path: <linux-kselftest+bounces-10693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D28CEED3
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD7B21040
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA113F9E8;
	Sat, 25 May 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHGd4PN6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248518044;
	Sat, 25 May 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638924; cv=none; b=V2q9J4gf4hA8v2IzMY4nXE0XgNO3dLw7zJt0iEd/yLexkjF9R8E6FvZpK91UJwA2SHs1sPrNbpjRLN7EGqYzCWGUwVCAjTJ48LBVubYqUATdQmsAduFoDsVbdxCt6LDwmONIfUOcGAZIbAebqETufSJIUeKlKQdqJsgKYBLsY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638924; c=relaxed/simple;
	bh=wGw935yiDzPlQn65eeTyCpfK4FoIfl/VfslSpJ+j3YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5rc+zqC1xFXKnCGf030JHjrHIZRCpXkZ5D7LsDfQB0FEoeoaYkZZGDEEaRYzLq58SW+z9GH7MldGsLHRSs3lw/D/+C72oIQ2akFoXdXssFxH3ni+j7coJ1MLsB6qQHQbHPSMwsHnntvX93KrcUiNMho0d9o5Akpvfx0PXK+Pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHGd4PN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E15BC3277B;
	Sat, 25 May 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638924;
	bh=wGw935yiDzPlQn65eeTyCpfK4FoIfl/VfslSpJ+j3YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHGd4PN63nzzNroPzJC0td3WuN19VgklvmnxvCylqApYmzy8gmh+V0/79lYNL2z0s
	 8aFze/jLco4+iKg1csc6Bzv6kg7/qs4KVKaGcFZY75yNI8lNGE8o7AMn7Bhb+Ex8hi
	 A8rX8mRVFKes86iWNkEs0jt1VxTsPytJHXvjgXN1DhLua96K9hTjZoQaR1//i8VW3U
	 3H9kvJcUinrVjK+vZDzIIzP4j9WSnD8rnfJyvOIW9xNwb0E6k6preXCJp6xyvMcFVG
	 Solk/f08bXfW82BYHsOoO2HhGz8s5si/96EzrpwTBVclmWBHzwv1J9JmSPTjAc2oTM
	 gWC/JCAY069CA==
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
Subject: [PATCH bpf-next v5 3/7] selftests/bpf: Use post_socket_cb in connect_to_fd_opts
Date: Sat, 25 May 2024 20:08:17 +0800
Message-ID: <b512bb8d8f6854c9ea5c409b69d1bf37c6f272c6.1716638248.git.tanggeliang@kylinos.cn>
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

Since the post_socket_cb() callback is added in struct network_helper_opts,
it's make sense to use it not only in __start_server(), but also in
connect_to_fd_opts(). Then it can be used to set TCP_CONGESTION sockopt.

Add a "void *" type member cb_opts into struct network_helper_opts, and add
a new struct named cb_opts in prog_tests/bpf_tcp_ca.c, then cc can be moved
into struct cb_opts from network_helper_opts. Define a new callback cc_cb()
to set TCP_CONGESTION sockopt, and set it to post_socket_cb pointer of opts.
Define a new cb_opts cubic, set it to cb_opts of opts. Pass this opts to
connect_to_fd_opts() in test_dctcp_fallback().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c   |  5 ++---
 tools/testing/selftests/bpf/network_helpers.h   |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c       | 17 ++++++++++++++++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0e8266f439e4..8502917b6c7b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -348,9 +348,8 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (opts->cc && opts->cc[0] &&
-	    setsockopt(fd, SOL_TCP, TCP_CONGESTION, opts->cc,
-		       strlen(opts->cc) + 1))
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
 	if (!opts->noconnect)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 4e3e6afe7d3a..11eea8e2e4f1 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -22,13 +22,13 @@ typedef __u16 __sum16;
 #define MAGIC_BYTES 123
 
 struct network_helper_opts {
-	const char *cc;
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
 	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
+	void *cb_opts;
 };
 
 /* ipv4 test vector */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 0aca02532794..6f034059888a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -23,6 +23,10 @@
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
 
+struct cb_opts {
+	const char *cc;
+};
+
 static int settcpca(int fd, const char *tcp_ca)
 {
 	int err;
@@ -81,6 +85,13 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	close(fd);
 }
 
+static int cc_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+
+	return settcpca(fd, cb_opts->cc);
+}
+
 static void test_cubic(void)
 {
 	struct bpf_cubic *cubic_skel;
@@ -172,10 +183,13 @@ static void test_dctcp_fallback(void)
 {
 	int err, lfd = -1, cli_fd = -1, srv_fd = -1;
 	struct network_helper_opts opts = {
-		.cc = "cubic",
+		.post_socket_cb	= cc_cb,
 	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link = NULL;
+	struct cb_opts cubic = {
+		.cc = "cubic",
+	};
 	char srv_cc[16];
 	socklen_t cc_len = sizeof(srv_cc);
 
@@ -195,6 +209,7 @@ static void test_dctcp_fallback(void)
 	    !ASSERT_OK(settcpca(lfd, "bpf_dctcp"), "lfd=>bpf_dctcp"))
 		goto done;
 
+	opts.cb_opts = &cubic;
 	cli_fd = connect_to_fd_opts(lfd, &opts);
 	if (!ASSERT_GE(cli_fd, 0, "cli_fd"))
 		goto done;
-- 
2.43.0


