Return-Path: <linux-kselftest+bounces-41032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C95B4A604
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FA03A9814
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A7274FD1;
	Tue,  9 Sep 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U7VX1ij6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD3274650;
	Tue,  9 Sep 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407995; cv=fail; b=HFiB1oY6AEJE/KBRuu+R9y5PEhzptE1HSclSPgl2B68UlzrirIhFzmODY+l1iUC87jlUTmOY73AlPyJnw2QD7g8on25IHOaNPqkhTfuA4gUTBv4pJWicP7pwUcO1sOZyd/C2PBuZSEL2eGbQgUKDPwCBt+MZdNjERrlR9R74xSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407995; c=relaxed/simple;
	bh=uuoEH3fBCbWrBNdr0SLD063RoKCHF6RZ5pnWJAbXtX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI5C/UijBdPv0Dr1IKI73B28upk8BWNcGuJYMxFP2Ggs9+mUwlBzdxuLj14S0mnDc4kWTE9WsY2Ps+hajFxTZOhdKRD5DFJ1NgZX0Oix2PkHjjhHt1vo2P145GrgewkNdTU+dse+ssnfT3rvZ8LIKKGRlh0g4wT8sHRQItAYS9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U7VX1ij6; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ1xTXyw00WOd6ZPfPrwvgdhpdtgSlqyj/wPgOAsNw34S2SiC+06pIdllmxdypfdtcQ0/N7IGyvvudv4IGh/FUd79uDS21WJmJ2hlPGhoSVQUrRMB7CxEV3xR6FPOPH4YHT9PBtfHTmlF00d3TwiG1QxM5X+Q8HR7xwApX0S0MMlhrS118jOWj7kLwskSqj6VxuUIRV3i5nKxCRWSaaSnO3YJpTAdwPeUoOgxu3jnEa27e6PxLLqWecJyiRzQERO+Zet92QiUtb4DZdV1QRsiDWdYyxAlamGogJcp1ZIATd2UrNvfYDSTaS0CLA8N067SeIT1oLYoAaxmMlUFz7PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onx+GB/cBKe33y1ZbnqjlvsjuipDC54kT76cqiNQ6+4=;
 b=g5iQ/ruXYqMZ/URz0Zd+KwMBZAdUAiSWxvsOIfCmRN/O+DgvN/Cx6l5Dqy7tfpuSQ3RYye1+se6S68ZowpYhbindqq8j1Q4WvIpnK2ipkth0C4WcMAiTvHp3pkhyJCEU9fLbbFZuhud5glD5zzKacZERoSBZu41AGMi/pRcDKlwQfw4uaxIMkwHgpGDd97E29odcDKN5S60V6yY+yi3U8W1gpAF83oEXrQUUud9jddGgygM4MRTcKn6dbIQOB9D6qLs68B5ODwHti2wMEtuznZ6eZbyUWQNIzcBl1gCcyafx+g8rOgrmYcj9+hrvzHtiLmpX2kJ1yHr/Pk/AEW1xKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onx+GB/cBKe33y1ZbnqjlvsjuipDC54kT76cqiNQ6+4=;
 b=U7VX1ij6bNsm9NPVsxjq8iGW9c7QOADHpsxW6cnvPi6WDClXS2yssyT/iC/kKRaBaezCr365n9GpnEF9GTPNUA3mu0K/TSpD41o+Yeh1Ye1GymyBWSpe4cV/7myVG5K6mUJ1XHlA374SsDTD8OPAvk5G4lp9mobQ3oi87PmvpOGJA/bLebhBWb0TlEprP/TU40l1hCQJeX1/Ipoegl8Vvl19dhE02ZhcklorQY57Mw+Pq25BD8CE1JrQyYv85JfJQuLU67qdfzY8Sdj4W5BK8LrrBEv5t5zsN0vYF4OWaBeO4imm++TgALU3nzw3NoYQOXfx7ESpO+c7Pvo2GeWupQ==
