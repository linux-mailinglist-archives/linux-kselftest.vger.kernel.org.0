Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D106AFB3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHAgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCHAgI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6A9E322;
        Tue,  7 Mar 2023 16:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbPYFq5MZry6+TBOUjdfZnrYZvFzrU8Oi2HFAcq63Pboe3hgY8nz5lpR1LN4IhCxMOYJql1Gz1Oj07bas5wughVdf2XtxiKpor6dpO8pHMnGzv5aw+bX7S3NB3W+VVFYWcTI8s89NKyKUFvgH50LMjfM/Dt4WDdjdY2bpRKtP/WDEAgkC5kJvfY4wSOrHZ5wtjmxyfKlEnAVW07F+aFXtb+MPh3Wtq4taI/6F5Bo4s85z4vDoNtVOR8ppd35/KeqE9P/UsDjoni+CZ6VgSukJ2ml3wzTCn8d8SlhCz2AV+ikZaIXtG2ajz0KSu9FErdXBPugePtUaRWb+A7o/LmREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxXDxb7yShZBgJIQpBZ1v+WAP276Yp+uWU6odHNvTGg=;
 b=hePpelqkRO1cQIpFlGGYyFS8FdnmcPWvPHIjcXx8KuSAnNlxO4pfgyQ8OG1fzwHveZr7I+mFKf7IB0ku4Ffh9Cq08a82FOGnPvNPcCR4bnFExTJJ9OQsxlWESmU5/RDu75NTKmx/lapyvDlVI9x4V+eDGB5AKa+mkK+rDcMy2Ly1hJcEFmID7Q8vrXqf/0LXtHrqypMuRo5bdptew/jC4kzrHss1JVUG2ZVNDIb7ywW5P5Yx724S3iQzDAi04ZF9YsqNpJUHVWQs9Qo63ojd0+dloZ1/9evNCTzQx+Log1Lp8K859VufFz+BaXpnDUE/dWPbJ9VDsO65TPI1o/GP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxXDxb7yShZBgJIQpBZ1v+WAP276Yp+uWU6odHNvTGg=;
 b=SuqHOYmjSBUmfojalRX1+bgAGHUX9PRXuOsynYHkp5Lq4tCwzhDiAMLBmbFcFlX/HpmdWAGal+kozK2IabC/qcSqbxkbp8jC/v0l7FqirsF9vHOHEwbv99zNSA0pwkJHe2z6dMUjMjV4ZtR/pszJmkuRYAWKec1nRAci9aPlqc6X0f+8AeXS3uxxw+pt9YhfaMPXeG8gKKHeBERkRiLehgUVKZACgYFTGtcHtZne+P36dCJnqChfOuVfy/ATdhHKVBs6MH1clHhpz3xTG6zUVOfArFoU21ghTwH7ArUstbMskSBgbL/dk0NUHMc0IDZ/4L21fD0PFbIjQQNnvOZX+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 10/17] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Tue,  7 Mar 2023 20:35:49 -0400
