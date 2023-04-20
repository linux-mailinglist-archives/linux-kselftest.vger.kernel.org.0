Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A056E9C09
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjDTSwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjDTSv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874C35BF;
        Thu, 20 Apr 2023 11:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP/0m6W0dDW5TZ/unYY0S1xZrt5a7+plSK3FgfDbs3t33A3bL1+M5OvwGDyXH1qOq7rtcIsYSAtAAKUHz0EwhxEFj2/dm7PZTXOm+n74oCGvVmOcXxIfBa+tCuRer4JufX7DMsPthj5XG0S1dUfUYQDyWCRKM+K0SoeDwNugABMHtjjCuVxE7Zq2MrIhPvkXevC3BtFCQEwah91JbxuR/8IJ7n8iIYxk2QY5wSABHR5tIQoG4B2hKewxpmhVt8la04JIB8rqNRLSjF0f4DiyF3vVUacJhSuYMmT+duSUSKCJOwwKo8GZCVri56HCUn7XBiUVGLDXoyLxR69Qq6cilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=YekFlJ70dNMWyqFQkl1YCeUllePoQ0jHQo6LnANWgO67Ue++iaEMuP4veJqW9b0Th1ibFIy00K7O5CZTkMmAbBWgpR7emH+gFq/SUi8S4oaGv7DA7p9RYKRWbasvjpZrGkXuiENmbvuWegmUWGXJ++JhBweUxtJQra03KsOg+ROZ0Cv5io0duKkwTgeAc/O5YCU0aQiu2QJO5rDV8zyKK1IVjV/2SoJypuhzZEqT03AVkm9XbS18d86u45e9A8MR9W4WVkt4CprtO+1XUqXqIbfQCWAACnjSu2jFiZOC0PgsXPHFBfZvb+jprqCi/33LbLP9gqA6vBmK3VHJ+WGJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKnolzfT66UVjhCW5P9kzq/7vlXczbFBSK46RGNX3A=;
 b=BcUCbhKulMNkoYVoYf5IFEMAnYkOc0alpXF7duqWG2WUpHorVGqfB7EC0X7bZ525uIsSlxWB6c2DxRMU14Gk/KGMPwcgPIm26LWMtKV6LobYPvAVj0fI4ncIFWqvgtPO7c+TnWgvYJbNqRnMxGhDv4wXKq6gLaYCbEVU2lnc6abLvDERdZn/apVknqTosLtkBvf0hRGB0REHnOdqheCY1QtvyM3USeGUpG/9w8GtYj2WSvCYVRTI261Rl3ZR+EzUDcVRAmjSgZh1SwcP5Oyx27ZWYnp3QiwPN8rlF9+7Qchu5khe+zFvYNHAS9WZRhSXR//KqH7U7BA4hUa1QxXgjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 02/19] iommufd: Add iommufd_group
