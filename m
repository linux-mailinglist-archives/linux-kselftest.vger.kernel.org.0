Return-Path: <linux-kselftest+bounces-20739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF69B138B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A77283A19
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5321CD85;
	Fri, 25 Oct 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIiY24GN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5961215C6B;
	Fri, 25 Oct 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900271; cv=fail; b=FKHtJAGPBimHIxGAlhh791d3QenXJJWLuhkfiowVBHChtXVDjXjndqjqnZgg5+klvq1K31OTt2IIlwnGRIbfMOX3RDjJyjXBjihYR6g7NGWNIFYt81FXhKy0mmkgWKli9slGn0WFUPYDxUFpvrXBZhSNzdt+7VtQj2QQORmY5zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900271; c=relaxed/simple;
	bh=o8uhP+J65A23rmuNLrlxuApcD270ErM1VWdSWE25220=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4mnDR1u/h0eHMC8SpimXrkKTWozYzGsLAnUyCVli2Y3lwZjhPtTnFnXL0gBiQxM/FYCMDcOc6taCY74RoDULBxLVbOx0vsFvbxBRGt+Cu7L5NUPOncjwmSxLPFaAYKnnMXQtE1u8Pg69xKoyt5CFyKomjJnGnEEgrLsA/Fln5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HIiY24GN; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgIWO7iStfvtZVnzsrcgpk6pCSlJwZnmdAhZGnCU8/f6+7dQYOTSZJaMiYH5ztPZw83d3m+YgsJ82IXN7IfYtKsN+y7Pwa/TFKhwlV5aycHZUbOwc0ACT0hqy6pCnuKkKr3SrM45lPTCiVdzzSQv2BQAs6HKRlowgJP24AJ9QtPot6DqahMHckAb6SYE5bMN3y2dwKVjCcDhX6szWQFGeZnFjEy7jAa/bXF5t89QbFDbhp3J2/wZkc1/pLVniiF3Q+Hp27tyCovvPHaPtlUYbiQQKiDpHnEbtApHHT4vIxsWQtrepoVavudvdL51yaAdeKBuvOjX2IHQCIyEPvhhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaerqgkx1SDByzbEftWJcr3XJ9L+0hT8ZgnECFVw/qk=;
 b=mdtseqhMUoO5HXCH663XYGvV/FZLGZqWbaO6PvyGr5CAzR9YgZ1S8sP/XA3jjdmIe5SO/n9iquXfEvXHixBm970SFXFAol8h/gKOOec70wNQZQ07ne1x/rCJZ7yaErOSDrfJoeaefZm4gBZX94in1biOKgsq1p6ZARkrsgVtu/dk7Azq6R0fK7akIehVkq6UpCygZaWfRFRNeOOQrjaDJhfxAmK+nScAKwYYbzwFeKkwZbL5KNeaiZXaXLZzNjIYTgRDgO4wuv9i3GpQ3NzXvebfk9ooTPZ4cgmVwx81M/lP6Rzw02dO/7o7Z6P136KsN0iEZTPqTVdBmgHU/u2WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaerqgkx1SDByzbEftWJcr3XJ9L+0hT8ZgnECFVw/qk=;
 b=HIiY24GNUDwMs0SSluguN4sPwP91pdE/ofBLMfgEP9YxdJYWsaOeAbhnf/d0a+cVc+rMPROJPO9+V18kCmR9/VuUBEmZyiKWE8WhfsAhZS0qk06C86/bhf5SL/fwMVDXgeyRakI5SkrN6whcY+Ao4wa/wD9BaUMsYJ+nOnXqSK+ikZPOiGUKYf5onfUmhHfvLUW3Q1WTngKO9McULO62ak8SyEi95CSejKtFoqU0xqclwhzzvGqVyJE9Hnh0OLB8giF6ZXL1yuv+eaNqZ9j6fhSYy6rXsHQNrqCS/vPMdeNS2GUfLeAAb23frsydI89Borl5fIf4bFkV8pdK7JBfHA==
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 23:51:00 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::c4) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 03/13] iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
Date: Fri, 25 Oct 2024 16:50:32 -0700
Message-ID: <e4817b7c2aa58b010a1453a3db9e9804b3acf5dc.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9af7a3-dbd6-4107-3bc2-08dcf54fe0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0wqGYWZmbAXttT5DXVjhCiWBx1q+TNk2gvgk/lni8XdjDXEUZuc8gRoviC0?=
 =?us-ascii?Q?K18d25FZe2+8pNRiuF8D2KbKMNX3D7ZD2sw3/hF6j3J9aoZHlNg1snFEcStj?=
 =?us-ascii?Q?Fa8jq6hIvvpjxLUVyB8F8pZRfzWOW3lV1mNjE0mGy7S7g8Lk/rMW6NbbqBtj?=
 =?us-ascii?Q?jFFpqvMISbiM3zqP8ydzt4VtfwirbHG5anx7N/Qs1TnlsyfIIrEF1gn0AxFK?=
 =?us-ascii?Q?7gsKj6oU2fAkDsJpLVbtSoVeV8SYfaHgQ0Oa6xTmrzDRY22bFwzPhkDad89i?=
 =?us-ascii?Q?LxnYgeg0S1UMn0XEjdn6Bo7yJSFoLGv8YFqqsWZwFB/Zny7bfzTDoIxPd/w3?=
 =?us-ascii?Q?7lhLuU78iVR6cthRPZdYiRWplNYfy5v+kVYTCymO4BCDfXiWQaQTGf3E+Cwd?=
 =?us-ascii?Q?63i8Av4RICmfS9ueWgUeUEbcU1frLz0t898w2CtDgEp02BBjF1n7nOAteAi8?=
 =?us-ascii?Q?iGkQPOIjJWeaL5Dun4YXvSGlz5iAzvbESr5G8EMF57ne28cdn3cQX2azJwgx?=
 =?us-ascii?Q?rq2GjzQ6Xyypi/Trx19I85vfoV9b2ehPWR/DO+yLPjpxrzc0lq08TZ9DEFVD?=
 =?us-ascii?Q?myR5ZXJ8TRpSm8oSG7YT+q4FKx/kTGTR1/50YO0P1cKQmSvo7sxAHXDrmzTh?=
 =?us-ascii?Q?gW2uHxFvRWOg9qD/xGFzL1ns7HV2cMz4TQql6/eAnFuvQea5HqaoVseFfWS+?=
 =?us-ascii?Q?m9vFI/DuPvT9DV6roWSdGGJBrVQGM7WdZT43VDYOUPQP/621cuHRDwrrHaYB?=
 =?us-ascii?Q?Rf3CzfkWZ1CMzl3toj2lh9ZWy+H+euIj5XLEkW2MPv+ESKyF2id/Vu91r6pF?=
 =?us-ascii?Q?q21yMktapJX56+mP9Nadq4o6TT22iwx+qwMtgkpAsdrlMAdUXOiU2T5uVrcF?=
 =?us-ascii?Q?7k2gnLcS7K9jXYCrGHtWkf+jJSlZQKq65jlwTjLmkCHlXSCP+G3zo95Rn7hG?=
 =?us-ascii?Q?f/ROLDe4C/FGUHamXTJNpnEttlC+F8mUUdmrHZJTsVTdXyDLwSbMOzfPLRmH?=
 =?us-ascii?Q?WXSpDgBMcGPR4nOfGxzRDBbkdJfDK12L/5uCBYoPzIj4WGaD4lsKBhfmsuR7?=
 =?us-ascii?Q?wzSJ257FNJl4oMjhm0dHjjN7Fgct9lZbPXw79VtF8p6WKvxp+jarhGzxDR2x?=
 =?us-ascii?Q?bDjH9QtwUBzRQU7XEc4JIX/TFD7ZIrU0OcPUNI/ebw9Au/6IFQLBHLW9Ig4Z?=
 =?us-ascii?Q?NLt7ULUVgJy2Jcb1YL6MRpQvJmfeLtpAPBz44zhHWmkU8hm05x8Sucu78LWP?=
 =?us-ascii?Q?JUzkqmnvffjonR+SPp2pJC410uaJpJZonHnD3f4fvlvtFPOjkQspiRCEwVhx?=
 =?us-ascii?Q?NmsMLpGIQFDf9CEA/z1DYPrW+Jw9Rv/SRZkUfi2gx80xOqdlsVGJBN+ZcnAO?=
 =?us-ascii?Q?IAB8fZMzXAE8Ho8pJ04dlK6suYeBOhYfGVOzeygFamH+9e8d7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:59.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9af7a3-dbd6-4107-3bc2-08dcf54fe0aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980

This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
ATC invaldiations).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index e6cd288e8b83..0287a6d00192 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -15,6 +15,7 @@ struct device;
 struct file;
 struct iommu_group;
 struct iommu_user_data;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -104,12 +105,21 @@ struct iommufd_viommu {
  *                       must be defined in include/uapi/linux/iommufd.h.
  *                       It must fully initialize the new iommu_domain before
  *                       returning. Upon failure, ERR_PTR must be returned.
+ * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
+ *                    any IOMMU hardware specific cache: TLB and device cache.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*alloc_domain_nested)(
 		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


