Return-Path: <linux-kselftest+bounces-10237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E75D8C6081
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA31C21E2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCD3FB1C;
	Wed, 15 May 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mph49uLB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3D3C485;
	Wed, 15 May 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752843; cv=none; b=iqp90xFlXPNky5eBRfn9Kyw8aJOmXEUD3H+E9wF90dt9lAU2gueb5oCXoV+tsiNGhcQy36WCf7uXEo4nIwLCoaxXfv5ZXgmkhV1uVAXjmvb/MR09/ACSHjGttPUzYqp4yGY1XHJC2wN+HEpHuTta0t2bRHh140ZI9y27aBPSihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752843; c=relaxed/simple;
	bh=nldUSDpla7riCahA4LY3CS7ej4UNHCzwLWbb6fr1yh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C24fzB2d2gOP2TJmdZr9RLnpAwaw+SLM2zXafA729XwIkaYSPQDFS2+bdyGREA6FE46wBZmtzq8D30WpSkZSVpjsY2OOTEokXUA8/npVp2P6Leid1hx6pZizGtABSM7yxEcpgltVi9102iscLdQhsuE/C/eOLqjOakZ9VPHaBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mph49uLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55732C4AF09;
	Wed, 15 May 2024 06:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752843;
	bh=nldUSDpla7riCahA4LY3CS7ej4UNHCzwLWbb6fr1yh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mph49uLB2V/3pmuv8rGdEr2XZWaBSniab8bljQeWjWvKvoaplSgXfblYYC4E+Uwpy
	 Htv+6iYUp0A+Nz8JfXnqrABZscfQbmoy8OO7XkcLvHWFPsJNdi08gSDonM3j2aDq2y
	 V2dEUnP3idcM7uNRe34AwXS2dU07WqH7WsDDWddZVv9d84190BKD/iO/0oGGRt65Dm
	 AsBGfnBciuU/CC/mBinfIBD3gj+acj52NjsnRchdz3Ap0NpjIZ4xjwv0ku4F8qEEoM
	 LNV0G9cyXwS+R4/RIV1dSRuywbp7nXfZC5ivGjLvJEGCdoYf8eVvf9MgjRW1rutMfI
	 luPxNVPqzWEWA==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 5/9] selftests/bpf: Use create_netns helper
Date: Wed, 15 May 2024 13:59:32 +0800
Message-ID: <8927853212a8bfedc303452f450ee7a0cf520d99.1715751995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715751995.git.tanggeliang@kylinos.cn>
References: <cover.1715751995.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The newly added helper create_netns() can be used in assign_reuse.c,
fib_lookup.c, ns_current_pid_tgid.c, sock_destroy.c and sock_iter_batch.c
to simplify the code.

It changes the behavior of test fib_lookup.c a little bit, but doesn't
affect the results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/assign_reuse.c    | 9 ++-------
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c      | 4 +---
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c       | 5 +----
 tools/testing/selftests/bpf/prog_tests/sock_destroy.c    | 5 +----
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 4 +---
 5 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 989ee4d9785b..21e1549d9749 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -175,12 +175,9 @@ void test_assign_reuse(void)
 {
 	struct nstoken *tok = NULL;
 
-	SYS(out, "ip netns add %s", NS_TEST);
-	SYS(cleanup, "ip -net %s link set dev lo up", NS_TEST);
-
-	tok = open_netns(NS_TEST);
+	tok = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(tok, "netns token"))
-		return;
+		goto cleanup;
 
 	if (test__start_subtest("tcpv4"))
 		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT);
@@ -194,6 +191,4 @@ void test_assign_reuse(void)
 cleanup:
 	close_netns(tok);
 	SYS_NOFAIL("ip netns delete %s", NS_TEST);
-out:
-	return;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index bd7658958004..b7eac1fce746 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -315,9 +315,7 @@ void test_fib_lookup(void)
 		return;
 	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto fail;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index e72d75d6baa7..6dae14d106ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -204,10 +204,7 @@ static void test_in_netns(int (*fn)(void *), void *arg)
 {
 	struct nstoken *nstoken = NULL;
 
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
+	nstoken = create_netns("ns_current_pid_tgid");
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 9c11938fe597..c156218c7280 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -193,10 +193,7 @@ void test_sock_destroy(void)
 	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
 		goto cleanup;
 
-	SYS(cleanup, "ip netns add %s", TEST_NS);
-	SYS(cleanup, "ip -net %s link set dev lo up", TEST_NS);
-
-	nstoken = open_netns(TEST_NS);
+	nstoken = create_netns(TEST_NS);
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d56e18b25528..6a19bfdc0677 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -113,10 +113,8 @@ void test_sock_iter_batch(void)
 	struct nstoken *nstoken = NULL;
 
 	SYS_NOFAIL("ip netns del " TEST_NS);
-	SYS(done, "ip netns add %s", TEST_NS);
-	SYS(done, "ip -net %s link set dev lo up", TEST_NS);
 
-	nstoken = open_netns(TEST_NS);
+	nstoken = create_netns(TEST_NS);
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto done;
 
-- 
2.43.0


