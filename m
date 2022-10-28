Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259B611AA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ1TJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1TJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 15:09:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308E1E8BBB;
        Fri, 28 Oct 2022 12:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odPrVVu2N8KBAc5LuHG2TfNZzSDtaTZCD+UNituAuYQT1oAbzod46xVCw+u/gDcE7rXkAKWVxYVvyJRpuASa0aO4B0YAzE50ebRtpfKDVa9QYh5TNLJzyVAndS0XeYlIU8e2UCV0Bp/jmBLWFG7psEdtMu1J38lF49XTd6hWChdW/VgVNd983IYe7mBH8CTpvcU6BX1O/R4YtVVlN9gJA5qd6eh9vcrdWxxpHckflzYyfueCcdm3IHt0Nfl+T+zF8CHIElsC6TpkuJNgoDizVJDPMXij4tckMHGWFY8rqugemDIsnjrsZ24Dw/SrLjlSdJRArGsfwm98EaWnT2fsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l66zJzKwo6e/bAC4pemRGz4vVm+9/CWUt7VT41vsPuc=;
 b=KqsVqlAbhyveairADjxWhebuBiMl/pZQjlNd1EB/GvOKFljsXst5DnBlZSNk69oNLTHxpmmVwkPcwflC1a0DhJCJ/MVZh8LFDLfgN/AgPCaLzpgq6YreJK4hBzKqjvmwROYOEA5qN2OcV/XGhxtyp9svHaTomGhKFy8GyvjPvZ1VEmnioFYtDRfOsW9QDsh23/AJ8y9/+yFJ8GM90NOH/vePKP5uZeUOfhlGhI4qyfYvr3oLREK490NjD1fqvlqpVHCQD9yYWRKNjK237F795B3n+1GTOft6CVS6gRDLPtf+q9lcY3BVPp2poId2B73/PF4buNj+QxiO9cJ6goXc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l66zJzKwo6e/bAC4pemRGz4vVm+9/CWUt7VT41vsPuc=;
 b=KyTZCzKLtTB/lT+bgu2g0nni4Kw5R95SZvfcMqgMDZgYg48pbrjN8rm5iwNx9B+XAgt4lvjG23vnMmhZIWjTwYBTvKOB17wd/fPsh1K7VeODeyztmZUPcBW7QvHCRWovlmDpQMfWLv1IKt9NngPw8rhAuw3fghwChqFXLxP34gR0UXWAwCEs8y5ysyEUZQhZim4XPJpjXs7BxclqxI3K7sfV2I1GM3FaK6RSKtH3cZVlUPqHBZrcQZLbm7N0JsdCwWRRSk1EE9dRmB4qClHsb4gKKXIvCwy+AQKzuRANjHZtHI3i99L5DPBI7r06tXeYEmrkBWucnrhcDnyqTAMUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:09:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:09:07 +0000
