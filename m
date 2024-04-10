Return-Path: <linux-kselftest+bounces-7574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6889FBCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E81C1C245CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E5178CD4;
	Wed, 10 Apr 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpSIBqsa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4B1779AF;
	Wed, 10 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763356; cv=none; b=YAriZSDLwIFUjngVWyNxzx4of6NWW0skYi/lRawDBWIzVRtsNoYvu0cFDKMUS9FbbH+sHBgr1abOSeAzI0q9QbdaKd0Y3qNwbazHIofcyhZ6+fvQKGMtRiMIv2+xwFC9B6M1jLbnl/s4XsBbfYuTjC3pvgRzVMPXPF0c1udfK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763356; c=relaxed/simple;
	bh=9Zp8iPX0jQlUJwfcjhF0I+ShRBkh39BZ3ToTtQd5BH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qoo4NL8cqQ9fajX5LdWb2A+0Wg60Ibqostq6/N+I6RlyIkANx0m4jfCGKGWlUkkukPCXHJjK2NlNbM8rmPZA49QKc/HPrgTsUuZWjZt3vUrEE4Z2n2IgzaHDtbmKFZQ8yrZz6cO/byGwXAv+i5se/mOpcSZyD3ZOU7GUbRF9RKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpSIBqsa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4173f9e5e05so4191605e9.3;
        Wed, 10 Apr 2024 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763353; x=1713368153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=jpSIBqsavTd1UU/pZoN4MFO0LNOjtr0/HA1RvdLM9i95jmuP9qPGBdsvarQBRGqA1M
         jowBKl/iZrp/e7pHUJ/INK4CgRDEIiLPDSOSWRU/YxWTQrMUtI11rUcsYBWRGqGddeQF
         Du2eazTLMWgNIGvQSEWdtYlYdNB6fw3nCMAYdp5LJZfPoqcvMvDLbI+FuSpfYRgVSiwG
         56Iwxa1wIsrzo/uoP6eUL4ivwYnJoSowGfp3cgTziG1LxbUkbF85LmRmTyccmB1bPG1R
         vxMqb2BG6YPO/C5r0QwvPNK9NApyPI61V04glqmbchK8rDMS+QnQe1pqm539Q6yop3MT
         Q3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763353; x=1713368153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Cy7Ko+UcnCG7nOcHmA1+y+Nd7j5NW8NL0jgsxVudM=;
        b=JoqBDmdJBHI9nejRtslmBCfyUSJfrSjfRMuqZ9aUNvRyUAplOrBWsjWD4fEmp5crzT
         7jEW4fUUJhxAi8Wtyi/tJdRtcNCMzvvqvcyXO4KuXIS6sWCquuByWvxD1bMDicyJsg3V
         0ltjYtLzUYCpyKsZfCXDeYcALISG4rRn4Uk/a5t4blnLKA6APMR0gbpZVLy1F8B1KVCL
         UF6LkXq5YJZDUgX+L5+GAnX2ohq0H9hfXf7jK/hR1CvCinY585tf3pvxgkSoLqeh8oBt
         9N9k/fo1HueRp6GoK3laqWQDZWBqpNtglsBDYXvypvIwtNn2P7CGLfLZVdr8p3dDEh1h
         rRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpA46TZOilwCEYUUlfwstAprGTQQI5gCugUAnmeSkXuVbh19B2958nRgl/GNc2gOFGyYImlvON/iKHRDR0WA6VG3Hh5Vy42O4fg0ANnAU7TL+u1uFX7uuaWv2DYCebNBGxEUbH2UQ97b2DpyR6PSl4pkPf8r6kUsOm96BQxD0O5jm4Yo++
X-Gm-Message-State: AOJu0YwCk3z0c3U6ah4j4HOAXYVABdgY79Zp3Gsna8qP/QcZ/gLakCNg
	L9bJag8HH4bVWFfs8SIswp6B+trODKM+mDfes86i6MC/MFX0EgN72wpIz+cp
X-Google-Smtp-Source: AGHT+IHwUOss4eOPGbcTTFqRl4GRlRAHFdSjwFWuxW5e7ZrqVh7llGW9PJ8P0Ig6TNN1rErwomDyBg==
X-Received: by 2002:a05:600c:4446:b0:417:36c5:7c64 with SMTP id v6-20020a05600c444600b0041736c57c64mr1374948wmn.21.1712763353353;
        Wed, 10 Apr 2024 08:35:53 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm2631946wmb.21.2024.04.10.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:53 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	dsahern@kernel.org,
	aduyck@mirantis.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 6/6] selftests/net: add flush id selftests
Date: Wed, 10 Apr 2024 17:34:23 +0200
Message-Id: <20240410153423.107381-7-richardbgobert@gmail.com>
In-Reply-To: <20240410153423.107381-1-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
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


