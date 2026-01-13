Return-Path: <linux-kselftest+bounces-48804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2CD15F0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9113066458
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04B1DF742;
	Tue, 13 Jan 2026 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i93GAK30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E514A4CC;
	Tue, 13 Jan 2026 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262870; cv=none; b=gS6Wgpsc2Heytn8S1HYGZlRTyoK0aBzVrh0atnf10Jj6o+UvnOzg/wPeBkvzpkgXP+w4XqEzVqgahDL/ag3EGYNY3i9l0jyl1a79D2zVUUQurldxru/GOZqfFLQKn3FfQwrsYvzwfenHhZLFIhbKcg57lujk6e6ZFYgs3urqLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262870; c=relaxed/simple;
	bh=z4vdrWeVtu9sodxpbIrxjQuubvK+Sc7StmsX9jHc5zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Azn+84miwMTUiu/fOnKMhUrDTWfb8uXreZf+TyFd4TxZ8TUqX1jlbtGKQrnIZ8b+MRYRk/Y+r35yPIafDwBMJsL2IfibS7ZusD4QsvTDexSWyPmajdQL4eW428IzFVzcvqXoAfUuL6VhfAM4YM5zqT0eMlB19H3WCFoLyLK+7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i93GAK30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA2DC19421;
	Tue, 13 Jan 2026 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262870;
	bh=z4vdrWeVtu9sodxpbIrxjQuubvK+Sc7StmsX9jHc5zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i93GAK30tuuwLMjj/IdJUNXRBb6UTJGkQQePelqxozIkEHqnxUcBx3krF3HcryXys
	 Sc+OQuzzPsnkSQLh40pBkWgWe9ex0Abro7r3JxVPBFB0wctGax1Eq/HpMTU+tjQf7z
	 U/5SP18g6BOyOhwICeFSXYnmGoQ5NzEDjZAAR1xijRnGFkSnGIyTPg4d4LMaT0WzU+
	 mT5X9MNkjQQcwHARm8eQKGkqrJ4VbPh3zZPdfQYy1G5RbzOtFx0TMreESOHbmv4UrF
	 ni1t8JiYRquzSyuGDeLXkOqB/z4Dfp9VIntZaF5msnKOcQ7/9q+CEeL20Rag0X0KNC
	 0qOwVCfKiYORA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 6/6] selftests: drv-net: gro: break out all individual test cases
Date: Mon, 12 Jan 2026 16:07:40 -0800
Message-ID: <20260113000740.255360-7-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
References: <20260113000740.255360-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO test groups the cases into categories, e.g. "tcp" case
checks coalescing in presence of:
 - packets with bad csum,
 - sequence number mismatch,
 - timestamp option value mismatch,
 - different TCP options.

Since we now have TAP support grouping the cases like that
lowers our reporting granularity. This matters even more for
NICs performing HW GRO and LRO since it appears that most
implementation have _some_ bugs. Flagging the whole group
of tests as failed prevents us from catching regressions
in the things that work today.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - add enum for the flush_id test configs
v2: https://lore.kernel.org/20260110005121.3561437-7-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/gro.c  | 433 ++++++++++++---------
 tools/testing/selftests/drivers/net/gro.py |  65 +++-
 2 files changed, 308 insertions(+), 190 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index 751a8103f408..e76c618704cf 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -3,26 +3,45 @@
  * This testsuite provides conformance testing for GRO coalescing.
  *
  * Test cases:
- * 1.data
+ *
+ * data_*:
  *  Data packets of the same size and same header setup with correct
  *  sequence numbers coalesce. The one exception being the last data
  *  packet coalesced: it can be smaller than the rest and coalesced
  *  as long as it is in the same flow.
- * 2.ack
+ *   - data_same:    same size packets coalesce
+ *   - data_lrg_sml: large then small coalesces
+ *   - data_sml_lrg: small then large doesn't coalesce
+ *
+ * ack:
  *  Pure ACK does not coalesce.
