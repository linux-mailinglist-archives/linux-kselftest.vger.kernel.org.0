Return-Path: <linux-kselftest+bounces-9475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B0D8BC045
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA5F1C20A18
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207A1803D;
	Sun,  5 May 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ku4iN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67317BD9;
	Sun,  5 May 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714909007; cv=none; b=P6j1E0B/lkOan56TUeMVcCIyZ202ZoNvBcC80WeoU8pgVsNMKzAsP7kBbvuitBMFFiuA2WfiOb6gC5tx5eH6qst5Q0lJLBQmGAxgxRmZ5r/POQLDdwe47mZEdXH2eIL6rk/iAODqD2xYwcvlz+VAVlEqVlT6h3/iKwb68FARBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714909007; c=relaxed/simple;
	bh=zTT8utGtNMXPeE9ci+04rvk7F9kPQj3xfSI34Wl/coQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmzqj0Ikcd7vYBbwu3b38g4sJF1gcfLMmJRPdATWm/Q0YnSQaajD00wh3lErRndXYoyGp1lOF6jEaXV9ERVLIGZhGwf9BfQ/ulI2DVxoYI+ris6NbXiAzwO/+kJ5TJI112X+b2Peg6SwGeL9U4kv+cgBtP3fb2aiqn7pFSRZ6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1ku4iN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30749C113CC;
	Sun,  5 May 2024 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714909006;
	bh=zTT8utGtNMXPeE9ci+04rvk7F9kPQj3xfSI34Wl/coQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1ku4iN8bYVaRW3aWAPaN7JGF3n7eBiAB3fOq5pglOwaFmE9cjrNQaeXxvjUtfO1D
	 f3nCsYsLRa67TCL6yiA/bGo1LV4gwdNNnazMQ8FS0ZArPzRtr4fStgqbLkBAZYS2VZ
	 ywIsR3+kZXUfqMGx/UvoyAwJW63gpaycSFtlfk5mbSG6mtTjmCY1oRwGkiy0ghpz2G
	 qS5DY0QIexoKbF7Dfw7yRi9Qt1DqJ04bLgfaJ5fZpDLouUPVsE9SWzsWrz/GjZf4yE
	 PYw157DBdHgkmckyCp2hjbbZL5m6w+DfnOLWf/VRCBTBa7Ws9HMf6I7NmI1UrY8t+5
	 dRO/QcvocNQSQ==
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
Subject: [PATCH bpf-next 5/6] selftests/bpf: Use connect_to_fd in test_tcp_check_syncookie
Date: Sun,  5 May 2024 19:35:12 +0800
Message-ID: <e0ae6b790ac0abc7193aadfb2660c8c9eb0fe1f0.1714907662.git.tanggeliang@kylinos.cn>
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
test_tcp_check_syncookie_user.c. This can avoid duplicate code.

Then the arguments "addr" and "len" of run_test() become useless, drop them
too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 38 +++----------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index bf60bc267cbc..b928474f3bf9 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -18,30 +18,6 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
-static int connect_to_server(const struct sockaddr *addr, socklen_t len)
-{
-	int fd = -1;
-
-	fd = socket(addr->sa_family, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, len) == -1) {
-		log_err("Fail to connect to server");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
 {
 	struct bpf_prog_info info = {};
@@ -80,8 +56,7 @@ static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
 	return map_fd;
 }
 
-static int run_test(int server_fd, int results_fd, bool xdp,
-		    const struct sockaddr *addr, socklen_t len)
+static int run_test(int server_fd, int results_fd, bool xdp)
 {
 	int client = -1, srv_client = -1;
 	int ret = 0;
@@ -107,7 +82,7 @@ static int run_test(int server_fd, int results_fd, bool xdp,
 		goto err;
 	}
 
-	client = connect_to_server(addr, len);
+	client = connect_to_fd(server_fd, 0);
 	if (client == -1)
 		goto err;
 
@@ -254,16 +229,13 @@ int main(int argc, char **argv)
 	if (server_dual == -1 || !get_port(server_dual, &addr4dual.sin_port))
 		goto err;
 
-	if (run_test(server, results, xdp,
-		     (const struct sockaddr *)&addr4, sizeof(addr4)))
+	if (run_test(server, results, xdp))
 		goto err;
 
-	if (run_test(server_v6, results, xdp,
-		     (const struct sockaddr *)&addr6, sizeof(addr6)))
+	if (run_test(server_v6, results, xdp))
 		goto err;
 
-	if (run_test(server_dual, results, xdp,
-		     (const struct sockaddr *)&addr4dual, sizeof(addr4dual)))
+	if (run_test(server_dual, results, xdp))
 		goto err;
 
 	printf("ok\n");
-- 
2.43.0


