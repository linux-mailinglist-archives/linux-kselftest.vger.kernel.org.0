Return-Path: <linux-kselftest+bounces-31321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EDA97156
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27902441EF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57D129345B;
	Tue, 22 Apr 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nUoenbNn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB4290083;
	Tue, 22 Apr 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336328; cv=fail; b=gJbtBpY2Md2zQVnKeZHTHvdAbigfsM0E+tFONtA+Yy0um6IpmnO6+hDj4fx8omAfdKfxh207pOeBUaZ4SqmLu06kwFbdhXsPiybAx7rId7yL83opv9plwx3fsJQYvWrMvsGgjpBAGF+7qpTNZmSSyJEc2aJvyinygiDf8Ye7Sto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336328; c=relaxed/simple;
	bh=TS5wtJOTOa6Pz9z90VGQb5Vj1wjT1bDl61JO1AO2KAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDvALimAioTSwkwZyk078fGq2iBBLfuyAD73Ye0xOiam9Sks7OLNKuJF7rzzCa3qV5C1Ic++Sct6PJkALbWBP0kCoKR4rXoOvDLSdOW5lZb6wcBMcjLsI8pyKTfRE29sBRH4dBFWSb3metZRCqrYNLDe0fFnTlBTH74IP5jg+68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nUoenbNn; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuzLlaXvCkkBqbj31yW3PyH6D+iLgc6ohvH0LRK9vowYu6WI0LGaQEgE6coWnacB5SfQDRfTdU2rG46kfkCY3E1RUZwyUFoL4to6D/Dpp9jfRQqbClkVeJQF7LoBcZ+G/pnNYa9L6p8PRf0z0NINFYsxpGWEOxDNYQ6dAQoMLrB44ri8vtqyUJsvdo7KSzou3q/zubdu3kMryNSmjTY5WYD9iOE6fQUuVCf7oxvgRVE74AXowo1C7zGJTl5pk5nX+23o5G0XllVUuRoA5X5daLcHbrSb/QDhLp+3jtfvVT6Zn09Xh6lHYHfksS1Wn6A27Wfb/Su7d3yuh/YRykzimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KbGzMvvWONFVypmWme0rrDmlnFWJaEhyTIIh8qo3a4=;
 b=mrczDSYjjs3/G8cVZb5wImmwj+5IUibGy4xSro/uwckA2LjJBd5ysYsFXE/6wSf4HRDvRuxN/fJktWDmJKILn907r75GnfvaPyWMd5NWB/VVhlJh7CCxIY6kl1sbhIS0JlJSmMHDPTBPse4TkzEofj5dgu6jVV91hMGJgSAIrb0TbNX/iMlnp+Y7Ej8UrJxIJQYqmTofjh2TTAO2NyF3pjddGsgTLz8GhV9FGyUB71cXRYEGjVsPQ3QXJGKrLKoVJzh6OZlWe0NaZ+Yeg4tdHi7KVh9GJdae47StSWjujF3vllkYOEWQODXN93biLRMp8ZU3S2YzZz8ykBjrAcxtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KbGzMvvWONFVypmWme0rrDmlnFWJaEhyTIIh8qo3a4=;
 b=nUoenbNn2Cf2M2YvJ2IP32K8b3J3Jll2vApW4X7FNolmirQ9UHqmHyqXe+2rRP1doHTqNP14dVsRmZ/uYaFgkE52CjhPa6dAMfmVEYcU6cDNp8L818oaAeNe8cyruG8SNeKG05X8xf4JRwbU+QNxP5CrwdgewvsZRlwDFx7VH1Xw0STegULHPnkaIwiRY8zblCyLsDM9YuKF8kPqpJDZ8Yd6ppWrt6UkLJdoPGG+E/GWmZLYX8tGWn1LM5Ran7mHwJ2n6NQMGpPjyWbHW/K7CEsbG/WDjPipbA6+2zNeYIAyoydE6NbZaaFvAg5GHmRvvVCbhzNQCbmJMBTO0mhFww==
