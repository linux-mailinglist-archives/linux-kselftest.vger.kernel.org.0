Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD960D31E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiJYSMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiJYSMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD4B5141;
        Tue, 25 Oct 2022 11:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HInt0p5JWTQ7T+vs1DPb6X32PH+CTNkRGmmI6xrwsitk13MHLMWYP6tWEFW8n6dhHYo0Xqj8hkb+iXNcO1dz9c3bnd7IRDmVfroM/MvSxG1yXx0IwQUCUhqoAknTfxvOoWJOOinhqEZuZRYDDVppAVXvbl9NMzgBK7srEAeBz6nnApSKxsXg+l2gZFf5ddDZxOIBLbFFkZp9KX3Z22lmVcawlwIBjKakaN+K+mDigRPafIrWE/F/hXHFARwZxGsC6PSQHN4Pjg1smgeMXHA1uElwoKsArWwWuBJxze1Uk3/XGUvycEiiPqG1Lz1msg/UhU2pNbHs0g/f6oFalLBo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k1jEdWbPrB230iYl3DKsZZp2Ntco00Esgp1uKwOQ4A=;
 b=XIGyWj45GPd2Qyv51JhhBODShx7lFSwzgP4qZFdrA/3Plfmd510jZJcts5r02BAyPUwCmggt14YzqLUgp+hrvXPQQAWvPqtHi0bizJqMzEy8gm0fw0e1azSIiLmbDRariH2s5oR1EzFAhpiE4TF7bpPRf9sFLxehcNLTSYvFroKBdr/29U3Qa5ur2GqrDE2Cvh6dOZjDXIV2JAsFxepHm894lIJ+UxEhWzODNwXWW6PE/oBfhBJ9sDD0+VhlpDbkGLaV2Ay3SbjQ31FuORBSHvSR2b4B8SDtQs1VsOfWUPa8hJttyWp5kKbzOobQFYa7G0XSuk21nNhszupR1pbPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k1jEdWbPrB230iYl3DKsZZp2Ntco00Esgp1uKwOQ4A=;
 b=Koz29OtZFMvePFq2EGA0nEgyq/F6UKbjt7hCBPOlRlroDIAYAYc/xz5pnj2XYRE5jHzXVEu6zbppg1Q+sh9QyVpIE6d5w41h9byl8XfBlZYgT3JAIdwDxufIBdUHd/5jbkVaAtAw+5HgvgnHv4fLQzJb2eeqL4oGJp5lcrX5zgP+0xzZKdHO8Ww+RbAIiLJRw3E34Zq+Xzxi02b0XvS/mGnWr2l99u2833p0E3Xfc+cfA3YLx41r1RVL0gBG7Wg2xlWwUi1T5k7Xcnd0oxk/jto9/iG9slgP6nXeTxvJYFOsdKpDdPoxPZBzu74HahRS5mvnN05+Bf57EZOqbk8qCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:28 +0000
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
Subject: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and makefiles
Date:   Tue, 25 Oct 2022 15:12:14 -0300
Message-Id: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:c0::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3664cd70-0560-46bd-6727-08dab6b4783f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIQto3oaxL6AXSJ6eoqqt9aOonhHR4KCBlpQdGTRfSdyYpQEXMl3qnrNGEWKGePmpAopWfIqMAPMfIUvpkU2XNFn45B3cfV2XHxq7KIUVcPm/r3NvuYkjW2iPRJXCIvzunrou/bnCawGjiXkg5/RlLN0k5U3ln1OX2Yd0AhNEVIihtHmHpXrE7jo4rHALCu8mSs82e1H+xG0LGo3Huak1S0J9FjDxpK1MuzAav7PxBBTQt702z5MAj1N8gyxRGZ+Srn1gnJapAlO2PfZ/8tJw+v561fsCuJRYXALagfQSqq9sGodGO35gIWlRolaABZPgFvt+NOZCBBl3XULkvbO+atM45xhWW96NjqzV/3T1Y5mFFj7BsUXSZy89ISd5hoyFkmbsbTjlvuZkNJybuiHXbSl64DqsSBBJjHGsxDrayhlLOM/p+BfzohTclXGU0QHu2f5OzmzEYma0K6hLrPlYlRNu7ZZ6Dec/hTavjNzDKlC4oURxamzN0EVc8JX3BeT1OD3q/msPrLG3XZOs4xn+YPlmJVhEUpx6uZZL+cS4hb76H5NIJZgUyO40vnQ5kodiE0ODsPQu7hyBa6QD8S9V9M3/wxhXUwrYQdhvlW3+FH7hvsUvze2ltFtZnKmeOIrU122sN0Evl6zVYV9Mmn1/m/bPkYjqOYbaoaKCtNTqN0UZayeS9NM/Ep0ZxzMgmHZi0x2siQsXuu59mJ7mROUWcsAV9bj3FOTFEwk0Uls5RCnZ2Ad1q1YZ9kyggYn92koTrxyu4QWjLVZvfWHSPLrdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(86362001)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dlmvY3QodFCoD28fYdTSrOV932Wa50DyxhJoGct+xTPR6ucD/Aw9beSQQGhp?=
 =?us-ascii?Q?u3Uj/bYQUHNRGAMTI+ap2G0cOdJfGxefJS8wip0Qz2TWQKGdFVIuETyE+FwJ?=
 =?us-ascii?Q?uehbwVCm0/rJNBqNZtRqz6xTXRWw4r2DRl0+cXsk25OVbFGCPtJ3DQoz0SlZ?=
 =?us-ascii?Q?UC5MTfan48rNTdD9DzKj8ITdvR0CJY/7uCrHm2gTSLfwRZ/kQ0xrd0Zmz1Eg?=
 =?us-ascii?Q?0Fo9c+BIiIwFe0uxzERb6fbhCi3IeK1mb2RAbOKxkuOD7LRFisWwNDBXUUTO?=
 =?us-ascii?Q?u6jlpdwFG/UTpv+DX4bFxP4gsBTySea8ZjQiGFlK9VShBVj9pfIWZOt/w+70?=
 =?us-ascii?Q?91QYtZS3MdupIkR+OvNberKmuCkxCv6V6OeGNPeeWT04Q874kLz02TrZ7Ii2?=
 =?us-ascii?Q?rS2HjW+k1JvWJSteutO7qU2Z+DXg4CW4F7E08NnWOQnQo/l8mGUTq7H5Tt8Z?=
 =?us-ascii?Q?qapeWeCBXczGUILPKSTvL+PBCvyLToSm94DvlukBB5deNkKU9cjUW2sjsuiw?=
 =?us-ascii?Q?boffhuLzKW6YQxJm+WasONU1GsmfJlag/up71YZXAM6Z+XdmpXCvnWC89+Jx?=
 =?us-ascii?Q?IX02S3VItGfNeAxnMVPfU31dZkZ3ywGFA4NuUxynnt/NuD/pYwIJMahrVFZK?=
 =?us-ascii?Q?c16M4H0Iijt7iSOmZFL3W12JBuBdsz+esywYTElBXaxbXlatRkJ8aZe3bl6R?=
 =?us-ascii?Q?Cbp45JGNZWASKnO2TfHXO92fV4uRwKHO9vZ/ubgjoMPh1EgTVMRqvhxUp2Y2?=
 =?us-ascii?Q?d4ySyYKysaJ3XkH3JSrsTwN3A0iLxz2Vuv141CvMp/FMZoy71m5yFVde/VKb?=
 =?us-ascii?Q?1b7R1pDP508FuyawZpyO0g8ol2vqVWM3J43T++/W1aM/3E1xTZWvOHh81Mut?=
 =?us-ascii?Q?NvmquujyHjaYfqNw9qDkkTl1XFx7r8QGqKAXT8U54f1OwyzLxpBeCGSYHVpJ?=
 =?us-ascii?Q?761hwgyJ5cfhDIaIHzuh90yu3p7/nkxyEUGHnOfGpUAjQ1PbhrgHIKCCWYCN?=
 =?us-ascii?Q?J2uA0FCUE4uW3L8H78nQckFL8WrY2UJ8uTzNKhKUVo/mPw2Au6zFcVJ3Lux+?=
 =?us-ascii?Q?Z2k1m2xGx8L1HuRnuZYWXejPvS9GqJiZ6C4ffqrUahVzN+bYGMSnwVHt2jW7?=
 =?us-ascii?Q?abUzZQGpG5w3wcSchIN+DVjUwlAnVnfeVPzCN+Qu17r7fu5YYG80ArhefBAM?=
 =?us-ascii?Q?CJsIeRjfsmEmjsc+ZiQB0fbEJGccmyMwL3sfj7Iveki6QkxKMNfA5JG5EVqA?=
 =?us-ascii?Q?yqrb9QP6EcwJqV6i26mi2PIWTs6OdKCzAFnN6iQ8wwBG0Ka8GMuoksi3Gc8/?=
 =?us-ascii?Q?/C/nMrCfGQIGpIiY2kW0i1bTpRwU1iwOfDECOFxLvBCgECDsy8PCME548Str?=
 =?us-ascii?Q?AqPpwW9vYjgtr0DkUwoTi3+TRlINFxCViM/Ib+pVWh1YHn2FoMIoVhmA2Z85?=
 =?us-ascii?Q?kSh5mwjrTslS3rPIOu0v0ii4McYjy3lkYA/Nv5FxjMFbC5n0xcoVdD2x5VQL?=
 =?us-ascii?Q?JJ/qLkUTCJSBkn+7rqXtzuuF3+hoKI9v0hIs9D2YQV9RUcjIROw9FN2sv4jz?=
 =?us-ascii?Q?ZRx331DqX0+XRtFmxcFExIUQl0PD//kKQxpub/IQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664cd70-0560-46bd-6727-08dab6b4783f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:25.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v7qiccGdVcRQS3bbBz824WbKXFeuGQSKWJOxCEWi+w5ChjxH1irkg6Nm/bEKFad
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

