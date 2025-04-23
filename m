Return-Path: <linux-kselftest+bounces-31426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39986A993D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B508B4A5A7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B728C5AF;
	Wed, 23 Apr 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnBCOxgi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BE28BAAB;
	Wed, 23 Apr 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422580; cv=fail; b=hIWQpFM+ymRXBP02v+//hkpcjltEQa4LQ1tq2GC6kMw0ipil8ASE7PhUtHcwNOWrMExYwAkhsLPJIkt26vJhm+hgLJnAmJq6iQceviYElJR++XKgsVX7gU4ShNUdYJAOYb5RbfIhy786lLDB0LbYS8OE046Sn/RERYVeIOyBgV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422580; c=relaxed/simple;
	bh=u/CzDu27K8NZ9n9R6pgdmbP/T00gFlACGAqxKbHEwQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEwkGsxFTROGdtkJlmJCtQ+eawKxuOtPgJhAxDEPPQ6OXiZgMd6ryZyUyy7Kw9IUrHnZFtlxqnsauMDxTNUW0EW5P+bTr3Kx0FPrkYDCrXLgpKXLlmXzHK637t9TOiwcNyM3tT9FI3l7olj5CFb4RJOSS1VzNcyMYmQggeeElZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnBCOxgi; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4YNSarwN5IBKm4CXPqiXVdQqSvx7WfvQ4wl3CYUT2e6COgc1tJaNZ8ZeCEbw1MNT4RWyu+E2ZU6d/77KfPuj2BH8GOFGy6r+Ima2ClK6uZDSl55O8GvlGnxaCEyrE5i090Nw3j5uoAF1k8eEx1YhWrise6srVHGj8uekEbIxeg2U71Q/sriI0Pc7l78S9xJptj0jlg7Obd9AF7JmdL2yLCCE5Ny0AI1Lg12l/gOB2VdhEOOYhp6pibwx1Gu2xb+pkHpRZBFtfsmTcBggq0YokzDmx9gZfZ3i4Zj+rxW5LGSoI6lGwm5Iyp3vZvwtSSoVtwYY6CwsTNn4E9siUZSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKw3gZbn7TVfO0XJezVPubckVzWsubYhHD4y8IWrh2g=;
 b=RvVByUukoeuv56EJLep2/yWJvHfWDVyfm8l/Shqd2ndPL14fOwNTMQx9GS4Jwf4zyMjXcO9mZjqqT7mEGDaAkeHVX3sxw0jNSf6TFMS1uduLHuMw9ks0hIeiHuAT+83M+2hKO1eR+7xfbaAO3RpxDxhc679fg39wIEZQUksGB9hDm592YokjOJCjV9Qan8k4ZJ8jJAdpHf6KsLX06+9TNdmfM+2p0g3jMbUXSZnWJLHvfXxJAeoJBqejL9HLgD8E/VqcJIGKHAkredVGsD06lK0qtXAc+OvfOKRfRQTHSy3rh0pViQgoVD87auVG5J2Zgh+TYuiZtOll/XZoEykgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKw3gZbn7TVfO0XJezVPubckVzWsubYhHD4y8IWrh2g=;
 b=cnBCOxgipf4Cg0j5K72RZksgf3SDoqMLTyu1F/VEFNFbxhQi5Tc/H3FGbykvvtjlZSCdOghUoiWI4bAeYby77mRfPpCAHl33yHaERQ7L6dQ45S5n6hfgr7I87xydNzO95q/MX/5m6t1zPp/ZA2koDWiFSYtGdB0vxV5vxWt2UkQH8sJHYySF/HCoq5BtEzQyeCsy8Wkqwwvzvw+V5GX3kzD73MNPU7pWMyGejtvJIkpMN9cKq4RoE41R3uPASTyaVopy67gglb5o0mw4jKa9dAqcfkwzephjDibV5iloIzUdNjH3euT7nGff62pYN7IHME74W8eIfCXLgQqGJqe9HA==
