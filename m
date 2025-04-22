Return-Path: <linux-kselftest+bounces-31310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2909A97135
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FCB17F9D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374A28FFC7;
	Tue, 22 Apr 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MMH0gFsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DA1A0BD0;
	Tue, 22 Apr 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336290; cv=fail; b=py7sHYObJE/kNC/687m3N2FjZ5JzNwU+rEYl7J+qmy+TmCubXGacNmjizfbJ+V6cJpF4Arm+x76F1X4bSoCfWw2yvIS0tN6EJkZk7VfFogdEoooinfN6aaBZoPAggWUKhkV3tF6Nn0jmJkuTTbCoGDaucwWaXqeCZJY1qSksVOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336290; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnKv5gW8ClZ04lNHCq6HfCDT+CPu3hdXu+RSa7LOzWVbV6G6RXSIPobtcXEoVExGQokjdMb88XIJGuRJTMTV3QfrjWwlPwGLkZohA3QeD6kQE3r+bJLCTOEV4dk4XvWDkNAWTgDpdZLfvQ+hdmDjDVLH44wOO42iJ7O13SN5fyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MMH0gFsk; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amnbmd7CyNRoXiSfJHQzog6bQU5UPM+JXTEfUhdFv+qmm2iODV4M9Uvkd3XDU31OpZNjSn0kvqHXDoCpEohJG5UfjBMppnc+xYTFVl1TDFbhNZDuuX9faGSRnunijogV3pTb2LyD5LRyn85nb+JzUkQiXf3m0DLzsyDhnAWOctDDXE86mQ2CrP/EQlkq5FIBZc48RtBxvWWOumV8FNSTEraXmh6Ks4QgP1Lh7CuCmR3jVe/rZKSLp91S4YKu5rtCvI2eeGqyUIs/9/JrolIQm2UxehOjvk60f47aV0Zh1rYIJdOq4HQs+78e/0yxpNFuQjJ1SDibLYzkLEnzilbeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=iKPywM5omG6rRH4psNBqHfAQRjhDxCRaYrbCAtzq/zagYtCMRdQk1YDPGl35Lx27SBUCs3/Rj3aVYxjVFx5vSJh+QFrQnOaPpleBPCozOK15Fg1Dqq0fs9O88lEX4th+RqZHII5KczHGZlFRR/6WJjVcAMBqsxug3ILHfveB4pJBk1l+JDyJA9wlRxeVZNcuWehkTDFyMH52jxrmjc3iWiEfWfmCIm5K+/MP+mBViY/jAED2E2kM/VON87yrCHAJciy8wwmPgRVDE3quGNhVBMdOxTup2wDnSo0kD9KjBgrmQFxwvg1t8zfZ2oFoYbaU0zLnTL4+gfRTQ3LgcEytvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=MMH0gFskcyC0bacifT227znmLWsmQbK9kxKbifDqQOBqvkVSi+VIlRvKFSwUADow17RSV2UpHoZxvT0jxYWu6Am4hjSoCHMb9a5McqnIJSj6M7TaYJP668jG1jIqJMO8NkU4n9w4lOTr5ZA41R1WIyQN9yQfU9h/mKMIftQ8KjFXBHkgGC4l01Q/CNz/MHeZ/5WK+QLIXjBw/X7B712/1SJzmxQ3ieZprEvEIDU9XHs4va9iGgT0SW34RuZvBSa/7NI2BmDsNVDuxVibykP8RO6VewFf8oiqpUkHqhbkOYSdddCiShF3QvQ/erWQWJ+KZdJfYUZlAEoX24Nhno6HZg==
