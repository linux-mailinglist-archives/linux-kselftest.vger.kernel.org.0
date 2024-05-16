Return-Path: <linux-kselftest+bounces-10273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120808C6FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B097B224CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361DEDE;
	Thu, 16 May 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm+gUajB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4510E6;
	Thu, 16 May 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822028; cv=none; b=HVYa/gv3OvcJ3Ps6dqk1UiT3HBzc3D8agN4v0oRuDdpHhZXLnlFNIYVDL955ejZp+Lpsl787RL77mYUm32lLq4d5Phaqm7SDIzfZwDsq1U9gZoKW+d7yBDmBa5kchJeHxCHXrP+Y8j5gw4mROqgGfilsJjuoR0i1BUYIIceNPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822028; c=relaxed/simple;
	bh=9RIzon2SQFRluCkM4WuVpqfZM7QKLJta1nv2UWTfiXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn17x042tzZXSOq/i/mTPlAzBkGPMbeUoiJkv7F9eUtacZMPjYI1L/E73SNymOnRMAEiciq/BzeI44kYs0yD7ntSs2Buf8dhmhqqXg59lpWJ8U0Cq4i4I5K9wn0xR9IPDn7TjwSHvaTDMpThQOpXAYcEQk95bp2uuJHccQscuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm+gUajB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A3C116B1;
	Thu, 16 May 2024 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822028;
	bh=9RIzon2SQFRluCkM4WuVpqfZM7QKLJta1nv2UWTfiXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm+gUajBIrXdq1jEl+IXdn6UM+bOrpU9FP5krOj+r8eFWqku/gyisAG5FaDkTiM+e
	 Cg2hv5CbW1WhZHB1vTLXh1r8oHUYM9gXBONzdXUP+00DjMxr24b+OzeuqApZHZV/KL
	 +CoZ38NgyrnEALo44lZb5cwHEkk8BJDl+T1AeqXIO1INqXij/SDD6PVdI9F4zzGRw8
	 E0/7PmRR52kFRTWzki8UTn3DpmvDkqc695sB5+fFtejZzoj2P1ppU8d0HjV2uGXtN3
	 SI6JyhmnILhdpWiOCkgrdjhzQfIlFSB1KzZExQwXFvI2dO5NFtw3VQkZDXNHxPprYd
	 eOJjHwgeWTu2w==
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
Subject: [PATCH bpf-next v2 2/8] selftests/bpf: Use unshare_netns helper
Date: Thu, 16 May 2024 09:13:08 +0800
Message-ID: <f213e56c388d667ab901e3659eaaf8c4c48809ff.1715821541.git.tanggeliang@kylinos.cn>
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

The newly added helper unshare_netns() can be used to replace unshare()
and "ip link set dev lo up" in sk_assign.c, btf_skc_cls_ingress.c and
tcp_custom_syncookie.c to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c  | 6 +-----
 tools/testing/selftests/bpf/prog_tests/sk_assign.c          | 4 +---
 .../testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index ef4d6a3ae423..f697397c641e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -27,15 +27,11 @@ static int prepare_netns(void)
 	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
 		    .prog_fd = bpf_program__fd(skel->progs.cls_ingress));
 
-	if (CHECK(unshare(CLONE_NEWNET), "create netns",
+	if (CHECK(unshare_netns(), "create netns",
 		  "unshare(CLONE_NEWNET): %s (%d)",
 		  strerror(errno), errno))
 		return -1;
 
-	if (CHECK(system("ip link set dev lo up"),
-		  "ip link set dev lo up", "failed\n"))
-		return -1;
-
 	qdisc_lo.ifindex = if_nametoindex("lo");
 	if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo clsact"))
 		return -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..56df5861059f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -47,12 +47,10 @@ configure_stack(void)
 		return false;
 
 	/* Move to a new networking namespace */
-	if (CHECK_FAIL(unshare(CLONE_NEWNET)))
+	if (CHECK_FAIL(unshare_netns()))
 		return false;
 
 	/* Configure necessary links, routes */
-	if (CHECK_FAIL(system("ip link set dev lo up")))
-		return false;
 	if (CHECK_FAIL(system("ip route add local default dev lo")))
 		return false;
 	if (CHECK_FAIL(system("ip -6 route add local default dev lo")))
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..07817d9c039c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -32,12 +32,9 @@ static struct test_tcp_custom_syncookie_case {
 
 static int setup_netns(void)
 {
-	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+	if (!ASSERT_OK(unshare_netns(), "create netns"))
 		return -1;
 
-	if (!ASSERT_OK(system("ip link set dev lo up"), "ip"))
-		goto err;
-
 	if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_ecn", "1"),
 		       "write_sysctl"))
 		goto err;
-- 
2.43.0


