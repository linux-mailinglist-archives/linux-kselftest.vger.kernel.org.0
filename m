Return-Path: <linux-kselftest+bounces-31100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C49EA92DA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5371B65E18
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B38221719;
	Thu, 17 Apr 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dgRDhjn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE21A5BBB;
	Thu, 17 Apr 2025 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930893; cv=fail; b=mZZ2B2oKtuGd8PXDIezncNwQMH3FE3cnBu0WOdejT/pGxt6HzpivlO4yboSfc9YTSJaQxiwk7zVyKIsz8EuA/oRy/bXuFx5qdSlN1j2i/0lajOTtij85Z3b/h0qqLDMf2q8CGoY+Tgkbdc7SS9BwrUBEDc8sOg5uC6X6aoJG7YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930893; c=relaxed/simple;
	bh=BO2C7Yxj1XlxijxJtesTYtQsvKTzVV3DCZRpIE1vjs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOgzHLqIn9iT2EUXrjZikNSFeJGw1X0qLNyPzdmXQlFuej0dK2U5tzaecGvkYBcN6wJ0loYSU9YBP114i6ziHZszYYKkYluPoP512KcDKs+3vsSpchZh+KoWRRnZ1nFXZW4bkktgmHgLKGmRC9AtjBaH/C02nlz8X2+bHufC/ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dgRDhjn8; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOCIfmJwz9qAPfsfl/GvUFcr7z5lS97O2HfpwJAd59RA4pjviqtqnWOAhVGg3rnaytd6W5YYziWh/fACa4G8PfdJSD5b9aei/H4HLO4gO7uVnXHeLOcA6G1H4YVCIsPMFvnLIOGlra4TDmpJTNJMQMcgkEgslsrpg1g2/r2yUzwN8HYUiZDNLQKLi7lv27ge8slxFwkemhKfHxvcwJ+0fj4tWJx/zlFRHmny3Z+b3eA3Z8t9q9Ia/y/QNG4RC5O23/ZuDka8Evft5nhZY/JC97petV1mXTOxnwqSOfzJpSm3m4JllUhvphBIdS4pcc5cx5iMnNWfLglAkTTvrAFXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcWHWlz+pn6+3DSlonX0uLWbfhn5DkxcFeo+8Nqq6jU=;
 b=K2uoQZ0aFQooV7K2zzz2DWcn40KQJfOYkS47trlNrdViOkl0PTezvbesSaAwk/xyq2Ih6AKMkAfgrOnOu8/bu67gy0SF1lWKllg4VvRrf/RlKHkH818bSgC5KSYzHq4PYvZnnfyVljNY1a6FHs0Ng9PfcHMFtCKmEgcXWqVAuhFrFEs3BhIP+xweeW2s+MPKBOVF+I7jCZkwvBV3832a6cFvesdUMpgyLqb0vEc2UBjHampn9ovd/o8xb1l8X7WD9j+io+XfMo/6kJoBT/HI5pX36oVbpyGPwlfzrNBCs3TlHTkznPdhaHpDqZAr9OWV3HPshiaQIXqThbRxAtFJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWHWlz+pn6+3DSlonX0uLWbfhn5DkxcFeo+8Nqq6jU=;
 b=dgRDhjn8ybC6IdBIx+ch7yduejZR2tWyMVR8cVL7L7KazDzB5bUEeAIC7HpXgrYsBT76eKdxU5esBbnBgUn+6+/sGyjy3jQAXmnGnYm7ksv6WiQ8CJjJPij+ATW+rUStAP5z+OlPaHDAjazc6ztB70mZ10Hs84Xxi7Rk6awnsE94ue+oOcj+iknWNU1BCHSTzdPla2VgF3YtiR/feaAg3hiOTK5ab7xzYCx8O0xy4wXip4afDQ1kjWm1NXzFLVj5nyluTd5kyDbvFiI9ddY6jU3ElRryPsFsMVTEviC+kuY6Glyt/DijjANR1zWoI9llQPoSvS7J4D2BiFkjyacQlQ==
