Return-Path: <linux-kselftest+bounces-26979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CAA3C2B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F591884C2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DC1F4635;
	Wed, 19 Feb 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jCyUpUU3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EE1DE3C8;
	Wed, 19 Feb 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976789; cv=none; b=DMDxO5G40FU2KGE4oN6BFj5AQrMsys+fTei9LeYTQ5n+uGbQn+SWy+wrreEqh4Q7WvgC8AOToLn5Pz2In4Qe75Lvo0FUCP6LaVfVHaI7r3ZuYl8ObGlXOZmV+XQXuaBOT3nBO5f6e/J2FoFa5IBWdbxKzfTdEVwnLItubTbDmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976789; c=relaxed/simple;
	bh=5NlbgLVbXwNqDHFBrPOG58MApB3K1XJWatoVAt/J1fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j74X6WJ0hiyjHtxycxb7rWUjjuy5hPf6BqcpNOL/uAfzGA7EP2KCsZ8uu8axztG6DGfv6Ff3LLYysREFiu2vsooEwlL+2iYXqB9GvDGlAaHkDN97cA409YiTuakLOrvdt25dUUMyjLQ2484/CG0/o6NuQmlz7UlljnZzsZRYgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jCyUpUU3; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AED4204DB;
	Wed, 19 Feb 2025 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739976785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9FWmaIoJdpj9qH99xrn+joTAMFOYOWp3cJ8oH+lKlg=;
	b=jCyUpUU3yU2K+v5Q8MUIEPNlUG6WnOxuHUmJ8htU/AzxEF8ZgoX+b4DF8Bp3KyxK6GTwsM
	1aFpkIsQwIEvErPfW7d3zYoRRzC1tP20ZXJpqIYLtZCkZNSnkSq514ylxCgg0OCyA353Xp
	6cBzbIOci1ZIK2u/r/3ofK6tPqrEYJpM29tcTUb/Afdn/XMRWNNZ0PRgs9CqTPbEZ1QFNh
	C4vyTLt1oFHU2HoFssPaoRI2F6ENUtAkZREiigwde50To0suCwcyAF6dIuTSe+Q+ExsJjb
	1/aMYunrBGjROi6B/wO25+lRUdJKxFaE3iq9w+bH1qQtdfIah7FBBrD6p++h/w==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 19 Feb 2025 15:53:02 +0100
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: tc_links/tc_opts:
 Unserialize tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-tc_links-v2-3-14504db136b7@bootlin.com>
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhon
 hhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Tests are serialized because they all use the loopback interface.

Replace the 'serial_test_' prefixes with 'test_ns_' to benefit from the
new test_prog feature which creates a dedicated namespace for each test,
allowing them to run in parallel.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_links.c | 28 ++++++++--------
 tools/testing/selftests/bpf/prog_tests/tc_opts.c  | 40 +++++++++++------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 1af9ec1149aab6ca5ef6986fc16a650162266966..2186a24e7d8a948840532f9bb6263f68985583c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -13,7 +13,7 @@
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
 
-void serial_test_tc_links_basic(void)
+void test_ns_tc_links_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_query_opts, optq);
 	LIBBPF_OPTS(bpf_tcx_opts, optl);
