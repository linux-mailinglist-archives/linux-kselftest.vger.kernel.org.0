Return-Path: <linux-kselftest+bounces-7404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D421589C6DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF71F24067
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15EB129E7A;
	Mon,  8 Apr 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utt8VZTD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928512BEA0;
	Mon,  8 Apr 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585965; cv=none; b=j4MQPUj2DJ0eRpNr8xN8X8bJzj9WvePkUeoTNEDPL3xazZgw4vPvtldJcZJuj347P077Ly3tQ3j1KfRD13/eTrjw59c/hmgt6Jt4ykehiazQ6jeVPQVKo7DeBLCkFVa2hKGEke0pDbTHmVm5D9nNs8ZxbjOqYYHZMx8VIfODrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585965; c=relaxed/simple;
	bh=9Zp8iPX0jQlUJwfcjhF0I+ShRBkh39BZ3ToTtQd5BH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyk+m9aJMbA5+iUZ5dt3ee4urv9rGhiq2PuUlugEcngC7seGMELwK4Lep8uGPu3HqKuTbhoo1yuxf/YyYujt0AbQg5JWbQ+7saA7WN/W92X159z6MRlpBpTS8g3+KrJrfCsAmBCxC/aMeuCVIahaYKvMMGCcLKRxwmv7nFHylHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utt8VZTD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so3249561f8f.0;
        Mon, 08 Apr 2024 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585962; x=1713190762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=Utt8VZTDX0NgUq2DjKylVHQIGcK/sic+AIz44CzUcuUj1FWEW9PJEGncZD98TJo08z
         V/zKALpCBn+Gx1qhUTJgy18cqcpeDOuPhz7qet6GIGiQmcbLTO1D2rjSb/EW4qoleyHW
         tL+iKO90Vyuc7I5jZz+btkKhi6VzoURa7ZQ0ckmduS/bhAyl8pVIbVNP18beeW0EA2Xt
         fq/HezZ+BaFbbJk/7NpMclr+6f1kTSNSylfKcMqMXgAlJ3GRknVhz8LdyZrGnf8LwAc9
         aScrg82rWPSX9PRjAiRPEEqeW83R3BMBPwPe5Ew8WEEs3wrCX9/VtFaXm6EXy2VPo77n
         vYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585962; x=1713190762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=fla2ULhXWjwYyhw/5t/1th3q6D0CqdeT7kzzmYCo5XQH5OAWXj4FqNHn8GqPmka/0M
         tvb95YgRn63UJm1u+EJezUl5gdqeW1v8ozjKib7flvPvZMTf7Jz7v1f3P81IX6G/jB4Z
         LMIA8xb2gLU3fXVQm7ha3JErIJ48V/vJGZenIfSn1Qh7aJG9YAffWLig5+zmtNuE2pbt
         jPbS+1jT4C0XXpHSuzU9GZQArc9/RIye1ECO6zGFOfz7tzip0o5Se9UAkIGCgH9qG9LI
         0fYDqZhF40K4OxBVB4pano1DiJvm9cSxdDphFeVMW8o5lh/91MM/7O6uutYrU9okPXIw
         J1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo8+2MdInm8tISIECa1SDBmvNYLLZuWmrOaEDgchBS4tZeVbFhgsJagYKjBx8Kwl36B7kh2ibSLLeAZ9Zh4NftPHJiDYl1GcGl+Idbedz8PvyBgtN3PoX+65LZjnk2Z38JK7qu/NGwk2TkX/GX5qC1qdllKgvOBQXUOUg1u+6uOskbrTSO
X-Gm-Message-State: AOJu0YzXkIffMYPdKjlBC83kczneG0DyXIyiWPBMdJdU5KKkMwJXMf6H
	DPX3Yp8ZzTAgLVv6CQzKKmWTOk+xrO1DyL86oN+gegEQO3Hr6p4R
X-Google-Smtp-Source: AGHT+IHlfUYJFytj9nVduWFBw5Z46eVAybZbdGYHwguK53NUXLGJRUBhQCb9VDIJP+zJw2h83TqRbA==
X-Received: by 2002:adf:a4da:0:b0:33e:793b:a2aa with SMTP id h26-20020adfa4da000000b0033e793ba2aamr7647861wrb.47.1712585962157;
        Mon, 08 Apr 2024 07:19:22 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id e16-20020adff350000000b00343ca138924sm9057837wrp.39.2024.04.08.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:19:21 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 6/6] selftests/net: add flush id selftests
