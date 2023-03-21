Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE76C3A1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCUTPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCUTPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02205231FD;
        Tue, 21 Mar 2023 12:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvVrTFWOvnvnbQdSse6isGdUT/gjS/AvsAoyj4an2WNkp7dEKHayD27Wv5rL302Ftcs/ygUnZSY45bSopn+vfqJvlAEB7GwcD9OGIBAuxhlrRWmHcKFr72pZ8F5Mb3f+35Sby3QQvztQeox6/m9t+qac3rgEEfQhCHjNZXTYLDwlROyeqA4lpdZIi3oygJQeuWj3rBvDKXJGnCryNzfx7sxWi4gtCz0pwrFmpbUtitn+qJ0FB7uUtWlE4ZL56Yw/kfEogcT3pfWcAJzGujkSWfRpPRaTy1jCNSCVeAgLua4+XnL+EliJ9eoYTHf8pCdJ3Ii9qNg1HlUAH/dF+97KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=BaBnNn9yu7cCu3NnVF+FoPsqslROTSgGD+pg0sgj7L9rIkHboG+E3hofroTrAwYloa4P+zLPtx/Ggc4W+NcYP0sD6H/ybx9FPdamZIVcf7+UzdlxujkbCybzRWZ2LpBma3a9C87o0JAQpHOnDKwIwICDGEfCyVBSLeKXCl10LIfb24p1LwYN6WQaAvlNhiw9T1D/4QfTgd0YyfKWR+xrabmF/OFxPwqMe/rKTN/rjaw9JVNeLIuzssi5K17eK4HD6qTz8GxXqh+iKdYMan8uSLg+BYKsAE3m5L1jzERRiplWCF4Ezhm/TXzER5U/fiUbUJMkLB5YhW89haAfgxn7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=LBOjfbeZv8WC0BAHjTI8l2ImGOgzZ24MCN1V1BW9XIOsRA8D03wOGitO3N9cKB+W+fl639NTTxcygc2/YIJkTLmW9IpJeXHSPEbG/R0LYHuntn29xuTsrYdn9qNkoFoGRP/+DD1urucJVElzwGqk5mpqWvUVIBVPeQn9YcOpzBlPJ7UhtGWYApzn0CPyvSldvZDuVoCTMBqN31mM+/L7pkeaEMbMx/KCTvspC7X7GYusd5GduNFV+8xo/UgGYs2tABn44tKVZ+wZPRET/8YhZtfiJEJs30GN14ZrXFQetjGEUqim18wJkM9qZkk0Iyu7d3eX4IeCXwGAE+u6WlLnqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:54 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 11/17] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Tue, 21 Mar 2023 16:14:45 -0300
