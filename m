Return-Path: <linux-kselftest+bounces-10239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B48C6085
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BA11F23A98
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE84084C;
	Wed, 15 May 2024 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCCPXEnQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152093D388;
	Wed, 15 May 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752858; cv=none; b=Y3gkyzhHIU82/AC8MfFaxS9GVY4eDdme6sNNHfPdlog0hRsTgygI+gduoAmBD+WFaaSC+K+3GW6lhjndYqqPUhpXbwmIIxyAeCZod3UGOJ4WbveDWSWQwl371kb2b3QGStslcdQbVbtdZq/cd3uSimzQTAyFKrvkN6QDFSMlaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752858; c=relaxed/simple;
	bh=ahPd+Unc79ctEtQ8nwVSV0Z1os6ivAaHf/XZcrXhMxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSuSqAv4uEeL44XxJFrrL4cMrYZ0jblpVLmI79Gqpi0XEhNmOGXHTkc8E+8XOB1/EgQJLKiTGYNDIENw876G1JfKHn317ILfYuqgIF6KES6A6+UK55y03skHYJ/DNAu9LamTxcTWQUQefdO8V0o9hVeKJnKf5Anf78oatGazM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCCPXEnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E408AC4AF0F;
	Wed, 15 May 2024 06:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752857;
	bh=ahPd+Unc79ctEtQ8nwVSV0Z1os6ivAaHf/XZcrXhMxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCCPXEnQXF+3hlJRjcBHccyPlHGtnz6w/jmU8OMuNtcY/zC1LX7jalKzFQJBJLg94
	 Ks0s+/nJoGkDU8UPcLRvyxxgRPsfhQRWMhGsPTAFBZEE6DiwmdKkEMf93W8LO/9KeH
	 EyZZwS8Q5vG8ihe71zRbiWGO37XutIEyNnSYM+ii9B5W2KGCYYraUCLy4J2VkGeAkv
	 x/wI8ldkLChVBS4B5WLf6iRMxAvQ1gfwG16h1Ykn4vz5e97cOlJO/nAxlvQGIgNdk1
	 31jrrbh3r6cDxQcRaADU4OWnzaUIuNaQ1Y13K1xzsJNikUaOAgni9iiWslE5pAqN4N
	 K3LeDiKPb5nTw==
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
Subject: [PATCH bpf-next 7/9] selftests/bpf: Use cleanup_netns helper
Date: Wed, 15 May 2024 13:59:34 +0800
Message-ID: <ea2c5ea958ce94c36fe2d687aee98a2edefb8789.1715751995.git.tanggeliang@kylinos.cn>
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
index 6a19bfdc0677..786cf316b3fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -126,8 +126,7 @@ void test_sock_iter_batch(void)
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
index 498d3bdaa4b0..7ae93bbdbf82 100644
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


