Return-Path: <linux-kselftest+bounces-36614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE10CAF9D2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FF31CA02A5
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9C1AC88A;
	Sat,  5 Jul 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOMuFgh8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D184039;
	Sat,  5 Jul 2025 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678054; cv=fail; b=XCz+6mU6l70gx18HJVtHVw+yZDugYM5oYDsI0acXk2ZCXfnR2RhvMYteBFBMe9Py69sxKrT7+Z7tWMwtN2U/iCZ7T4dI/V6LYLZU3bCmyC4mcByYtmaoZGbezfrEiVLPa9asIj4AjktxrrplmM6eYF3Yx4egqkGCEZQucTYQyes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678054; c=relaxed/simple;
	bh=g/XHBpzwClpXhX9Avg8a5UhVX9rXmAQ8EaTa5Pg8RQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsG5plmMZcoUYz5ARtLQJ8vZLGls73KDBF/4qjqTK8BH6P4YG2Nz+IOzN2ZfllPoLRs1MRED985S5MC5zaxjnMj3+nxJmFCao8ePrXx646g7h3ACxhX95MIRjchrcEmV/QbvrIZG5viaJxl0sns6CKYuLNnlXLJ/RfCAmytYvh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOMuFgh8; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhoHcrXdgnLymuMm87YqqYBHxKc1YK9/o+VlbJ0dVHOvRTuKvth+sEAAoGpRTiNE8ngAmGnpFmPUzpxlh/5X94b1NeJ1eJ95Eq+h0znQfdaVMUMOPLxP1zhrASAZDgzqOzgHLEnFzmKuW4IHordIG9qLrGtmH184a/YReey8EoTYzBJErhzyLow9iXiUS/i46Evx5zh34y1MSRTQLx3nbqMeuzmlslFX53ryV5mAxtvPxmbQK5GEdHwxZfEZeGNiKBz1GzQ0Hb3QWQ+KbvGpWxBfI+54yifIcZwVUSsO0D4Tw8sBnwtLSzKTFod0hB1SVlrHN8lnmBkDjY6jCzqIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2urNujoCbfVjgh75rFz4HYYLC4oj/nztPYBRPw44wY=;
 b=ulURSJWakKYzaI1QqijHX6VbFpxOU/oJT+f4Cd4cjUu0WcgRjmE85+KlbfYvmYjPBK4QSszbf4lksqBH+JFGezQLTrIo0Q6lAEUXMDccTMXgok7fdRXFeYgQ7gACnCUXc8DuE+1hgJllDJ7Q2fcLqhDUB9WKEMB9zbeKIXGIfolcm4vaHMCfWS9gOtYuT+X29fFtr+Ocn8wvHz13m9nb+jOGrKlf5Pwr6Ic6PeWhCKYVonK0l6kUVLPVHpb55aa/6WTcyMrqn3GMue3tmDtWF7R5TcbcU4OoztLGw9xYFfELfcqSMG8fb8bHcKl6yFVBInlZRYARTwGpW6wm6jN3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2urNujoCbfVjgh75rFz4HYYLC4oj/nztPYBRPw44wY=;
 b=EOMuFgh82+7CgmynCFMyZz/x/nrUmNrFHorT53TwJdkDwJgfe0kqNuNT//eKcLyuTdUYhwXXa6arF0WkxX/o7v4TZ4ycc/D0fqpsWIepk+yA5MPogzX1DpPebrQmih8gUGOzHoxGt7NMGtQGDzLmf5AA+ozv6Coc5hJEbPkw5s1ikhqYr8gSnMmZaLzQmLyu8fTNbrlzHKBFk/6mzKYGuOz6rHgOpA5gX0le6skbjgbkccM8gwgsptIPvzSiO19ODuWOfSRAPIo79YtK0s/lNvy1g7jGYd/irOsg2lPUqQE+kBoKEO/d2nQkackBpkFlQsyG+/pSdFRYXE/PMzNclQ==
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sat, 5 Jul
 2025 01:14:08 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::71) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.16 via Frontend Transport; Sat,
 5 Jul 2025 01:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v8 05/29] iommu: Add iommu_copy_struct_to_user helper
