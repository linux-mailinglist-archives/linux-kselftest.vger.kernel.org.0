Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462A6DE14A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDKQoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDKQoP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76D55AF;
        Tue, 11 Apr 2023 09:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7o4pb0DIREuOIBFUJpayfIB/rC0ID8Pt6O9DwsfVp++dwJ4lyytMtib3dkz4HVrH+TqGx9Nfh6KRRZDmM7iVdnSyHwmE20YeZkLbXAhpK6O+5hVnSQPFIn4nHa2Tso0p32mvxFh5RawnFt3gvdRomemgalwc0CN07N4kvzEa0bQRDhfIW8d9QSVGA+4UiSBGkuyF267CLPSVcmtKTQggPhUHrE9+BhoFnyZcUfzWgpX3gCeFzm2hfhz3gWv5Qe+mXnCeCA8E+OcP3m3ra2TJNTTClVq6erxKymda7jpb1xRVeUPfkDCXY1DMGDDm+H6FNrUK7pu7Wqho+irYDuWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=Croa5QGThs6PZRxpp3Mh8bwlm+uU0lpfXzNyBIDAZwNRPNPMWo0YAefPbUN1mhgO4QlRErTMRGcQIbb584KuKDaJM6tVGjr8NR3KLEl7CQ8zsZRWrX1MU+4Q2/i3/GufDkeZNuAnswz4Ju7HB6KOBCyoMxTKi1cJWHHHiGEn0bn95+knNKbEM3JwL5jxh6076wC+mviuLRJYZfeWuQHhup54z6lfAcw/jyGQLoAaQibiaMeZYyDPuXM94WhaSxynMmlhcJMTwZdBJ5aQJGjg0X+RdHQIGu2Ts9Pp/vEJdkJaG00ZpPpiat+A6zk0iGXbakH17rFiPATfA3hvCRP+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=XhZgpf3Ta8bg3zkK3Zzkwf7Y7EsOnpVcMUAfN9pnP2ALk1cI6Ij74jNcEjn7cbRXEzlBDwIFpud6hj1m8qKlRtpZukqviDu9eTnaNH85b7G5KJxpECgNIQAslmrtJTkWIniXkurEfbsMZfX5mFA+qx37kq2cepFNhiPS3r6X9K825ZdbA6qdLu6CBRZAR0zs7oSEfZcJPck39Cm/8d+j5pTx+NlZtAZrC9UdY/Sq3zygkham1XcWNmaNOPg+RZ5j3A8nUUhX84LIwoWsts2wpHxd2cQbkXlWX4anEA8M5xHFdRcWqfQf8TGeio3s+Mt+75XhEZuxV3xvwespsnQDsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 11/17] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Tue, 11 Apr 2023 13:43:12 -0300
