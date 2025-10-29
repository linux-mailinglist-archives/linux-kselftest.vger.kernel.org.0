Return-Path: <linux-kselftest+bounces-44265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4AC18F32
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 177184F66F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99D732E6BA;
	Wed, 29 Oct 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gCHim5QZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FC32B99E;
	Wed, 29 Oct 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725204; cv=fail; b=pghmDzRcmq55RnjcsWmhNQU/VMVm1+m6ORXySpDiFOS5Tq32dF3TBPJaTRFwk72r+MaMhU153dSldolWPGZM7JZND63Io+/LaVhenTk8uabClkvtn7ZE2pqDRbaJwWSs9BFwWq2XaCGUX4nd7UGJrFyb9qjkFcDXk+RryJIIyu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725204; c=relaxed/simple;
	bh=HGYvJh57mRlKSm6HPNfzkQrHpySiYLJCs7PcbOkaqBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJMpX8UxXzsgTq2+8AjsLTVIMZxloKDVz7y5EVXyQlvhTsMx6M6/1W3con3HE3fohIX0JQEXgh61bfCxOAViHxz20A7IjqGJNQnYnzUSEwFY7mO/4xAjiFe/1MdnxIwc//ybb5rnH/xsQtfZ1Qwww/ZV3DWtrgNMlwfKGqiF96Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gCHim5QZ; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOd/LWjbmAKNkrr+atRqoYo11L1BQTCb/MIhTDDnuC0x0i5AC4Lg8Y+E2jnkFUe5Dz3vuXUP9fNzSvwQbEmM0oPHD6AgUzAQ0wzYb6954qyWRciZloFDxvIo69e6wMJnpuIOj3tcrbsA3wa5Bo/EoFr1CTJyIyeNy4flzr7hnvcPG3JCQdCM4sxuPLye5OY+gHvtQ+iCafdRA6faU3F0K7paIONQEfX1gxAAjDZXLeoVKytzwRx+nMHo1rBqYwMEvX3QyTDdeTxKmYhLUAR/HyNMYAiqjZYupyfQKkv+yNuohJWAleYIiCixuapuv/gS0h1++gWQgakJ6By0uTz/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Do075TrsNt8mtS9+ADiQR21Am0fode/jObVOb/5A+w=;
 b=W2/CrNSCe+1IB2I/akBwICOk/TGRxRHQ6GpmchqcWP78YO7Gr63di/yacalnxve5oWtPgSTAHbeJiQN2JgEkRhijdHng6krV0Z18yWpt5ZDTIFsLCO4ZxX4owl2mcshnRrQDujiSicf8YuZCe4ok10RPj71nVejQ+NcW4yoXqH2ol7xhmwc0mHUAfyl+mJuFadcaBYSxewnpI5qYe9566/iP6IuN+wIZmFfR7c/7k8MawMzPu9W7gzwewzRgeS0+mg8fqJtGFGLcE8l5MRsEbrf0aTgEAhqkptXhUqaWTBorOaF6xdTc7wrY7ojhEnycz2jZ1tw1dMg8GgyRsHJ6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Do075TrsNt8mtS9+ADiQR21Am0fode/jObVOb/5A+w=;
 b=gCHim5QZ2CDxQrgjtQvuV51m7nj4hUHwTbI5WOQKAyI36XIv4V6jn2Y0qhVoacytdVC9G1wBCoLHVf4p9JzzS3+uvWRbeIliVXR4O0qyJUPJRiWpFI2JjLp5bqumQgGsfq6Jyo+apa1MIrM8fZCPukFRtm099Nt/ZJdQhi5QPyz0N+FCT1RoTTui9n1XKrhgCYJKxOv5LI8X2qIgegXUzzbptlET2visEplFuKAjQ/m/oaZ7mRe/naMYY+afKeN58qb87LRf0FJfEV9LDR2MRG1V9hMr+w829B/SRWRx8Sxn+eL433mOhD/sHN9W8ZY9lMaF44QlIAz+5CfrYEfv2w==
