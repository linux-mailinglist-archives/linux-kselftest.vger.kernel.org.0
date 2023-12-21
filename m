Return-Path: <linux-kselftest+bounces-2314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7C81BEC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24706B234A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578C6519F;
	Thu, 21 Dec 2023 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHqSD+RS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE266518D;
	Thu, 21 Dec 2023 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so11206565e9.3;
        Thu, 21 Dec 2023 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703185169; x=1703789969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prT5zhWN3Xwvhx/dTTcm4J0NQjHP/BjQ2cfs9rXhsKs=;
        b=lHqSD+RSsDjFxrJEMe6Qoe0zxcgBrD8zkmFqYW2ePmh1XtshVem307PtC0MQTXorx7
         U86y1TFVtneYga/IBKShDqaEuwSPrDMC6hAFRC/XHPOxnZy3ccUUXfCX0LPtiUiTVbef
         N/QrKNyKvH+POorpXyer4+0kO109HKNfNHAow5jog92QlImDbjlhQDt9mpGlO/pcNYOB
         fH08xKdweRr/Hw1IpzNvAq70R9Aqh5yvYQueazOVN3DDzoD+Hya2w61IutNPiQqeE5vc
         m5gra0d/KGRjD3FO1CTVRBISJ6itpbgmVf4jWX2hn1sncKj7H/9rEyn0ZX+aW+WtzpTY
         yMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185169; x=1703789969;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prT5zhWN3Xwvhx/dTTcm4J0NQjHP/BjQ2cfs9rXhsKs=;
        b=M8cY33Dm+uC+WieVo2jfP3FKC+DnHs9FMn94wwXSoHN4LZ+kOdDbNSv1gQqrE2qj1y
         aqhPc63ppSFL+i9YEAXlSbY2djkys47rJs9qxcAoz4RcT68y8l9cwDR5sli9jmzN5yRy
         rITspeehYoWPUQRwxttSjzyjNI0WslFymlrynOxfZKe9q98vE2R0/ajCP3DPp1cQTOrJ
         RNbR99nItDFxENyU6dhLK5tqPE4t8kHmFpvQpgCH+ExKMZyF8YglXJKsn+GQVUeuItti
         vw/XXofUVSET0ahN0PNY1jLdrMWN2b527NwYW3PxnS/SsYx5kPANwycnp8gadVsa4zcS
         CLXQ==
X-Gm-Message-State: AOJu0Yxk94nxpJg7I/5yi9v20fDJBxdpuE9OIh4EOSE3RBnuVBbkx/uJ
	Pf29nkewFTQA0JuJJDANAd8=
X-Google-Smtp-Source: AGHT+IGcfjzOQgIK3oE5a0xkZ7F3VXQnA2OqVx/WoldDgtxZW8s2O5rFIGVBr5oJ6hVqxbxAUbsFww==
X-Received: by 2002:a05:600c:4f0f:b0:40c:2cc5:4539 with SMTP id l15-20020a05600c4f0f00b0040c2cc54539mr99103wmq.23.1703185168870;
        Thu, 21 Dec 2023 10:59:28 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b004053e9276easm11868269wmo.32.2023.12.21.10.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:59:28 -0800 (PST)
Message-ID: <641157c0-f224-4910-874d-7906a48d914b@gmail.com>
Date: Thu, 21 Dec 2023 19:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 3/3] selftests/net: fix GRO coalesce test and add ext
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
In-Reply-To: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently there is no test which checks that IPv6 extension header packets
successfully coalesce. This commit adds a test, which verifies two IPv6
packets with HBH extension headers do coalesce.

I changed the receive socket filter to accept a packet with one extension
header. This change exposed a bug in the fragment test -- the old BPF did
not accept the fragment packet. I updated correct_num_packets in the
fragment test accordingly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/gro.c | 78 ++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 30024d0ed373..4ee34dca8e5f 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -71,6 +71,10 @@
 #define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
 #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
 #define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+#define MIN_EXTHDR_SIZE 8   /* minimum size of IPv6 extension header */
+
+#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
+
 
 static const char *addr6_src = "fdaa::2";
 static const char *addr6_dst = "fdaa::1";
@@ -104,7 +108,7 @@ static void setup_sock_filter(int fd)
 	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
 	const int ethproto_off = offsetof(struct ethhdr, h_proto);
 	int optlen = 0;
