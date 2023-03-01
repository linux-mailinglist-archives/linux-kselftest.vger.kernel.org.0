Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745BB6A7445
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCATag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCATaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95275FCC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtA71LIEA9JI3JmC1Ah1PeRZCg8G2QuJehuWkTqMCixCxmr1B96UX27gjRkbPD6CFr6hPPr2yY2DvYXkHziFaioD8WeB7NHpTBS++jltEmbzH7z9THVBovcML3kSQJDnRLHcl5chX/ZPIeLGrUurFeQiKRLqReQeZthydHwpb58QoRYDYeuO2csHaHn8tn4zAINSR2x2wEmVaSMsgEkY8HMr73PvJRWHxb1rs4XXrByRSf1vU4xrPG1Oc4JmNb9KvoyMcqmx+CJBwmkvoDgPkBtIA11He0p27voGubCxiHsyps9xJux0sWZBPStXW4y0LYkBt4HA2Vluw6EgP/MIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QubGYVFKToRpOqo23e7c6OHX38arz2HH1JaQG3zIZ4=;
 b=UW5i/RuvNaWIyjxra7NYCTcQ9lpvgpEjUDR1sAc+q/pqQrjI04ej4fWCiVUdUNoPMDw8Rn9s1/c2vhLhQ4oe0IH4jxj2JSzSleR9hcBD7fHL/sNsHRciNVwo5OB0xHdpMiNTJdkFdhtshYtNI+zZiopJ4B5AvunUOgMtFeJ4JsjBC0GUjlTZYH0HeZjsR5sOzxgNi9qdTGFtTzRZK9gV7hQfYJtja8rRWKjgV3M4BR9XixeTLqwfJC/H9m5mgIGj3ZHvKNEAlsnt/0fR7TW37q8jNvKSwalmeNx1dJSE7PwoSSSgLO52Pp1zXgP2gwXKL1XXsJfWBoUbZIRs8jxBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QubGYVFKToRpOqo23e7c6OHX38arz2HH1JaQG3zIZ4=;
 b=PYlRBcXQLlCVvy2Kobfg6IuTQGaRb83FEXpLNtxWPFb/4YCsrDJhDR1vX37+YbByg1Mq/LJS5f3bqF6Et/J/qwr2X2YnCmWrJ5Qha8QeK0V9W8bwEafmqCetGXGX8QVHXrt1VMrjRzRsFzqnV8YD9l7CnQwgwU9X3Mq1u49BsHO2wYoSGq+E+XNlNnNwZeV8kZIdS3cXsofp1uWbxWDyhFRdhggdlBJPvbjd0u2HwqVnZnDMBgm71z2JPrnQ+kzBWxNza/E7p7f3wjdqoZT9XW52DRZ1JP7eSnvC+6KzXSbqe5zOR7kFoQuT+x/ygTwpBsdqToA25Ecmi7rZIGZ9MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:32 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 04/12] iommufd: Move ioas related HWPT destruction into iommufd_hw_pagetable_destroy()
