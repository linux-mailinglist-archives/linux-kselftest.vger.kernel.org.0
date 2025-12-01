Return-Path: <linux-kselftest+bounces-46819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCAC984B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB93449DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB4335067;
	Mon,  1 Dec 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cCZmuagj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D133358BD;
	Mon,  1 Dec 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607115; cv=fail; b=ksVy179Jb7U1nviMsw7FLn3jXgfngE4sxCUBn5YsdKN6BPop7rqPZeZILFm0kRN6M9ZA48wRNaE+2tq0s3C7WgfRYAb/OPfM8pJ8qxUWMhl0o5IHKu0lWyC0vO+vx1T3lCnfWMhwOwgBkiIZ091xPN49cMfmXDpwrT4okc27vAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607115; c=relaxed/simple;
	bh=qhUdabS43GHi7aEzF52u1483YECMRE5mtn+ehFpAmiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbeE8J/RALFMvHX6eZ+RbazDuSPgKYgkx2mydNDHZHffsRFPx05LvjvNjA8y/3RiV19NSyszEDijQhJzH0BkUqgyaOFnrJ4GpY/l4uPm+gvZw5xrCbUw2VBATk4SGH2mCQsdZmll0WG6HCmynPlBrgHtNwlvbb0Uxn1v+5QDUmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cCZmuagj; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjBXXx8g9ME5uKPQcd29t/IFL6MdjdRHIg5Dd2v06PnrQBTAprbu19k8ksNq5CacSkuBeYw+euGlTNtNqqAiHdS1AW/ehfTnFVUEYtp2W3W3RJvOyaZOXxjs/rkTZkbzWTScl87ZYSQMlisL9ZpCJqQpEy7CzlSNKhlW45G8yu6S0mQ3NVpn1F+5kjV56kO/bqx+vQtQFuSfKC25DCK8q/Kyc4xNdsKJUe3RKjz0l2JtsDHlCZjSDXjF5wZqcUvre8or684e2kin8hBY3K/MX/RJPwlPQMtsIKCKW6b49eNHz86I9XWXNHBv1IMNyeigUJgrjMz3D32ij8Ij2PcpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=hA3m/TDd5YOrNpeuev0HHuit4zSNCDkWcH0zWOFqvfr2sMsOctQEgF54HqAADwjtvRxuiIDHvYK9DakyVXm3ZxjJItw38ZYwhWN3Zz2Dn8jcS4dXsakXLFF8VIvcu8DrfJ491hbe3WWablbVT8SYEl4ksWVwpU14L9QtnxWIKRZWr1Z6rF/lSkr/9A6CVNmCV3dzoSd0EMT97ULATyEZcQ5avkfpa4weunNCxVUnjmLTdKPDZ4JOQ7FMohDEIQonisLMx3t1L49UWeufpQIxrm7K8TW1dBNE4Hgy8Ytfzrj0tlAj5OQNpwxy27Oc0L/+ppT6Y5FeLw5bZ0G1OG9r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=cCZmuagjplxPGxVqBNqlD6o9PBOOZHo+9DeV8ea11+mZdaSnifnaqCYYziEzutMFy657GPgVESh7vGOVJ0lOBkxREEb6Y+X9VJuot2i40yTPkcsIHA2R1dKLL2zKV/b4qGgG+DvDhF/qUrc1xP+uG4FTZGjsRAOIwQQuARH+8LXTm/Vt8WAaUyDIaQXs09oUJMq4Hjl39w2kLw3OUUFOIJM4v0KoLyYxMFskHKCsW0xlpkNb4EA4JZa6qlPKIRY3asE6MRMmZN63z2SLVjTrhUASoELbKQGAzRcJCoVdbHaeNVPIMK8WbiIMjiYwyrlHQg8GmFsdOV8ELzt922RzKg==
