Return-Path: <linux-kselftest+bounces-13535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62F92DE96
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 04:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0999228243A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 02:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC3BE49;
	Thu, 11 Jul 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqwCe6jE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88E8F5D;
	Thu, 11 Jul 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666402; cv=none; b=T3/ERjlWJSwhsPLn+aosHgxQA49L7eWOhKVvrwk/d5LEdR1qjhoWb+AP/F6yM8vc+B3KKMrm7HCWCQ/oQGU1g1vtBdggUrjtqejopMEULzsZSuCPSHlzectgXe+lFMIJvWT7ZgqMabUg5Lf10Iw1jrBr8eV83YQutsJP9j1o8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666402; c=relaxed/simple;
	bh=CXQYkTQhcNfF4hvRS1J939E7r0iDn/ER/ecF1KZT/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAWTkYr4d9NpDZHSyO8KqTBrPsNJBoBF36V3J5jifT2EHP3cr4Z/165ikVm91Vgsr+ECK3ujYSz7gafnjdssa2pTB9ChOoRDtRZA+TD/FrP5Wt43/jevR3guC7NKE+m6aXZczqQnAxrbaIuvvhALXivWhDbZZSDhdFt53gZDtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqwCe6jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A14C4AF10;
	Thu, 11 Jul 2024 02:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720666401;
	bh=CXQYkTQhcNfF4hvRS1J939E7r0iDn/ER/ecF1KZT/nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqwCe6jEroIKUDrGe2BuVussYXxfE7lt6IxhyUHs4KSpigUZ2NtdAAsDWMTdxdZLO
	 Pj+aii6sLsqlTorODXuOsAJ/dzcjnhyVRBBYzPMpeyGb5QwFBXfSgTPDWzF5fthyNr
	 +U1XBMP2m0g5Of6xTCz4cdX4V+vAlizQNe738doOiG6iYrnD3BFgeZYuGtHE9WdrGZ
	 6IxvFz9vS/nhrOZV8zwyHLE/uHF0pUPiBm1VepY6oces6jRZgwRDJkiycbU80hfegK
	 7DS3jKMsgDGID7QBG9/jBJQGhc2tPaYQyA7eMRI1tHQEP8e8E5jidJXgy4RyG+kUlO
	 ekOSmy5kuyXyA==
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
Subject: [PATCH bpf-next 2/5] selftests/bpf: Drop must_fail from network_helper_opts
Date: Thu, 11 Jul 2024 10:52:49 +0800
Message-ID: <009c7c136773462cc71c73ed8da84d58df2e1e3f.1720664658.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720664658.git.tanggeliang@kylinos.cn>
References: <cover.1720664658.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  6 ++--
 3 files changed, 4 insertions(+), 34 deletions(-)

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
index addf720428f7..eda67b629c67 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -9,9 +9,7 @@
 
 static int run_test(int cgroup_fd, int server_fd, bool classid)
 {
-	struct network_helper_opts opts = {
-		.must_fail = true,
-	};
+	struct network_helper_opts opts = {};
 	struct connect4_dropper *skel;
 	int fd, err = 0;
 
@@ -33,7 +31,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 	}
 
 	fd = connect_to_fd_opts(server_fd, &opts);
-	if (fd < 0)
+	if (fd < 0 && errno != EPERM)
 		err = -1;
 	else
 		close(fd);
-- 
2.43.0


