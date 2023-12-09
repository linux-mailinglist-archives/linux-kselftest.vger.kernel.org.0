Return-Path: <linux-kselftest+bounces-1468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766980B18D
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527781C20D02
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 01:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575B80F;
	Sat,  9 Dec 2023 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQ/dZh9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C705E3;
	Fri,  8 Dec 2023 17:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwvVbQzeNYFGaGNACZA1nyt8T6FtChe5V0/m/LH3GE6yHXBDNRmT5eeXG3pHXvIrglrseWVaJjaNy65yxKA7hulFh9H0iZgktFypq/VPw8MQqRh9av96jyztOferFgE2HBRx73d2uUmZGQ0s1QEEyLGM+dR/QzABJTwADSz0brlEx8NyNO4chVFQP3jh8DzFugqMwojRnbCHU0P+BMqxTP/qodkJz9OOjkO5Ik6d1pEaUM/QpyUBN73JZ9iL/qQvsF4Qu2Kv8TUYQAtmpocypumH41/KW2sLfnla3aHpwXpNzZqI800zHL+XnQ5XffnDSDOeds6g7AzxXnoTIkPEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUNwJl8Jn1PBN/HxlkjA3aFFCPKLNlTw97AZnQreqcQ=;
 b=L+NnUnWPdUgxP3Nhl7iUepLCYOKbi9WKPM5pQmrWmyL+B113zn57bIJ2DbxwehbWwV8MH7iDPR4vjU5nSHogicUbAAD12vIQa1XJIkjF4p3Om0tKpzxOrV+1puNaoO4GOQvzxXaGZ9BRGFCnsNaVkbE6bZpZ3xl6fuRcofHG7h9p18JI/lIOW2Rc1FUFM/y0gkW4Wxk2brYYZnuooNg6VlWKsGQE0GwL4kDY+IShYe7eEYbFassSWl/+HNhqbYkU5yZVNQX8zRS62kQ5h6K0mzIAyaZehQsWNRDXvGdb6UthkDtdLpL6w6PRThwxLFfLch73B9JWSYB19FmdoNlG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUNwJl8Jn1PBN/HxlkjA3aFFCPKLNlTw97AZnQreqcQ=;
 b=IQ/dZh9FIDKmdKb35WnQZIWPmyNTkY5lno+Vvrmvx3pgQov/UiF+R+C2UUUNyB9YkYgu6nEjuCbxnab8CRI83LOVdTjFFJUlaluAYlZwxY0MFVlNMw1Je7DoQlYh4joyBuUQPwMI1w7h66L22Lw3kOOJv9SusfyHLDcg9lYbD9W7cFhgzoN1x5OsKmhThgJ8SKFR5pPkuR0Ymwj8vqnp8ryJmSZEW1asJmeo3mb4CKNwwg6zB/6wFv08EKuyB0SOrCgtiX05+aazS46qxek9FqqdKJo02Zp0Q+L5FMEpFEQDuyK/2NAt/4fqf/z37p7B35y/DKYWdti+QUJPmUNYvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Sat, 9 Dec
 2023 01:47:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.038; Sat, 9 Dec 2023
 01:47:27 +0000
