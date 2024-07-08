Return-Path: <linux-kselftest+bounces-13298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DF929AD5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E961C209ED
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741D1C17;
	Mon,  8 Jul 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6+5UoTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC77442F;
	Mon,  8 Jul 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405845; cv=none; b=LUKGZ3Xt+cCNkbLMAyiO6XSW/lRmnDRCs0z8FADsprKzpcw5e9gdfnRwV6+zPwqP35o2Hx1FXXkH2xpzZX1bT2iy/Pu9RZJTLUGw/MxU8sP7eO4JapAehCfcDNxL8eKJtcSRY9MvrO4O2yWaQrQkUjr3HTQVXzuwHMEMJJYO33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405845; c=relaxed/simple;
	bh=xkEJWzojc89EojQm4GQ2qYFqMqQKzaIHgglr7UG2tq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkJQ0VlF7OOESqxAp9oR5tkHUFE5+jI/usIFPlCOc+gHPpavdNV/v1WgI0lORDhS28+L7CbHIOwaWpwrr5vKIyTb6yLceMMetJ/seYFyQjw3hgyrhFsO4MORM4AbHQD28Y1ZEu7vSK2x0LtHEHPxQgfHTjE+4E+jqh0DHnqPwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6+5UoTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2303FC4AF07;
	Mon,  8 Jul 2024 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405845;
	bh=xkEJWzojc89EojQm4GQ2qYFqMqQKzaIHgglr7UG2tq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6+5UoTY4TFQVSrlOH0zleLuVCmkRI11Mw+oyoxSzT6wkZEWfvG4OX6bYV0okPOMF
	 /Vk/VaanbLfzdgBTGi2bZPaRXTKLwjteyF89UN/RcebRd5suDbYjeEC7DwzoijRcYA
	 V17ar9DTb2tvHOCkPG7BMb8XRKN1i2B9cEl5FAoPQal2+79PBTeiiDUX0GrKWA3hZH
	 guPhwK0yuzljiADvexDzuHWuKw97co3iG020HqTU78dL5z52ZNV8zVP2OQMlMwi5yO
	 hDF00YXvqaigZYlWHiManqgrILE5PGXAKWgIFscN4fJ2NbfzJYcjbcppLaX4Mdr6OD
	 s9du//vaQsAZw==
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
Subject: [PATCH bpf-next v10 06/12] selftests/bpf: Add expect_errno for network_helper_opts
Date: Mon,  8 Jul 2024 10:29:44 +0800
Message-ID: <35ab4f6f094e3c700aa9ec20ee6d6d1a91284b5a.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The errno EPERM is skipped in connect_fd_to_addr() by cgroup_v1v2 tests.
More generally, it makes sense to add a struct member "expect_errno" for
network_helper_opts to identify the expect errno to be skipped.

Correspondingly, connect_fd_to_addr() helper needs to add a new parameter
"expect_errno" too to accept "opts->expect_errno" passed from the caller
connect_to_addr() or connect_fd_to_fd().

With this change, only need to set "expect_errno" as EPERM in run_test()
in prog_tests/cgroup_v1v2.c.

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


