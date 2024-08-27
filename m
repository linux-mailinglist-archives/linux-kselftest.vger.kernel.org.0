Return-Path: <linux-kselftest+bounces-16433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1419614ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3501428570D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F771D31BE;
	Tue, 27 Aug 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAw+6XOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2841D1735;
	Tue, 27 Aug 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778126; cv=fail; b=CFrka9oXvypxrE8nDMgPkiJ5uaXwfcNdl8gaE0y81NbjyrkQ3YF4zf5DO1D1ObQcSk6p9laUB5S/aoi/sVCQeYYUa4jCZQN0o5XcpDuX3vmLUCjUrealzMrg0jfA+zBl217bc+J+5EIUWjRfDlByfKX+b2rcNRm8y3qsvoAJ96o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778126; c=relaxed/simple;
	bh=0IylUcmzRjV4meE6CQjfyNhe68McguHncHAb0bsyyGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeBySN7P8qUm5DMnIM0cCogyllTrnRCBevJB9cniaXF2z7dgiZhK+TA2odR2nmIg8LFq92LDk7w1b4bBQLLllrcDCBW2cdYH0AckrfjASYmbkzworegFoqbj9QzluH5ykUoQrU2Io8zHorAQOjUhqozBzByQG+svWYhEi35IPYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAw+6XOS; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBjbgcTIhjlLeoCAFudLBQxwRyUxmleYfQZO/5c1oheNFwjDpyPZaWarHFV3Jd86gAOS+67u9x/Fde6jmnbMQxs5w1CUNiI/Q1+gnFBlE3WFRwxEvZbgYMYpu/Jjebug+S1nVS+0Wnm/bkGgd/nEB6XNW3/ar1k9va6oDLsmqVWAAT5ydfvy+2foupRIflt9sYFeONUdzINj9z/aE0Q/LPrrgwh851COjs3sAYkBjKkeUWpvZtvXVK8/zLCDdIcngSYvqFFwY0t7fxRYVFwZvIVTTsQPFMi54q7LdMVnB3ocE3haxoGetQ3rVTOsLLC73GeLRAruOf8X7+rm3tT/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRo87J3lJqxbRQDxwquN+4RK8PiFhblCS95tLtEOU3M=;
 b=DJotl8pD2lP2Ih3fqWQr+xaCMQWOMxLa6sNThwAFmOz74qnzSS/G2QjerwLnQmuw41v9knY0QmCo5tYrN5cos9WqjJgwviOlhN+gHRwu9t5llHj0tr486ImNfrTgEKdLlTjpRM4RYXb1YRbPUr9s86FwZsPzLVakG6xYuSxgNQIIez5IMLrIA8hYVPZ+NC6LDocNtlrlTKk5xPpmlrYlTjratre1HXQRa1qDSm6XUwt4WshUywO4iPQai99/wc6rJJaNC6NLLGWzusGcqQJO92bDqkxhX9wCAIgY98Cwaor7JvFttmAuveOmDAF30fyxobDHHBHg68MdFa+VeIx3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRo87J3lJqxbRQDxwquN+4RK8PiFhblCS95tLtEOU3M=;
 b=iAw+6XOSVKOA87rc/4mxrvqD5atAdbR5wHGq9JW1uwlLuIUzUIoI6dbpf0l6nbstxIee8vyar5J/lQ9tMRwd39i3qNB0Rp2LEEFGdAX9GCa+lxberm5wQx6c4uhim6ZdS/Tr8MfBbmf7ai0Mi98BrGCXnNj7U9jI1R+O2j2PXVXISnkBRSQrV+UeJdU/2tQpNCBkwoHwwEzD5SGS3X2wBVVjaYDnZFz7HcTvUyGGiOMJ7Izqmz6SxHgOl72cxMXb1xMayGqfaMAkBTyxnNpUSNhE+nOh9dLzoIIIdv4RxFGLOZUTzT7nl9YXkxtjqgQ5D1yr/kgjmBH/kxoUW81PEA==
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:48 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::2f) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Tue, 27 Aug 2024 09:59:41 -0700
Message-ID: <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: de376c9a-4059-4779-5d77-08dcc6b9eff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pB2xK6UgGQvNIKuzlF7SYWfK6Nq3DxIIR4fdcMChins7JZQtw0O4x4Ru2tq?=
 =?us-ascii?Q?pl6/0UFiX1E9DAxLtkKyc+mdjWx+pTBlt8zJq6T8YD8McEAkwE9BUUAYNNPv?=
 =?us-ascii?Q?72loC97KlsKcndUVo++iNAItLsVF6LwAnwKxl4AqM6dgGNp6oeDOGcntU1Mm?=
 =?us-ascii?Q?GKPUTYo0uULBgdk9UGUmJYCu5vREhkXsqlZKYpnU56eLv59aSebs+c1sPzb8?=
 =?us-ascii?Q?HhiYnWf/Eqs3y5gxCjeaP2lJR6zqr50a9OYECH+CFhwVIkw3gBIYlAfYVZv2?=
 =?us-ascii?Q?2XYYOvgexPWp5BkKC2d3wly22sqZlg664eOx1WPPvFXmUNPcFiYPhmafrYTd?=
 =?us-ascii?Q?iBZ9QtRYx8SSIs68DBB0EohoUfOgYNyZyTuJx4n4f77TZKMD+8AnHGtl/kZ3?=
 =?us-ascii?Q?TeIfP7gNXLzRsWyh60G46ZPKcA/Rk4cnEuv1MAKiLgykND8WNyC2LEM7b68Z?=
 =?us-ascii?Q?CG31Eok+3uo92i2TuIiQ1A40WoJiscP1mqvDMPaz1TkPaMCbMmgKOBoDl8oG?=
 =?us-ascii?Q?Y+oz/w0czYBT/Xkz3M29nESbQ/ynJk8ApQaxed/4XESy3IfvBvQkesY5Cn11?=
 =?us-ascii?Q?gFMr8MJGu+7y0/gdKuolq5pzEOuYUNXIJrrAMdz6CDAQeaUxzvvu0vjIbYXB?=
 =?us-ascii?Q?5OqTHGDuXCIZvVB+yYGSruDUmMlwmUXZ3wpES6PHT+N6Z+TvtnvgFRr5zd1h?=
 =?us-ascii?Q?zYLzCxMKC2oIHcAkaSQfJw2MpQ/GoaQ11L6VgwcO13pA5iZRFu1RLEkdWR3s?=
 =?us-ascii?Q?a4cGe+CrVTsp+iqq0F7WQtGfPetobc6MTP+8XS9TmGTw5WzSuSgRkeTa8KO7?=
 =?us-ascii?Q?MW6je9r55KVDpm+hyWp9mZ4fmhbeGZMN1gOmx3/eUTblFibt9BBdZVudnpSi?=
 =?us-ascii?Q?T0nw40+MKTOagMOZ9U6qdEBQryxPd3SEbR9aHHUOvm0cGXpwgcDtKsYQ7JgO?=
 =?us-ascii?Q?mOcoMI1Y3tKduUDeKyFAimWZIEmF9GJOJqJXNg16+Wx0J5G2Q+FuyNC9BY8C?=
 =?us-ascii?Q?zy5Y+JsTHAaJWIRJhmzspp6Dw34tfcXd+LXpw6xt12n5WWt4J4LH1pHyLwO3?=
 =?us-ascii?Q?h68D2YWmFr87wgoHqnHtxWXzwgPn58xIcAjGK8XrAZb8RCGIBFeML62UEukF?=
 =?us-ascii?Q?W51iYRnQQQNYG+/U/dhfR9TlD9I79z5e2aSVvFaAkmzlmH0cZdDXmzKVLdxu?=
 =?us-ascii?Q?Yz7MTGYWSKzs0r+AAye/5oKt24onrmJrqpxDyc9JFP8yB9zS6zbtsMyvD5Na?=
 =?us-ascii?Q?/d8uRQxSYR0Rfl8lxE/dyKIT4wuTZn3uF/WlxsU4xODpWneThnNWPzRC0r45?=
 =?us-ascii?Q?oPVGkkD76YybfszGSLLbnFc8/IPtH0iDfZdVkVoF6ROO+2H+GFrZUe0B7hYW?=
 =?us-ascii?Q?+33ya9ATQO0SJXmT3B5Bf8Q5D17SDxxII0gdiRMfNVNpY4TycPrgWuyxjmkl?=
 =?us-ascii?Q?FxzLPeT8j+KPdjDIWVvCQ5cujZaEG7IB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:47.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de376c9a-4059-4779-5d77-08dcc6b9eff5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
