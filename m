Return-Path: <linux-kselftest+bounces-44409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45AC20A82
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A81AA01A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290D280CC9;
	Thu, 30 Oct 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="boxlXGEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77D2417E6;
	Thu, 30 Oct 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834897; cv=fail; b=FCJ36yZ1groBUG6Zk+pUyURrMTECHe4vt8DAqqx51Zrc2DO4zYHg6uYyAeeuLA3NoEBUHXleewA70h8P/RaNN9/BpUrQyXtHhLY2KzbGxnRiUM9E4xH4hCg03ytnqCjawdsqg2L5TKRjbddKr+Nk554QR2ed0MgYzFNnaRskp08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834897; c=relaxed/simple;
	bh=S04ydwaBMy2Vi6fSZxjERn0vxJdouX/SP+1arVkjSTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICWnAEunOvqI6Txv30kiiD++Ii5Q2vvKrZdb3vI0cFUgoWhQtCdArae8hmEj7kx4Iyj06kxB9PLJmC+T8WKoS9hjIpoRILfq0BRKFMTl8mDLF4SjPe8R2NBnmjxuFk6LYMxwpuzJyVMKGwO/2+Xq9b/A27hotuOlubh5couIDOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=boxlXGEt; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tldxTtEtF+KEdAbscHlVepxAFp40DXYUfAD/BdGDXCpBtfLXH/A9B1GKRg6/tbUPNoEpgejIk1JO5sg7vkJDai4Pr4GNiCy29gkj+ckDQ3jm4WAjAtMo7nmAVTRRB54cI4aDsMgdmTvjC9HyFhuN9Q+Yi3ttTfn6LUeorb3t5RAwCj6NnrFKYAk1ZV96QRLahM6UU1+f28EONNHRICBGmtDPr9qt1vGdrK0Kqcm6RbYnwE5RGWx9tnJlPHe7cl2k0XroTYxkwTJ1bmgUbT856uktZBOsQLmH5jmquy8uUOAatJQKHnFh6rlTqhrwHE5objiupttJFuzVaD421nGBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxMvScUkpgxzyIKiJfYOoG0Xu2SUzXHOIgfHH0RJow8=;
 b=sVrijbLevTwNn6vft1oYgVudEwPS1sqJKRUE5KpRzxqINzEye1dAPhsqmeIKP/J1KkePqKDb0drc6TYNBFRow9JV0na0egbz3PHX+mCHnva4D1vLQnc5JGWjwU9Dm1U56mMXiaB+kize5LcO6HiclstLvePr1GVbYzH94TBEvX+1D5o2JK7n5V/8BZL+mg5LX+WAdwcm1Wx2CSXmHvhwJQxe5nnWvBlabvy4kvG1dbKPgl7ZaIG/fVQvrGWye4wfnlzsMxlwXZKbpvwinr0jlXqE5V3ls+NosVlPSWdawVCjp7uVRej5vHeDZ1lCSzmnkp9JenvqxE35ppEexsuZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxMvScUkpgxzyIKiJfYOoG0Xu2SUzXHOIgfHH0RJow8=;
 b=boxlXGEtw7T4fc/UXY2OX1b3huwlvyVXcXFLK2h3SbDYPOj6a2G3+QLtrRydkJ1APMSt2M6FlZst4Xcq4DUPrjBMW+yZrj0AugKPzfiPMn+4WHZ66e3viRuSr2Dun5D9CjTMr843GY0EqJ5aS3O6qgAyKUp2OqS9Ix8VZIPFkSoNEbyw6eQXKvtYbJw0YfDB9Llrs3vx/PmTc8N/QSSNTbbQ1i3hESvesWBu9dO4AEZrKGKPU4dKFeU2pm8S0+SXCcHpUWevhzaID1fbJh2eEFBbE+2zFIAvUi45qKnMJU5rgw62poGog8fUXICDC4kH67s1V0YZ1TcGdhdAo711cg==
