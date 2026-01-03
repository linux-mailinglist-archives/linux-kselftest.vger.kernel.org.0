Return-Path: <linux-kselftest+bounces-48109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B645CEFFB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333FF3067DEE
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479130BBBB;
	Sat,  3 Jan 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SYgcvwzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578630BB81;
	Sat,  3 Jan 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445850; cv=fail; b=MrYnDHedNP5SidcIGPhmoM0Z3LOBKKZyP4XPL5tChE8OzEMxpsmbKw6tuZbcUQfqCAVfRjOjDKbG/jSVLDfGyTUYdfayZ3xEfn73gwB4FVO1Nzmj7ehdAA0AmXkeb/VeVOe+wahbJi+oalG65Scn4qGtHDGXbuD/dI3aJroDm+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445850; c=relaxed/simple;
	bh=RvdwvQHJmwOXRu3ieXVeT6Xuileq7yr33ztD8CGu+Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwFARz337UkQHzZfnktOgHtad6wz9PWS4QGrba3gpbM4m0cJFgVjns5HL87Xy5Eq983xGXWcs9VBx+rEfX6/oXLEI9shVQ+DhJiaAHBr6mwL5Xg3TQ0kpCgjjtQu50VLQMB2O5SYiBTOps6m+/Qf7JzX4xCPTHpvT8l9i6hEvXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SYgcvwzn; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO89uh4lK5cQLjmDfNIfSePhotJAKdxUShgQ1zOpYO4l/3fc/fBijDzSFM4g1AMXaJwSm2OLMCogxGusZl4rBXKwyBUqZQAMaGvrlnOO2irmjSmMfNhAxuvktoAwSQ2ulnda4KkhI98JMaoTaByt6Yq5E/zIxMpgFOzhfP+ppfFLYYMvwzU3JpXbYsXJuLanUHYeK5kKJ1xSkaz6b9lWN85Cg49t8dc+zx0kY/6RLjPzkheBJQI8LfAyXo87hJBnEbHtHDIKDCSCiZ0hOROhR/JsoduI8Zuls5F4A9IE3ZO0OC7IHYLuJ+m40kvTz9aN0O9nBUFb/4PoUdxo64uyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H39qcEQ3bV3a6vUVFmPpn6mWBcKSElb8aFC41LqQnAk=;
 b=jgXvN+dzNPoqScUlkOY6b5RbjnUcZlQPCHdQcNi6jlN3kJppsgEvagGpDGbQmB5Cdyo7b1eVuKEmcDRGpkh6dcFiXx/3nGl8KBd1PCNDAYDYgSW+sE4I5VIXhog4jA8WhspWRzsdFgtVQrB3HOFL9H2YAKAsvRnsvuw+lqqoixaUA5B6ible5v+bVAE7wBT1vUZT3vZABgGo9K7DRU8xcamSVrzC9jNT5gQodDoYxjYL2TD+xEYXEJ3HKzqNcCH/Kf/Wo9MxVMugcPheQhJIgtVJoMRh2M0PskiYx3UJcQJQibgPVS5oMDtHKvaCsJn6PmIQYPXJUJSh5fVVmpC9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H39qcEQ3bV3a6vUVFmPpn6mWBcKSElb8aFC41LqQnAk=;
 b=SYgcvwznXLfbc3GV6OoDKoGo2BexEdQ6r+K1X+f3NolvYadFJnEcErIZM0jZagwtWCj/I8OpqGkEsIcPPbDenCwEFn78OjIfUfCYuIxpYUM/oDGtLuq2fOZUJ6m1AMdWEorURZ0biyV30rri2ZzdePf+wsKdlJtudq38MkXZV+6ir7dIHoEOYFXdGZrxlrrCYI42Qd9NHhmQzY73Puh/xSzQyplrcCPR/+YYcLSzJBYYCAF+zH0lk2bpzVkPJ2JxEcvHatOqFQyf9uODHPquKYNgTLpV2LOYCckYwliwCL+hvJPBiTA4vtZpQH+5F7ZTzkWovLPs8E9YDUAFKEZATQ==
