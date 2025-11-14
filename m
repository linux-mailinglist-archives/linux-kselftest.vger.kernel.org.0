Return-Path: <linux-kselftest+bounces-45616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DBCC5BBCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD2274F4723
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3702F656B;
	Fri, 14 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qaPvJ7CU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA012F5485;
	Fri, 14 Nov 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104450; cv=fail; b=CHMpFGcapZlJuAlQ0sl+p4+Cotzr3foCJe7k0+zT+RirHhSPOiKsJ0fQ84W3RZZKp4jM+nj2uLw7EZgLH/B6dbo1zahIUU+AZgyHvtznEbzxnhiCrcZ4fylc1Up52ZylDebsBohLnBrMGzq2+hw9ZwBFdo8z2UiMCQqwCCIGCaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104450; c=relaxed/simple;
	bh=f5ZnyjQSr0EOESr5WFGKQlnZkWnJrCzxyDS6ZBQdSq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFjlSWLBNcPIIVI4od3F8vafPLVhgC13QyMcC62anZ0DmeXz+nnfJKdOT4hsG7bisZ1a6JntdI7T3rMrlS9kL90PMvZMbbaeEU3B5IWUi3xUZtvCZppraUnHSCEBAgLOH7oGo+EY100LuEwYGerpGiQ7JqYC1cdq9i1zM119ZTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qaPvJ7CU; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc5D1NMYbuQ0MQ3immzQ+qw2Qli3H/x9ivwpIBpkQemeQzVh5VstmK34M1qSrMHaxQL4BUUybkQUWdJAfn1GVXI2Uf8tzwLk/MNjDxU8JsP/LvqzONIkgmWMqkCIK753Yco+FKsQAUcOYgqTAUiYq1Zt6zhHFCHhB5KuRY9aL98GFjc6F9+nzaLoQiokUZ6drMXhNlsV/GMTutRqmyn0+3Nnb0Wihkx7hYUloCIG0qeoPan83Wlybi6OxXh+7PotFCnoHnAHIFhCgUISN59phs6x2LiWwsvvuu2fmj+mlddf1wpRlxrdaVOzFM1R+x7eAFXvLDFv6jZIBl95NyuVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6LBx9ZJjgFwIoVZRhFcs9B2yYSxwoc5wiq3KtfeUgA=;
 b=B46dQ8saHPFBbS92HuK/TLgyS3Ki3b4R74FlP0gk19YoyliOLCq9tlBAwbqq1P3So/R28FWt7E7jAYn2V5VTWN+8qoQtw2Rp4tMm/4FMS8/j84zvgl2gR8I0Nps4bsunhZcXB71qH6IfSGTbKHn6JEZ3L9dU+7ex/oBms6gjc9g3DsCEgH+F4+CaxsI7C6uok0ARvmRS+3k6oOX8y+ZPf9YKtZZymwlLl2bZz1dtX70YHkDxTHT/Il48TZaM4W5p346W1OqChX9BLLYBnR1KcqkdE6DTKfY13OTL3Ydup+vvMhfH80x7wdckeq0oIdnXqchjqWGclmkUMKEM7hbhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6LBx9ZJjgFwIoVZRhFcs9B2yYSxwoc5wiq3KtfeUgA=;
 b=qaPvJ7CUB+e1YrnKRG0tICNcDCvtrkw+hh6U3849yFtr4W+mkm+WUSp+atMx9SrS17qTS0m083+n65Ualqs4aY/DT9boXgwhG3G4ZwiNxwU9uaLsjv297qWyDY5M/bMXwqn1OR2x5dyznmPNS0BI9yY4cYqsFqmoF5wUi3aCqMG8VIq+VgyCxu92q1CTnY/xaGUnADcg+l+cJxuzeIuQgMQNcKTKRy6GV/tQf2KOA+p6XFw2uXIwKgrtRqejSL0uHskwsPBfy7TWSkRVhCU4CqVgTfOwmDOjFTUDazl7kuJey4enW0HSRwtJWC+i/OWxxB6F8ctZTahzxXL+FuanaQ==
