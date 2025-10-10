Return-Path: <linux-kselftest+bounces-42952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF31BCD19C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E75401AB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8602F531A;
	Fri, 10 Oct 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cSwIuPGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1A2F0688;
	Fri, 10 Oct 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102263; cv=fail; b=e+b7Dd12W2I0+IBfp8lPQkvukyYqnQh6dDMpP2NNUicBpn3jOMOBX5iZqKFFi1E02gehCYS7rKefmaYmmjtVKlAw1PQsBW+bQiZALnaTXOiofBj4di08ksSeaXYaiovlUS2aGRasJmUyQxz/hpaEaF3uo7gjLELITKr99qG7Oew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102263; c=relaxed/simple;
	bh=VvjNrgUOG+2q9U54TORO0KAheXriJpHU764d8EWI48U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL3JduavfFHjJF/FyIM1CXrY3OmaW8z5SmWm1tcyTgYnvqGimK9KL+fsLAB1WZSXX52+o1P9JxxmE6PF0zhIdpBii29DzRjKxWiiQOgriXxW2ukk/gb+W3msqY0FlzY4/554OVW6cnjvOY5gaAKKpGbr8EkhfcDUI3JzPjJdleI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cSwIuPGE; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5hMiT8IwFsv5y6KQKQ3KfmyvWmoUVM9CLT2Co5wVBMq5JffH8zlTktoZtir7qsufTPay8pigW4d29mfk+gCgJQm15xVwH4kO4QtvA1R7vbMzXRhZTATWCp4oHl5S1ZVYanoTiHR0E7v73nyhg960Ul/6JL4CUZriTYrGAICFLvmB05pliG9hO6zDCUn3OP7Mf1O45Q2dKhyIgJLvvKvbS33UCm0q3/iUscYycdFs931AVqtHHQNx47ahSC8f55dcgscrYzQRdOvTVlu55+Oa58FzZYHzeSIZvO7kgcXZur9mJ0pV6KpIh76FKtT+cZCJPjP222m008hqvLemgkuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeO35W+pzTJIls9iqnzLDzbVijoVPNDIsl5W0qy0yFA=;
 b=yBgsClwVVaBYY4c0NaMjY55UKMh99IwgwpXdBzu0y69yANef0EwgMy26hSiyhBwY7NtglgEPMm5m4Ghefn1WB8THBwzDT+JiOMwX/RfFLudmkRP86LNVDuplnfie+niFBUv9fWH9D7zyrobCWtLqGj2aEWudrTAn2pqXaItHwnIJ2gYIXykXf984zzJu6GrtWTXcD7RE8QcBfEzX5PMsHL/vPtmJimpTQTGOUNsJ5RgtS0ZyF+2Ns2//2E1QjHExUYSR3YUNm9JSghssIngnbKndddurmW9YOCbwO3PzkPGxLCZT8TAC1Gk43dJ/aB3KIBGuirrctZAmiLwJrVVt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeO35W+pzTJIls9iqnzLDzbVijoVPNDIsl5W0qy0yFA=;
 b=cSwIuPGEyXf4rGp3haKbr9pkT90J/c8QatnYu55Vw+a1nHs9QG3itoZ5XqnpI/q8pIlsi1Z8xvy0j59s/443Oj0XmlzxBE+rjq055LVkBu5uyIpdwce75FqT9lIntt2iL7nSK07sSRI0U886zFAbY9eYTkBGR4qwwOpTnNgEwF2EOtAoa43ACFnVKd813vGhnNrCZTc5E1jWRnwTCo8jEdfwqxV0ZZKX7RH7I/LgPuUTa8Wyo9Rs/jPFD2spTymRW49K+kzD2MsaFwqLeCXRGrshZfafb9SoDD+y3XTTpb4UNnDCv8r+n/8ruYPcu+YJdi6Tzs5RfWewFBmHeMbXVw==
Received: from AS4P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::8)
 by VI1PR07MB9996.eurprd07.prod.outlook.com (2603:10a6:800:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:36 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::fb) by AS4P191CA0049.outlook.office365.com
 (2603:10a6:20b:657::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 13:17:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 31DC61C0052;
	Fri, 10 Oct 2025 16:17:35 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v4 net-next 03/13] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Fri, 10 Oct 2025 15:17:17 +0200
