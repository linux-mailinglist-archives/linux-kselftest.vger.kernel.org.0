Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93D756B6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGQSNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjGQSNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDC19AB;
        Mon, 17 Jul 2023 11:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcewdVyatxhh0/MxUzOXvdkwQmaeyyDDCaEnQkHJHrca09s3QaVQxeS4xZSx9sPUaSK/XiMFM2phtqWG4PQJZTsS1JOiSeaPdPIj7hrRgeJJ9TPr9rNq7uw20cvas8ny6at40wnZMMF28sdDCvb/uyD9Ast9s9/Cq0+IUQbDSfZbuTKbbD6V1KO8qLUc6aXcSJa6MzsPptoecRphQgzlbTugZ4sTGL8QTBgbP3dJrxSjxDeUpFvCg5I9jhRuc554oz8ofYfTl3/Xo/PkGLvs6jfumc0wYAjVb3LCqlVHjCvZfnAF3Hb7d3sXCR/SZku51Oix3yuPAKzuIkleYYDy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59+UqnDsP73Vw9a2e/KkthiRq/RcFwX1H/JPPbAUIwo=;
 b=kKlq+TNDqQ7AZ6oDkBH8zzXBv7zPE4pHW/wBj6+xEuw/IZWFgd4//1lFXsQ5aamZA4vg19N/r88oAQZA5J/Z5mtSUZspquryOI1Dx3n6LkUI1gIrM/rtXdomyUBzUrd/vLKi7KE0B8FFFRKrCFKLsLBOa40owAjV89Q0MMNA/5i8izKVEr35awKXLs+WX5rPjzXM0XGF4Gb+0nKH9jlulFhDQkRptYtj/eRt3vQu6StcIw28chMK4SzgmVYCL97z9V0neJFR2zF5g80EJ5q/H0TdUze7S0bppjoP5QtgfrUyxr/8hu0yEKLpl4CJd1lVqZm76eaagb9pkdIk9fqdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59+UqnDsP73Vw9a2e/KkthiRq/RcFwX1H/JPPbAUIwo=;
 b=R2k19A7h58GKY0CSUC3VkdMG+jjllwLAZ+zPfh2fOu+hdgFIBLLBJ8MR+wW5DS8Ou1Fs6GuhEhUCJ0zCEWfPZNdRuw0wwhnin5VW2WkDsV4Lo1KrJ7Kud9no9811+pjOmpmbvBtjjzS7ZVXmYsHIaUdP6fHrmxFPyexDNX2u3UDGVKVrenduoKVKgGWUW5gqmPE/Tbi/iMXWadcjh2K81lIDx4hRKeHI9RNmuW5OuDC1jkdisr1qQQqO52+Ehzkxw3a+GHx/fX2z2ofO57X4ItWPAUudrMg1gMNe2hFFcMk/MhH7LHaOqdPM7hMFtWHkRIc405r3aCU66x98qh2AYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:12:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 09/19] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Mon, 17 Jul 2023 15:12:05 -0300
