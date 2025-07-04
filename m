Return-Path: <linux-kselftest+bounces-36525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F452AF8D6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45E9762671
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EBF2F271B;
	Fri,  4 Jul 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JxY+DdRu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650782F2726;
	Fri,  4 Jul 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619332; cv=fail; b=rSY9glO+JTe6Nmo5o6Rf+87eMy5iZ6lBMyjApwP1H9YAorbseT3qODRXX9i5ymV/npcwaKp4NmK05zyPzhquCCOT6oQjqzcYISH3suMDG1CZ/2CvfyJRFTgt2yD5rgWEyGHD0jah6gWU8GDR1sJLpWUw6IJW8WRoE+z4MiCxGSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619332; c=relaxed/simple;
	bh=bK4Xx+l1sBybj9q09xns660ule0tkgq5RmKraqLaarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4aebDFy7cXBv8Mzy+hEd7AFIhx/ghow4+47Lr4/ZtMzK+aVmCsIzZxZPHP2yELCJml0SitxNMD3NMhj9NyUioS7UtI704Bds00cJefrUz9ko0qpBHQ6odfmxvE7QTmeODdmfINDUeED1nzlqvpBQl1F0/9gTy6FhQTFbzgFesQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JxY+DdRu; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9yDeRmWMv/m7ajVPvxexnJ9ccPSK1+vFVAAWTYqXn1chUiaYae8PsJPqNiPO9USBQCVsg83dx6LU1HbvIT9V2EcR2Am8g/uVXb4PE4kpTqLIGVO2HggK3QQujzgfgN5EhXujcZxjqi2brRloob1zSN3l7Vg5Y8Sv/MEX3TsrziuTjrvRa5Y/i+mcKrK5zQ540GT8ir9wRcLsiaFR+kA2jqIXWInaDTCsZNW/wxcpFgRwRrekik7gtehWVkFbvB5Rv0zbQ+PucU3lvK511ovIvQeZBAhOxziuDsrepBLP5YHY42VNW8aUkhVKClvjvpHHjO2g6cJfw//wQncgJXiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=vk3zRXdJyd12thf2Zj/YO91KmG4yoTDMhqdejlpAZnoaSK6pha6uAWqCFYDViJBkUGeNfaJOu+Cd8vT0U2n77EHcE3IO8h48e5mLIGtdMqbgm/7meaRkSZrfOD5kKyHxuJltlbUnzjTBh58u7GcqknsRYIM9yNpSeL7Sq7LEODA15GSdElCKb8oS5fOObIa7vz9HZrHKzoPTYe/cJutjuA7weFFrNO+zQYTvG1Dzs/8lg2LCk0gHiESQfRaeLX0o/ZBncvW1sDwdPJ9wioX6GEGKHw4AhvFNuflwTQuW39zcqZU3org/isC0Sezh3VN/mhOMvMT7RXkkSI3umdEMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=JxY+DdRuzaubPXwEVlkyPwae8WTmoniWgeHEFNwYIt+Jn2ONrb8MEw3NxRDAXmgRDwcvO62vgrJU1el+rOuVw8BpK+v5UO1hFL8VQgR8MLHlHR7R++QVSDKr0r64Lhg/9jyV0TvSm4FE4zgxMPsLBN9AmYmIsC7odSoKr9KwTNhvj+1uIgby0IF8lOWVWQrbCT1zsxY5UMEk1mpkHTS7xHVbDL1BijecJZ9KLT4PqVFx3iapBVLjzjNG8EkixjyFYYyrKw18GWw9ajHBWgIvDYECNOUM8OhqHPL8zdRKrZY/icw90ayVyAe9ogqIsSF3RqscOYrBb5QW4LXX2mSxdQ==
