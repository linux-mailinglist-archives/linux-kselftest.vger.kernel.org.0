Return-Path: <linux-kselftest+bounces-35701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195AAE6E07
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D567AE7E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C012E7632;
	Tue, 24 Jun 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tvhewtu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B032E62C0;
	Tue, 24 Jun 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788084; cv=fail; b=cIdLwbp/3l3FReZ7Z/+nelUWzLz9O9q+Uj878Cl4OOpdo/Ii+qJ6wZVe2L8LHjv837FQt2Pky90Z3euEBKT/kLk0MhmSKNdH2PWdii27KdFWPzeAgUDOXt65MzC58rhiTyAu1YyYv9abRhO6m109ifyCr6g0tjBRSTSeSCtxQRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788084; c=relaxed/simple;
	bh=5Ni1NPGOZyphDijmrGiWL02+n+JStbd1ojfNKZM4snE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyCq5l3T3c1tVBa9gFp5xiMJYctCxLu6GpLNxawNe4MFYIX9+DrzK1/SK9NzexEoxnVJVX6ni3FUTcgeZI7wmyr2B06EI09V2DubZkljRclaUFgQiznER24fPceWauENfx8acBvnJv4geuOGHrkD2sIcvBxL0gMMfxx2JqJEXlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tvhewtu3; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiRGp95/E8aEwDDPjax3tFFAmfoOhf2brDFE/f34NmEaN9e+Gr0umZgNCftDZSKRn7Oh9xQRS9h1Qgv4vcqGO8+BfsQKOduHzVCYuImoW7ikAbg4Uj5McK0n3gPBMRhlV+YtZMbDVBFFWCkdkwmP8JCI8+NnJF65PN4ky/rN0BdBbpsQPSh9f38+2UrZxeWMhGcLTFj1KYVJxek2VA1162ef7lLOQrM5AmAuuWdZ4a0l5ZkHmDfFc5KNwA2UcMyPX9m2NUYVQo/LLwrQIk1rAmQAK5rbtGxjLD1VkKF/onl6pWV/UO3ZUr5hlWTq+viLF1/5FbpNewRkNNOsovkMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OJ4ofSmuBRIzTl6zbVagr21vkH7GdeC4IfLtIIPLck=;
 b=HhXkOPs8F/VI7fT8H/mR6Q+Cjo7dwf4QtAxCITCyliR3N2L1pfiKMKF0Sj0LqwhCPlm6bcbbSpBfPGTQtWX1TKZ6V76IKd2QtabvuMCiXIbd/HR8id0OSXioOLaG3yxomDPQGju8GkjfuZDoHGTBZkupA4b15WyRjfIV7Mz79bxIHdH0nOsPQBh5Uv4gpDAqzcAvos7ESj0JrELQjANaM920DN+GGoTVK2JE0zWpRBF/+j//YiHezI8mdaZP6bL6ODvPMU7E0Fqr4oP4y9Os4K7nrf0DQT/HhvqytFlFSs8xok9CTGGdeOjbt6wcAvzAm5eVcq+6iuVQrfWKV6GgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OJ4ofSmuBRIzTl6zbVagr21vkH7GdeC4IfLtIIPLck=;
 b=Tvhewtu3BG2wY9uHP8xtr8DtKpWrPpM+a7CrkR6UJU4dzAQtl5cBT/eCj03oHSPnxGiwtYFYljNWwwM7gT67bymgK4tO/shS/ooYbeMCclvR3540PlXGeX23V0bGbcIzPrgITdzMj3ODd5ZuSIw5D3t1cvPOIvVhxY+Y6/+9Xhxx/toJpEgwy1Q/X8pDd1qKCagJdd+0YlV3PqEPd1iutOSnkS4I3ZLpc+EqVRRzB63UQh0A8Nf4+mxykFtv4Fs6V6Z+dBRtZ2/KAXfkJGanjSdOv2EP8sIZPmQtZN1kMgIy5cuT/H/aVSJgQu/MUxO/EHhSE+Z2PH2mrbsZnmCDTQ==
Received: from CH0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:610:119::23)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 18:01:15 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::99) by CH0PR03CA0376.outlook.office365.com
 (2603:10b6:610:119::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 18:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 18:01:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 11:00:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:00:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 11:00:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc v2 2/4] iommufd/selftest: Add missing close(mfd) in memfd_mmap()
