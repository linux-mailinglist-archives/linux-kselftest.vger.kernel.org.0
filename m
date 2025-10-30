Return-Path: <linux-kselftest+bounces-44405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD5C209D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57BDA34F64E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE7278E47;
	Thu, 30 Oct 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gN4FuNrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345122773EE;
	Thu, 30 Oct 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834891; cv=fail; b=bdqHtPreFXuL2u2WTvSqXG+AURpreLRaH1fZNRmTIr0uOHUIVQRtngXi197fUL2hM7f8Fa9kXvqFQVmQHCrOMBidufou2l2wpXala5gPVn/FmHXRdjj4wRhtGBwUD3LOMFpDaANU3C7VK+pKgZS3t7otgtXvJ9Aqk7beYqhTNdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834891; c=relaxed/simple;
	bh=64GD6neJl7sfmzU7g3xopb+j3J2rODQnsqLOFTKetV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ic6j+Zf/fgf4ejKppz//OY7Oahrn+btq1YQCoSdWOWCs7gG8eN94iBPi65MbqryJUnOmeIUdiwV8NPtn4iTO52RVuoMqQZOtIdf4BttprpJItX/6irJT1uXSTz05wEQ4gyqOH93mFg22BY7Ytl9z7hXq6bcFi6ZZByISrpyO+0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gN4FuNrG; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX1ICc/3eRd2iuZL+Lt2yRfb97j1w9l8g09uSRrNx3K4i0SlBIRjHpJPFQAHn0x1YrIUXftSwwDbNwP19p9FfFPvw2J6A1uJJar1X7J40vt0phVbwOIVZUO1RGAVvizW4cFW+kPUHbc7HaLSFV2OHugIAJ9MCb0YhOIr+599Mdb8ym0JKPd6HBCAUSwZVSAbnlP73iTn0/eE+GISQ+A5T/AqnZFGLuf1uu0IZgXt3vNtvphZriug7XQvBJAFseuScdrytSv5JyIQ7KqxcUkJBVwTtn6hkyqPISozHNRGGweTS5gwFWNxWnmDUb97BL6RiHD5K5hWHgDQdkezgVE0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgmT/90nMj2m7ZU3ofliyU47HiTuKPLfFS1Wg6dL3VQ=;
 b=uhZPr1yNDM2GbUM2pEf5NBZQ/hdx+poeS/pAcYORM51O5KkUUAiDMh5zvrmrVGLiEV+P5Txp1ej0klMRyqU8fr7g9hghOgslStxKmmi/80xIP3rEYRATFz1iReHIoyfM9qU1BqFpGnDUCAZXOlQZp+dUohcwOK3GmzQ3RtERKSgRyPvLa0H8N8IjZW6/3kXnFdtMRs4pkEdh3uB1WNeGUfOthDI/b7aAN7emOPJm0jxDr2afUViZmIDx08LwzJqNMkUDfvCWFG+giLnXc56F5WzOiGAbEwNT32IRbLa2arAtFs/PfkWb4y69UBvEcGYjBog0R6AmjYbB5DLL4QQcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgmT/90nMj2m7ZU3ofliyU47HiTuKPLfFS1Wg6dL3VQ=;
 b=gN4FuNrGL/88j/uwmXKSvAT2Paw95Sr//veQ7frcElhIra/URZ5FzO4lp2G8D+spQM7MJ6yIU2hy75pFX0l3EMVwPIKsXeUkmqMOtH8+K87LqO+PLHBebVhle7KoS7Eoxch6l6KbwB2f1NuQSByr9DuN/u0svD49xz+oai5vhoQx7u2S69f1F+dybzV4FXx2KGjQGJS2489U3zmYYSLVAGwvTl9RRt7w00vVTuMEGjF5KWGJ2MHtPiKfiJxl1E59BwbbDlqNWuMeOnkBf8LU7yH8TPLEcXtxmJEZixWuPYAIghHBzZNwL7H/OSx0+jcty3+Qlmng6Geq4lWUJBLNDQ==
Received: from DU2P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::35)
 by AM7PR07MB6325.eurprd07.prod.outlook.com (2603:10a6:20b:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:34:45 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::1c) by DU2P251CA0023.outlook.office365.com
 (2603:10a6:10:230::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 30 Oct 2025 14:34:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 697CD202A3;
	Thu, 30 Oct 2025 16:34:43 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v5 net-next 04/14] selftests/net: gro: add self-test for TCP CWR flag
