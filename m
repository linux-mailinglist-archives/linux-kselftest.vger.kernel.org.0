Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034086DE134
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDKQn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDKQn2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB0120;
        Tue, 11 Apr 2023 09:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIKLYQBwrFqSUKEzcUdn9dmjXwsY7AN3hC6XSRrh1vB0IgkB4nTahTpjSLhlhp8/Jow+IYdiSbQD00ampq0xNxaswoHXCm/6bWPMM2aRFm5H6odbCZfixQvlDNrG/PQ96/vqOtM09yym/PWSH5Yboings0bCZHYuFzIPXwjT0zMQ2WUf1f9RRLRAv2Lqh2FeGhDdcSjKKHwwKgui+7iwEX1rZ+1gKwUiRmX9Ya3e8U87yTwrpH0DxzfLrA0eJBcvXpree/r16EPDp4TTAP3bTZ15XwLa3e+9hsl5A46LjvQW4F/WG4swFRZjB/77RigWPFMp1SkwRcWvzZ6vifHoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zlb9W+5EtTwswzSQq518V7RNAu9hwA9wh1V7iPQkOaI=;
 b=ZGxwpkDVKnTBObuCoXtbyh6jLhflj6FBM5fthAanuWHXAcfHW+/gYqa2x1UZtzPxjINNR0+kiMwQxvzfiDyZeXdIRkYCGCdG5P8LgbfRN26d/w8UpAzV/b+K07GXzyLiBcLGHuZC52CKgGy6mnyMZ2qu+CF5cBOMN3XWUyarTnS8WbHVWvniY6b9CFCae6dgopMCFBL1N2e/q6GFbAUL3Wflocm+gVN574Y/ExNN1CELb9voXUMZ5ZlM9GOrIfkGRrNVDNgXeIXXXpYuBkk76CArwSzFzf1PJg3sLtHKMuqacFAeroU1U2hlwrkPYn/WahIxcIHOrkIHhSLgRsIqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlb9W+5EtTwswzSQq518V7RNAu9hwA9wh1V7iPQkOaI=;
 b=Jx8p8q/UShpVR7xnab7hzDyckrv14k88cd/MVeQs+fuELKaH4R/G2WKLOuD5hBaQ9Yyo2OtzSzj4xpdHCZKmusqrY7Hh5YaV3Gd07gG2YAyPhdiEN/csInfAJL1oVkdEa2WrQ6vq80PABBUVzJrY4tPA5GptrPXNPM+gsMC6inF6l18z/ez6tH6YlBWKyJ801Bs+iFJEbnvklCmwVkeLtAiqDIBWv8Edded8ccM4GcM9IWH+p0tUKOTGfjPwRf+R7KU4z73vUnXjaSLPpqI5Bw/sEiQlJF2Xxzbsojnu4kldUA9wur2GPOtYV/0RrQXwH/tnlG0guEVQHB0r0PExPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 10/17] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Tue, 11 Apr 2023 13:43:11 -0300
