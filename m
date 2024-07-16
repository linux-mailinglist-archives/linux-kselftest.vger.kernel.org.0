Return-Path: <linux-kselftest+bounces-13800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C723933013
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D58E282D6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787E1A08A5;
	Tue, 16 Jul 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQk/U7l4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A341A08A1;
	Tue, 16 Jul 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154782; cv=none; b=ATrwkxMH+mb4QX0nVInxaHTOfTSx/Sqw2gyFSo8/+4lBnuCoWqdFpc4/dNYWQRr3e0isNc5cjBWn+9h09/zShVINmLKX5geTFXA8tcTHIJ2CWe0/1UVaX7IgJpcv1BH5cO9N9GbFRGXlqCKUkoa6/ti15FHvqWsnEmUtNxSJ2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154782; c=relaxed/simple;
	bh=+svFXP1A49Vx6pvrKt2c6eFpqNlACgVtNw7SiimkAs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJTw1WdN77PYjGgUzXI3dotg6zUfarleWj/nK42Wekhb+I2HchOyVZhEc/sDDgvNXJTnjpO8t+fEDgcJOiLhQfk8BvBUBWx3ijUIDM4l4c++IoTUI5MapPokdNk8hIBYMJcLv9EJ/cSu2JyhnQjYOQlTBxQAXVoXRQ+T7hmktdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQk/U7l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FEEC116B1;
	Tue, 16 Jul 2024 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154781;
	bh=+svFXP1A49Vx6pvrKt2c6eFpqNlACgVtNw7SiimkAs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQk/U7l46ZkjaH5iWzM+DnK2pF8LdIn6JPguBUj3ssBu+U98Wl9RdrYToxiI+FO2Y
	 y7GgzU4qcCPtnW9gC5EdrA5pkmr/mOIAn4CmOGgbliiesCNukljYD3JjUKgLvSA149
	 KI82cC5Ti4JmrZvTVqQUvL6axsiQfo9pPs66max7Bu9qQt5VUUBUC41HUkprM9XG8y
	 0f4jhS7ituHJo1MHqQ6C2mP8JKT2I4rckSYravVYmvkcB6ztDTp71JPOeawiPHWZMI
	 mj/lvUJNdrCqIbjptN4X0q49JzE/3+F+4J6aFCPX7w6HbCZ88rCHRX5Qug2oP9QxJ+
	 xQPf2Gi2VCyUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 10/11] selftests/bpf: Extend tcx tests to cover late tcx_entry release
Date: Tue, 16 Jul 2024 14:31:54 -0400
Message-ID: <20240716183222.2813968-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183222.2813968-1-sashal@kernel.org>
References: <20240716183222.2813968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
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
index 01f241ea2c67b..dec9fd7ebba7f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,9 +53,12 @@ CONFIG_MPLS=y
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


