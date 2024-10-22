Return-Path: <linux-kselftest+bounces-20353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBD9A94CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CC1F23DF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8214EC5B;
	Tue, 22 Oct 2024 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QvmocKHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021C1547F5;
	Tue, 22 Oct 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556457; cv=fail; b=oZmivmy/CeRZ5RBGvdWsi6Wh6EBG6r+WsoBRF87KZhgsi9SYib3V/yqpjnURukx4Fyo6/8PH7tEyMWhCs73v7fUH0Vanyxzot+Y51Rt1hAoF4LdTgPaYdMabNE9Rki04bY0U/jeoFx6lmw+Cx1bTWfuANIuuMKmp/P3fiYnnhRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556457; c=relaxed/simple;
	bh=DWsWTSHUgKOE/4K7gdva80ZDmUkW6TbMfV2IypiTDuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEI1BrMijMWZ5ZhcCUAcDfg3RWx9QpY3B9N8VLqQrO2yWwrxGo4LJIKt+0M7O/Px0s3gQ0we96BKQkiHtpN2tNkbMBCTCe1YJHB0DL3jx3VNTRw6U79rkceEVzL362FZecr3MGgnyTNry34GDWTXffPzGnT74fYjH1Qn9PEWAkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QvmocKHx; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7ML3mDtshFbRKUt78VEXk5ovJHOz5nHEBySUOWru+fFh6/NM8gYWHTPs66cckfsTqnxLqnrCQOIEoBRr2yBkNTNL9UYokUBxqLr5QC9FKlu6lb09EFCIz+4VOUvRVGJJYxon/kV6Gb/xdY0gAAlP9LmKjiNwVwn3ei2azIQRNrobXgXEgzTz1y+flwcw/VWarbuNMdOefQXBpdTgTfHdc+y5TcOZ4Rb66Hqct8e1CL+vsi0a7OSYZw3SvRsRAzR4Sf2zp7yIYxVTD2nbEIfbbkQdTz3IIs5G7diXJ420KCC3vofsvFFFgp9Iy23Ma0nPeelB8qWmPDeQRDRreRoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdrhTwHRY60JX6v8g95ZafUwTwY/UoASg7RZ4ctBi/Y=;
 b=jkzmQUaWWUnlrhCzNc+FDhuCueBP20E0XqmreXQISUUDL9WhyZSt9kl6/RZWCCJ4gnU+xL63qrT5oviMiL75oT8rSEukN+AF0vC93otVHawx9C+5aqRjfXtGMk4+HCITizBFiPnu9PxXyMgFZ9Ql6x39zOsPbinTjDkcTE3f6VNJEbco1Sq5wH63l0QzsS63X04/Siz8qsw5xmWbwymOgx1BW68Mdszw7/Y+P3ALkp86bc5lk6nubofqU2Gr4+hTWBYy/eDtzcvJK44AcOnhjj6c1QhxyvBt9eIVJN0LZniLoyTRGM0whgrSew1oMjqJZoMNsoaY/K7FPN+5Ha8GkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdrhTwHRY60JX6v8g95ZafUwTwY/UoASg7RZ4ctBi/Y=;
 b=QvmocKHxMtvZVqovg3Wu+syNpE4Euvt1/yqthJDcpYt+L7Fgm3HNTrqdtKM8+u39sIQ2D/k5fyPd6l1gpjnJYX1aJxHYa8Q1SFWbdjvowzg2USFADXrji9QxugQM9rPv21NqoqNx6L25e11tiUUS/xLtdtv1RevzIwKoxgfpZBNIcpmMfdRUpcb5yZXqEYfslr5VXunQGxOxLrjzefdxd8CxBlGKCzcVNrwpFdA62xt+fTL3WGIR7wGM8Fb/2yC2nyEEybqS+yfatrv+LiNG05n1/cTJVAdQQoYL2yzXiPaDuOOu6pVpn8kIbJFgeEQU+3/sjCmKwCVPsuNNm/c3ZA==