Received: from DB9PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:10:1d9::10)
 by AS4PR07MB8899.eurprd07.prod.outlook.com (2603:10a6:20b:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 23:01:26 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::ef) by DB9PR02CA0005.outlook.office365.com
 (2603:10a6:10:1d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 23:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 4D84D2081B;
	Fri, 18 Apr 2025 02:01:25 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Fri, 18 Apr 2025 01:00:29 +0200
Message-Id: <20250417230029.21905-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|AS4PR07MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a19c3f4-66f5-4799-286a-08dd7e03c867
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Rkd1Z3NmeTdFR0NxMXNuV1lGalc5N0Qrc2hrNW5zWjhWUjJ2cnRLU2JzSFlY?=
 =?utf-8?B?LzA3NXpNU3gySVFOK0txKzRrQWgwM05HcXJ4TGo3OFhBenF3ZHZCUGFkZGV4?=
 =?utf-8?B?cFRQdDVVS09JS0dDWnAzTTl0SHd1aVY1Z0dHaDd6M2xFZlJGMzQ1SU1FSThK?=
 =?utf-8?B?dFRLL0IrQUpkZVNHSXlNOFJqb0xQOVM5dzF6YmUzZ0gyTFdHWDNMLzg3b3B1?=
 =?utf-8?B?a2orUUtMNlBYbThQNHF5MmdNN3B5bnhzTG5UYXJOVjFRT244QndwUjIyU2o5?=
 =?utf-8?B?ajk0QnUrUDdtbmJxR1FBNXlnZGJWTlJNbVAvUkpmOW8yLzlCaEVTNnVVTlly?=
 =?utf-8?B?VndhWHU1d1MvUUR0b0x4SjlsbFFUWWVNY3FvWFk0WFJGQVdqdElkamhMSTRW?=
 =?utf-8?B?WUN1N2hpd01JRHlKbXdRd1JYdWZKeFJWanRXT3M4bkFvWXc2TklZYUxzTzll?=
 =?utf-8?B?Wkw2amw2cG5BZlR1NUNGdXdjK0RKRVd1Q2szZkMzOGNySFpqVjljT1ZhQ29R?=
 =?utf-8?B?QzQ4T3pRdjFRZzhuVmNPWGFBdStlakdzQlJqOEZ1WENWb0NRMDV3VjBvY3dS?=
 =?utf-8?B?ZFpkYjhmSDl2ZktweUIyb3NZWDZqWXQyUVAwWWhNTFVvL0ZWQ1lOL29uM2FG?=
 =?utf-8?B?VWFiNjNBSWhRVXdQTDN4alN0dGFRSVNnbjlVYWd0L29oc0NkaDJLcnFhRVZ5?=
 =?utf-8?B?OUZ6L0NKTjhKNGIrWmFNWWw0b2xiY2ViY09mS016emF3aTliTU90MHo0M2dK?=
 =?utf-8?B?MFZTRFBpNEQrRTQwNXg5bGxzTForTitBbVh0WnVsdkdwU3pzMHJuL2tyUE13?=
 =?utf-8?B?b0czSVU4VmFSb290MnMyVG5VTVdlS0hlaGwrZlBIb1Nmc1VxYzBUcjUwMGlM?=
 =?utf-8?B?bnBzb3ZMNTUrcFVpNy93WGpSOWpaVDRVY1lzdHIxN2Z3SEhwWlU3ZmtmK0ZH?=
 =?utf-8?B?LzVEejZXUWwwSTdNUUIwbDdjZXFTa240VExxVUtpaHZnTVE1WE5zNzQvdE9L?=
 =?utf-8?B?bEQwRkpCY2hwN251cC9uWXdFSDdkRzl0MElMUmxrb2VCMmZGWWs2dTNFQ2N6?=
 =?utf-8?B?S1pnKzJEWGx6eCtUbVlpNFVmakd0bUU0dUxjdVRkK1Fhelc0UHptbVIwdUw5?=
 =?utf-8?B?bEQ3Y0U5Yk5NY29tcTlPZXk3OEpjeE1BdHNmTEtKOHA0Mi9wRTFmY0hyZkRz?=
 =?utf-8?B?QUgrYU4yNzNBY1AyR1NmUkhYRU5MVU1wSUE3VE11MWI1NDRUYjhUSFRSeXM2?=
 =?utf-8?B?NFp6Wi9TbVA4UU1sSnp4NUw3bU5lRUpSVStFSXdoWjUxVFBPSWxSTEtBOHJH?=
 =?utf-8?B?WWNoWld3YlBSMm9xbHVqUnJ0NTNQMmtpeFdpM2YxbU9DWmhQOFRqVWtIdTA2?=
 =?utf-8?B?bW85T29qMEtib3orY1NCY0ZBMVVtQ1IxWVoxZ1k2NCs2d2hsQ0hEMUZhN09o?=
 =?utf-8?B?RVVuQTBUUFpPNVprQWNXVTlTc2szeEJxL3JKL2ZZTmRFOFFlUWErNzdydTFI?=
 =?utf-8?B?YmxGRmVhYjlNWW0wVytwNUIwNThkU1hJTTRzSldwNHAyMGZGYVAvTFAxdXJD?=
 =?utf-8?B?RDNqWC9Nc0ZXdWtlbjE2RXU2ZlZRR0FXNG9yRnF4ZFFjbTgxY21uNmlkeHF4?=
 =?utf-8?B?MkJTUXBQc3hwREwrbzdNS0FXVUYyTWNTa0U2U1V6bS9yaURtcmhsUTRrcVVE?=
 =?utf-8?B?MXhzalBwTzJ4ZmF4KzJsOEF0MXpsVXJidlNIQ0xMdzc3WDh5REkyMjhvb0gw?=
 =?utf-8?B?UVlpTlVYMTRSWEhjUmZHT0luQXZFbDlHWktCT0tNNHRUbUJiSU0rQWJ6eVMy?=
 =?utf-8?B?UWcwZTArbUgzWnd5RDBFYmRQU21oZTI1Z3JIdWhmb3NsK0VnZjE4Ri9iZE5H?=
 =?utf-8?B?ZjNjV2h1cklhY28wTWw2NUJqZ1NXd3JCWjlaZk00blRVSlJqOG0zK1NCMkcr?=
 =?utf-8?B?QkM0ODYvdjlxaFNsWHlyYWRLMkJUQXpSMG9rVm9rTDQvUzdkbFEwakJYRlhV?=
 =?utf-8?B?ODk2djhZQjRqSkJRSmpiQXR1dE5weU82MzBrNjNSNVZxdFpNTFcxQkZ6V0Er?=
 =?utf-8?B?bHRtZXpBTVJ2VlRTb0hTUDBoVTBGdjJidXB1Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:26.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a19c3f4-66f5-4799-286a-08dd7e03c867
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8899

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
index 8e3582c1b5bb..56b6467df18b 100644
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
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 132 + 8);
 
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


