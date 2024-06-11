Return-Path: <linux-kselftest+bounces-11627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C993C902E21
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34F1C220B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B6B65E;
	Tue, 11 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc+l36f7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0645A945;
	Tue, 11 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071203; cv=none; b=ZBOnsCq8eSi5VRx1xj1zrahzd0D/dDjIPz431wDQAWbBfc8zIDwblrR7ZooVjy/KCjQXqKRvq4BFxCFIEdC6ZlujyEGztYKlDds+g01lVtNyAxgb+JUSXlyQ5w/AkksiXS56C6Soqt8nJ2TUzO2xLPMoLTntckxFwGzvsdUXENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071203; c=relaxed/simple;
	bh=GLcqHPSIDcYyOOhUOQFgzOMdTgSerYPzPDHb2rayz3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD5bM3GyKY1eLw19qqoPGy0kFd1hSPSh+lSwAbc96QHLtrBeFKBaF9ofIB6/xzgXcV2Ss1ci/pj+vcr3bSZ/ys8NMxRu8YWn/LoJmM9im8rOMBSBcEhBaR6W24mM1lhpKrY4jBeZPjRPp2PO3RvVo08gP4U7cpw3qxvimNY2sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc+l36f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15900C4AF53;
	Tue, 11 Jun 2024 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071202;
	bh=GLcqHPSIDcYyOOhUOQFgzOMdTgSerYPzPDHb2rayz3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oc+l36f7QW9YBtPUZwGJQs013KOcVUc+E9pYzKTS0+0NfeVYrVrtFUlFhuH0Nmc1w
	 4QKoBLzidiV3tpQiV/G0qT88reCBqi28WgbHoE55u/Jo5FuMVKyLqLEHydhtYLByt+
	 tLAwEcGwSYtrcGxHqQJOZ8fal8C8LwHOJ66cjow3fh++qPRzFaxXd1siqAXkteJrGq
	 nVdzyucjPy+MusuJAu1v7Gy1c/eLFnj2Sjqt5xNNBn/EGiwe5E0KW5i5smI1p5y0Uh
	 MmmHC4Cze4FBo7hz0lyVFfZ6K9xQsfcKUsaanWP8PIbbUZUcFVvT6eixaShbo/a86t
	 4tFpiXdifgLZg==
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
Subject: [PATCH bpf-next 1/5] selftests/bpf: Drop type from network_helper_opts
Date: Tue, 11 Jun 2024 09:59:34 +0800
Message-ID: <b80ca04f4f1e65e4b796331c48283ea282fe7ee0.1718070939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718070939.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The opts.{type, noconnect, must_fail} is at least a bit non intuitive or
unnecessary. The only use case now is in test_bpf_ip_check_defrag_ok which
ends up bypassing most (or at least some) of the connect_to_fd_opts()
logic. It's much better that test should have its own connect_to_fd_opts()
instead.

This patch adds a new helper named __connect_to_fd_opts() to do this. It
accepts a new "type" parameter, then opts->type can be replaced by "type"
parameter in this helper. In test_bpf_ip_check_defrag_ok, different types
are passed to it. And the strcut member "type" of network_helper_opts can
be dropped now.

Then connect_to_fd_opts can implement as a wrapper of this new helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c      | 14 +++++++++-----
 tools/testing/selftests/bpf/network_helpers.h      |  3 ++-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |  5 ++---
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e20caef06aae..902060a70e3b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -303,21 +303,20 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
+int __connect_to_fd_opts(int server_fd, int type,
+			 const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
-	int fd, type, protocol;
+	int fd, protocol;
 
 	if (!opts)
 		opts = &default_opts;
 
 	optlen = sizeof(type);
 
-	if (opts->type) {
-		type = opts->type;
-	} else {
+	if (!type) {
 		if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
 			log_err("getsockopt(SOL_TYPE)");
 			return -1;
@@ -364,6 +363,11 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 	return -1;
 }
 
+int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
+{
+	return __connect_to_fd_opts(server_fd, 0, opts);
+}
+
 int connect_to_fd(int server_fd, int timeout_ms)
 {
 	struct network_helper_opts opts = {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 11eea8e2e4f1..9a7cbea87967 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,7 +25,6 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
-	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -61,6 +60,8 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
+int __connect_to_fd_opts(int server_fd, int type,
+			 const struct network_helper_opts *opts);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 284764e7179f..30349c866c77 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -164,7 +164,6 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	};
 	struct network_helper_opts tx_ops = {
 		.timeout_ms = 1000,
-		.type = SOCK_RAW,
 		.proto = IPPROTO_RAW,
 		.noconnect = true,
 	};
@@ -201,7 +200,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, &tx_ops);
+	client_tx_fd = __connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -210,7 +209,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
+	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