Received: from PR0P264CA0053.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::17)
 by DU0PR07MB8786.eurprd07.prod.outlook.com (2603:10a6:10:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 15:38:36 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:100:1d:cafe::59) by PR0P264CA0053.outlook.office365.com
 (2603:10a6:100:1d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 0FF2720A3B;
	Tue, 22 Apr 2025 18:38:35 +0300 (EEST)
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
Subject: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
Date: Tue, 22 Apr 2025 17:35:56 +0200
Message-Id: <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DU0PR07MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918e96e-5bda-4912-c2de-08dd81b3bf4b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|30052699003|7416014|376014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SDhETmRWL05CZFJ1OXQ4MXdELzhGalhYVnp3VkZPbG5UYW5ES0RZeG9lUU9L?=
 =?utf-8?B?blR3c245SHNCZ2FTK3Fpbk5weWdXT2lMSXRKdmlLendCaGkvdWI3NjlER28y?=
 =?utf-8?B?V3JGTERoN1IzYm1TRmNwQi8zRVhxLzdxTW9wUjZNWm5jcDFPNTJaeFJVNVNl?=
 =?utf-8?B?L1Y0SndFZ2UxRFl2N3FRVi9VdHJabkRSSEYyYkdXZ29qY1VKQytuWTVRTlAr?=
 =?utf-8?B?bGpvMnZuY3k2QUh6WlVEczR3VlhmN2kxL0R0cXdYUkJ0Z0ZRQWlvaGNaVC92?=
 =?utf-8?B?UTRMVjZqM1ptTU9SSnd5aXpVYVl3VjJ4OEFKK3hJbmVZcW9qSElSaWtjWnVL?=
 =?utf-8?B?UU5oQ1NyUlNaWWdEMTNiTmRDbEcvVWZGbW1rYU9oRU8zVzlPcG1vZXIrT1RX?=
 =?utf-8?B?MWh1VENmS01JMG8wcDhXNjFFeC9ndFkvYlhEN05nNngwWnVaN2lES3UvTmhD?=
 =?utf-8?B?eHpNTVFTZjVoclRIZlhQOS9pR3J5bVc4Yjh1VXhMeDJDSXRkN2F4M2tCYm5k?=
 =?utf-8?B?dXZxM0lVQnpaZTh3ZjBxRUlVQjJZNUhkZS9BWUVRYTU3LzM3cjh2b3B4UUp6?=
 =?utf-8?B?QWlMWndkRTZ0elB0Z3d3Tkl5anVvbFFKQmhSTDhVVDJ5bFVRZHZwWmN3Yldo?=
 =?utf-8?B?dXdTaE1ZalNIYVV4dE5MVTJnSTc4NzE5QmJ2c25XQnA4bmJZblROQnU2NVZS?=
 =?utf-8?B?Q2k3eWxWNUtBQldEc0Z3ZkhTRlY1N0VheEFrVjZtVUdFZDRyV3U3V1NTSVk5?=
 =?utf-8?B?eDRObGdla1NZMGlONU5vV3dsdmRIc3pOL2o5bUNDSXA5Rk9nNzlOVUE1ZlMz?=
 =?utf-8?B?VEhEZmNxOTVzVTZ4Rkc5WTdpcm9FQWtob0lKSEVxNm5BMzR1dzNGdThUTDIy?=
 =?utf-8?B?SUJHM0dEVm51bjhYYkRFZlJ1eG85MGR0dEZSZGR4UTlqV2p5Tk91ZWFFVmto?=
 =?utf-8?B?M0NBYWFJQzRldEhQL0s0ZWVIWDRwN1kyREEvS0NwQWJYRW83RVZKWEgxcTNW?=
 =?utf-8?B?b0dyRzNvVU51a1c1eU9YTkUreTNLb0ExaythZWYyMDZhalhsNkY3ZlhKd3lw?=
 =?utf-8?B?czNqQzkyNUxRVzRmdVd6UVljY3M3b0NtNVlzMXc5dXk2TjBxSDVpcmtGMWdB?=
 =?utf-8?B?ekpPQ3ZhZzFxUWlUYkI1aDJPV2JZR0IwWE1lb2pVREIxLzh2N1Nyczlqa3FG?=
 =?utf-8?B?N2NnNXYrdm9helRvQ0pZYkZRdkw5UFM2OVdaY2NYY0FibG5waXg0a00vc3VG?=
 =?utf-8?B?ZTg5Wkh4Q2dwNG5xN2t4dlRvYVBmUy9YVjZxMStMYUs4YmdSbnlFbk9sVjJW?=
 =?utf-8?B?eUtCVGtUMjE5T0hOdWtTcmpPYjhwWFNNdmFtWHpwNVkxU091VGhvUzJFNVZK?=
 =?utf-8?B?RUp0Nk9HbTdWcFhieUhIdmlmeGZuS1Zqamk5NmdzNUo4MFJHanEvNWFIa1VU?=
 =?utf-8?B?MTczZVVEVUJDak45MnUrMU55SjVNZ2k1d2xIczNrNGVHdzdIWWJOTXRnT0RQ?=
 =?utf-8?B?YzNsQzZFY2IvcnBDU3daM3FDMkh4MDFVZEZSWW5aVHBxSngvUkJqUWFqcVFV?=
 =?utf-8?B?UUpteEMrYWpFc0d0bXZwM3FjT3RkMmF3K2dla3ZOWE01Sy9mSzNKVnFOQUp1?=
 =?utf-8?B?UW9QSW5lRWlxOE9uV1FBMElhaHlJbUI2OVVURWdLenJYbmdtZCsxdUxrdFBB?=
 =?utf-8?B?OHBTNWZ0ellxVUVJa29nQ25jd0RMQTUwNnpIYkFDTFpwWFpXRmZ3UGFhRGhN?=
 =?utf-8?B?RG1Hc2o5cHE0VTlOMWpYL3RVMnRrU0NrejA2WXJaTE8xaUthZXdvK2ZGMSth?=
 =?utf-8?B?cnpvVlY3QUF3MlFNV2NjNWhyUGZ3OFB3ODh5ck5NSGNFM2gyRkQvaHhsUG1w?=
 =?utf-8?B?b3pXUVJyeE5NVmZDUWtJVzMxdEh0VVhheGdlZzM5T3NqOE9yOW12THJ3S0M1?=
 =?utf-8?B?bzFUa3AyTm9ZZXUrc0l5ajF0b0NDYndrYzJOMm5uOXZvRFNLaEF4MCtkNU01?=
 =?utf-8?B?NXZMdXJXK2tOeG9MYVBaczN1OFRxRzllQXJoNkxjdFZTWFZURVZOTDBZSTJH?=
 =?utf-8?B?N205ZVRpaUJrd2pndjl5T2xJSUI4OUZsN0xqZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:36.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918e96e-5bda-4912-c2de-08dd81b3bf4b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8786

From: Ilpo Järvinen <ij@kernel.org>

The Accurate ECN allows echoing back the sum of bytes for
each IP ECN field value in the received packets using
AccECN option. This change implements AccECN option tx & rx
side processing without option send control related features
that are added by a later change.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
(Some features of the spec will be added in the later changes
rather than in this one).

A full-length AccECN option is always attempted but if it does
not fit, the minimum length is selected based on the counters
that have changed since the last update. The AccECN option
(with 24-bit fields) often ends in odd sizes so the option
write code tries to take advantage of some nop used to pad
the other TCP options.

The delivered_ecn_bytes pairs with received_ecn_bytes similar
to how delivered_ce pairs with received_ce. In contrast to
ACE field, however, the option is not always available to update
delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
bytes calculated based on the cumulative ACK+SACK information
are assigned to one of the counters using an estimation
heuristic to select the most likely ECN byte counter. Any
estimation error is corrected when the next AccECN option
arrives. It may occur that the heuristic gets too confused
when there are enough different byte counter deltas between
ACKs with the AccECN option in which case the heuristic just
gives up on updating the counters for a while.

tcp_ecn_option sysctl can be used to select option sending
mode for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |   8 +-
 include/net/netns/ipv4.h   |   1 +
 include/net/tcp.h          |  13 +++
 include/uapi/linux/tcp.h   |   7 ++
 net/ipv4/sysctl_net_ipv4.c |   9 ++
 net/ipv4/tcp.c             |  15 +++-
 net/ipv4/tcp_input.c       | 171 +++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |   1 +
 net/ipv4/tcp_output.c      | 129 ++++++++++++++++++++++++++++
 9 files changed, 346 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 9cbfefd693e3..0e032d9631ac 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,8 +122,9 @@ struct tcp_options_received {
 		smc_ok : 1,	/* SMC seen on SYN packet		*/
 		snd_wscale : 4,	/* Window scaling received from sender	*/
 		rcv_wscale : 4;	/* Window scaling to send to receiver	*/
-	u8	saw_unknown:1,	/* Received unknown option		*/
-		unused:7;
+	u8	accecn:6,	/* AccECN index in header, 0=no options	*/
+		saw_unknown:1,	/* Received unknown option		*/
+		unused:1;
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
@@ -302,10 +303,13 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	delivered_ecn_bytes[3];
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
 	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
+	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6373e3f17da8..4569a9ef4fb8 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -148,6 +148,7 @@ struct netns_ipv4 {
 	struct local_ports ip_local_ports;
 
 	u8 sysctl_tcp_ecn;
+	u8 sysctl_tcp_ecn_option;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ffa4ae085db..bfff2a9f95bf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -204,6 +204,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
+#define TCPOPT_ACCECN0		172	/* 0xAC: Accurate ECN Order 0 */
+#define TCPOPT_ACCECN1		174	/* 0xAE: Accurate ECN Order 1 */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
  * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
@@ -221,6 +223,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_TIMESTAMP      10
 #define TCPOLEN_MD5SIG         18
 #define TCPOLEN_FASTOPEN_BASE  2
+#define TCPOLEN_ACCECN_BASE    2
 #define TCPOLEN_EXP_FASTOPEN_BASE  4
 #define TCPOLEN_EXP_SMC_BASE   6
 
@@ -234,6 +237,13 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_ACCECN_PERFIELD		3
+
+/* Maximum number of byte counters in AccECN option + size */
+#define TCP_ACCECN_NUMFIELDS		3
+#define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
+					 TCPOLEN_ACCECN_PERFIELD * \
+					 TCP_ACCECN_NUMFIELDS)
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
@@ -1056,6 +1066,9 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
+	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_minlen = 0;
+	tp->est_ecnfield = 0;
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dc8fdc80e16b..74ac8a5d2e00 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -298,6 +298,13 @@ struct tcp_info {
 	__u32	tcpi_snd_wnd;	     /* peer's advertised receive window after
 				      * scaling (bytes)
 				      */
+	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
+	__u32	tcpi_delivered_e0_bytes;
+	__u32	tcpi_delivered_ce_bytes;
+	__u32	tcpi_received_e1_bytes;
+	__u32	tcpi_received_e0_bytes;
+	__u32	tcpi_received_ce_bytes;
 	__u32	tcpi_rcv_wnd;	     /* local advertised receive window after
 				      * scaling (bytes)
 				      */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 75ec1a599b52..1d7fd86ca7b9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -731,6 +731,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &tcp_ecn_mode_max,
 	},
+	{
+		.procname	= "tcp_ecn_option",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1e21bdf43f23..89799f73c451 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -270,6 +270,7 @@
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
@@ -4109,6 +4110,9 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 {
 	const struct tcp_sock *tp = tcp_sk(sk); /* iff sk_type == SOCK_STREAM */
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+	const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+	const u8 ce_idx = INET_ECN_CE - 1;
 	unsigned long rate;
 	u32 now;
 	u64 rate64;
@@ -4227,6 +4231,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_rehash = tp->plb_rehash + tp->timeout_rehash;
 	info->tcpi_fastopen_client_fail = tp->fastopen_client_fail;
 
+	info->tcpi_received_ce = tp->received_ce;
+	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[ect1_idx];
+	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[ect0_idx];
+	info->tcpi_delivered_ce_bytes = tp->delivered_ecn_bytes[ce_idx];
+	info->tcpi_received_e1_bytes = tp->received_ecn_bytes[ect1_idx];
+	info->tcpi_received_e0_bytes = tp->received_ecn_bytes[ect0_idx];
+	info->tcpi_received_ce_bytes = tp->received_ecn_bytes[ce_idx];
+
 	info->tcpi_total_rto = tp->total_rto;
 	info->tcpi_total_rto_recoveries = tp->total_rto_recoveries;
 	info->tcpi_total_rto_time = tp->total_rto_time;
@@ -5091,6 +5103,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
@@ -5100,7 +5113,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bd7fc9bcf66..41e45b9aff3f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -70,6 +70,7 @@
 #include <linux/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/prefetch.h>
+#include <linux/bitops.h>
 #include <net/dst.h>
 #include <net/tcp.h>
 #include <net/proto_memory.h>
@@ -499,6 +500,144 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
+ * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
+ */
+static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
+{
+	switch (ecnfield) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return 1;
+	case INET_ECN_CE:
+		return 2;
+	case INET_ECN_ECT_0:
+		return 3;
+	default:
+		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
+	}
+	return 0;
+}
+
+/* Maps IP ECN field ECT/CE code point to AccECN option field value offset.
+ * Some fields do not start from zero, to detect zeroing by middleboxes.
+ */
+static u32 tcp_accecn_field_init_offset(u8 ecnfield)
+{
+	switch (ecnfield) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return TCP_ACCECN_E1B_INIT_OFFSET;
+	case INET_ECN_CE:
+		return TCP_ACCECN_CEB_INIT_OFFSET;
+	case INET_ECN_ECT_0:
+		return TCP_ACCECN_E0B_INIT_OFFSET;
+	default:
+		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
+	}
+	return 0;
+}
+
+/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
+static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int optfield,
+						    bool order)
+{
+	u8 tmp;
+
+	optfield = order ? 2 - optfield : optfield;
+	tmp = optfield + 2;
+
+	return (tmp + (tmp >> 2)) & INET_ECN_MASK;
+}
+
+/* Handles AccECN option ECT and CE 24-bit byte counters update into
+ * the u32 value in tcp_sock. As we're processing TCP options, it is
+ * safe to access from - 1.
+ */
+static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32 init_offset)
+{
+	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
+			0xFFFFFFU;
+	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
+
+	/* If delta has the highest bit set (24th bit) indicating
+	 * negative, sign extend to correct an estimation using
+	 * sign_extend32(delta, 24 - 1)
+	 */
+	delta = sign_extend32(delta, 23);
+	*cnt += delta;
+	return (s32)delta;
+}
+
+/* Returns true if the byte counters can be used */
+static bool tcp_accecn_process_option(struct tcp_sock *tp,
+				      const struct sk_buff *skb,
+				      u32 delivered_bytes, int flag)
+{
+	u8 estimate_ecnfield = tp->est_ecnfield;
+	bool ambiguous_ecn_bytes_incr = false;
+	bool first_changed = false;
+	unsigned int optlen;
+	unsigned char *ptr;
+	bool order1, res;
+	unsigned int i;
+
+	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (estimate_ecnfield) {
+			u8 ecnfield = estimate_ecnfield - 1;
+
+			tp->delivered_ecn_bytes[ecnfield] += delivered_bytes;
+			return true;
+		}
+		return false;
+	}
+
+	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
+	optlen = ptr[1] - 2;
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	order1 = (ptr[0] == TCPOPT_ACCECN1);
+	ptr += 2;
+
+	res = !!estimate_ecnfield;
+	for (i = 0; i < 3; i++) {
+		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
+			u32 init_offset;
+			u8 ecnfield;
+			s32 delta;
+			u32 *cnt;
+
+			ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
+			init_offset = tcp_accecn_field_init_offset(ecnfield);
+			cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
+			delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
+			if (delta) {
+				if (delta < 0) {
+					res = false;
+					ambiguous_ecn_bytes_incr = true;
+				}
+				if (ecnfield != estimate_ecnfield) {
+					if (!first_changed) {
+						tp->est_ecnfield = ecnfield;
+						first_changed = true;
+					} else {
+						res = false;
+						ambiguous_ecn_bytes_incr = true;
+					}
+				}
+			}
+
+			optlen -= TCPOLEN_ACCECN_PERFIELD;
+			ptr += TCPOLEN_ACCECN_PERFIELD;
+		}
+	}
+	if (ambiguous_ecn_bytes_incr)
+		tp->est_ecnfield = 0;
+
+	return res;
+}
+
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
 	tp->delivered_ce += ecn_count;
