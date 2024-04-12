Return-Path: <linux-kselftest+bounces-7814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C58A32F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5887C28373B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD037148825;
	Fri, 12 Apr 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYdCoEf3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23783149DE2;
	Fri, 12 Apr 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937402; cv=none; b=DPrxZ/PHoZyzxjVLrXUxge/USZe9Utm/VCWjvxTCLCBQc/Agunphj0+kcvuIwrV8EMpv+fMnX53ovxd2AOwNq05rEYD4K5LLFSMxBnGk56om6Nth8qq+DY+Qz1cyarvkkEAk7aJp6hI4/Nmnm+h9sZmE6Gvml05hkMlToAtfCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937402; c=relaxed/simple;
	bh=9Zp8iPX0jQlUJwfcjhF0I+ShRBkh39BZ3ToTtQd5BH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiF7cZw6osx5GTz6fmCRLq0V+tLuSVMdFSPwx1DhllqbTkx5w/wGsLdXMs7N7Ya3rfEs8NFp+VV1YaWjCqqVvHw9ViA2wr5QctlaKufIfbqNHq7MhWtMaoPmgToWKQUOBqPp7XiOHeApyoosrWpDeY3eciH9OyJi/JiygIfOXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYdCoEf3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346b96f1483so581449f8f.1;
        Fri, 12 Apr 2024 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712937399; x=1713542199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=UYdCoEf31cFpKE+gH96/PFG9nf4S6Xnj29PI0q2Wnu6r6aaTGy4Pn63CE35pGMhoYl
         dKJTuUZweDdx7i/oRUyZiMJAy6pU9CDx/rvyeFObMMesfD1xTH4V5M2+sYmrCWitnV7Y
         itx6bEpePH8cgE7NNTGfHbbKeRdxE6o7zqrt2xsNjjK13Dbo9Tvs9M66O9ZYKIAKi+IC
         N+c2+fMTISoKQZGe72P4pLYs1rnYbzkUjBXNHsO5Zh7ITnj30EQfKi9FmVqqE/zlGvFU
         WzoJiBj9Vwf7t0JFWmDhUAHyAX8CX1QKwpIi9ElFdJqLGy42L23Y4u19CdQqklvEhXI3
         q6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937399; x=1713542199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=Dp7Jbank2kwloSUCqhPVdslfCPsc+QpTbsYJtv6nKLRv4p48bo4ETyKzi3TEgEN3n4
         oWpgFPlNSO9F1/Blcn5wpEEt9bkrDZ3FsXPf7uMrJv/KBHGwE63mfa3DGQ34Rx4XVZPL
         HOvY0Lmsq5AFwyN9oAUJnGL1s0xb6wxgnh8rJrbdOq090b5/iDfYXKhMNY7Yn8yhbadk
         O4PCrMqgJU3ruGflgKRZvqs39uCpfacZV1WptDjvtfXi06JXDwYqOGrtwV2t57Y1tgJv
         woDx+wFgKkX5CVk4oOsSXw8rXagQS8Ng3osJNzO20dUQxncELVXasn4aRmjjAr2K9Evd
         hsEw==
X-Forwarded-Encrypted: i=1; AJvYcCVoUFysqtr8RTxqY5xmHwe6qzOTzyygO2i54Qz/wUOEO5Ofo1IJ72LNoefhHN5CvFsk1ObkGZ6MYe3582jHtBoRpbIxS7OpeDGEs181d9FUxjh/ewHJPCj5/6pUPiMtQarsrmddm7+F1xANhnK0FHNiNEQwjMzd1yy7RnZbe8hihjEoiRr4
X-Gm-Message-State: AOJu0YyAg0LtsguU1GSqZSH4WksYdHJc5KgeoTo95SMhgC09rIXYRJg5
	GsiLweMTE0aZuX9GtE8eh4BvfB4vt+pNFzj8lHub19xj8hgwwogu
X-Google-Smtp-Source: AGHT+IHqw0lZNmPTVGC1nMF7xTvbJaWf0Ps1v3Nx+9WZ14s5b9TyQUXKOVWPHZcsoodu8ZQoMNy8jQ==
X-Received: by 2002:a5d:6408:0:b0:346:4e74:819a with SMTP id z8-20020a5d6408000000b003464e74819amr2502318wru.14.1712937399398;
        Fri, 12 Apr 2024 08:56:39 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b00346d3a626b8sm3631708wrx.3.2024.04.12.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:56:39 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v7 3/3] selftests/net: add flush id selftests
Date: Fri, 12 Apr 2024 17:55:33 +0200
Message-Id: <20240412155533.115507-4-richardbgobert@gmail.com>
In-Reply-To: <20240412155533.115507-1-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
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


