Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5F6A744A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCATaj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCATai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A172B4
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8k23N+B+MCVmM9T3qNocVnxb2SC4897Z1suHYA8q4dJ1CF8N6G4phecbX5E3H/bcLzclLj78j+/nkSOY77BFg6+rYl2Tveb5WKWlZ+LbuIEO4xEEsMqFzbNZ7BBuFuv9QvQWr+6auds8DwYjPIp+KosJLLdXcfcNULA4rR82VFOOu7qSNXAaHgF1FZ2NE+tXVzEhQaQzE2/iQ7J/qqNRZTJ25J7OZY286RiBJsPN16ASN0vBeJo9EGMihB6K0oKRXt/o6LvDtAux+cRYSz7Fx+JREDf912gkzGixNM3Ft4Fonvlm39iI6/TIMtgXyX5NGNWlIHFdoK4tfFdm51mXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TiEY2h4OTbLT6U40o0056k/YqqESe64u5Isx6Cn9dk=;
 b=f6IYTOmx928p4dEW1fTqgK24po+YojSHz10oOkuQQBCmfy0yCHtuS/6nXuUXldSe5DVESDo9pCGPRazDDInrBXmFtl+Jw6X3lUKK9Dasl4beyw8BRwE2J+LbzPzV427pIgEB+5PV7JPADS+uqYSEGHS0uv34QIGzUucfxWYwdO75Imi8qKIk9pnidLksQBokX9+vxUa22Brbn660QHbAFiWg9mUQibyo2IMk2/41yLCrZ1Xo8jbu9sjD56T+mU/P80SrXGPlsjdxt3xtc9vq0F4WzR1HaZg9MRkEJ4wb5UWR6HgalfVQCaADQr0qj12RHoKUrjPzdaLHJYv7LjQ4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TiEY2h4OTbLT6U40o0056k/YqqESe64u5Isx6Cn9dk=;
 b=IgtSIjrNtxMloJE1Ni6OZA0IXDUKUZ9gPl+p+VNwhTpumjWTMFmXM8qyvOCEDCl0xVdugzzG32GSKFLWYX7Gk9CSrAmhZxG8Hdb9OQIGVMXGcbuLjfkYBQkk4JU+2bxAkYGsQ38yZ//4RpgKL1uwk44QBlK6nw3mh6F2R4hHbh+Kf55r7xVGsHs4gk3cDEAGgsZHLwX3CcNZZFUF/LjLxZ94A37yfmlaHwi6KwAb+R4OFRVrU5VCNArUXGgSPbVShxQ5POhu6gwR74tAqKSnUwaJjqZh+Vwk+31C/eK8GdR9RNJ1lnxHvhCOLisVFwt8wJ0jPsNgxWhDD5M5e2duSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:33 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 11/12] iommufd/selftest: Make selftest create a more complete mock device
