Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9D6E9BF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDTSvp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjDTSvo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7A2722;
        Thu, 20 Apr 2023 11:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5idkkagxxcgPUphndLm3hKoYMQ8ybpBR5bcN4IzLxJfKc6BWetx1+YdZCqrCl36ZRoKi0GqPlmaAKJfQojR/2XfQoQuXK7CsOScO90FVupX3CZZT5Zk59uULiJUiMRg6xNgiyXUducPqShQsYqX0z2a9ah2VXkxwqnIJzuHpzhQmCe3m7rFVrVNJIv448z2hYBPehD3+3Prk4lcW3zGuLGEpNoGXl1TJ6LrBqhFYUeOVCRZh0zdZGDaiDPW7nXMO06XX3TbaHe/fzlQbfrNpmFXWBxntRx9qFqiHvWnKD+dAm6t2LZCMtq+Wr8TPw4NhGokcxcmd8BlxEdCtA/Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF9CYXMf/7HRZlzzbzfWpeCrXmJIPYP1jSbYNy/mgOI=;
 b=lKhQjeUepaDIyGQmFSNJv5nGDArtYt3zZO0YW1oABclf62dhBKRWL3Xg064CQOyjamkdDE2/UpnVpCbDbjfIkiC17tCcdhXQyY+BY+Q8z9IyW+BL1fMIC9KsuOV8K2T1z+JubzqV6EXQe0ksf7LYhS1DsZ3g3ZAReh1diosgk/FQT1jSKt+1zeb1FOQqZ/pOZt9ZrDh267TAgT0nRVeF9mEIECU/0v3wbt6bfmyl1y84EsQf5JAlxXoQXp8Yt+RrdcTrzTPxPNb1xXNDcppdduNPDPJ05TgEtq7XUOWWjlOW6V/XTUkBhWzLZl5kvE+9DqDif2O+v8qq2Pp2ZL6a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF9CYXMf/7HRZlzzbzfWpeCrXmJIPYP1jSbYNy/mgOI=;
 b=uWMFjvXEMB4iTGN3Xnm3wSU2G2vwSWnfu4/Sx6/sQ3CS1eJWBtw4YsHBRZRgbcq0u5WljeKNLbNG9VyAOvqHaxaWJBb7QZIHa9z7I4qr02NEFNmQbzAZOR2Z65un5SwGbM78tzjRWPymOGYrMs+Hf0AQHbdr44bGwaOAmWwAtGIw0/T7bmFBiKP+NNZBIw6P/GGyLe3GT6EzyavV9CmO4DVFKFVKdE/ZPSZwSAVlOzD980M2xlVgfzU3IZPOmCY1FGK8sMfWLdh4XvwFqITePxCMjIZGuvvrz2Dyxee+IM6Gzw3ef6d7tNBL9BuvAu3UjRxEujy+WXq/8kz/FHAV+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:37 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 03/19] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Thu, 20 Apr 2023 15:51:18 -0300
