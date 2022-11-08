Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4DF6204F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiKHAtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiKHAtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:20 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B4B1E71E;
        Mon,  7 Nov 2022 16:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUr/iP6R10xTreyC9bHuZLXzl5um6Y+gEsmK4MbJyWzSf9RJYU0kulxMTgU2lOtU0Jrsjorv2qF/X7YQsMTlHLBGM4Um5zB9b4wEkDfok+t7Kij3i4yHlvATP9lDpxbdiTlCaaqEK6q/xugoaB3YGIs2Ed/wiy0k2czf9yYUH7Hl13+uhBe6yktWBtj5AItDzQgkjh+Zht6WC7E1SXrO/OuOVkL4XuisrquuefjgavlubGqtaCSdVTjuocPXWmS0iHcyueTiVxUqy5QOyDcngvJ1Xl1QymS3JHybG484JM9dZF5I7itsawAy5evunZ/RixLe3PQF2fT/hJokI25p9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/rAhOAsoFYxLxlU+XliYEr5EZSXbkEJ9xP/A8r4GO0=;
 b=ZIwDWso8EB7VIprOBCIQ6187d//g2heXJ0BoqWXA3uEuGJCcDokaj0vjG119sOlV1jM8E8BcYuyJarNpyR2yGGzByjj9jFKXkYWuP7DbpSJEEsbzsu8Bh65LbjVW3zHWfU4E2oeLToOl5D5srbL4UwxpDSSyaU6MYCmCXQjJtju1sl7Xny1Ijh9vByrn27qy1IUck45ZLbVe2cDIdLWXLsGagqyJJYeHa+ZMgh1nyRteS+dliRCmzqIrp0kQ0woIaUjLjFTdiHLSiszfOt68PUsAM6B2V2mDNgszjQEHub+cl8sWdp5/CqVwH1iB/y840JCGaeBD+bzUb0lDIb2kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/rAhOAsoFYxLxlU+XliYEr5EZSXbkEJ9xP/A8r4GO0=;
 b=cGgafTMYr7CT8DGOB3DZRsvEN9wd4zghB5OgvyfmLrPQRozrDC1NC3ba9BKsfymaLAWbSE6Qtb7MgCv3Q0w7CXzljce2CQTFpmamgVinlDOocIaFxgmH55zYAqJmnje3OgInEhbQp7ktpPr8WAjqHnjCZVZCgaais6clbk0+grYOcQXySCIOTk1MauRK0kSC5FJOpQDFokJ0edHxpTyyYIUhq83VYzyDu71ZM/J6D0hPkXrrYZPKlxuD1sC98QpDVz/mUYqw5+xjPOPImH+AcMImbANxiDhXwAqpTGANdefXwE2VRv4CamxtQc0T3GquwiBhRfub8fuiyMC2W9Kjwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:12 +0000
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
Subject: [PATCH v4 10/17] iommufd: IOCTLs for the io_pagetable
Date:   Mon,  7 Nov 2022 20:49:03 -0400
Message-Id: <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:208:a8::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: ec33fdf7-655a-4d3a-2751-08dac1230ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGcFO1viZ4V1Y0UNYBlKlqSIZiYr61Ly/ZJBWIK6AJRbCNpdSrXuXyJxHIfeNoB9md+K/ULD3YnOSAcouR5KBw9xpQ2sei7Mhix4t4oKInQOCX4T7wcbRocWPTC7QI1IknMNIz2g1YN9IXUSJT1t0s83pJUuXhwY1dwEblimEMJ6HFtc0wzxBen6/jB8QF7lf2UTyAH69DnnN0C6elbc6La5uxvIOeQo39eAXm53iIPsWx9SwZ793VMdASQrooChb2fWkxZKttXOuEOykCyTQD1KMRxQBxI4+v/DjM0fa3HgzmyessmhX3rEWz0JhoR/m9ImN3AC+GTIoeE+/MlW3ncCNrliYzavwE0icBqb8dm0uKXKVpLSQmmTBEbFSwj9uPZo0i5wdvwQxVv0PdFcinx7qK7WLC+JaMUwfU7bJJa0vNSJRVcqrkwk65Tu0e0wL/6G3vFNwfvm30d6cSNuGKo7eDI3ZWHoke8e2WRbzakFtl2+VXu1V/mDWT1f7khQi83kyxQlLyOTMRklXG47a7gLgcfwbe20Ag6cooPXGf4YKtw9AIzlcyy9fVSwrXn6+tEUO+et+QRoJxLBYcSNGoqztIL20fEy2BCEFr00JZ/+6wr1ubyIegS+uptscRyaQby2TXuslk5tv7zCglS1Ao2O6nIuENICqKWAQn7dDMjcPN2mMxqb3AmWNWg/+bhErSU5PZWzPwW+l4bCo9yy1yFkLG7UtkG4i8vbd5GCAPlOv/k4avPlMfcOvAcSC+bd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(36756003)(86362001)(30864003)(478600001)(2906002)(6486002)(38100700002)(921005)(26005)(186003)(6512007)(2616005)(54906003)(316002)(4326008)(66476007)(6666004)(6506007)(110136005)(41300700001)(8676002)(8936002)(7416002)(7406005)(66946007)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FL2LtBVGc8riCifwU0KTypUUBzHsj86LgZt28BvhJlEcKS/+HXJW+E50krcS?=
 =?us-ascii?Q?JDgTviVr2chV1GY8BO5No+L/Fjyapgv/O/JkeW7ynEG2zq58JDGfcjg+H37t?=
 =?us-ascii?Q?FU6KmBTSx/jFwcqA444kvH4kjejCSpDKiUbimgLHgR/vaHu0TPDKLYudNoxD?=
 =?us-ascii?Q?ukxc5CMQYlGfGXsdnxCJX6sM2w/72Fu3jpCruX51afpETzaY5Q1UgrTdWWy4?=
 =?us-ascii?Q?7vAOThyDmg0YT8CIEUPaN1yekg4DiSARt1XOq68pMl8O4p1FEr7qbBqefd/B?=
 =?us-ascii?Q?wr724WvIVG6DD0oj9VpnVc3Q03gbQRdJMEvfsC4+uXaIDB7NUTuSIobA6pPc?=
 =?us-ascii?Q?cBCu/YzT2nD2msMqUd3z8xBGGeBb0WuWuHOt53nrLBu4VD2I8mynzXlF0hXC?=
 =?us-ascii?Q?B5zMaTDlWioY3dBlrEs55HM845Ji+Cl2Okv9f4HWCmRhgR/QvJyoNV+Xaz6Q?=
 =?us-ascii?Q?QwcbGVJ8c1Ofn3DhK6yly6g5XYRopKvebXOCuSxEokaqXrMp/fXexlEUdCuI?=
 =?us-ascii?Q?TJnMcbbioaw0Y2zF98z5w/+bTh+uHokgATBZo1ZqlyokE5z5hhRiKksbVMBc?=
 =?us-ascii?Q?JND/lHQ0Y+Z5o2cGX+0uF/WBtHF4MJKDkpmGj2UVx/TDPm46LDf5r5XsmIRX?=
 =?us-ascii?Q?z+sYhLq89ojOF7/drHUqLfnkwSWTLSE/bqxWnRFTaKKAfzPzDF+yaLKx74JN?=
 =?us-ascii?Q?z23ePusDSPzAybEfGMjAJIH3WBQ2sxgP0I7lDek52o+ZvOI56SlOEygOujsx?=
 =?us-ascii?Q?CxCR2bDgIy8B6QlWnYu5yHjfeffj6/wbW/fY4gJ+d8G0r32BVuPm7EqYUGyW?=
 =?us-ascii?Q?jprY/UCdIaObXtLsyj9AXjvr9qyqdhBPRTmxmwmQUOsQbrTeUe8CJsMDErzY?=
 =?us-ascii?Q?H7yvjIOpiV+hMq2DRHb60n2KvXPNicJ2fTN/Anq9xXh9HJW/MrQSkzhKLFWy?=
 =?us-ascii?Q?6mRWqQzLW7UFibXJsTkTBDXxs9k/piMCQ8lTonnQiuojYS7fVJWYrWvzE3cx?=
 =?us-ascii?Q?NNs7br7rwbWB1naURdQd3QT4Xp/nlg+LR6eJRzm1lxLmy7KYDiM2ntmTC96v?=
 =?us-ascii?Q?q9zxUGCdvHEkiwUX2OSqTeQx9uRSVRsgP5Y9jF5p9aKKF7VpWaXMRWYe4FCr?=
 =?us-ascii?Q?AzUEpMUu+9oar+CZzudfbyUSXuMPxy35x3K0u5xdMaIQMZJs8NseO0prQZ7U?=
 =?us-ascii?Q?rXGyMR9Fdc3fOOUsqKi4AdEZLtGeXTp9SiuByM2m+ykkxCn6M07maGQQBfuF?=
 =?us-ascii?Q?GltXKutm9+ouSTutlGTwaI0nqcg4K9WCq+7LxfNN29DLCfu0ZlOl6K0Ws3f5?=
 =?us-ascii?Q?jPgy0i8Cym53JtXLTeFILoLbVoz+GSXipLJO9VMs2TCzERJortUmKZ9l3Uh8?=
 =?us-ascii?Q?71hZ3NOsXTIOHqnm5kKNFsss681ThZYzgqmN8hsfVXh9oMYwSLQu/Ctsu9js?=
 =?us-ascii?Q?ciDIqpZJu87lSCjvNrn2mMtEIxG6DkKpeyGQtFVeWN+QFsLQFCtSFIwgRK1W?=
 =?us-ascii?Q?oIv1gm1ulHXtL0xVZv56sRxCwCD7OReWen/SOyyF33LiJDA0CqVyUAYpQeGp?=
 =?us-ascii?Q?o7vcJnY31NrcybLbMis=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec33fdf7-655a-4d3a-2751-08dac1230ce1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOF8VXavxki9tU4CQYlifNJBr9wW2zNfynZUXw1B81ZtkGoJMHo449hN2ijLvjDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Connect the IOAS to its IOCTL interface. This exposes most of the
