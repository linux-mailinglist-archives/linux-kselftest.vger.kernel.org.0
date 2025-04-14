Return-Path: <linux-kselftest+bounces-30688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C2A8815F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23717178672
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEB2D3A8E;
	Mon, 14 Apr 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IE4l/LOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925DC2D3A8A;
	Mon, 14 Apr 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636441; cv=fail; b=BcyKOP6r3e0DduhKm1hvhQytTnDar8+WemcCvorspiGDqPvAxcW1qM5GZizzK/EaI/S0U2HmWXH3IrLin1Gf3mkEtrlRwSh3HIBx4jouIdwRiLMGhUOSq77JHFqTvIlMFd9QAurOVxHnjv0uMUqPmpKoY6Mt4a0YPApQOCoh1D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636441; c=relaxed/simple;
	bh=PYyCXUuKVKRWlC5fYTcacULQXbuy70otEK62ZKgXQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyFIav2nyQ7gicSqJNNgPUCy2PEbXFqHoC3pFpOeo4dd2M+q6B7ogSC3/fWl7oQCI4wP4P3xlGaSOLuWUo/8UWSc1unQFmnOr7rzzJo7f95Rc1cADSABvi0w2cKMCSqwp66RQi7rCow2b/VsdfPClzasBgIioO0HuyNN57nJ2BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IE4l/LOj; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulFnbsNGGwVfKQ3t0YA9dy6E0BUyS1V6X8AcItxatSRN/CEuytfkFrCzi4hbYEIIJAuvmdHqKHURp7khHtJhii4d9BxUsC8aqhnvXfL/55FjFPc4qVFVshWj9Yrx+VUTQKHTWIpBavPRtfWnA0JrPHWORzZ/I5MoAtUCu+K9vo5lFAPnwkvBsWxJ62UsQiuDuMjJOOVam4zmItl2PeIA1hRKSKSbTEB1cSPpiGnU+O8dIeCyPdsVOsQAXfDhnIv+w59J/n5KTRKdJuo0udTitWJTocOhvevdQP6AIB6L8DZXpM0+AEeS9c98D47zAK4w8AK1racGncqEk5LNs/qCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=VjUx4AwVbHWooDjiP1SleNGnvskrjLkDr9qF2t4s5MDkNqm9PhjuA8MBolytlV+iNhbJprUTRqUCHKCol1PlJompqutUFvGnejOrypaL+PZq1zVfh6oAEuJdAuUfvLG3kLvsw+OrjuRnncdAAkUVKHRHU6nqc7mb/6fTeb/DKVwPTmCgjm4EGo0wBu4qotbXkwilT5cLGi3Tdn53BkCm0rL+SRzGMGP2DXRYGDw8i4a1dKcSqd2EgsQndpHA93PqORW37bmIiqeKZSNcBz0x1NPTpffU8CcPcwva1jJcVpwj398lHbEWSwHQJBKncvT3GwYxdoRmmSn1k6oJUbsKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp9mDaGjGTen8BidXf0OT4su1XnPFAKk8A8EBFXEZQ=;
 b=IE4l/LOjKbFk2t5vvJmfXTBZJQ8rO5NarYHkMcNPF5odHcepmZiOjMuvH6GUpKTJGgzFT4Js8gQch0HGB6voCmV50jt/x3xSwrpJvB66BI89T71dJR/sap3k1qWEZA848amNVzFhLx5pqFWRr/DQn1QyRFc9U6A5N7u4x3ffhCe9v8BOP86NbTKiG0qCbmB0qwPeG2qFyopyeCj3f8a9zQGVD4ScT+2QpeJCPF5x6zROMrUE0+wDIB7oYRVESZbJwooBd6b8hca8YnvJQceH58D+nW5ZRjZ/r9uYM3YW1q4+PCyt7I7gLnQU+vuTVKp0yYNYYlrKZVhz3/Rbym4BHA==
Received: from AM0PR10CA0068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::21)
 by AS8PR07MB9548.eurprd07.prod.outlook.com (2603:10a6:20b:628::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:13:55 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:15:cafe::d8) by AM0PR10CA0068.outlook.office365.com
 (2603:10a6:208:15::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 13:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:13:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBC009623;
	Mon, 14 Apr 2025 13:13:53 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 01/15] tcp: reorganize SYN ECN code
