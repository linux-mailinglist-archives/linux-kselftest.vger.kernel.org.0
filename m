Return-Path: <linux-kselftest+bounces-48111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65DCEFFC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C172530911ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3E30BF5D;
	Sat,  3 Jan 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QfSr/LBZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9D30BB8C;
	Sat,  3 Jan 2026 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445853; cv=fail; b=QMPOVR0f4ZIXlPwmR+owBF+i6pt8WS+mB/01Q9MmHFGkIa8Uwzkv/JwJC4q8/TfFkOhPbdKNaVcbRk1ubTtwoqnvxmQAopJwxReRTbqJosvF2ZJVmfzbVXVYixk3sjkp7BUj6jD72Gi+fhmGG5VJx+UiCTCk+vaGVws1hwd1PxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445853; c=relaxed/simple;
	bh=Tbxrku9UDXe1WskClpxfRhgbDqQVukHy16K6i4RtDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5ZuIm7omfeWitYF3CXm8qR+Sv9xXcE/2ym6EhiVQj+OEHDjTfM4Fgx3MMOtSgssUUF8Pr9Z9xD8a+Gn4VXBqUD9mCT5l+ZX2QRiw/H890xKF/T2cI2L0bHKMZ3ilom2RJdj5KN+lKu1Pw6bA9SLRSG4YrW6PY5EaVKN9za2C+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QfSr/LBZ; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADNNNCa1MOdMlboyHBW4KBMvqXMAzhgcEe9Nk4apv2DsPuVuekjOaVVjimnQBQMlRiS6EHid0hcjSfkO5oBWOSz1/vtlqPKflgPVOCoYR7BKd3XJsI89capHqMxqc8DyMJY3mneZqj/BtH14N9K9rLmfVRrrCz3/4MWlux1LdnBDGrTAAHXG0Zsnw9us4G8/V4z4/nPvjz/0wqb7deYk884ApHYM4UmV8Mz0o3VVP6kvRDLxKE7mz3r7PVJdDhmy9OTUt7YnFk6lPxiL51laG9HjA8+ap4D1qVYMMmp1XHVBABOrd244OI8/Om5+FHqbH60xkSzz3iMu8zpNDrcycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=W+SScXGXj1KFZkAjdNr2DDOUdpkgQ82WHGWrihx011rNG3nQHrD+S4WoliRbXn5lRS9dhp7XA1hC/8BW4wX2kviQHnmIqkkrdsOWfHI4U1jXi0olQYqPHcaMhFW6ehLIlrJPi/UiYUhDLvNMaZckU+7+9Ed96Z+yUCbFCeOhYxA1rY74+E4RUFZtwFNLWLuIMc8J+8RUCUomY2Y+EoL2kJXGUxzhohGf0leF8Kf/wmQR0z+ma6UuoTeDDkWrrK9W8WeH+q7A/pGCF2UMxxwfR55/MDhVDrclDYBUtdd/ea7Abj5HncP8pDXNXg2hiX282zW/a+qhY9H+4CmI0MIShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=QfSr/LBZVtY+l99qvbvj4XzfpH1ONvPQet8nXp+7yccy9qn9YUbRUN3A/L5agMCIO3XjYbat+tSR7TGW/Hqtk3aMyNEhavSxq5uUlJb7oFuib3AETD846/p+7LgPVV39P0xYX0aJm9F1K/03MxUtH0Zkczi65piMgR89NPTue/wChWduCb200sNTPmslRmn1y29wpe//33Kr4OU6sIKhjCnVn3yExbhvDy/dC9AUqUgJPaccPOJySBSAOUbn/OoowFR//34rOXBxj7oIXjUW+dFfS73ImQJkRqngUcJ1JMw8EbDcl/XYJiMRdAyBshDkLKM57F5d+vyLZxPgU76iXA==
