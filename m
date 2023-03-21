Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F96C3A2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCUTQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCUTQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8002F78F;
        Tue, 21 Mar 2023 12:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCZ8eNwF89o6+UzzPEll0X6VG8WsR0P7/tOc/OBRY/+79R6IPy/7BPzrrscJqoCy5WuQFjTMn3CAkIspKuXCJauMFu0IIhT0ZmQGm48GBxKKdWF+QIOgdj9t3QPEAtAu8c1oWr0GtFZ7c5YnRFVBbsDhCDxZzfznPIOf+ZKNzF9mysUIqvQB2pVCN8HQU0ijA8Szuj7iBS2bhpJa+CnS6sx/x64PAdLrcULGIS/RMX+GXDip11cXHgTubQdoQcPPHV78mLpLuucd/Qq7K+KWkX/eM9AILIOybykT/5h0IhTagqeLzjskjYWODkx62HlzN++zYBGqZu2zshe8axRxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVBwHzXqSmGrjtunqphBg6xim7AyqMFeWvgqRs42a2c=;
 b=nOdXmyY6GTmXg+hzzrJeBKKelKHgBwtUlyv+M2NkLHIXn0EjxLu45E3DREBjU9O9ILk5ABFMvWQ2pFgGvMAeQEQ6Yh8GDdBDa+VLmlxFq8GOydueWq06Xx7K4Oex25neEPW6kngpTR1ZCNgaozQColc201yzIRL01dbaUmmITwIi4hN/YM4mPt6K9am59Zi1oPrXEOgaXqiLkOK7oYbzzBEVwpVYMukLuXSLnpIVDP6csIzOimYPPTt5L/6ALA0/5Kdqa+tSW1IqS/ZFiNM2goG4xIcD/yXLC6ueLty6a39vbBP5hdjWIoIT1OR3/H//Z0MygwxnnLARXpdTGDG5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVBwHzXqSmGrjtunqphBg6xim7AyqMFeWvgqRs42a2c=;
 b=aCNW8xrkdSvjT0hO9XKG/Cuu7Enw/bXpGYiBwkDnNoM8GZFp4nQZWHZErU0x/233rW9G90MioDOLyVo4nQnca950BpHs6arQEXRuTUTkdLdk525ER+QJe3fwRWQ0x8IIa4KI1ZPj4tixkvw4fbIASDtSO5y/KX8I50qJwEQ6uYUni7FLLYipG9XRfmtrg4VIf25SCrSbtzrm/sPBqaUlUMb45n2/QgSos9JdO8yoGEMCnxBhCif6bfPhUPSOE4ave9WRtsNh2XVZLXVbGAzX5XPKn0n2goU3qFS64x1Iyws4CT2ZjEtXtc6rUVKtXOmOTSHe6XBtiE5ibTgezvaSag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Tue, 21 Mar 2023 16:14:37 -0300
