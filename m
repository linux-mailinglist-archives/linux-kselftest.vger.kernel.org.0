Return-Path: <linux-kselftest+bounces-36518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A10AF8D22
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B4E565631
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA032ECEAA;
	Fri,  4 Jul 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qKrsDDAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244262E7BAB;
	Fri,  4 Jul 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619320; cv=fail; b=fPkP+yu1LOMH0A3GO2sbwnxeGBqs/pd9jScTUtHUlSLECGlXav4C6DeHckZIMNFl/QxWIPOaPMMjbDqq1LG6IPOGZBJjv40rl4j6vCRZtqd4jPUYzn/CO9LkP/lawY8tkFtM+/P7QPDyg2dCNkg85QgDxQjkDWQ9/szcfGn+Qjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619320; c=relaxed/simple;
	bh=QheIjnkZhAAj/gUXxo2UK5OQhY+fZUG8lLWtSanvv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSosBnl4jSh/UMl7pVLFo+R4e9bbjNazCNj3zpsMat5DFgKMya3geWajPepl1aazBjTTnE66lPnqKIkseO/6dPbsEvVr39vNOHN+ofzWoG7o3A6tfTLmP/Xk6sIJsPgbUMmiZWF6x3wQzF/szz+XP6mAa7Io6VUA0FuGv9EmriI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qKrsDDAZ; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABogHse9oWO368IyUoSVV6jOJPMg0FPYewY03nrQGujLz0YeD4OF6XwTE+j8Mv1XrbRrPFHwSw4bRDoY77pqpovgMdyr7PaRVVy5j81CzKabWAwyDgV/qwetw06ULaY9cBhp3TEdD1pwYRkiBTwKp3cUG4gagJCDvWNbN6/7qRjVbdr+h3laxfFqkLTQUOES3ir0sKiV8xCxyElTupY6U2Z5XmXcE/GWUQ5etEE8ReGTNRHBkT8+LIwoflxbMdrlVJsD8f7Gz1uNs6UaFQod0MGHJ/yWGLdg05Ypxl/ePoSgufD60fxVGKetxzKvBpgSKs6iGQe5K5WSLXT8cGc6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=LPo5Y1/L1UjdK4MJRCk4zbnU+M2gIjQciKXZc5KhUs2lSzEFYxNyQ/dq/04snIQj3RFyywhMTVRlW8ZAFjdNC08LsdYHVUeZ5JVO9CpPyUClts7MPv88sdf60xntNBd4m9rNa+bKf1ZZbIlGnab112a312zdnZJxleiWvUtm1HWogw1cNeQj3MdzZPt0Ky5rt/8HDTZa0gEqLLQAAfmPR6c4FQZ+BHaLd1cjVD5S3ufcBfDLKLTQouMSYkgWgry1ZmFoktddAdLAWafO43NRB5CjkmIUc9C8u/5VD6dWEWQVStxGjecNDNPzCjJXkz3HNabo/bxeHfnsHJIwzzzYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=qKrsDDAZ7YbC8geU8jItDGvEkqo0FDeHGZzLBKTLNhJP58mSBrKxE63+SdUOVdPnnRoKrSV/MHsmLkOLs/jLLptoh5K2iMHk+AYQFGu9lUldlGV5ErXgg6O19K698dFyIBhDwm6gBCQFRHOHlSx2WrmBEFJS7wLa3MZzNdNb2PL0iEpu43UJnhegzH2Lj9wh8eSc+RiwV9GR9vnPdcHF76+f0BzGJsgPGo5emwt8PnUvN/Pl8K8frEay6dagMupF5K3InZEgi/QLKl4Rrge1CTSxK5RUfOdZP3cfYCYdD2PxkziOVv5VQIqEgS2Uf/mSfCxf10stCISztbS3g9oXrA==
