Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F36A2587
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBYA2N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBYA2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C518B1A;
        Fri, 24 Feb 2023 16:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAXlZeMob0u78gSal8b+GrxwDzJ8AdOy23k23myzX/y6Y+ZkJTlzjOvJsIX7KKwR/pbk6vOPH5ubO4truYZttvxL7k5XNzYpAaLWr0MV1NGsppc9BH0IQNo/fA4LNuiw94TMZ9hGnAaGPc9cnldJwJC1OtIDRDylyWT2U9nBfkN+JR1Om1Aqa2s9h3xf5ryLLxO3tVXGRc4Gu4LkHEDc7VMKxJmJIolWgMRsIElQEm7MtOqlzT0XaGLen5cLb9XuPynXYwia7oaV0282rS9IttvjRe5IM/xOIb6I0OqVXR37q/yvaRL90OisDTAyZiwvq73S4UmvU9trxCtzkCRgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh0NycKltfduhZDQLFW4V562rmKPtPvJsMvEKchc71E=;
 b=aEUs0r3uv72AcDJhiI+R8H/9k3nq6AKik4dR2O8rQZURZ0EHqyKpqyUp5+CQgWI+SxZyGrv8mXhOzt/LpDLcJ1RegH64vQPKLHUCtNtQddNWP7qGH2eiRpUYD+Cv9vxVDFIeMnnVUmPBP3i5WowE81zU0/OxCwdYKsG0NGt6ylWctHuw47nghN4472HVu5dee9hlp8x+aY8zNL8nuKnRvgps00+fmpXwBdiJpGstmg2IbBCiE7zJsB4sdr1GyRjhz/f9+bsH22AEyqoiuYqEVYT7T3OFIPrCautcoz7rcL+eV2NOQcKzcX/I4RjzPEJoYKjESTx0j5WvIRdJZOQawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh0NycKltfduhZDQLFW4V562rmKPtPvJsMvEKchc71E=;
 b=HsMXdsb0/ikFzcFn9NF/ZLM8aTURegGDOlYLzgt7Ew/0ApxqKS2FxXky3EpdR5rAaCG1c4mhxLHOv8XMErbEJpiUbdeB+o/pH+2s1YrlOLfE3533Wy/E9SLNe46KfA63aTXGHgegJLAK0RvPBDzlqT6Ryjq7W/HfQqFGFDAJ9RcWPU1d/lCB7Wzf4WhYab4QB6hAHEdAZPGWsUwiqpgCEv8aG9apWGt4VtPDQNTjW+yKkAQYRyZZuq6O89RMBZMgDW46Nw0oIVhrbgvmjALxGP2Fbwo0uOh4AgYoVJcbLrnEwNLO81RJ1wuUSOGPsPEW4aFHzdbz7+W7yajQAvXmsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:06 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 03/14] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Fri, 24 Feb 2023 20:27:48 -0400
