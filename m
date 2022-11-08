Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69D96204E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiKHAtQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKHAtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:14 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A621DDE4;
        Mon,  7 Nov 2022 16:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8/8/TPLjNJqeM+pdSMFUoW4xr1/ALCe6/vjVzrsTXDc1z7NL9KFydxETGxd/tKQVeMvkvgJpyMNKqoxZihxPFfoco6rVUEtm30QcsAcMQI2YHhapKNpYnLhIih/uvIUW/szBbsKOISEvqbHrWbyCXHRxc3mAIiXE/xc/LKg75hPH5v0rVHs+3361F1MpIPMT6TAmcTWrJ7+hXZuhPNXBXf3WIQZEdA37Sr+Lb26vLPUmvJ4n6FtcUubEAL33DODL4fyCCnt0zVnOenLEekwrX674faqrpsR7ioLoqzE6P1a99ZlpHho4wDJsagfPwnWH0tv0ZUtfEoVaxElu/Ph7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MqW21qoUwB46aqWL49Z9oSAGkPjy/Of9UBW974iQB0=;
 b=nWAIQYHg72Bq5WE2rQtBu5n7bRVelqILRewgJCvcjs8UMgvZy6VOoC9ioSAnSoV4x0kzYfFjeax4TVtvmd9wUUsu7eJqImHIQA89U97md3voOvZW332wisK+k/sedvoanGsDc/vXwhcxjFFIbHQo3aZCDzAO1C3kT84lsfELj/djf6gyk99HWKjoEGmJLKH5CeBMSea54U5fDVK5viYcXHC/L8c6glGiuGUamAV3jKHfsVUDOd1mRna0uyKABzqwuo24PBDXJXAuux30U62H244I/8haZu5+Sf18S0dTgMMaUYVsBUwHXDKV9FlqvBZ1ATA6ra5O2sUkup1ebFQM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MqW21qoUwB46aqWL49Z9oSAGkPjy/Of9UBW974iQB0=;
 b=GZr7KcRyGuAgNTmOFG+WEaCyJBFrk+E3dP5S8eId7iVd1teXjNxvi3CPklXstIsFVJuEN0KjqWS0Fa5uV9fZyq0iWFuQFo5DS5Y2nZA2K7hwcOaQsq0RQzzU00i6DbSoUp6mNI+ngRxYFBe7cNVLrcOfTZ39+aJW4tFgRRN15Avu4OWndlDSh/F5xbTXIKnIfY8W6O3y++SZ49F5jTO/CxrgaPMqzcZsAioa9GKbNmTrhegaDZ1xCvFugqNr+h1Wc2xObA4gx8YGzySARz7fD8unCVlyp1FBm8mAcFpJx9Djc8hj9sGWasaB1tWfynWkQl7TWMS398Olor8uLJRxhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:11 +0000
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
Subject: [PATCH v4 04/17] iommufd: Document overview of iommufd
Date:   Mon,  7 Nov 2022 20:48:57 -0400
Message-Id: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3d53e0-fd70-4338-763a-08dac1230cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55lbO/SXLDS8lg1q/lvX6SwSmLJGDcfvnjm48+Eod4Vn9OFywgcmVMhHR7AgV+kjkXEaasI0fRikJ8SS6G+KlsAcwdxFCmFCuhRRut3YfY68pzBzHO315PEt6LicDaYeq8/fNrMjEZm//nlhA5Vh4mxbCxqu85BKKkD4f+ms0zbmQyXomNiP7MA4DXueGp47gCGd6ecVcCCZQgKYvbXr7YJqJzhukxS7JR2y6qY/4mC+xWDK8GiziJ52DeCz/ycRSUcrH/SUBWjESXX/IE7Wf87zpCD2KwB3MDzNFb0RX9cmFhpTKaXjfhw4o0V1wHB35guMmTSZz9o6swivOeLc+2KtRtR96mg4l82Xe64QAxb511hkzieSjdkm7J3BhYPdqTQBdoE0XSVufRqFqaS2P8e0uNfC6r+kLbDeIVhnmuJ477K33FJGc1OkDtKghaIpkQNN4vwnGoCBnT8FyWwltVnaUP/uEat6BKUd5TssrtO6cR35/ol5t+2OeoqVEN0xD7EjAvCZyy3Eh3T6oGxnpP0hWgvOCfogPSLu5GBVen9A4pOKZGpQnnwCXMrHlNSHN2w9nYeGV4tPv2QWR6hxxA8wxFEIC3BGRsXbBQGKGE2Lh7igkrEMtnpK9aQKlZZvsitvBau3U+kDP0sXWVe+LxvM05QhGBEDvU+U8y6XrgJyhIROBYPwP6MhO3IHPyTWq8qsKfhBtOvBSoo4xs4VFTp3WtbQGMX6yjrjIRHzm3YFX4hhOqKq3/BBkBEnVjJZfGEQj7glhxAiJIv3XrBFkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(36756003)(86362001)(478600001)(2906002)(6486002)(38100700002)(921005)(26005)(186003)(6512007)(2616005)(54906003)(316002)(4326008)(66476007)(6666004)(6506007)(110136005)(41300700001)(8676002)(8936002)(7416002)(7406005)(66946007)(66556008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CvCKYlW8+GInQYIIfRPK0qlUOcOXz/y1uAWSBcOLKfPYysTihcahEVoSgZVV?=
 =?us-ascii?Q?NDaCrmmqyap77xpb+2pMjCqxpPx96uecDODVgR83oIAxuf8a1JnnPZXTV3hh?=
 =?us-ascii?Q?gYn0NboHmVCQRz8B7qvqV5wtpaL0G5MUNK9UVWSH/hzJPka4Je6GxvAItn8i?=
 =?us-ascii?Q?1j0kDAlC2Jt/tlFripPTpRPg2K6ubwAxIb3NM39bu/cuKaUvKaefgNK6xEAf?=
 =?us-ascii?Q?HKdIovnIxnrLNPA39jvkfJP1e0s2UcALMC+x6F3vo8IGlsTqcqxkkpOUYNQ+?=
 =?us-ascii?Q?R+n5IeN4iXgwXCSKVpQw03ovDW+qt5mURmL6Mu+VpAqg/xwnF5NFAZK6hKw3?=
 =?us-ascii?Q?EteHoVNguZPlyT40BMNcBzbfJu/iy4pG0Pj7FkC8nuILB/XIPUyTaR9OBdRh?=
 =?us-ascii?Q?dOB5s3bQg6LPNU6CT0yxRdo3CV1QEemGfh00kJeriA6/XxdKYgtdqWoBiZPP?=
 =?us-ascii?Q?KI4WfpeDxUTsHHProHF/fu+8WJlQaQngzpgX0rbZ+Lly5k6uzzUsNUWlr/DF?=
 =?us-ascii?Q?xYxVUqneU/j9Pb3XH9R7LD1+lKbwzXJjaAZeUWMP7STZAEshLiq5qWoP0w7X?=
 =?us-ascii?Q?atGpfaMdV7iKWE3uD5sVuUwcNLdyAX8A1VmjYqbRaetzIYSn0fReZWH2vd7l?=
 =?us-ascii?Q?11YJkmOnRaiswFa1v3q9n2nqX/72slcjeB3zTVhBAnwOlt7hGuD4+02mITV2?=
 =?us-ascii?Q?Ups4fuRAM0wiQNGWF1TLrLF7Py0gZL8+0+ULjqEY0vxvEd2RX7S4xXrhUT0o?=
 =?us-ascii?Q?JsIWIlFr/TYVXEuUzQkroDCyDrt+YmZVw4zs40jIiMkvKL9OEjOAyqC/XDEw?=
 =?us-ascii?Q?uaAz67H+tEzZ+XjCmOElyVsNDqib7vOwv5TqJLx16OwmTfLkl15g6vY/6dN5?=
 =?us-ascii?Q?7MTvMjmoW49Y7eo9fXa0vU3wMZYezDWWElbTtxb5yTGyiXOuPw4XtcUXW5dD?=
 =?us-ascii?Q?75G7wCQXOygHpOTcIYfusFyfTkkguvHn/jJP2joopN03O/5efhNsFOta3SY8?=
 =?us-ascii?Q?7ZULUn4H1iTJPwWbzjNEZ3G39S1AF6uGRiNOzPI4QModaf1AKidL9VinZgT8?=
 =?us-ascii?Q?BsStlStZBPTPT2q+Vpdd5gsLBj4s1Jb3Lmi/jD7X3daDtFIk8tlP+1vi1oB5?=
 =?us-ascii?Q?mlpAvXqvf5cMVvhr0VJbTXaukR83mALLHT/3+a6Z8eAkch8mEE0vop27O9OG?=
 =?us-ascii?Q?sp1Z9YaZq74NXhnM2ONCrleZUTwokDwGJMA6Zz8JpmxvqmuTEaVAHIBkkC07?=
 =?us-ascii?Q?c3lQKd8IS7yeHWgJnW/fuYbo17Hh4TtDWacVVS4ziM7/qmOqrRDmIuUfi8Qm?=
 =?us-ascii?Q?E4CzT8lEBrWihgUCSUFk6mAiXSnX5/yOiNTMdLX4QlFzodB4ZYuSC8ykCiiz?=
 =?us-ascii?Q?EQXQvOstSnNUWs/k+GHIusgP732f5X4q468Nshh/Vt/F7a3Xj0N7ZppTjKC0?=
 =?us-ascii?Q?O5HDz5I/uxkhXYOlYQZhu5fTCn9g/tGEa2yaxu5x7iSk+VB6vsTXM7el0kCU?=
 =?us-ascii?Q?xDUa/SpL7OGFl+0St/Z9iDTaFm7g/XlEsKuWEg6SfucDnnFenmPrg1Ot2nHo?=
 =?us-ascii?Q?4mf+C2BtfFF9CuGd2EU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3d53e0-fd70-4338-763a-08dac1230cb1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:10.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLKM43Mq8sitpT8aR+pzc3IG25+cYP+vIK/v0AVXmpOFYmQlfzrFEY1EjD3Crz/B
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

From: Kevin Tian <kevin.tian@intel.com>

Add iommufd into the documentation tree, and supply initial documentation.
Much of this is linked from code comments by kdoc.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index 00000000000000..64a135f3055adc
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
+IO page tables from userspace using file descriptors. It intends to be general
+and consumable by any driver that wants to expose DMA to userspace. These
+drivers are eventually expected to deprecate any internal IOMMU logic if exists
+(e.g. vfio_iommu_type1.c).
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
+   to bind a device to an iommufd. The driver is expected to implement proper a
+   set of ioctls to allow userspace to initiate the binding operation.
+   Successful completion of this operation establishes the desired DMA ownership
+   over the device. The driver must also set the driver_managed_dma flag and
+   must not touch the device until this operation succeeds.
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
+Currently only PCI device is allowed to use IOMMUFD.
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
+pinned the PFN is stored in IOPTEs of an iommu_domain or inside the pinned_pages
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

