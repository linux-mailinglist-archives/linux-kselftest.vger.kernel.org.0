Return-Path: <linux-kselftest+bounces-41870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C46B85FD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67561C83FD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F573161A8;
	Thu, 18 Sep 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UNJozR6b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7B307AFE;
	Thu, 18 Sep 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212507; cv=fail; b=Gk/mM4mcKT9aNvMVddo8dF6kG/XJfAC7bsW6ttMllYXD6Js6lZdQpAw/9SI3WBJFA/lEjpOvng4VEXk4g31EevtTNnoQ0OIi2ZQV5ctOnj5QFnBDXqTjw1zOmkPGEKxHfngJEPVZDhoJtYakms61kq4SnEyb1eTUjlDRZOkBNV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212507; c=relaxed/simple;
	bh=cYXVVzwdbNPeTWX8R2CY9GTV1X04YYmNEp84wna0TX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BonkU74MlKl0L+gzg02+veLotgeYEQvwr7gQTAxEjbV9i6QKq67++uhip1O4Z4DoUwt5lxdcJvUR/x762xgEPUFieCdlX5WP7zBC83RvDJkT2qbfUXhckUbt4Io4ZvvAJnNLBUERj0rgQP6Nydq0WdAfCIABKC1puKRtV12XKSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UNJozR6b; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F16zAPwUnhg0SZ2kiH3nRg849gdcxVG+z+258wAewjktikpVCQlKJrCqaIWxbeuXzN46favdhZ3jvLu9fqddsPQIV1D7I9ulsVOdJNOjQUVGsikjyjInLDdY+3nPzMHdzEcg7a4TNuV8EKXoSavsY8OQKPyZ3dRZptdntfoXZ62IKV7eTHHA0Zb8TDlZPc18/S2AEa5hjkLK7LqsEXif0pwvlyFFoCbiE03wzAEYOVz7kmrg7w8mln8fhkO0vyPp5vWXCZCltXKFRQAiQrxVFSiHWIhRDGsGX2kgrfZcDyTk6m3kVLwqhKnu6kycH8rNeSnEblO5z65fcw4jOWISww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV9a3e3cgxiDsIJ4LCG/B9GA97dwMFIn96wQbioBiu8=;
 b=oD/5COjPY5Rx7CAEtj0OQtEb9vKRyBNl6TaiI+FBUaLwvzwU70fLHldY9/y32Qn+oZR7yS6gEDeVBItpmb+fA727RD/Ip/5SkKc1E6HoCi9ruo5EiXiyLdsgH5D0O4u0bwdiW0/Mja8hVpqgk5zpBVlYanNmRDpFRh63bqOkFpUXuw9X323m11MaA19yA+q4uDv8Y6NzNaWEDyLo9jLCzVnOMtPNNW/SnR6qDJNm7skLASQwMD81GMjMxr5W72gZXZyExnLqHma17T5uUnUVi8HCn/9fqfqgH0xnQXUQkzXFFTNjtj+rTcdkyhjQSrOmHLB2WTsSbzJr+TotJ2Vo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV9a3e3cgxiDsIJ4LCG/B9GA97dwMFIn96wQbioBiu8=;
 b=UNJozR6bAdRQ+0VG4tqdo4lEcfXkcq/fJPkpytdFtm0g7AUWYbJvFNQxLbFjFu31ESS6A+519uSYLQ3FolMgUic8IkA8sNfk7at7mBZYCe/AwdXHD571fJN4V4s05cJ6MhHcH2dCBTSY8JLSdI28+h5KaH4tZSmZQ3OS0CMQsSnu2dEMJXENVoppYbEZl0aoKoHgt7G37q9RZgwJoYZQht/ojS8f5ZLgbyLFqEwSQY18uVoxw/MxpcCJl7VX7teAIOCLY2dprYfKvlICVGNP/kTKOZ0rZycj9rSB72fPMHnx/jD+DXS4mmk3m6E04/aaR6jkyhiAoZ+FtfZ3EeJciQ==
