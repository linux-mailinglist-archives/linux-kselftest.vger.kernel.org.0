Return-Path: <linux-kselftest+bounces-28915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77132A5F169
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F503B3085
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD69267B00;
	Thu, 13 Mar 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IIxum4RC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D7267384;
	Thu, 13 Mar 2025 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862902; cv=none; b=XRUl0gkzvThgcuGZzQXHPgdvgZ6lxndkNh/7MsoZGw6iYzLfS698r2jOGSsUpvzJ15+0zVqQ/5+IyG6N5djhAibwF/RiR1bnjGAnxj3gnhcrc3cvwdlW5O3wg9dm/mJPpE9BbxHu+tMg3JQjZ/WX3VA+RhgehBOeX8qdLeKv1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862902; c=relaxed/simple;
	bh=DfVK2eP/rEHIQ/LHV+vTsRtjG/dV4FNr0mLMdEZA1Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIFrRYQf/yzhI2sUX/wHkkdBeKXSNdf+Dqz+ACom0z1X49D9/jkBt8oyM1NaVMUKkHHk4Ft61aYx+2POqQbTTHzqL8NareXSMUFrfqO9ABBBCGHsZG4AFqZzdEZI3lIXVaF+Ed+uyRxOxCMo1heUVbCBixD+PNisHx1BrI9NPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IIxum4RC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4198843216;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J54YxD2H5zp6wXZtYAdJxT5kos5myQzsnbaVSddZn18=;
	b=IIxum4RCtV1vNygGWDBMgHUlR3cDdmwTPDYh5mcFkIDt158odDHsn1vwt03RUIxq656rhF
	FU1bPcZGV4dNoqolRmI4BJ6WHh2/juztIdZUIkPEHsacv6CK4wyESXvyve1UmEqwcV2aa5
	dLg3JjjjWOaJdCbRzMeOSLMAF03Uyh2da/4M1fTxBHQTf+0AuvR1NNvWVRdB5pK7xBxz0k
	KW4ZnT8QJOX4WUHQ6HvqjKY+gnvfxPF4hk2KTIl7+IUNSk5TxJ4gB5ajVVfs2/sCDBQ941
	09hevrQ1hdZYiAPp6pBmU5t5MMLfU1H9gPrm2AJwMIs0lnHAs9+nfiv/H/YDzQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:48:07 +0100
Subject: [PATCH 09/13] selftests/bpf: test_xsk: Don't exit immediately on
 allocation failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-9-7374729a93b9@bootlin.com>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

If any allocation in the pkt_stream_*() helpers fail, exit_on_error() is
called. This terminates the program immediately and can lead to memory
leaks.

Return NULL in case of allocation failure.
Return TEST_FAILURE when something goes wrong in the packet generation.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 97 +++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 41c744c627d9b8acffc687f6893a01557e6556c5..5b31c694fb0e104a81369b7ee2e82dc6ee190b4d 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -733,7 +733,7 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
 
 	pkt_stream = __pkt_stream_alloc(nb_pkts);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	pkt_stream->nb_pkts = nb_pkts;
 	pkt_stream->max_pkt_len = pkt_len;
@@ -757,36 +757,51 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
-static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+static int pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
 {
 	struct pkt_stream *pkt_stream;
 
 	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
+	if (!pkt_stream)
+		return -ENOMEM;
 	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
 	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
+	if (!pkt_stream)
+		return -ENOMEM;
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
+
+	return 0;
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
@@ -800,14 +815,19 @@ static void pkt_stream_receive_half(struct test_spec *test)
 
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
@@ -816,13 +836,19 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
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
@@ -881,7 +907,7 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 
 	pkt_stream = __pkt_stream_alloc(nb_frames);
 	if (!pkt_stream)
-		exit_with_error(ENOMEM);
+		return NULL;
 
 	for (i = 0; i < nb_frames; i++) {
 		struct pkt *pkt = &pkt_stream->pkts[pkt_nb];
@@ -924,15 +950,21 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
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
@@ -2101,24 +2133,28 @@ static int testapp_stats_rx_dropped(struct test_spec *test)
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
 
 static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 {
-	pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0);
+	if (pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0))
+		return TEST_FAILURE;
 	test->ifobj_tx->validation_func = validate_tx_invalid_descs;
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_stats_rx_full(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
@@ -2130,7 +2166,8 @@ static int testapp_stats_rx_full(struct test_spec *test)
 
 static int testapp_stats_fill_empty(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+		return TEST_FAILURE;
 	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
@@ -2144,7 +2181,8 @@ static int testapp_send_receive_unaligned(struct test_spec *test)
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
 	/* Let half of the packets straddle a 4K buffer boundary */
-	pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2);
+	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
+		return TEST_FAILURE;
 
 	return testapp_validate_traffic(test);
 }
@@ -2154,7 +2192,8 @@ static int testapp_send_receive_unaligned_mb(struct test_spec *test)
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2162,14 +2201,16 @@ static int testapp_single_pkt(struct test_spec *test)
 {
 	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
 
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
 static int testapp_send_receive_mb(struct test_spec *test)
 {
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
+		return TEST_FAILURE;
 
 	return testapp_validate_traffic(test);
 }
@@ -2210,7 +2251,8 @@ static int testapp_invalid_desc_mb(struct test_spec *test)
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2255,7 +2297,8 @@ static int testapp_invalid_desc(struct test_spec *test)
 		pkts[6].offset += umem_size;
 	}
 
-	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
+	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2267,7 +2310,8 @@ static int testapp_xdp_drop(struct test_spec *test)
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_drop, skel_tx->progs.xsk_xdp_drop,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_receive_half(test);
+	if (pkt_stream_receive_half(test))
+		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
 }
 
@@ -2311,7 +2355,8 @@ static int testapp_xdp_shared_umem(struct test_spec *test)
 			       skel_tx->progs.xsk_xdp_shared_umem,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 
-	pkt_stream_even_odd_sequence(test);
+	if (pkt_stream_even_odd_sequence(test))
+		return TEST_FAILURE;
 
 	ret = testapp_validate_traffic(test);
 
@@ -2339,7 +2384,7 @@ static int testapp_too_many_frags(struct test_spec *test)
 {
 	struct pkt *pkts;
 	u32 max_frags, i;
-	int ret;
+	int ret = TEST_FAILURE;
 
 	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
@@ -2384,8 +2429,8 @@ static int testapp_too_many_frags(struct test_spec *test)
 	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
 	pkts[2 * max_frags + 1].valid = true;
 
-	pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
-	ret = testapp_validate_traffic(test);
+	if (!pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2))
+		ret = testapp_validate_traffic(test);
 
 	free(pkts);
 	return ret;

-- 
2.48.1


