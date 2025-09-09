Return-Path: <linux-kselftest+bounces-41036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C158B4A614
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ADA18845C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75F280332;
	Tue,  9 Sep 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7+NoyFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC12765DD;
	Tue,  9 Sep 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408022; cv=fail; b=s3VOYQeNHGGfA39+YFZuPqHFTsgoZ3BPMt+RWfzoS/sZ/1YnkkBt84ZOrKumlagrkURBjOfreyv+sVcfEby4ER/y0oMmTnQYJJaB5USmhe+AnHWRCypPqInSjMVU1AprQ+RPwEoLneVK2lqAU6ShrqmWxq9zHEQyybevuN6nECA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408022; c=relaxed/simple;
	bh=aL97GVxM//EIu5XcWNXoEz5L11oBOT8ulClsSSRe1Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLvzgRtXQIFds6ml14AsUpC5iv/dBaWjh8nUXgyV61t6KjGW1AJSrHeVCMC19cmEt8lZeYjZnaw7v3AVx0uXCexbT9DYQdZLQkiUW5ZM2n8mlkV1jGqxt4ze8bntH+nbcrTT2gikdF0eV0D7zz7shql47BELFFxRFdQiOW1VRSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7+NoyFG; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT+9KIv1PJKRxKcDScD+8dk+Ac9fGSt8bC1/G/9WpGvOq6ta70XeT8tWavCU4ov4Q9YxKG8LqrT6D0t63hfecoazuuDZidb7NmSkY5RR1Sgk2bsFhQ+Z3Wk0tJizfTBf64G+j9m46T1vuMyBilgHn+BCB8sShqCup3onYgRN/g2RLyKY9GwvKgMaGLLjE1lDjDD/Rb0P5X/5DBM0ijv2NUi/Kg3C3kWhyua7P02OwFf4UzGiqJIfl001NnGU64ZKhExK4CSD7s+k59sLT+0Ql6bj5u3O52vL3JvU0mgAoatkFVR/a7b5b9c/r9z9D4vmeLJgyXl6y23mnfP2abv3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBQBw2IiweZKwkwCJ4XjCwgaNzKFpnWNkz2w1FLLSgk=;
 b=PSXLX+fL/xCWsbQOpx1NDU9H4ILBEJKN7VFDta+aMwn4nRilG7j/YgEPcHDhXcVuzLf8ShlXlP10SfMylagZmC5Xq5PX/lO/e3cUtCs3NBrHWq8+FowUGKGZr6hVipInKQgCE1ghN08lEtK/hFD6BAv+Ld9LqGfWo1cf0NJ8z6+6XJFV61w7HSFIK5c+azbrBIE7mSizwWsWTZy9CD/UrbnUSQf1FjP6SQPUNeGEW4AKnEbsyEga/QnOob0RoFPMceXSeFehyIukIs2JAv2Nssm2jIT7tYpbrF2j803l7VL3nkUyKLl8XDI+SqUGt1kUV6Ywh1qPnkEJdDUAcfgUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBQBw2IiweZKwkwCJ4XjCwgaNzKFpnWNkz2w1FLLSgk=;
 b=k7+NoyFGw/l1TBXLDUmigYyZTcNB3gbRXdpmC2gOpoKoTyCWFcPRD320ohEXevx6H8pQ7fO8tcqzDG1awf3Gy0ue1R591kYbMyz2KrlfnoN6/Bz6+hnSHPCJYeCunV4G/3j1182AuNO/EmQ8Tp/IlRCVjsVXEkPxi0NcN+DSt6oLgfrarrz8qEOCIEEcEzw6appsFEVaZ0sNdraFvC/8DaIpK94kZJ7gSJAS20ndYF/5PF6lR515gNudCb8dd5XR64XTsQIcyLFcWEba6n/vNHPLxhsQOQJ/d3VyAXfAt7OzFJ/3GRBaoVHqHDhVHNsEX9AsAGUQQf6kp2535yQ+Pw==
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:53:37 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::df) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 08:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:53:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:53:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:53:20 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:53:16 -0700
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
Subject: [PATCH RFC net-next 5/5] selftests: drv-net: Check XDP header data with bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:36 +0300
Message-ID: <20250909085236.2234306-6-noren@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d56a85-0b92-418f-c40d-08ddef7e5d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUGzcn9bF00whcncEgZZ2X6bQPbcbBfOCHRDYU3jkoB/CIkctwNl1XYRnvkx?=
 =?us-ascii?Q?Ker9rX4eveyny3OcFmjBM572IogebtnYvSRMzuaBoFQpQz/13gWAuv0Ar2zd?=
 =?us-ascii?Q?ltq0pJuFGDEAkVxReG9RjiLNFjCQKLHdLgzoGr+5iPop0kmvnCAfLIX8oxFN?=
 =?us-ascii?Q?tHlKoHxo3hbQC2pS8WnnBq4N+HAqk4jGDbfShzebJSEqf2lNLTibOEWTo5Tk?=
 =?us-ascii?Q?QYI5FV3XRyAQlRt2Ici00OfmIHcwD+iZDOldkKRJMWbnMP6ebm1rpweOHt72?=
 =?us-ascii?Q?8TCINBg7yfd5QXs/4otAFgbXMuv8rUN3hy8RjXCE5Qg9jU/Unh6nOP9AV0GS?=
 =?us-ascii?Q?3jsISV67j1GwofmkQIDqkCbwVmtcQM0MVKlbAZ/RsM6jv3WjRxziDC7jY/n3?=
 =?us-ascii?Q?XmN14HdySNa2AzChVa/v1Lqm6ugNkn/9vD8HpzJF80+4Z/cPUzpanBk74TK8?=
 =?us-ascii?Q?TIveuK0D6zb6QRA28HLTsXgn1W4DBtK22FXefzR1IrRdJVrD34hCNMUtUqZe?=
 =?us-ascii?Q?VwR4qK1hhdMDy744B2FuMcfdKESaeTTZK6I4o5DGgH12rEVSk/dulBKVEeuD?=
 =?us-ascii?Q?8skSk0Bev2w5aL68N1xYBtTMXjok2uHjDEtCELPYGUst5fviFQXC2hwu3dZo?=
 =?us-ascii?Q?JfqtNkCuqvnI0DBg/n4I1OTxD9pM/hIlQuHgmLs/Sw9cBp+i1FIyYkBVulWg?=
 =?us-ascii?Q?Fx5a6VtESSiwxyTuDIOSZtYPK/XgevCG7uIz+sgRa046Ye6GghNscbtdjLrn?=
 =?us-ascii?Q?yYu3c23Q85OysgeE/2R2XlIEoDUH7j3BWy41Rt/KGAxdDGCEXEJz5zjYiWCq?=
 =?us-ascii?Q?3gra/u6iIz89HrveJTbvzkpsF5zERryHjACj9NxwVyl5pkpg0wmYN6JHr28P?=
 =?us-ascii?Q?TZPxR5zusI5I7Hd0bIUnEkP56Vf8MSAj3qTXQGKDE9qR4tSDyvOvXhcdr0rG?=
 =?us-ascii?Q?L86Va7a3o/YxG6prcNubnhhb4Rg0l1GWPz9Yas3cGG1Sk3/8vh/pGuqllPoy?=
 =?us-ascii?Q?Msa/iJGk/QJFj5ZBuoQ2JtbMqwh4gHYAtw81yfDUWIB1a+5HErNna13Fu9r8?=
 =?us-ascii?Q?yCV4eBx441gdhLGacZL6lTMh6H3NM7q3gteguLwVVgb8WgHkjFNykd987PLr?=
 =?us-ascii?Q?Qt7TCZfVXBt7+04CZreN8DlWXACo+wPsyHl458PkVkUmJXUTNH+JCITV1VuI?=
 =?us-ascii?Q?63OnylajTr/jl8MptnyIcve8s6yKEBccja9l8Hx3DpyPB2RFuQ7k+Tetyyop?=
 =?us-ascii?Q?QGAMOAOk8kjhwtAF8blIqToc4fiomHHd9KCSnBlQuIOdLSj6JhmvtPjrzpSK?=
 =?us-ascii?Q?s10HtXzC4uFTiZpn0n/h+Pz58lQLgakTGhDXczgSNtTdvLBzbVGtZ2p+r0VA?=
 =?us-ascii?Q?JLfGpNO56dYrROa6jzHOYLOh8gX2DeIJm7jmlA3ne51/+gW4YYQKnUa7RmsT?=
 =?us-ascii?Q?M4rxI2LBlE4annOF0D60p6WinOUGSYivhFSqMTjcyCZfzjFexI2Jx85soPpt?=
 =?us-ascii?Q?3EZHahVUu0GZwAwkJZvbCse4aU+rTKLCmGJGkridm6g8mXms/m4PI0jE3g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:53:36.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d56a85-0b92-418f-c40d-08ddef7e5d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

