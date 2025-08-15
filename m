Return-Path: <linux-kselftest+bounces-39069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F61B27B4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3719CA21570
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BDA250BF2;
	Fri, 15 Aug 2025 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PCg8YiWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355A24886A;
	Fri, 15 Aug 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247186; cv=fail; b=InEI//fq8WpZCyS01xWZAJv7mywBK/5UGk0noDaWJUiV/ezI8jhywJl9luRJLcT+PvP/pMRbdx5EIE8nqhbtX5xjO0g2KjUinfr8/mXGjAvz4f3qYCYzW1Kx/nBt5b2jSVhKKHnLEw1jaQ2xxmr9Fl1wc0HuGVEZOH4R4XEEuts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247186; c=relaxed/simple;
	bh=kst17emt2tBQFLUPREzre3JYXU14RG+19cKk8X3DB2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bdxjs483+gr3xbOH7aBlse0ONG0bQUopjWCGq1LJjz65Wd5EMYQIev+bB4PXWjcbc3s/PlxdYwWmT1+kJ1LZ7pjLegp8tFX5h6aDw0v2PY4Y+5uMVEOYbTUQgsNoIO6ctZ+3ixJ+iaoz70pZqq1HycspiCh8wO9uKbKlLqKMTok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PCg8YiWr; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5jLDVUa4UK3pv65DXkE+9NZrZr2QxPLBz2DF0f19MkONbTUrBoqasIQIVlEL/9SPvOYCvl32zdo36ejLD4xGqrEVP4zOT4MDchbZhw4Ana9IKNqrphmD3MLctWidtsKiimXOXsiPKkmt6Px8kzo9SQvXblpNQ95CkUx17zm99ZRqj8SJT42DUv1IusWNCeLK23oWxlnGoYVHrt3wBR3CgyFcpMpFjA1sYOq41ScqX0X0IW4MC1CONcPMZzkvtEpWlTFTl1tNMncBBCL47ddU4eAh09NlqrrPpwPTLiIYsJ/7TWsydbWck6YBWBwShpkL5wqvzTuLUujsdreVJlFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K57L8qqT/vEf2KB8+mXvPpRIr9K6B+2WHYaCRdTa4Xs=;
 b=oYgW6sZ+YtjlRU7oIAd9N1woPqI1E1eFAABcnSFtujNcMmuMV5qMAaTZtHSUhch57nR5jwJStfBr8Vo0ZEDtSzX3rkGIpHy8EQ0bnkfa2E6SElNLrFk8Ne0g1kr7qCWpwkZbGNN5ewrkq/HD6OLvjwAuBvBDR7rAgzjPI80GUJI9RykH/ls2n63zZ3rXsVBRBXvFaF3WtdUzz0gom8JzddDE3d5NRg1kfgR5UMUPKZxjm9Q6M6ffQMpV6i5Sl1IX60AuBICwEkRKmb4r6fi8jcMd6TvcBQkWqfYcIp17kpyoX2oDBEiXRt7DohV05iskgMDAbB6GNYRNjAl4NercZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K57L8qqT/vEf2KB8+mXvPpRIr9K6B+2WHYaCRdTa4Xs=;
 b=PCg8YiWrgXhl8jSfGEWYBtmFdCXdcqU5e5vCzOXGwsaXIjUWILd2dJ1ybS0NFc82Rw9DxmvFrY65HCibJ2Htwh2hVFvyqzGgSUW2MoYDiMrWsDbAfGmldGWGMbwQ/3q3LN/9uuMbzc4kxV2PdJ7A+e5XhJydEvuIY5OW0wbXKcARAWdQTdSLpsWY3f6/pXmkm1N4QdBKd3BihZdgln3pS/n6ik7Q31kGWNrR9CIZGBQPzxALO1zQDI74wqWuYvjcwDFMR2kPi1Cxm0EZ+6eVhR4IXLGHfkCfa7UcMg0X9URv1XN8KrSxJVKPAGXd3xchtog2a1Qv8EW+YWRP6P11qA==
