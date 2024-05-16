Return-Path: <linux-kselftest+bounces-10278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C238C6FF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE071F230C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1965EBB;
	Thu, 16 May 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jde1oyOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484710F1;
	Thu, 16 May 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822059; cv=none; b=VZb9YYxUIcSx5prpNILUFzfHVXw/Yp5qj4QaElSMwjMBcjT7gnPqLUy+b6NmKXoTjlmGH87H98QTRE9E9XrKEdyI/NMquGSVOEvoA/9KcsRxxOAhrf2lXJ21K44iqeBJyUwCHaito87VJb0tdGrjUTuV5j8iZvF8yXvSEDHrDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822059; c=relaxed/simple;
	bh=Uo4wLsAlHWOererHPGvsbRVZjycyG+wZVHCA7IFyqz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNi28ftQQvFjlbCr6G/KEigE8mWSd5wBwNevQBbw8YevJElcx7nAzuaOvpdjdVsJhrXQ686LnUAVdIm4bZTrK3/sM5Znbu3YIXohxCj2KgTdEm/PzcjCJBGXpQZyVklaA6wmFsxMap1jQ2Wl+GvHxs4/9lDfBRfkMvWabvruMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jde1oyOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7785C32786;
	Thu, 16 May 2024 01:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822059;
	bh=Uo4wLsAlHWOererHPGvsbRVZjycyG+wZVHCA7IFyqz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jde1oyOxYp8DaQCMaya6jI/lNx+AG1YZ9HYLA1K1TW+pB3ETgU9IMeDO0TPyERsmN
	 27KWpX6Qmhb+CLdgefCydChempXl1Vs0q9bWVfiezGEyM11b9Fp77SqV39OFILLgb/
	 KA28Vjcg+f6kXHP76qx6i5uqhxRnI06ZGJN/RsuBSLmVJltDTJc/oXkW3p40X+Cq7J
	 rR7yc7H4ZM6Wn9bveLYzMEo/bjdm+iQWPeBuwyxSGUIFL30bBr0hnrZ0XcUkX6qsUy
	 ar+e8Vr6cpDbgkBvu9/EMrCajzY58Ebp4Gos6jPLHnIqOk65r6ABtVR7DiyGCdsp3l
	 UGuM0CgoZTnyw==
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
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Use cleanup_netns helper
Date: Thu, 16 May 2024 09:13:13 +0800
Message-ID: <4b69f489f2cd66dcd69851e4cfc419a3dde4b575.1715821541.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715821541.git.tanggeliang@kylinos.cn>
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses cleanup_netns() helper in BPF tests wide to replace
close_netns() and "ip netns del", included assign_reuse.c, crypto_sanity.c,
decap_sanity.c, fib_lookup.c, ns_current_pid_tgid.c, sock_destroy.c,
sock_iter_batch.c, xdp_dev_bound_only.c and xdp_do_redirect.c. This can
simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/assign_reuse.c       | 3 +--
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c      | 3 +--
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c       | 6 ++----
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c         | 4 +---
 .../testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c  | 4 +---
 tools/testing/selftests/bpf/prog_tests/sock_destroy.c       | 4 +---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c    | 3 +--
 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c    | 4 +---
 9 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 21e1549d9749..6fa08c47357c 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -189,6 +189,5 @@ void test_assign_reuse(void)
 		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT);
 
 cleanup:
-	close_netns(tok);
-	SYS_NOFAIL("ip netns delete %s", NS_TEST);
+	cleanup_netns(tok);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index b1a3a49a822a..ce6ceac8a812 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -190,8 +190,7 @@ void test_crypto_sanity(void)
 	ASSERT_OK(err, "bpf_tc_detach decrypt");
 
 fail:
-	close_netns(nstoken);
+	cleanup_netns(nstoken);
 	deinit_afalg();
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
 	crypto_sanity__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
index dcb9e5070cc3..9528b039ad33 100644
--- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -68,10 +68,8 @@ void test_decap_sanity(void)
 	ASSERT_FALSE(skel->bss->broken_csum_start, "broken_csum_start");
 
 fail:
-	if (nstoken) {
+	if (nstoken)
 		bpf_tc_hook_destroy(&qdisc_hook);
-		close_netns(nstoken);
-	}
-	SYS_NOFAIL("ip netns del " NS_TEST);
+	cleanup_netns(nstoken);
 	decap_sanity__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index b7eac1fce746..9de05603098d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -368,8 +368,6 @@ void test_fib_lookup(void)
 	}
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del " NS_TEST);
+	cleanup_netns(nstoken);
 	fib_lookup__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 6dae14d106ac..b4af39dbc449 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -211,9 +211,7 @@ static void test_in_netns(int (*fn)(void *), void *arg)
 	test_ns_current_pid_tgid_new_ns(fn, arg);
 
 cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
+	cleanup_netns(nstoken);
 }
 
 /* TODO: use a different tracepoint */
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index c156218c7280..1d3abc7a92c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -209,9 +209,7 @@ void test_sock_destroy(void)
 	RUN_TESTS(sock_destroy_prog_fail);
 
 cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del " TEST_NS);
+	cleanup_netns(nstoken);
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
 	sock_destroy_prog__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index b82ab5ddd9e6..f37e6450d08b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -124,8 +124,7 @@ void test_sock_iter_batch(void)
 		do_test(SOCK_DGRAM, true);
 		do_test(SOCK_DGRAM, false);
 	}
-	close_netns(nstoken);
 
 done:
-	SYS_NOFAIL("ip netns del " TEST_NS);
+	cleanup_netns(nstoken);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
index 7dd18c6d06c6..315777a4c7ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
@@ -53,9 +53,8 @@ void test_xdp_dev_bound_only_offdev(void)
 out:
 	close(fd1);
 	close(fd2);
-	close_netns(tok);
 	/* eth42 was added inside netns, removing the netns will
 	 * also remove eth42 veth pair.
 	 */
-	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
+	cleanup_netns(tok);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index bad0ea167be7..27cb409a237f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -241,8 +241,6 @@ void test_xdp_do_redirect(void)
 out_tc:
 	bpf_tc_hook_destroy(&tc_hook);
 out:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del testns");
+	cleanup_netns(nstoken);
 	test_xdp_do_redirect__destroy(skel);
 }
-- 
2.43.0


