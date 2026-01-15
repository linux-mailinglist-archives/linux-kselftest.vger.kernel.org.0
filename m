Return-Path: <linux-kselftest+bounces-49018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD43D2486D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B52231185D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC3396D19;
	Thu, 15 Jan 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IdCDki6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894C396D15;
	Thu, 15 Jan 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480152; cv=fail; b=b0Qn84WcSZ13uMuBTCBxMqEKR3uaRi0hLwqSr7H12Yx30tyM86Uxcbbbc1xiaI3IS/UzI8Vj5CmVAW4BnifHThIa8UV3kvMvm3NmchVUHJimaxa1yVVLgIeaEllUsWwGN1yEn5VCOt/GnK0ytQ89fR6HeoNIC1pPnHfBDq9qfMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480152; c=relaxed/simple;
	bh=Q49lg1ygR5li/7gImh7zFQzfI3h2ISG+4HsdDeihcTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgmcYjCs8sDSTYCGVEstKg591bpiPRcaS2TcyZejMhA07KnUU2BU38TWFNOvQdCmdi6TONiA0+POWGbNEfLZn1oosSLnJyKwvSrb/BCtZPSUpf0bcdmN6j+ism+Cx4V+2nP5FTSanTW9CquYWBH6rt4emgm9qi553ZoIJjeDB7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IdCDki6d; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl3ALMxshzbeuOqrBJGEWC7k7sjHZ4TfC1Uhn82B4Qx8nUcJo/bcXnxhzViauB6PqZai708+IECrA0wCSN5Ps2ar6PMfhJmUtmEx5nrgX4S0thT82L/zyDtk6HJYOpO6unGzDjKc5Hq//w7mJf8HMZJOUk8YTHVTm2Torp/eF+LK8HqL4IVsS+HPZ8ikQ05wqIWdWlTT7AAi1Rh2Jh1xaiRWhkauz68NAb1MRvpCFiX8RGAojgbwPXfk8Rr9++4d/UWRfKZLz//Ibqbm+lqdKgYR1GCyZo1Q3XsnIwI+YYHtjC3BqTqwhFErgHagjyVS1Q4xzYc8CiWZf1clGMEEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=X7FdBHTahZ3uFB7vGSpfjQm+nKsCn2AXeTjp3HuchWQXQEAZn//nKVlgnhwC9EpJrbP/SIVpgGZG7o88wbCKOYqfC8q2Eu7Wks0JgKZoelI7fCPccPITP70mvCDSDfkP84t/wXnzxo6yKYWMzwStkQFxsGIUnyKlRULXHgOIzEmNnzVaSAodS/joqsy/qORjHEDGs9G2BVjoyt+DwSOHAcsS/dK7Ye1V41KV40Kuyixh56K9soBfwFII1n163J2Y2BUnd5A97e9YjQTVL0uwwREAEyjRJL6ql1HeSH2HuXrk/3Q+fkk9R4y4GALbhMJYuRIfzLy6ImItP8mieI+ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=IdCDki6d5yF4wAQzrVF7Jbehu4cLa/vRXOWWbosA4t7vv6tjv5a1mmJStUrMs5TO4kiknbX2QUg0bWUFpGkOCglq3coUcmH7H1EnSLHDkGINz/hFmSKgqPjm4A894COSELpAwGgnfajnao/mm2K+GNzToVsYZ4xrvWbLzkRnI6d46xXjZ1ImT2cwWTM041vIgwwbh+CU8o6VThpxMJkvKZXRjdURr09c92Aqk9yDr6UJcDy7BRors5qfE7hZ5gAO+PIU2cqsFM/slfj1brqBetkTgmYn8B5nJu7TAYhi5MF2/j7ED3D4aFurWgT1G6LthUUTXhkTwz2XGKzwh78GiA==
