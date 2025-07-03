Return-Path: <linux-kselftest+bounces-36382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B4AF698C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C44A843E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BAC2980AF;
	Thu,  3 Jul 2025 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OZoVe9Wv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316D292B34;
	Thu,  3 Jul 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519933; cv=fail; b=PM6spZS2y+68BU8KVvfYrOKPnEWWyJEgwOY6bwM+JlzIhL/ui9Q5xTaXhDK5zxgsVgrtYtrryMhibUBChp1aCSuckVyZoNMt5E38po9ctRtwex6Hi/9/Aq5yAwGCaaOGQdK3rbglLgU69IcH2rIFYhtQfvHaHtWSnuYepqxDXNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519933; c=relaxed/simple;
	bh=ysCjso2UDOH7uPgndI9UFJIVtJHk2x+Ytu7mK9KrKiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPM4YaiKnMEqII2n372yLzLZwTDW7p0kvd8SC/KxjQT+WL1gyhZfO2Lndoq1uIeADPn75VFBwm5VsGGiINMaGjLy6B/2wc+83M1S432oUfeASMF3aKJCo/7xwdCG2TP3cC68XRMz3TTSLjAD/A84Bab9CzLuYl7dETFSaCHd6PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OZoVe9Wv; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEL3IR+Fy7hsnkf80dg6jlQkflIPq3JDOyMJaEf8githg7m7Nb/03Vnw5p9ubRM3vVn7VJyZyR+2duebnHDWMbcWPAqqCtee0u7QOwk4eIPBIjXJPRcJrB9LrRf56m/GjS4sz+wvJCYkmBvJ9BzxAX/nJ40H7TqPPrWNn3SFfAvz8OYjbA+HpSertQpVNUjNGaxFcTLumHbi3O2GzYRsaH3VJj890JA55NQA4RlUkBjIL6R5JItktMvHCtW3P0GxuvSw1Vq6zCWTIvWMoGJ12p19/RnrDC6DVuS9lXP0QiFpNRt7lWzfQOEWvLdutJt4kLKIvPnTLJPKU1tuYZF0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++RA9AWzdDUjOn71rWRtt1dVmfq8t/g2AbSCVVALcG4=;
 b=Dv/cXLYVmQ7nGAjP4fa31uaCLnw3oQ/uG28+rKW+wO7F7NjHwnnUHUX8EL9fCWiS6z4OKs5LsHBkBwPkYHEu2UaCyxC2K7evJw8dhQ/mCF8SwGowqSXshoBH5PykyuugetgIisGATP8UUhfiwydB3GGEv+olPgAv46WYqkfA6ZGtoF11Y92RcWBrTNCetnt5KMfe02OZL5orb9z+1r6sXL7yPFZdFQJoy5mDIQ7ixAoKk+LUHZXc9TkZ63Vbj/3YDKrnjj3+9NupFMug638ZcvChmVr2b4ID9xN6ZsGdh5nVUa9Oeu7/j+TL/U21iuwnvETNtBnyBIgSmJFbx7TEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++RA9AWzdDUjOn71rWRtt1dVmfq8t/g2AbSCVVALcG4=;
 b=OZoVe9WvHRlk5S2O8p6sO3U8MWxRXLZuLe2qEYjfZc7EiTt8zyZxA7wQxa45kMYVFNspqKNxQrsCTWZMLfhlT1JC94l4hBmxVMJGOI5EgvYwlVIAZxVz8n8BGVY6juUu3DHHJ3sHHFwWrgpPaw5heRqyOLf9Yl3JjMOhxk70lzsZkDVlNh4wYCJT31vSPUUlqkI2SsVE4/8f/z0j1k1K/KSBn7HIHxncLW9I7ekwoSfaReJUchKDsYK0ynpfv3k7wIepMA96/smIp7C6g1aWCzeGm7sMuJI/raSChr6yXdnYTrsxgIAgdaobomSqARMm1BgVT0rGZyo0drNxvqvdgg==