Date: Mon, 14 Apr 2025 15:13:01 +0200
Message-Id: <20250414131315.97456-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|AS8PR07MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe696ea-f8ff-4ed8-fe8d-08dd7b563548
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MXFTMkMyYllpMHI1dGJDVjNmTzU0cDg4bWtEMEdJeVIrNlE3c2pWVmxHSlVW?=
 =?utf-8?B?bmdkaEsxNlVrV1czY1FLUzYwVU1pUUFrcG1lazJ4cTNKVjBkZDd4UCtDQ0Uw?=
 =?utf-8?B?UjlDaHV1QndYVkl0NEE4T1E4K0k3MkxHemt2eHJNTi9ubXBaRjFqa1N5OUpp?=
 =?utf-8?B?eWxrR0VCdXFrOTEwRitGa3lvRlYyT0hIeU10VklGUkNkdlJaTU9yS3JkS3VN?=
 =?utf-8?B?dUY2UGFzWVlvNEgzQzlXUlNYNmxGeXQvbjdMWmpXdDVNWWhVdGxtT1BydzdG?=
 =?utf-8?B?NEdydU05K1lkYVA0Qy9FalJub2V4a3FzVVIyeFloL2FWbS9FcTl2UEw3d2FT?=
 =?utf-8?B?T3JnMGRqbjdUeSsxb2R5V2EvWDV2dE4xSGRwcVlxajhsaFF2ZmlwM3NNSlF2?=
 =?utf-8?B?UmIxZkhOSWZzWFFIY1RQVEVQemJwSTg3Qkk5RzhOSlk2SlU2WEU2Nk9iVnFh?=
 =?utf-8?B?T2JMdlFEbkJ4L2FONVB1bEp1bmZNL0hKY0Z5MFJ1eDVNNjIxNHdSSGFrd2NZ?=
 =?utf-8?B?M0N5UnpkazNxeklSdy9Ndy92SkM4UzRBcjRNcWc4Q2FnejhlZjFRd2JSNlRK?=
 =?utf-8?B?eGlkdkltRUFTTmhPV21QNy8rUUVYWVhIZ0Z5TGp2VjFVQXJpYUVDY1ZrdDdk?=
 =?utf-8?B?ZWQ1dXAxd3NwOGhHL1QzTElkMmFQbVp6TFF0SkFMaExoWjJRSVF6cUQwenFt?=
 =?utf-8?B?N29uaGdjUmY1YVN5dXMyRlJUdmorYStQcDZOQnZqM0FJZnUwV1VwbFNqdGpT?=
 =?utf-8?B?Q2toam9MNVIzaVIvd2hNSjN6OEhzUUdQZXJVa2NoRW15elQ4bXZjU01KYzhM?=
 =?utf-8?B?Tmw0UUxUV0xiait0WCtHVmw1SGdRMFlUL1Q2RURCSm1vZjNvOUpkMVRpMmNv?=
 =?utf-8?B?L1VHVkhvOW50TEY3K2ZXc3EwWE9rRVAvZGVPNGM3MTlHS3E3eW5RMkRPL0hn?=
 =?utf-8?B?eldwc3lqenVNdkdNZ1ZzZTExbWVrQUdJNnFML2E0MVVCNjhjK3dsVGRvZjcx?=
 =?utf-8?B?dW1EK2NxY1k0VFhzSS9kOGxDTlBPUVRnT2xIcENKRktHUE1HVHIwVWRxOUZt?=
 =?utf-8?B?bDFyZzNGNTlKaml1b2FqSEZYTUE0eHVkSWZUT2t1WnBQWGJMclorU3BOb2Iv?=
 =?utf-8?B?VWRRNWNOTnJ4NWVWQ25uRldMbFIyWmZudEhIMmxSdFlTYnNZcENYYUdSSGg2?=
 =?utf-8?B?RlNtcmF1eXFUWjhoOEYvOHhRVGpyRENMcHRqaVg5VVNBTGVVdjhQSWc2THZQ?=
 =?utf-8?B?NnErQ1RKeWZxam1sWlFlN3ZXcW1tSmdZSWlVMUE4ZTV4VStSeUxLSGx3U0VI?=
 =?utf-8?B?Q2NWb2pyZ0gzVUkvTllJMG84ckdFNkJGZUJwSWEwZERzbkI1SkY4WE13ejV5?=
 =?utf-8?B?aFFBRVlWNUF4SkphK040K29iWDVxeU5IN2RSaUptekVFbUUvOHdxTTI3N0R2?=
 =?utf-8?B?QTBHdDRSS0kwc091ajVrYzc5bDExOHpvRER4cWVMQjhuVE1RY29WOHlqYTMr?=
 =?utf-8?B?RkJGMFJaYk9iZWtldlJFejBMRUo0M2F5a2x3eU1iK3JWLzg4S203aFZiM2NG?=
 =?utf-8?B?Q1NyUHlRZC9KZXNySUxjbGpjM2R5MU83aGV5QlFwaDdKRWhDNkNUc0dxWERm?=
 =?utf-8?B?cG9xT0RzTEtmWFJPRjZPalNvRi9PWm9vczh4OW4vZm5lMEIzUjNPaGpZK3FJ?=
 =?utf-8?B?T1hSWFVrMzVnOU12QkRXSWE2TEQ5cDFmeDYvQ0ZEZHVGNHN5RUIwL051YXdp?=
 =?utf-8?B?RFpJKzZVMkdiUmFvcmhQdm8wNTFTeExaL2IzcmpsQ0JpQXVrNTF2ZkNpRWV6?=
 =?utf-8?B?eE82cUdKMHhJalczUU9tSmZMRHhNNVhGTUxCQ01QamJnZFVkZFdzTTFXRUNG?=
 =?utf-8?B?M2VNWHMyL3lGUW8wTHBOS1pzcnZ2KzlnZ1lRYkp6elJLZ1JKY045NEYyaDRE?=
 =?utf-8?B?aTc1TEgvdmZZNWZkblVuVnFlZHNkeEJ4dzBjWnNSK0YrMmhhUmZTOXFhNThG?=
 =?utf-8?B?UU43WDhXY2l0Qi9CTEJjNk53NUlBaVQ1dkRFazlYVlpyVWlnS3I4aEEzVThn?=
 =?utf-8?B?WVFoR0dDMU95b05pVTRYYzJ4R3BzQTRxZzM2Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:13:54.5671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe696ea-f8ff-4ed8-fe8d-08dd7b563548
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9548

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


