Return-Path: <linux-kselftest+bounces-30816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50374A891B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 03:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007243B584C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 01:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E051F4E27;
	Tue, 15 Apr 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JtEttDHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F3A1BA;
	Tue, 15 Apr 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682286; cv=fail; b=KgryT5ZVKE2nnqHYHaNzTP2JiC1Hha6G4agsoQ2o16DMDKksehv6OlX9k4wHDH5pNVFCJT+buzMcW3g07wTp/uPDdOaP+p7LpfzTS8khZ1P/MC7ZgJVg66i8+HNWRbLUS+qf4S8CAKYIiEErvblXjh+2buM4JBbr3lR27WmE/fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682286; c=relaxed/simple;
	bh=w4JD0NL/AHwo1JfoAZFre+bdqHcUx1W0DN0F2Zs4Y58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWL+FrZqGdAV+k1PItd5g1oSg/qNZD7HblJEYZkdQ9s1G8WpFNzjwyOKOiGHRGwk12E1mE+VeZi75Oi+pTdbI9dGMhoesOFKT+apnqO8gzTWsf0ggGShvkIALsffuuiwPymopZ3xnOEZIpUOU8NVeWkuHTFgxwzk5oXMZI7tLr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JtEttDHF; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD/jyR7ccx63xusPi89XhYoYobSY84lZ9OdFr7IzHKyXurcYXMCfaUbmBKxpcjJM/oGMGBgQsK64pPxbtySqcn/HtV4pCT6CGSPRmdEvyFx4rDSYxQIZRZ/BEleJJYarM5Yb9QdSStWCEtWDXwrwG4PwRNPOHiQSsSniv+4RDhULaz4ZsAE6Mq+y6CFx7XCVxjBaY1okA7W8BVhXBfYacbxwmFWq6j0E4k3uJCPnXLVqZOGcvaP+4xuCENt7HYEMqJfY+BvMA/4KoiA8rSjZ5KYT0UOU2IBxOR+mAdT61uK7fGAaC9Nm1JoXeTs832H+eYB3Y4/MK6Psr3iXfA3AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=g5l/jHyL3V+CoSLwi6zdF67fCFvxr/+V25D5ZypAvSj/YfzVSBIG/mO368dBnkKN1YW5kBa+7C1nhFtzTxHqCQ33l7BVbfxzkg/UQxDQ0Ue85DJEf34GlrLU7of7RxHgX2NmLINLRU9u7sGqVOZEwuUWeL6j8mE2Dj7u6JNv5dcxXhy2oC9kr6/PBBVHIbXafpgZ/50kCBkloa5cyXzEU5+NrRH/VfYCLKZmxJyy+JTaMiJd9Mgg+W1kctKaqIMBW2fi+JPQjaX9PnQs8Hm38P4bpgl4DvaZBpOSfu9LWj+Jy92DpVkh3LnVCGOSalzyinQeRVh7GKfMvIFyFywrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=JtEttDHF4cpCfAD8P6MAipTi8H6Hdv3Bhc8sUtoRsp/diS9W7deeosS9HD2aDc9BZIfTu/FzmIcAkMJIeVOlZclxO0rG1RKN08LEE3Hm53t3vzWwEpqBwOcpE1rxFHZ0pZJGfkMKzs//64HmGEu2gcoj3iRVTFLmfCGBe8iVKD/GdpOrjnyGfCPCW00g5OVYVaTAB8dFHldlsli3WHO8UA3WPglApzwNHoYXIWjkKIh43ZSIuvfnvD1/XZX8mnPKHXQKoBVuJGcwSNF7en2EbWCJe2Ox2q/WbBHSgv2v1FMJyAzyLzlx1dtYXUGw1tcS5prnY+Eq78ke9RbhnGjbfg==
