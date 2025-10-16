Return-Path: <linux-kselftest+bounces-43306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C2BE2054
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784DC1A60FB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1F3191AE;
	Thu, 16 Oct 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pbtYUHMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A593176F4;
	Thu, 16 Oct 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600785; cv=none; b=QzI1amSKpuI1EV57C5hv5XG0g3LbgMN/frOtuuFJ4yevrBPmjD2RO6zRbsXV3c2pxLM1hB1t5xYIK+fdRscXj60eFheaM+rvFJUG2F4ZhDUAwWsEesYrI17W8tt/9meTZ5KS6O6Y/drlkoSdeuMLesaHITW17x6vImEQl9eI5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600785; c=relaxed/simple;
	bh=ybFBMDeQr/H42za1bFLg0laL8mJUzPF/f7ssoZRlt7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qa2tQPKNANZ0jDmtKJJwKH5OWi0n4M8oY9RRaG4CnvMSMKfC9dey+tUGTf5N4+LcX2hIXdcEJ1/hbDGuGhWktQExXyfx7OhYq3gLFqS6Psw7xpJukmTa2rODz1v1wJ0t5eGaFbNsJ6a232EpFOxUpCYwyinXEwX22sbV1rrU6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pbtYUHMt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7AD404E410F3;
	Thu, 16 Oct 2025 07:46:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 505B66062C;
	Thu, 16 Oct 2025 07:46:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE78D102F22AA;
	Thu, 16 Oct 2025 09:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jbRm5/lGK67wKeRqbvttbixXDU6tGc155EFWQRJz5xE=;
	b=pbtYUHMtQEgp98/I8ozqgABqKTjp1iLHtvKdJl3a3UrczjavcRWy2O345UIqA2xoTwWnlu
	liKLkue73qx4uS5d9pOVR53PucsRT68aDNRCAlBBzUvtuqAbr1XCE/mcRjKNqFAS4b8nLZ
	FH9M8CG6CjGWgzcovIxt9YiTPmd8uvYO0LUtfWvMhnFMRRRNt3M6/NdRTDefg26eLQs6/r
	d1wz1QhTOoyB2WW9LApdQhN39T3rsVBWjKqj/vyZRhj8OTWLYLm4/tcgYYk4i6tyuJSae0
	0S5hH2Kf+nrPEfoCWiWtiT+SUygE2aDZXIpZ3Fl0RV5kKJ8zG8TD/gHPehJCWg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:42 +0200
Subject: [PATCH bpf-next v5 13/15] selftests/bpf: test_xsk: Don't exit
 immediately on allocation failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-13-662c95eb8005@bootlin.com>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If any allocation in the pkt_stream_*() helpers fail, exit_with_error() is
called. This terminates the program immediately. It prevents the following
tests from running and isn't compliant with the CI.

Return NULL in case of allocation failure.
Return TEST_FAILURE when something goes wrong in the packet generation.
Clean up the resources if a failure happens between two steps of a test.

Move exit_with_error()'s definition into xskxceiver.c as it isn't used
anywhere else now.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c   | 136 +++++++++++++++++++++++--------
 tools/testing/selftests/bpf/test_xsk.h   |   7 --
 tools/testing/selftests/bpf/xskxceiver.c |   9 ++
 3 files changed, 110 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 18a6ce648461de1975aa25997a22c77cecb97a76..453b55463ee8dcd2738d6605752ad305532211b0 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -479,7 +479,7 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
 
 	pkt_stream = __pkt_stream_alloc(nb_pkts);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	pkt_stream->nb_pkts = nb_pkts;
 	pkt_stream->max_pkt_len = pkt_len;
