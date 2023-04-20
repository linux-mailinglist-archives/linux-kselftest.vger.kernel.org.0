Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E26E9C0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDTSw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjDTSwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58D4221;
        Thu, 20 Apr 2023 11:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiTMS8X7p/8jNlFAmSJAaOK68lgN67gTwxU0zL59m81MDcDeHSDE92+WGXe3kl3frtPl21qBSiFwzQnNeVwJuudwGGqHTIO8+FUXVa0MFy0YNvpCaUe+wTg5qh2SSZRsqk4k7Dm9piIzlHnmVr84UtAH1/pIgh5erI9jA4eXduQQRLrzxE9hRni2aOpKV13XkTdP0UWx4M+5pZo4whDJKVMBciV5AUx+RoTp7otAQkHua19x8Cpi11PvBvi5txd9OyWU0kR//YLLgw46xes5ls/5OS/Al3mxtTsG9h7BnXgDwLxPHD8Mkcd5ZhwRiAQgeiicdgnmnwyNVpOwxulH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=XQb6toU69FOnpUFa6bnTYeI0sQcP5aMrt3XlnKL5dY6A3w5J9OhQbX7wO0a7syqtJUuAgZZJ9XChaYHdwnvQ0Bve/zyIAmAtLd68kCfVtkbGTpOzCWvhoZFe425y/mZt1hcqMhgteiS2IgQyasRd4bcerERQLf1Vg8GGMVhuKvoaJtMkXgY/a4Y7BvqD7amAXuNrpR3g1ttl7MkR5KfdHjoHiURdj5g0O52VW+B/ubZs6pd67yvWsabddkD8lTbPjtvYQj5qzTa28fquUI+JoMC1jJc6wPzC+sWp8ss5yK+kfkikUfH2EusmuMk8vAcMGWyDjtrq94pHApaQLq/g4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=ggzITyXO+BLupjCFHB9ZUbpdzqS9+ahdyvHbCh4njNNF6Zp+s9tzrPjIMBOZRvq8OBK1h65c6BsjjTSfJp7ZRy3gxSeoJ6JGeQrN1GgpkjUbn3zl0CQ74//r0y/gtyAyMlyFSDICcxb2lxF0/gp2FqaLsEzBqR+SwXk7rdiwLp1kcZW7C3LeVUm6E/sMwRGRI2UxEBm5hDkD6FjcDBEx5/hjT068hVemn9wf1cYYu7lcwN8mfT0f9TOlyZ0gA/iHo1BWe73kqC2sVP4Ni2eq4AIDtsmjhIHNcDu6tM49UjvIMztlFb8ysqcbvZsQwxC73HhMiYJsa5oEPpyxVi1rEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 13/19] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Thu, 20 Apr 2023 15:51:28 -0300
