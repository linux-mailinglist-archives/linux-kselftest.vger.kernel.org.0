Return-Path: <linux-kselftest+bounces-1590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6A80D45B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EED1F219FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8C4E633;
	Mon, 11 Dec 2023 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMA7JVCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB989B;
	Mon, 11 Dec 2023 09:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqbJ5SHEWfSlDL/kYi3F7eGjFWpRTC/i+WVDF4UD0bxuBzNv5q948Qq8xFWtTsNESq5XaZjEK8bXg41u1EzRsRe1/69TOEz/14qnVQiofVm0mqQ5pMCRNHztxD9y9d41dKKojvu2oWob9/J5vj640rBMkWkNTQWiT7mT/+QEJYDR7nL9wN+Z2xUAmFoCe2NlRLCrC3vU8WgwR7wZpGPvHChDwLne0+0sggbCnviiRKPXUZRzYfMVj/5bhIlQuM9bsNLRaK17ur5N27tMosNBxCm8+120E7pmpDlKvzXmGBXKZqwwfQr6/hEkWwo1Qam0kfhTba0g2rY3EjrwPeM8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f2F6AnF+pqrefN721qYQbHcq0KJowVHF/bg9h+ti90=;
 b=LCPOTjOmGU9lNnbDTWt115USqtdR9shd9EPcsKq1fQCYQm6CwozreTtI8zUT6PX5ul1E7qEPada6JUSpChM/rCAqitnFPEABRbWwoiWfZttli122Bhuo0M4O3NCcQIZQ7eG4Nyn/m3ZXu9+v9vP1jQfim2Mt9IhcWj06XTnRe6sI5o/179xgFMqfPf9ZhO6s7OmVnwpCgIXQYVdhwr4MT4GN1f7yM/mcrhbmBuhpJm2R3CiYWZ6femHKrH8YHhz3LqnVgOWtvE2k2FrmYitn6c8MYa0U1ACRaOhJuqJTj1bxUZNfHNORWIAxfQ4baWvsJidlhKEgq9Xj6YgjWcO1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f2F6AnF+pqrefN721qYQbHcq0KJowVHF/bg9h+ti90=;
 b=MMA7JVCmEodkLnATrcd6Z1td58jyIbG7yRMo8h0a9HnulXwaw0dWYma6dOfGKl3gFiLeZA3arqHr4PcOqfNGRdKP9rfipoYk+7jSdxArik731kOcgFUoKjIAT65kE6CcIHsGmG4v4X4vB0vFZDbFlPfvbqterpXLS2bf+MGGOsXd+DjcL+KA+vadqNPMhJdst0DjtVTkbizx0mG3D5tM0/+Yax4oTKDjM0YGZnoJryrIEjqWK+lxqOHhzh4vQCErNC/4UDSUjDJ1I4ZQoYLnlqraT3H6w/sYtyuOyux+FVLWfRBM/PrVnENOciQj1ewtOspNA9U0yE4mU0kTZKSO9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:45:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:45:59 +0000
