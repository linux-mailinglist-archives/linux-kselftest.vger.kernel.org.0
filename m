Return-Path: <linux-kselftest+bounces-1625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5780DDA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FF61F21C0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912725576D;
	Mon, 11 Dec 2023 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tuDuU0lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E080C2
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 13:57:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmaDRhr86SIr96p5Ra4bzviZtM4XP3jCwOR2bXUfaMe4NX6VECTMmmN2RB26C5BPVs4KmdamNSgvOd5QVOYZUWKQMRkNN+unGOWPulAQ3xKdAAPJGspLXf5CLjkRotr46o8H7+IOe+ClbdaZ8BCbxFBLdFNWimKFnAq4oYbRgGH4NswcPQ7d6y6g2RJzorCabXvrdavWQVGt9F/39Llgq7jFzZVLT3KIeh/EPWxt+IBd9Hu8xIvOxlq6mzR82pzKk6EX3JWLpuxTSgpZadxVZrbJ6OvK8RQMb/NwrgM1bMHgz2bSQOTzmdUX6i3j4mjIi05M3ZwjQ4Y5p6hj33/giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlL5eLRoUdedfh821ze9eHzie1om8tI74i+byygAh0o=;
 b=YLLiUjcbUyHcTbgwVnuOxvwl435Em/Nqpd2grqOyeTwaWJVxhhPxyMjp1/wQ01phf1/e0+K3sQz4qeulDuz9No/yIlN0cT0N/8/pLWVNimBEvlDUBrz8kb8uvjc9IteDrL1aj0tru2uboEY/f5q7oKTUzrmlQDFA03hj3KDb53uc4DVmduZe5EI5nZtY0QTf0qM85RGnKR/M3isYvQmvStY6mRclOzQ+DQ7dFj0+pIp5LtGlf3RiwDd+1/o2vgiXnqiYv6kQVArYIeHxqAAUrsfoY1HIV/uvvTCMegjJl83n1qHFJybOiEM1VhJym3ba23Fvqw2jWjl3Id0sOMdAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlL5eLRoUdedfh821ze9eHzie1om8tI74i+byygAh0o=;
 b=tuDuU0ltKXqgJTgbvXpwikMGo2FX0tp11Ir7EaGg0TEde+B9ywlfjVD4fP07YAOF5axrBkpqjIdjO2SgiwLH1qpHZn/1HpIXSAJMq8CN3x4tRaSTDcAFliZZ9w4kzfiiugS6jbJ1V8B/GEO1JAePNYm90wJO7YDdFJEaxAVkvP1eOPNNtJutxdokAZ7me9P7Mavp3bwJaCTzd8rh7IfbttgcGe8KHkt75KtXCNAurwKCt3bBlfeCr9gwY0pGa0adyoMBLPM0N3yC8v4dPhmaykk8+8KrP8c/+7MSZjEcT/sqo47CHfOBwyd4Fhu9YHS8Is+Pe2RorIGSnYKPT/zhgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:57:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:57:39 +0000
