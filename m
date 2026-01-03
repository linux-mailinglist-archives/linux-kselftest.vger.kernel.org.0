Return-Path: <linux-kselftest+bounces-48110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC9CEFFBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDAB7306D306
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339F30BF6A;
	Sat,  3 Jan 2026 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aS6oHH9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EF1E9906;
	Sat,  3 Jan 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445851; cv=fail; b=hkNKIFf1FibaRzq36cBB4MCz/BJpLJwGQLAZC295TsM/fE64FdXdILIfZbSqQ0TKeauWGewXWtGvY9heLATp4LnPyZlIwidS5A8UmD88zcVbJX63vU9xjZooKc1sdblFF41AkrHyT5urL1+AqJy17q2ghWUBgYLJjZRlFDVtpqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445851; c=relaxed/simple;
	bh=qhUdabS43GHi7aEzF52u1483YECMRE5mtn+ehFpAmiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNKCFgrcrZMuQKor6qvvue0Rnyt5i8lb1Wc4SV5Gy7HKxz9a3eODOnZ6EZjmgKUpaK7TIo0WM88QDoz4igghzYR0QWp5GLRSTWPCaziNufX53sfE1h+bc9umOduBSrBrZKihrGMzz9ahg246z+JmWF0c+XZRrzwTT9Qwg7LJZZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aS6oHH9z; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrkhAPhb5IV3L05EMf61iinMEwyU19jchV5MN7gB1ZeH9QhMZFZ/3xBtTnHm4PQbi3IaYS8G34KRcji8soqS1/lb7s12fNpM7eWNipKG0DPRktB2f8IxZJTLO1e4NF5ECNglbSa/O5X0/CyKTrj0ORmXNAPjscyka0KDOGTLzAIutIarSh9SULDIW9oQdu3eQHypSbOGpYzOKqr23c5VQVQeTqTqkkJ5MFuUiIfZCA6S6welbDoiQg+45ho/ur4Mf2Brf7Xa9OdOhLZKYDwd+t4eLDLsRtv9roGqbNP/BiOHqeNmVsFCyaxzCHNO6VbVbzLqjdPMd46o/IiEiXX/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=Oai7zw2z2znc7e5CdZ8pj8ukuB8sWuykzu16p2J6KJUh2oAZCEkYmRUVu/YDWOqXHPHqD/Vlh4UmONIcZ//XSXan6itLSX40TycMuktii7PJpKjbkNebRsNaY9NE5zpRUJ0e/Ee0BTO2ilesWd9HPguMRJk4CsEu9ZPdY8utffHh2H73q2BwwPlZdmEf5CSVvLhM6nZMf5TrVWeDizyMRA1cVUqZVa9ys67XEfLEQMs4wmxWtGGb3ioky+oe47iZ3+XgoU83WdaiqLjr1sU3kiIL5PZAfWqXOqcA64z0PVjRLmRzc703iH9i7LakkjLPLvBP2eG7S4vHHYjlkIB7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=aS6oHH9z3wv1KbzwWzl8ppek/fBMnrIme9Xcez+Zb9n58/FELNqP/qlI53kXdZJYjmJsgiRo2ialL+OzUaGyug/1M/nSp9mm8P6s7BANOviRJGSY7w7oemHDm2BLIBQh99YTfr39g8xLVvpOjDS9B/iiOzpna35kACrioQCtUCAJvwusHzMvwGdlMOKPT6NJiEwX2pX0lMLQ1YxyRs7WeGC/EWK0olyeJbZSxxb/fUNRgZ+kfGSeD1UM8f19/xEuiEgLEbSdwsYQS8Rf66EMAz8OtHdB710ZOJ2J36OVrBI1DklkXsEjy7NXs2tod67pvJrEtnJsocuiUB4VUkaU0A==
