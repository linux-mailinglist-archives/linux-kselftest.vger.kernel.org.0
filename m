Return-Path: <linux-kselftest+bounces-32785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5CAB1EE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546AD17E229
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F72609E4;
	Fri,  9 May 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eH+tqWDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E92609DA;
	Fri,  9 May 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825534; cv=fail; b=j0XxwIwkNAVlNQ71VIUku/LXN+GbG4kBhdcU8YhUeugThJXvOIL1MUTNm9uK5ItyDFgLsoz1unTn7vuDMkgFZhgfnNiCobMAtj1gadHxuNOtuFEP05wLx3nBYvzYCxQjiKm1G3vWyVaEj2gYPUC15c3KPXbHgqVkwrvuhWkeA7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825534; c=relaxed/simple;
	bh=wxvw3IhyRiSSdE8SNPEH28aAqhHw09n9tpshjMQaOy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ5YxbwJfOoXWcJj8jAjPNQwBf6K9sQ8KklQEZiIfKIP6wXKIsvdd1M6brgPEdzfYvsfFoSVt8obvwE3Wc6sMtOwemXsIAAtSAbTQbRQy9IbJRpyCMK00hI54fL+asz8MVw7DUmPbMzWaPF3B538P9zHMDi+gP4IgtUwpBmz6yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eH+tqWDI; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjitNoDjCT5dGGAInwCa3QUtmJzozlnXLjl6vy+GuI7MrnAob9kjOKy7Hsi7Wl/28Db/ywcuuG0aOWY03IAdGBgwrb9CRexEnmtRVXOa8Wmg0rN041p+yHV2V/lQlBDOqUBbK7aFtQp2Ckd8R0UIJZTWax5tUEQLHjgY8JTKg5stqeI3KSlb/TtF1IxKKCT9+851mZCXHB2uDowr3B0Y/vlElUBr9U7PVfHfPsAK/+8VeNb+XteMCKnkr9LA1u+vKgDhj2PrGAbggPiYP8rM3wBrwiR/8Z7TinuPGcq3lwS1RaUXRSqTSLkPMf7xvqx7rVoFhHaD92ircetpH6t9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zk+o1AubfTQcWuNv8xRZbPY7N7NoGaZMwdByUdXvQo=;
 b=PkIeBH63uDDigTqJobndn3teigBTQQZhk/t8J6Dne5CrGG3LUuIU6Q7/nMUwvrWAWUB0U+5gZbl87bqSvqB7FRTqUuquw6aOtyAJ0I6lrBk8XNLoPBsYLB+mzxH0uA6gN7r7rMf8NliuuAv/TM47bvLdtYGoma4JaFqdtS7hVfSQ03YLuoZ2YuUFwo4jxDumNZRiXOO8EuaDJAKk5qxL1+9GhMTzQswlLplvDvD4btIwekQCHZJFkuBtU8DDf5xYcoBnMr/R4CgNl9ZDRCSQ/BvYLvqaVx1aSwFk6luyLLqZbboIRdPTxpHMw5KWybAwwvTkljapgKHrZ+pIEZx3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zk+o1AubfTQcWuNv8xRZbPY7N7NoGaZMwdByUdXvQo=;
 b=eH+tqWDIku0L5cd+rYHSTMfXJMt/cbPbC/bjy4d5OptHd1M8LkyI1OLpQlPSbrSFrTLy/Kn1GQcScoSzvKCaukvWq61lQU5URRGVe6PbxVIcu1Rpjjxn5kd7BOv8WsbXYBjWNmo13sT3xLHaCcUY51Dt3w4DuEF86PdycUZ8zZQvg4Tt37XbjiMmQiqLY5NEmbAV8Ug0Nvgh+FJG/d0iYxbi/MV03JUDhy5pfLnxh6Hx8IUeLE77eLeXAcU8KrpNTFgnjUQfxW4Sor7/oMstP1N01uYmAHESs1aFoykkbY2ftDxpxMnko2Dqto2V8Vi/QuarE2k64Qw5qu5brsIKPQ==