Message-Id: <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: fe524aac-bb53-4097-222f-08db16c72767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTZKk9DUvYi7E4pota5M2CVVnABKrTiRVa0Wquu8FL/RIn1O+JlxozZT3Nudk7glxG5QeGnoYUXSBmjc+ryCIPeB1K+40889alvYvTRQ19OTzkHUsT2l56wguOWm/tGaNE+nfMWl6wm10eRLeGplKI7LX5Ah+r5ABVAI7zMeb/3q89wL/DuU8iUaqnT6ifg9AZe5q9c1zEFDon9F7Ra4QE6IZmOWTp2snJ6eo0bdhoAZk4PP8fhwtxeXE/MM5HSQTy6Dzysbp5nr418v+uQPon07FqJxUccxSWzbbp6Q3vxqMS4JJ1olb7nQDV6Z26uz2y40x+ax8xcKrYXWI8tEt3aFkkokt00poDohpJFlHfN3Mm9802hIKw9tlCu29eoJU65qGRXYqFoP7lU7aHrMUOoIrjqkZibz63rUnkq7T6melmb04haKg/MW5PHG0E5Iq2xD9U/nD+D81JCxe9+OSWSG1uYyFEck9MEyAxe6aVKPgD0XbH6BYIi/EITS/uNvWHVh4A/OOV0RmFEO1CFY6wuwCgHwMmPWC4bpmxuakyfJT2OSSTolkubcmtv+BYmUz4CgU3lZE58eQHTFOcG7NcSgJptmJt7co89PZ4m5CyP2vv89m08cmr4vGlNOtLysm1GvEWVP1M4Z+RyPHCgqQamJhnC0YXaFSrlgPYYAL8b8QR63i70kHtDeHcRmLsCe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(54906003)(86362001)(6486002)(6666004)(26005)(186003)(66946007)(2906002)(30864003)(8676002)(41300700001)(66476007)(6506007)(478600001)(6512007)(5660300002)(66556008)(4326008)(8936002)(83380400001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ui6fvV9G1cbsyIlYlJyolr/HPi57I5H+GcjiEzjaqqrVoxxGj7Tj77IOH4u?=
 =?us-ascii?Q?Tg5MJ9q0WtSMrHM4HChxG4NbLx2p5dxiEgOLvkkOSgHIslKFpS+iweqHRJdz?=
 =?us-ascii?Q?MeUInRQPFCpVaD/qkhk5V7Cb0mavS9HuIebDTsgEsEj8rN2fUWKkrrvY97Ec?=
 =?us-ascii?Q?epRYkDYcHvyT3SKZy9jwceo3SDROZ0mF2o9YGeP5wk/eSc/iTQx4G9tVgpsd?=
 =?us-ascii?Q?qosS8jYQkUrsiIKDUKLk/ES/BefZvsHD26s4rJKW55W/iQiP0HNI2CjN9lbj?=
 =?us-ascii?Q?5Drwi56mta+deKaXoHNUPUMpGLbvji4KJkXYG0oHbEHNhsfw7F5kvqgW1OJ1?=
 =?us-ascii?Q?nG5X23PvpiRMj3a8vLBdBa/VGxhiusAH9g5VTqxdM+JtUSlt01OlZarp3zDB?=
 =?us-ascii?Q?mgRQXA01+eZ2f1aZah2etXOI6iW//kkAVQx9YoSqxiGa2yJhvTIMiwQl22Ts?=
 =?us-ascii?Q?NcONeTqf7tjF8EqWYdc64peQdWc5Jgx5WfiV27PH/tJP6/XNyEiDVcjz0qXW?=
 =?us-ascii?Q?7jbzEVMFYwGaVo5jY2u3BmkGIYR/zyFfAHlbvE0yU324gnkNuVIC5WgpKdWC?=
 =?us-ascii?Q?4GZd8Uz44oNgfRj6TGW6Ey5Dbl2eHB7Re0EOl3MGLG/Xni3wMUCAY+grpDuk?=
 =?us-ascii?Q?KKSIHCmSTSELnPDnfG7MqFpuRdmjI1P5B1GAC350MeFHGd/4U/di6jl8IEcv?=
 =?us-ascii?Q?/yrcPTsqJh9ejn2PBEcBWapcoM91Raj5B9EtkcTLoIvLP8kgVP4MCDAjakSo?=
 =?us-ascii?Q?jOYhSwXlFxZL6GbIzcQ9jLc6NKppyr6ue+sJGCPmyf0TcAiTjLh7kItStnyR?=
 =?us-ascii?Q?+jrzTQLg+MJaPMbsKNZmwOHdYHArUdKgjTqTHwnlMKPswEoaOzCHks6ecuQd?=
 =?us-ascii?Q?dP4kPOLH85ws6FADvGOU/3jkqkbOP/25MX2Jz/5j3KFm2NOuivDwd4pd3go9?=
 =?us-ascii?Q?Z6iKH/IqZ3q92loYLnhWMfRYfz9XNQfvF7jt4fnPQqn7bpg5ybmYFoz34Mg4?=
 =?us-ascii?Q?KfmsZP/aKgetYrTY8PE9PSPo3aRtMnTbleLKq7tgFv3PWuyBxs/y77ZZe3mu?=
 =?us-ascii?Q?VN3CirO+gPtJ0PLHeAMpiDeWuDhURLWhX2bS0kC4yHV6XIV8IqSUu/OfNvUm?=
 =?us-ascii?Q?Wjpt4wZskRTxa5+/goz0VYnkc9Km2qvFT9I8oyar53+VV6BLXAIg9ozWxzUd?=
 =?us-ascii?Q?DDTmpeU8EgcFfE+48X2i7HPNE4WkE8yPTtOvKnuQ11HphBlzBAn+s3tUl32f?=
 =?us-ascii?Q?l8WwV6Q6ATdVkRynTvHOeEFHdtUDderpsUGQdnr69MD8lredRTwnwLJY1L/Z?=
 =?us-ascii?Q?bLeNQVgnZXSsw1mDAbAuChZn1smrJANLF1Z3mLUgZmau62D30KsKHX9IYbOy?=
 =?us-ascii?Q?Me8Wlo1aGM8Igd+LeQlr7LpdAc82BdapeL1Y0yJ2O8orB7j/Y7AqaaNkuqgH?=
 =?us-ascii?Q?Nn9TSzK66j4O2KUq38BjG3HaY2wp+Ro9sd/63b/XYlzfkmnmfX1AbkqBUQQs?=
 =?us-ascii?Q?CWpEKYUgDypyNlAJyA08FTglA2PEjbH6/BXqREQrJcNZtdiFS/JQPJPj1lcF?=
 =?us-ascii?Q?7EEegj7UreRnK3kSLZ0jA83vahVqbu3V9DigQ7rA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe524aac-bb53-4097-222f-08db16c72767
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:02.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VwYkilcydYTuKh3RRs4YU0x7DDwCxlCjYDpiOo7GswqL86+pcllwjwmrybzKnSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The devices list was used as a simple way to avoid having per-group
information. Now that this seems to be unavoidable, just commit to
per-group information fully and remove the devices list.

The iommufd_group stores the currently assigned hwpt for the entire group
and we can manage the per-device attach/detach with a simple counter.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 75 ++++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 23 +++-----
 drivers/iommu/iommufd/iommufd_private.h | 12 ++--
 3 files changed, 47 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d1e227f310e823..264bfa2212481f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -20,9 +20,12 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
+	WARN_ON(igroup->hwpt || igroup->devices);
+
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
+	mutex_destroy(&igroup->lock);
 	kfree(igroup);
 }
 
@@ -70,6 +73,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 
 	kref_init(&new_igroup->ref);
+	mutex_init(&new_igroup->lock);
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -266,28 +270,15 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
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
@@ -302,7 +293,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
+			WARN_ON(!idev->igroup->devices);
 			return -EINVAL;
 		}
 	}
@@ -318,26 +309,38 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unresv;
 
 	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
+	 * Only attach to the group once for the first device that is in the
+	 * group. All the other devices will follow this attachment.
+	 * The user can attach every device individually as well.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+	if (!idev->igroup->devices) {
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
+		idev->igroup->hwpt = hwpt;
+		refcount_inc(&hwpt->obj.users);
 	}
+	idev->igroup->devices++;
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
+	idev->igroup->devices--;
+	if (!idev->igroup->devices) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	return hwpt;
 }
 
 static int iommufd_device_do_attach(struct iommufd_device *idev,
@@ -345,16 +348,9 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
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
 
@@ -364,7 +360,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -391,6 +387,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -400,6 +397,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -444,7 +442,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -455,7 +453,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -473,13 +470,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
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
index 2544f10dae9aef..5f3ad16da819e7 100644
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
+	unsigned int devices;
 };
 
 /*
@@ -278,9 +279,6 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-- 
2.39.1