Received: from DU2PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:10:232::20)
 by PAVPR07MB9192.eurprd07.prod.outlook.com (2603:10a6:102:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:41 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::e8) by DU2PR04CA0075.outlook.office365.com
 (2603:10a6:10:232::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 78825200C6;
	Thu, 18 Sep 2025 19:21:39 +0300 (EEST)
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
Subject: [PATCH v2 net-next 02/14] gro: flushing when CWR is set negatively affects AccECN
Date: Thu, 18 Sep 2025 18:21:21 +0200
Message-Id: <20250918162133.111922-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|PAVPR07MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 49eb6d1c-edf1-4f01-9f8d-08ddf6cf7365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2VCRnlNSUVWQnFTcTVqTzZuTkZodEJ3ZUpqSHE5QkpmZlF5bVEzQ1R2bGpy?=
 =?utf-8?B?b3pGNlN6ZUFhQjNpeW9MK3g5VExTZjRad1V6OW81NVdvS2tnZXhxenZYRGMz?=
 =?utf-8?B?WVFWSEpoQzBKdnU5S1d6UXFlT3lRN3hOMlJ2bEFwUHpER1ZieXJWTU43OXh4?=
 =?utf-8?B?WE10bWwybTdNNnh4T01WT2N1cmVobGVkWHRCS2ZjdXVjSzF1UUxyMVBrNGV4?=
 =?utf-8?B?WFp2eS9rZFRSK1JPY25JVUI3eUNhZUxKK2VCOE5qRWRTZmVYZWZ2TDFWeFo4?=
 =?utf-8?B?OWRBRlV6bUhUVlFrd1ovNlJzY0FQNTM4cjdhVlUvRzhWcklqUUdGM240RytK?=
 =?utf-8?B?Y1h3WlF5RndIUG9zUWovd2FaL3lBUlZuZ3FyYmZra01HL20xNUdyZ1Njcytr?=
 =?utf-8?B?NHpNeTlQSTA1M0xyRndzQWQ2ZkhGaXBrQ2cwOU1BWVVaa21CK1hta2tzc3Vu?=
 =?utf-8?B?YzFoN1pTNFVNTDBOSWdGTkdMN0hHbEhXYXhJdnBOWEphL0VkMm1RU2hoUVIw?=
 =?utf-8?B?b1BNQk1KQ0VDbUpkVEVYbkM4RS85Q3grTTlZcWFLNVRZallDazE5dTFmdHVE?=
 =?utf-8?B?RitGK09sWVhLVnhHb1djNmlFSUZ6MWF4bnRxc3g4MXhVTEpCd3FSc2htNVNu?=
 =?utf-8?B?U0JFSS9JY1FuK1VuQS8wSUlhZGdxSk9rdnMvRk4rYnJueDFVYmxjbkRqNTJK?=
 =?utf-8?B?K29rd1pKRXpML09BZ3cvd3FpVzVmWW5jYzg4SHNnT0cvQXd6K2NBcTVDclVB?=
 =?utf-8?B?TkIvaGdRVE9oa01KOVh3V1RuY2NuMlJFdUlUOGZxT1FrdDZLdnVSUi9UbUtD?=
 =?utf-8?B?cmxmSEhqMWRla0RsUXRlRDdDMVVXN3lrL0V1YnFDVnRVRUE3YmlneFA3V0Ur?=
 =?utf-8?B?R0tkQlNocHJ2emo2a0FyMnVrVXlrelVXbVMzUFl0VGFXbkM3OXlodmZpYzgv?=
 =?utf-8?B?dG02WEI5RVBoeHFhbmFMR3FKN3FKYkFpUm0veWh0VGpNQmM4czRDOXNJemd1?=
 =?utf-8?B?Y2V1SjJCMDFWckF6bHlLSlpmR1lza05WbmJNOTRCZkhmakd1enV4WVdVYXhU?=
 =?utf-8?B?d0dZbktQV2hJeEhrRC9yZkIyOUkxN1JkeXRNRFBHN2hhM0U2dnFtMVhzZENo?=
 =?utf-8?B?UDM2YUVCanFjUlc2MW51Ly9YekNZd1ZKTkUzeVRnU1lUTE00M2xYNy92a1dU?=
 =?utf-8?B?aUp0T1h0SE9IS1YwbmRzVTN1N2NNdHpIMHRkMTBiNTBvdWx6VVgvQXArSDIw?=
 =?utf-8?B?WjhTcXlvZlZ5VjhYSTE1OFJOdXp3Tzc0RjBBSkNzaU9DdTR2c0FZeSt6Wm5G?=
 =?utf-8?B?WnNtbWRVL2FQVUZuM1JCK2tZYmhMeWlSaC9HTE05bDlFSmpGaFRSZjBsM0NR?=
 =?utf-8?B?QXN0aG1zblVvSUpMWjNDRTVPcmM1N1FtdWlrTktjbjdlRVNBNWpXeXV2bUlo?=
 =?utf-8?B?Y3ozb25uNml3blhYL2pwMFFoamd0OGlrQ0tlcnIxcjBMajVUVVpSdmlydmFi?=
 =?utf-8?B?RUpqS3pTZENualZZbk13MHlBNlF3d1k0ZGI5MjhxTTI3aGVQL0hzTUdMYStD?=
 =?utf-8?B?RnBLWnRwalhsUEZDblE4dm5QSHNXSWF3WDFNVW5LTkxFaktCODNWYStrUmF6?=
 =?utf-8?B?WWFLWEZINDBFajg2aVNtaksra2hjL0pNUCsxVTZEdzZLOWpEMkhRUEdmT28w?=
 =?utf-8?B?OExIZ0k1YW8wT1IzcnI3Z1pYTWhuSlpmYkk4RGgwYzQzQkc0T2lFT2M5UHFv?=
 =?utf-8?B?QVlMbG1CMjE0RDcyMklqVFpBcmxqaFhkRGpvMkRhdTNESjNHMHVvZ2NwOEpZ?=
 =?utf-8?B?T1V3b0lXL2tFbk1nZUVYdzVrY2w5SWxWeUZXdXhPUUNRWERlWmUwTW9GdXRI?=
 =?utf-8?B?TUcrSFg1RTBoMngvT2x2c093dmYydnVDaTFoVVFDSUROUlJwMEZUVW9naFYz?=
 =?utf-8?B?Q3RGTWtJZGQ3bmpjbkhZNzFmUzBHUVliTFJCa0c4b0lLZlNEZG1Hd2h0eGVZ?=
 =?utf-8?B?QnZMbG05MHFKZm1kb09HMnhvRGY5Vmp2K3d4WDVhM0ZCekIrd1RUNnd6WGlS?=
 =?utf-8?B?T3FjeVZtZ0dZT3p4WCt1dXRnUzVlN20zZ25EQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:41.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eb6d1c-edf1-4f01-9f8d-08ddf6cf7365
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9192

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
index e6612bd84d09..533195e00e4b 100644
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


