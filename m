Return-Path: <linux-kselftest+bounces-49022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26FD247A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3C323027547
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F44D39901F;
	Thu, 15 Jan 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Zp3aXKdL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3B396D1A;
	Thu, 15 Jan 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480159; cv=fail; b=qKCVks9MLzCvmmVPaH6kdxl7ph65XjHHAxS/eBQef7aFa2KLMIxfcorBnJk+3ULvEaa8KLl1AAh3qMkttp5n9BD5GNAfjIlTyzlqD0a2q/C5ESTdLWdEAiyEO0WnZkiY+X8P6T2K2rCwKX9LkWCwICUwxlyMjftI+EU6r+MOtlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480159; c=relaxed/simple;
	bh=AeQsxhh0GoIz7L8Clgj0Ixzys0BdHniHVQwgcCgzyXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu1rEcSjHVu3I+rPNet7URGinEfF29xcz4LQMsnkOFfcyaY8X5trQbtmQfnENyKP06cMVcU9MH7dE+EQJur3MPgy38SLjKSPWvdws7sWi3JkM6NEYfR6WLtv5w7pGBo9fJ/2hNPgwk8f9bxGzN3toHgmQJNqgAxBMDYuyzJkOaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Zp3aXKdL; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvaxcdZ2vgWO7t8NRmYIHwaArb2k4b7oMs7JczfgOQVTZWQbNwxlw9+OJpIsb4kagUrvo2Oh3gjrqWUYUeEb7aioaa8IVq5o/pPuuir5FPPtmen3nGOAHxz5hmf3u5cU1Wzef4AYpKRIv+GyXr4G3VgwVxqamFgS0U0cpXSBHaIsfBXJY4I1vrxWFe8u3nSamMggqSpTsjLlTamH9kpdVkayTOVu+Ndaw6zxUSXN0YxLMhPbv8bGXjcPAWnoRFyqz8U7Xq8kPWtjuGm2NQguyTL33BGs1uMWTceoLO5HAASnFN8Ltsnsg+vhF31eIuB1vpJvs+hXhSm+pZvJpznC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxqcfm4QxRg1t1sHfxlc4EcAiDwFdXcYOrjoL+9/Vi8=;
 b=TXGLJJxQ/5UJh41fv7fJnCqrBoVfBup4O/WhulhXShGM06Cs6xt0CMPgey+jCcRtbyckeLGmG9WeRj6cdVuUOim3hwMZ8hEsHmMfao+xwY9OedZDmRyjd8a6VTsqD4ixMXhxaAKv1q/AKUvBcOlhTi1c8LHmBLZAg3EBmKQsTT1wgJeHw6h3KjURK5wYdY+1FGYiDL82BYIUnE5HBEMLYqpUDDK53pt+Tk6J0Or3uLH52sCo942GDYipZPeigTb62dDaDXGyrY9UY9R1XXxc7/C/bSA/s3k/05cwmHED86qDJvhdog/y1tX5CkCFXIq/2QFlfh4XU3PuxfVarHIMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxqcfm4QxRg1t1sHfxlc4EcAiDwFdXcYOrjoL+9/Vi8=;
 b=Zp3aXKdLG7N9vZRGkOpxpxRiA4SYdnC65uSVyHYwPiXaiCbQZkr/Go2vFRUUL5BkNSql0UZPOfSWmLaNm4WOClCHfEnZmHVXxiQbM0IE2n11e/er2rjqZPXGy/+El+1uIeJ1ZCOSYi9+zGazcljWqojIJZGp9QMwJtOm7KWSU0+p2Ne8AguFSLFzZZZFJfFSRIf4umMfsOcB8NKtXKkCZWPuY8Q6sffqWRS4AR0b38RZAtxiuN/XD93oW78JxrOP3BtZhu62t03m/NkFuUiswjPoUXlVFthqqt12r1+gUGK946r/HVUzVwOEkYmZADi008+ROo/wMmZsrslNMBDXVA==
