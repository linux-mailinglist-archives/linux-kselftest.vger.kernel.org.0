Return-Path: <linux-kselftest+bounces-13644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E992F5E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43391C227C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803C13D510;
	Fri, 12 Jul 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFKehbxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F672539A;
	Fri, 12 Jul 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767920; cv=none; b=oCwuitwqsKvdbmQDBW0iU6bfSybt6kPMhBp9Q5hoEomAE3+5xT9RmOr+O+rspco4Rh6e5raN4SVyGr+T/jnLOgift5fzEUcn5zMGA9TDfj4HKajOpr2x5Tecu03K9arRAr+BfLYSF6aiaQKA7p2iNzerGC0Us6dFegxUj02H2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767920; c=relaxed/simple;
	bh=RoryFHEXdhJ0Z21xVcDPhC9Tvu04Y20PP7QTuQ3gRyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boOQZ4XQEg0Lk5mpmutbv30/E4TBTNctZ6/GgnG4LYbcb2fpGOscZhqXtSYWLcttGXX1idfp+JFUZrHwXu8hhZK23fAKu0Q7m2YScw8SIxcpBJrZpLASmt51gAdpv+wLwcXxpCzsSGIYA9ZPsbjB6/x5FQNJZS9hkZZfKMS63Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFKehbxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BDC4AF09;
	Fri, 12 Jul 2024 07:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767919;
	bh=RoryFHEXdhJ0Z21xVcDPhC9Tvu04Y20PP7QTuQ3gRyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFKehbxP6Z/GelfHYKYPOd82EAaPep5bb8dSHYnnMF/2NhTujTB8we3oJhoQD15KZ
	 tpJKxE2yDyphLud0/25BmKLX3ZS9DA/A+S5BlQ/ypZId4AYLQwxCFwOqocOUPPyLou
	 QweCdr3uXZTiIOOKPpxNA09MEI3A63cykvKYmVqa+BejK1xd1A/yuW8u/CFHE/7FJJ
	 jotrnlCPL6LUuCIuibpQ6aCcKvJuMYH3jSKKW8TVsKHNC/e01nvehS3ezWX3hR0pmw
	 BdiYTJyn+bzK5zRU2NG9NDCKAWLqvuS0LAfnZb/tySDb6jiePKVkYmzzpPTtKd4EPy
	 LAq6U9QZ4lPew==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Drop must_fail from network_helper_opts
Date: Fri, 12 Jul 2024 15:04:49 +0800
Message-ID: <5730eabdd6e90d1534d4f5df47e55a76f04197ca.1720767414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720767414.git.tanggeliang@kylinos.cn>
References: <cover.1720767414.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The struct member "must_fail" of network_helper_opts() is only used in
cgroup_v1v2 tests, it makes sense to drop it from network_helper_opts.

Return value (fd) of connect_to_fd_opts() and the expect errno (EPERM)
can be checked in cgroup_v1v2.c directly, no need to check them in
connect_fd_to_addr() in network_helpers.c.

This also makes connect_fd_to_addr() function useless. It can be replaced
by connect().

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 31 ++-----------------
 tools/testing/selftests/bpf/network_helpers.h |  1 -
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    | 10 ++----
 3 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 15e0e0bb7553..48c27c810db7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -277,33 +277,6 @@ int client_socket(int family, int type,
 	return -1;
 }
 
-static int connect_fd_to_addr(int fd,
-			      const struct sockaddr_storage *addr,
-			      socklen_t addrlen, const bool must_fail)
-{
-	int ret;
-
-	errno = 0;
-	ret = connect(fd, (const struct sockaddr *)addr, addrlen);
-	if (must_fail) {
-		if (!ret) {
-			log_err("Unexpected success to connect to server");
-			return -1;
-		}
-		if (errno != EPERM) {
-			log_err("Unexpected error from connect to server");
-			return -1;
-		}
-	} else {
-		if (ret) {
-			log_err("Failed to connect to server");
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
@@ -318,7 +291,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (connect(fd, (const struct sockaddr *)addr, addrlen))
 		goto error_close;
 
 	return fd;
@@ -383,7 +356,7 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 		return -1;
 	}
 
-	if (connect_fd_to_addr(client_fd, &addr, len, false))
+	if (connect(client_fd, (const struct sockaddr *)&addr, len))
 		return -1;
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5b548c0c60de..f39eeb5a4594 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -23,7 +23,6 @@ typedef __u16 __sum16;
 
 struct network_helper_opts {
 	int timeout_ms;
-	bool must_fail;
 	int proto;
 	/* +ve: Passed to listen() as-is.
 	 *   0: Default when the test does not set
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index addf720428f7..04e82a486102 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -9,9 +9,6 @@
 
 static int run_test(int cgroup_fd, int server_fd, bool classid)
 {
-	struct network_helper_opts opts = {
-		.must_fail = true,
-	};
 	struct connect4_dropper *skel;
 	int fd, err = 0;
 
@@ -32,11 +29,10 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, &opts);
-	if (fd < 0)
-		err = -1;
-	else
+	fd = connect_to_fd_opts(server_fd, NULL);
+	if (fd >= 0)
 		close(fd);
+	err = errno != EPERM ? -1 : 0;
 out:
 	connect4_dropper__destroy(skel);
 	return err;
-- 
2.43.0


