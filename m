Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053926A257B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBYA2G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBYA2F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:05 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3218B0B;
        Fri, 24 Feb 2023 16:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx2fUHfir+8Z3LMXvF2uL8C7U4a7/kkKvkcUT+UwuySal9c1tm98NHOsV25NfiVe9m7h662hD+t01FdoN1kNeG1jw6XXSRO3NPrsAo5keuAhU4gGqAgSgYrU15tukDWhUBL052S7BWMoisGw5+T37iog9LG1lvAEKYBg2ipe4srspBCufnOA4WQz8A7GjEHwx5D/X7uj+Ld28WAhNTzGvTIf2oGm++ftJ6G1lgC17OSN5zaMtRCIhJMEkTS9Lg7WL+5Fn/w+o0+4LXJrh01s59foR7dyhokTrZwMe6X5LVu0Y/DuFOF5iW/ZmTLxuLvc4RRvD06GiCVGytCcIeJzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnzJQh/4OPTkwchnBXPM9CMhIalhimwOA0CZalhAdmo=;
 b=mSSaIK2eMfuBVQ3HXnLNq6azYFojGWysJJCHNWPwFguaWcs39yANmKbIewgk0fQmYK3IV9fcGVP/IG/gmUHIqGQrwnifbb+ulJFl+68EhWaMIPc6bhWNWCq6pM7v9zjy2oUQhc653fiLi8LPbbTmNFMT7L6XTkIv5GnMvLiUp0WSxbhG5QICg86TG0uj6v0Tqa5q/B3ih2v8zEbWijK+L7YKtDOX/Pce0JU+QG/NE3EiKw9RljDC3z1YuO/7UQFYn0eSZoBflYmuvNJKOaRyFDQbGLMPev5azDXWoogtfPDHU87qjBz/Vmz5+5/5p2F5M9NsLbs2OX42erR8U5iZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnzJQh/4OPTkwchnBXPM9CMhIalhimwOA0CZalhAdmo=;
 b=qF2eYTK/qQNZObzgSgksULJBVoXPM3Nyit7xmm+lEh2fU/aXVqaKnKzqcRme3tClau+zk8wd5liRsseysWmqbWOsJvvaq8oRgQiOjmvoqxbtJxkNIKaV5bX4HFob4jISJaq7ZeUjpv9rlQk2hliPrr4DlsWys5Jlkj35gRRSdIyL7g90eLS5mhKJmIO6JdN6adlQHbYE4vnsPohbH22W9TZLq9k+CD4bUP5jP98Tn+Bc531JGED8n26/Qmaql9BoSq95+dyL4FA50ybFMZyn37++vbsMm5Y8xZbE6G7lLiubfZ3MHotD4epY1I8d/31NX9IvFiCqCYQsz7lIlw+F6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate reserved groups and msi setup
