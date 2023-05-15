Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE0702F03
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjEOOAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjEOOAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBDF10F8;
        Mon, 15 May 2023 07:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKNZpwI8oJ9OgedpLafiHrOJSAg7foh95WtYDTGagXIALifzweW5wAWxGEOJctMQVRF6MtU6Lj0aBEXKpWY88SRk3zZggIeV4H8MYkzjobun8vHF50ywIMjgppP+ct/kEBH+HNiYUrKv4L6zb84XuyTyME5jk3ehLJ9osFKIf/dFe2H6ALGrQZa0O+qhfNbBPV7ACVDXvSIDV4y+HWdDzt9Kz5zrM1DLLAn3DtW17kfFvbVCyjYzj9bXZjl1vaUC2zvvYedeRExKNWSknP55Sb1lZrp549PUm5QqoWG9oBEfRxe6Z7owFkvcMLZXuEmZnIwJWBWcKt05kyESfM8DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebgzZQWSCLvsHkPx9jJnECsKQ6BZK+Kb866/ltNuntY=;
 b=XWCcI/4aBLHx4oJ/tcXv6pi/GrHnWt/CorfyrxcW2DoGeFxgZ+I7Oqe/HhRRqmFAQr/AsGUMe2b6/KV8S3ptQ3HV6mopVV+H1B3DmlqqMWMgIamZs2GOyvAuwLk1233dkBwatRS97UwJaIuaTVQ+WS6Zt0hq8H3NKOYXYVVOTZ/4KPn2O/SNRjg/YMQgKiYDxy+US4KjfabkxmmXg62ViIA4sf3mcAVBBqMDsMD8uKNhSsnT4Mz33AsZja04PgvoRHCu5nl3OXCz68t8n/4tI02M6OD1ToVwW260GYfJU0wJlU/bGxT5ASfoMh92366Mx4CShxGEAXjEzkO96fzxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebgzZQWSCLvsHkPx9jJnECsKQ6BZK+Kb866/ltNuntY=;
 b=ZPpSUvcalinI8zP0aAgxY5IjepYgLquCOKVZkT0DHJcf7npWOpS954n8aZwW9A3HnFJmFWE5Pi1xPfeFEJB/t4vLX86eC8o4ZkJXg9FX5BN0L4EI0P8sNiNUqOnc3DWrTNS5yTHUFFv5LquHr6k+ziymurafc3mJsIK1pZtbMCiA4Vy5mrGdnyCJUhpy7wSjTPIg8PmVgz9XIB41GiKHHmk430vp+JlTmacumQJDP8FHf+XAGAMj8wwLrSMpWYA1Jse6HGjr23fpVpPq3j21X0F6nXH31AJcWDIokTW3eeaysVLMsACVKPv50AfgbfDX+R1bLM/TTQQmHnUsaaUeJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:37 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 13/19] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Mon, 15 May 2023 11:00:28 -0300
