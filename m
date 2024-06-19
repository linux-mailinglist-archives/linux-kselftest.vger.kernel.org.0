Return-Path: <linux-kselftest+bounces-12203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8990E1C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5934B22E2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025894DA09;
	Wed, 19 Jun 2024 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDaM7n1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1745227;
	Wed, 19 Jun 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765772; cv=none; b=beuvrnUDYq6FdX/TbyFeWoGH14TYCehsn7J70BQvX0G1ULVRrmF/6VMGNvyYSanU46cwRHPoeZ9v+sknyzDORTsFFHQD5iokosClIb3hK6jx3F8zwYrtmJbOxGiAkgMt/9bmsrKCaHsqUCTTHMVBflIgvciQB88uEyxAe15CwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765772; c=relaxed/simple;
	bh=+Roi6zcDTR991qExEbHBsv+5AIBadf+YA/sbhVcvykk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nt6DBrOUcDog7feJw0cANmAGmF6utIWRnagETW08G5zGwDWQbVdckkOgp/ZOb4NmjE2Zqnnki4+HvA/gRN3Tttkj8IsghvB96O/zG1FVlWn6V0XtyN3XtWN32AUKXMKC5bN/IJuXxGMv9gTssosRLmwk7S424mTYR7/JEZG0oL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDaM7n1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6771AC4AF48;
	Wed, 19 Jun 2024 02:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765772;
	bh=+Roi6zcDTR991qExEbHBsv+5AIBadf+YA/sbhVcvykk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDaM7n1rOiUHYlfDHbOKgJU7PtU1YO/3SADNKbNxEIFipMI9UpbWXkGxW5OXvTDWU
	 C02QFiEhHV4TxpIqc6BwiJZSwVsNnieJB2184BvSfKklUTaC20sEFH17h4JWWXqudg
	 nPs+DR40gMGP5EAhbW8R1kGTQepdYPLtbmMkWzkKlU42+PWhpRWaK+knmZF2DDqoyS
	 TFxDVrR4st8dgDZhYE8iDlBwH+lHs45PYxNnK5dGoSCrLaNbshUQlWQiQ10HlmIt/l
	 dhyYks5n4xdtKGkjRLakJVkeCVqnUo9YocVJmPPLYahranVUl/FKAqS9cg5TaawDRJ
	 1XJOILrMB68vA==
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
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: Drop noconnect from network_helper_opts
Date: Wed, 19 Jun 2024 10:51:09 +0800
Message-ID: <03185ae444b4fc91a3729df1f6f274ae5273aa67.1718765123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
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
index 5f8214e2880d..44c2c8fa542a 100644
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


