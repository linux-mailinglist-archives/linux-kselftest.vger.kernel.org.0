Return-Path: <linux-kselftest+bounces-28918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94283A5F172
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E2A1892E24
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD5267F5C;
	Thu, 13 Mar 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="THS1CHws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3C266B41;
	Thu, 13 Mar 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862906; cv=none; b=FCJUmoKeC0g5ApQGpX/uzgNNSX/bDzPTalo0pkZ0CVtJtH453yIWfflKbuT5tnqN7it7+DB72Sb+SjaJYemoepvh3cP21xR020lKwmzwGE6W6Y+XBUxRewHr6PNJT1emig00qdTzqwiKX+dbNmGXkM3t8/b30NbyQWX2NErz6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862906; c=relaxed/simple;
	bh=6CkYmR+y7CEUPuEqAmEdcB/uT3E51cy9/COWbkbOSDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/ta/kA+R4fMZ1Z+ORLKDAUvtGXVvsAeTqvj4DC8A2K5qSaM5pXRGepOE40lCWYRrkjfFSyHxxL5ClSC+30Iec+EC3YgWLyHEG8dUICYVY7bLdoF0meSG9+FDg8ZPX5l/a/kZWpRTcZpU++tOXHvQRY73MEfRYzmKTS+pUx0GAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=THS1CHws; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03FBE441AC;
	Thu, 13 Mar 2025 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bBamxfXBRKlk09QuG3YiBX+zGqdxP/e2S5ZONi/jHM=;
	b=THS1CHws7ygm4QWN7J2ZImZxrYhQ5ayl7ofAjrFpbcTcS8KxuMNwNeLIeUX5aCJ/uhgvp6
	A6EJexENSuP7BwerUnks054BQF3PYPAbmpQeG1kg6jTdgYjeLzZTzEnX/Ml+BPwx6FJgta
	HOwztnFvZfckvwO45IqwH//BLCEEomRZte9/81T87fHDVGXAnhZsq+1twXgYqq4tnh/Glt
	ANk+AquCqIXH4UGYozvFfzM/bkq56h5M6d0USBliOPooRhlg48NBy9Jxt9GfaRm0eoQTd/
	LYHy6LUQLzKKWfihBRFeLZTC168/VOu8NhatbIxsKbLKF/zfhvXVpYDge5Gk0g==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:48:10 +0100
Subject: [PATCH 12/13] selftests/bpf: test_xsk: Isolate flaky tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-12-7374729a93b9@bootlin.com>
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

Some tests are flaky (especially on s390). So they don't fit in the CI.

Remove flaky tests from the tests table so they won't be run by the CI
in upcoming patch.
Create a flaky_tests table to hold them.
Use the flaky table in xskxceiver.c so the tests remain available for HW
in test_xsk.sh.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.h   | 12 ++++++++----
 tools/testing/selftests/bpf/xskxceiver.c | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index 9653687087c122ec5fdb9f23e3343e37c82373f6..430054e57b85fa284d405f31747fcfade100b90d 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -271,7 +271,6 @@ static const struct test_spec tests[] = {
 	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
 	 .test_func = testapp_unaligned_inv_desc_4001_frame},
 	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
-	{.name = "TEARDOWN", .test_func = testapp_teardown},
 	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
 	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
 	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
@@ -282,9 +281,6 @@ static const struct test_spec tests[] = {
 	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
 	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
 	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
-	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
-	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
-	 .test_func = testapp_send_receive_unaligned_mb},
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
@@ -292,4 +288,12 @@ static const struct test_spec tests[] = {
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	};
 
+static const struct test_spec flaky_tests[] = {
+	{.name = "TEARDOWN", .test_func = testapp_teardown},
+	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
+	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
+	 .test_func = testapp_send_receive_unaligned_mb},
+};
+
+
 #endif				/* TEST_XSK_H_ */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index fee69e18d4303ffc02085c88e08a2caf413454ae..e554b6bb1bd0d64ff16f2544072e98042c821990 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -310,10 +310,14 @@ static void print_tests(void)
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
@@ -341,7 +345,7 @@ int main(int argc, char **argv)
 		print_tests();
 		ksft_exit_xpass();
 	}
-	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
+	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
 		print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
@@ -381,7 +385,7 @@ int main(int argc, char **argv)
 	test.rx_pkt_stream_default = rx_pkt_stream_default;
 
 	if (opt_run_test == RUN_ALL_TESTS)
-		nb_tests = ARRAY_SIZE(tests);
+		nb_tests = total_tests;
 	else
 		nb_tests = 1;
 	if (opt_mode == TEST_MODE_ALL) {
@@ -403,11 +407,15 @@ int main(int argc, char **argv)
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
2.48.1


