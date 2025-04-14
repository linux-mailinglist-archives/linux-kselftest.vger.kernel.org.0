Return-Path: <linux-kselftest+bounces-30808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C1A89032
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 01:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEE7A1D18
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282881F4188;
	Mon, 14 Apr 2025 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WboQoVXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946A15B54C;
	Mon, 14 Apr 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673888; cv=fail; b=VBYYCmbBZZmHEt03fZzPlTVdLyFn8lVsK/XuF37msrgc06W1QlQhhw0xtUvWPcKvZpQji7J2peaCaKR9kaZWhGpFsn4L5rHQMYJciJZAf4hov1uurd6+xMpQyBPEdjKiti8h3YVHdjzThqISwCYjR02xOGllYSicVXuPdWejbxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673888; c=relaxed/simple;
	bh=WJHQxI6i/fEm60bcI2XfCDvqnlxwPFZf87Vi7aVBoy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOmYqgc7vSYkPEFz2O4T9uvV3LQUHoDFpQySsOj0itZRVuA/qaefT+tHsE+X8/lb4TBKM39bJPc5TesBJcHy75iFKYAE4bXp6by3t/xj3Rkk8FRAogEt22AajWcKFVl3VcDCf4SfO1CJVn59IUTjg9RwkqaIwTjFPtg61F00+2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WboQoVXP; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT7GRNFllASwvZoIdGLAqT0J4cIZEwSgyZ3B4I0Nq9YKc9tv0JL4ivFCAg9OF3HUiweTyTLtZA9HDZXUCvGkTal57IQ7rM4DurWxKe+9vkLs/qwqGZKgThAHwrPIH9/scMasyyCw78BnPOvhrnBcXK4pPPjic17qwJddwnmvNtTzDx4eSGzyqL5VagtRRhljkGrWT923LJnFh1xhIb8a5+iV59CCrvHdvr/09dUdiPy+l9NM1QzBemeqX1ZhpQ2RTbFF6q0Qq0xmxlCWb15lco1MdHh3SOoNcFBA/UHmu8C4SwvTrFcpf6j4EBW/pq+AbmnqCtmH9DJWk1lrf7IHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJrGNiiOHulkzV3MesfEyK14yRPd86Kdu/49Wik9ee0=;
 b=HV+DUw0O9dBuVHYdZa9P7xDoKxhrh9xf2nJ2/w+0qQcv4eZa5ctlJgOojVfjaJmD9AE/6br5hhMPjvAyAjRWHzNpigZmPpWuHRh7NmLSehcWCPWlJ9MZimIBU0eOHWJO9gTauIWHoP6J8hGeuN6l9nLnumxOA6fNoc/hiwD6I7x/U9c42mspVbYLUmr/zE0WJssLmS1Nb5cgehMhxrWx9nx/GbyQIRp7sp1C0jiBTptLLokyBFAzeclF0zPMc/xpW0qYl5uHT2z0G7XUey2NFrgjyXqpFeGmvv29R7h8M50nO9mLviwIz3yBfLy5W4lLnpxdLc1XpubmnRQLIYWCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJrGNiiOHulkzV3MesfEyK14yRPd86Kdu/49Wik9ee0=;
 b=WboQoVXPna2mJ7IA53keFA2AzIA1K00vAq3358r2CJjaZh3xPKA9ltlB6Uuqe4fewxbB3YpsrDOtbNvIyRPfTdA5GZh2TnQc1OySA1iRmgM/BFJDSKkAGBx0vu+ZptyJyxSbh5P9vZ8KumqNt29wt0EG6GXwp6VpW4eVvTZxqg8zc6J34mgpvHnCE1FNNiVG3/mH8JWDV9NJprK+uZGaTNZ91BDHKMcZJ/PLTtw8J/ts7xVrXJRCLXhE4FmD7L4D2VwcsdcAai0LnSN9HZnZD8bUoLl6wrRubSYsVKfU28hPBMJm6M91JJakx1vcQuaQ0Hce2GejO5WivxDsw0JZ8Q==
