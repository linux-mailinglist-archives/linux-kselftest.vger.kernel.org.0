Return-Path: <linux-kselftest+bounces-44264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B8C18F20
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767F8467C0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B732D43D;
	Wed, 29 Oct 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NTjLIGv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857632ABC5;
	Wed, 29 Oct 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725202; cv=fail; b=Q04w519wdaaTb6AS/MMYVVq9efKAHzwHe4loPp6YCCNJHeMcIRR0IvpSwSE6FOZUvzYhAJKTb+UZDKi3V59lZXeDprNXBqsvfpAU+Mks75yN3kB6ESFoV1dZi1LjGSgVUiuDn1UDn99PSqula416oDkf7q62MqnaEt8RcFmZbH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725202; c=relaxed/simple;
	bh=64GD6neJl7sfmzU7g3xopb+j3J2rODQnsqLOFTKetV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meQxQcqSvSTNOONoftsOarzCBqxHMzjmSNH4OdoMNrohJkshFFS4V/Lbh/T98GeQPGrYpqqbsOSob+JjFKQLd+mrv2bDa+JyZbpdRsXbga4WssKWwQ8QUA41hwobRAuil9w+1mi//TeACTzKfMOVuy879haRiheYwNiRy7D4PRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NTjLIGv/; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmTgYiJXkpJrBjslcqiwT6H3nzHHQkaNc58SW0cRbfWsx8U0XDDbZLOBCS7gcF6+14F0RIuVRhscqHDFV0VAJ/DGMZwrwziAxMVfcnCG5Wjma77MyZYPGZbtGYFCPugS8GFGrGMRx0qkt0IvoKav+sWZnoMBpkJ9CEBZqOEA0oZM0u5K0eXL/nQSirQdgmZafNX9GJqV3aPXQV7mxTlanigSUbLNbKpqRk3EYYNAnLcIp7sN4HwaF1sD/XAnmMOdj86vtb7mywtNINy2JBJWXF2Ks1bLGNhUtJq66CP4zM99YYnqSaSlnBrIjeYkQvgTNwxYfwOSgjR1OHUDu8T2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgmT/90nMj2m7ZU3ofliyU47HiTuKPLfFS1Wg6dL3VQ=;
 b=lgwQVi4jBlyuuUsfi6VHm0rPGbbn9WuhR9dzFViIBkG2PnnJy+pUpfeBy2jbxVzE45L3qFeAkl3UZnK52GUICgW+TDZmMnEWdVhiynT/7RiprnEaJcM/dhX8n/juKeNROl8272rNhCW+n0I+urBMcfxxdEtfdJ5yYj5zBmrZZVBRXFX2veIj5szAEF+MDvgnwVqsSARxPBWowugya5OdZREwYMVbifrxOEpfx7Yyr8G4J/FnUeC/8NNGBYbVKRo3MsoNac6XQFT99rrpaw60nK+KqEx2WbNkeEfuZvZyAr66PshJOyZJp/qnc4ZqWo+5QeB0kKJIL3LaW1f1BUwVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgmT/90nMj2m7ZU3ofliyU47HiTuKPLfFS1Wg6dL3VQ=;
 b=NTjLIGv/0RXESSDy/BS3KQ0d3tuEoCM3oK9CynxXdqpmlqkFGn735zxaeXV8Zj0S+/tEJW0CxPEBnDwvdAE5HxPmYABnqL+efAXuD/Cky2GBWI88atqGsHEP9gQZhyoNBaCpiXtHkDeDkNlWeVviiLQ6ie5+ENveZhZGmmBtRMUKqZ4OJm01cOMTyTqnd1HVWPSEtjaJBe7qNzdLggRylVJGSsETZb/p8x7gsJeX4FZntwJbYDyQBjP7/GrzIIc2oEWW7fGiWLZjuIbV1f1+y+ScV584o5fnld/14wkMdR5OF1OTPfKDS5otKFTyxQ2+aUxQHOyJb169Xe/xrOnvlA==