Date: Mon, 11 Dec 2023 17:57:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211215738.GB3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: f1db9526-3083-47b9-554c-08dbfa943177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ng2wsh3zm5+yNFhU+/lJm6RkCyN8sCoQHBPqpzxY6o47K+mUH0p/cZk78A99s4lOznVEyIHuM8HWHw1X4+f9dKDN23zDz0CODHD0qWfuIiZuCei+1fJfMUywZ9Kb5qYnMMT0IM1A7/3xgwIUfGhXuA9+JeEXUmPxKbBIZ8BzvseKvOFl/f8uhW5W/8NRhs5y4HYWs3AeIvStZTG9MHgu1Klkyj+mLBCJxo4RXl5/aqzDtw13P5zhvi+29rWKPVDRQlUE15HfDYVxv1HqquAKpMBYPrNIHT85oPa7EwWzLzY6Dv5u8r+3TBfdkdjz2RXzDNaUQTIvk4msgkkpUw90wfU7KiswSILmMvx3XHyThjrQOPdBdi1H+dYwmjUkQQ0L18T2Y7CkR2FqOsolXrSmHe2mOXQDFHFzPmBeCxso7OANXT8FU9Xkogz0X9+ZEDwDYrRBRGE7AqLtG7TFzDSPYFAbPc9V6i4WOuXt/AFrvKpMJa3s4pXnRIOFU6mu16+91dqCs86yiPD71g04rgjG2cMaVk8pi9YnLa12zEECY4J+lMgZfOpQelMpQdJ5slAP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(26005)(2616005)(1076003)(478600001)(6512007)(6506007)(83380400001)(5660300002)(41300700001)(54906003)(66946007)(2906002)(6636002)(66476007)(6862004)(37006003)(316002)(8676002)(66556008)(8936002)(4326008)(38100700002)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNbgYY5g9/GcQC5m5n0/xs0TVk3IcNYVdRb7l5IicaAvU2EZNW7y8MONxTl5?=
 =?us-ascii?Q?KHFIH5iEM7dtEeHoCKbhEwiHbwVZCPMUBtH6ZigXqIn3kAO0puzINPxF8YuJ?=
 =?us-ascii?Q?ZncIB1wObtHA74df2eoEMz4Qrk6I5UbF9Yzit1vJsWCJfgei+wu+KDyIt24f?=
 =?us-ascii?Q?Getnq/VqBEpgeP/DQjZMcHiBQz3x2aCJlCOMHRqUNP/cDdgBKqkR6lZI/Ar5?=
 =?us-ascii?Q?YzEFtIqXKRYKd7Ebje+A06TYjfi08FfqtHBiHGX77rQ7x+ec3XoBifRIICIk?=
 =?us-ascii?Q?oZGRH5Izv2dHm0wpko449kKDgVdRYlHAniuh3v11WlCYYAzbFN5luV0Su8k1?=
 =?us-ascii?Q?e/tiDWNw41dqMntbwgYnKDHDm79uCMhcR3bUlo3rZO9k8tYMGczgSjmNzKoK?=
 =?us-ascii?Q?L0nOKAB3ZmLDVyxkL68/JiSe8AXGTUtTbFnIOjK5AM73iO5MOVcHWY7Yshbj?=
 =?us-ascii?Q?b5jSvFwu9dqHSDoxVubTKGU+gi8hLLf6Z1m5uNCDDHuo5jiBFOjFWda0/qFO?=
 =?us-ascii?Q?DGMZiEccZ81fmkqmjj87ZRM6yW/wAIrFk/LHaXEIi5AwTE0yVavUUvjO5sj9?=
 =?us-ascii?Q?Fv8yrqT4Wi+65ABr59YeGXa8/f2SnMK+IG4nGs2yjXSePPhCvYJmFCpQsfBS?=
 =?us-ascii?Q?SzGddjsg5YX/jqPa4y9O7rc2A3MTVCK04j74fGsVXTuNVrKh4TVqLOPf7x3V?=
 =?us-ascii?Q?FEfzdVdqBDlsLO3Gm7hg+knrvEnnrq1rzF/NT4bmEfxLGAQjD3nv6D3wUQ6i?=
 =?us-ascii?Q?rbgkDsq4xGAHrr6s7joqxImWhfTExMNNF9mI5gc84XDMUzNPgKmY+yOfsSm+?=
 =?us-ascii?Q?0thaYB4Qu100wtYUSA6qxPVXMGHhZeHPzZvPHnmcEX0PjNP5n2NjOihSSh15?=
 =?us-ascii?Q?Zv5UejkOnXSmK/Jct/32cqIGrjaIVX2okTmi0sI+cmzz0WmxHZPDgLDZ8dPC?=
 =?us-ascii?Q?sgygVRPxdo7YiMFAPHRiAyJ3xSl5Tm0RS9PnUaSEGtYBes9ezPwcPnFnUdCK?=
 =?us-ascii?Q?8dSUgnHwUYtrVGmPJPVjpqT2CHXPIkHDktu5DESq3x2uDHpcNnCNSgyZc9+v?=
 =?us-ascii?Q?snNE4CD/xmAWPXYZREPFu5PmLb6vfumuAZv7j2SOOzcyFtFf2drkncgQpVb/?=
 =?us-ascii?Q?RLErqaXlfVZ1uNfsHnf1e4r5TGgrHI++Tt15E2LsrLJ50up+MhKfFciskebq?=
 =?us-ascii?Q?TgJnYy1iPYiog7tzds0Ay0ESa8o5CD4QklQUkTh5jLZzpUOX/1TPslH8P5Ib?=
 =?us-ascii?Q?fH1nO0kC42ksZLHkhJ+tRJ97JdcaYcKCwFbAK/jKNCV18Pf05BDjZ41M41qi?=
 =?us-ascii?Q?4H+/692rVnGsBqt9Ng3yVPS9YhVCE36Mmo3KLRjSGPTGDwTH9Gq3L+zjnQ+Z?=
 =?us-ascii?Q?pO92YJ7rzNJIF+PLdrHC82rGKMotzlJ3heZcDDxvUsTBfoffTd+173dqSKdb?=
 =?us-ascii?Q?nPyWJovKEJnIgNESAxlyhDuEMOAwgeqy8o55q8FjoECvfbJ+ujGP2WqkouTM?=
 =?us-ascii?Q?orvH6l/hhZraKoHgG6QxE7qpURugqaa6EoJudyb90KaBui9s19JBaH1tU7VL?=
 =?us-ascii?Q?SvKHm/jsHjqOsR5JtU8Jtw3WcOuMW3y4iiSWL8UT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1db9526-3083-47b9-554c-08dbfa943177
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:57:39.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwraKNlc+l0itg+GkiLUqTAiQxXeW1NYL4d4kbVFhMlEQemzMfGkCOIF7GwIpFSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

