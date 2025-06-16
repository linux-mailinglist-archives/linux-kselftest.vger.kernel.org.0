Return-Path: <linux-kselftest+bounces-35039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBAADA751
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F6A169044
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247A1D5ABA;
	Mon, 16 Jun 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOUuC8zV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0C19D087;
	Mon, 16 Jun 2025 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050168; cv=fail; b=FgcFt8lNBDzSj2om5fkrxhkY1oLW+PPg/grrBfuT3dQZ6xdpUa6yagl2Sime7jvlHgIP77C5nLqw3CL6TSemaqHGrgmKFZZu8hBRGaxuNUrYIG2bxYy6JFMaoADMVRI+eMe4Y/ueVuiY4bnckHUxzQ29h8+57njm17OHcnwFd8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050168; c=relaxed/simple;
	bh=TnKvoA41i8APzVrwU4tKAosi4KeL6KxONJh7NhIzmkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmHr4VTa7ZNejbG8iyeDo4XfeOZXI/ijecRReU6jiHjlzXIc2Mvj13rSYeTipfq9cuFQmcSV9MjG4hf095XS1vr+bFhh+u2lUh5T3RpZftW3HAYiiLzVotAVwgrEvLN11jAbj7/M87JZw9I8rxCVhes9lpUCN77kPvILCC30zLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOUuC8zV; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4YeRiQqXv3KKlU5mZceaKwkKrG/iVDmyGkSTqsoR5OI4dSbhWrbiUMG2ufaP72xKKtcUd5v2Iu/sJc7sZIbzny9W5wwhdm2ygm3I686TPfMDngpCYUs9Gf18JZqxkH1B633OfXP7+nxUYQvBtVZOQbgxCELdTdcdYgfKBavKroZ50Z6a1ujUiZcpAiT7F1+Ur+yduACGhFDsDarGWgiu3D7ZiA3fgacRrfUoH8EgDPHfPCnSK3rGmLFXrh7B0RvcnsgfMbGKgdxgZTQwGsRSz7KRWkjVLslYmn01S3Ov5/n11hGA+qlZnrKJqTdgKiEnPQLLr/Fw5wjAUua8/iQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTDXucY8rTkuJJL07uP5aHqak3pGAPuBOF2w/GsyN90=;
 b=mIn1uQAxwpuWV2sGY5CEm+oxUpHz2DPgBZDRIyaem7U1HkbR8FtP42xZIDADx6rICdQVaHl0ZXtqECKEhY1wBPmpZ7naAF2lVbp4hktz1d9HdiWaA7ylqlyuCk9y+/BOfVlWrRZvNkKfNE28D+VCQr6YlItSeoS/IW/lNc4stP75ukmXgNjnwAsFkAr70F9Uzt3ajbQal2kj/3fD0AskpioTsmQzBY3yhW6EkWSIlspakDxuVRRM463hfzUWfEZXTos0Xb8MPTtrcicNd8F5JrMH5D91/5519icT04KqbKVYo454+dc4q8NO3xtjiUyN2RzOx/PMe71VwnpjyCFOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTDXucY8rTkuJJL07uP5aHqak3pGAPuBOF2w/GsyN90=;
 b=VOUuC8zVApJr8ga+i5iL0Z5cZ9TLhCKjWjFO3t0wW/iRRV4eWnnYbekHjQC0EaXV5OZt9ATCThQfWaq44KthwQEEZSoKNuiPjPp5NwfUKoZ8jkUMd8svYFMDeNL0mzhTZXfzzzYlukM4tt0Bc6XvuPPPw5rb1R4TIF1DlnFTpgT66gZYM7p0wdT4hhJzSUlLXJQB0tsYnE4rx1bkrPus3ceM5IP9QOkgX61St+9RS5sULgcCupxy4csE2c9wAe9YLbIMFmd86HriJEJUKvPRt9x8f248akr101Mu9n5x1t6iSfzCSNnLrdi5sbfFjvjfvEoCGs1YCMJ326hdA5Sx8Q==
Received: from YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:83::6)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 05:02:43 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:c01:83:cafe::aa) by YQZPR01CA0118.outlook.office365.com
 (2603:10b6:c01:83::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 05:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:02:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:02:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:02:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:02:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc 2/4] iommufd/selftest: Add missing close(mfd) in memfd_mmap()