This is the basic infrastructure of a new miscdevice to hold the iommufd
IOCTL API.

It provides:
 - A miscdevice to create file descriptors to run the IOCTL interface over

 - A table based ioctl dispatch and centralized extendable pre-validation
   step

 - An xarray mapping userspace ID's to kernel objects. The design has
   multiple inter-related objects held within in a single IOMMUFD fd

 - A simple usage count to build a graph of object relations and protect
   against hostile userspace racing ioctls

The only IOCTL provided in this patch is the generic 'destroy any object
by handle' operation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  10 +
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/iommufd/Kconfig                 |  14 +
 drivers/iommu/iommufd/Makefile                |   5 +
 drivers/iommu/iommufd/iommufd_private.h       | 108 ++++++
 drivers/iommu/iommufd/main.c                  | 345 ++++++++++++++++++
 include/linux/iommufd.h                       |  31 ++
 include/uapi/linux/iommufd.h                  |  55 +++
 10 files changed, 571 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/Kconfig
 create mode 100644 drivers/iommu/iommufd/Makefile
 create mode 100644 drivers/iommu/iommufd/iommufd_private.h
 create mode 100644 drivers/iommu/iommufd/main.c
 create mode 100644 include/linux/iommufd.h
 create mode 100644 include/uapi/linux/iommufd.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 5f81e2a24a5c04..eb045fc495a4e3 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -105,6 +105,7 @@ Code  Seq#    Include File                                           Comments
 '8'   all                                                            SNP8023 advanced NIC card
                                                                      <mailto:mcr@solidum.com>
 ';'   64-7F  linux/vfio.h