functionality in the io_pagetable to userspace.

This is intended to be the core of the generic interface that IOMMUFD will
provide. Every IOMMU driver should be able to implement an iommu_domain
that is compatible with this generic mechanism.

It is also designed to be easy to use for simple non virtual machine
monitor users, like DPDK:
 - Universal simple support for all IOMMUs (no PPC special path)
 - An IOVA allocator that considers the aperture and the allowed/reserved
   ranges
 - io_pagetable allows any number of iommu_domains to be connected to the
   IOAS
 - Automatic allocation and re-use of iommu_domains

Along with room in the design to add non-generic features to cater to
specific HW functionality.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/ioas.c            | 384 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  33 ++
 drivers/iommu/iommufd/main.c            |  45 +++
 include/uapi/linux/iommufd.h            | 241 +++++++++++++++
 5 files changed, 704 insertions(+)
 create mode 100644 drivers/iommu/iommufd/ioas.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index b66a8c47ff55ec..2b4f36f1b72f9d 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	io_pagetable.o \
+	ioas.o \
 	main.o \
 	pages.o
 
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
new file mode 100644
index 00000000000000..7671456e86413a
--- /dev/null
+++ b/drivers/iommu/iommufd/ioas.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/interval_tree.h>
+#include <linux/iommufd.h>
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include "io_pagetable.h"
+
+void iommufd_ioas_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_ioas *ioas = container_of(obj, struct iommufd_ioas, obj);
+	int rc;
+
+	rc = iopt_unmap_all(&ioas->iopt, NULL);
+	WARN_ON(rc && rc != -ENOENT);
+	iopt_destroy_table(&ioas->iopt);
+}
+
+struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
+{
+	struct iommufd_ioas *ioas;
+
+	ioas = iommufd_object_alloc(ictx, ioas, IOMMUFD_OBJ_IOAS);
+	if (IS_ERR(ioas))
+		return ioas;
+
+	iopt_init_table(&ioas->iopt);
+	return ioas;
+}
+
+int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_alloc *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_ioas_alloc(ucmd->ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	cmd->out_ioas_id = ioas->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_table;
+	iommufd_object_finalize(ucmd->ictx, &ioas->obj);
+	return 0;
+
+out_table:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &ioas->obj);
+	return rc;
+}
+
+int iommufd_ioas_iova_ranges(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_iova_range __user *ranges;
+	struct iommu_ioas_iova_ranges *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	struct interval_tree_span_iter span;
+	u32 max_iovas;
+	int rc;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	down_read(&ioas->iopt.iova_rwsem);
+	max_iovas = cmd->num_iovas;
+	ranges = u64_to_user_ptr(cmd->allowed_iovas);
+	cmd->num_iovas = 0;
+	cmd->out_iova_alignment = ioas->iopt.iova_alignment;
+	interval_tree_for_each_span(&span, &ioas->iopt.reserved_itree, 0,
+				    ULONG_MAX) {
+		if (!span.is_hole)
+			continue;
+		if (cmd->num_iovas < max_iovas) {
+			struct iommu_iova_range elm = {
+				.start = span.start_hole,
+				.last = span.last_hole,
+			};
+
+			if (copy_to_user(&ranges[cmd->num_iovas], &elm,
+					 sizeof(elm))) {
+				rc = -EFAULT;
+				goto out_put;
+			}
+		}
+		cmd->num_iovas++;
+	}
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put;
+	if (cmd->num_iovas > max_iovas)
+		rc = -EMSGSIZE;
+out_put:
+	up_read(&ioas->iopt.iova_rwsem);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static int iommufd_ioas_load_iovas(struct rb_root_cached *itree,
+				   struct iommu_iova_range __user *ranges,
+				   u32 num)
+{
+	u32 i;
+
+	for (i = 0; i != num; i++) {
+		struct iommu_iova_range range;
+		struct iopt_allowed *allowed;
+
+		if (copy_from_user(&range, ranges + i, sizeof(range)))
+			return -EFAULT;
+
+		if (range.start >= range.last)
+			return -EINVAL;
+
+		if (interval_tree_iter_first(itree, range.start, range.last))
+			return -EINVAL;
+
+		allowed = kzalloc(sizeof(*allowed), GFP_KERNEL_ACCOUNT);
+		if (!allowed)
+			return -ENOMEM;
+		allowed->node.start = range.start;
+		allowed->node.last = range.last;
+
+		interval_tree_insert(&allowed->node, itree);
+	}
+	return 0;
+}
+
+int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_allow_iovas *cmd = ucmd->cmd;
+	struct rb_root_cached allowed_iova = RB_ROOT_CACHED;
+	struct interval_tree_node *node;
+	struct iommufd_ioas *ioas;
+	struct io_pagetable *iopt;
+	int rc = 0;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+	iopt = &ioas->iopt;
+
+	rc = iommufd_ioas_load_iovas(&allowed_iova,
+				     u64_to_user_ptr(cmd->allowed_iovas),
+				     cmd->num_iovas);
+	if (rc)
+		goto out_free;
+
+	rc = iopt_set_allow_iova(iopt, &allowed_iova);
+out_free:
+	while ((node = interval_tree_iter_first(&allowed_iova, 0, ULONG_MAX))) {
+		interval_tree_remove(node, &allowed_iova);
+		kfree(container_of(node, struct iopt_allowed, node));
+	}
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static int conv_iommu_prot(u32 map_flags)
+{
+	int iommu_prot;
+
+	/*
+	 * We provide no manual cache coherency ioctls to userspace and most
+	 * architectures make the CPU ops for cache flushing privileged.
+	 * Therefore we require the underlying IOMMU to support CPU coherent
+	 * operation. Support for IOMMU_CACHE is enforced by the
+	 * IOMMU_CAP_CACHE_COHERENCY test during bind.
+	 */
+	iommu_prot = IOMMU_CACHE;
+	if (map_flags & IOMMU_IOAS_MAP_WRITEABLE)
+		iommu_prot |= IOMMU_WRITE;
+	if (map_flags & IOMMU_IOAS_MAP_READABLE)
+		iommu_prot |= IOMMU_READ;
+	return iommu_prot;
+}
+
+int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_map *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	unsigned int flags = 0;
+	unsigned long iova;
+	int rc;
+
+	if ((cmd->flags &
+	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
+	       IOMMU_IOAS_MAP_READABLE)) ||
+	    cmd->__reserved)
+		return -EOPNOTSUPP;
+	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
+		return -EOVERFLOW;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
+		flags = IOPT_ALLOC_IOVA;
+	iova = cmd->iova;
+	rc = iopt_map_user_pages(ucmd->ictx, &ioas->iopt, &iova,
+				 u64_to_user_ptr(cmd->user_va), cmd->length,
+				 conv_iommu_prot(cmd->flags), flags);
+	if (rc)
+		goto out_put;
+
+	cmd->iova = iova;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_copy *cmd = ucmd->cmd;
+	struct iommufd_ioas *src_ioas;
+	struct iommufd_ioas *dst_ioas;
+	unsigned int flags = 0;
+	LIST_HEAD(pages_list);
+	unsigned long iova;
+	int rc;
+
+	if ((cmd->flags &
+	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
+	       IOMMU_IOAS_MAP_READABLE)))
+		return -EOPNOTSUPP;
+	if (cmd->length >= ULONG_MAX || cmd->src_iova >= ULONG_MAX ||
+	    cmd->dst_iova >= ULONG_MAX)
+		return -EOVERFLOW;
+
+	src_ioas = iommufd_get_ioas(ucmd, cmd->src_ioas_id);
+	if (IS_ERR(src_ioas))
+		return PTR_ERR(src_ioas);
+	rc = iopt_get_pages(&src_ioas->iopt, cmd->src_iova, cmd->length,
+			    &pages_list);
+	iommufd_put_object(&src_ioas->obj);
+	if (rc)
+		return rc;
+
+	dst_ioas = iommufd_get_ioas(ucmd, cmd->dst_ioas_id);
+	if (IS_ERR(dst_ioas)) {
+		rc = PTR_ERR(dst_ioas);
+		goto out_pages;
+	}
+
+	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
+		flags = IOPT_ALLOC_IOVA;
+	iova = cmd->dst_iova;
+	rc = iopt_map_pages(&dst_ioas->iopt, &pages_list, cmd->length, &iova,
+			    conv_iommu_prot(cmd->flags), flags);
+	if (rc)
+		goto out_put_dst;
+
+	cmd->dst_iova = iova;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put_dst:
+	iommufd_put_object(&dst_ioas->obj);
+out_pages:
+	iopt_free_pages_list(&pages_list);
+	return rc;
+}
+
+int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_unmap *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	unsigned long unmapped = 0;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	if (cmd->iova == 0 && cmd->length == U64_MAX) {
+		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
+		if (rc)
+			goto out_put;
+	} else {
+		if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX) {
+			rc = -EOVERFLOW;
+			goto out_put;
+		}
+		rc = iopt_unmap_iova(&ioas->iopt, cmd->iova, cmd->length,
+				     &unmapped);
+		if (rc)
+			goto out_put;
+	}
+
+	cmd->length = unmapped;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put:
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+int iommufd_option_rlimit_mode(struct iommu_option *cmd,
+			       struct iommufd_ctx *ictx)
+{
+	if (cmd->op == IOMMU_OPTION_OP_GET) {
+		cmd->val64 = ictx->account_mode == IOPT_PAGES_ACCOUNT_MM;
+		return 0;
+	}
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		int rc = 0;
+
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+
+		xa_lock(&ictx->objects);
+		if (!xa_empty(&ictx->objects)) {
+			rc = -EBUSY;
+		} else {
+			if (cmd->val64 == 0)
+				ictx->account_mode = IOPT_PAGES_ACCOUNT_USER;
+			else if (cmd->val64 == 1)
+				ictx->account_mode = IOPT_PAGES_ACCOUNT_MM;
+			else
+				rc = -EINVAL;
+		}
+		xa_unlock(&ictx->objects);
+
+		return rc;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int iommufd_ioas_option_huge_pages(struct iommu_option *cmd,
+					  struct iommufd_ioas *ioas)
+{
+	if (cmd->op == IOMMU_OPTION_OP_GET) {
+		cmd->val64 = !ioas->iopt.disable_large_pages;
+		return 0;
+	}
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		if (cmd->val64 == 0)
+			return iopt_disable_large_pages(&ioas->iopt);
+		if (cmd->val64 == 1) {
+			iopt_enable_large_pages(&ioas->iopt);
+			return 0;
+		}
+		return -EINVAL;
+	}
+	return -EOPNOTSUPP;
+}
+
+int iommufd_ioas_option(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_option *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	int rc = 0;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->object_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	switch (cmd->option_id) {
+	case IOMMU_OPTION_HUGE_PAGES:
+		rc = iommufd_ioas_option_huge_pages(cmd, ioas);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6b7e0982b8c802..68c12115400285 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -11,6 +11,7 @@
 
 struct iommu_domain;
 struct iommu_group;
+struct iommu_option;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -102,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_IOAS,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -174,6 +176,37 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 			     type),                                            \
 		     typeof(*(ptr)), obj)
 
