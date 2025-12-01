Return-Path: <linux-kselftest+bounces-46818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DCC984CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008324E2E63
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9C3358D9;
	Mon,  1 Dec 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JkExyt9b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832603358A4;
	Mon,  1 Dec 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607114; cv=fail; b=BpeSMIXpVYZSJrQxlKfKKxyjrDPt8tLEiNAl5NVRBEqvosSVhHNklKe0pOGOpbfHrum1xN46FDncE8az0WzimyJzVi/UwWJztdBe4eSJncbdHStqkaH/0t2HIWgGAdPdmWQAeEefIoGcJVM8WltzykU7QZT6bJUXBAVTiqAMayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607114; c=relaxed/simple;
	bh=KkXONK49jppz882QYy5MBdqRcd6nxfuySBF0IPgJxvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUjyRf5VSIrnxHY0lIafxGKc8kATe9ScEY95caU7nXZoB2u/1wi7zzkXNum7m0sKQC5XRozCmIzJ3QdnPNCfuHSe7ZiX/ZvCST2eUqIAEn8NaYnxIYWSf7Uwi0sGLU0FU1/XRyEFa2z7jDSC+gWErw7cVBuRyxL9vzmEcu0Euws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JkExyt9b; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEqAvYNmrZKtatphlb7GBe9ZddC0QojPsHfz3tf5MwBtmo09nJOjZ+leQwT+BOCa2g/z/AeBkMiKNaOLtsSPUkv5/tRDvfoVlydQLd4xL/d9BProK2gKYc9bddmlCoDG5zWPwkKDC6/ct396KsVt0280GGPNdfq70tZ5n/IQtoSwQ85KJ2MbcaesFIZ85PVtM6L4ILdiG0tEK2gjJt5IpmdYJFQfgH3cwt3BOTAmV1ILtcyF2gk5LNkb8QZCAg+7McFa4+Mad0CVRWDt35kB0OX5kK94afrOo99vtBZQ+ZKm87mvUwZWf6XbJ0BctAuIG6q6COB3U991S86wfwE3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0GH968YJc+WHnHWbi4wS8Vi0yQU3eCKcVG1QhtkSa8=;
 b=Aq/TDXuv70N77A4wBal+vaCMnBPfC2fn3zCOTlimC+JlVItrRVS5JEsi1ve9dvUcBCnGe2qDnFBwp7tX6vAnU7NvIdA/WYFiJ8dUO9aW3uAaPQgaTm/FpoGZE+ftWwRpNw3Bz47gOUPtjVjNA8Lq/1yZv48g61JdtQ3aRekJMYU7iLjw60zOTlmekWaC5bS5Hp9q9E1TptT9tO3FZfbtpyARvR2id4RCdmqCi7TdnUXc8YuOpMB8E4JKwhmVneF5brfVcemvnHLoK2mhgAMlI+JsjekggbcSaJ5wjvwHWbJP7tYnXNeZV0OkNqOk62btK+FTAVXswEzb5xvbHmXSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0GH968YJc+WHnHWbi4wS8Vi0yQU3eCKcVG1QhtkSa8=;
 b=JkExyt9bnpCT2J1CKfl/9W0Deh28W18tfTzW7Lerq0Od1xGbftVnIZB3q5SyVVw/1F4eCrPR4j3Sm+REOD9eokSS72/6cnGba53qIL2Neesum35DcE+Hw7tHFsJWAt9o6UVpmEokNidfp9aE28/RNInqn5RInMVbx2gCf982UWI4Ev4RADYavrB8ppQIWugkKJNbecUaSSNaFidTDoG7ofxSCPKfss73wzHeC1uRpzIW8hOuCj5T9h7oAUFz+JcApUv3XGsiCXgvMpV+XiFj1fzRRnthXDfG6GjDA7tFqrG7z3MNDaZ8cLpuKQ/3lmJlJqJzixL5EXaV9N4FST7pcQ==
