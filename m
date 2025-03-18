Return-Path: <linux-kselftest+bounces-29302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AFA663E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF6D188B225
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1EF187553;
	Tue, 18 Mar 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="V63bKlJr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012009.outbound.protection.outlook.com [52.101.71.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDC17A319;
	Tue, 18 Mar 2025 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257690; cv=fail; b=G43yijSi/pWTe2e8nUZ6TWEv/Nz67uFU0q7yoCigsX3dNY+60JGQxpLW/SW5Ls+LnBl/kRYlGceaodbm3a3JPXz8GC/Q7vuHl6iIz4Kg6H7w9rn8TzSqinRyLsYxm+gVd0SRYcqRjfDXNEb5yVsI+y9rqeaDHOkMh/hx7WSsWaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257690; c=relaxed/simple;
	bh=TmPK1Vyp2bFVJubcSXhUlXk5Wuf8M2fpIB8ZL5UOptg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFS87xzoc67tpWJwXvX34NhHjsd4zF1DFZQMfkxsKOa//xCctkK00gPSLbnJyKgX5+AlumzYG74rg8zMPnBUpJArroIBFKtFvJvBiAQKAe8RK70MVF511+KErBPDZSdKfbdZir+0Nant7n6A//f21Lulyr9awgrWGH0BA3CdiVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=V63bKlJr; arc=fail smtp.client-ip=52.101.71.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPYA8vBLc4B1P1BzwycawK848R01ZQ7pn5k3cIxTuB1m9fQVTL16ndcJ3lvDUZAWqaDX1supoCzqkpriojWLOHQRTIz1z0QX3MeuqOCbEO3pV0g4DToM1O9v8ri4FZov3xFLcT0Iglk9ISnjedhOy/Wwu0xCxvFWQ30hNoU1zdu28bwtOESvgUvzJasSg5YAk2Nvz44570NEl1biMAQV+PYSr+Dw19/gqmy7mebMYMg5zpEvSmJLdwVsBPYiZ5rD68PdK+HIi5j1SAyTukMc8WjItYZJWNPG2QLCZDqrnf2PD0++BavwzRG8ZmSLS0ez24aBkRD218fXFujXLBNdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/4w8JPc5QkyDdKZ1GwKpR0KH4xz9bMjj6Dj9IGETB4=;
 b=sBmufZU4eM6stMrO/pHiuJiWzuAfk1FqPht6ryV6HqTQrFEWYF8S+AB4k7mS8OpouIRtUTVt8/PhSkn0LCCPty26GChOFfB2nWohzS64MZ19VcKqz2VH7SrhnOCfDvxIWU80ZIBFDJXjbwAYKmVO2MP3jmNOC+XjzMCgwyaEw4TiTvVAzbsDC5BoXrrlrYwqUOmHwL5ZOUFjaUkHs6p2daqNRIo494fRmVw8aCEp6iMVE69B5gim5IAjnjio2cfr3U5msDtrdTU7Lz+aN3DJT+AKw5e1lJ1TlIjh7nZHIWO/kwvwM4F4ot1aZjZXcZvyHyZ99IsE19SWFJFb/xAEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/4w8JPc5QkyDdKZ1GwKpR0KH4xz9bMjj6Dj9IGETB4=;
 b=V63bKlJr6mE1P8z2DP7F4qgW0Bqd2eWEC+b1i8qZ6FOJWD8U96DFP6Mfoo/o4s7pnYj5mN4pTE+Lc4hb2PtCvemRwPFynrzHl4yc71YqdrqivOZSHxkfBmAlaPluE/Dwm1tEPe3vM2V/g+xQa1GhO0f7GRVK2RcqFDDqbJH+r8OR9ofzi2HquC2YBwTAnD0wl1U391umOhPO5zQQVd/Akp5GPDKw1KkptC6JtSTKwrHppX9U65hwyn9PP1yBEb2l8sZ6jI0n5wpSrhZktUgtsUGGW2CbsPI4F43Z/ziHWM2PeBiLbpx8OZ1RF/qyX3AXVmaX6PXS0+IqJcRpue6tLA==
Received: from AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38)
 by DU2PR07MB8109.eurprd07.prod.outlook.com (2603:10a6:10:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:28:05 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::9f) by AM0PR07CA0025.outlook.office365.com
 (2603:10a6:208:ac::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:28:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBv024935;
	Tue, 18 Mar 2025 00:28:12 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 15/15] gro: flushing when CWR is set negatively affects AccECN
