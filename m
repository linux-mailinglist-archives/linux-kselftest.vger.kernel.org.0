Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6609162CBED
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiKPVCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiKPVCO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:14 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1B81FCF3;
        Wed, 16 Nov 2022 13:01:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/aK0FjbiAYsrJKgg3ybNmqWD5l8AGNAg1CRaLqb2BN1B1SjPKkiTIBAUaOSQYDo8045bCRcBup606cRdvmfLIlGR4ajPZ+yEPfDBUrkjGeog/OdJVcGc4IJxFDltQYn+z+FbOIESvQka6Cp/XMusJCB/GG3jrMKhIEVLzJYuyfStv0c3UjPWtVGAOBL4H+UpKKWlOduUhtp9AT6km2kSKpjXGnYSHk5htyM748ACp74ZatmVVWlm/amK6GNNNvH3kIm5S8xGgdiJgrGlg+tD7dbTtGE5MnJmME0SJ3nhX6dQMb0Fbxb/7Vy9nO+DSV/fbWlNP3hxF+9WqDsMtujfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJkeITMxjD5i2EZbCIfAxjerYNLhb7yjGh5dkfwNOhY=;
 b=kqzOp5YcQMFGcqTnTovrF2x9lIrBV3DpQKAxxTbhn1ph9Re+7lTtFariP4zWhUEJBTsvTzRZBVqLB9dsJhMsLn8zUa5hUBCEnYHKT1wF1sDCl3p3iJZna2XjUliF4nUl5hMOD5FLZbImRwbdd6aix+GbC7qeCpgP/whcUB4ePLdptLMrM/DYw0o4ANKBiAKuJSTPNjq2RagxnHnSBRXqqrTXqsmURdBtpgNgyIrupSUMTO16u8llE/IAMtyvdqzME+kh7G3gLf09gPuUh+rjOYx9WIBjlN5NOKHepkBHsTKbjU9ED6qtjTMw47BvRgos9JZcU+OWJgyXeEzXAjq/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJkeITMxjD5i2EZbCIfAxjerYNLhb7yjGh5dkfwNOhY=;
 b=HbkdbwX39Btxl02304oMGo67I34tj630iElCcFwuswn+Z3hIr56FZP/vQheh5fjVs/jofU6mgRTCzyQ14PJ+7ic0QX21pZNcRK62Vttd+k5jMLKJC7O3YKzBxlxFXhkFwZg55ixovsxxVj5XN8SrI+T3HfL4x39Z4JglhSiZi6piYa5vdtNiGQBsYUorqshegtji/x/W7uUxp3RjpQ1mZ+iGZvpJkgJvGx+ohz6RbPl3hv7CcNfhbfxaulpsEU4oENvqRwq9MDTcaZSU/ivXMI1Q90ePZ8qfhDr8e4gVDp7Jb8Q8lmbd4YOLnDtan7EY8QBHlA1yRuH20j2p2NT4/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:02 +0000
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
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 12/19] iommufd: Add a HW pagetable object
Date:   Wed, 16 Nov 2022 17:00:48 -0400
Message-Id: <12-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a7a6d-3c1e-4631-caac-08dac815a8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAc5x0hPvLyajD9F1yyIJVHxhcoT+O0zrY7IZ/AshuX/fGGOAUc+yn8DjLGtzr/TAS+lYGKDGSo7jzB3h16OyoUL6WsF8cuqP/jaVJMEDscncefLoUEXNjNBC+SB+0fO+TkYKV6E1JqfH5ygZm+2W1Wq82qgIOeEjA8iKVZfVV4+ODH1bkylEP+KAwbxmV5q7R8FmJdDuSAofhRx4+a2rbwqJW5kZ+G6Z4cT0Azd+OmXver0DYcehim6bHp462mr7f3uoRDfLbnqcnlZs2SQXdSqGsKR2LiBa66Cui9RXWIPTOO7t3yeUvaq/Klb+L14wlGeT91K8bempwga1mpfH6aU8r1aNr42i3intEAWlXIfy0E1FC0pL53w4WOh5es0U84XMAiEZ+5pAscRakob824bq9cVLpvOG0tL2t51BGBZ4ClznRzrbxoY8gMa7i4dbanyx99SUZPPLwt1lN8vwL5PtcNbciTSVclzRnbz6FMYLPQeCcNijl9G4JV/r0ClzQpCBmM/dklRaPHwbvS+o8jUA2iuhRVc1hCTxiMqqjzNBKFE+O2GOBXAqv/7NX0mREQlYr3m5Hc5uzA8MKtB6d0pxJUjo2ovPkANR40seY+C4VDSzADvWs25fkf+jJ3sDVdj+UBfPqHaDvijcaDb0WbobQ1TbSTZPbjtufeCPYYwTECjAD6ER9n8ihLHuy9zSMgy/O9CVPe513/ycrwC/79N/nRyDQFXxE0wqQ5KUoIGJ3wn0jqaSx8OOlqvA7QK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(478600001)(36756003)(38100700002)(6486002)(921005)(83380400001)(86362001)(7416002)(8936002)(6666004)(7406005)(5660300002)(186003)(2906002)(66476007)(4326008)(8676002)(66946007)(66556008)(110136005)(6506007)(2616005)(26005)(6512007)(316002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62Y/4pOuHxuXSRvgA7MFWK7MLIFrcUMuD42jawI8MFFevGbTPUh05BC8nsxl?=
 =?us-ascii?Q?10uIVsN0ukY0hWqWaHqPGJ3/kNT31QZxxDPRWBLiDG1oX6N/Pl+HUZOE7Mhs?=
 =?us-ascii?Q?OSmQo+zo0U85lwZoMNV6i3E0FG4zF7PQdpSUXo+EJNS7dahKit0vT6hbjF7y?=
 =?us-ascii?Q?wSpAS1N8Jx+QKvK5NaRg7nYIYeYsSVxqmHR2YSpP9pN+zumlsCSUT3mQegc+?=
 =?us-ascii?Q?Q5oMaNXWGhA0RfxAhtG3U/tBBKHgdmQQ4fyRi30PrCXuyeSpQtb9MRbJzlPu?=
 =?us-ascii?Q?5RSo9ui2RX/nZ4waY3thHimzmFiz7DYgpr2Z+UCQo4jGCKEtfJFOmABcZLpC?=
 =?us-ascii?Q?B1DNOnJQrPys17yHmYkia8HPrAANjp3wCcBfJ54idqJWJ707g3ehZMLUrDpW?=
 =?us-ascii?Q?1BA4C6gZ55NZ/f7Vxlpn79BNKQ2StkbZEowrsJVkhc2+xrsCSeW2Zu+r4ScX?=
 =?us-ascii?Q?1pikHldCa3o3pTHiBSAvqRLkPNZByCz/gCQTkNj15lGzu5XxeanuvpyNcz4Y?=
 =?us-ascii?Q?nB3Fz0K8hcF/tDzHLWjTzIT8bC10eePiFGWyMaS6uFRdhdhleCaf+H4Zft0L?=
 =?us-ascii?Q?7WxAXyFsAZF4IxEI+yT96rfcf3iMikxz2R4zOc3yXqgFvH1VK01g/fHC3b/W?=
 =?us-ascii?Q?5U6X3Dz2Pku53F2w403efGHu0U2R/P7MeqAmTQ7uF571yGU7KRrgkxLh6fMv?=
 =?us-ascii?Q?BOORhniCfG485uGhI3CtP4Nbju2jeluRVDYxbIj4W2BNz/+oJWBJcE1TL+es?=
 =?us-ascii?Q?aJMHgG1z60ScmU1BDHqboCsLu+7CmFLN0KbR7lUXljGaxgkIqXSzbs2siKnd?=
 =?us-ascii?Q?afhzwvRChRv/LR7RhjbMgk5KxNZfA24h01Rdoo4E5oyCoj+YFuxg7LGbFgOa?=
 =?us-ascii?Q?RWGXyKI73Tqu4m+B3be59mWzzLx96/pseAq0ZzrnmyxSgsRs6VqouDczzvJx?=
 =?us-ascii?Q?U+NJgdt3qtD6KutDlCT+FUyB6frpFpHWgVyc+GpXgU6ijlbpPyvAq+biteoe?=
 =?us-ascii?Q?IvmsncbO2E+J3ueoDp6OWO3pnjpUcpMIMi5EO+036Jesru5T6qwkdaRdxG2q?=
 =?us-ascii?Q?da7ZlAZzk5V2mxTi03FdUxbJ3VlhWqh8tfVf4R1rVfFRgAk+QdtZv7D0Pr6v?=
 =?us-ascii?Q?w0kAjTQgbHY25aVnGlY1QZ4uZJpWbIwOEOn4bMwkUNqrlGYnrWM8SGmRlBTw?=
 =?us-ascii?Q?Bmr5gnuW+XsB+vdNlxMtFSNRZICogXImWafmoSsNvKwOaSEZd92ktuWqrP3h?=
 =?us-ascii?Q?vj1MS54rIa6vEsGYT+qXkkFsXL3js1KkyTQuuEn8SfYg07YFhqkGlwxievBS?=
 =?us-ascii?Q?b8r/1cJxxstts+aGb27c5SIUlsY2KTKOltqrd/5a1JbRRwmzc98LVB9wE4V2?=
 =?us-ascii?Q?YxGktQX+2QtBtamh8gmhQrIPxLILwMbq88MQLi12kNgFdqP2o5ZXP2Pwd3FM?=
 =?us-ascii?Q?qGtJXtJdVkl2UEM+F4GYk5Ceo6J3zMwJH+IYvFJUhI5ZCYMoT9h9uj9038e5?=
 =?us-ascii?Q?23ohhKqSKnfYsyaNLSmJr6oYt3hkeBp7eD+DAisb/vmlEfXJ4Nf/Mf96mxfO?=
 =?us-ascii?Q?uRSK2mchCXF5ejKvw+w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a7a6d-3c1e-4631-caac-08dac815a8f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRn55uBXPflb6bd+82fjnFSqvwCK+yHj16nArgMgpbqOZ+iBoLiqbQi2+WAnmXFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
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
index 6721332dbbba03..bb5cbd8f4e5991 100644
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

