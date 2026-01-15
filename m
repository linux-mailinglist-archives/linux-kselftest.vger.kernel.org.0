Return-Path: <linux-kselftest+bounces-49019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B53D2488E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC53D3124057
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3B396D29;
	Thu, 15 Jan 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GWIXwCAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111B35B150;
	Thu, 15 Jan 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480157; cv=fail; b=MlLHvnbu8KuqEmKTK1J8cXeP61RRv//OploRoEGcrDgLASqxgrLjTdHsWFG2RK3njC4wcP8SSfIJMaOw8Rh4yBrx/GFcuxpdDZ9xf5/FTJUze58r1TX1V7SsrDzFtQemaBqoWFVIb424cyUOabPwlZx2ci+zNMoWr5s+29rwMq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480157; c=relaxed/simple;
	bh=qFWOvmXHHOZ3FLbNO5o0z3fyj4GrtzuuuWVQJkAT3Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW5Abhl2Zd5rKN+IFhpQVvpjyexfzclhgIGtaHi1O4D7K7GZLkHVT0x2yRB1RHRFo//1r444xveDWw0NRDSTVSy6dIF8LpNAleEYpNpRjeJ3Wj+ukxpuv9v1oBBjllwP4Zfq14lItdRnLw6fpGAoaVPSJcFQp6UII8RL3o8z1ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GWIXwCAY; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLzwMFfeaCfFGypq3RowKTgAphfYj2SuHLOWfNRBzuFBtHWKuiBm3QP0tH6deKfy4s9COGMCcnz/YPcx8qMSjyHL8xO1s3X/f6tsuk63QADIjYWnLOSw46LEJzFpO2fBF/a9Ogy9CiKGMuoGCepKF6OvJVFUebQ9OYN3TICS80Pba8IBO5RxYSMgI72l6ITV0WDSOXpOy9dc2j1UJ5/UW42hJR4NQiT80s3DIk33Hqr/h2MxNA7lFAb6Tdbu7bQyKwQtyBxQFDYMvJz48JPfJ0IL/JRYa2NBIVVSqFX2aYO2U8jve5Lp9SDIPJuJWw+5QnPztfyUyqnSn9gmf4TZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH2hAechvGGq/VJ+wUEOz5/Ph3fo+zMmoGdCrWhbsy4=;
 b=y/5I0gd4a2hTYB42AWdB/FA8B91DWAHjkClwAIJ9HoMJGUK+uVLbvSFAwjDjsCW486kMTw/MYcbkpRFA/+YDclzlqQpUo9raxXpAXL1QM70rityT8Kb87zF9LZiFnssE2VCQQeoVLM+EqFLNRWqY5HsbQmXfSz0HKbGFpsObu1y9RYYKlwefK3J86Js6aBlN3bq+rqveZgj5FicAT36iiePyugONOWUFu7UqP0WxrF+mJR+1WYkAy0/pnlK928ZMaqF4n2ocOOynY60Y3wkzgnvBcZaRwSITJR8Z6JgrSmszDY1kklc0NpA9u23COUI9g2owTXiJZg+L3xsSYJU01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH2hAechvGGq/VJ+wUEOz5/Ph3fo+zMmoGdCrWhbsy4=;
 b=GWIXwCAYe7Nl9hIlgq80BIpSGAx18y1dg4sSZS2xdy8yVrazUpjNghNEt8lB3S0GyfKQJEV1tSBw2Wcl6TsbTz6QUUCGRsI/4DCE8uFCMDAQ8G9pXrv08UiD/a/w6XB96pdGu3C097YqWWx/MjsSg2NpDqaI9P7nuPQnKt7OYJ+wclp2BV2ZJjfOumjR91oLyLDNctysSrBJpoTjFNoG52SWMUvAzyZRjcngtZLAb8Vz2fBKgJaTQ1S2Naam2LlmFGlg0ZTy0+uFG19R9DWRxjfN6F6Ko9lpOEb4hpNiI5Ot7k2X7/kNzAifeP7fjfnWEYKOCxgoik+S9o+X9B/gwQ==
