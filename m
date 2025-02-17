Return-Path: <linux-kselftest+bounces-26778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77174A3831B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFBB17177F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CE21C16B;
	Mon, 17 Feb 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GeiSKRgb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6629216605;
	Mon, 17 Feb 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795868; cv=none; b=ED+6NkXSnFvsPfNUUhUw5sGN4bQIWGil+sIL0tULiEWhpa0z1vMFQoPKkaPXjtBlamLZhqaB72kB/KmGdQIC97b9C53GawvFrFV9gK3HBy2MfAk6JmtGE5MANsVH/9VjjXxmNZf3kQTFaMiYpRhsiVqWmHxeBoTzgauUKBBoA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795868; c=relaxed/simple;
	bh=dBDzjWo6VKaha93rZaATReYixZ6fjqLkF4Ozu1zlCnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeTDF37TbW2Ff03f3uI2vWBbVvAIVjNsfBCtPlhqyiiJwNRjwBCqKMBl4CzVQSLT7sLdZgSa0AOM4qlg3opTW7opQ/oYicCmVjRTmtRWWevKRpPWz4x6fN2KryEGV0UtM9f2JZBXe+Mu+vjwSjP0tF1+Od9J2LeLcQL8yX45Lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GeiSKRgb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 518C442E76;
	Mon, 17 Feb 2025 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739795863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/PSKk2nTtn7RBvDNRW2TtzxymnJUDPRTpmAdQXQeOY=;
	b=GeiSKRgbqhzzq9tBG8HuVOgywAnYfyI6Pd4xP0zYJXGQdNkXTskTaYUZsiwmWNKAD3PxK6
	+nRfi5dmcOyPOaz4UK3RpnL7jWquRSUBn0bPdue1Vks2eMyWOEI7QiWDwbDzm6ZV8w4CPd
	4Aa8r8WIuokpT9dOTModStU3amRJpgx/Uuw/m9L5bsbg8SUGW+Z5JxeSSXOR6vqF3R5iv6
	TOMdaoD42F8XuC6guVzSOOvTnH3fqIaitnl4q0KvbfxxtmhQdFpw3R81gp6dsx+2rhjdRZ
	gunywfbnADVNgadfTfU6+NTbMyYIBui+rbCy3HX1bbfq9y2bUe5Uvq2qW3BKlg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Feb 2025 13:37:40 +0100
Subject: [PATCH bpf-next 3/3] selftests/bpf: tc_links/tc_opts: Serialize
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-tc_links-v1-3-27f7965e3dcd@bootlin.com>
References: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
In-Reply-To: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughri
 hhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: bastien.curutchet@bootlin.com

The tests aren't allowed to be run in parallel while they could be.

Replace serial_test_*() calls by test_*() ones to allow parallelization
of these tests.
Rename some 'subtests' functions to avoid name conflicts with the actual
tests.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_links.c | 40 +++++++++---------
 tools/testing/selftests/bpf/prog_tests/tc_opts.c  | 50 +++++++++++------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 07a2fc3d44d03e18dd3c715b0b26c7f1ac6d47cb..c94fe1e1687239ed4090f53bff40ede10e501f55 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -269,7 +269,7 @@ static void test_tc_links_before_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_before(void)
