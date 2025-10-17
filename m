Return-Path: <linux-kselftest+bounces-43380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B207ABE9314
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3ECA1AA2BF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261D32C922;
	Fri, 17 Oct 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rpws1Ofz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A833971D;
	Fri, 17 Oct 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711371; cv=none; b=lwYid1cIilAJfRxIOmqhIsAFFcesJktc/S4HdufZXlEHl5aoQaMUx7O9/9u3piMimNUkZWHkhmXPPPinzfnV9oQi8oSIMmEfUdiE2Celvg02jqac3FlMgoanEEKhscTZriO+Nruk8P3Su7VvcOL4dqr8c7v4cmFAFxufe9/VIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711371; c=relaxed/simple;
	bh=A2+BJQdJspIyjnNBD71p9D8fyy524nUvFg+SCj57TrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UikQKEXZKm6JeEZJwxoiQtfqMI7w6yjPCXDrX3p0GdITRSmjXSMfpiEP3q8Nw6qIJWsx2PGd06HOw+s266DHW6wn99bC7MJwKt2SoA1eI7cVgkKRIrBILEa4Es0LuHcKJmRCByfaOqgUxbwTf4+p/xwXwVQx8qHPxRRsKyhFwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rpws1Ofz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 270ECC041F6;
	Fri, 17 Oct 2025 14:29:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 726A0606DB;
	Fri, 17 Oct 2025 14:29:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F62A102F2360;
	Fri, 17 Oct 2025 16:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+kMT0CW26KM6Xux1l6FI4PsWmscMwn2T30Z7fSdtkGQ=;
	b=rpws1OfzgTFLudMoQLjznKzPUq8gcS19MYwFkhNqS/UPM574FSKu6QUUkTrGnLvlfiC9c8
	VYiixTnhrXRmYHk46JTDB/C1OpjiPfS+1DRhCXaATs5cF9MfWmwUYKj8AtoNx+Ok9txkuR
	WygzfBdOvWCyydAzmxic1jr7E6rB/K8/LA6D+88XgfqfGbVXbLc+7TMVgNcZV3hu8ByHoe
	/208UkIy0oBwyN2dI6S51T8YugcXcjYomirmB+HjvjyfbBjGru0uKNAbbFNHhm/UxoxsmX
	XzsYkCJ07xoUo0Gt9a2OJz2jZqfMRQSiGCR8Jt6ggbcXlIIZubXnf+TiEWYD1Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 17 Oct 2025 16:29:01 +0200
Subject: [PATCH bpf-next 1/5] testing/selftests: rename tc_helpers.h to
 tcx_helpers.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-tc_tunnel-v1-1-2d86808d86b2@bootlin.com>
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
In-Reply-To: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The test_tunnel.c file  defines some convenient functions to create a qdisc
and attach bpf programs to it. It would be beneficial to new tests to
get those functions exported as helpers in a tc_helpers.h. There is
however already a tc_helpers.h file in the BPF selftests, used by a few
tests. This header is quite coupled to some BPF programs (some exposed
helpers consume a skeleton from some specific BPF programs), so rename
it to something more related to its original purpose.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 46 +++++++++++-----------
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c | 22 +++++------
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 40 +++++++++----------
 .../bpf/prog_tests/{tc_helpers.h => tcx_helpers.h} |  6 +--
 4 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 2186a24e7d8a948840532f9bb6263f68985583c8..aa61d1d27dc9dcc5ba1e2ec628f0b12382528b4b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -11,7 +11,7 @@
 #include "test_tc_link.skel.h"
 
 #include "netlink_helpers.h"
-#include "tc_helpers.h"
+#include "tcx_helpers.h"
 
 void test_ns_tc_links_basic(void)
 {
@@ -67,7 +67,7 @@ void test_ns_tc_links_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -100,7 +100,7 @@ void test_ns_tc_links_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -191,7 +191,7 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -248,7 +248,7 @@ static void test_tc_links_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -345,7 +345,7 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -402,7 +402,7 @@ static void test_tc_links_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -504,7 +504,7 @@ static void test_tc_links_revision_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -584,7 +584,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 2);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -597,7 +597,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -708,7 +708,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -779,7 +779,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -807,7 +807,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -835,7 +835,7 @@ static void test_tc_links_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1247,7 +1247,7 @@ static void test_tc_links_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1302,7 +1302,7 @@ static void test_tc_links_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1403,7 +1403,7 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1458,7 +1458,7 @@ static void test_tc_links_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 	ASSERT_EQ(optq.link_ids[4], 0, "link_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1628,7 +1628,7 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
@@ -1641,7 +1641,7 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
@@ -1654,7 +1654,7 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 0);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
@@ -1744,7 +1744,7 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 
 	assert_mprog_count(target, 2);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1757,7 +1757,7 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 2461d183dee584297f68df19b3c28cb52118bc59..ed52d1ece42ed8fe4edf4be36fd8558b6440f72c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -12,7 +12,7 @@
 
 #include "test_tc_link.skel.h"
 #include "netlink_helpers.h"
