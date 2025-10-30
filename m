Return-Path: <linux-kselftest+bounces-44406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58056C20A64
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3578F1A66AF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380D27A917;
	Thu, 30 Oct 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qaBDw1kz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F1277C88;
	Thu, 30 Oct 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834891; cv=fail; b=ZV0M5WaXxZ0ac3xE4Cyr/1/4ptM5L27bPzsGOVFt7n9NRgqkHcO/VH3uwh00nr32d9VgvxHShUb95oM3zPzPnKVpMBhTdWQpG/1qqfoMgu90GSwdhol0B5sW1odarQ68Zsg8+ZSckPYO0r1aeRjuN3y9LkNYTwxh/k+vjTvE/M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834891; c=relaxed/simple;
	bh=l6H9XJvnhG6bON7Rl8rpQN6rpvhkY37F8A87/A0gZxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpvPrHmrLbkmeAGRPfoygUvoQ5b8/fcrN8RNbBp520BtiuqPiVErp8jYesUGrEF7p8IBF0XZGdPCfx20cjh3Bh6IZs3yDFL4uE26oqj7n81rC3xwi6Rr6jyX2u0nfalSeWipAxvvBRvGyM1cX5q6YVohrKE3ArxPv6DZONrGUZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qaBDw1kz; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA//zyWZQhWthd2Osw/M6O6OxNR4hsM5JEUk3BvYCvL8zPZ3Q7utPvPi1hUZzTWjPj6itbY12gfFVTHbDs0kXQDo9yeusDfIXpSBlO8Oc6uUj11tyLnwOl7dNYZlwTOmHuOs3JaM1xJsWzyWr+05TMNsiNJ9YQvhHEHnNVl/0Uly994susEOooIlcdDdrPzhj3v6VmDS3KXFCwaM+OlI0PdyxwBDxEUhHWR6ZoiD2TlStRETYt0h3UCoaNAjgWlDHarbqXmtpVFP1581+3/dPRzx79NTGgytuvEcwVaWeYakfZsAgFdTnJRksobhkRediRaiwJ2bqdIZE1coyRZLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4v2Qstt/elvyDmqjqmlNYSrGnYpXwrJ24ZaqWaGy38=;
 b=UB9XFeW2PEn4X3KgOfY8fCg3tAS7N4z9Pz/zncMfWNUKTKi3CkMqsZbF9xO6HWNj4XqKtcjtB3/qnybgv6ko3IkiVkutdz6a1hK+1qWURIue2diyY2RfHXEuqrr6Ry3gVyIdXPU5Z8zrVn2pprnKvK7kZg/2kylFacKMZwKTeZflPP5fLQN9IDTopDOeYW2ZvhSifcP/BXcDt/m4byLPFSGDDPCdqcZx6clWRwBeCYu/lsq6rAWHdrpuk2BaUAe7xv+4uKRux7J2WqtO4KRKN8wazSPm0UyiThG8lLBa90vdX6LpByniKW12PXRHUsDOw3MUxybsN4578A6WPU9kOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4v2Qstt/elvyDmqjqmlNYSrGnYpXwrJ24ZaqWaGy38=;
 b=qaBDw1kzSCJ3Tnau9bjiXiSOMok6dOJU5u4PdQYO6PY377RqK3po1U0+mLLDcn3lmY2gdTcLKIM7I1zmDLMvvkBsYsRwTOn3s7k1TqmhQIKqOjbmwlYiBAh0AaZyV8H6pQCbe9wZdBePk5b4XLlDgJUmNotyh96bNQRL1yw6Taqg144jxPjWCFUK1VYSyzvFzId83/Y9YNSElE1SE4O2UG28y4Pq5khxgIjvENEwDvdyPZa06KM3tjkbhh7i/v7HjRrXslewgcqbxBPlj1ch5dCQOT6cu/Seq0uMlxZnoKnukjkDTUqTryGOaAtbqjTOWuG+85EKW2yutZxgEy7rmQ==
