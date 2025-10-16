Return-Path: <linux-kselftest+bounces-43307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C285DBE2093
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C591F50271E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47E3195EC;
	Thu, 16 Oct 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UtWLMPaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC03191CB;
	Thu, 16 Oct 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600788; cv=none; b=C1V/bR41B0FTh9kAvRoglZvneXvyniWFn4H4LtyMxRktCsKKhHO8W/3vTzn8v1gWjCW9x/GBiqK4WJHG0lFfRJGyEZdHWWd76ey08MBBlGN4+PdgdPMBffXSg49kzkQlV323FtNsuyq4dCaCvc1qsM6Q/0nfWsrltZP9HuSW0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600788; c=relaxed/simple;
	bh=7bBe/qzKswYlN8kUx7+HxLoGBCAAAr7TS83KTNK+fEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+HYjafU0NTLEASHzVqyB3gH09ADOlX9M9ZHl7inapaNKdp/6H80mitUHUu1JsGU2besc3kanPeTYVRDEusERFwlyiWNTasd1PxZlULjkHfxYaReZC4mhXgylnCd10wOOaiyCCAQv1i5Xovd0cQaKxYxbD5bZJVrW/NaB3AuTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UtWLMPaN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2A68C03B71;
	Thu, 16 Oct 2025 07:46:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2ABB6062C;
	Thu, 16 Oct 2025 07:46:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79B9E102F22B9;
	Thu, 16 Oct 2025 09:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SSDn5WvLXfzk3g9Cy7VdOq/has9xJcIUEAnuGD/5GnY=;
	b=UtWLMPaNdcwZvUoto7Ti2Rty7iMaPgzMoE7DWVVOJH2jnn8viC+IAEKuFnzvN2h4OgG71n
	GGya0/9TsAxjYEA32f30LjcBAzdHsHP9L1ePKUCef8F1+Rzt95Ef4Z2Evqvx51GC8jaT+r
	1VwqZKzUaYOewjEAnG92mv2XjJF6v0jQF5FwS/tlYh0f7boDQB5oP0ZmUGOdJBu91BSBuu
	dQ4kb253vKdgnsxUDB6114FDcLIwVKruFqh8U3cCR4EsKPX+vyJ9AFhdiABsjG/2swfndJ
	5N+4gDbmifzde9ykqHmnIMczT0ge4HzVwl7m5Ozo7DpsCnbZdXHRZOjzZgulZQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:43 +0200
Subject: [PATCH bpf-next v5 14/15] selftests/bpf: test_xsk: Isolate flaky
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-14-662c95eb8005@bootlin.com>
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

Some tests are flaky and fail from time to time on virtual interfaces.
Adding them to the CI would trigger lots of 'false' errors.

Remove the flaky tests from the nominal tests table so they won't be
run by the CI in upcoming patch.
Create a flaky_tests table to hold them.
Use this flaky table in xskxceiver.c to keep all the tests available
from the test_xsk.sh script.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.h   | 10 +++++++---
 tools/testing/selftests/bpf/xskxceiver.c | 15 +++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index b068b25ea5da728fad1e17b894d6a1b1c9794f74..ced30bdc19b7fded2d79143ebedf8c5d97bac6b1 100644
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
@@ -281,10 +280,15 @@ static const struct test_spec tests[] = {
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
-	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
-	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
 	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
 	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
 	};
 
+static const struct test_spec flaky_tests[] = {
+	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
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


