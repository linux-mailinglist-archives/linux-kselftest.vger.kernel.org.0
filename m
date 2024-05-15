Return-Path: <linux-kselftest+bounces-10224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714B98C5FAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285A6283B71
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED238F97;
	Wed, 15 May 2024 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy1QISpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7338DE0;
	Wed, 15 May 2024 04:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746844; cv=none; b=ZXexg2iSOKxgcHEo+9xU0W4pXDIre/JcYHHK+S4+4cxiMOoygYmLAyQYB6lC04YYfBf1tVVqI9/NUzyPSb3w2bQi1e+j+7P9/5seS3RH220BqmSw5OaQsmnvbBblmWYyBvE/mTBCqCIF4oPbirTk3J6v0OgW0p9xc3UY7VUcwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746844; c=relaxed/simple;
	bh=2EQNSMsbvUMMfTdrfFOCFTL322farv5pEPh6cXpZcSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPu/O4BQ6U8YMyTxxJqDy4mIX0qjo8s9Hrrg5MGg3LynAdL5ubWE/8KhC1b1A8yveRv8i4rNbEK8AEq6vbo7HokcfSoAlxdAdJg42LDG441KVyO4h4NhlLfOF55P8/RhZvzezGV+o4cFRq2Cw12WSRsoZCvqTs8EXdjy2MXmvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy1QISpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA1C4AF07;
	Wed, 15 May 2024 04:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746844;
	bh=2EQNSMsbvUMMfTdrfFOCFTL322farv5pEPh6cXpZcSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fy1QISpBORgeow4S2NAMUX5cobe4o2BigTsiGBm+pNLO+zmnBNWOKPWDdj+m6t1jA
	 WieK3NSwyiKuWUFdKF8qv/YAKk48/q2UhpP4eLsBjhxDWiApktOPR83PbsWQfhfyrh
	 pFrh7W/ZqzE+Y/YTB7MytuJBUzy9VGp3IYXyDcYIygX9wXh+oNZB9lOYYtSMYPaiam
	 cnRWkUwt6OvJaryTltJFt/qXf0yH8BmfBkTnOijEwUxJmTJf1Bxfb6j4fPzYtI1o+W
	 cS9UPFEpOc00p4wgABdv466H2/vCdjD6dxhfdKqDpVHLgKyK7AWVxg8mC/0K+N+Rh4
	 ne1OO7yhyr2Jg==
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
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Use post_socket_cb in connect_to_fd_opts
Date: Wed, 15 May 2024 12:20:21 +0800
Message-ID: <0de05f2ffdfa4adb832fb87d08e6d1c56bef62b2.1715745588.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715745588.git.tanggeliang@kylinos.cn>
References: <cover.1715745588.git.tanggeliang@kylinos.cn>
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
index 0aca02532794..9bc909fa0833 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -81,6 +81,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
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
@@ -172,7 +178,8 @@ static void test_dctcp_fallback(void)
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


