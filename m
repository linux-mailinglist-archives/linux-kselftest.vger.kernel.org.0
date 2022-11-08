Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469E16204EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiKHAtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKHAtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1581F9C0;
        Mon,  7 Nov 2022 16:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOUCzBFR+WR+bLEzuDRDIVTOdmEhzv5w58C1jw5RR6Bg+CMIn+qS3S19No3/Cs2ECD/2wDyMYxpWcmHXjCubM+M5QKqBGyrDJKPhfeubxeYZ4depJ8ff03/t/K/C/N/DfQXtrh2Ym9i0HP0wB/ZFwLcgR03+j1vMCloOvLsxUWnAzx4CCH2tWV3KQ0JHK2bRr4ymJTI2/Qaw1wXsHXUYgUORKqf8HqZ63+RSiXVpzg8iMKbYEy2gRAhcBHgPZ7F4YZRSCgMIdnF+g96/5YWrt/YKUpJb56iD/nAHS4fnKcEe0lC9GdYMcvXqfBGd/7boDTO/JTEf5IEj1ZLt4ClKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJyFjVqFUivODmsOKqYLbJlMU9rCdX0hU6O7Lkr3Ik0=;
 b=KSRjW61bmMxblGBHGMhApg+RaFt8LmPiSHNTY0c0XsuWWgoaG8Kw3UZ+2r0dW1tWv+u/myPOPT0NOvC25ksRLx/sFFsX6/0ewmTna1Yn31DnxYtZy2siLJHqcJRwcjE6bTMrMtIaNS4iKe0SJHL+2luvHyqatZKQee9/hJpgggqmhy9UahcHnKXIQ8RoU3ooblKLLMojLVeHuJ/dfjGQJkm8BxRMHh3uQHRFIDaOtv9lF0u90W1iOFWL8ZHLgEga/Xts1VIHdnU2+UBiZdycjtl0LFRwUuBwGrQ8+g/1fM1V+oWReh1klj9WLScEymj5HoejQ/8SNTaqt46Opkl00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJyFjVqFUivODmsOKqYLbJlMU9rCdX0hU6O7Lkr3Ik0=;
 b=NaLV78RcSV7BB7ZaX54w2LWOnedqJp3rgfZI6ftUmjYg3FQC2lpCjT7HssZjUeZn3SOjvHdsprBC/M4FuwPwuDOygFfC2ubriP9cSPTbmpqRVJkSfqtpJfvJgqmJoIegYLSGF/akLPRL6z9eWf0cQ0D2ceV90st7p0YWDFYxpPqZqFk/1HjoN5qz0OBtLC1CV8lbbIg2rjmsFY86aK1ZMqaJtGM+GbRxUGl6PJAjBiQaF7nBVE4dPRtWbECSgNy7bJIm56lgwSjTRob4Srs4qucQYnO1d5nhE2qLMrMvqcsnzScafmYJIzA4IYHHT2tfe4GrdycAI0iczhcYOjqQVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:13 +0000
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
Subject: [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for physical devices
Date:   Mon,  7 Nov 2022 20:49:05 -0400
Message-Id: <12-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0b023c-54b7-434e-c198-08dac1230cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTqS5nqoFVmEJMn0Weqew2HeeWTwa8eLi1rulgtZfQiJGirjje5KN0gdvoYJdK/JgiadBrVabah8cLXbo5bqHfJEIG/oEhUbkiIxdury6Mt69t3WK2xhvS1dPRofI8PJmT89JPJNfiEOVfbOIEby1zJ9L+Pk/3KgBf+BDVF6aknvpemsTbQE4Y+R7fW6LK6hJggE1wOhlMxh2gMHIdWx2EnbNxoDt+9JXDc+0gdjyGL2G6i4iIxZRrZxWy0JiXo7jr49ikpIj0815vrx5a+L3DRVeU3Ex2BQ9u8J/qzT0xdZWDNif2d6Tj7q2uKfgb+qdzvA+ninbUJ2mmEhTcD/hZ2q5R32g/Wl3okM52iXCI4jRjLocgNeMwcR8mwco6siJ5vX68ikubwtxrU7fOjtep7IZp/nzUGNid5JRrO/tJ45Jx7HD+p+Sx85zwMWNGIN6sCIzrvPdtEB1cfCACXwQQyyr6ZSCfOIFq77IPWegejSjXqaWZer+4kwQE1rxvY8p0rAoNFdea41PKoopaChwtq5bBHexDhIiFIQMavELS3OwGSe6L43qWbAOW1SKSUun//afOjXDtL9pbnN30jy0AeDTryH09cNvb+yVqwXUaSP6BCqNr+Q8GjFB6zZWcJG9eV63cjY1xtPRFA3cvb85pRSbqXyrm5gEbaV/tyZjI3sDH1I/ZV6IfUFvXWklTxQd32ngCeVS9xFbIlqbp+8yGrcd0VipmuR5qD8mdoo/X1GDBZvg0XhiXLVUI2pUWGe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRYUP/PNrbG97mJmpIRMhSfGOLtA4xb9bIZcnfekt3MRP6LSN4vaM/osFNxt?=
 =?us-ascii?Q?YJ58Qw+JG9Y5W7BpN4mHSlGGjMnkxQerAK4Z5OyEaaBne8bEOER1j0RU3UPj?=
 =?us-ascii?Q?2gJsnZGsoV7B9AZE5lzGYEimS61BrO4FbzL8sQcD8HU8jAVfawmGeJPvK42S?=
 =?us-ascii?Q?ei5c8NKxaOkZrH1KvQPWdOCxiMvcSZ9B6Pyf/n2P6jjH5xmYVByPwa2pYtCb?=
 =?us-ascii?Q?I+UTRSzED5ZAkK4XAuHu5Ba/VGQXI95Cqh0qFtp4KUGYHyHojWlyFIi3bkNo?=
 =?us-ascii?Q?iTfJ6zDxP6trRCunCRZT+m4RlH3+mN3P5sbFWXFHBTgRz42IVCeS8WTuF8qB?=
 =?us-ascii?Q?RkCiJU1m3R/x3wf1VFhd+j1aZ50H8SZ1w2Fm3Xu1xS2UXydtdV+zyYOwlwjA?=
 =?us-ascii?Q?qSKCiUgCVjFJtlJWTmZ0TOj8YQt/MiNa9hx3iGisu7Ql8bCHaYFx7sTK6GH6?=
 =?us-ascii?Q?D5+1J9nFz0HLnAqW4d1pCmZ4gmRmjigtVmZeDeimrLWPE674iH9AI1lG/kGJ?=
 =?us-ascii?Q?4E6HXOHkGlKfX89/vgbGP4vM6M46TLN6MFrafLx1uEhJLaFL0ztLTP5NZ3n6?=
 =?us-ascii?Q?2Cqq/EjBdgj9FD+5TQ5sxeHimscEWUGVuxwp6qSOtI8ZJ1MR18obFhw10JV6?=
 =?us-ascii?Q?zbv3m7ZQgzHU8uCa8ztSbEgVRum/lF680v8AZ71fxLMkXwqmNDZNJXa9E/eN?=
 =?us-ascii?Q?3+PiJSO9m58S84pz6VmetIcqNhLGsboGmpe9406rnzOhjl+57n5bFngwdr49?=
 =?us-ascii?Q?wp53CixyTtOpnKqZd9h4we7l7nh5s2V1UDZrikzFXAp6ozp3IcmyLpXbat4p?=
 =?us-ascii?Q?yAC4gMV2OYlQvXjS6CrFxXcY+tZYJ/02mFBNGMTQEkljFuiOXBpcOOpFG2E+?=
 =?us-ascii?Q?KZFob90J8nnX66Pdr5HbMHVQJGTgYEpyAxF+1jGektRCo5VhPIZz5QtmEd84?=
 =?us-ascii?Q?KmJeb0CY7XVmAVRqZUU7//rJRQL3fvbHbPmnN03O+T4BCBnaVsPpUG2Au9JX?=
 =?us-ascii?Q?EHWcGOeFb76TLZI3MI4FQjzvv1d8ElDRl5mqfttukzHS4VFz4CXH7eHg5rYm?=
 =?us-ascii?Q?IKzvYcT6N56IZYOYzHJnWIGBaMdShg6nXqlo3kKdjRBDPPtD1bs7A0rCKKIT?=
 =?us-ascii?Q?0lUGiSrxXqdonhTw53Ux7W1I5wOo7dXQOEvQOPCn/CJAg3KwYijJtN3Td8QR?=
 =?us-ascii?Q?qBUWOhsBNcXdjnm/yLVXpi+80LE7q36ct+jw0Y9X44Yca8wlZxPcUMgZ+BKr?=
 =?us-ascii?Q?JNwSMG/zGmqBD2sB8O5R1oM+ecw8ZpR1KubLcfP9FD0YN9xq1E4ITPISehKP?=
 =?us-ascii?Q?AiiHnk/hJT8GMz+iWJR3zov27WSdCJbOrkvOEdRTf16s2iS4u+TeONKKzleV?=
 =?us-ascii?Q?t7GCvpGIPbQpfIz8WtdzZmH8mCrDbWniPrQsO/QayKOs7FGPp2Fvab+uHz9a?=
 =?us-ascii?Q?iDfuDDiXtf4dfaDkzO+CtOT808qv6b/s+2UxqVzcFKE5qft7jKcQkHbJWa+V?=
 =?us-ascii?Q?gZBAm81QpBmqOdhjhY2/eCOUxGxIVWP2BvChcGYvk93OoVNGUPKyuq8ErSgl?=
 =?us-ascii?Q?SBeM8aHVP9pL44ZXtbA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0b023c-54b7-434e-c198-08dac1230cfd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKShSMfkkBxw0zoOt+OYAeqxZfSpghCtHw2Ju48gjnbX8vjUs+5g/xhs7JyVqEcq
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

Add the four functions external drivers need to connect physical DMA to
the IOMMUFD:

iommufd_device_bind() / iommufd_device_unbind()
  Register the device with iommufd and establish security isolation.

iommufd_device_attach() / iommufd_device_detach()
  Connect a bound device to a page table

Binding a device creates a device object ID in the uAPI, however the
generic API provides no IOCTLs to manipulate them.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          | 402 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   5 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  13 +
 5 files changed, 424 insertions(+)
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
index 00000000000000..a3bf3c07d3f800
--- /dev/null
+++ b/drivers/iommu/iommufd/device.c
@@ -0,0 +1,402 @@
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
+	else
+		dev_warn(
+			idev->dev,
+			"Device interrupts cannot be isolated by the IOMMU, this platform in insecure. Use an \"allow_unsafe_interrupts\" module parameter to override\n");
+
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
index d0272efcd8038e..1f8c73aca176e2 100644
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