Message-ID: <9-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: a494935f-6218-4110-ee86-08db86f15ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcvE2C92i/rssYJQOf57k4ssKqcV2uxQK3rW1hh9zrmEge8rVrCnuEV77yLdS1RldNLsNEtTk27WQwJj7PCoUv/0W/fbLvkeOoYpRFJJTCV3Ms3B67azvIbYHPcT04po9Pr+KR7R/qZeI1z8t1bmjz2HqqxjfQI8h/vG1QlywYsGsgLhBNAhy5ApQZFdwr5MPgKP4Gg6ETvt2hS67SXEeQ4RVmdBMFTnnPhBJDCSfTeGuXciU+Vqq+aFIiOokwS8u2nl8tCyft+m7Ud+c3Gwhy7vqfBFW85LguAFCEbPNygHYRbuXvY6V7xm72KnXnyTDIRuWItVPEHs+WZzGWvquqPmCq8+3A2HTk4LuQCQQzxBSLDQJ5y9v+WjdsKLon4x5vza+BDsZ4GCL9vhvKFVaS3t4JXcht8YQSW6qs3KCTj6HC0xN9C8YSxVQc3PFMNLGvwIOHs3L9RsjVNnYmvbvboJEyv/WpK8M1ncoeZRdA1LSHLbam98pDsQdn6Y0erkkvq4oy75lkfB/u6/3A+nRhFmhRPhf0k0lj3SVZV1adbz6EQuX0NUFIxlQXFa43/H84bHgFB7dkb/6cPmeMteIaTndsXEyaDyks2d/SAjpsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(316002)(41300700001)(83380400001)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(5660300002)(8676002)(8936002)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMANlwnrlFYu/ppDe5TrVPlxDFmiuPTQzHUq3yMEhIkmyqzXkPfeJCF6LB+A?=
 =?us-ascii?Q?z5Z7pzJEl8H7sKYsRSdFUOSe43Tk6ET+vTf/vms6JLJNd6wfTRJOvYj1jRGM?=
 =?us-ascii?Q?v2hvD9CsepwXRHFiEi516pbt99A4l905TOLe83IgXbFVtG5kOMpdktsO/iTi?=
 =?us-ascii?Q?Tau8b0qNbGes0fwxYx1VbO7Bcc/+PuK2wBnywtrvyeJA1rgFEdrhAsnIgeXE?=
 =?us-ascii?Q?UVymjwNAPlUTdOpQ54nprALvlfMGxqc40atilgOOAaZiPMHaWawsdurCASrl?=
 =?us-ascii?Q?+phT/pdGwJGqrgq7w9E5wm2n+plZ31j+RWukALca2n36gHJFKmx7yzkP4GvU?=
 =?us-ascii?Q?vujv4wwvVwjQBpnckN8AD/p8YoaSxOf96j1BmIgBA6B+l3jZhf1/t+J6dfU4?=
 =?us-ascii?Q?BDANAa041xbpZ2PYwzbMkDODdIYf3WWLO5/FE1nosPPA4XXZ1dF0/joOucgy?=
 =?us-ascii?Q?6kO1j3Tv7eV6CzDT3CwFmXlXkOfdJuU5SITWh7+vZ4HQr3YzsQp2S0bW80+J?=
 =?us-ascii?Q?8ejCb4RJmRcQEK0wEKVdUR7zcHbb+VHfnFrqBuehUG4ykYMSDEt/hOyl+213?=
 =?us-ascii?Q?FYTQNR6DCs5qcKeFRL7SwEY59cCvchn2FVolDRqCupNf68NrcuDWZbfCLsye?=
 =?us-ascii?Q?pB6s+DAD0bylg8OQdCTsQLs7G5iv1Fl3Br1wjMtosx0R3FXxR6drqkkD4ywM?=
 =?us-ascii?Q?EQ9FD1eXx6K+FaVvzVS/GHn4Ezwkca5sGtLlMv68fAIfh8F2aXQaAcj6ZiwF?=
 =?us-ascii?Q?9JeOGJNuQo3MsCSLBV4X+feZ8tDFBJL1s62h1Omn8THosNJ7L5kg0HVU+6NM?=
 =?us-ascii?Q?phAZ/xGGdywtpKyJuu5uAcldngo6w4y1l1A4g2qAwJSGl6vecaISS0ohWa3U?=
 =?us-ascii?Q?tuYGIuDN79EwiSqM7g78e1wanJ5ESWw5jQdfqjWjGc+BHbxiDDXJA5BbmAGp?=
 =?us-ascii?Q?inXVP3iLFQ2zEvuglWsRqelO7qY1T9WVxRxbCD/imcMca3p4zP/XNQ9Z6h3N?=
 =?us-ascii?Q?vVaGgaWcxrAT0BkpVMf3kkFP+96xo5kOOIbO4PLeuJeEl+R1JpNo5tHkV64o?=
 =?us-ascii?Q?KUqS56+n0M6Tp4SbJS1VwK3XKn03cFxPCoBg5meneAOwCgtRI0oFCXki2wMY?=
 =?us-ascii?Q?4YLNgjNfmV6uQDIdsIDenCuI8by+dRw5Je/s9ErMNYH90Uv3OxceSbIEmhgU?=
 =?us-ascii?Q?eyx4HHZfou8IPC4cqFhQOhhdrS1joJ8vVi9y7QQrutfokRgZAyW9ORVqHPjr?=
 =?us-ascii?Q?yS0G9BG3+syxFrf6raxcIefxnozf349Jq8nSLeGAvsEMR/aOqZGUZDYU3Ogg?=
 =?us-ascii?Q?R6BcIC9aHGhYU14tT91AuLMEAGFVeaee3Xwaz2Ls74hRCp2aT2v1FeV0ILK0?=
 =?us-ascii?Q?rRx0yj0EPiTyUqqO5v4QXOzB9EdVzms4nLFj1xP4/A72qprJI2tYXoNiVDGj?=
 =?us-ascii?Q?3vK7oNd2lGWHnVTleeDRv8jKXRdmdLSEBwewm8eRHTPwSP0zjeA1E0oQe3vQ?=
 =?us-ascii?Q?5WMZKGR/b1xu7qGlAinTg9OJLt+yBoBAH7GSivAIIz16BCGvA3eU9OoU+FVG?=
 =?us-ascii?Q?sdKtjzWB0nnOU7KjVI2Afc4dzEuEfY/R2HbdVCPd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a494935f-6218-4110-ee86-08db86f15ceb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:20.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqmKHdgi9OYjmcFk5qQSRo48s/9+K0haagRJi6W6ebzMpxaeAgDfuD7wlhuLA2Qo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 19 ++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7db5df11ad9be3..d41e34d1b778dd 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -295,22 +295,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
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
-			rc = -EINVAL;
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
 			goto err_unlock;
-		}
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bdb76cdb1dc347..e0699d7f4c64af 100644
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
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 63b2587a37f23d..5ce9eaf5fb88e3 100644
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
2.41.0

