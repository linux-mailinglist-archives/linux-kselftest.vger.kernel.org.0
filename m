Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80856DE146
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKQn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDKQny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61649F8;
        Tue, 11 Apr 2023 09:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqOIFYQNJK+3tEtwpfx63GGMAi2iJ1fj02wWdxbVvPt+j6V9GgA2L+eapcuW/MZybpknFyouhWHyjMYpMWYWMWilFZpJYKi94q+IlnGKUobKPaewFgj+9seiHJdW2zGmBaWbLPRwtZFe6EAO/c0LCrVZZHYcbYSszO3q+KFUBSWdGXHzM8qZaR4FOk0zH2jmBlRQ/dwGbEbcKBEVFXMyfOmb/FBr0+rwhOmIV+MtEh+Pm+zpomXzjgBnHIaa6FCJuqQqW6hBXwuZdbSh6ilUJBrGf8dJL1iAOuc3rhAACvCejfO2FwohJ171yLFsqHpp84pFSojCtHkSqianq2+emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMFQ5E4y7XFpx0TNpN5drsychS1gbvFhFrR/KXAmAZM=;
 b=SG8Nh62OzhwmfFuI6v36uxDHUUCi0HibFgLyQ/aL6YOhJMqVRjumjbLIk0Cvdvl3SF8bKJKlmtd2jc4gDgcBxq+cl0xlj6ami7m74V4u6vpgbr0R4qDxbaiVPG4xrZVLjNJ5YlR7sypabUwGpfIev3SRjh946BTiq0utEMYVE4DbXdRHAXJO5ni/bbgiSi68YY4PBuiIJCSMsSySDMKWdIVQVteKQfpIbvuFZxpnVz+zufHpcu1i9EysZzKB18njhS2WJikqOY5GNBs/vymZ+B0buCgu/xSf+eWrdM0zNURMmJpBp98uP50nWvVEALtwjhl2nW4Bx6An4GLozyAq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMFQ5E4y7XFpx0TNpN5drsychS1gbvFhFrR/KXAmAZM=;
 b=Y7Hperd20uMsTPyhAhYieXHCT6DO33BNJN8SZuZbvYLlpw5cfBZiRkafkAPeJiR/KrQQ/KLilxD7GubejxeM1KA6k7hOTSvKhRTRPznHqTsn2w00Zm80jaHh3v97q5l+R87XEGWq8RBZVwx5FusxyzrMiEycyED1gnsw9S0qzHj3TMyWelU5wwsiK6p5Cz4gZ+iQM/114RGSOu7+Tu3NxA7wpnkPh4Ecw6lXGGvX/1tvsba2pT39ysUuQiBMR3fZh1y8J/ggyoIEWtAWkZzjDUR6mUxNw4JXrX6u5q5oQPZhuZgFSxjYcYowIr2DFVB8LYCNFi28cO5a5UWtw0ALcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 03/17] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Tue, 11 Apr 2023 13:43:04 -0300
