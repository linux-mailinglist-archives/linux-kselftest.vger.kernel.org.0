Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924886CAD4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjC0SkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjC0SkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:40:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CCA3AB0;
        Mon, 27 Mar 2023 11:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USjHit39ETv0qWe76++lMpMuaaoq238q+pXGEoHHUnqZrNYx4wak5O/i9QpjY5MhBJpJESwCRPxdOH7F1AurqmMyrWq+xv9aL3+DZB3VtLYEhI4cWFWIipP+1X3mQ35z53PTDdGuSSB5oWOQstujl8EyCCP8zMlvsVXZ3Wmhc+ixWiEnDCFoSCNvWdgwj2w9ZiJGkcPN8x6n3HgGKohqnzUMqWDszacV+qfExV6bWOpywCW3yKKyzJz9y/MU+XmzbkORxSXBJi4/FTd9RbWlUPCQYvnZDEJ04GolWCP+e4rwhCpj0nEh4y39DbMKrTWG/tztB/m7NVUX6fcePoKGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6nDYQUsNfWAbmgRPmdhWZsdYJVwxkTOgAlxuEwaR4U=;
 b=IqR/7t+4Wtl79bmQyLYsmDOBuaH75zDPVRaQHvc3H91fXTTdbBTxb4ymanaPr7oZh6lFiTcwfSnL4q8CvzhhBMXBTBuoJQc95dBVI7mTsPPh+fPHHzehPm5L8V2SNn7fa3eGndFl3UpY0dNcl/pf6W3fqd4xaPuh+MtN4gbj9/qM5QYTl7pmlC7Wk+3mneVR9U4UV3e5ZfeLIQQWpDoLvZpMf2wZz5n/zxmB5jBpo/RMyWXP1wz33nYjO7nsLiVq5AcOqQMwOhLRVlcgMoLRlA0xQNJcjm/Ebzd9KD1vOUooSCLmlZ6VKpnz5nWOSx/uPea9/d2AxuL2CpwdYda7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6nDYQUsNfWAbmgRPmdhWZsdYJVwxkTOgAlxuEwaR4U=;
 b=DmyZ7i+6Dg6afdJ6OLPP4tUdNyuFPY3HcZLZZVP9hK2EtN9CpvNv9eHV04FZpMUFC4sbTSJLg7XeYIZhhnR7WG9QeG/w8sBrHzCONe2eMrOiCzJ/B9PEL2WjcaCUPimZkQ2N2RJC1KJ3QQs3jbyCkI0WKU2O3SRR9/RtGv4cXwnPVbl2mXY9Kzl2lBSkehBQXL6VEiijPiYHnNKYWRWvz+SVC3mVn7tf0+DWDZdtHIYoqRywlpqcm+uJfcw1PGiu7kV9CVmrSCrjk7kzOxKxWr67Urk+dml+1y9eOw7lYLof6y16ZnaS5+EYvbXDNcXBCyaJRM9YE81Ryj2e5Vr17A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 03/17] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Mon, 27 Mar 2023 15:37:57 -0300