@@ -515,7 +654,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-				u32 delivered_pkts, int flag)
+				u32 delivered_pkts, u32 delivered_bytes,
+				int flag)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -526,6 +666,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
+	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -551,12 +693,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 }
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, int *flag)
+			      u32 delivered_pkts, u32 delivered_bytes,
+			      int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
-	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
+				     delivered_bytes, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -4212,6 +4356,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 
 	tcp_in_ack_event(sk, flag);
@@ -4251,6 +4396,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
@@ -4378,6 +4524,7 @@ void tcp_parse_options(const struct net *net,
 
 	ptr = (const unsigned char *)(th + 1);
 	opt_rx->saw_tstamp = 0;
+	opt_rx->accecn = 0;
 	opt_rx->saw_unknown = 0;
 
 	while (length > 0) {
@@ -4469,6 +4616,12 @@ void tcp_parse_options(const struct net *net,
 					ptr, th->syn, foc, false);
 				break;
 
+			case TCPOPT_ACCECN0:
+			case TCPOPT_ACCECN1:
+				/* Save offset of AccECN option in TCP header */
+				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
+				break;
+
 			case TCPOPT_EXP:
 				/* Fast Open option shares code 254 using a
 				 * 16 bits magic number.
@@ -4529,11 +4682,14 @@ static bool tcp_fast_parse_options(const struct net *net,
 	 */
 	if (th->doff == (sizeof(*th) / 4)) {
 		tp->rx_opt.saw_tstamp = 0;
+		tp->rx_opt.accecn = 0;
 		return false;
 	} else if (tp->rx_opt.tstamp_ok &&
 		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
-		if (tcp_parse_aligned_timestamp(tp, th))
+		if (tcp_parse_aligned_timestamp(tp, th)) {
+			tp->rx_opt.accecn = 0;
 			return true;
+		}
 	}
 
 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
@@ -6133,8 +6289,12 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
 
-		if (payload_len > 0)
+		if (payload_len > 0) {
+			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
+			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
+						  minlen);
+		}
 	}
 }
 