Received: from CH2PR18CA0040.namprd18.prod.outlook.com (2603:10b6:610:55::20)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:51 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::98) by CH2PR18CA0040.outlook.office365.com
 (2603:10b6:610:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:35 -0700
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
Subject: [PATCH v4 06/14] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Mon, 21 Oct 2024 17:20:15 -0700
Message-ID: <8ee26e296f77ee8f1b611ef2b9295713bfe7b542.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: bde0f919-4daf-4569-7523-08dcf22f62b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?egArw/8eWYXuwuADcCPVEaZZ457s2UIP7Vxn83sYPkybB1I7OhswqKLraHDT?=
 =?us-ascii?Q?PtFvprR5YFrely6wRt0dTa+dlpBB1HD6pjcOf/UOMt9ChF1FNXQX8dn7WT4J?=
 =?us-ascii?Q?lz1Sv4n9kHZM0uMKviYDLSWq55lUMQllxZhKIUfXGbfFiNNFq77/P8RSxz5S?=
 =?us-ascii?Q?jAhGMj1utIydfTVARka5YAlipBthmXUcXUiKFQPpalc+hgPtId3HgIemcliz?=
 =?us-ascii?Q?uNIFT53KamAFHCtU0BqeQL/0Cks7lXruS+eB6w5bfBJsPguV3A79NQQJ7STi?=
 =?us-ascii?Q?3yRUh2NRq/yt3aGipO4jzoZjRTxb4XwOfnR3k8nj7ZcgoBcptVOY5iZ+6m0R?=
 =?us-ascii?Q?cJBc4bYiET/9TxT6ztXylbl3aowgqaEPh8mlFIBJETmxXvNlOfewZ0+igoAq?=
 =?us-ascii?Q?448byCPKzirFpngjjWX1svjBuUFwhJc59qi87BEB3v+m7T21w69GCuqrAwYA?=
 =?us-ascii?Q?hzy2E0w0q4e4gkFvUbrZCuA/y3WNa/JXzkK67yTM24hWGCvL/9FcuDkKOYzU?=
 =?us-ascii?Q?D59X/2gDTmdSZ5dL/yAbfIYq3DC+tFKp2g6ACz0RPH6F65vUZlAyLqrm51qI?=
 =?us-ascii?Q?+f8X4ulS656wGovgfoc7S2ew4bPoZ6Q6UfT3p/CGcYrSX9W+9UChaBT4695T?=
 =?us-ascii?Q?sjixrYbMKASNqRXKRlM4QroaCmj09zBlz8KDtNtWhjutKh4Bse3h0mi4cjkv?=
 =?us-ascii?Q?kfyumMmbEr6bjJsBTjG1xS/zNoZ+xAL5713GvE5+BV6qpNsIHHupRjKVy3VS?=
 =?us-ascii?Q?Q+EjxLXb01cvhWB7VSBpcQNJA14QCh+e1WwxEKdwHTBCg1Q/eqg/7SqpJwlg?=
 =?us-ascii?Q?zBV1rEQyUXzX8soGRYj5NSNz9H9hk3zqaKK6L7Zx1BhXx+9vyyjvpRP8Hf3R?=
 =?us-ascii?Q?Aujz/s+Wrwb+UxJkVZMMjN+iHxmqZPlX/HSQCRycTkrnkuUbUWlACiHrPoib?=
 =?us-ascii?Q?CVsf9GtkiDwvODDjcnvC/CA4Uj/o/XOotJJvApnP3LUCdbLPcOhEqTtVBtwK?=
 =?us-ascii?Q?83moEY9e/U7wgIkyuEP4++7CkoYCV6y5bLwG0hUIuRynxyldML0LoGYrXD2p?=
 =?us-ascii?Q?8IY+J/q9kRoTcfjRsDBWEG3f91BD/RFL5gb1XlSNnom5/6KGUCpaEkxBXWD8?=
 =?us-ascii?Q?BOzONoNeD6eZ4PP7NBBBO9kRfklnABQWHLU6XfFhPSg9eGGa9pPCjhs74dVw?=
 =?us-ascii?Q?NN1BAOYEOAUqEKo1qthQvXdbUWnFz4vh1ZDFxr+cQFRQxsNYWfTzk9BLjnrp?=
 =?us-ascii?Q?E8XWtMIjqEohxCu2Sc0/aBG42feAKvOkA5313jf41k6tLoOFAhhskmdY4B0N?=
 =?us-ascii?Q?zZHR3XdaJhoeOCMQ9viUYyGSRrYyn1QP1WinkrrDQtZHmKFYlp7Mybf+tQ2W?=
 =?us-ascii?Q?bmtuiShZ2APHu7Uj/ETMGc47sz5Sso7IwpBIel9KBVN44fzCQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:51.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde0f919-4daf-4569-7523-08dcf22f62b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

With a vIOMMU object, use space can flush any IOMMU related cache that can
be directed via a vIOMMU object. It is similar to the IOMMU_HWPT_INVALIDATE
uAPI, but can cover a wider range than IOTLB, e.g. device/desciprtor cache.

Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
and reuse the IOMMU_HWPT_INVALIDATE uAPI for vIOMMU invalidations. Drivers
can define different structures for vIOMMU invalidations v.s. HWPT ones.

Update the uAPI, kdoc, and selftest case accordingly.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h            |  9 ++++---
 drivers/iommu/iommufd/hw_pagetable.c    | 32 +++++++++++++++++++------
 tools/testing/selftests/iommu/iommufd.c |  4 ++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 407747785f6a..3486ae2d62d1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -730,7 +730,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or a vIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -741,8 +741,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
  *             Output the number of requests successfully handled by kernel.
  * @__reserved: Must be 0.
  *
- * Invalidate the iommu cache for user-managed page table. Modifications on a
- * user-managed page table should be followed by this operation to sync cache.
+ * Invalidate iommu cache for user-managed page table or vIOMMU. Modifications
+ * on a user-managed page table should be followed by this operation, if a HWPT
+ * is passed in via @hwpt_id. Other caches, such as device cache or descriptor
+ * cache can be flushed if a vIOMMU is passed in via the @hwpt_id field.
+ *
  * Each ioctl can support one or more cache invalidation requests in the array
  * that has a total size of @entry_len * @entry_num.
  *
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7af6cbe6dbf2..cbc58e98d8b4 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -481,7 +481,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -495,17 +495,35 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 
-	hwpt = iommufd_get_hwpt_nested(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->hwpt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = PTR_ERR(pt_obj);
 		goto out;
 	}
+	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
+		struct iommufd_hw_pagetable *hwpt =
+			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+
+		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
+							      &data_array);
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_viommu *viommu =
+			container_of(pt_obj, struct iommufd_viommu, obj);
+
+		if (!viommu->ops || !viommu->ops->cache_invalidate) {
+			rc = -EOPNOTSUPP;
+			goto out_put_pt;
+		}
+		rc = viommu->ops->cache_invalidate(viommu, &data_array);
+	} else {
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
 
-	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
-						      &data_array);
 	done_num = data_array.entry_num;
 
-	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_put_pt:
+	iommufd_put_object(ucmd->ictx, pt_obj);
 out:
 	cmd->entry_num = done_num;
 	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a8c6bdf64825..e09dba3588ee 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -362,9 +362,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
-		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		/* hwpt_invalidate does not support a parent hwpt */
 		num_inv = 1;
-		test_err_hwpt_invalidate(ENOENT, parent_hwpt_id, inv_reqs,
+		test_err_hwpt_invalidate(EINVAL, parent_hwpt_id, inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
 		assert(!num_inv);
-- 
2.43.0


