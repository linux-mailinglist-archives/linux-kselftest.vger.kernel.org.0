Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36369FD5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBVVCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjBVVCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:53 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152146A1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiVlCH9ZmNF6lthoA7m3Am2nrXuZ/41XXuq2jfTcsGZNOyQSPUP0pv1JDo6ZuL8KB/zipv8FjpU2e65IdxWMgqftPagiNXiOu79GTJtqKxPD2k++0yen1EIiCXmFC/NiZnPMIPt7a6vhx/igR7tbcowwnYpYcIodvRsCR0HgscFcKqEOF/j5OKBH8NGIcMbsSeCk8Z/YQCAkLs/WvnkWMfJZJBpt2+XqpkBBbsFO4SWfsqbKK7JxH7030/3lGbHdNzwJaeGYe8yYofs1eao0/w+sLafYBV9fxYsDqlhyelxzxmn8MGVtEqiviTNXBKF9nFm1wZ9M7DnMnybKIHtBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIbZPEi40haaohP5cRK05QnG+s+96VhqbULjGDDm2As=;
 b=ZPwZ9vxnWeY5i2uA4pB/kYdUuM5owiw+w7LNId6FUHUs5JiDgTQbFBIMEOIe2Tfvc3iZlNLO/yb4pNKgXnF7pi6lGEcjZRBZMD9ULvg2vcWTubHe/hXB/4DqUfdl/hdJj99WCKNWdtSdfRh5q6nsanHBNHK37ehK56BKbQxKpc/5BcnQJfepDnkBOIKNsQRY6v9qlIZfsMj/L4RpIuFogUYrjtuRnnvb0+Fy/agYxV5p9Uv2Tq2qQhExcxg2C2xuniQdkH3BfU46BMKiYJPSJkzNl/Tg3KWLY9rMt96uDLNExyn+3LBD3CZMbMBpyZV2ueRgmyuEdiu5+vbbT2wc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIbZPEi40haaohP5cRK05QnG+s+96VhqbULjGDDm2As=;
 b=TD9/yOeGy3eG08/jQQojIaYOmpdmTsvSe0tRBzGpVtVcXb7E4ukA6d0siJPx2wrNd3TD7rBNSdUe0zJahs9aQcmKz57c6G4X+6yUlxlRLB8pPmCjl+so49NlxxRrp1TfiMFyUDLrklBlWT+qnHiv2iiLXrB6fMPLvY/i1Ee6KmCgYKo2mLZ0ia05x0KAhhG1vBzpFdKj/hCtsxOr/Y92VI4t03lBYROkiDGCxKMp7DcNSxRBNs1yhmJL4Q1tEjbDdpoGzFOTRdW2YvYU5gQ7jzzHHVNWSNnO+o6bC/kk+fOZFLxEubjoDpvy38hLosbh84HqRw2NKuyddFd+uGo6xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 6/7] iommufd/selftest: Make selftest create a more complete mock device
