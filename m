Return-Path: <linux-kselftest+bounces-9474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384418BC043
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CCC1C20A8D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDE1802B;
	Sun,  5 May 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw8b9vkp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E817BD9;
	Sun,  5 May 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714909000; cv=none; b=MrrMIiJPYa5oCCUGPikUAbRnejP6pTcdHT5rpDpMGpvJXNFXEm22Cu7DCwWodKTBV94IK6plkRx6GH7OWsYufi/SYZOgAYfamrprkluXmCzhT2Od7TyodXlYP7Z64lOApF0Kufn/uWVKSSl5jYIQ33+55tABdv30UUuCZoijt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714909000; c=relaxed/simple;
	bh=HGnpd91Q9BcDlpa9HSMrm+MOW8Kgw9qrkCwve21fJ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsD334qTHlzlrtVDgfOfRXxTkt6BpAFwUJN9bYO7QwCVuRtPO4bsQ24amUV5YVgkF3rVPaP0vmJAUKJ76xlHgbFwk/gBVcxBxcnwUzBcQ5Vt1giMoxbaGBTrquaaWmc88ncOJ8bZgjWm9N/dmI/nzIDtsYQRwkH5Cun0yyugNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw8b9vkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0783FC113CC;
	Sun,  5 May 2024 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908999;
	bh=HGnpd91Q9BcDlpa9HSMrm+MOW8Kgw9qrkCwve21fJ9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw8b9vkpmI/xIJyI6KW7vzLh2zrogFk94g+Q7vorqi5z9SHCpA1CJac7EzzF3PV00
	 w8C638J51AdkK5b9sS+P18OQG4xcVinL647Y6Hey5/KM1go/M+lrK33qdsS9NJ1RVp
	 LPqzUmOyIiC591ghtCQNZYWFC+Ys83AlAXupdpA7XYe621bBGuOBOAhrZj7Ia+B6r2
	 6WUz/U7youWrC2Dl9hzpu/fduDxOlSrVEl4guv1JNbMXmK3CEJ7dK7sMfUUKXKxkO5
	 UMpkY9MpQqVz6LXWnV3QTTdoWvLDVmC6GYFIdu84vuRtdAapZYu5MDL1ydDdkcKq9X
	 UyO6KDbrtOPRg==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 4/6] selftests/bpf: Use connect_to_fd in sockopt_inherit
Date: Sun,  5 May 2024 19:35:11 +0800
Message-ID: <71db79127cc160b0643fd9a12c70ae019ae076a1.1714907662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714907662.git.tanggeliang@kylinos.cn>
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_fd() exported in network_helpers.h
instead of the local defined function connect_to_server() in
prog_tests/sockopt_inherit.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 31 +------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index ff0694ef5286..17a015a34d15 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -10,35 +10,6 @@
 #define CUSTOM_INHERIT2			1
 #define CUSTOM_LISTENER			2
 
-static int connect_to_server(int server_fd)
-{
-	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
-	int fd;
-
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
-		return -1;
-	}
-
-	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
-		log_err("Failed to get server addr");
-		goto out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)&addr, len) < 0) {
-		log_err("Fail to connect to server");
-		goto out;
-	}
-
-	return fd;
-
-out:
-	close(fd);
-	return -1;
-}
-
 static int verify_sockopt(int fd, int optname, const char *msg, char expected)
 {
 	socklen_t optlen = 1;
@@ -165,7 +136,7 @@ static void run_test(int cgroup_fd)
 	pthread_cond_wait(&server_started, &server_started_mtx);
 	pthread_mutex_unlock(&server_started_mtx);
 
-	client_fd = connect_to_server(server_fd);
+	client_fd = connect_to_fd(server_fd, 0);
 	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
 		goto close_server_fd;
 
-- 
2.43.0