Received: from AS4P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::20)
 by AM0PR07MB11517.eurprd07.prod.outlook.com (2603:10a6:20b:701::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:41 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::93) by AS4P190CA0049.outlook.office365.com
 (2603:10a6:20b:656::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 773991C0031;
	Sat,  3 Jan 2026 15:10:39 +0200 (EET)
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
Subject: [PATCH v7 net-next 04/13] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Sat,  3 Jan 2026 14:10:19 +0100
Message-Id: <20260103131028.10708-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|AM0PR07MB11517:EE_
X-MS-Office365-Filtering-Correlation-Id: a01de837-bea9-4134-118a-08de4ac97ee8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YUovN25QL08yR0M4YWl4QW9EY0tQMjU5NlJlanhxaEs0SXhYREJqQnhTTk1I?=
 =?utf-8?B?NXJjVmowNUFwVEVxbVhFTFR5UE1vUXMzMFNxNitGYlBUNjNkeXNMMTBlZFFG?=
 =?utf-8?B?UWFTeGFMYzg2WEdWdndrSGFyTGdHU2dUTWJWNjM4cU50SHdHWWw1SDJyUTJs?=
 =?utf-8?B?UGlwNU1Ib1hkR202SGRWOTlOckhXNnd3UjU5Qmxsb2xKbnhkUWVZNGVWdlhx?=
 =?utf-8?B?YWRQd3RhTDl4akJRdUt3bVBHQmk2YzN6eURJMFpqb2VENGdTVXkyOG1tbVJ0?=
 =?utf-8?B?R3JTTTJSZ0REZEo5ZTdrWFZJRi82aWQxb0RYdW91ZFJqc2VVdU9uOGJuZXBE?=
 =?utf-8?B?N0tTRmM0bVJpazFxR2pyVXhsTHRobHUzUC93UTRLSFVPSzFqNEJtN1lyOWpT?=
 =?utf-8?B?K2tHRTZqUG5pK3ZiNXZENWpDVW9yNlNVbmxydjBMdTdtMEFyRUFZUzdCNHQ2?=
 =?utf-8?B?ZCs2MzZvb3BCOU84Q1lwTlJlb3N0M09sYVkyTktpclF0RmJMM1JyUmZlVWNk?=
 =?utf-8?B?YWJiQi9Bd3lCQ1JvS0Z1SmVEcHl4S0J2VHZDZEsvUEVvUXE3SGJiTklzMWFN?=
 =?utf-8?B?UlhNamh3b2dvMGdXYWRreVZQQm43a256Q0RHVVZGRDc1ekRyOGhxZzBJUXpH?=
 =?utf-8?B?N2I4S2JhcXlQZzVkWkdkb1BXUHE3emhhVmJHUlJTckQwYmlyaEJTRnpvaGVh?=
 =?utf-8?B?VjdSWEh0dEdzRHg2ODBxZkdzdHhwUXdUR05hZndzRlJZRWlSaHJlM3Z1ZHJ2?=
 =?utf-8?B?MS94RGlUTDcxZitaTGh1VTJEN2wwY0FPZzZ5bXNZU1dzMTJuVDJCZlZwSHJ3?=
 =?utf-8?B?K0x2TUxBSE1oU0p0aVNzQ0p6SU5sNEE4VzVkYTVtTFhpejFJZ3BUb1Z3a2Va?=
 =?utf-8?B?YWc4V1FEakVzazBiZmY5T1M3T05NMEp5ekVvcEFRQ0JrLzJVblZSU1FUZWRo?=
 =?utf-8?B?ZkVRUXN1bDNVU3VqWEpWMW5GN2RoalBGMFZwLy9uZmdIOXIvOGlTYXdJRDJo?=
 =?utf-8?B?VkRxUlRRTlNaUmVoMVhyVmcwRmpMK0NtYXR2QTVQbjYrYkRCdHlxQXM1OXI2?=
 =?utf-8?B?VXN5Nm1Da3hyZ0dTTERYNGs0M1RMUjhUWDNGc0c5emdmNnNJVFhDMWtBYlFM?=
 =?utf-8?B?R2dFMWROakl6VHdMUGc3Y0VOMW9mMlJ6TXZPaDhNelY0KzVIeXZUcjBGbnRR?=
 =?utf-8?B?amlzM3dkSXJoaVlVWlJJK2N4Y0VYQkN2dGFORVg4Tm9FWVhFenp0dWxrdGtC?=
 =?utf-8?B?OWY4ODRyZFo0dUNPVUlKeko1NzhGVE5hbEJCT1lsVXA0Z1BhTFBxT2JCMEVv?=
 =?utf-8?B?eTBBa1hhZmUwdk1XNWZaRVdCL3hQRndiTVJqY1M5SjJQRlVuUlNoOU03SDZN?=
 =?utf-8?B?NFppYVdURXBSVEpNV2Y5bDFuRWVvVjkwdmJjb0ExRWlZTE5IazQ0VU84RkZH?=
 =?utf-8?B?ajU2YWpjRmhDdC9oRHFKSEcyVVAzQ2xLMTV6L0xPQkpHeVBVSWdkQzRZZndP?=
 =?utf-8?B?YVVTNyt4VEJpSTZJclowbXRJZTVWZW94Smt5QTZKbXRleFQ3RE1IWm9nSWll?=
 =?utf-8?B?SUVRLzE3SG9ERFdSQ0ptTERhSHNIOXFUNTNSeENmdVhoWHBBZUVuNngybUs5?=
 =?utf-8?B?NUtlbVY1WFFGRnBNMW01aW5zQTYvSlZpL1hJdVQzQjFXdG0rQ095SWt4eC9P?=
 =?utf-8?B?QU5XYUhvYzJ1SHVldm9xTDBUcUR1NTg0VUluMVNmSHFqeGw1a0xCdXdJMnNW?=
 =?utf-8?B?WVRNSzVBcXhVRDJyOFNDOEt5djJ5cExMcHdBMWJ4aFV2ekoybm8rWnYyV2o5?=
 =?utf-8?B?WCs1ZVR0ZTlXSnAyRVROWU1VeS95VEJIS0F3TjJYOVFRaXBYb0oycGdwTVY5?=
 =?utf-8?B?ZFpJS0szenI2MkNoNWNsWHlQRHRJenliWS80ME5oNFhTZk9wUm5WWEVTRVdB?=
 =?utf-8?B?TG5XK1M2UFNtTUhXWVRnSGQxK2xTNWtTa2U0VHNkNVgxOHBLRGQvOWpubmVY?=
 =?utf-8?B?eXdQb3g5ajZTbmxhcHdwNnYvbHRTYjlBM1BjZndIbFArTmZZOVdJRmFFamhN?=
 =?utf-8?B?Zm0zNU1sbHB1TmFBbFEyZUU0K2hEVmxmeWc4Wkdhd0dlbnRCQm9OWFpJRVow?=
 =?utf-8?Q?wnHfZHdD3mJBr977zm0dz+qPA?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:41.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01de837-bea9-4134-118a-08de4ac97ee8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11517

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch related to AccECN negotiation.
First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
expects to negotiate AccECN functionality using the ECE, CWR and AE flags
in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
in the IP header by the CA when not-yet initialized for the connection.

The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

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
index 0deb5e9dd911..c4c25f2e0c0d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1203,7 +1203,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1335,6 +1340,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
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
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
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
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
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
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e95a4e302f4..ccbab5569680 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7266,7 +7266,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