Received: from AM0P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::28)
 by DBAPR07MB6743.eurprd07.prod.outlook.com (2603:10a6:10:191::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:29:05 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::ed) by AM0P190CA0018.outlook.office365.com
 (2603:10a6:208:190::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 15 Jan 2026 12:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8F553203EC;
	Thu, 15 Jan 2026 14:29:03 +0200 (EET)
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
Subject: [PATCH v8 net-next 02/14] gro: flushing when CWR is set negatively affects AccECN
Date: Thu, 15 Jan 2026 13:28:34 +0100
Message-Id: <20260115122846.114576-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|DBAPR07MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9fb0cd-e577-4785-2e0e-08de5431ac36
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WW5PODgxUDVSZDZmaU1UZE5EQmFXNG5lR1VCZENjT09LbnUvKzBhMUFrOS9i?=
 =?utf-8?B?R0VYWk1xVlVtRVZPZkRMN1BQNDhDWmlvaDU5VFJBZU1UeTRpeVlNUytpOFlR?=
 =?utf-8?B?Tkd1cFhRdzEva1MwRTBGaU1GZ284SmFiRU96dUl2ZW1JN3E1M1VOL3RYaHRq?=
 =?utf-8?B?QmNmck05YU53VFVMZEVmU2hiRFRDa2g4RTE5cTRiNlZ0cSt6SzlObDJHM21h?=
 =?utf-8?B?L2Y5blVVUVdETVp6QmVtSi9sMFRaWGgzUWtxN293MnZQRm53bDlrb0krTHhI?=
 =?utf-8?B?ZlU3cnRTTjh6blVISHpIM292aEVWWTJUazZUaGxvWTNCem44L2tUZlZLYU9o?=
 =?utf-8?B?RHhVeCtBa3FRTDJYb0RxRGoxaTlYOFhsVlZzNy9Vd2JCeElibWdadHdqZ212?=
 =?utf-8?B?TVZSOXJDaGZ4aHUwbTVJS29UaEtDRjRlRnlZUDBlTkxaSGhGTVJRSUQrZ1dy?=
 =?utf-8?B?MXFnYnRvU1h5Y1ZnTlBTOEVJRUllWEJsWllWWWVDeGJZM3IzQzhBSW1oZldE?=
 =?utf-8?B?dEJ6bkJYcDh5ODVOUzhua0FOanV0Q3dBR051dSs2MUs4dStUK25uSnJmaWts?=
 =?utf-8?B?UWtHYU8ybWZSV2FpMUNVdGVkbDduVjNEVExPOStLOS80SjJ4ejlWdnpFNlRD?=
 =?utf-8?B?UDJjMkt6WXZkM1NwNWlET0x6R0RGV1o4dUdhZW1BQXdzanQwQTg1VzdzUHh3?=
 =?utf-8?B?OWVPalNYRzN2eGdFRDRCbDhBbk9XZHZMb05hNHdwRjVITmxYL1FMd3EreXZB?=
 =?utf-8?B?dWhNZDZYMk9Ia01DNnZPSjJyRGppSG5IWHU5dTFKajVVcUNHMkRMVm1CV3dS?=
 =?utf-8?B?MGgzb2RVb2d1RStzdXZyc1kxL3J6WHdhYTZ5bGc5bkZ6WThKTUQ3MWMvQjVU?=
 =?utf-8?B?dVZwUDlFb3cvWXlSdkFVeGkrYWpQMVdBaWczNCtyblFPUTh5QWZBNjRDd2tY?=
 =?utf-8?B?NTlKQ2ZsTG5NWktpMGx5VUhVaTUzcFBYYzV4bStuRXpBalJOazNoZXd0b0RE?=
 =?utf-8?B?VEgya0QzVThQYlh6VXNUajRFRzJFRko4SEl0SzNZdDhvNWxoOHIrY0gyNW5y?=
 =?utf-8?B?dkVtc1l1RFBTS2ZiTkM0b2VZdFN5SGQ2U214Q2pneCtwdFhCNmRUTmNnRmZT?=
 =?utf-8?B?T3ZIdGNEeWMzN3c3aWpIdm5DeVNnT3JKbFAxdVJoVXRoUE55VHlHYllrOVAy?=
 =?utf-8?B?aFpBd2hxWjMrM2U1STBTLzc3VW5GeGZKSUw2THI1SVhHMHYweFdqeTl1Zm5J?=
 =?utf-8?B?UDB0MHluUStjejlTUHNJYU9zRmQyMXlha3JjazdZWENRZ2RXdmY4NktvYkRk?=
 =?utf-8?B?TndOWHM2ZW9iVkFsRWhvYi9PdU5SeEtuNk15MEJzOGpiWmFyRzRsNzRpbVZk?=
 =?utf-8?B?TUFuR3ZIWWRFbk9JWk5RSUxpMEIwTUZuRlQzZHlTcFNsbFhkczRGaCtWQ3cv?=
 =?utf-8?B?T0dwSkRUNkJUb0xJaXJTdmp5bkpPenNWNUNkcjNqd3NSRzhVRkJZd0Y4RDIy?=
 =?utf-8?B?QTl5bzgydXJ1TE9QKzdKUG9zWkJubGYwSCtTaERQY1BvbjE2c2RXQVFTUTYr?=
 =?utf-8?B?aUdZOFFNV20xSzVRdGNWU0t0aTU3Q1l4QkVsOFZ3azdNdzUwV0xXTmg0MUYr?=
 =?utf-8?B?WFJ2aForRGl5OHN6MzZ2THZIejJjL1pMWkFJTndDenVWc05vM01GS1kwMHJI?=
 =?utf-8?B?Q2ZBbUQ4MGhnbE5qUm0rVmxPRWMwTzV1NDNId0s3MGh3RnF1T0VFOUVKazEz?=
 =?utf-8?B?VlJPdlpaRjBVQ2xsMk9BLzRJT01JRkNVOWl5czcrV0ZoVGpreHVMSlRqaHo3?=
 =?utf-8?B?SnFIZHlwQlhzcHJmdE9zQzcybVcxTmJ6cXlhaXV1Y01VSE1sQW1VRzlab3Ur?=
 =?utf-8?B?N1hONlVDOVlyVWVadzRJTHl6WVBBSUpiUEd3NzVPWTg0L1RRS2VVSVZZZlBl?=
 =?utf-8?B?czJBU1hKbTAvV2djRS9NWlIvOGpLMzZjcDZhWlJJWFdIcFp3WXNNb01WL3Uv?=
 =?utf-8?B?UVBLNmFiWU12KzE4WGVIOTBSbjZnNmF2Q2hUeVZHWmlONnZuZHdXV1pSb21S?=
 =?utf-8?B?d0x2SlhrZmhGeVpDMWtGcFpjamI1WXBSN3ZMREJmYVVNSGhxdC8wYk5FVk5C?=
 =?utf-8?B?UFRvTlU5bHROYjcyTkpXN0dZcTlFS2tWV0czZGkwcWozMWQzRkkxWXJDajBn?=
 =?utf-8?B?WEhVdlAzcFdKTVVLdVlPbTJpRVBnNmpEWmV0bGJQbERScy9IdTdWUjA5Sndl?=
 =?utf-8?Q?H8OeMczxPzR3oyyS1rFOHeB2hnJZeHbJvSTY8BZFSI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:05.1332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9fb0cd-e577-4785-2e0e-08de5431ac36
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6743

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
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