Received: from AM9P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::8)
 by AS5PR07MB9745.eurprd07.prod.outlook.com (2603:10a6:20b:672::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:47 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::2) by AM9P192CA0003.outlook.office365.com
 (2603:10a6:20b:21d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 339F01C002B;
	Sat,  3 Jan 2026 15:10:45 +0200 (EET)
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
Subject: [PATCH v7 net-next 07/13] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Sat,  3 Jan 2026 14:10:22 +0100
Message-Id: <20260103131028.10708-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AS5PR07MB9745:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: edb65b47-44be-40bd-613c-08de4ac98250
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?feMpIRE+TGQMCkSrDvcV+voxBx0DajPRhhQevfw/gHX1tRIOWQUgxMw9kVVK?=
 =?us-ascii?Q?sVfsOl6rEMgFvkeJa9uaEuBkun35t0D+FCa/nsYshLYD5im//UD+HI6ivifw?=
 =?us-ascii?Q?4aXIE6P3/x9RL/dyHUYvNEiE7sv2GoiLx0zy3I4QPLb04CTCj2/JIBVcM4Xc?=
 =?us-ascii?Q?PjEgNsbcRa2BHhCDVAiL/ZifXPq4BxouEdQVLHWtDnt4rPYjKD6UkKq5JppL?=
 =?us-ascii?Q?8K9BWdqTeutatAiVunAE6jh6ckvq5XIDRUULkVaOkHnEzLV1Uk7HvS55emDO?=
 =?us-ascii?Q?LQMFvhnsaDaF0ZM8wE+u8D+ozLp7ahJYdE1QfTbqAyJF0XYqVMq8kAUP3xHp?=
 =?us-ascii?Q?QI6QAUwVp7nFFnPkeeSz6BLCoHcydXGFCeVO3wFLDalR/mqlAaqeALvAPfCj?=
 =?us-ascii?Q?lf3VBxNyNQrI42OWg4GWP9q36m73BmlKapcOOeFQTmUQK8gFayn2azQqc+uM?=
 =?us-ascii?Q?F9Se2asnjiSAQnPjb0rZGkir7RReX4bqb2ohy4A3TeNctFUSN+O3lrBBnvqk?=
 =?us-ascii?Q?tBMTDr/gWoqX4WUF7Ohi5L4q1hG0H3Wq1fQqMvQL2TycoM7TMWyHrjp4x/xx?=
 =?us-ascii?Q?W4OCCbKeH+Mw0K20dfxsC7/vbNBj5lFebPqeMUWfWUhUSRi7LJjYtHOlsfCz?=
 =?us-ascii?Q?so2QUMVXZc+wGlP3b3Am9hrUJfnuULLOuwWG5ZnTOQvRu6sRMGDjdTuap+1z?=
 =?us-ascii?Q?/xQH1APmyhYa4/3+wqGkhMJNukxLn8xAx12oqXpEtivxwpoIp2d5vj3Jy2FL?=
 =?us-ascii?Q?pVM2rqjxXCPx6RlkRRROu0JoNiMNkfl/JmDzdsNTtEJ7W3wtoVIFov2y0e9J?=
 =?us-ascii?Q?yFr9pUfLW1u8dodPZ33LtGFXay4s/jYskLllGaaB7ijXWZU33RlmpgSaMt12?=
 =?us-ascii?Q?mcMbBjAMPqmf0/LxTsNFNbsdWN5xkocyeQ2+kTqUZJNzhX3CvlwdJCHDbGlY?=
 =?us-ascii?Q?qTq69qra24tNoh9V+Jtq85Uo9KD4BDjDWVeHge7AdxrLJ+PRBpLSJQY9iX4d?=
 =?us-ascii?Q?85eqWJAu7eXflQz0h1p0td96VqVo9Pfe30QEIR8FF5rfHCsqgDgn55L74Zmw?=
 =?us-ascii?Q?81/88ImG58vQNiacT0i6eIOXHNrIoqw19Rin+LGOiru7XIITldnocSekkxpe?=
 =?us-ascii?Q?/6ElrL39Rcqh3nqDgSsFL/ddTPfnD7OR3omZAQJ/wEf8gzx0wNjeSOyukxUt?=
 =?us-ascii?Q?ci6sGK/XucOAOrS5Hur6TwNzqWUhpclGnXQ+anpDTXn4IugF4KO+QNoh2pjw?=
 =?us-ascii?Q?UHfh6mEJrXR4dbEzxr5tfeQS3xNfcIdoyB2Yhk67YoL5qv0+WO/LHBIrpImo?=
 =?us-ascii?Q?WYjm5mEsUzU0wHXyGGckY3/CrZxpfgxpvQ0yJljayIDQb48dOsQQ1cTzyQcS?=
 =?us-ascii?Q?ejrESRTwQ5RBudCnrMi05MjwhNtlA1rgg3FmdXdMjYAgKhjXNPosQ5mHKCFt?=
 =?us-ascii?Q?EhAQHrTZZ8aZwWOkiPWq6r8QwWafnw0n6wDNajXFxTViboOkicuq453fDMby?=
 =?us-ascii?Q?344FKoAuwHwrQvrr6VbYeDGwfIIrrCp2zJlohCugvQsZDod/C37YS+QQBTsz?=
 =?us-ascii?Q?sxSoJHJTQwHTcT3FaAQCGUyDMehGKNNoYKQHSTGb?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:46.7685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb65b47-44be-40bd-613c-08de4ac98250
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9745

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
(the TCP Client) times out before receiving the SYN/ACK, it SHOULD
attempt to negotiate the use of AccECN at least one more time by
continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 479afb714bdf..8039c726d235 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3571,12 +3571,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


