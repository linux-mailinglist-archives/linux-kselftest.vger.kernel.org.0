Return-Path: <linux-kselftest+bounces-986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AF8014BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 21:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A944281DA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4258AA6;
	Fri,  1 Dec 2023 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdgPe+TR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F16F1;
	Fri,  1 Dec 2023 12:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY1A/mR8MeSrmlAaMH9A7DphZKzDMiKjWjAnVTxxzkDisbistosZSHLsyvYqb9tejgDCuWgDufJ3u3JN5mZjGdBaF0gIdRIa+iitcZ5dSBbLXqSYSbSh8eOotNxav5UuliA9h8Y95C3rm+TLSPrt68kJbVrdk9ClFr6lnAtCw9DeYAgAQaF/aVEIB4D+hgjrGZUa9u8XbgnOu/2+ztOJoBYGbBsmlg6WSt6tEzyzIPfn1B8Uhxy03v0kE/NHy4v5mnKKzrW39UJ7tjugpxx2jmkn/ZblEQdZW0p2OWfen+x05gcgqzlakXuo/0YPJ7xeZKddyBfFP66rMJwZhUpY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXhWGgPhFcPgX9xjyOaqsavFkzyBCViMhx9CiIVyDFU=;
 b=NumEE/HByvFbnaCTs+KOmIXkPJM3A8LErFYbr8lhH3bfzd7ywqbZ92lMkp+xTohpsCR/rJqDGnZA33N4+y5WqqOM9KIMI6PERYnum958REDcQE7YJDvwGiuY2q7bLbRDI2hQhHs7Ti9FO82tVZl1zYwe4+uw7ked/g+qHSL2M+KgSRrEZ2/1MpUObBNihBvFB7ZTgzo74k/H148wjjAAeEKm3fF2G1TABHgW9UC+XvmIvKRdf35jGHOYm4U4KLL4+kul0x64D5LXSLTujdozJ6hOHlAcFa33XoA4shJYmIcs1B7SO/4OmP5NjYFgwWJJ8ayfTai7+352hLPS+kXYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXhWGgPhFcPgX9xjyOaqsavFkzyBCViMhx9CiIVyDFU=;
 b=FdgPe+TRlCR62HtvsIrGU4biNBZaL7gZfmKyUYtShxmpfMbWThEinUh2KvAXmbBPeCF0bCMW7f3Fgxhifg8hPgbKd6HVMQyspnXVaINiC0injzqPbL5F+QgD3BvYzYhXG3xE37Dr/HmspikHbm1Px7pGwKzdbftwBQuMz8q3j/aTAmU1WH0XhsIar48659G7healPsb8DtRWZGzxsKLujLE4sSlgPw/NiGpHaLITKT4Cg5WfAtq09nVMbB9HXRfnWvNIjXL6Lm64UOrwJdZc5sYUT7f75tyxhcCcOGkeOMFVDoPFMXqu2U9HkoQz6tusDEY1qHy51mEZpXcxjMHFHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 20:43:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 20:43:42 +0000