Received: from DU7P194CA0020.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::11)
 by AS1PR07MB8525.eurprd07.prod.outlook.com (2603:10a6:20b:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 15 Jan
 2026 12:29:07 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::ad) by DU7P194CA0020.outlook.office365.com
 (2603:10a6:10:553::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 50FB4200C1;
	Thu, 15 Jan 2026 14:29:05 +0200 (EET)
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
Subject: [PATCH v8 net-next 03/14] selftests/net: gro: add self-test for TCP CWR flag
Date: Thu, 15 Jan 2026 13:28:35 +0100
Message-Id: <20260115122846.114576-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AS1PR07MB8525:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5f03d164-9fdd-4273-cef3-08de5431ad38
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7h9JTeshDkOBXWMW7u6Rdb9pq3nOq5vub0ioBtC0D5fshJgIHuoajzHcOz1u?=
 =?us-ascii?Q?yNUO/iak/yZwAeNpABx2OlHc3tOaOsFCQS57/q5WuPEge5YhD1oJa/oD0esu?=
 =?us-ascii?Q?pdGIxm+6itMv0gRGQyAEYVFiMvkUd9bsCJJT6/ettKND9KRncM77p1TlLtQT?=
 =?us-ascii?Q?3+5XwqVHUyn4YH9vLiTsoH4KAM9O2aVooOeZvLe+r7hYE6nuGl6BwqxepOXh?=
 =?us-ascii?Q?IRpj1WHp8R+gAS8XqKDoDJMhHxvywfaxfiJxmApzgheONAS9ID8+POV7AksK?=
 =?us-ascii?Q?KDFEfrFSxNTwSeIsyM0yh6TOZpEV3/bjedpoH4qSRQy/KpkOuDVq/QI0RFVD?=
 =?us-ascii?Q?bmBLJZo2e0YojJiPjBanOytUYmpH+AVrrBBxK3dM55sREAx/XRnI4pTKg1od?=
 =?us-ascii?Q?DUZrlnQG0xScmQpOJxqF6ZW2CICzaFONr+igFQmU4hEEud8YPIDZPbZS0avs?=
 =?us-ascii?Q?wTDKs+ObD5zYRq1aj9lOWnEo/jkpO8KdLHWShwFBusrUXLgglhHobAfJJgu1?=
 =?us-ascii?Q?4bGtUWrGlfr+1H60J2JBZPMj1mfIoHo0btW1A3JclH64RH6yPuG8TJ5kMrgK?=
 =?us-ascii?Q?cgpO0yR8AcNr0iPl+SVVTiXQGUUl7ZAgJil5ZzJtyiiuHsv+L1e6Sf9JxNYm?=
 =?us-ascii?Q?ixWaspSjyWxA8nRDx49ksolYt2z3e2TAPaLlJOESFCNjck8tjW5AFeajKgkZ?=
 =?us-ascii?Q?yyWtnP2Gby2qCSKLm+IxMJgoBkGFu1TXDE5NxNkckutaQ9dB0eX9EOz00yX4?=
 =?us-ascii?Q?dwcXxPWPvoZyHjcBnpl9IbO/FspeO6sN2L20L3JXKKFZ96QqzINbmLWyuiS/?=
 =?us-ascii?Q?eRQ5kwTZw/tl1qlHmIHYd2BOrY92a756uYFsRcqHxJKYX3+pggJbnSf7RanV?=
 =?us-ascii?Q?8+hZIlbEFtOJMlDlAcv0hOWkAllkcbOZtOqXh1posGJGSHcvRLrrNLC7DE7z?=
 =?us-ascii?Q?RV7gNiQY5eSuJOEnxrT/pXlzZpakKeZHbqg2AKgwmTiDdVewNSNWorqaslw3?=
 =?us-ascii?Q?OKqm0Duta2rVXsjKFCKSTRkfkvHRlxNkITDf5ARwlqf95mvoWKBk1YkTVJCy?=
 =?us-ascii?Q?GF82Gi+Da6RGtQEmR5lue1LO7P1YXvQ6UDPEtLSsJ9qgUuuQv77hqQ1FjUwZ?=
 =?us-ascii?Q?TnZbbs3lnSkgo3duFy285/S5RliWzu/mOMFZDCOHm6HFsKL7w4YcyTapAqoB?=
 =?us-ascii?Q?NZC1yv33vJNLxZXmpNp10UISdYK7Kcn+A/k5ARUdTwYAeb9/Csv+aoEavo8S?=
 =?us-ascii?Q?N0xqmcL8ZaaxCJkYlAiAZUx+CwCMNK0Ce5DlglccWIgWpjox8SpNeEUTJzWP?=
 =?us-ascii?Q?ElMV9wxZ+vfKtzLDerlU2umTCCS4ebWDlnmGY71FOCK3C9M1w9QYVTLCe1up?=
 =?us-ascii?Q?xeK7o0NeN/nfRDi32jERwlIZ8Jk9o1KeLmSGPKBVWHRxFtsSr0HqInYuOZs2?=
 =?us-ascii?Q?Frjgver9oqGDuzKOyj7Cgsldipm5aWJeu+/RwHXs3umy3G0UB+sJjX8lOg6V?=
 =?us-ascii?Q?S56SMn8D9urKSOlywCFyhz0oUj2nmwHS4jVgdmiKdXrx9lahTHPCr7y0KBTN?=
 =?us-ascii?Q?48oxrrTRTgr2hjcXw5Cktzrl1vAbKB3feWvz3JvlsBeJtxRPnaNw3UyAF+6a?=
 =?us-ascii?Q?sl0KbFQIsadH2KHDLuPan2LMtDC0hHoTnmxXXJPJ93Ve5uxWs7k7wPftyw4u?=
 =?us-ascii?Q?P+PXoFEzBcAdVjViUR/t/26RQBA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:06.8682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03d164-9fdd-4273-cef3-08de5431ad38
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8525

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
v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
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
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..d147067650af 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr"
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