Received: from DU2PR04CA0227.eurprd04.prod.outlook.com (2603:10a6:10:2b1::22)
 by DBBPR07MB7483.eurprd07.prod.outlook.com (2603:10a6:10:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:18:47 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::1d) by DU2PR04CA0227.outlook.office365.com
 (2603:10a6:10:2b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 21:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A89462009C;
	Sat, 10 May 2025 00:18:45 +0300 (EEST)
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
Subject: [PATCH v6 net-next 06/15] tcp: accecn: add AccECN rx byte counters
Date: Fri,  9 May 2025 23:18:11 +0200
Message-Id: <20250509211820.36880-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B99:EE_|DBBPR07MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: d8458ae9-e14b-4d8b-1faa-08dd8f3f1605
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N1lrTDlTWmRoLzVNSk54YThXTXQ3TittUnpZL0JxRklpeGRKOVp5TktIQXN6?=
 =?utf-8?B?V2NHU1N3Y05pb2tUL1kxbmFFZnRtWEpFWUZ4U2FPVGRqKzV5QVFNUlhIQjBR?=
 =?utf-8?B?SlJrR29McW5yS0dtRGZVRDRwNjkyWjJUc3hlVUNBRVg0NlQyK3VmbEpPYUJu?=
 =?utf-8?B?YzJqb01IQ0srYzNzSzhMTERoRlNtR1N6NnVsOEZneFNFZWtKd0RMY2MzNUQ3?=
 =?utf-8?B?bnk1Um9abm5Yc0Q0SEFDTzhrOURoNUpDT1RaQ3JNdCtCa3l0RkMyNXNpa0Ir?=
 =?utf-8?B?dWlNVXZFS0FHRjQ3a2xrSzNCaVFmR1JwRGRHZk1BS0FrM0tOY1l5UjJzVTBp?=
 =?utf-8?B?eUNQMlhWcHl5Vkpnd3Z4NXZRbW5JamdjWkxXbmJ3TUw2YVBvZWFOM0Nud0Zx?=
 =?utf-8?B?ajMyQlRVS0JCNzRpOVdXWW15K1IzaGNxSllyVzFSSVlRQWI1Wlh5ZDBzYm01?=
 =?utf-8?B?WEdCenA1TzVSVGNmazBqNGgyN3hvaEtBN0VCNkRqS0M3Ly9JcWJEWnVkdVFl?=
 =?utf-8?B?MG55N3hPSk0vWk5DRFR2QUhIeWJ5aG1rYVJ4YkRFQXM3aENMSVQwUjk3QlRy?=
 =?utf-8?B?ZEtjNEdhcjNBVHhqU3UrMG1XT3BlS1NaTmUvRVVYUm5OUVM5WS8wclpxbnRr?=
 =?utf-8?B?emwwcklHdThaa3ZRNFNGRDhCUUgyb1RxeFpYQmJjRjQ4VlgzeGF4bExKUmMy?=
 =?utf-8?B?cmNTRTNjVGhFRlIwSGpMMjJHdmpkMW95RkdVN1NkbXJXUjBtK1A4L1pReVNt?=
 =?utf-8?B?b0gvdXpFVEwzOGVDTTE0MmpvSE1pTm1GUkdLZTN2RWpCdWNBNnJwajgyTUF5?=
 =?utf-8?B?SEN4dGptM1dYZ2U3UEZ3cWtJVUFuT25nVFBtQ01NS2lEaFZIa1ZUZ25Fd0lH?=
 =?utf-8?B?MFFFeVhObjR2emJZYmRQaHR4MTRRbjBNcVJaTUVPK0RISERYNlJud0FhZmta?=
 =?utf-8?B?akFDUnpqb25sYm8rM1g2eGFuUnVQUVRoQ04zb0txM3FPM2ZMMzVheGpXNklK?=
 =?utf-8?B?dDVuSXF4M0ZOOEExTUxSVzZkSTFKd0szdlROU000VjcwR0o5aHBKMEwySVZt?=
 =?utf-8?B?SGM4bUF6NHZnYVhkSnZWaUpyNVRhT0Jqd3FuRi8rT0VhV2RjSDJvSFBMNjMr?=
 =?utf-8?B?ekJZdTRKL29qeXRRYW93TGVNd0hPdTZGQlRqem1LU2VQT2gwempGTFRlUHh4?=
 =?utf-8?B?REZrODdGekQ5QjcrWmZDUFRUaGtWMUc1ZVpacmtXVjNpc1VaZDlSdU10Q2Fp?=
 =?utf-8?B?WHN4M0NCVUhJd3VFTDh3SXJVc0ZEUmUrMmRzNWdhS1BCTHgyNlc3TS8wQ2Zn?=
 =?utf-8?B?ZjFUTzNWa3hNalJjS1hrQlZmcEpkR0NmMUkrM2Y4dUI0MHlZZmhFMzI5NTlz?=
 =?utf-8?B?RFJGRWRUZ1pkS05QRlVzT2dWem5KZ3VnZUJXRFA4WGRFRWdnT3dWelhoREJB?=
 =?utf-8?B?MmlIK2dra01QNmp0OVl6aWVuOTVGNjhlSEhIcm9PaU14ejBIc2dBRjErME5y?=
 =?utf-8?B?UUVVK0hoVXpYcjZLMmJKaVRnWHphdUZ0d2hhSzFLTHRESEh0K1pRYTZidmUw?=
 =?utf-8?B?NGl2WTZieHgycnBXeFpHeTBKVUczZ0toNzRzTEgwZHRBYVd5dmZVR1A5M05T?=
 =?utf-8?B?RUNlZEF0YTU1WitTMWJsR2dpNlRLdm00VjgyUURZTTFnOHZUOXBRdkpxQkFM?=
 =?utf-8?B?R1hzQzdMMXpaYWRUc2RNRmZZQkg3OHNOaUFYOG9LdkVtcnV4bmx5RnhtUGNx?=
 =?utf-8?B?WTZrL0EyT0piRHh0Q1ROQmpBdGtPbUJJTEQvOHMyakhXeUdNbGlwZy9uQlVw?=
 =?utf-8?B?N25iL2NvMUpvTzdHNGNXNS96QkYrTHlzMTR5VjAwL0hIdXhRUlRQZ3pJaHZX?=
 =?utf-8?B?YnFWdWF0MlVSZGFzZXZpTzZYSnM0NDFZUTZLUW5xaFRlMjY2V00ycEx3NHpX?=
 =?utf-8?B?cTY4bEtMOGpNMGsvTGVTUGQ0NWlnTXVSaTA4WFVGTVVTTnpVNWJYVS8wVHNa?=
 =?utf-8?B?eVkyZENWU1hsMXIraC9ma3ZIY0JBNU40Nis3aHhNcExySlhHNjVHN1ZXa3Uy?=
 =?utf-8?B?L2p1QytnaUZkNmlRNlNYdWlJRFVWR1UvU3FsUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:47.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8458ae9-e14b-4d8b-1faa-08dd8f3f1605
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7483

From: Ilpo Järvinen <ij@kernel.org>

These three byte counters track IP ECN field payload byte sums for
all arriving (acceptable) packets for ECT0, ECT1, and CE. The
AccECN option (added by a later patch in the series) echoes these
counters back to sender side; therefore, it is placed within the
group of tcp_sock_write_txrx.

Below are the pahole outcomes before and after this patch, in which
extra 4-byte hole is created but will be exploited later:

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
    /* size: 3264, cachelines: 51, members: 169 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst     |  1 +
 include/linux/tcp.h                            |  4 ++++
 include/net/tcp.h                              | 18 +++++++++++++++++-
 net/ipv4/tcp.c                                 |  3 ++-
 net/ipv4/tcp_input.c                           | 13 +++++++++----
 net/ipv4/tcp_minisocks.c                       |  3 ++-
 6 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index eef8700085de..64306ae096cd 100644
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
index b0e6a11a3fa1..427f2adab247 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -307,6 +307,10 @@ struct tcp_sock {
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
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5fce4b49e132..101e07b8a089 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,6 +1036,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
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
 
 /* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
  * attemped to be negotiated and requested for incoming connection
@@ -1053,6 +1068,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9340d1f2bc6..7396bfbe7ab4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5095,6 +5095,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5102,7 +5103,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 96 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 108 + 4);
 
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f0475f95e112..76fda2a63add 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6135,7 +6135,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6150,6 +6151,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6423,7 +6427,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6469,7 +6473,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6516,7 +6521,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..3f8225bae49f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


