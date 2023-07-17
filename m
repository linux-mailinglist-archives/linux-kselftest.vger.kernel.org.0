Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A939A756B7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGQSNh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjGQSNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB1172B;
        Mon, 17 Jul 2023 11:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epzFFrPXHoThPgfvSG/1Dkz6q1w440bCFY49z7P2ge15ONNv2MnaG0Srgp5g9ArklB9wi2cd/sVljPd/bX9rW0+0tTO/eXSq/2VOCcxpnsjprgbUqvY0j7PDroU6wT4JpXOWMgcnpopZn5jmcLeFHUQ/Yr/Y42XzkD3hK2t73ybvrN6LxlMiQeO5YG0ulmcmRriXE+quzHmgLpH+It/5C/XAjXWk7Eg44AXCFHRuoPK4tVVwlg6Vy/TwT0Dhgmj3jRWa6T30/vqurP5X8NQcM1YWWnDt7JQ3nX2UfhW3HGJ9zg5qrMAE8uMYGgV1NvNxcE1lYROOZktFnk/bsC/4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAaGDT7OpvBrZRHecD1g9zcOZQwFgtLl6th7riYqQsg=;
 b=AIvHidl/Wa+tp8ryakN3nde5dR0+5YdvTeO29Xngb/GjE+FLM5szuN9Si32EqHKyJqKl0vRUh8XGpLNayyoQZzA4GCCO0+J762yGvYpsAHsfpXbRxe5MGOOOQMQHD41FCM8XyAG/0EgiSNU6vJ8RVwp9HJ6qPDRhv1GI7gCHjNZCeMu5ruhfd7OLULV0HTKQvE/DONrmg4thQ6vkbQdEHmf2ZpQCMbpEUWlSn4S/kRigJ5Iiti6ybabBG6bCQMb+r2WmkgeGtM3rTIERjbQ+ckEA7Fi8KJut4OWK1XVUw+x00ApLA8cDdXvKZwNK2Dw7PEKkWAuZZmySL8waTeBNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAaGDT7OpvBrZRHecD1g9zcOZQwFgtLl6th7riYqQsg=;
 b=WyrJACDjrP6VsNL7c2KZzTOJ8Qp3lKkFZ1lKwWuCJfEtUjHwVSxUsJXhYVz4GoHPbO4JpbAMOJqwtpPqxJEqcUlY7kDXSnvqZIA2PBNJNB/gUMzOyj1R11IFBfluV3fp/aHPKOx5JCVQUtyJREAI63wkAcmf9KiGp+YKxn/RvO9DQlo+vJ6JM2atp2Kn3cwrqO+X/xjjifyHdQLR3xo29O/J0SuU+LjW3HEvPT+NC9OMPWqovL+uhqcBnjB27Tr3C03x3VrXb6Yc9GNseCXpdmR7OUip9wti332XKwmjj2hoM4uq7MJ3EVpOztMIpQPUi4R6JAIJDrBgPY4Vu/zDVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 12/19] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Mon, 17 Jul 2023 15:12:08 -0300
