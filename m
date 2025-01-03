Return-Path: <linux-kselftest+bounces-23889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E153A00E82
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197393A4274
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6251BEF68;
	Fri,  3 Jan 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+0Fa6tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C951BE86E;
	Fri,  3 Jan 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933482; cv=fail; b=Duis/S5w/wz2v+riN/5tNwj92Pe+IDbW5KjwP02c78G+WlxyMWxHAy89N9z8zzQ8n3hsloAgZS8VoowhORVLLHMFPThA0NxTP5YHsTePIQ9bwVg29q503d3i16Hlb8u8E9C1BxgyPk3/FRSWTrEaYERmWLxJ/RKjR7GFYrmrnVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933482; c=relaxed/simple;
	bh=pTErDdU8lksTgIlnE5twHmeNbcml7g5JAnnGJOg7IJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbzwKHCW8V7zBJft/ohA/tvJXmBaqdZX/jvizMNokMSNUnhEffWj1JZR7j7ykCgGeGecl/VYOMvr2Kqv8qoIiK1ywE0d5/ZnQV/v9VM+5THEZQ6VCFanGUdEfHfoYCjWfHvg1Z93YQWlM4ncjbXPps7ZHjkSGzTgbxkuC5igwyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+0Fa6tb; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9wiHWIBeTuZdGtE5ROq3OWExRbEqvJABo1x4f/wLtNj1f/f6nM86j/Za35sArIk76/QS8QiH1e4MtBXOOaiqYF/MZKlq9uEBQ0GVweT7wa54JaHpRLzPLkU2IokaxT6mOIY0sVZhmKSbZMZsd4YMnNqho++wGCTrpPK3SJFvy/51c1uw0eVP17Fx9utGGxeGSGaXJSWbA0Ok5fDg36qckepbPKxEoDjuLXbCcA7hB0BavUuc3m3UjXhliFATqNSNqo2DKUbrKEjoA1D5opb3ezoT9vwWJ7+PePmYFwi4VCIId6L9YGthZP5Kp+eAyu/ZHzySOTD2qqqUNUuS5uufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIS+saEdL9KmV30PuFRRR9YLXw4Q/rgjK+XCzIzIlpk=;
 b=nB8S/ncfZEEnEoDfK8LS/Wy5SIyCxAiAxqJNaRGZmCi1comfcINwge8WEYIvBYsMxjwEqp1BrUwzSvOqHTuNQa/rQBp7ESd8Z+A4wIedZeWrof7JbJGPxjtVNsjxkfleTBmU8PL4X6gTHjL6NVVNN96W35B9wRW2LqHFFlbaHhJdigI7Lkbn8QK3SUQEScvc4xGriU2K+CcXiPo4UW9RNMRc9av9tOb9IsSbhGC44NBm65SXUspSOJi1ed5/ghDEFyHrzga7qRTXYQTSR6kBWYILal/hA2FZ22ZPjXwYtH5DC9QxgvkVJp4CM6n1TzUAx1RmjbABdWPKDjrwNnU89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIS+saEdL9KmV30PuFRRR9YLXw4Q/rgjK+XCzIzIlpk=;
 b=R+0Fa6tbAPqd1OpuOyw9tjEQwiYCjzOhJlfmMZvSHZ5WrxEYhzYQwituq4j34T3UdfSo+/LQeCpPwAcBgipeLf5mwb5HzgIiArl/r5MSHr+WCgyeWKOdikcn9FLd3qZar5bCufhYWWFDUKOwEdqzNR5Vk+yRtwCwyLxth8IOgUrVoc2fpauXbuuQP5OjbAoHh/WXikq0c0zlxBD8HfaogcyWdYoIglDei+4BWmLbRdVoIURlfjiFJVd0ETibMY2ocTSxajCN6qUd6F+rjFoZh7OkbKZIJWgUaJaupvTDm/LNsfTCbGaQ6pL7xrBORlLl7J1QM+QDX4d9B/NlwF+ZJQ==
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 19:44:29 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::b3) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:44:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Fri, 3 Jan 2025 11:43:30 -0800
Message-ID: <e29a931521365e7953cb993a61dadc72a53b66d9.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ba63ae-b728-4e53-0edd-08dd2c2f0981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0wbRaqMzYzNtPJcqUopw+5T1XIOtjsjMq8Tzeu/ZLyn6sQw6qTj1MdDYQEZ?=
 =?us-ascii?Q?luoh7quuc+B0UQNbX7Dlgh2f1jLzuXrGmiSQ5YFWcvFrRg+g/kvaDFAsCntV?=
 =?us-ascii?Q?j5wy6F1KYqZdHMWWUKtyo39PL7GuTkPKx8dI+KO+SPlML9gxGeKnZtr0+YEd?=
 =?us-ascii?Q?Dx03La/4NI91L0TsuLcgHpzmr1GWkW6hb5CdMDxhQBP5DacJEO2r0+E/8YQp?=
 =?us-ascii?Q?GCZQ99S0Lyq9Ez8Yu89fh9xVqvdwi+6IZMGyiFjsMz/cUDpEtRaTYsqdXEeK?=
 =?us-ascii?Q?WzNBVp52Q3Bg9Nk84Jw2itqO4oeyqIQa0Lmm1Ia406+wZAYuRDwqZ6B22iGv?=
 =?us-ascii?Q?aFSFGSD+xOBnxoc8ibYrKWX3rP/qvxKw2N/+FMz3d8BhXV7GmztEwnHqPGfL?=
 =?us-ascii?Q?hr9gg6NlJtVHkELMEJCXA0lTpfP3U/6Jder3NxQSEJXXaVziElr+hzugjq/K?=
 =?us-ascii?Q?rY/DnQbAUkh5F5bIc+gDzUES+s0PBRgqsvu9ZPDoW9U3QtsCL40/2tjM8oAw?=
 =?us-ascii?Q?h+wlPJNkQTJcEq5nydrsnaZiuj9p30+s+e8VWOTgxBw4VLV+PNHc+NL7BV77?=
 =?us-ascii?Q?3Rope36IAMOjG2fusIhKaohIEW0Tm6fPRp+vbY/IlWuLi4ejg6VYNzNN6WNK?=
 =?us-ascii?Q?2o4wPArSPBDZXSr++Xvr2VWWWzd8eS74uHn9sSx6DApKfgHZRDRh1p7FYAbP?=
 =?us-ascii?Q?jRMQ3EAjuD3vJP0xjiiavfxGi+RsVi759AP2KS354IKk0JLbRwa5wzV3eIL/?=
 =?us-ascii?Q?HlgBGXDrPU1sm3MQ7FpYopiE+dFYZTQmDD+X1PSDv8qCmESTDmfy6IZ+wScx?=
 =?us-ascii?Q?8MjPAq7JZc+XN74PvQr33X+FVAFUfeMmcrz9rVu2oxOTWoPBLVklALMGMtGc?=
 =?us-ascii?Q?dQTKtiRCa/exADeKCmFFXSfOpAds3LVu0ZZFfKSf2rlOJizlXYIW8CK+hxu8?=
 =?us-ascii?Q?u1lbyXaszNcRUrfPY+tc8D9+6Hq66Rt+GlpglCBuGN4akYHXJHZnhGJzMGiC?=
 =?us-ascii?Q?zZmmieGUtLipmvtHdtKz8GCu2fDgAGP7OZ77PY943zjlRdpKMIPG2j3IBmBX?=
 =?us-ascii?Q?g2TIFNBpbzPU5y8BC88UyvERHL3pY+CBiPaz9MVh59SRaN1TKDCDhcA7L241?=
 =?us-ascii?Q?u+hL6Ti+bWFkwB1fYyZGUbsWdmN2zQ6kwpX3zeQR9mzDc8mviX66xMiPiz3m?=
 =?us-ascii?Q?dCLgT62K+S9E2ctc0GKFeT4G/ybmJ60EDMu6/HKFBvK6j4GquPcHSJjtSAyJ?=
 =?us-ascii?Q?z6thXdr5iIeUZMN4XpD5OoW+EEhxbnplo+lfiY3Wx0k2KIRAmSuuJAR4wOcm?=
 =?us-ascii?Q?gZPIAqU6UI5RSCw8aXypSjfX1y26tNmNbZKuNo1UlP0c954sTLfF3bHBRlXn?=
 =?us-ascii?Q?VVAGE6Z7OV1IN7Xk6aghQe7FJvIY9S/Cw85q0jt2Pb/RwoDE29hDvNuE92+N?=
 =?us-ascii?Q?glhhXQNNHW0Q6r9+bVdcSVXC2S1tLES95Breu4/ZC585E62dVzPk8bYkrf3B?=
 =?us-ascii?Q?b233Ohx+ifkCyro=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:28.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ba63ae-b728-4e53-0edd-08dd2c2f0981
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 8948b1836940..9c6ba7df3994 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
+unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					 struct device *dev);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -203,6 +205,12 @@ iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
 	return NULL;
 }
+
+static inline unsigned long
+iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu, struct device *dev)
+{
+	return 0;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2d98b04ff1cb..e5d7397c0a6c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,25 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
+/* Return 0 if device is not associated to the vIOMMU */
+unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					 struct device *dev)
+{
+	struct iommufd_vdevice *vdev;
+	unsigned long vdev_id = 0;
+	unsigned long index;
+
+	xa_lock(&viommu->vdevs);
+	xa_for_each(&viommu->vdevs, index, vdev) {
+		if (vdev && vdev->dev == dev) {
+			vdev_id = (unsigned long)vdev->id;
+			break;
+		}
+	}
+	xa_unlock(&viommu->vdevs);
+	return vdev_id;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


