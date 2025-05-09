Return-Path: <linux-kselftest+bounces-32781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C6AB1ECF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C84D7B50AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0125F99C;
	Fri,  9 May 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mDgS//Bz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A25D533;
	Fri,  9 May 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825511; cv=fail; b=pWBp4+qXU4rn3XNa8XJB49K3QLR0S9b0XXAYcTvrK1DwFp051QeF/6lXGkji1/ud+qa6TU7EItAXEgZ++OAG6oganzEVjwEhLbtztduRQyZO7ryGwO9Apb39mVsqtp2M+rhRhPEbnAopYGN2nCS5OM0gfr9TzgiGpsCjZNj9Dls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825511; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IR4Iiqn+uGTSUhouYwmCX5jHvCzSYGtW9JGJgNOX0ccg3Tke/ziIb5dvB0WRmZas3sn51o/m3PsQXMbg0weN+axnXTlWZi1vxsXFE/msSyNQqn/pbg/dzxqIV1Oi6GfzuV0gXpSUzChGvyjhSlokDMh5yDss+VhEXLeXKsXKrkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mDgS//Bz; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3npzQpKFyZXBS2kuEhjpO8CkpQ5Du9xMtBPMhAhTefqk3BDXFYsB4NMCusWxeX5jrqF+6tCNEiSA/ivGD4bPXXC01IR7Vv25VhmtY5LmzChCnKkjWNhYdagepILdxEyJJWBbLHmLn7mDcfS0DXH3w/m4+UttvwhVQsYvY9zyuJosz3nNtZ22CazUon6PSdGm7Rrw9Os5VmngSW6y8PYOe8NBG1EI361Sl0x+tTl2/EvkwUYCVoYfgaxLFZVX+EoGw8Y0LTt1bv3ZVMpxvOt8T9GWlI93VdR8QrcsAZA5SQ5SLA1iOCM8oa8kIRo7Ibi69FxwfXztwkTqw1ud9AsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=pCSukyWs8JvZrkZxw43eaaYqi6BOhztA3c8UEE4MfEy3493YVPZh2OFpKqnzskgIMduVG3+w5VKpyc4bHbk9t0UxnRMBkllk9/wo4p71OByklsMag7fjlxE5SKX5G31zDFe/4Wi80nKXi6fteMIRbB1o5Uj2aLOtjGRiZhfZ11o/Mqnb4TpoKjVHV5pHJXyqT3UgZjwVxCAV3+EjI99xCBart2kieoZYGuBq4ciHx5f+aoopgNqjCADXTpZroo4egfSejctBmb7bLo+g/tx5zRJGP3aRTulUfudLbDqLA3BO+yHYa7qL4DkTPG65eqTqmV4rp+NXnn8Z59Uf6jOZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=mDgS//BzXyHO99IA/s9wBeobkCWmlqi69oEHzNzV6Sj741WLDeLS0pXVbfFwKqaFQxUx1z0g0IAP1VRaPlvkn2/aF3Zifk9IpPhzoSXo0t5p3Oz8ddfhDWy4TfpaDN0s2QuAz1H7tEAMPKBWTK/D+2hOjgw314ClVOJ4tHKbwfaRaxlB6buL8q3xBTeu7u2FYe5yNNlDVo+nxbNT6cjCPsJnuWRw0NsBLep1T12KKtTvMnVpcTM5aVm/rTbAL+e1UdGeJ9tEqeQxknXi8sqvlrBDQh8NbWiqVP9WXp9kis+JOZcq6PbyfNUFKC1UaWbcGueSzslcMWwQu6OWwQQugg==
