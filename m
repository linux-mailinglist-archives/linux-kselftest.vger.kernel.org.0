Return-Path: <linux-kselftest+bounces-2617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B2822FD2
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806CF1F241EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF41A5BB;
	Wed,  3 Jan 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lusyfWkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813971A703;
	Wed,  3 Jan 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso4800435a12.0;
        Wed, 03 Jan 2024 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704293344; x=1704898144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo5dRLFbCi8DdkGkFyA+UxEEzSuEB3v7ILPp4RSqkrU=;
        b=lusyfWkOn89pXZg0+DFfqNapOg72FwYRTOF7WSXuF3SgkN6DdD6bvxzHw4RxNdfux4
         5t+0dB9KU+axjWsJ5RYkys2Lp92z1t00HsbuE0jXkptLh4ec701nsjkiPVcWLhZSHdjE
         6Duqek/07hZHc+KAijvGRbxyJHOCLZNlvRe1gsSHXEvFUcTjJx7cXnk9j5jLGWpZyyzE
         VXRg6EsJMttr5/EkKGDYRfcb0HIl7ikcr9FPIFWsMPHqNGls720k/UkCJxUhWgebFFO5
         mcOUgT8eov8NrvU/A0R+5ZPQyhAuf5Z634tUthwFDTzmC1xwIXjtbjwl9etNKbU1gHVr
         E9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293344; x=1704898144;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eo5dRLFbCi8DdkGkFyA+UxEEzSuEB3v7ILPp4RSqkrU=;
        b=UBZqmyjk/k1AL0rsOP6f3fYBxCDVevkhuOfrSdlIi2KAeOnLqbpOVK+binOjgI9UXH
         4W5a8s+zLqKJtCpXUfoeTJnuKm0mFCyt0PC+rVeT4vokxehKmQzfxu23dVfM+nMDK5F/
         nAKjxfHvNC455D6doeUuUSpECOAqBAYPQ0J9wOkA16PIdbHxdPJaxAVL5WCga8zpm+EM
         bbnaVl2R9s7JlE1iA/sSWNtCJXLs4dSDiMXE7voDdZZyZb4n4FXH5AULqEwpuwZzQJdG
         Y8yWkoIxge5y2WJWpJn9gPYLAOd2QMrwxgtU3wm0/NE3kGJs0xr8Ca/mSiRsJDDgDFhJ
         W5Gg==
X-Gm-Message-State: AOJu0Ywa0pXJxbVJCfj+5xgAdy+JvW2r3tv0Gk0WLBTdaJVwFVRN6dQ2
	gkKRdT04RqYeFMw5uBIBzZU=
X-Google-Smtp-Source: AGHT+IHFI0jtW0d21mVAQ5qDVxCZx/Qg8OCjZBnjfM3kA4gFFBoduMaSiiVOTSQ+kag1QFmHnwfjMw==
X-Received: by 2002:a50:bb45:0:b0:553:2294:816f with SMTP id y63-20020a50bb45000000b005532294816fmr10415516ede.3.1704293343752;
        Wed, 03 Jan 2024 06:49:03 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b0055678085e27sm2952266edt.20.2024.01.03.06.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:49:03 -0800 (PST)
Message-ID: <69282fed-2415-47e8-b3d3-34939ec3eb56@gmail.com>
Date: Wed, 3 Jan 2024 15:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v3 3/3] selftests/net: fix GRO coalesce test and add
 ext header coalesce tests
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
In-Reply-To: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently there is no test which checks that IPv6 extension header packets
successfully coalesce. This commit adds a test, which verifies two IPv6
packets with HBH extension headers do coalesce, and another test which
checks that packets with different extension header data do not coalesce
in GRO.

I changed the receive socket filter to accept a packet with one extension
header. This change exposed a bug in the fragment test -- the old BPF did
not accept the fragment packet. I updated correct_num_packets in the
fragment test accordingly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/gro.c | 93 +++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 30024d0ed373..353e1e867fbb 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -71,6 +71,12 @@
 #define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
 #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
 #define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+#define MIN_EXTHDR_SIZE 8
+#define EXT_PAYLOAD_1 "\x00\x00\x00\x00\x00\x00"
+#define EXT_PAYLOAD_2 "\x11\x11\x11\x11\x11\x11"
+
+#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
 static const char *addr6_src = "fdaa::2";
 static const char *addr6_dst = "fdaa::1";
@@ -104,7 +110,7 @@ static void setup_sock_filter(int fd)
 	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
 	const int ethproto_off = offsetof(struct ethhdr, h_proto);
 	int optlen = 0;
-	int ipproto_off;
+	int ipproto_off, opt_ipproto_off;
 	int next_off;
 
 	if (proto == PF_INET)