Received: from AS4P195CA0037.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::26)
 by GVXPR07MB10798.eurprd07.prod.outlook.com (2603:10a6:150:287::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Thu, 15 Jan
 2026 12:29:11 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::52) by AS4P195CA0037.outlook.office365.com
 (2603:10a6:20b:65a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 15 Jan 2026 12:29:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id E5D282031D;
	Thu, 15 Jan 2026 14:29:08 +0200 (EET)
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
Subject: [PATCH v8 net-next 05/14] tcp: disable RFC3168 fallback identifier for CC modules
Date: Thu, 15 Jan 2026 13:28:37 +0100
Message-Id: <20260115122846.114576-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|GVXPR07MB10798:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0c233feb-f0dd-48b8-7723-08de5431af71
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?YHJZZZ+MrJcX/AuUpcwNMFw4Gnf5xClCafRfsDmN1VDVicsGUk1DaM6/h2iD?=
 =?us-ascii?Q?ttTDzlPoPYsDo1bp6kfDxQKMN2dMIt36OLAm94ItWSYlJhgD/LFh2zSNcJj0?=
 =?us-ascii?Q?4a7zJkpp/1VE7XgtCIIZPpllr3KelbujqDryVZDlZ3p27E/7U4ppeoUCM+gV?=
 =?us-ascii?Q?OlIjbl+P6oSyu4cNwWfOdJ/fZP6P/1pDwCHLmIb2LAaTFTm4K4mDYkA/q9kP?=
 =?us-ascii?Q?9Jc0DbM3ds6PZGaJRGtGlR8NNOBTdjN4B4XT7C9wxkewgj7wS14FnqYieP7Q?=
 =?us-ascii?Q?dRWpciYwM4dwuWurDwDhC8wmIyXXLktEknzaqX9WKmDpPQvTsle6dNM+RzAc?=
 =?us-ascii?Q?05VLggraY8CQC4YTpcaRtyPt5xqZgft81Sai/pHXyJds6UCVD7cczxCjNan7?=
 =?us-ascii?Q?yd8SJz9ARuwzG+BoCxeEUIDpUsiNps+BwAP+1z5f0rkUlL/8vaongIKpBbga?=
 =?us-ascii?Q?9RL60JBSkES2MzLBluLApAXWwthSqyJym7eOqjsdJrI0ZWk6m9i50YF/MFwJ?=
 =?us-ascii?Q?AAtn80/6VD8taa72fOUX2EAc/r4bm49D3sUGHh42fDHu1LLGxjdA+asSi4Xz?=
 =?us-ascii?Q?5Qhc7MWFiYB7TlwJ19keffGTylLj5rJYxD+YmOaAcVr1NFX3F2nzJzkf5V/g?=
 =?us-ascii?Q?f+fmzF5BVELYhyt97XSG22rdlgX50C+A1pU4jlJ/JlUoE2Q69R5WIhhMd6C9?=
 =?us-ascii?Q?4f7r5SkfiV7Kwbmat5m+TT9HAfADxfEeAM07CpjYvUBBEVTFW0in1LZxo5to?=
 =?us-ascii?Q?GA128BJ3b8mS3kN/J8b/AeUWAIhRx7e6RVXckweAs+3d2aJA9Cg4xMv4uMDj?=
 =?us-ascii?Q?OdZsoNgkaeFBTT27iJlIgmMHofS/S4nl/qWrQF0vJE+KX+Z+PzzMsoeJmpIP?=
 =?us-ascii?Q?SqQ7hxR5xUuWOYe4rY1d8zQUKYD3m5ZdhInef6GEB9D5xVmJThbxvPaXctlT?=
 =?us-ascii?Q?WGT+entX0lZeM6g6DgaA32bg26qz0AjL1+Dsn9otgPpkN0TO9xbHbeyTrac9?=
 =?us-ascii?Q?6A67ZZqc/pay3SIxkP1hF4YxK0WKbkw654XFthxrQh5CWKBNOmAM+z4kO3b5?=
 =?us-ascii?Q?VFJX7N8KBaBrucUVWR6EH2TPa54gTv/26E92z3FfkfDFKpSQBo77RZ1sfQDt?=
 =?us-ascii?Q?vQNi7CIq0iIp50u9tGhB9cfcRbp1Cpf0GOWMd+l98JLRFd/R9ch3WTEIVKck?=
 =?us-ascii?Q?QrVmP8wGfspVmlvuurd5rOgvu4evag3ou/gmtngztHZii6UdJvEcvMPXtQaW?=
 =?us-ascii?Q?nUeH6T3tpvUVG7+oxnidq2iXWt/kAy8QtlOlzQdr7hvZbMk+2hnpH2WWHABv?=
 =?us-ascii?Q?u6OvMm6W3ZjlS3ABQZ+FVZC5W3EuR/zE+6iKE976vK0Itv0IVW6RXJKraJ3b?=
 =?us-ascii?Q?4qXvwEXaawqlsnTOZeE8GEr6IKz1KH/I0aUPg2yECVNl5YdsRhrW0OF27hQU?=
 =?us-ascii?Q?Rnt/aHsD6G990dk08jWkjDVS2JBGdZf+APiZ3Sv/67GllPOOlXMSebmgaTrz?=
 =?us-ascii?Q?MkCO8LTdOiU3tNQW8Q3Uch3xqeWHX3WCYccXk/p5OtwEeAz+fs+7AHnlEQit?=
 =?us-ascii?Q?9tGo8SI74LKwHaH2FVJeSoFN4mU5KKOQNAIGKhrNy+KPplLGU3byFXuY82ni?=
 =?us-ascii?Q?MSnarbAizIlJVAuoJ10K37vP0xlUOJPNeFngUX/wxMrzjRlZXiVmUJysHBzq?=
 =?us-ascii?Q?adb5WQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:10.6027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c233feb-f0dd-48b8-7723-08de5431af71
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10798

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91e1dfe58160..d0d8769e2a60 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1207,8 +1207,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1363,6 +1366,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ccbab5569680..e5c9cf586437 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6861,7 +6861,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


