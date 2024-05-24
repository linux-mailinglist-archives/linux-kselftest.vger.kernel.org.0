Return-Path: <linux-kselftest+bounces-10648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A88CDFB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1261F21735
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D051DDF6;
	Fri, 24 May 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyF6D0qq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5D12E4A;
	Fri, 24 May 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520959; cv=none; b=mUvTZasHaT2fHXSWgmIou7+wyypxX0R4Zsa5Z4/fT0WjmeJ2MAsH3CvMWnl7CF6PGPZFCrqTH7Dm+sI3A1196ezJQOkJrdu/RHxhWEDxgEIHyC4Yx9k37i/wjru76/vYddl3avUs0GbQJHweIGovk8NTJjPfz6witjbLRMKXQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520959; c=relaxed/simple;
	bh=CLRazJ30wBSFi8ItYaU0PAXfU6G5vkeUSfRYkSnwNKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uttn2CcMRlmKOT44DaYC9aFUQ+aqT2WKWzvSAjQbjAcMcUGf82MwHwFwEFhcPOf2lYkQEJZtDg/TXc7xPtouxaLeZmtOPDNd2bmd460XpVATZ4ExKfjgrvWWerA2+MH6Vb0JxnoiId8BAxyvLJVi6H4m9bCqSr+DZnQKLgSGdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyF6D0qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB0BC2BD10;
	Fri, 24 May 2024 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520959;
	bh=CLRazJ30wBSFi8ItYaU0PAXfU6G5vkeUSfRYkSnwNKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyF6D0qq5lsnIdDEKbHGoeqE8UNqgtjeRcqn3CxGxJjXJDRfXhoy6CHiNN4BGLgmZ
	 mKJR/zc+CswAqwDv1tet+5Lfip3RR4FvWiRWH8mDoJmUckz+tDDpnoeoVTMVimazUG
	 6SkFDas5XxoVushx/3MYtb0ctRTaJ7XIZsf4j4VirJN4Et4pxd0WyRTsSlQ23cn0+y
	 JLbiqQJnmYHR18UjikOH01F1hIJSA5gWvAq4Wv43ohuPHmpwZ0tNEcIHFAidm708Zo
	 PBIVwXuaIHC07aS4tH1nM+S3dDdXPKJsfd5JU4VUj4c4dQQDVBrHaJAuJtE8C0c7O7
	 s0Lwr3pNqjdRA==
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
Subject: [PATCH bpf-next v4 3/6] selftests/bpf: Use post_socket_cb in connect_to_fd_opts
Date: Fri, 24 May 2024 11:21:51 +0800
Message-ID: <34180b520025f700f65d23b41148109e4214c697.1716520609.git.tanggeliang@kylinos.cn>
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

Since the post_socket_cb() callback is added in struct network_helper_opts,
it's make sense to use it not only in __start_server(), but also in
connect_to_fd_opts(). Then it can be used to set TCP_CONGESTION sockopt.

Add a "void *" type member cb_opts into struct network_helper_opts, and add
a new struct named cb_opts in prog_tests/bpf_tcp_ca.c, then cc can be moved
into struct cb_opts from network_helper_opts. Define a new callback cc_cb()
to set TCP_CONGESTION sockopt, and set it to post_socket_cb pointer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c  |  5 ++---
 tools/testing/selftests/bpf/network_helpers.h  |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c      | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

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
index 0aca02532794..c9dd2a3d3218 100644
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
@@ -81,6 +85,14 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	close(fd);
 }
 
+static int cc_cb(int fd, void *opts)
+{
+	struct cb_opts *cb_opts = (struct cb_opts *)opts;
+
+	return setsockopt(fd, SOL_TCP, TCP_CONGESTION, cb_opts->cc,
+			  strlen(cb_opts->cc) + 1);
+}
+
 static void test_cubic(void)
 {
 	struct bpf_cubic *cubic_skel;
@@ -171,9 +183,13 @@ static void test_invalid_license(void)
 static void test_dctcp_fallback(void)
 {
 	int err, lfd = -1, cli_fd = -1, srv_fd = -1;
-	struct network_helper_opts opts = {
+	struct cb_opts cb_opts = {
 		.cc = "cubic",
 	};
+	struct network_helper_opts opts = {
+		.post_socket_cb	= cc_cb,
+		.cb_opts	= &cb_opts,
+	};
 	struct bpf_dctcp *dctcp_skel;
 	struct bpf_link *link = NULL;
 	char srv_cc[16];
-- 
2.43.0


