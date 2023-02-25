Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D366A2586
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBYA2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBYA2K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CE19F3C;
        Fri, 24 Feb 2023 16:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdNUfwOOjXZdLlo2ibIJ06aiF9YwL4xJ/+abNXwK5R7hvnS3KIMQKgKznUHO2HlXqrmNwWNisMf7NAchzI6C/uZrjvJxYxG3cPvEycdu5QRfZgJou/yjQlb7e+1QMcuiYfyzR4JiWGS04c8/WQhb22JMmn97XkLQt0OEc5tcQcv9g5IoPylILO+gB+SUK84PchFAZl3/PmJopRZafVPFgYyZARk/8LphN1qPBdyr3/ThSWGitrbZTiH46PwqzBPOyimEGB/a2cG9IojJYQIyV4I67WO81pmEgEzb1TBAnB81bjzeORf07T2mb/ximJ/OxjLtabNJXDmIRmxjwims0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss9a4Pd/0GLcdwASCAR6Ahbzror96iWMtEj2Mk5fVuQ=;
 b=KkogLPTJrha2ym6cy5xlBFvAGZW3+jjlec64+JzdkzKfmrDDvA4UNuLVPJu25jPcnu8pbLrS+Ih2KkUsUKFsMqAwWY/GPuUP5VkQUdODqcGQmmof+wZG8Dgz7d/zFui0dbiet4OFSklofLJT1uXe+7TMEdvqsE0ymvWEulY7Tr7u18gCg4aVN5AtbiWmnLkbVSxQwu/hrxAGz8nljiTqKFpJrtRvERWbkU/jZh5Hc3nd+BJh4b8DhjJKASKtyxvqbPfM9Rhl6glv5ZbTvM9TeODDhS4I9+DpX6lmqZgPZLwY2oMDOeGrn2frhAUu9Ik1ePIwvJMhk2DgpyS895s8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss9a4Pd/0GLcdwASCAR6Ahbzror96iWMtEj2Mk5fVuQ=;
 b=NZbGtEmkTjGXb9ZshtcogMJm5/twAp3TxiVP6Tuqb3DDddAacHbDfijqhRG5yil6tz5xyMzIIZ5m0Ef4p8vpctPXLffqONZpCPbtynkK3XJwUS9VRqlfn+PfI/WLw5zFtZ5/7bv1ZitqEQ09qwonOmiUbS3sLa+iN8XtQqC7eVukuYVQ5iwQkgwjOsU62QthLLABgFsqCbOtUrCPzEm9GflhETb9UyIQ3BilUc8VJI3jLrvcdKJuvwyTgvPo3q8fyWfZG5p2HBnWziFHwC82WzIWypcKWusa8GUgnZG6O1KKKr+HEBsD7Y8Iii4DdsN45mNxlIsKUYvmkkDXRf803g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:06 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 08/14] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Fri, 24 Feb 2023 20:27:53 -0400