Received: from AS4P191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::17)
 by BESPR07MB10747.eurprd07.prod.outlook.com (2603:10a6:b10:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Fri, 4 Jul
 2025 08:55:10 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::59) by AS4P191CA0048.outlook.office365.com
 (2603:10a6:20b:657::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 00E1420138;
	Fri,  4 Jul 2025 11:55:07 +0300 (EEST)
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
Subject: [PATCH v12 net-next 01/15] tcp: reorganize SYN ECN code
Date: Fri,  4 Jul 2025 10:53:31 +0200
Message-Id: <20250704085345.46530-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|BESPR07MB10747:EE_
X-MS-Office365-Filtering-Correlation-Id: d12d33ca-c67e-47b7-c1de-08ddbad87b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVAySjJlS296NXNpVDRuTTNHVjFTWWxUZWpwbWdqV0dPeWNrZlVSaWtrMXpF?=
 =?utf-8?B?RHdMTThvelpVbFRZaDMzZVNSeTg1NG5sUWp5aHk4dlVuczdQdFREeFBwZWxs?=
 =?utf-8?B?amVjZGZoUWhaOWtiWTNPUkdSbWlKUlZ4d1ZwSHlxVzRXV3hHTktiQ1cvQjJW?=
 =?utf-8?B?bG42bStXM3lvSWhPcDNXa1ZzSW5DeWxYOVVTWnpwTjIwTVNsYURFNC9mSXBm?=
 =?utf-8?B?enZGMGF1YnpxTTZWd3VZM291MVR4azJkWndHLzFZV253SUVsWnZDRng4TTc2?=
 =?utf-8?B?VlNLTEpsMC9jTDF6bHBHdHlIWnIwbDZJUlg3a0xIYWdzVkhPZHBoc0F4VFcw?=
 =?utf-8?B?M1luNUtkUDl2amVWNHlteEFFU0E1V1RHYmZENWhiMWozcllCSUh2SGFPWlBm?=
 =?utf-8?B?RFhXbEtValVUdTIvQ2xqOUtRa2d0WURscWlNWjhibHB3cHRXd01mTnY5ZlBE?=
 =?utf-8?B?bXNwbHV0bURlY0Z5NjNMRlB2NEpVZkkrTjc5L0hBUURNbjh1dGFvOVd6S1Fx?=
 =?utf-8?B?cDY1OXYxR1M5RVdGd25vNG0zVmlSWUIrRnNvWldBWmF0Z2ptUlZ6ZHBpUTNQ?=
 =?utf-8?B?YjZhTThveTVPQ0JjaEcxQko4ODNta1g3aGFxOTdya1B4dElzV1lqRnE4OTFY?=
 =?utf-8?B?OTJyemNtcnF0NHY2UENqMFNDcmovUXNwUCtuUnZQSTh1c1lVQUR0WktUQzNH?=
 =?utf-8?B?Y3hTVnY1VkxOK09Gdks3VlpGcnNoTkc3QXVPSlV6RkZHYWhPWTVGNDNxTEMv?=
 =?utf-8?B?ZHlFdENBb0UwQ0JSdHFnZXlnbTlmc0c2cFJMTndFUWFyYTVkeU15KzF2d0tZ?=
 =?utf-8?B?UXFBaEEzNTZGaHRVa2k0aDd0NUt3Wno1RXhVZHdyMXVYYTliWFJpWTRhQkQ2?=
 =?utf-8?B?cENNUWNia25HYVRGMHQyME53ZlRkdFh6T3RyVERJWEdUbDhscVV5QUY0cFJT?=
 =?utf-8?B?cGk0NUdIU01USXpnVXB5Y0RMbnlOdkdBYnVkbURyVEY2T2UwK3pBRXk3WTFm?=
 =?utf-8?B?WnhIY2lKMGw5VXhOUlhOM01GeElCeXFiTzRjUDBVc3VtMStEQWF6eitsc1R6?=
 =?utf-8?B?SGdDZUhvTnRlb3dJRUd3enZ0b1JUN1poYm5KNC94OEVqRW1oUldJOUNBZXc1?=
 =?utf-8?B?ajJzaForWk85bE90SzkrdzdGTTZ3TnZiaVFFaUhuN1RvQUxiaDZZY3Vyai9t?=
 =?utf-8?B?QnVZWWMxSDBORE1DdXlpWEVZVWZQMGxVRlhjODg1UEpxenlIN2VpMTdsQzg3?=
 =?utf-8?B?Qm5OL2F6YU5DeEg2TERPLy84dnd5c0Q3bldzblZIeHI2WkdSdk13Njhxck9o?=
 =?utf-8?B?SlRUTHRiRUNaMm4wbE1TTTN1ZGg4NjZ6VEEreElDZTk1SDNma1J5WlhrRE82?=
 =?utf-8?B?Q3EzVHhiT3VkRmVKNm9JRG5JcVdjVjRJQ292ZnBKZUZmU3JZbHhlUWQzMnQ0?=
 =?utf-8?B?L2pnV1Q1VzVkbXROVjl0amtYdXo0QWNQVDczUlZvTmJqdWF3UzFreFNkZEtO?=
 =?utf-8?B?UXZjWEZWOHFrdG1YTkRSaWgvQWFZWkZ6QnRrZy9tOHZQblZuQUphU2V3MW5L?=
 =?utf-8?B?blRhVXpzZGEreVA4ZGlvSEkyOTFQQlVITjdFVlJqMDB1MWFXa0RxSHFIejdW?=
 =?utf-8?B?cUd1VDQwRnZPZm9kSGJRZThCSUdhUTBpY1k3RnBKTXk3Y3djczBXbStUbDNi?=
 =?utf-8?B?NEZ0cllWTHVZMXo4ME5kL25nNUFkTUVKREc0MGx1emd2UHVnMm5qTmVrWWlr?=
 =?utf-8?B?LzJ6bXlLbWlFYyt4VjlKK3BZOENHQ2tMZ2pabWJSdkcvU2ZPS2ZlamtyOE1s?=
 =?utf-8?B?R09sV2tNZVRnT2dsSVBLNFpadjFzNCt3ZDVCQTRmck5tdWlqRWNUdFVWWDRT?=
 =?utf-8?B?cno2YzZFMXlxWkNoWVZkT1R0azJlcERWQWVreW02b0N1Q1hjK1hSaUVacWxs?=
 =?utf-8?B?L2lSakVVcW5VQlN5UEo0Nm5JQ1pWeVFmbjU3NDNtNVRQWTY3Wnc5eHl2bmE1?=
 =?utf-8?B?YmU0SG9zYVZ0MGVHeGV6ZUdBTm9RamcvTUZJb01XQ21YeXhLYVRPa3NUTkdF?=
 =?utf-8?B?MUdjVnk5cVVGSVMxZXY2T3Z4bmpOcU5xd3pOZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:09.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12d33ca-c67e-47b7-c1de-08ddbad87b02
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10747

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
index b616776e3354..caa980c3f25a 100644
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