- * 3.flags
- *  Specific test cases: no packets with PSH, SYN, URG, RST set will
- *  be coalesced.
- * 4.tcp
+ *
+ * flags_*:
+ *  No packets with PSH, SYN, URG, RST set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *
+ * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
  *  different TCP header options shouldn't coalesce. Nit: given that
  *  some extension headers have paddings, such as timestamp, headers
- *  that are padding differently would not be coalesced.
- * 5.ip:
- *  Packets with different (ECN, TTL, TOS) header, ip options or
- *  ip fragments (ipv6) shouldn't coalesce.
- * 6.large:
+ *  that are padded differently would not be coalesced.
+ *   - tcp_csum: incorrect checksum
+ *   - tcp_seq:  non-consecutive sequence numbers
+ *   - tcp_ts:   different timestamps
+ *   - tcp_opt:  different TCP options
+ *
+ * ip_*:
+ *  Packets with different (ECN, TTL, TOS) header, IP options or
+ *  IP fragments shouldn't coalesce.
+ *   - ip_ecn, ip_tos:            shared between IPv4/IPv6
+ *   - ip_ttl, ip_opt, ip_frag4:  IPv4 only
+ *   - ip_id_df*:                 IPv4 IP ID field coalescing tests
+ *   - ip_frag6, ip_v6ext_*:      IPv6 only
+ *
+ * large_*:
  *  Packets larger than GRO_MAX_SIZE packets shouldn't coalesce.
+ *   - large_max: exceeding max size
+ *   - large_rem: remainder handling
  *
  * MSS is defined as 4096 - header because if it is too small
  * (i.e. 1500 MTU - header), it will result in many packets,
@@ -79,6 +98,15 @@
 #define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
+enum flush_id_case {
+	FLUSH_ID_DF1_INC,
+	FLUSH_ID_DF1_FIXED,
+	FLUSH_ID_DF0_INC,
+	FLUSH_ID_DF0_FIXED,
+	FLUSH_ID_DF1_INC_FIXED,
+	FLUSH_ID_DF1_FIXED_INC,
+};
+
 static const char *addr6_src = "fdaa::2";
 static const char *addr6_dst = "fdaa::1";
 static const char *addr4_src = "192.168.1.200";
@@ -95,7 +123,6 @@ static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
 static bool ipip;
-static const int num_flush_id_cases = 6;
 
 static void vlog(const char *fmt, ...)
 {
@@ -127,19 +154,19 @@ static void setup_sock_filter(int fd)
 	/* Overridden later if exthdrs are used: */
 	opt_ipproto_off = ipproto_off;
 
-	if (strcmp(testname, "ip") == 0) {
-		if (proto == PF_INET)
-			optlen = sizeof(struct ip_timestamp);
-		else {
-			BUILD_BUG_ON(sizeof(struct ip6_hbh) > MIN_EXTHDR_SIZE);
-			BUILD_BUG_ON(sizeof(struct ip6_dest) > MIN_EXTHDR_SIZE);
-			BUILD_BUG_ON(sizeof(struct ip6_frag) > MIN_EXTHDR_SIZE);
+	if (strcmp(testname, "ip_opt") == 0) {
+		optlen = sizeof(struct ip_timestamp);
+	} else if (strcmp(testname, "ip_frag6") == 0 ||
+		   strcmp(testname, "ip_v6ext_same") == 0 ||
+		   strcmp(testname, "ip_v6ext_diff") == 0) {
+		BUILD_BUG_ON(sizeof(struct ip6_hbh) > MIN_EXTHDR_SIZE);
+		BUILD_BUG_ON(sizeof(struct ip6_dest) > MIN_EXTHDR_SIZE);
+		BUILD_BUG_ON(sizeof(struct ip6_frag) > MIN_EXTHDR_SIZE);
 
-			/* same size for HBH and Fragment extension header types */
-			optlen = MIN_EXTHDR_SIZE;
-			opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr)
-				+ offsetof(struct ip6_ext, ip6e_nxt);
-		}
+		/* same size for HBH and Fragment extension header types */
+		optlen = MIN_EXTHDR_SIZE;
+		opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr)
+			+ offsetof(struct ip6_ext, ip6e_nxt);
 	}
 
 	/* this filter validates the following:
@@ -648,7 +675,8 @@ static void fix_ip4_checksum(struct iphdr *iph)
 	iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
 }
 
-static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
+static void send_flush_id_case(int fd, struct sockaddr_ll *daddr,
+			       enum flush_id_case tcase)
 {
 	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
 	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
@@ -667,7 +695,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
 
 	switch (tcase) {
-	case 0: /* DF=1, Incrementing - should coalesce */
+	case FLUSH_ID_DF1_INC: /* DF=1, Incrementing - should coalesce */
 		iph1->frag_off |= htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -675,7 +703,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(9);
 		break;
 