@@ -503,37 +503,56 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
-static void pkt_stream_replace_ifobject(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
+static int pkt_stream_replace_ifobject(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
 {
 	ifobj->xsk->pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
+
+	if (!ifobj->xsk->pkt_stream)
+		return -ENOMEM;
+
+	return 0;
 }
 
-static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+static int pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
 {
-	pkt_stream_replace_ifobject(test->ifobj_tx, nb_pkts, pkt_len);
-	pkt_stream_replace_ifobject(test->ifobj_rx, nb_pkts, pkt_len);
+	int ret;
+
+	ret = pkt_stream_replace_ifobject(test->ifobj_tx, nb_pkts, pkt_len);
+	if (ret)
+		return ret;
+
+	return pkt_stream_replace_ifobject(test->ifobj_rx, nb_pkts, pkt_len);
 }
 
-static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
+static int __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
 				      int offset)
 {
 	struct pkt_stream *pkt_stream;
 	u32 i;
 
 	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
+	if (!pkt_stream)
+		return -ENOMEM;
+
 	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
 		pkt_stream_pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
 
 	ifobj->xsk->pkt_stream = pkt_stream;
+
+	return 0;
 }
 
-static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
+static int pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
 {
-	__pkt_stream_replace_half(test->ifobj_tx, pkt_len, offset);
-	__pkt_stream_replace_half(test->ifobj_rx, pkt_len, offset);
+	int ret = __pkt_stream_replace_half(test->ifobj_tx, pkt_len, offset);
+
+	if (ret)
+		return ret;
+
+	return __pkt_stream_replace_half(test->ifobj_rx, pkt_len, offset);
 }
 
-static void pkt_stream_receive_half(struct test_spec *test)
+static int pkt_stream_receive_half(struct test_spec *test)
 {
 	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
@@ -547,14 +566,19 @@ static void pkt_stream_receive_half(struct test_spec *test)
 
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
 							      pkt_stream->pkts[0].len);
+	if (!test->ifobj_rx->xsk->pkt_stream)
+		return -ENOMEM;
+
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 	for (i = 1; i < pkt_stream->nb_pkts; i += 2)
 		pkt_stream->pkts[i].valid = false;
 
 	pkt_stream->nb_valid_entries /= 2;
+
+	return 0;
 }
 
-static void pkt_stream_even_odd_sequence(struct test_spec *test)
+static int pkt_stream_even_odd_sequence(struct test_spec *test)
 {
 	struct pkt_stream *pkt_stream;
 	u32 i;
@@ -563,13 +587,19 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
 		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
 		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
 						   pkt_stream->pkts[0].len, i, 2);
+		if (!pkt_stream)
+			return -ENOMEM;
 		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
 
 		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
 		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
 						   pkt_stream->pkts[0].len, i, 2);
+		if (!pkt_stream)
+			return -ENOMEM;
 		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
 	}
+
+	return 0;
 }
 
 static void release_even_odd_sequence(struct test_spec *test)
@@ -628,7 +658,7 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 
 	pkt_stream = __pkt_stream_alloc(nb_frames);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	for (i = 0; i < nb_frames; i++) {
 		struct pkt *pkt = &pkt_stream->pkts[pkt_nb];
@@ -671,15 +701,21 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 	return pkt_stream;
 }
 
-static void pkt_stream_generate_custom(struct test_spec *test, struct pkt *pkts, u32 nb_pkts)
+static int pkt_stream_generate_custom(struct test_spec *test, struct pkt *pkts, u32 nb_pkts)
 {
 	struct pkt_stream *pkt_stream;
 
 	pkt_stream = __pkt_stream_generate_custom(test->ifobj_tx, pkts, nb_pkts, true);
+	if (!pkt_stream)
+		return -ENOMEM;
 	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
 
 	pkt_stream = __pkt_stream_generate_custom(test->ifobj_rx, pkts, nb_pkts, false);
+	if (!pkt_stream)
+		return -ENOMEM;
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
+
+	return 0;
 }
 
 static void pkt_print_data(u32 *data, u32 cnt)
@@ -1944,24 +1980,28 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 		return TEST_SKIP;
 	}
 
-	pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0);
+	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
+		return TEST_FAILURE;
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
 		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
-	pkt_stream_receive_half(test);
+	if (pkt_stream_receive_half(test))
+		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
 	return testapp_validate_traffic(test);
 }
 
 int testapp_stats_tx_invalid_descs(struct test_spec *test)
 {
-	pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0);
+	if (pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0))
+		return TEST_FAILURE;
 	test->ifobj_tx->validation_func = validate_tx_invalid_descs;
 	return testapp_validate_traffic(test);
 }
 
 int testapp_stats_rx_full(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
@@ -1972,7 +2012,8 @@ int testapp_stats_rx_full(struct test_spec *test)
 
 int testapp_stats_fill_empty(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
@@ -1985,7 +2026,8 @@ int testapp_send_receive_unaligned(struct test_spec *test)
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	/* Let half of the packets straddle a 4K buffer boundary */
-	pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2);
+	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
+		return TEST_FAILURE;
 
 	return testapp_validate_traffic(test);
 }