Received: from AS4PR09CA0007.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::8)
 by DU4PR07MB11594.eurprd07.prod.outlook.com (2603:10a6:10:618::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 30 Oct
 2025 14:34:43 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::bd) by AS4PR09CA0007.outlook.office365.com
 (2603:10a6:20b:5e0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BC7F6200D2;
	Thu, 30 Oct 2025 16:34:41 +0200 (EET)
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
Subject: [PATCH v5 net-next 03/14] net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Thu, 30 Oct 2025 15:34:24 +0100
Message-Id: <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|DU4PR07MB11594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b61e693-c359-4c4a-07f4-08de17c1777a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VGVJMFF2WmFsOU1Oanl5V3NYak5hdU9wblVNZmxLK2ZLTkNVektURGp4YlY0?=
 =?utf-8?B?RDhqakIvQkNxeFczUS9mbG9uZWhFMHpMMHNnSTZFWHllZGNZUitvMmJtRnJy?=
 =?utf-8?B?Qmg2QWc0V2tZb1YzZC82ekl0Q2N0WHBkbnRWZ3VDckJ3ZTZQdHZwRzQ3UVds?=
 =?utf-8?B?eVNOZld1T1MyV0NNNWZRK0M5aHlmb1dZeDFhN2tIMTRyQklLN3ZBUnJBSlQ4?=
 =?utf-8?B?dCs1NTBEZGIvVEFRNVhLT0RUNTAvWG8zd1QvQVliSFpML1FOd2xGcTJLb1FE?=
 =?utf-8?B?U2REZnpDSmV4Nytlak5EcGR3dElyalpOUFovVmFZelVxcmV3UnF0cE1TN2xK?=
 =?utf-8?B?T3lxWVNQVUNOcldibEM4aUlIYithc0ZNZEx0U2RlNkFsS0MwVFc5M3BXSmUr?=
 =?utf-8?B?Q1F0WG9vQkJvdDVRTW5UY001eGlWb2lsUHdkbmRyWDhlbUFSdDUzSHhQb2hq?=
 =?utf-8?B?ZVpUdHR5cWE2aUhEMlNtdWh1QW1LUzFBdHBZNEEvWnI5SUlpZk9LMXZGbFll?=
 =?utf-8?B?OURCK0ZaSmlTeDlLOU55eGxlNzJ0aURiVUpBQTVpS1dtMGN6WEVaQTJYZFN0?=
 =?utf-8?B?bTdoMW1GRkF4Y3VsdFh0N0hsSWpEdjBGeVZ6RGJWdWw0NGJFS0pLTUR2QkJj?=
 =?utf-8?B?SXZDTEY0NURJZWVYbkNWdmpDOW9DWkJFamNqTFJIZVczYXUzWFBwem5uektG?=
 =?utf-8?B?YjN6eHpJeUc1dkpEZG1jdVhsVFRmQlQybkhXYzNqZWJDUmdhMklSYWdkUURI?=
 =?utf-8?B?OC8xdmVqaDZSeUNVQzllc2ZZN2wwODBvN21MR1djSDgrMkJ5UEdyNzV2Y0Jt?=
 =?utf-8?B?aHB5Qk04Tmt2VFI1N2V1QUpOWmxOMXRlMkF6OXlPKzBDNUVqRS9XcjduOEhr?=
 =?utf-8?B?RjZyNVp3eGV3TkpBam81a0x1Y3c1dFVQenUxTnNuNEc4Ty80dnk5aDNlTEJK?=
 =?utf-8?B?Y1g2OFVUb0NBMjFsSUdqa09PdnZscitPMWFja3YxVUhDVGYvdERUbVRKc3Jz?=
 =?utf-8?B?VXFmNFNaMUxvOUswYU45WGJLS1dXM25ZOW5rMG5oYTB3RzR6am85QVNBYTJm?=
 =?utf-8?B?L1dhaXByNnYzdjZEU3JNYkhJdUg0NW1PK2FqTTZHem8wdkpLTXZrLytJMFZw?=
 =?utf-8?B?bHhyRXFpNjhxMTlHVGE3aGlWRFl5cWdqcTlUOTJ5YlBydnJDcVZBVkNYL09D?=
 =?utf-8?B?WmU5cGkwbWZ2emJUVTBMYmhxbGNUeDFmU3NUUzMzL0d2MWFGQVJXa2RyZVJV?=
 =?utf-8?B?VmZwU1B1OTF1TEZXaUtWeXRJeEQrOFNhaTBoVnpCRVM4a0NUQWZFeVI2NW9I?=
 =?utf-8?B?MTk2ME55b2p6TVhEWlRUWWJaNUY0VFdHUjlNMlRzNDVuYzRlc3NReG9ad3lm?=
 =?utf-8?B?T3FMUEoxam9XYWx2QUtldUhZcFhUV3lHM1liS1dwTngzcjRUb2lsUGZnS3Fn?=
 =?utf-8?B?eFg3Qjk1M05pOUttUC9ZT2tPQVBXMFVtVnp6OWFyazRQR1pkaDlGaXczZkE0?=
 =?utf-8?B?ZHF2ZUEyUWtXQjZJSnFpVUg0MEc1bkZSSU9UNGxyM0JjK25pM0IwWllHVUtQ?=
 =?utf-8?B?Z1ZEOTVEV1gvMkkxT3kwNmE0aG9TZGlpZXNCSFgwaU80eis2Q3N0akFpcHlE?=
 =?utf-8?B?SFJPL3pMdFRCSDBsZllMQmE4ZDZvT2NjQ2grZEU1ZjRCamc2ZVVUVFpYRmlG?=
 =?utf-8?B?MTNSYUJUUytnR294S1hTM1A0bmVPMThBM29tYm5KTVh5UHFLZHA2MW1jSTM1?=
 =?utf-8?B?RkxCNEFxeFdQRDhyVHB5eGhJczE2d1pTZFJqcnY1emdXL0lEMkM4RS9iaWY5?=
 =?utf-8?B?elE2Q21Tc2thMWhETHNjVW90N2s2dGFaLzd2NWRJdURDbVVodE9lUjNoOXUz?=
 =?utf-8?B?d1hGaTlvSElSY1VCU2l1d0xYWGNNS3pLbmpQMGx5cEd3Qnp0dnR2V3N6aTBI?=
 =?utf-8?B?V2hncW1ORlVGY3E4dXo5NnRRUy96Y0FhVVlpWE1Yc0lXNURXUFJ3a3lZb1FT?=
 =?utf-8?B?KzN2QUtDdGR3a1BoYThKNFVoUUxWM3F6Qy9Kb25XMVpKRUVhTVd5OTRraUVw?=
 =?utf-8?B?bDlpYnk4MTNIWlNJVGdZeEtEYm5UcHY4YU5lcWJ5dHlZU2VJbEhhSVBwc2Nu?=
 =?utf-8?Q?MzC6xEgIcpFGcJ5nNoMKLmEdd?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:43.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b61e693-c359-4c4a-07f4-08de17c1777a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11594

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional changes.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a7cc3d1f4fd1..74d6a209e203 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,12 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates the first TCP segment has CWR set, and any
+	 * subsequent segment in the same skb has CWR cleared. This cannot be
+	 * used on Rx, because the connection to which the segment belongs is
+	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
+	 * offload may corrupt AccECN signal of AccECN segments.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +711,12 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates the TCP segment uses the CWR flag as part of
+	 * AccECN signal, and the CWR flag is not modified in the skb. For RX,
+	 * any CWR flagged segment must use SKB_GSO_TCP_ACCECN. This is to
+	 * ensure the CWR flag is not cleared by any RFC3168 ECN offload, and
+	 * thus keeping AccECN signal of AccECN segments.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