@@ -6358,6 +6518,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	tp->rx_opt.saw_tstamp = 0;
+	tp->rx_opt.accecn = 0;
 
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_prediction is to be made
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5c5d4b94b59c..3f3e285fc973 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3450,6 +3450,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
+	net->ipv4.sysctl_tcp_ecn_option = 2;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ad97bb9951fd..a36de6c539da 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -491,6 +491,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
 #define OPTION_AO		BIT(11)
+#define OPTION_ACCECN		BIT(12)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -512,12 +513,14 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 num_accecn_fields;	/* number of AccECN fields needed */
 	u8 hash_size;		/* bytes in hash_location */
 	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
 	struct mptcp_out_options mptcp;
+	u32 *ecn_bytes;		/* AccECN ECT/CE byte counters */
 };
 
 static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
@@ -766,6 +769,47 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		*ptr++ = htonl(opts->tsecr);
 	}
 
+	if (OPTION_ACCECN & options) {
+		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+		const u8 ce_idx = INET_ECN_CE - 1;
+		u32 e0b;
+		u32 e1b;
+		u32 ceb;
+		u8 len;
+
+		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
+		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
+		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
+		len = TCPOLEN_ACCECN_BASE +
+		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
+
+		if (opts->num_accecn_fields == 2) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+		} else if (opts->num_accecn_fields == 1) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			leftover_bytes = ((e1b & 0xff) << 8) |
+					 TCPOPT_NOP;
+			leftover_size = 1;
+		} else if (opts->num_accecn_fields == 0) {
+			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
+			leftover_size = 2;
+		} else if (opts->num_accecn_fields == 3) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
+				       TCPOPT_NOP);
+		}
+		if (tp)
+			tp->accecn_minlen = 0;
+	}
+
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
 		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
