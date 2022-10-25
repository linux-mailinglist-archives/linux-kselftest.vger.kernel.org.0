Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFF60D329
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJYSMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiJYSMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4471B1DFC;
        Tue, 25 Oct 2022 11:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi3rSMNhgW8FeO5kK/H63h0uzxzeipMgkwBOIIUgGpi2DPXxEC4FVNGHgyVNN4gfTStWV7db9xNW0oN/jju5Ut+v5gw6mpGcFg7m2eKMACLVrlwXP5N4WhQMd7o8Hn/dG8UF6U2GlM3MtqoQ7SuSjzR7RoiBOcmmGudHRUPyQn+U5e2hu/45aH23ta9iqQDOjQQXlshv+5gpHBiklUSC1InIH13WTa4iW1XhA8fZR91xigHcDb+qAQu3xDN5pH4teKpFj1n8ljVtVt/jMALCcTniC19BJ8L5LpRHuuMjPVtlaYNcggwqP5pIvbSBwvpaWPO+XDTkj6l2vwIEss61cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H76TqWxd7cBnKBawkdj1id8iaDhvCbSXqb9CIIwvcts=;
 b=lAyD2+HFkQH9NnXH5gPQOP4E/wRx8xZ7i3io6yZIDtVnpZWNjMxDaGfrMhpAsbleToGrY2GfFSRl5bWdGQajkj1GZGqJyOMYgkQqrfDORiVIjE7NaLlWzVkGfX4z1O22JL6Zzd7JXOPaBVQHtJrrHeYb/KedTnzQREZK9OXN82IYtXtfqBSzJgPncX2lxF5pgxVHh+dLWghcHaU6uuGscJoyutMxqWW6UrBOVeUjw+y0VOMW7skkKzuOBPTE39B+7Td9Gdv7KfYpKzgKdxiUjXV3cqdGTBo8N2g5zvIFo53jTMNKLh8XToCUE7OWeSp86Vw2f6h7DBcyuoqJwVKD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H76TqWxd7cBnKBawkdj1id8iaDhvCbSXqb9CIIwvcts=;
 b=Z0pPnOHQlWltoSIO+pbbZKP/nHMgu3vHkoQ3Vl37tJXVUvN0t5oH6txWiK5rYg+8PpRoh6oToxpb+mUoZdDC6OVCnKcrIvx5CHz1CEf1Q403WrL1wAh+vCU5FJz6esEQMNaKY0SHgunCd961R7ygsKtzFlGZsrn44nxo8wXbAg706PvS2al3fyR3EXQksLobPmv8DPhTuJli2hUvVSHzSQsVGykmv3APaPIwn3UFv4dn0HSZ8kwBtfUNJyfxx216LgmUIIal9lqHeUeJfXUOXd4eUVnGQELWkws6WtsQs0W4S/8dCLSF7QBHgCOe2VfglDJd9guVwyQ0vBdJLCzezw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v3 11/15] iommufd: Add a HW pagetable object