-	int ipproto_off;
+	int ipproto_off, opt_ipproto_off;
 	int next_off;
 
 	if (proto == PF_INET)
@@ -116,14 +120,27 @@ static void setup_sock_filter(int fd)
 	if (strcmp(testname, "ip") == 0) {
 		if (proto == PF_INET)
 			optlen = sizeof(struct ip_timestamp);
-		else
-			optlen = sizeof(struct ip6_frag);
+		else {
+			// same size for HBH and Fragment extension header types
+			optlen = MIN_EXTHDR_SIZE;
+			opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr) +
+				offsetof(struct ip6_ext, ip6e_nxt);
+		}
 	}
 
+	/*
+	 * this filter validates the following:
+	 *	- packet is IPv4/IPv6 according to the running test.
+	 *	- packet is TCP. Also handles the case of one extension header and then TCP.
+	 *	- checks the packet tcp dport equals to DPORT.
+	 *     (also handles the case of one extension header and then TCP.)
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
@@ -576,6 +593,39 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
 	iph->check = checksum_fold(iph, sizeof(struct iphdr) + optlen, 0);
 }
 
+static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type)
+{
+	struct ipv6_opt_hdr *hbh_hdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
+	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
+	int opt_len;
+
+	hbh_hdr->hdrlen = 0;
+	hbh_hdr->nexthdr = IPPROTO_TCP;
+	opt_len = ipv6_optlen(hbh_hdr);
+
+	memcpy(optpkt, buf, tcp_offset);
+	memcpy(optpkt + tcp_offset + MIN_EXTHDR_SIZE, buf + tcp_offset,
+		sizeof(struct tcphdr) + PAYLOAD_LEN);
+
+	iph->nexthdr = exthdr_type;
+	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
+}
+
+/* Send IPv6 packet with extension header */
+static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr)
+{
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char exthdr_pck[sizeof(buf) + MIN_EXTHDR_SIZE];
+
+	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
+	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
+
+	create_packet(buf, PAYLOAD_LEN * 1, 0, PAYLOAD_LEN, 0);
+	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
+	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
+}
+
 /* IPv4 options shouldn't coalesce */
 static void send_ip_options(int fd, struct sockaddr_ll *daddr)
 {
@@ -697,7 +747,7 @@ static void send_fragment6(int fd, struct sockaddr_ll *daddr)
 		create_packet(buf, PAYLOAD_LEN * i, 0, PAYLOAD_LEN, 0);
 		write_packet(fd, buf, bufpkt_len, daddr);
 	}
-
+	sleep(1);
 	create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
 	memset(extpkt, 0, extpkt_len);
 
@@ -760,6 +810,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 	vlog("}, Total %d packets\nReceived {", correct_num_pkts);
 
 	while (1) {
+		ip_ext_len = 0;
 		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
 		if (pkt_size < 0)
 			error(1, errno, "could not receive");
@@ -767,7 +818,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 		if (iph->version == 4)
 			ip_ext_len = (iph->ihl - 5) * 4;
 		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
-			ip_ext_len = sizeof(struct ip6_frag);
+			ip_ext_len = MIN_EXTHDR_SIZE;
 
 		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
 
@@ -880,7 +931,14 @@ static void gro_sender(void)
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 		} else if (proto == PF_INET6) {
+			sleep(1);
 			send_fragment6(txfd, &daddr);
+			sleep(1);
+			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			sleep(1);
+			send_ipv6_exthdr(txfd, &daddr);
+			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 		}
 	} else if (strcmp(testname, "large") == 0) {
@@ -997,7 +1055,13 @@ static void gro_receiver(void)
 			 */
 			printf("fragmented ip6 doesn't coalesce: ");
 			correct_payload[0] = PAYLOAD_LEN * 2;
-			check_recv_pkts(rxfd, correct_payload, 2);
+			correct_payload[1] = PAYLOAD_LEN;
+			correct_payload[2] = PAYLOAD_LEN;
+			check_recv_pkts(rxfd, correct_payload, 3);
+
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			printf("ipv6 with extension header DOES coalesce: ");
+			check_recv_pkts(rxfd, correct_payload, 1);
 		}
 	} else if (strcmp(testname, "large") == 0) {
 		int offset = proto == PF_INET ? 20 : 0;
-- 
2.36.1


