Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0D6C3A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCUTPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCUTPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2232D60;
        Tue, 21 Mar 2023 12:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNQITJ+8NShh5ToIKl4lJLS4r41muL1Zn23mr+6F3zWU+UmB+Wl6hbFx4PHZbLBn9BgyS347VElyDJt4U5FamVE1IWWKMRoPsnKs/6Qb0l4YQYV/R9aYzlxS+g9I07odDqaz1m2Hrk/McpNuTjf8ltB3V3Pgp6uad5xzmwnJ9GgcmeFbWm95/6xanWi+iPnWua33khUY6OjRuUPXyS72WyQ5Up1Xov5TLQYIg67RfnahJ6cX2LOrOzAj1SC2jBChxhD3Oc+FN28hVhlAWLvZEj8oA3zgQAnfbWuJJVvM4LjDOii/qpwVX+1saOiIimTZBF0QYm449zBNQGOStUXHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpnWdnGM+iWS1BRmvM1odRXkk7xHHXmUULu85gxnIsw=;
 b=XzNcDkS3phReLSkgd5ooUI2s8PUTPJIo4l6BsgLQBa8Qf1XOW1LzU95zoawXFDpS/HhMsFNrKL+EhImflfC9j9Re/3NWzvHr113xyVjb8SIhxMLQQ5XAvuh15oKJQbk7y37ZMS7BQsoy4vhIjRuHJTYEzwjrWKl2yfFvdce8r41vxwDW6GgWGSs4xw2MkQyGvJ6znqYJ12PrK/GIYX0h5zBNafYQVCD1SlGGCv4hN3A7irw1/12tix0R7wovnI0SdVAsr4c2+QnwZDTyvrPOuCh+xqX3SH3J/2hYlQVrDrJob/EH9yrelEsPDFU2afqe0WISo59MVkAgZNwliJdK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpnWdnGM+iWS1BRmvM1odRXkk7xHHXmUULu85gxnIsw=;
 b=ZmoQRWzQdg56QpdWFlSEaYVkenVLSD67EZEIYZwJfUAuGdBgAS/3WRdCgwHkF1C/TAowCHkeh9k5fNGDDONbc8X73uylQnCiUQRMbrYGCxGVCsYZ9PrBVT24Hbpw2govg/9SucToC5JW/OY/0CLlr2CuYfze06TYS99NSGCOQpdjeRQtw5jDGTuobs2a8OHfkekw4JKIQc599jNtusOFPKMfnqQhKWb6cx0S5pCIFuP0A5iVOMqcoUR35q8OypAv8aASqbgn2oKLwh5DSXa8ZW+4ymmCfUmv+HTeNP0i4lI17GMHYtjPsD6s1Sf71s1u4aPxMZSd0769dFqXV9JdNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:56 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 10/17] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Tue, 21 Mar 2023 16:14:44 -0300
