Return-Path: <linux-kselftest+bounces-7537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015889EC00
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56601F21D2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413813D27C;
	Wed, 10 Apr 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hduXVhUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA113C9D7;
	Wed, 10 Apr 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734230; cv=none; b=X052qkvaFqkDwNRxMuoBt7+ooC0FbxDh5NunblNV29llFVvgvX2aYx9h6MLvGyp/5drfyYEI6eSg/2JQ+/pQxaVI+X87xTqnpAtIedxaKzfdfaTUI0QQWEet0zgik15933zKWMUs/JnDBaLjAr+kwZnsxOScHQs67MbH+wLEOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734230; c=relaxed/simple;
	bh=U2m3gTB3QVoYDws8kPOeNlwkY75f28fDIoqvSNHpaKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kx4mEOgynvFIBGn9IL94ByXhQh3o0tWTJgL8isrebbFbJuv03ASjQO9tlQq+hXa5Q9gz2Oq7BdbkTAJCt74RdyTD/xrqQ2ov1qCexNYXMmpNgaXVGMDZKUWwXstJsij74CSXPRmQudUFKNQxNDRZFamzhhrc5ksHyaCz0egQp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hduXVhUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4374C433C7;
	Wed, 10 Apr 2024 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734230;
	bh=U2m3gTB3QVoYDws8kPOeNlwkY75f28fDIoqvSNHpaKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hduXVhUKjiMxbiCQpUBluQ1wlXhLKyLa+ltRcjH+mSZ7dkZWcqXoTLsJtq1L6G6ah
	 WCHrCs5UTMFvuMaAZScYFawXTYO/iSiD2LetjiGbVrWc37V8M7Bt2UB7SU5aaDIuu+
	 WImykDglxLEoV1eG+WQgUQDHGzzrkZ09uQOnaPm7+sXdBmgYFkA5ScAmWAeWipxwB1
	 phL0XfeDpJRDAEUOT8YU9yD6w34EjB6qpee78J6s0lU9HeLBNTFqwA/Bf4sfmde18J
	 zz8c/rTBrRC6ZyeVE9gBco0mxdPF2Z16Utbc5ST58Jbcx8O/zFIBkkRii6zdyz7qVe
	 4yobAF/eIl+0Q==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 05/14] selftests/bpf: Use connect_to_addr in sk_assign
Date: Wed, 10 Apr 2024 15:29:38 +0800
Message-Id: <42e78119c9ee2d487170d5a2b7915a5c8837ae82.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
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

The code set SO_SNDTIMEO timeout as timeo_sec (3s) can be dropped, since
connect_to_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 130aafe8cff6..b574e162ce6e 100644
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
+	client = connect_to_addr((struct sockaddr_storage *)addr, len, type);
 	if (client == -1) {
 		perror("Cannot connect to server");
 		goto out;
-- 
2.40.1