Message-Id: <13-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:208:32a::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: bc40397b-192a-4f61-5ac1-08db41d04565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNsXK6SrHYqgeugEoX9dvxXM3cOacwcv62RO4X9P3TBq4WL/2tIp37bFiGQVpDalJlaU/pH45v6CKi5jmRa+M9LutsDtYcuFCZ3ekphOfhZpQ2DwscZ49DrawEgTPVpENHdxod/MutPn6zUP/oYa9MkWwbYT6Nwi0jpi2CP2ikWTY2ImESOVeE1wIP6fviCJPmD6bXngYVc4sgCEpSfLtRKkJNSoj6I91l+0DqsV1JyPRVQY5CRS91YnySmYBe99MuOv0A7pmKbHe4bZc7fraIyVvLIqJ2iTUeJ90dzh2mTu38i+YYYzVB+WbevxHDVZA9Geh6s32L2N8EHjhXh+jAgwm21cp+XQW9qXuC89pXAxUfhnZ6eQKbeH0ULUTRGVxbXRFSkzATDdifl0aXhKvxedxXbAiP7nmZ5CdKv8c24Hz/fLKYnCvFNJXfjoqL12GW9npbzJXsTwF2yAYdUyelH6w1HAsnBT3DWnkBNNDAhW5lh6oyLZnQSSnMyi/c9T1I8Nkk7rwFEyB6dDRE6rfI//gI9mhjs6gh/DJ86Jue1HQMY6oVTkHjDoTWIdd1Xp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSbjo3k7QrPwgWTyzWWxBEIXhtf5zvXajdyYMwSc5hs1JpaqnS2+Jdy1tJgY?=
 =?us-ascii?Q?UdF6h5riKy+e+pQf141LGkff7xCgI252suOIBjc7HNNqQW4rsMHCF7Hn0tP/?=
 =?us-ascii?Q?cmgpzyCI3KJmgQMYyI06BaKwzWkzdlBIv39w02VWXB2kzd6BdhXCpzamCsij?=
 =?us-ascii?Q?ljXUOhJqWFBZpAaJzvqVFLSULV22lN1X/BC9kqbU2dLszYNpWljHwzonij6m?=
 =?us-ascii?Q?QomTKEjOKzavHH6UDB46Ne1sY8Qtk3SFfT5mADpA7Itji7m9ZIdaiq6t+46x?=
 =?us-ascii?Q?DkbMsXdMvL7m7TKJM2az4tKUtXPW+Ur/XD3l8zLavJ4kQb37RuHQelRsOqc1?=
 =?us-ascii?Q?wZJuV1y8bbkhJ6tnf1FstMJhT/AxSiaakYUZCOT9vOqD3r61NbgJclQI1Dl8?=
 =?us-ascii?Q?1a8BIx8KNYQxbsh7eXkusz7TE53Hnzo3+ZCaYOYuFleDOrNbLt1dZUooFXpu?=
 =?us-ascii?Q?ElYzE5twGCKOMKP/Jh/gdEEzGiH7j5zikayBqFITGTOOpIGgbcA27mHx3lF6?=
 =?us-ascii?Q?7YfaxoKZS/ZbkQXM04HMVIga+VzfiCW47wxLnxLKTg8EbTezOHAZkpMTikUp?=
 =?us-ascii?Q?C2RpEVr/8ahkvjkhiSQse01stopfIhVom+sdSx22YsQ6wBuTOgh1v7XOc8UE?=
 =?us-ascii?Q?uw3javasC78Hc3CMxZVErlGX+reKFVRdv1JAvPT3BZoWkQN98ckQtNbwdjDq?=
 =?us-ascii?Q?7rSLA4atTT4RxtENdrQyHb5YMMaG10zTFlIGssSqLylBr1PNMAksk6bR/Sfs?=
 =?us-ascii?Q?nh1FvcqoH6/ZQzCSnsZl+CMe0LdkrzppVEZlSpBw3+XE5y1NLl0pXX2YYcsH?=
 =?us-ascii?Q?fSSD7qAJve67TW7gz5UP1EjelRGDQUlLCYVVvNbq7/CLMlnwsDCxPWVg5uEr?=
 =?us-ascii?Q?RCtbByrYTYngls3Ey16cLdN32e4rp+ypoXDt4veHBTDcLaiTcodLZJ14uZcH?=
 =?us-ascii?Q?V9pVVsMlN0K6Ye3UzUkZl3KNJb2zuN5kYc4nAZm+t5VVyIVh5wg9rxaiwA/i?=
 =?us-ascii?Q?kVgjOlf/WhZtKrEOTxqxohE31kLA6/tWwJKSaQ6zoFRc6k3zly+uzgXxm8tC?=
 =?us-ascii?Q?7BRwyOzldbx82gtKdtcmX+2OxTRZ6u06o4nDPdIJRaWso8rNuqPPqoIeMfem?=
 =?us-ascii?Q?nNL+IVe2IcnNl/I3lhupwkZLucuuYhZsISckpyYLvCe/il822R1zmS2Sv+4x?=
 =?us-ascii?Q?Oegv+Iv7mc7hL44ALHl/JM9eHh0XPmdBDd08hMZZh6uDmIxLnIGOaD8zQMR6?=
 =?us-ascii?Q?NzI5wJwNZvYQkMfF91jNO41wCBkwM8M4YCR4acUEx6v15GoG7YhdWqs6FKDX?=
 =?us-ascii?Q?8WfSbS/c0SnhG/KiKMQ+ovYXPc46bNnrnUPqGAVtwNnsA4eqloSIgZ/y+dN+?=
 =?us-ascii?Q?HOmPVrByisRPM0jfLj11CbdDBhae+QitNScheKsiJle5YQtQU1vV2Ih8U7y0?=
 =?us-ascii?Q?v9xtFQT6tNyRcZvW2ESrYsCn+FkzkKCCbtQnsm8u0KmQCWOipkZga1WOBkhT?=
 =?us-ascii?Q?KUO8P400aXN2dXvJFU3z2Z7V/j7zK+Gcc/UPULebx5GwjFwie5JEPXco51n0?=
 =?us-ascii?Q?eee1iRXAM0mPRvMR93dPh/VEmf0HGtELiieSQlMo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc40397b-192a-4f61-5ac1-08db41d04565
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jntZfU23zc8DbbLi5Fry0yO7hvgjW29EQHNFwAwecqKBTKMVpsX4vIsxXILfMsqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

