Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5F62CBFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiKPVDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiKPVB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41769DFC;
        Wed, 16 Nov 2022 13:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh6oDnlYNPbx5nY9Laj+CCovpnxUzYLYzOYB5FFPPBlSf4gGOiCI5ewidRAtKdjbgkmcwjf0ujTv9ssNjwkHZz7xvpWmrkpzqZ3WOc+AvBC/twhl0B/hQS7b/dTCJhqxREJ3M2B9+PcLSISQj6KzJZPfML+1eUnWYRnBnT9jkzVwYcFT0US6LYoH7Ny+xghELHqA9v5eXQOAVWsV6FBmbYC44GFJfcZZbd9/cxKRN7hrx9ZqdgS1laoAdLcBiMAWY/omWpDsCjnIYexpT3xK9xfpn9K4xe8uRHIHQZSjz3g6oyA9yjKzsMUMMBKWkLKVrrZoq6v23AxrXcgm6rRV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1ns1RBZlNvW9wa41AzKWH485BLRGI/NY0lWTXw9CcM=;
 b=lUpK4l6QsCEbGrbzp4X4C5u23T6oKhjYxCIUseNf0R7E0CBxyHP1Ei07aatd6If4dodqEoUyULcfts8JGg8j7Gk8JF/UROv7DukyFEx+zrtrp7jSKYE5VLpoQjYT5tG3O+/TDc9kgGLlf77k8p7AI4DtIrRcK9qgNX6WS+LDJptMwp/wlOsvFhSXiL0GfYYuKSZjmb1NB8bgtl1Y7Sg8kJzZ6uUYSf8oW8BGDKzEwkpif6mRXjnfIiV/Xexb2HkVmcty5u+nSPCdGIbeN+gISOWLDJw8RrWUOjLArBxzQcxY1XJtGFtgEDQIJA7BRH7HLcp2FToadnQBDIjX9BXsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1ns1RBZlNvW9wa41AzKWH485BLRGI/NY0lWTXw9CcM=;
 b=c7nwd1dAVhjDmaEibc39xKnxhlsnrreyVd39vI7LRXNeS1eEktSuBZK0DY8Pwwv5sRgAB9vQfdaB1sXL7ffwN9di/gx5MPtdg2uyWEAet8I/0FZn0p5Jm5VVSKlZqtChaSvDT5zcmpWp3w+dGHI0X3bEVx0zCckrpu71GfOAercuMKY7X3ISB7Jgmvhd1Sodtmi6PT4aaWm1RgkZMdbom3yKZKg9NzkXcFbJj8Ram97GMRhWMCALZmK/4n9gCeji3BiMTlrSKU0qW7lvYMlCLsr8FoejbDmmnQ2URck1V6vFAISCY9RvvjMdFmQaVQugxNcaoGtvhjG/8WEfH/8iVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:59 +0000
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
Subject: [PATCH v5 05/19] iommufd: Document overview of iommufd
Date:   Wed, 16 Nov 2022 17:00:41 -0400
Message-Id: <5-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b684b83-7729-441d-4ae8-08dac815a837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZStOIWQqSUTlB4wFoNrV0Uxh3TBqK3HLX8XfJFWONRLNvYIRbwEIWJamq2TfakDvjXvwqlaPcu81YyK7yheXroHfI8dYK7T7d8JAa1j8Icn4y2IejRZ5h55WEzx0uhvkNZE4vnQx2XMPpQgnPr8E6a2XNbDEUzvoBkCYZukrz2x5I796EgsZi/O4XaMr1GN+C80znTGFZqhkb41NNO3KgF0HjZYsmvh+g9h+UfMkC/wwPVMFK6H4Oi0976EQDO7B8oQiUKXHQ0a9mL28Al87cs8lKWqThcacb0lr2+Nqq3kJX5pFO+WaB35KLhoL/d+YUH9c5Pgs/VZhlSpNkOVrfb8KHN0KNWsaYrq92AZEvaOFFGLmjNfCAeZCf2KApyQOSiMfKDgVF3pi2gLPlpQryvQls7amgdXX7R1aT8vU15lnSIxP9mjA6NVpJ99b7086T5n5GNeRe5+ZllqMYG3L8zh89w4zaqqHlki7QFXUMqXkNSzHVkF1IwP0lXdHfewBN1TkxowA8xvNIt6ArIo2ecTrnTTkdx4LtT0oKRsYWfxloNe6ti+akJWz8u/HnrxKwJ9rUKMl3Fi3kWhWbpGQPyz8jpaAJ7vNEbL6CQmbejeCcI7YJOzYcsokMcZ67EwqBaxTM+WSDGAvQLbkoC7jpdzN/wXHpjOCXx/fgTcMx/tW2vcJoXSS8deRiTe3zF3iJwUsihTAU9LiSJIukC668A2kvwJ+w7gqA1W4UTmedMTkpMYjA2vdYdZ9oB3ONJbpufEezxnE/wLzACcg9AlPxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(6512007)(36756003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GnLSgVVooON7LKvsjhzyYu2oFXYIUwwZBiah1otytSdiQI1MV0qy/vKeY6n?=
 =?us-ascii?Q?l9r7RcyTiqOatBaZsfSCqReLm5KDIyjScLHQEUJh5CgJw4gwZX/dBsdENdWp?=
 =?us-ascii?Q?jmLiZyuE+zkp0A1Z+B7hj0zoWO8RI4D2ivvZOSksZ8YlSgF1do1k7UdwghlT?=
 =?us-ascii?Q?QTAJmqkETMhIGqJVJtIcoufiIF2a+TcfC2v49dmyzs4qnOEOwd7r37/fqi8H?=
 =?us-ascii?Q?n+m+EzREOL/I5XGh4vtgqGn1yc0gkYjDetJ4LJxt7S23LfAGEITVAwqazGhB?=
 =?us-ascii?Q?Brc+ybyvxgeb697BqFDQeLuKom4c0fHr35yLKZA3OFNleHTneQRoVQhQcG4x?=
 =?us-ascii?Q?RHv3Nf/OVqgGT7nXRc503V380bcEGie6JOOPYqaKjaHfzJ0ABa/AyJCk9gvp?=
 =?us-ascii?Q?a/MlzKKD+rYLEh9SYZpvwiBsuhepWaC88OBKv02AkGuwru70IRbtQnvG6v1J?=
 =?us-ascii?Q?ODorSg3BHDjcHzzmNd/JfzVGn/HfCMMllDEJe9GbmCS9ogdcwoBQ7E0XsD+z?=
 =?us-ascii?Q?hzmlbGQ5eudcfJecDmsr2JQ9hDrrVVgjeri3J55TvKP9dw+7L043l7+0zkG4?=
 =?us-ascii?Q?HhbT+k6tKYCI00XqGazPzE7Yd7XmdZ66DCFWPZ7p3KhVlLJ7lj/hV0cZShRl?=
 =?us-ascii?Q?mA+2GBUNgEADwm16NyRzG/2TNRunaCpVl1v+fsMi9iFV/WOl/GrkhLnbLkb4?=
 =?us-ascii?Q?llejBAHr3lLgK1lUV5xLl4wP9gyF0Tyeb3QcAFIIilI5nfVWF1E7vU1zddrM?=
 =?us-ascii?Q?7kx6Bo2HXGUCSNl1N9t94ocxGR+S0gJDDep0HdsvkcApVO+wWZpp7Kmfhght?=
 =?us-ascii?Q?O4WKR9D3O7NPAqbxkXKmeo2fLSx4/AmzKqMzsSvslj01W89MhIGFHaf4HQCJ?=
 =?us-ascii?Q?HFt1vVnH9IrMdQSS59Ml8uzudDNRvusqK2BaAgGCNsYCDFcIG+exWjdUgmh0?=
 =?us-ascii?Q?6tXprfE1QZt2TBhvTD64SepY/vR021TYwwUv+M1wRkpuho+4pJOT97kI29gS?=
 =?us-ascii?Q?hMyIAH3E6b38wQ1tPjPnkCG3R21ZrM/rtDR9jidfA955+0mTJhDk2mVz+XoV?=
 =?us-ascii?Q?3yujHWks+uo1YClgmLe0jzwVqSulE0zQQweSjB9cLJuoo/bBr5hbWo3Xeake?=
 =?us-ascii?Q?aWyGbH+EVWosIqNXn1s1xtmisq+IQKXHM25dCGb0VQsvNZ4nPakQbLai2azg?=
 =?us-ascii?Q?9bMhngPXLTrXu9pSgMg6Fb4nTdvE+n3crWxxSVGK0/n9u/1yASQMiHuMwVaW?=
 =?us-ascii?Q?dN3+EbI9BnwO1Jc7eN5QGtpXEpxFxUsVaUaAvEQqLqYGfFIMEy+l6rF7VGEo?=
 =?us-ascii?Q?Anf7+lzJLcHc+YV/UueJ/GVJnVWc7HC1nUjCfoVWG9DnbaP8WgiTZwlurqBi?=
 =?us-ascii?Q?Eefbqwhy7HJjDyOqxmI0u2XSXnzoZlWg30cKFgvpVjZ/g2Naj1zCnQ4NhpCo?=
 =?us-ascii?Q?j8YllJ2si/ES7cr4k15DdNG+CvpBvDlZXksGKZDb3BK2gPtLnoMN8BcHvRpR?=
 =?us-ascii?Q?XdbgZKCHAajMTgXv4W8Iq/lLXxddI8tyk1EtLFiErQBqi8tF7o+dd6Uy6yJp?=
 =?us-ascii?Q?ZpCpTGTV3Uxy1E1alEM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b684b83-7729-441d-4ae8-08dac815a837
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:57.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIG9NpOUNMCDprhXOHjaDloGwdvkv8+whImz/n5Q+FwaqyXR+JsScpylqoKTqXyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

Add iommufd into the documentation tree, and supply initial documentation.
Much of this is linked from code comments by kdoc.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/index.rst   |   1 +
 Documentation/userspace-api/iommufd.rst | 223 ++++++++++++++++++++++++
 2 files changed, 224 insertions(+)
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
index 00000000000000..8b1392fd2e3487
--- /dev/null
+++ b/Documentation/userspace-api/iommufd.rst
@@ -0,0 +1,223 @@
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
+IO page tables from userspace using file descriptors. It intends to be general
+and consumable by any driver that wants to expose DMA to userspace. These
+drivers are eventually expected to deprecate any internal IOMMU logic
+they may already/historically implement (e.g. vfio_iommu_type1.c).
+
+At minimum iommufd provides universal support of managing I/O address spaces and
+I/O page tables for all IOMMUs, with room in the design to add non-generic
+features to cater to specific hardware functionality.
+
+In this context the capital letter (IOMMUFD) refers to the subsystem while the
+small letter (iommufd) refers to the file descriptors created via /dev/iommu for
+use by userspace.
+
+Key Concepts
+============
+
+User Visible Objects
+--------------------
+
+Following IOMMUFD objects are exposed to userspace:
+
+- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS), allowing map/unmap
+  of user space memory into ranges of I/O Virtual Address (IOVA).
+
+  The IOAS is a functional replacement for the VFIO container, and like the VFIO
+  container it copies an IOVA map to a list of iommu_domains held within it.
+
+- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
+  external driver.
+
+- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table
+  (i.e. a single struct iommu_domain) managed by the iommu driver.
+
+  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and
+  it will synchronize its mapping with each member HW_PAGETABLE.
+
+All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
+
+The diagram below shows relationship between user-visible objects and kernel
+datastructures (external to iommufd), with numbers referred to operations
+creating the objects and links::
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
+1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
+   hold multiple IOAS objects. IOAS is the most generic object and does not
+   expose interfaces that are specific to single IOMMU drivers. All operations
+   on the IOAS must operate equally on each of the iommu_domains inside of it.
+
+2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
+   to bind a device to an iommufd. The driver is expected to implement a set of
+   ioctls to allow userspace to initiate the binding operation. Successful
+   completion of this operation establishes the desired DMA ownership over the
+   device. The driver must also set the driver_managed_dma flag and must not
+   touch the device until this operation succeeds.
+
+3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
+   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
+   allows userspace to initiate the attaching operation. If a compatible
+   pagetable already exists then it is reused for the attachment. Otherwise a
+   new pagetable object and iommu_domain is created. Successful completion of
+   this operation sets up the linkages among IOAS, device and iommu_domain. Once
+   this completes the device could do DMA.
+
+   Every iommu_domain inside the IOAS is also represented to userspace as a
+   HW_PAGETABLE object.
+
+   .. note::
+
+      Future IOMMUFD updates will provide an API to create and manipulate the
+      HW_PAGETABLE directly.
+
+A device can only bind to an iommufd due to DMA ownership claim and attach to at
+most one IOAS object (no support of PASID yet).
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
+- Automatic domain - refers to an iommu domain created automatically when
+  attaching a device to an IOAS object. This is compatible to the semantics of
+  VFIO type1.
+
+- Manual domain - refers to an iommu domain designated by the user as the
+  target pagetable to be attached to by a device. Though currently there are
+  no uAPIs to directly create such domain, the datastructure and algorithms
+  are ready for handling that use case.
+
+- In-kernel user - refers to something like a VFIO mdev that is using the
+  IOMMUFD access interface to access the IOAS. This starts by creating an
+  iommufd_access object that is similar to the domain binding a physical device
+  would do. The access object will then allow converting IOVA ranges into struct
+  page * lists, or doing direct read/write to an IOVA.
+
+iommufd_ioas serves as the metadata datastructure to manage how IOVA ranges are
+mapped to memory pages, composed of:
+
+- struct io_pagetable holding the IOVA map
+- struct iopt_areas representing populated portions of IOVA
+- struct iopt_pages representing the storage of PFNs
+- struct iommu_domain representing the IO page table in the IOMMU
+- struct iopt_pages_access representing in-kernel users of PFNs
+- struct xarray pinned_pfns holding a list of pages pinned by in-kernel users
+
+Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
+ultimately derived from userspave VAs via an mm_struct. Once they have been
+pinned the PFNs are stored in IOPTEs of an iommu_domain or inside the pinned_pages
+xarray if they have been pinned through an iommufd_access.
+
+PFN have to be copied between all combinations of storage locations, depending
+on what domains are present and what kinds of in-kernel "software access" users
+exists. The mechanism ensures that a page is pinned only once.
+
+An io_pagetable is composed of iopt_areas pointing at iopt_pages, along with a
+list of iommu_domains that mirror the IOVA to PFN map.
+
+Multiple io_pagetable-s, through their iopt_area-s, can share a single
+iopt_pages which avoids multi-pinning and double accounting of page
+consumption.
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
+scene. This allows the external drivers calling such kAPI to implement a simple
+device-centric uAPI for connecting its device to an iommufd, instead of
+explicitly imposing the group semantics in its uAPI as VFIO does.
+
+.. kernel-doc:: drivers/iommu/iommufd/device.c
+   :export:
+
+.. kernel-doc:: drivers/iommu/iommufd/main.c
+   :export:
+
+VFIO and IOMMUFD
+----------------
+
+Connecting a VFIO device to iommufd can be done in two ways.
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
2.38.1

