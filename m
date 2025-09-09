Return-Path: <linux-kselftest+bounces-41035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C719B4A616
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB867B8895
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542C927B4EE;
	Tue,  9 Sep 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="haitldel"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0942459CF;
	Tue,  9 Sep 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408020; cv=fail; b=JWUTztph0R+DO6QRxcTU8/fxSSA0f9pKDddOTAWg5SL1GhdfIkCtUKEP2wQ+m9MTX7BVyu9/uUCoxrelQhxm0s4EOz6BClQO9MM9q7GZ+JF/wTwFX8z/O9hdltphIu7or4N2ndKgpFXfOWwaWY0/Z+X9RlnOFm06y8LRAaEF40o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408020; c=relaxed/simple;
	bh=eUOgDrk80J8xQLXPDHhJXezMCTA3j3aOqquEt6xEIuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGn+P7yJ7Sr11Ck9gPjEL7PwWJaqrG8PeL/maQ317YejZRL3VL72IJr167lnVbc8g9wc5KDIdCZL1ekn4gUw+3QNgWJoyrUKAEWrZN+gGuA8vx/5alzHTs4SNbyybYxAl1mkLp7SJiWBjvH3kPNRDY6pdrIMST/mr1OhOT+sbio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=haitldel; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PngBm89B0wivL+RSqECXcRtbJgMRxWP19jVFt5MGijqEqQto8YVo8kezzWJKs6sS71DmRktXrKmt7UxNgPMTfUNf8Se1KQ5p0kv7vikYA+55PUbzS0J43km0QJMMTZoxGgtHBqVhfTMF/634uZvvJ/Pu3O8OwEQi54D44+Nj+7mSm6ouSnsF2Moims16+9G1jlX0rMtlugVbRBHTSNJGADuAKyIVmVlt0WOFg9SOHhSNG5J3lY1hSAhszjqHnBqnppOk93iQVJj9IRakawnS1Ub1MaJl58niSajv/8D/GqYUQXUV5Gy+kd4BmsD6KLnteAw5FNsLn3We1B/Gh9w9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+d/OAsXExzGowwEYzypzydUaqzGi4KtXFN1QH6AdqI=;
 b=qGKShNseyH8E6bjfIGcPUhV9tG80+SZDQj2TOav9RFg2WwF6mwIDBl8dWafxA6hTDbaW0XyNfEnvJTW3aMu0j+RctcwpY1UvKmFWZWVcE7S6QAvwT1ts51oMMjquDKhHuk+OORP/iTPw+qwWBcmT6QNZnWg5G+EWfhyQhDeDNeNFZ68FB80Rw9FkdfHJDmY0Lf1fV2QZu/DeiifoG4H7kQWgA/SXRntxuMYnxIDVU50xsheQcsI1OAPNZflzGAaXzQQ/rR63PW0JB8zIigog3x4wCP7d5ZLQpaDLhSGMI1m9/ZFXVDG3R6Ey8t4aEV/WuhcMezns/cqQUCROYeO7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+d/OAsXExzGowwEYzypzydUaqzGi4KtXFN1QH6AdqI=;
 b=haitldel1wxWt6JgYGCIH9Gd0hBc9ndi+SCC8XSbCSrvx5egGkRL+s2sHap2vlOGL0uQqOOfNb3ioA1eRecH9iwh/zDn88D4I7Go91lhCZykppVBhF6J7Nu795SLE49Cpz/96tckyifuK+3Vy4F6MKaaHP6vqU20nqmmMw3G6pr87Ifc8pj4gCCJK031hzJA30MIOGasigO+NWJF0aDbg4sHJYCbXOrf/1An/EaLQuprZmNNSkBd3UjUeN8yhbJm2aldml1lIrt6o28vibfu5qpgt58JNo+tJtMZC99r4H+mF3F6TyxjTxg8kRXNqbgxT85fV5qCCVCsJH24axfE4A==
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:53:32 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::c4) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 08:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:53:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:53:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:53:13 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:53:09 -0700
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
Subject: [PATCH RFC net-next 4/5] selftests: drv-net: Adjust XDP header data with bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:35 +0300
Message-ID: <20250909085236.2234306-5-noren@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd66cff-9763-4de6-cccb-08ddef7e5a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjfWSAgYPs9P7Qe6e52j/kr/bXZrx1a2rQELHNnvbzUj9CXSdFINfwsddNZQ?=
 =?us-ascii?Q?+wKFHCTuoJQp4clt4L5aM152p/VSUcArieTcQgpjjXSVIuoTfuNxocKzugkR?=
 =?us-ascii?Q?fm/3bXQx4YR4rmDhh40/qKLgHlF3hohZc/PdCHEFNayJObLPgwVsQcLCN/e1?=
 =?us-ascii?Q?NtSNR8YoWzCh4vakLHmmFWzaEf+u4RmChA1xMpmRUS4ezm6CZplJVst/EKit?=
 =?us-ascii?Q?LWA6Nazxv1EHznD8TsnvPOFCnssvB20KSGIV4Wnwc4ncl8iYfCl3UxR9MPCw?=
 =?us-ascii?Q?J9Vae27GaCQC7/DdBfUEzh8IdqycV9m8zcHLV+zrt7vdpgGGSHK2n3d9pMCD?=
 =?us-ascii?Q?oJfqb/C0IjjM3xPIyL/MbbsotOuE63+3dOjiVHz/yB3bVZlVZNlzc5Ls80NE?=
 =?us-ascii?Q?VyABgKVwTJkjmQwy4kcZ4OrAdbZL2kSN+rA2MLZ1Ut40KdnVZh9aoo4CzwcI?=
 =?us-ascii?Q?/6Z1epRISb8PqvCkQjo/VkA15ch9rA5oEt4Peg9Mvyi6FxEY/GwCiEn2NKpA?=
 =?us-ascii?Q?nMDnvmdlUujZkAObwp16GAtwuRV5Qz+52Ux/KnTxmXeqE0LtaIBr7juUuOjw?=
 =?us-ascii?Q?P/7pMRRLsMO6cuFD1C1mn9wBFzSaL2htpb99L7AkLEstIP4ntyTxp5nDquzQ?=
 =?us-ascii?Q?bgdxtrHXexv69P6eG2oBZOk5JPM4/u5NqM68Q9cTZncUciPYjzFSnuN3vh5Y?=
 =?us-ascii?Q?lGJnziGyQdA0PUd5tMfk8YljILB+E0ve5ZRKdUbamOQXejRa0RGEUTAcm1dv?=
 =?us-ascii?Q?qFqwEQJGahgEWmZIhN9o1M8/bYWR06HOBQ4RkXqomOoKXURcf1zHBoJQSkTc?=
 =?us-ascii?Q?7q5L9qm0/+7u8Gr6JyqeJDrYvUMRavMlgxMdMqOu9aQrnSqEtETOmw1ZS9CU?=
 =?us-ascii?Q?w8tqaltUnhx76HLhwf6YK97oaJkoYdX7egzVPnWM1I2PQ8WqWYww2SYLiEg6?=
 =?us-ascii?Q?KMKH936Az5b3Nc0yg57O6NE+czgzUvwbJ7nOkLfuxeOPllJbE0YdzGZFcPGE?=
 =?us-ascii?Q?M8Op2GA7Lyy8OnrkYwB/2GviuuAEgzxPhXU4l4XbzTlAvlJwSN50ggTdMALp?=
 =?us-ascii?Q?9DJF/LRrTEd2C1tLSX2UA99saenhdaz3ixrwCYvin0e3oTd0XiG/vh4TZJkV?=
 =?us-ascii?Q?aUpI71iyX8CyJm9gs/BAvDI0UKEtxtT0t38mmJB4q0AAZNrdjtWQ/Y79xLRc?=
 =?us-ascii?Q?TxknPxMBOUcTtUOmxAZ5BWmWGuU3gZAVXpXeGPT1A0PQNxZvYI5UrXtRw6N1?=
 =?us-ascii?Q?3PHbx70nCElbQJXsh5RNT7wqtrMPA9Rof6ohvmjFyRJXgKe6zb0eLyGEZQLt?=
 =?us-ascii?Q?CiQOfkAjEtbh/mlWXsEAb1j9k3bCAhH+NCalKkc43ibn26MQQyeO6X+RyUZC?=
 =?us-ascii?Q?G5McJgYPdlEESY1aqJRvXBas/BzAwZo1BqVt+LMMQfjKqJtlBXO6P80oAiLN?=
 =?us-ascii?Q?Jled7Wxt3szQBw0TRs9rv34tLz+gbX2gv7MpQxjv0ZrO4H1f48gdFP4E3xCC?=
 =?us-ascii?Q?NMUt+nsYS1T4O/bAPsa38XRmSaRD4+EUHw/mj9f2q8ryXI7lyJHbXO3Qtg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:53:31.4634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd66cff-9763-4de6-cccb-08ddef7e5a4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

