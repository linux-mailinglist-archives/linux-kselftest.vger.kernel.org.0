Return-Path: <linux-kselftest+bounces-44507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48975C23AEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0BBF34E5C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC633E363;
	Fri, 31 Oct 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOX2dxzE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536D33DEE5;
	Fri, 31 Oct 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897932; cv=none; b=p0p5LthqT46Gq4OIqOuevhIW4MDOS/p0p5S4k8E0AjgtzmUg2iBR8sTEN08a00ZkgVZbXHtLNfSD6Rn+OsOFUs4f8EhZ8tv3MbVzIcht3z5fZ1YfGybgr1PyVJsiXI5G9FOHTXiGs/HYGMQOqRBm9TDZE7LeApP+qr7veLOpt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897932; c=relaxed/simple;
	bh=EYP1g6ILAIRuipFpZVQB29tZDOyn6uosFb5pzpZkGxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvh6j0Hn7CJxwsFOTqH6WFmbYs7NxEEZT0vBH9D6tg7TBrI7QP63ZDj04tEEzjQsXseLkJOdE7YxaYyLc60Sn5XPsiBgcmKklmzl0J5rdlj1aHA/Mi7h7ac+BFa8DdbobzcjYJDFEIFBn+6QcDX3vegdB8bbtDVqb1EStYCHXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOX2dxzE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 74B214E41437;
	Fri, 31 Oct 2025 08:05:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A79D60704;
	Fri, 31 Oct 2025 08:05:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9931180FB6D;
	Fri, 31 Oct 2025 09:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4oP4SA3WDBmB77+xU7Hdn9aCn/4FW3aMWThtZxtROQg=;
	b=gOX2dxzEkJESzn7fxnxjTkBS44aFYcYpoOOnriC9+Dp7RKbKG0uQuFUtLU43gOkIt9hQnl
	eYhHuijFbEH4fs97t5YOeubYzB8RKHeQVBGo/HXN34RrBJzUUglR20rmCXmMmW0Ah/qmky
	BzAiEIIvK2LyAvZielbe1BgsTh2krXooRTMFazKZY8t2qzSICfO2NyprvpJmQEirbLhQTP
	jZNg0F7hhAg81XSwoOAV2SmdNO5UZZ1f0l21+2fZHVRZEThI9t9UxsESQucAwBkd+yLz6/
	VRgntZOihBoZxz+MRzkD2/nOljoyNfK1dsqvYMIMBw2qPuvx8kE4P3d3hSw3UA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:50 +0100
Subject: [PATCH bpf-next v7 14/15] selftests/bpf: test_xsk: Isolate non-CI
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-14-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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

Following tests won't fit in the CI:
- XDP_ADJUST_TAIL_* and SEND_RECEIVE_9K_PACKETS because of their
  flakyness
- UNALIGNED_* because they depend on huge page allocations
- *_RING_SIZE because they depend on HW rings
- TEARDOWN because it's too long

Remove these tests from the nominal tests table so they won't be
run by the CI in upcoming patch.
Create a skip_ci_tests table to hold them.
Use this skip_ci table in xskxceiver.c to keep all the tests available
from the test_xsk.sh script.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.h   | 34 ++++++++++++++++++++------------
 tools/testing/selftests/bpf/xskxceiver.c | 15 ++++++++++----
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index b068b25ea5da728fad1e17b894d6a1b1c9794f74..8fc78a057de0bed1792be8f91c0c5594c1122fdf 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -254,14 +254,9 @@ static const struct test_spec tests[] = {
 	{.name = "POLL_TX", .test_func = testapp_poll_tx},
 	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
 	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
-	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
 	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
 	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
-	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
-	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
-	 .test_func = testapp_unaligned_inv_desc_4001_frame},
 	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
-	{.name = "TEARDOWN", .test_func = testapp_teardown},
 	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
 	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
 	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
@@ -272,19 +267,32 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
-	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
-	 .test_func = testapp_send_receive_unaligned_mb},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
-	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
-	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
-	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
+	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
+	};
+
+static const struct test_spec ci_skip_tests[] = {
+	/* Flaky tests */
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
-	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
-	};
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+	/* Tests with huge page dependency */
+	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
+	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
+	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
+	 .test_func = testapp_unaligned_inv_desc_4001_frame},
+	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
+	 .test_func = testapp_send_receive_unaligned_mb},
+	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
+	/* Test with HW ring size dependency */
+	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
+	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
+	/* Too long test */
+	{.name = "TEARDOWN", .test_func = testapp_teardown},
+};
+
 
 #endif				/* TEST_XSK_H_ */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a16d3ed3629a995e2bcdd7357437451f059d213e..57fa4b3f0decf76b022c79b543b1a906f0c89076 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -326,10 +326,13 @@ static void print_tests(void)
 	printf("Tests:\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		printf("%u: %s\n", i, tests[i].name);
+	for (i = ARRAY_SIZE(tests); i < ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests); i++)
+		printf("%u: %s\n", i, ci_skip_tests[i - ARRAY_SIZE(tests)].name);
 }
 
 int main(int argc, char **argv)
 {
+	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -357,7 +360,7 @@ int main(int argc, char **argv)
 		print_tests();
 		ksft_exit_xpass();
 	}
-	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
+	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
 		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
@@ -397,7 +400,7 @@ int main(int argc, char **argv)
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
 	if (opt_run_test == RUN_ALL_TESTS)
-		nb_tests = ARRAY_SIZE(tests);
+		nb_tests = total_tests;
 	else
 		nb_tests = 1;
 	if (opt_mode == TEST_MODE_ALL) {
@@ -419,11 +422,15 @@ int main(int argc, char **argv)
 		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
 			continue;
 
-		for (j = 0; j < ARRAY_SIZE(tests); j++) {
+		for (j = 0; j < total_tests; j++) {
 			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
 				continue;
 
-			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
+			if (j < ARRAY_SIZE(tests))
+				test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
+			else
+				test_init(&test, ifobj_tx, ifobj_rx, i,
+					  &ci_skip_tests[j - ARRAY_SIZE(tests)]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 

-- 
2.51.0