Message-Id: <3-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 6157340d-b8f3-44c5-0936-08db2ef26d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6Vkec+ZGDHa2zrbCW4oXkMEeimeCLXk/1beza0BPevLZfnLaGUyeoFLY+3ea/QvYUk6wLWD43gqJAwPI7NkMt79T5qWHw6Oy9Q+agPc3Lfdl1DadexwFHiI1PHbi5gnHhghUZ0E5fEEFwzFiJDD1fyuiTD57AlyNVuYdXyyH6++x+BVR77CKprN88OX8S9V1qbJyATEpVY7wHJNOC8yEXwnOwMxnE8J0iwMSSbwVYM4MHHcr57WruS/iLffeE6KoDokAu2I8HwcxByPF0kBnS5qvE6rzRdUR7R2ayY4nUE2e3QmK1UECLnjEb73TOfUGDCZZI8SQTHzRdoANM1Sa0RdtmYlSuHHNoFSYE6kXBUDu/ukxGu8/3liy9lORnux6d8+a21OD4G642fYKNIREniTNDmAtn0NyuHMF10Cb/75ymkw9ZvvFti544d1qwuPsHAUCoI3nYD1j5m1qRc3pWdtjbgybJsX0bWtjGXnvponBe/5S0Ho4d4DZtrYqkGnNRtIep3ienP5oOJNRrva678anQcY60Bfn12f636oBUXWZV+NkOkXnIV7SB8DCvIKvhRWPy1Yf5j/gLu0TAB3654y0ui5trkHrQrqzfkKsao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(30864003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQt+6bYcQLRvgHJH95xgzAt4VCdeEWo9mJ4HJ9HpYhklhd8zU+S7AnH2xS4J?=
 =?us-ascii?Q?lQuX+xTpJu984xBDtbEfOwbTW3zZ5jXCQG4Bg8Jj00OVTfEtV6oIbnKHJ7HB?=
 =?us-ascii?Q?Ih4a9I64dCaJ5qlomICCSa12fJkC0CdsNRdPvbHW/9zQmDAHd2PgEQhPJ1T5?=
 =?us-ascii?Q?tCwfGD9A5SAhthiedOv20gvfocZ5R0A7bR+CZrz4DPQvdr/h+ryigsSU4e8E?=
 =?us-ascii?Q?/Dt4zcUEX9sp0YJ8BBHhplDfIOJISs43NkfiCiGiYgjAbpFYK+kxruUPEu9O?=
 =?us-ascii?Q?zbU7s5yD5RBQjTju2NksiADHVgbXzRmSRLl4TWpXCN4KSOI0NuR4IETCO+Aj?=
 =?us-ascii?Q?luVWWZ7WISazXtS174OXXSHesBvpCVDdCtNczDwbW98uI90UwZLkzmYsE9rp?=
 =?us-ascii?Q?MgkF3tAN+clDBFS7n8WxXJZ7Y9hLRonuNQqVMJPjYtJG5ZonyrzdWjYvKU1b?=
 =?us-ascii?Q?YayKHHanEKSwuM/S8qa+qnbbdw1emQU5KXIysldJBiyu1Oq66Su3qjqxD+UQ?=
 =?us-ascii?Q?NuzTex3XIAk+jOemFK2y130pKjrilriBeoklJr6fKKRwRETMHl+z/WVVgKWj?=
 =?us-ascii?Q?GjBPZt9le/KA5tIzfnzkqnjYa2S5GDC9vnZdHooocoSYTVJonH8BjWeKcR6/?=
 =?us-ascii?Q?vdW6Hd49r70na4NMQhKeW02dIkPQdmYnbcS9vXVhxdzN5QtFP8z/5PMIVs6t?=
 =?us-ascii?Q?fgbbUUwwM8R8I9cniJzoiYKbBjniN4D43CaqkryCmQyAaUeppOUcOqrctY2V?=
 =?us-ascii?Q?ZDz3SvWgg8UG1AtftIV9A6zPZ53CfN+4AJluFSymhLx5WMdRrKKFfv8Z1OBL?=
 =?us-ascii?Q?vzKD/jrZTduekdYPsH8UKMeZzXYAvNCxh6EXe2K+juJbEMyStKXXH2gJLetH?=
 =?us-ascii?Q?TwV7rOjQVWabkSU0d0RYlH9m731bOvZ3n5BxV+xpnhJzf0s56euEsJWDSsdr?=
 =?us-ascii?Q?6L+0cvYQGNywTUqmfP84L2uBTWkl52EpNx2jIAbkqWupfPcSXjsbvEBPl/Md?=
 =?us-ascii?Q?mdmqs3zknI/HuYJU6bdBlkCJTPai14eb+jdJcyqL6ZPmq2yKpUDUistFPCHS?=
 =?us-ascii?Q?GJDldaBOPqxxWnvIeU1Zo1EpholvjyuWkws3bcjz/aH2Mqhe5M9h/z/A+5lO?=
 =?us-ascii?Q?/enfjy3f+jsD+C2/0h0Ej5uvUKUQ8oTIcju0HfIQemnfSTY6SsWwcbF6w7R0?=
 =?us-ascii?Q?FpsYIf07mdIhFweWcSaa/GMiEr0x/668Xc/VL6SSnn7NDLtmBKsGnQOjmv9W?=
 =?us-ascii?Q?EnV3qWXif8/aIgPJ/LYu04y2MEBzyF01j++yLDFZOwnM0t/SfrU8uvF/pnZL?=
 =?us-ascii?Q?oRqdy3exWrLa+uLnWiHNDDmmfbpcP5ofAiMlGm3IyxLcI8EB+g1zEhkAT7+g?=
 =?us-ascii?Q?OxZtcBt8CGID307t02yqbtmm+GcJGlhkIQ/aa78K1A8j4QVBiWDu9ffmuk7E?=
 =?us-ascii?Q?Kc9xZVUX0zgESvi+8hO82qzQXbMLunilwiTOivt52ESVtG4y/MrgSAM8Vpyt?=
 =?us-ascii?Q?yfrZkkyEFNWdxgUq/SCJXLqOCWNYTgoLUhiI6oYC/p2kI1aLmr8gX5OjD/wt?=
 =?us-ascii?Q?R0HiKpWvr7lr/utohKz+LKgqmvslOicOUAUfLluf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157340d-b8f3-44c5-0936-08db2ef26d20
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:15.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8c5jbnuVgfN0iVBmG+vU5kVCPKPVMCy807jgT/mHu5FLtU4P0t3s+GOxH3qfeml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The devices list was used as a simple way to avoid having per-group
information. Now that this seems to be unavoidable, just commit to
per-group information fully and remove the devices list from the HWPT.

The iommufd_group stores the currently assigned HWPT for the entire group
and we can manage the per-device attach/detach with a list in the
iommufd_group.

For destruction the flow is organized to make the following patches
easier, the actual call to iommufd_object_destroy_user() is done at the
top of the call chain without holding any locks. The HWPT to be destroyed
is returned out from the locked region to make this possible. Later
patches create locking that requires this.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 102 +++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    |  25 ++----
 drivers/iommu/iommufd/iommufd_private.h |  13 ++-
 3 files changed, 59 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3fd623208c691f..58ad98de1914dd 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -20,9 +20,12 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
+	WARN_ON(igroup->hwpt || !list_empty(&igroup->device_list));
+
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
+	mutex_destroy(&igroup->lock);
 	kfree(igroup);
 }
 