@@ -260,7 +260,7 @@ static void test_tc_links_before_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_before(void)
+void test_ns_tc_links_before(void)
 {
 	test_tc_links_before_target(BPF_TCX_INGRESS);
 	test_tc_links_before_target(BPF_TCX_EGRESS);
@@ -414,7 +414,7 @@ static void test_tc_links_after_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_after(void)
+void test_ns_tc_links_after(void)
 {
 	test_tc_links_after_target(BPF_TCX_INGRESS);
 	test_tc_links_after_target(BPF_TCX_EGRESS);
@@ -514,7 +514,7 @@ static void test_tc_links_revision_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_revision(void)
+void test_ns_tc_links_revision(void)
 {
 	test_tc_links_revision_target(BPF_TCX_INGRESS);
 	test_tc_links_revision_target(BPF_TCX_EGRESS);
@@ -618,7 +618,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_chain_classic(void)
+void test_ns_tc_links_chain_classic(void)
 {
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
@@ -846,7 +846,7 @@ static void test_tc_links_replace_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_replace(void)
+void test_ns_tc_links_replace(void)
 {
 	test_tc_links_replace_target(BPF_TCX_INGRESS);
 	test_tc_links_replace_target(BPF_TCX_EGRESS);
@@ -1158,7 +1158,7 @@ static void test_tc_links_invalid_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_invalid(void)
+void test_ns_tc_links_invalid(void)
 {
 	test_tc_links_invalid_target(BPF_TCX_INGRESS);
 	test_tc_links_invalid_target(BPF_TCX_EGRESS);
@@ -1314,7 +1314,7 @@ static void test_tc_links_prepend_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_prepend(void)
+void test_ns_tc_links_prepend(void)
 {
 	test_tc_links_prepend_target(BPF_TCX_INGRESS);
 	test_tc_links_prepend_target(BPF_TCX_EGRESS);
@@ -1470,7 +1470,7 @@ static void test_tc_links_append_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_append(void)
+void test_ns_tc_links_append(void)
 {
 	test_tc_links_append_target(BPF_TCX_INGRESS);
 	test_tc_links_append_target(BPF_TCX_EGRESS);
@@ -1568,7 +1568,7 @@ static void test_tc_links_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_cleanup(void)
+void test_ns_tc_links_dev_cleanup(void)
 {
 	test_tc_links_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_links_dev_cleanup_target(BPF_TCX_EGRESS);
@@ -1672,7 +1672,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_links_chain_mixed(void)
+void test_ns_tc_links_chain_mixed(void)
 {
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
@@ -1782,7 +1782,7 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_ingress(void)
+void test_ns_tc_links_ingress(void)
 {
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, true);
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, false);
@@ -1823,7 +1823,7 @@ static int qdisc_replace(int ifindex, const char *kind, bool block)
 	return err;
 }
 
-void serial_test_tc_links_dev_chain0(void)
+void test_ns_tc_links_dev_chain0(void)
 {
 	int err, ifindex;
 
@@ -1955,7 +1955,7 @@ static void test_tc_links_dev_mixed(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_mixed(void)
+void test_ns_tc_links_dev_mixed(void)
 {
 	test_tc_links_dev_mixed(BPF_TCX_INGRESS);
 	test_tc_links_dev_mixed(BPF_TCX_EGRESS);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index f77f604389aabbc7afb71ac003dc952cba82c460..dd7a138d8c3dcef0db4d9e6831951db5306c0c04 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -10,7 +10,7 @@
 #include "test_tc_link.skel.h"
 #include "tc_helpers.h"
 
-void serial_test_tc_opts_basic(void)
+void test_ns_tc_opts_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
@@ -254,7 +254,7 @@ static void test_tc_opts_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_before(void)
+void test_ns_tc_opts_before(void)
 {
 	test_tc_opts_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_before_target(BPF_TCX_EGRESS);
@@ -445,7 +445,7 @@ static void test_tc_opts_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_after(void)
+void test_ns_tc_opts_after(void)
 {
 	test_tc_opts_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_after_target(BPF_TCX_EGRESS);
@@ -554,7 +554,7 @@ static void test_tc_opts_revision_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_revision(void)
+void test_ns_tc_opts_revision(void)
 {
 	test_tc_opts_revision_target(BPF_TCX_INGRESS);
 	test_tc_opts_revision_target(BPF_TCX_EGRESS);
@@ -655,7 +655,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_chain_classic(void)
+void test_ns_tc_opts_chain_classic(void)
 {
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
@@ -864,7 +864,7 @@ static void test_tc_opts_replace_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_replace(void)
+void test_ns_tc_opts_replace(void)
 {
 	test_tc_opts_replace_target(BPF_TCX_INGRESS);
 	test_tc_opts_replace_target(BPF_TCX_EGRESS);
@@ -1017,7 +1017,7 @@ static void test_tc_opts_invalid_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_invalid(void)
+void test_ns_tc_opts_invalid(void)
 {
 	test_tc_opts_invalid_target(BPF_TCX_INGRESS);
 	test_tc_opts_invalid_target(BPF_TCX_EGRESS);
@@ -1157,7 +1157,7 @@ static void test_tc_opts_prepend_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_prepend(void)
+void test_ns_tc_opts_prepend(void)
 {
 	test_tc_opts_prepend_target(BPF_TCX_INGRESS);
 	test_tc_opts_prepend_target(BPF_TCX_EGRESS);
@@ -1297,7 +1297,7 @@ static void test_tc_opts_append_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_append(void)
+void test_ns_tc_opts_append(void)
 {
 	test_tc_opts_append_target(BPF_TCX_INGRESS);
 	test_tc_opts_append_target(BPF_TCX_EGRESS);
@@ -1387,7 +1387,7 @@ static void test_tc_opts_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_dev_cleanup(void)
+void test_ns_tc_opts_dev_cleanup(void)
 {
 	test_tc_opts_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_opts_dev_cleanup_target(BPF_TCX_EGRESS);
@@ -1563,7 +1563,7 @@ static void test_tc_opts_mixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_mixed(void)
+void test_ns_tc_opts_mixed(void)
 {
 	test_tc_opts_mixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_mixed_target(BPF_TCX_EGRESS);
@@ -1642,7 +1642,7 @@ static void test_tc_opts_demixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_demixed(void)
+void test_ns_tc_opts_demixed(void)
 {
 	test_tc_opts_demixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_demixed_target(BPF_TCX_EGRESS);
@@ -1813,7 +1813,7 @@ static void test_tc_opts_detach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach(void)
+void test_ns_tc_opts_detach(void)
 {
 	test_tc_opts_detach_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_target(BPF_TCX_EGRESS);
@@ -2020,7 +2020,7 @@ static void test_tc_opts_detach_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_before(void)
+void test_ns_tc_opts_detach_before(void)
 {
 	test_tc_opts_detach_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_before_target(BPF_TCX_EGRESS);
@@ -2236,7 +2236,7 @@ static void test_tc_opts_detach_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_after(void)
+void test_ns_tc_opts_detach_after(void)
 {
 	test_tc_opts_detach_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_after_target(BPF_TCX_EGRESS);
@@ -2265,7 +2265,7 @@ static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_delete_empty(void)
+void test_ns_tc_opts_delete_empty(void)
 {
 	test_tc_opts_delete_empty(BPF_TCX_INGRESS, false);
 	test_tc_opts_delete_empty(BPF_TCX_EGRESS, false);
@@ -2372,7 +2372,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_chain_mixed(void)
+void test_ns_tc_opts_chain_mixed(void)
 {
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
@@ -2446,7 +2446,7 @@ static void test_tc_opts_max_target(int target, int flags, bool relative)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_max(void)
+void test_ns_tc_opts_max(void)
 {
 	test_tc_opts_max_target(BPF_TCX_INGRESS, 0, false);
 	test_tc_opts_max_target(BPF_TCX_EGRESS, 0, false);
@@ -2748,7 +2748,7 @@ static void test_tc_opts_query_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query(void)
+void test_ns_tc_opts_query(void)
 {
 	test_tc_opts_query_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_target(BPF_TCX_EGRESS);
@@ -2807,7 +2807,7 @@ static void test_tc_opts_query_attach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query_attach(void)
+void test_ns_tc_opts_query_attach(void)
 {
 	test_tc_opts_query_attach_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_attach_target(BPF_TCX_EGRESS);

-- 
2.48.1