Received: from DB9PR06CA0028.eurprd06.prod.outlook.com (2603:10a6:10:1db::33)
 by PR3PR07MB6809.eurprd07.prod.outlook.com (2603:10a6:102:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 05:18:45 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::d8) by DB9PR06CA0028.outlook.office365.com
 (2603:10a6:10:1db::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Thu,
 3 Jul 2025 05:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B1437200C8;
	Thu,  3 Jul 2025 08:18:43 +0300 (EEST)
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
Subject: [PATCH v11 net-next 08/15] tcp: accecn: add AccECN rx byte counters
Date: Thu,  3 Jul 2025 07:17:21 +0200
Message-Id: <20250703051728.37431-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|PR3PR07MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 831db6b8-7629-4ee8-cb48-08ddb9f11570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDg0aU5XM1V2TFoxekI2eDh3K0V6cG5yandkUGRyWEQ2S2p5Y21pQ3JMQ2ln?=
 =?utf-8?B?anNSVzJsdkg2UjQ3ajhmMDlmeEpRUDQxZ2o4aUJuUFpqTDZrK09jNU5JTXVQ?=
 =?utf-8?B?Y3FhVHNwZFVTdisyakxOMXRaajExRWt4K3I3SmJLekhyaW91Y0xUOERibU1k?=
 =?utf-8?B?QXRtVndZUlhEekFXK0ZrNnJjS1p5bW80Q1hpSFZ0bVM0TTRieWV6U28vL1BO?=
 =?utf-8?B?VlFXZWwwNzFpTXZJUCtXc0VXSkdhOG1TYXJhcXhvckNKQjY1L2FFWUIrRGZH?=
 =?utf-8?B?dUlTQ0l1YnNMWmtMTjJtd0VVdmNLN2xSQzc2SVR1OTRXMUhpRVNPKzlaTmlM?=
 =?utf-8?B?a2F1cDk5emdHWnlhZlNuQmhBUWhPY3ZRV1V0WXBzQTZSSGlFV1paWmppYlE0?=
 =?utf-8?B?TlFWdThHc2lXcno0SEJTcHdFZ24wTnhiTmtyZzZSVzRoS1ZoaVVRVFZ2RitR?=
 =?utf-8?B?RVpXcE9OYmdBbVMzUm1hV2VpSWM5WHF0ZGFnaFpVS3VvUzcyRnVzVzB0dUk0?=
 =?utf-8?B?akZEY2tVYzIvL1ZpUHB6ZlpHRU1ZWmhIVmlhMlJRTUN3bzQzeGJ4Uk1DQWJL?=
 =?utf-8?B?VVZQTnd3RmYwSlRITzhTc0Vnd2lpd0V5TFZ2QXdDZnR4OXNEUmxGVnZReEhp?=
 =?utf-8?B?SisyQ1N2MXF6bUZwcGsyaG9zN2V4VUhGNHB2SzdsV1J2WUxMOXZyck0zbk84?=
 =?utf-8?B?U1hVcDNOR1NZTVZxSjRjNHhZMzFUamxGQlBaTzZwS3RiMDN4TGFnUytoQ2JX?=
 =?utf-8?B?NTZpeW92S1JFeEIzbG82WkxaYWZxUWxDY3V1YWxlQjVTYkJQb2FHTnMyL0h0?=
 =?utf-8?B?dGZHMENuTElWeG9kMWJLRW5LejN3NjlkVUlQU0Uzc0xFc1VBMU9FUEZNejVp?=
 =?utf-8?B?NnZNWWpkV0VJZkdXajN0NVNpaWpJa2JwR2pBWWxHN20wSmo0anU4Z1o1V01y?=
 =?utf-8?B?S0kwWUVWRmxhTHZKTjFseWhWMDZNcDNSWDdLOFVWMDIvMk5kZzl1cjJHRkR2?=
 =?utf-8?B?RlpYU01nK1FuTXltazB6RDJ2L1F3Ty8xZnJWMyttdDBSc3lDM05kTFdqSk1N?=
 =?utf-8?B?bE5IbDJCVVJIWGo5LzVvOWRqZkRaOGowUW5aR2daZ0EwMnNHZUdSa2dOMzgw?=
 =?utf-8?B?SnEvd1JSaWVPR05YMDRCY2svbUx2anNzazdicmd0S29ROGd1WnU0ZGNVYlM1?=
 =?utf-8?B?cmVpWXpOK3FmU3lXVFZtWjdyNDRSV2VsTWRGTW5ITlJGeFRNKzJNYUNnUTRF?=
 =?utf-8?B?UVd3Z1BsTFRhM1p2U29nWXR0NlUwVkhEYlRjUDJhbmdaOW9kUkJvUXNadGZ5?=
 =?utf-8?B?dERjRG1ycmlzOHZjMDNFSkJDdy9jYnhlbE9RK2tVaW54RG9kSDlKQUNyMWM2?=
 =?utf-8?B?UlYzTUF1cHBpUGhXclYyWGQvNmV2d0d3MkQ3eWhFWUwrMVk3Wm1oSmF2TVBC?=
 =?utf-8?B?ZEliOXNvMitFSE9TNDhQMlVJeDJUOUVBS3JkVnlPd0FKYlljMEVVWCt3ZjFD?=
 =?utf-8?B?SnlZQTdNZ1REaG44OXBHTGt2OWs3N1VQT3Vjd1JaMHU5QVFzNFFodm1QMnZr?=
 =?utf-8?B?TFB0azQ2K0FBbDAyUnJkd08wYlhKS2tuKzZrUFZQVTRlSWxKeGxJOE1ZZ2xt?=
 =?utf-8?B?Ym1ONkFGcXdvU2J0Y0VLdmFYQUorR2YzUVQyK1FlU2padlpjV0NDQzZZVDQw?=
 =?utf-8?B?OU1RWnlnL1B1K3hQcjlzVnp2ZjZTeVZpZDRucHQrWlZWd0JCUmxWOTIxMkFB?=
 =?utf-8?B?VnJWV3JlS3NONjY5bkhvQnIra1pRVGFjRUp5ajFaaGFBWFUwNGs0T3lUUG1M?=
 =?utf-8?B?bjAzSFZyK2tyNkdGaWkwQVV1OS9hMEVTK1JLVUJ5YWZSNml4VSsvZTJ4Sjd0?=
 =?utf-8?B?QW5tU0hkSFlnNFhGQ2dHTEJ3d2c2TXBva3hzRmFHaDdIVmgzaUhxMU56U3lP?=
 =?utf-8?B?ZFZwTWFaQU96emc3UHh5RlQzbjFkU1lSYjUraUFwY3BGMDBiUHNkVUtabnZw?=
 =?utf-8?B?TUpCQ1hheU9RaGQ0UDBnWHFDRFNYWnpwN1hrR095dXcvQWhXVURzb3N5T0h4?=
 =?utf-8?B?N3Z3ZXNjU1FQZW1qZHM4M3YzMnlIWHl4eHVuZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:45.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831db6b8-7629-4ee8-cb48-08ddb9f11570
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6809

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
v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp.h                             |  3 +++
 include/net/tcp_ecn.h                         | 26 ++++++++++++++++++-
 net/ipv4/syncookies.c                         |  1 +
 net/ipv4/tcp.c                                |  3 ++-
 net/ipv4/tcp_input.c                          |  7 ++---
 net/ipv4/tcp_minisocks.c                      |  2 +-
 net/ipv6/syncookies.c                         |  1 +
 9 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 22ac668fe6c7..804480d39132 100644
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
index 1d8301f2883c..0c2331e186e8 100644
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
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 61b103633da4..0d8e1a676dad 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -971,6 +971,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
 
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 7ac68cb70ef3..68e392ba2f9e 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -176,7 +176,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -196,9 +196,21 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+
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
@@ -242,10 +254,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
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
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index e0c1e951c53c..569befcf021b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <net/secure_seq.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/route.h>
 
 static siphash_aligned_key_t syncookie_secret[2];
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0548c74458c6..237435927b9a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5121,6 +5121,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5128,7 +5129,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7ccfde9bcfda..eea790295e54 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6138,7 +6138,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6184,7 +6184,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6231,7 +6232,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
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
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index f0b87a3268ae..7e007f013ec8 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -16,6 +16,7 @@
 #include <net/secure_seq.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
-- 
2.34.1


