Return-Path: <linux-kselftest+bounces-26777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1CA38314
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC01188F24C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77421B1AA;
	Mon, 17 Feb 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k6P7047M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282F215F5F;
	Mon, 17 Feb 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795866; cv=none; b=EJ6XUskyyCbD6LFjJFqrl6gTr8KvaMuXk3EkzYlR+B/1W/dlAIrrS/sLUKmFAPMQY+cmodcbHCaCGbwj9omVxJ0IvIRLJ8PheXBb4l7D5lG4X7pubHGqDXneIUWFrT8wezC4Z5orO2jBSaPXbJAcn4AhjkfWTBJ4qrDQXjlvZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795866; c=relaxed/simple;
	bh=lBHKzM7wgOrvjY1S4H2VmwbZNB7CaSNAUpx/6g0spzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPg2VP4b+eYx750o9V+wU8Pt1jPbkqr4WO4H7xV0mTbXHD2Ik0m0QmIHgn96DY+BxdEs7SlbGOMnHk+9Sdi67uhkpOXvFc22U/mk7EvHs1Gfk+paxYShyxMC43QqJPnLRgZtj2C/oBlHi0FBmAWJTLlxxzmWM6yr7q7NARzRiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k6P7047M; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53E31442DA;
	Mon, 17 Feb 2025 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739795862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLcEGHTZzAbYR+0qANyqNR8i14TPZB/5Yvji8iH8d9c=;
	b=k6P7047Mr5iarIaBRGQ7poO11LSLWLgOaNMol85OBfOtfzlJWId1MW9SwWEz9HqSgX3wit
	AJoV0VNCsFr4RDTA81q0WZyCY1jqkWfa/W5Is4q9vLa7rTWmVLa53RxgmgYOplA+yxAuat
	PPy5V/GUXg6belTVU7lxs4ljk4tkLckaCeBISNVQkjZUtu1igZ5gDazo9MArlQlep7qygO
	fPZuJOkaeRd0IC+BfQvrXfteZfBBMt5+XutUpX0kMv2FJnXZe1YnwWIV841ruOjL8IyYdM
	r9VIgMthT65yL4mi/cI4oB6HdS3r4TfqI5zgE4EHn0lYQBdCPI9TaV9n95O97Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Feb 2025 13:37:39 +0100
Subject: [PATCH bpf-next 2/3] selftests/bpf: tc_link/tc_opts: Use unique
 namespace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-tc_links-v1-2-27f7965e3dcd@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughri
 hhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: bastien.curutchet@bootlin.com

All the tests use the loopback interface. It prevents from running them
in parallel.

Use the create_and_open_tid_ns() helper to run each test in its own
network namespace.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_links.c | 124 +++++++++++++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c  | 180 ++++++++++++++++++++++
 2 files changed, 304 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 1af9ec1149aab6ca5ef6986fc16a650162266966..07a2fc3d44d03e18dd3c715b0b26c7f1ac6d47cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -7,6 +7,8 @@
 
 #define loopback 1
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
+#define NS_NAME_MAX_LEN 32
+#define NS_NAME "ns-tc-link-"
 
 #include "test_tc_link.skel.h"
 
@@ -17,12 +19,18 @@ void serial_test_tc_links_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_query_opts, optq);
 	LIBBPF_OPTS(bpf_tcx_opts, optl);
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	__u32 prog_ids[2], link_ids[2];
 	__u32 pid1, pid2, lid1, lid2;
 	struct test_tc_link *skel;
 	struct bpf_link *link;
+	struct netns_obj *ns;
 	int err;
 
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	skel = test_tc_link__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;
@@ -110,6 +118,7 @@ void serial_test_tc_links_basic(void)
 
 	assert_mprog_count(BPF_TCX_INGRESS, 0);
 	assert_mprog_count(BPF_TCX_EGRESS, 0);
+	netns_free(ns);
 }
 
 static void test_tc_links_before_target(int target)
