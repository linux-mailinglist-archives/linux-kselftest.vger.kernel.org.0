Return-Path: <linux-kselftest+bounces-40774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BCB43851
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FB45A385F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D603054DD;
	Thu,  4 Sep 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pNdNjImU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D2304BDA
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980710; cv=none; b=WIQj+YH0Bv8GPPL/l4FWQQpmr8/Ly1Fvk3EurzeKWr82R6aMRYH6rXn2laF2ubp/cF/dcZKYm2ChI8OjSibUyKRuVxyEJX3Aj66B4ieOAUuCBUNQ1AkTk0s4CYYOplmw7BQJvxaFvrh9UE60MjgNtugxTobQOFXAf8WKxi7nPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980710; c=relaxed/simple;
	bh=ySeFB81wyOEL1ibh6XPYK1h6mvjE7neXO3Qpm3VY0rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4+9UoO2pmProWKJMbEs7kWbXVPX6KXxuIeaF87DkwbDqaO7usAyoZUSPwojkm2EnXLXVYB3/qKvlFpANo1yYaxVXKzq4MTut7IrSg9Bie6mEWPvYiJHoqbdpdbXrfw6tgIR4gqq+43rNw9aldG6HF59VPjrv9SUcXhdN0w8QvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pNdNjImU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8DDD8C6B39F;
	Thu,  4 Sep 2025 10:11:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5D22606BB;
	Thu,  4 Sep 2025 10:11:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0DEE1C22DB98;
	Thu,  4 Sep 2025 12:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ov2C6bmMKKd/7/sOT5biVAPJ20pJG8ZtnhCLvNG+TfA=;
	b=pNdNjImUELFipsIYv8yitRwm26Cs+k+yXBllXNaFpTGh4s4u8SeuVba1XcEjHK3vUDqefd
	bCCBgvUijeWQJlafY5WGF8tDUoa9Bs8DHD4h+OphcatdLepsIv6jzZ7eI1b6a0wNFQ5qAm
	AQPzcLH7uv3cu/HT5qXZsyYSlvgjsRR8JCmpP2krw64oFRBC/D1BzNKizm+1ROInbXF6i6
	DkcCB5KWeDGmfIr9gP3iY53fbSQfEJkULP1VbJpzrVVsavmsstIVm3baBWOBfo2at/SPaO
	GJiQQPDMZzTOG7P54k8GQvF/xffLNn4xuqcaNmpffnIGU5z03/VduvA/HEJoNA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:26 +0200
Subject: [PATCH bpf-next v3 11/14] selftests/bpf: test_xsk: Don't exit
 immediately on allocation failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-11-ce382e331485@bootlin.com>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
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

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 136 ++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 74bbfe344026e52046c8da28b747716ec6e55e28..66c6c38a65791730685453e2f429857d612008e8 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -489,7 +489,7 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
 
 	pkt_stream = __pkt_stream_alloc(nb_pkts);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	pkt_stream->nb_pkts = nb_pkts;
 	pkt_stream->max_pkt_len = pkt_len;
@@ -513,37 +513,56 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
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
@@ -557,14 +576,19 @@ static void pkt_stream_receive_half(struct test_spec *test)
 
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
@@ -573,13 +597,19 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
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
@@ -638,7 +668,7 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 
 	pkt_stream = __pkt_stream_alloc(nb_frames);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	for (i = 0; i < nb_frames; i++) {
 		struct pkt *pkt = &pkt_stream->pkts[pkt_nb];
@@ -681,15 +711,21 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
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
@@ -1951,24 +1987,28 @@ int testapp_stats_rx_dropped(struct test_spec *test)
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
 	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
@@ -1980,7 +2020,8 @@ int testapp_stats_rx_full(struct test_spec *test)
 
 int testapp_stats_fill_empty(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
@@ -1994,7 +2035,8 @@ int testapp_send_receive_unaligned(struct test_spec *test)
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	/* Let half of the packets straddle a 4K buffer boundary */
-	pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2);
+	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
+		return TEST_FAILURE;
 
 	return testapp_validate_traffic(test);
 }
@@ -2004,7 +2046,8 @@ int testapp_send_receive_unaligned_mb(struct test_spec *test)
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2012,14 +2055,16 @@ int testapp_single_pkt(struct test_spec *test)
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
@@ -2060,7 +2105,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2105,7 +2151,8 @@ int testapp_invalid_desc(struct test_spec *test)
 		pkts[6].offset += umem_size;
 	}
 
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2117,7 +2164,8 @@ int testapp_xdp_drop(struct test_spec *test)
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_drop, skel_tx->progs.xsk_xdp_drop,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_receive_half(test);
+	if (pkt_stream_receive_half(test))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2149,7 +2197,8 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 			       skel_tx->progs.xsk_xdp_shared_umem,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_even_odd_sequence(test);
+	if (pkt_stream_even_odd_sequence(test))
+		return TEST_FAILURE;
 
 	ret = testapp_validate_traffic(test);
 
@@ -2163,7 +2212,8 @@ int testapp_poll_txq_tmout(struct test_spec *test)
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->umem->frame_size = 2048;
-	pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048);
+	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
+		return TEST_FAILURE;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
 }
 
@@ -2177,7 +2227,7 @@ int testapp_too_many_frags(struct test_spec *test)
 {
 	struct pkt *pkts;
 	u32 max_frags, i;
-	int ret;
+	int ret = TEST_FAILURE;
 
 	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
@@ -2221,9 +2271,12 @@ int testapp_too_many_frags(struct test_spec *test)
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
@@ -2297,7 +2350,8 @@ int testapp_send_receive_2k_frame(struct test_spec *test)
 {
 	test->ifobj_tx->umem->frame_size = 2048;
 	test->ifobj_rx->umem->frame_size = 2048;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2419,7 +2473,13 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
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
 
@@ -2445,8 +2505,13 @@ static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
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
@@ -2498,7 +2563,8 @@ int testapp_tx_queue_consumer(struct test_spec *test)
 	}
 
 	nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
-	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	test->ifobj_tx->xsk->batch_size = nr_packets;
 	test->ifobj_tx->xsk->check_consumer = true;
 

-- 
2.50.1


