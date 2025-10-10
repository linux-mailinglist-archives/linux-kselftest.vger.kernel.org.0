Return-Path: <linux-kselftest+bounces-42949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB809BCD178
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1B2E4FD38B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E82F360C;
	Fri, 10 Oct 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="J0QLiB4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A52F1FE2;
	Fri, 10 Oct 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102259; cv=fail; b=Oxa3hhpPIoRRMszCf05cuNkTzucosEbkphODMJEXm20IRicxUcFoPg82U/w4x8HWKgYf2XFG3Fu5CnZBH8kOjQiOncmW3vOZQJeLn9PpjPF1qzaBexozRV9L+FXOC9LFN3noOf8W2Pa22UVRWoDh8lgzJ5voSuXJWKPCrN30k4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102259; c=relaxed/simple;
	bh=xQm8MLa7p2JD9L5oGMf++tNq0TKkUk66QS899RE+6Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA4cHt2mVBSOm6tkryMXIFgpbGwLaI7RBrRdg1ohpInODdVlsm8PtMv9CuZKx/a7Mhwv07K9BwUdJz5YWg5R3ur9bLc7o5/j4f2tfmlvmvPZcoIKjnH9fSuSola8S0tZoG392beNl9WWSh+GQ9EO+EYPg52vQW+93glyMNiV7wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=J0QLiB4k; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOOPesYZaDuZCYu4XMC4HkM87oyAamwW++/GjaeehgRDyaUd17/EnKsrpSG7r3LXQHmvJIcWnm0LLn19u5lKg12MkcVKcfm8qMzVhcdfO6b2jhC1yUFY231iDXfVcpVWwse3RwvI792u2r+JC2raWHXnJieVsfV5x69i7Gkh1gTEOBFWaWuW8zdNFinmultesD005PozJBwmJZk0Htwaa80F0dzl3qxhiO0EmvKhNJYdga678tiouTJBMq8LWdDNvTTt6G4wsxLzuB9ORIEVdSqr2NB5wA1ehya0qCkcOgPZN4uN5eVKlncyci7JKEbNS88YY/4Q7cqva4h6pzS3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiqTdhXOq2mMhAnl0NsYURfrTWV+EmIJRwG2vh4irIU=;
 b=e9XlBrk/Hlza/nHYk8PCUUkpG5Aj+BZePzDNjenfzaKC5aus1QzJlTDw6XX6aYtOGGfgjhUaMubTKaVHIjo4SvuPTHKX/tJ3tP8gxjjBg3P46dhw1m7tMUI8lJ+97aagI5T3e4d6U1Pk14+ydKBm1t0u5kdmXpbNYKTnriQkCIpMvZ/gsxqUilI60+nvTGZdEkivu3BlG+uYQexQPdHgIxlaFl7xFgR+qL97XkReFDxW1CeNH9MyTIBjCCx02xhyizichq/OBDPMr3j/0SDYtnZ8Fimj65DuMLmfh6uqz3naLKlofDuLoFtoTrO7lkzjj8oADFC+eBF4N76YHprjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiqTdhXOq2mMhAnl0NsYURfrTWV+EmIJRwG2vh4irIU=;
 b=J0QLiB4k/Ula7zzpiXjEnzCnQWJEgSK+o4xBv/vTN/6W2Y0efy1pypDPeX3b4+f3XdxXV07K6EEqjyXYbQxFniA6vqm+lK/JIA5ybr5LTEo8FBgLVNcFmrCGPUa0LfvERBRvSY54nAlvFrPZO/VRdBtrRjPCxGVfaJifw1AulqGUxiJ1bvmzHtUs8Rmmo1uiLksovOI0gGdmqnijeO7/IZEEFIm9W5ImPx7QOlha0DJ57OOmtFuIs19HyoiAru5HA9Yg+VwbeY/GOe+KO9QZC8VynZskl7WIHSrGq2zD0xPkgVq7qvaKflSMMu1aq51mZuGVvvTaF9Codx68fKQVGg==