Received: from AM6P194CA0084.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::25)
 by DBBPR07MB7499.eurprd07.prod.outlook.com (2603:10a6:10:1f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:45 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:209:8f:cafe::d1) by AM6P194CA0084.outlook.office365.com
 (2603:10a6:209:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 469511C0031;
	Sat,  3 Jan 2026 15:10:43 +0200 (EET)
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
Subject: [PATCH v7 net-next 06/13] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Sat,  3 Jan 2026 14:10:21 +0100
Message-Id: <20260103131028.10708-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|DBBPR07MB7499:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e9af00f3-3226-4856-a64f-08de4ac9812f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?JeMS72xs/wCCfXkeh/y6j13UQ2VmhpZ8Hb9T1cZFQ3ERx5kuJOt/geAZ8dqC?=
 =?us-ascii?Q?7Sa0zAyDN+2Xv3CxR/fDs+O2OaXOO8gPap6mmvrn7QF1JsIxYMJ7b+BNahj5?=
 =?us-ascii?Q?1ni97tQDRoEV002o+E7NQ+8Zm2PstswAPG8qCf/e5t/NfgAIG4mLk2zle4d9?=
 =?us-ascii?Q?gmc7jr9h+f7uxWV7Wujs9KiUHl/iD/7Cj+t7U6qTATVTnm4cd3JSeiizMiZH?=
 =?us-ascii?Q?zLlE/BXCNlW+2XmxZ2cXickEvesoZoCRKoSvjogirxWzKjXmo6G1fqqQWEO2?=
 =?us-ascii?Q?qqhwPAVXFLQ/MhePau3g/dGRG+xoUVW8a4pYNwYV/5rOvQbIPGmQ2jJlggGo?=
 =?us-ascii?Q?O94mpIAMqsRUVYi9n4ZfQUle7JgBWLzywTlBJQEggiz38KmJkDb6KjKbvUM0?=
 =?us-ascii?Q?DOItJ93mzupirXvubG/ObC8Pb+xZEM4w+39tZBIOnohCeF0FxNALTWuvfXos?=
 =?us-ascii?Q?3TIRZf2F2lCGq0uh1TQERNWXz6LM96ioqJ43Y33F8PbvAr2AQVe8a0r7k2ii?=
 =?us-ascii?Q?TXwFTJCdMjPCaGg0Ywx49Qhy5Afplm4knt6/rh9SBCVJYfi/QtANgyCYxlEp?=
 =?us-ascii?Q?HQrtF8zEcalQ9P9uqj72G1jX2RrAu/Zx4D3TkIF6JHRCKnDjWufu7lYtQ173?=
 =?us-ascii?Q?5Pbjr+znRrZl4gdNv1DllleKwlhXigc1/r+yMycijkvgCRcyMgeDzhnS5BUu?=
 =?us-ascii?Q?WVWt8w4eun5mVsa1YE6SA3nKXrMpwTwEOKEZ8BC8ygnp8x+V7xEmDy4Lau+R?=
 =?us-ascii?Q?i9KxxFijsFYOwhTDXV1NLBhje6KOB61DLaAuxIgH9+xhV71s2jvv8BZanDwj?=
 =?us-ascii?Q?nfw8Tx4ZxPXCOd2WaIipFxbgyBSfoo8+6JwUoxz4JnAIA8t7nA0akp1QAhRz?=
 =?us-ascii?Q?bxuhr7aFGqX0gjk/S5jFPN3X4XTcnOvNLua8F6xcvgU8A6UWYo4f6SuDIEzE?=
 =?us-ascii?Q?yPrLYrupJKZXrdNmkdlmF+RhdOmt7B9Cm1YRLSaHLTVsjIornjkpbEtlPQWS?=
 =?us-ascii?Q?prQWMequU+C7x/Tu5vTQGmHOwMsgNdQQB1pbv+CBv9/mmHuIayjWeCvgCw4c?=
 =?us-ascii?Q?egTvhl8u4nUK/SsnXjPR+SwbmmuniQLNZGSWd9jhm1dNimVhtGNQEH6Gr1Jb?=
 =?us-ascii?Q?mm7Kdh+lgCEhqNjMGhddDJIJnuz0LZluBZzYDUz4RWIaqSpdhQff4F/7Llg5?=
 =?us-ascii?Q?AY2wVequ4TmLz7OUUXImeLPHVS+1dtOnpDG65r3hgEMY1kYCOirqK8R/u2pS?=
 =?us-ascii?Q?fJXZp7Ys/w+cElaBHxBDn9S756+yoTyCQwpRe+NGKo9u8Da/JaAum4TLrca0?=
 =?us-ascii?Q?6Ey2aCaTgeOVFcZfWb6KVrUfs2C7YFCGbxEdlRj0FGGeSZsOu2ow0e6rRRhU?=
 =?us-ascii?Q?5d0ia1BUxE9arqgpRoZP+iHWQchJr5TEuK6Upf6IMSkGIxcOUVIyPsvXOVJB?=
 =?us-ascii?Q?LvZ1S4IOJ8AVpkN7mtlc/E8R8ynVhevOLwgNsw0+8+LcNY5SxG4hQfPqRvGQ?=
 =?us-ascii?Q?K4W9izi7tVZW+pMBSCFNxqodTHFtDI19EoPCs/U+mzaac3lfEb5FirwOWN0b?=
 =?us-ascii?Q?jGW2l3ngGp0EEUL/jYTus7dTzsC6vK1/FqMw2x5B?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:44.8602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af00f3-3226-4856-a64f-08de4ac9812f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7499

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