Date:   Fri, 24 Feb 2023 20:27:49 -0400
Message-Id: <4-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4e75d0-c87c-437c-579f-08db16c726d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deCX8ufa9ebyFQGs2KM7AisEPaKfKH2qSnYfDQOMnKqs2+vhzjZG1exrjnMtljxpl5K69cP+TslKvm4VTBUhbOuA9bZpenRu0AHUEO8j+McQfgevbQetIqUDb99u1iHK9YxDxByoZwirJhwaMDWvWwgSYVPjYhDy4FblqXsiaD9YE2JRxvR0Wb3N6KjDTG13yXYSYZODjQkfYyGqW3us9Oe+1dcwER2k12KZml68znNC3neDiGKuPAu8mHfxh5CM0IedYjx5eOAybqPbWPB4WdXwdEPPOCNmolwyq6Ro37hf/F+e7x0JRLle762zw2TLYR3H90A2S2LRpyKM8GF3oXdta/wbhqg965Nz5tpn/br9vAovpRuZUJReoPh7XDsSmCCUvceetNQJmxYpA78O49R72s4mvlJL12qHXCmvp/Mt1nnV/0UkFBHGgKP/mfaLXzbY4i+RGXt+uRkQH+5DH4FQMwCY+/WUwyOFBy1mzu0ZAR9GwjUdmfPyYZ6CHQGi3FzErc1U34LdE5rxyjh8uz5EFdnbFprWvxJOM9eAV8te8KMHJI/0veQvgiMIK9gYZns6qaYUSuXjrQRZ87XCRm3J4MRt33t7C7GzTnaEWaHbWoLnFni1iVQyMHeXGun6YtjxAfVPMXcBIZhvEgi7hMRzHsHDTHZR5TrvkfKUa5q2nAO1CC5AUoZWWLs2euUo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVJuPrRvO71Y8Bpn1Jp85LGlvDTE3cQUaNBH63x35q2xI01LZBrmAtryjict?=
 =?us-ascii?Q?ho0b1Nv3/+MCr2CvyCMm34sclXRSle6s7Bki/qIXQ/aDARXzbG2oMhg3mGP+?=
 =?us-ascii?Q?RCWc0W/FWn+pfY4VgLo9UMrylnuhjvyIOO3dQOYWapKabZxjl0vNVwRy6AwA?=
 =?us-ascii?Q?bnsKe4t+YGMuNyw1/2jSFdxzMxuzYPIEyWyLTbS9NP26oXj5aE50EKh8VDee?=
 =?us-ascii?Q?vUDTRQGFlw7g7SxanazbBqKfMnqflhP0CAXtGbLhZXxrm2MZJpA+F4iw7m5w?=
 =?us-ascii?Q?HsyhzTl9UBxZxOBshSFe//Z3YbElm1IC38PMhafzaPz5b5g7mODnlPwR7WOi?=
 =?us-ascii?Q?pxiTK3QKANC4EcfmKHqR9Q1uuMw1Ha+wBQbmbGsX+T3rbctuJEmfOx3/ogeV?=
 =?us-ascii?Q?Ud7udCzVjtUA0+f95sLXx3QEgNS9d7iKmyH8j+Ez0B/9vH/D7HTRKaoc8VEg?=
 =?us-ascii?Q?mcL5bPQoatlnnYBoOyv6DgQ6jm/lgXPbfxCCwRWDCTnWORlEg1MJpG8KK+sW?=
 =?us-ascii?Q?T3k2XjBIGkjybPzdNXwG3n4ozfruEDX95bwHbQPw3K4fdG9VNbeRwZrBhhnz?=
 =?us-ascii?Q?WnGCKsKjlJxUJN5EfURhZtFTGpKhT5CIAUcVSXWQyNADMNt92flvjZCg1zrX?=
 =?us-ascii?Q?8H3A7GDqA3OkJZf1ffDL3qmiR7TGx91gU2xspBy3rR8APbcNyQUSW0bUKC+z?=
 =?us-ascii?Q?Lo6+8HrcW/WUftVNImDrTYKwN6pPHV6ypNrwnGDYt/NiBoS3mxCx9q/Zrt4D?=
 =?us-ascii?Q?6LWFmJJP86r69WvwevtbJftL8gDbtjHIDhBoksPZA39jjq5w+yDrA/muffLz?=
 =?us-ascii?Q?NIi+yddAEFIYsDx4gEXWpi0AFFEnrEimZyBPlf4U+Na3y1hAXv5BPWgeBmGl?=
 =?us-ascii?Q?HiRq6XtacF8ohf7itg00IgxSaj4Nf4qvU3FylOhCog1axYOQygt1j2C8qQc/?=
 =?us-ascii?Q?/eRpVcRR9KEHcYsfkUgc/qWqgni5cJyRxDYHV8kKDXpm11d/fY/u/azTTtkL?=
 =?us-ascii?Q?Y9QXqtKcoFoFCMeF+vMhNhZAjImjNwaT3DDP1wUcGXhTjKpiRS+yM8FRYi7L?=
 =?us-ascii?Q?PfdUsr/aLtrS/L1z/9GKhzwbWR2I2jIwc142RMtbfkd8KuCYS4ssCRSoYgF1?=
 =?us-ascii?Q?tOM0h9aiSWX5aYu5s+lvMHvFDzHSYpUHrywTEdMd3gnvn+09sboMB+VnLCzz?=
 =?us-ascii?Q?xsQAVq64PQGdHO01cun7963ZTSKdAGO0oNZAEBzZXmMUV+mzPXpQxdKXCCfy?=
 =?us-ascii?Q?wbGEcqBW1N9zVmIv55FWwT+2AYxUC1/WMeGkFDa0mrHStF98eY84+BjfVAX6?=
 =?us-ascii?Q?IBA32oLP3eLvu8ZnzT4WPHWuXkSV8sCrZshyObJuRy0pNdJxCbXcirC9exJZ?=
 =?us-ascii?Q?lBc21MsKqawd42wSawr0/hYblPXmHvzBdyL/hgiyquTjozoMyfAQel0kB0cp?=
 =?us-ascii?Q?3a/OTEccuFeaRVkpEO9dFKGcylVasir6kCzHoT4GTHFAkGLeUWqAhmlwIpDW?=
 =?us-ascii?Q?H/CUNfoCanB/i22q5Xo2FTty7LZ1xQA/aH2L7BaQUiorgh99LoyutE4gGgpL?=
 =?us-ascii?Q?BA8rdzmyJ9QkMrDIfrF1Q0W6L4LLeel9fr+w0K+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4e75d0-c87c-437c-579f-08db16c726d3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUgZFyHoOYTy/9+802etF3mUBIHoCeZMw+kaQZ33DQ+LlJch4CVELAi0cNHp2fjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These items only needs to be done once per group, not once per device. The
