Return-Path: <linux-kselftest+bounces-40604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB5B401A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6857B3B2C26
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20530649D;
	Tue,  2 Sep 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ej9AQwPy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642C305E14;
	Tue,  2 Sep 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817669; cv=none; b=rT7711Z6+TRttTRx8DATAC0xi0LlfCHEjKE1PM2YhgSToayEqykt4/N3FzuqFcx1z+/kElreyrqN/n3wuqHym9zBW/+YkTJcMJ8Clk2zU6FrqQ89XyK4U/tEh/0dLyWmwdiQBcVmjIIuBBWw1lgRE54SAkyZyJb93nrZirRrowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817669; c=relaxed/simple;
	bh=lj73w5D9vAdZmPcvAp9jaxwrpxkmIGwTkywyhV6ljgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGumwgZrN2QM+DXVWaMDxBLxiw0NLCmICNfd+2k7llpPTVxKs+HWzZ7SA6MtWTmvBQLMnNWSibNVLrF92lzpQrOibFGJWKUV0Q7+c1el+O1vflYH+oIKn2qP+Mw7mhCXOb+T5riOzScsjJeD3olrFnN6Ln0bSA14uOxrEO4cLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ej9AQwPy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 08E22C8EC73;
	Tue,  2 Sep 2025 12:54:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F063860695;
	Tue,  2 Sep 2025 12:54:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C054A1C228A25;
	Tue,  2 Sep 2025 14:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ooqug4bEYzc4JdqMMDt0seR1F0XHJ3six2E0/lF92z0=;
	b=ej9AQwPyRKzSRw8g8gUmopflB5muxUPtqNXKrtxqlyXrt9Uu15KAEHi4T05hGYRI6pu2JF
	SUv+6DQgrZWi5Q0PLjWfw+9YQHGpD6ESiAnvJwS7qPires8OQQpt5Kht1wIUCVHnSR8t9I
	aoKOOYWlRXIw0JSmWijNbIKfifmY3cgPRNmJvzwClw5MeBo6eRH3z47TV9K7jgzsEid44D
	62ySDYHqYiYO/eGPDFZNOxw8V7kthe929wfY1DI6AIWTLdOPtjOKaC6HIsdEU3f1KfSW0S
	wClC0EWha9Qu2gladCQJUuueGE3ghi1sdzQzMOg59mwFJTvxcCCYbXQtbIYBCQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:50:03 +0200
Subject: [PATCH bpf-next v2 13/14] selftests/bpf: test_xsk: Isolate flaky
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-13-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
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

Some tests are flaky and fail from time to time on virtual interfaces.
Adding them to the CI would trigger lots of 'false' errors.

Remove the flaky tests from the nominal tests table so they won't be
run by the CI in upcoming patch.
Create a flaky_tests table to hold them.
Use this flaky table in xskxceiver.c to keep all the tests available
from the test_xsk.sh script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.h   | 12 ++++++++----
 tools/testing/selftests/bpf/xskxceiver.c | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index b068b25ea5da728fad1e17b894d6a1b1c9794f74..579c061f49fdcb2dbbb295823eb222a3975cb8e7 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -270,9 +270,6 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
 	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
-	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
-	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
 	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
 	 .test_func = testapp_send_receive_unaligned_mb},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
@@ -282,9 +279,16 @@ static const struct test_spec tests[] = {
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
-	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
 	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
 	};
 
+static const struct test_spec flaky_tests[] = {
+	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
+	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
+	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+};
+
+
 #endif				/* TEST_XSK_H_ */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 68aa3317dfc62cd4deac07f2d58fefd55770775f..b7295977cf69aa9a66a97866eb0f28cf1f614f1f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -311,10 +311,14 @@ static void print_tests(void)
 	printf("Tests:\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		printf("%u: %s\n", i, tests[i].name);
+	printf("== Flaky tests:\n");
+	for (i = ARRAY_SIZE(tests); i < ARRAY_SIZE(tests) + ARRAY_SIZE(flaky_tests); i++)
+		printf("%u: %s\n", i, flaky_tests[i - ARRAY_SIZE(tests)].name);
 }
 
 int main(int argc, char **argv)
 {
+	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(flaky_tests);
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -342,7 +346,7 @@ int main(int argc, char **argv)
 		print_tests();
 		ksft_exit_xpass();
 	}
-	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
+	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
 		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
@@ -382,7 +386,7 @@ int main(int argc, char **argv)
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
 	if (opt_run_test == RUN_ALL_TESTS)
-		nb_tests = ARRAY_SIZE(tests);
+		nb_tests = total_tests;
 	else
 		nb_tests = 1;
 	if (opt_mode == TEST_MODE_ALL) {
@@ -404,11 +408,15 @@ int main(int argc, char **argv)
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
+					  &flaky_tests[j - ARRAY_SIZE(tests)]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 

-- 
2.50.1


