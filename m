Return-Path: <linux-kselftest+bounces-37571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF60B0A625
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BEE5A7D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD852DEA83;
	Fri, 18 Jul 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RF+2YQn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B62DEA6B;
	Fri, 18 Jul 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848465; cv=fail; b=ruc6DUhXobQqezegMDwuLKUCfPJwEEbyJj0WAFXJ4v/Gk78Pz0gZ7MJP3ba9lPW+IKgS6UHOeF+qAeXzpfWPfzXn4j5ekX8WPFNa0iM5mTP4aUYKbYgyaq8sU8yxg7SmEz7KOgNmH2Vz8kd4zsQu/3ysXl6J/74aqB0vb29kX6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848465; c=relaxed/simple;
	bh=SSCPOjfKavBucykZA8fgCFC/lCNaFL37gPT7N0CnBUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz/iIqKsVNgVSjb9V/yY/t63Rwvj2cp7TaT9NoFlYQX6KK6FeE07l7dAR1yHQDZUs9HNUrb056OZ1EDZ1IlYSqLUawlJMnGTV98j/PBnvM9+lNddDOgEu/B8uzGFBbfKSHo73VF0nn0EdwjLhwLfhl3gUI4U2nTvqtpcAQblsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RF+2YQn6; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4zs/jovkoo2VkHU3mDNVChiUScDufy7a0DXuGYJBThAT/Mi0q9rT2hoGT82J0fZNb7mopWwPoejIr72Pew+rOQPMiH5K0xATSlBrjBmbX0kwL6B1GtNllMrV8jEmUvdyLhR9PmMZRqr+UfCy4X84iUhMKiLFCvibB/OztSkKI/ODNRK/cs02Hv+nGhRyuTCwt6fwQhrQGdyKoeA9c99Qv2X19bkCKI3q5BAKm5QndKvSZd29s0YzsvUqkyOKUEzam0hAvJtCQVBs4S16ODcq4EuQJH1ImOZ6kv++jBe5RtUlkhb7qLKnFp2X5jDuYJ6SsAQK1mjt96KA4J94FVJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2kjCJCgdtg422pB7XSR+7JiRUG/oQf6RLlhBriP0o=;
 b=P9Pv95uyEDZBBtP4KW7anw12lKPvf2kK2tsnitG7rV231b8JNU94RBO7vhHm+g2vQSBLpF5bzG793W2xhWiFbU3jE10Wp9+ekTwA1AJ3vexGaReFCSqT3GrMezZCHqU0VBUlRc4Wqjaf3OU5+lErpz7l03Tf41fsbN6VEtaZwL2+bhYv/d0RzXErxplHSpoX7geJ2/8CMa2kgKuI7H0HzzPHcLmGFrS+pWSkMPrMyydYk6ZSx6z4f2Eov8/Cmaxg29zQZLoxTDoRgDHv77C7l/ZhkF510tZgpynHZMLfqM/fhUeSt2JdzNHJPEvypOxi6fi0UIZJVfFUS61jYiztXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW2kjCJCgdtg422pB7XSR+7JiRUG/oQf6RLlhBriP0o=;
 b=RF+2YQn6mlvGPHJcGHru0XuoxNVFPoEeT3McZubGrlYyTBH6d1qArKPbuTfw9FOJuXhSClLGplLddqscOlG2122WXm6qRWSQHWFOPOdCsqMF+9fR5BxaNlTGbO90jBmhVPRPCgCokT3FlG8It/YilSj0ZIK+38dhZXrVrgfnFTlbDf0lKzbq73xoGQyQZgCBgxsk9WAoKpDFdhTawf2XL+pFortGsvqwgnSa0pnf/Do+MsYPOyHKxHHA6I14XIuw2BrcbXi1nYY54gAG775RNGL/6tqt+ZEQpZhCNHcP4BhyLyas6ZVtVl+nYw0HfW7vneU6/hssNMuNz2qAnn0GrA==
