Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9FF60D33D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiJYSMu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiJYSMq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2AB7ED4;
        Tue, 25 Oct 2022 11:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZenxkHNvE3j//SiGoEXZGJrQYhjqVn4kItcQ+ITv8NWCwDvgc/2al7pvM9ztEC11u5PajsoZH+nobFNRqdvHUe0uu4j9W/QNWyW4rmB9CwYC3ckF0wc0wgzOjT5tm0MJU/i9TKCul1HI4HAcgpzeOvOqujV1rBgnznWgzzoXEKup2AI6Tr7l4tm3cbW9GyojUxwV4oAGA8pzQ8zefS23dffuPAqkR9D5iAJV20Xv04rqgBRYfeLjaC/syYspVimDOq6zwnRWUSKG+GJlsdhJ6sE+mNwNBAf0ftf0/cIf2NLgAI3asgiCoeQq0z7EBSbqnigmS3N4JrYSqdR9bAGsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L8RbAu4nZfNb5tHHUdNba1DcxTXfQA1ZQnuEjA4X2E=;
 b=iZ87O8e+kVb1y1xQyZXo1ip5EK8l3O9Oqmoh5IDHvK0dfbKi39/tZ+DFyIjDRriqMYUEzgj9vS2IIlbF3qbEa0FHNh4ugNqK5+rTctsO/0MMB4XVLQlMArOfiS9XJLWZrdjG3OG/Sywl38w19Wim/AmBZi31ETwbrGQgiQZzxgV+knyFOOXIDKlygn8HXTPfs9MOTS9k+c/4fKYVTom5J+fyv7JC5o6wq/XSadZhgSRX/EhPTVdhCyD7AGHlSEZ0RIu8NLS+98v3gS5fJTNR0B8yurvpWYZka1QYd7UFfbfpK4ULTxRIoaRpeoL92MAvCmFS0Ct2uU4TIELxwbKr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L8RbAu4nZfNb5tHHUdNba1DcxTXfQA1ZQnuEjA4X2E=;
 b=n0kFJB9aGZ7eFhWZwz26Lv5UYPwQUYPwH6y2SVxOXBfuw+px02oykISPaxpM0yQkkTSO/mk8PA+X1oOsZYbbTPdB7q8vWxa3gnW154rICbIgn7HPmz6GIDRDN9PGNGGYflFcjjRi2WeD+nS1Gbgkn8/YReLiLR2+Q55/TDTb47cP6PBStOaIkYDDkRoa6K4ZEu+NY4PAJSiYeu+9obpR41nzOOxCq5Q2oGGLPilyLgFHmdo/mvH+lNuRaHFLHgJeavzIg+/kf0djIrOxvOwZ40knUcM+XpgMnsvhXpVDvQ7ppRLZMmi/QcR2EtORfYrPmHqAoO1KVTsy12qhdOcrBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:32 +0000
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
Subject: [PATCH v3 04/15] iommufd: Overview documentation
Date:   Tue, 25 Oct 2022 15:12:13 -0300
Message-Id: <4-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0400.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: b496b3d6-30eb-4880-95b1-08dab6b479a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIjN6nde+gMUgQ4Smo6EGMmh8kK0prdwwa7/dZrkQB+IkzbYlz2bGCp7o1ODSHOfRGYftbjUNKYJ9VWg/ayM5Bqp+ByTlF5Uw0zpd65AXjrEI+Iyx7QTScf5m+ve3fstnN83RxExf76xKaWt4HkF2pyAYpzGZzVSoqGQWy+Y8fkwe06aVmvlnCHU72ewamALFI5G7+Ptc/mF4be1bpDPuY5Ow2NVnEBG8jE18u/kbE7GD1G21IwRjy0oDXJtKiLuOUtuKKp93CCZlfGwBSpt++G9Ab/P0LdnyhyH/qdZrQkzOKvyuK6vheIBT7rHczI91UV61l9ZAnl1Tyqr+jenv8QRxbA7M/xbK4CHmtvnllKzpyhSsIG5J3z+Ef7IRHnipOmws4tfBIy+8RMPU6h8S37/2CtAaKTsN5XKcSDSu9jLFuiqehWM24IDE181F5WzO3ZDCfcvIx5YfZANLHbzC8d36Zu5O4WkFfZHZVoI+qTot9qwiEHE9GAOnJlsqjZgco0dDXNginVwCgnnLXBUR7iMpHVlc1aJNWlwvmS7vfTdnmyWpjvmAKf3wXW/DZvgRoX9TgqKuyacVWiiSLgPnRqxMeRjLR0FP6V7iHOrmCSnlQMy8M0NqSvmkZreidVqq9QdCnfwlYCy5r8v4fZn04+PKZfWUUWGKL5/vpcXRESKMpV+h7E7npCTfYCSa9RPbRfeZQdgx8Ev7LJp3MuMnBVfadmKTw8kQ3M3/NVzpmZRiUEwNVhxrCjEZHSSCujFvfwlTF78RMJiuSOUYu3Ztw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(86362001)(83380400001)(6486002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5vwA7boNl6bi6mofXyn0VUXz7SiSHLSKJAREx29RVQJhIRJ15/bXWfRDpei?=
 =?us-ascii?Q?ulkMkBu6mRsKPNYceX3iXs6DxOZHGqdXSyrCt74qzDGzmZJZ4bO/T162GsH4?=
 =?us-ascii?Q?FbqbM0MJc8GhheHB3PGqPhpV1s+R/QifoilHA7q4pbCUokA6+F8qKJtwxuB0?=
 =?us-ascii?Q?svymlaMdZ7VXe+Wk/MougxG3eCgAS9sIPGMLeVUYj1Yhx0RTOIF5gzFulh68?=
 =?us-ascii?Q?bRntaP5VE4heEE7RTnZDmRDBKu+PAbu91phqwOoRYADdyndXCQuavizg929X?=
 =?us-ascii?Q?Gwb3Tmf9vdtkOzW2dqNOu1QnvsZGtvuupeLI1bMLe0+MZCQaS1R/t9oE/Yq/?=
 =?us-ascii?Q?4rpuFZArxhg2QjIwBIsj/X38jC5jut0JpyHWUepAMvEvRefPTUYK5aBa+oiV?=
 =?us-ascii?Q?Nn5vDJI7n2JZblRCa1dF3DJ2cU+0fdz0fYMU9hPoR/053NF+hXZW2fqrhHag?=
 =?us-ascii?Q?PUQyP6TjunSDxntfsBiQO12ITyuyQ6NDYQiAXGZUFvozZOHbOoKHWKd49iVP?=
 =?us-ascii?Q?X0e5JtGpxhVjH8yEjuSJVcWBMO7n6V9bkSt878jYULIfrWIkiFLa0AQAqs1k?=
 =?us-ascii?Q?T703RWWyi4WNmjDXCLct1Rt5M0LgEGfesR0S+hK1f1tzc7LKCLyxz/758v1N?=
 =?us-ascii?Q?b5eJa/J1vnffMjhdPgDkVaA0/kzU/0i4JZCWI7dmBEA5LNYBQfyog7wzdvKK?=
 =?us-ascii?Q?6AS21sRS7JCj6vbrcu1sinTbhWObmWB0j90NYws1HLGov1LNL9IIlAUU6jj9?=
 =?us-ascii?Q?4lPJMaxlYb7gNWDqCnNp3znI3VCwCUcf3tDMrn9AM5flUPa8kEfpxfH+bIAw?=
 =?us-ascii?Q?jG+e0U6niV3XQBC96L6zY4/dmbeSq7bT/R+HFm9pJoyvW8VBUgW565MjYyZN?=
 =?us-ascii?Q?qAfVrYQmtHjkM0xA1OUxrVWMFaVSX7Ge7a6s3IAWJb9RTFxQLsJ/dzX/HDYz?=
 =?us-ascii?Q?wU53ujjBWuNbBZFqSaJMpAOkVrCG1+xlfXCkiYSIErCPIGUXwjso9NYppd0F?=
 =?us-ascii?Q?1mJ5JXBDvJPjaFTi3/KU1iOupOm0sQZ4F/avJ78lF7gvOubQBbD/xzI8c+35?=
 =?us-ascii?Q?K3JQegfwVzZA8Kbh9JVcc58ys2BqMUlarTGWKwp56Rbzh6bs2Q+h/06Ob/0I?=
 =?us-ascii?Q?OCEI9sWpEl6ow3a2pqMuKIrL2tarzn/ksqFwUouy9XJag7T22SIvcaIIkkGq?=
 =?us-ascii?Q?rh2MxCTaxgFKk8eZ2BskkZ0Dxidvq55bwwBydZYrbcBWNa+wnQGPPN1a5k38?=
 =?us-ascii?Q?dPmW2Oofv53PO7bmUyJPFDM5PXXvln5H4z5ZOf0W/nbdbBwxHUIzT48ko5as?=
 =?us-ascii?Q?kddvC1NeGCtkP7F72Ruxq0mtmUI94tOD2plrnJJhA1tvnkZGsB9vvpVoBDVs?=
 =?us-ascii?Q?pV80OSd7YXvb1q82ZX7uTQjFQ+a4LPu2rNPPHQtJMW4boijG8eZRlFNl7kra?=
 =?us-ascii?Q?LNUKIL6HTbud/SYF+e4ycsAinuN/DeylHiMAo7gjthGP3oqcJdT7+eZ5jKnM?=
 =?us-ascii?Q?ODEcsDtQ74R/UR0RNEtkUxM5hgp7tGn9VxENxPUQf/ulmQtRWeOWWlUyHghr?=
 =?us-ascii?Q?NW61+yz64yo0hrGrcAk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b496b3d6-30eb-4880-95b1-08dab6b479a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:27.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XddUubiX7LsQnjhbe736lh0phFer7uoxc2kPkYpCM64mV8lzyUj6IvzkiNmJGPd
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

From: Kevin Tian <kevin.tian@intel.com>

Add iommufd to the documentation tree.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/index.rst   |   1 +
 Documentation/userspace-api/iommufd.rst | 222 ++++++++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100644 Documentation/userspace-api/iommufd.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index c78da9ce0ec44e..f16337bdb8520f 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -25,6 +25,7 @@ place where this information is gathered.
    ebpf/index
    ioctl/index
    iommu
+   iommufd
    media/index
    netlink/index
    sysfs-platform_profile
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
new file mode 100644
index 00000000000000..3e1856469d96dd
--- /dev/null
+++ b/Documentation/userspace-api/iommufd.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=======
+IOMMUFD
+=======
+
+:Author: Jason Gunthorpe
+:Author: Kevin Tian
+
+Overview
+========
+
+IOMMUFD is the user API to control the IOMMU subsystem as it relates to managing
+IO page tables that point at user space memory. It intends to be general and
+consumable by any driver that wants to DMA to userspace. These drivers are
+eventually expected to deprecate any internal IOMMU logic, if existing (e.g.
+vfio_iommu_type1.c).
+
+At minimum iommufd provides a universal support of managing I/O address spaces
+and I/O page tables for all IOMMUs, with room in the design to add non-generic
+features to cater to specific hardware functionality.
+
+In this context the capital letter (IOMMUFD) refers to the subsystem while the
+small letter (iommufd) refers to the file descriptors created via /dev/iommu to
+run the user API over.
+
+Key Concepts
+============
+
+User Visible Objects
+--------------------
+
+Following IOMMUFD objects are exposed to userspace:
+
+- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS) allowing map/unmap
+  of user space memory into ranges of I/O Virtual Address (IOVA).
+
+  The IOAS is a functional replacement for the VFIO container, and like the VFIO
+  container copies its IOVA map to a list of iommu_domains held within it.
+
+- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
+  external driver.
+
+- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table (i.e.
+  a single struct iommu_domain) managed by the iommu driver.
+
+  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and the
+  IOAS will synchronize its mapping with each member HW_PAGETABLE.
+
+All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
+
+Linkage between user-visible objects and external kernel datastructures are
+reflected by the arrows, with numbers referring to certain
+operations creating the objects and links::
+
+  _________________________________________________________
+ |                         iommufd                         |
+ |       [1]                                               |
+ |  _________________                                      |
+ | |                 |                                     |
+ | |                 |                                     |
+ | |                 |                                     |
+ | |                 |                                     |
+ | |                 |                                     |
+ | |                 |                                     |
+ | |                 |        [3]                 [2]      |
+ | |                 |    ____________         __________  |
+ | |      IOAS       |<--|            |<------|          | |
+ | |                 |   |HW_PAGETABLE|       |  DEVICE  | |
+ | |                 |   |____________|       |__________| |
+ | |                 |         |                   |       |
+ | |                 |         |                   |       |
+ | |                 |         |                   |       |
+ | |                 |         |                   |       |
+ | |                 |         |                   |       |
+ | |_________________|         |                   |       |
+ |         |                   |                   |       |
+ |_________|___________________|___________________|_______|
+           |                   |                   |
+           |              _____v______      _______v_____
+           | PFN storage |            |    |             |
+           |------------>|iommu_domain|    |struct device|
+                         |____________|    |_____________|
+
+1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. One iommufd can
+   hold multiple IOAS objects. IOAS is the most generic object and does not
+   expose interfaces that are specific to single IOMMU drivers. All operations
+   on the IOAS must operate equally on each of the iommu_domains that are inside
+   it.
+
+2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
+   to bind a device to an iommufd. The external driver is expected to implement
+   proper uAPI for userspace to initiate the binding operation. Successful
+   completion of this operation establishes the desired DMA ownership over the
+   device. The external driver must set driver_managed_dma flag and must not
+   touch the device until this operation succeeds.
+
+3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
+   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
+   allows userspace to initiate the attaching operation. If a compatible
+   pagetable already exists then it is reused for the attachment. Otherwise a
+   new pagetable object (and a new iommu_domain) is created. Successful
+   completion of this operation sets up the linkages among an IOAS, a device and
+   an iommu_domain. Once this completes the device could do DMA.
+
+   Every iommu_domain inside the IOAS is also represented to userspace as a
+   HW_PAGETABLE object.
+
+   NOTE: Future additions to IOMMUFD will provide an API to create and
+   manipulate the HW_PAGETABLE directly.
+
+One device can only bind to one iommufd (due to DMA ownership claim) and attach
+to at most one IOAS object (no support of PASID yet).
+
+Currently only PCI device is allowed.
+
+Kernel Datastructure
+--------------------
+
+User visible objects are backed by following datastructures:
+
+- iommufd_ioas for IOMMUFD_OBJ_IOAS.
+- iommufd_device for IOMMUFD_OBJ_DEVICE.
+- iommufd_hw_pagetable for IOMMUFD_OBJ_HW_PAGETABLE.
+
+Several terminologies when looking at these datastructures:
+
+- Automatic domain, referring to an iommu domain created automatically when
+  attaching a device to an IOAS object. This is compatible to the semantics of
+  VFIO type1.
+
+- Manual domain, referring to an iommu domain designated by the user as the
+  target pagetable to be attached to by a device. Though currently no user API
+  for userspace to directly create such domain, the datastructure and algorithms
+  are ready for that usage.
+
+- In-kernel user, referring to something like a VFIO mdev that is accessing the
+  IOAS and using a 'struct page \*' for CPU based access. Such users require an
+  isolation granularity smaller than what an iommu domain can afford. They must
+  manually enforce the IOAS constraints on DMA buffers before those buffers can
+  be accessed by mdev. Though no kernel API for an external driver to bind a
+  mdev, the datastructure and algorithms are ready for such usage.
+
+iommufd_ioas serves as the metadata datastructure to manage how IOVA ranges are
+mapped to memory pages, composed of:
+
+- struct io_pagetable holding the IOVA map
+- struct iopt_areas representing populated portions of IOVA
+- struct iopt_pages representing the storage of PFNs
+- struct iommu_domain representing the IO page table in the IOMMU
+- struct iopt_pages_access representing in-kernel users of PFNs
+- struct xarray pinned_pfns holding a list of pages pinned by
+   in-kernel Users
+
+Each iopt_pages represents a logical linear array of full PFNs.  The PFNs are
+ultimately derived from userspave VAs via an mm_struct. Once they have been
+pinned the PFN is stored in an iommu_domain's IOPTEs or inside the pinned_pages
+xarray if they are being "software accessed".
+
+PFN have to be copied between all combinations of storage locations, depending
+on what domains are present and what kinds of in-kernel "software access" users
+exists. The mechanism ensures that a page is pinned only once.
+
+An io_pagetable is composed of iopt_areas pointing at iopt_pages, along with a
+list of iommu_domains that mirror the IOVA to PFN map.
+
+Multiple io_pagetable's, through their iopt_area's, can share a single
+iopt_pages which avoids multi-pinning and double accounting of page consumption.
+
+iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long as
+devices managed by different subsystems are bound to a same iommufd.
+
+IOMMUFD User API
+================
+
+.. kernel-doc:: include/uapi/linux/iommufd.h
+
+IOMMUFD Kernel API
+==================
+
+The IOMMUFD kAPI is device-centric with group-related tricks managed behind the
+scene. This allows the external driver calling such kAPI to implement a simple
+device-centric uAPI for connecting its device to an iommufd, instead of
+explicitly imposing the group semantics in its uAPI (as VFIO does).
+
+.. kernel-doc:: drivers/iommu/iommufd/device.c
+   :export:
+
+VFIO and IOMMUFD
+----------------
+
+Connecting a VFIO device to iommufd can be done in two approaches.
+
+First is a VFIO compatible way by directly implementing the /dev/vfio/vfio
+container IOCTLs by mapping them into io_pagetable operations. Doing so allows
+the use of iommufd in legacy VFIO applications by symlinking /dev/vfio/vfio to
+/dev/iommufd or extending VFIO to SET_CONTAINER using an iommufd instead of a
+container fd.
+
+The second approach directly extends VFIO to support a new set of device-centric
+user API based on aforementioned IOMMUFD kernel API. It requires userspace
+change but better matches the IOMMUFD API semantics and easier to support new
+iommufd features when comparing it to the first approach.
+
+Currently both approaches are still work-in-progress.
+
+There are still a few gaps to be resolved to catch up with VFIO type1, as
+documented in iommufd_vfio_check_extension().
+
+Future TODOs
+============
+
+Currently IOMMUFD supports only kernel-managed I/O page table, similar to VFIO
+type1. New features on the radar include:
+
+ - Binding iommu_domain's to PASID/SSID
+ - Userspace page tables, for ARM, x86 and S390
+ - Kernel bypass'd invalidation of user page tables
+ - Re-use of the KVM page table in the IOMMU
+ - Dirty page tracking in the IOMMU
+ - Runtime Increase/Decrease of IOPTE size
+ - PRI support with faults resolved in userspace
-- 
2.38.0