Date: Tue, 24 Jun 2025 11:00:46 -0700
Message-ID: <a363a69dbf453d4bc1bde276f3b16778620488e1.1750787928.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750787928.git.nicolinc@nvidia.com>
References: <cover.1750787928.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7addf7-ecf1-4c78-87cb-08ddb3491ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E5K4QhUnconqACVDQwcciOcCkBEn/WzinqQ6J9XSBg/yMhDA+L5654vtys1?=
 =?us-ascii?Q?hyUtZuygShHnfZg/WQuOhS1u/FzwQ/K2w4oTxur77lpM40wymiXHihoKgmGF?=
 =?us-ascii?Q?ITaSXn+XbsaQeITUqHnJBBHiTBRnbxHOJielsCXQM8beKNOx5PSJFslrvNus?=
 =?us-ascii?Q?0jRbW4LsUfswLYwrl6vebp7vaM2K1xL91dhcek0KSssEhtl9906Uc/oEuz2G?=
 =?us-ascii?Q?hamGNOTZ69FVUh1kn9Aea+vu+ODSq4Ia7ZtNi2Zs/PgPCg5TQfcWKgp6r0ps?=
 =?us-ascii?Q?8ruJsHcVSOWKu1O0Ny4mtE8P8jgRgn418fycMTcpk7q3ndpZYQ4R4B2fR4QL?=
 =?us-ascii?Q?v0cXBMzhIBVF940zkAy2nYBrMFtZtffcJwj13LSoX6rjfsJ24+1iq9t4cMLW?=
 =?us-ascii?Q?I6b6ceDQirof4QqooGPq/njSBOOZSKMhY9UrBLD5Utqw3Y+y1STEAMr3qtHT?=
 =?us-ascii?Q?Bic1kzzNvt5+idwDukapMixiqFwN2+UyE04xr7YXtB6hJ+b83XM1gbAJakrA?=
 =?us-ascii?Q?FM4LSZoZkMc3y3WnkvTNs8eXSuLWCQp01a5hsbgLNOuVDtJvVB3sUu4a0rDi?=
 =?us-ascii?Q?qU+jZ0VZu0qq9rXY8oVtsmZosO8fbv7gDE7sLh6yjc3xNUzMbQbQs31e5EQ3?=
 =?us-ascii?Q?RvraN32UNiQxNpGs7GEOKf9E0xysrvIY21t49vEWB+F4Ov1vAzanRVI4+GIu?=
 =?us-ascii?Q?6e2aA1O5LATpp4vJsxQOpmcNHQkuknskv6EOMdF4eOV5hv/5BLz/8mx+W6FX?=
 =?us-ascii?Q?kXDUj/zhAg07rvyJ641cG3gODYafDll1c9raWxDTRTDgp6bUT683esa0MLZD?=
 =?us-ascii?Q?kyIHbv2E00NAyLUTwizy+ef00tIulGtmRDNxhLjegrKwalIX9cV5IC/g/6sD?=
 =?us-ascii?Q?cvtGUiIPgRYJOyV0TRGiNLQV+NKgOaPYanPxtfoAzJVNLEYus1WHGRZtpAx8?=
 =?us-ascii?Q?DR/t0OTSXqVIJ3++37Y8rNe7O+Zeq7QYE5mr6n8D/wqJ4UrHqhmhxnB/Ober?=
 =?us-ascii?Q?SqA/qvLgXOcKiZimgMXLdWKRjWVeFskBc+Zos+REqagzIm013l8/8uKCR0u0?=
 =?us-ascii?Q?lzTtEThjgKbj4x3g18EDAAI5w1Ms9j6uG5LSs1fP4UnB/ufaLFWFdLNiJoYW?=
 =?us-ascii?Q?EcC/Jgb3s8hgHjWedy5V50aayBwxs64bIvh6Bw1MWEC03X9AefGhYEi7JL3O?=
 =?us-ascii?Q?yGxX7J5wOQEhGPoeH0VLYSV0w5/ltRde7r4SilbQq/SKgAL72zdjsKoPHfru?=
 =?us-ascii?Q?RmJ4dJF1LWnfllaxaom/jETCyH7lvovN4FV2+x0+LMLwMsIKhfy0VhJ+3Azi?=
 =?us-ascii?Q?QuAwvqPLmWZkiB/7uFfTY6MFCVqHVEKNvoze9EHy521MzjiHC+p/rvYm2Uay?=
 =?us-ascii?Q?NfOdBMjBulGDxt3qNMfVEuD/jVjt9u4T2avw1KkKcn0Yq+/J1fyj+lYh/p4z?=
 =?us-ascii?Q?Ymbcxdny2LQGENQYX9GyBqdvQfOZbKzT1BuXLjLjcTfZ0gFi8A2NfEvHUvo9?=
 =?us-ascii?Q?wDItRMiGXDGm6ZG5EaUUQUJFlIGLNxfGLNyP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:15.3587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7addf7-ecf1-4c78-87cb-08ddb3491ce3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

Do not forget to close mfd in the error paths, since none of the callers
would close it when ASSERT_NE(MAP_FAILED, buf) fails.

Fixes: 0bcceb1f51c7 ("iommufd: Selftest coverage for IOMMU_IOAS_MAP_FILE")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