Message-ID: <12-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f898ef4-5746-4bc3-be60-08db86f15ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9fxp+hKjQIAcHw5SllBfqZ1zaBQ9LxkO8jYvHxfWcd2dD5WIbnXJ3ggSwJJwj8rMuOIPNEiJHVO4CeGxgbBAkr9fizQR8fFynVGIOrSWp7PRLGwOAofhK/0n06PCFAraM5sRcRDpCdtWi8dmy9SFzR10ImwXNUfTM2U7lhyFH8qeynhrZZADAs2dCnT4wgfNJT8Uik+7XBwRAFlwsKmwjJompd91UrvIb5UtJQt+aymsXHxexGuwLPeMMGzQQtnsfjQ97a0zkF1Gv8OrGRD12A3iFhps4jwDkyCURtagg3ZRkUDzut89K4ccDn8YfdQdPSm5aoUo5WIPajSNnBdCIXleT7mHpdsgQFDtvvWnmmybhZVS8340lWUg+Z1OyUt+sl8YppKOjGH1g962OPupaGUrOsQh6Tubn4zd2uZ5YqCkbA/ijwbaBOhE5XlJhImpeACnddXEb15S26icsc/atpDLECuT6ZWDCD9vNa+Rjx2GqQGu5ilsyGAn0zGgLP16SgHS5vkPi5di9LNjWWuGn7JoRELVrruNmW7lvKu3SbBSM9jSTVldHUdNpMG840j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lU2FJt1liiVbQ9YpTsxjXbQ2Jgvh3m2IJSH6beA02tsCxx8NfuYcBEYy6jqv?=
 =?us-ascii?Q?0YRZPAGW4JddZtB3KDuiBN+aze8d1m9Z1MzkyxlrA57CN4NERSyIaUolcU0H?=
 =?us-ascii?Q?YlDgtIhQ8j4njSOzywICPfOiMZ7qA8JtLMmI1Qr/sV+IwIftzjP7zf+zgZF7?=
 =?us-ascii?Q?eqwKdXF8maARIUgsTX9Mc9y5qkr81KNJKmoIs4JOHld6DIIy9AyPSRTKtCi+?=
 =?us-ascii?Q?NZ4IAPoU1+tC94yrVSaQtgC1zI9wO8zjnfdUQYM2x38g0GyxsJzU8s1bo4if?=
 =?us-ascii?Q?p4d6+BtmPFSREFXERb1ughJrWZhb2pLVQfu5SozLSRNGNFi+mrihFb68SmuP?=
 =?us-ascii?Q?Ve3CGbN/ykRBa2+3Q7ReCCJV2ZFLM7zazt7jBH57wQbcN8X3ib0UyyE7kGkB?=
 =?us-ascii?Q?oFAk1ZUfzwN50c/N0xatStnAb5z5MHn2tNJNydI19oBZcVFxFhB61DHcXhd4?=
 =?us-ascii?Q?RFbVDQd/qQnT/X0H+Psx63tclaQaZcy2sIEObxDW+cu+ZGwEsU0V2i1/KvFm?=
 =?us-ascii?Q?5AVqjJefw59aWoVUoo8KoeDVSsVxn0av0RgP0dEUsoJc2fi7sGmzEANE8ABj?=
 =?us-ascii?Q?hIVqkpH19gbGh1EuljV96wgRtUTBYTqRq03scslJapWQw8wpVS/ed7SV1EBY?=
 =?us-ascii?Q?d4JuqF7tBd7bQPBpbpF5vSNEfD33RIBprNBIXYkyK9IMz/WJ+6+i+UCC11VB?=
 =?us-ascii?Q?OB0seXOUhKMPVyOq/LmrKdN57CBJsnInKt48WxBl4jl737kT+U82xNvFxR30?=
 =?us-ascii?Q?SX5K2VVY6Bhda+K7zjJCfeHpP7lcFx64flq09/Evc0kaMXiOLjvkT07rfDzh?=
 =?us-ascii?Q?xDofa/6iOVPMp+fTCD5qEUNqpVB9ckCCnPqpOGWYOhY93woO4I9TcHjEuLWm?=
 =?us-ascii?Q?LyUizNJLc8GIOrMS++Rtv5ZYO7MIFhn4iA5cY3aTU+gFp/f9352sG5f7ZSL6?=
 =?us-ascii?Q?x0ymauv5sdeqeww2jH3Q8HtsqbyBipY2VD4gyZTwctDuHolCz6tOWUnppvKt?=
 =?us-ascii?Q?wmZClfoKC+M6k8sZyMB6nM8tAP+JBWpiggYe/Dak/Igsi+5vSGKyOoyCJPJ6?=
 =?us-ascii?Q?Po0+La/ewVsn01Vip5Hr/nf8MC/ioAWpWeglizA8DP3jO0qOS4L3KlFT8IKm?=
 =?us-ascii?Q?t3y1lCFZapaikIQO/0c6WXpsMiCFb/8uoCSOGMna/wb/1EJjg+6YV3ms7G7M?=
 =?us-ascii?Q?rHqsqnSRmUHkVfApl7zH0Vcr111K9n4S4pYh/hY9GVjrwgAOryVKC/JVT2sO?=
 =?us-ascii?Q?ueC6QSJy50D1neN7DEuw2JTrepcnqLogI7C50iXfWfs2CA9jvbN8pRjjHYAy?=
 =?us-ascii?Q?gpTD5wL0p0RAqeUVDw5IheUsml0hTcCZdsJz4VGjJwoVfcAMjEmaksslYi7H?=
 =?us-ascii?Q?fmzUESwxBb7abChI0UbTt+c/n67mKAv2+mTutIgVF6oAn4Iz90DHiS1Vhyvc?=
 =?us-ascii?Q?KjBQpPVwdPOq7sQ4FDldlY5+8PglJQl9LegGGuIS7WO8kG5i15eS+trTwwpz?=
 =?us-ascii?Q?lexz9a5hX/hgQIXKdM6nVwAP9tLTC+o12VmUV7Bf4bqPIqHXK17kF3E7aRx9?=
 =?us-ascii?Q?ZtTwc+ZP/dZsCZykZ55JSHPPXegmEq6oVL9nV3kp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f898ef4-5746-4bc3-be60-08db86f15ba7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsG+zESG8C8g93h4+vNPW0geGHWj1Rj0YVTOWvVmHwT265Hyjn1O6t0RCDoR3G9X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 165 +++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f2b34c56d01216..87962d19ccd363 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -353,16 +353,41 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	return hwpt;
 }
 
