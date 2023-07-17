Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB12756B90
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGQSOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGQSOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976AB1989;
        Mon, 17 Jul 2023 11:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzosH9wNzsZgZPPFFVT76eHR90xpy7I7GpUoA2GNXQJhI40+GZ1G9nMgS/g5tPzEvHK6/Mvq7/wfTAa4XN/dh7yJ7gp+onRDNJlRA/5XV0288oLFOgnxTitLi2jN5qh6uBYCu/UUgYmwnmOegilbZuwsR5AousOMnNzi+sIC450YGrDE+6z/yuhe/nLCI+XWz4b+0HrIpiIyvrE0JSyfhmNOg/e3wn4I0UGyajgvRqYqjv3CBVe4bJV4yYLTYtet5hzwywVGNaKbrGlXNNiST6pA1wtG3k5rpej+C4r7WHPf2PAw2xcQxo0NG42nx5qhAghFnoZeiZuOQz4ZUX37Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKavxZx0xtJ4+JXlz3Upn7Vkv7zIMSYBv8i+/jLoCZc=;
 b=cRCsGw8lpiA8tlIKjiFl2hJiv+nc5I9tsv3gQZRa6hA0lVRhdRcVrZ00cxPwJiyDFUMNHrB+lxpiDjflz81R6bV14caMaymUxA6bT6ARkCrKhW2C8AJSIcIeU1Mw3/rnkV5z5d8s03YlsJazsSKPeFoGPWZt9tQlZdJQg7dao9arbO/JB+Y9GLZqeEawQLrjvAQcbjxEfKxosv2hi+kvyuent/HuUcxwNIIzj1RmU9pXqxAdIdtZeVGMH/PPzRXYKWLBJx5NqXnhhpsXwn7w76xx3z+vYBNAEke68SDHpPLsSMhOwMFvbc29PoyXeq4LAFpUGZ47SctAuwsFlpWy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKavxZx0xtJ4+JXlz3Upn7Vkv7zIMSYBv8i+/jLoCZc=;
 b=o3TbJhlHuslOiHbsXTn+cYZfjM3nvJ53W6IUlpoIxkUeBaMchIGPqtzvmiKyZneDfpJ5D6wWs198PKZWGa0TsbO1b4G5bxjfXcNKpbfPPbgvqQme8qPdtFrttLcd2eMQvU4YM0+2IT9pvPz1OoJrOX6HEfCvuE4ykJy+rSPGi822RNCh5jX1PENtZfBOw1sEQMw8eh1OmStZEp789se/trv5KPYOH1JjTBO/uUbgU+cNRm6U7Mk/zMiS+3OX7vs/X+CKwPn18vHlh3eC+hJHiVb/wXrB9fy0Y8qvELYZO83k+LlONtDfojCKjccNeW7y8fG8olB+ZNCCv5SH3mZmmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:12:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:28 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 03/19] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Mon, 17 Jul 2023 15:11:59 -0300
