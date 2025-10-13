Return-Path: <linux-kselftest+bounces-43011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F7BD56B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83A2F502BE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32392C11DF;
	Mon, 13 Oct 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DK0ahMDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C42BEFF2;
	Mon, 13 Oct 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375037; cv=fail; b=C1o50lZZC0ydRdp2wuKmQ6AFvLGPWJ7AAoETlLGeHlFjfbCM8KpFqwd1j4v1epGuGK8+O6Lk7jpnZOIvF5gEewMaoIyuhn+vFG2FslPuLF5Ri6loPiP4/vHAy/9/8llgRl8HdD1GDP4+FE7j38PxY+MnHIR0RzGFHfhH2H4MSao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375037; c=relaxed/simple;
	bh=Bmd1yqV6O1sES9qpyJ2kMDlR/P3iTbOt5T9WIWk1MmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2tTZyn1aG5K3XpSHfTtfpa6VSO1FdF8FqhYkY9oREYYjRj4fJttgqiXq0k8yDjE8WSJZdTkfmDrRDI1wZwyLFUpjJPGUU8+JDo2OEv4hSmthDeH+2JgymOZ6t5SueX7g4HaGPt+t1j/eCGHVOCbGF3eTYj3vMcEVCHEx9mlDwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DK0ahMDQ; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5h0SwJef8jAcr7pYwGc0fQDeS3efZf3qQ/QYubIvqN79lLXucVTMJMURDEyDn0QcNRG0Rr0qvGDUmH3oDru+MVTK77SUnTC7HNMJuX9UMM1PI/RSfDgECyx+hNtKuMvCO6OMf7GXcTwieGjCqFuYLVJNy5EkyDz3FKWO2sPPx260RksZCwD+HNBT7hI3SHcrV6ZNjkqpwYtEIhncY7WseRuo3T/OWl8Ev30sKUMwbMwZ//jYl0JIUWkk1OX8jAdClBt9REyDWdznE/sSozS03RdNiu47WMzOZA6swzHfqDF/XiIgvYVpSL6b2XJov/ZuVgzeXzAM8Q1e3fKaKY3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=Z34KrDE9pxh4q+q+B6lmrlRllvXufDSgITesyh4c6RIxN9VFU8w9csJM8wNJG8WEqSqNqKTp882Rc8qjz/fwQfSkpG2JM/BT8xefsmDr/qT9nHJiHipxG+241NzdPQu8L/H46/VfmnCqt6EzRHBHN/FmiKJC1j5/JhHxaOY5bykKwMO8xveZyj291ng+JW2ogDHFDpQCojzlI144mHJ7eQ1v28g9znsIr70A3WgOl3ddcyOVbzU8RnYIROUX5TtKP79wtkd+GNxUVPzwBuo/r3hFrLDNBrrgprp6+YTPhHIev0q5AXmlFM+DV5gWh3BVUCEqJnNcHUkaPxk7SPIShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQ4bl4fU0QRZxb2AOptBsDSPl2kJgcYchY6xmeybn8=;
 b=DK0ahMDQGm8tb/LWSUqnrx8bgwX/VIfWLT1r4SGHLQcXvux+5tll0Cm2zMySqvltkJkrwZKoIGa5nOxI0cTW6rCqM7yczzV+LR9HtgV9O3Cl1sUaoGvADi9dXM8MLCgfP1YTmLCSh10eWcGoBPiicJsUh/EICGn5SHVM+wfhj5S6ie504aLZAluSr/Oo4zjmeF+p/yCcd+SzbObJ8Ol2Q18R0Myp4pp85jvtni1nGpZPspdipT8rZ3oQFyA8X2bjbdOdVhSLSzn1rnyqfvxhc588bYnowPhEfrPRKOV8xzzSBZvw5rUHZWwMNm7RZbIbc4agJ/F7qYJYwcDH2JbyVA==
Received: from AS9PR05CA0170.eurprd05.prod.outlook.com (2603:10a6:20b:496::31)
 by DB9PR07MB11043.eurprd07.prod.outlook.com (2603:10a6:10:5f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:51 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:496:cafe::7f) by AS9PR05CA0170.outlook.office365.com
 (2603:10a6:20b:496::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B8DBD1C003D;
	Mon, 13 Oct 2025 20:03:49 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH v4 net-next 05/13] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Mon, 13 Oct 2025 19:03:23 +0200
