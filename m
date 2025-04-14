Return-Path: <linux-kselftest+bounces-30698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833DA88177
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125C43B65EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515422E338D;
	Mon, 14 Apr 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="U+4Q9Zdj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5914A0A8;
	Mon, 14 Apr 2025 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636463; cv=fail; b=iOViutdInT9T2FL++qTnpl1jVe5mj8Kjyd2ZHDXDD/08RkVOa5dAyjM8/4UCuGd3sux9Yfq/oLhfzx69uC3yhB7Bu9CDp5jQUMr9sLBnMGy4oRegi1TIiPwiDyDfWj1C5uZiOxSYXswiXLoBRG2W/ye//M5GWvDzwnRqxUh9Flk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636463; c=relaxed/simple;
	bh=G7AD1z9w1HgJyE5etSVk9tk++GMHosLLpz93FfPbtls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDCtoOS6pQYsKpF6zgI34vJBcf71UOhIA8LScf39UVBKL8Caxfr7/YrCOL+GvhB2jQGaad7Engy0+RAgoiHp41SM30/Moi1K59do1XiK4z50RG4F9yUVQYeEprCkzb2P2ykGe6V35YVGz0IKu0zkjstyw6GK/Dzs+lIqi9XN3Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=U+4Q9Zdj; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdLly4e7VxGrHN3xU/xIAmJlVWmXqSmnkgYbDgeHNwfn6XOSZ/zJvYRLJfno0s81oYXwiDUmurSd2CbjU+VPJSP311pkLg1qDiHGDO0+xuJ+R0cmSWPxtxpxkNyRjbpBLvLju9uAdCPcpq7cocxvN+czlisZk+DTryercw+uBFMhUtNkMrPA+dfQcEer7uy6HoxjYk2l/TkJ8/LwKSjjr8UpdpoqzkRwc6kbcALxULSAlZY19FkxAmg0LcMrGRJ9s0r32h016DyPRgw9z0cAhIhIZ6yMz2wi/CxNoBqUxkuIRs2w0uOROjvV5O7wAZeP1Khf/r7u/UUkaHd7VHof9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99oKgOcN6Ay0P/Xag6QzCJxFE5Sfm9d6UD3XFt66CiM=;
 b=V0KGuVxKiJ4hIeG9wb2IHIE4LhZKG2SMZ3p/j9meWIyMUUuSOBB2h4mMV+JeYaKFhVJCxkpTi3dVhQK6YxpN89sEPZkRxadW8tx2yuIC2B9BrEd3BHNVZy2v4FsHbouTftTjBOeJhYr877aIi/0sFz0A1KMiOfpUQw6eH8sT3Pd2W+Y0/7+YkuOPbeIok5w86vVoHVTT6hmL0npK8iJK7WB0NxhgzX9WJ2KNUxLY3fettuUtpzAa0l0up4XHWZMWKV8vfwYqoc8O6Y+7rj9gFCZS+USJM2iAZbmHa53sYO2TvrJ+xzg5jHARv8AzhxXwia9M2MLKWPrGKvRrwNB8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99oKgOcN6Ay0P/Xag6QzCJxFE5Sfm9d6UD3XFt66CiM=;
 b=U+4Q9ZdjtsOFLORTB1M1ZjcZE6Tpuch/f2puL7eO2cjWsjm1tgZM3/3pk1r3guoK6y34HcvckwgJ/voXi+iZ+aCB+NbXlzeUZPpl0/oWpequWZ5CcGXrUKOhhTHvc/slIe9Uc73oGSLkyvBXf5phMSHTpEcSz0NfyGDGOEHzS1YdtBtivjw0Fp+aRRr0saf+pgeB0/ltHoV7m813VK+6SiQVpmlVkpjrxsZrC7q2TGF1K/MQKdFl7U+jMHALilOIxHbY6vKtrEENhXRVhX7Y6SaoOaFZNFUyK4tSY589/RmtMlBQ4EYpnfva2G6zQ1S2jTKnhTsBg1ydvWA6WvRXrw==
