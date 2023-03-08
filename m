Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94E56AFB48
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCHAg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCHAgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13638A6160;
        Tue,  7 Mar 2023 16:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsIdmkRCe9xCZCh3EbqnHMEhna2ATc3Frpp3iTO4wcIwm2WPXqi5RKsE6aLi/357yinh8nA4ZPAXXIKa9sejx4tvcajT1ngoTKrg4Eiz2V5e3z83VUbXqKyBOK1LtFpy+JBJisHKAISW6mw62iKkgto5AVLCnVERlawI1JKH8ZJ8J4zxTkvjtwOaTtWzfeWRRXGiDRpd7N5lOy9JfovQZgC1wHFy8grlGvSvO20DsVMCThqynkL5QCadnQieIcj+cWhUqAQl4FdR4rzeC0ZEvCL0j0Z70FaQN+QXXFWfJ8pu6KHiCrL3qukqvEj/ucCycYGnbK4vTa8nbeNp/PWwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HraoYaiG6bH0MrmthsTdxK0oZRIy6v+ayoUpyWu7zFA=;
 b=CyHQXOUAB72Xga3PUKtBjKCQ1xRZwR3trNZPfuMWpvsXpaOfKOT21MANF55oCqE2E1sQYl096ARTLu5NklWpwxoweGNNWE0zefje00koM+MQs7Py8q/gv4ObEI2AI/T+BvpB7HKA0GqbPIMP+V/JlyJc3Q86eMXxvp7tmOvUKntfPy1e5yhRROjzD/Mf98TbHa7Y8B9xZQ5KEcyb4RQ/6Y0tnBZVC/yEU55lEDE6eLXCnZ5yFewmcaDqdwswd/QupOCJMje2OMoQQtEFR+NV262JURxz4wh4Y/kYYyvRjk4xdeY5GBSlRtyxYPaK8Pp9PgtKK51bcftKY+5R3aEHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HraoYaiG6bH0MrmthsTdxK0oZRIy6v+ayoUpyWu7zFA=;
 b=GdmRbRWaWNesK/EbamKE0RqCO/Ttdw7o4HcNr/cSibnXAz2SEpc+r9UyMDMz4sQ9p4klDkhdOz9NHTAe0CMvTWzGwxpnQsfyCmuUdCPeRk3YThU2+pJ9XEcUbS5wL4+hVLoFy/Va1IR+p8RtpFdIKF3WBfUeNs7mtHWsto9d6DwtKO7kbA82E4E2vUKEH7VqRA5RPv+gxQeD7BhsTdkrrpxwYCo7Gr7bUAlVSK/athYHd0IoR1TsVrmHOtcBeDWEg1soURzkRt/Hzr+s5NKssGMEEygT0mKDL1Pvyn8CgrP8AP9BqBmKW6Va22H8rkwJvbEyORitinpv/KbUZVqnbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 09/17] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Tue,  7 Mar 2023 20:35:48 -0400
