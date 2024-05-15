Return-Path: <linux-kselftest+bounces-10241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D48C6089
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF42824FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1241C6A;
	Wed, 15 May 2024 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6QklQBE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AB40862;
	Wed, 15 May 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752874; cv=none; b=kKVhlqPA5XGO2v/EXE58SKaONM3dMk62cE+A/gTl/xizD1BBBYAI+PfBNP01xCOrY8tWOmvfzspCPJnHsd9Q76v2VXwOrGREGBMPP2FFMQEHqCJPHB0cvBb6epSleBz5K2sWH9ktANZ8doM70accvjuYwgkrxCdSSyIA2wdlWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752874; c=relaxed/simple;
	bh=v2VRj9lBoAF6iF1QM9Z49yG7Oe8T0ukmCgaWUngLrP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzWb/4Tj2V7STHu9lgenLatVTFBcANVy/SCG2UwKldJXktT5rJFS3Zx1sUxrtufZmAjtqUXYFhrTUM2zRmvGmv46dErtKeqzNz+5L1YFcPt2eknZU+esq0sV2kFaIWRmfPBg3x8DBoyLOCZaghXfO+PllMxIjYB650/KzcD2KFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6QklQBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B2DC2BD11;
	Wed, 15 May 2024 06:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752873;
	bh=v2VRj9lBoAF6iF1QM9Z49yG7Oe8T0ukmCgaWUngLrP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6QklQBEq8iY/45up63lz7ShI5e+HxEt11Xxnc0V203YrEPQGqghBLRJsSHEpcG0R
	 ipALNF2oWIpkEiGtugglhAHSOQaDyL/yI4cMjgI0+cstsMe7HEzZhBhUpruT26hyBt
	 lFFjO7ynWQjohFoZOhDOXl1mnKgTctXpI7aKlgCGE8dT/31niGE8GkNRygOo9Dkzji
	 ecTRy2Le9JhNAv05GyquUMRo4lQ61CwJCGUtftMCIbbZMj22LIZU3Rge4N8PcQc2vJ
	 mQcTIfoqyUO7E+U4fbddLmqXrUckrjW3+LVfUE4e4uu1S5NN40kEm2xovg1eW+O9ok
	 5eppEYPq/SJQg==
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
Subject: [PATCH bpf-next 9/9] selftests/bpf: Use netns helpers in test_tunnel
Date: Wed, 15 May 2024 13:59:36 +0800
Message-ID: <a1d1035cefdeb675ae561fdb1fd49cddb4ba4bb6.1715751995.git.tanggeliang@kylinos.cn>
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

This patch uses netns helpers create_netns() and cleanup_netns() in
test_tunnel.c instead of using open_netns() and close_netns() directly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cec746e77cd3..6706ee1cb36d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -102,7 +102,6 @@
 
 static int config_device(void)
 {
-	SYS(fail, "ip netns add at_ns0");
 	SYS(fail, "ip link add veth0 address " MAC_VETH1 " type veth peer name veth1");
 	SYS(fail, "ip link set veth0 netns at_ns0");
 	SYS(fail, "ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
@@ -117,7 +116,7 @@ static int config_device(void)
 
 static void cleanup(void)
 {
-	SYS_NOFAIL("test -f /var/run/netns/at_ns0 && ip netns delete at_ns0");
+	SYS_NOFAIL("test -f /var/run/netns/at_ns0");
 	SYS_NOFAIL("ip link del veth1");
 	SYS_NOFAIL("ip link del %s", VXLAN_TUNL_DEV1);
 	SYS_NOFAIL("ip link del %s", IP6VXLAN_TUNL_DEV1);
@@ -444,7 +443,7 @@ static void test_vxlan_tunnel(void)
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
-	nstoken = open_netns("at_ns0");
+	nstoken = create_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	ifindex = if_nametoindex(VXLAN_TUNL_DEV0);
@@ -456,7 +455,7 @@ static void test_vxlan_tunnel(void)
 		goto done;
 	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
 		goto done;
-	close_netns(nstoken);
+	cleanup_netns(nstoken);
 
 	/* use veth1 ip 2 as tunnel source ip */
 	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
@@ -517,7 +516,7 @@ static void test_ip6vxlan_tunnel(void)
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
-	nstoken = open_netns("at_ns0");
+	nstoken = create_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	ifindex = if_nametoindex(IP6VXLAN_TUNL_DEV0);
@@ -529,7 +528,7 @@ static void test_ip6vxlan_tunnel(void)
 		goto done;
 	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
 		goto done;
-	close_netns(nstoken);
+	cleanup_netns(nstoken);
 
 	/* use veth1 ip 2 as tunnel source ip */
 	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
@@ -611,13 +610,13 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 		goto done;
 
 	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
+	nstoken = create_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns"))
 		goto done;
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
 	if (!ASSERT_OK(err, "test_ping"))
 		goto done;
-	close_netns(nstoken);
+	cleanup_netns(nstoken);
 
 done:
 	/* delete ipip tunnel */
@@ -667,11 +666,11 @@ static void test_xfrm_tunnel(void)
 		goto done;
 
 	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
+	nstoken = create_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns"))
 		goto done;
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	close_netns(nstoken);
+	cleanup_netns(nstoken);
 	if (!ASSERT_OK(err, "test_ping"))
 		goto done;
 
-- 
2.43.0