+static struct iommufd_hw_pagetable *
+iommufd_device_do_attach(struct iommufd_device *idev,
+			 struct iommufd_hw_pagetable *hwpt)
+{
+	int rc;
+
+	rc = iommufd_hw_pagetable_attach(hwpt, idev);
+	if (rc)
+		return ERR_PTR(rc);
+	return NULL;
+}
+
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
@@ -376,38 +401,101 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
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
 
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
 	mutex_unlock(&ioas->mutex);
-	return 0;
+	return destroy_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-	return rc;
+	return destroy_hwpt;
+}
+
+static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+				    attach_fn do_attach)
+{
+	struct iommufd_hw_pagetable *destroy_hwpt;
+	struct iommufd_object *pt_obj;
+
+	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return PTR_ERR(pt_obj);
+
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HW_PAGETABLE: {
+		struct iommufd_hw_pagetable *hwpt =
+			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
+			goto out_put_pt_obj;
+		break;
+	}
+	case IOMMUFD_OBJ_IOAS: {
+		struct iommufd_ioas *ioas =
+			container_of(pt_obj, struct iommufd_ioas, obj);
+
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
+							      do_attach);
+		if (IS_ERR(destroy_hwpt))
+			goto out_put_pt_obj;
+		break;
+	}
+	default:
+		destroy_hwpt = ERR_PTR(-EINVAL);
+		goto out_put_pt_obj;
+	}
+	iommufd_put_object(pt_obj);
+
+	/* This destruction has to be after we unlock everything */
+	if (destroy_hwpt)
+		iommufd_hw_pagetable_put(idev->ictx, destroy_hwpt);
+	return 0;
+
+out_put_pt_obj:
+	iommufd_put_object(pt_obj);
+	return PTR_ERR(destroy_hwpt);
 }
 
 /**
- * iommufd_device_attach - Connect a device from an iommu_domain
+ * iommufd_device_attach - Connect a device to an iommu_domain
  * @idev: device to attach
  * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
  *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
@@ -420,43 +508,18 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
  */
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
-	struct iommufd_object *pt_obj;
 	int rc;
 
-	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
-	if (IS_ERR(pt_obj))
-		return PTR_ERR(pt_obj);
-
-	switch (pt_obj->type) {
-	case IOMMUFD_OBJ_HW_PAGETABLE: {
-		struct iommufd_hw_pagetable *hwpt =
-			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
-
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
-		if (rc)
-			goto out_put_pt_obj;
-		break;
-	}
-	case IOMMUFD_OBJ_IOAS: {
-		struct iommufd_ioas *ioas =
-			container_of(pt_obj, struct iommufd_ioas, obj);
-
-		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
-		if (rc)
-			goto out_put_pt_obj;
-		break;
-	}
-	default:
-		rc = -EINVAL;
-		goto out_put_pt_obj;
-	}
+	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	if (rc)
+		return rc;
 
+	/*
+	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
+	 * to destroy a device with an attachment.
+	 */
 	refcount_inc(&idev->obj.users);
-	rc = 0;
-
-out_put_pt_obj:
-	iommufd_put_object(pt_obj);
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
-- 
2.41.0