+void test_tc_links_before(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -432,7 +432,7 @@ static void test_tc_links_after_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_after(void)
+void test_tc_links_after(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -541,7 +541,7 @@ static void test_tc_links_revision_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_revision(void)
+void test_tc_links_revision(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -654,7 +654,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_chain_classic(void)
+void test_tc_links_chain_classic(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -891,7 +891,7 @@ static void test_tc_links_replace_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_replace(void)
+void test_tc_links_replace(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1212,7 +1212,7 @@ static void test_tc_links_invalid_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_invalid(void)
+void test_tc_links_invalid(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1377,7 +1377,7 @@ static void test_tc_links_prepend_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_prepend(void)
+void test_tc_links_prepend(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1542,7 +1542,7 @@ static void test_tc_links_append_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_append(void)
+void test_tc_links_append(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1649,7 +1649,7 @@ static void test_tc_links_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_cleanup(void)
+void test_tc_links_dev_cleanup(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1762,7 +1762,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_links_chain_mixed(void)
+void test_tc_links_chain_mixed(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1777,7 +1777,7 @@ void serial_test_tc_links_chain_mixed(void)
 	netns_free(ns);
 }
 
-static void test_tc_links_ingress(int target, bool chain_tc_old,
+static void tc_links_ingress(int target, bool chain_tc_old,
 				  bool tcx_teardown_first)
 {
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts,
@@ -1881,7 +1881,7 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_ingress(void)
+void test_tc_links_ingress(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1890,9 +1890,9 @@ void serial_test_tc_links_ingress(void)
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
-	test_tc_links_ingress(BPF_TCX_INGRESS, true, true);
-	test_tc_links_ingress(BPF_TCX_INGRESS, true, false);
-	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
+	tc_links_ingress(BPF_TCX_INGRESS, true, true);
+	tc_links_ingress(BPF_TCX_INGRESS, true, false);
+	tc_links_ingress(BPF_TCX_INGRESS, false, false);
 
 	netns_free(ns);
 }
@@ -1931,7 +1931,7 @@ static int qdisc_replace(int ifindex, const char *kind, bool block)
 	return err;
 }
 
-void serial_test_tc_links_dev_chain0(void)
+void test_tc_links_dev_chain0(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1963,7 +1963,7 @@ void serial_test_tc_links_dev_chain0(void)
 	netns_free(ns);
 }
 
-static void test_tc_links_dev_mixed(int target)
+static void tc_links_dev_mixed(int target)
 {
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook);
@@ -2070,7 +2070,7 @@ static void test_tc_links_dev_mixed(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_mixed(void)
+void test_tc_links_dev_mixed(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2079,8 +2079,8 @@ void serial_test_tc_links_dev_mixed(void)
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
-	test_tc_links_dev_mixed(BPF_TCX_INGRESS);
-	test_tc_links_dev_mixed(BPF_TCX_EGRESS);
+	tc_links_dev_mixed(BPF_TCX_INGRESS);
+	tc_links_dev_mixed(BPF_TCX_EGRESS);
 
 	netns_free(ns);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index d38376244532026b2b3d505bcf9711c8e7948e17..615048fc3cd7b497b49883bf4c1ba410efce52f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -12,7 +12,7 @@
 #include "test_tc_link.skel.h"
 #include "tc_helpers.h"
 
-void serial_test_tc_opts_basic(void)
+void test_tc_opts_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
@@ -263,7 +263,7 @@ static void test_tc_opts_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_before(void)
+void test_tc_opts_before(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -463,7 +463,7 @@ static void test_tc_opts_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_after(void)
+void test_tc_opts_after(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -581,7 +581,7 @@ static void test_tc_opts_revision_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_revision(void)
+void test_tc_opts_revision(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -691,7 +691,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_chain_classic(void)
+void test_tc_opts_chain_classic(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -909,7 +909,7 @@ static void test_tc_opts_replace_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_replace(void)
+void test_tc_opts_replace(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1071,7 +1071,7 @@ static void test_tc_opts_invalid_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_invalid(void)
+void test_tc_opts_invalid(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1220,7 +1220,7 @@ static void test_tc_opts_prepend_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_prepend(void)
+void test_tc_opts_prepend(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1369,7 +1369,7 @@ static void test_tc_opts_append_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_append(void)
+void test_tc_opts_append(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1468,7 +1468,7 @@ static void test_tc_opts_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_dev_cleanup(void)
+void test_tc_opts_dev_cleanup(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1653,7 +1653,7 @@ static void test_tc_opts_mixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_mixed(void)
+void test_tc_opts_mixed(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1741,7 +1741,7 @@ static void test_tc_opts_demixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_demixed(void)
+void test_tc_opts_demixed(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -1921,7 +1921,7 @@ static void test_tc_opts_detach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach(void)
+void test_tc_opts_detach(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2137,7 +2137,7 @@ static void test_tc_opts_detach_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_before(void)
+void test_tc_opts_detach_before(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2362,7 +2362,7 @@ static void test_tc_opts_detach_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_after(void)
+void test_tc_opts_detach_after(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2377,7 +2377,7 @@ void serial_test_tc_opts_detach_after(void)
 	netns_free(ns);
 }
 
-static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
+static void tc_opts_delete_empty(int target, bool chain_tc_old)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
@@ -2400,7 +2400,7 @@ static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_delete_empty(void)
+void test_tc_opts_delete_empty(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2409,10 +2409,10 @@ void serial_test_tc_opts_delete_empty(void)
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
-	test_tc_opts_delete_empty(BPF_TCX_INGRESS, false);
-	test_tc_opts_delete_empty(BPF_TCX_EGRESS, false);
-	test_tc_opts_delete_empty(BPF_TCX_INGRESS, true);
-	test_tc_opts_delete_empty(BPF_TCX_EGRESS, true);
+	tc_opts_delete_empty(BPF_TCX_INGRESS, false);
+	tc_opts_delete_empty(BPF_TCX_EGRESS, false);
+	tc_opts_delete_empty(BPF_TCX_INGRESS, true);
+	tc_opts_delete_empty(BPF_TCX_EGRESS, true);
 
 	netns_free(ns);
 }
@@ -2516,7 +2516,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_chain_mixed(void)
+void test_tc_opts_chain_mixed(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2599,7 +2599,7 @@ static void test_tc_opts_max_target(int target, int flags, bool relative)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_max(void)
+void test_tc_opts_max(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2910,7 +2910,7 @@ static void test_tc_opts_query_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query(void)
+void test_tc_opts_query(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;
@@ -2978,7 +2978,7 @@ static void test_tc_opts_query_attach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query_attach(void)
+void test_tc_opts_query_attach(void)
 {
 	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	struct netns_obj *ns;

-- 
2.48.1