Date:   Wed,  1 Mar 2023 15:30:28 -0400
Message-Id: <11-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: dd21df5b-13e6-483f-8cd3-08db1a8b6b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gt7gStWSX2eBoGlLzgRvx87F8tNC6Ida047a7yRqDNYjscwfcPPdscaetYyZVeG5yOAcuNBl74Y5755LPBNeyL1yff8IgPlZCvI0GylxkHCIocLf4TUQwOQPeBVYPBjUsoPvlnggpq/hjm4tZH17NZgicv5L6R7xHbU9FQVYVb0YKm/YalWPwPXHY3Rbc/6PPriUgTQDHJqD9SnpYdx0IOIVNOLFapsXqShsWZBbMPeaUNNFnmJbqsRcjhTM7dxpcN5Gnv9NIyi/YzS1fbrI+V5zN+589kUKXT1TtPXB71hDvg67ueJtp1D4nddxzXkBaaVXxrf7TtP6nYcXm/S35rihyu2fASZ4HtnHeH902lwzDpKQPb0wyeUH5JWVgVF8IjHjdC0g64xqm4rNHjGc3husxlB0+t12ufxQpUW3rq+Lv2bun8AIrhzgEEEiXEl6V6fV/P0lVF+Zh++UMkU1ttI4qdDjeJ/hGLbAgX1k5zcH5t0D+6QrD8sbEFQVlJ0QhGCtcIfamr/h955ZwhRHvcVhQr8nErZ7rxRNvpiuRyQxaB3vj83mrSXdjLWfMLCARIYBc+ePQVS/HS4WGv/KN5CB78YqsMtKGMuFMJ7b6RTsDRnFKEdcFNT8ZUCv8rofB9nOvZep1qeQ/YLFOPWXkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(30864003)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SKA7IdPVa8JCsBe0hSZPo75XDrNk99iVNhLdUBPwmaMuF7K2MM0ErCP/IsAv?=
 =?us-ascii?Q?iScvz3NLIlUMG0qenFCRkWcisEESrSAykgVkBn+OQWrQRVEWiTWTpu/iztRh?=
 =?us-ascii?Q?VrcOOS4AU1hXK9AhUv4v1LM2i6oDuPEknkofG9yuSY5P5NdYwtcA7Zdcrwpu?=
 =?us-ascii?Q?5bnLYb2MN0jJmINerdT5NJLtV8D1CEZeYGhbLySoQJ1pN+7/20vjYjyHGOow?=
 =?us-ascii?Q?5gHE4pBkCaYW+KxK39jo3cuCw2OzM0jUgyfPWWxiWXEMIybAQD19dna2ApE9?=
 =?us-ascii?Q?JTvXLDDfZC2xVFFzfhF4yawP5MnIr4wbCn7sTH59IFAIze4TtV7U/kae9Rhc?=
 =?us-ascii?Q?Xf8cyJEnZGADq8kkdnPetDQzCYDmNzIWbagHcSOgX8FjmWWwjyJHcLJfbt/b?=
 =?us-ascii?Q?TNlFpWuLDmAIwLHj2cGYLgPkKfF6KFGqw5wCGxLk4npqSiXUnnk6r+OCGXgT?=
 =?us-ascii?Q?WJYYv1aA24I+8KhTxu4FuvkrVG7s1wjjkrvNmLfcYhz2NNxELpP4tgRsQlf+?=
 =?us-ascii?Q?zn2AMhPPKroBlKFYrs5ffsTfK3JsJz4WQpU3DznFhOGmt92+N+9kvKI2GBSd?=
 =?us-ascii?Q?cx7iEfH1yL1Z91t0D3fwtz2Ort1zCB64Qo6+ZEuELJl8r06DspvX6MxU333d?=
 =?us-ascii?Q?ULdfuYbgl+cmExqJy3dFTaLZ6JX4q5+ItZzjcv2Sf8b2oIRisQXZhzMUJWRS?=
 =?us-ascii?Q?f4CQOR3IglVpVKdoRchG/u2jiLCMRkiAF/N+bCOjGP93YQBCy7jrtZm8oaqa?=
 =?us-ascii?Q?0+/lltyhUfdgvd+rSiLUzGd+52H0+yhVYKlKMj8U+wIoIHdIUDH3tgJePbhe?=
 =?us-ascii?Q?9OXEZDN7NiaaS6IvKQuyI8imB9IN+nu3YEpoIkECnaAmF8uIkqEdVVdoP3PY?=
 =?us-ascii?Q?BXITgJFuoHwxqhx5XTlmBAE6tm8TkS3xnjGD568pi+yx2c96yD9LVtohy+vQ?=
 =?us-ascii?Q?5YtZ4M9K4oPSOhqKpG17sTJYx1d4qeTQjxMzt5j2a7oYUsBxmmfYZt1ffXCd?=
 =?us-ascii?Q?M2C1dfCKyfmHAf4imtOeVI4VODYSX4lvH+FDbjzVEzFMDdUfcGk8XC9b/FQy?=
 =?us-ascii?Q?BaLmQ/sq3HqnpZlhZu1e8ewbtafpzW1ncDsmaf7QqKYag/Y2Hn8Hbjrdi1t4?=
 =?us-ascii?Q?q54G7vbWQhVTvcmeaKlUtJ/DRZg/g3+91yLLP+ZBPVZCoSV1dki2FdwGG3qD?=
 =?us-ascii?Q?p65czdEEidwPIefwRKqDoTSeZNu6EHlBGLKiZW/DmO3WpKz1k2dtlBZtiyRG?=
 =?us-ascii?Q?gkymjTU3a5f4Sw0Fwto2WpXrOcseEIx+vEkBYW6HMXT3awQ4F3m+9RqjG0d+?=
 =?us-ascii?Q?hCHPOXpRvjRj8Zm1KwFdZpUN3fIAhAwmj4uZgIVI6fUFYHQS5anDofxe/6dk?=
 =?us-ascii?Q?c13fYWSGsoN4U1NoLfNtixZ/gzKs9s2yPccVUruIn7UqlwHeUTMLQQYN+byG?=
 =?us-ascii?Q?gM8saC1AAzYco8bSRHE7xJIzriFExsYGigzS+WrxjfZ2yxajWiFRUhcbRS5P?=
 =?us-ascii?Q?tGYYWr71eIZ8sc/j7zZhpaMKovtq+KxLKOG0HBfszmeusGqdkxxdhMvp9vnO?=
 =?us-ascii?Q?JmS6LD9Y5oUGQTMnJCuwAnM6dNQo7/+rVth83xeK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd21df5b-13e6-483f-8cd3-08db1a8b6b7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:31.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y29MyJzWY8fe3+yPhboPOxz67yhlx7un13ryAu5Hr7KdtBl5kZLrLukD7M7Jiev7
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