Message-Id: <3-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:2d::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e3458-de31-48ad-e381-08db41d044a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf+G9U2THOf61zpQKZdNaE1n9+AR/LxPbG9PQjXxneOdUiEtwygWTYHSdWJfv+jBB58JJVFhaNFO5jLRFccJIUT9EDJgfxY0zCUHeyPg98UXylJrVbszNz5D2o+WvLsAJ5rYz8nkPPHhNA1rBBHWYO5pK+/s/VGcCkrQ5BdK+ucBGHzDnQX0JZ/2bojtnaQgMzoHC3P8hSlFuQNABETJnhGwIFhsjiQ2lGemltEcCRASaFV658+pEk3sUheEnf2CrXGVEdJnKEvmwEN4rL3RSMOsVgQ3E1v3MqL/FqIaxGCV5M0QBP1QHgP4aB2Ez1Dq8+wyvIRQ0zjcq+mo6+eqj2HkW+/D26ch7bsobRW9LT2ZSREGuUzFetHdjPUxLd0Lk5O4aFnffSeXxdZnu7UXEfV1c/eksXm2T3JZe3SCI6R7zsASh7lpxUYBFH3pO8saG7Z6W/WQrTBJRyNAHrS1a0RonbT5ZIUysFRwxgPIyScIy0faZqPN2H91DC2wTsGJfx4u3ZJddCVajIHTQUUuktXLUoGmVFzh84fDvPi20Isj24Lm+eCprf9mmGdA+Y2n23RPpxnwiOnLKYaB31mY51qclFX/HcrYgL40AzCqbss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(30864003)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qq8w9bFSWvVPCb4Cv7FDgVfLgkwOKAgd+1mSjlzOA7PNo5XSzsCbxideoQaj?=
 =?us-ascii?Q?p/LMQy74mmAx/mVSqnRxa8oqPkg+gsfZdcEQZe4fFi6aZD78NKv8rgyzAGwo?=
 =?us-ascii?Q?rzvM86561HEAZe/xasuvEESqzGGzWODFS6nvDZgdK2f8A3QSK7BbKpDk2Pm2?=
 =?us-ascii?Q?Y1ulySDVmpvGEBXdVTYqIhP5EfcY7DDb7a2VzScmY6vsZkx2YtYxaalhETuL?=
 =?us-ascii?Q?E9WmKN90r332Ce4EyyzhKzl9lgj8TOA9tWJXgkDy6Lg/dTwUTAjQ/ssvo5cs?=
 =?us-ascii?Q?bRXHnWm9yrjXkuR0T3G55gs8uFkG9YeN2wY0GQsNe/qmfEnJMTk/ATZFvDEE?=
 =?us-ascii?Q?3USwPDscpuqbfI5o5q8DQQ30/7oBg22Iw+zpcH+jaPc6X6k8UDI5ODN5f9sS?=
 =?us-ascii?Q?kNc0F53NVwEroS/oMdEY0+8zBwETpNX2Wy72NwCth1Yt39ofDGCqzBWnr+Sq?=
 =?us-ascii?Q?MJaaIzD/xWQkTPpI900jBAuEr+qbbQkWmarI8mmCivAEDw0a3/wG3d9vbypL?=
 =?us-ascii?Q?17grWV3Fc2bcriiMo8rEhxlzD5xWM/6OlIUPhfuvy2keUAr+c4Z69TayPIhX?=
 =?us-ascii?Q?Oo8isjWRUapSaBYFwTPtKtnddTaXiR2RG+em+en9VsQixYnPOyDTPcExs7vW?=
 =?us-ascii?Q?YRwCFDxkxrVamblxEA2o5aPOGCQDg6nHGyzKO6p214YFV7ktgC89rXVknX28?=
 =?us-ascii?Q?UUllBURWuNIAvw7cho3GCy7eZ5UjIt9yZrIQnudrhwRxsDQsVllYCDwdl/I7?=
 =?us-ascii?Q?+A/J9keHp6hTWsyVCwBircqSer1RZO0bZd2hn8ewbEFsR0ZIkyoVu+pmPsuG?=
 =?us-ascii?Q?ucB8CEA00s5SZFj3gTOgLKL2fq0Z+R0XDYIvU11yWlxU0MBWk4l2Os1cGMnD?=
 =?us-ascii?Q?o352x41V+Gjl3PDzp0S4HngU1oaQs5GHNtgbqQi4V/QBMKsK8o0y+eoFTHDf?=
 =?us-ascii?Q?6xpjg6L+nw9yBejKymjkyoTsnk6IpAKGKjEvT7PRlrAFLTzF3PEMMDNjp/l2?=
 =?us-ascii?Q?lcKd1mXiu7OnYWpktU0n1xb6DfZ/MTJjOCavt6YSUQFZyX5LCUlwwwWFfXpa?=
 =?us-ascii?Q?Qm23987OZE+Kmwud21KPeXFj38bwVPauDO2IOfFEdpW84xbDJ7D6oFbDBBtb?=
 =?us-ascii?Q?ZYrUAYYr7lYJe+BYFiwSlQSBanX6J7C1rnBMHiVLYT3txrmabeKjCly5t0RS?=
 =?us-ascii?Q?sXHN6GpyiBkRwOyM0VrPPbYJRyrqm2FDuLj3ctqyB7Os98QXaQLCq8N++9uf?=
 =?us-ascii?Q?e/c/7WY7CmnrAFnv/DcQlM9tnN+GOvwUUMK4mYZqrUpySALyeDGQA020MBT0?=
 =?us-ascii?Q?p6UfKWd1ZyyxIF3YkFYJzjqeILoC3GQdDcIQ7frww4lheaZbFfvq5ETLlHUC?=
 =?us-ascii?Q?jWV6b5fSvF1KtYCHVcjo8+N7miPjAZs3Q8zMcpH4qz8xuFV3nccjD1s+2nXd?=
 =?us-ascii?Q?g00dkc3tscS6Xzfp42wVRKP3RRXseIz2oVk0RuSG+SYxSyj9446OtJvyYqTB?=
 =?us-ascii?Q?JGS+o7CuobUmSqhxjedCvkwW0lyu0k7h5vSy/TEIohfwi1Ub/570Jr4S3ovw?=
 =?us-ascii?Q?+pVsQDYhOjbV/s6+DvI1XyTREcxBQQojiFGh072s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e3458-de31-48ad-e381-08db41d044a1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:36.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O87KQxPzm/PAIrmBKS7gUCeQr+flLyZDslkp4bOiWReO4s4MdoVgzH3d7sKZ2yql
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
 drivers/iommu/iommufd/device.c          | 100 +++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    |  22 +-----
 drivers/iommu/iommufd/iommufd_private.h |  13 ++-
 3 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3fd623208c691f..33f9ab2dc5f4ae 100644
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
 
@@ -322,51 +317,52 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+
+	mutex_lock(&idev->igroup->lock);
+	list_del(&idev->group_item);
+	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-}
-
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
-{
-	int rc;
-
-	mutex_lock(&hwpt->devices_lock);
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
+	mutex_unlock(&idev->igroup->lock);
 
-	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
-	list_add(&idev->devices_item, &hwpt->devices);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
-	return rc;
+	/* Caller must destroy hwpt */
+	return hwpt;
 }
 
 /*
@@ -375,7 +371,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -392,7 +388,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		iommufd_put_object(&hwpt->obj);
 
 		/*
@@ -402,6 +398,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +408,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -446,7 +444,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -455,7 +453,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +464,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,14 +481,9 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
-
-	mutex_lock(&hwpt->devices_lock);
-	list_del(&idev->devices_item);
-	idev->hwpt = NULL;
-	iommufd_hw_pagetable_detach(hwpt, idev);
-	mutex_unlock(&hwpt->devices_lock);
+	struct iommufd_hw_pagetable *hwpt;
 
+	hwpt = iommufd_hw_pagetable_detach(idev);
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
 	else
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6cdb6749d359f3..bdb76cdb1dc347 100644
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
@@ -65,8 +60,6 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	mutex_lock(&hwpt->devices_lock);
-
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
@@ -76,29 +69,18 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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