Message-Id: <20251013170331.63539-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DB9PR07MB11043:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fb6cb6fd-1da3-46e2-2392-08de0a7a7be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/8KClesieOpatfGNY2QGC85hidd4z2CXuRynL+v66pe8FU0I0Rhq95+mwoIt?=
 =?us-ascii?Q?aD5ip0qiT+oSA0R3mzPyu/pn+KRQYtZTVTsax0V/IoUZN0ZDt1nHm6ZEFx7u?=
 =?us-ascii?Q?Ru9TUpFAxU2V/fH+GjUMVgI4jx4DNul026L+f254xFYWpCDQuJNbE94Eh50W?=
 =?us-ascii?Q?iXA31L9CSRls3fZaGLB+HFTFFo0BL3kzRMHCwO4ErEsSfE7hwe/y6igSE68/?=
 =?us-ascii?Q?FxkXEmi4Vt4pFlR9GzmwUq1qaHHVQNahl4YOf2su8Ovh2EtzbqOf+y65ZGNS?=
 =?us-ascii?Q?bxRjiF67wYLACZHcoaWV3c7lPR0JWJ9NcrJCK31tMX8MwXvDzxHCwkt0wMq1?=
 =?us-ascii?Q?3jlid13tGyH4lnbHbW8JiHfLRjBB81Uk9mG+S/llmsMrZ8GqjqJuwuFu3uyP?=
 =?us-ascii?Q?dI5aEjh3i//MI3tX1d4uTAcnqgzOUr+HmnLucuF1CqtV9QaoJ06KMJd4cetv?=
 =?us-ascii?Q?6FV3zYrxIoP8DRAxgA5h2GlX4NbC4qH8v0ji8jzyvinIXYF3P/TWC5pBIwJJ?=
 =?us-ascii?Q?WAQG3jAgn2Xo7Zn0k4nA74hhgpcZU+gYwQxcU9hIh2wyyyQMNqQhBere7NxN?=
 =?us-ascii?Q?lpS5nkR1lLJJvGPgSG9vXK9RdPXLttFD2yafdz/VPlb5fRlFO+HAN9zoPeRz?=
 =?us-ascii?Q?Uo/gJUGgTC5jPLNlMzBTfIrvnvLYAxxT6mmZ43VtKWtn4V/XUpcoy0Y/WnfX?=
 =?us-ascii?Q?0yBbRi61oo+DLO2CK70RuXAR5tVLmEfkcpJNqj2NGFv6f4MuTFrB+KjBuuTr?=
 =?us-ascii?Q?HnmEH1wTYoykrDcgAysDTnNzvSb3zV6oXIMmDzv8IGfI/CiNGlrfMMvBvflF?=
 =?us-ascii?Q?C+6s7qzPuZ33WYjNdeoFrOBhlxLdLBacCKdut+SVXQ8a4uG3GPI9zaoIRJS2?=
 =?us-ascii?Q?qJxlXguayQO/PzfT5ntDPtDw4Qt6x0opPBeG7cZbX6M2eAvhtzuWaOwP9FsE?=
 =?us-ascii?Q?uxGJMFgexRTOoVusJH4z4LW073OCtDzHAc28Osxr1y45dAYeylObgTN9LWe3?=
 =?us-ascii?Q?3xfkYMvO86tOVBY5b0bl2heGFDZgq0F9O4iApu4rP3UITlBbGSnWZxE1NMK3?=
 =?us-ascii?Q?V+0wXzb202PXgvqn9eJl3RLZ4ffwxkfb3mn4TV8zZ9Ic9HhDF13uiSZXUPAD?=
 =?us-ascii?Q?jZVI0/1LdrQiM8qsNl2ESyRuT6zx4l0ZEz+9eH0U9GhdMnKH0Ied6S/DOqGs?=
 =?us-ascii?Q?xbi8DYiqdrnEd8eEifFOXgrsyMZIq0hJFw1AwscZ5xTB6Cs1aFd6boYkH1hQ?=
 =?us-ascii?Q?jYCavFCG+5UMXTx9xh1095gXrl9oYHcuQ/6koBmR1ylD1kg3a3EBL2HJ1KUA?=
 =?us-ascii?Q?yCLH8WwRrvd1Xm4ht7hlGKQOEtQ94bN07w9kCqGT5qP4JivNtkkxtL4ABOBo?=
 =?us-ascii?Q?2VFi9h60bmI8u39cdvTbb1B/A1xzcYJnwKVosa8ZmUPf43By3+E7TOPOaPRZ?=
 =?us-ascii?Q?D1WOkF/fqjl70fPeur5ZIJmbEHErTMnDLtMM+h2bw9JhjNtKQYLTvU022FLs?=
 =?us-ascii?Q?x/9TE8OoYzD1AKBk9c3VDLK+6Lr6iokEYLFHsdIj8FfNoXjAFxg7MOj7rsFv?=
 =?us-ascii?Q?44U0jW3Hg474iLN9ajA8lCS3VIBQWorQuj79E28d?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:51.2919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6cb6fd-1da3-46e2-2392-08de0a7a7be6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11043

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

This patch fix an incorrect AccECN negoation of commit 3cae34274c79
("tcp: accecn: AccECN negotiation").

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a7ba21d298ff..c66f0d944e1c 100644
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