Received: from AM8P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::26)
 by AM7PR07MB6577.eurprd07.prod.outlook.com (2603:10a6:20b:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Wed, 29 Oct
 2025 08:06:38 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::f5) by AM8P251CA0021.outlook.office365.com
 (2603:10a6:20b:21b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Wed,
 29 Oct 2025 08:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5F3C320202;
	Wed, 29 Oct 2025 10:06:35 +0200 (EET)
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
Subject: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Wed, 29 Oct 2025 09:06:04 +0100
Message-Id: <20251029080608.92428-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|AM7PR07MB6577:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b74dd837-1bf8-45a5-4afd-08de16c21546
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Uj2TQsr/rlZmC3CYgCF0Z1vXZ+joz3Go9z0rWp9XabutPihdoVOKWyCCuJoM?=
 =?us-ascii?Q?AFMDljx/T1obPOVBlENzFsPFOcdVsei7vNTrCviGFpfAAtzG+kA2LgCqs/2x?=
 =?us-ascii?Q?yAPsAa4IlsFb/R/qnQX3hbB0RSWQXHWNz+H2lceCfMCGLxwvM5Vy0YMmBdew?=
 =?us-ascii?Q?DD1F+OCzLNwbY3/jcPiqTP+YPdD5PmI+lwbDDX4HxedQzzPNOeArDnamkdLq?=
 =?us-ascii?Q?MQe57bib5GTgOHIB+XitBobapecXVgNkLvzreCZah0sKOoSzxhgol7kXCmFX?=
 =?us-ascii?Q?1FE4RrOfwaWSDdDxkZUNbPRy1rdy2hlcrtgmmTH5gbGxIZT+/eSL6V2Za3io?=
 =?us-ascii?Q?o5iGERNPyc49nFx/iDN78E2dmjyClXLs5GYtgHrhWU5QhbASO7Pty5GTW7b0?=
 =?us-ascii?Q?5/7/KL5F0P1CKhUwLDmM8jpGOAEpGnTuyWeAfUeHFEQ7YAso8wuZQHw9911e?=
 =?us-ascii?Q?4MTyx8looyeRTUt8gvXQYIOxcLyP3rGWH6xtsjhf9hiwD2Cu8ucAZ114Y8fp?=
 =?us-ascii?Q?fcpmm9ACdPSNORmKXfhBkIMnFMktiGo+mg3CHePDfWa7q2RUBCChuj3zNvvM?=
 =?us-ascii?Q?h9uR0n9SSRpkYTVsK4m2XShcpMST0ruXHuqgtDXEu+E9c9rEJ6XpglArXNhG?=
 =?us-ascii?Q?Mdy9bMG9XqMSVR8EnNXwT7Kc7NOcCwFmOdF4usTW7VNbomTmNP356XzcKa5P?=
 =?us-ascii?Q?xj1Oaj7ZqtiuL/FvPEGnsPJrwlUAxfGTTswKhYzGmki7iiwvM+m6rprlpkZr?=
 =?us-ascii?Q?xjTnRdBPTC0paB9xnyMrg7npeT+csq7DoCFw53xyV+QwrHHLMiJfM2DoAg8a?=
 =?us-ascii?Q?gSpRsQN3Xodatx3ZrJaCFg/Z/sICpNXie2udehjqsdjzM6OwXN9ghf31jJyP?=
 =?us-ascii?Q?BOO9/xsxWOBpkITbMIhsiNQUhNOEIoMUIqZ4ord9jA0BezEKY3Du5Ic8REva?=
 =?us-ascii?Q?Y3uEa50KbC4g96Ht6xSXs37qOhcN54gZfSArZpih0INJDF0F3JEmGoV0OvM2?=
 =?us-ascii?Q?bII2hlNzJJ7PxAUPqYuCvbzOot/tLgRPtmVpzhpB3KHvOPsZRGaJAdCRyfi8?=
 =?us-ascii?Q?1J9lGcqYxkj+J4shZmu3nokVZF3SaG5PNa34O9CL2JOBwW4UkG6LHXXP6OqJ?=
 =?us-ascii?Q?3g9Eo4wsW/ZDcrSFe9etlV6t27mfsVsOKp/JicnhRDnQZLLTrPIbi2cfCxpB?=
 =?us-ascii?Q?FNz3V912A3p+QwadX/4CPBBi6nLSJ4ulhrpvnw6E9/P3e6CFuHuzBT66RIrD?=
 =?us-ascii?Q?XY8FNklcBU5O02Wyj3IQcRw8pNYohPu0KmQWhbYFi4i9SkZBbjjBWRIvEKOV?=
 =?us-ascii?Q?lyjBOMqleoRepXSG76JjyL1f0us3l52qt+v5QTanBeyxWCt8OFseZOvGvq0x?=
 =?us-ascii?Q?VSHCPob9tNFQ/t4gaQCXP+7zLB4VAQx54LKP4C/m5ErxqV3NdQSK2X2C1QMY?=
 =?us-ascii?Q?U74m0Xde/qBuL0xu0YTrL5DadpiZX4i6GEmAReHqpV1yrbu6s9D6mLHtXk2q?=
 =?us-ascii?Q?aHpca4xZxQV1EVzhjQd6Im18cReAq+Nm8Jz/9uRYiXYJz3LaIvy3XaPDfgEw?=
 =?us-ascii?Q?JdYFN+NzHqMt3jcsYloNlxTE/OxMyNR4fuCtYsY8?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:36.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74dd837-1bf8-45a5-4afd-08de16c21546
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6577

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 14 ++++++++++----
 net/ipv4/tcp_output.c |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index c66f0d944e1c..99d095ed01b3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 static inline void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	if (!req->num_retrans || !req->num_timeout) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 90a71556b93c..37c04da4cfb1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1109,7 +1109,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_retrans < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
-- 
2.34.1