+';'   80-FF  linux/iommufd.h
 '='   00-3f  uapi/linux/ptp_clock.h                                  <mailto:richardcochran@gmail.com>
 '@'   00-0F  linux/radeonfb.h                                        conflict!
 '@'   00-0F  drivers/video/aty/aty128fb.c                            conflict!
diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba8d..35a9450639527e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10714,6 +10714,16 @@ F:	drivers/iommu/dma-iommu.h
 F:	drivers/iommu/iova.c
 F:	include/linux/iova.h
 
+IOMMU FD
+M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Kevin Tian <kevin.tian@intel.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+F:	Documentation/userspace-api/iommufd.rst
+F:	drivers/iommu/iommufd/
+F:	include/linux/iommufd.h
+F:	include/uapi/linux/iommufd.h
+
 IOMMU SUBSYSTEM
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5ec..319966cde5cf6c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -188,6 +188,7 @@ config MSM_IOMMU
 
 source "drivers/iommu/amd/Kconfig"
 source "drivers/iommu/intel/Kconfig"
+source "drivers/iommu/iommufd/Kconfig"
 
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index cc9f381013c35f..29b88ea77275b6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += amd/ intel/ arm/
+obj-y += amd/ intel/ arm/ iommufd/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
new file mode 100644
index 00000000000000..020614dc5eaf7e
--- /dev/null
+++ b/drivers/iommu/iommufd/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config IOMMUFD
+	tristate "IOMMU Userspace API"
+	select INTERVAL_TREE
+	select INTERVAL_TREE_SPAN_ITER
+	select IOMMU_API
+	default n
+	help
+	  Provides /dev/iommu the user API to control the IOMMU subsystem as
+	  it relates to managing IO page tables that point at user space memory.
+
+	  This would commonly be used in combination with VFIO.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
new file mode 100644
index 00000000000000..a07a8cffe937c6
--- /dev/null
+++ b/drivers/iommu/iommufd/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+iommufd-y := \
+	main.o
+
+obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
new file mode 100644
index 00000000000000..224e4b5729a846
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __IOMMUFD_PRIVATE_H
+#define __IOMMUFD_PRIVATE_H
+
+#include <linux/rwsem.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
+#include <linux/uaccess.h>
+
+struct iommufd_ctx {
+	struct file *file;
+	struct xarray objects;
+};
+
+struct iommufd_ucmd {
+	struct iommufd_ctx *ictx;
+	void __user *ubuffer;
+	u32 user_size;
+	void *cmd;
+};
+
+/* Copy the response in ucmd->cmd back to userspace. */
+static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
+				       size_t cmd_len)
+{
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, cmd_len)))
+		return -EFAULT;
+	return 0;
+}
+
+enum iommufd_object_type {
+	IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+};
+
+/* Base struct for all objects with a userspace ID handle. */
+struct iommufd_object {
+	struct rw_semaphore destroy_rwsem;
+	refcount_t users;
+	enum iommufd_object_type type;
+	unsigned int id;
+};
+
+static inline bool iommufd_lock_obj(struct iommufd_object *obj)
+{
+	if (!down_read_trylock(&obj->destroy_rwsem))
+		return false;
+	if (!refcount_inc_not_zero(&obj->users)) {
+		up_read(&obj->destroy_rwsem);
+		return false;
+	}
+	return true;
+}
+
+struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
+					  enum iommufd_object_type type);
+static inline void iommufd_put_object(struct iommufd_object *obj)
+{
+	refcount_dec(&obj->users);
+	up_read(&obj->destroy_rwsem);
+}
+
+/**
+ * iommufd_put_object_keep_user() - Release part of the refcount on obj
+ * @obj - Object to release
+ *
+ * Objects have two protections to ensure that userspace has a consistent
+ * experience with destruction. Normally objects are locked so that destroy will
+ * block while there are concurrent users, and wait for the object to be
+ * unlocked.
+ *
+ * However, destroy can also be blocked by holding users reference counts on the
+ * objects, in that case destroy will immediately return EBUSY and will not wait
+ * for reference counts to go to zero.
+ *
+ * This function switches from blocking userspace to returning EBUSY.
+ *
+ * It should be used in places where the users will be held beyond a single
+ * system call.
+ */
+static inline void iommufd_put_object_keep_user(struct iommufd_object *obj)
+{
+	up_read(&obj->destroy_rwsem);
+}
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
+void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
+				      struct iommufd_object *obj);
+void iommufd_object_finalize(struct iommufd_ctx *ictx,
+			     struct iommufd_object *obj);
+bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+				 struct iommufd_object *obj);
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type);
+
+#define iommufd_object_alloc(ictx, ptr, type)                                  \
+	container_of(_iommufd_object_alloc(                                    \
+			     ictx,                                             \
+			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
+						      offsetof(typeof(*(ptr)), \
+							       obj) != 0),     \
+			     type),                                            \
+		     typeof(*(ptr)), obj)
+
+#endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
new file mode 100644
index 00000000000000..d4f3aa06ee28f8
--- /dev/null
+++ b/drivers/iommu/iommufd/main.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 Intel Corporation
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ *
+ * iommufd provides control over the IOMMU HW objects created by IOMMU kernel
+ * drivers. IOMMU HW objects revolve around IO page tables that map incoming DMA
+ * addresses (IOVA) to CPU addresses.
+ *
+ * The API is divided into a general portion that is intended to work with any
+ * kernel IOMMU driver, and a device specific portion that  is intended to be
+ * used with a userspace HW driver paired with the specific kernel driver. This
+ * mechanism allows all the unique functionalities in individual IOMMUs to be
+ * exposed to userspace control.
+ */
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/bug.h>
+#include <uapi/linux/iommufd.h>
+#include <linux/iommufd.h>
+
+#include "iommufd_private.h"
+
+struct iommufd_object_ops {
+	void (*destroy)(struct iommufd_object *obj);
+};
+static struct iommufd_object_ops iommufd_object_ops[];
+
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type)
+{
+	struct iommufd_object *obj;
+	int rc;
+
+	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+	obj->type = type;
+	init_rwsem(&obj->destroy_rwsem);
+	refcount_set(&obj->users, 1);
+
+	/*
+	 * Reserve an ID in the xarray but do not publish the pointer yet since
+	 * the caller hasn't initialized it yet. Once the pointer is published
+	 * in the xarray and visible to other threads we can't reliably destroy
+	 * it anymore, so the caller must complete all errorable operations
+	 * before calling iommufd_object_finalize().
+	 */
+	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
+		      xa_limit_32b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+	return obj;
+out_free:
+	kfree(obj);
+	return ERR_PTR(rc);
+}
+
+/*
+ * Allow concurrent access to the object. This should only be done once the
+ * system call that created the object is guaranteed to succeed.
+ */
+void iommufd_object_finalize(struct iommufd_ctx *ictx,
+			     struct iommufd_object *obj)
+{
+	void *old;
+
+	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
+	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
+	WARN_ON(old);
+}
+
+/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
+{
+	void *old;
+
+	old = xa_erase(&ictx->objects, obj->id);
+	WARN_ON(old);
+	kfree(obj);
+}
+
+/*
+ * Abort an object that has been fully initialized and needs destroy, but has
+ * not been finalized.
+ */
+void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
+				      struct iommufd_object *obj)
+{
+	iommufd_object_ops[obj->type].destroy(obj);
+	iommufd_object_abort(ictx, obj);
+}
+
+struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
+					  enum iommufd_object_type type)
+{
+	struct iommufd_object *obj;
+
+	xa_lock(&ictx->objects);
+	obj = xa_load(&ictx->objects, id);
+	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
+	    !iommufd_lock_obj(obj))
+		obj = ERR_PTR(-ENOENT);
+	xa_unlock(&ictx->objects);
+	return obj;
+}
+
+/*
+ * The caller holds a users refcount and wants to destroy the object. Returns
+ * true if the object was destroyed. In all cases the caller no longer has a
+ * reference on obj.
+ */
+bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+				 struct iommufd_object *obj)
+{
+	/*
+	 * The purpose of the destroy_rwsem is to ensure deterministic
+	 * destruction of objects used by external drivers and destroyed by this
+	 * function. Any temporary increment of the refcount must hold the read
+	 * side of this, such as during ioctl execution.
+	 */
+	down_write(&obj->destroy_rwsem);
+	xa_lock(&ictx->objects);
+	refcount_dec(&obj->users);
+	if (!refcount_dec_if_one(&obj->users)) {
+		xa_unlock(&ictx->objects);
+		up_write(&obj->destroy_rwsem);
+		return false;
+	}
+	__xa_erase(&ictx->objects, obj->id);
+	xa_unlock(&ictx->objects);
+	up_write(&obj->destroy_rwsem);
+
+	iommufd_object_ops[obj->type].destroy(obj);
+	kfree(obj);
+	return true;
+}
+
+static int iommufd_destroy(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_destroy *cmd = ucmd->cmd;
+	struct iommufd_object *obj;
+
+	obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+	iommufd_put_object_keep_user(obj);
+	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
+		return -EBUSY;
+	return 0;
+}
+
+static int iommufd_fops_open(struct inode *inode, struct file *filp)
+{
+	struct iommufd_ctx *ictx;
+
+	ictx = kzalloc(sizeof(*ictx), GFP_KERNEL_ACCOUNT);
+	if (!ictx)
+		return -ENOMEM;
+
+	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
+	ictx->file = filp;
+	filp->private_data = ictx;
+	return 0;
+}
+
+static int iommufd_fops_release(struct inode *inode, struct file *filp)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	struct iommufd_object *obj;
+
+	/* Destroy the graph from depth first */
+	while (!xa_empty(&ictx->objects)) {
+		unsigned int destroyed = 0;
+		unsigned long index;
+
+		xa_for_each(&ictx->objects, index, obj) {
+			/*
+			 * Since we are in release elevated users must come from
+			 * other objects holding the users. We will eventually
+			 * destroy the object that holds this one and the next
+			 * pass will progress it.
+			 */
+			if (!refcount_dec_if_one(&obj->users))
+				continue;
+			destroyed++;
+			xa_erase(&ictx->objects, index);
+			iommufd_object_ops[obj->type].destroy(obj);
+			kfree(obj);
+		}
+		/* Bug related to users refcount */
+		if (WARN_ON(!destroyed))
+			break;
+	}
+	kfree(ictx);
+	return 0;
+}
+
+union ucmd_buffer {
+	struct iommu_destroy destroy;
+};
+
+struct iommufd_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct iommufd_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+	[_IOC_NR(_ioctl) - IOMMUFD_CMD_BASE] = {                               \
+		.size = sizeof(_struct) +                                      \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
+					  sizeof(_struct)),                    \
+		.min_size = offsetofend(_struct, _last),                       \
+		.ioctl_num = _ioctl,                                           \
+		.execute = _fn,                                                \
+	}
+static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
+	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+};
+
+static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct iommufd_ucmd ucmd = {};
+	struct iommufd_ioctl_op *op;
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	ucmd.ictx = filp->private_data;
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	nr = _IOC_NR(cmd);
+	if (nr < IOMMUFD_CMD_BASE ||
+	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
+		return -ENOIOCTLCMD;
+	op = &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+	if (ucmd.user_size < op->min_size)
+		return -EOPNOTSUPP;
+
+	ucmd.cmd = &buf;
+	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (ret)
+		return ret;
+	ret = op->execute(&ucmd);
+	return ret;
+}
+
+static const struct file_operations iommufd_fops = {
+	.owner = THIS_MODULE,
+	.open = iommufd_fops_open,
+	.release = iommufd_fops_release,
+	.unlocked_ioctl = iommufd_fops_ioctl,
+};
+
+/**
+ * iommufd_ctx_get - Get a context reference
+ * @ictx - Context to get
+ *
+ * The caller must already hold a valid reference to ictx.
+ */
+void iommufd_ctx_get(struct iommufd_ctx *ictx)
+{
+	get_file(ictx->file);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_get, IOMMUFD);
+
+/**
+ * iommufd_ctx_from_file - Acquires a reference to the iommufd context
+ * @file: File to obtain the reference from
+ *
+ * Returns a pointer to the iommufd_ctx, otherwise ERR_PTR. The struct file
+ * remains owned by the caller and the caller must still do fput. On success
+ * the caller is responsible to call iommufd_ctx_put().
+ */
+struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
+{
+	struct iommufd_ctx *ictx;
+
+	if (file->f_op != &iommufd_fops)
+		return ERR_PTR(-EBADFD);
+	ictx = file->private_data;
+	iommufd_ctx_get(ictx);
+	return ictx;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_from_file, IOMMUFD);
+
+/**
+ * iommufd_ctx_put - Put back a reference
+ * @ictx - Context to put back
+ */
+void iommufd_ctx_put(struct iommufd_ctx *ictx)
+{
+	fput(ictx->file);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
+
+static struct iommufd_object_ops iommufd_object_ops[] = {
+};
+
+static struct miscdevice iommu_misc_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "iommu",
+	.fops = &iommufd_fops,
+	.nodename = "iommu",
+	.mode = 0660,
+};
+
+static int __init iommufd_init(void)
+{
+	int ret;
+
+	ret = misc_register(&iommu_misc_dev);
+	if (ret) {
+		pr_err("Failed to register misc device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit iommufd_exit(void)
+{
+	misc_deregister(&iommu_misc_dev);
+}
+
+module_init(iommufd_init);
+module_exit(iommufd_exit);
+
+MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
new file mode 100644
index 00000000000000..d1817472c27373
--- /dev/null
+++ b/include/linux/iommufd.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Intel Corporation
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __LINUX_IOMMUFD_H
+#define __LINUX_IOMMUFD_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+
+struct iommufd_ctx;
+struct file;
+
+void iommufd_ctx_get(struct iommufd_ctx *ictx);
+
+#if IS_ENABLED(CONFIG_IOMMUFD)
+struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
+void iommufd_ctx_put(struct iommufd_ctx *ictx);
+#else /* !CONFIG_IOMMUFD */
+static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
+{
+}
+#endif /* CONFIG_IOMMUFD */
+#endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
new file mode 100644
index 00000000000000..b77b7eb0aeb13c
--- /dev/null
+++ b/include/uapi/linux/iommufd.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_IOMMUFD_H
+#define _UAPI_IOMMUFD_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define IOMMUFD_TYPE (';')
+
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl mechanims follows a general format to allow for extensibility. Each
+ * ioctl is passed in a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOENT: An ID or IOVA provided does not exist.
+ *  - ENOMEM: Out of memory.
+ *  - EOVERFLOW: Mathematics oveflowed.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+enum {
+	IOMMUFD_CMD_BASE = 0x80,
+	IOMMUFD_CMD_DESTROY = IOMMUFD_CMD_BASE,
+};
+
+/**
+ * struct iommu_destroy - ioctl(IOMMU_DESTROY)
+ * @size: sizeof(struct iommu_destroy)
+ * @id: iommufd object ID to destroy. Can by any destroyable object type.
+ *
+ * Destroy any object held within iommufd.
+ */
+struct iommu_destroy {
+	__u32 size;
+	__u32 id;
+};
+#define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
+
+#endif
-- 
2.38.0