@@ -886,6 +930,60 @@ static void mptcp_set_option_cond(const struct request_sock *req,
 	}
 }
 
+/* Initial values for AccECN option, ordered is based on ECN field bits
+ * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
+ */
+static u32 synack_ecn_bytes[3] = { 0, 0, 0 };
+
+static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opts)
+{
+	/* How much there's room for combining with the alignment padding? */
+	if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) ==
+	    OPTION_SACK_ADVERTISE)
+		return 2;
+	else if (opts->options & OPTION_WSCALE)
+		return 1;
+	return 0;
+}
+
+/* Calculates how long AccECN option will fit to @remaining option space.
+ *
+ * AccECN option can sometimes replace NOPs used for alignment of other
+ * TCP options (up to @max_combine_saving available).
+ *
+ * Only solutions with at least @required AccECN fields are accepted.
+ *
+ * Returns: The size of the AccECN option excluding space repurposed from
+ * the alignment of the other options.
+ */
+static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
+				  int remaining, int max_combine_saving)
+{
+	int size = TCP_ACCECN_MAXSIZE;
+
+	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+
+	while (opts->num_accecn_fields >= required) {
+		int leftover_size = size & 0x3;
+		/* Pad to dword if cannot combine */
+		if (leftover_size > max_combine_saving)
+			leftover_size = -((4 - leftover_size) & 0x3);
+
+		if (remaining >= size - leftover_size) {
+			size -= leftover_size;
+			break;
+		}
+
+		opts->num_accecn_fields--;
+		size -= TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (opts->num_accecn_fields < required)
+		return 0;
+
+	opts->options |= OPTION_ACCECN;
+	return size;
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -968,6 +1066,17 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
+		     tcp_ecn_mode_accecn(tp) &&
+		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+		     remaining >= TCPOLEN_ACCECN_BASE)) {
+		u32 saving = tcp_synack_options_combine_saving(opts);
+
+		opts->ecn_bytes = synack_ecn_bytes;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
+	}
+
 	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
@@ -985,6 +1094,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
+	struct tcp_request_sock *treq = tcp_rsk(req);
 
 	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
@@ -1047,6 +1157,14 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
+	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    remaining >= TCPOLEN_ACCECN_BASE) {
+		u32 saving = tcp_synack_options_combine_saving(opts);
+
+		opts->ecn_bytes = synack_ecn_bytes;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
+	}
+
 	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 			      synack_type, opts, &remaining);
 
@@ -1117,6 +1235,17 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
+	if (tcp_ecn_mode_accecn(tp) &&
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
+		int remaining = MAX_TCP_OPTION_SPACE - size;
+
+		opts->ecn_bytes = tp->received_ecn_bytes;
+		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+					       remaining,
+					       saving);
+	}
+
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-- 
2.34.1