Date:   Thu, 20 Apr 2023 15:51:17 -0300
Message-Id: <2-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:2d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: e848ac29-0fbb-4770-1941-08db41d045a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBTuffLQC1bzVNdUh8pOx5R6u4qomhNMIhr0Ivny3NlfYIzeFO65NMNMK1QRMN68KPJ6lMtRSeo8oFc6G+vIowSmrLfsNDcVQtuN1z8UI8srQA2bbmZCft39deiVOgV1Ozer8GTdNc6n7o8RQtIIz7g7mjKXw+HThYitQvvTegUgPdxJaNeiBV17CvN9QN9bFxjduOHH4egluYmXMdX6wV4U3WqO70zj/YylreU6NBSKo5gvn3B/KIk1oWTZO8G1+uSx55MEy+Ls0LxyXemoPYCoO76LGAmNJ9QVI5gdSwlUwNQ5ipnRPpgE4DvdbHNPZ/mjMIjWYAXb+j6Mh8WaclQKyCevq/hDjFgjzyVrEb6hF7tSwsP1VlzxEdt4Gi1yn3V73mvohs3cw9KtZPAoeQucIdbV/V6Qbu/nZB8SIDPJZKd5aI+Gy2zEmKNX5+5uFlQlS/NdI1scV3PRhxlzsHTtoQ1kVHcq3WuYTQKXC3+j1PYpru6pjoM2ihDswo//NxBfVIm/7ra4mRL1tJDsoBk56wR6VE7vh5ZqZUZyd/IELjg6s1HVE+23xCTSaPZTi+O2OYKbF16AYXsQhZXew0OHOlU6gdhOPEzxPWQJIfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q9I0Pnms+yD9cRvL1eEYE2dThNFwWvGjkZvQ6Pc2RsNXGjfZTrzOx6G3yFN5?=
 =?us-ascii?Q?yrFMBSIOZcI7EQasc0qCiT8suKklSwv6BcECcuFeUYEx0ndXoTnwwdS51vdV?=
 =?us-ascii?Q?XlwQYsTp83I0cV3ilZSOyI981YQ+u/r0uwwZzuRcl0SuzoQvKzrla59pXyAN?=
 =?us-ascii?Q?yXNOl/umDKV47ixg4LkytgVVkGjEKF67CJd/+n/z4IfPZGR93lhRKVYQ4B/V?=
 =?us-ascii?Q?gBnv63AGsMn9ok5JgRwYcramBwgJKK5QP7o86BxaRZUTAHE8n0KH+eBrur9i?=
 =?us-ascii?Q?yAl0dKA8MLZx3WM3wGsatYyi+/yiicH21FwgdLJR7EPLlYGGAX/eSFI916wy?=
 =?us-ascii?Q?jt5NGsMLX5beZOSPXZOMWJud37MnqVTYxW4sqDVFgZFY1Rg7e0ukc49Oczi/?=
 =?us-ascii?Q?9rWRYuxJ3skQwTiVLklNV1smatWxivrmxpLR8dwPfziK5JosNWkZCHKBDChN?=
 =?us-ascii?Q?PvW05mhb90d8bfeLhCvaKyxWn6WOl5x2F0K2GPeeO/bd/ssN9lic+8BOGJtM?=
 =?us-ascii?Q?gttSCGkNc2TeGzFrAY/SlcgCqPQTNv9tteYucmDrfw8A6wqxSQZsklkp/ZM2?=
 =?us-ascii?Q?JFh9kGpA9E85153YWSzXO1rcP7cUWYz6XUtbSgmh+h20pkOpWp+HRjErgCoY?=
 =?us-ascii?Q?pQHE1I+1XCNGtaDI1PfIvSLXLC7OyjEgpFdyBdu/1of2GiOqy7lPJKkfs4W8?=
 =?us-ascii?Q?sKNqlGt1gonYosojRvl+tsLLmYJ8oR6PD0NondCKFn8EmzrL1VfQOhNoGT48?=
 =?us-ascii?Q?LeQTII1IKoWiqL+LyNEupXAAYtpeUBpMArnkW2sV8GR69+dIjZ7WqqD62Kb5?=
 =?us-ascii?Q?7MHOZlgPkJrjud3h6XZ6REeFC3QR51Zf7mpOs/QpNUPZJqtB4CVHcImxB1Ee?=
 =?us-ascii?Q?ujjODKahQ7kAIsgWWfucO/G1MF0J4DAXRyeCzYcTcqYxxZ/YIbhsqDAV3pVK?=
 =?us-ascii?Q?/0vC1HGcZjz/lx85mB2wa7VKvy9td68jgFgcxfEmoOu2HbJoCfgMakzn3H/2?=
 =?us-ascii?Q?uaa6idskaMxCnaYrkUDbx6sfDL2/idqrBuT7NAzV2Uo0eLYbufVjflxXQvDk?=
 =?us-ascii?Q?SM5ArGk3Uux8OHu30jbfJ2kQ4cwaAb/vQnYA/tCMOoQvAjLyQK89uC/Bw1p+?=
 =?us-ascii?Q?IOwq2mobLxh48nM7D8JHm1Ey3skTnkGrq3JBDRSallBVYXm4Sx6xvDdhlqJx?=
 =?us-ascii?Q?oJEw629YIToxVxGvu3bkIXTiLx0kav9t+USBmQLDpsAwVgyhSqI5jf/MS5nv?=
 =?us-ascii?Q?+wTOc9bQ0yegmter3iWqjkaPr+VEqq0k81QGqV71uiJwTKlTvWYJ4jALIwHH?=
 =?us-ascii?Q?prc8+1hKmyAfsc+FfT8wp4WZkjHrlJZ2D1WmkiopKdn9p9iSRXJrvq4rHqhR?=
 =?us-ascii?Q?AH13LUuNzOb/vp/p54bUAlLKBfKY64aMd0ugruQKBPi1HFOuP5wIwY6Xc+ag?=
 =?us-ascii?Q?G1Mb0HHMWnEIgPKJ66fGNrzI7/ERIbApFM3Irghaw7b8RRXQ48wFDSdxbWNC?=
 =?us-ascii?Q?zmKBYWLzk5R6wrwxDAKZsQ0HUBFUfNGXXmvy0sPPCcnU4TSB5LLnbCf03fWh?=
 =?us-ascii?Q?IPpyv1YRmpds+KWCeMESbZEWlXCFTgOBWz60aUEz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e848ac29-0fbb-4770-1941-08db41d045a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:38.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z51/O4k4rp198sKPNFmDSLQKzpDahevSKCQZ+9i8Me4eZh/LFmjNAtzEvl45tt41
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the hwpt to device attachment is fairly static we could get away with
the simple approach of keeping track of the groups via a device list. But
with replace this is infeasible.