-	case 1: /* DF=1, Fixed - should coalesce */
+	case FLUSH_ID_DF1_FIXED: /* DF=1, Fixed - should coalesce */
 		iph1->frag_off |= htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -683,7 +711,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(8);
 		break;
 
-	case 2: /* DF=0, Incrementing - should coalesce */
+	case FLUSH_ID_DF0_INC: /* DF=0, Incrementing - should coalesce */
 		iph1->frag_off &= ~htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -691,7 +719,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(9);
 		break;
 
-	case 3: /* DF=0, Fixed - should coalesce */
+	case FLUSH_ID_DF0_FIXED: /* DF=0, Fixed - should coalesce */
 		iph1->frag_off &= ~htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -699,9 +727,10 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(8);
 		break;
 
-	case 4: /* DF=1, two packets incrementing, and one fixed - should
-		 * coalesce only the first two packets
-		 */
+	case FLUSH_ID_DF1_INC_FIXED: /* DF=1, two packets incrementing, and
+				      * one fixed - should coalesce only the
+				      * first two packets
+				      */
 		iph1->frag_off |= htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -713,9 +742,10 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		send_three = true;
 		break;
 
-	case 5: /* DF=1, two packets fixed, and one incrementing - should
-		 * coalesce only the first two packets
-		 */
+	case FLUSH_ID_DF1_FIXED_INC: /* DF=1, two packets fixed, and one
+				      * incrementing - should coalesce only
+				      * the first two packets
+				      */
 		iph1->frag_off |= htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -739,16 +769,6 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 	}
 }
 