+/*
+ * The IO Address Space (IOAS) pagetable is a virtual page table backed by the
+ * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
+ * mapping is copied into all of the associated domains and made available to
+ * in-kernel users.
+ */
+struct iommufd_ioas {
+	struct iommufd_object obj;
+	struct io_pagetable iopt;
+};
+
+static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
+						    u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_IOAS),
+			    struct iommufd_ioas, obj);
+}
+
+struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx);
+int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_ioas_destroy(struct iommufd_object *obj);
+int iommufd_ioas_iova_ranges(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
+int iommufd_option_rlimit_mode(struct iommu_option *cmd,
+			       struct iommufd_ctx *ictx);
+
 struct iommufd_access {
 	unsigned long iova_alignment;
 	u32 iopt_access_list_id;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3a705cadb85020..266109045537ed 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -202,8 +202,36 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int iommufd_option(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_option *cmd = ucmd->cmd;
+	int rc;
+
+	switch (cmd->option_id) {
+	case IOMMU_OPTION_RLIMIT_MODE:
+		rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);
+		break;
+	case IOMMU_OPTION_HUGE_PAGES:
+		rc = iommufd_ioas_option(ucmd);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (rc)
+		return rc;
+	if (copy_to_user(&((struct iommu_option __user *)ucmd->ubuffer)->val64,
+			 &cmd->val64, sizeof(cmd->val64)))
+		return -EFAULT;
+	return 0;
+}
+
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_ioas_alloc alloc;
+	struct iommu_ioas_allow_iovas allow_iovas;
+	struct iommu_ioas_iova_ranges iova_ranges;
+	struct iommu_ioas_map map;
+	struct iommu_ioas_unmap unmap;
 };
 
 struct iommufd_ioctl_op {
@@ -224,6 +252,20 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
+		 struct iommu_ioas_alloc, out_ioas_id),
+	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
+		 struct iommu_ioas_allow_iovas, allowed_iovas),
+	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct iommu_ioas_copy,
+		 src_iova),
+	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
+		 struct iommu_ioas_iova_ranges, out_iova_alignment),
+	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
+		 iova),
+	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
+		 length),
+	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
+		 val64),
 };
 
 static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