Date:   Wed,  1 Mar 2023 15:30:21 -0400
Message-Id: <4-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b94baf-04c3-44c2-9eae-08db1a8b6b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPwbdYtIMy5fLM8j6/BUTBHHQ4IR26OksW0qj+gWzIRsHVQjtUXNWhlNlQYv1fplgqusZ/AtsAES0w5b5TTFrUEyev49ODoSMau7kr6FstPxm5Sm7bWvFVjdy7vPacwLuw9UPBX1HA7p/BOy/wiBS35KeC+MO+Q6ZYttIdPIUNW5n16SI658svPR7TXNg7HEUfrEbOKNujC3q767BClAjfK2dy8V4pyPe3ruXvvruKVzaGNd1K2JqRA4TNavWDGXzPTRw6Ez3ZXD8zYVfR5WPN1mk22ZHhouf8/rZtuStDm5lQ4Jm8x7HrbMOLP1npKro4czYS6A/L0vo8OEHtPxOirhr0x9z06W0QfLXIgDEJAllRXfiVa0RVwUIU5uPVV4dBplrISZJwVVbBdCugHnTIdvnjvhi4K4SVq4S6KThXBL3wR31nAIvUquNHEd8lH/7kfGpIqiBZ3dXCL/9DMd3tp+aSphN1i+fTXc2IOg6gu17J7WM/tciu0nwTUFnAAS2nv209Q4S12nx5lYlr/RrS4dwlaCQR5A3hDbH6M3Q17QagGlZFj9c0t+4Zct0yg1ybgjNtRItQfr0THh8izMHtUanxNyP5JPVIFFpzSkpgsv5s1xohvsyYPZhJB7zYRPjmfX3+kaqIjUVat4mYDx7tuC+jVwhfsZO0HJwMG2CMe6IPi9yRuYMXEFli5O7Mpv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yXc4wwl7QCuSKd8UfC6zU37WFwk+vFaQuwcwVRletgZKYU2cLFVzw6LMCzN?=
 =?us-ascii?Q?JN64eMIO6UDcxeG8d8s+R1RRNx9+F/6UFSu7ahJUWvbvBAmc8napKKZ+s2me?=
 =?us-ascii?Q?+B/0GxhNgd/LiUResG9P+n2y/Rc8crdkdXw6nn+kxTmhsNUQ0aMnc9DXdXX9?=
 =?us-ascii?Q?ABynZsqcyaRAqRGylCOlQkEXMYujatDm/KIdqlrGDHxs7G5B47YKcEFmCQta?=
 =?us-ascii?Q?+lhnS3rjbwPVyDI9nU7gzsfSW6cK26Rbn2hP6op5gV419nG8EAwdnNR8T91M?=
 =?us-ascii?Q?xYufPT9HY/vttWZhBTkIGxTzi9aANku74wu+pw6iOolta4TpR/TvVgeZTZVq?=
 =?us-ascii?Q?zlTvakcy/qUnnl+yhSocCQbfm//hsNw2rnLR5IgRnr+HmGu82f3CcoliWNb5?=
 =?us-ascii?Q?fWElmeEK/KPASQzge+VM1pZH/iqo1lzArEEKWpDYLDBYBXqFc5U9zgNAggqb?=
 =?us-ascii?Q?PeFnF+RXaEbr/lOwecgPPa8S05ZBu8NMpfQqDr06YtXPPNCn6blrcyaJWi+u?=
 =?us-ascii?Q?96XqgVsIe4sT7rj2LwZCPYr8CFoywzMZ0MEN1AEivPpgMz7b3+VsLLJdw+XA?=
 =?us-ascii?Q?QQp9skVWV3EzvOUtrvodRDR7EhCzkPBF0fMNvkErFhEtCh5oydrVy7thFR46?=
 =?us-ascii?Q?Rk8TgM/5Oq0XN3/Ntrplxg5YppNrVRNhNSqeMAa1oXadNycyvPbNO2g5gHfQ?=
 =?us-ascii?Q?YaWoPBzCxldfcD1Ee0xJ1cgNsMGJUq+WCT2PLv9vxE31nhULB19mn6xupuwR?=
 =?us-ascii?Q?eGTfm8WZ63v3yvP/zH5Y1VHu8J19DmJix3BJvY9J6jqpWfrcbUdIT+KU9yPi?=
 =?us-ascii?Q?QJtyXmFLKYNegU27X3dT9bthyVC15kENptaOlR/DwKrB396oy9/MLU2l65XF?=
 =?us-ascii?Q?4DyozQlWWCmiotzOCwSnzbhPvtEJg3IiCqV72GhYhgbl9fRH2IUkpogz8t7F?=
 =?us-ascii?Q?PAFXwdqhLniAZDgf53DgtDYnXDbh65yukrW5SYIVxad0SD2EvrZsmaxL42f+?=
 =?us-ascii?Q?l8N4vwt0JycCkL+CBmUCGIlgS4z8FkGRxSXh+I3ybhrBMxFNi5ZPetlwXJn4?=
 =?us-ascii?Q?MQZCDNm5swtBxJMfJcd7yiCZdFDVhmNU+suaYN38QKsVcuP6FYIdmpJH9fTH?=
 =?us-ascii?Q?AAg38OKKN9zi5Gls7ZGjq5QjwITrjSH7X9Z4pmsomVAwookVlqU5AbR+I83g?=
 =?us-ascii?Q?Dqg2IymLw1lqcGn0ME9xOMmWo5vSrrqMZVts43JUT8Sm0XW9DdqkEgEqfFLm?=
 =?us-ascii?Q?uqmR15pXgKMW/OgZf3K8jt9IPvgXFd64U1oAnfENdmBmakfhL7rTt7JWQVM5?=
 =?us-ascii?Q?2+N4tlBBtHUZtMyjqmp4l68SbhHZQ+G+2zY+L2pVrEPae0U5swM47sMqfmwA?=
 =?us-ascii?Q?9GbKpiJQUgtGJGVP0WiDrv1T3XBxRKaziqad8NCEt9R/IcDD1XFHZfw+w6EO?=
 =?us-ascii?Q?3y+ImAkQmv3jMtQUdgMphpJ2tX4bYxnhmMWRSILRQjQPX4WnSOKRC9tfP83E?=
 =?us-ascii?Q?zfvd2MV/nj7FNWi0p2wfkLgmorK2XBXcb41hLZribcXj5towp1iRKWo0Bq5D?=
 =?us-ascii?Q?a+E9qH5Wtcsbs8CJQGzqdxqhi50shhSn3+1zQk7J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b94baf-04c3-44c2-9eae-08db1a8b6b8e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:31.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84OdcWa4SrjRDHbL4ZjdIXjBQkdGuc1ydSQEZisCtvuAprIglw46z0oUxcA0UmCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A HWPT is permanently associated with an IOAS when it is created, remove
