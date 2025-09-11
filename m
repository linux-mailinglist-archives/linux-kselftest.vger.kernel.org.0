Return-Path: <linux-kselftest+bounces-41237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4659B52F83
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CFC1885F04
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314A31B10A;
	Thu, 11 Sep 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="crUiaFOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1B3164A9;
	Thu, 11 Sep 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588829; cv=fail; b=cM7MTED0naSYhP8TNe7jStq8XhmZTg/uvhLn7V8GMcmvsj99rwa/9EyHSBfAWCqEeC2uiQjf52ZCv1MRx4iY+TTGF6am9UXZB6iMWNptaVnFv1V8pM9Git1CTmXIa8D6DLkG4A4MQd9AZB/b6XVSQ1+X+9Bj5h1njk06fQvxRHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588829; c=relaxed/simple;
	bh=vQqpwS7TwAx0pGEhr45JDuQZdOyD6Unr26mUzxzbDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCxZZSu7hhYAAJJASmhbbR3F6TdrGlffhGlYkku+4sbtRLK8pZARPFCYsvnJsgVH5eBR4ic8KLfr+fXY7NIsN9c6+Dxq1fwefjbUfr1QwM9CNE7sCaSGwXMX4hvj+949Tnt8iF3qizQ8flSjKjcTVzTGU2pOhev2ktZCo84aNms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=crUiaFOC; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri91xfVPj5KSx4NZIVzVzvLfP31lT9OO9uAvRaeqpjIJxaW2E1G3vPiKK83DFmq2sx4I4b6UbP7x/oucRehGo9Muqxar7mUdStDuSzLJps8nzyNGGVPyWlVxISh4+po4gIVJAhe1cBjiyfr8SDyZ0A4nTfh2Lm4JAARa5l194d3Q882eOxDiEwQtWcEec9E982JlbT/29WsHNPCVZusWrraJVf5qzKzhkXHhD5eKzwtPF3daXdDne0pig3a66vkhk3hRXdZDy3HJlPW5uwFxK4a+Anja4sSnNYDlPvaxVYdXlWmLvkXJov88HtdbPvkP0ZESY9ANhqkOH9uvTPaLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=BRMNixR0unigiqRTObrpUo1IvRzxv9nfVEBTpYZ368STLjuoUytyDyUUz+ZF4zkZspOdVmKkSmlGlv2Mq2ynl61unJxQdZZaeqVrNwSSReyM6iIIKpOFE5Bjm4ebdVwIWeIw1jK2skql5MUV8Nr67416sxq3KHcAPSccH3NG7vSrNEdjyC//2HtUm/ePJj3/0JoVLjzk5y6GvTpLiRjU/qbIjzCD59Ek0nClim9efxDgwErmEHaMsGYScJN+wJyijYw0mop7meVH7bGJT9wGacVlZdholahjGauieUWwGrzkoiM6X9zfR4h0BbNvkT7IDM6oU2qxD2lAfmpp7WBEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=crUiaFOCZ8dhwF37KH7siWSNk5ZJfZgK/gzA2vayQyvHhgCOa2GbegKCK4lDQk8MbojONpbh+RONBcsPOvUYS9VipLw2puEtdXFTFBgeECBejR/qawKY0dU/4zSOPznohB7sFseUmTMdEb7yaMvGApdpQGi7Cpyi+1nnnydDMwxvPE2GzgO/WkKQa/j8kjl1tP/b0LFBppCvTxMR5c8LDZnWuNMzmtoTWVpzBJu7Gv/MYnqMzK7hNgwoVP4SP24AvFTMC55qTaKy+XnQNiRy6dyBOVs6i48kUwhiwLHY/QQaIAIgQcWmBXtqdwnUcyGqzu6WLqA305Qhd/8uVsPu1Q==