Received: from DU2PR04CA0155.eurprd04.prod.outlook.com (2603:10a6:10:2b0::10)
 by PA4PR07MB7663.eurprd07.prod.outlook.com (2603:10a6:102:cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 21:18:25 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::44) by DU2PR04CA0155.outlook.office365.com
 (2603:10a6:10:2b0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 21:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via
 Frontend Transport; Fri, 9 May 2025 21:18:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id ECAC2200BA;
	Sat, 10 May 2025 00:18:23 +0300 (EEST)
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
Subject: [PATCH v6 net-next 01/15] tcp: reorganize SYN ECN code
Date: Fri,  9 May 2025 23:18:06 +0200
Message-Id: <20250509211820.36880-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|PA4PR07MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5af6be-bc3a-4749-973d-08dd8f3f0918
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WXBRb1ZnQzZVQWRXVmR0YTNaaXZranhGZkxsU05YbG5rdHlnWnl5Y2RtaHF0?=
 =?utf-8?B?aVJZWGJwYzVnMVBCbUVEZFJtU0MyUURGN2c4d3g2MndHaVY4NE8xQlZZb29l?=
 =?utf-8?B?TGhJMDVlalpNWjNhMTNQVjNrSGtadkZ6K3NhKzZveGE4U1RYLzdVNzlNYTNF?=
 =?utf-8?B?SGdmVUExTzFwdmJWeHordWlMbGk3QThXSDlYSEtZR2dHZGoyczVuZjFScExK?=
 =?utf-8?B?dmFncm00Z3Y3NTNoelg2MzR5RlFNdmhhc1B5VTRlR3dWVGpRRlVSNUZwM3NW?=
 =?utf-8?B?TXhZTWVSaVF6cGdvUjFsYkVSRHZWRHdSSUpMdUJpdEsvS1haQ3ZFV1p0NE5l?=
 =?utf-8?B?YTJ5S2x2MndEUmUvVG5nYWNmZFplcjF4TzdETXNERUtveXk5dHkxKzFjNExi?=
 =?utf-8?B?dEFaN3RVNXBrc3ZKb0NwUGFMZlJ3cVpROFByS0MwQ0traWp1dmVlZFZRL3hI?=
 =?utf-8?B?YWpBWm54NmttcS9zUk4rZjFkeExuOFVKUTNmV3hiaXZOSXowUWtQNEpRTE90?=
 =?utf-8?B?bGlSaFB5NnpCZTBwZ042eE1PT0QwMGJtanFpcXNxeE82ZGNNa0VHNnlQeXU2?=
 =?utf-8?B?U0F1aEdJSVNmOTI5S3FPNDd5eGtCRVU1Zllqdk14aStUVnJrQ2twaVBUSzBZ?=
 =?utf-8?B?SkpjeW9VWGRYZ3pkdTV6QzlPbzVGblEvQStYeld4RnJzVHBWblNXWGdocW52?=
 =?utf-8?B?bzI3UGtZUElmRlBIUFRRY3c3bGp6TXMybFdUZFdzY1kyRWV5aG1lWGVjb1FI?=
 =?utf-8?B?RXhXSStXWm9UU3Zyd0p3V2VrREoxa3VPQk9DalJYb1NGcGFXZHhWOWJVSXgr?=
 =?utf-8?B?T0lBV2tsSm15cnpzU1I5YlVMSkJHcFJlcm1Rd0V6MlFZclZPSDFUSGxkZFBR?=
 =?utf-8?B?RjcwaFBCdnA4dnNMS2pCK2NWQkk4ZUxlM2tCL2lGMUlKQzMybjR6U3IwZW12?=
 =?utf-8?B?SlF0YTg5b3E4c2Y1QnBJV2xuNGE1VlRNWS9UK0U2MWxJU29scStzcVpGa2Z4?=
 =?utf-8?B?RXpiaVU5UGxQMFBwbTJxNWRQaG8rSGZoald4K3d2Z0lhYWdidXFsWjNXY1Vv?=
 =?utf-8?B?MXZOZTRnUUlheFJhaUhFbmY4MUlPa09tUnE0TUlrdkVVVGI4OUIvcEljd1BY?=
 =?utf-8?B?VlVoNFIxbktWNGJhL1VENWZacjdpclQ5T05lSStNM0ppREJ5R25GOUZHUG4w?=
 =?utf-8?B?RHFqL0JDbkk4bk9CYnJpakt6WGNvZ2MzU1lpUnBTdHZvM0ZJUjJQbVhCMitq?=
 =?utf-8?B?ZXdTVU1uNlIwU1duWklIZDV1bXhWcTNxTVl2RjdGVGxaOEVBb1p1N3RsRWNz?=
 =?utf-8?B?bUFRMWg2cndHSzRtVUpYRW9ieUNCN05lUnhRS1k0Und0VXZOaytGOTBLS21l?=
 =?utf-8?B?U2hMR2YvZ3ZWYnlWdGlhSlJsakE5WmdUdDFvek9CSUtScWxhUjdHYSsrRUw2?=
 =?utf-8?B?aGtkeVA2eGVjUFlpdjdWNWoySFlXcUNVQUJNakorM0k2K3UxZFUya1o3eldx?=
 =?utf-8?B?a1ZRN3g0d1JJbDhPNTdVVXV3YnovVkJwbWRBTk9GNG9haGZTMzhLZmZabUVU?=
 =?utf-8?B?bDEzWjlDbzlYczRvV3JVZGd2QXF5bmg3NUlra0dZczA5ZjJyd3NUb1NucmRs?=
 =?utf-8?B?eTAreHNEcm0vZTQvU3pvY3NRU2V4bjE1YllxaXcxUUJJc3A3NS9DWDJjYUFn?=
 =?utf-8?B?T3dCd1R2eGVndGZyR0N2VHVxUFZHT3lsdHdMNDB5TE50enlQSDkrN042ekhD?=
 =?utf-8?B?TjR6QXduK290T2dnR1F3VUM1OE4yV2ovdytXY2ErQzBGTnV5SFBXNnVKdWtm?=
 =?utf-8?B?aHVlTnRPNmFScVd3K2w3UHkwUDRsOTJTZUpZSlRqZzlhOUdVQVpSTXJkbUVG?=
 =?utf-8?B?NkpCbWFWaS9odzEvU2hMcGpsSmhQM0dZZU9CbEZOdDVBQjR6b0VzeTlud3Ra?=
 =?utf-8?B?ZmVmb2hpUTVVZzlucG9lZlA3NjNKY2R4UGkrcWlWWFhhRHcxajl2c0x3Z3ox?=
 =?utf-8?B?bUtlMjJMTkJVTUR3WXpBbm5UbmhsREZWUG1LNE9uU1NhR0pIQkdKWndSKzA5?=
 =?utf-8?B?alIrNkUxdGdvSnNpaXhNSUtsd01FWmhNOGs1Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:25.4355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5af6be-bc3a-4749-973d-08dd8f3f0918
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7663

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
index 13295a59d22e..9a1ab946ff62 100644
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


