Return-Path: <linux-kselftest+bounces-46820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF6C984CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E03A4875
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A6336ECC;
	Mon,  1 Dec 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dusZjSk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEF3358B1;
	Mon,  1 Dec 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607118; cv=fail; b=qsZ1GPxF6Xk45D43w9t12ZkEPSPM5/3NYXM7rwsM4I1XanOp9WCS7/gQou2pR7kTk5x/tH6jOKVBujMKGbWXUOdPJrqkaedxxql8xqChoX1UbogZcTkvI92MQyLoDKGBGQjwe9XeqhjPRzjKDHaTaqnwkqQSW3uDXzzX12M8eaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607118; c=relaxed/simple;
	bh=Tbxrku9UDXe1WskClpxfRhgbDqQVukHy16K6i4RtDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCqOjBQ8ConZ70ZijN4lvPQmGWd1D6zBYRsTK2n1AWamP1CbZzDk3Oy00sn22nHqNHX+Y7mbHJC4/d4JCW4Q5Y1BS5SEW04+qKnRsFOKcdkYJXJOcuMP6CMWouX/7xN1woIWT1aMBP4ktGfHXGllJ93njx29RaiiB7dEhlFn9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dusZjSk9; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD3ILeyJE1E865JFLkkyPRv1sPWGrzLAhAxJ1vvevk4mEMyVpLLGkQ9S64iTXXe4DLsRR2cyXDeV3WXesOk/cIHKOpXdtLbH1+6paAYDiJfKVRikRWDofqx0L4MlS9q0HLhedbTEhiqnJ+L0hKJ3Hp1j/iWoUFQAr584FBELwT4Q1lkKe3BO5IQTeCNqxhWEy5DdbIbyeyvMQ+CtWyqIV2cuCv7N0AsmJeg0VP6p3CODcdhqeeRMMPgyjKp+9UC6t5qAFNqcw2lo0RyY0ofNBKJDgtWFITC9yk1msXfNIGqX5igLITh4RRE+MEvVbfEA3BQjNLB3Jx0JOpxtlpg0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=CVoHJtHqyoWsW4RoHGYcWhpT1LW0F2teJXtavjG6kPXCn9o/YqcKBN4SRYvFvRLzVjHnNhYk2WXwlBKCF4DAeXNN+n9WHk0GvVEDZ6t9Gl2BTd+3wUhgV+9rLwAopAe3gDtr8TcYQ56YALpxExCLK7ExotS/PIpreD37GibU8rQgRgTaE7akX8hWufQgeRfRLnv2kqNZQVlmFY/W+YQl0rdinoNdkbWBWcJH27rDEBdZMK6ka+yDxyWtVkyzLl3TPdQrG64oXdyRfL2eepki1T/m60KFVMZ3lDlCMF9C7bL7f/mtIyU3C9os1FznjxpBKbMhAuIlOXHIOG8z1XT4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=dusZjSk9zjpyl2IhkLPpX43poynITEi6ewrxraKOBwBjGnYDUoVL4nh67q8mleWFF8CtvyD3tAuHuvaHS3I+6vleB9enx4Fd8mRJDdxLETLT6Q9nDuDwtM8cn1leudcPoO8sbSx8EvuAflw+f5F7w9ixjfgDn/FuHqoz1W9ywRFWwSyyefCSnjJo6si9BV92E0mQf5vnn05MJBPSrz4C26Ko9iRF76d19sEip9MiBgljtigJZAmgaiUnKLCSb0OGqL4Y/l2u8hn4+/1cBPrw8USYqahd3KzmaeGV/wHAAWddQ7RrCZ+39LyhDpP0kech9P7Ks7N7Njl2vFB1q3ihdw==