Date:   Tue, 25 Oct 2022 15:12:20 -0300
Message-Id: <11-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:208:a8::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 32173e7a-6dfb-431d-de07-08dab6b47902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUw8lvzvLVQ07zoFJ+bBL0BYtpKenOZd50yfxGKa24gqDV+nEt/tq/c45ZdiD5MrMwe2PBxYhAK+ft96qkAQPml5mgVD8R2qLSRweqSSQ0tHB8kVEmTBkaKWMWFyLeGELTYMoVyXKwIJWZmeiNlrBSfZRhawas4U8Kf294ve9gnoFpJvSKPvdqoP8HHYLZLNfbG02JE0sY5vflS8o5ldI+UAYmAL3GE/kUOT/GFCL/HUEmzLsmXYK0+KGhwR7ZXqhvv9yI5gjF4HVtc5TApj8cop9+jNtRoXSZ9ITAEKFDbuRQvwd9lJrylTPnMUKfw0lWerrhfh/Lo9I8CbTwCnD6iYO6zkbj564tg9KNfuhKvYrz5YzbeJjR88Es0lzMbHqxzrq8JYIjXmw2+PlIyA9tRuFyTrXVSxFSM8sbvKlvEBp8MNieupxlejKJILcpiKItQjTtQamQKgZ1xt2zSGKh1yuxTobM1RHArMIP+n5ktx6i9F5CsaAX3Y0e5fbFN4IXbCZvd+2MJTPLpqtyQwBErDveggNd5pnUw4DN6fgw52Cvce7MpMgWJxuAb8MSCHyFfju16ka0M53ghmHF+SM9TmPC29hSobsJz6q4tOb4jWIyHpYihjVsLbsAO/0bfko1OsceODRuCx+m7JxEX/yj05j6aqstkHQAArafjyonKfbjb/pvXkAPlVcf3JfseP+JgRSjFMzbM/ZNulo/yYOK+iWEmu6CJqHDjp+iAkf1YbFz+7XaVrxIHzJZQQIb5M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(86362001)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0HEm/o7tSLBp8ybnkDN+8Wp9UTeftUnTANWH9T3Gp5kZVdZHQDN1g/WS7hE?=
 =?us-ascii?Q?IuWauqdDwJjvmb6WqtxfeOs+9Sg1HG8LjZFGHrkIGFUIAxVop40/85ULH+fK?=
 =?us-ascii?Q?6efCRezNBiVvNAJwCCsqCZlbzWfcXV5Y60imkFvliA6GDQPgmY1fsVhhiW8p?=
 =?us-ascii?Q?0XLvkvlMfB/KoIuHfWFBi/XcASCUk4S1hxIXpSKDzFPc3xWK0JtA/GsMo9Z8?=
 =?us-ascii?Q?R7jQakvrCtDnd2aIwoWB1ZJqAqT+6ccS2kwhdNXlbDbqIpalk8hPzye3MxC5?=
 =?us-ascii?Q?N9ZshDQVZg8n2qAA9Wl33oY7tyVigRvar08wD6olbLg8dlIXeDhQ4SXAEUZ1?=
 =?us-ascii?Q?D+fp39DOcFBQGbYjuVOut0VnpWdK7ZCvDscNW+jOEoc9RAns2qUcT+fmCIpK?=
 =?us-ascii?Q?8crJIEuL7cal7RVOCKU+myM8f+FNqkWDHioUmh0PB0ojXzcQDVHJFxIpkPWZ?=
 =?us-ascii?Q?M9IhaOxsk7k2x9sJnPCadHvSKV0shNK03KbaUZZ0GqXls07LaTJP7ixiHmYg?=
 =?us-ascii?Q?q9GMsxBx9Z1NDEspPCsMe52hAlYuThGGriDccknrhNBfsibbzqP9L6XxWauX?=
 =?us-ascii?Q?KCBaiaGmM9wymILLebl3qgaGjyByPyp79CxVmbHLPGVt0j+wpVhhfEpz8SQo?=
 =?us-ascii?Q?HSR5trvfRay8Uh+EKq9/8Y8oq2Sib2EEPyhZFKIYVpb5nWHUeCAE44BR/WY0?=
 =?us-ascii?Q?gk+ZL8YrZOfqXnAu0ys9dNn+ktd5YI9nKC50urSyfWgI/G37X6qsCZsxCUL6?=
 =?us-ascii?Q?GnmW9KdfxURZKDbFzRpOOKmoYBKS0efiAAqF/LOOFSB8C4mKmYx9i/ZGcP6O?=
 =?us-ascii?Q?TAQ0tWQs0be5UxYfmmZ4AwXKmJ9FQoTEFy9Q30j0ibKbk6DKj3LBy3h0M2l3?=
 =?us-ascii?Q?EoVTKMvYbBm1eySfzoTC+K+pHXje4G22XAAZQXyEUIMNe+SFpjlWCU8jpzn3?=
 =?us-ascii?Q?Es2YvftN6WJFkABZM8wNxfyKDnSeMgELw+5WdtG6lPwhKJbS1R29W6aZevRM?=
 =?us-ascii?Q?u87jWXhYE1Pav/K3XwQ3anABynXIKplNKoPALXffHGuqQHTTWdli+Fl6SuwV?=
 =?us-ascii?Q?P0aPMGdJg248xmsJ9uv+ZBM0CzD+dLRKs4Q48qqmbYIRZxprjj5QTAY9Swy4?=
 =?us-ascii?Q?db9g/9OOAzbspwqZx68AGUIJwSip8QNnX7rL9WSTlUhwMqxYcGZJcR3EtBLW?=
 =?us-ascii?Q?DYrRYwvDrGKtZPfFK771Dw4m5gTn0/5T6MWAEU1gmK1OYas51XJw2Pjb5WbQ?=
 =?us-ascii?Q?9Ejz6hbn/lEPaF9HKJv7L2t58UDDygqYOD1LUtdX757BPFmp8JidPKvza2XP?=
 =?us-ascii?Q?WCRQtUosW0pXM+vdpCVFJHTI8m4hD6pPZ4FJWr4tq0Si062GZwb2SWrv5P2K?=
 =?us-ascii?Q?7kVBjRGp9UhvgpMPpqfCS/+ywJG0dAiC5CZpn4J5YKsEm/7Rau4S8cJPl784?=
 =?us-ascii?Q?xj/mmvTWqDV+G4ojGNzwB5cG6bP5SYLxk/BcYVQQXY2dnJDYxLUyKLfU+Xzv?=
 =?us-ascii?Q?RtOiU8WMsaZPnVavc5bG8FXIYVI4HcqPKiS1Tx+ZbjHVEu4lZdWi8v3BRAHj?=
 =?us-ascii?Q?4N+tH9d109+bbYbNxRw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32173e7a-6dfb-431d-de07-08dab6b47902
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCjNhWhy73EOJYfvx1xvNg+2KXXMgotlZUGe4TR73JDGllSLJlLFvAp98441mn9e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/hw_pagetable.c    | 57 +++++++++++++++++++++++++
 drivers/iommu/iommufd/ioas.c            |  4 ++
 drivers/iommu/iommufd/iommufd_private.h | 34 +++++++++++++++
 drivers/iommu/iommufd/main.c            |  3 ++
 5 files changed, 99 insertions(+)
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
index 6963b7b0a3c957..52ca5776e00b8f 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -17,6 +17,7 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
 	rc = iopt_unmap_all(&ioas->iopt, NULL);
 	WARN_ON(rc && rc != -ENOENT);
 	iopt_destroy_table(&ioas->iopt);
+	mutex_destroy(&ioas->mutex);
 }
 
 struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
@@ -31,6 +32,9 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
 	rc = iopt_init_table(&ioas->iopt);
 	if (rc)
 		goto out_abort;
+
+	INIT_LIST_HEAD(&ioas->hwpt_list);
+	mutex_init(&ioas->mutex);
 	return ioas;
 
 out_abort:
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 20e1e3801fc525..e1521764a335e6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -102,6 +102,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 };
 
@@ -179,10 +180,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
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
@@ -204,4 +215,27 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
+
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
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index c91156ba3e3ab3..84d315b9e73845 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -355,6 +355,9 @@ static struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
+	[IOMMUFD_OBJ_HW_PAGETABLE] = {
+		.destroy = iommufd_hw_pagetable_destroy,
+	},
 };
 
 static struct miscdevice iommu_misc_dev = {
-- 
2.38.0