Update update_pkt to use bpf_dynptr_slice_rdwr instead of accessing the
packet data directly.

This makes the test viable for drivers that do not store any
packet data in the linear part when in multi-buffer mode.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 71172d32c529..ff63f572552b 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -208,38 +208,41 @@ static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
 
 static void *update_pkt(struct xdp_md *ctx, __s16 offset, __u32 *udp_csum)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
-	struct ethhdr *eth = data;
+	struct ethhdr *eth = NULL;
+	struct bpf_dynptr ptr;
 	__u32 len, len_new;
 
-	if (data + sizeof(*eth) > data_end)
+	bpf_dynptr_from_xdp(ctx, 0, &ptr);
+	eth = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*eth));
+	if (!eth)
 		return NULL;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
-		struct iphdr *iph = data + sizeof(*eth);
-		__u16 total_len;
-
-		if (iph + 1 > (struct iphdr *)data_end)
+		struct iphdr *iph = bpf_dynptr_slice_rdwr(&ptr, sizeof(*eth),
+							  NULL, sizeof(*iph));
+		if (!iph)
 			return NULL;
 
 		iph->tot_len = bpf_htons(bpf_ntohs(iph->tot_len) + offset);
 
-		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
-		if (!udph || udph + 1 > (struct udphdr *)data_end)
+		udph = bpf_dynptr_slice_rdwr(&ptr, sizeof(*iph) + sizeof(*eth),
+					     NULL, sizeof(*udph));
+		if (!udph)
 			return NULL;
 
 		len_new = bpf_htons(bpf_ntohs(udph->len) + offset);
 	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
-		struct ipv6hdr *ipv6h = data + sizeof(*eth);
-		__u16 payload_len;
-
-		if (ipv6h + 1 > (struct ipv6hdr *)data_end)
+		struct ipv6hdr *ipv6h =
+			bpf_dynptr_slice_rdwr(&ptr, sizeof(*eth),
+					      NULL, sizeof(*ipv6h));
+		if (!ipv6h)
 			return NULL;
 
-		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
-		if (!udph || udph + 1 > (struct udphdr *)data_end)
+		udph = bpf_dynptr_slice_rdwr(&ptr,
+					     sizeof(*ipv6h) + sizeof(*eth),
+					     NULL, sizeof(*udph));
+		if (!udph)
 			return NULL;
 
 		*udp_csum = ~((__u32)udph->check);
-- 
2.45.0