Date: Fri, 4 Jul 2025 18:13:21 -0700
Message-ID: <2f269b4fb1c0bae93ae93e9b30e8e7bf37563104.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: aff3dc7b-9f16-41f7-83a8-08ddbb613e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiPHfZHFyW7BrZR9Y09AkRSGZZAUZ7hRnOOzgD5eQcNm6Ozkm2FP74Vc9OPV?=
 =?us-ascii?Q?m1mHDoedZtA/OcfxU2BYcKLyPNwMz020K7982+VDUL5ZkXGifCCAiL463WoN?=
 =?us-ascii?Q?jRY4S6HyCcgO20gP2e67fztZQcwN4uJnFmAe0fnMSR0Kcm/rkxAyW8krm32t?=
 =?us-ascii?Q?pDzpzsqr16CH1EKCSY5whLh6aA+XafAbXE/ofPQbIhiOKCqy/3d11sqeCRB2?=
 =?us-ascii?Q?/kHMPEqRAqT67DBpd/O+GPx49ydcAMhopJaKQ8tmibsk+uix4ut+0eYXQXDi?=
 =?us-ascii?Q?4st3Va8jmNcf0dhOHp8jYiPr2Uee/TRvymIbWWaMYD6pTZoGHsfMUS0Smji8?=
 =?us-ascii?Q?zq1gy2lkvVfcNcTLuZwGeYya0MKDQRAI7XK9khiCQOq6WiAAJS/5xZI3ZL1y?=
 =?us-ascii?Q?UtAXFlnj2ox+q8X2a32lzZYTchSVD/TATm4W+tc6PzgCzj9HNK9iC7Lo+Gam?=
 =?us-ascii?Q?zsLTgh1pC0vEUthMMRVoef3q4edE7X/Sm65WIcJrmUVlYX9FReH8VcbrtAdx?=
 =?us-ascii?Q?6ly9sk+mQzeoP00nx2C4VHr7V+ppGeuoRGneRBlAsvYmDJaf5qKyV/YyYmFq?=
 =?us-ascii?Q?HTOvEX8X7Yl0yhmo1ussN4OWmgyurwWe3fh9PB5Y1f6B6DlNXzvYMKuFEbbb?=
 =?us-ascii?Q?sAXhlRCLw9OWFw04gmAYu7fQUhkQVcvleJUpHw+T6WLnAEBzzjjIOLFLHkdE?=
 =?us-ascii?Q?6UdlSTdhNfRG+Ths+IrCIN3/PqmCXgbpqozF+G3s9c6XRAqR2vV3gKNRt33O?=
 =?us-ascii?Q?mu2stUTCoWppTpWDJtt1xlJ46LKbg36ghQvxObndGs1afFiXBmneFnmDdqy1?=
 =?us-ascii?Q?8J9WVCZWH+/DCj/YqOKk0H4FPuDk+N3a8xoPZBim9v+LiiBSKGkVBpwWxrGx?=
 =?us-ascii?Q?0AiGQQq7td8izABmNG80Rwxhy4UQh5RL8lu0lrAaawj6qfyg7qg106kOKreZ?=
 =?us-ascii?Q?HrurBB7ahH6QZK0lmySh1S2h/4IizPvHegycrGfzbiW26rSGnKkACfXLUe5Z?=
 =?us-ascii?Q?wdvXALGZ0afeMXTXV7lWemcd9+EjITXsYl2UuNO/aiarFKTyeRf+dc2DWQmw?=
 =?us-ascii?Q?G1SjWFEtpZ8X5DZKIyC/qRsi7+o4U5/fQ/jxzddkE+9e+eh9cJ1kDspJ8N/T?=
 =?us-ascii?Q?HP1zaqyH6Jn/8uTGec/7HKGBuoZyZt4kj6qmrZZ2XnZvhO0wG8Zosk4liYXQ?=
 =?us-ascii?Q?hLeA2bPIlbq92V3Wo3vDFnyI5Rf5VJzbaZW4a1rIirHt8ZARgTU/x2vpRhBq?=
 =?us-ascii?Q?xE8APB7GhDbCPh7Uobf6OeoY9i5RsKLJijz9T+iQfcWRsl8sGi284I0W0R2s?=
 =?us-ascii?Q?t92cxidG3+Snyv/Lm1qB3Ec6HYG+WL8UPPYnpZJAYoasUMyI07BqUWsD8gUX?=
 =?us-ascii?Q?wNGv2jpDZW4QTVav23pVpO7KBvyPBG8QwiscSHk+cmVIdQQfwp7/mhHeUjUj?=
 =?us-ascii?Q?GLffQH/6GYbi53xfHjmDo0SHnkxx+Dc3RJj22GTcIFs+w2Cdv/k6rvwm2ZT9?=
 =?us-ascii?Q?/81Q6lxt3pdApA+tZX3gJnuWrY1z4msFfl3S?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:08.3028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff3dc7b-9f16-41f7-83a8-08ddbb613e0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752

Similar to the iommu_copy_struct_from_user helper receiving data from the
user space, add an iommu_copy_struct_to_user helper to report output data
back to the user space data pointer.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b87c2841e6bc..fd7319706684 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -558,6 +558,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	return 0;
 }
 
+/**
+ * __iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @dst_data: Pointer to a struct iommu_user_data for user space data location
+ * @src_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @src_data. Must match with @dst_data.type
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _src)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
+			    void *src_data, unsigned int data_type,
+			    size_t data_len, size_t min_len)
+{
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (dst_data->type != data_type)
+		return -EINVAL;
+	if (dst_data->len < min_len || data_len < dst_data->len)
+		return -EINVAL;
+	return copy_struct_to_user(dst_data->uptr, dst_data->len, src_data,
+				   data_len, NULL);
+}
+
+/**
+ * iommu_copy_struct_to_user - Report iommu driver specific user space data
+ * @user_data: Pointer to a struct iommu_user_data for user space data location
+ * @ksrc: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @data_type: The data type of the @ksrc. Must match with @user_data->type
+ * @min_last: The last member of the data structure @ksrc points in the initial
+ *            version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_to_user(user_data, ksrc, data_type, min_last)        \
+	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
+				    offsetofend(typeof(*ksrc), min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.43.0


