Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2F62CC1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiKPVDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiKPVCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584506A745;
        Wed, 16 Nov 2022 13:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EexaQBQtZPoolK3Wh3DXHb4yTfYcz31OpNDjF4nlt9GbkvELYZj2Wv/1qyjgLlxi50s7TLxJIEE8KYZfYn2DLQchrXPmpopiiGBqZPUOmSQsqDvu1LKOY2ouQH/lyX04ktps6eHouo7ZYE01uJYwKsh/vuDB0msVImLBWwOukCBIXvLWYm733a6x24JHrhNR5kOWBjvX6txjpflSzgx1bVT95Ss6/BbxKiLtv0SH70kvwAv2W2bltzs7XXwAXFWA1cj/Y9dM6QjscljPS3z4/QiGhHkzqIB+sal40oJQIDvoiyoNdu8scXINUTCIOKMwU3MWtAYhhWIC6U6G1bSixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCOapQlqTPZ1EI4JIErID4xPy5rnUJxiliVEGm3eo9w=;
 b=NorsnnjPlPUlfPs/AGPu7GddHuWaT81SLlT9acqs/bitS/zMnLiVDPpaVHlrF4CK4esmkTd/ukPE5FXPmklYJOgB8M1nbxkP6W0g3jqLVKSYCsUmCz2cqNVQwIIaqTZzmbZQqujQj+wyNeB92sHc3MYBQA58ygF12b1DFUs4IVnER+sEanRRBMKzpLzWmHJR/I3hA9ciFz7Q7cJpXczmYh8SpIzn9vbY3PYS7noT4g5ThsYu1X1xfycvHq4cgYUa+SgydRUpuBGbIEt6f1bWWa02Fw7ASR7RQREewJN30Ebw0oEzj5ZQQAdI0WjumC4YMjKRtEncLnphfCzmfn4N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCOapQlqTPZ1EI4JIErID4xPy5rnUJxiliVEGm3eo9w=;
 b=UGdtrP7ixNnz7bKf4vfuKj7X4PpZrU6bnQTg6QyUeXzTErb638UK1PRig3VwAgtDhdqaSwk/UGWJfFE9f1Yt5UJ2PJ7MSUA31Mzaid7qVMjvxua2j5TeHXZZKV4wEBzqHIo/w4LM0DON8laUTan9yJ15ZmE9OdC2pU/u1J9pzq2ZLTGxeKd1VRtDRJ0WNL9U9WG9nR2FE6FWc18TIfuzn5cixj2EGMC+7KO78M3Hom/uvYKnSuKlnJ03ZREJ/7ZrG4RSTrdq4ic0A9WkrDSl1HidZcxzBE1qhxNsPoc5eRWfVcfy1hJT7wfrcgm4N0Aaw1dhYB2SSWj9plp/NSlkqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:01 +0000
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
Subject: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for physical devices
Date:   Wed, 16 Nov 2022 17:00:49 -0400
Message-Id: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:208:178::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d08044-8196-4c9f-1ded-08dac815a8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyh9FTS6ay5VcpyQi38BX/yt0xl3DPPO+mUfQosod+wscNO2CC/HJBIAiqH3QR/kcnRG2BV0dRZWM/iKO67yIoUOzyjzPPzJhg87Eg+IjlqBSbSkpfxg/Q1uSWPTJqscMOMKyXGarhxJobV2sJyzr0dCRldyl9eo/QJaz+Wzy6FgQv7FIK3pnh8mkdyYkfWA/D4ksug/SpatWfKc17JKZ2infot3DtB2sUtCYUBiHIvoKMIoyPV1L2M6KQdGglTuKOGFLAK2zBfu3m7rmg3ULS7wwnOk3CLBP8Fo2QlQchbN0qlyg9alBjG/BgHR56D4CUnMt/pGtaydbGOTwK7c1dtq3Z9WlPgtTn3DQrWRiWqP04uxxsQFdENA9wiPa5paA6ZQnCKpW34G9FFVGSJMWMGlL0Sdxrrd0HH40jU/XJVQ9xlOfOr61+bG0eRhzKr03P3ZisIawwcHV2PVF3IDRP2cgwtfK8nEf8UbY+5jbBgCywhYJezVdqfwlf+s7JrKjmC9gkq9bQMDqqmAVHKeGC9s+1gqsgx1y9GF4kGxQkjir6qbUBR8E+SiWghuhRu6j3WDvqUEdOaKvz08o6RRigMhmZ8iDZviYpae7Cpnzv0GvgtbZmlniNskcb2/UeuA04h81KOSfjMz46kvtD1e/UMM0EfO9wDqa/QYZuHJUvElJiDsOe8bvOK7BTYwsNMwue5LILKzY3KRxOnFQW9VaNTGoJi1mYCBwy5iFewnHJ9DEBfvgNXH62QH0oCk1q7v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(66899015)(478600001)(36756003)(38100700002)(6486002)(921005)(83380400001)(86362001)(7416002)(8936002)(6666004)(7406005)(5660300002)(186003)(2906002)(30864003)(66476007)(4326008)(8676002)(66946007)(66556008)(110136005)(6506007)(2616005)(26005)(6512007)(316002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrFvc6Z8a0cU7gWSjZ86N/WmUp7o705wTBcMxQZEI+y4kKcjAZrK2wfhLwK+?=
 =?us-ascii?Q?T1ZJLvm+AdSm2AbcfM2HSqd+0TidQONw5ID4L8AcwEW7GADUnQoBx5emsPUg?=
 =?us-ascii?Q?inw4BpJvT7jPY/Kj7yirV8ZuNr2ownG4RQ2yLosM29htWlu8COZ/rdndWPm/?=
 =?us-ascii?Q?wuisYxsthDX16Q1GjbFXmgAOSm9No4rLAtFjiu4qNV/7omILOOlrA/LJ+zls?=
 =?us-ascii?Q?4AjoHo+QALp9yTmYCpCMvEGIG4GHNZsdiwS9dB20t/HHIh9Z4aC0KDSIUs5I?=
 =?us-ascii?Q?YzdxF/4iYpXaDdcpI0HMjvcwiNB1cZ0KDtsSl4S7GN5JpCs223qXH4ikg0rI?=
 =?us-ascii?Q?I0KnxPBgtcwoQuokNS0w+ZcQ28097VDk+GJVmDAon8X/cfnvuRKCVFaQORPw?=
 =?us-ascii?Q?Oc+9gR/q91C/D+jtflOf8Wc845I+G+pn9c2bHtUvbbr6e4Qg1kBpXlrTZOre?=
 =?us-ascii?Q?vO7Vks8IIuFZeXoJv2ohZo5foAake4OZx1x6wDDaejVlhGWN8gvN4kfxNK+h?=
 =?us-ascii?Q?d/oqLj8lNS2GbZv4PEJF9xSEAYBoIdHQukwbIyDk7+TWdLYxzYnHBqMEM/of?=
 =?us-ascii?Q?9EkeLKfXyXJ/HMmD9cq2ZtoMGBo6zCMu6h5UdHW5hLx2QSeBxASFGSjPVGec?=
 =?us-ascii?Q?AnEtTY1WZx1seNicAqvGPfaBz4BYXz1fB3ikhW0iT67bDNeNFP7KC8zqLXlp?=
 =?us-ascii?Q?DkgxwrC1KuSZoXX+y0bv4XVqoWJ6LRcJcXf9jb2xoplyCkxr/ikX47GqMwrw?=
 =?us-ascii?Q?CvLtj/PW2ZGsXDz0D+/ajlq/BF3eam5ixer7JKYh+Y7PcTGbexz7zuYCd7Q8?=
 =?us-ascii?Q?HASkLJI9S5lXcR04YGQC0bQpg+DL/yxOO40SMWrpGFuEkZXQONBdH1BIlf4q?=
 =?us-ascii?Q?SjZMf67TDpOSXOD5apMg3gqpNKkPX1Ioqde6aGIMZ3R8w4HmmI8M8LN+5B98?=
 =?us-ascii?Q?+Ix8Fpxo05L6uCgY9GaBgvx3oEy5Sle8DaITb24squAr2mYutOwTM7Wb32oK?=
 =?us-ascii?Q?pRXwxHTeKlDJdRrZ7Q08GeJoJvjuYr87DtnNKNZz7z7V9rMDyU2QA5yVNUAT?=
 =?us-ascii?Q?CtjfL3RL7Jefs++A9ocaoMIXgozEdGSk9Sd/I6qy93HEVcGk8KY6GdJvnKZL?=
 =?us-ascii?Q?Ene9LAhqQO6zJOqM3wWbz66RnheMT4vzBcQIMXeR0nMiMPhNRbUa6biSa+Ry?=
 =?us-ascii?Q?sf4gLVyucNzOZFvrea9lJzRYZtOFufKCVvvyoq/S5jl2nW7WFCimSSym0E/V?=
 =?us-ascii?Q?ix0dhL49R8Xav7Ny9N3jMWnIUJnZ3S3OQ8rv5Z/37yiZwzvb6/0bx5yYTjsq?=
 =?us-ascii?Q?U57XnRCKZGpuaQB1CIWFMMJRwKGKdhBzZagWhBLJQf0Ub5hKnU4hWwoQddBZ?=
 =?us-ascii?Q?LfCRDfdy/HBqeIrJEa3mB8YSnPHjKq12KIqsCOiZTRwtHZTRbyf4QGJpcAn2?=
 =?us-ascii?Q?2bk4FE+1eAxQaHNPkA/z/FwfzXqisS3FOvtGywRB3Ccd5cZUPDmWvhOFlLU8?=
 =?us-ascii?Q?ICP9P5MRZJj219rqzHB6noi9p4w83PwdsYgYXvrquIoRTfUcev8S1iZCIRVP?=
 =?us-ascii?Q?EzilT5mllsEJc/62t7A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d08044-8196-4c9f-1ded-08dac815a8c4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2pgeZYXvu6JxvP9tLsZZD3LUIIxBLSQu6YRV3OhgRW6EPjj1/+peo5O8+xSrXDB
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

Add the four functions external drivers need to connect physical DMA to
the IOMMUFD:

iommufd_device_bind() / iommufd_device_unbind()
  Register the device with iommufd and establish security isolation.

iommufd_device_attach() / iommufd_device_detach()
  Connect a bound device to a page table

Binding a device creates a device object ID in the uAPI, however the
generic API provides no IOCTLs to manipulate them.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          | 417 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   5 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  13 +
 5 files changed, 439 insertions(+)
 create mode 100644 drivers/iommu/iommufd/device.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index e13e971aa28c60..ca28a135b9675f 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
+	device.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
new file mode 100644
index 00000000000000..a71f5740773f84
--- /dev/null
+++ b/drivers/iommu/iommufd/device.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/iommufd.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/irqdomain.h>
+
+#include "iommufd_private.h"
+
+/*
+ * A iommufd_device object represents the binding relationship between a
+ * consuming driver and the iommufd. These objects are created/destroyed by
+ * external drivers, not by userspace.
+ */
+struct iommufd_device {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_hw_pagetable *hwpt;
+	/* Head at iommufd_hw_pagetable::devices */
+	struct list_head devices_item;
+	/* always the physical device */
+	struct device *dev;
+	struct iommu_group *group;
+	bool enforce_cache_coherency;
+};
+
+void iommufd_device_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_device *idev =
+		container_of(obj, struct iommufd_device, obj);
+
+	iommu_device_release_dma_owner(idev->dev);
+	iommu_group_put(idev->group);
+	iommufd_ctx_put(idev->ictx);
+}
+
+/**
+ * iommufd_device_bind - Bind a physical device to an iommu fd
+ * @ictx: iommufd file descriptor
+ * @dev: Pointer to a physical PCI device struct
+ * @id: Output ID number to return to userspace for this device
+ *
+ * A successful bind establishes an ownership over the device and returns
+ * struct iommufd_device pointer, otherwise returns error pointer.
+ *
+ * A driver using this API must set driver_managed_dma and must not touch
+ * the device until this routine succeeds and establishes ownership.
+ *
+ * Binding a PCI device places the entire RID under iommufd control.
+ *
+ * The caller must undo this with iommufd_device_unbind()
+ */
+struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
+					   struct device *dev, u32 *id)
+{
+	struct iommufd_device *idev;
+	struct iommu_group *group;
+	int rc;
+
+	/*
+	 * iommufd always sets IOMMU_CACHE because we offer no way for userspace
+	 * to restore cache coherency.
+	 */
+	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
+		return ERR_PTR(-EINVAL);
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
+	rc = iommu_device_claim_dma_owner(dev, ictx);
+	if (rc)
+		goto out_group_put;
+
+	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_release_owner;
+	}
+	idev->ictx = ictx;
+	iommufd_ctx_get(ictx);
+	idev->dev = dev;
+	idev->enforce_cache_coherency =
+		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
+	/* The calling driver is a user until iommufd_device_unbind() */
+	refcount_inc(&idev->obj.users);
+	/* group refcount moves into iommufd_device */
+	idev->group = group;
+
+	/*
+	 * If the caller fails after this success it must call
+	 * iommufd_unbind_device() which is safe since we hold this refcount.
+	 * This also means the device is a leaf in the graph and no other object
+	 * can take a reference on it.
+	 */
+	iommufd_object_finalize(ictx, &idev->obj);
+	*id = idev->obj.id;
+	return idev;
+
+out_release_owner:
+	iommu_device_release_dma_owner(dev);
+out_group_put:
+	iommu_group_put(group);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
+
+/**
+ * iommufd_device_unbind - Undo iommufd_device_bind()
+ * @idev: Device returned by iommufd_device_bind()
+ *
+ * Release the device from iommufd control. The DMA ownership will return back
+ * to unowned with DMA controlled by the DMA API. This invalidates the
+ * iommufd_device pointer, other APIs that consume it must not be called
+ * concurrently.
+ */
+void iommufd_device_unbind(struct iommufd_device *idev)
+{
+	bool was_destroyed;
+
+	was_destroyed = iommufd_object_destroy_user(idev->ictx, &idev->obj);
+	WARN_ON(!was_destroyed);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
+
+static int iommufd_device_setup_msi(struct iommufd_device *idev,
+				    struct iommufd_hw_pagetable *hwpt,
+				    phys_addr_t sw_msi_start,
+				    unsigned int flags)
+{
+	int rc;
+
+	/*
+	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
+	 * creates the MSI window by default in the iommu domain. Nothing
+	 * further to do.
+	 */
+	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
+		return 0;
+
+	/*
+	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
+	 * allocated iommu_domain will block interrupts by default and this
+	 * special flow is needed to turn them back on. iommu_dma_prepare_msi()
+	 * will install pages into our domain after request_irq() to make this
+	 * work.
+	 *
+	 * FIXME: This is conceptually broken for iommufd since we want to allow
+	 * userspace to change the domains, eg switch from an identity IOAS to a
+	 * DMA IOAS. There is currently no way to create a MSI window that
+	 * matches what the IRQ layer actually expects in a newly created
+	 * domain.
+	 */
+	if (irq_domain_check_msi_remap()) {
+		if (WARN_ON(!sw_msi_start))
+			return -EPERM;
+		/*
+		 * iommu_get_msi_cookie() can only be called once per domain,
+		 * it returns -EBUSY on later calls.
+		 */
+		if (hwpt->msi_cookie)
+			return 0;
+		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
+		if (rc)
+			return rc;
+		hwpt->msi_cookie = true;
+		return 0;
+	}
+
+	/*
+	 * Otherwise the platform has a MSI window that is not isolated. For
+	 * historical compat with VFIO allow a module parameter to ignore the
+	 * insecurity.
+	 */
+	if (!(flags & IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
+		return -EPERM;
+
+	dev_warn(
+		idev->dev,
+		"Device interrupts cannot be isolated by the IOMMU, this platform in insecure. Use an \"allow_unsafe_interrupts\" module parameter to override\n");
+	return 0;
+}
+
+static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
+					   struct iommu_group *group)
+{
+	struct iommufd_device *cur_dev;
+
+	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
+		if (cur_dev->group == group)
+			return true;
+	return false;
+}
+
+static int iommufd_device_do_attach(struct iommufd_device *idev,
+				    struct iommufd_hw_pagetable *hwpt,
+				    unsigned int flags)
+{
+	phys_addr_t sw_msi_start = 0;
+	int rc;
+
+	mutex_lock(&hwpt->devices_lock);
+
+	/*
+	 * Try to upgrade the domain we have, it is an iommu driver bug to
+	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
+	 * enforce_cache_coherency when there are no devices attached to the
+	 * domain.
+	 */
+	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
+		if (hwpt->domain->ops->enforce_cache_coherency)
+			hwpt->enforce_cache_coherency =
+				hwpt->domain->ops->enforce_cache_coherency(
+					hwpt->domain);
+		if (!hwpt->enforce_cache_coherency) {
+			WARN_ON(list_empty(&hwpt->devices));
+			rc = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
+	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						   idev->group, &sw_msi_start);
+	if (rc)
+		goto out_unlock;
+
+	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start, flags);
+	if (rc)
+		goto out_iova;
+
+	/*
+	 * FIXME: Hack around missing a device-centric iommu api, only attach to
+	 * the group once for the first device that is in the group.
+	 */
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
+		rc = iommu_attach_group(hwpt->domain, idev->group);
+		if (rc)
+			goto out_iova;
+
+		if (list_empty(&hwpt->devices)) {
+			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
+						   hwpt->domain);
+			if (rc)
+				goto out_detach;
+		}
+	}
+
+	idev->hwpt = hwpt;
+	refcount_inc(&hwpt->obj.users);
+	list_add(&idev->devices_item, &hwpt->devices);
+	mutex_unlock(&hwpt->devices_lock);
+	return 0;
+
+out_detach:
+	iommu_detach_group(hwpt->domain, idev->group);
+out_iova:
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+out_unlock:
+	mutex_unlock(&hwpt->devices_lock);
+	return rc;
+}
+
+/*
+ * When automatically managing the domains we search for a compatible domain in
+ * the iopt and if one is found use it, otherwise create a new domain.
+ * Automatic domain selection will never pick a manually created domain.
+ */
+static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
+					  struct iommufd_ioas *ioas,
+					  unsigned int flags)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	/*
+	 * There is no differentiation when domains are allocated, so any domain
+	 * that is willing to attach to the device is interchangeable with any
+	 * other.
+	 */
+	mutex_lock(&ioas->mutex);
+	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
+		if (!hwpt->auto_domain)
+			continue;
+
+		rc = iommufd_device_do_attach(idev, hwpt, flags);
+
+		/*
+		 * -EINVAL means the domain is incompatible with the device.
+		 * Other error codes should propagate to userspace as failure.
+		 * Success means the domain is attached.
+		 */
+		if (rc == -EINVAL)
+			continue;
+		goto out_unlock;
+	}
+
+	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_unlock;
+	}
+	hwpt->auto_domain = true;
+
+	rc = iommufd_device_do_attach(idev, hwpt, flags);
+	if (rc)
+		goto out_abort;
+	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
+
+	mutex_unlock(&ioas->mutex);
+	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	return 0;
+
+out_abort:
+	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
+out_unlock:
+	mutex_unlock(&ioas->mutex);
+	return rc;
+}
+
+/**
+ * iommufd_device_attach - Connect a device to an iommu_domain
+ * @idev: device to attach
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ * @flags: Optional flags
+ *
+ * This connects the device to an iommu_domain, either automatically or manually
+ * selected. Once this completes the device could do DMA.
+ *
+ * The caller should return the resulting pt_id back to userspace.
+ * This function is undone by calling iommufd_device_detach().
+ */
+int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
+			  unsigned int flags)
+{
+	struct iommufd_object *pt_obj;
+	int rc;
+
+	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return PTR_ERR(pt_obj);
+
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HW_PAGETABLE: {
+		struct iommufd_hw_pagetable *hwpt =
+			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+
+		rc = iommufd_device_do_attach(idev, hwpt, flags);
+		if (rc)
+			goto out_put_pt_obj;
+
+		mutex_lock(&hwpt->ioas->mutex);
+		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+		mutex_unlock(&hwpt->ioas->mutex);
+		break;
+	}
+	case IOMMUFD_OBJ_IOAS: {
+		struct iommufd_ioas *ioas =
+			container_of(pt_obj, struct iommufd_ioas, obj);
+
+		rc = iommufd_device_auto_get_domain(idev, ioas, flags);
+		if (rc)
+			goto out_put_pt_obj;
+		break;
+	}
+	default:
+		rc = -EINVAL;
+		goto out_put_pt_obj;
+	}
+
+	refcount_inc(&idev->obj.users);
+	*pt_id = idev->hwpt->obj.id;
+	rc = 0;
+
+out_put_pt_obj:
+	iommufd_put_object(pt_obj);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
+
+/**
+ * iommufd_device_detach - Disconnect a device to an iommu_domain
+ * @idev: device to detach
+ *
+ * Undo iommufd_device_attach(). This disconnects the idev from the previously
+ * attached pt_id. The device returns back to a blocked DMA translation.
+ */
+void iommufd_device_detach(struct iommufd_device *idev)
+{
+	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
+
+	mutex_lock(&hwpt->ioas->mutex);
+	mutex_lock(&hwpt->devices_lock);
+	list_del(&idev->devices_item);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
+		if (list_empty(&hwpt->devices)) {
+			iopt_table_remove_domain(&hwpt->ioas->iopt,
+						 hwpt->domain);
+			list_del(&hwpt->hwpt_item);
+		}
+		iommu_detach_group(hwpt->domain, idev->group);
+	}
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&hwpt->ioas->mutex);
+
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+
+	idev->hwpt = NULL;
+
+	refcount_dec(&idev->obj.users);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index bb5cbd8f4e5991..73345886d969e5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -103,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 };
@@ -229,6 +230,8 @@ struct iommufd_hw_pagetable {
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
+	bool enforce_cache_coherency : 1;
+	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct mutex devices_lock;
@@ -240,6 +243,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+void iommufd_device_destroy(struct iommufd_object *obj);
+
 struct iommufd_access {
 	unsigned long iova_alignment;
 	u32 iopt_access_list_id;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3eab714b8e12a3..8a114ddbdfcde2 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
 static const struct iommufd_object_ops iommufd_object_ops[] = {
+	[IOMMUFD_OBJ_DEVICE] = {
+		.destroy = iommufd_device_destroy,
+	},
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 26e09d539737bb..31efacd8a46cce 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,10 +9,23 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/device.h>
 
+struct iommufd_device;
 struct iommufd_ctx;
 struct file;
 
+struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
+					   struct device *dev, u32 *id);
+void iommufd_device_unbind(struct iommufd_device *idev);
+
+enum {
+	IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT = 1 << 0,
+};
+int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
+			  unsigned int flags);
+void iommufd_device_detach(struct iommufd_device *idev);
+
 enum {
 	IOMMUFD_ACCESS_RW_READ = 0,
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
-- 
2.38.1