Message-Id: <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6ffc8c-1e58-4753-0aa0-08db2a408dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSV8XSHhcSQyWKTtTkNuwmNzGCoy9Ga9ypqQ1DRCWmVcB58AHhxT5kfsmGm/f0CzkaYFXBvUJg9gl6zXC0yIbUGXGNE5hMbGUHuAGZtolhiLyKzSQNErXTG8OyRY4z0ifo2k5xJmZFsMWg8YDjPydxWcV6tjF1COpOdhdtdtcvRwA2IBkW5tc7l8R8Pe3OKQQvkTTH9x24xspQy8uokSWrXpXby537jy7KgrcDSH2L0nnRpMpnoE+Tcj2HQQ4kFLTaoFvzSNhT95+AatPR39l6/IwGbfv7PyytOFb1cBpLqQc86hd8MinEorUrGDxOiwp1ZtxCsYfpnXI1ZAXy+46CogiCiLSgtvtuDZJXHid58QNN3CJRghy2/edtpZLtAGotuiioDGrVaDYuAolytyjI8kQyAH6fx35WpAPShpnCx086tU/ju1/j50Pk40FDCqlfJnHNnt4emIl/Mw/+f6FySHqhRerLy5mAxFKwmdu2OwuUd8WrOcm7UpKdcMBwz9/wQt/H7jyxtYQOGWoHK1xdj+SqrhrhGh3BPCSZ/nr96+r1njfyole7rF9S1R+MLs96XvoMMH2j34VFR/QLRjKlrZJPzfRR6Om2NmFgM4Z0TR83vmr4vSkEhOkm/zWbwZlQAuCCa8KCtZQpN5fN0GR8xAVpdlS/3eDLT1TkKenPNn8R4xG5cWms+wV0rYPU2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(30864003)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0I+y5LAyIgbm/04cJoXyLEL10FX6+uPLiF0JsCN0H9qAwMbT6lxm2YtnHt2?=
 =?us-ascii?Q?tAv++7hxqIU2qJ+jNrukDwhaxME8dYi2Y4YGrSIzCx5lVYYR+BFXHix5LQYl?=
 =?us-ascii?Q?aYrdxGYmnaW7skgS+Rm72KWyjHw3olqJTSVLXnnzvtiaIsEYe9/HWI7Y5Akq?=
 =?us-ascii?Q?clusJwalytOSzWaCgm+5kAUQcV684S+crvdtnR0y2Xy65aVnT4qBK8lLJJQb?=
 =?us-ascii?Q?j0Mi8TPmjRaa8dqCAa/RihIIv83l9xpiZhvcbyaycHBsGhl8Eet+p9iWoky4?=
 =?us-ascii?Q?z8svln/+9yIvsqcA+g+nJqCcMkj802PE2X5JjaPV5aTj0B9hQkYznu4VleZ0?=
 =?us-ascii?Q?yxq34S2kg8nFvTCM5VDrYh51Hfgkc1RBlkja2bpmOUoVF66kwTDdruNCFPXd?=
 =?us-ascii?Q?80f5RYy+KvlyUWp8Q/j+oJbJIttkqPYqIi3WYM+RmCeBOJz8/1CXcP+RlBb8?=
 =?us-ascii?Q?EtZoVrk0uR/FL9ugOrp+HM2EMZ8NifaanXo7CLvmNT5JnBB3ykAyuUYRv91B?=
 =?us-ascii?Q?QhNL2S3NZqQaQ2RdwqAk+5ggJW17TlmpdcXxwHWpEXk5fjfidK7D/vW5a3fA?=
 =?us-ascii?Q?ahpoARKi2ZD8AhnzeEyl9U/EF0vW8SOSo5t0u8tO6xsD0MgTppGiJavYrUXx?=
 =?us-ascii?Q?+/6cVMbevp5fSs8c2GKjYdcxXbuafpku91Kbthcu4k2L87wmlqR9ChwRZI/j?=
 =?us-ascii?Q?ieElYY2qglAcce8ckQE8/2N85khEpXd4R9BPCnLGcEpE0uVZbxtn+OX+HsyD?=
 =?us-ascii?Q?tIOLSxchTAi2lVgqZfcydnwLrUUV1zdwsrVrpreSxgerFNxBRh9CyaZrspS2?=
 =?us-ascii?Q?yKHTIaZdvPes7rOHPD5pEdSAMZXP2R6pDrcbBGcJIfWGOKwWLg0DnrYgoNzm?=
 =?us-ascii?Q?vGm7UC4wVez1RKj8btrPVLuvqHVmOThz6h3kIMFnoh3OT3phC9mKmOgSmg9k?=
 =?us-ascii?Q?9Y+Ng+HXd+vJojtjU540OLQpS7V9UNFRsg1BiHsT0gBEYbJMre9hklCVwzh8?=
 =?us-ascii?Q?W2cIaaO0mpPKkR9sQFdbdYRd1C46pUM69xzAGG6/t1FGP157OgwQaf7RaQpv?=
 =?us-ascii?Q?ikn1gyBoHp9K2FZrtdAHUNJDYJA/bsn5v/YDir++ndcenafIuxiicK8SXwqg?=
 =?us-ascii?Q?a5ZM6e+exS5OwITGLqEM8xWaNh29MraiqBJ/oeUHrN1MfnKTdVgftGqDwvgA?=
 =?us-ascii?Q?pxBvbBX7R0TQwQ4h5qDGBeqwIl8SQmSS6/nb4ZIBH8wOXsEEHaF3JfLDURDf?=
 =?us-ascii?Q?Q7rNrpoj55OTZm4IRE/VqgwH/zQOMGndDcXzG5D4nXtMz3wqZwn6HX9VDCFj?=
 =?us-ascii?Q?c1SaOGezysZYbGVDD8P9hV8axqLfUv2tevR2Leb+/43tRoinwWdlNtBV5wFw?=
 =?us-ascii?Q?1JB2NZT5cXwRTFl5/MWEjNBLMvkVjkwx2W8lP63JA/OajxItJRITtVNfdGbW?=
 =?us-ascii?Q?BLGW+Qw1lXINSzVbhj56i6exL9NBHQXQsGI+WEmJ+KYdEZoLLORrDxSAs7oM?=
 =?us-ascii?Q?x44F2E21GGxUlc811Rn5Msr8AzapgjqmUNlzs9qcmX6GmtEEm/bC3+kNFSGJ?=
 =?us-ascii?Q?ULLXp+wOUIwcP1ubXtRoSpMNJx0tJ6Ice7ipjYh6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6ffc8c-1e58-4753-0aa0-08db2a408dae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+HBpoo+tSrItnJZg5r+uLEDTgFG7FyWLDwdfDSirv82JagrG9gZHynY+oraTveB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c          | 78 ++++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 23 +++-----
 drivers/iommu/iommufd/iommufd_private.h | 13 ++---
 3 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3fd623208c691f..66de0274d65629 100644
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
@@ -329,26 +321,40 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unresv;
 
 	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
+	 * Only attach to the group once for the first device that is in the
+	 * group. All the other devices will follow this attachment. The user
+	 * should attach every device individually to as the per-device reserved
+	 * regions are only updated during individual device attachment.
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
@@ -356,16 +362,9 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
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
 
@@ -375,7 +374,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -402,6 +401,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +411,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -455,7 +456,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +467,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,13 +484,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
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

