Return-Path: <linux-kselftest+bounces-12122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E390C2AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A246A1C21D7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4EE13F433;
	Tue, 18 Jun 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAqAcrhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9213A24B;
	Tue, 18 Jun 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683683; cv=none; b=WoHLSaKd/xjIrc+m+HCQ7abs8B5SYMF07jAWNKgU6/ORfu4t2Al1EUw9xlIEATzJWZ8eZiK9xHcOhSsRfWZ5l5O3JQxIW8+KIejZ3/w7NUaTRzAUXAad5MwIUiWmB0a6/x8p6IokKfMDk719ZVAj6VDLBXvczAQy9yLDzPoWilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683683; c=relaxed/simple;
	bh=e/JLTeEFEAOhfmwQgh2DXqK3uTH/XxAWmI2jXxJrmAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diX5xHC3QupfTiHd4FMe/+2WJfrlLnkHWeag9TGn+DEka4o2T9pu2ZGkwS8zpL+1nfghofu4w3x56yv2cjkW+1kHpLfSMx78PPHGddOjRTPCXRAqKaZGlV4c6tSa3FsrhgNvbg1gJUIspYLnEMzXMKZFlCuiSBrXFBb2XIjvfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAqAcrhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE6C4AF1D;
	Tue, 18 Jun 2024 04:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683683;
	bh=e/JLTeEFEAOhfmwQgh2DXqK3uTH/XxAWmI2jXxJrmAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAqAcrhNcX4WjPzvxX4g8fP4VDQ2r75jel5Ectuw9rsdsqMVvKrvrY94KVbwQ+6u6
	 gRGUXmhH3ocdRvQS5C2mENtRcYH5Dqp6w+D9uRbnvtsPXwb0DbEUAjxi+oXGci4O0y
	 gsHfVdn6PzuzkbpobJDTljtC/IsWboEzoZjI9QWx74lO8bYFPmfc4cWkfZ69NgaPek
	 3QrJFlRM5aoPpTB0AuRmdiYu/OI3TjNjIcPOMfcgA7I1F6hbwQntoCE3t1RWBZXyIU
	 8UBRwG0k4pjUfwZ2DpY+m8TOOgNRmmxeZYdVPyWGsz12JjEVFrD+GuwPIfU20BXP4k
	 gUIBRadbMSOoQ==
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
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Drop noconnect from network_helper_opts
Date: Tue, 18 Jun 2024 12:06:54 +0800
Message-ID: <9fdafce163de5e89a1d45527154dff88cbb6722f.1718683292.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718683292.git.tanggeliang@kylinos.cn>
References: <cover.1718683292.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In test_bpf_ip_check_defrag_ok(), the new helper client_socket() can be
used to replace connect_to_fd_opts() with "noconnect" opts, and the strcut
member "noconnect" of network_helper_opts can be dropped now, always
connect to server in connect_to_fd_opts().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c            | 5 ++---
 tools/testing/selftests/bpf/network_helpers.h            | 1 -
 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c | 9 ++++-----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 47c86987de12..a8d65f5845ce 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -318,9 +318,8 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (!opts->noconnect)
-		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
-			goto error_close;
+	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+		goto error_close;
 
 	return fd;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index e89eadfb02d6..9ea36524b9db 100644
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
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 1607a05bf2c2..e73da3de5bf6 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -158,14 +158,13 @@ static int send_frags6(int client)
 
 void test_bpf_ip_check_defrag_ok(bool ipv6)
 {
+	int family = ipv6 ? AF_INET6 : AF_INET;
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
@@ -191,7 +190,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS1);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns1"))
 		goto out;
-	srv_fd = start_server(ipv6 ? AF_INET6 : AF_INET, SOCK_DGRAM, NULL, SERVER_PORT, 0);
+	srv_fd = start_server(family, SOCK_DGRAM, NULL, SERVER_PORT, 0);
 	close_netns(nstoken);
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		goto out;
@@ -200,7 +199,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
+	client_tx_fd = client_socket(family, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -209,7 +208,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, SOCK_DGRAM, &rx_opts);
+	client_rx_fd = client_socket(family, SOCK_DGRAM, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


