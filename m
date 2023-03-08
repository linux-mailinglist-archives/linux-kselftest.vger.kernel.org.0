Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B06AFB33
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCHAgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCHAgF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E69CBEB;
        Tue,  7 Mar 2023 16:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzYsfjgovuireCVq6nc8V4B1zF7qCOwD6erUFiG4xd9QTjpkDi7IesMwM4/I6NhouC70uHhBsrW3r7IEosFkoFSBalm4z+C9zrrr3oUbcbXRmy5YD7xCk6FsY1FfracxN1nU+4jvIt0ZJFZT5vP4yGKPX2/4aOiyGCHG9J0keL1vxUCf1Rsg+vVrAht52n4z6HARhFpYdhyoUOV0QILIteJ64HK9D4YvCN8MMvr9aI+SETHIAeywOGWSQX+o4hzE6gMs9mI0dZi1tlGHGYrU/pz7AGQ3Tq9Ox7UZmyDqm/vXVerNy2qAKtE73wD0gYd01xrfUTCpXeyTvVmB7hNSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je6yzDNdMf08l4gjaNgXgbzq7TVME8YmFB6ue1iVNRE=;
 b=MIQRSwaBgKsDqnh32J0BXeJEYESt6RjiaVRQ8FUkR1IL+LZng7IBjkabSQW6CxAooIQUrC8+z9ccqJDl/334V3IZSTRafDbwglstmEud7OzCV0jEZAFdkaxM5vLjjkHOuGAMi7dEPR2+eD0JsXpoDRc8M50i50ZvAgyVy62L5FzxBYB3q5twn6Wuag1kJuu9dLDoKpx+GbqV6CUPyl53JeLErxokV+VcskUjNt4xOgKqm66v846f1KxHyc4+OiW4/A6FnznjY1KC+NCJsyIehoD1RXsTt/mmE+fnsKWnm80bDsWhnBVV/3MpY4fUc9mf462pVARCO/oRXUiPyHpyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je6yzDNdMf08l4gjaNgXgbzq7TVME8YmFB6ue1iVNRE=;
 b=rxuHRtFJExZfBUZKjGpDoWna5G0qnwald6JSfAic3yFPgVTtaXm/B1I1n6y9WQh7dYBxuWX3r2+17VOxt8sOuRkxIIHis/FA46djxyckXYPYP/CzC3QQe85HwmlG33V8Dx6r0q2BkhI4cfpH9DlRpA/BHCUm0qYsUQV5NOQBxxSRQgLHglb2D5a3EWN4IIwoSS98Txzz/Mn0UYgsL3e6CqHGZlnNAH8PZiOKL4qhDjHKHTQxIKK9rTi1DxGg3RGFvDMtH/vfRYdQfZpZnjuHa/OAagy/0hnGrJfMmEab4+t1mu8QTIZl8mJjigqk+17hgTDcKO3Att8T2RIa4/a48g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:58 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 11/17] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Tue,  7 Mar 2023 20:35:50 -0400
