Return-Path: <linux-kselftest+bounces-45619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4770C5BB82
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C673BD976
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE32F8BC5;
	Fri, 14 Nov 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="o4ZiHVfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D92F692D;
	Fri, 14 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104452; cv=fail; b=aeVNud928wzgeLXbsg1OqCiLs8x2pG0BscAUrwlD82ZGQ4xS7m2hvpEwEEFQZjBAuUBPwGvX13oCa88UsTp0M8H7PZC7blArukm6v6gpu463qo60Id7R9hYua9gcNjAh/vhZHb6XAwWZCl2pUCH8FRAUP/VBoZ3i3Cz6ry9qluE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104452; c=relaxed/simple;
	bh=eHEsyB8uqs/vIEF7eOyU3B8PDPOhjsI4MJQMU+bq9/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPFi82QVwO9EG1Bi6RE9l6DZsIFA3oIcP+uUyOa/BDzkMPyxOpg9dugPKT0dniejBvgTrMZyp5tTTIckB6L4KQU3M9GDf8oWKlqGg1z4ovmlv9R8VG5dUqNzpBryMylLxYh5zCyhuCFJHHIZN1zRzijWgBQ8fe2/qHefaYqY584=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=o4ZiHVfJ; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm/KrwN+N94Hlx5YtbsdBJVBIzD/iAX7QJf4vl/leYp2tnkcOJCoXjOsm5+huFuNWcP9Afvo02vap9yAssRiY2F7sBjRhGmEMuyrRCbnjViR5xFqHfU6wUhYnk8OuoDdDQOwmcRRtbGaShYQkxGFozembiLBh/NQqGixMI8DzUPXKGxVz3Q3apn3t4NhS0xX9KerzMN1v3PaitSby8WAxwS1B767BD+NVeM8Dv1zA/guZAUIxUgYbtez0rVP1/zC2JtF14mLfdaVIsLOvKdh9feCjv112X+q05kr9e6iuRmZ+umbuNU1PIBfvXwSjWOZIf5uencCFtCK7Hqz/lTk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMJZ+Bdz8niGpsYg0IwCJC9fpprMflBKXjiMaDCRDss=;
 b=f8QYz96NWCrqd/3v48Q9lsPTr97ZwNCZiFOwe/ze9fvxYoWE1YbIZC7ACzKU8vhQ58nz7OVKG4+GbN1QglPwMA73NPnRd4D1RhwAreuUM2ZZOwdZSTy2ql/LEJ/dTCkyjf2fhlO6fdn+8HFSdvF+ZZcIH6ZG14k4uP6inrOOlQATeZv4s3/XKYjm2QE59RaKiq5JAqKXl5kiFIKwJEL71ML5gw/w9VpGs+0QTBVlL/BgFsKcJNowIKaQkEa1XuSjoCdcQmtn+XGOZ793/laChU7a/Ie+9umH1LAyaBZr1jAN4ZqIVQDiseZfulmWMYGs+nE3ppOae3gBTH3a86RT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMJZ+Bdz8niGpsYg0IwCJC9fpprMflBKXjiMaDCRDss=;
 b=o4ZiHVfJu6Mk8kfqorvQFMUE3nK82X2DE45pNarsLIVKsFmjcfwqTfJfFdEMaB43hztNgB47nFqGdXirnS+1oXEHKl45et+UtumHcTdBaN9kptzALMK4eGHL2GSU3+tPnWRo/uZd4ouxT3KPSZtf9nX/eJQOA07dWUuDG/YXixtPo+AtxsVnroyzvpoQFnfngh8KhKPvry8cxd656pMSR5Yvv22YslyuZ0DSGaHi5BB2cDTDvn/1CTkYZ3sy8PG3rQGjzHycdKqLYKCmTl4F7M+eAp39Ul8GSgPbj7JhFcfXMlNAcP41KQOjPsoIfxggs4aHBXuCJi4ylAVFNnEVyQ==