Received: from AM0PR03CA0105.eurprd03.prod.outlook.com (2603:10a6:208:69::46)
 by GVXPR07MB9750.eurprd07.prod.outlook.com (2603:10a6:150:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 13:17:33 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::1e) by AM0PR03CA0105.outlook.office365.com
 (2603:10a6:208:69::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B7BE41C003B;
	Fri, 10 Oct 2025 16:17:31 +0300 (EEST)
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
Subject: [PATCH v4 net-next 01/13] tcp: try to avoid safer when ACKs are thinned
Date: Fri, 10 Oct 2025 15:17:15 +0200
Message-Id: <20251010131727.55196-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|GVXPR07MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 370cba1b-bf5d-40b9-bbb7-08de07ff5f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2ZydEZHLzBxeHZjMWxVU2FYTjFVVzJKSGZUaXhHbVFTQWZ0aE1DdStPVWZB?=
 =?utf-8?B?Nkp0RVdyM1JvYVp2aXNuaU5kVjF6M2JXRzNtUklMQUVEL1J6YVFPQ1VDVU9S?=
 =?utf-8?B?WEpISVNMNkFuOU44TkpKOFdHYUZ4UFBMQ3VjZW5xWm15eUxMRU1aelp2RUZw?=
 =?utf-8?B?RWpVYkRaaStjbWRtRDNGb3hlRENSY2hXUE1FbGhtY0VPTnplS1Q1NVdRMzM2?=
 =?utf-8?B?ektFVDNidUdZVlJXeURiQlRMVXpBdDJyVXlvNlhJbldQTWprSWpSa2VBeVN3?=
 =?utf-8?B?anhrWFBWdE95TWhyeGdTU1E1VHp3MjdwbnJpczU4ZzZXRGtVR0JVVUJ1bVo4?=
 =?utf-8?B?cWNxMEpMM2JvT2drcUptRzJ1SlJPNDdCRmFsbnBXb2ljV2dEcjAyUHd5OTBU?=
 =?utf-8?B?K1hhazY4WVRDTkh3Smd3ZFExNGhhSGxid1lOQUhIQU5rWXJlblJJQWIxaWVP?=
 =?utf-8?B?b2J3Qk96V2JIQndyU3dsQ1VvTG9NSUl1REZ4ai9CbVVwYjl3T2pGdUdkMjFk?=
 =?utf-8?B?dXcrekJFQWRZTldBQk41VmkwVTdHSGJHODRYUHBUNVFMOHdhS0hWdEJsTWU0?=
 =?utf-8?B?NkFjMzE5Q3JmeFRuRW1OU0lzQ0ZXUm1CSGZoQUtiSGhEQnY4cUNVLzJxK3N5?=
 =?utf-8?B?dG9jMFdBeE82QlIxTEJFclVxdEZHSG9XaTlJY2NwV3g3ejlvejV4TEJta2VO?=
 =?utf-8?B?UUk1aXNFS002MmFXV1Btcjh2b3k4dkUyRUovV0V3Zm5Udmk3K2ZyUDloUTQ2?=
 =?utf-8?B?VWxhWmkzTXNFZ3dOclIwWlcvNHVSN25QQ1YyVFQ4aTZla01aNmp3VnhPZ0tB?=
 =?utf-8?B?czRwdG5sSzA3dHlRRnp4d1dyQTRlUTkvL2NRc1JXUjNnKzJPR1ZXajBKL2d5?=
 =?utf-8?B?Q0c2cmYxN1NMQjlINGZCN25uekZybytkVWxpVytsSkI2L01ucVhEYmtsdFhT?=
 =?utf-8?B?QTRpMDUvZlNHNXo1YlZHRVAzOUU5RVc3c2M2dGwvWVhRQTlzVG14STc0Wkd4?=
 =?utf-8?B?ckpCaWh6TXhoWTdYU1RFb1hOcHkxNjZCOVlaa3gzUHJWQlpISkRuL0FpaXVG?=
 =?utf-8?B?cWM2Y1BTK0xsRFZ5VEtXOFBvSlRNbjZ1aGJnOW1IV0ZKOHhBSnNnR1dJb1p5?=
 =?utf-8?B?SllsMzJ3Zk5meG8vOUI4VWpUTzJOKzZncnZmcWdPYUEwVVJTb3BEV3VSeGwr?=
 =?utf-8?B?ekhYeEFiOFJTQTVValZsWFVOWlUrNzJ0bEhnVEZUTVFlM1J0U3llZXhFNHFP?=
 =?utf-8?B?YmpIWU9TU0RmTFZMR2R5WEZ0VUwvR09DcVJSd3FuQ0ZhQWp6OWVBV0l6dnpq?=
 =?utf-8?B?bVlybHhZc0VSYnJpVk14MXRTQzBnUzkydm1rOGFXRm1YNmV6WXRXZUFCR0I0?=
 =?utf-8?B?U1NabVF1M0YyVUJCUTdOSUlRQUtqanJ4VHMvN3pMQmlXYW1MU2hwbVNVTFc0?=
 =?utf-8?B?bnNvNXNMUzhsRGFPZTJjbUVQSVpzVHR5WXJWbmF5RzVsT0FQTldtSE1sc05t?=
 =?utf-8?B?Zk01UTZadFRJK09EeFFUaDJMaGVMU3JyK2dORHZadityeXphMDFjNzV4aURj?=
 =?utf-8?B?NmorYTl0THNycGwyV0doVGFnd2tSNS9Rb2VLZ2hnSGF1RGczeU1xZHpBcTJv?=
 =?utf-8?B?MnRwVWZidXJWMkNCbFZ2ZURQdTEvOERUdjJEZ0xpeFczOE5WWldMRExqa25C?=
 =?utf-8?B?YzZ5SVZibVFSZGxxMnlrbDJJbHBBK1NBZHd5dWxxZ0F1Z04zZGx6cWFCMTll?=
 =?utf-8?B?ekdmRUV6MDhSQ0xLOVR6VTZaaFp6ekpYb3k3SHVzc0JFSjhrbGtjVUNqQ0xz?=
 =?utf-8?B?TTgyV0x2a25jOU1PeHNHY2FXTUJ4dWY2NVhJWXpXVFRrN0hUOXM1WjRIcTZj?=
 =?utf-8?B?TEU3YlF4eE9uQ3FHUWtEZ2tKRVBIZHFCd3hnMEk1Skx4SG0xLzNiMkgrcHBz?=
 =?utf-8?B?cGRMZWNlMHJQL3lnRzIvSzAzbU9aQ2FZZjRFeGhoazAreWtIK3hUb1N1VlR0?=
 =?utf-8?B?WjU4R2JMNllCN1NZQnFhZi9tcjl0Qi9jWUlNYU5TZW1uMXhvQnJaOUMvTmxB?=
 =?utf-8?B?YVphQWU3aS92WlhFTDU4T0FJQ2hCRDRHTys5TDRnQnBrbkJWTkt2anExSDlX?=
 =?utf-8?Q?Y+Nkuxtl1kbV7nAQHfFeekBRr?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:33.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370cba1b-bf5d-40b9-bbb7-08de07ff5f7c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9750

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
index 8a18aeca7ab0..f68d2ba619d9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3419,6 +3419,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5180,6 +5181,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2d..8af527f4e2b5 100644
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


