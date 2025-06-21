Return-Path: <linux-kselftest+bounces-35559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3732AE2BAC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4411885A8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A8272819;
	Sat, 21 Jun 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rVDu5ZI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AC26A1AA;
	Sat, 21 Jun 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534684; cv=fail; b=fOBV7rdgBzVBNRGKto8tFfqOUSQT/ARO8gpx6OI0xWfGQbXiKFgjUBmlTSe4LvvII0ipuhm4K8imxXKPgQgdBUsDETP8nlWV+/MC5er868X8o0qrNOQ1KWUdpj9SWQ79WBH/1IhECVQ7YLSy0SPrq2fwwJ6JnfAcP8QqiDIqL0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534684; c=relaxed/simple;
	bh=iFcTZmQz+KoxMbWnmT2MTrBRX096Ooi/MssASdIt668=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1cVdmGiG+ukvneD9mcRRmSkG9qlJ2uJDBz87ei2ei4mpmqAWvArqZDRmv8QQ3oGmvWYw4dOpm+tjT0I4OIQyfT2s9bZ0MGb47OVAs0fuQFfU92z5IlwN7pg9ql1M34FW74FhQlNZLpLzkT26SjQ+9WoD4Ngz8LS2hKloYjQZIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rVDu5ZI+; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMquD+z+sf9uP2RWYr/L4kZxnGG2IUTtrnim3cTLCuCV5IdGxwdjWvt1MYJ1Gn6RvAcsQjISFkVZwGGUhd6/gNh00WKL98mS/HgJh8JMDeNpYdtAB6eNGX9KOZe43Zt9LVeZ/8AFeqW/C35HxyYWIRFFfIEeWZlnnBw4WQ7RKeVAUHR24l9XOgNTSiQO1e1eBWZ5BjoG9zrdEuhOxNtmbnGjf/yKIkh27+5X+2ZI9IO3kDk4Wp0T31PP84R3XdhBeUBUkp3zsLi2fWaq5cNO650iIlvmp4Haru0M24cbax2iG6cmW8L7Z7g2GHQ9cdXPoK4+S3eFcrNEb4Caf3FMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohyzgWWmf7ArvRe6GftbHhI6Bzqti+BWAQUIhv2YGRs=;
 b=Xk7Xow7MGCWEMdLXHZ9Q5Ncwayt1QBvtjeZDFxQO+peIpCPqLBWBF8WUZoIRDfvE+YjHOOc7yFtzZrfdbr777qixDLTa7ngCWdrjrNVx3LK0gshLHKm1VcH+5/7IHqPMzOPNb9PsE5mB0OxydTLZJ/CNDcKbdYHVqi0s9Ge+0CkXZ0YlI83oX/HFjy/a5R7Cq/KHVLyLqJhiQf2WeKprS/zgx+ydt6eeKRYQpqUypBw5YJ2K4ctwTIG9fom6ptQY/AlMvXq7MIxwzX9NLPQ5KhVv4EAN0UCu5C4BJOmRY95HTJqY+82mb5m2CuF9yVhpYaEb0t/5j0Y/r44Dr+4kzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohyzgWWmf7ArvRe6GftbHhI6Bzqti+BWAQUIhv2YGRs=;
 b=rVDu5ZI+ftT4i0x7T1ma88IAYzP5qppceRhiNkWuuwiMdIiQ/5xxqRBu+TQ2KLXvM6iPkimQA3Wv9MULqM2tyXtviEfLmcerONocGoHfvc3JE3vtVplmsBcdhMEkJywQMDLphPrhWnPxxkJyLLdTGC+TfI2D3faEBNq/Cm3BcnOPJdGDlenF3A/78jbakG+35eUZT6peWY7NOiJjPQlVRpYoFQ3/yloFp3pE2zDVKoP1ZqKicQrfCRXpPCJY9moGu6rDyAzS4SV5wVybSsAvIgBXdSlSyo0mVKRfdSbVljweCS73Q7o52twChB7m7KwbehJW2suegeNQclDQ6bnGWQ==
