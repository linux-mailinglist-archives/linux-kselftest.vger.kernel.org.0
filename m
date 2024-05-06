Return-Path: <linux-kselftest+bounces-9513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D88BCB3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565C91C2177B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1E1428F2;
	Mon,  6 May 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijUDRax0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A940142913;
	Mon,  6 May 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989117; cv=none; b=ZHjfN5Ndy/rjkqtSf8buvtVOU6PRKvPKsbQkCfvAMKU0EMyuW5/GRJC8VNcQEYvWObAlBGthxsaFt5cMwA4GA/A/BlKGPRlvtMBXDXNcgUNLVKZV9f+KdP1qhSeiAmubmhQXMtm9INZOsnm5CVFBYoMu/iiegj1fFNjUShfMxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989117; c=relaxed/simple;
	bh=EqjP3m7uykjcyB/f6y24MqoFP7cN3H5kazDuBfsQ4+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FsjICVXjftubt90oK9zDKGaz3mcX44/wg5sMughDxA7C62N/d/ilPN5MMrMUtovoOXtIc+Z9vassFHJcWBc2+BgmIpNhNhzltyt2UN3fecTN32N22andLRoF1u4m06MBtSh+Z4aXEeChTibw/+TOZ5Ja1AIg75SJvcHoPw2t2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijUDRax0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso11332645e9.0;
        Mon, 06 May 2024 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714989114; x=1715593914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5lawwvvxgc/VZKdPAnqoKgJL757qCfC9o6ubXHOj+0=;
        b=ijUDRax03nlc88DUHUbEJ25DBq5xuHGgWRDHe7v0LUaM94oZp0EDGe/FI4kTOT3HwI
         UvHmcs86FCRZFzzSGOsoe39dPTN+Hpcxorn3ZkS2XcgGsbIVMOiCm2Sq3mxcQk5q4n4/
         xUJvLbBLmQQPZ/UZt2hKH68mb/j2QbLqxMb7iYnddcu3fC0cPrj0UndwjxcWbpbG05F/
         PEq8l+Os3PVPXL2wN8EVwI7dDdbhgtX5CS2rwoU5iC30rd44fm6xgaqc+IGGaHKx0lIt
         CqYBY0xWq9zSTmCNFA3l3iTLznMzYeLB4ag9Y/31AU7M3dTq/jRF1q8mA+UzaKmA5lTQ
         0fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989114; x=1715593914;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5lawwvvxgc/VZKdPAnqoKgJL757qCfC9o6ubXHOj+0=;
        b=COefp4l25A/D326NpjnGLaZXOK5zAyG6IK2uEiF1w31FMlYJgl+WAkcxzVTY4t1FJW
         j/7seZZeXQmJKfSUpsVhtIZ+/0WfpX6kBGn5arp4T9XF6Syc/US0RgQTiD7sK8Kd8GgZ
         2/9wEucuU0mwq729DjoBESIGBUsYYeXek5AltuNJ6agZCwjAR2KcJNOp1w0tSSd06A0m
         LruZwmYygG+cKlfjHjq0utnqVYyoXQSfSR2TGPIyuZ1knONGsy8lWprmeFWZ/2kv1OOe
         PnzKvsw7S9zx4CAobz7FuymxNpjRUkEt2R7RVr4ISAZF2jrshbMvfSwWQyMQvWN3Qcm1
         gepA==
X-Forwarded-Encrypted: i=1; AJvYcCVCf8vk6slTi7VtdBGxgpvOtj/ySBV+rbAtK2KTWRO2oMuIhQStBDgjo9u9HDVq0zhWAy6l2E6yJLd4CJn54/SeLHgnwuZpdskoQ2/EmryYiGbnJUnruntxej93oW9LSjfRSU8bahYRGWgBzBOeeapYhkXCl0vRGyrehH06ch56T938RiUC
X-Gm-Message-State: AOJu0Yzy33tePxytQODTEWi3/EbRjgv6/bs0+nTA3Gpq8DfgLI0AW5Vx
	xuBfdoRgPna0B9vXiN0Ao5z1J8qGFFGIaQRBwlRrf9UF/3xG24yuK0IRPQ==
X-Google-Smtp-Source: AGHT+IGAWuWiREqnEeRfMAFvOrd7cLm1v0RY/XfOQ7VR4+16ai775AJ7UrcrKVlhpl9/apO723+vOQ==
X-Received: by 2002:a05:600c:138a:b0:41c:13f6:206d with SMTP id u10-20020a05600c138a00b0041c13f6206dmr7399586wmf.25.1714989114331;
        Mon, 06 May 2024 02:51:54 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0034d743eb8dfsm10258649wrt.29.2024.05.06.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 02:51:54 -0700 (PDT)
Message-ID: <761374d3-1c76-4dc2-a4cc-7bd693deb453@gmail.com>
Date: Mon, 6 May 2024 11:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v8 3/3] selftests/net: add flush id selftests
To: davem@davemloft.net, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, alobakin@pm.me, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240506093550.128210-1-richardbgobert@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20240506093550.128210-1-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Added flush id selftests to test different cases where DF flag is set or
unset and id value changes in the following packets. All cases where the
packets should coalesce or should not coalesce are tested.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/gro.c | 147 ++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 353e1e867fbb..5dc7b539ccbf 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -617,6 +617,123 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
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
+	static char buf1[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf2[MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf3[MAX_HDR_LEN + PAYLOAD_LEN];
+	bool send_three = false;
+	struct iphdr *iph1;
+	struct iphdr *iph2;
+	struct iphdr *iph3;
+
+	iph1 = (struct iphdr *)(buf1 + ETH_HLEN);
+	iph2 = (struct iphdr *)(buf2 + ETH_HLEN);
+	iph3 = (struct iphdr *)(buf3 + ETH_HLEN);
+
+	create_packet(buf1, 0, 0, PAYLOAD_LEN, 0);
+	create_packet(buf2, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
+	create_packet(buf3, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
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
@@ -935,6 +1052,8 @@ static void gro_sender(void)
 			send_fragment4(txfd, &daddr);
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			test_flush_id(txfd, &daddr, fin_pkt);
 		} else if (proto == PF_INET6) {
 			sleep(1);
 			send_fragment6(txfd, &daddr);
@@ -1061,6 +1180,34 @@ static void gro_receiver(void)
 
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


