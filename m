Return-Path: <linux-kselftest+bounces-40973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B0B4971A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F381893132
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64333164C1;
	Mon,  8 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="adNNdqHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77955313559;
	Mon,  8 Sep 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352875; cv=fail; b=k696YpX4BtnmyUDxyqcxfCx7I4gq7KlmtG1PYX/CDuJZ7IQLj1ZwrUu3P0n72APpl0XGokqUvbRoghQ/Gj8Y2RWi0y8oB5daZ77kQqQAg0AOlTv6ERJWK5r5bDDbgZY87YXbRxfa/ybquJY1DizT4Kg6Hfn2vBet+/aQ4T7M0F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352875; c=relaxed/simple;
	bh=vQqpwS7TwAx0pGEhr45JDuQZdOyD6Unr26mUzxzbDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEkcCqV/j2IepXAStQyYFn3v6AoHMQI0B6CsEp2tmfXjpIqfhseVMKnRHp3oocdolcsKw2QtnSDJN0xEREh+5Cnq6ApWAuCBFeS3Dz/MIW7bZSdm06w0UzBT7LqnvBA58vOXO6DbW1kxRJ/bY9XvDJVBMwguhWjsbhY3AZnhkvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=adNNdqHF; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Hb7f+HRTLiA18FBtArcZpMvljfdOfDb+bB2nxWd3E6hSzMo+RK9NSLHwfm9/Mz70J5XVgMqKiwdxnP6o0e0kICkXSBDhqdO+cIs2A/cKJlMo2li9fWpT3XHqQXZ6ba3ZD7uMJ8W56xAcP1otBVi4Hg4cTRSME4l05Me7byFAbZgNbpKxhBTyxI0Y1jxwOylBzVz3BNdVks1ErJ+1m/Qzn1TXEaNr+pmPaxyCx+UJP6EpovC95UN6NGuPlDCfqNJgN10chWpzGDE/osFQo/QKdiGi/3uoKK66U9s+iSgNS3R/C2nwELkuGxYqe66mlO7lF8YPq4TOK7Xo/3mawy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=bOAibZR0mizcBOMDV+gezgaxJIeDfVr/1UyEMOyG2GxUuW1cBtizP7oX1pK/Dd2+qTcreNQ8fZgBajMGiFqGXWXi+Cn//xqUigP3dAZs0A2aFnOdVLosKPAGNRT6TnztwTFkqRA9H2Z4+p0KpQ0jwKfAmSPIFJSeJZ6ONdD+oTL4yMxJlExnxEZmm2RsZV6tTwbUZOerz4Cgdx8VEwq8fq54VbKCvKMSAIXyGwB23ruk0cDGjZ3LZ7W09e/VzNglkvZgYukubEXfkQ33Jlwh229EF7yvWy/5Kd/bt/IfHTnbXp5ycxYLn52wJNuG3byEL3uNMhOzBq+Ur+tFcQeNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=adNNdqHFi0G1Q6fgGy9/Ti5Mp2t2FQwIgp3xJyddKcXJ9U4ccNgE2UXLu681yH9s0puV27iNivq/Txd5C67YirUhrAZnJ+EmiH8kEKmTzBJsqPJ9N/s3ezdwx5CEDwti2y6v30EdS3LZhFnb2tT5+oDktlGEI4IEbMjIUJlxE+iByxPw867XMmp1FUFBYbPyzwcn8vd5Tjo8Qt4N0+wMUZ37JixaafD83aSO4UBwwnD6tYBdZoHIM4rBCGXgxVIC1FcE7OmR48crEWuXql0gqhTtO4ZF8OtW6Lt5XarfetQZ6BwgbeF8T0gpuHMlkdwRFQvmxrcJBgkKTJEwnRhPew==