Date: Fri, 8 Dec 2023 21:47:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231209014726.GA2945299@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 239ad3df-e218-43ba-bb7e-08dbf858cc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dW2Hcnt+yR64b6809RnfwaNFBY1Tqn/qAqsPtYc+NGcAmMaVaaZMk6D46KfSK0tUswdAZ65/yTdnbKM8Rj4+Q/U5cgYgmS8rIphkF6sUSOVetwq8uxgLAchEntzI0jAPwPgpEiQa7dI8n4ibuZTqFxcBvGSBREMyWMk6XVkzIEkQ/S/NKcw5EZvSnIOYqsNCBikIuacOxjB+EZgJc+a2db50hutcP0J+qwtHseRE32Iy9Oo4L6NHWTyUfdoliEV0/MpMfoLsB7gsSyGCdExLxcthIq+wIBnlzSLKp5kL/7yb6gnajN4bw/r3/JtCnG/NwHKrzLeJ/qEUc9rBcNwW8abMBdm5jvl5uyQY0V+PLi8qRmIfhvd8pC3pqmNaOyYehvxh9EWRDnlv1IwQ9bTgI+8lwYqFsnSBGIB9wZsOcRMuoMpFhICl6axhZXGH5kNT7w1ItgtFXLy+Y4dlBCZN1xeUiI+TUWyIss6dhke9CeKIG6CVX+dueqOITu0DeRxRZe4RWjZ57KFm/ghRXLECgdBUxDRKZblAh8fj0bT09+njGBPv0gyyyd8/0p/ndCwq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2616005)(6512007)(26005)(1076003)(83380400001)(6486002)(41300700001)(86362001)(4326008)(36756003)(8936002)(2906002)(5660300002)(7416002)(8676002)(316002)(66556008)(66946007)(66476007)(110136005)(6506007)(478600001)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?upgdOvZnvOyF2J9bMCEzv56ykztyfAFrUxBHLfdrE/clS0CVEn1cl1T15cuI?=
 =?us-ascii?Q?wLulaBcgpEwIi1iu3CXx7XeoS0/npTmuTmfa6kfQewkzhNvAghdusKUpumAn?=
 =?us-ascii?Q?XhNGK/xxNEJ1rm7LKqavWVFruzZClAQkI4/H+4k4tDmAEvGGMkRijn1fTrSR?=
 =?us-ascii?Q?SUGREwmeAJMT4AuX3UHPZooVl+X+EpIHrOYD5KhN2jw59sYr9ZFLjmcSYNj4?=
 =?us-ascii?Q?Xgob9r0iINMXPUI6y3WrN7nNB2lk1btbLL/Fgeu0Ehp/sOsCAJcnaIKkjdCh?=
 =?us-ascii?Q?W36jFtFGbPOYFvnP2ub5KzXjb69+YirHFlsgLa9/7stCb3aT6TKxw9sGFLAP?=
 =?us-ascii?Q?3Gc78VdpJfobDrhH7FNr7KBJmvGmjHw7kMJhBatA3YVyZVRN6Ip3tJHwX5Fn?=
 =?us-ascii?Q?FbjC73par//BKJKkEGyRmaQBbgKLz31cBuz2oziovkjwUD0a1knYGVkelx5K?=
 =?us-ascii?Q?GcZDxuo81GwNPtLpY44GgviHvYK+ogVxCUryzK8pIt/l4UkGz6scL1EuVabQ?=
 =?us-ascii?Q?qvFjxC/Y9gFeBpEPVM6KFuF/KCFytyhTVhjvjomj8F4idU4+CAMGwawLQVV/?=
 =?us-ascii?Q?6aeVgkUAilihUuGCkQXp7+ZVfYK+9bpeb96qpn5Ir5zAzHnx1/9H/BbuTE6M?=
 =?us-ascii?Q?2fyppqz3FnKpI+vpiCk1HsT9fWluaT+ImFafGOYPWZqp2gim1Fkyg/Aez2OF?=
 =?us-ascii?Q?lAw1hHDnM1OdIUNek5UG5/aswydZmtXtt0lMGqf1g3ULuVWsGqISOFdd/YyI?=
 =?us-ascii?Q?ZOINmLvVX2xfm0YgAwb5V7T99eX1ujnyiOXplImpcgzOJsyzWTB9kShvI4d0?=
 =?us-ascii?Q?4Twk9r5slMivj+rLbqO8k+BFxyh2NfCseVknzTvzyMQpeOdOR9jX0RBnlExP?=
 =?us-ascii?Q?LIoqwW4fYh1pYClhozsI7sBT4gLctpuERHne2ndaxe4jNgttyEhetg0/TzFr?=
 =?us-ascii?Q?w5t1AgkRMCb+fhLv5VhzHkwITH1Y37VSKssT37T/1KBVZFpfxM8uWdhlDL4M?=
 =?us-ascii?Q?CUyIugJSn0oWf5TLiK5zcjkkIYJEWTcHgmKkSB395u5uXLMgDD5xkg8Q4HRc?=
 =?us-ascii?Q?lqCzGHLnb8xSwK+e7iuQpczZXN2XRPCWa2Rum1fazLFLzi9aTVktojVzFdEe?=
 =?us-ascii?Q?QDZIVh+fLrJJS/MvXUb5lOW4w3nEKZBTawN2mBbCL3nU/g8TrttaqJm3qrHp?=
 =?us-ascii?Q?wRlMRAnK7F4ldqCfDt1q2uWlTW4xBycO5HcfHlU/19U9urqjz30HG/YYS08E?=
 =?us-ascii?Q?YBn+p3d4Z0/J9RRW03SARAaSWH1mieKfpB0IASkNJbs4g6tsAyUB5Z2R5TkC?=
 =?us-ascii?Q?8b0pO+vOjpYDuMNJsjJZtuQSLKhcLn8GHmmis2caJU032cerXKcGic9e4AkW?=
 =?us-ascii?Q?Zrja2Y2+dZGTze8xzLpvDlb7bnio7B4Nqp7pxRbEmp7Mv3yMOCouexL2MTBs?=
 =?us-ascii?Q?M2MNED+kpy1HHe6xaMRA9blXJVT8l46L3dUiiABTdCn1Zp3pcFqNM6l8rqK0?=
 =?us-ascii?Q?EPpm+l+CQRillz44Mj1Ze01Y/XvDaqPnHzeBPBViIHiwIt3s4mObMMOfepai?=
 =?us-ascii?Q?r6v/qXj+/7IdnZvYNc3bbxuc/l2QlOGNtZ9xYxOj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ad3df-e218-43ba-bb7e-08dbf858cc1d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 01:47:27.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax5QQCwKo6nOeSKMvuFmmRshbt3lyYkgVw+xce9hE2bbYuwNZbIJh0BeCvTn+sgs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:

