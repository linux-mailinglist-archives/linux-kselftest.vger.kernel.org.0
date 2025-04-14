Return-Path: <linux-kselftest+bounces-30702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE8A88179
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6C188F05A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C02D1F5E;
	Mon, 14 Apr 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BpnSzPwz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278F2D4B44;
	Mon, 14 Apr 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636471; cv=fail; b=KtkgePPbEuB/vJBjdC9bIl1bxwKrnYIYuFWC8Chq68BiCJgG1QbGTLfy94ZyuGdEq4STV3UNPooWQVt6aK40TsB3C0KF1VrpfAPOTfADgfePfqoOuRqLENfxeX+BxlC4FySyWcYCL6BWaU+D/AnHucygbpHZBfSjM8srkxpW7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636471; c=relaxed/simple;
	bh=WJHQxI6i/fEm60bcI2XfCDvqnlxwPFZf87Vi7aVBoy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+VmKOy4nAnhoOGdSUmumIdu9LasZiCaK3uBzhpYjINeW+QstfE45tx7l7BIatR1Awau2Wb+p6kt8bIkH2LgMsPeVNKUj0+6t1NQ/iiMqzLLJ1RZ95B2oXFDcl901moS/VAGCZWCF+VVvvS4AShQgMIoWy8f0B0UDtvWFZDys3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BpnSzPwz; arc=fail smtp.client-ip=40.107.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsD3XlxGCYuVco19uPI7BoV1LCM10wbnC11GKic5dZgIfD+OrqUmaN68qbAcsGkdBJUWV3k0rRx8FccEMt2ieEN9z2+OZElw12ZlnQJLuMj85gheO/8gjoAxyh9v4ig3133ziFyXEQ9cxliNIVOKp/Ik8p5/Hf59sRnF7Ni0O+3PHZUXkoPUZEQ/222vT2rYX460BwNxkiEVtYsRKN8p9ge66Mks/cIHVtE7DJKpIoDPA3P+g4ELqH1rFzZ/x+gCvVoL9RPQVawJPDbb08OOp9cSdIfeSTw4C8la3bwIP30AKEB2ameat03mbl3R05RPVRjZnl/5Akqvb4cjKYtPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJrGNiiOHulkzV3MesfEyK14yRPd86Kdu/49Wik9ee0=;
 b=DBsAR6OqwnfY0e8YSry6e0rPTrezNhdjJIAvxy9xlhKcBwVxo7mvopIHovPt1jZ/8w1h627qt9s9tk2QN3mrlcj8X/RERTrCi+wrkWTq8k02CWtPoW9K2OS9buqZpKru1r62AhHq4Tji6B2gRuEtNSVZfhHuom03J9wu31rERYsjPxvdkScrR0ogvaVeW9oeinQ9pUlNha0B6wGZxk36gi7jiDqcmA5ZsX2ShyPcPnqtIMFb+panJoX8hT325S7ebK0gtfMjXes7cWmIxUr53e3dIvRL+GxC57nF3/16Rqr8cZQyvwUD6iOYHmXSY130N2GzJbYh2AROzWf/DGd/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJrGNiiOHulkzV3MesfEyK14yRPd86Kdu/49Wik9ee0=;
 b=BpnSzPwzvcOXam9geQuEL53FR94BnjM5fqD2szeu5SwB81GN+5EV8tSqsZrOQ3JhbTs/qXd31PvkJU80sPfGd9cA8SwMVazggowuXpjvES+NAJxue/JkNQy7qnujA9kM1aIXDFYlzPVyiaJ7n1B0FTL5oiCqVlFHbmTj3smE8sGBK+UdK2olwDoLsAm9878J7LFIrTyIWJzCaTPe1pYhvIe0ZkuUeXzJZqDCYDzZRM9ESf/Eqet0p/A7dkiu/7dr+Q88HUcc9JpIqU44GX5EUMUhu85qaa2ZPc+yYkEUzZyOv487H/vOpvvfVwHzNvtQuL+nucLd++QEER9ibVYE8Q==
