Return-Path: <linux-kselftest+bounces-10235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089058C607D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E66283D6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE843D3BF;
	Wed, 15 May 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5MW5drk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E383D388;
	Wed, 15 May 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752829; cv=none; b=WSI4LITgaKLMnuzNkFIrPMHqIv3b9+/Upte79DI/Q7QvDn7u9JjqwLETPjfPHoEb1X3HQr16IT/0HRB8ZB7fPVMMhthEPAUHn+3ADdED97M/kBmbICYJL017DBa/dDlNfml/QOVZo+yDGUWz0iNaL6hvvmHc92C/jPFOoco75Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752829; c=relaxed/simple;
	bh=tbrFM8SkYDvnxIQcgUhbjrMR9nLEahNNCk3IKrv15cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+/qrNoZ1ZOjPQiazgNEPOMSyY3V6HawuHc/3cbbW94vCDcE91+u50toOzvTZ8bvaTMGUc/O8e4jZ7fDONrbH14UmKh4Rl5WSVOvyCcCdNEn0AAXzLoLcU8RhOA6B1zJ2TkLKSMRC7zDR4V0B5L+5PlfXOBuHawu2ATrhwlSyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5MW5drk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB02C32782;
	Wed, 15 May 2024 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752828;
	bh=tbrFM8SkYDvnxIQcgUhbjrMR9nLEahNNCk3IKrv15cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5MW5drkonn2FzeumrfkBGlA7DV+wnahgX3rBmVIpQo87ufQ2/bVfPbrA+nYOgIgH
	 nBdWGStA/9ObBJ3Om9E8p8Q15aO48VwmOONgfHkV8+XPjMYM599Yk7OdSGTXm3sWyv
	 NcjU8rg1EpEMi6SwbPTxLuzOnWulSbpzBboy+TwLDUTpyj6bR1a/b4ieEJK1k0vceC
	 NzmsK7KKrbOQzblDHuNU+IIf/pvQIhgKtD9Q/L0W0NmkR8XpS2MBwtIj238hZR1p5g
	 dGrhuS5h5sOIfRB3CUNkUXEijFdCQqpzEH9DzNFLJEHhv55phkSR7VUubD7BJGafkH
	 1c6CieMY4eptw==
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
Subject: [PATCH bpf-next 3/9] selftests/bpf: Drop duplicate create_netns
Date: Wed, 15 May 2024 13:59:30 +0800
Message-ID: <d145d1fcfc1a58eaa7948e109583d0087cc46ee1.1715751995.git.tanggeliang@kylinos.cn>
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

This patch drops the duplicate local functions create_netns() in
bind_perm.c, bpf_iter_setsockopt.c, setget_sockopt.c, sock_fields.c
and tcp_hdr_options.c and uses unshare_netns() instead.

A new helper create_netns() will be added in network_helpers.c as a
public one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bind_perm.c  | 11 ++---------
 .../selftests/bpf/prog_tests/bpf_iter_setsockopt.c  | 13 +------------
 .../selftests/bpf/prog_tests/setget_sockopt.c       | 10 ++--------
 .../testing/selftests/bpf/prog_tests/sock_fields.c  | 13 +------------
 .../selftests/bpf/prog_tests/tcp_hdr_options.c      | 13 +------------
 5 files changed, 7 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index f7cd129cb82b..bc80c2773b67 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -7,16 +7,9 @@
 
 #include "test_progs.h"
 #include "cap_helpers.h"
+#include "network_helpers.h"
 #include "bind_perm.skel.h"
 
-static int create_netns(void)
-{
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
-		return -1;
-
-	return 0;
-}
-
 void try_bind(int family, int port, int expected_errno)
 {
 	struct sockaddr_storage addr = {};
@@ -54,7 +47,7 @@ void test_bind_perm(void)
 	__u64 old_caps = 0;
 	int cgroup_fd;
 
-	if (create_netns())
+	if (unshare_netns())
 		return;
 
 	cgroup_fd = test__join_cgroup("/bind_perm");
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index b52ff8ce34db..eff5d445896b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -8,17 +8,6 @@
 #include "bpf_cubic.skel.h"
 #include "bpf_iter_setsockopt.skel.h"
 
-static int create_netns(void)
-{
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
-		return -1;
-
-	if (!ASSERT_OK(system("ip link set dev lo up"), "bring up lo"))
-		return -1;
-
-	return 0;
-}
-
 static unsigned int set_bpf_cubic(int *fds, unsigned int nr_fds)
 {
 	unsigned int i;
@@ -187,7 +176,7 @@ void serial_test_bpf_iter_setsockopt(void)
 	struct bpf_link *cubic_link = NULL;
 	struct bpf_link *dctcp_link = NULL;
 
-	if (create_netns())
+	if (unshare_netns())
 		return;
 
 	/* Load iter_skel */
diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 7d4a9b3d3722..a44b6e3cec15 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -20,14 +20,8 @@ static const char addr6_str[] = "::1";
 static struct setget_sockopt *skel;
 static int cg_fd;
 
-static int create_netns(void)
+static int create_veth(void)
 {
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
-		return -1;
-
-	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
-		return -1;
-
 	if (!ASSERT_OK(system("ip link add dev binddevtest1 type veth peer name binddevtest2"),
 		       "add veth"))
 		return -1;
@@ -160,7 +154,7 @@ void test_setget_sockopt(void)
 	if (cg_fd < 0)
 		return;
 
-	if (create_netns())
+	if (unshare_netns() || create_veth())
 		goto done;
 
 	skel = setget_sockopt__open();
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 7d23166c77af..3499f54b14d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -45,17 +45,6 @@ static __u64 child_cg_id;
 static int linum_map_fd;
 static __u32 duration;
 
-static bool create_netns(void)
-{
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
-		return false;
-
-	if (!ASSERT_OK(system("ip link set dev lo up"), "bring up lo"))
-		return false;
-
-	return true;
-}
-
 static void print_sk(const struct bpf_sock *sk, const char *prefix)
 {
 	char src_ip4[24], dst_ip4[24];
@@ -350,7 +339,7 @@ void serial_test_sock_fields(void)
 	struct bpf_link *link;
 
 	/* Use a dedicated netns to have a fixed listen port */
-	if (!create_netns())
+	if (unshare_netns())
 		return;
 
 	/* Create a cgroup, get fd, and join it */
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..6b4d8fd0f087 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -40,17 +40,6 @@ struct sk_fds {
 	int active_lport;
 };
 
-static int create_netns(void)
-{
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
-		return -1;
-
-	if (!ASSERT_OK(system("ip link set dev lo up"), "run ip cmd"))
-		return -1;
-
-	return 0;
-}
-
 static void print_hdr_stg(const struct hdr_stg *hdr_stg, const char *prefix)
 {
 	fprintf(stderr, "%s{active:%u, resend_syn:%u, syncookie:%u, fastopen:%u}\n",
@@ -548,7 +537,7 @@ void test_tcp_hdr_options(void)
 		if (!test__start_subtest(tests[i].desc))
 			continue;
 
-		if (create_netns())
+		if (unshare_netns())
 			break;
 
 		tests[i].run();
-- 
2.43.0