Date: Mon, 11 Dec 2023 13:45:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
	alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211174558.GJ2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <391ab316-79b1-4535-a45b-4c01bfb80de6@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391ab316-79b1-4535-a45b-4c01bfb80de6@amd.com>
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 66990eab-b3c7-4099-20c0-08dbfa7108fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsI0i7Qs4G8o3UO3LOHgrH36RXSp2L5gls51yYhaIBOA1NV+QGrJcSCMLC/KAsjGIbOUXyPjUqDeFQMKiBSjHvEi8tx+CQamACi37lf3jdpISda0nNCx/F6pTKgPCb9bkWWKu7vEKwWQnjqL6N2rspUrha+2dryXQoN5aE3JVZN4UGzFmdddzsi4MBb40DAYhIhifNPDy7yEFpmqH0GE8qJ/EsYeW0YpJPLwR/5bND+xD7PBXCQ3LuI7we23L5IbWMIMaXS4xYJl8RZBL9mGeozvPRFBxO8wMWsDzQ/v5poCdlS7y+dtDhtjWOwl+SYNjZNAAl5cMwS3tyHepvDgx7rrmNtx1gVlBv5aU6FK+UrCznCJzUmKQbYUccIWu2Gh1vAy9lAlBjF2e9Dmu4mZFUTOlN7hropevDvIckGbz6HDnArYYTT2OEhOEWsJB38vVLbt+1hTg9twdLyL70VsGmAy0+9Ge4mDnUR+mUEboV2feLIcYzQdrBgW/p0JMIGDt98om08x1qneZDwRI+HZSDrT2mT2447fUHKMIwnlM9kCFK2HiOj+fMEifMOoXdR8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(1076003)(26005)(2616005)(6506007)(6512007)(53546011)(83380400001)(5660300002)(7416002)(4326008)(2906002)(41300700001)(478600001)(8676002)(8936002)(66946007)(316002)(66556008)(6486002)(66476007)(54906003)(6916009)(33656002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k68UooqVGSzSNqwGmfnSVtS94KwPNHYejut/KZIpQ3w35WajJ2Epqa1Uj+uw?=
 =?us-ascii?Q?yE9wQfG4VnJ8XbixmA+0bboev2OQ1dp6SkcvnpDAJGlNU6DEZqda2RMi7o86?=
 =?us-ascii?Q?6C+Gu3RBbprC3D6WFEQNTDbn6izW7mQUnghwdhe4JKmFYDuYDrVV2Zz1REOE?=
 =?us-ascii?Q?YXolH63286aCCBOl6H7pPlO6K9cuFSpHko+nA/xxpw4VlJJmS1LGUMCUaolj?=
 =?us-ascii?Q?x9JMI20FjK+2+9wkPcn3cRmX+6Og6l/RefmYKW6NtHsm70hkWllQs6Qg5LPW?=
 =?us-ascii?Q?8IDq3F23h3RTz710aktTIYaSuXiPN2+2xOnP9/tciPDuOrVEZsJXZhS9Ze8/?=
 =?us-ascii?Q?s+nUXEZGT2GhBBSXOoR1qB90iTRQVHnTihbJd0MbQK+7TTrQom7l618i3fOt?=
 =?us-ascii?Q?V7lFjwWJRZ6NPJtvUlv8/2QBicR2dqHp3kVUD3bJA0aQMQsJvXolx50UG+jk?=
 =?us-ascii?Q?2imWGiPOUx4hte0f6phtzb3mTc4t8Mtc1ibgNnghSxkGr2Qc0kEOAjHnr0qb?=
 =?us-ascii?Q?FHubkFJiXQUOKjXVZn8vF2OxIsbiyb4FLDxZMoXm1JsyBiV2MddFekl/eB27?=
 =?us-ascii?Q?HdPojxICsaehY6wRn96mbUtz61PU+3v9ziqwTI7wRB2/kwzuas0DjlOPox7A?=
 =?us-ascii?Q?GfflE8msM/XLEgSdqjNFFWXQzMrZSEDb0d1JC43E0c6E8bnVkSN2B5MMe9vN?=
 =?us-ascii?Q?gV4IOrrURh18lDcvN9lj9CNWR0KiJWUUaXD6ctXYZtb1wzjGse38q+diuUUE?=
 =?us-ascii?Q?xLkopY1JVvLr5xPLrhSg2Meg0u/x9reA9uBRIpvcQI11I0H+tBL2NuOvrT8a?=
 =?us-ascii?Q?2rBfdD/2bouaul3t0YgoWTca/xyUCUajIX9Qy9Evj9cyA8CE/r/VGy8h6JST?=
 =?us-ascii?Q?MRvOLNPSypu/Vdg/d15zdq1FBjCuJFq7cBsX1D0N3NTQk0+3B5CALOeXaIyG?=
 =?us-ascii?Q?ZQJRzJdHuwhSjMSFX981AaWtbAfiC/N4a8UgSRux4O7niA8mEwAjKKSjCRQ7?=
 =?us-ascii?Q?KuBOYVVPa8ioVDbZtXdw4EOipYVI+i4ECz0BuOUfX0ZZz5yW94DkYMnYF4IT?=
 =?us-ascii?Q?8HvILNKvUFGGEJFTqmhFOCzveJclu3mBX+gVgFWIPMeax6ZPHf4UPNZ9/py4?=
 =?us-ascii?Q?Acxz7A1fjPyUdm+QFDrOLMcIn/YuqqKS2NrWj/HOiePwiHwjBzdbJmHlkjgP?=
 =?us-ascii?Q?LNfo01mcLURFqpbmJIPFNkbtUeZuANUH0YepDeP5Ntb4A/RrNCKVrCPI65DV?=
 =?us-ascii?Q?Qss6p98hGMRs45reQL7sclPWq371r+1NJV6iRQEaxHnJibKsWRYRfC+rXR7J?=
 =?us-ascii?Q?FbIeNopNk3aQPnA9O35EU9+rbZZ07eKDh38OjVTzp/XZQ+EvNW2GfBC6FITr?=
 =?us-ascii?Q?rtC2OYvAKdf4d+YEiUA24A7sY7GTy+dbOHbsokFi8V8hTJDcQ2ZU2IoH262s?=
 =?us-ascii?Q?IKVUZ6RIIGzbhXRXebFQl0UkcZaJjorTvW5sA9VSkC4oOOvt5rzrByim3haV?=
 =?us-ascii?Q?r/aLkKJz4JjaFRyzcZ2pjDbCL/jyyUMjDHPhVnYjVu8v9S6QeoAX4XY8Kpp3?=
 =?us-ascii?Q?Z2X4y0PRp6wWqIWdddh/8vf2E2YhYDvaFgT2ePEA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66990eab-b3c7-4099-20c0-08dbfa7108fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:45:59.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BisBPJB/rkQz/DQEnbsHNKIEm3Dcl81LCyD6mpX65Fjs43RO74CSG4DqZi5TDRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Tue, Dec 12, 2023 at 12:35:26AM +0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 12/9/2023 8:47 AM, Jason Gunthorpe wrote:
> > On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
> > 
> > > Take Intel VT-d as an example, the stage-1 translation table is I/O page
> > > table. As the below diagram shows, guest I/O page table pointer in GPA
> > > (guest physical address) is passed to host and be used to perform the stage-1
> > > address translation. Along with it, modifications to present mappings in the
> > > guest I/O page table should be followed with an IOTLB invalidation.
> > 
> > I've been looking at what the three HW's need for invalidation, it is
> > a bit messy.. Here is my thinking. Please let me know if I got it right
> > 
> > What is the starting point of the guest memory walks:
> >   Intel: Single Scalable Mode PASID table entry indexed by a RID & PASID
> >   AMD: GCR3 table (a table of PASIDs) indexed by RID
> 
> GCR3 table is indexed by PASID.
> Device Table (DTE) is indexted by DeviceID (RID)

Yes, this is what I was trying to say


> > Will ATC be forwarded or synthesized:
> >   Intel: The (vDomain-ID,PASID) is a unique nesting domain so
> >          the hypervisor knows exactly which RIDs this nesting domain is
> > 	linked to and can generate an ATC invalidation. Plan is to
> > 	supress/discard the ATC invalidations from the VM and generate
> > 	them in the hypervisor.
> >   AMD: (vDomain-ID,PASID) is ambiguous, it can refer to multiple GCR3
> >        tables. We know which maximal set of RIDs it represents, but not
> >        the actual set. I expect AMD will forward the ATC invalidation
> >        to avoid over invalidation.
> 
> Not sure I understand your description here.
> 
> For the AMD IOMMU INVALIDE_IOMMU_PAGES (i.e. invalidate the IOMMU TLB), the
> hypervisor needs to map gDomainId->hDomainId and issue the command on behalf
> of the VM along with the PASID and GVA (or GVA range) provided by the guest.

Yes, that is the "forwarding" approach. Contrast this to the Intel
approach where the ATC is synthesized by the kernel emulating the
INVALIDE_IOMMU_PAGES

> > To make this work the iommu needs to be programmed with:
> >   AMD: A vDomain-ID -> pDomain-ID table
> >        A vRID -> pRID table
> >        This is all bound to some "virtual function"
> 
> By "virtual function", I assume you are referring to the AMD vIOMMU instance
> in the guest?

Yes, but it is not in the guest, it has to be some concrete iommufd
object.

> Something like IOMMUFD_OBJ_VIOMMU? Then operation would include something
> like:
>   * Init
>   * Destroy
>   * ...

Yes, something like that. It needs to be able to work for ARM vCMDQ
stuff too. I don't know what the name should be. Maybe viommu is OK
for now.

- Alloc viommu (against a single iommu instance?)
- Assign a virtual ID to an iommufd device within the same instance
- Setup a submission and completion queue in userspace memory
- mmap the doorbell page (both need this?)
- Route back completion interrupts via eventfd

When you get here you and Nicolin should work out something along
those lines that works for both

But I'd like to keep things in steps, so if we can get info, nesting
parent, nesting domain and SW IOTLB and ATC invalidation as the first
(two?) steps that would be great

> > Thus next steps:
> >   - Respin this and lets focus on Intel only (this will be tough for
> >     the holidays, but if it is available I will try)
> >   - Get an ARM patch that just does IOTLB invalidation and add it to my
> >     part 3
> >   - Start working on IOMMUFD_DEV_INVALIDATE along with an ARM
> >     implementation of it
> >   - Reorganize the AMD RFC broadly along these lines and lets see it
> >     freshened up in the next months as well. I would like to see the
> >     AMD support structured to implement the SW paths in first steps and
> >     later add in the "virtual function" acceleration stuff. The latter
> >     is going to be complex.
> 
> Working on refining the part 1 to add HW info reporting and nested
> translation (minus the invalidation stuff). Should be sending out soon.

Nice!

Jason