> Take Intel VT-d as an example, the stage-1 translation table is I/O page
> table. As the below diagram shows, guest I/O page table pointer in GPA
> (guest physical address) is passed to host and be used to perform the stage-1
> address translation. Along with it, modifications to present mappings in the
> guest I/O page table should be followed with an IOTLB invalidation.

I've been looking at what the three HW's need for invalidation, it is
a bit messy.. Here is my thinking. Please let me know if I got it right

What is the starting point of the guest memory walks:
 Intel: Single Scalable Mode PASID table entry indexed by a RID & PASID
 AMD: GCR3 table (a table of PASIDs) indexed by RID
 ARM: CD table (a table of PASIDs) indexed by RID

What key does the physical HW use for invalidation:
 Intel: Domain-ID (stored in hypervisor, per PASID), PASID
 AMD: Domain-ID (stored in hypervisor, per RID), PASID
 ARM: VMID (stored in hypervisor, per RID), ASID (stored in guest)

Why key does the VM use for invalidation:
 Intel: vDomain-ID (per PASID), PASID
 AMD: vDomain-ID (per RID), PASID
 ARM: ASID

What is in a Nested domain:
 Intel: A single IO page table refereed to by a PASID entry
        Each vDomain-ID,PASID allocates a unique nesting domain
 AMD: A GCR3 table pointer
      Nesting domains are created for every unique GCR3 pointer.
      vDomain-ID can possibly refer to multiple Nesting domains :(
 ARM: A CD table pointer
      Nesting domains are created for every unique CD table top pointer.

How does the hypervisor compute it's cache tag:
 Intel: Each time a nesting domain is attached to a (RID,PASID) the
        hypervisor driver will try to find a (DID,PASID) that is
	already used by this domain, or allocate a new DID.
 AMD: When creating the Nesting Domain the vDomain-ID should be passed
      in. The hypervisor driver will allocate a unique pDomain-ID for
      each vDomain-ID (hand wave). Several Nesting Domains will share
      the same p/vDomain-ID.
 ARM: The VMID is uniquely assigned to the Nesting Parent when it
      is allocated, in some configurations it has to be shared with
      KVM's VMID so allocating the Nesting Parent will require a KVM FD.

Will ATC be forwarded or synthesized:
 Intel: The (vDomain-ID,PASID) is a unique nesting domain so
        the hypervisor knows exactly which RIDs this nesting domain is
	linked to and can generate an ATC invalidation. Plan is to
	supress/discard the ATC invalidations from the VM and generate
	them in the hypervisor.
 AMD: (vDomain-ID,PASID) is ambiguous, it can refer to multiple GCR3
      tables. We know which maximal set of RIDs it represents, but not
      the actual set. I expect AMD will forward the ATC invalidation
      to avoid over invalidation.
 ARM: ASID is ambiguous. We have no idea which Nesting Domain/CD table
      the ASID is contained in. ARM must forward the ATC invalidation
      from the guest.

What iommufd object should receive the IOTLB invalidation command list:
 Intel: The Nesting domain. The command list has to be broken up per
        (vDomain-ID,PASID) and that batch delivered to the single
	nesting domain. Kernel ignores vDomain-ID/PASID and just
	invalidates whatever the nesting domain is actually attached to
 AMD: Any Nesting Domain in the vDomain-ID group. The command list has
      to be broken up per (vDomain-ID). Kernel replaces
      vDomain-ID with pDomain-ID from the nesting domain and executes
      the invalidation.
 ARM: The Nesting Parent domain. Kernel forces the VMID from the
      Nesting Parent and executes the invalidation.

In all cases the VM issues an ATC invalidation with (vRID, PASID) as
the tag. The VMM must translate vRID -> dev_id -> pRID

For a pure SW flow the vRID can be mapped to the dev_id and the ATC
invalidation delivered to the device object (eg IOMMUFD_DEV_INVALIDATE)

Finally, we have the HW driven invalidation DMA queues that can be
directly assigned to the guest. AMD and SMMUv3+vCMDQ support this. In
this case the HW is directly processing invalidation commands without
a hypervisor trap.

To make this work the iommu needs to be programmed with:
 AMD: A vDomain-ID -> pDomain-ID table
      A vRID -> pRID table
      This is all bound to some "virtual function"
 ARM: A vRID -> pRID table
      The vCMDQ is bound to a VM_ID, so to the Nesting Parent

For AMD, as above, I suggest the vDomain-ID be passed when creating
the nesting domain.

The AMD "virtual function".. It is probably best to create a new iommufd
object for this and it can be passed in to a few places

The vRID->pRID table should be some mostly common
IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. AMD will need to pass in the virtual
function ID and ARM will need to pass in the Nesting Parent ID.

For the HW path some function will create the command queue and
DMA/mmap it. Taking in the virtual function/nesting parent as the
handle to associate it with.

For a SW path:
 AMD: All invalidations can be delivered to the virtual function
      and the kernel can use the vDomainID/vRID tables to translate
      them fully
 ARM: All invalidations can be delivered to the nesting parent

In many ways the nesting parent/virtual function are very similar
things. Perhaps ARM should also create a virtual function object which
is just welded to the nesting parent for API consistency.

So.. In short.. Invalidation is a PITA. The idea is the same but
annoying little details interfere with actually having a compltely
common API here. IMHO the uAPI in this series is fine. It will support
Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
setup to allow that the target domain object can be any HWPT.

ARM will be able to do IOTLB invalidation using this API.

IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
(and just force the stream ID, userspace must direct the vRID to the
correct dev_id).

Then in yet another series we can tackle the entire "virtual function"
vRID/pRID translation stuff when the mmapable queue thing is
introduced.

Thus next steps:
 - Respin this and lets focus on Intel only (this will be tough for
   the holidays, but if it is available I will try)
 - Get an ARM patch that just does IOTLB invalidation and add it to my
   part 3
 - Start working on IOMMUFD_DEV_INVALIDATE along with an ARM
   implementation of it
 - Reorganize the AMD RFC broadly along these lines and lets see it
   freshened up in the next months as well. I would like to see the
   AMD support structured to implement the SW paths in first steps and
   later add in the "virtual function" acceleration stuff. The latter
   is going to be complex.
 
Jason

