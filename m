Return-Path: <linux-kselftest+bounces-49021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F7D24798
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24C6D3026619
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5931F39900C;
	Thu, 15 Jan 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eapwF1Pk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD2396D16;
	Thu, 15 Jan 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480158; cv=fail; b=tp7MjKdQfYjQPop7ZzQn+IHoJOgaDGkEptJy0CMAMw96HhM1isK6R5bg1XZNTCjKrWmMrequRCly39XS924qB0GcI4CtkGw6zyDAW5eyxHuTJaARKAGmyrD+0nAWYSNZv7FrxhYCk45rk12KHSxflJEdmedNdq2Ma9zoumm25EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480158; c=relaxed/simple;
	bh=qhUdabS43GHi7aEzF52u1483YECMRE5mtn+ehFpAmiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7IxueYLNMSHuKbc+lkm9Aq8dVKdi2do/ooturdBNQEHn2zRGeqC8N6TENiST3NRSwgA41X4dBq7H43H1LAgHjcuBhxnYzsmSNxxYtTvbwhMeJaVw0FT2Q6I1A4LvzcLmETAZrcapt6r8rTxqY2LKZIt6vEQ6fNOTwgLg2XptOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eapwF1Pk; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8QjYSPx96OnP5hw1alj1rHFbGLI1xgRDe5er2MKP8qUn6m57UcB3eNaL+5M2fVOE8bubN06k4YNjD5JGTjIeUYE+WN4G4+n8Gn4mJpDfwMjP8oJLNn3V5xwf7WmXjPCjp8W0vuLqrEpzOgNP/9DaywQ3FXYQa/hCfYIxqBiNeeTq7bohwxCIm7FX3Bz+r11sXkb/INpImDh7e6JAJoxGl8d93K0qXe2l4IEhMg4Rlutvkr3eXv9bzJ2BF/cJOyrT8RsDjCcowwMSrBQi8LGNEzH3aVipRX3e5t6GjL53nvktsx94FFzAuZuyoZqO1BpE9MNgAYchToTqT/IOkXJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=y69H6POf4wB7bqw7m7aURsrZHNb8M8/Cf22VOrdZZ4YW/BGnPmw1JY96PExtpZV6hy4VVJbAXNOSseav0gSV6IRgxwNgbcfflODYFt6jpl1pD7tG2AI4VW1YyBV1RNsyDxjnqudyIg1EIbc9aiWjLMHaCmGu+5j3iUH6y1qavrql09B93As73n9dyf99FhbBdFu1BpFB8U9AeHfurzTRc9HPI9YycPqir/lZOymi5zhsNQXUemznMwT1Tako96hO3QGnTa82rxDJYdLF6SwmzrbQ6cglqnRhiT1BryIsBeVcblwniatsFqTXGZpX1Zb9cTGHYomKYmmaBB9n1MstvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=eapwF1PkTWuwuG/Tg/WUyazK6OmscED4TXHuyVLKA8OB7bmUErRKRh0Vr7zLzuPVP1UgR0pSnjO/CZoGkxUmrA7FhQCPpO+ikaTs94JbgeQ1X0FiQmZVuH28J3GS2Iha7euGgRFF/gvvv32tNAo9H8fnlaLqcKaWh7FqYUossRqQxW7dTAysXmByy8XUA5jkmWr0M6f/0lVdjp3sHgRfSvqNCsdroXJ2HpBsXp8lSoNA4fAelreDUPdngxxSe8QjA5aZr3vJ4g6GTtxuVGQWfTHMbWUOfor6HmTq6nwIsvYd+DB8UxL62EK9cmsO2DcacDfAtkIdZioWQGV2n001yA==