Date:   Wed, 22 Feb 2023 17:02:39 -0400
Message-Id: <6-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: e8833741-8a9e-4528-ae42-08db15182405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eowigl0xpR3iezP4OtHQQ2KBQaVpt8esgMBkzFB7jtATKxoXBvjxBeEOOApG6u+dxBoGFc5x3k3Cn96QH5NxmiZSZgLPZPnf5YMJFgguCbPud54hGN1LAHySqkpqp5Tiugu1f2+YMvbHn/BZlYWMHfm/zAmTUB42Taa1v/9eZyE/lnYz31IDfw8w38G0i6yVB8bFTG6RITvM24roS3q5rFVm/DtI9DAVtTWMlNJ6rVZxNrC1/dBeZ2l5zY+wcyBWRD/g9W3aF72BHlrf9PyUf5bgj8f0eooukWXhOzfxqD4o6E/kRCQ7lyt2HTVjU/qk1JK3F7Q8cKnGTl6vhGRcs6KfHcNV9dpN+Oal8HwSUqwtxrTEmekp4+IzSXUKwNEi0U34NdQm1s6cAFlAC3kP/Y6+TFVjrKQI2wUQcABOOgDzXf5yPb7cLnpBx7wpVDi1uuHDzeiHbBikBXOZDJ3Pc2Zm02l25gHdCqHK+BXwmYhbkIUtw1Y0oxrVHdTnWfY8wNHIeu5P08G2YJTHEN2XlXpnsK4VV0DEGKyyGpp0TxoopsPoXlIml6W0Ehnnu1Yc6Iz+XJxweqtOIATRIG9W9ssUjXsXd6IrQz1Eyv2VtjlzpIbsPED2DFdpmacGER2yteWraaBmQW+cG4JkC7zlPkR9XmopY0N3g/t3rt7uuKIjXvWQ+/zy97DjQbT9itQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(30864003)(83380400001)(2906002)(6486002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptw3Nn67o8Odw1TEBpFDM8LNttGDQeOJqQKMYkFBX40KyKO1xrLZIXlCVlgg?=
 =?us-ascii?Q?6Sjy+TXrV46DLSCxvZ7olvDH8N8pP2Xc3snslSfG80LBOlG+Kkjw6Bl0OGre?=
 =?us-ascii?Q?bWSEGSs0D3ZOANL4F4kfvQaWAtW5gzbFjnPd5mJ3Nk5jgLmHjE4PwTSQQwRT?=
 =?us-ascii?Q?B8DmJ/Z7GYLn/Dn2YMB024YJf7TdGvtxMfk9yeusDK1lTGSOw1sAorzo2xvz?=
 =?us-ascii?Q?wgy7P83THVTT+kGrDuHtiKi8nK3OrD+CKdVTaLeCGEUugNrViduYZ8X8hdwo?=
 =?us-ascii?Q?hSix90mEWCkYLnoQ9lfdnMYkMq2F+SQj8d9a4/7xwrO1F6RsZCGvXwVbWMTM?=
 =?us-ascii?Q?4X/pGrahgd0Zdc3/4Ac6PEb8LudHZrySb2vN1s9SYkP1Zw31Y9yFW4eT5Iij?=
 =?us-ascii?Q?GesEMoja8/IE5S1EqDPcduwTPkDAwQxyNpD8sa/2YMNmiUALTzm57zRKfomX?=
 =?us-ascii?Q?BnreabJWWcHY08pZBhH7xfeaNrMoA/JA3NfS8338a+7WwNsukfVsD3sNo/4V?=
 =?us-ascii?Q?cxSwNnATsahJWx9dYQ/LAy0wuPoMfRAgOM4AbsGb5AjoEPER/bFYIynkQRCe?=
 =?us-ascii?Q?r+XK3sW3B052SKz2zqKsOvfRSd5sDhA7sFRi49m3mmV58t6yM30I7bAiBrnN?=
 =?us-ascii?Q?ncYt5lp8WcvALMdUTThp/mphqeHIpT0vTNVlKevdOPHm33GbGQzFNasW2u4y?=
 =?us-ascii?Q?YD1YPk0fKwSSOat0v/R4/RTxU418i0YP9c7ZabaFqbXh9f6lV3oQ80612JCX?=
 =?us-ascii?Q?uBL6npKTWCtJX26A2rIozvj/jEGy8RvgAd7bCz+LAbn9vErFxO3HEinaelIX?=
 =?us-ascii?Q?e4T5XHP6DrvUaPct2SuWSItRhjBJ07JL63//69kkaD5MFYv9WeG/f+apRgPd?=
 =?us-ascii?Q?R7ooTaFsSUPKZuOwanFMwUliSyLRaA28RSBidb1cW0TTbUOnVL5bTkydD6rI?=
 =?us-ascii?Q?Mt6aGRO3Zu2tUbWyokCdGCKpbzLSLLRrUOmfZf4YYXfdZ/R6IAb+p4fMVzjm?=
 =?us-ascii?Q?SFESMEvXvrSseSgLNHok9xv4fVQXPrPYWbNlP/03jRllzxiiorkf5fVkSyuc?=
 =?us-ascii?Q?KlBhpl0c4to9UtwhpXLr+O2Y735+9rLvJXS+fRYprwQ30sT/gpz3SKlzznfw?=
 =?us-ascii?Q?cspw8DeOqkAWSs528sHkMM2iUlG65DR8Jb9qIEXGYbg5tXw5NXw72ej4AwP2?=
 =?us-ascii?Q?vRzraBMxgjWdNgw7HutmgzWmiaFALmpzvYZiW412MdZOtx54m9cGRfF2NN/m?=
 =?us-ascii?Q?BUim7QDh8sLNOv9NNe76MSU4z/6ZwcEY0xyIt52udCweXcp3ulHy9rqVJjP8?=
 =?us-ascii?Q?ANaL1O5p0O7YiK4hyBF0gHf0MzcN+s1Nc3Hes8WC+ISnQU1OBePGI2A9u9CX?=
 =?us-ascii?Q?5/oUoHlkpHvOLSrY+5uESU7rd/9iQWGVMHQqFPjP4q0uiu4mZZFQe6HX0OaM?=
 =?us-ascii?Q?IHlgERnQpy4EaV728G5wxW7FCfZnisxa4ckaECk7SNQJlDjTsuksIfh6kbOb?=
 =?us-ascii?Q?sq9poMhNwEtCGZc/87KOIIl7PxW9XRgQiORnnFN1iv1qTMEUX80dbMcg0kAS?=
 =?us-ascii?Q?yTIuuQsUpSF7oJJDGmRlMLp4Iymdc/gfLM75Z5KW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8833741-8a9e-4528-ae42-08db15182405
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:43.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS6+oLYoQACrglm7iEfYNiKvWV2aX3DkqHXOT3/emmPT0MbsupWR8+e3UZaVG/GE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c                |  40 +---
 drivers/iommu/iommufd/iommufd_private.h       |  11 +-
 drivers/iommu/iommufd/selftest.c              | 196 +++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c       |   2 -
 .../selftests/iommu/iommufd_fail_nth.c        |   8 -
 5 files changed, 181 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index cf2517a6472ff8..41cd65c758d3bc 100644
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
 
@@ -707,34 +710,3 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
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
index cfb5fe9a5e0ee8..8540adcb68f1f0 100644
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
 	cmd->mock_domain.out_device_id = sobj->obj.id;
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
index fa08209268c42f..0c4bbd4079a425 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -645,7 +645,6 @@ TEST_F(iommufd_ioas, access_pin)
 				   &check_map_cmd));
 
 		test_ioctl_destroy(mock_device_id);
-		test_ioctl_destroy(mock_hwpt_id);
 		test_cmd_destroy_access_pages(
 			access_cmd.id,
 			access_cmd.access_pages.out_access_pages_id);
@@ -1214,7 +1213,6 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 				   1);
 
 			test_ioctl_destroy(mock_device_id);
-			test_ioctl_destroy(self->domain_ids[1]);
 			self->domain_ids[1] = old_id;
 
 			test_ioctl_ioas_unmap(iova, length);
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 9713111b820dd7..dda8f0187cd88b 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -323,8 +323,6 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	if (_test_ioctl_destroy(self->fd, device_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
 		return -1;
@@ -365,13 +363,9 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 
 	if (_test_ioctl_destroy(self->fd, device_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 
 	if (_test_ioctl_destroy(self->fd, device_id2))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id2))
-		return -1;
 
 	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
 		return -1;
@@ -572,8 +566,6 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 
 	if (_test_ioctl_destroy(self->fd, device_id))
 		return -1;
-	if (_test_ioctl_destroy(self->fd, hwpt_id))
-		return -1;
 	return 0;
 }
 
-- 
2.39.1