Received: from DB9PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::17) by AM8PR07MB7602.eurprd07.prod.outlook.com
 (2603:10a6:20b:24b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:00 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::2c) by DB9PR01CA0012.outlook.office365.com
 (2603:10a6:10:1d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:13:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 567A81C002B;
	Fri, 14 Nov 2025 09:13:58 +0200 (EET)
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
Subject: [PATCH v6 net-next 04/14] selftests/net: gro: add self-test for TCP CWR flag
Date: Fri, 14 Nov 2025 08:13:35 +0100
Message-Id: <20251114071345.10769-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AM8PR07MB7602:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56781761-801d-416a-415a-08de234d6239
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?byBeiiA/JbmIn/SBayRJqxnkqSgJ+2csUnMAj7/WqQprq2yyS/frGvElX0Qt?=
 =?us-ascii?Q?yanpGEu56J1zQ9v9HAVHlt9u5Opm33xswSrvm7fI703FzmwQykrI4sDbukrp?=
 =?us-ascii?Q?Wc9uHqOJhr23yuXS/sH3hbK52vnQ93k/fL076htQcBzDJ84wz1lF+FuIt1At?=
 =?us-ascii?Q?kgmTlfH/ExIiHKcBBPzY8l01ONiX3qfmepV/VW4xxXW3ku88GXXRvU3kELCr?=
 =?us-ascii?Q?qzXc7bZqxC7t6QiBDLcqd0mvecVHE0dxHKSFGdPCwknW2+GcYkFlXwhpyp4C?=
 =?us-ascii?Q?yrmazwRGqeoGxen78ZPrb1AZB6d8kU2iQbPXEhXwKaR9mQoChajrDs0r8axT?=
 =?us-ascii?Q?fokEtQUQV828stF3+4iMGLBLTUlqg0cOX1ot1idA4dbzKww04f/0HR+lNRoW?=
 =?us-ascii?Q?iPeF5ToNwBOUgSEs/KTVvawH2RdeZ6cpUQWwovP9joUrSj64g/YzqkjNfHOM?=
 =?us-ascii?Q?A1GrE9mGEnWAwAv4Y6UbbRyNX5Br+jVUrYiU3pM+YWnKDYWOL9clpKuiAEkH?=
 =?us-ascii?Q?/FLyf9wHQSs9WHPZE4SiBCspuptsnFvDoekh6zPE7IX169c7tQBatID/Gw7F?=
 =?us-ascii?Q?mP4V2kHnavAgVS9AwRY3eSnELaX4NK+PI2M/wGer14YJuZkPH/y3MSG0A1Ee?=
 =?us-ascii?Q?kYfd5cisjr3DSa5kvlNKkfGX7pOgxoexWCR/FSfy7Iz/dTTuj/dCGczP2PAt?=
 =?us-ascii?Q?hrGG9PGBxXoQnCtqc3UKJ6r1HT8TLYeMBst3oljc5Qsx82jWPF6g+7spBdM3?=
 =?us-ascii?Q?OHoHhlLVjJ9LQ5Y5Hnf3V8hUpj+RPbvIHLK5wJJiY2jfSOjVdaQ513FkGh7Q?=
 =?us-ascii?Q?aP6c9Boxpa8DKFQZVahhCACrLXlNj8hw7FxWnz8SNd0kTwsDxeOgIaNCnA0M?=
 =?us-ascii?Q?6JYn2tpwgG+EZiOmf6ht+csUnRBNECyg7d83bGBb66Z8VPaCYkB/WMhz159c?=
 =?us-ascii?Q?re7bkBZxAqGWRnV8ssef8Bxu7ZctEIQKotm8+c0FRPFzQvWUfAuWqSKxtZN1?=
 =?us-ascii?Q?Vqzu2su/Zl0E7slIazf+0z0WrcyhCbTECvAymKm6rGGyPWFoKoUPX6+g4kif?=
 =?us-ascii?Q?lmToAXbpkAV/5bo3qN9dpL+kCQbdnRdsj/3tDa3cLlijlkNTFr+TUMEgshq9?=
 =?us-ascii?Q?e3Jd4vTOc6U75DrEuQ3TCW8WbAA0+/7x8RW3OUS4kcIF0DIk2zpfZTRikazL?=
 =?us-ascii?Q?JGdBl7ufFi6wT7cGxghCDYtkVIkrJ8/UKhnEr6JDsapJsxKM3nmGzYMx4Pil?=
 =?us-ascii?Q?UJ0o0DZYxY5PoUnb8LfJpO8p6hK50QFc5VPWsEtt8FIi5kwrKDmnTnZntz8S?=
 =?us-ascii?Q?S9G1MWRLlhTuNIUUT4DgZzj+p3zC74TT8HDrD+wg29SMNcRz6UN5CKWr7BDG?=
 =?us-ascii?Q?GwYc7o+9oc9J4a8SpY7VYI6hMvRBIe3yqgI/77o5q11aKtEpWpTQGfhdWtj8?=
 =?us-ascii?Q?M+zr5Y263M/sWWlwzRJHEdf9Zevjw+X/vGNmgwHuqd/++FStpFapdJOOUA0S?=
 =?us-ascii?Q?A3giDgcIV/kW9/Ia4NZptVaTzvvbGXqdvAcIEitUTdFCStThMXDMgccKJfnY?=
 =?us-ascii?Q?WqDfP2ha0Ji9aSYCWlq9wW+563b+b/xMDH1edWel?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:13:59.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56781761-801d-416a-415a-08de234d6239
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7602

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
index cfc39f70635d..50bf1b96ea9d 100644
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
@@ -1020,16 +1045,19 @@ static void gro_sender(void)
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
@@ -1163,6 +1191,12 @@ static void gro_receiver(void)
 
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