@@ -310,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
 static const struct iommufd_object_ops iommufd_object_ops[] = {
+	[IOMMUFD_OBJ_IOAS] = {
+		.destroy = iommufd_ioas_destroy,
+	},
 };
 
 static struct miscdevice iommu_misc_dev = {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2ad06b27a35fe5..a872a50d800a41 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -37,6 +37,13 @@
 enum {
 	IOMMUFD_CMD_BASE = 0x80,
 	IOMMUFD_CMD_DESTROY = IOMMUFD_CMD_BASE,
+	IOMMUFD_CMD_IOAS_ALLOC,
+	IOMMUFD_CMD_IOAS_ALLOW_IOVAS,
+	IOMMUFD_CMD_IOAS_COPY,
+	IOMMUFD_CMD_IOAS_IOVA_RANGES,
+	IOMMUFD_CMD_IOAS_MAP,
+	IOMMUFD_CMD_IOAS_UNMAP,
+	IOMMUFD_CMD_OPTION,
 };
 
 /**
@@ -52,4 +59,238 @@ struct iommu_destroy {
 };
 #define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
 
+/**
+ * struct iommu_ioas_alloc - ioctl(IOMMU_IOAS_ALLOC)
+ * @size: sizeof(struct iommu_ioas_alloc)
+ * @flags: Must be 0
+ * @out_ioas_id: Output IOAS ID for the allocated object
+ *
+ * Allocate an IO Address Space (IOAS) which holds an IO Virtual Address (IOVA)
+ * to memory mapping.
+ */
+struct iommu_ioas_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 out_ioas_id;
+};
+#define IOMMU_IOAS_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOC)
+
+/**
+ * struct iommu_iova_range
+ * @start: First IOVA
+ * @last: Inclusive last IOVA
+ *
+ * An interval in IOVA space.
+ */
+struct iommu_iova_range {
+	__aligned_u64 start;
+	__aligned_u64 last;
+};
+
+/**
+ * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
+ * @size: sizeof(struct iommu_ioas_iova_ranges)
+ * @ioas_id: IOAS ID to read ranges from
+ * @num_iovas: Input/Output total number of ranges in the IOAS
+ * @__reserved: Must be 0
+ * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
+ * @out_iova_alignment: Minimum alignment required for mapping IOVA
+ *
+ * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these ranges
+ * is not allowed. num_iovas will be set to the total number of iovas and
+ * the allowed_iovas[] will be filled in as space permits.
+ *
+ * The allowed ranges are dependent on the HW path the DMA operation takes, and
+ * can change during the lifetime of the IOAS. A fresh empty IOAS will have a
+ * full range, and each attached device will narrow the ranges based on that
+ * device's HW restrictions. Detatching a device can widen the ranges. Userspace
+ * should query ranges after every attach/detatch to know what IOVAs are valid
+ * for mapping.
+ *
+ * On input num_iovas is the length of the allowed_iovas array. On output it is
+ * the total number of iovas filled in. The ioctl will return -EMSGSIZE and set
+ * num_iovas to the required value if num_iovas is too small. In this case the
+ * caller should allocate a larger output array and re-issue the ioctl.
+ */
+struct iommu_ioas_iova_ranges {
+	__u32 size;
+	__u32 ioas_id;
+	__u32 num_iovas;
+	__u32 __reserved;
+	__aligned_u64 allowed_iovas;
+	__aligned_u64 out_iova_alignment;
+};
+#define IOMMU_IOAS_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_IOVA_RANGES)
+
+/**
+ * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
+ * @size: sizeof(struct iommu_ioas_allow_iovas)
+ * @ioas_id: IOAS ID to allow IOVAs from
+ * @num_iovas: Input/Output total number of ranges in the IOAS
+ * @__reserved: Must be 0
+ * @allowed_iovas: Pointer to array of struct iommu_iova_range
+ *
+ * Ensure a range of IOVAs are always available for allocation. If this call
+ * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of IOVA ranges
+ * that are narrower than the ranges provided here. This call will fail if
+ * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given ranges.
+ *
+ * When an IOAS is first created the IOVA_RANGES will be maximally sized, and as
+ * devices are attached the IOVA will narrow based on the device restrictions.
+ * When an allowed range is specified any narrowing will be refused, ie device
+ * attachment can fail if the device requires limiting within the allowed range.
+ *
+ * Automatic IOVA allocation is also impacted by this call. MAP will only
+ * allocate within the allowed IOVAs if they are present.
+ *
+ * This call replaces the entire allowed list with the given list.
+ */
+struct iommu_ioas_allow_iovas {
+	__u32 size;
+	__u32 ioas_id;
+	__u32 num_iovas;
+	__u32 __reserved;
+	__aligned_u64 allowed_iovas;
+};
+#define IOMMU_IOAS_ALLOW_IOVAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOW_IOVAS)
+
+/**
+ * enum iommufd_ioas_map_flags - Flags for map and copy
+ * @IOMMU_IOAS_MAP_FIXED_IOVA: If clear the kernel will compute an appropriate
+ *                             IOVA to place the mapping at
+ * @IOMMU_IOAS_MAP_WRITEABLE: DMA is allowed to write to this mapping
+ * @IOMMU_IOAS_MAP_READABLE: DMA is allowed to read from this mapping
+ */
+enum iommufd_ioas_map_flags {
+	IOMMU_IOAS_MAP_FIXED_IOVA = 1 << 0,
+	IOMMU_IOAS_MAP_WRITEABLE = 1 << 1,
+	IOMMU_IOAS_MAP_READABLE = 1 << 2,
+};
+
+/**
+ * struct iommu_ioas_map - ioctl(IOMMU_IOAS_MAP)
+ * @size: sizeof(struct iommu_ioas_map)
+ * @flags: Combination of enum iommufd_ioas_map_flags
+ * @ioas_id: IOAS ID to change the mapping of
+ * @__reserved: Must be 0
+ * @user_va: Userspace pointer to start mapping from
+ * @length: Number of bytes to map
+ * @iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is set
+ *        then this must be provided as input.
+ *
+ * Set an IOVA mapping from a user pointer. If FIXED_IOVA is specified then the
+ * mapping will be established at iova, otherwise a suitable location based on
+ * the reserved and allowed lists will be automatically selected and returned in
+ * iova.
+ */
+struct iommu_ioas_map {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 __reserved;
+	__aligned_u64 user_va;
+	__aligned_u64 length;
+	__aligned_u64 iova;
+};
+#define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
+
+/**
+ * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
+ * @size: sizeof(struct iommu_ioas_copy)
+ * @flags: Combination of enum iommufd_ioas_map_flags
+ * @dst_ioas_id: IOAS ID to change the mapping of
+ * @src_ioas_id: IOAS ID to copy from
+ * @length: Number of bytes to copy and map
+ * @dst_iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is
+ *            set then this must be provided as input.
+ * @src_iova: IOVA to start the copy
+ *
+ * Copy an already existing mapping from src_ioas_id and establish it in
+ * dst_ioas_id. The src iova/length must exactly match a range used with
+ * IOMMU_IOAS_MAP.
+ *
+ * This may be used to efficiently clone a subset of an IOAS to another, or as a
+ * kind of 'cache' to speed up mapping. Copy has an effciency advantage over
+ * establishing equivalent new mappings, as internal resources are shared, and
+ * the kernel will pin the user memory only once.
+ */
+struct iommu_ioas_copy {
+	__u32 size;
+	__u32 flags;
+	__u32 dst_ioas_id;
+	__u32 src_ioas_id;
+	__aligned_u64 length;
+	__aligned_u64 dst_iova;
+	__aligned_u64 src_iova;
+};
+#define IOMMU_IOAS_COPY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_COPY)
+
+/**
+ * struct iommu_ioas_unmap - ioctl(IOMMU_IOAS_UNMAP)
+ * @size: sizeof(struct iommu_ioas_unmap)
+ * @ioas_id: IOAS ID to change the mapping of
+ * @iova: IOVA to start the unmapping at
+ * @length: Number of bytes to unmap, and return back the bytes unmapped
+ *
+ * Unmap an IOVA range. The iova/length must be a superset of a previously
+ * mapped range used with IOMMU_IOAS_MAP or IOMMU_IOAS_COPY. Splitting or
+ * truncating ranges is not allowed. The values 0 to U64_MAX will unmap
+ * everything.
+ */
+struct iommu_ioas_unmap {
+	__u32 size;
+	__u32 ioas_id;
+	__aligned_u64 iova;
+	__aligned_u64 length;
+};
+#define IOMMU_IOAS_UNMAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_UNMAP)
+
+/**
+ * enum iommufd_option
+ * @IOMMU_OPTION_RLIMIT_MODE:
+ *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
+ *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
+ *    based accounting. Global option, object_id must be 0
+ * @IOMMU_OPTION_HUGE_PAGES:
+ *    Value 1 (default) allows contiguous pages to be combined when generating
+ *    iommu mappings. Value 0 disables combining, everything is mapped to
+ *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
+ *    option, the object_id must be the IOAS ID.
+ */
+enum iommufd_option {
+	IOMMU_OPTION_RLIMIT_MODE = 0,
+	IOMMU_OPTION_HUGE_PAGES = 1,
+};
+
+/**
+ * enum iommufd_option_ops
+ * @IOMMU_OPTION_OP_SET: Set the option's value
+ * @IOMMU_OPTION_OP_GET: Get the option's value
+ */
+enum iommufd_option_ops {
+	IOMMU_OPTION_OP_SET = 0,
+	IOMMU_OPTION_OP_GET = 1,
+};
+
+/**
+ * @size: sizeof(struct iommu_option)
+ * @option_id: One of enum iommufd_option
+ * @op: One of enum iommufd_option_ops
+ * @__reserved: Must be 0
+ * @object_id: ID of the object if required
+ * @val64: Option value to set or value returned on get
+ *
+ * Change a simple option value. This multiplexor allows controlling a options
+ * on objects. IOMMU_OPTION_OP_SET will load an option and IOMMU_OPTION_OP_GET
+ * will return the current value.
+ */
+struct iommu_option {
+	__u32 size;
+	__u32 option_id;
+	__u16 op;
+	__u16 __reserved;
+	__u32 object_id;
+	__aligned_u64 val64;
+};
+#define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)
 #endif
-- 
2.38.1

