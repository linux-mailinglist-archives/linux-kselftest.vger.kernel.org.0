Return-Path: <linux-kselftest+bounces-44404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B286C20A4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB12E1A24256
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CE827587D;
	Thu, 30 Oct 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jvdA73/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D978273816;
	Thu, 30 Oct 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834888; cv=fail; b=W6DcYPjTAOiWdzyT4Fmax9Q73MkmmVU58i8vMx3UbT/xzqUy4WIluJ+EJsvlMaKPABsoM4+9LSjeNdJILUGbrhgXj5eNYu78lhASuLyUsl282dtHr+MSsgQKPjf78XLHDYzmzj0/A9BOKJatd0Co8J7IhZdhc9RLo+qsIrv+YGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834888; c=relaxed/simple;
	bh=gl3KYdwFPr5kG5ylpWJ49KOafH3C1sXGOstcCfy3vQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixpMASUaoc3X69Kf7SEDw5elvieid5eo5rP6FCd8T8z/KktmiFeNdxc+UeEiGbaIQYhxzixR8ZCawLQFQTMbGOpqfP8UKihnznW+7UT4SmgysxguTMhp51lg+06DpHuogtLY57JMRiJ4uU1z2NJgjXd7zC3LHsZ73vamOSdAdTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jvdA73/4; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAeY/rQlL43+Alj/66Em1xVgsuj66Dhzs817ExVRA89EeCfJmwLZx/xLjkDQSOxN3PwXj42FQAeIfUyCaB/vYjOIouaUqzyRgW6oWKVKRDBfzbffDHslNGYdXV9oVczMKU55m0kRYtTbIS5mcACi/NjFWRYXVVAwS/lNbwke6dQBYfwAM7er5VgNkofmIBe2/aFN7YwwHYqO7qM9rKRbnihl4OSJmrTvYWZZXRveHWhjYwA/aH/9BoOZg0ksxuCw2OHXQ1U1+/L0OWrGedeSkmt3N16S5HV6WC6s5qX9/FHIqKVnEggCbH26tmMwYFfkjKrsFrRhPIuwHqdOUVOPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7463pAfxF/t63kgtwYfAhr0jj4/tftxhp/gxfR2FA9I=;
 b=kmGSDC3/wC9Ta4OJgtFJkdSx3cir8sea05uzML0lqbMpTevEYE0adm3ZQNvOGb50uzbiVtbIXL0CmA3zH0lVi0pfVndRw2egrzRKwYU2wZT8DaMqX9Ds4Y0OWcgfFGv00FDKE+iy/gH01yaG+3KNbwVHO5nQeDA6lGh7/9+6ejq7IZiHBH/BsAHVlPSX/EST0DhVup2ggmYzixeuiTlcWSewq7kTzeqc/Rr9Oq4KHgSTfhvFeRLTMHu4wpfKyo32cVQvCcxHmsAeQDmhSlJjY6dEUq8WFWJApRdDPhIjazhXNToSn82AMQtNVGeFz2hfSV3IBuCKB3GJXhbutrNBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7463pAfxF/t63kgtwYfAhr0jj4/tftxhp/gxfR2FA9I=;
 b=jvdA73/4rvIEjm9O72p9tBHsBAtB0RhUQsD2nFV8Bm5bLohR1qG2MTHq018GdIQqcEV3/Fvvyx0vW/MgyWMTa6enYU0xgpEDR0uoMkZmCFQVa6amH9yiZFbFt7/Nlkpu4C8LONnjP9uRp0ETSjZr/Rd12yGyF7Ls5YNfAt4oFrs1IozLlWYgeeR5yMyPQIdRAxhukPCgXYPAY3F0CbwQpfgSTMGaQNSYIiwbGjvmWUCbsXR6QKv0fP4oA3pTewBzhDgNBcGmPNrCIl/NBZJ/PVPRQV+x7o3jb4cvVukm/uFMWNugtAphor+sod/yJz48jO38cFy6ZOL5pr0XQ+mzXg==
Received: from AS8PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:20b:31e::8)
 by DU0PR07MB10662.eurprd07.prod.outlook.com (2603:10a6:10:5a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:43 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e:cafe::8f) by AS8PR04CA0093.outlook.office365.com
 (2603:10a6:20b:31e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 14:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 69B63202C6;
	Thu, 30 Oct 2025 16:34:38 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v5 net-next 01/14] tcp: try to avoid safer when ACKs are thinned
