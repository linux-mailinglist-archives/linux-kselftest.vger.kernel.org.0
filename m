Return-Path: <linux-kselftest+bounces-8114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F48A67FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58251F21D4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5960126F2F;
	Tue, 16 Apr 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDDkWE3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA28126F1A;
	Tue, 16 Apr 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262491; cv=none; b=fzHuaDRlfY6h0B7U6YcZVqZstJxFs8Ygo1jFEpm/qhFSX2GEGhUtR8an2hguhZMORlSfikLFzf3IsFUnsKvOqo6rxAJKqCJfKGwR0pZzxEUA9ZVtozU6waaIR3SqBy+YVSQxApUaHeLgqtsZiqtSSpRG8g3Rayg63HS0CjhRRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262491; c=relaxed/simple;
	bh=+UY5Yx87xkXUquSqExXlO++aZfWesHnQpbB/kBWWX7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoGg3eQ7N2oq0C41b22Vw/Z9hQzPtnkDjHFx49h7e2QQ4GR57WFZhl0ID7AnamfjTkMzs3pfFPdhNtmvNEPfAM34SK2XC1hzgVp5svLo475u65fXURTkFs6IavvJskXke+JLOOHbd1WUrHoMypT9ume8wfsXBTDYDxZqCpHPh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDDkWE3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF8EC3277B;
	Tue, 16 Apr 2024 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262491;
	bh=+UY5Yx87xkXUquSqExXlO++aZfWesHnQpbB/kBWWX7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDDkWE3+Y+fkkxOME0DTLSPg78HzyqKGnTNtSzRWz5hQgMBJxFxKnRo1/gLcsvmcS
	 w9Ib+fs9WD6+CGlm7TTIy63nyfs2mAMIAN417uKY1NK6zXPc7l/X/NiqcW9zcn5KT0
	 yvri3fJOoH4/WW4Mg1ePWUqCSWNi1zjFvZfPSG+7dt2JplKy9b5vlHuBAwyaN9oHBb
	 VBiAV6jYl96xHphgMjP95TXEPa19c09Lqz4GPL4wzAqUNzah1PGpETkAxZypHl7M3s
	 z8U1GTCxMgEgQM1qje5Ac89w5O2wjn4dFVC0k08WXFxM6qu6Oy6wh80S9/w45T2JuI
	 Rzkzd15tcKhSg==
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
Subject: [PATCH bpf-next v4 06/14] selftests/bpf: Use connect_to_addr in sk_assign
Date: Tue, 16 Apr 2024 18:13:52 +0800
Message-Id: <b918f3e9b4f5cac694982add59e4da575516b9e7.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in prog_tests/sk_assign.c. This can avoid duplicate code.

The code that sets SO_SNDTIMEO timeout as timeo_sec (3s) can be dropped,
since connect_to_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index fa8f757c0edd..766fc56f5fc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -23,8 +23,6 @@
 #define NS_SELF "/proc/self/ns/net"
 #define SERVER_MAP_PATH "/sys/fs/bpf/tc/globals/server_map"
 
-static const struct timeval timeo_sec = { .tv_sec = 3 };
-static const size_t timeo_optlen = sizeof(timeo_sec);
 static int stop, duration;
 
 static bool
@@ -74,28 +72,6 @@ configure_stack(void)
 	return true;
 }
 
-static int
-connect_to_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd = -1;
-
-	fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		goto out;
-	if (CHECK_FAIL(setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo_sec,
-				  timeo_optlen)))
-		goto close_out;
-	if (CHECK_FAIL(connect(fd, addr, len)))
-		goto close_out;
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static in_port_t
 get_port(int fd)
 {
@@ -138,7 +114,7 @@ run_test(int server_fd, const struct sockaddr *addr, socklen_t len, int type)
 	in_port_t port;
 	int ret = 1;
 
-	client = connect_to_server(addr, len, type);
+	client = connect_to_addr(type, (struct sockaddr_storage *)addr, len);
 	if (client == -1) {
 		perror("Cannot connect to server");
 		goto out;
-- 
2.40.1