Add an automatically managed struct that is 1:1 with the iommu_group
per-ictx so we can store the necessary tracking information there.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 141 +++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |   9 +-
 drivers/iommu/iommufd/main.c            |   2 +
 3 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e66303c17c894c..3fd623208c691f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,13 +15,121 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
+static void iommufd_group_release(struct kref *kref)
+{
+	struct iommufd_group *igroup =
+		container_of(kref, struct iommufd_group, ref);
+
+	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
+		   NULL, GFP_KERNEL);
+	iommu_group_put(igroup->group);
+	kfree(igroup);
+}
+
+static void iommufd_put_group(struct iommufd_group *group)
+{
+	kref_put(&group->ref, iommufd_group_release);
+}
+
+static bool iommufd_group_try_get(struct iommufd_group *igroup,
+				  struct iommu_group *group)
+{
+	if (!igroup)
+		return false;
+	/*
+	 * group ID's cannot be re-used until the group is put back which does
+	 * not happen if we could get an igroup pointer under the xa_lock.
+	 */
+	if (WARN_ON(igroup->group != group))
+		return false;
+	return kref_get_unless_zero(&igroup->ref);
+}
+
+/*
+ * iommufd needs to store some more data for each iommu_group, we keep a
+ * parallel xarray indexed by iommu_group id to hold this instead of putting it
+ * in the core structure. To keep things simple the iommufd_group memory is
+ * unique within the iommufd_ctx. This makes it easy to check there are no
+ * memory leaks.
+ */
+static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
+					       struct device *dev)
+{
+	struct iommufd_group *new_igroup;
+	struct iommufd_group *cur_igroup;
+	struct iommufd_group *igroup;
+	struct iommu_group *group;
+	unsigned int id;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
+	id = iommu_group_id(group);
+
+	xa_lock(&ictx->groups);
+	igroup = xa_load(&ictx->groups, id);
+	if (iommufd_group_try_get(igroup, group)) {
+		xa_unlock(&ictx->groups);
+		iommu_group_put(group);
+		return igroup;
+	}
+	xa_unlock(&ictx->groups);
+
+	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
+	if (!new_igroup) {
+		iommu_group_put(group);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&new_igroup->ref);
+	/* group reference moves into new_igroup */
+	new_igroup->group = group;
+
+	/*
+	 * The ictx is not additionally refcounted here becase all objects using
+	 * an igroup must put it before their destroy completes.
+	 */
+	new_igroup->ictx = ictx;
+
+	/*
+	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
+	 * value to assume for the xa_cmpxchg algorithm.
+	 */
+	cur_igroup = NULL;
+	xa_lock(&ictx->groups);
+	while (true) {
+		igroup = __xa_cmpxchg(&ictx->groups, id, cur_igroup, new_igroup,
+				      GFP_KERNEL);
+		if (xa_is_err(igroup)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return ERR_PTR(xa_err(igroup));
+		}
+
+		/* new_group was successfully installed */
+		if (cur_igroup == igroup) {
+			xa_unlock(&ictx->groups);
+			return new_igroup;
+		}
+
+		/* Check again if the current group is any good */
+		if (iommufd_group_try_get(igroup, group)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return igroup;
+		}
+		cur_igroup = igroup;
+	}
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
 	iommu_device_release_dma_owner(idev->dev);
-	iommu_group_put(idev->group);
+	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
 		iommufd_ctx_put(idev->ictx);
 }