Received: from DUZP191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::26)
 by AMDPR07MB11167.eurprd07.prod.outlook.com (2603:10a6:20b:716::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 07:14:04 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::cd) by DUZP191CA0043.outlook.office365.com
 (2603:10a6:10:4f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9CED31C003D;
	Fri, 14 Nov 2025 09:14:02 +0200 (EET)
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
Subject: [PATCH v6 net-next 06/14] tcp: disable RFC3168 fallback identifier for CC modules
Date: Fri, 14 Nov 2025 08:13:37 +0100
Message-Id: <20251114071345.10769-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AMDPR07MB11167:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44f34820-83a8-4ec2-0fb1-08de234d64c9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?EzaWFrDrv68vlCJEix7MB5/OWn2oVNceAco95RTjCA9IVongWEt1sXRgbLSN?=
 =?us-ascii?Q?9SnBbotfnkYIolrjUqdU5PjIK5kkNgL45N/Rrg42dEyqtkUvTyfnXbrb1xo5?=
 =?us-ascii?Q?P7A1FlukwVjeWoicSxyFpzmpoi8Xs0vnE3AHaBgvOP6pRf3ZK+h9msLKUgNC?=
 =?us-ascii?Q?RZWC/UR49Mt/gjvTsuipYYf5xgSFZBOvnBCroxTS+DpU6kcEbF1nTm+Ynm1j?=
 =?us-ascii?Q?/PEZgrPa9VUs5GZgXOTSzONq+7UdrHtD4SBCktHsh0tWO89hdGKs4qTGRzWU?=
 =?us-ascii?Q?9TqdLk52iOIJIJdMpR0pAbPNJT7MOhQooWxwOEuUIjbnpNrWYaLwmsNShRYO?=
 =?us-ascii?Q?Xk8eIGeDNqepDuty7FC8TzNLl3/2QlEcyBXd6OldkdDYBkpGPYEmC6sgBrjg?=
 =?us-ascii?Q?MEc2mPOjbfb07koB+rVi29+uJKPckq4fN7IaHT0zZ1RKT1y1JKJdh7HDl4cC?=
 =?us-ascii?Q?XoCf6jMwnd0bYds41MaQgAGe+tAxlPAYxB1NlUQ1WJLi+FetiacV7NK66y0z?=
 =?us-ascii?Q?/jlS+qxd5vdIKdmpjKl/tgDzamPdeWoweI0uDa9y9Xv5OJTjiDfsCs/jszpm?=
 =?us-ascii?Q?3vGrtasAr5RvhEF4SCdb4BOJUQNcYRk4L55YIX3AqYRfjzpuQxqWl2ywP/5u?=
 =?us-ascii?Q?7f7i8WVHq1DQ7Fh1JxXP6BE7aidM07CU+oO8dGzoVsquZRTZ2H0K+QWs8gVK?=
 =?us-ascii?Q?boxcK6srd55Ej3btPoW5YT0Pbfg45EAvb2Xsu4+rNXReZfBfvZ2iVsqYtKqR?=
 =?us-ascii?Q?T3mUNPOO9yyDYAnZo57RuVOYbEIG2aVKkIBOuuqE6+hndesG9mI/DJ529Xsz?=
 =?us-ascii?Q?50pUoP9FNAJMIFaL1o6yitBmS52DMG4DQ+h/3Btnbd5oXpqh/kT+o9Zl4uL6?=
 =?us-ascii?Q?0SyomlwMs0/Aw9kBfOxZYDnwnZrf1pbeVAftEGkqN9XFrkE4cDOt8sFA3P/L?=
 =?us-ascii?Q?ddrxNGhGUhzPAY5iDFcbtkMs3OyPQM+9/tLNJgHMBtvs+hXLohLu4khx8U6r?=
 =?us-ascii?Q?7lwpcfK0HNn0y/PHW4tsxVZdDZcJF2eKqi7+saBq+1PmUaaXuk4wVHfmyS0P?=
 =?us-ascii?Q?LeeQB+fO42bpDi14DiDa0uKEWgD7lZPs6qn6UclKvdNS2HkjUp/Kj+P0yXP0?=
 =?us-ascii?Q?Bre9ypfteS/PxzoKaVQfBBnrkyxAYnhMSIgeb1vJHIDmnZO1BWniITd3q0rn?=
 =?us-ascii?Q?UzeR0sQF4sbKTfyNZJ1cjLf45/KNUTNBoKN/zBm7WXX6f4mbjYI3xD7vRu3J?=
 =?us-ascii?Q?ntv387x93/cse2HaX4qUrU02jCupvF8VK032bA8mGNtFTbVJMVWFMA+8qb8x?=
 =?us-ascii?Q?rCKZBHtDN7TgfLo5RcaUvkiY6IavF7idTQ+GmAIx/Z21rfwwDD7tWOExlLkp?=
 =?us-ascii?Q?wc37eUv3SK0VR5QXN8hqlHv/NZh61cPaWvz6IQChGo9E2Kwng8HHLFiIYCuV?=
 =?us-ascii?Q?ACvN50p8Y1H8IVRbrAAlwGnZDpv/LMVhg4TlZf21QLm0iQU3ttQT85tt+UTI?=
 =?us-ascii?Q?/ayjDw7HmHhZlPzdC3JwmN//yukGTrNV94xMuYElDK8upUypnpP3muVJ7iO6?=
 =?us-ascii?Q?Hesj4zU+tTM8glkRMc8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:04.2712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f34820-83a8-4ec2-0fb1-08de234d64c9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11167

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
index 2e1a5b3d1c5c..a8eb67ff1568 100644
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
 
@@ -1354,6 +1357,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
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
index 3fa4a70d429f..1f354d3cf26a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6851,7 +6851,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d8f4d813e8dd..545d3ba0adcf 100644
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


