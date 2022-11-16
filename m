Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756262CBEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiKPVC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiKPVCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B169DF7;
        Wed, 16 Nov 2022 13:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxE0Uc+bqcHt8hyqRIFOC544b0XNLw5977yVftLeVLA+7p0zV5d+jfRYku2S6tuDNqFzfdlGu2fn6UhOkhtvxvTT4vI+MrYmwU7jyM5n6DwcVEio9nFdpy9xB2acN6Ml7OWlqyEyFH2UhsPFLHWTa1GcqjQoTyCb7prqOZRbawDx75lxy+YTHcWkxH3h+28aPoahk52KGjHav0Z7FAHrXGKsR7tzq7q5rPP3FSB4Jnd+KOkK/QJ9cVYA2L0XjDGUPoPn/QaOwjYwWXMId69nCrJT1TiMh285/fdt+c4qTfuyN3w7rdVvNj5tl7KEru3mD7KNcGcfdHY17ShaXdAUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ipb6nu6yCIyXHTgfhj1GkGvznzb5fO163c7PAOS5wk=;
 b=XtVAXD8wt9eG2/k6z+mUnhp4WU0nm/Zfy5plELsVIhtoVWlyjNwbpHi52YjkbgQoWV5r0O03aZi/O9aqz3Vjd7P2r4X/Pq+m45Rm5lSX80TrWkSB3frNfUGeAqtczW0vJnZuJ7VZn5zeFLXGj9vKItxWpSqv4s2RrzzCdFnEZ2J5lQcExM4IwMDfpEBWyASeKWmCtkSd1mQRAERI5W5C6jlqdOd2aFThfvqu5wlnjccLJDCz72j2cqEfov81beMEkG+RQQtFpLK0/dqKxi5x4JTGkiGGcI1HbIAkBvif/sN7aij66c3dftV0yIZPdlMY76HECypNcACy04MBE4mJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ipb6nu6yCIyXHTgfhj1GkGvznzb5fO163c7PAOS5wk=;
 b=smsBEHNLsm8VT7USYEQDiVCnTVQeJKzZqE6bxZZIkXkseTrDs3h4CT3a3WJUltJW2z6/qgLY3ARPsucKRGlc+36PhYi9JAvOd1UMeQ5NuZV1xEOy+SG2jLako51gXsTAx7CFqoVB4XEI8vIFvehS0NotUHzs+N7/9L3IElVjQdMkjQENm/Z2XnB/XI6282tnWjFl+dcJYTvy5v1+CwvUUGim93lttuwASJJnHlNRuuINAnEf4OsF+Z8Ho82eTxSH5fpeBXLmLCWuvEAR70dXVcSkZmDiJMsWVLjnrGGKBa4HzlCvwPgWeU2iJxBO6afucc8VgMTM3Xba8q3DDU0jLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:04 +0000
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
Subject: [PATCH v5 06/19] iommufd: File descriptor, context, kconfig and makefiles
Date:   Wed, 16 Nov 2022 17:00:42 -0400
Message-Id: <6-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c30f95-7676-4db3-7a23-08dac815a92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvQOmaFZbY0bCxSiSfitCj1LdTgUMEQAvcJ4Tk4cCTrD6vHSC2pRontn7ZIQFwSC2zhRjUZDVSApAc9YI813KBzzHNtQ0LhKtMS0hDVMX1GpCiOEHJsmwQy5U57VPqTP/T7FaH/4+eYqo6RQxWEl815efCV/6W+gqpBgv0y2kSQNWer0lVzPJzQAS0NDyPyPyRzYH6CWh/DK6DSrfL4TxE17errQQ9BqPtgLn/Wg3nPQjLPxZNk8Ot7SCgn1Vt/Kz8IOVofYP2J80gmQZka9j3acuuFzyz/7ndqMCxOXi8KgblTlmGkoSqffBbXYI0Ny2MnxtEyNwnIn4GMm1gB6haJim6c4ybskoe2FIP0J6BE/oEdCxMeSvWn/+YeKW0k4ZJVhrpsBNK0lJlqrSJzP7I6hMkf5TjC8M3nK7XXj9sph/1BgI8xUWhrtP1YnreJYYM4L8raPyId+S7BaewP/wRGZV2+xGZzEntcdBVG36Nm5nHLSKBLyeOiiYj4fdFbXEEPyxXqGrIEQNEa+iKRCnbYYNMK+TRxrxkiMRB2hb8N0UQAYcdqWvc90dIsvzoI844GLuI4jzZmTA3XD6Un9MGs1yYvfEf9B+olYFC4mj4VcW7BhbCHvSlbqJS65Ss3O2+htLiKmS4g2lbyP9z204I1wtcekABcEpwtkRQ5hnTaknJ4jy6eYHdpiBWD39kLfLzocN+D4BZKjG7qzTmKQ/nIdXYhmfD2j79xWT6Q7nXEMqJGXmd9xhFZ0SNzgcgOWoEZPTD+cSFfc4Yvl7b5U2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(2906002)(30864003)(7406005)(7416002)(8936002)(5660300002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZxg7R1opDCwmCygRACLDQyrn6jP549y0GQUHnkseVkvulhmXYVkGzxEI8Iw?=
 =?us-ascii?Q?tVVxT/g0UA4DhENZ48XvZp3Jqjh1LtWyNxCdvtBYVuZ0lKBPlpOsCQlyfWej?=
 =?us-ascii?Q?zjQD6QvPGZpIHq9+QfMuA/GMUogb6LK5+ybABaVYzaiVyLNHf/GwYFNAi8dq?=
 =?us-ascii?Q?cUPq9u+ePBMneR+EOWjG3fOVxu17cqI3Fu6S7APaEpSSqARJdrcCZwgsfQwY?=
 =?us-ascii?Q?14XFCi/vP7NT9gRBe0wMezlWWFtNh4ZAOYfuZVmwUwXyMf1HhREoF4anCRRL?=
 =?us-ascii?Q?oK7N3urhH0zYDG+Kw218oo8uP4lL7lNsxGr7iuJJFMV/8a7QXHV3uN1zjtjp?=
 =?us-ascii?Q?DRv14ba4WGTCgKpeOgQjCzmTOMVvCb/RyGsDRNlc5iaUmVSnhrs4Z/N1Q4IL?=
 =?us-ascii?Q?U9hQO6bv2wvapXMEKDor0WJk7PSRgbvv6XI4cIAg7/6HvVzB5Fp0XmA59Lag?=
 =?us-ascii?Q?xqvdB0bSrC7ehDlKuoWcRen0v3kC61d4PPAp+axgSIpxV9GWV65siik0wp4w?=
 =?us-ascii?Q?F62l++bbECUhBgyn9bUiNmBzdmKPXhjjuNFxnfQd87pzP8uZ6YychzZ5PgTX?=
 =?us-ascii?Q?V5xSx/7bkLal/sPmr0Ju6BolUb2c42drHwJ4EfemGD8tlKoc6GMLPXydVeXU?=
 =?us-ascii?Q?Z+7dGPixQqaOsmGiIqrRfV94i3In6x2lU85swCrHTXNY81oJTZZUt1CEMtsF?=
 =?us-ascii?Q?GV5wzd6/PIs9dxxsG7eyGMFyhymxS7wb+xvYmSxV+3/5eDXAaIVu8F8c+WMX?=
 =?us-ascii?Q?vAfI23x6uFgbgpNppoxERqjw58Pvrg8jkANCLHjp762gPwtxmV5o3ZZjKr51?=
 =?us-ascii?Q?jo+oZUHOzox/sXOwef7S7/jm9woNMDTBz7VasrFSN2DXFdVGY3bvCabPAI3i?=
 =?us-ascii?Q?z6JZeCWBCsWSPKqY/rfyyaTeukpFzqRlerYlSEWAmAP2/zgpVwWwfGdBUEB1?=
 =?us-ascii?Q?zYsVcLgmDv/i9Xd6QaRM2drW+737wTpBpOsD47qDD7FjDuUb2MgTyGv4Kc/1?=
 =?us-ascii?Q?hiKwpP4Rg72TzMk8WBpI00mk8Sb466Mr406Gf63ChsFr6gmk650ibkYxQgN9?=
 =?us-ascii?Q?vN/f+mwEMrwZVYMX7gb5BhG/n84g5Dqxd+oEqN16suJ9na1rjdbTWO1lhnJ6?=
 =?us-ascii?Q?SDAHJeHpylOxBsFY9c3gDiGwb1wlo95RcXYO8yRhGOrUxxQkJljJxMZDJ3Eq?=
 =?us-ascii?Q?X2uYvZf1JzcFSE6qgjCsuHoYboH8ZtiIYJQFURfOmZWaa+nJSDvwvjGrEqRT?=
 =?us-ascii?Q?1b1rZ1Fhly5s2HnkKQ4fy0lInV0VgYy/xAC4MzS0tKM+hKPB1o4FpxEuWm+U?=
 =?us-ascii?Q?30ZoNTyTjLmJns5/YoUSNqhLxVIkTq+yCW71SxoNrGH+eqMIYq9V0atR3K1N?=
 =?us-ascii?Q?D5xcf8TL0+ZsBIvPWiOEM5SWXOkY8ixLdwg0m7VZdFmqYO4jcQhUT5Touv6I?=
 =?us-ascii?Q?bAEnAaTXqn12kj1gu9lhlFB9ZSfUbXGbiJfh1SFRQyuDt4k0Y8KvVY3JDjov?=
 =?us-ascii?Q?hGwFBBRjlXmzoY+0wnO5hTu8Omgl+F/Q2Fl18PmOuFg4B80i6h0FT7bnkEFR?=
 =?us-ascii?Q?AsKaGT/kPfB0wXzjhK0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c30f95-7676-4db3-7a23-08dac815a92a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXLHLmT/zCcpmMq4e339NeP3ejuqbW9yWaG/EhP3SwgjJ+vAORlB8YbS2GDf5eAo
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  12 +
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/iommufd/Kconfig                 |  12 +
 drivers/iommu/iommufd/Makefile                |   5 +
 drivers/iommu/iommufd/iommufd_private.h       | 109 ++++++
 drivers/iommu/iommufd/main.c                  | 342 ++++++++++++++++++
 include/linux/iommufd.h                       |  31 ++
 include/uapi/linux/iommufd.h                  |  55 +++
 10 files changed, 569 insertions(+), 1 deletion(-)
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
index 379945f82a6438..c0a93779731d7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10717,6 +10717,18 @@ F:	drivers/iommu/dma-iommu.h
 F:	drivers/iommu/iova.c
 F:	include/linux/iova.h
 
+IOMMUFD
+M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Kevin Tian <kevin.tian@intel.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
+F:	Documentation/userspace-api/iommufd.rst
+F:	drivers/iommu/iommufd/
+F:	include/linux/iommufd.h
+F:	include/uapi/linux/iommufd.h
+F:	tools/testing/selftests/iommu/
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
index 7fbf6a3376620e..f461d065138564 100644
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
index 00000000000000..6d65d0f06f169f
--- /dev/null
+++ b/drivers/iommu/iommufd/Kconfig
@@ -0,0 +1,12 @@
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
index 00000000000000..d523e7967b1440
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -0,0 +1,109 @@
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
+ * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
+ *        protection
+ * @obj - Object to release
+ *
+ * Objects have two refcount protections (destroy_rwsem and the refcount_t
+ * users). Holding either of these will prevent the object from being destroyed.
+ *
+ * Depending on the use case, one protection or the other is appropriate.  In
+ * most cases references are being protected by the destroy_rwsem. This allows
+ * orderly destruction of the object because iommufd_object_destroy_user() will
+ * wait for it to become unlocked. However, as a rwsem, it cannot be held across
+ * a system call return. So cases that have longer term needs must switch
+ * to the weaker users refcount_t.
+ *
+ * With users protection iommufd_object_destroy_user() will return -EBUSY to
+ * userspace and refuse to destroy the object.
+ */
+static inline void iommufd_ref_to_users(struct iommufd_object *obj)
+{
+	up_read(&obj->destroy_rwsem);
+	/* iommufd_lock_obj() obtains users as well */
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
index 00000000000000..3a705cadb85020
--- /dev/null
+++ b/drivers/iommu/iommufd/main.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 Intel Corporation
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ *
+ * iommufd provides control over the IOMMU HW objects created by IOMMU kernel
+ * drivers. IOMMU HW objects revolve around IO page tables that map incoming DMA
+ * addresses (IOVA) to CPU addresses.
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
+static const struct iommufd_object_ops iommufd_object_ops[];
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
+ * Allow concurrent access to the object.
+ *
+ * Once another thread can see the object pointer it can prevent object
+ * destruction. Expect for special kernel-only objects there is no in-kernel way
+ * to reliably destroy a single object. Thus all APIs that are creating objects
+ * must use iommufd_object_abort() to handle their errors and only call
+ * iommufd_object_finalize() once object creation cannot fail.
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
+	iommufd_ref_to_users(obj);
+	/* See iommufd_ref_to_users() */
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
+static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
+	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+};
+
+static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	const struct iommufd_ioctl_op *op;
+	struct iommufd_ucmd ucmd = {};
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
+		return -EINVAL;
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
+ * @ictx: Context to get
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
+ * @ictx: Context to put back
+ */
+void iommufd_ctx_put(struct iommufd_ctx *ictx)
+{
+	fput(ictx->file);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
+
+static const struct iommufd_object_ops iommufd_object_ops[] = {
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
+	if (ret)
+		return ret;
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
index 00000000000000..2ad06b27a35fe5
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
+ * The ioctl interface follows a general format to allow for extensibility. Each
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
2.38.1