Received: from DB8PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:10:110::28)
 by PA1PR07MB10534.eurprd07.prod.outlook.com (2603:10a6:102:4f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:21:00 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::60) by DB8PR04CA0018.outlook.office365.com
 (2603:10a6:10:110::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 14:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:21:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 122F92003B;
	Fri, 18 Jul 2025 17:20:59 +0300 (EEST)
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
Subject: [PATCH v13 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Fri, 18 Jul 2025 16:20:25 +0200
Message-Id: <20250718142032.10725-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|PA1PR07MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: b72db8fe-222e-405e-c791-08ddc606521c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3E3ZzdodVVSdExtK2hpWEZiNnI4ZE8zd09FYjgyMDI1Y1o2dlVjb3RrVzBY?=
 =?utf-8?B?Q2tSdnVDbmY4R1RjZmxOVDc3dlpvSURXSjh0S3I0enVtVmEwY1dGWkoyb3Jy?=
 =?utf-8?B?dUtrN2hEYlVaTFFCRGdkbnBYa1VaZkJDNVFqNWU5Zm14NHh4ckRmaGZ4dVNG?=
 =?utf-8?B?TGF6L2dZajR6elVJUzdvUmMyOW9BaU5kaDNkajRoTUxsYzhvSUh3WnRMTkI1?=
 =?utf-8?B?SzdnYVFGcjBBbnRiTDY0VDVIQm1McmFYTitaUVFMVkxBZTB0RnArV3pubXU1?=
 =?utf-8?B?WjYxamdkWGtma1JVcFkvcUpFQzVWM0ovellNNWM1T1pBWWQ2cXRjU3Y4OGlh?=
 =?utf-8?B?dG9WbzFWZ0Y0elU4dmxqVGxITkl4THVXVGVzMElheEEyam9ZRDZSUDRhSXNx?=
 =?utf-8?B?bTVIOWJoSitwaU1iZC91dWI3SS93T3BrTFdoYjJ2Q08vMWxmM0tzcjI2WEVz?=
 =?utf-8?B?SUptRkRtMnBPbGdNNllneU9PcG93UHM5SmdDQ2pXb3lzTHQzOTBKMnluc0px?=
 =?utf-8?B?NjkzMUpsb3V4VnNyWWxYYjVWNWxxRU16SWZaRWw1Y0xHSXp1L2pPM25McXJw?=
 =?utf-8?B?b29QUndZTzdISlA5Q3BQYTZTV2c4V283MXhnSVVKKzQ0OEwrNHBLTlVqWHl1?=
 =?utf-8?B?cVhMa1ljQ1ZKbk9FN1ZXRG5lM1lVbE1oZzFVbmdheU5YMkdiNzl5TWpjOGds?=
 =?utf-8?B?MEx2blh5bkZzb05SS0hHbDVQTjR0MllQZi93ZG1uVUQyd1NjRnR0U0VSdm1K?=
 =?utf-8?B?YXhiUVQyamRBSDlTejZQeFRmbUhXcUNvLzExOSs2eXlVcjlTVFNaKzlPbktD?=
 =?utf-8?B?a0pPZjYvN0g4ZGpVdmV0R1FTUVN2YXUwR1pzR1N0ZWdMWWVmNFd2WVF0aWl6?=
 =?utf-8?B?ajl2cktCZFh4RzV5UVRTYTZxaC94ZEdHRytsbm1KYU1ZSE0yRmRHZDJTUVFM?=
 =?utf-8?B?bUkvKzBrRDBXQUJLMndGaHQ1c3E3a2RXN2ttQUdDa1ZhZGJpY2JqQ3JFRGVO?=
 =?utf-8?B?OXZxWEUva0xlb1c1czIxZDhCUTVOS0FWckUyd2EyWlQ2cy82dktBekNLTUpC?=
 =?utf-8?B?dWsxMWhSOWdvRGV5K0tzZUU0LzVyRzRuNStBKzFCdFRYZlJCMFpIZE1IYWdw?=
 =?utf-8?B?YkJrVnJWWlE0KzN6Z215WWQxVWlrSGU4ZXVFeTNoSjdCQVQxNXlYWFRJeC9r?=
 =?utf-8?B?VEhIdEs5WmJMTjV6OVlDZHRFMlc4QVdWdGE4eGVyS1h6eFhqZUdyM2UxWnk1?=
 =?utf-8?B?KysyTjl3RkxLRS9xNjF4UGx5T29RWTVSazFSbGo3U0pMQXNpTm9QTkxSbXpJ?=
 =?utf-8?B?SWJFR3dyUzZQYjhCSnBoMlZPQlVhbVpseUxCdUQxbUx3WmlBOG04bWJxTHlK?=
 =?utf-8?B?MWtzMC9ZdkduaU9sbWlkVGxRZlE1b05YR2pxbEtqY3F5RVRyNERGVU0xTG9S?=
 =?utf-8?B?eUVIVHFKU2Y1U0F0TTRoaE5SdjdsanNyOThJdDMyMTI2MXRWdnNXRnk2VFNZ?=
 =?utf-8?B?cnByMzdDVUlJSHFOTDBrSEhrY3NHV0hnU1U0ZnY4a2pxU1hVZStiMlRTQlhz?=
 =?utf-8?B?dTBUbnQrdVMxcE84dnpGeGsvd2xPVmtTM0laUXhTZzJzQkxTSmJURXNZckVJ?=
 =?utf-8?B?SmtQdDF6Y25jUnJ1TVNhcTJqdjFWR3VoZnQ0RXdycElpTk1MUjlrTXRKclJI?=
 =?utf-8?B?c2x3aXFkdkVueDN5R2UrRlFnTG56bGFpVU4zYVBZNDVWcnh3M0JIaTNsM2NH?=
 =?utf-8?B?anlWL2dlbFZmK0xoVFllR3QxRlRtakgxN3Jkc2p3cnVXa3NrUWN2TGZXNlFp?=
 =?utf-8?B?QTRseWl0aml5cVp0UW5qcm0zcFNXa3NGNTc4WnFUODhtQ1NFeTg0S1Zpalhz?=
 =?utf-8?B?Q3A0UGw5c3dtTU1kL1VqejV6M0l2ZGhFRytLMC9sUEJRYmxNM0xNOEIyelhG?=
 =?utf-8?B?UW9OTVlGSCtZbE1qcnllckd1UHJJTS9IcmxlWkdtS3hJZWxRQ09aQ0ZiRG9J?=
 =?utf-8?B?dVRPSFZwZlhZcmlsU0YwdjVhOEFtYUFjaUZCejlCVlZoR05vRk5OR2t5NUht?=
 =?utf-8?B?ZXBTVU5oYkpoWllnWGo5dFdXRlRxU01xYjVmQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:00.5402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b72db8fe-222e-405e-c791-08ddc606521c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10534

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
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 169 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        received_ecn_bytes[3];/*  2648    12 */
    u32                        app_limited;          /*  2660     4 */
    u32                        rcv_wnd;              /*  2664     4 */
    struct tcp_options_received rx_opt;              /*  2668    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 170 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

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
index d91bed21c885..114b0760ce51 100644
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
index 1367d003abf2..97b2dd79c883 100644
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
index 06390313bfb5..932ddff5fb7c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5119,6 +5119,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5126,7 +5127,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 35673e30cb11..064b26e2086d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6155,7 +6155,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6205,7 +6205,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6246,7 +6247,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 845b1c81b3b0..0a0ee33e38ad 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,7 +473,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