Message-Id: <10-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b18aabf-c023-4d7d-2861-08db2a408d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDosVza2cKIF/g7wE0SX7a/YoXoDCe1ErXTrBu6C07ytAZgpRwv4nSS557jF3+MlVSOTtVaxmih1Fsrv9yIeHmlyIguDU5VSam72lap0BiI/vKYQoWOfIA4oypwG7YsdE/4GCLMi/qWep0kNp1GX/S0LuBnmKFpEVbfSPpWf4wfSAt0aSdiE0yU6zp4DOnZ5+Osdwb3GdClUz7HfKOW4u6r4MmB2nrESut2ix5pIy69vquxZEo1jm6/GRqtsd42btOIlSKrwbWjD21CQkfwx7uJHMQmdy/m4or3ijZy5F+5YpWYRkieqOmnP9IZm8X/8tyb9KSZ51/INimzeG81xosHbSTxDFDu1vIKOXmNzCWw9pPTjL/aFemReyTXc569MPjyrGmuGcdZu653X8L6JDcA6SgNZN8OUyeqi9ts1A6uEUQykiVURWnNLBUeIVL19aQJnMCf8yUmnmBJtJsWRgp6X3UddpmFBu8Jn5xJOsbMU5foiU842eAUIBBo/33mYr9BRbxjYyTLvCcwv6/8fsHdQGJwRkTeewLFD9vtc+J6keebReq9KgabUrFP1K8mUMmZ5m26gBkY/c90SRuvJfmYomx7MV8TxoyPbKR5bPiFRhBcTP7h2OCGbCy+0UZnqs0beLnB73w32G/XVZcOv4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKRSQBug0B8KZbyRh2lvx/pm6GDgorjIGv7dP4ShbcGz4XrD+WGHSh5WWlo8?=
 =?us-ascii?Q?/RYwgtu0ayyrRY4qZ9ycwRDUTuPSNsPQwo5kSvbwPrvwy44V4X9cpl7hU1Nk?=
 =?us-ascii?Q?887aOzxFDCFXOA+p2Epyw7Q8COB/e6s7v7zXdr02XvNxZHGoe1v7MMj5uVhC?=
 =?us-ascii?Q?aCP2NCTU9aFonBTDtdrOLB/gWuNg0d2CPsbKWb/k8qnAh/1Lboo/4+afUNno?=
 =?us-ascii?Q?lDPQqrMsPAKP7RTyA36MmSBDOP4sZCJg3brwIII94e3/4qPbYxR5CuNoc8Bd?=
 =?us-ascii?Q?FLGwyRyv5h553ccxZFQgBkXkaWmrDWLgbQVbSBoGICWjbSW74Ml7FvKxD98y?=
 =?us-ascii?Q?OkJL3hIQ/uJPpFFj/QhH2jNUvO/kwRpxDynItC2P/Ba9sxFVhGozEAElhBk6?=
 =?us-ascii?Q?OlbJTysJHY3odYjEuyze7Tsu0MH/c16g/kOzK57jUULWPY04QGnCgvL5z//F?=
 =?us-ascii?Q?m/j9CwXAnTBdD2yT1YdqRSOzh4TPwgSTdyp22ydT3onKIQjeEpwCKkDeBUjG?=
 =?us-ascii?Q?dO6zzsdrqzMAvz3b4Gd8l4anTKKxZV33FWY8NLHMV0ZMiIn2JgNbpKDXVVUN?=
 =?us-ascii?Q?xGclh08n2oFCqMpE+LE2c7IUClQ8GjtED5/GjKUTjOw/e8i5ttoccrgBBZXZ?=
 =?us-ascii?Q?/ne7/ylWOpJTAG2bjMhObtWa171OxLbWLGhYY5lzTfgG3Rj9Yd1HbHSwFxUP?=
 =?us-ascii?Q?rP3uu/hLZew6Thop/IaO/pBiXiUMN3Jk8u6U+stR5QgHSpFEWW4W/4hoIvUr?=
 =?us-ascii?Q?dAZBkJFGzNDGMh5duOgVmO7Ukx3MKO4NcjKpP8cfcRXwXUdSmH1jND5/K0uD?=
 =?us-ascii?Q?BeV/A0E7d6QraJwCPlgqDz80rt/r8G8AH1c0P1/gPDBurzKxZ7p0ttJFBo1s?=
 =?us-ascii?Q?m3Uadp6YUptgwuaoEEhDP8QYwn+HG3rFqjB/RlifTD0UnIFXO5Q3QktiVUMe?=
 =?us-ascii?Q?81I8BkzBRQb9A2b2gsfz7rkDKrnC1cpEzG7sX6rT8vbC3FMskKswL/38B8Bb?=
 =?us-ascii?Q?e+bJ4NPJxg8t9f8eUBV5/9MMzwxSso7TmolvR/xeluQNl48GZPLleAYoWksu?=
 =?us-ascii?Q?/ietNEtlXA+Cu5FfLl648cpd/XPEz0Qu2ujXe3PMtG1dFjcMWbrFJYPw412n?=
 =?us-ascii?Q?P07li4aZpP4lCTEFw1TCvTLuVx430GPVyoF9Mn4LBZQdpgIOSNOHqQLg58D1?=
 =?us-ascii?Q?dystyft8OnjT7ox2dEZKL0jAoUJBKKAkRpgVaNB9ZURsrVe+2J+QprMj95zm?=
 =?us-ascii?Q?v9cMZvaJ8FY2iXdRsKtJcgTSlDw0KvNHnvXG/Y5Me0Ckeoc+ClQxfeU9iAQT?=
 =?us-ascii?Q?s30OOPCCgezV+rIX7XyJAVG/OvioTE89Wpm7gwMHqMJdjP3OFbsqiK72KpKv?=
 =?us-ascii?Q?M9c0I4E9vX54b3etjJU/OLj03oaiiZp9iyQJpdHXo/TDRjd6n2PM2lgaoOLh?=
 =?us-ascii?Q?PQ98ZJMabNqe6kIATeFZzATDRmXmH6dXQa66mvy22hS4Clm0YDKb1BQkJj0R?=
 =?us-ascii?Q?pOqoDL1FW5Ellymawu+WBB4ji05ormtXisPdJwRSAT2cY5pWSVCx12aEsa7P?=
 =?us-ascii?Q?biFkshd8RxPxmFOFKIiK2Z44GEAse48xrSgIxdce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b18aabf-c023-4d7d-2861-08db2a408d45
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhytKYt6xkVKri3C8RKb6Y905+p2cWq+P2ONKPf6DqylKg0GDaPAiB8pgPkXuP+d
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

The code flow for first time attaching a PT and replacing a PT is very
similar except for the lowest do_attach step.

Reorganize this so that the do_attach step is a function pointer.