Message-Id: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6680fdf6-4f77-4d61-16ad-08db1f6d16cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfI9WYK+uLY69ir74u4FKm16mOIsAu4TFbXyk/993HzApZuGR8m+tiXimH9BGXVMnH3St4J7JQxnKyYJ2fuSCAsQZh0r28GNJ0Tc3GgAW3Y6r4Ab7C+fGdeR2+47UuAMAkmMvSZEyobGPUnvMRVYnnXb3CTxAhX/2TADeTGA0P9/C1DMadHRWKjdqqVt8p9DZMj62/vRDHSwuLzZ5hNOnfOmNkHW2ikEWQJfaIG+4Bcfz+w91beFAPM8wMh2z0KLR9xB/Tb3fRvK0nfdhPEr/EDSU78i40AL5TpecPoF2hAvgS6vRvqcJTSp8xfSU28QZYyoYNm99gFUNzw5ok1+BHJodFY5FyoG+gV1GnKN6iNx8QjbCDc5a3K+xVixrsgI69V7bkhXZNnctI6jHrc98LNKBJMqxmYnj1eztwtRrhQ8GhdBsijltjuU7H21E6/MELWMePpP8Hywd3vZW2DCtPWj6QEyVp13uC7yPlhHXG7h8QQTxbnJjIk/UcL/QGyDOVwTU2N+0zdlcvyYFjUPjDYJqPYCgUQ71YKKt/1P+YqbTPFifSdRbTDYPHLg4wdOSByZs1KHrhHb/ltuqc19rPGxUSt/n/+YTf7rJrI3odxYCCqM6NhQhRBfbRWyVQ9f3hN5mgmkg2KjyiOJxoflPoXbBo0R17wknze7dLTG+OxGHlmu2oWCXH8vBkYCYfp2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lftEaMLRTLYHtMkuIt9Kn/UFimuow8wwHwRO9CTYxztP8mgeGek0M7Gzr8M5?=
 =?us-ascii?Q?lWa9TCBnfOLyK89TN4aDAIPulOZ0IObfYUaDRfXWTLuzCiBiXa75bElR8Ws1?=
 =?us-ascii?Q?lBiY9lDJLHXS8mV8u7+I7Qg4HXhJHuH6qEsVjRehmMf0BTtQrEZNKgg82MVt?=
 =?us-ascii?Q?EePgtzME/lTuawpdDUGsut0Xhm22e1x7/2kcmnhMEIyCOHoTgEydtGnA3f0k?=
 =?us-ascii?Q?ly1ZnMdB0/fH7h1ZmoikxWfVl2tzbAHpwOdKYpkG0KtAX2U9nhCOuTyOg4kH?=
 =?us-ascii?Q?30DWn61j6eSkvQfJMbrk8fKPDZUZjDGm6aeVzH7l90F+8rp4NRGLC74m8i9U?=
 =?us-ascii?Q?1GLK7CZWyP6+w1NWpYacy+w04nZ07r2nmfTKOYVOJM6Fvdy78OhyOmP6nNaz?=
 =?us-ascii?Q?l10v3tqGHu+XCgc+sgnKAEvJgL4bmwbxhnQq0t071+ZchqEIqWOSYWA+M8kU?=
 =?us-ascii?Q?yn4Jx0AE2IBjnAG4w4RRHndPQfe7ASjJba+0NDYzOVgUmrfOCEzBsKDFV9fm?=
 =?us-ascii?Q?M7cCYyo/Jj6MAfdfguRdAWM59DK/pb4Bk7hByhfAf1N6gmKP5S2tNHeXFtyV?=
 =?us-ascii?Q?2Q9jjxYKzLtJFGhFdMKfAYT1g996avdSjG7CvGfMa3ahLK5wExgeK5BVfOJ2?=
 =?us-ascii?Q?tukqXcLgV3etPlELls7q/bmjgmBmncZi2rFPsTZ4GW9hHYDklJj8EhrWVB0I?=
 =?us-ascii?Q?Z4+qMXyRaMOGQ0DA8sPMy538+oCQG3IqDjgomntB0h5V5dTaGoWVa56bIWEJ?=
 =?us-ascii?Q?GGgvpqA8YvuxSXV0xMLKXo8BRE9B+QZN47c4GBy78IR0rDnu9PcSyw9HymzG?=
 =?us-ascii?Q?NopxRgKP9/e3dU45ynDMrt9u4hz/4t7tOrp7rIMF0tzs3NPYa2WxI7FI1qug?=
 =?us-ascii?Q?TO9fiCqb/yUxljD5EHJZMBibdEycJ9xrKfUGPs13YY6Sxj9FmujVI/hadU2I?=
 =?us-ascii?Q?xPZr24V5kwnAqc1M0WVO27CWAvEhN1x3VaDoVm6Xl7cpKd1PnDvhGQw6bysM?=
 =?us-ascii?Q?95PijGIKotmOW+EW6KGLJTx8s/Iv3KPeXzzVCQ64T33igaduABUCC3qwWDPM?=
 =?us-ascii?Q?6m9AcuNrT7SkUvFv7tT0jZpMALwrUm01Iy3JL2NoqNOYs6TaL+RpJNVuGUPy?=
 =?us-ascii?Q?Q/1aHfptHEVVwSNEiJ8HGptZffT/g3NU9VNQvRgOnK0E8MM7qdHFxUHuYqve?=
 =?us-ascii?Q?crIlA+310qeSqIHn5QfkegYhI9UEH/ckMwUU1fp4V2ueXceGK2q3IaV5gUkQ?=
 =?us-ascii?Q?U3P59y1LkD9ZiewJYTfnjq/8iuHTn5zSd/fEyvw5vvQ4Ql75M20Ywz9kdgFs?=
 =?us-ascii?Q?Tq55IZCAOGh23ZDpyUEmH1OB/dZlrNAlQaWEOWbgmzjgXfygKOwKKJ54QKF1?=
 =?us-ascii?Q?dM4Bi7LjXN6yuGK53ugP5ipWdvjzmhG7WBa729jwnkfKp/Q/nVC6On7yBYeG?=
 =?us-ascii?Q?cOYKRVdCPp7vq+q2wrrOIqN/u4Rtc/iZQKk4cBswjpAM/bsTTkzRBBgpeyvA?=
 =?us-ascii?Q?Xj3NYSefXE94ahH3AYS62sO8FUqdb+CUeda3WqEOQ4NqqLl4sL9zGO8kjc5m?=
 =?us-ascii?Q?rccApBe0ah6UGLZo+qAJBqXbmM0ZS5bcvgUr2ZTE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680fdf6-4f77-4d61-16ad-08db1f6d16cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khf+QDvErM7qY43GstWSbyDsaK6j4vF4u/HLjTWtPtySi0CWQiaevtIZGSTi1bTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 20 +++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d6d5c2fcc33889..ddde14d6d1352c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -293,21 +293,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
 		return -EINVAL;
 
-	/*
-	 * Try to upgrade the domain we have, it is an iommu driver bug to
-	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-	 * enforce_cache_coherency when there are no devices attached to the
-	 * domain.
-	 */
-	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-		if (hwpt->domain->ops->enforce_cache_coherency)
-			hwpt->enforce_cache_coherency =
-				hwpt->domain->ops->enforce_cache_coherency(
-					hwpt->domain);
-		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&idev->igroup->device_list));
-			return -EINVAL;
-		}
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return rc;
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 566eba0cd9b917..2584f9038b29a2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->enforce_cache_coherency)
+		return 0;
+
+	if (hwpt->domain->ops->enforce_cache_coherency)
+		hwpt->enforce_cache_coherency =
+			hwpt->domain->ops->enforce_cache_coherency(
+				hwpt->domain);
+	if (!hwpt->enforce_cache_coherency)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/*
+	 * Set the coherency mode before we do iopt_table_add_domain() as some
+	 * iommus have a per-PTE bit that controls it and need to decide before
+	 * doing any maps. It is an iommu driver bug to report
+	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
+	 * a new domain.
+	 */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (WARN_ON(rc))
+			goto out_abort;
+	}
+
 	mutex_lock(&idev->igroup->lock);
 
 	/*
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8bf053f4d4a9ce..471a3fdff1e0b6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.39.2

