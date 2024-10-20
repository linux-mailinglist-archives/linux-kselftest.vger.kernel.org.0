Return-Path: <linux-kselftest+bounces-20223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26299A5615
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F1F1F22037
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133A198A39;
	Sun, 20 Oct 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ak9oM2U6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F3194AEF;
	Sun, 20 Oct 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452198; cv=none; b=ev/4XPMSU8EFS4TRH//qVw4l3KR1nQO0ayRDF/nft3F12HcCtVbFVVGDNfxMr+8gCSzCR1gbasTGwwIyBIjH6St4w/CMjBdiwwS77malq0aiFIB2y71PfObRMIgrP+GFzs2slcQdiBcUNi9z5pbEYFH4Ze7M9ZlO4a+1a7O4zi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452198; c=relaxed/simple;
	bh=wz9PJsLLUbmr/HE8nvXkiEUh9OfFFPwNBZQ8P+LzMVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI7BEVVTAX2qybWeDi/uaVaLs+/Ky5bxKVGLxrb+ejxQNcqwULYbQYyuY3D0XHM1tZQ+BFxAORjcinmq7wOVHSZ/YC225fRxYSAHE/wx8lSJRjc4WWasz2wu4dhFaIkBmHXht7RxO8mTdHtuQm877Qbg4HX74sFd9SNis4DPd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ak9oM2U6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5632F240008;
	Sun, 20 Oct 2024 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyh5DMLy0yZvA/x/k9jCnet9GEiLYSrWjqf2wFa2L8U=;
	b=ak9oM2U6rh3IOZCL71V7v/YhJLLcYc9E/h3QF2/wqhRCwA0fhn+fcbyo4gOSGnhic9I7ot
	zTuAYvmMO5x5ljLns4aiW3d6oIRHMZc0Y4V4Yws7x2H8kTXQ6+KBtSp2U6AZulTbiZ+QOm
	eUISdSbSas8zzSqRHxTXLeUsQpDPjUYpWRIMgFO4JGYMOTGChr97TQO34QXV/yJugrmS8i
	0XQnv9CxLVMv9Bsqen5e/l1iv0BJL59I7xJztN652eQK85cGDEBt7nMuq/v3eMTNmwjmYl
	DHrtB902zxIYkbxRHeWbDviZUvQBiSnI+e1CwVQE7ZK5Z0Bsqg1eDUlmdKhOyQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:54 +0200
Subject: [PATCH bpf-next v2 2/6] selftests/bpf: add missing ns cleanups in
 btf_skc_cls_ingress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-2-2db240225fed@bootlin.com>
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
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
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

btf_skc_cls_ingress.c currently runs two subtests, and create a
dedicated network namespace for each, but never cleans up the created
namespace once the test has ended.

Add missing namespace cleanup after each subtest to avoid accumulating
namespaces for each new subtest. While at it, switch namespace
management to netns_{new,free}

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- slightly reword commit message to fix mistake
- remove `ip link set lo up` in dedicated ns, handled by netns_new
---
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 33 +++++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 5d8d7736edc095b647ca3fbc12cac0440b60140e..c88fb0e3048c81a09cf4b0b9df434cf8d4c6ff33 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -17,32 +17,30 @@
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
-
-	if (CHECK(system("ip link set dev lo up"),
-		  "ip link set dev lo up", "failed\n"))
-		return -1;
+	ns = netns_new(TEST_NS, true);
+	if (!ASSERT_OK_PTR(ns, "create and join netns"))
+		return ns;
 
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
@@ -50,9 +48,13 @@ static int prepare_netns(void)
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
@@ -169,6 +171,7 @@ void test_btf_skc_cls_ingress(void)
 	int i;
 
 	skel = test_btf_skc_cls_ingress__open_and_load();
+	struct netns_obj *ns;
 	if (CHECK(!skel, "test_btf_skc_cls_ingress__open_and_load", "failed\n"))
 		return;
 
@@ -176,13 +179,15 @@ void test_btf_skc_cls_ingress(void)
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
2.47.0


