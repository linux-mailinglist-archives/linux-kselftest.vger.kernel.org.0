Return-Path: <linux-kselftest+bounces-31096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBDA92D97
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014FC3B6DC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5693222572;
	Thu, 17 Apr 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R9rYpiWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46F2222D2;
	Thu, 17 Apr 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930884; cv=fail; b=uRYO1CmDNa5APqzpnb8z18ppC3KBYA2pmOhZ8BB+/ZJGJmenL9LgjRvG0ZkiLqpIZdwb2RBtG9IeIFsY3Tr7QiFMuqlnKx+04+hgmO0ur1w6Ddk9OBeUIVz8gSgEzXEjlBG65VKz+ripVHVKCljMH/2T7A2T1ydou/Pofl+crIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930884; c=relaxed/simple;
	bh=G7AD1z9w1HgJyE5etSVk9tk++GMHosLLpz93FfPbtls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc6i2piEGwh9QMilJj6A+j7E1ETFNwcdhyU1jzhCxhg+flA8kcbjYAtfyoMTEj+XKKCKujfoOZT4svuCpyarU0AZ/RYZV760MacgUP1KXLPc6zWyan/SP77FDygq150VkMKUmyhzEgyikYMHuppXTXEc+5AC9j33JGRXNIO0EYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R9rYpiWO; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPdCTIc0U7yrzM8fWC20LDVbEZkOrwqeKlwC7XejtfjixfO29s7moOQoR0Xaz6omDfRSToImlyq/Km6wkamRamvALLQtYBE/wQOU/K0fcV/lbIr2CEOcL/mbFC5iW4gn80k3ePr+hCmCB1jovz48XIIsB0l420Dlp5kR5gpOOXAu9cv12GJHkDqgPcQu2rzTHnNopJNu15KW7aoBy6a9V5MkXdU8AcxrA6qrJaD+o7otFIY5nDbPNaKQAaj5Qkpy4bnu0lTjBabou2KErGGHRnEVZYKD43ou9wIaUfV+4YkA532v8p0WVXWDAwrJDiU31r/dmTjKzJfeJWtRL4Mqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99oKgOcN6Ay0P/Xag6QzCJxFE5Sfm9d6UD3XFt66CiM=;
 b=tl27FhvU7egonlNm4x3YjLCZVlT8ct1gbl70Y9eaY05XaWTsUYA9TuPzAJO0kdole+snJXxOg8q1F6E1AJXUV41R0g4iIRF4gBNYC3ZvolzlpXgvnkeTMr6h6xiUkBVJjxfajrUWEUzJatOHER8whAYGdu1WIVUsM/HlJyWCW4dCoQUjX2EPq7+zYj5OnlVeLg9gNIOt9bVfr2F2MDat6JnxU47Kb3EISlCfkyoXQJ2JM5oq1qdGjt4QasE/ygHdXCsSijXHiW6OQTWS78klZgon4Myhv89AMyP2rjR7kgwkoMhd++fRc5hI7zse0eXUmZ1mAN7sIrREYWJhFR+g9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99oKgOcN6Ay0P/Xag6QzCJxFE5Sfm9d6UD3XFt66CiM=;
 b=R9rYpiWOP1zMTNdAaVAvNAJWX5P1/b01sHmo83xp/bj3nnwUlWIj8P4HUyu2slJpLQC8Sbuyhe2viSj5CdKp8SElxHQ0Ju9nH+oVa5RJSDARB47WdUav0OtA+h7x+xjaWz3HkK6Myb1jh5yb9R7QQSj/iaWv6ntRMKMgP0asIjcRO23YNlBqJPRRhUK6mDWiqG3F8+e+//YMl9Dsn+5+4cjStjG8EhRx2ZIqiEGt0V/A/P8xQtM1dhVy9zUUQVQdO+iNWtaATJKHgmrY8lFXy4hfQlp3e5VbZr+VqwrjstWW+tnM8isXgnYnFruMU3BYVn2z7yD/OAeUvkth5hDeRA==