iommufd wants to use more infrastructure, like the iommu_group, that the
mock device does not support. Create a more complete mock device that can
go through the whole cycle of ownership, blocking domain, and has an
iommu_group.

This requires creating a real struct device on a real bus to be able to
connect it to a iommu_group. Unfortunately we cannot formally attach the
mock iommu driver as an actual driver as the iommu core does not allow
more than one driver or provide a general way for busses to link to
iommus. This can be solved with a little hack to open code the dev_iommus
struct.

With this infrastructure things work exactly the same as the normal domain
path, including the auto domains mechanism and direct attach of hwpts.  As
the created hwpt is now an autodomain it is no longer required to destroy
it and trying to do so will trigger a failure.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c                |  40 +---
 drivers/iommu/iommufd/iommufd_private.h       |  11 +-
 drivers/iommu/iommufd/selftest.c              | 196 +++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c       |   2 -
 .../selftests/iommu/iommufd_fail_nth.c        |   8 -
 5 files changed, 181 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8dc7ed678e3fbb..c6f4852a8a0c08 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -22,7 +22,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 
 	iommu_device_release_dma_owner(idev->dev);
 	iommu_group_put(idev->group);
-	iommufd_ctx_put(idev->ictx);
+	if (!iommufd_selftest_is_mock_dev(idev->dev))
+		iommufd_ctx_put(idev->ictx);
 }
 
 /**
@@ -69,7 +70,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 		goto out_release_owner;
 	}
 	idev->ictx = ictx;
-	iommufd_ctx_get(ictx);
+	if (!iommufd_selftest_is_mock_dev(dev))
+		iommufd_ctx_get(ictx);
 	idev->dev = dev;
 	idev->enforce_cache_coherency =
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
@@ -151,7 +153,8 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	 * operation from the device (eg a simple DMA) cannot trigger an
 	 * interrupt outside this iommufd context.
 	 */
-	if (!iommu_group_has_isolated_msi(idev->group)) {
+	if (!iommufd_selftest_is_mock_dev(idev->dev) &&
+	    !iommu_group_has_isolated_msi(idev->group)) {
 		if (!allow_unsafe_interrupts)
 			return -EPERM;
 
@@ -706,34 +709,3 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
-
-#ifdef CONFIG_IOMMUFD_TEST
-/*
- * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
- * and go directly to attaching a domain.
- */
-struct iommufd_hw_pagetable *
-iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
-			       struct iommufd_ioas *ioas,
-			       struct device *mock_dev)
-{
-	struct iommufd_device tmp_idev = { .dev = mock_dev };
-	struct iommufd_hw_pagetable *hwpt;
-
-	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, &tmp_idev, false);
-	mutex_unlock(&ioas->mutex);
-	if (IS_ERR(hwpt))
-		return hwpt;
-
-	refcount_inc(&hwpt->obj.users);
-	iommufd_object_finalize(ictx, &hwpt->obj);
-	return hwpt;
-}
-
-void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
-				    struct iommufd_hw_pagetable *hwpt)
-{
-	refcount_dec(&hwpt->obj.users);
-}
-#endif
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 331664e917b771..d523ef12890e1e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -297,12 +297,6 @@ void iopt_remove_access(struct io_pagetable *iopt,
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
-struct iommufd_hw_pagetable *
-iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
-			       struct iommufd_ioas *ioas,
-			       struct device *mock_dev);
-void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
-				    struct iommufd_hw_pagetable *hwpt);
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
 extern size_t iommufd_test_memory_limit;
@@ -311,6 +305,7 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 bool iommufd_should_fail(void);
 void __init iommufd_test_init(void);
 void iommufd_test_exit(void);
+bool iommufd_selftest_is_mock_dev(struct device *dev);
 #else
 static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 						 unsigned int ioas_id,
