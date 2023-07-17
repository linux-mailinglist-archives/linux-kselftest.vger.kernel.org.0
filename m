Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444B756B79
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGQSNb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGQSNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27F10CC;
        Mon, 17 Jul 2023 11:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ghk0nItDQk/sAaUnyrL2SF13ic54mE+OXH71KAFDBi2oU4sS1EIkrX8SvjOfeuJ+E5kyciNeuu71LVUzC9nAG/bzHfWdrVNzsJ9TYLv2nZK0pxnbZTULiC1/vYffppcBQBT70pQJqqu43KcH9ubYvD+wLmEu23hCPlGr0GX3MhWkKTi4LQ1csvVbRYmbkS7hVuZqa5Ny9Rhz0itXGY5tnORwpp3G4MiHPM4e2NOAfKBTKW2ABJtYQDhgbjBYMgnCQCtjn/plaePRaEiOlWPo+yIAuvMkejhJ649+aOHU1S9/j2neR9RTFATvuzRyOMcFgX6Dio1Ou5x8ktHFgzPcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwrr+K8C6LvTSUm7HLyEg5ozvuzlhuxJh8GjjAOBsdE=;
 b=IN2Dxfc+MLgi8IxFRiiarKIDfWig3Nr+iQxIju31mKTP+ZXO/4BoVy/XqY386vaYMJbl0B3FwZ2DTc1sknRMrKsDtruwWIrmQ6suok+lvMVo3d8UFnv0adyr4A0wofofQxWd0sHo8/HpsQE0X6yArY4rJ2MTCLLeKRSRKFRgIdaPbkOLquhJtyd0tefnUkl7i8aN1mTxiUF6/AlNRKTIN1VbuHRav3QStKuAF+tphwyAAH1J098tirvXjHFJu5KwmZot7QwWcel1fw7NL1zfWnPToOmBzGAcSky/2r7vmcvkm7cvBq5rIqwDS/WpQlcB6f1hEkub3DWAEsy+TFLIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwrr+K8C6LvTSUm7HLyEg5ozvuzlhuxJh8GjjAOBsdE=;
 b=E3r0GChu3ZCOFA6hXtXE6I/jwur2PRViptvhrT4ixBhLk4wIXRePnW4BzCxMtRjvqWwq9QnBx6yMYQTtWCGN7xR7FkUCHaT1EzDbm+XED/qGAqbpcrsY36F5uQUD0Eqw8FHUDHvG/VwJ9AlQUwykxiN9YJtlKQS6l8oRmSDHrZ/iYpZ5mss1HEtBjy1wGqCgKOt4av9XIOuCmAlQ5m2TeEA8Hq+b3nef1Q04tcB/HMk8FvrVVRoytxciE2ZutrSfGjmJ42uCQnwvg8vkN3NcTMfZhxj+VIpr38mg4GZ2aUNyQdbeEgwATWN8yguJndIh2qnH+2ESE7NDtcmbRpJ/xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:12:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:26 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 13/19] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Mon, 17 Jul 2023 15:12:09 -0300
