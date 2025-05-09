Return-Path: <linux-kselftest+bounces-32794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6EAB1EFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26B5541295
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC51264F83;
	Fri,  9 May 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="k/mvQhIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8625FA13;
	Fri,  9 May 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825549; cv=fail; b=sh947iPiZ+hnV8+q1Pfefz1oZez2GBGhtfxC3bc7q12blSKmilwuRsBczLYFgkxwl8swWLg/Fledh7UI5BqQA176SwonujubFu7OG6cxpUtPgY8NMjRSHt+jzjSNOm6gKl2lK38VSkHFL+G7B41/g0a8sI7PJUeb0VkB7gqj/vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825549; c=relaxed/simple;
	bh=nrbWXbZVFwrcTvisblQ7HOjMBOXKQrrdo4lniH/1V4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsR/2RYWlUEbqU6HxX+0BLvvi3+BJokz/8iijjApBNiWoGJTiDslwTJAodXh0mU0pkriX+aCThtI3kEZREyIxiqkmIU0B46jCkYjvwNWVCSHiWdxrcGTbZswdLpBzJPZogn4CCU1qKxsLHbKnsOHEv83drLNMTI8Qh9bRBdcDJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=k/mvQhIl; arc=fail smtp.client-ip=40.107.249.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhJnbqCM/oPsZrL1Co+xFt/xGFfXV+PEHUamXEfdXmEMIvIheZ5YkMFtGiV0FBCO3XMjMtbRLuISVPFLyhv+nrTFYGBDdOpqtU9Q5MrPFJJ1UK6VylPQ72a69uALR7p0lsWqaBCXrGxV1VRoCc/Cjv5kILfEQy27vLY4zta+ivVrwmRAMymhjGKOC8D7vOIq5KLRH/4pcRvKZsKK5jo/+Og3xVLNIr9EFR6XgiSPIPxmbNQBq0PMO3Nz+CnAfro0o1bg7mzbo+OQEqUIcpp1jyV9PPv5J1k1w5vVWNFBLIRg5sL/O0oRmCA10b1hAMmAW2MeY7fo7G7ucjBTFdjDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY3CRV1KAoh3/RTE0T+7WZlY5VKa/rsJk+kz4smBDGo=;
 b=lcH7EprW3j4tByp/MeNwo2P29BN9wabW/42+20nCo0S+IHC0X+gGDjojAH1HgVi94k0JdTvASUJsVeXJow6BcCr8IETbmP0IcHua6r7+wYwwmP+39Vy6+2UBV/450kM7EM5cnavAxkl0zOmMIq77uTzNuSM2RW7FTpe4cLEq95NjwJjXrGUSneZq4fvxKIlLklnmaqQ2pFPEnwo0yC981FIBvzp15CF3Cf2jhfwBox32MC3hQjIqMJ2q6/EBOVNHfExzDW45W7Zn/xp8nOPQPBwsAg1MJVFkpsETl+Kzho5T9QuOoACh3FBQAVQCtFWwGYnqZ1ZQOfW1/v6Q5y5FPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY3CRV1KAoh3/RTE0T+7WZlY5VKa/rsJk+kz4smBDGo=;
 b=k/mvQhIlrw/wSK5mT8n6IodAlsCfYkHHwwg3cFSZiwoIdyt0gDgdYajrtVllNIu5RLwGRU24Vr1Px19KNEyk+ZKagHclKphfF1IwHTAiKSVZyMmlp2fJn7KheaF7T03Q64l8aOE2gAfuWfpshFVv0F+KPCQPUOHQAvSViGpXouQ3Gm0vgCa1xicF8ryCUCmfSGoZsWCWTdeflP6wfDfIJ8SiyAh5TOkqPUBxIUoHng01pv9Q7h7Qj0dMQKFcgtQXjCU/LeYtwgFTbMwosIbDrrd6s3rjQYxurRQBwy3vmzcO8ag05jkIeutswkKZ5Chlj0AU0khpr9UzeRSu3Xu2Fw==