Message-Id: <20251010131727.55196-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|VI1PR07MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: ad695e93-e14f-48f9-1c0e-08de07ff618a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnBuZ0pCYlNaL2FrSE43S2tFSEVMRkkzS3FGREUwRXRnMWlZMDA4cU5VWDAz?=
 =?utf-8?B?QTlMeVpzYTB2eld5dk83SFFvSGhERk9NbVFQOXYzTDlPTTlxKzEzdGdyWUZK?=
 =?utf-8?B?dXp5M1pFL0ZNTzgzTlM2QWhTaEZrUmZiVkIvei9RQ01CdkFOTGRHOWxxOCs2?=
 =?utf-8?B?N1ViNnVPWjBDUDE4REsyMXIzZnpuUTNMallQdzIvQlk0TGlTQys2cVExQzh5?=
 =?utf-8?B?bEhDSXZ2VXkxd2poNWd5ZU8yTFNPOUpHMG1TS0RYSzkzZi9pOVplUHgrSmNp?=
 =?utf-8?B?T2Q4dCs3QkNOOVNLTkd4OVkvZUhaWVlweVJjeFFzMjZrNDBpZ1pFdnJ4Y2lV?=
 =?utf-8?B?Uk1YanA5bVBtMDJZY2tRcjg4TVh1U01WbkxhYi8vb1VtdVh5NU5xY0dON2hT?=
 =?utf-8?B?S2diOEZZb2NoK3lxT2ZnVHJ3TDdOUEZlNUQwcjJMejlCREdGNnBMTzFBYzJx?=
 =?utf-8?B?VkZLRHlJQlZDUGhlUUtSQzVxRlpsV25BUkhWcitTS3FHUFNZN0J6ZjR2bllu?=
 =?utf-8?B?Y3Mwa0czcGMvY1p4WWlmYnoxTTZLVDJtMkhLamxtOEZiV1VmR0hkb0FQZUQ2?=
 =?utf-8?B?NUxzMG8ycXlaeWFSR0x1OTBoUDRpQXN5UnNNM0U0cmYyaHRHNWtLSFVWV1FG?=
 =?utf-8?B?REEwdGM2NzBRSzAycG52R0RFN2oyQXBETzVWYUVzckpWY05VRFlkOVJ0anpK?=
 =?utf-8?B?TThNRU4xVW1zakRNUXlvcWM5aE9zcmdYTENNMWk0djdjNjkrcVZYR1VPS3Z3?=
 =?utf-8?B?MVRaNmdBVlJ0RnluK1ZKKzhrUnVOODZ1Q0c3YXFobXRYZ2EyRHNGNjhrc3k2?=
 =?utf-8?B?WWVFcGhwb1Qrd25vRFpnUnhFeGo1bVVLRG9lUzh3Uy83MFhDTDFrWGVQNFlp?=
 =?utf-8?B?bUcyRVpsWFFxVkJlY0ZtSTVRQlY1SGdtUWtzQWdDaFJLWUZYYkREWTBWWUFL?=
 =?utf-8?B?ZDljTFptcksydjBOSXlUc09vdEtOelVvQWhLOWxYYWZXa0VBUHVTb2dTM0U0?=
 =?utf-8?B?OTdaZlZTQnNaTmJ4bEtUMWhtdVpvZE1aeCs5SjlDQ09MbWhKd0tpQ2pQdTRU?=
 =?utf-8?B?VWRXSmFjWTZxMWx4N0JzQ2l4dHhPWWlZZnFSMW5lRUhZekRmRlNFcWdsN3RV?=
 =?utf-8?B?bVh0NW13UHFwL2NZQzJKUC8zMEJzckpiNFc3cDBKWXVhY0wvMHZ3cDluVlIr?=
 =?utf-8?B?dlQ1VW4vZnpPU21vc3FaR3BMK2N4QS9lYmpMaFIvUzdyZFBLYUpIZE9LaUxE?=
 =?utf-8?B?cm1qQUVPbWxYakdFeHMwQVpyK2VxdW9JdEVFZy9OQk1tMVNaSWZpVzNhKzFB?=
 =?utf-8?B?QkFiZ2xnd29HMzhyTVQxVmNQRTIwcGtVZTBOZG0zK3dBMldianlYbWM2K0pr?=
 =?utf-8?B?OGNFTVVNYWJta3doS2dXNFU0b2RaRzdnSW5RbnJSYjZubjRDcFlNTlJBL3Zv?=
 =?utf-8?B?T2JBVEt1QVczdytRSFZ2Q2kySklCMTMvejRqQjR0RjhmK0JPVUJPalJUY2ZI?=
 =?utf-8?B?a25zTnVZc1Z3OG51WG8vRFowRlBYT2VlejRTdjNWU0IyQTVDUFdOaVBTMXRs?=
 =?utf-8?B?MHBFbldJR3gybDFMRXFjbzZycDBRb204Y2x0c2NzSW4vNlZzWWp6MnY3VHpV?=
 =?utf-8?B?eGpka2hwUzQxV0NsSEIrTitXdTBHMTB2bGJqRHFxUHliMWdkTnhnSTMyMzJR?=
 =?utf-8?B?UVA1Y0hTVm9tZVB6eE9penJuYkRnM3lBaUtNbE5jU0J1WlNPMzNSMkMvTGxp?=
 =?utf-8?B?V01CSThQcjBST1pHUmg0RE9DUG1zZ0xwYXg0YjVvOWFSK1FqSFVvS09FMVN3?=
 =?utf-8?B?L1F6M0w4eDRCZ1orbFprQTBoOGRJbi9YNDh0N2JvNElRM2xiamhWVXhrbFRn?=
 =?utf-8?B?emZWUFdTNlQxbmhaTE4wOGlENXJicDA4S2tmSWdLaVJyRGQ2cEZZRFhqY1Bn?=
 =?utf-8?B?TGpLV2JqU3pLT0pJL0VnNGZIZVY5VkNYeU5BTEpIQWxtREJoMU5ZUmhUSDc5?=
 =?utf-8?B?Q3hnaFdpRThQWU1YWndCNkdMSVluL1VPcHQzVEY0d3RacmVxZE9kaDNJMmxP?=
 =?utf-8?B?R1dXSFFZby9wSGJ0QUlqVDdVTXNUak5KMjRuWnNtZHY1V0xIVXVteFE4R2lP?=
 =?utf-8?Q?gwK1a2p2hXgOvmPJm79+tasyy?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:36.6877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad695e93-e14f-48f9-1c0e-08de07ff618a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9996

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
index 5ca230ed526a..8467c83e4aee 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -403,6 +403,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1190,7 +1191,12 @@ enum tcp_ca_ack_event_flags {
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
 
@@ -1322,6 +1328,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
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
index 8af527f4e2b5..27fba14bb3b2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7233,7 +7233,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7..c7b884f173d0 100644
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


