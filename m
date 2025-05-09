Return-Path: <linux-kselftest+bounces-32721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42295AB0883
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178123A7C2F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CB251792;
	Fri,  9 May 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K6agL9a1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DE2512F5;
	Fri,  9 May 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759848; cv=fail; b=QRVc7qv25DHnlyC6/1aAmcONI5X5xJZsSSF/gUP6NFa8WseTsuhleuJPJvg74x2Umo8poAZ4s+vlgwv/13vv1G5ry/M/CfWhkgfD684w893ub0gXSrJGR4rcvdPj6yNq8ULOgLxb630QF5foEFn9GHmvn+uF2JQXwobTqXNmmQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759848; c=relaxed/simple;
	bh=aMqJ9J6jPXVz3RsvYaFLTxrutpnL+louxo44YKxkSDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbNqBVNLGwPVq7/Dnek4s2T4ax+1A5SOc0Th2kMUg3MfwSnvd9G6CABwBXx4MymKYoAYbtzBukOMwkHByHprxnn7d0py3ZZyeBWklYoOlSbXZrpVqzaUWeryWa5qmaJXq5uSrUzx9YEi/qwx1vsoVFSdEGudBJIMtpQz+E3UekM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K6agL9a1; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAnETOYAT/l4ywWctblt0Ta9oj8tTXZaDMUrMuWMLMlkr3I5abjR+QFWA1w3DdCtC+d07ftKYny7n1E5cBKA8ebGknJHZk+KlBD6VgUxLDLRWUlqcobLmv2xFxMRpQ8rGGtxLU/9luX4f3aeOUzbCrvQte1Fy957TBPtXpP9h3e3AOuZAF7VePnaIhnRlatVEH0NTSXRTUWr47AuP2XrUWAFQS6R97nkgaXKF/4otFcwY86/SIee4Qf6nE3TU+QONv4sKUVcw7gI2WrrI8uda3ia0LDWFTKUCBoNZh4LTMz1JkTdGMa63CtRwGIRQlX+2gT7KszBT+14Kp8rE9lkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut80TwivoIVC6mxy9Wiy2zJBYTz2XX+Z3i3nfVl9RWE=;
 b=DKVONdaJwgvAMpXPr9OVtXFwrZbk4cm5Ujne5CsHyul/m0aMmkGw/oA+CRi16Fq4TmZdnI8Q5clUlYH7jHfzxMTs6tXsrDt9jSpQyQGTHvv7snRtN0UeUM2TP4mXs9eWklPEvNE3X7RflPwrTgkyEaep3tzxT1a2S21iOmCgn/X/b/9UapfYTc0nYkp2JaAdmoJX6x+R6DUpZEZqD8Z9VdNXv/1+R0L0eBtkfv/uESebp+AvI7OGsunw9Yj9DzS/RRLoVibkSLQkr/uKR9AHe4/3OOM/xCWmrN65mqL8IvZHYGYz/tDEw55h8zdMlFYsTOM7unDskBLdawPwbiITUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut80TwivoIVC6mxy9Wiy2zJBYTz2XX+Z3i3nfVl9RWE=;
 b=K6agL9a1vqIsAJjgw8zvfpfj12rcWPSfmj3gKJQ0uf20OhZ2zj4Ic8UtHFQYenKyCwpOmbqm7H5I30dLCpOy4gAxXfSljaK3YsUzuDGR6eRo59HhAs/gFYqnm662ki0O3mZPqysc90SJWxZcevWFVW4l/xzuvkGG38uyWlMzGdc6jLIzBqROUWzTv46KCjX/C9W5ihfOY2hD7G+iSi/OnREWlP/e0kwbPHGkGdSa0jyv/8o+sJN/82r57z7ZX3oiywhPIDuu7uTX8ylEdRe1BoPmxZKIjD0wB4LocdnVs8dLbjUPUTbPSdZRMuIn92Te6C88oMhrXs6GOYgPTM8tjA==
Received: from BN8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:ac::20)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 03:04:02 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::af) by BN8PR07CA0007.outlook.office365.com
 (2603:10b6:408:ac::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 03:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:04:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:49 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 23/23] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Thu, 8 May 2025 20:02:44 -0700