Received: from DB8P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::38)
 by AS8PR07MB8168.eurprd07.prod.outlook.com (2603:10a6:20b:377::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 21:19:03 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::c8) by DB8P191CA0028.outlook.office365.com
 (2603:10a6:10:130::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Fri,
 9 May 2025 21:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:19:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6EFBF200C8;
	Sat, 10 May 2025 00:19:01 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v6 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Fri,  9 May 2025 23:18:19 +0200
Message-Id: <20250509211820.36880-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AS8PR07MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: a431a0e5-3302-4f1a-d9c9-08dd8f3f1f6c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MTVHZWlYeEwvNTR4WXhvSVVNSGQ0NktZcWZ0T01NVWwxK3BmTUs1RkpLdnht?=
 =?utf-8?B?ZDlxbko2MHNOQ1UxNG1GUGtRUWxQelNnelowZVM1MTlrV05teVlybjdtSmJI?=
 =?utf-8?B?NEtZcm9UVFNLVTB3bzFrL0J3L00xSHFoS3EyVmYzdEduN3pDWWY0ZHY1azFo?=
 =?utf-8?B?YmFzU1FWak5VN1hEVFh0bk5KM25vaHRQTitTRzh6aFQ4bGtzTHNCSFBPdk5D?=
 =?utf-8?B?QTZDZEwyVi83U2hyZFNhWGVNNU5jSTBteVBIWE9UU3BNc3FheTU0dVJjekNu?=
 =?utf-8?B?c3JBemR3dTV0VzQ3V1hZZ1hna25YQ3h0b2h3U3hTeHZ0eW9JWGY1WHdUaDZo?=
 =?utf-8?B?L1c5cVFLbnpObG1YcEZCbVlSdVBuTUhicnBFUnI5cklENEM3cEJ0dFNrbHFi?=
 =?utf-8?B?d1BjM0FpTUFMTEhudkpOZ2VJWXlDZFI0WFZDM2xNYkZobWZwSkhOT3pteTRR?=
 =?utf-8?B?THJyd2RRVktTd04rUDJSMG9WcXNkV3JvMGJCdmtlb1FmVmExVU5sOWRIWVE3?=
 =?utf-8?B?NEpNenBsVU1VOHlhN0xlZFVBM3ZvQmxJV0crbTZLRUxXeUpKUG5CUlVhdlpJ?=
 =?utf-8?B?cm9EdkpmMEZsamd3OEZyRUx5Zm5xWVFseDB3UXBGcjdOb2kwNzJZa1NHSUIr?=
 =?utf-8?B?R0kyVHBYN2QxSzhTZ0J2NDIyejg2a0tkMWdkMVBvaWpPcHd2RFdhaDUxazJk?=
 =?utf-8?B?WDh0MjYxaWkxL3BtbXNVSElmSlJBdmcyUFJCL3Y1aStwdmcxMUZXcVU2ZzJj?=
 =?utf-8?B?N1N4MWhTRnJnUnhkTmpVVmxUNGhIMWozbUVKWlRyY2ovZUc0ZkszSXdiWkVK?=
 =?utf-8?B?NCtKdVB2b2ZFemNOM2IzZyt5ei9iT1QzNWh2U1dBaFNYUm9zY240RUNPTkh3?=
 =?utf-8?B?ZUo3R25iUHJxbmdNYVZiNjdBSEUyUzBLZzV3NXE3bFJQdkx5bE01V3B5aDh1?=
 =?utf-8?B?NmVHMjYzUnUvUVdUNS9icUNrQThISHREb2xMTnVCZXMycXRLa25waE44cEJy?=
 =?utf-8?B?dU9PSVlWQVFGbUpYYVloWXJYVFh0RjNraGRBVGdvbGNPalREcmhGMDRKVFV3?=
 =?utf-8?B?QnRndytJWi96cEJmRmZ5VG9UQ1VoTC80ZmRBRG5VU2U1dTdGUWhIRzBhUXJm?=
 =?utf-8?B?d2pWS29Xb1hlR0ZXVTVkY3U3ZE4vWUdLODVPOVRGb2hmN1BGcUtlY2JZMllR?=
 =?utf-8?B?Y21CSXExTmpZb1JDcFNDOE04SFRoYnFNNHB2YlQvVEk4SzZwTTYybE0xSjYx?=
 =?utf-8?B?SXZyL0ErV2pyVUkxbXlta3ZmSVhwR3N2Q0pVcXovc1E2N1RLZlJRR2c1NUh2?=
 =?utf-8?B?dUZ3NzZ3Qkx6bTkvdk1rQVhPV1FBaWIxWCtSMXFoUjl0Z0wvSnlQM2NNQkpy?=
 =?utf-8?B?QldjMFUzVFUrb01Cb0MyVE9qcjE2S3NIRkMvVFdPUkVZZS9ScUxtRTNmVDJn?=
 =?utf-8?B?ODRUbEttU21OeFR1UTVDVlNIRVVJUHFqSTFFWHhzRlYrZU16VlQ2MWRSYnJ2?=
 =?utf-8?B?RlQ5VjFLS3VvYmNSWVlMZFR4N0lMMTBvN2Fnek5qMGp5WFJLWHNuMm9yQjVS?=
 =?utf-8?B?OGhwVXdRZVI1R1UwT3lENmppMlNuVGU0SEI2emZZQy9nNFV0YktnSGFaRUxk?=
 =?utf-8?B?ZDFTNjR2bVl2NmxOckxXZ3BkVi91Y3lxS05Bc05rMHF4Nk1UREZoRVlPWGtm?=
 =?utf-8?B?NFRVeGxMbUZyN1dld1RPeE1rd25wSU41SkRHSFo0dk1UNHE3bDZOaEJqY0pD?=
 =?utf-8?B?cDlnNWtTZGdqZ3VOTHAvNXNCaTJLRWdUb2pDeFZxWlY1MTNLY0pXNDRlWFcw?=
 =?utf-8?B?R2YwbU00VFZUZUpOZHRGVytiWEYzQUgvTG80R2lXTld5dSsrNjNrelpYUEJF?=
 =?utf-8?B?L0RzVXZCeUQrV2JibUcxWmpxYW10SkxYYkIrR1NPS2I0ZzRTbytqaEJSN1lv?=
 =?utf-8?B?Mmw0cFNZRkNWV1VJVDJlMWRCMjBRNlVFa0FPMUlIV2lWR01EVVN2NWJDMDBn?=
 =?utf-8?B?c1drNWxTVkhLKzNTNE83bGJTdVN4RG9PeHJDWnZDZi83Q3RYNlVWSVd1aEZj?=
 =?utf-8?B?WS9hNDNZVVU4dUcrUE4xWklhWk9YenZhbzhtdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:19:02.8959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a431a0e5-3302-4f1a-d9c9-08dd8f3f1f6c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8168

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
index af619233a6f3..a53eae6892b5 100644
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