Date: Tue, 18 Mar 2025 01:27:10 +0100
Message-Id: <20250318002710.29483-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|DU2PR07MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c37557-8b60-4df5-8890-08dd65b3c018
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WlVTRWd0bzEyNll6eGlXbEJnRHJvZCtONXdTMG9aM2dqcThkSlpycnA1dXBS?=
 =?utf-8?B?bmw3SE5jR3pjVStrUEJsa2I5N1phVWxtYi8ralBYenptZ0J0RFZGbm9EVmhk?=
 =?utf-8?B?NWRBclZBWVB4aXZSdGcwc1Y2WndlZXZ5aEhCd21POEhRVytDeTVORmNPNnZ6?=
 =?utf-8?B?NS9zdGliL1pHNTUrdWhNc25uUmQrcWMzcWJjMnFQUjNkdVpSSWYvYmhMTmRs?=
 =?utf-8?B?bDBYeEl6eis4eERCM1VVUDJVZCtCSzBpYmFoV1dZbU1DRnBhS3lwekpVZXUy?=
 =?utf-8?B?SDlXaVZRVXBoV3FvRWhhUGpOYmxKU3BOekd1OWIvT2c4VGdGWS9RTEJXc2hG?=
 =?utf-8?B?WUJXT0dCVUNBTExZYUJ4MXNsdzJOemJWNzF4MTFKb245cGZBNVNtL3I4S2xS?=
 =?utf-8?B?V1FBUFB6STd5TUUrSE9tcHREUGRsakM1cDhSNzhQcmtoVUxZayt3TUdHbGdy?=
 =?utf-8?B?M3lreDFMNmdYNjBqbnlpa2p6RVZQMVFaWlpSNWFDVnQvY04rNGtwYjJ6L29H?=
 =?utf-8?B?Smt6OWpSSE41Q29VUENTQkV6ejJKbndCOGxHZFI2NEhvK01yRURNNEZ5Y3M0?=
 =?utf-8?B?ald2NjJ0YTFJejVpZ3lXNkRUNVVGcnU1OEQ0TXBlSXF4ZnM1aW1FZm44Uktz?=
 =?utf-8?B?TVptNDFzcUorQkFMcFQxZFpabFJZazZhZHRSUXl4OXptdzNtUitzUXViSklY?=
 =?utf-8?B?QW5nVW15QmJnMUlTM2l2TWx6QVJUZ2NBUkVhQkQrS2xUQXk3NUdvQUZJVjky?=
 =?utf-8?B?Ry9nMjFrZjdqTE04eldDTVRjbEZDL1lKekU5SWhQTjY0L2gweG1BWVFHUmI4?=
 =?utf-8?B?Q25RVGQ2cFVYTnB0MkZSS3FWZldtMjMrV3Q1alpRRkFVVFI5MWYvYWNVNlFR?=
 =?utf-8?B?elZhNWNrcDJxZVdJVlhockRBNmRldVNMd3hkU0t0T1lLZ1d1M2tQT0dzM2dk?=
 =?utf-8?B?aWxwc2RmWlRhZEVBbnRCLzhUUzV6U0dXeHNVdkdRSnJJSWhwZ2dTZngvWFFh?=
 =?utf-8?B?ZVFncDdydFVTYitNM0JZaDNaN1pHZ1VUQTRNTDNTajV0YkhZaWp5SnFWdFRr?=
 =?utf-8?B?N2pldTRJZnJ4OGFWUUpzYnpySEYxQUJ5azliSDM1cElLbW5CN2lVNGVoaklV?=
 =?utf-8?B?b0NVQjRHU0JML1RVQ09sd1lkcXU4VG5vRjJjN0Ivd2hvMXphaGh0Rm1RY2pz?=
 =?utf-8?B?OXZUUXIxNm44Wlh4MlkvYjBxTm5pcy9rZ0ZYNWQyTGhVTVg5R25sTXlHWmoz?=
 =?utf-8?B?TXpvWStXV2NNQlJPR2szaWtIRnQ1YzBST093ZWJZRnkyM1dIMG5RbzR2SmNQ?=
 =?utf-8?B?TS8rOXJhSDI2MFRNOTFVRmhJSXBaUWoyUlhtMURBcjRBWXljQ3FoZW5UUmVo?=
 =?utf-8?B?T0M5YlExQ2pWUE9maDRZNGsvR29GRCtobWhjOWI4K3IxV0ZLL2srcUc5M2hX?=
 =?utf-8?B?RW96c1l3bXVUV1h1UlQ2SSt3Sk8yemRuenB3b2RDTlgza3g5eUcvVkpNYmp3?=
 =?utf-8?B?VjNMQUl5ZlRsR0x3OVY4bFRSMTBZK0ExaG1MUFM4QWROaG51TVRvVjJHU1FN?=
 =?utf-8?B?azhGT0FMNWJKV2h6VEM0MUJFQjVpTmRrYTM1RG41djliYUFLWHFNREhiZ2Mr?=
 =?utf-8?B?M25Rd3l6S0VucXJ2VERFWENldXA0YUJvZEtkbVYzbXZyMUkzNHBvOGxQL2x5?=
 =?utf-8?B?TmVma201aFpjb1VLcFhhUGJuV1VQVTJSZWRabDNtVVpMWFpPUU9iZ0wwcEJt?=
 =?utf-8?B?TEorMk01VG0xOTEzT2Nrbk9sT1M3SU1SSUF5ZlB1QkYyK2Q3eWowa251Nk8w?=
 =?utf-8?B?UVhBTUhkREpqcy9aZkRRaVJCYjRNdklQWjhRWGx1Zm9jdTQxQmZRTjgzYU9w?=
 =?utf-8?B?dExwbU9TY2VXRklNcW9PdTdhUHpRcG5pdWJvdS9GTG8ybHRURDZjK2NKb2Iw?=
 =?utf-8?B?MHZWZkd5SXNSZTRWNVZHY2lSNmY3ZThoMGR3K1A0UUJZVlZ1Mk9DK0NJcVFm?=
 =?utf-8?B?T21oOHRabElWazNWNCtBRjhKNjFRdDdrTVlEMzZVKzByNWNldy9BSGR3bVlM?=
 =?utf-8?Q?7Z4/Rn?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:28:05.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c37557-8b60-4df5-8890-08dd65b3c018
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8109

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 934f777f29d3..fd2fd70f650c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,8 +330,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