@@ -83,6 +86,8 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 
 	kref_init(&new_igroup->ref);
+	mutex_init(&new_igroup->lock);
+	INIT_LIST_HEAD(&new_igroup->device_list);
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -277,29 +282,18 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	return 0;
 }
 
-static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommufd_group *igroup)
-{
-	struct iommufd_device *cur_dev;
-
-	lockdep_assert_held(&hwpt->devices_lock);
-
-	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->igroup->group == igroup->group)
-			return true;
-	return false;
-}
-
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
-	lockdep_assert_held(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 
-	if (WARN_ON(idev->hwpt))
-		return -EINVAL;
+	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
 
 	/*
 	 * Try to upgrade the domain we have, it is an iommu driver bug to
@@ -313,8 +307,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
-			return -EINVAL;
+			WARN_ON(list_empty(&idev->igroup->device_list));
+			rc = -EINVAL;
+			goto err_unlock;
 		}
 	}
 
@@ -322,51 +317,51 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 						   idev->igroup->group,
 						   &sw_msi_start);
 	if (rc)
-		return rc;
+		goto err_unlock;
 
 	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
 	if (rc)
 		goto err_unresv;
 
 	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
+	 * Only attach to the group once for the first device that is in the
+	 * group. All the other devices will follow this attachment. The user
+	 * should attach every device individually to the hwpt as the per-device
+	 * reserved regions are only updated during individual device
+	 * attachment.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+	if (list_empty(&idev->igroup->device_list)) {
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
+		idev->igroup->hwpt = hwpt;
 	}
+	refcount_inc(&hwpt->obj.users);
+	list_add_tail(&idev->group_item, &idev->igroup->device_list);
+	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+err_unlock:
+	mutex_unlock(&idev->igroup->lock);
 	return rc;
 }
 
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev)
-{
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-}
-
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
-	int rc;
+	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 
-	mutex_lock(&hwpt->devices_lock);
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
+	lockdep_assert_held(&idev->igroup->lock);
 
-	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
-	list_add(&idev->devices_item, &hwpt->devices);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
-	return rc;
+	list_del(&idev->group_item);
+	if (list_empty(&idev->igroup->device_list)) {
+		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	/* Caller must destroy hwpt */
+	return hwpt;
 }
 
 /*
@@ -375,7 +370,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -392,7 +387,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		iommufd_put_object(&hwpt->obj);
 
 		/*
@@ -402,6 +397,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +407,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -446,7 +443,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -455,7 +452,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +463,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,13 +480,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
+	struct iommufd_hw_pagetable *hwpt;
 
-	mutex_lock(&hwpt->devices_lock);
-	list_del(&idev->devices_item);
-	idev->hwpt = NULL;
-	iommufd_hw_pagetable_detach(hwpt, idev);
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
+	hwpt = iommufd_hw_pagetable_detach(idev);
+	mutex_unlock(&idev->igroup->lock);
 
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6cdb6749d359f3..a538ceb13a6f22 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -11,8 +11,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
 
-	WARN_ON(!list_empty(&hwpt->devices));
-
 	if (!list_empty(&hwpt->hwpt_item)) {
 		mutex_lock(&hwpt->ioas->mutex);
 		list_del(&hwpt->hwpt_item);
@@ -25,7 +23,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 		iommu_domain_free(hwpt->domain);
 
 	refcount_dec(&hwpt->ioas->obj.users);
-	mutex_destroy(&hwpt->devices_lock);
 }
 
 /**
@@ -52,9 +49,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
-	mutex_init(&hwpt->devices_lock);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
@@ -65,40 +60,30 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	mutex_lock(&hwpt->devices_lock);
-
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
 	 * domain until attach is completed. Thus we must have this call
 	 * sequence. Once those drivers are fixed this should be removed.
+	 *
+	 * Note we hold the igroup->lock here which prevents any other thread
+	 * from observing igroup->hwpt until we finish setting it up.
 	 */
 	if (immediate_attach) {
 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		if (rc)
-			goto out_unlock;
+			goto out_abort;
 	}
 
 	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
 	if (rc)
 		goto out_detach;
 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-
-	if (immediate_attach) {
-		/* See iommufd_device_do_attach() */
-		refcount_inc(&hwpt->obj.users);
-		idev->hwpt = hwpt;
-		list_add(&idev->devices_item, &hwpt->devices);
-	}
-
-	mutex_unlock(&hwpt->devices_lock);
 	return hwpt;
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(hwpt, idev);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+		iommufd_hw_pagetable_detach(idev);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2544f10dae9aef..2ff192777f27d3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -250,8 +250,6 @@ struct iommufd_hw_pagetable {
 	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
-	struct mutex devices_lock;
-	struct list_head devices;
 };
 
 struct iommufd_hw_pagetable *
@@ -259,14 +257,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev);
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 struct iommufd_group {
 	struct kref ref;
+	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
+	struct iommufd_hw_pagetable *hwpt;
+	struct list_head device_list;
 };
 
 /*
@@ -278,9 +279,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
+	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-- 
2.40.0