Update filter_udphdr to use bpf_dynptr_slice to read the packet headers
instead of accessing them directly.

The function previously returned a pointer to the UDP header, which
was then used to calculate Ethernet and IP header lengths by
subtracting xdp->data. Since this only works when the UDP header is in
the linear region, rework the function to return the total header
length instead of a pointer. Rename filter_udphdr() to check_udphdr()
to reflect the new behavior.

This makes the test viable for drivers that do not store any
packet data in the linear part when in multi-buffer mode.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 80 +++++++------------
 1 file changed, 31 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index ff63f572552b..6df5164e3791 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -63,53 +63,49 @@ static void record_stats(struct xdp_md *ctx, __u32 stat_type)
 		__sync_fetch_and_add(count, 1);
 }
 
-static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
+static __u32 check_udphdr(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	struct ethhdr *eth = NULL;
+	struct bpf_dynptr ptr;
 
-	if (data + sizeof(*eth) > data_end)
-		return NULL;
+	bpf_dynptr_from_xdp(ctx, 0, &ptr);
+	eth = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*eth));
+	if (!eth)
+		return 0;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
+		struct iphdr *iph = bpf_dynptr_slice(&ptr, sizeof(*eth),
+						     NULL, sizeof(*iph));
 
-		if (iph + 1 > (struct iphdr *)data_end ||
-		    iph->protocol != IPPROTO_UDP)
-			return NULL;
+		if (!iph || iph->protocol != IPPROTO_UDP)
+			return 0;
 