a nested parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, associate a viommu to an allocating nested HWPT.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 24 ++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 12 ++++++------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index c21bb59c4022..06adbcc304bc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,6 +57,9 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
+
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,6 +216,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
  */
 static struct iommufd_hwpt_nested *
 iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
+			  struct iommufd_viommu *viommu,
 			  struct iommufd_hwpt_paging *parent,
 			  struct iommufd_device *idev, u32 flags,
 			  const struct iommu_user_data *user_data)
@@ -234,13 +238,16 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
 
+	if (viommu)
+		refcount_inc(&viommu->obj.users);
+	hwpt_nested->viommu = viommu;
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
 					      parent->common.domain,
-					      NULL, user_data);
+					      viommu, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
@@ -307,7 +314,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		struct iommufd_hwpt_nested *hwpt_nested;
 
 		hwpt_nested = iommufd_hwpt_nested_alloc(
-			ucmd->ictx,
+			ucmd->ictx, NULL,
 			container_of(pt_obj, struct iommufd_hwpt_paging,
 				     common.obj),
 			idev, cmd->flags, &user_data);
@@ -316,6 +323,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		hwpt_nested = iommufd_hwpt_nested_alloc(
+			ucmd->ictx, viommu, viommu->hwpt, idev,
+			cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 154f7ba5f45c..1f2a1c133b9a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -313,6 +313,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ac77903b5cc4..51ce6a019c34 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or VIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -449,11 +449,11 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given VIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
-- 
2.43.0