Date: Mon,  8 Apr 2024 16:17:20 +0200
Message-Id: <20240408141720.98832-7-richardbgobert@gmail.com>
In-Reply-To: <20240408141720.98832-1-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added flush id selftests to test different cases where DF flag is set or
unset and id value changes in the following packets. All cases where the
packets should coalesce or should not coalesce are tested.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/gro.c | 144 ++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 353e1e867fbb..74ab06953c38 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -617,6 +617,120 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
 	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
 }
 
+static void fix_ip4_checksum(struct iphdr *iph)
+{
+	iph->check = 0;
+	iph->check = checksum_fold(iph, sizeof(struct iphdr), 0);
+}
+
+static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
+{
+	bool send_three = false;
+	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
+
+	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
+	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
+	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
+
+	struct iphdr *iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
+	struct iphdr *iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
+	struct iphdr *iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
+
+	switch (tcase) {
+	case 0: /* DF=1, Incrementing - should coalesce */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(9);
+		fix_ip4_checksum(iph2);
+		break;
+
+	case 1: /* DF=1, Fixed - should coalesce */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(8);
+		fix_ip4_checksum(iph2);
+		break;
+
+	case 2: /* DF=0, Incrementing - should coalesce */
+		iph1->frag_off &= ~htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off &= ~htons(IP_DF);
+		iph2->id = htons(9);
+		fix_ip4_checksum(iph2);
+		break;
+
+	case 3: /* DF=0, Fixed - should not coalesce */
+		iph1->frag_off &= ~htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off &= ~htons(IP_DF);
+		iph2->id = htons(8);
+		fix_ip4_checksum(iph2);
+		break;
+
+	case 4: /* DF=1, two packets incrementing, and one fixed - should
+		 * coalesce only the first two packets
+		 */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(9);
+		fix_ip4_checksum(iph2);
+
+		iph3->frag_off |= htons(IP_DF);
+		iph3->id = htons(9);
+		fix_ip4_checksum(iph3);
+		send_three = true;
+		break;
+
+	case 5: /* DF=1, two packets fixed, and one incrementing - should
+		 * coalesce only the first two packets
+		 */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+		fix_ip4_checksum(iph1);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(8);
+		fix_ip4_checksum(iph2);
+
+		iph3->frag_off |= htons(IP_DF);
+		iph3->id = htons(9);
+		fix_ip4_checksum(iph3);
+		send_three = true;
+		break;
+	}
+
+	write_packet(fd, buf1, total_hdr_len + PAYLOAD_LEN, daddr);
+	write_packet(fd, buf2, total_hdr_len + PAYLOAD_LEN, daddr);
+
+	if (send_three)
+		write_packet(fd, buf3, total_hdr_len + PAYLOAD_LEN, daddr);
+}
+
+static void test_flush_id(int fd, struct sockaddr_ll *daddr, char *fin_pkt)
+{
+	for (int i = 0; i < 6; i++) {
+		sleep(1);
+		send_flush_id_case(fd, daddr, i);
+		sleep(1);
+		write_packet(fd, fin_pkt, total_hdr_len, daddr);
+	}
+}
+
 static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr, char *ext_data1, char *ext_data2)
 {
 	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
@@ -935,6 +1049,8 @@ static void gro_sender(void)
 			send_fragment4(txfd, &daddr);
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			test_flush_id(txfd, &daddr, fin_pkt);
 		} else if (proto == PF_INET6) {
 			sleep(1);
 			send_fragment6(txfd, &daddr);
@@ -1061,6 +1177,34 @@ static void gro_receiver(void)
 
 			printf("fragmented ip4 doesn't coalesce: ");
 			check_recv_pkts(rxfd, correct_payload, 2);
+
+			/* is_atomic checks */
+			printf("DF=1, Incrementing - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
+
+			printf("DF=1, Fixed - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
+
+			printf("DF=0, Incrementing - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
+
+			printf("DF=0, Fixed - should not coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN;
+			correct_payload[1] = PAYLOAD_LEN;
+			check_recv_pkts(rxfd, correct_payload, 2);
+
+			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			correct_payload[1] = PAYLOAD_LEN;
+			check_recv_pkts(rxfd, correct_payload, 2);
+
+			printf("DF=1, 2 Fixed and one incrementing - should coalesce only first 2 packets: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			correct_payload[1] = PAYLOAD_LEN;
+			check_recv_pkts(rxfd, correct_payload, 2);
 		} else if (proto == PF_INET6) {
 			/* GRO doesn't check for ipv6 hop limit when flushing.
 			 * Hence no corresponding test to the ipv4 case.
-- 
2.36.1


