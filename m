Return-Path: <linux-kselftest+bounces-48779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E804AD146F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D8253019DF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705CB37E30D;
	Mon, 12 Jan 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RaiRRb+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DE34EF0D;
	Mon, 12 Jan 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239474; cv=fail; b=WZGcOSXHgw+D9L0+v9jVR7OsJ794RQqgJcYs2+csI8ScisEH7mwjjOoqEfGlp3K6RSoGQ5ZN4jEanJbCbykzFT3Q95SP1BfaU7rcnLyE/nsWNzWj3kVCTDrVJkJ3kEt5rLJAN3FWZlGLL0ZB+AU8ZktE+LYpltAcfNDkulE/arA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239474; c=relaxed/simple;
	bh=Rjnz+GBHVY7xc4kxEzU1Lv2P9E+xLJJoM9Ws8XGFo+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu2VVBctPl/HZGL1YL8npjdgeZ9de8wvNMlMih5lLKfV7tFE1G1MNWDdRieF0ytm7J9nEfb3RP5PGCuNVPcG8Nn+y1HibPfSu3w8QPLRYM4RACa7guGAM6ya+2YT4nYABNKpHVrBN3PL2jekKe9++5MJNApjmRhqeJ+2tVA7Igk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RaiRRb+F; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4FCYo2Bn7/1t32mzX/vW8owHu4FduyIWThIaIgmEOegebRhaobgBLtwlUPwJNGvsVNyJUw8JQzl7P1OPEJPXR8Iw2LQ2Ezvqvxkfssz0zk+0Ac8cffFcCpFkYdUF/eIv6zoogei1xDevm4myXrMjmqGMxNG0UfhX2gUteBlycEQJWhh0KP9bGpUJhEp8rQDIDG7CdfpUSMy8HXz+GSjI8RTpN7ul7lzwjSB6GiJEDWnBUYiwN8+mPnTT9wdVQ9UZT19tHB5gmmHdm88ma9Y7G6UhT+4UkkGDW4PzSHlF6eHVzwu6gUsaUIf9fcsfzmlwhWq4aNSERbPho0WK84oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xblyCgIho11s9h+j8jG/MI1dOBEKglrryKKE5lK8iQ=;
 b=II8JWRvWJeF2ccE3yzff4Pth6+U+06MY75OIL2VEwa3ZJ2MLCjXPjg5G2VOLHNlDHQAn7ymEm0BJVfFOplLkzamiu314lUrfIVZBqWH/BHRgeDaob9A2qtQ0J8ZZq9lm5s5ABVfAt9nk/zZt43j7CQ4CQw8qYJR1bNgqdRnWod0bjaM9fxyonastxPWRi03fkIEHcJ5IZIHq0w5I5LsKuE9W4TTaqnLE7pS9r2hGp9KMKQLui236mG/QtbyjM7fxrnxBrJ64IVtQyKCNBAucSauFs0KrlevRDOeo02s84GOqfpWAtIrc8jPmWGtXTdNLd+GkJ6kFVlqMktrlaqL3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xblyCgIho11s9h+j8jG/MI1dOBEKglrryKKE5lK8iQ=;
 b=RaiRRb+F+OriGQy4Qv7ZqnwvZBcQgm/BT+e2M8ZHYUk13jl+wrKRpI7hy/k1gdTmM/V6I7ECby6vtVC+NH3o0b7Ji3XfsAicf+Tq3ddXN2+KYqqwZaK2/nMHj7SBvfszMPCTP1zhXeCfRmTo2pHgiszj4/eh9RV4mMU69NrHTQx/ezx64lUA0qIbqIQIJtTWBSADCThOjnFrjh9ixHpkVPCsLoR4CBNGjqDA8D1X5BuTZ5kOW3V1ArZcpf72iq33Y9nyBwWV4SWqg1ltpqS8E/Qhw6jekQCWrmgaCFTF8VxYjQkDbmdwgwNxQ2f06PBPxX2OfmifBODvQcAaKih+nw==
Received: from BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:37:49 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::6a) by BL1PR13CA0026.outlook.office365.com
 (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 17:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:37:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:24 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:23 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 09:37:20 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v2 2/2] selftests: drv-net: fix RPS mask handling for high CPU numbers
