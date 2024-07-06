Return-Path: <linux-kselftest+bounces-13282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C996F92942A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8551B282D6B
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9D13A40F;
	Sat,  6 Jul 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTtRr0oJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CE811E0;
	Sat,  6 Jul 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277241; cv=none; b=QVZmekMfkD1TEZ2zcVXTDFBj1+Owpway2QkNseZqu2FrMeFH6C6uxbMn8bFh6cBKPmx/xjiSzkBHDk+ARImprwxISEQoISIe102AU3FMcde7oI/xy0+SUtGwtqpowLi8LMGg3Ev2ch0hiabxn+I+WPdyHO4w8XaX3trlfyyyo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277241; c=relaxed/simple;
	bh=Dpr4rRsmbyid4BnC85GpsbxEUjgT4+s7MlZSkdOun7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY55u+aPgeAOEGy6esXnqwYqBfLI1KEkifHW0XTGjEvxbThRcTODL10BC7ZwAE5W1HFCtVQXUyqxJfsq4S4LvGCmmK+zgmuIj+7U2+jdrNf1+Q8o5s8oBl/ZO7Wl5CVPv0xdHiCeDf22FC1gLnslvovH78/r8L25YrDjW+5S0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTtRr0oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B9FC2BD10;
	Sat,  6 Jul 2024 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277241;
	bh=Dpr4rRsmbyid4BnC85GpsbxEUjgT4+s7MlZSkdOun7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTtRr0oJ0e/FnYX5P6T6obOUjdz6cRucw3YEE0W5676c9l493BGEfD5lcI+vRCX1w
	 jdYgPan9QUnelZr3quraw9GV7mpHhoGbeU+8MOyzGzRlXq5JTMjqoRKsU1D5NZRZyA
	 M7SDNlMPPqHjHa9fQcQQs/DAEK40fQDWFmvh3AbC94pChGLAFxJzJrmccLK/nhw517
	 Y0oKTefYOmj/jV/tiTRijQxoB/FYQt9vdLt3T44szOeeI8Br3nBBE+6TCBG0DhQBzt
	 kA6cht9l86isspHI4X48hBhvjhOpRbx6zzZeDz9V+uy6/21IWyl8ueKOzKGwp1nX0m
	 e7f/7CnZi1RRg==
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
Subject: [PATCH bpf-next v9 06/11] selftests/bpf: Add expect_errno for network_helper_opts
Date: Sat,  6 Jul 2024 22:45:51 +0800
Message-ID: <263fb97117e3bb62df8bef34c35b6501d1b10e9a.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720276189.git.tanggeliang@kylinos.cn>
References: <cover.1720276189.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The errno EPERM is skipped in connect_fd_to_addr() by cgroup_v1v2 tests.
More generally, it makes sense to add a "expect_errno" struct member for
network_helper_opts to identify the expect errno to be skipped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c        | 11 +++++++----
 tools/testing/selftests/bpf/network_helpers.h        |  1 +
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 475a5a04e61e..062170d6be1c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -279,7 +279,8 @@ int client_socket(int family, int type,
 
 static int connect_fd_to_addr(int fd,
 			      const struct sockaddr_storage *addr,
-			      socklen_t addrlen, const bool must_fail)
+			      socklen_t addrlen, const bool must_fail,
+			      const int expect_errno)
 {
 	int ret;
 
@@ -290,7 +291,7 @@ static int connect_fd_to_addr(int fd,
 			log_err("Unexpected success to connect to server");
 			return -1;
 		}
-		if (errno != EPERM) {
+		if (errno != expect_errno) {
 			log_err("Unexpected error from connect to server");
 			return -1;
 		}
@@ -318,7 +319,8 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail,
+			       opts->expect_errno))
 		goto error_close;
 
 	return fd;
@@ -386,7 +388,8 @@ int connect_fd_to_fd(int client_fd, int server_fd,
 		return -1;
 	}
 
-	if (connect_fd_to_addr(client_fd, &addr, len, opts->must_fail))
+	if (connect_fd_to_addr(client_fd, &addr, len, opts->must_fail,
+			       opts->expect_errno))
 		return -1;
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index fcda6b2333ad..14d161d35248 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -24,6 +24,7 @@ typedef __u16 __sum16;
 struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
+	int expect_errno;
 	int proto;
 	/* The backlog argument for listen(), defines the maximum length to which
 	 * the queue of pending connections for sockfd may grow.
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 9709c8db7275..ff477163f0ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -11,6 +11,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 {
 	struct network_helper_opts opts = {
 		.must_fail = true,
+		.expect_errno = EPERM,
 	};
 	struct connect4_dropper *skel;
 	int fd, err = 0;
-- 
2.43.0


