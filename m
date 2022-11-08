Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824162051D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiKHAtj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKHAtg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDD2791F;
        Mon,  7 Nov 2022 16:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ3+VUJX/mJ6HZufsJpj/1o8uAo7RBY26liaA4303/6KDMlO3W3GO3MY+d0ucFU5k7pUKzP7ACxZEyj4YXiLxUFN93qxNAujBrwJUJxGJQUuVTIDyrcYI91aqSzp3Whh0dvcDcpzuY3+yvnhlp/uP+gYvz5mr0jRaQinNLpR7AWVZCGhMHzcbcy+Zy+tMb9BRlZm1BVPVA9poJm4g4+EQqwxVTHIS140K2IW9oNiv5NMfagOfOwCILFHLal7xxhKnt4LGtiybXsJhDby+YkY49DcFRiJDIU95gGNDrKpUEK6fZ55RRYyBATUNzOFkF7r5859NBhRXpwzVNtjEKlT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JwB10mqHJHGnTbsTJdsTOIRX5vOMI9l94yolqRobDk=;
 b=j19A3Rc5Az8IEQOypnrtyyMtDGzRaWAzd0FvKCGHZaTBrLsa4cAKWGSdv4luk1ofL2edsZkOP4k+dxuPlWfBxxu/1evcWGiDymm0FBw1zfGnKLnVouTNzumDZovsgH5fsqe1HiQjpTqdLF+VH+mYQAy0bLxgailNl2pSpkh8JiI0g6rFJkLh4Y0UmOj3NOM9jSMcRmUWh9H+CgXrU0yeIH0LVaLbqcjjycFrzn97nVcX3YgPyl4DvIu0vubcyEevhb4UaYMh2ADFUgX8dpv/GLsXOCIZ+W0O6rz5jN07SUgioEv8l94EiROcTXtdaPHjz0B4zDGmCRjjWkIm1Qirrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JwB10mqHJHGnTbsTJdsTOIRX5vOMI9l94yolqRobDk=;
 b=DaagreILhSbbi/Ssjb/lQjBiGpOn4Jdn1hMiih8CuSEoM4E3pu7b/AVPYGtXqfaR4z2PJ1+AQYY+bFGRTuW6NsK7hutYlA5W8onQbYjUwGjhwmb02ZQ3C0KUqqzqzGa7uVm4KYO4gLMUnhkahxCSRlV3C0Qjaig42yta5KrHHQufdZLQF6weNAlczlmudVDggHAIGUvr/Fm7LTQCZ4wC9wtpbGsxPrE9z2CNPGAJRJwcBtNmE/+txVWhZO1FvMu+Nma2aDn33UpDVQLb5M2+lM3z8zG5S7J3v9a1zUPOlEFI3MMBjpICSUQUazhefxIwu3Cw2u1YJVt2mczaP/7kAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 11/17] iommufd: Add a HW pagetable object