Date: Mon, 12 Jan 2026 19:37:15 +0200
Message-ID: <20260112173715.384843-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260112173715.384843-1-gal@nvidia.com>
References: <20260112173715.384843-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cbe5db-72c9-41cb-b37a-08de52014d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?arGhGKsdGj+N3hxoMeWZTW0uK7rKlnF0+0iFKyUyL8NkImcYcG83U6bqqBWC?=
 =?us-ascii?Q?U7UPtx7HRmH1llwcHRYoraVZxYNcBm078tENYySUoFEagHnLPZ62rXqyiuFS?=
 =?us-ascii?Q?eLwixBfyVUuup9BJYv+EBUqQI+J6KhCmMjhnV0jiGsLOIsDnu8h0EzOZVYo4?=
 =?us-ascii?Q?kKMLr1rE6aW4sGgCWOOSortogaoGLleBgpId3Quo5i71HvrTPZRENFbWWm6a?=
 =?us-ascii?Q?QLgLZkgaHKdoEE3zX+AKrngK1f/Azize3Sgc2ZYTG/M6amGgyg9X9tGgpdv0?=
 =?us-ascii?Q?37BQyB0O7BJSfVSrAzDf510lCFNi8emdoa3U3fhHUZoXxHRPAgNOV/O2TzgT?=
 =?us-ascii?Q?GMfCe3roMdw5ao4M6AnZUGNudDUgcpzu9b7eIJiNuga+FA4OLUnP05qB931/?=
 =?us-ascii?Q?qcvigBnUWq8kmqIvAJI/v88dUj7gNbZ4cYSpVttyWPrqxQMKEAYxodUwz2+g?=
 =?us-ascii?Q?070/iacgUq8bZ6iC4dseDr32imUNV53uCw5yyTzhUu4NMJ8Fph4IQeG0tik4?=
 =?us-ascii?Q?6ckL3gaZi72KXAvmfpZf15lDUeLSbtLbAmDhq+z3bdxN8PUCSEVzquABFT47?=
 =?us-ascii?Q?0434lt70lz3O63lq/ZpYvvCYke2Xb8NfU+gin7rlhdIG2XpzLrMBEr2IpI4T?=
 =?us-ascii?Q?/v6yDlxxrmvDbK30aPK2RfQpuVLymR02MQmBDvndn2ySpOTK6/lOxeTYgGmY?=
 =?us-ascii?Q?J4fbrwNfZWXiHRAkDgwLBGBxSpAIPR1tPmwN3eaSrI+6544vc1W8lygox2zl?=
 =?us-ascii?Q?40KcWCjAUyyE1la0oVOaH7xhMrDxpXXYav9CctHwuzoIR4gq1V7RYoT0ss4E?=
 =?us-ascii?Q?dSLuq4nWjVh41m19B8PtjWClaA6VFMZpZ1LY9fQ/Dw7s5ly1OvdJ+VJQMvKX?=
 =?us-ascii?Q?sXI789Ux5HKIrs7JFWK6JCuJMQxENtHTik7/aegrBz7IsAQ6ECtuH4ZymxsR?=
 =?us-ascii?Q?7mLnH/vLho+MrJ4WLJkWeaiedXHFD43zhmkNf7dbE72Fq7G1lu0RRHM/yG4d?=
 =?us-ascii?Q?EQ4Glijtz/wzhynyKARF/Ni2CUl87g7mTH9v19axsHyeYy9oXOg4h5AYRWaR?=
 =?us-ascii?Q?bTujt+imdIa9eYjPsdJthC3E4W8BfuBHd9ACZXQeY4rzfapESxtg4ECIVH9C?=
 =?us-ascii?Q?cVf+hT2gJv9468BApII6pWwGS5fv3eBewdJUHQjwfjjHrrv7jI9dAhy26xwU?=
 =?us-ascii?Q?mwIohz4fpSAWIpG+wPqeb5Au9w4TNgIPAqjUHNN63MZAOTFznNBPjVhNZ4Wa?=
 =?us-ascii?Q?TIS3VfGiUGELyiFVKOD+VxP2kGIMMo9uv6BkncinKGRJW8wlkQHS5nUsqvLh?=
 =?us-ascii?Q?ZWsd4o/oXAsRgJR5Vw86LKd9JP8lbAfO2taDwg0anQW3jN5+HWRkSJrS73PS?=
 =?us-ascii?Q?tnpYGrPvtl8AQKMRNxy5A47lFNbOVPXGCpNSX6mkVpXRMMomDgf+HooD6Se8?=
 =?us-ascii?Q?4n9K5psd9Eyuyc6a9z7cyWMR3wtZak4up9Jell8y9UwnzEpt9SQuM34b/FKL?=
 =?us-ascii?Q?VKAUkOVZrxh0Js3OcQuBBVvbrEl83cqYHLiDut54JkpKfucPnz9SVVePV3QV?=
 =?us-ascii?Q?Bs9pwIL3oJWx2Fw9J7w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:37:48.0502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cbe5db-72c9-41cb-b37a-08de52014d9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
0xfff0, only allowing CPUs 0-3.

Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
0-15.

Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index d23b3b0c20a3..285bb17df9c2 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -485,8 +485,8 @@ static void parse_rps_bitmap(const char *arg)
 
 	bitmap = strtoul(arg, NULL, 0);
 
-	if (bitmap & ~(RPS_MAX_CPUS - 1))
-		error(1, 0, "rps bitmap 0x%lx out of bounds 0..%lu",
+	if (bitmap & ~((1UL << RPS_MAX_CPUS) - 1))
+		error(1, 0, "rps bitmap 0x%lx out of bounds, max cpu %lu",
 		      bitmap, RPS_MAX_CPUS - 1);
 
 	for (i = 0; i < RPS_MAX_CPUS; i++)
-- 
2.40.1


