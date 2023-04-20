Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAE6E9BFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjDTSvu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjDTSvs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FD273B;
        Thu, 20 Apr 2023 11:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xtl3K8AB3kBV3Ui5T6+7tx8V8zlVSz/Vu/i040p7E3HPmzUH1itM5H/JfFr21vvnyOATgnWKAEeRRcfrek5pLVTmosAhi0tsWIuYdqEeMaTB+Lwh/SnxXuvwG6GFHMgl2QbaE3xOD/+8t2/jPbQfD3V+cMUEM42RwSCAQ4vN3DFD2d5K5LMfHcF21Peh6VbMsOAzFmbPlZr7LeJUL1N1wQSpUl1uz2sATRJrRhOL4894H6v315LUYv3M290oymPCpEf2kDVovov2LkVZdFeaWBkhd8p5ltTlO2zfFR9HvgH0xMt4w42YQiPW94uIxJDkE9E43CXWjQzXjltNXk7ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5Rzwud0AEnVkcU9Eg1RSZBsARPnBNOQKuq/4x50USw=;
 b=aSemGD+SlBL6xlR1hE5KTE9Iwpq1dtv25G9duRTnX/v4gKvOee9uFbQ++VjKYafyDY75TMyyTla5HDNHuc3IWYRcCepF+yHSQ8RBl7FM/dSXj5JY2SKMJddHA22Smyk8pUg/fEWoccpI3sGh+jm3ZbxdqfR26xza6XESHThyCgUCAv42itAUQvJOyzQc0IYNerb4/h55JjDP/mjrLAdPafYgGTAwL1NXv49imcW92aN45diZ0bAnsW2wD3Y7VYx8bPpYl3kJBg4mqyzFrn//W4Z/K1vwGYI0dIBGYwQzndS1Ciij3FAPor8k7s5N74SN1KO/QyiiznDWIFJsFWMLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5Rzwud0AEnVkcU9Eg1RSZBsARPnBNOQKuq/4x50USw=;
 b=YJwP5vIBwRQEIGHZWgTKYeUgZ4UdpcKuH7jur9PrlVhqCNWE7HGnK/B1ipkRdRILI8IHm/GkIq2OE8MqK46cPv0SUccyKtIzpfVfsILUJqfwdz14oV5Xgs57lw0h7AiF4j/C7Vf47n+RvBlN0BE4vNDswrcPfS3jrLkm5D3H2RMZl96MARKZ79XxL6A+ZVJZGa7xo3j6Rx+I9ngvKVs+wIvtZEZthSmaL+PSykCzPl8kLcDRWQ6ekvST4TzKHoAFkPkdBTIlgM8DCaXXXNLl9cWBwFh0doJFWCRKcgo1xOOVZzPI4nWv+8bu48/Yp6Hl6qXFoTchRvNyJHFay+bNUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:40 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 12/19] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Thu, 20 Apr 2023 15:51:27 -0300