Received: from DU2PR04CA0050.eurprd04.prod.outlook.com (2603:10a6:10:234::25)
 by AS8PR07MB8006.eurprd07.prod.outlook.com (2603:10a6:20b:394::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:28 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::60) by DU2PR04CA0050.outlook.office365.com
 (2603:10a6:10:234::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Mon, 1 Dec 2025 16:38:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id AD3A868004F;
	Mon,  1 Dec 2025 18:38:26 +0200 (EET)
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
Date: Mon,  1 Dec 2025 17:37:53 +0100
Message-Id: <20251201163800.3965-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|AS8PR07MB8006:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 07c0d11a-76d0-4076-909d-08de30f80e4f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LKo5bORoRAT/btDFd38Uo+VwSKE+zcVSJCgg4c97NAT9RxeFd4r3KNlNJ13+?=
 =?us-ascii?Q?sM+ZC9egtPxomAIShXg0EZKgV5Gqcmi6Pb7PSgu7disv1AK3UA/ZK2kO5fIg?=
 =?us-ascii?Q?xZEPlWpvpju2SUAGhjEXaiU5unEDi2SljoRYhLmdpLGhdxzdqd+6sYPHFLw6?=
 =?us-ascii?Q?dpr5q3FCDPcXT5i+AgDYOxlBQveqG8Zp74XxSj/ULR7+kyGiUrW+oD5PC1t0?=
 =?us-ascii?Q?ZnypRaSIzJsk7d7VgdpnqA7MrryREYL03f18AB16RReNdQj6BhTMt9VkUX5H?=
 =?us-ascii?Q?2uwW6/b7meywvnDYDKR6Ap/TK93qdgoeht0z+qRtVDO1nVWF31fAbAtGhP5Q?=
 =?us-ascii?Q?irDLcvP2M9X92SWl6pa1dXu+2IXfyfonfpWJWCJwTaNX007GoYypLUXSnyQP?=
 =?us-ascii?Q?vKLCKBBRA31m4nftEaxJi6uzSXiL5zEmABfLGVl85ut+DOppOqFHQdJP5PPs?=
 =?us-ascii?Q?jO7CzOvi1hfRs+hCTaVFI8ar8a3lnmBRfKQT3q76JtVHVNfardjGaG5dVr1t?=
 =?us-ascii?Q?bp9Mmev2gQGf+TkccC4q0he5ocHzRi9MhkD6AmxDzO3A8Ys0K5j5cC3B9PLB?=
 =?us-ascii?Q?XrfMRDcve1riZxJOB9n9LNPhsPDyXLSw5vMy8bB3Js6oWk2YWg2TIDQ3T7kH?=
 =?us-ascii?Q?hyW2I/R4GOkd6OOzWoGVvMd6YAy0Kj6AdB1OxroJNbZ96TwPidIUv8Sq3F01?=
 =?us-ascii?Q?hRdyiCcD/lBeCgyOhZbI6HuNONY4nMhE1MTMom481h8OqOPzlrLu9Krl6xOo?=
 =?us-ascii?Q?VgUUDxZI+KXvyiQCg/zbbjh89VeeNqss0fpRfKr2aa5mfMdFbpbeAfd8pCg+?=
 =?us-ascii?Q?z0bqZG+GTN7rlzAiRdeTAAjpVa8TwJhqlNfzsKynf/omJXKVD2o9HrQYn73u?=
 =?us-ascii?Q?TwB322dhapAIiU/1E54oKl6LncpL1L9liVwy9F3/jGY0TRZFSj05ka+llFUk?=
 =?us-ascii?Q?F+polT1Lsv/rUoqHM5+/CtIO8f2fdBbAQufK48my0LQpxM8OK55J2LgIoSXG?=
 =?us-ascii?Q?eix7ourRlz7RIzxVumrcVtqEJARgxCauDkc9nq0OX75YUa4GPZoox5tNj9hS?=
 =?us-ascii?Q?S4dc9GcFY6eZcfQxEGsvYIxVhxmeOkhyTJfZ8B3EoXrnlkGIk+1ZP8ejaO6F?=
 =?us-ascii?Q?QDOxXAvMx5+/TFuuFyy8wVQsFbbqr1TzWUNkP0Qdltw5OeEnN9w+RHSnQKHt?=
 =?us-ascii?Q?wxybkbTglWHysi1f/X+jPJicfHMYNV7lv93yiCoRB0DBg2gnPYd355ln6fgD?=
 =?us-ascii?Q?WCCjYzV+WYf4eBLByPg5V4daeVxNW4eVzCUFNYldbjHH62Z9FM7LnofmT30W?=
 =?us-ascii?Q?WTISJhuqaYOXlMFAhIArGE7m1/9yEJM85TmP034sQOcD2lHolFuaQi+XhtpN?=
 =?us-ascii?Q?bK8z+mmXfTMpoQttiD8Gcwu5Z2XKqLdCm4BwVUpLCJdGLP6zOqBUjbQ/X31d?=
 =?us-ascii?Q?Kj89UAUfds4atuC5yl7qY9FQoflJc6Ft+J5mIf5RgxbyP6fwOGfi+JcSWFUe?=
 =?us-ascii?Q?NOAA2J2ub6dhHo39gpUUAghwq8r4AUayFX50N8gYVguN5YUQUygcH8oJYPC/?=
 =?us-ascii?Q?5sotQ0DjeFx6o4+W4Ia+3OwB8pqKmnCJLeHS7ERn?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:28.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c0d11a-76d0-4076-909d-08de30f80e4f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8006

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


