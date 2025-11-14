Return-Path: <linux-kselftest+bounces-45613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D972DC5BB49
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B007B3AEFED
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC672F2916;
	Fri, 14 Nov 2025 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iY0OTS8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28E238C0D;
	Fri, 14 Nov 2025 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104439; cv=fail; b=qKC699D8GHE3iS/MPYMZv74z8CsuQr7vIQaR9dRuW16kgcRywCChN+ntoRZGTKUpShmGdR3eGl4k0PbMP8ExMrmoxYjWcw04HA/IaIN7I21eSbu72w2rRfSTfLwcZ3Ame6QMMPxDyCbqBbJJXg9I/8gYNbaMXIMyduTIIAIl/j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104439; c=relaxed/simple;
	bh=EkmOBR1SNbW4y+fmaZnhXUqWqddgse6McEQ5250g5mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYIDxZ3acAl2/VRqlSukg91fdkqV29T9MWrm7jWLIoTar7uVfhQ9vfVFQX5u6iN6930ctB1TyFpETc4AdzwxI2Iwa59z3TIUfy/bSVcjzyujlHYcN7sLKOz17UHZSGxO/DLwUctId9u9hQVF6z+rBoYFjn362ZUwBY/c7hHGn08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iY0OTS8Y; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcyxGLapkEh4EGqU2Ok0VIYnqPs4WMY1/i8DHGQEGvH8b5ceJ3gpDXwMGsPre51Z8h/KZEY+KUzs66N3wsdxrH1ViXvvw+lqVNcy4rzjtax2b1Voiz/kEKSbQOLtl+e/SkzQQWvTt4sXIANZzLyp9Ej2QumjY0YC+XgAXrmqnPpIaYiea+JycqKMkucqsbu2LsbDLUq9qCggPlgXBqj952A6jS8ietcnFOtljry5lQA9GrY+/EY4gPicP4ZTXlv5ewBpoN9gYczf2RuRWe816SnE5JUV0HkxLIJQ/M+dMm0EQMG5kHq9F/7OAZABAlbEBTzWIAOBvEjQzAZPynngDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESeds/ewHJQLRUbIPTW3+kBUAqvr/Hb4QqV/Wo2ctmw=;
 b=Cz+4pU/avKoyaMdlkyCbNl/LJk3SgqgOcxDZx1So28bnWwP6AMsp27W1zH+kg/H+C1w+LK0dBJ+vHXLEGraG3QfUWAjWO4wlkacD0oQbJ6yRb7nd4mEi/YEBkHoAlnpPaDHGbdC4jxEmMKUZzhb2IkLM7MBGorxtpKKdYoMDV53AyVx/RbPtPii7SoBzorXK7QB1ajwFVfMw6S4y0HV01DGyUaEl+m6LgT6uw7tpEuD+4So91Zhd7ekxWzLt6uouRyHd9FHWxyyHgNbGvwq1+76ItEktaeYASZMH8sfWTlvIrtnqN/USuIMELIv4S1I4CZw1bcaIuFOIMez478R9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeds/ewHJQLRUbIPTW3+kBUAqvr/Hb4QqV/Wo2ctmw=;
 b=iY0OTS8YcqOxeE+6QDusz3TNQPmOz2xlHCN8pThBD2MkjNuI2OPmM+qxZ59EA4uFmLS76XY+et5X6T7Fwqv7Jco9frTPFY3DDU/tUO8Cx9CtRG9rwkrkaxwnDpL9pwMJkweEUfz2okq+ihdBu7hq4JYajq3DZPajUy6EcV6K+BQ0vlDCm2IWETclQF4p2Nnohygy9UG1eED48G6a0B9pIImfKoiwWzHkcWCECDIh1Z0PVDrQN6NNvHnnpmXiKl+su0aG+TuSqSQ0hbKYDtHFdmcqSl5tXiYAlYGxqiy+WigqG2uUExB9skyoA4UR9BadcUC/hXtdfhnHHH6gg0b05g==
