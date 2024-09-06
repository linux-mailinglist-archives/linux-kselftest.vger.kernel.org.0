Return-Path: <linux-kselftest+bounces-17427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0796FD0C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102EF284E4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D91D7E26;
	Fri,  6 Sep 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o0x2qbGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF40155741
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656880; cv=none; b=r/JIuQ7PfYoPkyZ6QgPmMRY9hmyeI/qkOhVYMgI9L9r70T/nkHSuhu410Z6WsBb1vxzDY+rNDiqvGAWaHPMi9Mq7zPBY0A77zWAozUGkFNodwfIU/1ixEdyx5fsDuD/Ay1n1lt7DndFYsuh+kj2hvp6cwmzCRzJ4XAHA3hP2o40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656880; c=relaxed/simple;
	bh=JJ1smVVv1hpPtnU9o9QoOlpsW1GluwEyiacWgsBBzpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FJ6MAPFChsD810f83CB5XL2bgcAnEiUBEsUseV+JjI1g5r70hcRXECLum5N1nlaSHVV8QXmrt3rEg3oTKsUcY77O1rZurYlI78FXC1bojB/GaQ7IHdY5TpCnVumY8UYLD13w1mX5wJXCXsmXPbQEsk+EPzJDvPFvjMKuw4jqGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o0x2qbGm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725656875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Keefv1899VY9ObcYSkgFK6MVawN7CzaBeJBfIS+JVWY=;
	b=o0x2qbGmjF7Uq/qzoqjo7KmwV0YF0oQHrSqZyjFFaPILkbOeBqJrryuQj/FXGwKlilxv77
	0R2J1aVyfMmNksD0rCjLqr95uzzWfaRk7WzY7YKT/PJCzxnq0bEpWLQvFCPFuK4YS3K2KM
	O8cT5CPthjkxtExe6hPhT2wKRU14CO4=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] selftests: net: csum: Fix checksums for packets with non-zero padding
Date: Fri,  6 Sep 2024 17:07:43 -0400
Message-Id: <20240906210743.627413-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Padding is not included in UDP and TCP checksums. Therefore, reduce the
length of the checksummed data to include only the data in the IP
payload. This fixes spurious reported checksum failures like

rx: pkt: sport=33000 len=26 csum=0xc850 verify=0xf9fe
pkt: bad csum

Technically it is possible for there to be trailing bytes after the UDP
data but before the Ethernet padding (e.g. if sizeof(ip) + sizeof(udp) +
udp.len < ip.len). However, we don't generate such packets.

Fixes: 91a7de85600d ("selftests/net: add csum offload test")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Found while testing for this very bug in hardware checksum offloads.

 tools/testing/selftests/net/lib/csum.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index b9f3fc3c3426..e0a34e5e8dd5 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int len)
 {
 	struct iphdr *iph = nh;
 	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
+	uint16_t ip_len;
 
 	if (len < sizeof(*iph) || iph->protocol != proto)
 		return -1;
 
+	ip_len = ntohs(iph->tot_len);
+	if (ip_len > len || ip_len < sizeof(*iph))
+		return -1;
+
+	len = ip_len;
 	iph_addr_p = &iph->saddr;
 	if (proto == IPPROTO_TCP)
 		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
@@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 {
 	struct ipv6hdr *ip6h = nh;
 	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
+	uint16_t ip_len;
 
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
+	ip_len = ntohs(ip6h->payload_len);
+	if (ip_len > len - sizeof(*ip6h))
+		return -1;
+
+	len = ip_len;
 	iph_addr_p = &ip6h->saddr;
 
 	if (proto == IPPROTO_TCP)
-		return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6h));
+		return recv_verify_packet_tcp(ip6h + 1, len);
 	else
-		return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6h));
+		return recv_verify_packet_udp(ip6h + 1, len);
 }
 
 /* return whether auxdata includes TP_STATUS_CSUM_VALID */
-- 
2.35.1.1320.gc452695387.dirty


