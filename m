Return-Path: <linux-kselftest+bounces-44407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFDC20A67
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18521A673F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27A27E077;
	Thu, 30 Oct 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tFUNjk1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7090277CAB;
	Thu, 30 Oct 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834892; cv=fail; b=uNw3vZmFb+93nyroVyOFloZ7Ch3nAFwH9/EtD9OOIgCLvb12VqAEgBlCUGcOJ0XJ8jW+faGCnzAcc4dZfnt7LVPnWASQKWoga3HO/eUXyA1AfBvm0o+xdG/ZKX+t9GHCMjRZW8HVnV9uDL3t2nmKiZ2oBrR491wn6U4wIBUU5Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834892; c=relaxed/simple;
	bh=DZMc5Jj7nQuzt4HGTd59TXKPQkBwuAoRGiLNRW3jao4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnGlJIfsOSiTlDzp4TIGIeXFkfVrjPlO1IRF29v18yT17aYe956ZGNCwr+Hb99vujf7B4pVnyRgkvPyFqn8vpFDciWDprcwu8hc/bc5BXIO22D4PkHxO5mpaebQTTE3Q/j+rWK/Y5AwXJd2PHOGpwrruqADE/KiLVz+kFG6FTTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tFUNjk1/; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml/xo46G52MwEacMmhYff2RqtR8KPtvKhrg7Y4hY6aNhXDC13mhuID4idUqMSUbfvnIfKyI4o4q+Fa12ij6AIShRnRKuSos0uE2SnitGUIhCCPKXjY96C+rdibbYeCeEIDq4qCu03P5UkNk0xXwx47D1jyDH19F/gc/5TJWd8GssSeKlzSDWWPTikFNmj6dKt3FSto193qjvVrkv/Yd37/NsMjFb1+c+4msqIYC44m1d0MD3L5cY90sGjhNs6419j7aXPsfojMqvgFIxVm02KW0wkrvmH4I/Axs0gf3ZD85fGMGNy8FC4EMmUCNMV3w/by1YhpgSN8zrJKMXT7MvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue9xrzn/0yreIVbPA3vYy2LyHolmrEXh3PJb/NdNIfI=;
 b=oEeAjYOWoVMF9NMMEZtTlxxiMu255UIjINNLjl2p8uAzLq/iwccTih+7r1p54Nkw+/mLDl9o8b7Ajb9jhp99yAPW+53wyDJDxWftAAb8MTFaFK6BocYJLlgZ+hn6X9IatpU+BYb6VulSGv+nGoBF08YOQLPCnzFkPTc8HnUikZiRXK8ac4l+122Sx9hVK2KOoDrgMsfsJoMCSQLCofwmGj55Upr4rqkd63laxU3LQdHeV8JogSw337okYNlSUhwx6i7NW/XZ3+GSDp7uox89jPP29iBgUJyTyE2bXl2EjmBZg7bviNx85m+o4v7YC6RPyj1jak2lNtsJIJtyYSselg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue9xrzn/0yreIVbPA3vYy2LyHolmrEXh3PJb/NdNIfI=;
 b=tFUNjk1/fHtri9RP1iTHtOY2b2h/eCLijItLP+KeisYxLFtnrjwDdfmOV6kxTh4YSoHEW4aor32tJzZZ+x+Cp7jtB2tDVtGSwkELtOAlg6N6KqFh06GsdG5nToc5h381HbC7kt/ZfSFd2r604p6c3s/v2pL9TJh5bSXLtzBcikeVgSUyEngVJU+PanG3r8hUQDVYZuH9g5Z1Mhq6pnaHrYpv5mWKnvtKhU9TfACNIxR4CMxig25+4AM/4nmqh6AiPa8rik/zpOgUrLf0Vo6Wcqbg4u4NpHVULQ6xAIJ/7EkQ9zjHPciyRKy4Tzkd0wSY0109eZye1X9iZy50t8pHaw==