Received: from DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) by AS8PR07MB7335.eurprd07.prod.outlook.com
 (2603:10a6:20b:253::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:30 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::b3) by DUZPR01CA0038.outlook.office365.com
 (2603:10a6:10:468::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4E981680048;
	Mon,  1 Dec 2025 18:38:28 +0200 (EET)
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
Date: Mon,  1 Dec 2025 17:37:54 +0100
Message-Id: <20251201163800.3965-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|AS8PR07MB7335:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8021120b-2522-4edc-6c1e-08de30f80f4d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+HyCLS96OxPGn0JMrqOfFhc96PyMmODDkYq0uak48XfoM/J6712h6vwJWlUP?=
 =?us-ascii?Q?08uAUOc3h+KMUq5W37jONVqKnNSz7Obal2Ua/Nqd0iGAZqBV6ilO8VEEypcp?=
 =?us-ascii?Q?BganodKopKI+cnwpzFIj1Ck6/HNLVag6+W/DxoQN6Xcv/465jPqpvvHUbXhl?=
 =?us-ascii?Q?/oIMyYoQSqMajjA2UwsTEjD9e6gfnjVZZi/i5Dx4IcnqDevNvZqzl0sZ3NRR?=
 =?us-ascii?Q?NggPPD0I7V+Qbw7lg2AETVadQncb4DcK5MayXodp59f3GhIaF2+Q5ltuzOQc?=
 =?us-ascii?Q?xSW+MCkJ+CRjNTWmZ1iZoMujvNkqGvUKlceRI2iKKeudBzBCycnMr+ldjyzA?=
 =?us-ascii?Q?mJLK95/jwB1VB7+bmqttPsh5yVX0BQypQKcoms1pJ34z+fcN05wH0bSt1nG4?=
 =?us-ascii?Q?gKjfdSlRM2qJK4wByafa7nbQ96CK7fTvchLbkDLDJbzjBxYVihDNohT8pB+d?=
 =?us-ascii?Q?DMulCT/abihGQ+JmTdWJ0zZhsYEQa5DMxWGO5eLTqlbcQuuVpOj67bETvZhs?=
 =?us-ascii?Q?PHCxniGCNzsCqIuzQO4DqT30EcN+IUfWG6W7W1hBd6C7tIK9NQkk0SxdRTUp?=
 =?us-ascii?Q?Mw6vT7CIcRnkicSaBCyEHDuKGsYhl7VjRNrm3RUy6epBQq0LDwp5zxmlS5Zz?=
 =?us-ascii?Q?lTj/FekdtXFW32xazflqO06ErlU/XiZ4W9h+DQTUUubcLJ+CC0J9IzSP0n03?=
 =?us-ascii?Q?ILLXo3AkOdF7noEt+Uzj68hm5UyOEb+Hi9xnXsR46CC1gHKw4LpuLk2tznOz?=
 =?us-ascii?Q?HWzywlWbX8omZb0hJVAMmU3RcW9zlqK/DVFdjlDBn7DE7MXqdOiyCJuCoWu3?=
 =?us-ascii?Q?LWwBXDyvDQ2amRww60L5fqMiIqxhbMndwZY63vb7DU2BV+OLoBKBOqlp+76S?=
 =?us-ascii?Q?TPoalwY1567sXOgmcaf2TPlBED2ZvIsaOV+sOJ2VQZGRva2JY8MUQFL4Tmex?=
 =?us-ascii?Q?sXMArdZDAI074+NzgwLBL5IARA8559A/hmbChSetKaUoJwweEYklD6rJzOIM?=
 =?us-ascii?Q?0qr9xBYmmBCUP3EEuN1zBge6uze9gOpm91K/e3L6emZoSaZ7TGVMvVjQf90q?=
 =?us-ascii?Q?jyXgDOCNviv8XWcEUqa6gkiKe0LmIkjImwWOSGJahbPE+J78pNGW2BRr9b7f?=
 =?us-ascii?Q?0cD5BSFzHA/oTTHV9CHh55sIP/CjS59BCE5GMX9Z59DRDgc7710gUknD4RSj?=
 =?us-ascii?Q?ixw/5mOZmJL9xacV1fQLKSHUnUBkxOBPVhvamXXh9T/abJXS2eJnz5Wu2Fh1?=
 =?us-ascii?Q?YwWu+7XNbn9XbXaM4wfN9GkAB0d8U0VqDBMVrpmJRTyxt5nIf+NgYL7swSPc?=
 =?us-ascii?Q?6gKxgAOzY7OtKNv8dgFhAR8W52Qc2DaWrUca89Iw3tOFDi2Mto6812F1PdDS?=
 =?us-ascii?Q?ke4/sjXmKQboIVuvQOqqxBn9L3vzOHQkTOF3HSt0fLMFxUitCqMydrhgUNC2?=
 =?us-ascii?Q?NzPrfK7kZ0iHamRZpWMVr07PvfiJesjQSf8MEd3UTqeZS9HrX8dH0SqRZLQG?=
 =?us-ascii?Q?YLpuEG3XXGAVHSOst3/McQqQYEdyawyhgQmVu8vFaIZikimmY+zZBlUydKFF?=
 =?us-ascii?Q?8yGkDHRpXlN3FeRHbx80OUghjL+JdsLm3FoWiVNC?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:29.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021120b-2522-4edc-6c1e-08de30f80f4d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7335

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