Received: from AM0PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:208:ac::17)
 by AM7PR07MB6849.eurprd07.prod.outlook.com (2603:10a6:20b:1c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 15 Aug
 2025 08:39:41 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::c0) by AM0PR07CA0004.outlook.office365.com
 (2603:10a6:208:ac::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 08:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6C9151C0010;
	Fri, 15 Aug 2025 11:39:39 +0300 (EEST)
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
Subject: [PATCH v15 net-next 01/14] tcp: reorganize SYN ECN code
Date: Fri, 15 Aug 2025 10:39:17 +0200
Message-Id: <20250815083930.10547-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|AM7PR07MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d761575-cb26-46df-d6f8-08dddbd746ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0FZQ0hNdGQxclJrL1J0OGJyYmtDcHQ4dlZ3VTVjY2VGTG5VS3FQOVp6NW5C?=
 =?utf-8?B?czBtVUVUckFqTkt5NmIxTVVJZFZHRzk0VlM4R0VMOHZCUUJUNnVtMG5RZjJv?=
 =?utf-8?B?dVlHYk04eFZTTzM3bmtIVEdUaVplbm85MlpXbDNWYytHVXdmVDVoMDF3WUVT?=
 =?utf-8?B?SUo0czV2eG95S1lKWE1MWWQ1UEllL3BFMVMwWXJtREUwZlF2SGhoaXRYaE9B?=
 =?utf-8?B?cXB4aXpYTTRaanVsTVZuVTBCMzJ6RnFWRlgybWFsT2VUNmZ2L1pVKzFUUDg4?=
 =?utf-8?B?eUsrRE9vaFIvM3djRTVVQldGM1ZOc2FScXpDczVweCt4bXpXS01nWVp5bktv?=
 =?utf-8?B?MUNrQU41RmhBQzlEemVIekZwTVdkL0dXdnNITXArZ1V4K0Y5bGJCSVpaeHp0?=
 =?utf-8?B?VEp5SWxVMllrMHpDbjlpcXozSWJJbGlpUEZIWVdRdzFFV2JKdUVpNlJMalFl?=
 =?utf-8?B?YUtZZm9QdW1ydU1DVVk3V0QxTjZ5RWNnL2pOMUxIaWlSOHNEUE9VMHZkY0NG?=
 =?utf-8?B?bWZTaDRydmplVDk0T2lYMHpRYU4yRHZSckF1T3hiWWpYdDBkMzA2ZW52UjlX?=
 =?utf-8?B?b0ZRVDgrUWZURkwyaEJvc3JjUFRQVzFudkdnREhldkpSN0dOSkxMQVE3Q2Fx?=
 =?utf-8?B?b0hoU2NyV0NWZ0p3SmN3Y2oyUUc5WWhpOGY2QlJqKzZYeENNbzF4eVBwWkJn?=
 =?utf-8?B?V00wZTQzR2RYYTRMKzNTN1ZiS2phMkVIdG52Z1B2WmhHUjNEaEF2dnF2UnIv?=
 =?utf-8?B?S2tHbnVhSGU2dUNRTWRwRWJ1UUZCc0NGRUFmZzRZMkR1ZVozeFhUZjFiaU5P?=
 =?utf-8?B?Um5qQ0g3RVVkWnFYUmQ1Z2pMVFliMk5KZ0MwME5pTUxSYmNuNXZoN0RQc1Nw?=
 =?utf-8?B?ZDJTQVpsQXpDeGd6TkNXeXRjZEFSc3BOU3MwOGVXNGF2d1NwWGhYL2tZZ0Mr?=
 =?utf-8?B?T3J4MXc2RS9wQkJsdVI4SnFadDZZcDNXVFNLakNzaGVvZjhuR1l5dlpoNlRH?=
 =?utf-8?B?c0FwQi9tZmg4ZUxtZnVMUVZkZW9GajFhY3I2VDdsNTFab1cxMFB4NXgvRkhj?=
 =?utf-8?B?LzVqUksyTnMweTRHOCtFeUdmd1lQLzFST1NyVHJZZEttdFArQ0pRZ1VrSW1G?=
 =?utf-8?B?R0xKSFRvMUt2YmFSK2VaVzFyOXArR1JGV01kRHNIbC9RTzM5KzJrT2tGdlNV?=
 =?utf-8?B?bWwwcFF5UDlDM2wyVFMwZXdHbWRyaGZ6a3VNTzd1VVhtT000SHVtYlM5MHpZ?=
 =?utf-8?B?V2psZnI1T3VSWDJIWEhFQk1vQnhaYTRwYmNRMGNGNm1YSG9raGJhcHhVMW40?=
 =?utf-8?B?K0I1MytwWTF3VHUzVWxLNmZWVVpTU3VSaHhwZnpvN3ZsUW00VWF5TDFEc2sx?=
 =?utf-8?B?ZDNneHFaNmJrWkwzY1VtSVc4MmUrR3gwUDQrU3M4M0d2Z3lVR1FzQ2FleEdS?=
 =?utf-8?B?NzFwaS95OTJiOXRkdHg1UEhwWEtQTklsNWFPUzYzNFdpMTlCdGJzeThjTmdD?=
 =?utf-8?B?ZGJvUXpzb1VDckRMMnBBTC9iZE1sOGx1NkhpTkYxeHYzaHlrbWQwb2JMaWFJ?=
 =?utf-8?B?WUtNWHNQenA4dVV6YmpCVHE0RWRRMC93bWxVYzFnalk4TVRIa21IdDVpb2Na?=
 =?utf-8?B?c1JSa2JGeWRYWUxsNkRGYU9HcUY2NjBxeXNhYUZKQ1htYUpTUldON3dtQ0hQ?=
 =?utf-8?B?bWR6SVFtWTJWOXZsTXEwK2Z4cGlDT2JwamtRVUJEV3MyYTE0MWM5UlpyNU5B?=
 =?utf-8?B?amduUUE1YytXUjFMeDVSTW1sQ1pLRnZFdTc0NEZYNHMzSzJMd05sWFQxblFP?=
 =?utf-8?B?a2EzWE9MczRNbytJWE52MlNhM2RqRzJ5bDFtUVVHOW56aWlzWW9QZStqbEhB?=
 =?utf-8?B?RXVQSTlRL2FiYXByek9oSFRnN0h0cXlUbmhqMXNob3FkMzJtSFdDZ2ljU3I4?=
 =?utf-8?B?R3BVWXNoMUJId0FWTzFId1N3Nzc4ckliWjZkMXdtcTQ3THZxTWlrMzJDSCtx?=
 =?utf-8?B?NHRQWlJ6SnhWdVMydmlXLy95RGFJaXlXSUNodDJsVHB2bFZTQ3Y4akpXWjY1?=
 =?utf-8?B?WG5LZTRBeXZuM2VVSnpCREtzTnFrRGtPbWl2dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:41.0066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d761575-cb26-46df-d6f8-08dddbd746ec
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6849

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
index caf11920a878..b1ca5fc86239 100644
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