Date:   Fri, 28 Oct 2022 16:09:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 04/15] iommufd: Overview documentation
Message-ID: <Y1wo0kkAhNb37ePi@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <4-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y1i01MA4hfAC6+QF@debian.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1i01MA4hfAC6+QF@debian.me>
X-ClientProxiedBy: MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bceb362-25b6-4055-1fbf-08dab917e331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUA/mCDwUh/pCysMiVL5tm21BavZQiJvWk4npbRhRQhBkb0l8tTj/V0AQHpUZVyafiHdnqZnJnCdIYCmpt80vh+f+CAx/KhIs+QN0BLgvGaEswifN1ECiPpwsInZWO7fuu/zjbr8XmxSzRg9/sEMVEdtLw+NxYgJSwhNJE8RNHY5NCJtBd1esG4sV3fNDFYPJOHpstpAV+jo0JenVmPYknV5PZz8+mX9jRvvRFAAebRGB37APgkKeU3A5O4Hh4LWPhGJju1xIEDpyCHZ7BYPeIIC6KKwVi/mDTwBFK5e4WqjFQf3tgrOzKaqs0k076FUiPs7zO1LeYD5HRYRGJ73N0CHaBLEmYaoeOelNWrqeQKvMl0zaaHLr0duCZQez5Dd4moTwlVVKZrBoiAnNIly6bbWieFY3qusL6fQigv4ckK/84xyYyTKLAeYXgcvRKd4kLuzgTmzGs6odQIt+xn/20yfuKQGsgY9BFg2I9Sv9uX1KytoVae4wHNc+A8HnbxDHNCfj8XYlSiBhSBV9lnnKtZgpPdQpWg43fGXqUoyX7ch2Qj4Ocgeu2iiLAHMjj9LGISqpV+AtF5L15uEXbTKoK6yINCRxZxd4Lv3WnlwFINLuM2foB0c+FzjEkg3xyF/6ThlCN15T2UyiN7+YIUtMvzfk35ZFPvjnAoFNsFvs96HO4ssOAO06qQgqifmCYNm6UakhnXeB0AbncMRbyrCzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(54906003)(8936002)(6916009)(6506007)(36756003)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(41300700001)(83380400001)(38100700002)(26005)(6512007)(30864003)(86362001)(478600001)(2616005)(186003)(2906002)(6486002)(7406005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRsHJkZmeczXoh8/lle10ZT3oVli/ooChkgtXTYGSX7MA7+M42eNXPpD0Ufb?=
 =?us-ascii?Q?ThjKU1jCMKHllLqPenJeuQBrhW7UTOXmr9UHICA155l7I9fcl5FOgCYKQWxD?=
 =?us-ascii?Q?KDYcujnqT9B1BK+Jq4uwUgXnwFMImMATMrHFLqSPosvE6a+3IGn64MyYGfJT?=
 =?us-ascii?Q?1HAostDabJFL9VffLR+cbTGzb93qsvI7VIq+1XiGv+0bStB+WzQ+Jk2fm8eK?=
 =?us-ascii?Q?DgHg00f21uVtTl2c6X4G4xrIGbar4znxq6sNHlwz6Mpcv9iasCRDjQFUhq8e?=
 =?us-ascii?Q?vTRRKb5t+1kulCDAmCCJcUdZek5TdBsn7Hk6CytVFXwAqNgq2Pg8+GQ3yNna?=
 =?us-ascii?Q?9fE0gaa2MtyPX4xgtHZLGpd6GXL/RvoCZiJxp1HaOJN0cnuiiYe+qGGhGqio?=
 =?us-ascii?Q?R0QtZgl8nJgcYADQsgCOSPqV5G1bne6Ot+Nfbfwmm0/ni8QLtEtAb7cQvzaC?=
 =?us-ascii?Q?6Rc3z2YD+0qGPMU22e3OHsEcUJ+rT7GW/LSjsJgkX5w7M1eNK9f/HQW9wqGR?=
 =?us-ascii?Q?N/YyYMDRHxIJ2PEjeGg8ulpDGmDZtLDCwz4JRUcB4BeI9SjfKUUHBMxHdxd6?=
 =?us-ascii?Q?WmQCz4Na0MJyWCR27HOuJa/9rcuQ1yRUnikAzLoh9Zk6useQVnCrXFpbHjaH?=
 =?us-ascii?Q?yn0CsMY5I5xWbxg0D+Fu8mxs45fwsRfXYjf5ajGFg6Ly0NYhwdY/NcaJm4PE?=
 =?us-ascii?Q?uiszIcZ3WE1Ob1N/e70RG7K0hHdlPD+BckVv+DeRi1JcvIdjU6ZbGqjsiadI?=
 =?us-ascii?Q?7LKmEad1vqXtKvXxHo8oC3SQFgj/5Z2sNzXzQaidlPqq0xaWREdKBIMv5jtT?=
 =?us-ascii?Q?M8oE+1nT7gDeT1rJP5PD/zxl5cFgRPcxbsVnG1ROS6LjUqaHb7C+6tCf6Gom?=
 =?us-ascii?Q?kM7AYFiupM061q/hCr9KfeIV5gkk5wUunSq/BVmlHKm0KvTx2CL3phJIzPJX?=
 =?us-ascii?Q?k7PqTqpERyOAK9ffVZnom0C+SIy3Vfh4IeRJjxv6D8JxA0GFbA4bfhNvN4Gg?=
 =?us-ascii?Q?fJIVITMrrM+KmbIprJm+/rseG8IQyszK/CQSxweJjL2vTBBz2OL2wyP80h4C?=
 =?us-ascii?Q?+Mksq/6AWx8BBhLFdm3pMVm5Jea24iQzya0aDY2RiBETIdDVXyzfgUAmJxnu?=
 =?us-ascii?Q?o6PYtF18EqF1mAXc2ClQTr0UZkzQ5pm5TKWOQYEhGqcfaUaJXToEfATxhuEW?=
 =?us-ascii?Q?23d7kXO8txj7u1qwM4IQTUJFD1crB5Go1RD9FnkE+bk3uT1KZFjbHVPfRrl9?=
 =?us-ascii?Q?mzo/v5/KeoPzhK4QNEsaPHisA4cFGjujsKWJVfNfH2jDB7ezAfvdpYoBJoki?=
 =?us-ascii?Q?bKuJudkWu7+WVTl/geX1QjixSht7w+KTVx9URKmyVVhK29otWHPT7s9GGc8Z?=
 =?us-ascii?Q?oortBjuPvA/Z/qih4bBkHR+MmA7duXnzTBa9TC+AputvvwphCKy6hjikoHCE?=
 =?us-ascii?Q?NO4+TGNKiJrViq7MrsUL9he8wbbNh8BQbGxL8vnPJFwZDTurMlWJRepLwZo4?=
 =?us-ascii?Q?kgIpHFnTLxAeFiQOlJ3GxNx1AUiSC4nFPmsf6W6Oz1rhNz7Ld6kcZusLp7Fj?=
 =?us-ascii?Q?Jvacx3eCGv6eSaDskCc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bceb362-25b6-4055-1fbf-08dab917e331
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 19:09:07.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+EV/++TRl+L6Z6hJB2WI4mOgsaP0WabzmiMscsGHP173f88/G4Ax9HzhTQ15pPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 11:17:24AM +0700, Bagas Sanjaya wrote:
> > + - Binding iommu_domain's to PASID/SSID
> > + - Userspace page tables, for ARM, x86 and S390
> > + - Kernel bypass'd invalidation of user page tables
> > + - Re-use of the KVM page table in the IOMMU
> > + - Dirty page tracking in the IOMMU
> > + - Runtime Increase/Decrease of IOPTE size
> > + - PRI support with faults resolved in userspace
> 
> What are "external driver"? Device drivers (most likely)? This is the
> first time I hear the term.

iommufd sits between two drivers, we have the iommu subsystem driver
and we have the "external" driver, which would be the susystem driver
using the iommufd kAPI.

> -IOMMUFD is the user API to control the IOMMU subsystem as it relates to managing
> -IO page tables that point at user space memory. It intends to be general and
> -consumable by any driver that wants to DMA to userspace. These drivers are
> -eventually expected to deprecate any internal IOMMU logic, if existing (e.g.
> +IOMMUFD is the user API to control the IOMMU subsystem as it relates to
> +managing IO page tables using file descriptors. It intends to be general and
                
I added "from userspace":

 IO page tables from userspace using file descriptors. It intends to be general

>  In this context the capital letter (IOMMUFD) refers to the subsystem while the
> -small letter (iommufd) refers to the file descriptors created via /dev/iommu to
> -run the user API over.
> +small letter (iommufd) refers to the file descriptors created via /dev/iommu
> +for use by uAPI.

"use by userspace", uaPI reads weird

  
  Key Concepts
>  ============
> @@ -32,26 +32,26 @@ User Visible Objects
>  
>  Following IOMMUFD objects are exposed to userspace:
>  
> -- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS) allowing map/unmap
> -  of user space memory into ranges of I/O Virtual Address (IOVA).
> +- IOMMUFD_OBJ_IOAS, representing an I/O address space (IOAS), allowing
> +  map/unmap of user space memory into ranges of I/O Virtual Address (IOVA).
>  
> -  The IOAS is a functional replacement for the VFIO container, and like the VFIO
> -  container copies its IOVA map to a list of iommu_domains held within it.
> +  The IOAS is a functional replacement for the VFIO container, and like the
> +  VFIO container it copies IOVA map to a list of iommu_domains held within it.

"it copies IOVA map" is not good grammar, how about

  VFIO container it copies an IOVA map to a list of iommu_domains held within it.

> -- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
> +- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by the
>    external driver.

I would say 'an' is correct here since there can be multiple external
drivers using iommufd.

> -1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. One iommufd can
> +1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. A iommufd can

"an iommufd"

>  2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
> -   to bind a device to an iommufd. The external driver is expected to implement
> -   proper uAPI for userspace to initiate the binding operation. 

"uAPI" -> "set of ioctls":

The driver is expected to implement proper a
set of ioctls to allow userspace to initiate the binding operation.

> +3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the
> +   IOMMUFD kAPI to attach a bounded device to an IOAS. Similarly the external

I think bound is correct here

> -- In-kernel user, referring to something like a VFIO mdev that is accessing the
> -  IOAS and using a 'struct page \*' for CPU based access. Such users require an
> +- In-kernel user - refers to something like a VFIO mdev that is accessing the
> +  IOAS and using a 'struct page \*' for CPU based access. Such users require
>    isolation granularity smaller than what an iommu domain can afford. They must
>    manually enforce the IOAS constraints on DMA buffers before those buffers can
> -  be accessed by mdev. Though no kernel API for an external driver to bind a
> -  mdev, the datastructure and algorithms are ready for such usage.
> +  be accessed by mdev. Although there are no kernel drivers APIs to bind a
> +  mdev, the datastructure and algorithms are ready for handling that use case.

Ah, this is out dated, we now have a kernel API to bind mdev drivers

- In-kernel user - refers to something like a VFIO mdev that is using the
  IOMMUFD access interface to access the IOAS. This starts by creating an
  iommufd_access object that is similar to the domain binding a physical device
  would do. The access object will then allow converting IOVA ranges into struct
  page * lists, or doing direct read/write to an IOVA.

> -Each iopt_pages represents a logical linear array of full PFNs.  The PFNs are
> +Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
>  ultimately derived from userspave VAs via an mm_struct. Once they have been
> -pinned the PFN is stored in an iommu_domain's IOPTEs or inside the pinned_pages
> -xarray if they are being "software accessed".
> +pinned the PFN is stored in IOPTEs of the iommu_domain or inside
> the

> -Multiple io_pagetable's, through their iopt_area's, can share a single
> -iopt_pages which avoids multi-pinning and double accounting of page consumption.
> +Multiple io_pagetable-s, through their iopt_area-s, can share a single
> +iopt_pages which avoids multi-pinning and double accounting of page
> +consumption.

I've never seen the use of - to pluralize like this before??

I took substantially all of these edits, aside from the notes above

Thanks!
Jason

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 3e1856469d96dd..64a135f3055adc 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -11,18 +11,18 @@ Overview
========

IOMMUFD is the user API to control the IOMMU subsystem as it relates to managing
IO page tables [-that point at user space memory.-]{+from userspace using file descriptors.+} It intends to be general
and consumable by any driver that wants to {+expose+} DMA to userspace. These
drivers are eventually expected to deprecate any internal IOMMU [-logic,-]{+logic+} if [-existing-]{+exists+}
(e.g. vfio_iommu_type1.c).

At minimum iommufd provides[-a-] universal support of managing I/O address spaces and
I/O page tables for all IOMMUs, with room in the design to add non-generic
features to cater to specific hardware functionality.

In this context the capital letter (IOMMUFD) refers to the subsystem while the
small letter (iommufd) refers to the file descriptors created via /dev/iommu [-to-]
[-run the user API over.-]{+for+}
{+use by userspace.+}

Key Concepts
============
@@ -32,26 +32,26 @@ User Visible Objects

Following IOMMUFD objects are exposed to userspace:

- IOMMUFD_OBJ_IOAS, representing an I/O address space [-(IOAS)-]{+(IOAS),+} allowing map/unmap
  of user space memory into ranges of I/O Virtual Address (IOVA).

  The IOAS is a functional replacement for the VFIO container, and like the VFIO
  container {+it+} copies [-its-]{+an+} IOVA map to a list of iommu_domains held within it.

- IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
  external driver.

- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table
  (i.e. a single struct iommu_domain) managed by the iommu driver.

  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and
  [-the-]
[-  IOAS-]{+it+} will synchronize its mapping with each member HW_PAGETABLE.

All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.

[-Linkage-]{+The diagram below shows relationship+} between user-visible objects and[-external-] kernel
datastructures [-are-]
[-reflected by the arrows,-]{+(external to iommufd),+} with numbers [-referring-]{+referred+} to[-certain-] operations
creating the objects and links::

  _________________________________________________________
 |                         iommufd                         |
@@ -82,37 +82,38 @@ operations creating the objects and links::
           |------------>|iommu_domain|    |struct device|
                         |____________|    |_____________|

1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. [-One-]{+An+} iommufd can
   hold multiple IOAS objects. IOAS is the most generic object and does not
   expose interfaces that are specific to single IOMMU drivers. All operations
   on the IOAS must operate equally on each of the iommu_domains[-that are-] inside {+of+} it.

2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
   to bind a device to an iommufd. The[-external-] driver is expected to implement proper [-uAPI for-]{+a+}
{+   set of ioctls to allow+} userspace to initiate the binding operation.
   Successful completion of this operation establishes the desired DMA ownership
   over the device. The[-external-] driver must {+also+} set {+the+} driver_managed_dma flag and
   must not touch the device until this operation succeeds.

3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
   allows userspace to initiate the attaching operation. If a compatible
   pagetable already exists then it is reused for the attachment. Otherwise a
   new pagetable object [-(and a new iommu_domain)-]{+and iommu_domain+} is created. Successful completion of
   this operation sets up the linkages among[-an-] IOAS,[-a-] device and[-an-] iommu_domain. Once
   this completes the device could do DMA.

   Every iommu_domain inside the IOAS is also represented to userspace as a
   HW_PAGETABLE object.

   [-NOTE: Future additions to IOMMUFD will provide an API to create and-]
[-   manipulate the HW_PAGETABLE directly.-]{+.. note::+}

      [-One device can only bind-]{+Future IOMMUFD updates will provide an API+} to [-one iommufd (due to DMA ownership claim)-]{+create+} and [-attach-]
[-to at most one IOAS object (no support of PASID yet).-]{+manipulate the+}
{+      HW_PAGETABLE directly.+}

{+A device can only bind to an iommufd due to DMA ownership claim and attach to at+}
{+most one IOAS object (no support of PASID yet).+}

Currently only PCI device is [-allowed.-]{+allowed to use IOMMUFD.+}

Kernel Datastructure
--------------------
@@ -125,21 +126,20 @@ User visible objects are backed by following datastructures:

Several terminologies when looking at these datastructures:

- Automatic [-domain, referring-]{+domain - refers+} to an iommu domain created automatically when
  attaching a device to an IOAS object. This is compatible to the semantics of
  VFIO type1.

- Manual [-domain, referring-]{+domain - refers+} to an iommu domain designated by the user as the
  target pagetable to be attached to by a device. Though currently {+there are+}
  no [-user API-]
[-  for userspace-]{+uAPIs+} to directly create such domain, the datastructure and algorithms
  are ready for {+handling+} that [-usage.-]{+use case.+}

- In-kernel [-user, referring-]{+user - refers+} to something like a VFIO mdev that is[-accessing the-]
[-  IOAS and-] using[-a 'struct page \*' for CPU based access. Such users require an-]
[-  isolation granularity smaller than what an iommu domain can afford. They must-]
[-  manually enforce-] the
  [-IOAS constraints on DMA buffers before those buffers can-]
[-  be accessed-]{+IOMMUFD access interface to access the IOAS. This starts+} by [-mdev. Though no kernel API for-]{+creating+} an
  [-external driver-]{+iommufd_access object that is similar+} to[-bind a-]
[-  mdev,-] the [-datastructure and algorithms are ready for such usage.-]{+domain binding a physical device+}
{+  would do. The access object will then allow converting IOVA ranges into struct+}
{+  page * lists, or doing direct read/write to an IOVA.+}

iommufd_ioas serves as the metadata datastructure to manage how IOVA ranges are
mapped to memory pages, composed of:
@@ -149,13 +149,12 @@ mapped to memory pages, composed of:
- struct iopt_pages representing the storage of PFNs
- struct iommu_domain representing the IO page table in the IOMMU
- struct iopt_pages_access representing in-kernel users of PFNs
- struct xarray pinned_pfns holding a list of pages pinned by in-kernel [-Users-]{+users+}

Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
ultimately derived from userspave VAs via an mm_struct. Once they have been
pinned the PFN is stored in[-an iommu_domain's-] IOPTEs {+of an iommu_domain+} or inside the pinned_pages
xarray if they [-are being "software accessed".-]{+have been pinned through an iommufd_access.+}

PFN have to be copied between all combinations of storage locations, depending
on what domains are present and what kinds of in-kernel "software access" users
@@ -164,8 +163,9 @@ exists. The mechanism ensures that a page is pinned only once.
An io_pagetable is composed of iopt_areas pointing at iopt_pages, along with a
list of iommu_domains that mirror the IOVA to PFN map.

Multiple [-io_pagetable's,-]{+io_pagetable-s,+} through their [-iopt_area's,-]{+iopt_area-s,+} can share a single
iopt_pages which avoids multi-pinning and double accounting of page
consumption.

iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long as
devices managed by different subsystems are bound to a same iommufd.
@@ -179,9 +179,9 @@ IOMMUFD Kernel API
==================

The IOMMUFD kAPI is device-centric with group-related tricks managed behind the
scene. This allows the external [-driver-]{+drivers+} calling such kAPI to implement a simple
device-centric uAPI for connecting its device to an iommufd, instead of
explicitly imposing the group semantics in its uAPI [-(as-]{+as+} VFIO [-does).-]{+does.+}

.. kernel-doc:: drivers/iommu/iommufd/device.c
   :export:
@@ -189,7 +189,7 @@ explicitly imposing the group semantics in its uAPI (as VFIO does).
VFIO and IOMMUFD
----------------

Connecting a VFIO device to iommufd can be done in two [-approaches.-]{+ways.+}

First is a VFIO compatible way by directly implementing the /dev/vfio/vfio
container IOCTLs by mapping them into io_pagetable operations. Doing so allows