Message-Id: <12-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1064c4e8-63cb-46c8-2aed-08db41d044ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdoUspn0FcSlwYxQRx9JqgR0gLHNVX79XKlZc48Qcq1szDRfhgZ00Sd5V1pLxUb1aFhjW5F1UnSJGrDussdJht6evtDYQstrwm5vCCZItbpj0S9Grpxm9TGbmQJJbWcf6AJtutEFWX+sP9SEKD/ofRZlWJaHJflC6dLUtw53NaaiHGc8ixMOV1IqEu5t3txK4sXMm1U/Q2nDZq/pIoMC3JCaV+uLDUoW05Tdadt67QvTO1NWR45r1kxFKAUwpY2qV8HUEbVjw9ymHFwJvfPBGVahr7heBMecfyUCjD4iu+D5zWmwEIg/IkoTfkWp5EF5BLaafdkYkN1QD+qIMXlQZd7n0Wo+IXldb+8HgSandsmuo+13kpcAgVISqI/6yJXRJmPsHcHJvbk59c4pwHkviy48czP/iy3lporL/F1Tx3qXyJxqWxsDytbe9hE3sdZMgCXbsgf9JUv6FSDGpKqGxoKQe6nUa9QWvDlIizFsAY1piewRxs5MoLPbJErwtY6zR+nzTKM4CId2V+jqwuVZbcBltqump3T9SFOEGwW+T33mGL17YGmLd8LCX03McbW6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?316vup4AvM+hRaPiPjU/plhjbmddx4DqVAYvhp/r0cwjXNRY4aD5YOxV4dUs?=
 =?us-ascii?Q?0LSh7fytuKolMImSNF3jhe9jrfxqnEEvEI2T5YZK5rSLMt0TIJ06XlS1ePth?=
 =?us-ascii?Q?Jvo7AAFH3A9DO7t030toLI5h90jnUjFj+BulYxjWSduF/4mIds9PmQeeywHl?=
 =?us-ascii?Q?8sSJQl96ciuNrzQ5iD876rjnTS7li49562wuSKUNaoYNagyAnlqE/VZB9IuL?=
 =?us-ascii?Q?8IjzTB5gL+AHx+ychoTTSEeLY2kyqOnGy/9XM91SIzceHCPrzv1sreAp0l55?=
 =?us-ascii?Q?3d5qobP3mu91HDGML1Z83Zq5YmlHFPGwrrmPyM0WiXWwjIeoTBcL9gJfYI0E?=
 =?us-ascii?Q?5oce7LYOcGMCF9pPU152JJlN2VuNFGA1tNu1Tpnoz6nm1gMCPnaG0O46mNPv?=
 =?us-ascii?Q?Vtoed25TrEbeUAqPccNdN2azeGMP9jx8b516jXdOo+wL/LkembMSOed9WmNv?=
 =?us-ascii?Q?Mf9aW94y4ejCnUcOreg2eQPShNhFPXURv7ojoeqc7vKA4m4sTViHJAyBRgb5?=
 =?us-ascii?Q?PtaWzT8+/J/PqrgnOK9Rc/g1QC65LRm5hqCjybP1nUEI5L82fygSFv4c/Z24?=
 =?us-ascii?Q?8FVQmITl9RcDpEGmnSlrzqa/XAIVq82zoHx2/3rXPWHWfGu2e8+nSulQuMLH?=
 =?us-ascii?Q?z37l1RJyIIcZMNRbylDQjuOCFJ5CaYje2gEukjTG/JNCGzoH6P29lk2QJVCR?=
 =?us-ascii?Q?evgp7AIwzX4MS7fbHn9tI3Vz+uj2n2n2Kysei1S6dWOp5kL1fzZzBd4n2q/x?=
 =?us-ascii?Q?ccAmqRZ+258IKZZSo7wvK8R2OStzoWd5WDVc2iy4s/1OHVihcOqE9K3B9G4I?=
 =?us-ascii?Q?aa06zcC6+Hb4CSp0lyENdF7Mr3/2jzm3rprw24J5eaDQsJHVSIT1/WBE8Tt5?=
 =?us-ascii?Q?Dd8ZgK3EcoyCos+yWM6xWyyfARW2KxRCWB36aYMNg1+rzUc05nJcUc9yyZA4?=
 =?us-ascii?Q?SRykI4RM7NhBpj3R261ZWF3dcwp8nFYA4RjlrUzGxSiQWS6hHToh4Gw2yDrK?=
 =?us-ascii?Q?4soeTrZ7WbBEMA/XO2EV2rkcwa/F+hD5uZ8Rn80cdBGoy3m/ffhLMU5S5KPt?=
 =?us-ascii?Q?UrZjKcSID5wPx+/NtFKDO5ErwupufXXV+DbleyTrWGgtwywiocnNIWw/mTCx?=
 =?us-ascii?Q?LoWetxWFju+FvO6x2WrvpWe1Cp5l5ZI8ZdFxJFTn4Q6P5+WGm7BUR7MaYTzS?=
 =?us-ascii?Q?QpxudXIlV2kGNlYAPkyjk8q2D7569ByRP+fr2mY7rEV6y1WhQEvSFQb77oVm?=
 =?us-ascii?Q?Crvio9cCNKmMZblFSp8IJljOE+JUDevqgG7YJcihMNEpX+KNT74uuw7Ubb8w?=
 =?us-ascii?Q?pJh4DvyaZ4O6ELb98vRJNdu4cvua+Fb6k5AUEXkygSl9Ey0JqU7XL0nLR9tg?=
 =?us-ascii?Q?Pb16uGIonlilahJYKKTu/uIr/dxckr2ro3lZn17mO5dC1i+RbNCF23wzTMIL?=
 =?us-ascii?Q?jewZSOeIH+TZQbHttd4P0qAERcSPyh+YzJ0QNGLBENwSHrxl2O3nTt0duMxD?=
 =?us-ascii?Q?aAsF55Vt2GiTNJgIvo+lBvtdcf+4LmRuTcRNKDISB35zXy2UC0R7twTsi3rc?=
 =?us-ascii?Q?s9NTbryqDwmHozEt2XSun6871gh7nLueVtFI/g6k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1064c4e8-63cb-46c8-2aed-08db41d044ee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRbpZPaZ2b05tnBabdT90w36Yt6CDUzUsdYtAb2sebFqRVWqerXqB1uhpxNwbSAu
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

The code flow for first time attaching a PT and replacing a PT is very
similar except for the lowest do_attach step.

Reorganize this so that the do_attach step is a function pointer.

Replace requires destroying the old HWPT once it is replaced. This
destruction cannot be done under all the locks that are held in the
function pointer, so the signature allows returning a HWPT which will be
destroyed by the caller after everything is unlocked.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 141 ++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2155fafda27a5f..9d61a62c4be067 100644
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
@@ -376,52 +401,58 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
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
@@ -432,8 +463,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -441,22 +472,54 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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

