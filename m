Return-Path: <linux-kselftest+bounces-41229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CBB52F4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F383A5298
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBD312802;
	Thu, 11 Sep 2025 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RVdQ48f5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1932DF12C;
	Thu, 11 Sep 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588812; cv=fail; b=A1SOXacSNbfrwb6ba8l17LRfUU93UFpMZIRvFBz9ipZSU1LKYlvgMAULCje+UryEphSH5txaj9T6nN7niIzfshNdXcUKqzy2mfKR5Px5kSDrsTXPRK2RL0KRKKgQMYUFUjbM4LaX0iKLYeZ4jxrwLo5tiH+kmVohH0qpYJbJrik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588812; c=relaxed/simple;
	bh=QfBZJZTaijVfUGXpNNq7FqDbIyo3bYPrMYBOZNgpUzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGND1LUvXmZg+V6GXNyKw+5sGbgAXz9yFpShEtUHuf4coyAZUU8evcvuSmgQMFJl+1YDtRv5qkmHCvrz0ErjpQLu0+fy8YSM0eVd8x8RYpoivwvBlYNSvMBT2jX9wRWyHgyGiBFvfCXh7GlkhXSlrCZJN0ix1dZWhuzkLMIytGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RVdQ48f5; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHBBXSmhvZGsZ2Wxi9i5sJhyBNmK4STd42PoBWQ2LzHSQ/C1QBj/GROYUvzxS3Miw1+AJyi2MHWj6JWCEe8C2o1ObhcuZ5DzWd7Pvi7ngjH7bQWhjd1rl9ojay+5Elg8oc6wwLhYcTn/Ac3YcaKWqA+NbI2asDEvYzdp/6zxUGbLvf2ohCoamtipiXMhC6YfuKRI5rPsNCxXDTtEbEgyNwwQuztyhK7HHtcqzfDTGksPZ9O2WJRv8K//H2JFYRFLcN7UU2xq4pYMlSLyOn1tP0t0htnD13E8aiSo48JIpQD6pVCaiArWagAtqbIOlvE08d4UF6O41FmTRZ9sA3qMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=zKlCgC6f/Uj762pFne/vYSppoq3pC173xWWrwn2KyRuueW6Fj9qtT5igz4NMKVSfipg6VRJVwC5l7HM3jDhlqFQcaguzmDx57C6ghMZBQL6H85o7ErVahIbkIKluu9pAW6ZihQJMA9XYVIVhzb5Z7es6ihwDc+kXRplyc9Jhcdlx88qfKIEdImFfBHPR4vb5n5r7tV6vEG/dLqZLamUFYMpb74Ih+20cq/CVOab2nwO7E+j4007+KLx7xEuollo+/yXqhGrcWmrdW07k8uzVgnX4ebWmDhGEQLO2gOHhN71RP/FUNyxowKelaGw0hbvx+nOuT6PbSNpy3KAiLyH40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo6KMiGFFPh6BbGe3v1eOQrACUwFe/695f3FEbGpowU=;
 b=RVdQ48f5ev9IKKfF6VBXrZr1yvnBUsQACJBdMbG1pFgzi1jPGye61KN0n3+gCP5oUSrkB56SDMHIID2quWmbbOLZDBdMhUYi+FFFV3FpG6/gvh8pbMNcmETw0Jm6aS5qjJNQLji6G/INkGfHslJjQ0IdKahh7PJn8mXJW2SgmuoqLCggVGG1NMYq1wtjJh1YCPVM2Lz6kuoNfGRCAFf7Nw9sPSy3532v8IlG8+Kc3/+Q+JoctZ31X0ncPu3L+kua7DvPaebFWaVeyKW1/4mia4njA5XIIj3ltEeTDAK5V/pRzGKK9NJpCr0uaj2Mq7p8yeyTXg7MCSpWoMJ7sjco3Q==