Message-ID: <52a7150bcc0fa8bfad9e84bd0021ef4493586471.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6244ae48-5d16-442b-c40f-08dd8ea6269b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T22NuBDIoh3Nd+OrF3LgF+xu15ld2qTDjHXEIUva9N7Owl84JdRetiRy/7ZM?=
 =?us-ascii?Q?wxiaghpSpKLooBzDKCU0WWpBY6t5SHfksVowwxOA7qtNZn9BFhZ8mOXZ/HaX?=
 =?us-ascii?Q?iZSuAuD8qElgyCkgWeWeg8ExunCz1Q59vT1WIoYO+4CdEPP5IeHSBzXvaXjL?=
 =?us-ascii?Q?qXfpIBwVcEVxA4t6WFMCa4MUNLQYVDCTfA7HZ2XPu1CDBUyEWB/cokSrech1?=
 =?us-ascii?Q?pF7kI1zGYqxYF4EQKzGnbjtc0gkkEht55HOum/pECECHZ8X0VEFtcxKPagIx?=
 =?us-ascii?Q?S9PlLDofjvq0VnX9OEwQJVQ9JHCuxI7AZ/kzYw17M79b8ApsnkNpBR0XbAH7?=
 =?us-ascii?Q?VKSsAmAM6x6vE1870k8X/iAMht3GpKd7jU3M1n/Yji91TolzF2mPg8/to97f?=
 =?us-ascii?Q?eDwlUMtyaWbGLejor4CbvnCyZHqezttgbsGJnSjkOsGazV7F/xxqoEXz/aZk?=
 =?us-ascii?Q?MyN6Ma40+qv90n7TSGhMtTJ/fDxts4RKxwACYhmzcYJYul53uWMadXyVteky?=
 =?us-ascii?Q?YA+NfRt2AsihFS/2vtKr+oEO3WA9S915RCcvbvAWB5Z747xzz0lKJlQRYjOm?=
 =?us-ascii?Q?OIcgLK4qjZFnE9hMacX6vTYDVjvR07aA6yvckvNecXVtbEjNbEG88MtcyHOs?=
 =?us-ascii?Q?MJCUNmYnZ8KAZ5AqnR9z7rchYUWOkHWT+UFl8HQtFvDiDnBtvHdDVwZymCZX?=
 =?us-ascii?Q?RUlbOh4YP2OhoSwloxkfJUyXXdb7HR6IzDZjewFI/xRJrqratSAxEmUZDXKS?=
 =?us-ascii?Q?7bX6//YUhY7+VMalr3LNH7P+7U2LDIbj7E4nNX/b9y4mSLKD8BiqG7cvfD01?=
 =?us-ascii?Q?b8W7ANYqZkaqZOpsswTTknpX05lWnwHZfZ5wG24exhBYPR3NGVy6b41D7obA?=
 =?us-ascii?Q?DdSPtAKGxUITMjt2oUJa3+veU7u/JCnDvjLaq8y7ciO9qv8ORiyCjsOTaZGM?=
 =?us-ascii?Q?4Y3Rs4tt/Umh6GgEm9sFP7+u/JA9J53KM706YtYjZ0zfMVqwMU/WLtMwTFM7?=
 =?us-ascii?Q?KiKK66TKCT7u6P4TA/Rqc4h6gSXjI2S3Bm0Ql0Y8PXLd4aRBhBgGcvy6hOFE?=
 =?us-ascii?Q?f2bEsyuF7g/q7ZE0YBMPt3PGIsgidrhO0h08pNSHjOh6LvE9YVECc9TLFt/V?=
 =?us-ascii?Q?gUqKMedx6raZzeJ3zMYbuc+vwK8oJcBsVXw6ifC9N4OGzFhNWjcpGZkc1He9?=
 =?us-ascii?Q?/LtZy6JRfxTwshFUhAY3pugz3ZNsUW++7g2JDJuNcY4gcVAoNxIYzfVgxSZ9?=
 =?us-ascii?Q?g2yJliFVQGnwFjWZJtyGZQEZd2ZjL2ptD5uaqzoPJs5yKiRWZAr2hNT4GYpt?=
 =?us-ascii?Q?n+kltg5/KeHa3kz7fAPD9g2BjpW6HTlR+7BqeyrM8JKHkuvMAAn6cEs0WMmv?=
 =?us-ascii?Q?5QPxrnJs6r9yXu1Yc0hDmcpwQ0RWgD8DhIZp1hfMpY8C+OV4I9pdzzD6tcvq?=
 =?us-ascii?Q?sqNousa9xJcYkdrVOUpXvQhtOSQ0KB8z3MFZYthf3LEwNbMOQSLqIFaKvbH2?=
 =?us-ascii?Q?OB4BgqpZ7VjAL7yb7c8AepHNY5zkceOGom74?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:04:01.8015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6244ae48-5d16-442b-c40f-08dd8ea6269b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index a8a97f43ecc4..b566f12d99f3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1114,10 +1114,12 @@ struct iommufd_vevent_header {
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
+ * @IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension IRQ
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
 	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV = 2,
 };
 
 /**
@@ -1141,6 +1143,19 @@ struct iommu_vevent_arm_smmuv3 {
 	__aligned_le64 evt[4];
 };
 
+/**
+ * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV IRQ
+ *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
+ * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
+ *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
+ *
+ * The 128-bit register value from HW exclusively reflect the error bits for a
+ * Virtual Interface represented by a vIOMMU object. Read and report directly.
+ */
+struct iommu_vevent_tegra241_cmdqv {
+	__aligned_le64 lvcmdq_err_map[2];
+};
+
 /**
  * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
  * @size: sizeof(struct iommu_veventq_alloc)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 4f3ecc265d6f..ba0aed82fece 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -292,6 +292,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
 /* ISR Functions */
 
+static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
+{
+	struct iommufd_viommu *viommu = &vintf->vsmmu.core;
+	struct iommu_vevent_tegra241_cmdqv vevent_data;
+	int i;
+
+	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
+		vevent_data.lvcmdq_err_map[i] =
+			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+
+	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+				    &vevent_data, sizeof(vevent_data));
+}
+
 static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 {
 	int i;
@@ -337,6 +351,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 		vintf_map &= ~BIT_ULL(0);
 	}
 
+	/* Handle other user VINTFs and their LVCMDQs */
+	while (vintf_map) {
+		unsigned long idx = __ffs64(vintf_map);
+
+		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
+		vintf_map &= ~BIT_ULL(idx);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