@@ -327,5 +322,9 @@ static inline void __init iommufd_test_init(void)
 static inline void iommufd_test_exit(void)
 {
 }
+static inline bool iommufd_selftest_is_mock_dev(struct device *dev)
+{
+	return false;
+}
 #endif
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index e05b41059630a7..17cb7b95eb2757 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -91,23 +91,50 @@ enum selftest_obj_type {
 	TYPE_IDEV,
 };
 
+struct mock_dev {
+	struct device dev;
+};
+
 struct selftest_obj {
 	struct iommufd_object obj;
 	enum selftest_obj_type type;
 
 	union {
 		struct {
-			struct iommufd_hw_pagetable *hwpt;
+			struct iommufd_device *idev;
 			struct iommufd_ctx *ictx;
-			struct device mock_dev;
+			struct mock_dev *mock_dev;
 		} idev;
 	};
 };
 
+static void mock_domain_blocking_free(struct iommu_domain *domain)
+{
+}
+
+static int mock_domain_nop_attach(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	return 0;
+}
+
+static const struct iommu_domain_ops mock_blocking_ops = {
+	.free = mock_domain_blocking_free,
+	.attach_dev = mock_domain_nop_attach,
+};
+
+static struct iommu_domain mock_blocking_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &mock_blocking_ops,
+};
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
 
+	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
+		return &mock_blocking_domain;
+
 	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
 		return NULL;
 
@@ -236,19 +263,39 @@ static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
 }
 
+static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
+{
+	return cap == IOMMU_CAP_CACHE_COHERENCY;
+}
+
+static void mock_domain_set_plaform_dma_ops(struct device *dev)
+{
+	/*
+	 * mock doesn't setup default domains because we can't hook into the
+	 * normal probe path
+	 */
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
 	.domain_alloc = mock_domain_alloc,
+	.capable = mock_domain_capable,
+	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
+			.attach_dev = mock_domain_nop_attach,
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
 		},
 };
 
+struct iommu_device mock_iommu_device = {
+	.ops = &mock_ops,
+};
+
 static inline struct iommufd_hw_pagetable *
 get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 		 struct mock_iommu_domain **mock)
@@ -269,48 +316,142 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	return hwpt;
 }
 
+static struct bus_type iommufd_mock_bus_type = {
+	.name = "iommufd_mock",
+	.iommu_ops = &mock_ops,
+};
+
+static void mock_dev_release(struct device *dev)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	kfree(mdev);
+}
+
+static struct mock_dev *mock_dev_create(void)
+{
+	struct iommu_group *iommu_group;
+	struct dev_iommu *dev_iommu;
+	struct mock_dev *mdev;
+	int rc;
+
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return ERR_PTR(-ENOMEM);
+
+	device_initialize(&mdev->dev);
+	mdev->dev.release = mock_dev_release;
+	mdev->dev.bus = &iommufd_mock_bus_type;
+
+	iommu_group = iommu_group_alloc();
+	if (IS_ERR(iommu_group)) {
+		rc = PTR_ERR(iommu_group);
+		goto err_put;
+	}
+
+	rc = dev_set_name(&mdev->dev, "iommufd_mock%u",
+			  iommu_group_id(iommu_group));
+	if (rc)
+		goto err_group;
+
+	/*
+	 * The iommu core has no way to associate a single device with an iommu
+	 * driver (heck currently it can't even support two iommu_drivers
+	 * registering). Hack it together with an open coded dev_iommu_get().
+	 * Notice that the normal notifier triggered iommu release process also
+	 * does not work here because this bus is not in iommu_buses.
+	 */
+	mdev->dev.iommu = kzalloc(sizeof(*dev_iommu), GFP_KERNEL);
+	if (!mdev->dev.iommu) {
+		rc = -ENOMEM;
+		goto err_group;
+	}
+	mutex_init(&mdev->dev.iommu->lock);
+	mdev->dev.iommu->iommu_dev = &mock_iommu_device;
+
+	rc = device_add(&mdev->dev);
+	if (rc)
+		goto err_dev_iommu;
+
+	rc = iommu_group_add_device(iommu_group, &mdev->dev);
+	if (rc)
+		goto err_del;
+	iommu_group_put(iommu_group);
+	return mdev;
+
+err_del:
+	device_del(&mdev->dev);
+err_dev_iommu:
+	kfree(mdev->dev.iommu);
+	mdev->dev.iommu = NULL;
+err_group:
+	iommu_group_put(iommu_group);
+err_put:
+	put_device(&mdev->dev);
+	return ERR_PTR(rc);
+}
+
+static void mock_dev_destroy(struct mock_dev *mdev)
+{
+	iommu_group_remove_device(&mdev->dev);
+	device_del(&mdev->dev);
+	kfree(mdev->dev.iommu);
+	mdev->dev.iommu = NULL;
+	put_device(&mdev->dev);
+}
+
+bool iommufd_selftest_is_mock_dev(struct device *dev)
+{
+	return dev->release == mock_dev_release;
+}
+
 /* Create an hw_pagetable with the mock domain so we can test the domain ops */
 static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 				    struct iommu_test_cmd *cmd)
 {
-	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_device *idev;
 	struct selftest_obj *sobj;
-	struct iommufd_ioas *ioas;
+	u32 pt_id = cmd->id;
+	u32 idev_id;
 	int rc;
 
-	ioas = iommufd_get_ioas(ucmd, cmd->id);
-	if (IS_ERR(ioas))
-		return PTR_ERR(ioas);
-
 	sobj = iommufd_object_alloc(ucmd->ictx, sobj, IOMMUFD_OBJ_SELFTEST);
-	if (IS_ERR(sobj)) {
-		rc = PTR_ERR(sobj);
-		goto out_ioas;
-	}
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
 	sobj->idev.ictx = ucmd->ictx;
 	sobj->type = TYPE_IDEV;
-	sobj->idev.mock_dev.bus = &mock_bus;
 
-	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
-					      &sobj->idev.mock_dev);
-	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+	sobj->idev.mock_dev = mock_dev_create();
+	if (IS_ERR(sobj->idev.mock_dev)) {
+		rc = PTR_ERR(sobj->idev.mock_dev);
 		goto out_sobj;
 	}