Received: from CWLP265CA0475.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::19)
 by DBAPR07MB6983.eurprd07.prod.outlook.com (2603:10a6:10:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 13:14:24 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::a5) by CWLP265CA0475.outlook.office365.com
 (2603:10a6:400:18a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 13:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBQ009623;
	Mon, 14 Apr 2025 13:14:21 GMT
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
Subject: [PATCH v3 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Mon, 14 Apr 2025 15:13:15 +0200
Message-Id: <20250414131315.97456-16-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|DBAPR07MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 0937f453-912c-49d0-0f3c-08dd7b5645d2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YzhNbmo1bzkzTDl0SE9GNUJlMEJUdzUzejUzaDFHMm93QUpxaFgwNFZXTWZM?=
 =?utf-8?B?NlhrYjFsYThWMkplNUxteDZzb29YWGdUditscVlSaGdvUUNCbGN0SjBmN0t4?=
 =?utf-8?B?Vkc1NWtMam1Vb1dpRlA5NGNyUi9oSnpMTm0xalNwT2ZreFp5NTZrSUw4UzJy?=
 =?utf-8?B?Yzc5eG1xUGZSWjBxc1NOUk1TMCs1QW5ycUJtYUNNNk5rZ09kODVXWWtQS1lp?=
 =?utf-8?B?NU92aFoxaTlET3cyZjVNUk1wcFZaWVRBcDVQYTRYRE5xN29UVmNCY3p1bnBU?=
 =?utf-8?B?T3NaWkdKQ095NEd2Mkl5TDlXazE5OC9VTkJmeTEzeWRUY3ppNFFVVU55Y1BK?=
 =?utf-8?B?czlkK1NnSXlwQnhlL2FXQ3JMWHd0bEk4bmFWTThJcGtSb2xYRXRlNGF6MXpE?=
 =?utf-8?B?cFJLNmd6ejNCbUd3UHdmeGJaekpmSEdHd1ZpM3dURDFFaW1qcnQ3Nnh4UlQ2?=
 =?utf-8?B?aFhUczVnWUd6MmpXQkdZeVdhTmxpbGd4RjBnS2VuTEFZdU9OeUNoOVRUNlJi?=
 =?utf-8?B?Sys2WW0ybFpSV2tSVXNSSGs4aktVY2QvVHVENnd2UzJTdmltaE44TlQwcWta?=
 =?utf-8?B?U3YyYzNXSmwrTzQxVXAvRlRzWVpyZXdSdFpCV0YxNktTcSs1K3VpNEk5S0dw?=
 =?utf-8?B?eWZ0MVJNN1VQYVd3Z2twdnRwT3ZxRFlUKzRRTHR5WkJZNjRjVEpEdUNFTHZY?=
 =?utf-8?B?bld4aDloTG5WUzZOcHBWaU5KdXhpWWxlUC9RY0QyY2hqRTR1RmNhbVp0UWFW?=
 =?utf-8?B?WjJQTFY1YkJ3QngzVnVFb09oY0ZHWWI1RG0vaDV6QkVHOExRTVFsYVIrSUwz?=
 =?utf-8?B?UEpGcWl6UUxsNmRFUkZMOGxYZzhlWmxkQ0dvWFZ6VGJhZndSSmhRc0UzNEcw?=
 =?utf-8?B?emViTjFwamh3cjZzVk1zbGFvcXhsUC9TT0xkWUJ2blprQXFucjcxVHBKSXN4?=
 =?utf-8?B?SndlZm1QeCtqbXNrd1lSRDN5cjhKb29acDFOUjhla3dYVGI5TzhxWDRTVFcr?=
 =?utf-8?B?OTBSbTA4Z2FhVnJYeEQ2ZzNCQm82Y0E0eVVuWnRhM1I0WWR3UjNWS2xCVVZ1?=
 =?utf-8?B?OE4ybHR0SnpRUUtWRXpkZzBiQ1NweEhXVFZVNTFtWEZ4SzNxTWY4djcvUFh0?=
 =?utf-8?B?MFNhVmNmTmNoYllNOCtCbEFmWlVxa2toYnpKdHcwMVdiNEswRkhIS3dVQ0FX?=
 =?utf-8?B?bnZITnFFREFtS0tHVFFDOEVkSDZWaXprYlgrOElwSWtlRERHOEdtWHFFZmdn?=
 =?utf-8?B?ZzV0QVFwWVFMdUpEVUs2SFV3MTdaSVYxRDZGV3ZRVDg2Tm1ob3pzRTZMc3JY?=
 =?utf-8?B?d1NobWV0S0h3anJOQzBtaWtRc3NtdTZ6STFWcHkvVHM1dTMvTEJidjVJSkRX?=
 =?utf-8?B?eE1HeUNZN3VNSDBSa2c2UHJYTTNqcExkVThWNXRmcFJzVksxVlZOeWhNTXJu?=
 =?utf-8?B?TEhQdDd3YzJyTUFLN3FJMDJudE9DSnhqUFhwRzEyeXpZME41a2czNWxOV1BP?=
 =?utf-8?B?WFpJRGRDREVySUhpMXQ2c24yTm00b3k5aGUya05QKzRwSUQyaDBma01OTDdQ?=
 =?utf-8?B?WVBMU1kxRzV2aUlmdUp4bHZLYnA1a0VFRkUzbmFnandTVExEOXpBOTBhMmI3?=
 =?utf-8?B?anNLN0ZIdGlKank2OWRCTmJOUDkzdVVnZVFhNU1zSGJWdTZSUnNUYjhtaDNX?=
 =?utf-8?B?Y2xSQTlDYWVOMjNGVEdHcVlLdytZczE2UjNvZjRvby9kWk1VdVRzZDJieG82?=
 =?utf-8?B?NERnQTZqNEpzOEFyMGg1d1F0UmxQaVRQT1U2VlVid3ZOTW1oUW1xdGcvVy9B?=
 =?utf-8?B?Q1ZNMCtrNEszM2tFWGY2MmxpdmQ1d3BOSjFsZGNGUnN0UkFqRE5raU5xWWdG?=
 =?utf-8?B?SGFnNUY2OS9scUwvVDRxNXZhU0h3L1E4cnhhRDBxL1pFVHNVOFpHMUd2aUxG?=
 =?utf-8?B?MllQR2xzWG4vY0l5RFl2NUpvYkgzNXE2RTVtbGVOT0FpSGxKcExNdkFRZ1BX?=
 =?utf-8?B?bXpaVU5iQ20xWXZzR1lvb1QvRUs5ZUhjWUUzUmg3SSsxQnU5NTRZN2kxZE8w?=
 =?utf-8?B?c3liVUpYQXlGemV5S2JYZ0dwQkgxS0VuSzMwZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:22.4495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0937f453-912c-49d0-0f3c-08dd7b5645d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6983

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h  |  1 +
 net/ipv4/tcp.c       |  4 +++-
 net/ipv4/tcp_input.c | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 782e4dd58bf7..230f55b22a51 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -313,6 +313,7 @@ struct tcp_sock {
 		prev_ecnfield:2,/* ECN bits from the previous segment */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8e3582c1b5bb..673224273540 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3371,6 +3371,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5109,6 +5110,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
@@ -5117,7 +5119,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 132 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c6dac3c2d47a..5bdd82d3c201 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -689,6 +689,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -708,6 +712,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			u32 ewma = tp->pkts_acked_ewma;
+
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+			tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+		}
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -756,7 +773,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