Date:   Mon,  7 Nov 2022 20:49:04 -0400
Message-Id: <11-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dc971f-030f-4efe-5ecd-08dac1230da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbL2aw43VN+jou2A63ZE6ke/XMgJDJUGmSYShyHmDbXnMWe4U90/fIKS8GMOnNWax9ZAGmHKKpbjKyyr7U7L+nC34c+RlahR66ciWttknzZHVV1n/f6pPYbS1vWmUFPMUu0t73Tk3WCJuZlGNFMquPLQ3xcGm4xwHFCIibYX1M0ZxWdzsMyItsEm18R7y8L2744P2LPVe7OkcA6U8U5iOWxBsuLP/U9x059NhmWLKPuAlitVa5JB9ROAzyh+qfBK2zNca5OQRXFdrHvENX7wzwuvT0zcr4SGoGZ40XACVcNIqWk5JDietLLOBTQnnW55Dn4qsrLNYLZ2diOl+sl1mLRuEfJYn+oX3DM8KE7Xl+CsQCOLVUf90QZNvE/m5241N39dhWGdnvdn9W89ChV+v96LjdqmtBsAXFMuHPhBT+7u3IHCd8UX9atQ9reMfliVC3P4Z4c/LOhWmJwhVwkny/4/WdPPjZ3TvR8RzvwsneR1TrkIFiZqB9mbtA3hGW/PnhF+3cVJplZKLw21MHVC08X6HHRJpa1c7Ozk1ndECAyWbyrWzisU60RFSeaIGU3rLTTaYOtnJPXJqELdgYebOzzRsuFotELYw2cAUXZvheXKbSmlO0gyBACVgPGRH+AkzONNu8cwILfuo6nlI0bkfrX21lwb3hvV7JJCOdZKDKYXjbT4lucE3IKNQjihAqFQKFe8iPu2tg3N5e8BJyvv913yHRE9dkuvhxW6YgoO3EKuN7bTtzWmHHIAYfVaV/YY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMu6iy2FGzJvkja1MWw7Mv8OswixYuLKVxEcXESNGfXd7ZkJbf08O/c47qa6?=
 =?us-ascii?Q?R49Qnm7ENKLpoCyKHd1DXwkbEVR23hE8MRthMaC0GpcIJUC4NbiPW8C/KgOr?=
 =?us-ascii?Q?9ukFHxegy+d0pTHisRZreypK6dK9dCBgrnW+oZDstKT7jXwBudCgsv8OYwjr?=
 =?us-ascii?Q?85umVN81hP601i1nN326MRGq65N+Epk9NISTLs25fK1Y70bEBplzX67aFMsV?=
 =?us-ascii?Q?dfbxKu91WtMsyM8dxFgBn1ZtShCD1FW0jicxv+tOiZ9LgEzPjYNGWTJNXc+I?=
 =?us-ascii?Q?DRxnKHGH9dsVB40bCG5zto4cZP3V/IDtgTwUCTXasF+t4WUwtYWpiZkR+Ajh?=
 =?us-ascii?Q?Spn5DsDvYG8CD1WAAuc4B7IJs2sQdrndugFdHfQj/DFlEi5liHvKG6jvwjYT?=
 =?us-ascii?Q?j96I+RddRgzJfDIlbDmcIYn8KKpNLlIjDm4AvHo7Yq8ce2TjEa59feSm1OmF?=
 =?us-ascii?Q?6jHSILhQvmET1e8hnNi22NkWeAC+lHbp9xARwo2P+1fAcklNJd0eKvNJdu8U?=
 =?us-ascii?Q?slHQP24SvE6b69lVXvfFjQ55UbR3cn7HN7DjCAs+uaV0HxNPjtRDXR1YRiz5?=
 =?us-ascii?Q?ONfDhvaoNaac9C1dGWSg3K6tILdxq3M6Vxkh15gWFVcbdWVAIJfiv8dmSQnb?=
 =?us-ascii?Q?QqgeFxyzLjs4CK5I6ubDtyaSkCOIGNYwvXDgbg/MVNk4Q3FTDaiIojDpSdRo?=
 =?us-ascii?Q?yuYtd1fAM2ir/jSLaSmQAz7IKAv7NMjHw4upRERxZBJzRfFcQ2iCj0Cf/hFO?=
 =?us-ascii?Q?+uFYjE9/8J6Iy5D0/hBDx5qCJw8bnkz+WRbjCeEkETV4XMwBL4kjPy2EXzZF?=
 =?us-ascii?Q?yYnvmpFWAA3VPc5TK/x2sqT9dyi3WHZpNVIH16k6/nJJluB9l1bEYmTzvBJZ?=
 =?us-ascii?Q?wyeO7iEQ030Jxiki8qDuD/7M9VFJQDfJXnnAIjCV+ftOLEPhBbwKKCOvgDHc?=
 =?us-ascii?Q?hIs51XNzNNHY/p/2Qi4pB9CLQCYUnFYbsWOKZRLhZi1wxigEfxZ/0f7T1Za0?=
 =?us-ascii?Q?xDwXmr8FT1RFtPt+QCOEwCEXWn+8UhR93Jm7lD+61XYdYqaFmcRtL5H461Nq?=
 =?us-ascii?Q?PDupi9JzKDz6tJcnzZVCyQmY4NGolUC9tj+emdmFyZaBghCucCkHaabN2OYy?=
 =?us-ascii?Q?iOUN5nmLnrQzfvtSVAYZ0hbsclu/VInTpZU7fyUYSQEDrceDCbKjfMtlfdnX?=
 =?us-ascii?Q?O68UgGE//9IqoINiuS1NsIctNwuEzYjfzgYxVZkI9ncWAoCeqXJy3pd8xe1H?=
 =?us-ascii?Q?u8xx/VXHPDbmL2WiqXgdC939V0y5xoFyeG3jhjBy5X4wXmw8abfrYLdXNL6L?=
 =?us-ascii?Q?mNjuXsnI6MlzvKqbvgZR9RqULbDFgm5UZfUDQRApfQ2LjGtWJvRFKyflH3rP?=
 =?us-ascii?Q?97Icf08D6uhhHvHvPppdmA7GIoYCSAODAQwFJz4ZvBuP0WzJz08MMNeaUDGG?=
 =?us-ascii?Q?w64Fmt6vT6OwNSP49bs9YtwfsdqEzqiwvhEkeASjBVKIyUbP+DuxTgAqXGkm?=
 =?us-ascii?Q?cL5xOAUkx+BNfqvlszUirqnNOx5XpA6iDDWaanwkNXyU53u2zXlzCmxX6FcD?=
 =?us-ascii?Q?xTuxBpsxGEj5erI+xZQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dc971f-030f-4efe-5ecd-08dac1230da9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:12.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wpdl/P+yDMU4QU5qPu34y3ME6edV2AV5pBQb45m2vAerkzzgAiyoE1pg6sIAOAg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hw_pagetable object exposes the internal struct iommu_domain's to
userspace. An iommu_domain is required when any DMA device attaches to an
IOAS to control the io page table through the iommu driver.

For compatibility with VFIO the hw_pagetable is automatically created when
a DMA device is attached to the IOAS. If a compatible iommu_domain already
exists then the hw_pagetable associated with it is used for the
attachment.