Message-ID: <13-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 086fcd08-5f4f-4f3f-d6c0-08db86f15d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUea0MdkPuUiz06supNMfkBAhlareefSbnlXBnTe4HhduBAzPhhy5JNz/j4LZmuSV/Zusc+U3r0rvTiZ1RZJsPAS9+l7ve0/HwCnTYDXjnNblTsJPCBn+gq62hQTePpZv8boo0UD4SYnW3JS5eHJVRNn0NYpej2zPjwwoRqtexqVDYb3voLl1/77om5qYLSjh1vUMYwNlrfwXYtwrbMR2zJnlAp1eg2tXYt+HJ+1xIx6kaz3OBQhHwqrS3jCP5MdpD2qyyXuLpA99jbxT++5mUjiUnA6HmtqyTeQONBaTwLQ08Q0u5YAza/7Uwcl1gySI4+qBAnLvo3kDQeEudQF/dZhNfHoht8/225ONTH/x0+7/KvW8tq21SttSFLTLdj3TprrNdUPQ5tTY3lirtv56MqBk2c2WUnyk0H9ofvdpnFvnQumYjZO7pY0c+0bBzHPNtTjxALpBHbfC+axdxB4aD7D8mflaHQD1MKDa8ytXDKFADBnAdRxezi1qmcSgGcWbLH28KFl5yBVNu1BG0/Vf3cEXA5klbnK/xwfxhjy7S0u4hk+TnlKJ97cEkgpuTXK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(316002)(41300700001)(83380400001)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(5660300002)(8676002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?De1WiAypSzVi9i65KeDVczn5KkWy6jMsu1BxVeSBs+HLTbOaQMER8AGlXD/r?=
 =?us-ascii?Q?Cjgak0dj8dxzS+yQ/mMRRJHTjW0V7IDeJ4r0yJOmNNCazl8cbSG9GpVY9stT?=
 =?us-ascii?Q?VITcqmSEXh5LImq1v5REhgrWXX7uapKrbKl+YeObkgopNRtXT4UNtQ/cOI6K?=
 =?us-ascii?Q?Qj6N81ht3VyEUJx2s6dRxVLNRW28+Fxl1K+4Fkp7wtXT88nh5fJmgE1h4kxR?=
 =?us-ascii?Q?AyFKSblbuhZl4UUdrW8tlqpU8/q42j2xAUX1OawPJFb3NPOIILFdoO6SM0kq?=
 =?us-ascii?Q?cWm/XeSsepJupYGV0wekaC6f0qvRQ8T8i9vfELJ1iTJZFcyntPRiH19G5NJm?=
 =?us-ascii?Q?tWhqaDsbTem0xcQ1714FOrOBkBSgF40XG+L55q5OZwURbzF9SoDhHW1QefmR?=
 =?us-ascii?Q?ovUqZqTUlEwag9rQqcSUQQ8Y3Dc+MdTZYS7pXXmksJkkYCqcgSSR17rItS7M?=
 =?us-ascii?Q?2fY00Qg3ZPQkR8iCFKcLEzoFf3ZJ6NiWXe5/ahVH1UnWj0xLRWqkBc8b+s7g?=
 =?us-ascii?Q?zmMlEwbFCJ0L8Nc1lsXdf27soLs3ZX9j5yc6GIFL4I2wohGNr1xCFC4kMfhR?=
 =?us-ascii?Q?L80Hots7dvFnc2OTkM5jriVfnYYeaKoElVGfOtdCClJC9HC+U2a3AnYLl1Ve?=
 =?us-ascii?Q?5jB/YKSogBzQuB8HuZzRmNEo+rlQEOrkcSGHA/kXJE65n1l/Jof232MKuk6G?=
 =?us-ascii?Q?yz5f2mk208POroBrdtOS1HGNI8JYeW1tSmqFol20AYayoZf/T4XUcKvYWnmq?=
 =?us-ascii?Q?SJSIIZ5BKxrWABGyNJhxrrdUKbotJPHkFYzKbrP+Y0ON9p9Bxf2TO6OJ6jFr?=
 =?us-ascii?Q?A491FBPlmSwWOap0UY1QlhAphNPzElGB5Ft5C9DE1TnzLdnNrwUZgdkHwbyK?=
 =?us-ascii?Q?pWCtdkLG8+gOxGJ1oH0mNtXim6uK01gYcSzJB6fL3X56126Urk6DVha8xnEQ?=
 =?us-ascii?Q?3ku1FgfAGQFe/5IaDN8GRfQvYA4ZMXJRClxnfUQScKORy9Li/Qw+BeaoCg7J?=
 =?us-ascii?Q?47Q+eOfA5HUTylj509zymRupEjacc0ydEtO8RWWZRiVfrMiGcXTwi3sJ6rz7?=
 =?us-ascii?Q?9BqeSr8YWl6PZLE4HjH8Szp0/ED09TumSRX83NSB3oPBCj2ahDoYSjcJ0gUj?=
 =?us-ascii?Q?9zXVDfR9XkY83QgkTzVVLQAcKOUQCEvaVA1i/uMBOwJiTO02Q6KKCOeSE9+M?=
 =?us-ascii?Q?YgImJojgTh97GpLshBiis1FAB5xr8arLJviZMLJUS8gzU/nvHJae0wX3z483?=
 =?us-ascii?Q?qtVYgWdt11eNgxwQqfYRvtqdROkx+drdRcHGxY6WRZW93aN8z0WrHjMH0Mh6?=
 =?us-ascii?Q?smb6dBgFAsKMajP08ziIpXwDbvDcgRNV4Q5Z5vdWBJOZNKuae8ftjecOw+BJ?=
 =?us-ascii?Q?VDQCVdmb17NyhtQWne2s3YfaeyRVRZfXpmfBNc08gcLoX11AO8HrzIXdKV8G?=
 =?us-ascii?Q?udEhsZl3YgHRhbKrGG/BK5ZZtB/6IcdObL+Bg8cscAzAapipy38xw2j7a2Om?=
 =?us-ascii?Q?RPFKHi/+ot9C4/Eo9rPomKVGoMA8XHrQWi3buJdTMTTeAHelR251lEklBDLc?=
 =?us-ascii?Q?JFzMFZwHrQ3t27gK6xY0Kx7WTStSvDV+TjsT7Mtg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086fcd08-5f4f-4f3f-d6c0-08db86f15d16
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:21.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wepj8no3NBCb/uOn+4KsDY049Ijf/2tOHZWPzjVehsqvGk7HV4tbiELt5yhdKyGu
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu-priv.h | 10 ++++++++++
 drivers/iommu/iommu.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
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
index b0804fbad6f9da..58761967657371 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,6 +34,7 @@
 #include <linux/msi.h>
 
 #include "dma-iommu.h"
+#include "iommu-priv.h"
 
 #include "iommu-sva.h"
 
@@ -2114,6 +2115,32 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
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
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
+
 static int __iommu_device_set_domain(struct iommu_group *group,
 				     struct device *dev,
 				     struct iommu_domain *new_domain,
-- 
2.41.0