Received: from DB9PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:10:1d9::17)
 by DB9PR07MB11120.eurprd07.prod.outlook.com (2603:10a6:10:608::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:06:47 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::17) by DB9PR02CA0012.outlook.office365.com
 (2603:10a6:10:1d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 11:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Thu, 11 Sep 2025 11:06:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 19ED8202A3;
	Thu, 11 Sep 2025 14:06:46 +0300 (EEST)
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
Subject: [PATCH v18 net-next 01/14] tcp: reorganize SYN ECN code
Date: Thu, 11 Sep 2025 13:06:29 +0200
Message-Id: <20250911110642.87529-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|DB9PR07MB11120:EE_
X-MS-Office365-Filtering-Correlation-Id: 92301cdb-ed86-45ec-f8ba-08ddf1234d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5FYVpzcTF4ZEdGOG9ZTU5wMWpabUszQTV5NU5HZVhsUG40d3NXckt1K2hi?=
 =?utf-8?B?L0YveHM3STNFc1U5aVBCYkk1eStycys1UmQvNS9SdVBDZW9CYnpKUWtqMmkz?=
 =?utf-8?B?ZEVTUmVocDAycmtjZmRzb2NoaHoyRnJMUXBWb01YVVRaejBxU1FkZlV2enRi?=
 =?utf-8?B?WHJIRlhsRjFNNGJTQkRLVkxjd0xnc3dTK2wxQmdndUd3Uy9pMUNCTzY0TzI2?=
 =?utf-8?B?Y0pUb1NMUXdYR2lBNXMwK2hScjFPeXBpa3kvakNidjFRbENiTlIxV29lbGZu?=
 =?utf-8?B?Q3RaNXNWenM3U3dBbnpCV2lYU3lBMEpPdWlYMWxiV3pPVituRTViYjdSbitQ?=
 =?utf-8?B?dWNJOVpyMGdmOGQ3bHMxMHJRRXRlZmdiTEpRNEhKR3FmWDZwMGpOUVc3OHNs?=
 =?utf-8?B?Z3NpOUNRbldWL1ZQN056d3dhY09qV04zeEVRdUd3c1Vrc2FaMFJiYU1JMEZC?=
 =?utf-8?B?Sm1mcklYaEtPMDFZbVo4RlA0TG9zMEN6c3ZxR0JXQlpkUGNmbkxNYWVhNDRj?=
 =?utf-8?B?Zlh0QkNyMFJPYlNWV2dKeGdFaVJHNmd0a0VpMjBHcTNPOEpkRi9xN0taSDgr?=
 =?utf-8?B?WndCWjAzWWVCSFl4QmdoSmFpanJSSlJ2cUFsd1hYcWRBU0s0NlVOOGpBL0l6?=
 =?utf-8?B?cnRsMGlWdUx2aHlsMGJjUVF5MS9JVjZzVnVBQ3ZQYmtoUExQUDFlV3dDY29j?=
 =?utf-8?B?YmdXemNlWGgydlRXUm5xTURLd2pTdDJuUkRvd1J3T2sybWpUWU5HYmhWck1W?=
 =?utf-8?B?aUg0ekh5Z2NKais1bnlzUmRVOGlGdFpSRWRxQ21LM1pNSzM2Z0xlZ0lCMFlD?=
 =?utf-8?B?bHpKdUw4ZDc0TmJhemFJWW5ybk1hOHRoU0FjWWFQL2t4OHdPWHYwRC9BZXdV?=
 =?utf-8?B?UUI5V1RDRUhKR1BhejhZSGZzVnhNdFhLL1pCMGNub3EyMVRvYmFqQ0RSTEJS?=
 =?utf-8?B?bmZ1Mys4a1JOREpwcVE5Z0JvNkhPT3Z5N2UrWmdHU1JyaVFMZlZLVjR6cDZP?=
 =?utf-8?B?cUVJa0l4UCtUdHAybGQvSFI5ZWlpaTFvc05uM1RFbTNjdUhUTjZFL0Y2dlgv?=
 =?utf-8?B?MStTMFdIdmhqajdiMkxIZkRmcGpWMkVEMzc1QUF1MEY1cGFqK1hwUG5PMG5D?=
 =?utf-8?B?WkZNRlVLejdCd1RZRTVxOSs5YVFBazBLTlVCQk9kNVlSMTl2MWJrOHBVQTNZ?=
 =?utf-8?B?MjE2RVFKYmNCM0xQNmJYZWNlYkF4QmZUbFFNd0hoWHo1R3FjYWJhK0s3a2dE?=
 =?utf-8?B?THhlMTJwUkxCNTVyZzh6SSthdmc2SjQxOEVFZUpoMHl1TzBUZ1VSRHFjN1Ex?=
 =?utf-8?B?cTlLVVdkcFRLK0tYcmk3RkpEYk03L1dOdStsakpiV0sxMm9PcCtOeWtWZXg5?=
 =?utf-8?B?czl3dnZFL1NubjlQb1FYa1p1OWNORXRVeG5rcE1XVnl0UkNOVnpMQ0tBTFJZ?=
 =?utf-8?B?V2pLZTRZVThDZnhIVlBmWmdzWndGYWtvaGtJV2FxYkpoMklYMUc0V3Q4UW9u?=
 =?utf-8?B?MCsxM2ozOEIwU2x0M3F5Ykk0L2puL2FoNGJtZ3FsbFJqNzYySTFLZG1tSWVX?=
 =?utf-8?B?emxJVWM4Ny85cTh0TWFKSHpQeHZBV09iRXBKWVBpUHdSTURpMkNGcjJKRHQy?=
 =?utf-8?B?SjRwS21IYjVoZWVKV0ZhdmdXV0QzbXJFekV1T1pGNWROR1FYeFV6d291QnNq?=
 =?utf-8?B?eFM1MGxhV29jVnVsSytnZzltcU9WbFFqeXRlSWp0QWl0SEhudHBDSVJqeHZn?=
 =?utf-8?B?WFQ4WkZzLzdmMEVXMHlzV0M0b3FqbWlXb0VLcHdOSEZPOHpCM0RRdTkwWi9V?=
 =?utf-8?B?T1pZNXVZNllBVWFETGpERklaNTlJbXdXY3NhVGg0SHI3Q0J5Qi81dDNnSEJv?=
 =?utf-8?B?S3pEbXVkZzZpZ1RsT2pOZWlTUWhIZUt0YTE1SFVWTTNPbnlha3cvRnQxajd0?=
 =?utf-8?B?cmd0TzBuYWdpdWRGVHBPNU9FeG15bTVxYWp2MmcxVS9BajVuNE02bVNqL2hM?=
 =?utf-8?B?NUt1aHBZU1V1VG5WdHNrUlV1ZDJqbllnSUR4T29mamxVRExjR3RwNlpadVFo?=
 =?utf-8?B?VGY0UG9xVEFSZk5MK2VVZVhPbXdibTQxaVhQdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:47.6346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92301cdb-ed86-45ec-f8ba-08ddf1234d28
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11120

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e180364b8dda..54b8faa3ad95 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