-		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
-	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		udph = bpf_dynptr_slice(&ptr, sizeof(*iph) + sizeof(*eth),
+					NULL, sizeof(*udph));
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = bpf_dynptr_slice(&ptr, sizeof(*eth),
+							 NULL, sizeof(*ipv6h));
 
-		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
-		    ipv6h->nexthdr != IPPROTO_UDP)
-			return NULL;
+		if (!ipv6h || ipv6h->nexthdr != IPPROTO_UDP)
+			return 0;
 
-		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
+		udph = bpf_dynptr_slice(&ptr, sizeof(*ipv6h) + sizeof(*eth),
+					NULL, sizeof(*udph));
 	} else {
-		return NULL;
+		return 0;
 	}
 
-	if (udph + 1 > (struct udphdr *)data_end)
-		return NULL;
-
-	if (udph->dest != bpf_htons(port))
-		return NULL;
+	if (!udph || udph->dest != bpf_htons(port))
+		return 0;
 
 	record_stats(ctx, STATS_RX);
-
-	return udph;
+	return (void *)udph - (void *)eth + sizeof(*udph);
 }
 
 static int xdp_mode_pass(struct xdp_md *ctx, __u16 port)
 {
-	struct udphdr *udph = NULL;
-
-	udph = filter_udphdr(ctx, port);
-	if (!udph)
+	if (!check_udphdr(ctx, port))
 		return XDP_PASS;
 
 	record_stats(ctx, STATS_PASS);
@@ -119,10 +115,7 @@ static int xdp_mode_pass(struct xdp_md *ctx, __u16 port)
 
 static int xdp_mode_drop_handler(struct xdp_md *ctx, __u16 port)
 {
-	struct udphdr *udph = NULL;
-
-	udph = filter_udphdr(ctx, port);
-	if (!udph)
+	if (!check_udphdr(ctx, port))
 		return XDP_PASS;
 
 	record_stats(ctx, STATS_DROP);
@@ -363,19 +356,14 @@ static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
 
 static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 {
-	void *data = (void *)(long)ctx->data;
-	struct udphdr *udph = NULL;
-	__s32 *adjust_offset, *val;
+	__s32 *adjust_offset;
 	__u32 key, hdr_len;
-	void *offset_ptr;
-	__u8 tag;
 	int ret;
 
-	udph = filter_udphdr(ctx, port);
-	if (!udph)
+	hdr_len = check_udphdr(ctx, port);
+	if (!hdr_len)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph - data + sizeof(struct udphdr);
 	key = XDP_ADJST_OFFSET;
 	adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key);
 	if (!adjust_offset)
@@ -504,20 +492,14 @@ static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
 
 static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	struct udphdr *udph_ptr = NULL;
 	__u32 key, size, hdr_len;
 	__s32 *val;
 	int res;
 
-	/* Filter packets based on UDP port */
-	udph_ptr = filter_udphdr(ctx, port);
-	if (!udph_ptr)
+	hdr_len = check_udphdr(ctx, port);
+	if (!hdr_len)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);
-
 	key = XDP_ADJST_OFFSET;
 	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
 	if (!val)
-- 
2.45.0