Received: from DU7P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::25)
 by PR3PR07MB6684.eurprd07.prod.outlook.com (2603:10a6:102:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Thu, 17 Apr
 2025 23:01:14 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::38) by DU7P250CA0012.outlook.office365.com
 (2603:10a6:10:54f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 23:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id EBF662084F;
	Fri, 18 Apr 2025 02:01:12 +0300 (EEST)
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
Subject: [PATCH v4 net-next 10/15] tcp: accecn: AccECN option send control
Date: Fri, 18 Apr 2025 01:00:24 +0200
Message-Id: <20250417230029.21905-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PR3PR07MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb4769d-e2fa-4875-ea6a-08dd7e03c0ff
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cURmRmlCcW03ZWxvUXM0YlNLVGNObmZ6RlZsdGhiQUdaOUtkenJlVEdpbHdw?=
 =?utf-8?B?YWFXeXV6OWFqWWg2cFN2OEZzNEJza2xQakJVTU1QVjY4bnhXcE0zL2lBek5k?=
 =?utf-8?B?cFNwQ1hkRWxIQmdQUENVb0Z3VjFHbWhtblNjNktrYW1VcWRrMnhHZCt2NUFm?=
 =?utf-8?B?N2FIZktlRTlzRHU5Mk5GZWJISVB3NnhUam5tK2JHVXdmNlc5aFM5bkkycVhY?=
 =?utf-8?B?WmZjOXAwV2xWbDFLK2hkUk14Q2RIdjA5OGgyZlByRy9GU0xpeWlxYWZKd1lQ?=
 =?utf-8?B?aUtXZE1EdUw1SmhNUSsySTNxL0hlaG1TSTAwQ24zWjRMY2dCS2VHOWlBLzVU?=
 =?utf-8?B?MzZ6YzZRTXBRT0FSNloyb2wxM0ZzZWNSZ3ZUNXZXcnpFN2Z1aDdXb0ZLd1ZD?=
 =?utf-8?B?S1RVMFdXNjFsK1RiekcybnVHVGFFb0pqTjlzdVRDNTlXdTV4bzM2Wlo2RENP?=
 =?utf-8?B?bDdBbVBmeC83S3lMbU9xU2F5bzZXYmxWdkgzUDB1RVU3bTdlcEIyZ2hDNGYz?=
 =?utf-8?B?TXFhNTB3TkZuQW0xdGUxeTBjWUcxOForY2RyZURYOCtybExLMlREaVltQUZX?=
 =?utf-8?B?bmJ1alpralpJdk5jTFFlcVl2bytpWWJwcDNBdTloUU02bkNzL0dqQWhsTk02?=
 =?utf-8?B?RjZZOHdZeUlMbDZVR1RHNEFGQmE2OXhzTDMrRTRsTlBuUEJmbXFuTXkzSmRk?=
 =?utf-8?B?MEFEUUR4WHV1em5XUUtxbDdtYUx2TFBrVzV0em5UTDIzQnRtQWlsRDM4L1k3?=
 =?utf-8?B?c1J2V1ZzcGYyQUlsNEZvZHg5VGZiVnBwSEVEaFB2ZmJGbVBaeUhEb1pXS1ZX?=
 =?utf-8?B?aVdZWk1yRHBsVWNQS1pwcElRa3luZHpHWnBUVTcwRkZ4RmdWQWJBNGFmckNo?=
 =?utf-8?B?L2R2ZUgyZ2oweWhsV2lUaTVtbW1WOUI1ZFliUEJaVUNXQ3p2dHFsL3ZUZUVH?=
 =?utf-8?B?M0RCcFQ5QkhLSnhtQUhRNXVwVGZqdGVkMXYxdXlYcFJIM21zOERjSWdtWFd2?=
 =?utf-8?B?T1MweGxoOTNuMERUdjFEV2tzZFlCM3Z2akRkSXUySDZuUzJmcGVyaE4vVGpm?=
 =?utf-8?B?c2JTdk1IR2l2Z1ZJWUdCTWkxeFFTeEVzeWEzdnVNajQ4QlJpWWlRQ1Y0dzBm?=
 =?utf-8?B?cFZoUXdXMzdsK0JrcUxqOTFVK2wwZHVjM0pMR0t0Yktsd2xRT1VxV01IRGUz?=
 =?utf-8?B?QzZjQUdFQ0duWHhGYzRMdVJsK0RMOTliUjJnRDJQWVpHY2xLM2tTSTJLenkw?=
 =?utf-8?B?Q2I1OEU3eUVRMnlrVUVpem1lYmE3MGtIR3FkWFBJWFczcEV3b0lqRWV6VTFa?=
 =?utf-8?B?cFcxZmVDNlBNMTMwN3Erdkxwc053M1hQbVBMS3NNVTNSeUlHMzJxVHQzWGNR?=
 =?utf-8?B?TW5YbUtZc1pnMys5UFhmTnFFRmdnZi9iVkoyQmt1OTMwaTNmNTFHaVZCK0hV?=
 =?utf-8?B?VHprTmNqdW40N2dpOTl1TG9FWFJFYUxObENtamRpTXl6a0VuNCtoMDNZWFE1?=
 =?utf-8?B?aDZ5S2JIZEtPZHFBVTNkTHI2em9xVUNWN0xtM2M1cFRJeHl4cEJnWk5uWnpj?=
 =?utf-8?B?UlZhKytVWGtXdEcyVG45VHA1aTlPSjk2M2cvT0kvUEZPc05iMFJ5SFBnMmp6?=
 =?utf-8?B?NU9ETWJIdnA2RWkvWGd1WUNGOE5HR1NKM2o4N256L3YrdDlqVDg4eEhLRE9P?=
 =?utf-8?B?aFFvNGRiSThRSFZJOHQ1dlhUV0I4ZDVOTFp0UzYrTGo1RTVUeHN1SUpYVExr?=
 =?utf-8?B?OWY2NmZUZU5JOGZYaVRwdjNpdlRyM01pcnh5Y2plSjljWHdiZHlYVE91T2k2?=
 =?utf-8?B?bXo2VTkvczR5ZmFsMlRsUUtvQ0VFVlltcHZGaEw3eG1abFUxbTY2OGJtbFNK?=
 =?utf-8?B?c3dmTkw0TEo4T21PcEhmUnVCYkJMcGhiSTQ4UHc1Y3kwY3hIVlVySFd0ZmNU?=
 =?utf-8?B?TmFUTFFwV1dwaDlNV2w4c3BnMDVzd3JMNEM3RjVDMjlmSWRSZ3QrbFRtNnRr?=
 =?utf-8?B?MEQ1czJpUmNXZDVwUmc0aXU5bkhsSHlrbGViMENUblNibWJzNUJBalgxSy93?=
 =?utf-8?B?ZnJxay9TTXVOcXh0ZWRYNGNOeGRHTnRVSW5PQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:14.3852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4769d-e2fa-4875-ea6a-08dd7e03c0ff
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6684

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