Message-Id: <10-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 854e06f9-244d-48ac-c7f4-08db3aabdc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUQHOhBdyMwHqi55jqfjpwJM7wUryJRS96q8oO+a7uQOtDsFDkGjsAg4ztXh2bSvHXcKW6BILWfAEL6zVdDRbeXCCpUuPGrpZkkwRfZXpMmS4nzaYfhdhh7YF7GYsAPxahg+EogMblwL1jMvFO93zCViOfW0GW96VwQoUt7Kr1NocExuNzXdv9boDM2uzHEusDejH+SMn54jM5Mzyc11HgfoVnobjjfN8uSpbdXiObmdVvjN26R+QWASbdcPqlfo//2luZgxVbqxLGgaRsjK70Lard9nMu64oxqme188X7TkdZmfdZ+eQgKP4ZuLSppE+0oYVfHUgwssSmEnXNxbNAmA2XC+jwJwPHDEDt9tegzqibcXQN/rioj7tLgFyhw5S9MAoKeCZrdkigyhJoj9NqIs18h0Qkgw04XDXJFUjmunDk9jzVouSP7w/vkbeL0mHUmXj+C0KZ3ckwQ7ZqXnb7mX28VPIEtEaFxnhGBJZxN8srEPiUo3ooPdQzIwWAZ4+86HgJECTgnrsdHcXgi+3afip0+A6V/QzfhBDWeqI5V1f+GpYidHNJ9bT7AM5Ceb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mywoz2urXDPajIt3Ksge/48d1JIGd0C2M8rRUv0aL0hAQLtrDRAKr5xhwcXP?=
 =?us-ascii?Q?anJ3iqSe5+bd5dde1ehe7rO64uRpWOg/Ef/JTgeAhdKL4SbytFM7xYjvKD8b?=
 =?us-ascii?Q?S8Cbm+9YQ2oOtbdVqgMpE/XUA7oI6fegaqkMgdqRUdfDKHITo2xfAjgNZ0mh?=
 =?us-ascii?Q?L1n0WjbC05l3L1vWv4fr+rIpkZFPq5hRKA59a+8QK/JtrSpYzqJ7gPmMBPrM?=
 =?us-ascii?Q?4dBIxoRnYKPj10fHVXyUECCHk5QSJYT/ZkP0Y5dBrjPuols7JiDR5YmSII17?=
 =?us-ascii?Q?vMOQXeRV9vUYK2cq7JPlDbnHjkAZUcLDYRhkjmM0FI1iHLcvfmDa9mZtL0o+?=
 =?us-ascii?Q?RLy2+Rt+k0Mxd271myoz5cw2KVw7MDJGrlwXjimZ/8isoIcTcWXHaZzzMRP+?=
 =?us-ascii?Q?KSYVZgWCp77AfiL23uXCgtHWIRk/rTXIzDSwlBdzqfxrJG6Vf7Phqtqfmge5?=
 =?us-ascii?Q?Xan3pJ6EQfnNsFCzyP7qOB5tJsRCsi5wcvg8r3Cp0G5k3v0cZ+72mr2n69ZV?=
 =?us-ascii?Q?LZcb/c8j3fYlIqYxohTUObe3ieGKd7FyxWoD6SNcbcB6+r1B96IyXzGNeNw9?=
 =?us-ascii?Q?b/Dz5Nr46NcZCizHfaMkXVz/5+NVlUpCIqjKCtnIG87zjk8m3+xLUonKhJ5C?=
 =?us-ascii?Q?tB4af/a85EQCh1Tr9k6LWTqcIzeCSsH4pvoPpcyOfm9ixajZovloxInQ9TcA?=
 =?us-ascii?Q?pOlzmRXUSZNeK/oqSTLx8U5TyAj3a/BvkdUDwobgM2swHGSQYNwQcVZ+wkNI?=
 =?us-ascii?Q?WpcjJoJNN4MkqN3cTr/ibrqYYpEeRZopYcSu14g8YCrhlI5wA0zl0OHZqhbF?=
 =?us-ascii?Q?nnoMqWnPrbS791M51VPFohfYqXZoqX+Kh8HtWlZsaU0OHR5mPIJeEs+i7kdB?=
 =?us-ascii?Q?FXzGEPM1kePjmjgmnW9NLFkuwuePNw1xGlpJLDFgH3q73AZ76OX6AiSVCWrd?=
 =?us-ascii?Q?QCqXCr0JkbGFjjiMcu1FLNpNrRnucq/QlNDGrOkOjSEI0YBFTnhsiViPGIpf?=
 =?us-ascii?Q?IFy9bVnGXDvEBt+YfjXcEfmacMEz0W/sBzN1ua88q0DdxqNPrFeRU+1f821g?=
 =?us-ascii?Q?JLvVlJSfyvI8v/Qj2fKw4GSGGtsnlbuKjDbaCSQlCN1GllITSgucvn6u0Lpl?=
 =?us-ascii?Q?GBP5DvHkeWMH+QJcxnYLc9tgoWvxCw6G49nSYF5hbljcCrx9ex4uLIlZiz4w?=
 =?us-ascii?Q?nDV5Cu8HqqB5eHTp7/CMxm2JmrjyX42XBW2nu2sOWQbGpmGcpVrbKvioGQ+w?=
 =?us-ascii?Q?cxQ+vgdwf6qBVjlINeptz1GeA14k1w2AX/RZ1CPgdj39JuB47plMWUzij9P+?=
 =?us-ascii?Q?M2CyduwIqS27AR5FKCGZvJSlr4cVmQqhFfw6eO6Q3LNvqmwLS6CTdVXuhum4?=
 =?us-ascii?Q?4VjWM3RSDhqNlA+5sf+Weuw4AZeEysodwar+XA0vWM+Vhs9LuBqYHpampFC8?=
 =?us-ascii?Q?gzAkVtnJLPzQsWdmrJ2a9AvvxwhXh2qIPzkSeBfqk337Y1nMoHFd40DBF3lw?=
 =?us-ascii?Q?lCFuYKkkvs++XzUrxVxRXl2m6/uOt8F01w3EWiXuSQVUb1S0LUpDMwB5ywi4?=
 =?us-ascii?Q?59SslO2p6mHEIrJnKUUEyKemBUlCogtXKiYHQ3ge?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854e06f9-244d-48ac-c7f4-08db3aabdc0c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvR2ppytzUUltIIESO70t33yjGVyc3OovA9ocREXJ0kvkhGLsD0JsXN+6R7ltxpB
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
 drivers/iommu/iommufd/device.c | 138 +++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8f72a528325f04..e9979ca2494c48 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -347,27 +347,43 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
@@ -381,52 +397,58 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
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
@@ -437,8 +459,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -446,22 +468,54 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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