@@ -1995,7 +2037,8 @@ int testapp_send_receive_unaligned_mb(struct test_spec *test)
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2003,14 +2046,16 @@ int testapp_single_pkt(struct test_spec *test)
 {
 	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
 
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
 int testapp_send_receive_mb(struct test_spec *test)
 {
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
+		return TEST_FAILURE;
 
 	return testapp_validate_traffic(test);
 }
@@ -2051,7 +2096,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2096,7 +2142,8 @@ int testapp_invalid_desc(struct test_spec *test)
 		pkts[6].offset += umem_size;
 	}
 
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2108,7 +2155,8 @@ int testapp_xdp_drop(struct test_spec *test)
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_drop, skel_tx->progs.xsk_xdp_drop,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_receive_half(test);
+	if (pkt_stream_receive_half(test))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2140,7 +2188,8 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 			       skel_tx->progs.xsk_xdp_shared_umem,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_even_odd_sequence(test);
+	if (pkt_stream_even_odd_sequence(test))
+		return TEST_FAILURE;
 
 	ret = testapp_validate_traffic(test);
 
@@ -2154,7 +2203,8 @@ int testapp_poll_txq_tmout(struct test_spec *test)
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->umem->frame_size = 2048;
-	pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048);
+	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
+		return TEST_FAILURE;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
 }
 
@@ -2168,7 +2218,7 @@ int testapp_too_many_frags(struct test_spec *test)
 {
 	struct pkt *pkts;
 	u32 max_frags, i;
-	int ret;
+	int ret = TEST_FAILURE;
 
 	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
@@ -2212,9 +2262,12 @@ int testapp_too_many_frags(struct test_spec *test)
 	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
 	pkts[2 * max_frags + 1].valid = true;
 
-	pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
-	ret = testapp_validate_traffic(test);
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+		free(pkts);
+		return TEST_FAILURE;
+	}
 
+	ret = testapp_validate_traffic(test);
 	free(pkts);
 	return ret;
 }
@@ -2288,7 +2341,8 @@ int testapp_send_receive_2k_frame(struct test_spec *test)
 {
 	test->ifobj_tx->umem->frame_size = 2048;
 	test->ifobj_rx->umem->frame_size = 2048;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2410,7 +2464,13 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	 */
 	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
 	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
-	pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, max_descs, MIN_PKT_SIZE)) {
+		clean_sockets(test, test->ifobj_tx);
+		clean_sockets(test, test->ifobj_rx);
+		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
+		return TEST_FAILURE;
+	}
+
 	return testapp_validate_traffic(test);
 }
 
@@ -2436,8 +2496,13 @@ static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
 	test->adjust_tail = true;
 	test->total_steps = 1;
 
-	pkt_stream_replace_ifobject(test->ifobj_tx, DEFAULT_BATCH_SIZE, pkt_len);
-	pkt_stream_replace_ifobject(test->ifobj_rx, DEFAULT_BATCH_SIZE, pkt_len + value);
+	ret = pkt_stream_replace_ifobject(test->ifobj_tx, DEFAULT_BATCH_SIZE, pkt_len);
+	if (ret)
+		return TEST_FAILURE;
+
+	ret = pkt_stream_replace_ifobject(test->ifobj_rx, DEFAULT_BATCH_SIZE, pkt_len + value);
+	if (ret)
+		return TEST_FAILURE;
 
 	ret = testapp_xdp_adjust_tail(test, value);
 	if (ret)
@@ -2489,7 +2554,8 @@ int testapp_tx_queue_consumer(struct test_spec *test)
 	}
 
 	nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
-	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	test->ifobj_tx->xsk->batch_size = nr_packets;
 	test->ifobj_tx->xsk->check_consumer = true;
 
diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index f4e192264b140c21cc861192fd0df991c46afd24..b068b25ea5da728fad1e17b894d6a1b1c9794f74 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -34,13 +34,6 @@
 extern bool opt_verbose;
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
-static void __exit_with_error(int error, const char *file, const char *func, int line)
-{
-	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
-			      strerror(error));
-	ksft_exit_xfail();
-}
-#define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
 
 static inline u32 ceil_u32(u32 a, u32 b)
 {
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a874f27b590d8ba615e16c612728b2f515ac8dff..a16d3ed3629a995e2bcdd7357437451f059d213e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -107,6 +107,15 @@ static u32 opt_run_test = RUN_ALL_TESTS;
 
 void test__fail(void) { /* for network_helpers.c */ }
 
+static void __exit_with_error(int error, const char *file, const char *func, int line)
+{
+	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line,
+			      error, strerror(error));
+	ksft_exit_xfail();
+}
+
+#define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
+
 static bool ifobj_zc_avail(struct ifobject *ifobject)
 {
 	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;

-- 
2.51.0