@@ -262,8 +271,17 @@ static void test_tc_links_before_target(int target)
 
 void serial_test_tc_links_before(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_before_target(BPF_TCX_INGRESS);
 	test_tc_links_before_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_after_target(int target)
@@ -416,8 +434,17 @@ static void test_tc_links_after_target(int target)
 
 void serial_test_tc_links_after(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_after_target(BPF_TCX_INGRESS);
 	test_tc_links_after_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_revision_target(int target)
@@ -516,8 +543,17 @@ static void test_tc_links_revision_target(int target)
 
 void serial_test_tc_links_revision(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_revision_target(BPF_TCX_INGRESS);
 	test_tc_links_revision_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_chain_classic(int target, bool chain_tc_old)
@@ -620,10 +656,19 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 void serial_test_tc_links_chain_classic(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
 	test_tc_chain_classic(BPF_TCX_INGRESS, true);
 	test_tc_chain_classic(BPF_TCX_EGRESS, true);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_replace_target(int target)
@@ -848,8 +893,17 @@ static void test_tc_links_replace_target(int target)
 
 void serial_test_tc_links_replace(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_replace_target(BPF_TCX_INGRESS);
 	test_tc_links_replace_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_invalid_target(int target)
@@ -1160,8 +1214,17 @@ static void test_tc_links_invalid_target(int target)
 
 void serial_test_tc_links_invalid(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_invalid_target(BPF_TCX_INGRESS);
 	test_tc_links_invalid_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_prepend_target(int target)
@@ -1316,8 +1379,17 @@ static void test_tc_links_prepend_target(int target)
 
 void serial_test_tc_links_prepend(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_prepend_target(BPF_TCX_INGRESS);
 	test_tc_links_prepend_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_append_target(int target)
@@ -1472,8 +1544,17 @@ static void test_tc_links_append_target(int target)
 
 void serial_test_tc_links_append(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_append_target(BPF_TCX_INGRESS);
 	test_tc_links_append_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_dev_cleanup_target(int target)
@@ -1570,8 +1651,17 @@ static void test_tc_links_dev_cleanup_target(int target)
 
 void serial_test_tc_links_dev_cleanup(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_links_dev_cleanup_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_chain_mixed(int target)
@@ -1674,8 +1764,17 @@ static void test_tc_chain_mixed(int target)
 
 void serial_test_tc_links_chain_mixed(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_links_ingress(int target, bool chain_tc_old,
@@ -1784,9 +1883,18 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 
 void serial_test_tc_links_ingress(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, true);
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, false);
 	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
+
+	netns_free(ns);
 }
 
 struct qdisc_req {
@@ -1825,8 +1933,14 @@ static int qdisc_replace(int ifindex, const char *kind, bool block)
 
 void serial_test_tc_links_dev_chain0(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
 	int err, ifindex;
 
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	ASSERT_OK(system("ip link add dev foo type veth peer name bar"), "add veth");
 	ifindex = if_nametoindex("foo");
 	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
@@ -1846,6 +1960,7 @@ void serial_test_tc_links_dev_chain0(void)
 	ASSERT_OK(system("ip link del dev foo"), "del veth");
 	ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
 	ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
+	netns_free(ns);
 }
 
 static void test_tc_links_dev_mixed(int target)
@@ -1957,6 +2072,15 @@ static void test_tc_links_dev_mixed(int target)
 
 void serial_test_tc_links_dev_mixed(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_links_dev_mixed(BPF_TCX_INGRESS);
 	test_tc_links_dev_mixed(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index f77f604389aabbc7afb71ac003dc952cba82c460..d38376244532026b2b3d505bcf9711c8e7948e17 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -6,6 +6,8 @@
 
 #define loopback 1
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
+#define NS_NAME_MAX_LEN 32
+#define NS_NAME "ns-tc-opts-"
 
 #include "test_tc_link.skel.h"
 #include "tc_helpers.h"
@@ -15,11 +17,17 @@ void serial_test_tc_opts_basic(void)
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
 	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
 	__u32 fd1, fd2, id1, id2;
 	struct test_tc_link *skel;
+	struct netns_obj *ns;
 	__u32 prog_ids[2];
 	int err;
 
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	skel = test_tc_link__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;
@@ -106,6 +114,7 @@ void serial_test_tc_opts_basic(void)
 
 cleanup:
 	test_tc_link__destroy(skel);
+	netns_free(ns);
 }
 
 static void test_tc_opts_before_target(int target)
@@ -256,8 +265,17 @@ static void test_tc_opts_before_target(int target)
 
 void serial_test_tc_opts_before(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_before_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_after_target(int target)
@@ -447,8 +465,17 @@ static void test_tc_opts_after_target(int target)
 
 void serial_test_tc_opts_after(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_after_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_revision_target(int target)
@@ -556,8 +583,17 @@ static void test_tc_opts_revision_target(int target)
 
 void serial_test_tc_opts_revision(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_revision_target(BPF_TCX_INGRESS);
 	test_tc_opts_revision_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_chain_classic(int target, bool chain_tc_old)
@@ -657,10 +693,19 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 void serial_test_tc_opts_chain_classic(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
 	test_tc_chain_classic(BPF_TCX_INGRESS, true);
 	test_tc_chain_classic(BPF_TCX_EGRESS, true);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_replace_target(int target)
@@ -866,8 +911,17 @@ static void test_tc_opts_replace_target(int target)
 
 void serial_test_tc_opts_replace(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_replace_target(BPF_TCX_INGRESS);
 	test_tc_opts_replace_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_invalid_target(int target)
@@ -1019,8 +1073,17 @@ static void test_tc_opts_invalid_target(int target)
 
 void serial_test_tc_opts_invalid(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_invalid_target(BPF_TCX_INGRESS);
 	test_tc_opts_invalid_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_prepend_target(int target)
@@ -1159,8 +1222,17 @@ static void test_tc_opts_prepend_target(int target)
 
 void serial_test_tc_opts_prepend(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_prepend_target(BPF_TCX_INGRESS);
 	test_tc_opts_prepend_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_append_target(int target)
@@ -1299,8 +1371,17 @@ static void test_tc_opts_append_target(int target)
 
 void serial_test_tc_opts_append(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_append_target(BPF_TCX_INGRESS);
 	test_tc_opts_append_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_dev_cleanup_target(int target)
@@ -1389,8 +1470,17 @@ static void test_tc_opts_dev_cleanup_target(int target)
 
 void serial_test_tc_opts_dev_cleanup(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_opts_dev_cleanup_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_mixed_target(int target)
@@ -1565,8 +1655,17 @@ static void test_tc_opts_mixed_target(int target)
 
 void serial_test_tc_opts_mixed(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_mixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_mixed_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_demixed_target(int target)
@@ -1644,8 +1743,17 @@ static void test_tc_opts_demixed_target(int target)
 
 void serial_test_tc_opts_demixed(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_demixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_demixed_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_detach_target(int target)
@@ -1815,8 +1923,17 @@ static void test_tc_opts_detach_target(int target)
 
 void serial_test_tc_opts_detach(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_detach_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_detach_before_target(int target)
@@ -2022,8 +2139,17 @@ static void test_tc_opts_detach_before_target(int target)
 
 void serial_test_tc_opts_detach_before(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_detach_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_before_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_detach_after_target(int target)
@@ -2238,8 +2364,17 @@ static void test_tc_opts_detach_after_target(int target)
 
 void serial_test_tc_opts_detach_after(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_detach_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_after_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
@@ -2267,10 +2402,19 @@ static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
 
 void serial_test_tc_opts_delete_empty(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_delete_empty(BPF_TCX_INGRESS, false);
 	test_tc_opts_delete_empty(BPF_TCX_EGRESS, false);
 	test_tc_opts_delete_empty(BPF_TCX_INGRESS, true);
 	test_tc_opts_delete_empty(BPF_TCX_EGRESS, true);
+
+	netns_free(ns);
 }
 
 static void test_tc_chain_mixed(int target)
@@ -2374,8 +2518,17 @@ static void test_tc_chain_mixed(int target)
 
 void serial_test_tc_opts_chain_mixed(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static int generate_dummy_prog(void)
@@ -2448,6 +2601,13 @@ static void test_tc_opts_max_target(int target, int flags, bool relative)
 
 void serial_test_tc_opts_max(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_max_target(BPF_TCX_INGRESS, 0, false);
 	test_tc_opts_max_target(BPF_TCX_EGRESS, 0, false);
 
@@ -2456,6 +2616,8 @@ void serial_test_tc_opts_max(void)
 
 	test_tc_opts_max_target(BPF_TCX_INGRESS, BPF_F_AFTER, true);
 	test_tc_opts_max_target(BPF_TCX_EGRESS, BPF_F_AFTER, false);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_query_target(int target)
@@ -2750,8 +2912,17 @@ static void test_tc_opts_query_target(int target)
 
 void serial_test_tc_opts_query(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_query_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }
 
 static void test_tc_opts_query_attach_target(int target)
@@ -2809,6 +2980,15 @@ static void test_tc_opts_query_attach_target(int target)
 
 void serial_test_tc_opts_query_attach(void)
 {
+	char ns_name[NS_NAME_MAX_LEN] = NS_NAME;
+	struct netns_obj *ns;
+
+	ns = create_and_open_tid_ns(ns_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK_PTR(ns, "create and open ns"))
+		return;
+
 	test_tc_opts_query_attach_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_attach_target(BPF_TCX_EGRESS);
+
+	netns_free(ns);
 }

-- 
2.48.1


