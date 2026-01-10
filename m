Return-Path: <linux-kselftest+bounces-48646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43FD0CAA5
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05473306647F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF22046BA;
	Sat, 10 Jan 2026 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uciLmsAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3921EF0B9;
	Sat, 10 Jan 2026 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006304; cv=none; b=IEA6txdBnYQrAkRFEbBky22YwXJwdYvP/TRSSmGzaPDGoyuiUDeDDxrLFbyR5G1fajoMokczQ54hwe83d3PXObGe618ifhU7rll7xWqXTvBRnSegLx+LmPxXbL3lYQPO3InwE6uQfbjXusdeZg2F8Q8SMACwYVFfkzlSw4AuZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006304; c=relaxed/simple;
	bh=VqsK6YRFy4EuQOXzJBSBLX9jZm/ht8B57RXMHGQqUW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anH1XGaPO/apj+uVCq84EG9V2LPPlGegmmZNWy7I+uWmnT1VnTuekmP/wKrafaifpy1L+0jYNG8S2ZZ4A88b0QT0PXuNjE4GacXq/679mwc0vw1kNpclpt+hSBoRdhd4WRJyHPBmSLpjdIV/tCWbJ1e3/IPdmajkfsujln0KvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uciLmsAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1E9C16AAE;
	Sat, 10 Jan 2026 00:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006302;
	bh=VqsK6YRFy4EuQOXzJBSBLX9jZm/ht8B57RXMHGQqUW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uciLmsAXv+uPeVRdZ16p3ahH5fd+IfHBA4qQdTheLJsIsRn0cOAjCaHRp4eBPfHFH
	 XdCm1xHOpYlq3YBngcoAJ2ZmodDcoKUs87rjLf+/XaF8wmzcOJaSPC7UgDJYFUCcr5
	 9vGqyg3nQFMN1BNM67D5PZP7cT1YJzm+scfbpw7E1zzUljKpmopQeUyioffHxIxwMf
	 einfXth9hS219d7SM12hM2z4RCwrG8qb8Fuw+3aYWKUJACSeE9NRcE7VC6AkCz+RPi
	 QjVPvOcLarCMCotAA46i8hG/6/80cM+c8JSrIsUFLHu6GsqdJlfFa/VkjqGAXxomZ5
	 iC/2DThJ20Bzw==
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
Subject: [PATCH net-next v2 6/6] selftests: drv-net: gro: break out all individual test cases
Date: Fri,  9 Jan 2026 16:51:21 -0800
Message-ID: <20260110005121.3561437-7-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110005121.3561437-1-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/gro.c  | 399 ++++++++++++---------
 tools/testing/selftests/drivers/net/gro.py |  65 +++-
 2 files changed, 285 insertions(+), 179 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e894037d2e3e..a5838de97ba8 100644
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
@@ -95,7 +114,6 @@ static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
 static bool ipip;
-static const int num_flush_id_cases = 6;
 
 static void vlog(const char *fmt, ...)
 {
@@ -127,19 +145,19 @@ static void setup_sock_filter(int fd)
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
@@ -739,16 +757,6 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
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
@@ -1008,108 +1016,128 @@ static void gro_sender(void)
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
+		send_flush_id_case(txfd, &daddr, 0);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, 1);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df0_inc") == 0) {
+		send_flush_id_case(txfd, &daddr, 2);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df0_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, 3);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_inc_fixed") == 0) {
+		send_flush_id_case(txfd, &daddr, 4);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "ip_id_df1_fixed_inc") == 0) {
+		send_flush_id_case(txfd, &daddr, 5);
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
@@ -1132,126 +1160,153 @@ static void gro_receiver(void)
 
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
 
@@ -1259,14 +1314,18 @@ static void gro_receiver(void)
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
index 112560482d04..08b22d7857bd 100755
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
 
@@ -165,11 +182,41 @@ from lib.py import ksft_variants
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
@@ -210,7 +257,7 @@ from lib.py import ksft_variants
 
         ksft_pr(rx_proc)
 
-        if test_name == "large" and os.environ.get("KSFT_MACHINE_SLOW"):
+        if test_name.startswith("large_") and os.environ.get("KSFT_MACHINE_SLOW"):
             ksft_pr(f"Ignoring {protocol}/{test_name} failure due to slow environment")
             return
 
-- 
2.52.0


