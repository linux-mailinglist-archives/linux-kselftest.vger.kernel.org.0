Return-Path: <linux-kselftest+bounces-13803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0693303F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EA91C2244D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262EE1A0720;
	Tue, 16 Jul 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM8ec1p8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AFB1A01CD;
	Tue, 16 Jul 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154840; cv=none; b=k+tUHXEdWCR6B4wBJaasp2UoThPV8Z9bazyIAqs4xGIpxpBT176pvH2CG41rJtqzxJ85oGJf3uPocwoauZU/Gc+skHeAxqimdvPdNalwhfpbYyYQxF7v19EUep2R9nyRB2TeAf5lx2er0d7r8PXxuOBkvFsI+ishVzFFl2nX0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154840; c=relaxed/simple;
	bh=Xmi+WTq2V/mzq0LaYUdnlDsum6DVd8mVnqPEv88vJcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8fmgCoP10pNxeSMY9nwpZWy8hcGm44ggmTFhdJbrvgSeFGVL82xSYPrhETeiBzbVdW/Lv6sEg5Y3hcgt1JELTOjZgHEtA6Ha1voOA34aiEmp4bE4WrX1qWKhplGgaZdRDdelI5wDOHj/NOlSS0XJ+BeeNjqBouQpkGXZzH2E/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM8ec1p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29071C4AF0B;
	Tue, 16 Jul 2024 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154839;
	bh=Xmi+WTq2V/mzq0LaYUdnlDsum6DVd8mVnqPEv88vJcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mM8ec1p8FlDoCpbVDOxrE8ehTdGpJ8+lBzN9FshwsHSNKYAW54DAgF3hYkpGzOitu
	 Cv/vSkhYIVLuGXIiSPvOjd9851BfIUUpHeLS3l2XH2B1+7SnNMpKvxsOuz72qGcobl
	 IMEgxr80yK6oe001PrMOjy1SB/cTv8R/3hOmfljyc/n7b1gKwfsGRRDZKb5G1kIyKL
	 hYHIQAgAuahRSA21Ug0oRnVZ/JZWZdZaHmCmXbiu6IWWEVaLNYhA2yKIG4qCBCU+AG
	 70sSZKJS9L+S24e8FxCotxd6nKVurh3imr8Pq7DBJl+8uhDZ3Oi2xKhsGCJljrsp4F
	 kDczGGqawAYmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 7/8] selftests/bpf: Extend tcx tests to cover late tcx_entry release
Date: Tue, 16 Jul 2024 14:33:04 -0400
Message-ID: <20240716183324.2814275-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183324.2814275-1-sashal@kernel.org>
References: <20240716183324.2814275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 5f1d18de79180deac2822c93e431bbe547f7d3ce ]

Add a test case which replaces an active ingress qdisc while keeping the
miniq in-tact during the transition period to the new clsact qdisc.

  # ./vmtest.sh -- ./test_progs -t tc_link
  [...]
  ./test_progs -t tc_link
  [    3.412871] bpf_testmod: loading out-of-tree module taints kernel.
  [    3.413343] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #332     tc_links_after:OK
  #333     tc_links_append:OK
  #334     tc_links_basic:OK
  #335     tc_links_before:OK
  #336     tc_links_chain_classic:OK
  #337     tc_links_chain_mixed:OK
  #338     tc_links_dev_chain0:OK
  #339     tc_links_dev_cleanup:OK
  #340     tc_links_dev_mixed:OK
  #341     tc_links_ingress:OK
  #342     tc_links_invalid:OK
  #343     tc_links_prepend:OK
  #344     tc_links_replace:OK
  #345     tc_links_revision:OK
  Summary: 14/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20240708133130.11609-2-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/config            |  3 +
 .../selftests/bpf/prog_tests/tc_links.c       | 61 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index e41eb33b27046..5751614aef6a5 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -52,9 +52,12 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_NET_ACT_SKBMOD=y
+CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_CLS_MATCHALL=y
 CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NET_IPGRE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index bc98411446855..1af9ec1149aab 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -9,6 +9,8 @@
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 #include "test_tc_link.skel.h"
+
+#include "netlink_helpers.h"
 #include "tc_helpers.h"
 
 void serial_test_tc_links_basic(void)
@@ -1787,6 +1789,65 @@ void serial_test_tc_links_ingress(void)
 	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
 }
 
+struct qdisc_req {
+	struct nlmsghdr  n;
+	struct tcmsg     t;
+	char             buf[1024];
+};
+
+static int qdisc_replace(int ifindex, const char *kind, bool block)
+{
+	struct rtnl_handle rth = { .fd = -1 };
+	struct qdisc_req req;
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
+	req.n.nlmsg_flags = NLM_F_CREATE | NLM_F_REPLACE | NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_NEWQDISC;
+	req.t.tcm_family = AF_UNSPEC;
+	req.t.tcm_ifindex = ifindex;
+	req.t.tcm_parent = 0xfffffff1;
+
+	addattr_l(&req.n, sizeof(req), TCA_KIND, kind, strlen(kind) + 1);
+	if (block)
+		addattr32(&req.n, sizeof(req), TCA_INGRESS_BLOCK, 1);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	return err;
+}
+
+void serial_test_tc_links_dev_chain0(void)
+{
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev foo type veth peer name bar"), "add veth");
+	ifindex = if_nametoindex("foo");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+	err = qdisc_replace(ifindex, "ingress", true);
+	if (!ASSERT_OK(err, "attaching ingress"))
+		goto cleanup;
+	ASSERT_OK(system("tc filter add block 1 matchall action skbmod swap mac"), "add block");
+	err = qdisc_replace(ifindex, "clsact", false);
+	if (!ASSERT_OK(err, "attaching clsact"))
+		goto cleanup;
+	/* Heuristic: kern_sync_rcu() alone does not work; a wait-time of ~5s
+	 * triggered the issue without the fix reliably 100% of the time.
+	 */
+	sleep(5);
+	ASSERT_OK(system("tc filter add dev foo ingress matchall action skbmod swap mac"), "add filter");
+cleanup:
+	ASSERT_OK(system("ip link del dev foo"), "del veth");
+	ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
+	ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
+}
+
 static void test_tc_links_dev_mixed(int target)
 {
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
-- 
2.43.0


