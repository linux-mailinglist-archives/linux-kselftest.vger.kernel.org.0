Return-Path: <linux-kselftest+bounces-9621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43B8BE934
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C91B28F767
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10A16EC15;
	Tue,  7 May 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Nqs2Ke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BC16C692;
	Tue,  7 May 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099535; cv=none; b=gDDmXPGuZmdsxISvDvVpY48g/fuB5/alzoFAlmvMynISyNVMLFEK7sj+QcYwSjngeUqltCu65PnVH2Kx+dLvr5zSuUqihCP/v/jTlGktOkVJoIcrCnjA0TSRVdureEHfuv5rzSKnKaXNN58GHHy5TgqIytgu9+Wdv9vzKogGs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099535; c=relaxed/simple;
	bh=qEiKUExEMZHpgJDE1n2n1k+AtLntSGaapHb3Uy4fz7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR1imCAGAYBYhLEv3jtoCjPKH+4XQ8f3sr6LJzRLVYqeGRW0iV2HjhXRZC5LOSY94CCMlDQ2mGT0B0QXIg08lwHwVagat+ROCFcqdEyQEbD//3B6ta/eTNwHrxsAfEqb0Iv1VgLWGAyFKPqNS19TM+VtAhhQlZCTz8nFgoTgNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Nqs2Ke; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b782405d5so35310135e9.2;
        Tue, 07 May 2024 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099532; x=1715704332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eYssGOudGrpw/4EPUaTbhOQHlVbIPat/QtucojUP08=;
        b=O2Nqs2Ken37bQvU9ArX2yBIipGWZYuMVgSpFWXy0rn56hhYVJUb6UUlqn/jshp23VM
         BEslucmsMg8iy85oh8fkpPb3cUVidoeEDoYRzGRfmik2mi3PCRJ9/CpQgeIwqTugQvmO
         aPdGldeAGgoKAwM/30pCPUXpA6okyefmXcHJyKAdfAXRWFJWATBaLAxXJjqSU8bGxnkp
         DsTWrb5S+7PXNrcLe5VXTP+HEI6WWphzg2/ZVn1LVcdCEeuni/pAroPi+F1y/qxlkIYT
         V5ocdQcG4JyCSDLqDdpvjCRqAil6ixDDV94qNY7TB9/er1p66o6Eh/QBx8nYqMn9HGfc
         8NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099532; x=1715704332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eYssGOudGrpw/4EPUaTbhOQHlVbIPat/QtucojUP08=;
        b=Yiq8ukV/laizfQoW6T2v9/szRxiXHuLfIBG1sZ53F/QEcqMQBIf1/LOZLIPqATNKfR
         pduy8fFzJx2BM+na/cgor2GBP3snBVoQ6BbS1pYJBkZOHkUYoMEwp0zd+co0hssQSvb+
         fLeySSWz/qRRr/nZ/bPu5L+oAWFCzz6g9xSmtsDgIBez8z2wU0HKfuwNhoiZR3+WNLK6
         S/GSL1bRJNlKcU6yat4ZAHG7Iy2oczdxzYuOjQRWAEtVcg1FGHvW9zG3v1Ptg8eOfSSa
         MhemuAJANN9OqGI6q4ahZKRyc6JzeQGfF2FEIi45udk1Hh/QOgDmBTo6bHzdgsfzUFzH
         xBAA==
X-Forwarded-Encrypted: i=1; AJvYcCXjCLG1bbMYOjZrRy6EQQApl8cDEsQddTAfWpvjestqn4UnQ51/t7UTHGGjVxy444bSwyF0+m5oSoJ8lhSkta82Ch0Ojw1YNegVdwahW4zBr/2ERL6ODXbsYVeNzoUmUE88L8853Brji7Yls9N5DJ3ljrC7URIpT49c7VB3r3oDBN1UnqB8
X-Gm-Message-State: AOJu0YzX/TYNMYsNCsCtH9yR7A2RmjH/2ld9radqZ0yzDCjBmEWq9+Ij
	lFrZdEJ0TWc30+He0AOyIjSuGYgxKkdAGAGPUHYmpFrK1ZIiDpdF
X-Google-Smtp-Source: AGHT+IHFckoTAzD480JxZr2S3FkQjA/7iQ9pLJCVZIGiio6AMeHLJNEWOcA538F/c3ZULuJiBxaOiQ==
X-Received: by 2002:a5d:4712:0:b0:34d:3b:6ea8 with SMTP id ffacd0b85a97d-34fca241349mr304578f8f.21.1715099531955;
        Tue, 07 May 2024 09:32:11 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id cx8-20020a056000092800b0034e01a80176sm13305901wrb.114.2024.05.07.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:32:11 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: richardbgobert@gmail.com
Cc: alexander.duyck@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v9 3/3] selftests/net: add flush id selftests
Date: Tue,  7 May 2024 18:31:41 +0200
Message-Id: <20240507163141.130523-1-richardbgobert@gmail.com>
In-Reply-To: <20240507162349.130277-1-richardbgobert@gmail.com>
References: <20240507162349.130277-1-richardbgobert@gmail.com>
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
index 353e1e867fbb..e8fc94c2b9e5 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -93,6 +93,7 @@ static bool tx_socket = true;
 static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
+static const int num_flush_id_cases = 6;
 
 static void vlog(const char *fmt, ...)
 {
@@ -617,6 +618,113 @@ static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext
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
@@ -935,6 +1043,8 @@ static void gro_sender(void)
 			send_fragment4(txfd, &daddr);
 			sleep(1);
 			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+			test_flush_id(txfd, &daddr, fin_pkt);
 		} else if (proto == PF_INET6) {
 			sleep(1);
 			send_fragment6(txfd, &daddr);
@@ -1061,6 +1171,34 @@ static void gro_receiver(void)
 
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


