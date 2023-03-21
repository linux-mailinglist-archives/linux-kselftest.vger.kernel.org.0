Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266386C3A29
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCUTQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCUTQC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012362529A;
        Tue, 21 Mar 2023 12:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkR3jtlqVJ+pV908QoGBggBKVXN6z80WTtFmwYRMH5o9xQRl27hkka1oT72Qe538e4F26dZgVlXuBDFvS4iU7Y/dEsu42dTWdDKHjyV+hRalLGxs1m0mM4lqhEo6ZIsGR2Bt7/lpNEkcqBLTsnv9WRjnbv1mnKn40m0xnTCD6gHaEl4iLy/FAl36vUAMqImY+01jIZtn7EPcWJWMkm3N2DgOkfHa1S9437tee6NBRUdz1/fjxwmvL5ysHEyk2j3WvfWtTAqhXp0PiUvzRKeCOObGVD98/TVwLyNGh5y+P2ZzPuS+AkAyI7pgtKXgX4w2sVUws2SjgzCBx0vUVxH05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXkcyl5CslmbavBNzi7v41WIUEhVznkI0nxjbVIZY9A=;
 b=CKZDZNGEIZYmgsO7aY/qX4R1neQcUySpFper1xR8VOxwVVtE9KGpBleC77wjLBMe0OOT0Ompk2tGfCxZ59Kc41cu+9hBWECn+PqMmz1UOcZcg++KMqqoe6lhKMaxaIdPEKZUuVpeBff9R9KxuFh9qD7QVvyYeqev+/FfGHIuxDtWmKRMfhz/WzRSRafOvwBxcOkmbRBq5OoDXJdxk/Q8WTY2MRXtRCtCnj0R+MJF46BXiV2ns/0QKlguTseh8ld6EtHWOIQVwsFl8SkKLaZMeSfJgd3/J+rqt7rCjdNAqLOdQi+jEYdkTmlq6bA+C37zAmq0sdB+0895MjX4TYqdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXkcyl5CslmbavBNzi7v41WIUEhVznkI0nxjbVIZY9A=;
 b=YIpOk8NUsRwuQtJJdz1NfKAkcCtsLVCKhjdr+D5BaXkXVzw31xEex+2drvlX25hvJHoIYllQmXMupnzUFUxtD2USX2ZpdbYRLehPibgTU2+SpXRGKdw+jRb4wxx0ySMYI/LN2zMPlzCKb0/HUaLFkjVkvZYUhR++KefIeinnL5be3jYw5fVKnD8lvwpsSrJkuK+KD7WmZRoAijt8DwQKosWZOVY0SbCukJSzm3YENyULK9PvjsdvjW6AvjBH6gvudBEyDi9Nr62fVqpz9mZFLRDI9mAHYw/8RbCGV+awr7bhKxwxbBZWsMRgSzRygx7ObrcesKfo0nAHqH6AZlen+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:54 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 09/17] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Tue, 21 Mar 2023 16:14:43 -0300
