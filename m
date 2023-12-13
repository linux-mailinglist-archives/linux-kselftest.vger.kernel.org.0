Return-Path: <linux-kselftest+bounces-1861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34860811F82
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1971D1C209E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098E7D8A7;
	Wed, 13 Dec 2023 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oe2AIAnT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659D19A7;
	Wed, 13 Dec 2023 11:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1Z+8RiXtXZWaudsHokVoIBm1Cuj9/GGczVDXsdWa6S0gpGHcOmdj2VnCehFmg/Y4EsopYfKTYoh3Crli26dy8ak/Gq1ofBRd9P1peQxOncyMMHpoGd0+QMKhFUeUlOeguCXuS1aOhr7iq0h+wSPyGO+wyCiQvuyAJXLJqP2jCnYkM6tZv4KMCYInKWaw1j5YmNNmYBgI6ABkuHIKO30oKHQREGuhtCMo4Gl8z45snCU5oJ36RpJxx6hcF2IfD8h/nediPuRaezIaWLWxLQCTkrxH4vwHbA2cZLA+0Ne3RIn5XWToTQTTpBsHpop3CGHCpieg7I7oEBMup7QurazXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKUcmJlezdzVRlWijeebQQqbeIEOYwdh6FBYCTEmMx0=;
 b=ItjkDG9uFnHS+cPet40VNkv0YBoU8ftQoXxarF3wAC703G/mgacYE75wGiDCKaR5wBUtLVkZG8t8meDr+RNvE8hEYMHr3fLmi025Rf28XZZ0ofghiiVnN8h75J3XA6UC6/X9B07GBONYhqyZCCyXeSsKdMl5NXgo7hIEwOUx2vtDeBLyilbde0tAkVRpYrvNaJDKPSIvYrPvWnTTbE2MnsTq5WO1/pjXXCvef7bUuNrPQMX2G8nD0BOluoo9HMn2RNLqspra4SiViV0rNglJfuDMaIw0qF+b91JIB3L8DAakEvlQNEmS5//s7ofM60Hl2NRh6s4vM0tRe0NQ0KA6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKUcmJlezdzVRlWijeebQQqbeIEOYwdh6FBYCTEmMx0=;
 b=Oe2AIAnT9g225jHNCaWyAH7yYdXl23JSsevDFhJ+KZQur5i7JFVIH0/2MXcBDM1RBzcWObPPkCkrs9wh3K3ruVylqB9TZKLv3nx4BhsWaNu5FLdFgM3davpHPtKUGa41VG/f7RyNwhldsinBmWmLhN5f2T5hv2+S/DmN8Sa/VLUoNkVgww3amGerc7d43CscPpner/XB+QamyknBkpNvCe38Kz0LDz8nHr6ggbK7VotazbgRhgqNedIKqohun1ZLeL1iYn+3lfWHiYy9UE1fjtzAbkGqgh6aXBG946WPEUxE/if9n2r8rQaiUuAVxFkG4TLhM4lVTbmMoL+ozu2J+g==