On Mon, Dec 11, 2023 at 01:27:49PM -0800, Nicolin Chen wrote:
> On Fri, Dec 08, 2023 at 09:47:26PM -0400, Jason Gunthorpe wrote:
> > What is in a Nested domain:
> >  ARM: A CD table pointer
> >       Nesting domains are created for every unique CD table top pointer.
> 
> I think we basically implemented in a way of syncing STE, i,e,
> vSTE.Config must be "S1 Translate" besides a CD table pointer,
> and a nested domain is freed when vSTE.Config=BYPASS even if a
> CD table pointer is present, right?

Yes, but you can also de-duplicate the nested domains based on the CD
table pointer. It is not as critical for ARM as others, but may
still be worth doing.

> > To make this work the iommu needs to be programmed with:
> >  AMD: A vDomain-ID -> pDomain-ID table
> >       A vRID -> pRID table
> >       This is all bound to some "virtual function"
> >  ARM: A vRID -> pRID table
> >       The vCMDQ is bound to a VM_ID, so to the Nesting Parent
> 
> VCMDQ also has something called "virtual interface" that holds
> a VMID and a list of CMDQ queues, which might be a bit similar
> to AMD's "virtual function".

Yeah, there must be some kind of logical grouping of HW objects to
build that kind of stuff.

> > The vRID->pRID table should be some mostly common
> > IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. AMD will need to pass in the virtual
> > function ID and ARM will need to pass in the Nesting Parent ID.
> 
> It sounds like our previous IOMMUFD_SET/UNSET_IDEV_DATA. I'm
> wondering if we need to make it exclusive to the ID assigning?
> Maybe set_idev_data could be reused for other potential cases?

No, it should be an API only for the ID
 
> If we do implement an IOMMUFD_DEV_ASSIGN_VIRTUAL_ID, do we need
> an IOMMUFD_DEV_RESIGN_VIRTUAL_ID? (or better word than resign).

I don't think so.. The vRID is basically fixed, if it needs to be
changed then the device can be destroyed (or assign can just change it)

> Could the structure just look like this?
> struct iommu_dev_assign_virtual_id {
>        __u32 size;
>        __u32 dev_id;
>        __u32 id_type;
>        __u32 id;
> };

It needs to take in the viommu_id also, and I'd make the id 64 bits
just for good luck.

> > In many ways the nesting parent/virtual function are very similar
> > things. Perhaps ARM should also create a virtual function object which
> > is just welded to the nesting parent for API consistency.
> 
> A virtual function that holds an S2 domain/iopt + a VMID? If
> this is for VCMDQ, the VMCDQ extension driver has that kinda
> object holding an S2 domain: I implemented as the extension
> function at the end of arm_smmu_finalise_s2() previously.

Not so much hold a S2, but that the VMID would be forced to be shared
amung them somehow.

> > IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> > HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> > (and just force the stream ID, userspace must direct the vRID to the
> > correct dev_id).
> 
> SMMU's CD invalidations could fall into this category too.

Yes, I forgot to look closely at the CD/GCR3 table invalidations :(
I actually can't tell how AMD invalidates any GCR3 cache, maybe
INVALIDATE_DEVTAB_ENTRY?

> > Then in yet another series we can tackle the entire "virtual function"
> > vRID/pRID translation stuff when the mmapable queue thing is
> > introduced.
> 
> VCMDQ is also a mmapable queue. I feel that there could be
> more common stuff between "virtual function" and "virtual
> interface", I'll need to take a look at AMD's stuff though.

I'm not thinking of two things right now at least..

> I previously drafted something to test it out with iommufd.
> Basically it needs the pairing of vRID/pRID in attach_dev()
> and another ioctl to mmap/config user queue(s):
> +struct iommu_hwpt_cache_config_tegra241_vcmdq {
> +       __u32 vcmdq_id;			// queue id
> +       __u32 vcmdq_log2size;		// queue size
> +       __aligned_u64 vcmdq_base;	// queue guest PA
> +};

vRID/pRID pairing should come from IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. When
a HWPT is allocated it would be connected to the viommu_id and then it
would all be bundled together in the HW somehow

From there you can ask the viommu_id to setup a queue.

Jason

