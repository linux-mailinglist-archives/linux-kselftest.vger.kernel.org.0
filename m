Return-Path: <linux-kselftest+bounces-32935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD0AB6D78
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E1118980A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4527AC39;
	Wed, 14 May 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rLgYvlLn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFF27A465;
	Wed, 14 May 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231013; cv=fail; b=PuNXhI9LbhyusOK+/cZuQ53r6GCz4wI2Cq+TTZzOvJi9Xm4bHBbffkHkce3fCWMQpjgnFVo9nwP+pBI+aXN+ssMn0htmnsIFK1502wbI5+trPmhA1W6cdAS3rdY5maDOdJVKBiOd1FbCLSud3BbJZ57PuIo/53MRWPoSscnRiL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231013; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVFSM4wB9FN6qQy0UMpbXEojmONFy1CemD7kqy4jLYgBIVGoyXADaC/+qLcOgZfdh99UWac0zM7qvvBfz34HBJV78tPKQ+blN3+ADLblDxwPMCfqyKNCi8uYcdV1TqbcS7TOC56V9tiyYYy+MMqEjLJvbFWtAzNFTNJHycGGE6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rLgYvlLn; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daTvxasa0sf9HwFuqPpibnN6CWWyCQSF4zexmwsrVZ+lNgFNxr1kGlNtu1CzKtiAhR/XRgjrOOxIf70p3Fdw1vTTAFclLtdrGT0RsGOLIPhBBzNSN/QfPHtiybKn9uN0sTqaMslaaE9NwUv2WtEZ91mFDnXJ+A9kQJyX6bSkG7xiPaphofWaETes6Jbo60sPNrjAYWRzYOWs5uOHzVUcgv5MnIHxr4su1BklqopezHhkogn4a4QUrATr3Frwo3tTbhjM2mQSTqLDKqiY9HGJ1pBAIdTMvVWd4917MU46yq1AK15aIrNx7GyuEpxeCRMY3bAI4BdPQYrWE/qLcn0I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=xl80tEDQYfOqbxA/EPgKeRufqqEJnV4mXN+yKUut6W+fjWxr5A9ZbVnr9rdyCkygX3+YRTbXQXktlYcRSmEB7lVEpJTBQtkiYR7V+oDr2/J7lA11tIZJBe5o5ebdhXy7TGQTw/DUEsCqnBRy2iXWQHZ2bXBT4D1qKkBu+ZHxeTFpMKwqa/mDzXAmBQyBFKoHXRYx1k81mwWFv6ZW/8e44auox+QjWGUlcxxxSAXgnUMAzL3Mgk2t5IZsWb90koskKvcwFBDDLkF/G+eNmh9Z0SpvmlEjKUJCkpOKXOyJxiB6MQAIg+Qk4rrKA9yaRkP9nCvZi3vZhFH/aY5ebHqWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=rLgYvlLnxG06HInm4/CI3yhhgmB3uL6/U+xBjuYMCqOu/uRatC1Rh8j+GSzv4O9Ku8/xbi6ueVT8CSID3Rnb4I2aiZaPaBL1TGudXYc8YyC7ObJUagTiJYT7KPdvRV12IVH57FL7YqpIrnrErKR3PQLxTcqrVo2RnZwG/BLUb5+DwWjATiBu61FKAHWkFyrcRc0DHtcJqghX/dKaPva/YqugAX3DvuwYA0Ne8HmU9i/0702W6TQEWFCZSqSjrcNjw5zz1iV7ae4onw2MbTnnCXPlMBO5uuoC0SzmToxCYtQKEJMTsAePTBmHFXmU39Zwq2w8v4O/qiGXnu1zKAPc5A==
