Return-Path: <linux-kselftest+bounces-12389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8491185F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E60D1C21E59
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAEE83CA3;
	Fri, 21 Jun 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwnzoixq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406782891;
	Fri, 21 Jun 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936202; cv=none; b=oRtFkyuu3Emxp76BNVsCMzW2rF/saHyS39bxyh8yEEZrPtudt/ANQGjNV1MqL0QT3Eh6rDFsChMnGnKCDPMXnZONDZtyU4bWq09AbokwJausgT9Xn1Xm7V5CPKt956/uHD/pefwz4boIu6uf4oa2B0iqFzPWQml47spvVZIIfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936202; c=relaxed/simple;
	bh=jSJqvZp9QjM7EhqwjxQvol8jPHyk/g4oSwBHLcIw2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3yV3X5DXljDyFjBQ5xY//gSgwoTxIxnP0Xk+NME1pDjgmrkOpIP2cB5xi6aWxBv/xdAYzIc/BKpjrAU2FmXXeBkDfkOFj48Y12RBjmgvPOBXiFxna+i9TC0vtoDU2qETVIBxBI9dO/pgM4b/MScpwWGUBSDaNldDkL071N8FsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwnzoixq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4768C4AF0F;
	Fri, 21 Jun 2024 02:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936202;
	bh=jSJqvZp9QjM7EhqwjxQvol8jPHyk/g4oSwBHLcIw2gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwnzoixqaQtpEg86k47BbDt8CXWm4Mfsn8iFR3KEYaysYoadfJFNFNaLXTgm6yAfV
	 m6q4GIQ8J6G+CnDsOwv13Xl2SlpOh8+M31QwVSCVSO/lDml8AhqVtaNGGn3sm84ZrG
	 EGGPXri8D/6F20T/TRXbob7pu0pcROoPb55aXW9r0E8iYCf5srKJLwTSsR9QMets40
	 T4DglBBtEVKYpQthiy5fpbEJO1I84kUN4mrOXT5OSeUESG1VrIbjiqi9XFm5zvW4kE
	 wPdWaStS64gIidY8WuReYcKD+7Us+xWjdAIThYmRsYfJWOSwkl59+yiFY0nZbUbGoj
	 xUUbQHvAsJYmA==
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
Subject: [PATCH bpf-next v6 4/6] selftests/bpf: Drop noconnect from network_helper_opts
Date: Fri, 21 Jun 2024 10:16:01 +0800
Message-ID: <f45760becce51986e4e08283c7df0f933eb0da14.1718932493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718932493.git.tanggeliang@kylinos.cn>
References: <cover.1718932493.git.tanggeliang@kylinos.cn>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c       |  5 ++---
 tools/testing/selftests/bpf/network_helpers.h       |  1 -
 .../selftests/bpf/prog_tests/ip_check_defrag.c      | 13 ++++++-------
 3 files changed, 8 insertions(+), 11 deletions(-)

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
index 1607a05bf2c2..4ddb8a5fece8 100644
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
@@ -200,18 +199,18 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
+	client_tx_fd = client_socket(family, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
-	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
+	if (!ASSERT_GE(client_tx_fd, 0, "client_socket"))
 		goto out;
 
 	/* Open rx socket in ns0 */
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, SOCK_DGRAM, &rx_opts);
+	client_rx_fd = client_socket(family, SOCK_DGRAM, &rx_opts);
 	close_netns(nstoken);
-	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
+	if (!ASSERT_GE(client_rx_fd, 0, "client_socket"))
 		goto out;
 
 	/* Bind rx socket to a premeditated port */
-- 
2.43.0