Received: from CY5PR15CA0154.namprd15.prod.outlook.com (2603:10b6:930:67::21)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:54:33 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::26) by CY5PR15CA0154.outlook.office365.com
 (2603:10b6:930:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 19:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 19:54:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 11:54:18 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 11:54:18 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 11:54:16 -0800
Date: Wed, 13 Dec 2023 11:54:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>, <xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <ZXoL56s1EIchNRzD@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
 <20231212144421.GH3014157@nvidia.com>
 <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
 <20231212192100.GP3014157@nvidia.com>
 <ZXi9FaPSkHkCm679@Asurada-Nvidia>
 <20231213124055.GR3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213124055.GR3014157@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ec181f-7a33-459b-3d50-08dbfc1553f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aCKM+BZ8czRNrqvy2P2p580kSnjmIacgrQk6VpXLlCwqXu+EQH0JDX1QsIDkUT8P/x0gXSL0wjtNQdkYIeB4Ub9GsbG1c8pm1rZZ10wMvuxZpkcvysllfQb5wVKXozWZdw7ISCurzgNa2JXXcKBd3OsbdMgBj1ufhSobdBGaXKYS/aMuNfT/HstBQQiqsan0ehO56lrjgSoEs6of6TDNe/xtepH4zR6XLuOVsP1Sucg08XQQc6IJ2/DkCpnmkRsOeMXnrOP2ITWQEx5f7Gs6YFMF4q5UwXWfJUD9ed/IPOS4/CFaVdb5YZwknIs/h5yMc7n5URq7OaAKSqJjEq950vfj+h6JIiEIEePXFpyyoXLIyxwFNeLHVEwMJ3g+BGe8ywNxFwmYiyun3G0o3CoNgSOE25at+mkIyXqWZWZXiT9G/USQ2HWDHRphZMsTPXEbDx7o1L/RaA+YsyonEy8pg43qKes4dqrNw6EL4lWl/5adiIfoIEP7rnpAOIWf+TaAVInu/oGINJ7YDXLdPngcrtIhV5G15QX8ax3/Z0IwLOLXBpLxnDBZG4rFhecnvwv53ooylI/Gqsw1Q7jXdhfUsf4m9mxyom4DCIyYJgrdSYd4RANWIQGd5tUgmY0iqK1s4lRlLgCdmRIL7TAXO0CNwkQAnW7pC+Um/C9WzgJziJvj8zng5sAgTb60zIJ85xWnU2USnJYYoPG67hdwKRfL48kO/0KGym0VvR5MHH7EfLYSRL2a2HyG4PXEq6zokrlm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(26005)(336012)(426003)(9686003)(36860700001)(47076005)(83380400001)(8676002)(5660300002)(4326008)(7416002)(6862004)(8936002)(33716001)(41300700001)(2906002)(478600001)(316002)(6636002)(54906003)(70586007)(70206006)(82740400003)(86362001)(7636003)(356005)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:54:33.4810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ec181f-7a33-459b-3d50-08dbfc1553f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754

On Wed, Dec 13, 2023 at 08:40:55AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 12:05:41PM -0800, Nicolin Chen wrote:
> > > > // iommufd_private.h
> > > > 
> > > > enum iommufd_object_type {
> > > > 	...
> > > > +	IOMMUFD_OBJ_VIOMMU,
> > > > 	...
> > > > };
> > > > 
> > > > +struct iommufd_viommu {
> > > > +	struct iommufd_object obj;
> > > > +	struct iommufd_hwpt_paging *hwpt;
> > > > +	struct xarray devices;
> > > > +};
> > > > 
> > > > struct iommufd_hwpt_paging hwpt {
> > > > 	...
> > > > +	struct list_head viommu_list;
> > > > 	...
> > > > };
> > > 
> > > I'd probably first try to go backwards and link the hwpt to the
> > > viommu.
> > 
> > I think a VM should have only one hwpt_paging object while one
> > or more viommu objects, so we could do only viommu->hwpt_paging
> > and hwpt_paging->viommu_list. How to go backwards?
> 
> That is probably how things would work but I don't know if it makes
> sense to enforce it in the kernel logic..
> 
> Point the S2 to a list of viommu objects it is linked to

Hmm, isn't that hwpt_paging->viommu_list already?

> > > The second version maybe we have the xarray, or maybe we just push the
> > > xarray to the eventual viommu series.
> > 
> > I think that I still don't get the purpose of the xarray here.
> > It was needed previously because a cache invalidate per hwpt
> > doesn't know which device. Now IOMMUFD_DEV_INVALIDATE knows.
> > 
> > Maybe it's related to that narrative "logically we could have
> > multiple mappings per iommufd" that you mentioned above. Mind
> > elaborating a bit?
> > 
> > In my mind, viommu is allocated by VMM per piommu, by detecting
> > the piommu_id via hw_info. In that case, viommu can only have
> > one unique device list. If IOMMUFD_DEV_INVALIDATE passes in the
> > dev_id, we don't really need a mapping of vRID-pRID in a multi-
> > viommu case either? In another word, VMM already has a mapping
> > from vRID to dev_id, so it could call the DEV_INVALIDATE ioctl
> > in the first place?
> 
> The xarray exists to optimize the invalidation flow.
> 
> For SW you can imagine issuing an invalidation against the viommu
> itself and *all* commands, be they ASID or ATC invalidations can be
> processed in one shot. The xarray allows converting the vSID to pSID
> to process ATC invalidations, and the viommu object forces a single
> VMID to handle the ATC invalidations. If we want to do this, I don't
> know.

I drafted some patches with IOMMUFD_DEV_INVALIDATE yesterday,
and realized the same problem that you pointed out here: how
VMM should handle a group of commands interlaced with ASID and
ATC commands. If VMM dispatches commands into two groups, the
executions of the commands will be in a different order than
what the guest kernel issued in. This might be bitter if there
is an error occurring in the middle of command executions, in
which case some later invalidations are done successfully but
the CONS index would have to stop at a command prior.

And even if there are only ATC invalidations in a guest queue,
there's no guarantee that all commands are for the same dev_id,
i.e. ATC invalidations themselves would be dispatched into more
groups and separate IOMMUFD_DEV_INVALIDATE calls.

With the xarray, perhaps we could provide a viommu_id in data
structure of the current iommu_hwpt_invalidate, i.e. reshaping
the existing invalidate uAPI per viommu, so it can be reused by
ATC invalidations too instead of adding IOMMUFD_DEV_INVALIDATE?
Then we wouldn't have the out-of-order execution problem above.

> For HW, the xarray holds the vSID to pSID mapping that must be
> programmed into the HW operating the dedicated invalidation queue.

Ah, right! VCMDQ at least needs that.

Thanks
Nicolin