Message-Id: <11-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: d8190818-4855-451c-6cd1-08db3aabde3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/y5hUeR61qNQDGrdmblI5q+zcvpetl/9sylGSRjx2nlxZs/uUO4yTxRK8MkY0ZBUHQj8fFzifD/zwtuBM/JwfqnqMnY5+OCuzzsOxeTck53rb0OuaUcS1c0M66cejePtqPK4W/w1OtIbtTDPVGjgD7xggKzRLjIbz0S8nhcoIgiUld0+qckYi6CvVNIfUD2rzH/Of3k/tr86JjMknLX2OZSIOjUExk9ZjlElhxItfbVmDIjaL4/dPKdW054wziaVZMFy4YeOetg5gzPChbIo3/FHnxazrKOWa2pFV6Hu8JjU+wo/L6wg35xuLGQuncX6cABscZp9Lu51hTXPYafYBDvVDjVRLMxWvoWbunkDw6nI640/uFHCfzwqlxsiYRiZptcKK4wWY/q3DKFCQtaBoS+k+Xvw9FBcyXmm7NaR2fCqDMayE3RWArTvQaEjTqBTTUBr+YL0xegcbEI6DSj+bY6f54WXNcZLZjvZp7gPNt91ZzFb1RQYaGLZ4S2N0d2jc5EU4kYwxqEQo9XQxfmrZ1miiVJdmyK4fm4D5VHvA5/bqpsrRTDr3mO4leWybLs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0QVQNGd2eGRLV2+ITGB8NHtUPi9HDyzLl6AYGmtRad5RUMI1tDtmbGIU1Nvn?=
 =?us-ascii?Q?T3+9wiUBISvsWliXdptqu7Z1Fm6zivTUiR/7eZo10xDlEZXJ2Brb9JoKUaIa?=
 =?us-ascii?Q?+S/bXVuIQC73fHfDQDaJYNvxEyC1U/SqvHntIXwsv9CRNQ9kAGVqQTw3X/1C?=
 =?us-ascii?Q?Bi4rf9t2xDzfHgCX6YrkZT1BDmfnss7xblD8XPWfR69E1UFiv7uhMqTlr4QH?=
 =?us-ascii?Q?wGsbqig/V7M6/s5jvaURoSx6P8+hKyA+xgkTglIi2qxtkBz8yHa+lJRe1/Xr?=
 =?us-ascii?Q?UZhqwVVAKNLmBHk4HS4m4YQEkYuwtuE0EvL3/JB1qeFhB8x2zs0496XD8yE9?=
 =?us-ascii?Q?YK4CcNnbcikATgybQZC4/hlkxEy/b1OtZK5TlEGUn65Sgpa1PheSgvud7TKj?=
 =?us-ascii?Q?gdGmPtu/ELiG5JHAQLuNpOuCiF0VW0VPQS4cHp8tEMkPpMieokn1saFMR8ZT?=
 =?us-ascii?Q?RQbutlWy9iTysn3fnGLBRcbrsTWPAHx70v33nShIGQFjUgtZUlwcjTGG+fW9?=
 =?us-ascii?Q?zMpI/+2QuvdRNF6gxVVdOdkjJIhibq88HAfEUC1+HozC1sJI+zyhtVx0Ladt?=
 =?us-ascii?Q?fYb/lX+cXkQRMJEunGNUjtlSPcGOOwMy0xuBeydXVYr1gWLp5d2L4OTVb5qB?=
 =?us-ascii?Q?ijE14y0Sg2R0rQjby+XdK4QHOUfbNENw4quouxOPKmK8HY83GnZzihA0/0df?=
 =?us-ascii?Q?8QfVIXpZaYMVwgmUwxR3gWgqtvgaLCg+27mV9gkNC537lx9QlXDJ5cie4qlX?=
 =?us-ascii?Q?IaEtItmP8fmm4beZzTEKiYcg90TemPLjwnkA6GblhtSyFceRDUWfMTu5ALxh?=
 =?us-ascii?Q?GtAmI+g3P5hiw+19AI/5ZMgNiikkIuYpY9rqRbeH/g8tkS8ibOIOI2T8kCM+?=
 =?us-ascii?Q?n6TVkz9lf3C3uZ1PWsu9/9j7SaBHkaMqTFgQ/29WxA2yxNFP8R3ajQmC+sSR?=
 =?us-ascii?Q?lxX3bxvJuZ9DfpkV3Xv7082ejXk6tSopbnps0PBGZzhGu8f9J3jLH/8OgEnk?=
 =?us-ascii?Q?dCUEV9UxspJlGtfkrcwYjSUfGVS+EPjMosc5JT+W6FxWPdP6lZY1KVRRWgiJ?=
 =?us-ascii?Q?W1VoDY+RRQD5IGIL3DRPNjVQcDMJOlSqhkTFltMX/5n92RMV7FYJzhezrCM/?=
 =?us-ascii?Q?eYFHIWJG6l6rAAL981wsgqyZuxLwD4Po6Q3Z69PHRl24Ht5SBkf7yXYCkqYZ?=
 =?us-ascii?Q?cgJN15wa9sqW1dbo2ErCRYXtEAa3zX85ti4rG4IjYIsQnDxHlNDBld2c64Je?=
 =?us-ascii?Q?h/BSOTZ45pwch4kI+a/HPQEFNPgTsNDKI6c16U18sNWrBryXlEmKXpsS101S?=
 =?us-ascii?Q?/QlLaE3dycqfi9IMcOAjlRCjz/p3GMUY13wxPpfGRhu7AlIcDTAsH9Fbklr7?=
 =?us-ascii?Q?91hmdF3q1ULrbIMMQkwl8ZLTDbIarem9qzuAFIX7TX6LqvXvlVgxuVYIQ+Lb?=
 =?us-ascii?Q?2WXW8AysQ6EK5auCBQdLWl7HCYdQeDsqboPwYkzr+1f9TokqrRMjdEYoCKFT?=
 =?us-ascii?Q?Pw4WotUVrfTCBB9Zaf9ADdc5MUlS9Z0zFKjvWFJqu6QKuCsh1CrJRFqp6S8h?=
 =?us-ascii?Q?/JUgJvbWmlQOXpBVp7JvDWQh+T9FVhaVcnwoPOi5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8190818-4855-451c-6cd1-08db3aabde3b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:24.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE+ID1B3GCskiDjkk8y16bhyLXwvgnUkPHUAJh3ZeVefbgc63Kf+KmPKYu7FliyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