Received: from BN9PR03CA0095.namprd03.prod.outlook.com (2603:10b6:408:fd::10)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 08:53:07 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::60) by BN9PR03CA0095.outlook.office365.com
 (2603:10b6:408:fd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 08:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:53:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:52:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:52:54 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:52:49 -0700
From: Nimrod Oren <noren@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH RFC net-next 1/5] selftests: drv-net: Test XDP_TX with bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:32 +0300
Message-ID: <20250909085236.2234306-2-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250909085236.2234306-1-noren@nvidia.com>
References: <20250909085236.2234306-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1dd518-69ea-4e30-3669-08ddef7e4b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WoPKSSH9Rx/5Kv2xV0dH+Ip16n9jpny8uSnyZqvo3LoygwihJ+TIN+oz+hOd?=
 =?us-ascii?Q?sVd6ihOHVoB/WuRZOSNLRyPphYUxga/NBLz7XrcuAR7wNuX3TtsYxrHAzc0h?=
 =?us-ascii?Q?9Gos4vcW2OqPCqvhmWTdccbsFFBTrZOgHSgSN1xe73YKrRXcDd0//YsdjRL4?=
 =?us-ascii?Q?h+cWy47Cz8e8uhf9GAFM5kmex95iK+LcGQKz+FnqLOJgRl4T6ncC0p3XpMRo?=
 =?us-ascii?Q?pXram6QzeQbwHx8lc1DH1lRSwA7fxspgoPp6qJMD+8gAM84DoY/yJpYARPrG?=
 =?us-ascii?Q?yD2LjZJsWlsBjLxxEBX2tjAfX2uQJLFL9vDzcGJFxBOLNzoNjud65gGL9Ao1?=
 =?us-ascii?Q?7SbUN9jtRVKADecFoLlH7ZKwFNScYkSMDseDsfAfi0e8ZVBa1+wHZDvlOyfi?=
 =?us-ascii?Q?jvnbAmMQEnfyENvF0F1wGQHG1sY4s7GQvJjdbGFMG7SCyzy9cIuOTGF3Bfu/?=
 =?us-ascii?Q?qSco11PrDbRxjflR3CCcGxj+ypf+xf1g2ztz+/8evKkKb5QJs4smAVPwjzIj?=
 =?us-ascii?Q?IxJQAbXoAT8U3FqQUbCBNuVOzbtGLj/Cn91eLGrmILVF8nvpG8xLOnnO1tg3?=
 =?us-ascii?Q?2Vkp/p/vZds5EvkC4km0+vjx+1iBb7rjpRxNlLFRrGeX9BSY9Rib5UnUnp+h?=
 =?us-ascii?Q?hMknLKM+SkSJYnvHaaetRt07ChTeR4HbBc90smWuiRldjc3PtitHFWle2Zcx?=
 =?us-ascii?Q?Omo3aXAEjdRvBImUSrBXV1vRXFJXxC6/gDGTMWphUFXV7+e6V/B6BUS8onpJ?=
 =?us-ascii?Q?o7TvlATf9YDxSaPKjJUliRhPWPEDUHLwIQTOXZEfW2Jw10rG2rTraK/PMR3g?=
 =?us-ascii?Q?zoFTPjNn2YHwAdUmT4wgejvfE0z9UvVUc6kDP3tj7bTdWsOBkI2BmCFiyx0X?=
 =?us-ascii?Q?YQU2lxEqyaEsDa9qfZahk6Ds2NFnSw69sd4LjMo4alSdnuIWMN31ZTpLmsk8?=
 =?us-ascii?Q?v78PQtlcfOaKNwIrEtNz4robaZF0jWleto9gyhgXeL4kcikJ2hkQbBTk8iu9?=
 =?us-ascii?Q?g/0On+jF88kRICa40vIy2laANJe3oasjJoX7m0mnPW2SOj0k5dEIqqSXN9Nb?=
 =?us-ascii?Q?BTKh0a/qv+cm4yRzsjLl2MSwW9qWeAyAimAu8YbgxnDC05DcRkePbvEwm5r8?=
 =?us-ascii?Q?oy6j1y4c1WK+4uN8vzBSoHjfBcntcUrpTNhHZNWBYA/2KkqWPj00emBC49JQ?=
 =?us-ascii?Q?VI3zPc2rZALVVp1dHIndOXLkgaDtWyFFYD1xI7er8Hx2GkTUCPG+eVwh7BaL?=
 =?us-ascii?Q?CGmqDzKSCbHRQeIPhWAVq45kskU4j3w7ePPBvPI2MiQLk9BpXGR+fMpAlSgY?=
 =?us-ascii?Q?/kpO1NTgwq1hWG+GbMPNy/1w2TU1e8RkoklC3zjkQ+jLv2p15gE46KKCLUqW?=
 =?us-ascii?Q?Q9iXxQNhhvyiQ4T3Aw9Bhytb6OdYLtkZm//NzbAFdr0YckO6eTwm9GeTTAb/?=
 =?us-ascii?Q?OgOGxtr8def8GpRfGplYlqsTEdYDPYWMLLRmb92M1CLKiX14yehXePEYcRjL?=
 =?us-ascii?Q?SA7jpMT0QwnxlOsgyEKDRkKkoqrLAt9i4AdrJ7+Yiq85pN++Maee+y79eg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:53:06.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1dd518-69ea-4e30-3669-08ddef7e4b59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

