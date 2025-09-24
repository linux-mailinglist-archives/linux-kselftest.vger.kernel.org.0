Return-Path: <linux-kselftest+bounces-42207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BAB9A63D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD34E04C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2E314B83;
	Wed, 24 Sep 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ulkTM4A2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F643314A94;
	Wed, 24 Sep 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725442; cv=none; b=a43DdSLQUYWUBVXPSeuals9RSDk9CWShmPfq52oSa4PIdbsVkPwRcl8wSNB7omda2JZeir2er3GCnc/nCLcBMpJNBVNg+RLYDQuQKHT0XL5M+WI41MLTkbvIURxBfJOGwI/mJOWegTOECCIi5Dm1uhYmmRESS2VKGdp46UedblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725442; c=relaxed/simple;
	bh=Hs4+AUs3krBlVcGNstavnFhp/svJKbtUXTQMgJjRYgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TuiIitP70hSdHHSI6ox1JaF2Cbuak2hvjOfdsEEAQ8lajQyU1snF0QFsRigMfI+/oek6xTizuEkuSn9gY5sKennBlyn0qEwSpczryuHH8necfcGwl9jVQiguO9UPTOxWJLdGlN2zsLBVmyYFoaUjuDBuraE/VsbX1FfYLVmb6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ulkTM4A2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F9611A0F81;
	Wed, 24 Sep 2025 14:50:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15BB460634;
	Wed, 24 Sep 2025 14:50:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0956102F1973;
	Wed, 24 Sep 2025 16:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3/WEqKstae0b12RLPmjaq1abjYRG9ZTZTzDs8xwjMu8=;
	b=ulkTM4A22y4wfF3v9/v/dLmwxx2fEe/+ELWr9kvM34izrh3EsRTSoe82z408qdNpTc2T6I
	0jO4n3WceByong0f4iCuFnEc40appQrixa4AsbjkROH/lMORK+Wh+pT75CHNwaX/GRpj2L
	NcXV3vU4/7XO4+jmzhnMZKzDyXUEVU+D0RCYSMN3OSBQRgUQNafUfMtYF3w3i/g41iPDU2
	GFKPQfZhsCBj0HlhIQI2MwYlTNpil5/3zOwx+f5G22v1avFRSoml58R6ab19lBdc0FOkae
	cEyBKVcAZp+jDRc96BaH4BFUr0TheWCWuj2R3bStxhXkDQKGvLJZ5gQsygafHA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:49 +0200
Subject: [PATCH bpf-next v4 14/15] selftests/bpf: test_xsk: Isolate flaky
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-14-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
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
 tools/testing/selftests/bpf/test_xsk.h   |  8 ++++++--
 tools/testing/selftests/bpf/xskxceiver.c | 15 +++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index b068b25ea5da728fad1e17b894d6a1b1c9794f74..b86694d0eef53521e2f245670bbc8176991466bd 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -272,7 +272,6 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
 	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
 	 .test_func = testapp_send_receive_unaligned_mb},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
@@ -282,9 +281,14 @@ static const struct test_spec tests[] = {
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
-	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
 	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
 	};
 
+static const struct test_spec flaky_tests[] = {
+	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+};
+
+
 #endif				/* TEST_XSK_H_ */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a16d3ed3629a995e2bcdd7357437451f059d213e..8707f4a0fac64e1ebb6a4241edf8e874a1eb67c3 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -326,10 +326,13 @@ static void print_tests(void)
 	printf("Tests:\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		printf("%u: %s\n", i, tests[i].name);
+	for (i = ARRAY_SIZE(tests); i < ARRAY_SIZE(tests) + ARRAY_SIZE(flaky_tests); i++)
+		printf("%u: %s\n", i, flaky_tests[i - ARRAY_SIZE(tests)].name);
 }
 
 int main(int argc, char **argv)
 {
+	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(flaky_tests);
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
+					  &flaky_tests[j - ARRAY_SIZE(tests)]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 

-- 
2.51.0