@@ -116,14 +122,30 @@ static void setup_sock_filter(int fd)
 	if (strcmp(testname, "ip") == 0) {
 		if (proto == PF_INET)
 			optlen = sizeof(struct ip_timestamp);
-		else
-			optlen = sizeof(struct ip6_frag);
+		else {
+			BUILD_BUG_ON(sizeof(struct ip6_hbh) > MIN_EXTHDR_SIZE);
+			BUILD_BUG_ON(sizeof(struct ip6_dest) > MIN_EXTHDR_SIZE);
+			BUILD_BUG_ON(sizeof(struct ip6_frag) > MIN_EXTHDR_SIZE);
+
+			/* same size for HBH and Fragment extension header types */
+			optlen = MIN_EXTHDR_SIZE;
+			opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr)
+				+ offsetof(struct ip6_ext, ip6e_nxt);
+		}
 	}
 
+	/* this filter validates the following:
+	 *	- packet is IPv4/IPv6 according to the running test.
+	 *	- packet is TCP. Also handles the case of one extension header and then TCP.
+	 *	- checks the packet tcp dport equals to DPORT. Also handles the case of one
+	 *	  extension header and then TCP.
+	 */
 	struct sock_filter filter[] = {
 			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, ethproto_off),
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 7),
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 9),
 			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
+			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
 			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
 			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, dport_off),
 			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, DPORT, 2, 0),
@@ -576,6 +598,39 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
 	iph->check = checksum_fold(iph, sizeof(struct iphdr) + optlen, 0);
 }
 
+static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext_payload)
+{
+	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
+	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
+	char *exthdr_payload_start = (char *)(exthdr + 1);
+
+	exthdr->hdrlen = 0;
+	exthdr->nexthdr = IPPROTO_TCP;
+
+	memcpy(exthdr_payload_start, ext_payload, MIN_EXTHDR_SIZE - sizeof(*exthdr));
+
+	memcpy(optpkt, buf, tcp_offset);
+	memcpy(optpkt + tcp_offset + MIN_EXTHDR_SIZE, buf + tcp_offset,
+		sizeof(struct tcphdr) + PAYLOAD_LEN);
+
+	iph->nexthdr = exthdr_type;
+	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
+}
+
+static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr, char *ext_data1, char *ext_data2)
+{
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char exthdr_pck[sizeof(buf) + MIN_EXTHDR_SIZE];
+
+	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS, ext_data1);
+	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
+
+	create_packet(buf, PAYLOAD_LEN * 1, 0, PAYLOAD_LEN, 0);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS, ext_data2);
+	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
+}
+
 /* IPv4 options shouldn't coalesce */
 static void send_ip_options(int fd, struct sockaddr_ll *daddr)
 {
@@ -697,7 +752,7 @@ static void send_fragment6(int fd, struct sockaddr_ll *daddr)
 		create_packet(buf, PAYLOAD_LEN * i, 0, PAYLOAD_LEN, 0);
 		write_packet(fd, buf, bufpkt_len, daddr);
 	}
-
+	sleep(1);
 	create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
 	memset(extpkt, 0, extpkt_len);
 
@@ -760,6 +815,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 	vlog("}, Total %d packets\nReceived {", correct_num_pkts);
 
 	while (1) {
+		ip_ext_len = 0;
 		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
 		if (pkt_size < 0)
 			error(1, errno, "could not receive");
@@ -767,7 +823,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 		if (iph->version == 4)
 			ip_ext_len = (iph->ihl - 5) * 4;
 		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
-			ip_ext_len = sizeof(struct ip6_frag);
+			ip_ext_len = MIN_EXTHDR_SIZE;
 
 		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
 
@@ -880,7 +936,21 @@ static void gro_sender(void)
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 		} else if (proto == PF_INET6) {
+			sleep(1);
 			send_fragment6(txfd, &daddr);
+			sleep(1);
+			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			sleep(1);
+			/* send IPv6 packets with ext header with same payload */
+			send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_1);
+			sleep(1);
+			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			sleep(1);
+			/* send IPv6 packets with ext header with different payload */
+			send_ipv6_exthdr(txfd, &daddr, EXT_PAYLOAD_1, EXT_PAYLOAD_2);
+			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 		}
 	} else if (strcmp(testname, "large") == 0) {
@@ -997,6 +1067,17 @@ static void gro_receiver(void)
 			 */
 			printf("fragmented ip6 doesn't coalesce: ");
 			correct_payload[0] = PAYLOAD_LEN * 2;
+			correct_payload[1] = PAYLOAD_LEN;
+			correct_payload[2] = PAYLOAD_LEN;
+			check_recv_pkts(rxfd, correct_payload, 3);
+
+			printf("ipv6 with ext header does coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
+
+			printf("ipv6 with ext header with different payloads doesn't coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN;
+			correct_payload[1] = PAYLOAD_LEN;
 			check_recv_pkts(rxfd, correct_payload, 2);
 		}
 	} else if (strcmp(testname, "large") == 0) {
-- 
2.36.1


