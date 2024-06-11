Return-Path: <linux-kselftest+bounces-11628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2215902E23
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BA11C22034
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEC8C04;
	Tue, 11 Jun 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQnPwHmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7384C81;
	Tue, 11 Jun 2024 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071212; cv=none; b=Q2QKWT7EhXaAYRLOX5ZudPShrsqtkKMeezGbmpi7CDJmZ3h5vGdomeLjuOW3C0IsnsfEZJ7hdf1/rimfE6PqsijLs5nMD0gRO27Xc05ZrC0prSZLK2n9m5+8k4FFwoJWmcFfZ5W7O/eVuhqH3gmW/O9+505lWwa2Iy+4GBOFgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071212; c=relaxed/simple;
	bh=8EV55NK1hekoJ8C1IwqaoBlUiqoKSewbiQkaMFy1IqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0PP1LVcQ3+zAARS3r0M5Yqz+gnBLr7wV2BO+5mgRQ1oOVQ57DFR5m62wGesuewt0pb+9XFaYr3xKB1cXtEOjFnQ6xxWoaE/Avhq7IRP88uy53ZWOu35bj2n3Hgrqq5S1g1nVnD5j0qT0s81rFarRRpbaNaLP/XoKiLGO3vg5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQnPwHmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2632AC2BBFC;
	Tue, 11 Jun 2024 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071212;
	bh=8EV55NK1hekoJ8C1IwqaoBlUiqoKSewbiQkaMFy1IqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQnPwHmTbqBZ1bXmGaJM9HJemoZB1XPFaxpJbjY/JIOBwF9Z2C10MBFF1oX0l0AyP
	 g0QhEUYnQRbtGWBOp64SeKRb9Prc8n/4l7WIa7IdNzPpmCdbyi/kigslhHyyi1zV9o
	 AhKiJb+x0oOqCbItIGKbuSSN3QfLWvCmNdmYJfMIyfZGF5rQwDtSaNhjLy+5mA1pxg
	 olwpSZKZIxxQlxcsYbp8cRBAfo0ObBgFJcz7jWyjRMiCJU41fmaYSkiv2/+TgEcFxt
	 qC5XAELIhJ77Nm1UbfW3v7Z8PIUkkwem/WLobSAJVaTfTKOPtX7MqJGbafuNIfdvC6
	 afApph1SlLFKQ==
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
Subject: [PATCH bpf-next 2/5] selftests/bpf: Drop noconnect from network_helper_opts
Date: Tue, 11 Jun 2024 09:59:35 +0800
Message-ID: <9d2b9adc6e0892e4836c76d115658d6a41619789.1718070939.git.tanggeliang@kylinos.cn>
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

This patch adds another new parameter "noconnect" for __connect_to_fd_opts,
then opts->noconnect can be replaced by "noconnect" parameter in it. In
test_bpf_ip_check_defrag_ok(), true is passed to it. And the strcut member
"noconnect" of network_helper_opts can be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c            | 6 +++---
 tools/testing/selftests/bpf/network_helpers.h            | 3 +--
 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c | 6 ++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 902060a70e3b..0f53638ae5a0 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -303,7 +303,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int __connect_to_fd_opts(int server_fd, int type,
+int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
 			 const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
@@ -352,7 +352,7 @@ int __connect_to_fd_opts(int server_fd, int type,
 	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
-	if (!opts->noconnect)
+	if (!noconnect)
 		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
 			goto error_close;
 
@@ -365,7 +365,7 @@ int __connect_to_fd_opts(int server_fd, int type,
 
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 {
-	return __connect_to_fd_opts(server_fd, 0, opts);
+	return __connect_to_fd_opts(server_fd, 0, false, opts);
 }
 
 int connect_to_fd(int server_fd, int timeout_ms)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9a7cbea87967..e029d4ff983e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -24,7 +24,6 @@ typedef __u16 __sum16;
 struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
-	bool noconnect;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -60,7 +59,7 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-int __connect_to_fd_opts(int server_fd, int type,
+int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
 			 const struct network_helper_opts *opts);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 30349c866c77..330dfba95c56 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -160,12 +160,10 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 {
 	struct network_helper_opts rx_opts = {
 		.timeout_ms = 1000,
-		.noconnect = true,
 	};
 	struct network_helper_opts tx_ops = {
 		.timeout_ms = 1000,
 		.proto = IPPROTO_RAW,
-		.noconnect = true,
 	};
 	struct sockaddr_storage caddr;
 	struct ip_check_defrag *skel;
@@ -200,7 +198,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = __connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
+	client_tx_fd = __connect_to_fd_opts(srv_fd, SOCK_RAW, true, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -209,7 +207,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, &rx_opts);
+	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, true, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