Message-Id: <3-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 786e2856-3244-4bc4-a448-08db3aabdcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV/jLNSwcxMkqi7j1Gr+UbRMbeJtRK6CGs3h10rnSC+0Om9kXtM6rdza4h5lBS8Mz/2Pyvpm8BwLcInU4lYgHctPmJkSecsw0BqjOphi7Aa3DEhqi8walXdgidUSs/RINM+P6RcKhwsp3GMXqWJM8SBNaBLy2T8dfhpApwa0miaG7d60o05OW7GcLaIO68FVfQ0cvnEyq/1tS3vOODwgyXtTQdP9m3R5sbOO3BUlPbQ+ClMiU7ZlaabsU3cKAEquzoImBAEFstjNbprVfhZiRiLLOyTb/E0FXTsnytkFslwaePRTRBjHjmZaBkGVPkSQLwitv/TmsIvcrobPmhAXCDLvC3v9KBGzlE18jG7j+TJpOm6OI4Z3KQUbxrZylOoZi8lbZ8Gg6t9EnQpG4Sm8qdGn1ocSv+3be6gKopAXxYcyPU8Vkg9vm4dOrkKjms1BQQIdAaHw2a+k7+LwX/Zpi7z2xuac+bBvZRw2QvGr1Eqe/KhV3VODP27wgvs54dEmZUmSUnNsWDtOUWdvkeI/Q15FzGPj1E0uehH0uNAkGccZbMLE2KOHWpBvDhvS8RjiQYIG8W4glFd7CwXVqyWet7Oc142ysYJVRyyQZDyZ7Y8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(30864003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+m5W1FcxsQXIXoa1z4pmuSm80js9PJXHNPNJ4uvRE8K5CL7bC+JfZns+LV0?=
 =?us-ascii?Q?UWPUlmRMQE8QUpyKvMkvyCC4CYLP38QKEIezCgH2RWOC2TzY9gbUN4IHL+GW?=
 =?us-ascii?Q?QzU1AE5PdIh10fVMD/UhzSusVLNuTNWCEc9Y3pamxw45NpatIQZNY+Jo63bC?=
 =?us-ascii?Q?yDK7tNUobaa/hlbEq8h66oTwGBHOB+0PvcgvlYkJl5b90NKRGCgZxUdlYMJU?=
 =?us-ascii?Q?48/3K1xTfY0L6p6oImvYkFroTK7MqMCk8nBiLlviCAzwg6IUqTOaig/4yhEv?=
 =?us-ascii?Q?QNi01QkBOQcIGKEV3anWWlLFFDQf8Cc2GNtBWHF3oiFjrWh2l2UkuSMfYQOM?=
 =?us-ascii?Q?wMn+WLeZCHNE4zKIHZe1FUjbnjmRG2My3hS1xNfMuMpmF/KP8BCfRV9a2yIj?=
 =?us-ascii?Q?g7S5hOzH72GeaObvIaj+ED72h917TvxBjDxH+2ALLuSKE+tG8vkrEjnduDsS?=
 =?us-ascii?Q?yKyHMJciPPOSV95HBPMppzPEdEAhe5zgXneFmi7iBJCXaE8HJjZ+YO8NqtJ0?=
 =?us-ascii?Q?4XArjDSFEZ8Sru6teh/eiHk3daO2hdWZqySsorcCAV3wsOHIZhssZuZiHkY3?=
 =?us-ascii?Q?aX2M0J3OVVeJo9JvxhNfsXHpPnK8O80s1Xf8VD+2seIDDEJnn9GF1RpLjX4U?=
 =?us-ascii?Q?3/ECWmdX9Wj1subv2y3MfeJRxjklUceel3gypQc3IFCN2+mgFRxMSH9hNAq7?=
 =?us-ascii?Q?4f/t/ufLEfUwNVbj/bE8MFVniaDN+9DKUiNebtxvgN5b0a5hBZ/KlFqc5jCY?=
 =?us-ascii?Q?F2aPlR7JPDfDNqo1EREveGkwn5d9R6O2znwDEGapavN0VR5k44XW7X8s++vm?=
 =?us-ascii?Q?b6YYwCTYU4aAa3IhbaOck5O6sVchSB1fQseREuQiDt1wSu1OWs4cvm9iK4Ld?=
 =?us-ascii?Q?Ch52TMDc/u9bolsKKh3KQDqgzPTElNiINs2aVhh6Hcfk16yVUXTF6+pnDOqN?=
 =?us-ascii?Q?Yflwzd0ScIaxBtRA4BJVVNF7iCGgSKKeDUgi2cz60uaNM3lNMCKjyaugcIge?=
 =?us-ascii?Q?xvYfY2saY2hlAwNbN3hJHHTI36lpWeWL8Am5nDSwVmwiNqg97ajVXPT81U/v?=
 =?us-ascii?Q?YQVpQunj78joN1H0zSvIdhpzd5CBnAsx7wwT5mKUzyVGYub7W8smTWlS9rCE?=
 =?us-ascii?Q?MvZwakrT5U5YW7UW+cQR16Q0vGBXoG9lJzGzxNFKSQPXUsE1cQBtPqFEW+84?=
 =?us-ascii?Q?fS5uq7bfbMmm3Wqo/NJXHvoCsXIDoCw1oSFmOyF/ao/3aC5gJXQRl818yB31?=
 =?us-ascii?Q?V6GVZuwxSjzKb+zhri90I90oqqhP8acnVIfeMPoNmKg1vbr+HTl+hf7iJ6Ad?=
 =?us-ascii?Q?0PmWp/h55cm0emvFN5E9yhS4ld8lhNga73mEGtF3dreXw4Qxe/ExPFk+nh6b?=
 =?us-ascii?Q?D63P8fxzJFpXwQfeWK9EGSJbmfxbxol60dCmx6/+FAFjwKn3SMJvbgltk077?=
 =?us-ascii?Q?HOBYYDqAeQ1/Y/jFLUbnXfsuTkZpX6GKmqoHJck4OmGOjt2KlGTfK0aoA4XW?=
 =?us-ascii?Q?bGW+CddzKShJI4l+V8oBr6GKV6xCBTyGb2gvRKLgaeuTCh/a5EdRmjtlvKKU?=
 =?us-ascii?Q?v3LIt8DjW2uT343a38w+ISISDzl/fxGQqVu0YrYb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786e2856-3244-4bc4-a448-08db3aabdcb3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:22.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLporIcboHvjvBDN+6UD16wCMy9BcMkkSpyFt1KQs46hm6ozW8G48c62rJr7myHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 79 ++++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 23 +++----
 drivers/iommu/iommufd/iommufd_private.h | 13 ++--
 3 files changed, 52 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3fd623208c691f..366df246d4d1f6 100644
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
 
@@ -277,28 +282,15 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
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
+	lockdep_assert_held(&idev->igroup->lock);
 
-	if (WARN_ON(idev->hwpt))
+	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
 		return -EINVAL;
 
 	/*
@@ -313,7 +305,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
+			WARN_ON(list_empty(&idev->igroup->device_list));
 			return -EINVAL;
 		}
 	}
@@ -329,26 +321,41 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
 	return 0;
 err_unresv:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
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
+	lockdep_assert_held(&idev->igroup->lock);
+
+	list_del(&idev->group_item);
+	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	/* Caller must destroy hwpt */
+	return hwpt;
 }
 
 static int iommufd_device_do_attach(struct iommufd_device *idev,
@@ -356,16 +363,9 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 {
 	int rc;
 
-	mutex_lock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
-
-	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
-	list_add(&idev->devices_item, &hwpt->devices);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
 	return rc;
 }
 
@@ -375,7 +375,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -402,6 +402,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +412,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -455,7 +457,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +468,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,13 +485,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
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
index 6cdb6749d359f3..566eba0cd9b917 100644
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
@@ -65,13 +60,16 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	mutex_lock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 
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
@@ -84,21 +82,14 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_detach;
 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 
-	if (immediate_attach) {
-		/* See iommufd_device_do_attach() */
-		refcount_inc(&hwpt->obj.users);
-		idev->hwpt = hwpt;
-		list_add(&idev->devices_item, &hwpt->devices);
-	}
-
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
 	return hwpt;
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(hwpt, idev);
+		iommufd_hw_pagetable_detach(idev);
 out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
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