Received: from AM9P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::31)
 by VI0PR07MB10200.eurprd07.prod.outlook.com (2603:10a6:800:261::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 07:13:52 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::2) by AM9P192CA0026.outlook.office365.com
 (2603:10a6:20b:21d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 07:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:13:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1FE5F1C0030;
	Fri, 14 Nov 2025 09:13:51 +0200 (EET)
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
Subject: [PATCH v6 net-next 01/14] tcp: try to avoid safer when ACKs are thinned
Date: Fri, 14 Nov 2025 08:13:32 +0100
Message-Id: <20251114071345.10769-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|VI0PR07MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: af7a3fc2-c650-409a-e756-08de234d5de1
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NnhPL2gydlJKdnZMK21kMmtEcEV2RHIwcUhFYzJmQ0QxRVc4UTdhekc0TWdT?=
 =?utf-8?B?SDBHL3lIbFFuZDBNSzNmY1dNTktpWG5xZHh3Nzd4TGMwc2VjWGdRb01ZZzRZ?=
 =?utf-8?B?ai9GdmZvWTNDY1F3dnppWXFiMnZCcFVpcStFMEh0M0Q2UHNkdlJLY0ljZmJq?=
 =?utf-8?B?Y1RlQ1U0WWF3YVVXRStIZlduR1MzNTdlbHNuZSsyMWxCcCsxWktyZU9ydEM3?=
 =?utf-8?B?OGIrenYrVk1MU0NKOVptZzRoWU9sd0U2STRxZ0w1UlNhQ3k4NVhFMmovNzlh?=
 =?utf-8?B?SDNJUnJpalNSZi9WVTNuYkw0U3NsWU0zb2N5aDBrVXFocUZJTXhIbnMvOWNn?=
 =?utf-8?B?ZGhlWDZqS1U4Z2svTmJabHNEOFFEeUY5WUlBUW4yUTh0RnlqeGo3bFEvRTI2?=
 =?utf-8?B?eWpNWnh6L2phTDIvN1ZzNDFabnR5eU9LTmF6T0piRlVlV2JlWW5hcFc2UHFY?=
 =?utf-8?B?UndyMjcvM3E3ZTdtNXBwZWdscUZZcjVFZ0o0TFVqV29TR2ovVDNZckJsa1JH?=
 =?utf-8?B?Vkd0UXlrZXNmbWVweFNFT2NlZXNCeWtpWEtKY1pGckxuQzZZU1hRcWM3Tkdi?=
 =?utf-8?B?NlYvVEphSHhXZnpxUVJrTjkyMVdhSTg0ME81Q2xhOTRwNmhFQWl1WGhuZVAy?=
 =?utf-8?B?OFIzSzFxZWczNXhGbDVjWUhnWXZtc296eTd5VEFlM2VobDlsL2lyNnlQTDJa?=
 =?utf-8?B?V2RaZnlPMHA5MmFNemJhOFljS3VTNGsxUGFiZVY1UTdRcVZrT1BzdkNicFZs?=
 =?utf-8?B?T1RvOXdpZlNEVUpCRWtVVWlNUE5Cak5uZTRZY2lucWRsL0czZFF1bkFHcE8v?=
 =?utf-8?B?T0dhcU1nUFFOenl0YytZMDlxZGhwRzhyU0JERU1HYzN5QmZmWEhzSExFbEtM?=
 =?utf-8?B?WjMrdjZESlVUWWQ3S3E2NG9QUXBoSjhMVlJqa2VpWTJnbjBTRE1WSmdmNTJF?=
 =?utf-8?B?dFdXN3BmUkR1Qk1OYXR2ZEsxRFlVdFZyQit0dzV3NS9EU0lGMjhEWmJkU3ZC?=
 =?utf-8?B?YXFZZ3BWTGNxU2FlcFAwenNDQ1hIV21ad0xKKzhRYkt5dE1LNk1LWk9GQktI?=
 =?utf-8?B?NlFaMFlqT0thY1Y5cEdNWDVYNHNxc2dWUnZKdnE2Y083RnhqUHh1cTA4d1Vs?=
 =?utf-8?B?YXlZdVZ4TjF6dC9KbHRBNVVucG1DRmFrS2NYeUQxU2c1dy9zdXRFZlZIbWND?=
 =?utf-8?B?aUY4MUpObzFHNXVDSGdFRVBQemRXdmNvRlNSZFJlL1NiMW1ZWmdDNGlVMzFS?=
 =?utf-8?B?cSs4cDJFcUlXbTdVU1pTOWxHeWN5S1hiZUhab1M3QkUvdXB2OG9YUFBJbHVE?=
 =?utf-8?B?ckpXTnhKaXROcEVaaGlnbFByVUc2T2ZjbHhPQzZWZjh5UVpOY3BiOU0rendU?=
 =?utf-8?B?ZkdtNHAvVFArR2NWSXM0eFZTcUdDaEs1MGNnSElBQWt2QUYycWE2V0FsUm83?=
 =?utf-8?B?Y0ZqdFduS2QwMWlOZVZtN245OEZRRVBIdzhNVnF0bkpTa2VCTkJiZmpCN3Br?=
 =?utf-8?B?bnNjTFlUbTRXUjFsZngzRm9mMVN6V3FOMTBOVEkxSjIrVWVicnRBUXZ5OVpL?=
 =?utf-8?B?RTVTU0p0Vk0wK2MzcDNmNVdLQ3huaXVHQ3B3L3JxaEJ4QVdicGo5OEQ0WENu?=
 =?utf-8?B?Ni9EWGRHN01ZREovaVVSb0xYVTd4MGtxbk1nN3VmckRuYUxKKzFMZHdkdFRI?=
 =?utf-8?B?MkowaFk5OWdITk9vYTN5cHpDdFY3M1poZ0ZqSnVrelFMcnd4eHZyTDM3WDVS?=
 =?utf-8?B?OXZydC9uaGdjRXpjSFdpL3VBb3hvMFVUb3R5UTE5SWRJc2xjU1dmRWhCcXZY?=
 =?utf-8?B?WHJMc2FobDI5TGxkTU9Hb0grd0kyK0hwTlpIdHg3dTVtZHZ0eWJtVW5MZ3dV?=
 =?utf-8?B?M2NLbXJKZjlJN3NoRDJTUEc3eHFLMFJXak9YMDRIelFmTk5GOU12RlYzR1k5?=
 =?utf-8?B?N3c3M3VsMlRBNDZPQTQ5RkNSNGJZUmRYdCsrUHBWN3JCK3pVMnRUY1ZTOXF6?=
 =?utf-8?B?MmZzMDEwMnZTdmt2anc1MjFmeDhoenZVV29HTWFQejNpNmVCV0VmQjFOdWtq?=
 =?utf-8?B?SldOMjcxN243VDhjdSszVmwrbUQ4R29VZHZNVEpiaWhsaGhOVnhOQlJEQ3RK?=
 =?utf-8?Q?5rHUIuJps8XBG8UikipfZLygE?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:13:52.7038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7a3fc2-c650-409a-e756-08de234d5de1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10200

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
Acked-by: Paolo Abeni <pabeni@redhat.com>

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
index dee578aad690..ea28e6a73ec8 100644
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
index 9df5d7515605..eddd2e54d119 100644
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