-#include "tc_helpers.h"
+#include "tcx_helpers.h"
 
 #define NETKIT_HEADROOM	32
 #define NETKIT_TAILROOM	8
@@ -252,7 +252,7 @@ void serial_test_tc_netkit_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -285,7 +285,7 @@ void serial_test_tc_netkit_basic(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -366,7 +366,7 @@ static void serial_test_tc_netkit_multi_links_target(int mode, int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -406,7 +406,7 @@ static void serial_test_tc_netkit_multi_links_target(int mode, int target)
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -481,7 +481,7 @@ static void serial_test_tc_netkit_multi_opts_target(int mode, int target)
 	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -512,7 +512,7 @@ static void serial_test_tc_netkit_multi_opts_target(int mode, int target)
 	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -616,7 +616,7 @@ void serial_test_tc_netkit_device(void)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -716,7 +716,7 @@ static void serial_test_tc_netkit_neigh_links_target(int mode, int target)
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(__send_icmp(ping_addr_noneigh), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc1, true /* L2: ARP */, "seen_tc1");
@@ -787,7 +787,7 @@ static void serial_test_tc_netkit_pkt_type_mode(int mode)
 
 	move_netkit();
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	skel->bss->set_type = true;
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
@@ -847,7 +847,7 @@ static void serial_test_tc_netkit_scrub_type(int scrub, bool room)
 	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PRIMARY, 1);
 	assert_mprog_count_ifindex(ifindex, BPF_NETKIT_PEER, 0);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
 
 	ASSERT_EQ(skel->bss->seen_tc8, true, "seen_tc8");
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index dd7a138d8c3dcef0db4d9e6831951db5306c0c04..bae33c8b5c06469405726aa9682c9be701c401f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -8,7 +8,7 @@
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 #include "test_tc_link.skel.h"
-#include "tc_helpers.h"
+#include "tcx_helpers.h"
 
 void test_ns_tc_opts_basic(void)
 {
@@ -59,7 +59,7 @@ void test_ns_tc_opts_basic(void)
 	ASSERT_EQ(optq.prog_ids[0], id1, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -84,7 +84,7 @@ void test_ns_tc_opts_basic(void)
 	ASSERT_EQ(optq.prog_ids[0], id2, "prog_ids[0]");
 	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -165,7 +165,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -222,7 +222,7 @@ static void test_tc_opts_before_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id2, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -317,7 +317,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -374,7 +374,7 @@ static void test_tc_opts_after_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -520,7 +520,7 @@ static void test_tc_opts_revision_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -615,7 +615,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 2);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -628,7 +628,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -735,7 +735,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_attach_flags[1], 0, "prog_flags[1]");
 	ASSERT_EQ(optq.prog_attach_flags[2], 0, "prog_flags[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -769,7 +769,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -804,7 +804,7 @@ static void test_tc_opts_replace_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1084,7 +1084,7 @@ static void test_tc_opts_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id1, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1125,7 +1125,7 @@ static void test_tc_opts_prepend_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id1, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1224,7 +1224,7 @@ static void test_tc_opts_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[1], id2, "prog_ids[1]");
 	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -1265,7 +1265,7 @@ static void test_tc_opts_append_target(int target)
 	ASSERT_EQ(optq.prog_ids[3], id4, "prog_ids[3]");
 	ASSERT_EQ(optq.prog_ids[4], 0, "prog_ids[4]");
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
@@ -2320,7 +2320,7 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
@@ -2340,7 +2340,7 @@ static void test_tc_chain_mixed(int target)
 
 	assert_mprog_count(target, 1);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
@@ -2352,7 +2352,7 @@ static void test_tc_chain_mixed(int target)
 	ASSERT_OK(err, "prog_detach");
 	assert_mprog_count(target, 0);
 
-	tc_skel_reset_all_seen(skel);
+	tcx_skel_reset_all_seen(skel);
 	ASSERT_OK(system(ping_cmd), ping_cmd);
 
 	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tcx_helpers.h
similarity index 90%
rename from tools/testing/selftests/bpf/prog_tests/tc_helpers.h
rename to tools/testing/selftests/bpf/prog_tests/tcx_helpers.h
index d52a62af77bff9e9bdb54c7bd1061fc162610680..05f5386f4f989f441016eed19bd01d25a5dfd2e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tcx_helpers.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2023 Isovalent */
-#ifndef TC_HELPERS
-#define TC_HELPERS
+#ifndef TCX_HELPERS
+#define TCX_HELPERS
 #include <test_progs.h>
 
 #ifndef loopback
@@ -42,7 +42,7 @@ static inline void assert_mprog_count_ifindex(int ifindex, int target, int expec
 	__assert_mprog_count(target, expected, ifindex);
 }
 
-static inline void tc_skel_reset_all_seen(struct test_tc_link *skel)
+static inline void tcx_skel_reset_all_seen(struct test_tc_link *skel)
 {
 	memset(skel->bss, 0, sizeof(*skel->bss));
 }

-- 
2.51.0