Message-Id: <11-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0295.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d12519-2c64-4d1b-df8a-08db1f6d158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +e2zEnnXYo5seRpvYwzGVuiJryeYcRCbf+SH0vQKPWJFXiE7cPUVLWDy/ZvwxmjzlZQaMKR9kIUs5QzLPwTw2NML4WmLKF3rvZMam3HPcOiFTgQtG+hUWzU9jC7IxUZWq9EGRbw/cXPMVkCVfvUMy1gL9i0n/jPhGkMVXnw1cmKNd+KBSZ4HXlzliF3Y6MJgyI4PgYDI1Uil2tA+DZ/AU/nyMBBxXqoL5cy+03CCH49LW5Q3S6iv8vjrPYS/horLezDWM/B2uHoCh2Bt0jimJWdVeNsEEoq3URBtNBN/Xx8W8V8VytJBzHGnuboCyDDYAYgc+tpHCup+LRUvOCVQ7Q/RR2yzCnsYogJoi16VSPI8SjzSWhNxpykQstMXD5CjsaqBAjzV8LNE+apkhp6oU1ewDGYvQgqxTs/9428ksRJ0OmRD941f/AGsttJSmh7IrG4Vc5X+nPfX8Qvh0qy2W7dNrYC9c/u5Pc95+yy4pD2be3xp1xCJU3XgrKJ9p9Oh5deHiKa6ALzGPSDqJqxUDEspPFk6yfWie9CIn9nK0rBxazYwKl2bIKebbgIqO4QAvoUKR2bDPlRPVtjIc06SgCOf1T1I2KrMXmaslVjXc4k4WMI5g7L+80L/DGxnQEXe6+248O6RF3VBg53vF9SvFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gvTchg4OuiHLxryGqQSr8yv0i/WLm81pqNUuwoqueUgdAiW02Vz1V2ba2AUo?=
 =?us-ascii?Q?+OV+b1eCrLzWF7Uv+AIOVMjXopi2zNXba0t7+AKnqV8sFnfn334jmZ7PVaiZ?=
 =?us-ascii?Q?5/BRCNcf/xNbqi1rt//EFtTz4fZB/cgOaHRadHHaZ7iSfpT7TgDTN5f2ILqN?=
 =?us-ascii?Q?aCVNbMoiKx5CehoQ5On/+XxLV7sI9QS8aj397ppj9ffYkEFS6fPmy07VmEdo?=
 =?us-ascii?Q?/OP9bMGZTV5OUco1IA3TS/VmMPUh6rbQ1WL+ZeAVwlE7OKULijR0rkgxZYZL?=
 =?us-ascii?Q?PgBzGqbwAMUN/8nPc0OfCuACbPR7SDE8hrW4+i/tdoJIiI2jTRa9/Dbg1ktr?=
 =?us-ascii?Q?v9SRnXPIGWZ4KaKh7m5LT71tY0cCRxGNMkaLvCsQK/NepvHNYG+eB2ai663W?=
 =?us-ascii?Q?iYDoDBUgxRdeQqeMbM3KDlXTILp7MBLaFTG3i5xxj3nXVpwuPNQCneUpLPJF?=
 =?us-ascii?Q?rnWEEz+3QPe22nMRHITuIDH7kOkCNgTODNGX/4k/ieLJdSRAdYFX9HmB5utV?=
 =?us-ascii?Q?T5CUvl3XCpz/1msXef8Kouyikjx7qy4iuxVP8KBRAeydMvcaMFYCUpMikr8e?=
 =?us-ascii?Q?qR4f2C4otHntykDLOcIzIQ/wT8dY3Yq21zFa/JWZNYQeK8qJF8+Bxl7tH1P+?=
 =?us-ascii?Q?tDFEAdP6+R6kMWB6yDZN96Br/trkl0gFfKspG1+ON5tzFmCU9ymXRBHh0k5B?=
 =?us-ascii?Q?EzVVlHeGsj7CMml+ed7+e8lqu/EpxIZiGLizPoUA1eyC9slIqr2f3jX67bUP?=
 =?us-ascii?Q?YFtrzjyfTpOU6nbLC5uXlxviiUtoKjczbfu4cDNMVoM5B8eysAOpNpUhg70i?=
 =?us-ascii?Q?VI8d4OlGCxqUqOqNaDdf77PaAgH/98IuUNe3BcsSo8H2o1EeWTJUUTavyTpt?=
 =?us-ascii?Q?UWis+BQHGYkx2ktytaY1dqv1baQnWkGzqC3256IUz94IX+naWGmhM818aLsq?=
 =?us-ascii?Q?g+Mt/7pI/bf5/Gi2aEIKp/oOnzcSbVK2OY+D95K5MoqnaC4E3qKX6+xCL4PV?=
 =?us-ascii?Q?RrdghZH3h3MBdOoMl7bozEANiA8W9VH3nchyRV078J9Qc0aWGeJ41dI7iVfs?=
 =?us-ascii?Q?Map16NFKG4/KmoYCWU0yr4Md6UC8rLN+m7C9NoMWvsu+dnjrfqBR5QKDaI/l?=
 =?us-ascii?Q?FDE/EzL9ZmHnzGDsCWtueL/Asx7tv9eifiYg5a4tKUsUKki6xniSjFkzizot?=
 =?us-ascii?Q?DegasAEoJ9tHbGsXyPahITG7tPhCZIW6DoIVBgC89JU3UJqVkJM0yTASkTrF?=
 =?us-ascii?Q?48rh5LhCd1Ltz+6NNyITDeNaZe/FviIxn/tF21uiY2mBJ5EQhEVRHaVNJjhn?=
 =?us-ascii?Q?oIqSyuV/vDst1SpFUf72VBNYa+Zqz/AZx0WndCYwE0LqbILzFKRY1AkrKY7F?=
 =?us-ascii?Q?Eqr10O9K+I2/qL5/g2DQsxYTQcGpj8dklym5u28CNef5Oh1uU2/3tz5Vtz3X?=
 =?us-ascii?Q?n4t4W1vwdqOJQVvqRSzcM53uFX3Nd3kiglZeniK3E0OMHfxBraT+CUHud2G1?=
 =?us-ascii?Q?JRUtQiToNNrQU5Z+U5shPMriTWcW6muo9h0+xstUqKaEyC1QgWWL1lAqyvY4?=
 =?us-ascii?Q?2TWj7fRRunzCknnfWsmN2xzJsclSXQ8EzWWcPeRk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d12519-2c64-4d1b-df8a-08db1f6d158f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUx8LTfCsPGXSvbGbCy0K1E5Dcz3n4CMF2tvB0bIFJgEQXhQt75LfayJXlZ0IopW
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
index e57462bb06d9f0..0eb54efe01ce92 100644
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
2.39.2