Date: Sun, 15 Jun 2025 22:02:04 -0700
Message-ID: <ee5186412a875a958f9e77a5e6eb26a1f35c7c83.1750049883.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750049883.git.nicolinc@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb96d59-7133-4539-b361-08ddac9306bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4mRsm/dAF5Gvr+CtWIvJY+/JQqwJs5hrkwsQJWGx12w3U1iJDY1d4BliQRm?=
 =?us-ascii?Q?SC5Ph5fexzptdhIgM1QYjviAKnCQlxquMJsJwhh8U3wdulr5lgV2oSjuPIb8?=
 =?us-ascii?Q?6PV5kmpOksPqkSchxq960NX95NMmVID2bp05Zo3k5GQlQw1ZQjThq90vi9nd?=
 =?us-ascii?Q?sart8zVNb9lO+OGyvEzsqmoyI0yi8Ph7vKssb0TGNwtnhJJ154ZkXhXNlbZ8?=
 =?us-ascii?Q?99peZcXP8rCZFlPLgRKRGF3bwYdImFn1zQO7t1FdOzth91kiWoeZQgpBdBU3?=
 =?us-ascii?Q?5Vf695jQMqW37Ceu70AY75LOv22vEHk5Z5m8rNJFZIr0RxSH37Wv9gr3otPH?=
 =?us-ascii?Q?zPk4uaJIPxWpZzEwDvDhBfTuuHObXbzAo6n+7ZxEr1m+xOXREyzSYLJ6P2bC?=
 =?us-ascii?Q?EytWwO9pJ10NoudZ6tvuFb4J8pp/0uir5k8IiW6Nydg9OJzxdU4EreXw6gVA?=
 =?us-ascii?Q?pkTUhaYP8cBshD4d5r4nh3Q2+vGhVNVIE+1tqu7QurPYkDYtfTitp4O9yfIj?=
 =?us-ascii?Q?fuk68EqcUVskQcKPb9Dor5TeVvBD5T/GpPQ3wBTEH59WBjQGArCvXYtykAa+?=
 =?us-ascii?Q?vlWs6QdvDg61pXSOYTu14jqxsX4K5caqmcZuhYVK2EmJ8NG+nGUcOFuyvgp2?=
 =?us-ascii?Q?rKudCylZMZsd7PY0mFe75oPLTnxCW76Nn6xBAqCQFrby0Ni90RqCQ4hA0uHB?=
 =?us-ascii?Q?ALBeiH2THtMpagYixMTH+v2dkR8QsLoapMC/3T7EWRiEDhJccBsUja+gXx4n?=
 =?us-ascii?Q?SQOvaF7/ZnTospFZ52EaV8LaLinNTE30r2PurX9d3Vq/Awgk4fHInYuXTAxh?=
 =?us-ascii?Q?4xwuiIytPvYzOwo54rIfxpfts2y3zTcpjcBSugmhLjRfpg8OosIMN/b+KKcX?=
 =?us-ascii?Q?xR6d/AOeUI8dSMotKr7VZrG7oWU3q4P4UVd0s2gSoYTmKC4c12qygoMT4Wxz?=
 =?us-ascii?Q?Qm+fY0YKGpjvbehxg0ff/3j6mjl7qrEUYvtSxz/qFGktURAnLiDvm7BTdyjF?=
 =?us-ascii?Q?9oa2U2BC4Y4XUCuFlD9A5gZtyn2/HMKpecV3rUfS29277fle9qnG4zgqS1cv?=
 =?us-ascii?Q?VlEi1lLxmVtkPQ/rdTnwOYz/kbC3RWHhikP3W2O6Hg7RCa2F+MOa5K8zUj16?=
 =?us-ascii?Q?bFzkohru742mQpdeuy6D4Kz1bkVLP2lEu+MgkZ0O4BUj2ivd4uvKX2/3PuAP?=
 =?us-ascii?Q?IhLWEKFUfeDiWTxjpTHiwNRsbpFbg1J0QwkBB22iynLr0fygPEKn6CDeBUf4?=
 =?us-ascii?Q?5S1IAEjJ6lzArzsdMy3bwbJUxeUPVxbs7Xphuk1BG2ZC4hrQ1qEg38GVyrzq?=
 =?us-ascii?Q?P7OLiRkgDl0khpNqMs143i6nAnycrigPUqUj9GlSAZ+WCgwZ90HQt06Yl21o?=
 =?us-ascii?Q?WfDVak1YP0Np5edAAt+eLvISC+Wher1vF220BFz4g9H+RmcGKISyi1o1/i5J?=
 =?us-ascii?Q?m5i5mvJS8z74RKnfmBOW+GGzzkRv/H5BrzU7BRRDf8GQ50L1Aym5niJKM2Qv?=
 =?us-ascii?Q?I8j3AtmK/Kn0MnizC7AFlwNZHGkJM3cmRwvO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:02:42.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb96d59-7133-4539-b361-08ddac9306bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Do not forget to close mfd in the error paths, since none of the callers
would close it when ASSERT_NE(MAP_FAILED, buf) fails.

Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 72f6636e5d90..6e967b58acfd 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -60,13 +60,18 @@ static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
 {
 	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
 	int mfd = memfd_create("buffer", mfd_flags);
+	void *buf = MAP_FAILED;
 
 	if (mfd <= 0)
 		return MAP_FAILED;
 	if (ftruncate(mfd, length))
-		return MAP_FAILED;
+		goto out;
 	*mfd_p = mfd;
-	return mmap(0, length, prot, flags, mfd, 0);
+	buf = mmap(0, length, prot, flags, mfd, 0);
+out:
+	if (buf == MAP_FAILED)
+		close(mfd);
+	return buf;
 }
 
 /*
-- 
2.43.0