-static void test_flush_id(int fd, struct sockaddr_ll *daddr, char *fin_pkt)
-{
-	for (int i = 0; i < num_flush_id_cases; i++) {
-		sleep(1);
-		send_flush_id_case(fd, daddr, i);
-		sleep(1);
-		write_packet(fd, fin_pkt, total_hdr_len, daddr);
-	}
-}
-
 static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr, char *ext_data1, char *ext_data2)
 {
 	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
@@ -1030,108 +1050,128 @@ static void gro_sender(void)
 	daddr.sll_halen = ETH_ALEN;
 	create_packet(fin_pkt, PAYLOAD_LEN * 2, 0, 0, 1);
 
-	if (strcmp(testname, "data") == 0) {
+	/* data sub-tests */
+	if (strcmp(testname, "data_same") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN, PAYLOAD_LEN);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "data_lrg_sml") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN, PAYLOAD_LEN / 2);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "data_sml_lrg") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN / 2, PAYLOAD_LEN);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+	/* ack test */
 	} else if (strcmp(testname, "ack") == 0) {
 		send_ack(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-	} else if (strcmp(testname, "flags") == 0) {
+
+	/* flags sub-tests */
+	} else if (strcmp(testname, "flags_psh") == 0) {
 		send_flags(txfd, &daddr, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "flags_syn") == 0) {
 		send_flags(txfd, &daddr, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "flags_rst") == 0) {
 		send_flags(txfd, &daddr, 0, 0, 1, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "flags_urg") == 0) {
 		send_flags(txfd, &daddr, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-	} else if (strcmp(testname, "tcp") == 0) {
+
+	/* tcp sub-tests */
+	} else if (strcmp(testname, "tcp_csum") == 0) {
 		send_changed_checksum(txfd, &daddr);
-		/* Adding sleep before sending FIN so that it is not
-		 * received prior to other packets.
-		 */
 		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "tcp_seq") == 0) {
 		send_changed_seq(txfd, &daddr);
 		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "tcp_ts") == 0) {
 		send_changed_ts(txfd, &daddr);
 		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "tcp_opt") == 0) {
 		send_diff_opt(txfd, &daddr);
 		usleep(fin_delay_us);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-	} else if (strcmp(testname, "ip") == 0) {
+
+	/* ip sub-tests - shared between IPv4 and IPv6 */
+	} else if (strcmp(testname, "ip_ecn") == 0) {
 		send_changed_ECN(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
+	} else if (strcmp(testname, "ip_tos") == 0) {
 		send_changed_tos(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-		if (proto == PF_INET) {
-			/* Modified packets may be received out of order.
-			 * Sleep function added to enforce test boundaries
-			 * so that fin pkts are not received prior to other pkts.
-			 */
-			sleep(1);
-			send_changed_ttl(txfd, &daddr);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-			sleep(1);
-			send_ip_options(txfd, &daddr);
-			sleep(1);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_ttl") == 0) {
+		send_changed_ttl(txfd, &daddr);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_opt") == 0) {
+		send_ip_options(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_frag4") == 0) {
+		send_fragment4(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_inc") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF1_INC);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF1_FIXED);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df0_inc") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF0_INC);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df0_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF0_FIXED);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_inc_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF1_INC_FIXED);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_fixed_inc") == 0) {
+		send_flush_id_case(txfd, &daddr, FLUSH_ID_DF1_FIXED_INC);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-			sleep(1);
-			send_fragment4(txfd, &daddr);
-			sleep(1);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	/* ip sub-tests - IPv6 only */
+	} else if (strcmp(testname, "ip_frag6") == 0) {
+		send_fragment6(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_v6ext_same") == 0) {
+		send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_1);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_v6ext_diff") == 0) {
+		send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_2);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-			test_flush_id(txfd, &daddr, fin_pkt);
-		} else if (proto == PF_INET6) {
-			sleep(1);
-			send_fragment6(txfd, &daddr);
-			sleep(1);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
-			sleep(1);
-			/* send IPv6 packets with ext header with same payload */
-			send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_1);
-			sleep(1);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-
-			sleep(1);
-			/* send IPv6 packets with ext header with different payload */
-			send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_2);
-			sleep(1);
-			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
-		}
-	} else if (strcmp(testname, "large") == 0) {
-		/* 20 is the difference between min iphdr size
-		 * and min ipv6hdr size. Like MAX_HDR_SIZE,
-		 * MAX_PAYLOAD is defined with the larger header of the two.
-		 */
+	/* large sub-tests */
+	} else if (strcmp(testname, "large_max") == 0) {
 		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
 		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
 		send_large(txfd, &daddr, remainder);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "large_rem") == 0) {
+		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
+		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
 		send_large(txfd, &daddr, remainder + 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else {
-		error(1, 0, "Unknown testcase");
+		error(1, 0, "Unknown testcase: %s", testname);
 	}
 
 	if (close(txfd))
@@ -1155,126 +1195,153 @@ static void gro_receiver(void)
 
 	memset(correct_payload, 0, sizeof(correct_payload));
 
-	if (strcmp(testname, "data") == 0) {
+	/* data sub-tests */
+	if (strcmp(testname, "data_same") == 0) {
 		printf("pure data packet of same size: ");
 		correct_payload[0] = PAYLOAD_LEN * 2;
 		check_recv_pkts(rxfd, correct_payload, 1);
-
+	} else if (strcmp(testname, "data_lrg_sml") == 0) {
 		printf("large data packets followed by a smaller one: ");
 		correct_payload[0] = PAYLOAD_LEN * 1.5;
 		check_recv_pkts(rxfd, correct_payload, 1);
-
+	} else if (strcmp(testname, "data_sml_lrg") == 0) {
 		printf("small data packets followed by a larger one: ");
 		correct_payload[0] = PAYLOAD_LEN / 2;
 		correct_payload[1] = PAYLOAD_LEN;
 		check_recv_pkts(rxfd, correct_payload, 2);
+
+	/* ack test */
 	} else if (strcmp(testname, "ack") == 0) {
 		printf("duplicate ack and pure ack: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
-	} else if (strcmp(testname, "flags") == 0) {
+
+	/* flags sub-tests */
+	} else if (strcmp(testname, "flags_psh") == 0) {
 		correct_payload[0] = PAYLOAD_LEN * 3;
 		correct_payload[1] = PAYLOAD_LEN * 2;
-
 		printf("psh flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
-
+	} else if (strcmp(testname, "flags_syn") == 0) {
 		correct_payload[0] = PAYLOAD_LEN * 2;
 		correct_payload[1] = 0;
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("syn flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
-
+	} else if (strcmp(testname, "flags_rst") == 0) {
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = 0;
+		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("rst flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
-
+	} else if (strcmp(testname, "flags_urg") == 0) {
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = 0;
+		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
-	} else if (strcmp(testname, "tcp") == 0) {
+
+	/* tcp sub-tests */
+	} else if (strcmp(testname, "tcp_csum") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
+		printf("changed checksum does not coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "tcp_seq") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		printf("Wrong Seq number doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "tcp_ts") == 0) {
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN;
 		correct_payload[2] = PAYLOAD_LEN;
 		correct_payload[3] = PAYLOAD_LEN;
-
-		printf("changed checksum does not coalesce: ");
-		check_recv_pkts(rxfd, correct_payload, 2);
-
-		printf("Wrong Seq number doesn't coalesce: ");
-		check_recv_pkts(rxfd, correct_payload, 2);
-
 		printf("Different timestamp doesn't coalesce: ");
-		correct_payload[0] = PAYLOAD_LEN * 2;
 		check_recv_pkts(rxfd, correct_payload, 4);
-
-		printf("Different options doesn't coalesce: ");
+	} else if (strcmp(testname, "tcp_opt") == 0) {
 		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN;
+		printf("Different options doesn't coalesce: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
-	} else if (strcmp(testname, "ip") == 0) {
+
+	/* ip sub-tests - shared between IPv4 and IPv6 */
+	} else if (strcmp(testname, "ip_ecn") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
-
 		printf("different ECN doesn't coalesce: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
-
+	} else if (strcmp(testname, "ip_tos") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
 		printf("different tos doesn't coalesce: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
 
-		if (proto == PF_INET) {
-			printf("different ttl doesn't coalesce: ");
-			check_recv_pkts(rxfd, correct_payload, 2);
+	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_ttl") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		printf("different ttl doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "ip_opt") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		correct_payload[2] = PAYLOAD_LEN;
+		printf("ip options doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "ip_frag4") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		printf("fragmented ip4 doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "ip_id_df1_inc") == 0) {
+		printf("DF=1, Incrementing - should coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "ip_id_df1_fixed") == 0) {
+		printf("DF=1, Fixed - should coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "ip_id_df0_inc") == 0) {
+		printf("DF=0, Incrementing - should coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "ip_id_df0_fixed") == 0) {
+		printf("DF=0, Fixed - should coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "ip_id_df1_inc_fixed") == 0) {
+		printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN;
+		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "ip_id_df1_fixed_inc") == 0) {
+		printf("DF=1, 2 Fixed and one incrementing - should coalesce only first 2 packets: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN;
+		check_recv_pkts(rxfd, correct_payload, 2);
 
-			printf("ip options doesn't coalesce: ");
-			correct_payload[2] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 3);
+	/* ip sub-tests - IPv6 only */
+	} else if (strcmp(testname, "ip_frag6") == 0) {
+		/* GRO doesn't check for ipv6 hop limit when flushing.
+		 * Hence no corresponding test to the ipv4 case.
+		 */
+		printf("fragmented ip6 doesn't coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN;
+		correct_payload[2] = PAYLOAD_LEN;
+		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "ip_v6ext_same") == 0) {
+		printf("ipv6 with ext header does coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "ip_v6ext_diff") == 0) {
+		printf("ipv6 with ext header with different payloads doesn't coalesce: ");
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		check_recv_pkts(rxfd, correct_payload, 2);
 
-			printf("fragmented ip4 doesn't coalesce: ");
-			check_recv_pkts(rxfd, correct_payload, 2);
-
-			/* is_atomic checks */
-			printf("DF=1, Incrementing - should coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 1);
-
-			printf("DF=1, Fixed - should coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 1);
-
-			printf("DF=0, Incrementing - should coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 1);
-
-			printf("DF=0, Fixed - should coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 1);
-
-			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
-
-			printf("DF=1, 2 Fixed and one incrementing - should coalesce only first 2 packets: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
-		} else if (proto == PF_INET6) {
-			/* GRO doesn't check for ipv6 hop limit when flushing.
-			 * Hence no corresponding test to the ipv4 case.
-			 */
-			printf("fragmented ip6 doesn't coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			correct_payload[1] = PAYLOAD_LEN;
-			correct_payload[2] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 3);
-
-			printf("ipv6 with ext header does coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 1);
-
-			printf("ipv6 with ext header with different payloads doesn't coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
-		}
-	} else if (strcmp(testname, "large") == 0) {
+	/* large sub-tests */
+	} else if (strcmp(testname, "large_max") == 0) {
 		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
 		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
@@ -1282,14 +1349,18 @@ static void gro_receiver(void)
 		correct_payload[1] = remainder;
 		printf("Shouldn't coalesce if exceed IP max pkt size: ");
 		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "large_rem") == 0) {
+		int offset = (proto == PF_INET && !ipip) ? 20 : 0;
+		int remainder = (MAX_PAYLOAD + offset) % MSS;
 
 		/* last segment sent individually, doesn't start new segment */
-		correct_payload[0] = correct_payload[0] - remainder;
+		correct_payload[0] = (MAX_PAYLOAD + offset) - remainder;
 		correct_payload[1] = remainder + 1;
 		correct_payload[2] = remainder + 1;
+		printf("last segment sent individually: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
 	} else {
-		error(1, 0, "Test case error, should never trigger");
+		error(1, 0, "Test case error: unknown testname %s", testname);
 	}
 
 	if (close(rxfd))
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1ab85590c439..1bb8af571456 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -9,12 +9,29 @@ binary in different configurations and checking for correct packet
 coalescing behavior.
 
 Test cases:
-  - data: Data packets with same size/headers and correct seq numbers coalesce
+  - data_same: Same size data packets coalesce
+  - data_lrg_sml: Large packet followed by smaller one coalesces
+  - data_sml_lrg: Small packet followed by larger one doesn't coalesce
   - ack: Pure ACK packets do not coalesce
-  - flags: Packets with PSH, SYN, URG, RST flags do not coalesce
-  - tcp: Packets with incorrect checksum, non-consecutive seqno don't coalesce
-  - ip: Packets with different ECN, TTL, TOS, or IP options don't coalesce
-  - large: Packets larger than GRO_MAX_SIZE don't coalesce
+  - flags_psh: Packets with PSH flag don't coalesce
+  - flags_syn: Packets with SYN flag don't coalesce
+  - flags_rst: Packets with RST flag don't coalesce
+  - flags_urg: Packets with URG flag don't coalesce
+  - tcp_csum: Packets with incorrect checksum don't coalesce
+  - tcp_seq: Packets with non-consecutive seqno don't coalesce
+  - tcp_ts: Packets with different timestamp options don't coalesce
+  - tcp_opt: Packets with different TCP options don't coalesce
+  - ip_ecn: Packets with different ECN don't coalesce
+  - ip_tos: Packets with different TOS don't coalesce
+  - ip_ttl: (IPv4) Packets with different TTL don't coalesce
+  - ip_opt: (IPv4) Packets with IP options don't coalesce
+  - ip_frag4: (IPv4) IPv4 fragments don't coalesce
+  - ip_id_df*: (IPv4) IP ID field coalescing tests
+  - ip_frag6: (IPv6) IPv6 fragments don't coalesce
+  - ip_v6ext_same: (IPv6) IPv6 ext header with same payload coalesces
+  - ip_v6ext_diff: (IPv6) IPv6 ext header with different payload doesn't coalesce
+  - large_max: Packets exceeding GRO_MAX_SIZE don't coalesce
+  - large_rem: Large packet remainder handling
 """
 
 import os
@@ -107,8 +124,8 @@ from lib.py import ksft_variants
         cfg.remote_feat = ethtool(f"-k {cfg.remote_ifname}",
                                   host=cfg.remote, json=True)[0]
 
-    # "large" test needs at least 4k MTU
-    if test_name == "large":
+    # "large_*" tests need at least 4k MTU
+    if test_name.startswith("large_"):
         _set_mtu_restore(cfg.dev, 4096, None)
         _set_mtu_restore(cfg.remote_dev, 4096, cfg.remote)
 
@@ -170,11 +187,41 @@ from lib.py import ksft_variants
 def _gro_variants():
     """Generator that yields all combinations of protocol and test types."""
 
+    # Tests that work for all protocols
+    common_tests = [
+        "data_same", "data_lrg_sml", "data_sml_lrg",
+        "ack",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
+        "ip_ecn", "ip_tos",
+        "large_max", "large_rem",
+    ]
+
+    # Tests specific to IPv4
+    ipv4_tests = [
+        "ip_ttl", "ip_opt", "ip_frag4",
+        "ip_id_df1_inc", "ip_id_df1_fixed",
+        "ip_id_df0_inc", "ip_id_df0_fixed",
+        "ip_id_df1_inc_fixed", "ip_id_df1_fixed_inc",
+    ]
+
+    # Tests specific to IPv6
+    ipv6_tests = [
+        "ip_frag6", "ip_v6ext_same", "ip_v6ext_diff",
+    ]
+
     for mode in ["sw", "hw", "lro"]:
         for protocol in ["ipv4", "ipv6", "ipip"]:
-            for test_name in ["data", "ack", "flags", "tcp", "ip", "large"]:
+            for test_name in common_tests:
                 yield mode, protocol, test_name
 
+            if protocol in ["ipv4", "ipip"]:
+                for test_name in ipv4_tests:
+                    yield mode, protocol, test_name
+            elif protocol == "ipv6":
+                for test_name in ipv6_tests:
+                    yield mode, protocol, test_name
+
 
 @ksft_variants(_gro_variants())
 def test(cfg, mode, protocol, test_name):
@@ -215,7 +262,7 @@ from lib.py import ksft_variants
 
         ksft_pr(rx_proc)
 
-        if test_name == "large" and os.environ.get("KSFT_MACHINE_SLOW"):
+        if test_name.startswith("large_") and os.environ.get("KSFT_MACHINE_SLOW"):
             ksft_pr(f"Ignoring {protocol}/{test_name} failure due to slow environment")
             return
 
-- 
2.52.0