Message-ID: <3-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ab128d-5be2-465a-aa1c-08db86f15d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQhNKXG6igp9jvE6uW98cbXwQyo3OLMLNaUApd1qjx7ViO7gwQPu0ynn10RKB6tP8QwFPZJNkzCsehCHSFv3ymId2c5IKOzhLaE91X+lFON/ctSXHqovaaAIqSEL/OaswMuutc8diWb0PbrD4Yf+WGsSe5Upvep4akERheQLNYzUSNVuhj9eEr5cNuelWKkr4o7bOpSyHc90/MS97B4JLqkOuXS4/3E0PN+WjzCjaSCyuxIx2AyM7zU3nfekMAh3QkOLkPZB0YP1jCIrpdW5us53NXBH/l0jEwB/zO1vhjKUi5nlQjksmZlzqW61pkvi8BiwndD4s+HgLCddIXh8cWmX5B7Zi+o4oAKxe9XuJvf7yDsS6PH5CYz9nkVXM4a8t1TPpm/3uzHgE0cA35yJE6EAfMWwD5FXWlIDx6ioEqOEKrOa3D3qKNI741PIslfYnNHyT/veQZUKp5flzWJ3o8AYjnxNkjDDS0Uh4s3vuNR6vRvvBLB+1qMp91sq70M64jTX3IlXF8T0x1FlVpCAIrmSND2XMXUvP/f05iXbOeUiuPi+UBBOLiXUhy+JYwkIuRYQTTKSjEh3yAihrb5gvYKNEYWxclpmxlRdusrfblc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(316002)(41300700001)(83380400001)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(5660300002)(8676002)(8936002)(30864003)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2WjMBV+Wz+smfu1LOvpxbWMDgFK7EHrglVuKvOqKlLUrEzyL+1A31uNjPg1?=
 =?us-ascii?Q?xNxvttX/dCsCj2Ctppxn0O/hMyn/fcAf12VueIwfbnWtsydTvU8uvonextdn?=
 =?us-ascii?Q?IgtntORLEM+6JbLAjk2JHRfJwWdcirlvidNpaVMvVA49qZa3fpYt8nc55+aA?=
 =?us-ascii?Q?XlpjwZnB7qLCn2XOwKYJx/ER6ANO13815VhpSGnjUrBPStD3xuom49ksvmjI?=
 =?us-ascii?Q?A/yUrIPp7QQs5alMUeQPulcKwrUGu4dSS4GjH2dfKm9pDAOCXqiMZls5CH1f?=
 =?us-ascii?Q?lSyNH18qq4srcKV0IkdbxiZVYVGYvVWc7FrW43Y7PVsp69W0ebQHZYsQbNoq?=
 =?us-ascii?Q?+Bk22L36WupK/InlpF4lA9hhRFReP4W1NcuroQXaS/B92ANNz69FgzyHkFmB?=
 =?us-ascii?Q?dr4CKmlEhuHIlulGhQUTseuUHMzUM3STbUgtNQI9AJdm5KCrV0+PP0FCh55Y?=
 =?us-ascii?Q?4Q88dUiDcxd6jgdBlbrd01y2nD8l4m6FzeqmCtN+DXdMIRo78jrXPNMNFkyr?=
 =?us-ascii?Q?DiC6fXBB7e3RlEMUypQeU9vNz25Gs+29b1BGzET2u5fxEp176CfpcRP4cq3v?=
 =?us-ascii?Q?vlG8mA1bq559RDMNDhWXwtbLeJRCJJaGuYCbhWSAHCgkHym0Tzt+kDdIX1OO?=
 =?us-ascii?Q?STyLoz40kLHHaN2qifHvBk38ls5pU0JxtWYP2eTWY8KaUKrENQ0Wriog+W+k?=
 =?us-ascii?Q?idGoNYVh/Bh7yGaklRrkQ5n4xg7733HvMTyDZ0McmSrt3JFH4Tvhz8IKiLRT?=
 =?us-ascii?Q?dRAzEomIEDF6Jk+3bXxwey96vl6o6QmYrfqCTyywHH0E9NALzFPsZy4EHqnO?=
 =?us-ascii?Q?QbxVaO3upNp2SnLO9zQkP458Ld3DcPVbn8p894D54Q3EoaX40BkKVW7IIXYQ?=
 =?us-ascii?Q?YhI7KcB2Mik/vZh20HLaqCXdrzhCfzZ+sCmmrUQ+Y/ZAnINPLKcCjrdA+qpZ?=
 =?us-ascii?Q?neqGKJqskld1IgWSJbP1fxqcUEuP0xw7TBux6Zl+WIXutjg27wyi9jR4zTe9?=
 =?us-ascii?Q?PH4dzdjHoJ0mEWiTVVNPWy6SCMRR26Swp1qjV3UZ/SqvYfQjZ1oJQFLG4D2D?=
 =?us-ascii?Q?QOr40j0iBrkffb4BdoCjlzo/vgN+Tyjf4+EtjAt5GOOBANJ9JWbk8E+PIecd?=
 =?us-ascii?Q?5dHKf/fr4p4JuRyIhVGYDrM2ZnhBCMcNlUbt8pGbcE9BCE+txFXsHgz87gYZ?=
 =?us-ascii?Q?e13lQe5WhlIJcAi6907QvsYPdtYMaNRe6xPAY3ghY/5yVx5ruhE68W9MaWIt?=
 =?us-ascii?Q?aNlH98GkxAu8AVIIpkZBtH68VFlupqsBtCbJJvcaKmknlV1e3JP+zFD35Gs+?=
 =?us-ascii?Q?Jx6PtlGsyOjsJ5QmPXgrVIkgsIAXlRIDiyz30Zg3EnI1viiobvcJCgPMPrZc?=
 =?us-ascii?Q?kJHYiuMMKK+hpnLJ0aVgl55o5n5YlrjxmNX6htEO4nvSfEJtZpo2EQz4JVIO?=
 =?us-ascii?Q?J603SXlY4uocBhnejrh1Mb+wvYRnEZab+YdZY8fl3l7/j91xmy6e4lIt6S5H?=
 =?us-ascii?Q?PMhIC5qj/Xs8TozixLRPMguUYK/7CQP9y0AdkoOBXhfSFdW+IxQ2HJsDehuq?=
 =?us-ascii?Q?Ad0ns8anukkUxfgjFMNJ7FB/9lcUsDxPvKtpjZNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ab128d-5be2-465a-aa1c-08db86f15d4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:21.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu4miS+w6pVzsCKvPYSdOWeLtGqZ0Rtq2UhNFfq6qfSpvyfD5pGKXDE6jlxavkN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 100 +++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    |  22 +-----
 drivers/iommu/iommufd/iommufd_private.h |  13 ++-
 3 files changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 327057c5461715..0ab2fdf9c76be4 100644
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
+	mutex_unlock(&idev->igroup->lock);
 
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
-{
-	int rc;
-
-	mutex_lock(&hwpt->devices_lock);
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
-
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
index f45615f19798e6..e2eb1db5f8f8ce 100644
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
2.41.0

