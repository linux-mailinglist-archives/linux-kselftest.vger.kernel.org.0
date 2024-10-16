Return-Path: <linux-kselftest+bounces-19861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6AD9A11AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FFB283DD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345692144CC;
	Wed, 16 Oct 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MhxcGZwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CC18C33E;
	Wed, 16 Oct 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103751; cv=none; b=obRH5sS942HldLo83wV6a9/oQ81zxqLfR1iNlCabtS+tyB4krX4gL0skIgm/aPLvrkL2wiiGzebrKhcsgKPAXg78kwiMP2E9DArq0xmRr1DQ6W7K4eoNSe21fVfbsvzzawMCJlN+akHlh4/fN7Gz19m+zWaXo8+TCU6lmhNei+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103751; c=relaxed/simple;
	bh=VJuIl+avj3mIVVRSplXNtVjEq/MYsFRwopirnjoJCbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G186VQsrO4FUTUwUaWGOgVdVTSqnBk2a1EKXWv/N8w8/EoQqEUP1RgP9yYCPP4XuvQCoTKKpqv2OG/iL7wZ5WYE9tYNdPtu/pufjbtjTXlDkPniS+igK5fakF6WrTBH4VCa2m0X3i6P942/cpq1UTYt0dUUJHM1fJp0t7y0exdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MhxcGZwi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF3A8C0006;
	Wed, 16 Oct 2024 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729103747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOXwSc5wYAokVZg2BYBKgISgzuQIRqta0EKOkbceqLY=;
	b=MhxcGZwi5dxAO1w6rYLLbXgYiC/sIhB8xXuuiZQeLnWwz+C8Qm5XfRxl26svbID0g0b8Zt
	OYfCbgw+WDedLx8CmnZMHtCWmLp/7cz/Bpkf95W42ZZuJe+u7Esz4GREg3QyJ1SRtJ7Nlv
	dYnvAvgpxlePFNlLjn+d5KDaQ64xXPgWj/yEijimuUwywxLZvO88pBrUGNFBKIp+D/KfHq
	LdM3MeHLu6eAB9n8+o1R0mvPGiGGOLKc0CRhkOwidEiYQbrZQ++YCfbXckhVCSVVfunxTH
	TZDaC1nKu2W/V8td2hBWqJrPFyYpqR82GHkitrgmIaCyovKlf+E2MDz5D7UN4g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 16 Oct 2024 20:35:23 +0200
Subject: [PATCH bpf-next 2/6] selftests/bpf: add missing ns cleanups in
 btf_skc_cls_ingress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-syncookie-v1-2-3b7a0de12153@bootlin.com>
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
In-Reply-To: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

btf_skc_cls_ingress.c currently runs two subtests, and create a
dedicated network namespace for each, but never cleans up the created
namespace once the test has ended.

Add missing namespace cleanup after each namespace to avoid accumulating
namespaces for each new subtest. While at it, switch namespace
management to netns_{new,free}

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 31 ++++++++++++++--------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 5d8d7736edc095b647ca3fbc12cac0440b60140e..8d1fa8806cdda088d264b44104f7c80726b025e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -17,32 +17,34 @@
 #include "test_progs.h"
 #include "test_btf_skc_cls_ingress.skel.h"
 
+#define TEST_NS "skc_cls_ingress"
+
 static struct test_btf_skc_cls_ingress *skel;
 static struct sockaddr_in6 srv_sa6;
 static __u32 duration;
 
-static int prepare_netns(void)
+static struct netns_obj *prepare_netns(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
 		    .prog_fd = bpf_program__fd(skel->progs.cls_ingress));
+	struct netns_obj *ns = NULL;
 
-	if (CHECK(unshare(CLONE_NEWNET), "create netns",
-		  "unshare(CLONE_NEWNET): %s (%d)",
-		  strerror(errno), errno))
-		return -1;
+	ns = netns_new(TEST_NS, true);
+	if (!ASSERT_OK_PTR(ns, "create and join netns"))
+		return ns;
 
 	if (CHECK(system("ip link set dev lo up"),
 		  "ip link set dev lo up", "failed\n"))
-		return -1;
+		goto free_ns;
 
 	qdisc_lo.ifindex = if_nametoindex("lo");
 	if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo clsact"))
-		return -1;
+		goto free_ns;
 
 	if (!ASSERT_OK(bpf_tc_attach(&qdisc_lo, &tc_attach),
 		       "filter add dev lo ingress"))
-		return -1;
+		goto free_ns;
 
 	/* Ensure 20 bytes options (i.e. in total 40 bytes tcp header) for the
 	 * bpf_tcp_gen_syncookie() helper.
@@ -50,9 +52,13 @@ static int prepare_netns(void)
 	if (write_sysctl("/proc/sys/net/ipv4/tcp_window_scaling", "1") ||
 	    write_sysctl("/proc/sys/net/ipv4/tcp_timestamps", "1") ||
 	    write_sysctl("/proc/sys/net/ipv4/tcp_sack", "1"))
-		return -1;
+		goto free_ns;
+
+	return ns;
 
-	return 0;
+free_ns:
+	netns_free(ns);
+	return NULL;
 }
 
 static void reset_test(void)
@@ -169,6 +175,7 @@ void test_btf_skc_cls_ingress(void)
 	int i;
 
 	skel = test_btf_skc_cls_ingress__open_and_load();
+	struct netns_obj *ns;
 	if (CHECK(!skel, "test_btf_skc_cls_ingress__open_and_load", "failed\n"))
 		return;
 
@@ -176,13 +183,15 @@ void test_btf_skc_cls_ingress(void)
 		if (!test__start_subtest(tests[i].desc))
 			continue;
 
-		if (prepare_netns())
+		ns = prepare_netns();
+		if (!ns)
 			break;
 
 		tests[i].run();
 
 		print_err_line();
 		reset_test();
+		netns_free(ns);
 	}
 
 	test_btf_skc_cls_ingress__destroy(skel);

-- 
2.46.2