-	sobj->idev.hwpt = hwpt;
 
-	/* Userspace must destroy both of these IDs to destroy the object */
-	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
+	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
+				   &idev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_mdev;
+	}
+	sobj->idev.idev = idev;
+
+	rc = iommufd_device_attach(idev, &pt_id);
+	if (rc)
+		goto out_unbind;
+
+	/* Userspace must destroy the device_id to destroy the object */
+	cmd->mock_domain.out_hwpt_id = pt_id;
 	cmd->mock_domain.out_stdev_id = sobj->obj.id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
-	iommufd_put_object(&ioas->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
+out_unbind:
+	iommufd_device_unbind(idev);
+out_mdev:
+	mock_dev_destroy(sobj->idev.mock_dev);
 out_sobj:
 	iommufd_object_abort(ucmd->ictx, &sobj->obj);
-out_ioas:
-	iommufd_put_object(&ioas->obj);
 	return rc;
 }
 
@@ -780,8 +921,9 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
-		iommufd_device_selftest_detach(sobj->idev.ictx,
-					       sobj->idev.hwpt);
+		iommufd_device_detach(sobj->idev.idev);
+		iommufd_device_unbind(sobj->idev.idev);
+		mock_dev_destroy(sobj->idev.mock_dev);
 		break;
 	}
 }
@@ -845,9 +987,11 @@ void __init iommufd_test_init(void)
 {
 	dbgfs_root =
 		fault_create_debugfs_attr("fail_iommufd", NULL, &fail_iommufd);
+	WARN_ON(bus_register(&iommufd_mock_bus_type));
 }
 
 void iommufd_test_exit(void)
 {
 	debugfs_remove_recursive(dbgfs_root);
+	bus_unregister(&iommufd_mock_bus_type);
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a9b232c281c02f..113dab3a0cd631 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -645,7 +645,6 @@ TEST_F(iommufd_ioas, access_pin)
 				   &check_map_cmd));
 
 		test_ioctl_destroy(mock_stdev_id);
-		test_ioctl_destroy(mock_hwpt_id);
 		test_cmd_destroy_access_pages(
 			access_cmd.id,
 			access_cmd.access_pages.out_access_pages_id);
@@ -1214,7 +1213,6 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 				   1);
 
 			test_ioctl_destroy(mock_stdev_id);
-			test_ioctl_destroy(self->hwpt_ids[1]);
 			self->hwpt_ids[1] = old_id;
 
 			test_ioctl_ioas_unmap(iova, length);
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index e7d535680721b2..d9afcb23810e1a 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -323,8 +323,6 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
@@ -365,13 +363,9 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id2))
-		return -1;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
 		return -1;
@@ -572,8 +566,6 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 	return 0;
 }
 
-- 
2.39.2