qemu has a need to replace the translations associated with a domain
when the guest does large-scale operations like switching between an
IDENTITY domain and, say, dma-iommu.c.

Currently, it does this by replacing all the mappings in a single
domain, but this is very inefficient and means that domains have to be
per-device rather than per-translation.

Provide a high-level API to allow replacements of one domain with
another. This is similar to a detach/attach cycle except it doesn't
force the group to go to the blocking domain in-between.

By removing this forced blocking domain the iommu driver has the
opportunity to implement a non-disruptive replacement of the domain to the
greatest extent its hardware allows. This allows the qemu emulation of the
vIOMMU to be more complete, as real hardware often has a non-distruptive
replacement capability.

It could be possible to address this by simply removing the protection
from the iommu_attach_group(), but it is not so clear if that is safe for
the few users. Thus, add a new API to serve this new purpose.

All drivers are already required to support changing between active
UNMANAGED domains when using their attach_dev ops.

This API is expected to be used only by IOMMUFD, so add to the iommu-priv
header and mark it as IOMMUFD_INTERNAL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu-priv.h | 10 ++++++++++
 drivers/iommu/iommu.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 drivers/iommu/iommu-priv.h

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
new file mode 100644
index 00000000000000..7c8011bfd15374
--- /dev/null
+++ b/drivers/iommu/iommu-priv.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_IOMMU_PRIV_H
+#define __LINUX_IOMMU_PRIV_H
+
+#include <linux/iommu.h>
+
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *new_domain);
+
+#endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 76969904b93af4..91a948a76db5ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -33,6 +33,7 @@
 #include <linux/msi.h>
 
 #include "dma-iommu.h"
+#include "iommu-priv.h"
 
 #include "iommu-sva.h"
 
@@ -2191,6 +2192,35 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
+/**
+ * iommu_group_replace_domain - replace the domain that a group is attached to
+ * @new_domain: new IOMMU domain to replace with
+ * @group: IOMMU group that will be attached to the new domain
+ *
+ * This API allows the group to switch domains without being forced to go to
+ * the blocking domain in-between.
+ *
+ * If the currently attached domain is a core domain (e.g. a default_domain),
+ * it will act just like the iommu_attach_group().
+ */
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *new_domain)
+{
+	int ret;
+
+	if (!new_domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		__iommu_group_for_each_dev(group, group->domain,
+					   iommu_group_do_attach_device);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
+
 static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
-- 
2.40.0

