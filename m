Return-Path: <linux-kselftest+bounces-13868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC25F934801
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43EC282B29
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF56BFA3;
	Thu, 18 Jul 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+Z2cPUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EC5FB8A;
	Thu, 18 Jul 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283803; cv=none; b=uHGw5/JFIsoc8x3LS+kAGuEF72CHSWd051Wb6ON1qsYTUV2uGrabgbM8UTAJqugYrpIvytupZQsAsMPOdyFCoyJnA8scrUUzWPgE9CtjT/qnZa8A3w60pvqHYc8FSyi3BACVqjtijkGMSl9++qeHTp4Ic331GSzjL6r0ByTSzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283803; c=relaxed/simple;
	bh=kMZGhbYFsv5b+GY+m+qbhK9Wk0HNDAyX5YWMOzLEd20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyymVSvLuK7RpYrbEZwOOAXBfSJnU+a8Xll8Y6BSPxNVlWGiTM/LPPrvDLORcUKzJALFk8CzeJl0r0A7SMQUPp2qIMJxoU2ukNQFNzMZ8G0uGh8I7CSnAQ1b0rrxgxeLXypoug0GcxYsHxc7Ueit0o2GD2olx02AXTYZhwQPtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+Z2cPUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE99BC4AF0C;
	Thu, 18 Jul 2024 06:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283803;
	bh=kMZGhbYFsv5b+GY+m+qbhK9Wk0HNDAyX5YWMOzLEd20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+Z2cPULvw75OxlJlqg0Oq0VPXvQ1bT+9ks0Ml5twugTpMFmAK5uc0cdcZSaKR6G5
	 QpD35HUmmmHEfXTsKh7IT+W9ORs50fpwOTRt1/UZpBT6o4lWBjJUpDuiD082knzRmQ
	 bNJtsKqH0tgFkAJqsSCR2Whh984gY70Zk/OOPzFeuYJB4frspFLcOnD7RI3MWv3M9j
	 jGGpziu2o15kdkXbiwnMKqdVb2L1AD06eCpk9SIj5NsCxPGbWM/QAsGsMu4YkMib3y
	 yy0OfwQR506w3iN0SaXobzHTmKvr0rZKulLAe0LPRQnqH3pjx0uQE2qW1qbth7lN+/
	 wVvtfMKj2i+0Q==
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
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Drop must_fail from network_helper_opts
Date: Thu, 18 Jul 2024 14:22:30 +0800
Message-ID: <3faf336019a9a48e2e8951f4cdebf19e3ac6e441.1721282219.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721282219.git.tanggeliang@kylinos.cn>
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    | 14 +++++----
 3 files changed, 10 insertions(+), 36 deletions(-)

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
index addf720428f7..e91099c637b0 100644
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
 
@@ -32,11 +29,16 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, &opts);
-	if (fd < 0)
+	errno = 0;
+	fd = connect_to_fd_opts(server_fd, NULL);
+	if (fd >= 0) {
+		log_err("Unexpected success to connect to server");
 		err = -1;
-	else
 		close(fd);
+	} else if (errno != EPERM) {
+		log_err("Unexpected error from connect to server");
+		err = -1;
+	}
 out:
 	connect4_dropper__destroy(skel);
 	return err;
-- 
2.43.0