Update xdp_mode_tx_handler to use bpf_dynptr_slice_rdwr instead of
accessing the packet data directly.

This makes the test viable for drivers that do not store any
packet data in the linear part when in multi-buffer mode.

While here, remove the unused local min() helper.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 49 +++++++++----------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 521ba38f2ddd..346cbba9afec 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stddef.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/if_ether.h>
@@ -9,6 +10,7 @@
 #include <linux/udp.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include "../../bpf/bpf_kfuncs.h"
 
 #define MAX_ADJST_OFFSET 256
 #define MAX_PAYLOAD_LEN 5000
@@ -51,11 +53,6 @@ struct {
 	__type(value, __u64);
 } map_xdp_stats SEC(".maps");
 
-static __u32 min(__u32 a, __u32 b)
-{
-	return a < b ? a : b;
-}
-
 static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 {
 	__u64 *count;
@@ -145,32 +142,33 @@ static void swap_machdr(void *data)
 
 static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	struct ethhdr *eth = NULL;
+	struct bpf_dynptr ptr;
 
-	if (data + sizeof(*eth) > data_end)
+	bpf_dynptr_from_xdp(ctx, 0, &ptr);
+	eth = bpf_dynptr_slice_rdwr(&ptr, 0, NULL, sizeof(*eth));
+	if (!eth)
 		return XDP_PASS;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
-		__be32 tmp_ip = iph->saddr;
+		struct iphdr *iph = NULL;
+		__be32 tmp_ip;
 
-		if (iph + 1 > (struct iphdr *)data_end ||
-		    iph->protocol != IPPROTO_UDP)
+		iph = bpf_dynptr_slice_rdwr(&ptr, sizeof(*eth), NULL,
+					    sizeof(*iph));
+		if (!iph || iph->protocol != IPPROTO_UDP)
 			return XDP_PASS;
 
-		udph = data + sizeof(*iph) + sizeof(*eth);
-
-		if (udph + 1 > (struct udphdr *)data_end)
-			return XDP_PASS;
-		if (udph->dest != bpf_htons(port))
+		udph = bpf_dynptr_slice(&ptr, sizeof(*iph) + sizeof(*eth), NULL,
+					sizeof(*udph));
+		if (!udph || udph->dest != bpf_htons(port))
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
 		swap_machdr((void *)eth);
 
+		tmp_ip = iph->saddr;
 		iph->saddr = iph->daddr;
 		iph->daddr = tmp_ip;
 
@@ -179,18 +177,17 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 		return XDP_TX;
 
 	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		struct ipv6hdr *ipv6h = NULL;
 		struct in6_addr tmp_ipv6;
 
-		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
-		    ipv6h->nexthdr != IPPROTO_UDP)
+		ipv6h = bpf_dynptr_slice_rdwr(&ptr, sizeof(*eth), NULL,
+					      sizeof(*ipv6h));
+		if (!ipv6h || ipv6h->nexthdr != IPPROTO_UDP)
 			return XDP_PASS;
 
-		udph = data + sizeof(*ipv6h) + sizeof(*eth);
-
-		if (udph + 1 > (struct udphdr *)data_end)
-			return XDP_PASS;
-		if (udph->dest != bpf_htons(port))
+		udph = bpf_dynptr_slice(&ptr, sizeof(*ipv6h) + sizeof(*eth),
+					NULL, sizeof(*udph));
+		if (!udph || udph->dest != bpf_htons(port))
 			return XDP_PASS;
 
 		record_stats(ctx, STATS_RX);
-- 
2.45.0