Replace requires destroying the old HWPT once it is replaced. This
destruction cannot be done under all the locks that are held in the
function pointer, so the signature allows returning a HWPT which will be
destroyed by the caller after everything is unlocked.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 138 +++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ea01718f46ccb1..40466152b68132 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -346,27 +346,43 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	return hwpt;
 }
 
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
+static struct iommufd_hw_pagetable *
+iommufd_device_do_attach(struct iommufd_device *idev,
+			 struct iommufd_hw_pagetable *hwpt)
 {
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
 	rc = iommufd_hw_pagetable_attach(hwpt, idev);
 	mutex_unlock(&idev->igroup->lock);
-	return rc;
+	if (rc)
+		return ERR_PTR(rc);
+	return NULL;
 }
 
+typedef struct iommufd_hw_pagetable *(*attach_fn)(
+	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+
 /*
  * When automatically managing the domains we search for a compatible domain in
  * the iopt and if one is found use it, otherwise create a new domain.
  * Automatic domain selection will never pick a manually created domain.
  */
-static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas, u32 *pt_id)
+static struct iommufd_hw_pagetable *
+iommufd_device_auto_get_domain(struct iommufd_device *idev,
+			       struct iommufd_ioas *ioas, u32 *pt_id,
+			       attach_fn do_attach)
 {
+	/*
+	 * iommufd_hw_pagetable_attach() is called by
+	 * iommufd_hw_pagetable_alloc() in immediate attachment mode, same as
+	 * iommufd_device_do_attach(). So if we are in this mode then we prefer
+	 * to use the immediate_attach path as it supports drivers that can't
+	 * directly allocate a domain.
+	 */
+	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hw_pagetable *hwpt;
-	int rc;
 
 	/*
 	 * There is no differentiation when domains are allocated, so any domain
@@ -380,52 +396,58 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_device_do_attach(idev, hwpt);
-		iommufd_put_object(&hwpt->obj);
-
-		/*
-		 * -EINVAL means the domain is incompatible with the device.
-		 * Other error codes should propagate to userspace as failure.
-		 * Success means the domain is attached.
-		 */
-		if (rc == -EINVAL)
-			continue;
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt)) {
+			iommufd_put_object(&hwpt->obj);
+			/*
+			 * -EINVAL means the domain is incompatible with the
+			 * device. Other error codes should propagate to
+			 * userspace as failure. Success means the domain is
+			 * attached.
+			 */
+			if (PTR_ERR(destroy_hwpt) == -EINVAL)
+				continue;
+			goto out_unlock;
+		}
 		*pt_id = hwpt->obj.id;
+		iommufd_put_object(&hwpt->obj);
 		goto out_unlock;
 	}
 
-	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev, true);
+	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
+					  immediate_attach);
 	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
 	}
+
+	if (!immediate_attach) {
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
+			goto out_abort;
+	} else {
+		destroy_hwpt = NULL;
+	}
+
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
-	return 0;
+	return destroy_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-	return rc;
+	return destroy_hwpt;
 }
 
-/**
- * iommufd_device_attach - Connect a device from an iommu_domain
- * @idev: device to attach
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
- *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
- *
- * This connects the device to an iommu_domain, either automatically or manually
- * selected. Once this completes the device could do DMA.
- *
- * The caller should return the resulting pt_id back to userspace.
- * This function is undone by calling iommufd_device_detach().
- */
-int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
+static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+				    attach_fn do_attach)
 {
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
-	int rc;
 
 	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
 	if (IS_ERR(pt_obj))
@@ -436,8 +458,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -445,22 +467,54 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
-		if (rc)
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
+							      do_attach);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
 	default:
-		rc = -EINVAL;
+		destroy_hwpt = ERR_PTR(-EINVAL);
 		goto out_put_pt_obj;
 	}
+	iommufd_put_object(pt_obj);
 
-	refcount_inc(&idev->obj.users);
-	rc = 0;
+	/* This destruction has to be after we unlock everything */
+	if (destroy_hwpt)
+		iommufd_hw_pagetable_put(idev->ictx, destroy_hwpt);
+	return 0;
 
 out_put_pt_obj:
 	iommufd_put_object(pt_obj);
-	return rc;
+	return PTR_ERR(destroy_hwpt);
+}
+
+/**
+ * iommufd_device_attach - Connect a device to an iommu_domain
+ * @idev: device to attach
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This connects the device to an iommu_domain, either automatically or manually
+ * selected. Once this completes the device could do DMA.
+ *
+ * The caller should return the resulting pt_id back to userspace.
+ * This function is undone by calling iommufd_device_detach().
+ */
+int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
+{
+	int rc;
+
+	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	if (rc)
+		return rc;
+
+	/*
+	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
+	 * to destroy a device with an attachment.
+	 */
+	refcount_inc(&idev->obj.users);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
-- 
2.40.0