Received: from DU2PR04CA0259.eurprd04.prod.outlook.com (2603:10a6:10:28e::24)
 by AS8PR07MB7432.eurprd07.prod.outlook.com (2603:10a6:20b:289::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 19:37:59 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::c8) by DU2PR04CA0259.outlook.office365.com
 (2603:10a6:10:28e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id A3AC91C002B;
	Sat, 21 Jun 2025 22:37:57 +0300 (EEST)
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
Subject: [PATCH v9 net-next 08/15] tcp: sack option handling improvements
Date: Sat, 21 Jun 2025 21:37:30 +0200
Message-Id: <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AS8PR07MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9601e9-0cd8-4904-96f5-08ddb0fb2101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmhzRXVIS05nNEJvSE1OSGR6dzQ1czFCbjZKRHRHMmFGR2MwY04zRTc0dy9n?=
 =?utf-8?B?T01ES1ZvdlJZcHFjazVVSjdwSmhFdlNpSGRGemlWcUM1THoyQnpkT0hQL3Nm?=
 =?utf-8?B?dlRtb04wVVVWVS9qNXdKOUpKd1N1aFRyNytQWW5iZE5KRnBlVmFpdWRtWk16?=
 =?utf-8?B?UmgxcHVBUFdzejZXV2RybW1YVzhMNG9hTjBIMlEzbmtDRkhaY2ZoTmZTTExD?=
 =?utf-8?B?cTZnQ2FqTFVyTUxqNDJIUTFwSWhxYXlTSnhwNnlTUE1xQnBEcmcyVURaZE16?=
 =?utf-8?B?eDZJcU5hL3hTVjh2MUZQNmJtUFJoNjRrM1VYNXY0Q01XQ255Um1WRm9nUVRr?=
 =?utf-8?B?ZEx0ODFlWjRJckcySWpPNXY1d2NIYmhtWnNJOFYrQnV1cDV4VXJBNUtrak9h?=
 =?utf-8?B?dTRYcUVrb0dMRUhzYkdNOHRRR1IvNi8zaUtDWVQ2dDlmdmhZamR4Z3E1MkhE?=
 =?utf-8?B?RDk5b2lQc05QaGtjOXd2cUMwc0pVRHEyUHFrSHphWE9aY0xDVVlidko1TFVv?=
 =?utf-8?B?aGJ2ckU4M0pVUktpUTBMWUxvVDVodDJ0T0puYUZwd1BZaGJPR1RieXhDTUdp?=
 =?utf-8?B?eENuT3kyVit6bmFFOVp6bWxkZEwreEFlSDR2Rm54Q0ZoYjl0c2x4Z3pZTDVN?=
 =?utf-8?B?Y2tCblhhOEEyaUJLV1puUTNneGdyQnhCOHdNMUpZOUJTbVBoVTVpaENxVUFC?=
 =?utf-8?B?TTZ1UndjS1A4cnl6REtxcUVZRG1qU1BndjdKQm1tcjR2cTRkSFNlYXByVEpV?=
 =?utf-8?B?MDk1WW55Nmx1S0R6S1NjLzdzOGJkTHcybDZvSzJ6TkoyNzE5L05tY1dPVWt1?=
 =?utf-8?B?cUF3RDczQi8ybWR5d2N4bVp6M2dHcnovLzd5bFIyMzBhTFp2UXd2Rnp6ZTZV?=
 =?utf-8?B?ODRQY3VoMjl6eThYZFdwRW9kK0dZeVlLYTBSVVpMTjUvK1h0U0tLSWJ3QjlY?=
 =?utf-8?B?dFdwbStOUHB5bHNjS3hhZ0NzWnA2ZnJzRkZpK3c3a2NFVWNQRTVpSEM0NDgv?=
 =?utf-8?B?NnJEVHgzUnBNN1JlczVabmo5TG5IbHNVRythMVQreDhVaU90bUdFeDB0TDlK?=
 =?utf-8?B?UWhaOXJnRlNIVEVacjl4a0M3NTR0d1kvQ05ZZkEwdnhZSDNud05OYnpQK2xN?=
 =?utf-8?B?eGJNa1hGOGFib2Z6NE5hV1RFeHFzRnRXZVovK09yVkV1RWt4WjVLK2NVWXFa?=
 =?utf-8?B?OHZLUFBzdHRBa05jNE54NHE4L3RoeHRBdHRJTHFzcTdEaFR4WDZtRmEyR2pW?=
 =?utf-8?B?eU53TEVYU2UzdnJRZ203aVkxR29mQXVycTJRaDBKZ3pYNEhrRmRTK040Ni9z?=
 =?utf-8?B?N3hPdUZGN0ZrY2RjRUJXVjNmakprT2IveFdwSFMrNk4zRVlFdEtaMGdrMFV4?=
 =?utf-8?B?ZmJiRWw0bm9TcEpkYzRaQW9TS2ZlY3JzM2Vybkt4ZWpRY0g5ZG5rTEMwR0hR?=
 =?utf-8?B?dzdab3E5amk1UENoRW1UMFI0MG5LZlVoWU5BOXBadnladldDaWFya2d6a2Fp?=
 =?utf-8?B?ZHlwejluUTF4T3IzL1JFMTlGMGsvYW1lOGxwbzhIMnhSbnVkTkcvd2JtNjlk?=
 =?utf-8?B?L3VoNHJ4QmFHYkVBRUdmM1Y5U3Rjd0pHUTM3dVJTT0daQkZRbDNidEQvTUho?=
 =?utf-8?B?YzBSZU1rd1NGMk9iWWpKZ0o0L0ZnRUo4UHBnTzFINlNMYkF4OVQ2Z0kwS2l5?=
 =?utf-8?B?WDhIQWQ0R2p6SGMyOHR2a29NNy9XdHUzL09RdW9SOUtyeElZVWUrT1A2ZXQ5?=
 =?utf-8?B?eHRjVjFqeVhOYko2S2pPYlNlelhsUUxKR2ZxVUVpOSsvbHhTcGxsN2E3SHBu?=
 =?utf-8?B?c2dLM0x0T0g2SGRoRFhlMEFXM0hFUUg3R1czTXBzOWo2THdNKytUZURteGxY?=
 =?utf-8?B?dXFoUU9ocm5KZzdyQU5ES3ljSU5tMUFRY3pUNU9XRkVRSEM2dHdRR2E1UXgw?=
 =?utf-8?B?azVna2YwVURETjlQazliZWhoZ21WR1dTZnpWUE00ZkU2S09OUDVldWhNcCtY?=
 =?utf-8?B?NXFqOTI3ekVOeExmcmMwMzRjSXFEdFZtdVFrQVRBdkY2TDMzcURRbSswVy8y?=
 =?utf-8?B?U1czc2d2cGg5bHVEZmM5dlBLZC9oM2ZvY0I3UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:59.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9601e9-0cd8-4904-96f5-08ddb0fb2101
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7432

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 79ad69dfd9d6..37c981aa9bc6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1092,17 +1092,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


