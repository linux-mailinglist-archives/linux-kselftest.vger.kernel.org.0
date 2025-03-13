Return-Path: <linux-kselftest+bounces-28913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E8A5F15F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC3188D784
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B062676CA;
	Thu, 13 Mar 2025 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jh8saqkP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C21265CD2;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862900; cv=none; b=ZBhbBavOhKCwSTh5VkZPItkfC4uipRTE9xw5SfYVYhnT/gNltYSw7jaXpb1oekuZJmyBiMRVk56PQR9HK2bnQSKeFUpOhqQyyIZPOJVI0x2t+4mSoRQ86uXfcbKLGTAlWi8QrRxYrEc04JGw2bZxCBszkw/lwYahKmbFESgVb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862900; c=relaxed/simple;
	bh=ocSKF1hNgcKTyi5K8Ae9c6IQO2lUPxE/TqaPGrvc7fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L47Pe6M2E62s2Sll0NPwrLZ2L8gznzjR/7HRT2Xl/tVqormqZBmRzoopw564qqF63BDfb7pCIBCw8bF/s8ea6QIptATxv9f7fN3OMXeF467So5oclCZjSiiGmL3Cao8A9PhsQcKMc6/GcYp5mMzgcOIQhvG8UqIcEUmHP5dRUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jh8saqkP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B2FA44185;
	Thu, 13 Mar 2025 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw0JweIAlx4fLj+tvhcUqiLBdouvCnkylo3n6c/bCbU=;
	b=Jh8saqkP44vcBNKDMwSdMyVGfTvAZFlUtRf1Z+C6H7+69XFeeT83z8sBkjrZbNDpGNzxBH
	vr5HEFqwGEdF0djnRj3HtBG3CKsYCO4W7W7E+oSTyvBHpKlxouZ591adHoqi+ghm3uRf8y
	XHgSgwecrSni9rIy5A+Z9vkGFdG0PuFuUFugphe+IAR8hk6tKOUPJB+iX25NLb2xpaZiuD
	jUugBaCDUN70S9t2esFGjnkKnLgxe8FC6PLjWJr+WeKL2wJINhIj18chccwgDK2ZUrAJrO
	01GVXBuRtZfI7I19j1HXrwEgpWYf3nuU8Etb8jYj/t4U43JtThq6FYOmaZ+6Ng==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:48:01 +0100
Subject: [PATCH 03/13] selftests/bpf: test_xsk: Wrap ksft_*() behind macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-3-7374729a93b9@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

xskxceiver depends on kselftests which prevent from integrating it into
the test_progs framework.

Wrap the ksft_*() calls behind macros to ease the future integration into
test_progs.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 109 +++++++++++++++----------------
 tools/testing/selftests/bpf/xskxceiver.h |   3 +
 2 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index f43a6ab524f4758d0e155c254af3838b4079df13..8b74a0f79c2e594b4db495acabd02a01a5b1b95f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -118,8 +118,7 @@ void test__fail(void) { /* for network_helpers.c */ }
 
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
-	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
-			      strerror(error));
+	fail_reason("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error, strerror(error));
 	ksft_exit_xfail();
 }
 
@@ -144,8 +143,7 @@ static void report_failure(struct test_spec *test)
 	if (test->fail)
 		return;
 
-	ksft_test_result_fail("FAIL: %s %s%s\n", mode_string(test), busy_poll_string(test),
-			      test->name);
+	fail_reason("FAIL: %s %s%s\n", mode_string(test), busy_poll_string(test), test->name);
 	test->fail = true;
 }
 
@@ -333,12 +331,12 @@ static unsigned int get_max_skb_frags(void)
 
 	file = fopen(MAX_SKB_FRAGS_PATH, "r");
 	if (!file) {
-		ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
+		print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
 		return 0;
 	}
 
 	if (fscanf(file, "%u", &max_skb_frags) != 1)
-		ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
+		print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
 
 	fclose(file);
 	return max_skb_frags;
@@ -368,7 +366,7 @@ static void print_usage(char **argv)
 		"  -t, --test           Run a specific test. Enter number from -l option.\n"
 		"  -h, --help           Display this help and exit\n";
 
-	ksft_print_msg(str, basename(argv[0]));
+	print_msg(str, basename(argv[0]));
 	ksft_exit_xfail();
 }
 
@@ -944,7 +942,7 @@ static void pkt_print_data(u32 *data, u32 cnt)
 
 		seqnum = ntohl(*data) & 0xffff;
 		pkt_nb = ntohl(*data) >> 16;
-		ksft_print_msg("%u:%u ", pkt_nb, seqnum);
+		print_msg("%u:%u ", pkt_nb, seqnum);
 		data++;
 	}
 }