Message-Id: <8-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:208:e8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cebfb65-44f8-4623-2a29-08db16c7279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SbtLqGzWahXPdcLRUOi4Jonwbx+BVJ6iI80HGuenGBRrhwos7AKeIuaI/8ZBunMPf+HrHmyP20aht73G4iclZVHWpkDG+LWuCfucJvDUJpnq+/WTikzimd9b4xWXPH5N/8Mm9icXO9qyKhTkAfaftoNQIIwFcyWlC8ToPTJt43PXtuf9Yt/GM1Ka88uS5PrcfaQOYh0JozcKFCvNqOF5DHcwtNY6g/sDZr5hDdz+xQLn6CGW3hQ4JGIRXBHFSBlgI3Dc/M+ojSQvn7n77gjauMsj1trnhQd2/Jz65uvgj/CdUDP4kqy5scbN6URzJBiJhA+rj6g8QXc3lVSoEi9qUhSNaDZOeowgDeApsgMF5U3CAMClzdmCDiEiEprBxZA2kauOq9DQ0QP8rZBHds0wYSbxlW0h37DyAsHqVCSxWKMY6ISFADB5TwQOxy0esXX7TRvM+0tPbD4Fc/2blhVD8FZK73aRRfWRKfheC8sn+z3Oi1oYLG+kg/gt35Yx0D8DnVzUtk0Fb5J73bpDGAOuZC8zCllJak9Qz2HmUWAfw7Po/ZsSybK7zStCzfL+9tUADymWnCyF0dx8nVWnWmUgWz6RD7PUHtA4WPe/rJU4LBI9ITqTbpxAFVwlAx/Cevj+7Gc1uK4bdpFkN9pSxsi5rwsyWhZQPxoxk9L4Q8eC8zal1IUt8K5x0WRfnX5fQQF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(26005)(6506007)(186003)(6512007)(6666004)(41300700001)(83380400001)(86362001)(36756003)(38100700002)(2616005)(66476007)(66946007)(66556008)(8676002)(4326008)(2906002)(8936002)(5660300002)(6486002)(54906003)(478600001)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHBNu6Hy65jq/g8ZQPX2uj/54aJ3J2eW4wTi0ePfG2uoSRwK1xhLbPiw+kL6?=
 =?us-ascii?Q?xqRuY5GDkhhUZUgis8T6E8VpFvNJ8pKRkba5Uy+D7mHwz5IjHLulTmFNKhxC?=
 =?us-ascii?Q?wA6ABGnS9+n4tibdKZym8Cgya2omJ9DaAhJww5mUZD9ePNcKeWv8S+FUUQYJ?=
 =?us-ascii?Q?/5XIQhCm/rv+nS84nAN8bA1Kx20H06sry/FtVWxz+rxQckujzZvDrBsMhOqv?=
 =?us-ascii?Q?STeWigDq4csss879bCqSwC+H8CHtJ33ad9sGml9sOLTFR0aRp6bPBL2W8htW?=
 =?us-ascii?Q?qgOnNbaFac38b+Z6yxNeurAItgmLq98zAMdA7KFjje/EMlT0674C3QY1irl+?=
 =?us-ascii?Q?dPwMg9c3Y5KRz9OKgjL7CHoHpa8C0ScPegBQv7EiWGx/p/t0aaJfbk91gf+o?=
 =?us-ascii?Q?7ZV8X5CUZqX6Xf1LQzmP0xkivo17zqRV91/gDISL7jz8in3sp5vWrr4XVlRY?=
 =?us-ascii?Q?/mZSV7DK6RCluWfh44X952yv2vKW3T+nUYeR5mRXm0d3GvUQ2Fii1yvJ+oK6?=
 =?us-ascii?Q?NOaMgmHjw/kbFajin0rRm0S6HTWO3hntGKcV/vDN1rAsk8A/T0bWOiCBlQGW?=
 =?us-ascii?Q?KxlrHX8EjCihnWQpz5u/kgil1ztr2V2vrBn4K31GWgN+tokFb4kArcE0IgGg?=
 =?us-ascii?Q?M3sBhw/jfzETN7wVNo8VeK0XnebJ7ie5ib29B3usqqXvjw9Gkw6FZaV8MMn2?=
 =?us-ascii?Q?+RKMR6VgclpHcXH8q5aJFk0GuEXQsXPFcVkN6WitscS8RlNxNF5Hef27WaT5?=
 =?us-ascii?Q?E9dO834w9e5BShAKxQh4YoXIuYv19DLPES/UsrO3xCptR5SqVjfA+9DQ64sf?=
 =?us-ascii?Q?Jn/Ttmc1nJ7JIOfqQfpzNT3aDzXCKQOWQIOgrdTzZRh7kOpQHzzKrXBUgzUh?=
 =?us-ascii?Q?yf1kdaASDIUDIRBmgI9Rp7eb0k5wAHSkKrP1Bw2DMHccTSVnIEpLeiMAG9UW?=
 =?us-ascii?Q?MDF95brS+5wDetzi8NAIv92tR0Zq98QkVBErUOKsA0WpuUAs8N77F7oyKdGZ?=
 =?us-ascii?Q?OB7djN77VTLOAlG/xnKZcIVKdvHZYMZwlXz4q1vRTfpIEaSBV27tHiRFeyIe?=
 =?us-ascii?Q?FIne/+qm7oa31a5v6O1Shb8eYwVxeiGYDKlGy9APG4zjlYzn9L1aCTArC+dq?=
 =?us-ascii?Q?GctNTXKylCf6TEl4BzhN+RJrD9wnya1ByXexzCA2xM25QP3RyQL1IzwWlv9A?=
 =?us-ascii?Q?Oy4NR8TGpyrIAaCWnHelyl4qRU3t5rNrKPHUnWd3jRbipbbnEfISffK4KAeU?=
 =?us-ascii?Q?nnIysNU516kOSx9+HnzVOx/dnTd3kGR522V4KvpF0gs/2oJPTsM0Fu21wAhP?=
 =?us-ascii?Q?ET13W1YIKBuqjxsDVzEdOYqx5wR5NVxdVjEfYU+0a/jC4w1f2u59sSonBgjx?=
 =?us-ascii?Q?Xt7cdEjd6cU6MLpnY0D3H4j7jiCuAuQmFAgfV0plQict5u/+snoqb5Pl087a?=
 =?us-ascii?Q?gwIVk/iJ6QH33R8BCCLHXQVdC8iNnQ3fblGCKqppRVUM/asZmqf+DYMQ6mxv?=
 =?us-ascii?Q?rwJfLKQSaOENrQIG1N2HOq+5GVp3Vnp67Z02tZv6uAHqPN9/Lyyc6V7LXvL0?=
 =?us-ascii?Q?q56hxPNYm3A17k+3pktIWg9dIWlc0+4WhThvnSiZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cebfb65-44f8-4623-2a29-08db16c7279e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:02.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8VkXBBLhZ4IuWPJ8svsF0QpnsyUwn/NMb76L/RKvWHuN2+bI5Z8ViUA/aoVwHh9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

It could be possible to adderss this by simply removing the protection
from the iommu_attach_group(), but it is not so clear if that is safe for
the few users. Thus, add a new API to serve this new purpose.

All drivers are already required to support changing between active
UNMANAGED domains when using their attach_dev ops.

This API is expected to be used only by IOMMUFD, so add to the iommu-priv
header and mark it as IOMMUFD_INTERNAL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 10db680acaed5a..4c91d9bdd114ab 100644
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
2.39.1