Received: from DSZP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::10) by
 SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 15:36:13 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::4e) by DSZP220CA0012.outlook.office365.com
 (2603:10b6:5:280::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 23 Apr 2025 15:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 15:36:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 08:35:27 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 08:35:24 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf pools
Date: Wed, 23 Apr 2025 18:35:02 +0300
Message-ID: <20250423153504.1085434-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: cb964571-ab42-415b-b989-08dd827c945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DE+zKWMkiolWqb0Iu948Z1Ju3fERbWSUHH7dyo/w9qyIMEmrZtGRF/LW7JpL?=
 =?us-ascii?Q?UDZkEVF6oiQ59IzSXt8eg2Z+B1GqK3IgMX+hkXAz8WwP7RqnESXKiwwA5tif?=
 =?us-ascii?Q?gnpczgfgte74I5N5x5ZNVXQLe4Grf6FvGOXIL2xDcUBV+LUBm69k3LpQwVH/?=
 =?us-ascii?Q?Hemd9NZmyyHMijrvSxcx+VWnfPPKtd6pz1f/5wKY763UKkYpSumpXIrnQCtE?=
 =?us-ascii?Q?Zn8BuqxHIAJ5/NoWAtjk1TA7qY0PcxzLhFscqQwo0UWdIcbUtKCdThguAofI?=
 =?us-ascii?Q?HzX9hYvIJMzH43AOsTpu04BapOyt5RaOp0bj7mGvPanjyxuP7vBGYPsID+7p?=
 =?us-ascii?Q?SqD++T1N57EHHkJvFZ+vQjlpt9bmNKO48Z65qdHBQMYsIsPAkYjVlHmaqd0W?=
 =?us-ascii?Q?+qPo45I9UocvhKkx/w5hofnaR/5RpoQ3qF023rbgLxuQVyezbqDAlSR+2CqV?=
 =?us-ascii?Q?V1bOIxKkR3jN6eoNMWeP2wzY5+GqQIFqJLjt9F4o5FUGj//PmQN2svTrVq5l?=
 =?us-ascii?Q?NrWnDKUVQuM+k4qyhFDlDGDxqWaY8T3zpyqbZvP6iaBNr665gtZ+N3raOJ+U?=
 =?us-ascii?Q?GyXC/p1dtuL0hwS45RYij9yMTjxaWl46fxADTcEKo3gJpiTN1a/b17AhuQYG?=
 =?us-ascii?Q?psTkkwN/xz45z7rwnXt+0jCOqScO+wu2u4eHKMdr/hSx+fhcoKAjHBGdgBoG?=
 =?us-ascii?Q?s4j4PTdyUbZVebemylWR+o3MdRrqUHd89sN0MxTpmjd2/60Qc0qYWEYqWcu2?=
 =?us-ascii?Q?zDJ8ags20H3+JyE5Bg52FKYaSMKxJe15+kNRVkV5EJWdBczONiahyScd9rdl?=
 =?us-ascii?Q?kAbJN+YQhd246sQr5eRhMEUUv8ErOn7joDYEwDPgTbhATzC+VzAlCRCwcd8e?=
 =?us-ascii?Q?98o82IcTswyu0gf/bydRnLJa9om916KqfnKgg1VEQMLNRoaiuw3ZKQQFbtlN?=
 =?us-ascii?Q?qhs6/NMssdf6vO3z9lOuTX1PRGhP8KxaLC8VK+1B8YkNj39NsKKUnmqTpCSy?=
 =?us-ascii?Q?MrQm8SD1/LP/YCI4O3nzynmmIw8+XwcpyG93illbA+sf/YiWqbobHCp1bF3F?=
 =?us-ascii?Q?PCXeROq/0qT/E++wQYCrTNduqd5FgCisJo42wMzTgjuDxVLu18xd2qmTGB9V?=
 =?us-ascii?Q?1NUF4heCMdnO7QzqU8msSgHYpXw54j3Ar2YCrakUOaUL3Ezsjsgje12djE5k?=
 =?us-ascii?Q?ceqBP7JcX4hEB+vj+Txn3RnJAjRYKyg8Ulvuz9LDXEVBOoar9lSYDjfo/3ju?=
 =?us-ascii?Q?G5GFgn8rdP0I7OTB2oEZfNxa5vpYCsQe043M/JtCakSQLX+xmth7LFT7cR84?=
 =?us-ascii?Q?d9MYVNllaFE1XOtswSZNlwmLM0x1+0EdF3aVc1RY/cIZyX/YybIYT7J0yv2P?=
 =?us-ascii?Q?U46tvqHy7/95dgQlIPJdb+M6Pn9+zr+BUvyyKmgJYoJI6KDy/ivAnyxvSXou?=
 =?us-ascii?Q?L2PcDlFicA4k8MmrqdeEqbIyEYSCMzUfB20SqkersfmfRJDRPzDHBxPbXBU0?=
 =?us-ascii?Q?TazwieyL3fICpVoDzxkGS+4zDutPEPf4VMJI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:36:13.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb964571-ab42-415b-b989-08dd827c945d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

Drivers that are told to allocate RX buffers from pools of DMA memory
should have enough memory in the pool to satisfy projected allocation
requests (a function of ring size, MTU & other parameters). If there's
not enough memory, RX ring refill might fail later at inconvenient times
(e.g. during NAPI poll).

This commit adds a check at dmabuf pool init time that compares the
amount of memory in the underlying chunk pool (configured by the user
space application providing dmabuf memory) with the desired pool size
(previously set by the driver) and fails with an error message if chunk
memory isn't enough.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..651cd55ebb28 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 int mp_dmabuf_devmem_init(struct page_pool *pool)
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	size_t size;
 
 	if (!binding)
 		return -EINVAL;
@@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (pool->p.order != 0)
 		return -E2BIG;
 
+	/* Validate that the underlying dmabuf has enough memory to satisfy
+	 * requested pool size.
+	 */
+	size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
+	if (size < pool->p.pool_size) {
+		pr_warn("%s: Insufficient dmabuf memory (%zu pages) to satisfy pool_size (%u pages)\n",
+			__func__, size, pool->p.pool_size);
+		return -ENOMEM;
+	}
+
 	net_devmem_dmabuf_binding_get(binding);
 	return 0;
 }
-- 
2.45.0


