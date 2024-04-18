Return-Path: <linux-kselftest+bounces-8301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF298A94AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5031C20840
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8A7D09A;
	Thu, 18 Apr 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOZhNQIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108777C0A9;
	Thu, 18 Apr 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427798; cv=none; b=i/yqgcOV+aQWr7gKn6bAxnzoe0g7RsA67RrnBT2fdMTwHf9+l7xNAbMOleUjvDb/X47/+aqGurmhOBVCHmAz/mOX+HO6K5RR6covrcVngS4n4WUbgPIq38QxSM+GPOBZQo8EyQkcwsu0Ko/grisJRj7lRht6RZpSPcUtR9K0dxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427798; c=relaxed/simple;
	bh=NkME+wGXKoMaC+mSfB5Ca3k1HSHdXjtu8rQopoF3pBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfK9PTWlM8+Gb5gfnx0Zpbb7DnVyQzN4S69mbt15b5HrnMmd6LIayNBhjR5Ae/93ASmg02XYLwEHQEjr/htZq764yU1WWfcMYE8FyBFYdKmZKwFEAD7Bx0lec5JiT+f4PAELfCaEcV3csWyaJCIbNqzS5lXSgj7kAbGudU6Q07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOZhNQIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34181C113CC;
	Thu, 18 Apr 2024 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427797;
	bh=NkME+wGXKoMaC+mSfB5Ca3k1HSHdXjtu8rQopoF3pBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOZhNQIr86GBU++nKCmGIiMxBsfAXBedrxAJ2Ah5dHy1i8VMX+/FAaQtg3CaP2EGh
	 NJgu0qVq14n/SMdGAE4GR7CK8Q2UuNSbM3d2oAmfI9My2sxjYKOWwjsNceZk7dV2Z0
	 0Yw5f8Hj2KZBAhMwevlbbJOlLFj1343KcO+Odt46dyJEyNkD2p9QAJEb1mDLuFjIAA
	 M2uRTPPt//mCEfL+NGBUPF+WNtfmAWV4sdNpr7+aWY1UPvxAfTiNfiUclRU8nvKQrV
	 loPUCju8WwVPpJtP723mwzrCp6XHAEbZMZ4jp+hAF25QPSlcETbHazqrfDA7Y6NAuw
	 dqAgJtVk0w/lQ==
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
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Use connect_to_addr in sk_assign
Date: Thu, 18 Apr 2024 16:09:12 +0800
Message-Id: <98fdd384872bda10b2adb052e900a2212c9047b9.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
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
index b066b6b88d7c..0b9bd1d6f7cc 100644
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
+	client = connect_to_addr(type, (struct sockaddr_storage *)addr, len, NULL);
 	if (client == -1) {
 		perror("Cannot connect to server");
 		goto out;
-- 
2.40.1