@@ -956,13 +954,13 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 
 	if (eth_header) {
 		/*extract L2 frame */
-		ksft_print_msg("DEBUG>> L2: dst mac: ");
+		print_msg("DEBUG>> L2: dst mac: ");
 		for (i = 0; i < ETH_ALEN; i++)
-			ksft_print_msg("%02X", ethhdr->h_dest[i]);
+			print_msg("%02X", ethhdr->h_dest[i]);
 
-		ksft_print_msg("\nDEBUG>> L2: src mac: ");
+		print_msg("\nDEBUG>> L2: src mac: ");
 		for (i = 0; i < ETH_ALEN; i++)
-			ksft_print_msg("%02X", ethhdr->h_source[i]);
+			print_msg("%02X", ethhdr->h_source[i]);
 
 		data = pkt + PKT_HDR_SIZE;
 	} else {
@@ -970,15 +968,15 @@ static void pkt_dump(void *pkt, u32 len, bool eth_header)
 	}
 
 	/*extract L5 frame */
-	ksft_print_msg("\nDEBUG>> L5: seqnum: ");
+	print_msg("\nDEBUG>> L5: seqnum: ");
 	pkt_print_data(data, PKT_DUMP_NB_TO_PRINT);
-	ksft_print_msg("....");
+	print_msg("....");
 	if (len > PKT_DUMP_NB_TO_PRINT * sizeof(u32)) {
-		ksft_print_msg("\n.... ");
+		print_msg("\n.... ");
 		pkt_print_data(data + len / sizeof(u32) - PKT_DUMP_NB_TO_PRINT,
 			       PKT_DUMP_NB_TO_PRINT);
 	}
-	ksft_print_msg("\n---------------------------------------\n");
+	print_msg("\n---------------------------------------\n");
 }
 
 static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt *pkt, u64 addr)
@@ -995,7 +993,7 @@ static bool is_offset_correct(struct xsk_umem_info *umem, struct pkt *pkt, u64 a
 	if (offset == expected_offset)
 		return true;
 
-	ksft_print_msg("[%s] expected [%u], got [%u]\n", __func__, expected_offset, offset);
+	print_msg("[%s] expected [%u], got [%u]\n", __func__, expected_offset, offset);
 	return false;
 }
 
@@ -1005,7 +1003,7 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llu]\n",
+		print_msg("[%s] expected meta_count [%d], got meta_count [%llu]\n",
 			       __func__, pkt->pkt_nb,
 			       (unsigned long long)meta->count);
 		return false;