Received: from DU7P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::24)
 by AM9PR07MB7107.eurprd07.prod.outlook.com (2603:10a6:20b:2d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:27 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::2f) by DU7P251CA0022.outlook.office365.com
 (2603:10a6:10:551::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B0CF31C004F;
	Mon,  8 Sep 2025 20:34:25 +0300 (EEST)
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
Subject: [PATCH v17 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Mon,  8 Sep 2025 19:34:01 +0200
Message-Id: <20250908173408.79715-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AM9PR07MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be38201-a56f-4d49-d500-08ddeefdf5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVQvc2N6NVhDYnMrQW42SlBFZ1gwWUJtOWk1UjIrbE1ZZTdOMVI1SzdoRmVx?=
 =?utf-8?B?Nzh4NFpiL2o1YVRXSFhkb1F0L2haNjM3b1huMWxOa0hJYUw4LzJGSFlvdFVp?=
 =?utf-8?B?ZHZOeDUzcWhTeGVXcWtxeU16ZjdWeE1BUitZRVoyd2wvVWtHam5xd25TUGFW?=
 =?utf-8?B?emxoZGVVeVEyc0JRSEErenl4MFUzNGNqeUc4MmMvRlJxTW4yV0x2dWkvam5B?=
 =?utf-8?B?ZlhydlJPSkdsZEs2UGVqRmlDQWNqcW9QZmVySDMrRXNJTzAvM2RDNVpKRnRn?=
 =?utf-8?B?MDZjWWJzUWZZKyt5bzdHNCtyeklSK2lXbkVWYk1FUWg2NG1ZWWU3YWU1NGNP?=
 =?utf-8?B?ZkY3aytCWnQ3c3A3dmE3SXZ5TVE5ODkyaXVIRnROMnFZNEYvYml4U3VybmpE?=
 =?utf-8?B?K0ZBYlNvRjJ5RkUxQVYvUEdmVzJiVmpHeUM2RXo2UTY2bG9jb3NFams1QlFv?=
 =?utf-8?B?bHJPMk9MZStyQnZrUlVyZmRQSU4ydHEvamRQeWJSS24zU0YxWDNvcUlBdTZQ?=
 =?utf-8?B?MC8vbVBjdW5XQ1J6eDB2SVZjU2VGOEVZZEN6RWg0ZGxoQk8rVHVJZVZrRGlN?=
 =?utf-8?B?VnZ0YVBOTFI5dENYUHNDOWhPblVZZFQrZU1BQ3JDZTRIQk96K0FQekc2WTJn?=
 =?utf-8?B?QlNkUU4xeVh2UGlmVGo0ZzllNWFwclEraDhvL2xGZ3k2WHdsQTUxR2txNWFo?=
 =?utf-8?B?bko4Vm9rOUwwT2lCWUZvZklYWGU0MGZNVXZWNWNQS1lqU25EeEpBc0FMVHd2?=
 =?utf-8?B?WHNhM2Q5MlBiYy9EdHNQeExSY0tWUlJaU0RSdmUyRUl1M0s2TEtiTjMrVEtx?=
 =?utf-8?B?d1VnUjZKa2prN1F4RklGTVNCYUtXcHMvRkwxOEVkWjJzbk1Tb3MrLzYvZ01J?=
 =?utf-8?B?bmdhanhMNW1SRHQzTDdsYXNhZHhMMWt1OGtJM1VEOFRtajByRzJLNzloL3c3?=
 =?utf-8?B?cC9jV3YyeUc4TEdNOUJLMDJ6c2dMdDNLTDQ5dytSL1g2ZEJYd1NDYys3ZW8z?=
 =?utf-8?B?dkxUaEF1WlVYaU5ZYXpnMnM5WjBnb3Z2UHlnS1ZOOWpOcW5JV3lLUjRFemxK?=
 =?utf-8?B?Rm8vTDdyeEZFWENOWEpVVG9YYUU3R3d0ejcwc293Q0c3MEhBNWVMUHBYTmd3?=
 =?utf-8?B?QWtKcWFjREoyU3hRMG1OUE9PMjgxTzNVbjMxRVFUYXJId1AwN0twYlJoRlVq?=
 =?utf-8?B?OC9tTyswR3lTRm01blhYZUplRmphb1Z3dW9sS0FBeVFzd2lsSllrU3Z2L1R3?=
 =?utf-8?B?dHVyUkozY2hxVmNlcHdHV2lxNlZYN0IwR3FvYmpsOGZLUHJJL01DeGlEOURJ?=
 =?utf-8?B?am9FM0RWTmZRVFM4a2pLSDB3TjZJRnVvbTR4WHVMbVcvQlVvWWhOTlNGaHJG?=
 =?utf-8?B?TVcxOUJPSFFMdjVPMlBnbHZmT2t2QUVGcUE1dVlwNGN3TmRDR2piQXRBRDJO?=
 =?utf-8?B?Vm12L3ovUlhWakZ2NGZoeTBZcXBEMzFrTGdJYk1MM3ZBUFZnbXlJeUg3ZU5D?=
 =?utf-8?B?dUdTL2ZTUjNDWHhWU1krNDZVNGlLeWd5Zm9GcTFCVURJR0VJRFNWSkRWWjFS?=
 =?utf-8?B?OTJ5UEpXQTJsaU81ZGg5Qy9GdjRtdkZhYkFwVTJUSUxudXd0QlVNdGlxQnY1?=
 =?utf-8?B?MDRQY2R4ck5yaFhhRUJLS0ZVZmN1LzhrWis5NElKUXlWaUdrRm52Z25kOVg5?=
 =?utf-8?B?K1lidXNOYmt2L0JRNmpyeXcxcmxleHpaNGhqZXRtZXhzOGdsV1JOcGM0SnFu?=
 =?utf-8?B?V3MvTzlmUFpaVGVPdEUyOGpOTUJaRDRIcGh3YlFIWmFETHJPakdEK2tJbFk0?=
 =?utf-8?B?dE9EVlJZNkF6bkJhWlZyWjh5TVFydkZuZmtQS1VEMldhRXA4Z2JWSXJDSjlS?=
 =?utf-8?B?NldsL0N6TjZwbmdSektuczA2bHJVZzM1K2hMN3IyMFZFMHdTZEJWNVc0KzdD?=
 =?utf-8?B?QjhhUWEwamRnNUMrdFU5UThralp3Y2FMUmpIYU1rSVVYbXpjbUw3TjZJZFZy?=
 =?utf-8?B?SkhaRk4xQU1BMWFtUDROcEFFQTZXeHhsdnFHR3Q1N2dmaWRzZlF1cW5UUGdM?=
 =?utf-8?B?bjkzenArZThrVk5hU1o2bXJzc2hIWU1CRXpNQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:27.2702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be38201-a56f-4d49-d500-08ddeefdf5cb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7107

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