Message-Id: <11-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cef3af9-0c38-498c-132c-08db2a408c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU4f2o+HxfuP05o5u7aWL9BXwGgqJowoIqEYuMiCKLmRWYgf0WBpEDrpPkaQHEOXfrGy2TIZJo8/eKiNl4kqFxic05YJN5+pCkdjzTNk2jZkF/vkGmOwQ4aO1pq8glGoFgMwa0NlF9mi9+PK8aymeD5xhJmX5aH9npSc4nFOSTAp6r2IfltTPmC44plDuU1Z0Ql+e01y7Y7OFPYfsKwpRoBDQpPX8eXfzKd9faqSziaqdC2UEi7oTGsDtMhZKqpIYUpiO1IPAQE5+MvJ51TM4UCBphOrAJZS5FSDbB2bTBKShUptMOCBSw1VUlQSb2ztkNCTaJ/0WcLQ0Zvj1+fvxOx6GF0pOx7tk+jDAgSdcBa1WrRLHGz20esVRF1eUbFoSnw9d6WxnWD6CC0tcCepD3JW7hLj9GZ/PTr3r0Dne8svIFtSN4MjUIv9YVcylACNG64eBXQ0S5EifJy9tVhkGcVT8uPCY6x7eWKYalpByq6Z7Qg1zLY5Udgl1eniJQHly41rIX+mtSGJ+RmnykAKcSR7eVRq1yK9/9VjJef5+BUqIstNjeJv2nTp8IFuLNk+ZbTKb7q6w0P/qoRcFZmKYCif5iAB+Lvzv9IE41Y92P+YH6i9u6NijH6czz0ryUpranuiIph+ShYuGSZxKAg4sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAqsebLx9kVBgZVP9WUx4cYEFc4GsOn9+cnJzpHPMEV9tmAwmeYj71/7Os5l?=
 =?us-ascii?Q?zGvRoARcJeZY5NqDbvOJI+5aVI/ggi/jv/ZLyhTGm3iTnaWAcdYIkYEDBwNh?=
 =?us-ascii?Q?b45B/jxX+AriLzn3hBGOFuVe3IFPfOrIgX3y4J+a54UAODnTM7ewsFY7hflK?=
 =?us-ascii?Q?tTRAJQOQrxLpbegHdfY9DoTSmXz7milLfLAOGTPPrwH7mNa7fMyZoImqjb+h?=
 =?us-ascii?Q?KkN7Z0eovKyyX/N6LAg9RaYp5gi7DaQ0UFlXrpjZHccp4GXPdpCvluKUj4RC?=
 =?us-ascii?Q?xcNoLbn2/6zHKcuCf4VyXrWcknk61bSSF1RORcKgvWUpdWVj7YousXdrP44A?=
 =?us-ascii?Q?MVoAhovnHERs/agdGkKaI2nln7Ib52eiySHpEwYV8upkHLMaV4IRZyXz5p1c?=
 =?us-ascii?Q?G9JnEb+N7hnY5rgVxWmAXqfKw0ezHcbauhbWBsxf8vl4pjFE1Jaux1CqI+NM?=
 =?us-ascii?Q?prXiFEMCrIoc80feB4/VBdCLJeBzRU9X4mAlisHYU5aPi3OaNdQsKlWydlzI?=
 =?us-ascii?Q?Vto4LnUxPrvtLRQ/XsUyeOqehJVBYpy12VGElV9nyYEE96BIJO8zomSDoayM?=
 =?us-ascii?Q?eSBGTSUc0a4FK15Er4y2pgjJfGXEhjxXtQkw8dgwIRN/LTf6k3RESX1VL00n?=
 =?us-ascii?Q?gdx/8PptaSDxVkYolG8uS49lj3zVPOmN1nBGq3KLAipo/rQP+oRLijg0HwK3?=
 =?us-ascii?Q?xyfYnd/4vrZ3FLo62uNMjHtz/sVrmSScHus+lJ9PdV00UKhaBnakJQQMisfd?=
 =?us-ascii?Q?jxBZNYnvLv2XcRzpywcj1ufwZnY6phznlutLW59J8ehkmVd+XTIzgAeTJ9Bq?=
 =?us-ascii?Q?Z6h9+Qe8PvazG4lgVLL0F3cHVl/TAiC/01+EQUztVtiGfov2i+Xu2hK2RAZw?=
 =?us-ascii?Q?Lyk7d79msAMZW6UBSdvbQ5fkkCYk1RyglgQ38P/g1qfKq4feTRGLQSmJLCoO?=
 =?us-ascii?Q?p9UzjM6k7NPFalyHRsgKkQbcfkXO5eDwc/xlEbDSjGWee2VhEKtRDyOQvvSo?=
 =?us-ascii?Q?8sFqoox71N40T80XyUCF9UI1nDHdIG8ZePl0DeUhAWiA5DyuyUryjUNTC2Rk?=
 =?us-ascii?Q?3EAzO65UK5/pjIin/FOL2yCtqRhSMRZ38gylZiTWL8N64dNqz1+g9JtzUXoy?=
 =?us-ascii?Q?wc/Wbd+qI7mz/siT2BT72irpFUSzeYgKZPvmcQrBjrY3QkYDOq2HU/ASjN8X?=
 =?us-ascii?Q?/FJYSQRUHK5DOyG4Ms3VUVnT8qk9cE4tKKcQAKwyPd8pqYfyN1162UKVJoG4?=
 =?us-ascii?Q?i+NYrblrUyRLgzuCeozhxqzuHjBGiL9tEiT7MySb1tvQzx1d8YwXaN3SXnpi?=
 =?us-ascii?Q?PFSOLnSb67HU+QIBrmGF9mgOP+yTK+vFIbVQr4mDP4cyQfSzdPSqCyiOqLUo?=
 =?us-ascii?Q?/IQe4A3KAXsmdVbDGCeoLSU3AJtREyYXJnOgBNHDrKRMnklhvnQApc0/A7Pv?=
 =?us-ascii?Q?M0D/ZGAwYsh1niNK4Z7JD3dSW3MeTPcrcKBwoCgV56qxZES/PXrqawt7Ok8y?=
 =?us-ascii?Q?VHN1LM+RuO9IK5tMX6NXA3bzVVEU0edJvSuZZuwl6OYrDaZqzFchojF+Q/8Q?=
 =?us-ascii?Q?xH9/6n1vyyq3Lg5sg2XsayinTGj81YPjGrWnf6aR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cef3af9-0c38-498c-132c-08db2a408c8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:52.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVCLEHcTQgTLYmOpWiMVAvO/ciDkMgCSBHTUkoetjylOS6RC2SroJNnFnbvzijDh
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