@@ -1024,12 +1022,12 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
+		print_msg("Frag invalid addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n",
+		print_msg("Frag crosses frame boundary addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
 		return false;
 	}
@@ -1047,12 +1045,12 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 	pkt_nb = ntohl(*pkt_data) >> 16;
 
 	if (expected_pkt_nb != pkt_nb) {
-		ksft_print_msg("[%s] expected pkt_nb [%u], got pkt_nb [%u]\n",
+		print_msg("[%s] expected pkt_nb [%u], got pkt_nb [%u]\n",
 			       __func__, expected_pkt_nb, pkt_nb);
 		goto error;
 	}
 	if (expected_seqnum != seqnum) {
-		ksft_print_msg("[%s] expected seqnum at start [%u], got seqnum [%u]\n",
+		print_msg("[%s] expected seqnum at start [%u], got seqnum [%u]\n",
 			       __func__, expected_seqnum, seqnum);
 		goto error;
 	}
@@ -1062,7 +1060,7 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 	seqnum = ntohl(*pkt_data) & 0xffff;
 	expected_seqnum += words_to_end;
 	if (expected_seqnum != seqnum) {
-		ksft_print_msg("[%s] expected seqnum at end [%u], got seqnum [%u]\n",
+		print_msg("[%s] expected seqnum at end [%u], got seqnum [%u]\n",
 			       __func__, expected_seqnum, seqnum);
 		goto error;
 	}
@@ -1077,7 +1075,7 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
 {
 	if (pkt->len != len) {
-		ksft_print_msg("[%s] expected packet length [%d], got length [%d]\n",
+		print_msg("[%s] expected packet length [%d], got length [%d]\n",
 			       __func__, pkt->len, len);
 		pkt_dump(xsk_umem__get_data(buffer, addr), len, true);
 		return false;
@@ -1128,8 +1126,8 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 		if (rcvd > xsk->outstanding_tx) {
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
-			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n",
+			print_msg("[%s] Too many packets completed\n", __func__);
+			print_msg("Last completion address: %llx\n",
 				       (unsigned long long)addr);
 			return TEST_FAILURE;
 		}
@@ -1169,7 +1167,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			if (!is_umem_valid(test->ifobj_tx))
 				return TEST_PASS;
 
-			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
+			print_msg("ERROR: [%s] Poll timed out\n", __func__);
 			return TEST_CONTINUE;
 		}
 
@@ -1203,7 +1201,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 		if (!nb_frags) {
 			pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
 			if (!pkt) {
-				ksft_print_msg("[%s] received too many packets addr: %lx len %u\n",
+				print_msg("[%s] received too many packets addr: %lx len %u\n",
 					       __func__, addr, desc->len);
 				return TEST_FAILURE;
 			}
@@ -1311,7 +1309,7 @@ static int receive_pkts(struct test_spec *test)
 			exit_with_error(errno);
 
 		if (timercmp(&tv_now, &tv_end, >)) {
-			ksft_print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
+			print_msg("ERROR: [%s] Receive loop timed out\n", __func__);
 			return TEST_FAILURE;
 		}
 		sock_num = (sock_num + 1) % test->nb_sockets;
@@ -1347,7 +1345,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			ret = poll(&fds, 1, POLL_TMOUT);
 			if (timeout) {
 				if (ret < 0) {
-					ksft_print_msg("ERROR: [%s] Poll error %d\n",
+					print_msg("ERROR: [%s] Poll error %d\n",
 						       __func__, errno);
 					return TEST_FAILURE;
 				}
@@ -1356,7 +1354,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 				break;
 			}
 			if (ret <= 0) {
-				ksft_print_msg("ERROR: [%s] Poll error %d\n",
+				print_msg("ERROR: [%s] Poll error %d\n",
 					       __func__, errno);
 				return TEST_FAILURE;
 			}
@@ -1428,7 +1426,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			if (ret == 0 && timeout)
 				return TEST_PASS;
 
-			ksft_print_msg("ERROR: [%s] Poll error %d\n", __func__, ret);
+			print_msg("ERROR: [%s] Poll error %d\n", __func__, ret);
 			return TEST_FAILURE;
 		}
 	}
@@ -1459,7 +1457,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 		if (ret)
 			exit_with_error(errno);
 		if (timercmp(&tv_now, &tv_end, >)) {
-			ksft_print_msg("ERROR: [%s] Transmission loop timed out\n", __func__);
+			print_msg("ERROR: [%s] Transmission loop timed out\n", __func__);
 			return TEST_FAILURE;
 		}
 
@@ -1518,14 +1516,14 @@ static int get_xsk_stats(struct xsk_socket *xsk, struct xdp_statistics *stats)
 	optlen = sizeof(*stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, stats, &optlen);
 	if (err) {
-		ksft_print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+		print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
 			       __func__, -err, strerror(-err));
 		return TEST_FAILURE;
 	}
 
 	expected_len = sizeof(struct xdp_statistics);
 	if (optlen != expected_len) {
-		ksft_print_msg("[%s] getsockopt optlen error. Expected: %u got: %u\n",
+		print_msg("[%s] getsockopt optlen error. Expected: %u got: %u\n",
 			       __func__, expected_len, optlen);
 		return TEST_FAILURE;
 	}
@@ -1613,13 +1611,13 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	optlen = sizeof(stats);
 	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
 	if (err) {
-		ksft_print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
+		print_msg("[%s] getsockopt(XDP_STATISTICS) error %u %s\n",
 			       __func__, -err, strerror(-err));
 		return TEST_FAILURE;
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llu] expected [%u]\n",
+		print_msg("[%s] tx_invalid_descs incorrect. Got [%llu] expected [%u]\n",
 			       __func__,
 			       (unsigned long long)stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
@@ -1782,7 +1780,7 @@ static void *worker_testapp_validate_rx(void *arg)
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
 		if (err) {
-			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
+			print_msg("Error: Failed to update xskmap, error %s\n",
 				       strerror(-err));
 			exit_with_error(-err);
 		}
@@ -1844,13 +1842,13 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	xsk_detach_xdp_program(ifobj->ifindex, mode_to_xdp_flags(ifobj->mode));
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
-		ksft_print_msg("Error attaching XDP program\n");
+		print_msg("Error attaching XDP program\n");
 		exit_with_error(-err);
 	}
 
 	if (ifobj->mode != mode && (mode == TEST_MODE_DRV || mode == TEST_MODE_ZC))
 		if (!xsk_is_in_mode(ifobj->ifindex, XDP_FLAGS_DRV_MODE)) {
-			ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
+			print_msg("ERROR: XDP prog not in DRV mode\n");
 			exit_with_error(EINVAL);
 		}
 
@@ -1881,18 +1879,18 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	if (test->mtu > MAX_ETH_PKT_SIZE) {
 		if (test->mode == TEST_MODE_ZC && (!ifobj1->multi_buff_zc_supp ||
 						   (ifobj2 && !ifobj2->multi_buff_zc_supp))) {
-			ksft_test_result_skip("Multi buffer for zero-copy not supported.\n");
+			skip_reason("Multi buffer for zero-copy not supported.\n");
 			return TEST_SKIP;
 		}
 		if (test->mode != TEST_MODE_ZC && (!ifobj1->multi_buff_supp ||
 						   (ifobj2 && !ifobj2->multi_buff_supp))) {
-			ksft_test_result_skip("Multi buffer not supported.\n");
+			skip_reason("Multi buffer not supported.\n");
 			return TEST_SKIP;
 		}
 	}
 	err = test_spec_set_mtu(test, test->mtu);
 	if (err) {
-		ksft_print_msg("Error, could not set mtu.\n");
+		print_msg("Error, could not set mtu.\n");
 		exit_with_error(err);
 	}
 
@@ -1951,18 +1949,18 @@ static int testapp_validate_traffic(struct test_spec *test)
 
 	if ((ifobj_rx->umem->unaligned_mode && !ifobj_rx->unaligned_supp) ||
 	    (ifobj_tx->umem->unaligned_mode && !ifobj_tx->unaligned_supp)) {
-		ksft_test_result_skip("No huge pages present.\n");
+		skip_reason("No huge pages present.\n");
 		return TEST_SKIP;
 	}
 
 	if (test->set_ring) {
 		if (ifobj_tx->hw_ring_size_supp) {
 			if (set_ring_size(ifobj_tx)) {
-				ksft_test_result_skip("Failed to change HW ring size.\n");
+				skip_reason("Failed to change HW ring size.\n");
 				return TEST_FAILURE;
 			}
 		} else {
-			ksft_test_result_skip("Changing HW ring size not supported.\n");
+			skip_reason("Changing HW ring size not supported.\n");
 			return TEST_SKIP;
 		}
 	}
@@ -2058,7 +2056,7 @@ static int testapp_headroom(struct test_spec *test)
 static int testapp_stats_rx_dropped(struct test_spec *test)
 {
 	if (test->mode == TEST_MODE_ZC) {
-		ksft_test_result_skip("Can not run RX_DROPPED test for ZC mode\n");
+		skip_reason("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
 	}
 
@@ -2247,12 +2245,12 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
 
 	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
 	if (!data_map || !bpf_map__is_internal(data_map)) {
-		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		print_msg("Error: could not find bss section of XDP program\n");
 		return TEST_FAILURE;
 	}
 
 	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
-		ksft_print_msg("Error: could not update count element\n");
+		print_msg("Error: could not update count element\n");
 		return TEST_FAILURE;
 	}
 
@@ -2307,8 +2305,9 @@ static int testapp_too_many_frags(struct test_spec *test)
 	} else {
 		max_frags = get_max_skb_frags();
 		if (!max_frags) {
-			ksft_print_msg("Couldn't retrieve MAX_SKB_FRAGS from system, using default (17) value\n");
 			max_frags = 17;
+			print_msg("Can't get MAX_SKB_FRAGS from system, using default (%d) value\n",
+				   max_frags);
 		}
 		max_frags += 1;
 	}
@@ -2390,7 +2389,7 @@ static void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
-		ksft_print_msg("Error loading XDP program\n");
+		print_msg("Error loading XDP program\n");
 		exit_with_error(err);
 	}
 
@@ -2399,7 +2398,7 @@ static void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
-		ksft_print_msg("Error querying XDP capabilities\n");
+		print_msg("Error querying XDP capabilities\n");
 		exit_with_error(-err);
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
@@ -2696,7 +2695,7 @@ int main(int argc, char **argv)
 		ksft_exit_xpass();
 	}
 	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
-		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
+		print_msg("Error: test %u does not exist.\n", opt_run_test);
 		ksft_exit_xfail();
 	}
 
@@ -2739,11 +2738,11 @@ int main(int argc, char **argv)
 		ksft_set_plan(modes * nb_tests);
 	} else {
 		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
-			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
+			print_msg("Error: XDP_DRV mode not supported.\n");
 			ksft_exit_xfail();
 		}
 		if (opt_mode == TEST_MODE_ZC && modes <= TEST_MODE_ZC) {
-			ksft_print_msg("Error: zero-copy mode not supported.\n");
+			print_msg("Error: zero-copy mode not supported.\n");
 			ksft_exit_xfail();
 		}
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index e46e823f6a1aaa6880fe1141c571e81e3732b77c..5037ea8ddaf9257e6160ee201c75ed8928d02ce1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -60,7 +60,10 @@
 #define RUN_ALL_TESTS UINT_MAX
 #define NUM_MAC_ADDRESSES 4
 
+#define print_msg(x...) ksft_print_msg(x)
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
+#define skip_reason(x...) ksft_test_result_skip(x)
+#define fail_reason(x...) ksft_test_result_fail(x)
 
 enum test_mode {
 	TEST_MODE_SKB,

-- 
2.48.1


