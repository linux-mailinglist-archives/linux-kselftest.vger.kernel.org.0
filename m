Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8901860D338
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiJYSMs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiJYSMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5DEB5FC7;
        Tue, 25 Oct 2022 11:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVD6eQ7G1rmA8fuOdpKO8LKGNAuo26N1/W9+6Rhnn6/70LziTVg0MIXI54b+N2OEU+kWwEP+CZK/w4pmmWX4sje6Prkut5VBUmJhuv9JxOZ59dX+mwDkHKsFJjab7C8LoMKAKd++ouS0dRuJN8DXboasqwqsAcy3Acg7L70Hqk3RTU3zutEappTqGesOe7lnjtTaUSASggefgS1b6bddaT5DGecPNYoVIuRyPVshizJXbEHuqj2yVI9P22n17H8sDJzEBJhIa1i0ggfDFVnaOG+160v7dkshFqNA7KIFu/wZnvik7Pk3fnFfOxzf5elbYyXv8h5vUUT42qjDK5ybEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jICkjTeTjFztLFTGtsWobeNnEcq1kXd38jS4+yd8S0=;
 b=dHhT5DQgQzp7h9Sdnj3v/ROxl63kniNoUFF96rcpdb+L4ICXxt8dpdp4HbWDzdYVoCw+ZDPF/jRC00+M3wCQoq6wqEIeT4UFuIli6Qb/4e/X2zv/q7Da6MGVEkFNaHDH4uJqqrOGikbnr6fQUsVaWRjJiufwCpbwrp0FrgxOLvd/nE7OzePtVPzAuAmrXSEivrnPeFx+vNtKFF5ELGd6IFz1efxk4I2HY7fH5teL/fo22q1bFR7hVAktmaDbCR8dz5d63bbf8N8p6b0sT7ey4G6HstCdw+53D+MRdPyzlzSD1quLuXVoHm5DWTBvwJbuBRiKvJcAIDQy2pJ6I5qEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jICkjTeTjFztLFTGtsWobeNnEcq1kXd38jS4+yd8S0=;
 b=DRudZW4rwqQU8LL5qvP9gEOD8f/MeKNBp/pDC8UUQLIvXd5JV+zgZ3Hm2Ep8va73vxdUj5+YNNxO/Q2xnCCSm+3C12eLBFnR1uPrLeM2qPAhvyDjlp4MzowFnGzTOuCm60qM5RttTmyD7aDgGbMKJ7iUT2KzkPUxclDKX42HqPZjZCAEy6AWFqbFy5VMQFdU8jAtGElZiDqrWwAgiVRVMFFzJNbmHFgxaRnPM8D5Eu+pjlQtlqsEHwz1mbudE4pkR9w3ic4IuqeEefRG1Cv8XlTIGaNtHqAUQQoiBthmnu999PRzcxL7RiSABD3BQiRC09jxcRLSdnf4VarDZLz3Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:30 +0000
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
Subject: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for physical devices
Date:   Tue, 25 Oct 2022 15:12:21 -0300
Message-Id: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:208:32f::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: ef470042-8530-4b0e-4623-08dab6b478c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBj5DaYShjpYmErMK0Njg66Slr2JJDqMF9J81gCRxmQtngiv/YjUn3drxj7p2JWUOt78lGm5QCsjP5rM0eIQ21S8nRsHljKdHayv3vw/ewf+I/3kwyz/4Mi0L7speP3gT0OV0S1dIqP1x0rxX/6R8aIPYxFh8yT4Y4UbYnszsO6HfJBOH3Dk+3auaGsCEkWL0EL4w4d6sljbu9Y1i5USD/5N5xGpuOeqFjDdiPuXeeZd5nGe6J1X0kxf7arhAi+UioVfNdzulZa+zQUg3hZ5Yn4Uu1VF9pMP+3qfwFTZV/05ZUFlQGVsevFkghn27cfQpigcMdbvbcD/47rA9GMdUl8aIgApB59pFEcvWGkHJ3nFKGri30d0Ph9JzceMif/BC20fpdANarrjEXnftcozYXJOpfHvXYaBSy8OUuO8M4ZFpQ8exv6UAo9NffIHpv6CSS9oF2Em+Lz9qu3UDCL2EfgfwiE1MGy11ZboSmE2S+0FN+HLBRUXGIOue8NboO/4ZyZOlg/aWF9NOEjodaZ9OYm7bjFq0jVuZRVoJK0n7qx9fe4VieBn+x1QcoS/L87/J5S7k+A0BVqXzIUaof6LHwekTVt2uKKHiNic2Hh0C/LVXvxpl6fzD6yPA8srkxJLcz1LfZ3fp6THhEfNvgwJ/iye4kJC5Q+PgNnk8bI+MOeUjuEk+SES2DnDyeKa4SFrhVlxzFsIZuzk3oKI55MnZqWtgOJSq0lInsoKWj/6VUj4UmEwCZ5BvvKC1HRuyVaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(66899015)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CL7zzYY7Fxepq2qpc+qKhzoyfqzg/Fu15rPtT/cD6ZnW2pNVo2OiQIX4rMyV?=
 =?us-ascii?Q?DYZsv//vsA/tniqkQkLhVZDzibxcW8zCKYNyQ5Hj7r7f7f4+PtQYCJtJWwFn?=
 =?us-ascii?Q?AwposZuSnPHY7dO66zP3nJXwcdQ4G9LIXW4F20myv//87AGFcmRq827SPJHe?=
 =?us-ascii?Q?WA2La81HIRiYUK7r+0bjaXkidW78sM/SYWRG7WNzTzovPV8dzmYTFRQdD4KF?=
 =?us-ascii?Q?uyQTt8S1emLItr9T5qrPZqdfo1Dy4wuomWNdTIWrP9g2c7niIjiUr5xJmtht?=
 =?us-ascii?Q?ZV81z1p7oMV7/bjN2fxN7ufTGgJOezT4w4oVJc9VOp/GCr6zMIZAaexIp3Us?=
 =?us-ascii?Q?9baxeFRF4z07w7eDSVGPttJjo6lpKvwMMKVllC9EQ9l6MVGYb+b9oWfuE0aP?=
 =?us-ascii?Q?un1MKoj9ZJbylfDeOtHjwxspqpS1X/StrYpQp9LOdQ0BCatDfIuhYYsG8kLM?=
 =?us-ascii?Q?av/0qa1cJ4oX1LzfzF1Xq36tL1klb4qhFbFAO1OpLkYIpVuT+ri9SWLUv114?=
 =?us-ascii?Q?peErePbwGpFJhU6veGNCOsHMwWX7lJx6ENWZMF2Ny27NTdB6/2A9EtwmlcxN?=
 =?us-ascii?Q?tOvs0w4XI3cZ+MnGql9ehQv3DPjcL6NghqCUKQ1qSSLVWl+N7rXlBKctRDeD?=
 =?us-ascii?Q?AmXclXgEgHivcSv23eKBHAj5t5mvH9jTCS/TzqGoKOpPKVbtgi99GkjqcRFL?=
 =?us-ascii?Q?1ue9F6uAMLGlHnX+wvB93GHkaWi+rgxK/ewrVFqH7+OBM9AWJQr77Ax7C42m?=
 =?us-ascii?Q?trnkxLJ7DzWs28sWIyIQ/5AinABN8QZU7gTTshikNz2iRGJi3B+KBLqWvSbc?=
 =?us-ascii?Q?4SclBz/pDojJG2wtY8M2Rctc9wBpwgk1deP1FZ5ZCZamhRqKIPzanxWUYRB5?=
 =?us-ascii?Q?kvp2tNjC0BBijtIxBAUigtsE0S9gve6+U3NKspUTXJKYy4JYT52OsGMXFx6r?=
 =?us-ascii?Q?xQEHjUxxEHqRhqW/vhImJBx2biFIfO6CuneKbVsEHbwW2PzeOYOocxooTWt4?=
 =?us-ascii?Q?e/uO5QHYnvag4aH1N687EFqgxfBZPkgCH8b/zIx5rM2KNdAW+1iKTr1fhQWE?=
 =?us-ascii?Q?YJMl8EpkbkbvoLjL+wwlQpOgM5AyQoaeqG3g5hbnUYpHrH+xTpt5SANgXh46?=
 =?us-ascii?Q?0/pxHCusqCOpqGy7QUj0+GOJLoA1y+4aX22TltRLS1hclg9U0wa/MOKjHa6O?=
 =?us-ascii?Q?l7sDjdJ+BK8kTbtzi48Od2S2qAnArU6ggZ9lcO1syXL3a8kOz5dliO+VoZed?=
 =?us-ascii?Q?zut+FBvYVId+HT+0yUi6A4M1VNcwafjcynYRVWMSQOZyqoB1h5A5Nn2H8Mt5?=
 =?us-ascii?Q?7Ck4748Y136SaJqg5glxRVe2kKs1D9xASTf7B+M6bYDvDHMBPsVN6aKKYzvQ?=
 =?us-ascii?Q?O3Mdr/gHdtUXQA2WjYQAkZpiEkT2TCi6dfzloI3PKbMP26gKCy/JidgS0oc5?=
 =?us-ascii?Q?ADLfzz0NAlDWjMxfgBJPx9TChKRQVidSgMgzf+8BUazS23NUnzvVM7L4bjeN?=
 =?us-ascii?Q?mDlSflMN1hJLAU95FeItJcYFqvZQIkzeqhz/RSMz9XNMu1S9iqaI7l00kcmt?=
 =?us-ascii?Q?y/sM2jTgDYQCy4SaGXQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef470042-8530-4b0e-4623-08dab6b478c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziirZJgZG9YaBjWAECfgzIFQb7ijxaKM+ZucHX4t6QkXoKVQeyaTKmH7vyG4i/r3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          | 399 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   5 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  13 +
 5 files changed, 421 insertions(+)
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
index 00000000000000..b572b01f67b7b5
--- /dev/null
+++ b/drivers/iommu/iommufd/device.c
@@ -0,0 +1,399 @@
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
+ * The caller must undo this with iommufd_unbind_device()
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
+	 * DMA IOAs. There is currently no way to create a MSI window that
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
+		if (rc && rc != -ENODEV)
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
+		goto out_iova;
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
+	}
+
+	if (list_empty(&hwpt->devices)) {
+		rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+		if (rc)
+			goto out_detach;
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
+		if (!hwpt->auto_domain ||
+		    !refcount_inc_not_zero(&hwpt->obj.users))
+			continue;
+
+		rc = iommufd_device_do_attach(idev, hwpt, flags);
+		refcount_dec(&hwpt->obj.users);
+		if (rc) {
+			/*
+			 * FIXME: Requires the series to return EINVAL for
+			 * incompatible domain attaches.
+			 */
+			if (rc == -EINVAL)
+				continue;
+			goto out_unlock;
+		}
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
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iommu_detach_group(hwpt->domain, idev->group);
+	}
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
index e1521764a335e6..e982efca161699 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -102,6 +102,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 };
@@ -227,6 +228,8 @@ struct iommufd_hw_pagetable {
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
+	bool enforce_cache_coherency : 1;
+	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct mutex devices_lock;
@@ -238,4 +241,6 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+void iommufd_device_destroy(struct iommufd_object *obj);
+
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 84d315b9e73845..774c286da04d38 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
 static struct iommufd_object_ops iommufd_object_ops[] = {
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
2.38.0