once per device was a way to make the device list work. Since we are
abandoning this we can optimize things a bit.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 38 ++++++++++++++-----------
 drivers/iommu/iommufd/io_pagetable.c    |  5 ++--
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 264bfa2212481f..75e8d79678736f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -298,9 +298,20 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->igroup->group,
-						   &sw_msi_start);
+	/*
+	 * The first device in the group to be attached will do all the work
+	 * to setup the hwpt and ioas. Every other device re-uses it through
+	 * the shared group attachment. Users are allowed/expected to attach
+	 * every device in the group to the same hwpt, that just turns into
+	 * a NOP.
+	 */
+	if (idev->igroup->devices) {
+		idev->igroup->devices++;
+		return 0;
+	}
+
+	rc = iopt_table_enforce_group_resv_regions(
+		&hwpt->ioas->iopt, idev->igroup->group, &sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -308,22 +319,15 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unresv;
 
-	/*
-	 * Only attach to the group once for the first device that is in the
-	 * group. All the other devices will follow this attachment.
-	 * The user can attach every device individually as well.
-	 */
-	if (!idev->igroup->devices) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
-		if (rc)
-			goto err_unresv;
-		idev->igroup->hwpt = hwpt;
-		refcount_inc(&hwpt->obj.users);
-	}
+	rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+	if (rc)
+		goto err_unresv;
+	idev->igroup->hwpt = hwpt;
+	refcount_inc(&hwpt->obj.users);
 	idev->igroup->devices++;
 	return 0;
 err_unresv:
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->igroup->group);
 	return rc;
 }
 
@@ -339,7 +343,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->igroup->group);
 	return hwpt;
 }
 
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f86..096491bbb5acf5 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1163,7 +1163,6 @@ void iopt_remove_access(struct io_pagetable *iopt,
 
 /* Narrow the valid_iova_itree to include reserved ranges from a group. */
 int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
 					  struct iommu_group *group,
 					  phys_addr_t *sw_msi_start)
 {
@@ -1191,7 +1190,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 		}
 
 		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, device);
+				       resv->length - 1 + resv->start, group);
 		if (rc)
 			goto out_reserved;
 	}
@@ -1206,7 +1205,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 	goto out_free_resv;
 
 out_reserved:
-	__iopt_remove_reserved_iova(iopt, device);
+	__iopt_remove_reserved_iova(iopt, group);
 out_free_resv:
 	list_for_each_entry_safe(resv, tmp, &group_resv_regions, list)
 		kfree(resv);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5f3ad16da819e7..dbecdff013d082 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -77,7 +77,6 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
 					  struct iommu_group *group,
 					  phys_addr_t *sw_msi_start);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
-- 
2.39.1