Received: from DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) by AS2PR07MB9255.eurprd07.prod.outlook.com
 (2603:10a6:20b:60d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 12:29:12 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::52) by DUZPR01CA0288.outlook.office365.com
 (2603:10a6:10:4b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B5724201D1;
	Thu, 15 Jan 2026 14:29:10 +0200 (EET)
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
Subject: [PATCH v8 net-next 06/14] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Thu, 15 Jan 2026 13:28:38 +0100
Message-Id: <20260115122846.114576-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|AS2PR07MB9255:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0de53e83-7f70-4970-3d33-08de5431b07b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?pRIy5hWpSZox1Xs3w4sfcEQTusRMz28rifB3PwGKrLMLTeDh9/SRXche8/Is?=
 =?us-ascii?Q?dJf+8AAMy/SBk/JAk7RFy99fQZSmk1TTwWKezpg9UFVF7DhKtn5Q0EJ5lfg4?=
 =?us-ascii?Q?NmgOD3DNey3N5etfO9lFJJQgrK+0DevICxz7wGddfAnal1iNoMnJhbQxvDcy?=
 =?us-ascii?Q?FKXiGaz5nn5F56A1uxw+oEPQFOW7PidSC6o76qtF0TkNrfYi6f7u+6uqm3+/?=
 =?us-ascii?Q?rIzUqO/HZv72YcQToPAAEXFcl3hG1X3sPVMDFt7W3ojc3FzKrWTHC4eM6x8g?=
 =?us-ascii?Q?jWa+t+Yh/3Kn7Vyz+qtxNlHQyRcQe+sKYj/GUsREKOLo5z6BBUwbot7qFn3H?=
 =?us-ascii?Q?tL5M1krq+DxXmNQhuSqsa2YB5wibokLC2rr/SjnA1q+xgsitIUt6o44a55SI?=
 =?us-ascii?Q?7BBGlJwAl0yOhwdRfklMuBpIp1kvkUitedWfHbfE0djKVoJLSuFcQ9eMdja8?=
 =?us-ascii?Q?drHu/OeKwgL7eO312QtGggot0CtnwMeyYCxprfBAG9BuoGoQC0Dm//3yfYYs?=
 =?us-ascii?Q?eMvGlB+dXm4QjyGoeuYxmw53TeuIlpNcIdIVlex0AjQeh2KczAQc8XOv39fa?=
 =?us-ascii?Q?QyWKX0u4JuahjpEIwdeNT1mwRThnxlhduJtr2INtGljSHyq9uiUgSBS6KQw2?=
 =?us-ascii?Q?iGaQU1oHGAWtCntM9oQAzZLMXXJr8QqjqXxpO2DbvnwXUPSyQcGQYarzxZb1?=
 =?us-ascii?Q?7LngOFP2Ic3iVbBz0dTDUNQYz5FHRbZTpMgX4r6Xv+PYa/wSuq1rXbQ/FT0l?=
 =?us-ascii?Q?55lLeJyDvqEOXzNvlBuuhWFZ8c8IlP80BILxtFvDgBse8rl49iv3N8Qho82C?=
 =?us-ascii?Q?LNr1+Bde/hKAgZTAnBiBGeXZOZVN8t1iRN87DjMEuMD2jgFBYnnDvACMF/hC?=
 =?us-ascii?Q?aCUrl5iOZkm+NQ+YtF4l68sh8vCG5+z/Jms7POLyJsSPMnb/e++sL3kl0EKE?=
 =?us-ascii?Q?qx4eTgR4J52K3UMbdJ2PMr7Huw2PkOsvsdUyd/2ZgtvDFQDovaOBaB7JqsHS?=
 =?us-ascii?Q?YdzJta+s96Vg3KuTX7tpkJVDEtQ4Vr1pJ4d/MNjsETcvcNWs1DNAtX990Cqv?=
 =?us-ascii?Q?oOmqMs61cWY5FmTAobs3lZzziAEPM5AQkh8+wOEsMi6BUD7B59qL6gRpoeVm?=
 =?us-ascii?Q?ubQDMkXAH3FhI01BQHPO/U7t71aEjp5rCGx2HIJe9qy6dUQxsdWJT5EP5UG6?=
 =?us-ascii?Q?NejraJPQdV6hcz/3Alms7WNGskxaBgLo2QEg7InuVRsjur0J/9QPj1cz7byc?=
 =?us-ascii?Q?yisYHjj/lWDWoYweu8mB+2fR9JaE7g/27tNx/cr7x/aXRxQpuAYw1/fs6aGN?=
 =?us-ascii?Q?PYk6FBLBmSTOk2tTTLev5ApMmjvgCmW5G2rutIFWIDPV+pPMgTq8mGTgDxqS?=
 =?us-ascii?Q?hdPU+mG0Ts1oEN4BCFnmJoxaOg0JP3bz622+kiP37QokoinThdPGzPxpH3vW?=
 =?us-ascii?Q?/IBg2V7N17u7emnq7X6eN8sB8qgyDp1UCDv7VOMShZ5va8XljuhtlHKVOw68?=
 =?us-ascii?Q?a3VjXFYsxi/sKPanJe9jhlBnoEpQvnEmGCRIA6bqEfV9jbUpt4rN5rQDZtQC?=
 =?us-ascii?Q?ANYqHoms4TsPRPEnsZvXvf1UXTwNzO1Y6WY+xnAPkn1m/dRrH+2oa8BSLwyZ?=
 =?us-ascii?Q?gyfRCYTwXARhFQUYPpweNS/wEcDr2+SHrWA7XfqdI3z6ixyeZRhn6Um/2Xu9?=
 =?us-ascii?Q?Pygnqesy1zPHDbohpJk8Cji7D6k=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:12.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de53e83-7f70-4970-3d33-08de5431b07b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9255

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