Received: from DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) by PA6PR07MB11556.eurprd07.prod.outlook.com
 (2603:10a6:102:515::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:46 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::1f) by DUZPR01CA0131.outlook.office365.com
 (2603:10a6:10:4bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 25ABD200D2;
	Thu, 30 Oct 2025 16:34:45 +0200 (EET)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Thu, 30 Oct 2025 15:34:26 +0100
Message-Id: <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|PA6PR07MB11556:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf22694-964c-45a8-e263-08de17c17984
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dmF3c1VVVEtMNDhoU25TSU81MFMreG1Jd2JUcEtOSEZwbzhpTDF0QStUQ3pI?=
 =?utf-8?B?bkI3NEpjMXJGeHAxU2MyMG9qZVkwTlBrU2pZWHNNb3U4WCtHTDFjQjZPUWFh?=
 =?utf-8?B?VDhaQ050Uld6di9aNW1HdEVHcXNCRHNqakJUMWZGeDR6YWpjaVlkR0VURUlz?=
 =?utf-8?B?SFR1Sm84YjlubU5ZcVR0MnJXWlJxbTVtNFBucE45bGx3MHpkZlhnTW9rV2pX?=
 =?utf-8?B?blRUTnNNV3lqR1lvMXZxRjVlMkxTWW9tRmxlZTF4b010azZxem1DQzNaR3I2?=
 =?utf-8?B?S05TVDlPY2UwNHhOaEl3VThxOFZqUS9FZVVRaTVlOENnaVE1anNOYkdReFF0?=
 =?utf-8?B?SmRSbEpqUElFdDhEcnQyeGRzbEN6S3l2dkw1MGJzRWNTNkRyNlNPQ0NCVTRS?=
 =?utf-8?B?aEZWSzR2TmpqS3FyUXdhZTd5QStiTVZ1SlRTZGdEdXJpSUpBclltUEJHU0tm?=
 =?utf-8?B?ZHhYVFArQW5DSmVTblBuYlRzck81VGJpYmNoWTdNZitaWklZYzFOOFMvWHBv?=
 =?utf-8?B?TmNVNytvTHVlWkQvbVJNUUJyYldGZWdGTUoxVzAxdnc5RDg4SE9LN3RYclcr?=
 =?utf-8?B?U0pjNWhSenBBT05HK2R1S1hEaHdJcENXOVNENS9KVWkwekZpTXB5MGQ5L3h3?=
 =?utf-8?B?OFR3N3pITzNCZFBtSXZEVzRCRTZTUEg3ZTNzUXJjRXdwS29NZDNIelRSbkV1?=
 =?utf-8?B?Q3FRMUdIOWdtQkg4a3B5Q1lnNkRiNmdNU0sxYnlGN3M2RVZ5bXV5eC9oSGZC?=
 =?utf-8?B?dkN4aURSby91Q08zaUMzMEREYXRjYWlHVUFvSmV3QUJZUVZmaDFRWWREZVl1?=
 =?utf-8?B?N3pwVkZMQUZVc3BFQkpFUnZRbWlNRHdaSjUrQUFmY1ZzMWFxY0ZkeDZCZHpi?=
 =?utf-8?B?RC8vM01uZk1CTHVuU1FtM2FySFNEVzRFUWtVa21VRHhMQWdYMDRFejFhdTVJ?=
 =?utf-8?B?UE9PMnFqTGhhazVZVldaQ3ZYRWdKa2JHcktiMGlNc2FiT2dDVThDUVJHNGY5?=
 =?utf-8?B?anhWdkY0MitnRVFJeVBDNzlUbzBMM1JKRFZuVFR0Yk5UNkVRWC9jRG9sUHRj?=
 =?utf-8?B?aGZSWC9oR3dCN01hVFBTZ2JzVDZNVW5ubFZCOEFMdjJRa01xWXdCczQvUmI2?=
 =?utf-8?B?b0R6Y2M4S2kyRkpaUXJJVmROWkRSdENkK3NheXE5SGZ4MWE5ODI0SDhVUGZY?=
 =?utf-8?B?cjZWdzVaVFZscmZsSDU2NE03TnhzUnZXU1VXUlNjYmdSZFpRNUo1aDBiQk1i?=
 =?utf-8?B?Yi82OE9wN0F2RFI4TGJkdTJGMEhocWZKTlhZd2VXWlpSZStzNEhOdldrc3g2?=
 =?utf-8?B?QUhuN1hsOVg0OXNIVm5vWFlhTDhHV1ROTTV5dkZXc2hxVEJhNDdQaDQ4YW9R?=
 =?utf-8?B?Z1cyODlvVDZZODF1dDBLK0pOMm54ejB2NGpCSWVkQUhSWWh5MzU4cXdRUEtR?=
 =?utf-8?B?UjBiSEZnUzR0OUZDNWllbVBHSXlLUjR5R01OdUpoQXk3RTFmaWFRSWRnYzdM?=
 =?utf-8?B?RElZcTBTWjF2RFNqVkN5blluWnRLOThUY2haTkhxdE1rTFBDd0h2d3ZCMnlP?=
 =?utf-8?B?b0pMSEI1Z0hIcmM3aU9tcE02QTAwN2s0UDJWRnBJM2MzOElPN1pQV2FPMmtk?=
 =?utf-8?B?MWFHQVQyRHc1WWVVSUJiSWFGTzduTGsvSDNGNlhZWm5LOEY1T2VLR2o4ODJD?=
 =?utf-8?B?NkxkMDRrZkhPYTBYckN0QVQ3bk5SNm5obEJnZFBrWXB5WStyZWF5OGlsOU9y?=
 =?utf-8?B?dHVJeTM2aVZVTUZ6dGYxT09WYUxyS1FjVWxvRGpydDBWMEdhWXJMTCtrTURX?=
 =?utf-8?B?dUlaTWUrT2xMOHg0ODJCUFNVSkVHbTBOYkkrdFlzY3ZpV0ZkRFBIc0dPWTNI?=
 =?utf-8?B?MnA3Q3BFUHEyaVRPU2lGTzNqaWVuNFVkSzN4TERBRDAyVXBrL0dWVmxISUhq?=
 =?utf-8?B?blNRQ2FmeENUL09PWnBCd2xZemFwVU1EU2dGdktwSmxSSmM1Y0lGblJqMFF3?=
 =?utf-8?B?bnFrRnFCdGJPL0lPY25SK2YyZExTWm53YXdpU0VqWHM5dC9vM1pUS1NIc2VR?=
 =?utf-8?B?RDFyT1M5RlhqeFlVSkQ2SFZqOU81OTBUR2ZRTVdZM2ZqSzZZQkhPTWFodkJO?=
 =?utf-8?Q?7tQSA2/ktOAbfRd5Id5WIr19A?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:46.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf22694-964c-45a8-e263-08de17c17984
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11556

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch. First, a new CA module
flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
AccECN functionality using the ECE, CWR and AE flags in the TCP header.
The detailed AccECN negotiaotn during the 3WHS can be found in the
AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Second, when ECN is negociated for a TCP flow, it defaults to use
ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
This patch enables CA to control whether ECT(0) or ECT(1) should
be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)
defines the behavior expected by the CA when not-yet initialized for
the connection.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 22 +++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    | 10 +++++++---
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_output.c  | 10 ++++++++--
 6 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 190b3714e93b..76a67e77900d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -406,6 +406,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1195,7 +1196,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_WANTS_ECT_1		BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
 
 union tcp_cc_info;
 
@@ -1327,6 +1333,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..0cc698a8438c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_WANTS_ECT_1 flag */
+static inline void INET_ECN_xmit_wants_ect_1(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_wants_ect_1(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..1a8ed6983ac3 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -240,7 +241,10 @@ void tcp_init_congestion_control(struct sock *sk)
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
 	if (tcp_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		/* The CA is already initialized, expect it to set the
+		 * appropriate flag to select ECT(1).
+		 */
+		__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1);
 	else
 		INET_ECN_dontxmit(sk);
 	icsk->icsk_ca_initialized = 1;
@@ -257,7 +261,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f6e6f30c3d79..b4098d5cce48 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7239,7 +7239,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7f5df7a71f62..d475f80b2248 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 			 struct tcphdr *th, int tcp_header_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_ect_1;
 
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
+	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		__INET_ECN_xmit(sk, true);
+
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -341,7 +346,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
+			if (!ecn_ect_1)
+				INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