Received: from PR3P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::26)
 by AM8PR07MB7588.eurprd07.prod.outlook.com (2603:10a6:20b:24b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:07:00 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:56:cafe::77) by PR3P192CA0021.outlook.office365.com
 (2603:10a6:102:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 11:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0 via
 Frontend Transport; Thu, 11 Sep 2025 11:06:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8B721202A3;
	Thu, 11 Sep 2025 14:06:57 +0300 (EEST)
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
Subject: [PATCH v18 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Thu, 11 Sep 2025 13:06:35 +0200
Message-Id: <20250911110642.87529-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AM8PR07MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed35366-2610-4fa9-4a56-08ddf12353e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkpGdERnakNTZEZlSTZXR0pDb29sSjNwK0t2QVNhUHBMZEkwTlNrZng3T1Vt?=
 =?utf-8?B?NEVmcm5lVGFKOXZ6VVJBNmtVRUFnSEtRMndDV1NpR3J3MjlJZmgrd1dJUHRi?=
 =?utf-8?B?bTlpZDFvYmgvM1RNZW9jM1FBYjVZcnpzQWR3QS9QaDVFSmEvQ3FhOEF0Ty9i?=
 =?utf-8?B?Zms1bVNVVXU0alpQWWNHOXpibjFUZVhyL042R1M3WTJSeFJLRWY5RGxuRmR0?=
 =?utf-8?B?VzdRUjFTcmFuekNaMVR4QmpTT0EzRUNrK3kvci82M2M4dms3OGVXQUxxMVEw?=
 =?utf-8?B?MXprZ0JFdVN0S0dXbU40RHVWdi9sK3BJcHExUjk5RW11V0tOTTJPM2RzcXpP?=
 =?utf-8?B?bmQwNzFPYVR3bHhyK3Q3Y3QxVUc3V3huUzVaTy9zc3EvWmZpTHRDUUkyMTEr?=
 =?utf-8?B?T2N4akJXOUtEbVpMaFB1Z0VJS3VmLyttOXJWMGlYVlRkTFYxNUk4MEdqdVAx?=
 =?utf-8?B?czNzclM3ckw3d1V5NVIwVlR4bFNtdCtIS2dsdFVXa0t1WTM3bEF6RVdDWGRw?=
 =?utf-8?B?YU9hOUt3QVRWM085S1hvNXIzU2VKd09FZGlnMTdEM2g3VGdLYUV4OElMSjZz?=
 =?utf-8?B?ZkZDRGRSTVVyMDB0Q3UwTHZrQkN2cGdoMHRsVDZ6aVpKTWhFc2tua1pYL1dn?=
 =?utf-8?B?c3g0VDY0WlA1VkQrMVg2bnlJRVhPRlpQNDJ1Y21BRE5KSDI3Rmw3MmNQdldh?=
 =?utf-8?B?VnEyZGpSMy96Z0U0QnZUdHZoQkdodWFKczBMdU5EbzRCa0xsR2ZFMDV3a1FF?=
 =?utf-8?B?cHBPdHRUVko5M0dRNDdKR2RWRUdVTmcrMGNCR01nWWFDTllzdmtVekEyUTJ3?=
 =?utf-8?B?S1pXSTg0SkI0cDhTVGZLRTFOdG1VaExJZWNPQ3BaOUdjeXViRnl4WE5XcVEz?=
 =?utf-8?B?dnpQVHUwWkhkbVdVZDdJeGVkbDBrZVQrR21yRVJNZ0dUU3FRcWVuNlkrdUpw?=
 =?utf-8?B?UG1TZkhvL1BzQ1pvdXNZNmN5SW51cjFRQXJnY0x0eTZRU1VJdWh1RW1yaGtU?=
 =?utf-8?B?NWFsSkVGeFBjUTFrYkxwZStXQjFZbnpLcG1EeEw2RHhzQUFjMDNNZU9KdlBr?=
 =?utf-8?B?UDNRL0kwVzdjbXU4dGhXbUNyUGdDdlo3S2hqS1RZWU52c1A5bUNPWk1vRW1a?=
 =?utf-8?B?Mm1vTDBjcHZmNks1bStwMEtTUnM2RXJlTXdVYjQyb09Vc0YvM1VsOW0vVjZr?=
 =?utf-8?B?SHp1QnhzU2hjN2R4dFBrbnY1TktnMkxnVXdLN0cxY1hqa2ZTVFV0bW95WGtk?=
 =?utf-8?B?U0U0TlM1SVlwOWMzRWIvZDVPeHZEL3Y1U3oxNUd1SFE1bGE2b3AwY2I3SGtF?=
 =?utf-8?B?TGhCcUowK1pYdGN4a1B3UW9TN0dVQXY0dy8xdjVMZ1M2ZG16THBTT3M1Smkw?=
 =?utf-8?B?UkJJU24vWXB0ZGxzOXBITWRLV3E1TXNqZ0E3VlU2UWtMN1F1UFNDNm91R2hL?=
 =?utf-8?B?SnM2U0lsTll6bmk0aWhsOEI4UEhrU3d1VFZ5cnZHYmgzc0E4VWRlcnRTWWRH?=
 =?utf-8?B?S1dxWjliWER3QWJhK2tCcnRrdHpJdFYyVFh4Y2pLZnZOSXAxWUVqT3hDOWhv?=
 =?utf-8?B?RVVDcHVJTCs3QUl4YS9DTS9scldmWGdTRmJncUx4U2N3Y2FJK1hYRThOekV4?=
 =?utf-8?B?bzBPazVBcUVCb3FGNzBZblUvcjVORnFEV0xRbG5HQXpTTmNEUjVvRWV6TDZu?=
 =?utf-8?B?R2VJMkl0NGFHaUlNR1FmQ3ZMVzhzUDlaOGk1c1V2K09kTTdkUlJDTnFzQlJt?=
 =?utf-8?B?djZ6T2RnbHVFMGQ0OGFSWDhPUWc1V2ZIYi8wcjZ0V3REUVdPQ0RlTjArb2hi?=
 =?utf-8?B?V3JBSGhyTGpWQ1RTZWtnbUdPSndNUTN0bDNuNnBRUnEwc2hqL3RTaXJUWVhn?=
 =?utf-8?B?ZVdOekVpZWoyays1WVRGb21MZUpPMHIrOGVDSmNxUEFTd3dBMkNZWVJUR3o0?=
 =?utf-8?B?M0UrNXhyWmNab1NhU3pGdUJsMHlwQUJGWGFrbXJ1S0FqcWJ5UFlkeitqWVpI?=
 =?utf-8?B?MlNSVEd2YzZyUnk1Sk0yYmtJTmhCVjNYU09odG05WEd0cHJ0SUhuZWJiNDh6?=
 =?utf-8?B?Nk41aE81VFRreW0yWlc5aFdUU29oelBQcVRaUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:58.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed35366-2610-4fa9-4a56-08ddf12353e7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7588

From: Ilpo Järvinen <ij@kernel.org>

These three byte counters track IP ECN field payload byte sums for
all arriving (acceptable) packets for ECT0, ECT1, and CE. The
AccECN option (added by a later patch in the series) echoes these
counters back to sender side; therefore, it is placed within the
group of tcp_sock_write_txrx.

Below are the pahole outcomes before and after this patch, in which
the group size of tcp_sock_write_txrx is increased from 95 + 4 to
107 + 4 and an extra 4-byte hole is created but will be exploited
in later patches:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        app_limited;          /*  2584     4 */
    u32                        rcv_wnd;              /*  2588     4 */
    struct tcp_options_received rx_opt;              /*  2592    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2616     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 166 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        received_ecn_bytes[3];/*  2584    12 */
    u32                        app_limited;          /*  2596     4 */
    u32                        rcv_wnd;              /*  2600     4 */
    struct tcp_options_received rx_opt;              /*  2604    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 167 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v13:
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
  TCP_ACCECN_CEB_INIT_OFFSET to latter patch

v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp_ecn.h                         | 29 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..5a2b0af57364 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -102,6 +102,7 @@ u32                           prr_out                 read_mostly         read_m
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
+u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b8432bed546d..012d01347b3c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -306,6 +306,10 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3]; /* received byte counters for three ECN
+					* types: INET_ECN_ECT_1, INET_ECN_ECT_0,
+					* and INET_ECN_CE
+					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index da0b355418bd..1a41a459aa07 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -171,7 +171,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -191,9 +191,24 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+/* AccECN specification, 2.2: [...] A Data Receiver maintains four counters
+ * initialized at the start of	the half-connection. [...] These byte counters
+ * reflect only the TCP payload length, excluding TCP header and TCP options.
+ */
+static inline void tcp_ecn_received_counters_payload(struct sock *sk,
+						     const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* AccECN specification, 5.1: [...] a server can determine that it
  * negotiated AccECN as [...] if the ACK contains an ACE field with
  * the value 0b010 to 0b111 (decimal 2 to 7).
@@ -232,10 +247,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
 	return ace && ace != 0x3;
 }
 
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
+
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a387c39c9ea2..e4b7d6768d59 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5126,6 +5126,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5133,7 +5134,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8449a5a3e368..636a63383412 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6163,7 +6163,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6213,7 +6213,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6254,7 +6255,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9eeb33344762..f2f604a5a158 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,7 +472,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