@@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id)
 {
 	struct iommufd_device *idev;
-	struct iommu_group *group;
+	struct iommufd_group *igroup;
 	int rc;
 
 	/*
@@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
 		return ERR_PTR(-EINVAL);
 
-	group = iommu_group_get(dev);
-	if (!group)
-		return ERR_PTR(-ENODEV);
+	igroup = iommufd_get_group(ictx, dev);
+	if (IS_ERR(igroup))
+		return ERR_CAST(igroup);
 
 	/*
 	 * For historical compat with VFIO the insecure interrupt path is
@@ -67,7 +175,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * interrupt outside this iommufd context.
 	 */
 	if (!iommufd_selftest_is_mock_dev(dev) &&
-	    !iommu_group_has_isolated_msi(group)) {
+	    !iommu_group_has_isolated_msi(igroup->group)) {
 		if (!allow_unsafe_interrupts) {
 			rc = -EPERM;
 			goto out_group_put;
@@ -97,8 +205,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
-	/* group refcount moves into iommufd_device */
-	idev->group = group;
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -113,7 +221,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 out_release_owner:
 	iommu_device_release_dma_owner(dev);
 out_group_put:
-	iommu_group_put(group);
+	iommufd_put_group(igroup);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
@@ -170,14 +278,14 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 }
 
 static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommu_group *group)
+					   struct iommufd_group *igroup)
 {
 	struct iommufd_device *cur_dev;
 
 	lockdep_assert_held(&hwpt->devices_lock);
 
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->group == group)
+		if (cur_dev->igroup->group == igroup->group)
 			return true;
 	return false;
 }
@@ -211,7 +319,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+						   idev->igroup->group,
+						   &sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -223,8 +332,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
 	 * the group once for the first device that is in the group.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 	}
@@ -237,8 +346,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
-		iommu_detach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+		iommu_detach_group(hwpt->domain, idev->igroup->group);
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d523ef12890e1e..2544f10dae9aef 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -17,6 +17,7 @@ struct iommufd_device;
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
+	struct xarray groups;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
@@ -262,6 +263,12 @@ void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+struct iommufd_group {
+	struct kref ref;
+	struct iommufd_ctx *ictx;
+	struct iommu_group *group;
+};
+
 /*
  * A iommufd_device object represents the binding relationship between a
  * consuming driver and the iommufd. These objects are created/destroyed by
@@ -270,12 +277,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
+	struct iommufd_group *igroup;
 	struct iommufd_hw_pagetable *hwpt;
 	/* Head at iommufd_hw_pagetable::devices */
 	struct list_head devices_item;
 	/* always the physical device */
 	struct device *dev;
-	struct iommu_group *group;
 	bool enforce_cache_coherency;
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a69..e5ed5dfa91a0b5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -183,6 +183,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	}
 
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
+	xa_init(&ictx->groups);
 	ictx->file = filp;
 	filp->private_data = ictx;
 	return 0;
@@ -218,6 +219,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 		if (WARN_ON(!destroyed))
 			break;
 	}
+	WARN_ON(!xa_empty(&ictx->groups));
 	kfree(ictx);
 	return 0;
 }
-- 
2.40.0