In the initial series there is no iommufd uAPI for the hw_pagetable
object. The next patch provides driver facing APIs for IO page table
attachment that allows drivers to accept either an IOAS or a hw_pagetable
ID and for the driver to return the hw_pagetable ID that was auto-selected
from an IOAS. The expectation is the driver will provide uAPI through its
own FD for attaching its device to iommufd. This allows userspace to learn
the mapping of devices to iommu_domains and to override the automatic
attachment.

The future HW specific interface will allow userspace to create
hw_pagetable objects using iommu_domains with IOMMU driver specific
parameters. This infrastructure will allow linking those domains to IOAS's
and devices.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/hw_pagetable.c    | 57 +++++++++++++++++++++++++
 drivers/iommu/iommufd/ioas.c            |  3 ++
 drivers/iommu/iommufd/iommufd_private.h | 33 ++++++++++++++
 drivers/iommu/iommufd/main.c            |  3 ++
 5 files changed, 97 insertions(+)
 create mode 100644 drivers/iommu/iommufd/hw_pagetable.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 2b4f36f1b72f9d..e13e971aa28c60 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
+	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
 	main.o \
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
new file mode 100644
index 00000000000000..43d473989a0667
--- /dev/null
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/iommu.h>
+
+#include "iommufd_private.h"
+
+void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_pagetable *hwpt =
+		container_of(obj, struct iommufd_hw_pagetable, obj);
+
+	WARN_ON(!list_empty(&hwpt->devices));
+
+	iommu_domain_free(hwpt->domain);
+	refcount_dec(&hwpt->ioas->obj.users);
+	mutex_destroy(&hwpt->devices_lock);
+}
+
+/**
+ * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
+ * @ictx: iommufd context
+ * @ioas: IOAS to associate the domain with
+ * @dev: Device to get an iommu_domain for
+ *
+ * Allocate a new iommu_domain and return it as a hw_pagetable.
+ */
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			   struct device *dev)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
+	if (IS_ERR(hwpt))
+		return hwpt;
+
+	hwpt->domain = iommu_domain_alloc(dev->bus);
+	if (!hwpt->domain) {
+		rc = -ENOMEM;
+		goto out_abort;
+	}
+
+	INIT_LIST_HEAD(&hwpt->devices);
+	INIT_LIST_HEAD(&hwpt->hwpt_item);
+	mutex_init(&hwpt->devices_lock);
+	/* Pairs with iommufd_hw_pagetable_destroy() */
+	refcount_inc(&ioas->obj.users);
+	hwpt->ioas = ioas;
+	return hwpt;
+
+out_abort:
+	iommufd_object_abort(ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 7671456e86413a..64e6d0f73e39aa 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -17,6 +17,7 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
 	rc = iopt_unmap_all(&ioas->iopt, NULL);
 	WARN_ON(rc && rc != -ENOENT);
 	iopt_destroy_table(&ioas->iopt);
+	mutex_destroy(&ioas->mutex);
 }
 
 struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
@@ -28,6 +29,8 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
 		return ioas;
 
 	iopt_init_table(&ioas->iopt);
+	INIT_LIST_HEAD(&ioas->hwpt_list);
+	mutex_init(&ioas->mutex);
 	return ioas;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 68c12115400285..d0272efcd8038e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -103,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 };
 
@@ -181,10 +182,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
  * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
  * mapping is copied into all of the associated domains and made available to
  * in-kernel users.
+ *
+ * Every iommu_domain that is created is wrapped in a iommufd_hw_pagetable
+ * object. When we go to attach a device to an IOAS we need to get an
+ * iommu_domain and wrapping iommufd_hw_pagetable for it.
+ *
+ * An iommu_domain & iommfd_hw_pagetable will be automatically selected
+ * for a device based on the hwpt_list. If no suitable iommu_domain
+ * is found a new iommu_domain will be created.
  */
 struct iommufd_ioas {
 	struct iommufd_object obj;
 	struct io_pagetable iopt;
+	struct mutex mutex;
+	struct list_head hwpt_list;
 };
 
 static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
@@ -207,6 +218,28 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
+/*
+ * A HW pagetable is called an iommu_domain inside the kernel. This user object
+ * allows directly creating and inspecting the domains. Domains that have kernel
+ * owned page tables will be associated with an iommufd_ioas that provides the
+ * IOVA to PFN map.
+ */
+struct iommufd_hw_pagetable {
+	struct iommufd_object obj;
+	struct iommufd_ioas *ioas;
+	struct iommu_domain *domain;
+	bool auto_domain : 1;
+	/* Head at iommufd_ioas::hwpt_list */
+	struct list_head hwpt_item;
+	struct mutex devices_lock;
+	struct list_head devices;
+};
+
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			   struct device *dev);
+void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+
 struct iommufd_access {
 	unsigned long iova_alignment;
 	u32 iopt_access_list_id;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 266109045537ed..3eab714b8e12a3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -355,6 +355,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
+	[IOMMUFD_OBJ_HW_PAGETABLE] = {
+		.destroy = iommufd_hw_pagetable_destroy,
+	},
 };
 
 static struct miscdevice iommu_misc_dev = {
-- 
2.38.1