Message-Id: <13-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8f7983-1d02-41a4-a73f-08db554cc14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vXrlrWKYZ5kA1UioAjsKTZAg06Dh52vvU8tdLsC+qDspsTvuI++KRGcSkmgq+DRXGwIBfR4kzqDA28BWfVlI/bFeURq3kGQqm0/V/nlHFET9k+dCaiBkM5phf+q7tHAKa1cAaoIHjJaOozVBPyALrl/qdHT4FObA7tqEpT1P0wFohLsun4GE6fn7BR0bsttRqt7nt0+3tEZXnrToZ8qIoVMft51F0/u03Q9+TvGjIAu8gfbcZmX/a/nkeYMWpYEvIiqcSXPhMydHbsmtBSs14iWQmcr+2I+IASKvK6S/Nxr6ARk2kR3RSKvQv/QWbqIN2Uu8YUGvg1vFOYhkG+JAzFXHs0i+mw8qs4qvsHJIBzd9KLnKEma0/cuKCYiifPmsrehypG+9M01lInrFlQ4F89dds2iFfDGkp6bqBzERveaVJ+KwBou3hKLOXyko9kH3K2N6mXcbW08TP0IJUf3SJtHAku88UgDbhe0ZJSiHJBaJhV1y3gq4inqm3FVYDt9NLUuuQP2teRpT76vCnzn3uS4X/8iVAojbCN3W45Gqa9OpTQoOYI5dnnOnW5ZNdJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMI83+/tlhfIx2kiu1NLJbGeVZf4/DTH+SRpwsRlXeAm3fQDweuh4RU7RmlM?=
 =?us-ascii?Q?4lzjIgv6jwzZyxZFU8EdgxDgfKlnQ11a7UnEl3rDQoHEyIdE0vomYB5UDpBz?=
 =?us-ascii?Q?X1L81yE6+FIrbRCC6rJcB2RnfXqhb1M9yXk/hFwYyDTerndxianNXq1sUSNg?=
 =?us-ascii?Q?9fQTOIELIUhxQFLefNq6fFJOh3aykDaErsgX9QQVPTcazHFuk4qDul4z8uxK?=
 =?us-ascii?Q?liNLkyfqNrGDIShlYAQKlBcDHJI2s3EW2dgpfM/m3fRzgC9UcczFe3c9Tjqo?=
 =?us-ascii?Q?iSuahh8R9Im4YeZ5nUZECo3xQO8hzwuC5mKAV0E5hVf4ZAd0W/B8OGz7J6UO?=
 =?us-ascii?Q?RJJS3lkH6xXThDbCuLxpYldb1iRV5qedJ2BC3ujswi1emnrx/I8c29fbG5gU?=
 =?us-ascii?Q?roV2Vgz79Tyb6BLMUmJTbYHAME3eZ2DOYdKcH+Eu3Eyrxwq3UO/AbbIn6uY3?=
 =?us-ascii?Q?4yv01p1c+53grmUjxd3IYsTmi7JTyxHt8PLVKsXK4xl2Gx/L3/v/MSH9IrpD?=
 =?us-ascii?Q?o60qH3hEXROcUW36ks00EIEfkrVgN/4blOybR7OHLPxL56KzXixstCyPMOvM?=
 =?us-ascii?Q?Gz0FyePYxCW1cox/f75LunxUES0gasjpOLkg+fjbo/rod5AXj4OJghS1ueym?=
 =?us-ascii?Q?slj57OuG/ieI1gdSCjbnDbNoNdvEsKD8MiaknoMiV0NhX0j1mo9Wu86gg0RO?=
 =?us-ascii?Q?+gT5S9JlSeADvSRs6n9oBmpnri/HOZUKk3aa4FSfuE91hbag4OQJVQ13I/bN?=
 =?us-ascii?Q?I/sMm8XUOoHG2uVFepocNXzY2ufLbMlFLonpwMsC6T+jFwdn3Cb5T5XEZvAH?=
 =?us-ascii?Q?b15hBzhi15gzvI6WrYtfW572WrIyBluHwGTMI+7yyGWB9r+I6WGetYYs6aAB?=
 =?us-ascii?Q?qVMsX7IzJHEm/T0anTRkrzWM9oIcnqrZjZ619Pq2eiu0C9whvMt2duFbePzg?=
 =?us-ascii?Q?SkTDG6EQiWvMsK0FJICi2wJoUQTqpYb0hMk5AD8N0u01oifQf0uhXreW/riv?=
 =?us-ascii?Q?yMJHJOd5yk8gJBQIq7vQWlzp0BlSIVNbXTa9QL9kTvrR6ngI115GagTgAteQ?=
 =?us-ascii?Q?T4Pt6dRG0Yj99ERTXJNCxIR73ARFA5k0yaWMvI0QGwrdYC1MHq4OF88q/pvf?=
 =?us-ascii?Q?Gx35w3iOne4th9hyetIJncxRB3IMH4MS+7CM6X4R1LJm9FV1pBws0t/+0Ify?=
 =?us-ascii?Q?N3ra1xRS9Wxz09bOFBk974Cb9xLQzxBbWhR12IqDIKdW1kb9I8ThgG+O28hr?=
 =?us-ascii?Q?xJqITI6d+ScQxFY0n3MFXWGvaA+2NMq/pqg7C/LQKY5sAA8fVZ+HjM98maGR?=
 =?us-ascii?Q?p/6BC8dyjqA1sLUjQtBi63Pq8+5XyxYHVmq+uecWKHk+e7ZQrspW5mGIg3g+?=
 =?us-ascii?Q?QBckFVgp1CynlYDQelRZFErr7KKFLvnMstCUXHgyHinIh4TOzBjA/ajv41nm?=
 =?us-ascii?Q?NpKwtVRIyUCo9hMXAKMMVG3x0AJHiM9twO9K9nS5eBkn1ep8oOhh/LVZqC7A?=
 =?us-ascii?Q?YVpYSPzGk1oczUUvEx4J6iF7ZLVT/p/cg4DGFCZyUEV5QCu9WW+6gEtdQlRo?=
 =?us-ascii?Q?scIxbWtPl7pQ+M2vL2g8GoZ6m8y4SQkpFlh2Zvdt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8f7983-1d02-41a4-a73f-08db554cc14f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxwiTZEy9GSbca1Hb36sN8xga84HwzI1OAeexKpNdG7SqiqhSpPI1ZZMpnVRtAvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
index 280585965bfec5..91573efd94881a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,6 +34,7 @@
 #include <linux/msi.h>
 
 #include "dma-iommu.h"
+#include "iommu-priv.h"
 
 #include "iommu-sva.h"
 
@@ -2221,6 +2222,35 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
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
2.40.1