Received: from AS4P190CA0040.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::20)
 by VI0PR07MB11058.eurprd07.prod.outlook.com (2603:10a6:800:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:23 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::85) by AS4P190CA0040.outlook.office365.com
 (2603:10a6:20b:5d1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 8A30C680051;
	Mon,  1 Dec 2025 18:38:21 +0200 (EET)
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
Subject: [PATCH v7 net-next 03/13] selftests/net: gro: add self-test for TCP CWR flag
Date: Mon,  1 Dec 2025 17:37:50 +0100
Message-Id: <20251201163800.3965-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|VI0PR07MB11058:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 776edd22-6878-484e-6f1b-08de30f80b3c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WFxt/Yd4BgmZs2P1QdyzlI2QuWjFv09YEjkdPxFveOKRQuUEFtnUMITLc4EL?=
 =?us-ascii?Q?Tj0Ssd+OuaZSkNS40F64/mj83xwwAxPY+l5gRVdqEAxylTKrVqLuDSOFrEEU?=
 =?us-ascii?Q?NiMBg7lmpUNDXy7X6ewynAKcXoC5JlMIH3vbRqNcBEP7vKdwjNPYH8/mY69b?=
 =?us-ascii?Q?Zgupk++RvPOc7Kpp4cEIddJothKpWMpz2uOi8bMuIFxLdpriXjZLheFqr10b?=
 =?us-ascii?Q?oz97USEdRAUvJ7aPyv5nEWOPah+bVJ4Yh/mkS/CzVNA7QRWeYp8sTxoY8HD8?=
 =?us-ascii?Q?PjlXYIMxcYT17YZeWG6rLXa8XcQaauezUDx7GQrCZd6tZ8rD/I5rgNf6VkK5?=
 =?us-ascii?Q?grqArthlNtcq6vm2U0aztQL4rle4RCXFZx7T1pwNxb/QJPG+vtwwtb7Ub1nw?=
 =?us-ascii?Q?sVxm0c78bkipSPamtM9W88ueq15GaP6sdpD4XSaUXTngjYpW90YqjfhV7L+V?=
 =?us-ascii?Q?PWL9oQ8Jdx9FfS4sAXZeh0MYMVggfrPmkQ+uH+hOy4g9NyMqcLLfKiC61phK?=
 =?us-ascii?Q?IvHZnSik1xxT3WnjTKkc3GG0Ck9CImc+1hN2DIEB3EJIf5pLRacaZMcg1Kax?=
 =?us-ascii?Q?S2bB6qmkF676bMEfD2nTY+q2UqSevJvavBHcHHvPfKSNHkL7Gn7su0odistV?=
 =?us-ascii?Q?2eyPXNb9pXXQPNLK0Gh4iykEyROH2MjGPo0qOc21IWNd1jtw1KkpqlouoLBG?=
 =?us-ascii?Q?tmXZGyYKiPWebDm6Xv61PQgYKhKwj1ep5NTkcVhfax/OdhDbvg+TVCX7QVHj?=
 =?us-ascii?Q?utr1qiQeFaHgll7gNbZz2l9fYlP2ZCEefIbzUXDEV8P9QNThZOPsHedgztsX?=
 =?us-ascii?Q?2x1k0j9EUM0MgG0bL6ExYMQXksnAd/uEQV8mTFDYChR9nUckrg9UbozhAls/?=
 =?us-ascii?Q?lKBiy/AOEwJCZZ6Chd4qQec/C2E5KDAI8M/jCFLYnGYd6noCWWJ2rOCIRAtN?=
 =?us-ascii?Q?M55v6K4AeBvcQpYUhU+8bTk/7bckEctvkM0XFYx/FX7I/2CWZJ1bvM/2d03i?=
 =?us-ascii?Q?J9tr9+CqzRG/6iDj5QvQmaPuqWj2uax3ausBkIgC166CFu78Uat3PbsFN6vV?=
 =?us-ascii?Q?cslAj2H7so5bf52H1P787ZSe8xex17koPy0QtBreWteCFIdPhkCHFrrrMihX?=
 =?us-ascii?Q?AF8f+7o6IB1m9DADjvXREmXy+6/o1EIxg2hqrOcXTPAuly9SMqFTFD7tTWk9?=
 =?us-ascii?Q?hNgIwlNXeaYZVtDm+xWj2bEMmBH4yB5rq7nsqUtuIzLuHIR1cBZGpsp5JPrE?=
 =?us-ascii?Q?rODMDFqkfchhQfuOypCtM1wOcWhI8MvYA5ikpMPdcK/e5wNQcvCQ3G076YiG?=
 =?us-ascii?Q?VlH1WP0Rxkzc1Fra+11rdkPrhkp6vSvwpd8/V61wCFVY2Z8RKn18XHGK6FvS?=
 =?us-ascii?Q?bjzekc0z0UGkEHFstHNK1Pf6xVaa1cL5HNpdECy/t7LN9FfwNgVL/L7yL2Hh?=
 =?us-ascii?Q?VgSXqbfJoMZ6CmIy+WZkQtmKkSape4REp8/ACFYC4NV10mX8BIrXw+mpCs58?=
 =?us-ascii?Q?7WCm2L0mvVgBfswrBfMujyxHo71PEUcvgTrC0t+h+d1E4ubU3H3165Z3HrcI?=
 =?us-ascii?Q?Sa32SntmQpJEu47MRPtNYqaQ3IY8nb9TYVmeWYhy?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:23.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776edd22-6878-484e-6f1b-08de30f80b3c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11058

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
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c | 81 ++++++++++++++++-------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index 995b492f5bcb..00fef326efdf 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
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
@@ -333,32 +333,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
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
+	/* Create and configure packets with flags
+	 */
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
@@ -1021,16 +1047,19 @@ static void gro_sender(void)
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
@@ -1166,6 +1195,12 @@ static void gro_receiver(void)
 
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