Received: from DU2P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::13)
 by AM0PR07MB6259.eurprd07.prod.outlook.com (2603:10a6:20b:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 01:58:00 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::f1) by DU2P250CA0008.outlook.office365.com
 (2603:10a6:10:231::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 01:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 01:58:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A26244EF75;
	Mon, 14 Apr 2025 16:00:19 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v3 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Mon, 14 Apr 2025 14:59:43 +0200
Message-Id: <20250414125944.97350-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|AM0PR07MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 388b04c7-d3d6-4730-d418-08dd7bc0f373
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RDU3Smppc0h2SVlibUhoMUNwK3VWRFFwK3MvWFRxNWFEcGMzUFlDTklnSVdy?=
 =?utf-8?B?bXNFWDdlWU5PSjE0TC9pMU9ROVpXZk42djdwZU02MEhSWmh4ZlVmelB5S0VW?=
 =?utf-8?B?Q05pMGNUaXNreXpFT3Z5R0JURnM4OG5UUjh0N280TFZoZDVSQjRLaWZkZkxa?=
 =?utf-8?B?RExuckhKSVNoMFVFZUxVSVBtU0NoYVVFUnVzYVR0RU9PZzdPTnVsYUNtYVV1?=
 =?utf-8?B?dVdXTDFmeUw2dVREZEtPNW5CUmVJVjZaUzFmNkdGRzNubXpud2licTREYUR6?=
 =?utf-8?B?S2FXUUpPMnNaOHp2SjdBU1ZtUTlZK2NNQVlMZUg5akFMZEZtVVVUS2dsQ3Vr?=
 =?utf-8?B?L2xyL1pFQ1E1WjdreVJsYmxrd0h2WjVHTGtUYnhIT1ZxY21pTEl1K05HV0pu?=
 =?utf-8?B?c3V2c3kzcDltUjlDUTI1bHlIUm5ZYlVPck5TYnRkbmxEU1plQjcvQmdoRDlq?=
 =?utf-8?B?dHNMVTJyZVVPdnFBeFZsMVZIU1IxVEMreUI0dXBybW5EWnRyeU5CV0l5TFBr?=
 =?utf-8?B?LzJXRGRTQmJkR1kyUkU5RnJjSXl5b2dES0F6Um9OTFlQOG5saUpKcXc3OGdV?=
 =?utf-8?B?clE0MnRwd3dEeW5EWTlPcWNYdmxkWEs2TU5IQnZsRUozS0dHcW9GNzlDRHNJ?=
 =?utf-8?B?RWxIc3hmWExnNnhQZ1NySm9aYWlxdzEvOE5JTjFJUkR0emxlTDVQNm5Ma1Zp?=
 =?utf-8?B?b2o0MW56bm56My9OWjRkQjYxSlN5OGhNb3ZjVkp6UHd6YUNDNUVLYVVrSHU1?=
 =?utf-8?B?STNqMUkrbHIyYUZpTHQ5WjE0REpSejhaaUhBVEt5bHZiTlVmYi9BM1cwRHNz?=
 =?utf-8?B?S2FXQVZSNEVaZ0E2aXBTOFYvdDhxRW9qT3lIcUNnL2tLUnM2UlA0WlpJbUc5?=
 =?utf-8?B?ZUhxSjkrUS9aeGhIWUlBMjhtWG1wMEFPSzlYUDVnUzRSR0dxTTZhbWdXT054?=
 =?utf-8?B?Q2NqZGJhV1BobCtuKzJ2QjhSeEV4eDlyVjQ0TDh3SFdvUmhDWlZPTTl5dEM0?=
 =?utf-8?B?TGxXVUtHcjl4VytQZUJqemQ0cXhQcDJISVRSKzc0ampwZWpUNWVyMW9FTEVL?=
 =?utf-8?B?YmVsNTEvdmo0cVFHaTdlNmJ1cWtnMGR2eEpMU1NTODNNN2UwL0huNkdyd0p5?=
 =?utf-8?B?YVBraFpEc01iN0ZlMkJZWFo1K3pncXlQMndJSHVHanROTVQwVlgyRDFZSFVt?=
 =?utf-8?B?eE1VWG1yVUtLbkdpTXBLS2pPUXlaeGo3NnV4N0Z0WFBxR0cwU2ZiZ2NzRC9W?=
 =?utf-8?B?d1I4ZHJUNVNlRjJQb0c3Uk5WR2pITjcrbDk1REZiNWF0MHM0NFh5Q21FeVM4?=
 =?utf-8?B?SHBKcjk2ak5zbHZIUVAwdGlONGdyMnptT0F6V3BCeEhGOHRDdjVxUTF0ZEtS?=
 =?utf-8?B?SkhueUNnUVdXTVlBRFMrSnVYRWUwNUthTUw3VTY5N0U5bHhwNVJRVS9xRW51?=
 =?utf-8?B?UnhBWDk5Mm85UlM0WEludTcxRVdIeVFCdUM1S2JIaUlpblc4QWJtUSt2aGdS?=
 =?utf-8?B?RHgzcFBBTDJtNWpzT3RpeHlLNTVBWUdKRHBMZ3EyNTB6V1FjcTdUaFUzSkNM?=
 =?utf-8?B?M0w4SE95NXRNS2R2cnMrdnN6ZmpCRU9nOXdRZE5QMnNrQXBYOUEwVmVyK29X?=
 =?utf-8?B?NHVicXp3ZUZPTUFTbm5hSWV2ZXRaS1EvVTRLakt5YjJhNTU0RnB1VGlzUDdP?=
 =?utf-8?B?MG9SdkVwNE81Rzd4TkVIUjBtNzJsaTBHcDM1OVJRbzhHRWQxT040N2dEbTF5?=
 =?utf-8?B?SjYyWVRSbnhiUGxidEx3SlpvNGRCMFcxZzhpeThQak5zOWV1cy95Rm9rRjVB?=
 =?utf-8?B?YXIydUM5L0JoM3RmZmlsRzVjdjR2WWsyblRFNm9xOWJZTC9ydmtJNkEyaDFj?=
 =?utf-8?B?RGJEcWJFdHVSS09jQ2RYNzhHYk1SeFJmZ2hscUJIL09FYk1GSWx1dDNjdmlQ?=
 =?utf-8?B?bk9IM3ZBeHVVd1U5RDNGVUE5VkxZY3VDTEJhTzN4cVNSZ0ZXMlpEVk9TcVhz?=
 =?utf-8?B?cTNXTFBxMVJqTCtoU1dhZ3VtdW05bWhMeThJRkFtOGQrY2NFNEZtdUxaZEtx?=
 =?utf-8?B?Sm5acUtxa2hWOXNnd0NncFZ5dDkyTEVBTE1XUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:58:00.3776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388b04c7-d3d6-4730-d418-08dd7bc0f373
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6259

From: Ilpo Järvinen <ij@kernel.org>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and try to fit AccECN option there
by reduction the number of SACK blocks. But never go below
two SACK blocks because of AccECN option.

As AccECN option is often not put to every ACK, the space
hijack is usually only temporary.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8e1535635aab..936ec8788c8e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -981,8 +981,21 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
-	if (opts->num_accecn_fields < required)
+	if (opts->num_accecn_fields < required) {
+		if (opts->num_sack_blocks > 2) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			size = tcp_options_fit_accecn(opts, required,
+						      remaining +
+						      TCPOLEN_SACK_PERBLOCK,
+						      max_combine_saving);
+			if (opts->options & OPTION_ACCECN)
+				return size - TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_sack_blocks++;
+		}
 		return 0;
+	}
 
 	opts->options |= OPTION_ACCECN;
 	return size;
-- 
2.34.1