Message-Id: <9-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 094f0f78-7af9-4ca1-1980-08db2a408d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5AzphswxOwaiTOtfXCfy7kWt9tgdYbbxycjTOLWrpdi2seKHlV3OZjcSg+Eu7q6Fxtjk8ntPkunqiiZk88oqApNJMlbRTbvxR1hIPo10wk8Lgfem7nG2j/ADj2gsXW4oBofLLu1a164ujqzmgypEFFSaIrLfq4UbSKLoSck5kL8bnlB5cC7S9JZo/bi18tiv8lEaImocq44zXDWU+AbOr870EF3zALCGfNHMEfLkhcXya12HqknRxYNJ5JFkjJCKClT4klciVEIYLK0LpRmuwULXalwht1GUu0OadnnQCiwKYui2SQQJk5GD08EHFH1e43PX8v3wCVdT3rfxv0oY1QHcRNh+bo0CCaJz1BgbAUgbVdBO6ilpc/2tIV4sCTJLBKIsYnpueuIGabLvRyPK2rOYajI8xPdXvHv+L9w7Xs6efEA8g+HyoQCHuhena4MKGco9EzA+xmh4KwRLvN+3G40MWuR9qey8HeDPqaWhXMILu7dIpuXo35uLnflMvqvJYcplxo2sq04MtQs04rEB/Wl90QkUcumsps87a1JnjxFgxYHp2UK68kZThIWNUjZDkB4CvHPVZ0204yqREFFhwxGSMBYWTSkOml3Jk80i55sQW26LnKQakau/iYnU9yDLAyDUkRJMkHQXy5Y/XbZyBJ5lXZ51Gc9UhOhjCwHnN5dXwmwQ6sfBp0ZZU40G/W/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nC1/3usuQS4J0CH0884FI4FsKALnN3LxOHjjJ4Qy0b3TwGQvicWGvf2OzCpU?=
 =?us-ascii?Q?ixhUYgNEP+X65SQDlQTbtT1wAbvB1omgkCvgvWOpYciGJie2vB536lfXvxxI?=
 =?us-ascii?Q?T9K9CILtHfaydaQJzsxNgOC5wf7phPJaJ6PYPi1PLLUd23YiEnBs3nIzjO9M?=
 =?us-ascii?Q?88nnMpTFem8EdplxvAyd8FvFIvfBQ1BcjDevqT1L3+hyXLcTJFXDaIdnEPeV?=
 =?us-ascii?Q?SrK2gB1HQeF6xawGXh/4WeYcOqU7Os2LXLWUuIxNT/tghuW9nDLkLj5YwV2F?=
 =?us-ascii?Q?ULoPNihhjA4mrrMrWfvGE5rWv7b5N4RLUEPy9y2xRypK1C5VMd/UhSphN4Bm?=
 =?us-ascii?Q?R2gg53seXNlVuNI55/9xfNC9/dMyCaKg0ERBgP949Y05YQnvVF7q37pUYjLX?=
 =?us-ascii?Q?kHTktJtq5kx9eQcPg1KfNW5NHpqA6TRwje1ix5UrY7GGdviJUnqFtERw4WcI?=
 =?us-ascii?Q?ADFD4o75bRuALVZxv0pmKphm0JL0W0dJADewG32QjudZVc0g787jojYLB3qN?=
 =?us-ascii?Q?hbFYdsTuMm8n1NiVU/Vx/ARZQ/zs9CR0wX7LKZCFBWWAwyDwTkaI5bl5hdTT?=
 =?us-ascii?Q?21U/MeevXCNz7Vyygr1cHpy0hQqBcfn4OmuI/8tlc6Zh4H+J/pwejyKnYbrv?=
 =?us-ascii?Q?7cR1ON3uUGgpFuyJ3KyQ6Ku/ycxTmbyzRwsUxSUc7q2eF0wyDc+Wv4xqyY28?=
 =?us-ascii?Q?2OBtKEks+Rq7bCCGupTanMWIPAgesQAmXNfhxHztjyMpIJjGM6bjg6hWRJg2?=
 =?us-ascii?Q?bMpjHYFfNxUxXaW472J2VmArqUPKQrnkTZgfQU/z1EyBldmvlp6crdKrUDux?=
 =?us-ascii?Q?diCNndKJI8oeCux4ZAajcBir7/67iep30BxPJ0FsuSdrvyiUeGDEe17Jh1iW?=
 =?us-ascii?Q?OYknXz5F/Ve1ySLpbMr3IAvhWyP2oCuLppObFnw/fBjHRNaDtUmdOLrxVkJI?=
 =?us-ascii?Q?iDKg2ZmqFBC+hFUXJxb5ob4XzOLySHugvQRgOY/CGmVLFpuzjyWCpeE5RjRh?=
 =?us-ascii?Q?xBbr4FuHXZD5EFVxknR4IM2f+1z/wyFfXtDGMX22bQebeyUp3YbluNPArzQv?=
 =?us-ascii?Q?NTZGsYEyJPV+aTfpqkgZlx9Qq2+JW7j2MiLZv2wTOzAeiHQ6gXElmX5at3P/?=
 =?us-ascii?Q?fPUFq/x0x67StZ3gdF2eGp9AdFa7k3pE5fvz2EYHrwF7i0PPtcD6HHy/dPrP?=
 =?us-ascii?Q?KVNSBj05RDM5OTf4GAYjSelLpSVX0BtWYXc9COIy+LgEXr3AMIZKc4gv/DOc?=
 =?us-ascii?Q?AK1EuvnsqSo19nXGhqQe3VmTmPiNpOA2zg2BbLHo6Gi3EGVKG5ewFIyVm9K9?=
 =?us-ascii?Q?KLKvxlGOrUy4e1BpKcCQ3QKpMbjpVz0RoMWDi5wSyJSkQBUQmflpvhN8fxuq?=
 =?us-ascii?Q?6/rTpWnEljZDUKlUVolLeSVt1MUeFJbR046bfGVn27k7WnpZIWQg2Ch/g46D?=
 =?us-ascii?Q?cz9Cd2S/4qmU3XtYFOmxqBK5lp6Izy9DBT1oEmTECJ8N7KG9tZEHxxx3tHvV?=
 =?us-ascii?Q?bWdn4ywpWBxfG0xxEIs1MGBjNFdmojkzhtU4ZPKOBnicVcYoer9PWyBgH04W?=
 =?us-ascii?Q?kTkzx7nz+ArtjpK7vmgdbrrZrSSbQLMar4GuNYq4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094f0f78-7af9-4ca1-1980-08db2a408d13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:53.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i94SYfXr2hWVD0Kual0d7IYpaH4AzAB5XjO66Q+YRvhgpsXUqv5JyuwFnHLFI59b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 20 +++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8946de73660ece..ea01718f46ccb1 100644
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
2.40.0