the strange situation where a refcount != 0 HWPT can have been
disconnected from the IOAS by putting all the IOAS related destruction in
the object destroy function.

Initializing a HWPT is two stages, we have to allocate it, attach it to a
device and then populate the domain. Once the domain is populated it is
fully linked to the IOAS.

Arrange things so that all the error unwinds flow through the
iommufd_hw_pagetable_destroy() and allow it to handle all cases.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c       | 17 ++---------------
 drivers/iommu/iommufd/hw_pagetable.c | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index adb73539b39c0c..6787a0d8d6e9f0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -386,28 +386,19 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
 
-	mutex_lock(&hwpt->ioas->mutex);
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
 		iommu_detach_group(hwpt->domain, idev->group);
-	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	idev->hwpt = NULL;
 	mutex_unlock(&hwpt->devices_lock);
-	mutex_unlock(&hwpt->ioas->mutex);
 
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
 	else
 		refcount_dec(&hwpt->obj.users);
 
-	idev->hwpt = NULL;
-
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
@@ -769,10 +760,6 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt)
 {
-	mutex_lock(&hwpt->ioas->mutex);
-	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
-	list_del(&hwpt->hwpt_item);
-	mutex_unlock(&hwpt->ioas->mutex);
 	refcount_dec(&hwpt->obj.users);
 }
 #endif
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a0667..10db1359c067c1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -13,7 +13,17 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 
 	WARN_ON(!list_empty(&hwpt->devices));
 
-	iommu_domain_free(hwpt->domain);
+	if (!list_empty(&hwpt->hwpt_item)) {
+		mutex_lock(&hwpt->ioas->mutex);
+		list_del(&hwpt->hwpt_item);
+		mutex_unlock(&hwpt->ioas->mutex);
+
+		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	}
+
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
 }
@@ -37,21 +47,22 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	hwpt->domain = iommu_domain_alloc(dev->bus);
-	if (!hwpt->domain) {
-		rc = -ENOMEM;
-		goto out_abort;
-	}
-
 	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	mutex_init(&hwpt->devices_lock);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+
+	hwpt->domain = iommu_domain_alloc(dev->bus);
+	if (!hwpt->domain) {
+		rc = -ENOMEM;
+		goto out_abort;
+	}
+
 	return hwpt;
 
 out_abort:
-	iommufd_object_abort(ictx, &hwpt->obj);
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
-- 
2.39.2