Received: from CWLP265CA0441.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::7)
 by PA4PR07MB7424.eurprd07.prod.outlook.com (2603:10a6:102:cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:38:04 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:400:1b7:cafe::63) by CWLP265CA0441.outlook.office365.com
 (2603:10a6:400:1b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B767020A3B;
	Tue, 22 Apr 2025 18:38:02 +0300 (EEST)
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
Subject: [PATCH v5 net-next 01/15] tcp: reorganize SYN ECN code
Date: Tue, 22 Apr 2025 17:35:48 +0200
Message-Id: <20250422153602.54787-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DC:EE_|PA4PR07MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6408292e-98d1-4602-5603-08dd81b3ac07
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dm1aWU84RXpzdVhYdDNlWWNnN1lrWDRxWjlxMHMvRFRDYVY5L3c5NGJIOUlW?=
 =?utf-8?B?RnYxK093ZnU4SFptQnYxSWlnVkgrWVFQUDRIZlVzUlRFb1NTMDl5dHZUdC81?=
 =?utf-8?B?cDl4U2czYVlsck1mL0JONmREQklpcTRDY0hVNi9FQ0h4T3hIc0NDcjA3RE4y?=
 =?utf-8?B?NjA5OFVocWdVNldnMzhwbVh0d1JPUTUzTkMrQ2ZETFR3Y0p6UXUzeUhrT1hU?=
 =?utf-8?B?cGZkS1lmeDJqNmhWNkRRUmQ5Y00ydnhwdXk5ZGxnaFVhZStVVWk0aFpSUE0w?=
 =?utf-8?B?aWxaMWdLL0VmTzAxY0JDcXAxTFJTY1hkdWo5aGVwNEt1Q0ptNmRnL3NHVVZl?=
 =?utf-8?B?ejhtUktySHFDUlNjY3R0a3VtKzN4aXNqUUtQWGEvOUpQeXArYmozNElDZVVW?=
 =?utf-8?B?WjFMbExUNnFBNWo4SmY1c0RhS3pVZWxsbE05R1RsTXR6blhNT1pTaGZ4MTlG?=
 =?utf-8?B?aGtiZEFXWkZYbzdxakN1UDc1bzgyTlhJZ1lKQk5hRUdlejFRM0ZhTGM4bDZ1?=
 =?utf-8?B?T2JlNTJWOXhpbUQrUVlWdXk3NU8zSWlUK24yZTVnRGtBZE05UmE4cHI5SFFZ?=
 =?utf-8?B?RnpiNVJwREMzZW8rb2d6Qzl0ZlAvK0VKZ09RSmg0L05FUXI1eEdLclZOd0hj?=
 =?utf-8?B?eUJnR0d3SUN1RkRkb293cEMvV3RsbkY1Nk9YS04vYXoxbVlHdW9LRTQxeUVa?=
 =?utf-8?B?MGNPdU5acHRkQmFVSlUzMEpkSG1wWXl0WXNGNk1BSlg2b3ZMQnFrTUhiMTVv?=
 =?utf-8?B?cVdBR3h4YjJpTXNKSC9FNy8vd3loOFM1Q3Mxa3NKSmdxVFV0N25OK3NjYkVi?=
 =?utf-8?B?M1lyZTVUZlhHcHU3bXJUSE4xNkt6UlpnRG5SOGFCU3o4dm9wODRpblBtemhE?=
 =?utf-8?B?TFFzNXZLdjFUbW1wRTExc3RkUmltMVpNVFplZGlZMzFSb3NoK28xQlpCa2wy?=
 =?utf-8?B?OW5GZ25lRGdWelJBNzd3ZkVpTUIycFBDWTEvYmthbmZFZGdOZ0paZ01Fd1Vr?=
 =?utf-8?B?Y1AxakFrN3RWUHBtZkltclhPTlJ0Wk1oZW9sWWVYY3Jvalpab3NYY1dITHlo?=
 =?utf-8?B?ZHdDcjlHcENNU0t2TVBjYzIxSTRqU0xRODRtUlgvbjA2MDJvR2E5c3NRTnhy?=
 =?utf-8?B?QWkvdXd4VjRjNUtyTWtrWko1NFBHTFBaSlhNWVJGdXlpb3F5Y3RiM1NvaHBI?=
 =?utf-8?B?TUtza0tNa3hsd3NWemVaa1RHR283ekVqMm96QjdESVhSYWd1ZFVkd0M3Z2pI?=
 =?utf-8?B?M1VyeDZVdStCZk9YSFRwcUlIZjZQQURrUjdEaC9CZDkxT1NKQ2JTUWNtdFVT?=
 =?utf-8?B?cGhuODFxc0N2Q2dtdnhsVFJvdzVVdldlUE5iTlF2TWxtaE1yZndiUkVzcDI2?=
 =?utf-8?B?cWlseWpZOXN1ZENNdWpkeWRQclo4dWhWeWc2djVyQlhLcE5jb2hQQk51ZWlP?=
 =?utf-8?B?MDNPcXVUQ3VJOXNKaC9GdnBrWGt1NzhQVm5PZ29iTStoTHRLN1JkalNZbDJz?=
 =?utf-8?B?Qyt4VUlMV2ZuRXhod3dXSnNhck5hSUFseFg1bDBqWFFPSnQ0L0RPQzl5NnRQ?=
 =?utf-8?B?aXUwVi95Y09JYkJpZzRiQUtiU2hJckdGRnc3WUg4amRlcnFPZ2FsOS9NK0Fz?=
 =?utf-8?B?QzZaTHhKM0E5ZVRxcTNkMlhGWTluZ0J2aTRKR283dXErZ0xXOFdkQTNzQllt?=
 =?utf-8?B?aXhVNmc0RHcwc0praTB4NmZsV1ZMZHI3V01tcktDazVQRlFxSmNPZ0E3RnFp?=
 =?utf-8?B?Z1pyQXJ3WjRHd3VaR0VxemkrT1IxSHBlWlhjN3l0QXAxclM5NWt4amZ1a29n?=
 =?utf-8?B?cHJXMFVkc2lyNUM3cksrb1Y5aG14NEwzTm9CN1AwYzBjaENiNEhJcXB4c2pl?=
 =?utf-8?B?Y1RUOVUwSEpUOFUyVWVPemQ2SUxXWHM3RlVYZ01jRk9uNHhPdmszeEZZeW8z?=
 =?utf-8?B?eEhnd0hOakNWcytjWXJNSWNMUkhqUUV5cjdtVUY5UkhPVnRjd3lFYzdEWkVO?=
 =?utf-8?B?Y25RS00wU015YWsxOHJlNGY0K2FNc1EzbjVSekpzSE5HWThsc1VjWnNTRU1l?=
 =?utf-8?B?NDZPKzkwUlFZelJHclBYVHU5b1ZOSkFrc09LQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:04.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408292e-98d1-4602-5603-08dd81b3ac07
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7424

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