Received: from DU7P194CA0010.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::13)
 by DB8PR07MB6394.eurprd07.prod.outlook.com (2603:10a6:10:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:56:47 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::90) by DU7P194CA0010.outlook.office365.com
 (2603:10a6:10:553::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:56:47 +0000
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
 via Frontend Transport; Wed, 14 May 2025 13:56:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 339822009B;
	Wed, 14 May 2025 16:56:46 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
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
Subject: [PATCH v7 net-next 01/15] tcp: reorganize SYN ECN code
Date: Wed, 14 May 2025 15:56:28 +0200
Message-Id: <20250514135642.11203-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|DB8PR07MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 46520629-f505-4ae8-942d-08dd92ef2b5b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bFRaTmpGbjlaeGxHendpczdsWkZZTWFuNUU1RGszeElnNitDRVF0UVd6MXg0?=
 =?utf-8?B?WHM3QUl2NEFLQU8vSmJTUVFia0hnM3JhNGZyeU9GeERiZDFKS0xYWGdCU2R4?=
 =?utf-8?B?OGE0dmpGaUh4bU0zNk1QcjFvdWJyOHpXK05QeXF2dTQ1YUx1VVFUQ0dnM3dJ?=
 =?utf-8?B?VG1ONVFmckJvMTByVXF3eGc0MUtWa1BpUTFoMHIwR0t4Vit3c1RrVk8xaGUr?=
 =?utf-8?B?V2hGQ0gxQzdmU3RvbEt6WGJ1NHc3b2oyM1ZPcmtaUm52dUsrbkJpNUgvQXFG?=
 =?utf-8?B?OW9ITnRwdnVwNitnUTRodjB3ZVRLc1lZa0p3YnpZeXBDWWsyOWtUVy84ZGVS?=
 =?utf-8?B?L3QxekdXSDJPTnVBZk9Yb3VyWEg3cHEzMmQvcHBQME94NlRNYzNiMkp0MGtq?=
 =?utf-8?B?WkE1T3J4b2R5UXhaMDdlWHZHc0JkWHovTU96Q2ttTjdDMUZZZmEwR1gySlNu?=
 =?utf-8?B?Tyt4SVhxUmMvb3dKK09DTS9PeUZwTFd0MDVCWmdoN1piRGszNExTZEtoNG9X?=
 =?utf-8?B?REx3L3RkS1J1ZGVXMTBqNitOWjlzbGo1UFc2NG5hSWU2RXZrZzEzYUVnYklN?=
 =?utf-8?B?WEMrLzNuRE4vdlJEMlM4ZjdLOUpxaFBhQjl3ZDNTdGRHUDlYR0VPOUNDMTJB?=
 =?utf-8?B?WU9BQXlPam13YjdBRWY2eUZqT3YzNmJ5eTJWRGhtcnhuK1hubEVHYXpUVVVL?=
 =?utf-8?B?emEveEhUUzN4NjlXR3ljK3M1SWJKQ1BqNTJ4b2NDQUd6VnFzSHpzdXhXR0cr?=
 =?utf-8?B?L2xzUFNXRkFqMDU3eU5Md2NBZ0tZMzUvbkVkZ1c0bjZLOURUV1liWk9rNzh0?=
 =?utf-8?B?SEFMTVhnVzNSVWlScVlJa0ZEOVpURjU3MnRzUHB0bFNxZG9CdG83MlJVVFVt?=
 =?utf-8?B?UXdBL0F0dzRBcDMzL0huRUxYMVJaZDV0L2hJN1A4OUFxL3hSZEdVeWxJUDZC?=
 =?utf-8?B?MVNOYU5wL0k4N25xRi9uSWdJTHFNQ1F6V0diZnN5U29LT2JaS0V5U2F5djF0?=
 =?utf-8?B?QUVITlR6aTFNWitpNzFPVGNEUUdPcktxemZ6TmJWQ05qaTlkNXk3dXZ0UFVF?=
 =?utf-8?B?V09RMWR3VlZtVTZBNmk4K3RDYVFTKzQwRHlsSU9IZGw3U0VoR1cvVTVGdlA5?=
 =?utf-8?B?ZDcyVUZ5akttWTRMaGs4VnVCV0o2blRndGdvdjd2UW9vZEpza1V1eXh5TEFO?=
 =?utf-8?B?UzZTclMrS1VUeGtKS09nQnJ0M2lnbktMNHhvb1Uwdi9QSmJXTmV1WmVmVDdK?=
 =?utf-8?B?ZndPMFZ3TC9rTnBOYlRVZG9kSVlXYk9jZHNyZFQyZHVHOFkybmRpcVFwUXFl?=
 =?utf-8?B?bFN2WGhEZlk3OTJLRWtDTGpXekRjc1ZRa0Rid3FIVXlIbzJVOGpLaGNPTnll?=
 =?utf-8?B?MkFMZ1pvUE5jZVNJdjVPSzdvNjI4WnJBYlVvQXFHOVJ2TE1qK000V1pOdFNx?=
 =?utf-8?B?cDg0aG8wdzdRNU0vMTk0ZCs0dG1aS0FFMDlNWDljRHdnUHhaaEl1Qm9FRFZT?=
 =?utf-8?B?ZWJKQVZSKy9JWDhrQmFGNnV5NFY1Q2tRd3FCOEhlYzBpZlNBTlIrUVlPTy9D?=
 =?utf-8?B?ckl5bWRUMUwxVUI5U3ZKeFNFZ3VlVXVCNElIMnNxNFJqTU9FaFBhZlliWkd0?=
 =?utf-8?B?LzFUSXplWFQxcFBidDdjSTNMZ1JDVUNFb0plOEdMQWxoMnVmS0FqRDdybkVC?=
 =?utf-8?B?TXE3QW4vblV5Zk5NdEFBQ2hGV3NicFBSWGJRaTBrRHdsbEdnWmhMajJtbTZs?=
 =?utf-8?B?bFdLeTJ1VlhQdkdkOXRBRmhUaERSYmkrN3NEWGRRaWFGMWtkeUt4L1hFbEFL?=
 =?utf-8?B?K2ZCYmd4eHQ1Q1BiL05vTHRHM25TTG9PbEVlM1g0VW92c2ZNYy9YQmM1Umk3?=
 =?utf-8?B?c2tYWjZiZkRRa0dwYnYyWi81UzN4Y2E4OWJINGtzTUlydksydnViS21iSnNO?=
 =?utf-8?B?Mk8yT2ZXNVFpY21LZEVnczhaMDhEWmFHTDU4OVhTcDEwMDRrYTJQZmJwbnMw?=
 =?utf-8?B?Z2xweWVNMDFzTHpERGthQUJyQzZuZ1JubTVCRm9LcVdZKzQ3ZXIyamY1OGE0?=
 =?utf-8?B?a3FSZVNLZDFYOGE3cllIVUg4emJZR0gwY1NHdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:47.7937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46520629-f505-4ae8-942d-08dd92ef2b5b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6394

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