Date: Thu, 30 Oct 2025 15:34:25 +0100
Message-Id: <20251030143435.13003-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AM7PR07MB6325:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a92b6f81-d10a-4541-97f6-08de17c17883
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?He1YMtjuo/M0+XNkio8nZsaOCFKpDEykLdwFmAR2+fW1yoLRc3XrF0+32KA8?=
 =?us-ascii?Q?CYYYEP2q/Pw3uTL6XpA+83CcZB7VLLnkDhugcC8fE41606A3KVAzw4iDUaPg?=
 =?us-ascii?Q?4RlA9uML/m6qEacJrJagIsJl016TOCsLy08fG3TWfEekb3euK5W5txrxnWOx?=
 =?us-ascii?Q?FnLEL5mT3/amvldtAh3fdWVB+E6j+fch/LIJnKTIaGDE14jhvtEKpbpIBx9i?=
 =?us-ascii?Q?vXxiZA5879B60fDMDJaeH7FeNDWJi9KaAs3umE9fGs+JjnFGhu43P3NHpvef?=
 =?us-ascii?Q?CLDyJacKfSMSJmN/oj8tkntXVqcbuL0SLzD10E3q8G5DyKUvtK2t7NGiV1Cm?=
 =?us-ascii?Q?qcuAxgU8zn5BrrsEgqt7jAYimrX2h8rAG28hurDd4F04EufeuytvzGd6Ayc8?=
 =?us-ascii?Q?c7Kjxe5vvMCeYLToEK4HUSEY7w+Bjw06sEWirLL8BJn7eaWgVW95r2y9WE0v?=
 =?us-ascii?Q?IPu667+kuBIxPDT+Z+oez1KKF+OzdkPn4B464IM9pIH1qtgCr53lT/mztYd2?=
 =?us-ascii?Q?3UG+1Zo9xYfOh0DzLDK9sP5jdxTYt1rSneyPha2r4scKhjWgU8VXaqfuEa8L?=
 =?us-ascii?Q?U7SwAc8R6E1vrkn0kwVgeiqXQN5YQspLyAPwtdlCvImwgeLMwr8cTbYynuxg?=
 =?us-ascii?Q?EFufnd9qc/0+IfPKkfUhww/aqpw4vmJIIF0/tcgfIyr/C+48uMzcE04DISRj?=
 =?us-ascii?Q?rqoXRUPsNV5fJ5P95k3w4+KRiIR974VZN59S+Vepo9TWyydYsxYq/H0NgQWv?=
 =?us-ascii?Q?62fj86YcPZh0pDY9VLkfq/Ju5316dJ7sgGuAWR+72fxj0+UCC3YoVUjLaGpy?=
 =?us-ascii?Q?LZJ0uqjXdFFU6l253DVdiPp1HslDyq/Z9/Ek8XggRaP0EqYa53wgIIiFK9Zp?=
 =?us-ascii?Q?elTVJq4N+SHS3z0GwDHUvlJrYJsUzu11SzvVE4YgcRZ9Wz0F97dcyLi80DR5?=
 =?us-ascii?Q?k7yYzRcRzH2oUx5/O8AX6n78dNCLzqdY8gnKlfOdceZcwLjWAi0a2t1Lbnsd?=
 =?us-ascii?Q?cbSwzWukfY6pZwDZtt+lMt+eF8ezECEJI/WhPN2kxQwWRpwb0edTZFv9zD29?=
 =?us-ascii?Q?sTAJ2U4fck06mJI2g0Wv3rE596IglrR+he8z6n3AbQdpxzKWC6Rtg+ClppKp?=
 =?us-ascii?Q?m4Sv82OBRc7mPPALuq7Zz2bK7R7hDwhbBp9mVx/M2tcTeQANsVMiNnH1DFwQ?=
 =?us-ascii?Q?Ds46HzLGx8hEUsQq5A87azvH9hAEMGsENV4OlSSBY00lvoiQTW1toF0q/O8p?=
 =?us-ascii?Q?tzNyY1TIdBCs094sFtTpPkOxb02PWvnpDbRKeH+Ld7wtMd6TaLYgKbvK/ua3?=
 =?us-ascii?Q?FhNPC079xh77DjkbslJWwdwAcxzkpEnj8M0oTo8rzcgLmtlxNUo2FWbyWJoQ?=
 =?us-ascii?Q?vZWZ77FQNuHbVqBKmtrj7ilVH2ZS7q4DgqFT/GR5CWtUKrSPtAUu7+QZlAck?=
 =?us-ascii?Q?wuHWikVSZ2gcbZp81y9BvnBTxwo+ZB8jI/M38hKHlY6E5gJPRapSjnaMKPXt?=
 =?us-ascii?Q?2UVTOt+TtklRtiD4PguUVbWDnF5mVY1jPARe30u37V8XQc9Wf7HbYPEVBi5v?=
 =?us-ascii?Q?cLC1T01KZshejKI8hmgkVKvc1HtVkwYjxSDBDMHN?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:45.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92b6f81-d10a-4541-97f6-08de17c17883
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6325

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 tools/testing/selftests/net/gro.c | 80 ++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 2b1d9f2b3e9e..763331bb4bbd 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -11,8 +11,8 @@
  * 2.ack
  *  Pure ACK does not coalesce.
  * 3.flags
- *  Specific test cases: no packets with PSH, SYN, URG, RST set will
- *  be coalesced.
+ *  Specific test cases: no packets with PSH, SYN, URG, RST, CWR set
+ *  will be coalesced.
  * 4.tcp
  *  Packets with incorrect checksum, non-consecutive seqno and
  *  different TCP header options shouldn't coalesce. Nit: given that
@@ -332,32 +332,57 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	// Create and configure packets with flags
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1019,16 +1044,19 @@ static void gro_sender(void)
 		send_ack(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "tcp") == 0) {
 		send_changed_checksum(txfd, &daddr);
@@ -1155,6 +1183,12 @@ static void gro_receiver(void)
 
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 	} else if (strcmp(testname, "tcp") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
-- 
2.34.1


