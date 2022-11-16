Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D462CBFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiKPVDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbiKPVCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:12 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144186AEE9;
        Wed, 16 Nov 2022 13:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjVIAl5xH3Gm8bRaSWZYvxfn1l452kp6zsHcZOhrP7/xg3rTIThMOFTRrcIRUWLbRjm1NOZCuihoW7Qo7Ql70Y3gXvTQ4SLpA7NO1V0O3W/7UyQeS8d90JW7KsofxlQmSUWMskELeTCJ58E4lyBQbH88FgOt4+h9iJElkWkNQuoARiQushykNzYfQM9gvDmGgC4ff27vtyEsKAo3IFzDObFuqs6jq6pGyww+ehueL+ymCe+L1ZV9m92JXkX6vVMJMttA/gSMx07gqXgaRu4Mpixq/HM03wggozo2VRONtN718X/Y3roJLJjK/nHyt8JTE4kcLELNnR5wFIdaXm3vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80jNWS2V6MBihIYcR+xsRJahrjTV3ll3rCQ6s1MQZXw=;
 b=jluomo5HAhI+U4JZ0uLHNE3SXCTXgAtJZ0bDDmoLi+P65by9cZbBK9n0teYWTKAZbTo1C+ayAW8tELSTLs3p8wN5CA7l3IrmVJtpvr9R1q9M0A4WHfqsaM2SlOiRSCoI6haqWIhrihr6ByG86zLB5qxOd4RoxzQn1F/d5PsGyylRDtgf4L6xrPcscQFOvv4fbHc1XBQlAxItD4vtA6luSbpBfiXlMWAYd8j06lp/KJV4zshWVKCrV07WVFbC+dTyuKSyIoywFuerP1K9u7Ay1Ot/sXIOyAmcDfIzVPRyQCUDV90k8ewLL7J8ag9XmjQcTTLymuFwzz2p1NEgzVzzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80jNWS2V6MBihIYcR+xsRJahrjTV3ll3rCQ6s1MQZXw=;
 b=CTcxeKXbm+5Pk9VhuG8W6N3Dw17R5lEBfYoWxfPsTrrBbSQ3I5iWjJOMo6A8fc0XMMR2Eiw5QIpqxNvpfUlVDc4NJTV6Rj3mHLFwMZVJsJAmwvtF1Vu8neIRdcw/AXILa4FcTl6+g4LmzB9K3/OGkjGWHDNvaq7i0XjccoflF5Nr+ksdsoia/KxTBg8vFuBdxgdRHUv5v/QWkenU27PoxWQ2Oud3Mrv2+ZWiMlDMf7Ct/jM1ZEBJGylsygQuAWjgCpzxu2nRxBMXXYmZ/ftyDwHXpxrANWmAjvmsT4iIB9pXX4DIMqagHTlnvKIndkjp1LhSJHHWiLzPs6CZqbbS0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:05 +0000
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
Subject: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Date:   Wed, 16 Nov 2022 17:00:47 -0400
Message-Id: <11-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be012a2-1819-4dc4-ef40-08dac815a9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPBhCQyHOUEY76ii0qGnY1FQRkCxFyr3qpBxNHCXseXD5p+ok3OYBaxdaRR6dtWKUMTCwzWiKAw0cWqVKX0KU+ljHO0/cN/wAcN5aXbdk0iAAQS3pSbPFH4qzzaPe20Q1rzezpefRXfrRg+XIv5RFCmWyX072LBCOWKsSecw+A0m7iJlyJSEfYMoEUQ9M7NVwXL4vNZTMgXhG+ZNzmmlZoivIuaPhxBp73/ZXjLSgFq1SdZtGsvSb+Yn7SkRDi5tVuVkY1fKkx1jDHxQGoas0AmnmKgYCgrRDQlYKzgYzIJw5YbctHE6gJYXLvfuHl+T7PJ+4GbEeVuN5HNHsbkNDiXMnv+9I9auvak14DtV6X14LXH/tDYLAdl/8zSOovjzla/KfzskIr6Yu7Lch1yZrZGMCcOxKi4CpCT3NHDVQS5oR9NYJOzL4G3vMIQaglYU7wiYFyLquuqfsCSiFvh4WWmb+drgf63xjFFeyKQBFCO041HAxNbQY4099S8wJreJfnYthLEoEAoh+55KoqlDewtTikadVwvciOrOsFfnHxHJGwxLLgQWHqFEeZd3VMVSWEBEs799Y16zFZeFJRVE5uYE41y2soe7JRMbSWfZXL/EiJueW1u1mO3QhvGMGlKYzxG+iVAnCGi0oXMI7rNs6lh16Vfd3qVDvyg2XoSAnJ0iRVIIDgszhLKc27qT8yjRs/g+xr3LxlrJOJbxhE/TzR4vPWB6t+nvFJn4Iyhyxdb1uLOls9xjc4KCUN2aaHe6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(2906002)(30864003)(7406005)(7416002)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zqpY/+lCnWL7Hc7HFV6Fx60YOK1dFwoBvEsbRCXaWYaYA7G7p9f3244eeNQV?=
 =?us-ascii?Q?XHihoi6i7Biffu9PKRwR1axj/+/vkoTdbuXPnFp0+RrH/fCJWhA/XnaFubIS?=
 =?us-ascii?Q?Hc8jgLUQojOeuvr+7NOPgVzZComXPuao5Uo+hROBvIn6I9iEUeaBqYEeMsbW?=
 =?us-ascii?Q?GSM1oaenOZRHgpHe1nias1tN7Di7qZMqaTnUWv16swWWgkh4HW3i8TRTfzTD?=
 =?us-ascii?Q?4KhkMFOIj6Yiph7g6tTwv5ZTh0M2wuwYPJUdWL7oce7rQE9wuNcxHtTa7zuJ?=
 =?us-ascii?Q?aUfkH3vNg1M37Wx3Fk6dPHGK8+vUA3aj7mZh0Lypg0icADWZqH5gKq0Ee7K1?=
 =?us-ascii?Q?e4jiAlLj6+203/LkPg8xo2b+Rvc/DIwGSGozmln6ZFylOc5PTGcoOgN259iN?=
 =?us-ascii?Q?7s34y1MiIBPGwMu4p/xhlL/KVW6GzxXy+8PO+wIJKqw6Lzixfmp4hrnDzNaI?=
 =?us-ascii?Q?MKwHsK+9YW+zXBpHM2r182xoaDf38zGewsntgpnWe8FvUEtkAEqSdpRugfHT?=
 =?us-ascii?Q?JTHlXIRcZ+BKSRgbX5rFPKJ4+N/BAoGcbF1bEg5lkxDKSI3IdQWPz1S7Est+?=
 =?us-ascii?Q?33G6CCpaNKEvllvPjEQCjBQpPLllz8DfbpLZT7KW6p7qSqmxsmkujay2Jx75?=
 =?us-ascii?Q?BoHbHdQr3Xe3DEQPtd5Ow5lgnhS9joQA5Hm2AQJmIT181hbV6wAT9+rxMfxg?=
 =?us-ascii?Q?agyMEnfaz59FIq2/PNq7pU8UcB4C91nSTTjmjhbzqiUH4XCyqr61uOPpoeob?=
 =?us-ascii?Q?Gk4blUCLGQV02MlFDbImCnH0xVn0XRAI6hAjfcasxr+1pUFG1YczgLxzZ4DR?=
 =?us-ascii?Q?t/nIBL/ewBpnIdTRqqXThAvChizLMF+wb8oxZIrLDB+uBYjpHPMxi6xT/Uzv?=
 =?us-ascii?Q?GGLtaa1YExAdlSbbhs/y58EWFFdeT/VkHtrS1PQSEJY0435FF/NMlxzN1mXC?=
 =?us-ascii?Q?djwMv/YOo1igE6MDkrX715jCBAZiyFmFuZ32zmRCMuz6ICXXfGmNAusCS3SU?=
 =?us-ascii?Q?zoIOr2Anr316XjIG8rLqm3YQDNrZbe7uvuvxvbvdrGJ6RlAu38lClyYRD0WU?=
 =?us-ascii?Q?2/LRW4A2KOsfeSBVBTICAbiYVLP8u5K6f+lbnyy1wCxlNQFyoEXz7vRc3JcQ?=
 =?us-ascii?Q?ahtN5GfNNVlKoyq7J0BDiiRD1Bp9aMFwJ9h2qGjYQabshBwvu47IhtSIBYy3?=
 =?us-ascii?Q?iihPX4KeYZGV7Jj0qZIhCLAeaO806s7Wz/MG/BonCj3EXGfRdimsQ84xkSf5?=
 =?us-ascii?Q?089sqq+jQwNvriQw+dKHhSBrzg8xUGGUG7re/n0mFgahCuaLhUJOh5FuZNt+?=
 =?us-ascii?Q?zjQ8hdj7wBNBpTBKfqvvdcETqzh+7QtzE6f+lim1g1jEetg63pglz5UlZGnO?=
 =?us-ascii?Q?0ZyjmyGFO5xCOmIILBHKsUF86GBXUmhPM0Sw2lP0Pz88GQr1RZx3ubZwZ8gf?=
 =?us-ascii?Q?Lo8O46u8zDeh++640PyasFqJ/dfsZrMfIi+BHX5pz9zsK3NQpuH/YuSJav8Z?=
 =?us-ascii?Q?4SLTUSoDiR95YZMdrh3BgowT2bzGc7uLgshVe7OEF4O9DkZmL1booS39LhXa?=
 =?us-ascii?Q?NwNsNZ786FqQ5FNsGEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be012a2-1819-4dc4-ef40-08dac815a9ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:01:00.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DfrcpN91ZOJOuket1/y2rI7WZHXQ3xhpLFRGLdmMfneoe48nL+FV3FIujyH1efR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/ioas.c            | 384 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  33 ++
 drivers/iommu/iommufd/main.c            |  45 +++
 include/uapi/linux/iommufd.h            | 246 ++++++++++++++-
 5 files changed, 708 insertions(+), 1 deletion(-)
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
index dadd90cae543ba..6721332dbbba03 100644
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
index 2ad06b27a35fe5..9e9250dfc4fb1b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -37,12 +37,19 @@
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
  * struct iommu_destroy - ioctl(IOMMU_DESTROY)
  * @size: sizeof(struct iommu_destroy)
- * @id: iommufd object ID to destroy. Can by any destroyable object type.
+ * @id: iommufd object ID to destroy. Can be any destroyable object type.
  *
  * Destroy any object held within iommufd.
  */
@@ -52,4 +59,241 @@ struct iommu_destroy {
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
+ * struct iommu_iova_range - ioctl(IOMMU_IOVA_RANGE)
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
+ * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
+ *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
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
+ * enum iommufd_option_ops - ioctl(IOMMU_OPTION_OP_SET) and
+ *                           ioctl(IOMMU_OPTION_OP_GET)
+ * @IOMMU_OPTION_OP_SET: Set the option's value
+ * @IOMMU_OPTION_OP_GET: Get the option's value
+ */
+enum iommufd_option_ops {
+	IOMMU_OPTION_OP_SET = 0,
+	IOMMU_OPTION_OP_GET = 1,
+};
+
+/**
+ * struct iommu_option - iommu option multiplexer
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