Received: from AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::20)
 by AM9PR07MB7283.eurprd07.prod.outlook.com (2603:10a6:20b:2c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:48 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::9f) by AS4PR10CA0026.outlook.office365.com
 (2603:10a6:20b:5d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DB97F202EF;
	Thu, 30 Oct 2025 16:34:46 +0200 (EET)
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
Subject: [PATCH v5 net-next 06/14] tcp: disable RFC3168 fallback identifier for CC modules
Date: Thu, 30 Oct 2025 15:34:27 +0100
Message-Id: <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|AM9PR07MB7283:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 69b63b96-2793-4757-38ca-08de17c17a83
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4qiPYnieGunNF/QXfxsrzkLtirxlHbwkdUKG7Hw4wqB4zp0+IL+0OKoHWAwe?=
 =?us-ascii?Q?rIevKXkS574a2yZv/oR5cezBYaAn/yn+oj3ic1nxXpp8EtQSC36MFuHoVHis?=
 =?us-ascii?Q?hgzah3THj4zDxwNA+2lDWqz7Rit+uQsHrDd6AAJHHd/dMveGZH2NHp91GcKl?=
 =?us-ascii?Q?mUabm/Z3QHWJLbMEyVnqnGEgHRSf5DDdyG8E1jkjXqQVbCnR6UwWYISjoYtj?=
 =?us-ascii?Q?w4MvkviTKsuPEjctzf+UbS5mzwZjNcYSkFyxy4hcdt5oUEdb6fcH1o3Fj+L7?=
 =?us-ascii?Q?yKcdkYly007tv/MIULCR63QkXeAMf35pdFMp9SZkOiTmKuKDzmQFnDANlhVy?=
 =?us-ascii?Q?BTNiAgWjuOZM7EBwF4iwFfGz5Gni/FAv98Ue7s6ibwLUYN92z1HsRpaElgfC?=
 =?us-ascii?Q?swb8B5hg3blyojbgyunlhJgSl16IziaVa0e8tzAKXZJJH6ju6+341Wd3+PsK?=
 =?us-ascii?Q?G7t1kgBm522QljjNAnjOCDOO9Rr69pXAfH3w2AN9Vh5oo61R8fnsCoFMkmHN?=
 =?us-ascii?Q?X4us6RCF/uNDbh6D19v8Iw1qDs+F9wF7DGeRumV+msVVs9wJETXAuHGIe3zN?=
 =?us-ascii?Q?w8e+F9MnD+c1/1l3l1o2OrJe0nsQHtDahZfrkxjL8D6enpW/qjLoAT5HxXur?=
 =?us-ascii?Q?N+o9s6Idy+010HC/MqnKFTb2UOi7Iogg3aqvOsMRJw7hZH+zM63+uDgU1MrK?=
 =?us-ascii?Q?vhOWglNEcwLlwNuOBavKFMSXcKwQOBGgwzAhQFuW4WXnF02UBPOQhYibqKjW?=
 =?us-ascii?Q?nicRaJsaM6XLID816F+F7Cxg7MBpNi2Pvbvq1i85c3N53B/C1aDbMr2572uG?=
 =?us-ascii?Q?aLwQAo1s2xjEDxWlq5kxhz+2VwsVHVL7fDDO7uTnd+EsXDLWlX2joRa8zh6I?=
 =?us-ascii?Q?nXwsRlcO1yN/niVFMb3xjbwq9WlIO51fJieRqOXP9N5Ep9l4KZ857wq4qW2N?=
 =?us-ascii?Q?04OJDh9isNLqK3jaRjW5EPYj/5cm2X/EW7efaonrYH4nHtYTJssPE5Ftl+dy?=
 =?us-ascii?Q?plTxzAtdZ6DnRMffxHySl938rZtJEP7KAM5er4K8+sFG64cWdB/toc/wH3Ru?=
 =?us-ascii?Q?uAzr9lwkcOBgHvVSsUPe401YWAeeMcvNEEbjNI30wEibSGVFgSNn5Jq0xZeW?=
 =?us-ascii?Q?CtYskymx/uCLqTx37sdr19AReKyCvRJ17S+FId/tYtrOKccRz6ZtO6n5Zwgm?=
 =?us-ascii?Q?OnM/7RuOYMOMBXOefiHBISJn+OTpD2vw0IgaDPz0qxMXgTY3CIHAZzNZG0ot?=
 =?us-ascii?Q?r1Hbig072U3hmCLkOdFkB3C4fQr+eRb2D99eiEFMerC4beiP1UbVFatBY8PG?=
 =?us-ascii?Q?P8Wi4EqVQfJ4a26iYWsrzGaprJuKdSZXDUVBbUHEEJUJDRTwZWB5QGeAVqYK?=
 =?us-ascii?Q?hOVwkTLUG0wodbeCyOkl8qAqcayU5bmg6aEi1l+QQmDmnhTI6C2klwzjjf2w?=
 =?us-ascii?Q?cD+mF2YPCxOtZIl0dBrMLb+8hPwCIwQwl5e0qdXFYZamViWcM9xOfymavVb9?=
 =?us-ascii?Q?krZbRlieNw2ny6OeXXfDIXgRdWFcb2Ey4oW/IpiQokPlKq1QnMMIo/7d1Fk8?=
 =?us-ascii?Q?37Tg89ZmSFEzRLUHyyw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:48.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b63b96-2793-4757-38ca-08de17c17a83
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7283

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

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
index 76a67e77900d..68f835e70f44 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1200,8 +1200,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1		BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1 | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1340,6 +1343,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 0cc698a8438c..a7ba21d298ff 100644
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
index b4098d5cce48..6b10333fedd1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6834,7 +6834,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ded2cf1f6006..512920b23968 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -486,9 +486,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