Received: from AS4PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::6)
 by PA4PR07MB7552.eurprd07.prod.outlook.com (2603:10a6:102:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 23:38:00 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::8d) by AS4PR09CA0018.outlook.office365.com
 (2603:10a6:20b:5d4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 23:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Mon, 14 Apr 2025 23:38:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A83C94EF87;
	Mon, 14 Apr 2025 16:00:20 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v3 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Mon, 14 Apr 2025 14:59:44 +0200
Message-Id: <20250414125944.97350-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|PA4PR07MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 576218be-d72a-4b4e-d4b7-08dd7bad64a8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TGV1NC9kVG81Y2JsQ2dtWnlkbTFiVjJHenl4bGhoNm5rT2V1QTNxRVUzZ3U5?=
 =?utf-8?B?dU51OFNBSGlLY2RSeWV4c1ZYU2lPakcwSEc5Z0k2YnpMMVUvTU45R1hHVmZF?=
 =?utf-8?B?ck44c1h3TTVuNjZSYXNZL3dwaGsrMXZjNjdtQkxHdmJGQjZhM1Q4cmlzc08r?=
 =?utf-8?B?aDRZYmJiMTI0UmNuUUhyWXFwZDdldEgwQzZTYjB5R1dDRnY4Zzd4ZGg1ekE0?=
 =?utf-8?B?eGJvSUJTVjFuUHZtbW1QeHk5WUZMMTl4YlNtR1I1TGowWUhiSkc5cDI1Nnhi?=
 =?utf-8?B?dTNPVktlSlpYYWN4WFFIQmJQbGhpS01SRjR5ZDZSRXphRE1iWGxlR3lPOUQ1?=
 =?utf-8?B?bVNFcWNNRXU5RDZHUlhNRmVTL09xbGVtRjZvTDBzeFp4N3dCWlVzR0pldzgr?=
 =?utf-8?B?czNtRVVIT29WWGtBSmFINE9ka0YxMlNxOXVURVNpT3lJZy9ybjREc0haRlZt?=
 =?utf-8?B?VTd4aU02QzVCdnRHZTdWOWF6OGV3UlZWRm1JMnZ6OC9QWTNFeW1SR3dkRmtE?=
 =?utf-8?B?Z0lzREpyMENkeDJJSWVEWWFJWmpMSmdubzdZYW1VTGhLbngvL05Vb2lZV3lO?=
 =?utf-8?B?anhyd0VEUnhPeHU0dTgxSExvSVBhNGNFSit2VzZ5ZXlrV3pqWWRnTHFzaUs0?=
 =?utf-8?B?VW0ydEtCbTMrbE9XTVlLanFLTDkxcitnTkhrSkN1V2U5RkxaSTRVc0dRMDdv?=
 =?utf-8?B?aW1abGpnZnp3V0FJYXlzTEYzWEs1NlN3eGFFZ214aDRxZ1JGY2JNQXVTTjI5?=
 =?utf-8?B?VFhIalhadW5Qb0YxWWIvTFNyRXJGSDNTSTc4bm43Wkdvb0lCSTBtYlRSbWtM?=
 =?utf-8?B?U1QraXprdDVudGFsSU5MOURCSlpydHp5Yy8wUHh2T1R1ZndXZUluOEtCelQv?=
 =?utf-8?B?Zk1LSHhmdjYvRlBiU1krSDhmUWNEYm93QkROMExJeldHbGNwQ0ZuengyQTN0?=
 =?utf-8?B?RmtWQmN2c2ZEajNVY0MrMXEyV3V0Qmp1V3YzbUJJQ3NMbHVnYkEraXJIalRU?=
 =?utf-8?B?T3RXUnYyeTU2cElxYlBDYTdWNHpDWFprdHRSbklnSWxWbHArYmNhczZ6U1Rh?=
 =?utf-8?B?QS85OTBXMkpLR2J3OEVJYVVmd2VVb3hMNWJJWGdVQ1pSanhOWFdqSVNKMTRw?=
 =?utf-8?B?WkdGSHVLZExEMXcveVJHQlYvU0xVZXdUaFYxTGpYUFlQRGRRci9lYUMvOG51?=
 =?utf-8?B?Z3dlYThoZ09GL1k1ajhGUDJCczByK216VGFzckNoYVVZMCtqdTJQdDNkMW1v?=
 =?utf-8?B?b1Fib21sN0Y5UVNwMllHZXo4RG5yQXhNQ1RhNVFRY2xvZCsxckNqS0xlQkxE?=
 =?utf-8?B?bmRrSmFvNTVZenhXZENRdzJCZnptRGRUWTZOanc4eDl0MGxqb00yWEwzZ2Nv?=
 =?utf-8?B?YVBidjlCQm41RkhoeHoyUldiQms2NHc3NWhQZnBvZjdUbGRNNHJtamRZa0Fp?=
 =?utf-8?B?MysxdzlJUUpvSy82NUJDd2JTVlYxWS9ub203RTE5RXF4bElyTEJSUHFsNE5r?=
 =?utf-8?B?Q21WaU1mZWxUc0hRNkwrN1AweUdtR3dPaEFidHU4NUJ2S0UyQzEwNExxL00z?=
 =?utf-8?B?TDRCb1ZwMWZRUnlXS0pEdVU1Nm5vWjJOMjVrMHJ6b1dMNXhsYUZabTZWK1Jh?=
 =?utf-8?B?ek1kZHlwOGdxWGZncjZIejdPR1hjNnRUY0U3VE92UytEQXRoRTFQOFcvRlJW?=
 =?utf-8?B?N2J0bVJWeU1INUFRVmhyZGcvL2xUaGdsbWpmR1BZdnh1NlhlZGU0aURWK3FG?=
 =?utf-8?B?SGh3NCtmK1dnaXFKSHBxYkFUaEI3VmgwUDJ5c2UwdFZIaG5YdDM4WlRWRlVY?=
 =?utf-8?B?ZjdCR2d0SlloYnFNeVRDaWF3alU1UXJXTEVkZE4wSWlXcjFvQWJpRDZaU2No?=
 =?utf-8?B?WnEyUWdqaTZuSGxqQ3hUZ3ZYOUNpeXl5Z0haRXMrZHV1OGVQSGxhdWZKK2V5?=
 =?utf-8?B?NW1EcGNBazNyRStXSmJxZlpFeW53Uys3ZzlnZE5CR3NaYzg5czNZVDc2MlNH?=
 =?utf-8?B?b1dRQzNkRndSYnl1blYrRHpqVm91MDh3dndMNW10K2I2TVVqWHJtNFVyM3BK?=
 =?utf-8?B?cU1SUXFYMnVQMUVZSjhpME9GeDdndVlyOG5zdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 23:38:00.3885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576218be-d72a-4b4e-d4b7-08dd7bad64a8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7552

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