Date: Thu, 30 Oct 2025 15:34:22 +0100
Message-Id: <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|DU0PR07MB10662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6075582d-10dc-4cbb-67e3-08de17c17576
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Q0E1dlJKRGpRZ2ZVSm9ISDM3cTFDQmN4TTE0K0N4YTRlK25vRHBRU3JnRkwx?=
 =?utf-8?B?TTFINkVxMmNLcm54UXNxM0FRZ25wZnZJWE1HYnZtaGJ5Z2trTlE1MHhDOEwx?=
 =?utf-8?B?aWRCbkFnSFlXKzhvUklrT2xONlZTZmRGaFRhQVYzd3UwZGFaajZpNlBVWi9T?=
 =?utf-8?B?M09SVDluUzBoaXA3c1g5WG4vWUtibmFuNnJ0NG9ZaFU1ZGtWZFdoMXg1dlFp?=
 =?utf-8?B?NzZpMFF3ZDhlOVRRWTZiSU1iNFZSTCttYUNZejhkS2hpRjdtR3RveW9GdFNZ?=
 =?utf-8?B?VVl6d21oTExibmRvdlRQaWhCQ3FuT0FFUnFUOXlxTFRkREdiaElHb3REUWsz?=
 =?utf-8?B?VG9zcGVUaVZuQVVOektOZTBzbkZZWWllQVQzZkhrZEZrWnFaV3pNTTY5MDRW?=
 =?utf-8?B?KzVRVkNGN3RuR252T1BvcGFxKzZ0VDM4UDQvbTZ2Nmd2b0YydURzTHF4Ujg2?=
 =?utf-8?B?U2hrcUhKbVU3RGtpZ1BmVFdZK2M2OXRQcHFtYmZ4QmNSVkFodS9GSHBYajF3?=
 =?utf-8?B?RXNrYmZyT3hhb1l4K1lCb3dtUklNZld1Vm1HNnAyOXFhM0VSVTRPUGtIY0hX?=
 =?utf-8?B?M1J6OUMvMVlNOUhDQWVyZlR6UzFtM2VXNG1EYkR1UG1MVkZFVzlLaDlrMUI5?=
 =?utf-8?B?RVlCTllhOWcvVkk0dXJWMWNFZ1V4VWdyZ0YwNjVqQ2tyOWhRSUNSdlRyWGNt?=
 =?utf-8?B?cCtpWlo0TkRDTnNzM0N0Uy9YWFRabDByQXp4MkVKZ3UrbXpGNzlHa283WG85?=
 =?utf-8?B?YTluNnZ0M1JSZVM0enh5SlJQZ0h2U005eFRjcEc2NUlMRlNXeHNsWWQ2QWtH?=
 =?utf-8?B?NGVwRkNQMjRWU3cxQVdQeDJQcmlaTUswaE9vOC9FWTQ5NVNOYWVvODl0RmNR?=
 =?utf-8?B?ODdNRjdOYTZ6Ny9RakxlNWlXYjJld0MvY05OdjVzdU9yc1EyVFJ4UE13UHEy?=
 =?utf-8?B?Z3Vrc2RMdzdEdUp1QjBPbXJBcWUxVDNROEFHdUxyZWpRSzRab2NUN0RGMm1j?=
 =?utf-8?B?WHg4ZTFkaEdRMGc0aWF5ZFlxTE1vdlB4ek9EbmdHdk0xVUczQTFrZHNiaHI4?=
 =?utf-8?B?d091YVFsVE85Z09RVW51NzBEb3JJRHNXejAvOE8zd2FYZGlrcGVvTThvUGZy?=
 =?utf-8?B?YXFJeEp1dTJYNy9OV292Z1ZBQnRNWkxIblZ4RWx2OTBJbkt5TnRlTXl6Y0g2?=
 =?utf-8?B?MzJ1MWZPM1B5OGp5RVF0VUFoQmwyT205b25DNXp5MFQ1dENTWk5NMWM4SkMw?=
 =?utf-8?B?aHJVWVU0WVFDRXFKMjY5SWs4QWV0RVJNUSs1VEhISlBHQ2tlV2EwTnM1R254?=
 =?utf-8?B?S3YzMTBnaWFvZ2UzSkwwemlFaHZQU29SUmRtYkdLMnNBU2ZPNEFnVUxyUVdo?=
 =?utf-8?B?WXdwTjhxekEwRFVnYUptVno5OU1BRkhGb20vMVEzVlRFcHNud3ZldVRJaEwx?=
 =?utf-8?B?enV2QXY2bU9MNGlPbldCSmNSWDBwVE1kUlcvb09ZbzltZVIybHVsdVNOTUJs?=
 =?utf-8?B?QTV1bDhFclNDZElQemprTjB2bC9pa3plQjZ1WjNtdGlzZER2QUptRzZqTHpU?=
 =?utf-8?B?RlA2M3JHMnhTQXpvS1F5elNtK3craU54VkNpa1ZrT1pRRW45Q0l0OVVhbElk?=
 =?utf-8?B?b2ZabldESjErVWVnbkM4VGdJQUU1dmh5QjBPbFpsVzIrNHVZbmU0bTZxdjJR?=
 =?utf-8?B?VFhJMlcrNndEVG1FM241WExiV0pMVFEyY25mcUxhdzhFYmpvWjd0L2lDdXhi?=
 =?utf-8?B?SGlWVnU2RzFMU0xFRVV5N1k0eEtEQklXZ1BlWlVsZy9xTnE4bGU2MUdYNU9Z?=
 =?utf-8?B?eUtVRm9yakEvUUt2emVza3B1U3kzNnpVTDJGdkhNbXlDcmYwY0hscXpCNXI1?=
 =?utf-8?B?UENYWHNGWDZLZXhCc3JiV0V2V3lYdWVYZUh1RldkOUF1RG9NbklyL2NRWG9K?=
 =?utf-8?B?emxNQUU0WkUrL1FkZW9aWjVmSzJKZGw2Wm1QS1pBLzNVb001MFgyTGhtQUJM?=
 =?utf-8?B?bklsbVZad1BocEtPVzFrR0lqU2dyQVEzcGhjc2RYNVBBL09uWEc3MGlaZlIv?=
 =?utf-8?B?MzdrbzNkbS96UXdiU2VJMm54bUh2bDFaT3UxVFVlKzlSbG12OEwxSEFhYzNt?=
 =?utf-8?Q?VEJgjdaAFSqALjY6LefhJ3Q4o?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:39.9112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6075582d-10dc-4cbb-67e3-08de17c17576
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10662

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a9345aa5a2e5..d92223954cc7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3420,6 +3420,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5193,6 +5194,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff19f6e54d55..f6e6f30c3d79 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