Received: from DB8PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:10:be::46)
 by AM8PR07MB7345.eurprd07.prod.outlook.com (2603:10a6:20b:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 08:55:27 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::14) by DB8PR03CA0033.outlook.office365.com
 (2603:10a6:10:be::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 08:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4EFB920164;
	Fri,  4 Jul 2025 11:55:24 +0300 (EEST)
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
Subject: [PATCH v12 net-next 10/15] tcp: sack option handling improvements
Date: Fri,  4 Jul 2025 10:53:40 +0200
Message-Id: <20250704085345.46530-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|AM8PR07MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f8a617-5ee5-4ec7-0281-08ddbad884ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEUzdlE2WXhtYXA0UDFSQ2pUNHlhQzFZdy9GUTNad3ZaTSt2L1R0STY3WW1s?=
 =?utf-8?B?NENDV01FeFNETnNha1piYTdlQ0c5S2YzYktoZHZBaFN4WGN6OWJlbWxhS21M?=
 =?utf-8?B?V1B0VDByMnZGalhDQVZUUU5mUXpXTXJqKzlJSFZxMUdhTytTWVA4cU03ckJ5?=
 =?utf-8?B?TGU0eDc4TVdKZENBVms2c2RSL2Y5WVk2NjlvcEFLaW85dVRBMzh2a0JDZXps?=
 =?utf-8?B?S1Ryd3UwQlhxc2lpa0grWUpxbzc3ZVFXR0VvSVlaVmg1UWpldEFwTVV5c1B3?=
 =?utf-8?B?ZFdSdzRKZFdTeDRsRks1em10Nlk3SXdrenRpSk9temVpZ3FuL2hVQ3RYN0c2?=
 =?utf-8?B?alNXQkEwRjFramdDdVpyRzJqL0pLYkRHYnQ3RExuenpWMnp6eDNmNjZXd3BD?=
 =?utf-8?B?OE9zQytjTnRVUkhvQi9YNzZmamVuaUUxdGRxdkxOTlc2Z0RERkEwTGswYXE4?=
 =?utf-8?B?dTJMc01yK2llckxpLzlycXcveUlFdGRla2ZqTDVwanUwRTRjOUIwVWpwNjdj?=
 =?utf-8?B?cUIveElBTG5FQ3hibmFnWUcvYSt5elZFMjNEcHRLd0VsVHZ0U1o3dzBHR3Jm?=
 =?utf-8?B?Tktna2l1cWJTOW4rMmltMG5vSUNtMFo0SGczaVF4bFlLNnhQNHFoRDlodEdV?=
 =?utf-8?B?YzdlcDd6WFlQL0V4aktKUi9RZVdBY2drRkh0RSsrUDcvL0k4MHBCdVpqVC9T?=
 =?utf-8?B?VGh5dXJmQlprTDRxN1J2MUowcGRncUxaWmxzTGMxMjRYVWpnUjRKQzJMcXgr?=
 =?utf-8?B?bmdEbzBBOHk2eDExS3k4QWwyRTM2NzRiME9zSE5WWTMxcDhTQms4UFFhOGFV?=
 =?utf-8?B?a3lWQnN0dmlabGQvcmNqRTc2RGg5UnAwZkZCRnQ0d3kvNHBVUUJDTzZtQldH?=
 =?utf-8?B?MXhnbjYzUlBpVnFTd1duVXk2cit0L1krZnNrOHdrN1hFdUZrU1FZUEFyVWov?=
 =?utf-8?B?OTlFUjFhUWF1NkdVYmdGZ2UzMi9mQmV1NWZheUhpb1hwZ09NTHBLNkd0ejlD?=
 =?utf-8?B?UEt0b0t3R1dQQTV2anZTK3IvVFliMjFUK1gvajJuLzJndWpidWJXSkcxRWty?=
 =?utf-8?B?SDlHRWFHV1R4eDdPZFhGcUZhcjU2RTBKeWpSeXNGVEVhQ0NvejJnQ3ZDQnlN?=
 =?utf-8?B?NHo2Y1JUcUo2c0xoTzVxbUErUVN6NnF5UWw2SmVudm5tVmJ6WTk0K2VUVWlF?=
 =?utf-8?B?cFI5bitrc1NuRDVqVG9pQjZsaUdRQTY3Z3RReHovRStrOTdDVTlET21wYlkv?=
 =?utf-8?B?UEhkUnhjVjMrenNvTHJaM2dlOE5MMkk3dUtQWnl0V3Y0NHRKTHp4YjlwZkV2?=
 =?utf-8?B?SmVHQk5jOHkyYWF5bU84WEhlQ2lzNU1najRjRERPT1FRRitRYzE2OThpTE91?=
 =?utf-8?B?QjNYTWNuT3hBQmhhZk1DL2hLNGJlUHBFYnBLZXdZVmorZ3hKakR3aDZIYnl6?=
 =?utf-8?B?ZFRGUmdyaVFDdnRGbC9pK2FrL0RKTTJKNUdIZTlzRFZTbjVmQWNNdDRUNEpU?=
 =?utf-8?B?VkFZU3lSbTB3TXVIS3BFb2hjSkFEeHYxdFIvaWlTWExWaHM3SW9ndVlVekcv?=
 =?utf-8?B?N1lRUUh2V3VQWGRpOStMeHNPVkw5ZmEvRUV4ak5FbDd1TjBZZVk2WXdvMEpt?=
 =?utf-8?B?MlFUMmFoUXBFSUROM2tXbjVqcFhmWFY1T0pqVHFIa0IzbkEvY25Od1Zra21Y?=
 =?utf-8?B?MFF6Y013Ty9RZ1NoU0I1dlhJTjFGVDZZejNOeHhUQTVKU1ZIWU02R2J2MEFZ?=
 =?utf-8?B?bnZKYStXZktEemNKanFTMDd3WVg2VmpTeHFEMk13MzlvRFBtRzB5c1ZSUHFi?=
 =?utf-8?B?a1ZJUEF6aGRxQmh1YkxmVDVWZVFYa1cxUEZieFRQajZ0NmppYnJLUThjUmdS?=
 =?utf-8?B?dmJnL1JnYUJsaGRRK0pjbVF4cnVPWmVPMW9qRjkzdHNpQ040YXlHZlNCZGlu?=
 =?utf-8?B?UmVhSGtWRVhka2FYbkxsSjJSb3hGMStUUkZWY2NMSHFIV005RXdUNWJHS0Zp?=
 =?utf-8?B?Mm1sekwrNTJ6dWdrKzRiM1BpbG11MnFDc2hIcXpQTVNsREZaNm9KbVMwU0l4?=
 =?utf-8?B?cTYzQnhOb09HM0lBeTZiNVVET3NrNzQ3dzhwUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:25.8170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8a617-5ee5-4ec7-0281-08ddbad884ba
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7345

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
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index debcb1d431e6..d98a1a17eb52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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