Received: from CWLP123CA0109.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5f::25)
 by DB9PR07MB8750.eurprd07.prod.outlook.com (2603:10a6:10:30e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:06:27 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:401:5f:cafe::3a) by CWLP123CA0109.outlook.office365.com
 (2603:10a6:401:5f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0C742202D0;
	Wed, 29 Oct 2025 10:06:25 +0200 (EET)
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
Date: Wed, 29 Oct 2025 09:05:58 +0100
Message-Id: <20251029080608.92428-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B1:EE_|DB9PR07MB8750:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa8c1f8e-6faf-4d5f-52af-08de16c20f7b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UjDRKFLbA/t6ew52mRRImtaF61/AEop5dcUZU0Y9qnA9zX/fd2xDvuFxoKbM?=
 =?us-ascii?Q?CIkapbjMGREf60q0ifXZGM9+BmZnVRG+OqwBEbrAZx3eORgzBOhwB99SxJ8I?=
 =?us-ascii?Q?rNs0MpS7Fj+JLe2BHTPEDCdLpDW8ZlvwrDUJTiAn98/YVC/q8dk8vWZmLeso?=
 =?us-ascii?Q?CTyWdzTN57llgVIc60bLENihnwKRZ0kc2YlFdYcmiqMeexExFenGGtr+2vaA?=
 =?us-ascii?Q?f+RwnKXvbzKCuf33heGJe8Vs2NBljPTpfODyXRCG8AIvBPLyxD+rMZfaDIPT?=
 =?us-ascii?Q?0mbHZ8+ICCZFLNJjQ+8IsRA/2woOBVKF0jaqoTqGKN2v9PtiFHkZegkKba+5?=
 =?us-ascii?Q?MWGJIkan3BoV1fCcyrBC26StoJGbMcetWhkzUo7biTo8FmRLDkqqPGoWyuDL?=
 =?us-ascii?Q?eOwURtm8rH0PVjq7K19mvHgG2DM7WNthOLAZ1BjQaaE3GNR36WtPQWMnAeY4?=
 =?us-ascii?Q?KOaJSRBga8XkAiikPF9D4dRtzzg8uL0cxlJOqBFXHJbNiD/eNjn9RmVglPPh?=
 =?us-ascii?Q?IE2+en5K4aUzr3yNbjBZ7tsleI3SNMuuUowkbAYBc9B1HYknnPeWgalgRWzW?=
 =?us-ascii?Q?MgaAQ2SPa5XgWIRszKYm9kIqAE0sfKlTHPrYtB99aKcHrAGRl3ITEkFp7kFp?=
 =?us-ascii?Q?9Qh0kACkR8vlZ+7o2iGzx0tv1VEaoC3oAcaP/goREr/+qCKQ8wKnCQFTsRi4?=
 =?us-ascii?Q?qK/I6lUWpSmAL3PzY5OYV6PTcYzGwxbj0TGIidbxHN5ITc4YGvmKEzOOuftr?=
 =?us-ascii?Q?iQbstHJNih4b3OxDcsw8xrlywfC+dRP2kpnq8d0y7jValZtyRcSwGQyI7Pd5?=
 =?us-ascii?Q?XeHdjwqhYKII3DuZlQiRJlQEAfIpPrZKGBXxaMkgP09dt+Bd7SVclvKKfrjc?=
 =?us-ascii?Q?cyeLhsugwYYoQ1/8wh/4EUNMaqL2OSvQ1MlXJd6pnjEq5vPamKBqh9TwWr2n?=
 =?us-ascii?Q?9vtKDa2kNz20A9pt28MHH7RjYEOoOpzLI06vDbzWvXyItPCJ0fXeuxtcIfRx?=
 =?us-ascii?Q?zp3amtCRWqJZHi3An5e3wpMFsRgFvugyI5WNfd8aNrYDCO2mGYohnZT8BN1B?=
 =?us-ascii?Q?gXwKNNNfKWLI+vD0N2iJfvwkbiBmgRdn58nHxohHYvXkpX/8UlVZT0ANVsga?=
 =?us-ascii?Q?C/yR7ByfNo2RbdCtO67cVZXEcfG2G0lLbJ6c5xpZCeFxQFs4KhsaDrqriSCc?=
 =?us-ascii?Q?LdcM0Ype8z3RWihq889ByLyjRMeSJOd8B27YNE0rG7ExMUDj2oS/EMAX+//j?=
 =?us-ascii?Q?Scq51MZmgIHHkG/g0VhEZsQvgN9QuqI+f4tW93NqV+6CXJAMM/Rz152fyFc9?=
 =?us-ascii?Q?WDcBky40ok6z6YHoF/gK86etz19ZO5clqgM8Dd/6T5PYFuFB8tXFeuGnWHVT?=
 =?us-ascii?Q?DhOHQQ7CyL5DJy7bhFlaH1MYhpinGIL1FQ+9Lp1d1vgh+PFAlAY22f3ssrRv?=
 =?us-ascii?Q?aWfIzN6PT1EDwM/wXxHdYDAeu/wEC3YLBR+F4XdBR6yjJEfvLkW41dGa+sAV?=
 =?us-ascii?Q?eVqxoDQhDhXaHykGqhtlcRuHjUejqPJ3FAGR0SUQQ6Cb5jkXtCoxR0ExlTUf?=
 =?us-ascii?Q?VU/vs9AQH4+f3bhxpFP/Pk+5e+oiCoTBBhFCIWOh?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:26.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c1f8e-6faf-4d5f-52af-08de16c20f7b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8750

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


