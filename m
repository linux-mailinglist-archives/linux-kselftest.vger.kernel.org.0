Return-Path: <linux-kselftest+bounces-9820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDE8C1532
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7528315B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D27F495;
	Thu,  9 May 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epkngSnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB87F7D1;
	Thu,  9 May 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281785; cv=none; b=uioPXA+Yodprpu6qgpoKyXXv6Yb37pbSZBGFhRtEGQYuRi0BP7Nddi+2GjSbgnULwVvNuZXWXV5nG2xlciFbz7SsfMQJSG9FepH2jWJyD58rMyoNR0DA5fdmcGRbAJUWmftkSQ/9aRRaskemiq87XvsZaNQFgRaX9Xysg/7c0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281785; c=relaxed/simple;
	bh=Je2CopuisTQSqTRX+CMQd6WrKvalUE1cl0xUVrV4L50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AR3MniwtCN8l0Z55yiqgVKkEdZ+vzoF18l6dl0nZL/Fog/Rq33e/JUPRwgzx+u3c7vxLlNuZzfP7CwMxJ/NlHWCzzXB6ut3FiYCL/OEc7ql+vuO9zJKl/bDDjjO4g+vaYkz9SKBkBDej2xQ2/yoHeLw5nf3g3VoxD7P6foxiXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epkngSnw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34ddc9fe4a1so778337f8f.0;
        Thu, 09 May 2024 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281781; x=1715886581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CSbzIHGbUZ218pL4yd7rG60VIXMZlWnpY2Qh8ih8nw=;
        b=epkngSnwF0h+iOqsgdCG4Di9lFPeAj2JLO5ZD97jby7HjVBAgBTBlcFRyV7+7yK7gq
         tVo+ziwjpx3Y1yq3L19nveC0wj2Ndxm792nWJblG7lqS5sZwim/iwSL7RHRhBQODPWvu
         Yh0sE/7b5VpCYz52cddL/pZS0FBXJjM52BTAfHEMAdUewrUsGiDPXntYWmCz/RUb6kKj
         zvlvRjAr6tiddef86GsSGhdxQQY1xuwooAgP2kGTavhSY9WDj8i6iv5dgqffu7mTU+HC
         pKrfaQEPalJr/dP7LLoPgmCvGf7+J8b+FZVEy/JnrZvSfxDE+j30y/zqE4SJRWcsbR2B
         oyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281781; x=1715886581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CSbzIHGbUZ218pL4yd7rG60VIXMZlWnpY2Qh8ih8nw=;
        b=derbDo1tBiJuAsbzzrp8aiwE9kK0zj1OMpN1nafnFHQ26eDjtCNGg1Ly3w0w0kIV0d
         He15RJOrxbMxw7mKetpSBW87EEFC7lsYUQW7DUurkyw2I3D+V7hXnmiG3NXAmAyn1DUR
         IKu2seVESSjsWVgd2EgWLpFrolLJKKBBTwDfP3y+obuJh8JJHp7uiMD+jnCv9mntt1ZI
         UBcpA5NuXUMmv+xOpb3FpyRSJXzPLw0lNcfGn2J7DJ5X6hbEKKLOg/eBGIQ9UZjOg5h0
         Ni3Zw+zGFrXDsMhQL31iM8CzMw39AD6SSBRCb6BpI+1KKXZIbBk5SWlloZe6zL4oJ1Fa
         S73Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZeSZX5yuIF/3SFpX/XTooKiVglDoIG4BCgP3lj53pXRLoPHHyBOrYiuAiiU1jhe+QQwww/1cksDkl1hNpb9K50pCouPqzb08NzbfqOZ7ADwuSAE4tXWShuj9UoHJoIEqwPyPb36vLDtzdpE2liz4RTGs88JyBsyQed5WGt1e0QSQcxDQc
X-Gm-Message-State: AOJu0YxbMKtavakio7BEKPtWkht8qrm4nrPbdS28px/gzm2WuU+QQTD0
	s6ji0hQZsBQ3lWimBQCdZPW9QZKxJenjxqg8FRuDPPmq2/YG8Hl8
X-Google-Smtp-Source: AGHT+IG5prNPg2rPvVejn53N8fhi120sz/Ilh9Fs/V3adRIhICtygStfMc9Tdnf7wKHeG3l19/wJ2A==
X-Received: by 2002:adf:ff8a:0:b0:34a:687a:8f66 with SMTP id ffacd0b85a97d-3504a954dd1mr310915f8f.45.1715281781298;
        Thu, 09 May 2024 12:09:41 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad08asm2435998f8f.76.2024.05.09.12.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:09:41 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	alexander.duyck@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v10 3/3] selftests/net: add flush id selftests
Date: Thu,  9 May 2024 21:08:19 +0200
Message-Id: <20240509190819.2985-4-richardbgobert@gmail.com>
In-Reply-To: <20240509190819.2985-1-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
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
 tools/testing/selftests/net/gro.c | 138 ++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 6038b96ecee8..b2184847e388 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -93,6 +93,7 @@ static bool tx_socket = true;
 static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
+static const int num_flush_id_cases = 6;
 
 static void vlog(const char *fmt, ...)
 {
@@ -620,6 +621,113 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
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
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(9);
+		break;
+
+	case 1: /* DF=1, Fixed - should coalesce */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(8);
+		break;
+
+	case 2: /* DF=0, Incrementing - should coalesce */
+		iph1->frag_off &= ~htons(IP_DF);
+		iph1->id = htons(8);
+
+		iph2->frag_off &= ~htons(IP_DF);
+		iph2->id = htons(9);
+		break;
+
+	case 3: /* DF=0, Fixed - should not coalesce */
+		iph1->frag_off &= ~htons(IP_DF);
+		iph1->id = htons(8);
+
+		iph2->frag_off &= ~htons(IP_DF);
+		iph2->id = htons(8);
+		break;
+
+	case 4: /* DF=1, two packets incrementing, and one fixed - should
+		 * coalesce only the first two packets
+		 */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(9);
+
+		iph3->frag_off |= htons(IP_DF);
+		iph3->id = htons(9);
+		send_three = true;
+		break;
+
+	case 5: /* DF=1, two packets fixed, and one incrementing - should
+		 * coalesce only the first two packets
+		 */
+		iph1->frag_off |= htons(IP_DF);
+		iph1->id = htons(8);
+
+		iph2->frag_off |= htons(IP_DF);
+		iph2->id = htons(8);
+
+		iph3->frag_off |= htons(IP_DF);
+		iph3->id = htons(9);
+		send_three = true;
+		break;
+	}
+
+	fix_ip4_checksum(iph1);
+	fix_ip4_checksum(iph2);
+	write_packet(fd, buf1, total_hdr_len + PAYLOAD_LEN, daddr);
+	write_packet(fd, buf2, total_hdr_len + PAYLOAD_LEN, daddr);
+
+	if (send_three) {
+		fix_ip4_checksum(iph3);
+		write_packet(fd, buf3, total_hdr_len + PAYLOAD_LEN, daddr);
+	}
+}
+
+static void test_flush_id(int fd, struct sockaddr_ll *daddr, char *fin_pkt)
+{
+	for (int i = 0; i < num_flush_id_cases; i++) {
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
@@ -938,6 +1046,8 @@ static void gro_sender(void)
 			send_fragment4(txfd, &daddr);
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			test_flush_id(txfd, &daddr, fin_pkt);
 		} else if (proto == PF_INET6) {
 			sleep(1);
 			send_fragment6(txfd, &daddr);
@@ -1064,6 +1174,34 @@ static void gro_receiver(void)
 
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