Date: Fri, 1 Dec 2023 16:43:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231201204340.GA1493156@nvidia.com>
References: <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
 <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:208:32f::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd76af-52fa-4082-8b92-08dbf2ae345e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CNJwY14vg7JUj3g73X8ZpgOeTFSMv8Vz3yDYxO0jtWhj+iJSf2FnlzczQSeopXyJ8JxjGz/C6jyM3KZ9W3AvR0w5Up3ao+Y/54MoV81aEeJAqkuRNmJ3I5vJ1X+5GY9OYYFc2hqX1FOgUDq+8byWebUTsEhz5AAgECCrVD5Qp4fOqZ5hqdd6MQ02NaqtfsrsbFNafS84pM6BQnxxPyoZTPl3L7sSrZYdD6flXoWaSGXO9whGorx1wUfG/m5iRyfCqz06Ylf0qFyFhd+yq57Kw7e4i0nSYrOjxt9npgY05QYkZOfcsEBxMkIoE4L59WAxzZ1SF/gCwLmODw4CqYRj2FaR5OdnAVwCYnKYAQ1yDq5BBvOpANXSB9lAiMkhgVY0Sh6DzC/ub4oHew/dSy8O9VbQQYdh9qY/HDpE9SBbP6wYdrrjxhL2QdvpV56YrLgj1YnoqMJPuYisVr8+4SWhEDqfvFbd140c5Vc/QLQXSfLReBp2I3WlOo34/nZdzzepNIIBBua5orS6mtO41BayMGCQeklkKLB0uOXuKaZbtAkYIyEHxWnr/uzfvSvsqi8C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(33656002)(478600001)(2906002)(6512007)(36756003)(6506007)(8676002)(6862004)(4326008)(8936002)(41300700001)(6486002)(38100700002)(316002)(66476007)(66946007)(6636002)(66556008)(37006003)(5660300002)(7416002)(86362001)(26005)(54906003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQuJB/I3jOxexilN3IvfYPLeNtha3jt57LFklCI4giHK7RJuBHaCAhH8DO4b?=
 =?us-ascii?Q?0OotVvrT451wdDeDh1jyOsYQF+/SVAZIaFw64i8ILurC7P+NDnYswT+xYOP7?=
 =?us-ascii?Q?ushO5ZL8N3/em4IVzPLai2IBi1UNsh7I+vFGPglMppUfi/D5IHngoG6rNusH?=
 =?us-ascii?Q?mPUu/JWEVk9i53cgC9O2/kMpJh3Vhwis+1loSvewfuGkoN0aj4Tf34f49acz?=
 =?us-ascii?Q?oq151ClLvKCU62uotMndQz4/RHDOiziBNjVe9vO4iS2FpvdM8wKp9ojUtKFD?=
 =?us-ascii?Q?cHlNs0xHzHiw6PcBA4X5/ykKsNnHpt5ZMerWWzBL8ZyJ0Y1Dw//v9/An4mpl?=
 =?us-ascii?Q?y7i+KUga2GzDVTPPavIw5iox/NK4LGBwKRv6kYEbMgp5R/zMrvFO1z53zE0E?=
 =?us-ascii?Q?N507OEP/l9nRVVCp7KrB+iMK51nB0vv4ryVNoNg6SsOnLZxvGrFVdJCAfoX/?=
 =?us-ascii?Q?e/Vn+NTGTX26TRWq1GyNDWsZ3cVkBYMhqbQFnu8rnJnRVs0ihLm5W8Asebbw?=
 =?us-ascii?Q?13TLOJgZsNS/qIigglwL5OD+2WSAI4j0uqxlhBRQ9aw2YI5r6F4FyBM4X2p+?=
 =?us-ascii?Q?uMFGa1JNkK8RoAwv/cve/QV1000Yun0ZwwaktOCQL/axevINKpx2uyuvLPKX?=
 =?us-ascii?Q?D1nOkQYZNXp1qtaX3pyGmzYNEJp5UJUIX7d9NkthIqHggJHInBHC3GpJ5SdD?=
 =?us-ascii?Q?uehocOMgq4Bk63LIHlyqvFo88li3KXajH3cYFrN7B/Wy+tAb/vwXW4XiAgjH?=
 =?us-ascii?Q?5TossCLaV9oppP9aX88/cjc+h9zP6zfm/08O/mgIlefKWGXIlOXEj2hNeDIP?=
 =?us-ascii?Q?2W4ZClqXeHRJx1Md908WEIlQRZUmT0xZvu9gKiQ424FyREiQEV1Dc3IkdXcd?=
 =?us-ascii?Q?0OWtJxFY03Ulmci47R1Hh61c3SjBnzB0C5+4+u9Dk7p958iMSNIoCxCqg6kt?=
 =?us-ascii?Q?307exeL8VED0baLMixC9ox0QDWNlic6/NJIXhKVyq7z3ovrXNzpANqmTEQMg?=
 =?us-ascii?Q?I653YD3ofb2RPr1F/r8goAi7GCmt/MFV8KU4mWY7mNIWUtbALTtcPxrEbiU/?=
 =?us-ascii?Q?H1uUZZJ8jHsCBDsIlF9GxXC0Z6BmVynu43Iu60ALuD+yUUOkYKvOiYxy72Ip?=
 =?us-ascii?Q?TNpBx4RWLHzkdn0PWk1hA/3kSpWIRPefPcmCSKQBlmVhFAuS9gpZnmBscq4W?=
 =?us-ascii?Q?aaIXC6+YgBcXTEVy3omrQX+vax+Muk6oW8vPO5PA/7Yn4+X18geRfAiUqzsV?=
 =?us-ascii?Q?01lBhoLIx3fcq417FPtKBEk21Qdi4ZeqG1iEVqdkmBftphAU0qOSKqUMxmS8?=
 =?us-ascii?Q?tFiwUSM0niPp0APsIZobOgpoGqNmrOMl2ywExt6zQnhqklTE5/52n5x3DSWJ?=
 =?us-ascii?Q?vQ0FHMYnnx40vBTyAIatborqBsm7Tj4Q7FOYl8QITbidjkyqmDUP19kCCZLF?=
 =?us-ascii?Q?VmzMwWoqTqY+alQ3MnvawGWuaJAUju6fnWascyo7pdvL6tlL5I4VwIQNAthU?=
 =?us-ascii?Q?Nm4zQCOmC6hRGscl1rjLOHwXl2lnsfm5l5wMfssvo0vOd9lTJ7WbQagIawTb?=
 =?us-ascii?Q?nWnngeZB/An44uVo9nhnQ7os4d35wqxQtzF3M7Go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd76af-52fa-4082-8b92-08dbf2ae345e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 20:43:42.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPq+5zeepC6UKOLN/4yOMWGB54PRvRzeJ97Uv+wIPyODLxB44DqSHtK4COY1Bc0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432

On Fri, Dec 01, 2023 at 11:58:07AM -0800, Nicolin Chen wrote:
> > It seems there is not a simple way to realize this error back to
> > userspace since we can't block the global command queue and we proceed
> > to complete commands that the real HW would not have completed.
> > 
> > To actually emulate this the gerror handler would have to capture all
> > the necessary registers, return them back to the thread doing
> > invalidate_user and all of that would have to return back to userspace
> > to go into the virtual version of all the same registers.
> > 
> > Yes, it can be synchronous it seems, but we don't have any
> > infrastructure in the driver to do this.
> >
> > Given this is pretty niche maybe we just don't support error
> > forwarding and simply ensure it could be added to the uapi later?
> 
> If arm_smmu_cmdq_issue_cmdlist in arm_smmu_cache_invalidate_user
> fails with ETIMEOUT, we polls the CONS register to get the error
> code. This can cover CERROR_ABT and CERROR_ATC_INV.

Why is timeout linked to these two? Or rather, it doesn't have to be
linked like that. Any gerror is effectively synchronous because it
halts the queue and allows SW time to inspect which command failed and
record the gerror flags. So each and every command can get an error
indication.

Restarting the queue is done by putting sync in there to effectively
nop the failed command and we hope for the best and let it rip.

> As you remarked that we can't block the global CMDQ, so we have
> to let a real CERROR_ILL go. Yet, we can make sure commands to
> be fully sanitized before being issued, as we should immediately
> reject faulty commands anyway, for errors such as unsupported op
> codes, unzero-ed reserved fields, and unlinked vSIDs. This can
> at least largely reduce the probability of a real CERROR_ILL.

I'm more a little more concerend with ATC_INV as a malfunctioning
device can trigger this..

> So, combining these two, we can still have a basic synchronous
> way by returning an errno to the invalidate ioctl? I see Kevin
> replied something similar too.

It isn't enough information, you don't know which gerror bits to set
and you don't know what cons index to stick to indicate the error
triggering command with just a simple errno.

It does need to return a bunch of data to get it all right.

Though again, there is no driver infrastructure to do all this and it
doesn't seem that important so maybe we can just ensure there is a
future extension possiblity and have userspace understand an errno
means to generate CERROR_ILL on the last command in the batch?

Jason

