Return-Path: <linux-kselftest+bounces-7651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE58A0535
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5871F236E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68460253;
	Thu, 11 Apr 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Ki49ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B15FDD2;
	Thu, 11 Apr 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797445; cv=none; b=dnZwcBQQZM/goLERGV2GyXSBuwkXUYSVK0lbspeQv4wy+emtwq/HjqTK5lyQPqF3ffiQoeqWS8AzEr4qW9Xiwmarlr3GURL1dhgAlX31lkFHLzuzQk0v1tmRqNZPuZVO6Nde1tfBJfvWPKfcax/Nf37O+2ZjMECgmYEuGKJGpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797445; c=relaxed/simple;
	bh=Eb0PJ1vYwrl0NMtQT60fNBI5AJMQSh9o4iVlR3khSMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcVsNZv8llAJAGtgT9yqxgM40tL/3qTGyJgBA6/z/sKGKOn37FnJqieUcYqGpMRJztYwX2PTMSp0Q1J08h87vdO7l0ff55iUVVMl0r/misJB6Aj9ukYjMKZVJHK0GKacHiEOSAJYyBCv8u0LOamVCqBE8Rr+IyVoQyWl9ftIc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Ki49ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538BFC433C7;
	Thu, 11 Apr 2024 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797445;
	bh=Eb0PJ1vYwrl0NMtQT60fNBI5AJMQSh9o4iVlR3khSMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1Ki49ckuhHVHkIvDsQy/YFcmG18xuICkkRr5jzffuQRuaZkr4HLIBGf0e5uPgK9u
	 MDPYjhKUYPnhrUkhA1LSEtp0UHpvMV4BQ/88ORr2+4fW/s4Wvb8QjE08vLz2K/tVdh
	 mrh14O3l5s1uwOG5cfUfNu1p9jGgUCW/RvWBNirGJkBS+BX/zouwg7Q/0zOIy9xyik
	 JDN3eCZTkbQcHVui1HqdkfXkAz8O+/SbnII0wvplkrCLONxc0jSCOmM1UpfzeYjv4u
	 r0PUl1yZI0nWK6Jxha2s8ooMBnZ7l80+PiycpZmSAGXH5Zkr/+tKsIqw9+UAOxQYmJ
	 7Ig0Hzji3Uy1g==
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
Subject: [PATCH bpf-next v2 05/14] selftests/bpf: Use connect_to_addr in sk_assign
Date: Thu, 11 Apr 2024 09:03:13 +0800
Message-Id: <55a16644cf8b53e2bbf305fbd9ae21c6f8ad3cbf.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
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