Message-Id: <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0026.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c27baa-3b9c-41c5-d6b4-08db1f6d15cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRWKEjW1V7kdAEEuodc+X9tfB+Pi3OkNAVf8WUZGpZTP0qgRHkH/TH+ajB/MJjAXpXS65hC1a1g/sm83jlfb+qWj0YbV5FmoBNSP1+UqVyc1vlEzaLpS7JniYc/pUGt20zq/b+vkEkTtazmD8bsNPhxAN88rt9ziWBS049vpJ+KAiP/pcBsSSnE2N9qaDaUf25h6UdenfIG/pCrjAYEFzOIVWGl4P6SMJL1ACYOvYFHhUwBJJllPJdWHODiA59YVY+vKX1LR5kLFMyK9Xf1/suFsnB6+a1Drdpx1+HdQ7RDW9DVN4clUG4v0nlgLCvh4YrbWIlGekJChPLJLLhSthbpqw9XcrzO3Zjozh6hwel724abqXyeJ5gCMOfnY/jedo2VbrZktkl9ROm0aRGrTTXshjAanN0m8Mh5d7We6t1SB5Ch4tkLIbdn7mRt0h58/CCYMbwq2Gs8SGo18WhEa6dvP72lX5YJLqP38388xXuK+LyNSMVSjO7muf9/SH4wOSnIEaBugLDkE1lrwY4ouEq1zAgprPRSyVbLFIjQmsJjSFxuVoGgL/sBDNFdZFJvqXCefId57dnoYB5RRZAaHD0zVnmT0c6DITzQ55FCzkj6HB2kRHqFvzCX4C5VaoLQSWaHgvV+gnpZAFwyIrksopQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUOANU3SIba/E0SAAU+M+y0I8uhXrT8HwZ49C3dYKtIC6BWRQXQgZXQ7MdzU?=
 =?us-ascii?Q?bT77xZ5OX4EgSmbk+aHxv0m0lJY35dxkgBgqF9bygdRvvY/q3LKsFAl9PXhB?=
 =?us-ascii?Q?AtQz5Cwrc4Ot2cAyMNkWGXLZ5HcDnhX5t2klsqnhUGPBG7+mFuO7iAGiaNQO?=
 =?us-ascii?Q?uPhrWFt+XhVbrlgZnNBtSFJuzau+alFHsZDa+e2g49s1Lq6zbgTaQsaP42SM?=
 =?us-ascii?Q?cIGvTAqB/FWv4/GEKYYLYFA5Ee/hwSFm9l+zYiN/5t2d103T/ie+xGrN7eKz?=
 =?us-ascii?Q?wBoE+coPVpiAIVIg2KcSIbrJPDrxGNlqE5hFTbAu11YYu6P+5q0MkjW7g8kq?=
 =?us-ascii?Q?rVEYTBNozW2oy5zNyngNEB5KMOKW/OB23DcqdiYeGIAtvem9o1ovhDfNtkgv?=
 =?us-ascii?Q?EkxmgDqm7411ZoWuOom1P99vDdxxG4AF4A8iauJH1056bNdhT7rvgcGUEBdY?=
 =?us-ascii?Q?LZ/3Zk4Nufc2XKDUYCwc/pPvkcZVUIUBdKDbDcJVqAQl3D8KuFdrw2ERDECK?=
 =?us-ascii?Q?aayU5fFEnd9b9KyWBYoaksuRQC1S3hJ76hYrDBTq+fK9IFEDPdPXQEEjWUpn?=
 =?us-ascii?Q?ta7HmYRS8TPdGGpadP6Bzvyu0avFGYyrJnwBSlgQO0NzXC9AM+U2BDuXVHcd?=
 =?us-ascii?Q?d2oR54FM3pxn1qhWTlNSO8flbGmp5X+sd9Bit6ndB3g6X9E051aklmhdnJ7w?=
 =?us-ascii?Q?kGKnJqaXtnhUx7/bFEU5dY6bVrE0I2vCnSERfvjH6fvGhrADBrJjdyJO1quJ?=
 =?us-ascii?Q?nw8GydByqdmOIg8Txes0Nfj5ltuY2C4eDMKQnOfzIOtfsxPvbvenIUY+BkAB?=
 =?us-ascii?Q?Cr96RBeKYJJcuopZE/W2prvszOSSNljqFp/AOp5gE6Gp9VO+oTsO+ENlJfdu?=
 =?us-ascii?Q?WkvSQ0ZCwq1GoN45MNDYFfrF7ThVS6fSdvqhnHEs7M7JZkCi8BuHUKMqNXsc?=
 =?us-ascii?Q?4xS3QiAplf3FM7PHNE4gr0/4e4yxc+UKC9LNaaf85/J5XpTbwTUdlHijpqzD?=
 =?us-ascii?Q?0Zu2mG1pngUVpTm2Sb3ROoAQon5iVi8+csyq+Y9C2cKYje6AOe471/7F9KEo?=
 =?us-ascii?Q?46aEuI2DTXV5dhpr341n1fyqCGVvkuPa7SUaKp1VwRWMH5tLVlHPiRyF9jpq?=
 =?us-ascii?Q?k7kPU4kKStOqgnFBwV/px20BgHwNBhzNaZidhwzj/CmWBBxmUnmZ3eVn8gDD?=
 =?us-ascii?Q?+swb+zb6WnQOg1KIs/t9BxWGL2p0OwIH0e0gkIRvQrfsUmR9mftFyb1eyvNR?=
 =?us-ascii?Q?XqJvAPvXPw3kOdwljjz6pvrOMPpwQnv2MXxYQYwpkTcTVWY1pZlqbiQCoFYd?=
 =?us-ascii?Q?2+gvf4rHQy5ei+FsD3FweRGW6hLhf+yUrOys1uXYJ0SCC96fN2acpx1it1Or?=
 =?us-ascii?Q?MEXS0q8fMuyXyXG2G1DZ8u9KW6Xdl2XoCAtXTK3tSV88oDhzQg9yZ3Squv0N?=
 =?us-ascii?Q?zPqcL2Hmie9H0UvIROYdhqzmAtzNSK1MayJLK0T7qjPEMtzgdxrcJzUhIeyu?=
 =?us-ascii?Q?tElYOdZgCzhL19YYlQF6XjbJ1IfcQWzs9yqUhyNDw6jnL4ZEir8fD8Tor9hc?=
 =?us-ascii?Q?0RAq6tUAoC7tcwSZZk/Aq/9Tkb6c2atk2rq64Euh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c27baa-3b9c-41c5-d6b4-08db1f6d15cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:58.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx1DK2wJWIH1Xh7ZD2JKYB0yZiFVmHaeloH9/+xULH+3BG4rtgVHg0TalEWMOpb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 130 ++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ddde14d6d1352c..0256e65476f045 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -345,27 +345,36 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
+	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hw_pagetable *hwpt;
-	int rc;
 
 	/*
 	 * There is no differentiation when domains are allocated, so any domain
@@ -379,52 +388,57 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
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
 		*pt_id = hwpt->obj.id;
+		iommufd_put_object(&hwpt->obj);
+		if (IS_ERR(destroy_hwpt)) {
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
@@ -435,8 +449,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -444,22 +458,54 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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
2.39.2

