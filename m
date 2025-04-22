Return-Path: <linux-kselftest+bounces-31322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB664A97166
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC781B60422
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47091293B5E;
	Tue, 22 Apr 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FpZD+c16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B413293B42;
	Tue, 22 Apr 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336331; cv=fail; b=MNNxcwJX/R6ZKi6xyQ/KuYLxepznJgeG+Bz7iLMFF17ByMISEH4mDzyaYzFu18LToSEBmt411U+ZdMBpnGamOFY0B+WICpd5nSjP5FHkJR5DkigeTFTxLbE+ytkWpSjdCtW3MbZKCLEyNqUol9QuzrFmnKLqRGk8SmqHFj5vRDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336331; c=relaxed/simple;
	bh=w4JD0NL/AHwo1JfoAZFre+bdqHcUx1W0DN0F2Zs4Y58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jec+siPYWHC5ZdsF2xnFz6E4EVcMGP3Aq9Eqj2wZfTz7EiTGaotN1QMFsivEYnHynxwm8sBPWOLYi+rgsllYht58EnjLR8/2FcxnSCJtTYUo4+krTLIMnGFK1baE/iYFT3ak5f3EWBkDi7znKTn2P8XRVr15xRRcBPRNmz1yLVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FpZD+c16; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS+3nIQSIglF4fTGMrnXZ/Ykk+o0iK4zycbXkxAOtNJFoMgUlVPAlVKGab+FNLVmOxWWgK6hLPOvlY6DOAaXDAw/3mu7GR5GQk7GBEL1cELJfxjUyfan30HP5NeLfR5R93Q6rx7phtmR0BUl9/MnWAlcmDgUMVSDtLwo8vLyznVKdkAtNLkJR4+8X9N+Yazcb4qlU7rS93xdXgB3rpkSet9waasnPz12fy2N/jW6jWya7TWRblu2tviFPt/eBPRjE7/lYYMfme+eT1O9AhTI43eWa9hK9ksYILKLCFESgFQHpJMiQRsqQY1eCgVpf3jZiGCysDKTHZDgYf/fetXaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=D5G0Ufa/XJHnFupPqO3EgsgaDskiVTe4GLWJ0Xv3wTc8q5AbVKX8liK6PjuXhaMoxzZiUDmh4f8EZDqJ4UjfKag44qLTZRbL4CKFCPn5aE16vx6PdEBqPo8bdJjh44XNBRyIznut56NPlvZGZqoMmOW0SrtIi5ApZ1ilm62zypnbmNJaeCBp+e4DRLTdMZbYLw4zUReQ7fyj+bMrbxOzhT0ovvjKwdxOcQlCDAo1s6TLJ7Z9qFUmsqO6KZQi+HGcmgZMTlBBP//WGRJFbrOrb5JVmePSTY5aTbWzu87rG1i/vMnBt4e+VAvYi7SoEN/D2ZldUp5z3VSKoM1T6WZKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=FpZD+c16sQxoXRy96C7qOTCygWx1RFxedgGjCjN/UeCPpNT2XMvhgu23K/BSsfMdvwDp9lRltIUS71gKX9bEOk66hZGfQ7SzFRXiIhLTCjj5huQuISH6KXeSYpQfeTgpMAzhRZDGOyp3mjc1ihCPdpgNBGxGRmPzfP4AXJWW8mwQHDeSbSMBc9QuMoPN9wmJCGGN6BuKocNlh9I0sy8aXizhORznbgRu7tIyPcl/mTc0dry7H97stmMhXIMlYPNCnhzcnOwBu+h7qBLP8D3171l5JJ/E3ywXRIOZzU/2T0Ttluo145g0v0OjbuhKT9iB+OeHBok5ZwmCYBlqPfR/Rg==