Received: from CWLP123CA0086.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::26)
 by VI1PR07MB9682.eurprd07.prod.outlook.com (2603:10a6:800:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:14:13 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::21) by CWLP123CA0086.outlook.office365.com
 (2603:10a6:401:5b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 13:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBL009623;
	Mon, 14 Apr 2025 13:14:11 GMT
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
Subject: [PATCH v3 net-next 10/15] tcp: accecn: AccECN option send control
Date: Mon, 14 Apr 2025 15:13:10 +0200
Message-Id: <20250414131315.97456-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|VI1PR07MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbc6f01-e7f3-4a67-e282-08dd7b564045
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Vi9aTmsrc1V4ZE8ySnNPZGhLZWJYMzBCODN4YzFwbzF1UFZYZHFRVUg3WTQ1?=
 =?utf-8?B?d3IrbDZJTU85OTFEN1Zla0ZLTFp1eTY5M2NTeHZqeVY4eWZka1QvcGFkMDQ3?=
 =?utf-8?B?azB5ZVBYKzhlaXMycXFPSmZvcTZnWlF4S05ocmJxcUxGdDlzdzk5bStYcW5I?=
 =?utf-8?B?ZFhHZmxBYXE2QzlvZWVIQzVscWxxQTB2cmV4RXdFUjkvYVkxVWRZUzRlT3Nk?=
 =?utf-8?B?SXc2Z0FWbk1XZU1zaEFobEkxRlBLMkIvNUM4VEF1SEptV3VJVVlOYndCZ3Bz?=
 =?utf-8?B?dUNZemRiUmlwbVZSd3hWOUFqbkxoKzEzY3RKaEtLNGk1Sjh4V0l3QUc1d3U0?=
 =?utf-8?B?ZTR4U05kOU8xaytXSXZhOHgzL3hSdXVxWnQ2OVZiRFgreWM1TUpJZ0dqQ3JV?=
 =?utf-8?B?LzRMTjB6UHFxeHdHS2ZTMk50cVdyUTdlb3p6SlJmZ3pMcTB5YzQ1d2R2Vmo4?=
 =?utf-8?B?bm9UditjZTN0UmxkUCtyV3hSbnQ5eW9jRTNQY2RpcnF1bm5NWkVKT2xmOXV6?=
 =?utf-8?B?d01jMkhTOWtLSFpBZzU1UXE0cElFNmZhRzNDZEdKSis2TVh3djF2bThReWVF?=
 =?utf-8?B?VUNvQjFzaCsrQTlPWHpLWG96NE5IS1B1TjViOUNHRDR2MUFuMWZiN0xZVFBP?=
 =?utf-8?B?YzUveHJDMVF6enVOTW5CMXNZM0tTK0ZFUlVWY2d6WjJFdm53T294eXZsQTlp?=
 =?utf-8?B?bXRya1lzMEVZb0JkWWg4ckorK2gwTmZ6YnBlaXd6Y1dQaENEMjM1aWRvYnB5?=
 =?utf-8?B?OEdubGhsYWFITnhodHBSSVV5eEtHNThhU2lWa056K3BQWTIwYWk2UkRjUk5Z?=
 =?utf-8?B?ejRrdS82RUxQZ2hOQ3MyZUNjekh3VXlyVG5ka1ZJaVFKVEJYUWFhKzFSRjQr?=
 =?utf-8?B?RGVFQllLcEVrY21vMTFuTXEwSjhSN3FFdjBWRnhvR1c2ZWJTTll0WVQxc0Vu?=
 =?utf-8?B?RTlMSXk3SmZLWGJnWG5zSzRNdjFVL2Y2aUozbHMwVjk3cEdFdno3ZTFNM2la?=
 =?utf-8?B?dEJEQjlLL3F4L3hLdjk2RnNwWVZiQWU5Qy9Ub1VpU3d3NndtVHB4bzljZ2RJ?=
 =?utf-8?B?N1p3N2tJdjVqeUxuK3ltZVk0OGJiV3hYRGN3dUhTeVFLcmZIWXVGMnhRRWZo?=
 =?utf-8?B?elpUNE5Md3l4ZWtuU3lkNkZjU3B6ZHB6NHZTakxyWVgzdGlBWXpLWW0vUkhO?=
 =?utf-8?B?dXFMckFnazN0aHR5dnkyTEYrVkhoL0pNODAzVHZOVmloNmVJaUd2MzRJVXpB?=
 =?utf-8?B?REpQeE9OM3RLbmVDWjFZT0tIZWhnUlQ0L3VrVDZoR25malhPNmVheXREZGND?=
 =?utf-8?B?ejhkN0dhWlZEZk1OUTJ4L2Z5NmhRZXBaR2hUZzZ6T3J2WnluYlErTENIU3Vp?=
 =?utf-8?B?VEI0QlZlV3JwNkxJa1BWa0RIdDdSbURMTW41MXl1SDc0OXhCOW8wUkp2SWVO?=
 =?utf-8?B?NkZ3UXNNQVdtSmpYdjhlK3BtZVBvRWRDTnBNMkszdjQwK2g2dTZZelVHQjNq?=
 =?utf-8?B?Z0JQSCs5TkxWcSt0SHpqSHVhT1UxL2ZweGg2OHdWQlZrV1c2QkFNcS81dGlH?=
 =?utf-8?B?dlZqNkxFclcrUjRicU1qRlV0TTNERno0bjU2alZCblY0VE02VlVHbFV5K0hX?=
 =?utf-8?B?WkhRdm0rcHB4NEpZR0dBRnlyUGR1TVFGV2N5dkhJWDNnR2paajhQQlBPUDBW?=
 =?utf-8?B?aGdOQU9MMWxQNU1ac2RrbHB4UlU5QU1NZVRBczM5V3R3YWVjMDJxV3Q0RlB6?=
 =?utf-8?B?cWE4SXBLVzhuRExwL2IvWjFFUHUrN1B1a0g0WEo0aExMdHpQWUNKc0RJUmhE?=
 =?utf-8?B?bnRhdGFxN1E1VFhsSnlVZU5tRC9CSmd1MnBKd09USlN1elFLRXoxNDAyY0Rz?=
 =?utf-8?B?OUhKY1U1RkgwMURFYjgwN3JldkYvSE5rUXN6ampTektXWUh6TXRYZjhhd3Vl?=
 =?utf-8?B?N1d3RXlBYWpYRXArbUdFSyt3TWhISldQWXFNRmVBMXhJZlZKbk1LL1BVczJp?=
 =?utf-8?B?dGg1MVBCSS9DdFpRYlRkRGUza0NpeWM4Zlp3YXBwc1NZbnFMOExqTnJqZFFl?=
 =?utf-8?B?eEZCN1B6bkYvZWNxdGR1N2ZyMnhwT2F6cGZ3Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:13.1422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc6f01-e7f3-4a67-e282-08dd7b564045
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9682

From: Ilpo Järvinen <ij@kernel.org>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |  3 +++
 include/net/netns/ipv4.h   |  1 +
 include/net/tcp.h          |  1 +
 net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
 net/ipv4/tcp.c             |  5 ++++-
 net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c        |  1 +
 net/ipv4/tcp_minisocks.c   |  2 ++
 net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++--------
 9 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 0e032d9631ac..9619524d8901 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -309,7 +309,10 @@ struct tcp_sock {
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		prev_ecnfield:2,/* ECN bits from the previous segment */
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4569a9ef4fb8..ff8b5b56ad00 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index bfff2a9f95bf..3ee5b52441e3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1068,6 +1068,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..3ceefd2a77d7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_FOUR,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 89799f73c451..25a986ad1c2f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3368,6 +3368,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5106,6 +5108,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5113,7 +5116,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 41e45b9aff3f..1e8e49881ca4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -466,6 +466,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -486,6 +487,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6278,6 +6280,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6291,9 +6294,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
+				u8 opt_demand = max_t(u8, 1,
+						      tp->accecn_opt_demand);
+
+				tp->accecn_opt_demand = opt_demand;
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -6426,8 +6456,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
+			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+
 			send_accecn_reflector = true;
+			tp->accecn_opt_demand = opt_demand;
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3f3e285fc973..2e95dad66fe3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
 	net->ipv4.sysctl_tcp_ecn_option = 2;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = 3;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3f8225bae49f..e0f2bd2cee9e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a36de6c539da..a76061dc4e5f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -806,8 +806,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -984,6 +988,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1237,13 +1253,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
-		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
-		int remaining = MAX_TCP_OPTION_SPACE - size;
-
-		opts->ecn_bytes = tp->received_ecn_bytes;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       remaining,
-					       saving);
+		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
+		    tp->accecn_opt_demand ||
+		    tcp_accecn_option_beacon_check(sk)) {
+			int saving = opts->num_sack_blocks > 0 ? 2 : 0;
+			int remaining = MAX_TCP_OPTION_SPACE - size;
+
+			opts->ecn_bytes = tp->received_ecn_bytes;
+			size += tcp_options_fit_accecn(opts,
+						       tp->accecn_minlen,
+						       remaining,
+						       saving);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2959,6 +2980,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