Received: from AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::38)
 by AM7PR07MB6422.eurprd07.prod.outlook.com (2603:10a6:20b:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 15:38:45 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::3) by AM0PR10CA0085.outlook.office365.com
 (2603:10a6:208:15::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id DF22920A28;
	Tue, 22 Apr 2025 18:38:43 +0300 (EEST)
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
Subject: [PATCH v5 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 22 Apr 2025 17:36:01 +0200
Message-Id: <20250422153602.54787-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AM7PR07MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b21fe9-23d5-450c-fb60-08dd81b3c499
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RGM0Nnd3dW5OcTREWHZLT1ZGUmdGZGRzUzN6ODBMcjRGdGZHdExXbUx3a2Nk?=
 =?utf-8?B?VlNvbHJYcDZUanRmWXpNYnVLd3JkRXBFRDdOVVVacE90cmFEQVBsTGxhcDFo?=
 =?utf-8?B?Ung5RWIwZU9rdnNsQ2dwVHl2UnVWUHZKL3ZKV3FaNXZsNUIwQ0lWVThWanRi?=
 =?utf-8?B?VG5oSXBxcklEVFZEeXE4OC83SGpPM2tibWNwTHlJbDhpN0pTSDU4a2FLa0s1?=
 =?utf-8?B?MzV4OHFlTkczYXJzOWtkeS9nYVF4UGwwLzhuV2RJbFVSZi9adzdtdWpCdTJp?=
 =?utf-8?B?S0ovalFrZ04rbmczSjRFenFnVHBVQmQ3WkU2YXFtYkNBT3B2bFhsUzN6V0xN?=
 =?utf-8?B?WlNKSDFJb3ppdXBMWnhIaEdrYXppcXdReXpjTHp1YTNGMFpQWUUyMThJdHRz?=
 =?utf-8?B?Zm9BMzB4U25STkNaT2pkWUQ2TWV6d2w4TXIzWGJPSGRYM3Z1SEg5N2FQWnBv?=
 =?utf-8?B?TzcxRFg3MEIzRCsyR0VLMlM3bXBETDEyODBmamtqcURPYklQQlBGU1ZtMk1I?=
 =?utf-8?B?N0dNTWFxbkdTei9tR09SaThlVEx0eDliWEVUNC9CNncyOHY5cU12cE9SNFlI?=
 =?utf-8?B?OWNWOVh1NGliTHpJUlh2MmhqM3pVTjhrL2hXUEt6VDlBMXFqcXdvZExacU5W?=
 =?utf-8?B?VnRTVWJRV3F2UElmUXhyTUp2d3cwWVN4U2pWSmduM3VxN3BaUXB4K1lIZkNB?=
 =?utf-8?B?OEtWNUMwVzlyRDV6NXBRdGdnTUpwRk53ZzlOSVpBN3pINkdROEVBTjhlWDk1?=
 =?utf-8?B?TmRuQXhZNVYvVk0vN3ZFdFJOQzRvYmwxZndFS1FBdnlZQm4yYW1TeHJRL0kx?=
 =?utf-8?B?WEoyTEVBSXpzbjc0TEl5TE9xWVhkMnJGczVEaXF5SngyV3pBbjJacVJYem4r?=
 =?utf-8?B?Y1lFaHBZZm1PRlY4T1hXU05pdmtJeXZWckJEbEpDY1pBcktML1hhRTNLdlZX?=
 =?utf-8?B?Q05PUHFEOUhHV01BZHBURnFUTUJ6aGgyczdIcjJ4clMvTU0vZE93cHJxN1NU?=
 =?utf-8?B?R3lBSmU1dlJ1OHJZaDVaRE5CdldSUEhZTkd2RlBHcjRKQ3Znbi9pUEtZOU1M?=
 =?utf-8?B?Qks2eWJDcGxtSlg2V1J1L1ZzYUh1a1V1YnBSVjhPdGlqbnEzbXRuVjBBaHpY?=
 =?utf-8?B?V0RjRVFYN0FWVTVVVy8xSWYybDhiRlVFNnU3L2lKWFdCeHh4QS9SL1Q3cTNR?=
 =?utf-8?B?c3NyaUFTdTNVU1I5dzRqdU04eVE2RnVnOGFVNGJXUHF5ZWlDVzB5NldaRDdL?=
 =?utf-8?B?eXJnOFRmRDNQY1ZxS3pXTWxUMUVhb1lMVzVKYWFhZmpudHdMb0dIRk83cGpy?=
 =?utf-8?B?WUpOMnRuelpzQUJmOTVqRVh2R2d5RTU0K2xpdks3NzZwY3EzK3NDUTBab0pu?=
 =?utf-8?B?Mm9LUkc3dFp1LzFlZjdqeUZFczNYZWdYcWNUUTVLWThXMitmaUZwT3ExTnNa?=
 =?utf-8?B?Wm1STnRUK21ZcDRraGM3OHYvc0tXZWtlYzFFYUlGOVVpaitmT3ZlODNEeTlR?=
 =?utf-8?B?T1pLSDBZZTd1TlJtckt0d3Z5SnZ4Vnk1L0ZaZ0g0NUN6UGRTL0RPNXJxWUxj?=
 =?utf-8?B?RmFjWUFQczdIQ2FaYk95eHczaDFqUEdISWxsNW50bkxxRmpEK0paZFZrZnlm?=
 =?utf-8?B?N0FvSGJMZ0dCWGZYbEZjV2tkRlU0TmwrTlkyS0J1ZjdpdU9WSnIwNU9wcEts?=
 =?utf-8?B?R0MwSGxqR0JnREpQS0VZdDlpZWtselpwT3lNeFZONHBCKzRlOVl2bmkzdkpT?=
 =?utf-8?B?Wjk0ZzR3QXA5THVvVlFkb3hhMitmNUpET2J2SU5jY3R4MHI3TURqSjlHTGxE?=
 =?utf-8?B?MmhQbVBBc3g2SERJSTh1NEVTamloWkRYUnhQRlo5c2ZwRDk5M0lyVVhkOEpq?=
 =?utf-8?B?cEpGOURrZjJyeDZqM1VjMW53Z3lZeWRCQ2I1cjIxWjJnUVgvb2hWSUwwbnJ3?=
 =?utf-8?B?YWczTjBiLzF3clBOektJNWt6N3dvYjNhd2lZYitBelhXUm5hanI4Um9YbDJz?=
 =?utf-8?B?Y0lxMkptYlV0SWpWcjl0S2lDMWpmSEZkMkxsZGtLQ0lDWk1ScC9UQitubmJw?=
 =?utf-8?B?bEdhU2hueW5mdldrL2k4M0xJTmpUWCs4azdmQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:45.3408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b21fe9-23d5-450c-fb60-08dd81b3c499
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6422

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


