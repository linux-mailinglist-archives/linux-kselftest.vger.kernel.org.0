Return-Path: <linux-kselftest+bounces-1679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A9480EF19
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2831C20B24
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A811745DD;
	Tue, 12 Dec 2023 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpR3ehTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D537F4;
	Tue, 12 Dec 2023 06:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTWGCckd9IafTFm2Hc2mSp2P7N/nLja25WlttUw8KEjboq80Aotgd5DcX/pkxdY/0UgANI2/Du7IoAAw4pQVqn8uu8GBG5UWXppMHjZ5qz14DcNpf1q13m6lyGDwjbTTDEIuPAXjHYKdqztNVQuEK7syb+HVDUj9NOekF44EzrH/tP/cKG3i4SUYq6ajR4uX+jpjFmq1BZNz3npN5Yfct0qhZqZ2GsfUMAGXJhLjUj8cG8EHek2YH4euEBT7UJ2PXFv78ms6b4l1zXeeRPQAaF/A9sZU5XtsWnjkzamTl/c6Mjvdf/y7Nprw7Tsw0Tg6IpRRsvQV9KR5yUCDIQ84QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY2qKlJ9EbI1AwONZ6QBUFy6NGALblf6LOnRZbcu2EU=;
 b=O5rv0nqSQy4/AZrhTDmVop89iofjBbjl5vwoFu5mJY3VT0NP4YjYjg3zB8Uw8YguWJvHps/qsoq0QrYbvOnFvduiOg4YMcAbkhQAWa+W640lJETMpahRtvO/ptE0Kc2+gdmmMkbE0tcK5n2fd9BF3LZsRRxj+qlbTxHrEV6vvSxPmKmW2XFSLaN+NTKIl8NonXAKO9lV87bX7OzRQ+FrqCAzaNbW5BpqGNPTH89uOL+TkafReTELu9RMfdGk3G2qVSQG4jXYuYJpuCTtpqi2B/MgX0hyXNnM+fUKG0pu2mcKDCrn6HK3B03xHOBzCJefBjzekMwsxQYvZkS7HmiSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY2qKlJ9EbI1AwONZ6QBUFy6NGALblf6LOnRZbcu2EU=;
 b=XpR3ehTcoY1OlJs75J1u49Iy4v+QXGhNNOt6A5ayoPBMbdDbMLsQCR6Sl5G2/TbbRaJQSvtw7EyWXr3jHAOVz7mB1hMeb7wc6W7tEDr6jcs9VCOIdo3e09IbkGemJZXyN9wlOZMy7Aaa3HZcjUnFGqnnkL8PQDHvJ/8NIzYj+5aonOcLpJn8Vx0RjB+m0cfPBIgZ/ylvZb5mqU8snobi01pKGky5Qr0AmZyQDaKP+n837P/Uw1aJeDGJVoz8HPzFrRytV89eQCxUa4e6ZcB7qnqgQS9MYLEmskpvGwFrp4BsvMgJwZR8e+7KtAlbxL12+L702biPA5z02IDkLNdUzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:44:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:44:22 +0000
Date: Tue, 12 Dec 2023 10:44:21 -0400
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
Message-ID: <20231212144421.GH3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c772e91-8a67-4618-6820-08dbfb20d435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1PFYaSaOtyyCbXYU3vj+4NuT9+ys9/91oBPei+G9QhsnrTGBvocgZmsZY38C241AbQhsGJkkrfiOo44uDH07ir5CXcq6RUnwON0kU0qeODPPxE7FUxLlDCK2BpKaSphtBuBaw3Er4XqzU1yOy1A0oyE4Npf93ZTVFAu8LdxLke9l1Q0NAV+sR0QrPNiXv2bfS3HMM0IgSH4ml/6ZEVujSv/qWD93CQDnY4M8EZwuq7xToo1NOnzD4/6K4+tiy2GxR6S2LLbqSLZiVjQArWsaoRg207WWrc8NqZ4icBH+YoeO5sGAJvjZkKvM/G2wRX0gPtUUkYB33sp4hYqPQvAn+DwYERIWgqZhfte1TSVRcrqxId218mHp9q416/nUjYFLQDB4cjP5bDfPSp3DgGhyGsgPqrZcbd3Qe19kuCFIpX7nHDl0gAQvWDClDAqjsUo4Q78QAJm88hU3IB+ATKSm2TigX9dRvJaaGL+IP9/XhjBJhfPc5wyLcXbLwU4NcKaEUJeIbbYWDwUJWFvX5ipcoa1/2PczHFrQoPKiv4tJoo2NoL7pJFx8Q48b3+7jkmps
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6636002)(66476007)(54906003)(66556008)(36756003)(33656002)(86362001)(66946007)(6506007)(83380400001)(1076003)(2616005)(6512007)(6486002)(2906002)(316002)(37006003)(26005)(478600001)(8676002)(5660300002)(4326008)(8936002)(41300700001)(7416002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfYkKXHCJwfSJEXmj9f9/wvpAEtmhGkI6f4a/6Fh2XlmekyPCwPWNxyW2uwA?=
 =?us-ascii?Q?9CqSMfcFq0JeOnHCZQ5Tjl2L5258fm8egS3tJ0cPlvQIE7Tgy9ROr/j3A4PC?=
 =?us-ascii?Q?j4Uj05s2VES+anyh0eIEvgL//Yp9zPDo0n7CXemGbRzIyo7QT/g5YYideNuW?=
 =?us-ascii?Q?HuHTR9qyNKoWusZvZ7PG+I65Gbhd2HjHdS8H0jDzHtcPvaIHSWMx3IpPnZDd?=
 =?us-ascii?Q?/4GsugbkpSudPaWDjqz1mkiy0tNCLOE6KC/AgkSPXIjpjn1XsvkhCC/0w/LG?=
 =?us-ascii?Q?Sq3cNbGTzmWUt8gQ+qaox+hY+YPQ53uxSQ+kNeyOWtbQNcz4YIV9vhUWHTwV?=
 =?us-ascii?Q?VjMnmPUiMj+uJFnZXmbup+hu+EWZWvZcmC1wptyl326Pd0NE7dgsf2MwxRYv?=
 =?us-ascii?Q?dfvhpcL+l4lePL29MP7x/wOK5eQy7cus4pyDRwOSfTI1Sh9dBetjZfwcCLLe?=
 =?us-ascii?Q?WzgY0eFq8CWBABUAJNBuERxHExUk0QlGzEXLuuAPwg7I303nWa80SKw4L7fu?=
 =?us-ascii?Q?fWfCE1jswKJgSi6BoQR7w62m/avxvobEHjH8CSSfta1Qim1dmeJ6ZCOR9dXH?=
 =?us-ascii?Q?Upw2j3ayO3LTh3rcq2Uhptiq48TkPNsPLvt5+x/2EYdWVtusLe2ZIVgaUuk9?=
 =?us-ascii?Q?73ffM0m3KWrbZehBWH6O4XyOVRtm1JH3im2/Pkd/r+HdbESJPt6sYMqpk9bQ?=
 =?us-ascii?Q?L+U97ZuFcJLxNEEZHumzBivwf0X2ETJ73QrjFJ/gS+F0vh8ery8uvVCqJT6i?=
 =?us-ascii?Q?uUQ9gbahuB/HcqMOoeV3FGR6oAitnJ3Y5WEtiAHqPa5sBfnmk/QmUjm38DKo?=
 =?us-ascii?Q?S60KuLdZfEnqpcKLys3RS7hlJ7PTOkfaRoOuiatLnVTz2mXd0hsMGHAglALu?=
 =?us-ascii?Q?Gf5l1QxcP3Rtim8ZNejWxMxlAb3y3DiVhqGenUQrOkvSUAZwKbXQxn1Mhu3I?=
 =?us-ascii?Q?za+RIRqzFgWE+aHYHJfw04EEZD2wiRExay1V+pJMEhxfmdmXjlNiey7V1bJJ?=
 =?us-ascii?Q?76iSOd8yBLoSGuz77VDeeBcCgc6ZtnQV8zR69O1T6oXgtj3goO4kl+ucLqy2?=
 =?us-ascii?Q?kuo5dmxfcuGD00dEN+sY7ueLT9NvqOxeG1MoCtiLxFCddbFZHygbAbYiix2C?=
 =?us-ascii?Q?42FFv6E/1o5p4O7j5Xu9pwB4Uj50FbliQaOpthnLBa92KVhrea+iD6xb0Vxf?=
 =?us-ascii?Q?gTMHaPuqocC9Y8jpjtvCQe+71+R8QEZB2XTdcggIlFJl2n/DkKfFxOM3Xjip?=
 =?us-ascii?Q?NeHGypd59zynNOjYI+t4AGxQ1rROI4aUlsQk+9EYqz7SqWa1RxMaVWqzEhcx?=
 =?us-ascii?Q?u0QDC/K74RLxZ6RZclE15Src1b06okL6FCb0u7qJA0MOAcZo8h5tTYGFM5FI?=
 =?us-ascii?Q?YoMGmwD43I5B2WqFuApy0ObtbTfSnO9Tp36zMg7iUnt0RDdRokivIv08vCH1?=
 =?us-ascii?Q?RGbTdmt0Xmom/KIA2ASuJeDa0q0ZtBuGjQagOF2vRWiwjDPPyEwa6yn1Qm3E?=
 =?us-ascii?Q?aG+lXofnAiWKeGCLQqBVZ8waPgrOq9ZB0PEdK9DlxYlsFHXroSGOAeUesI1E?=
 =?us-ascii?Q?4vdpYEDBoi3wz7LPQ9EzBIIBxSJu3DfS7UNWyJJA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c772e91-8a67-4618-6820-08dbfb20d435
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:44:22.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU6yEARZupR7scGTLFZJ44ctQMidS4rYJPnFTrkBD+pyFihyiL/9rXOqqQLQMu/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804

On Mon, Dec 11, 2023 at 11:30:00PM -0800, Nicolin Chen wrote:

> > > Could the structure just look like this?
> > > struct iommu_dev_assign_virtual_id {
> > >        __u32 size;
> > >        __u32 dev_id;
> > >        __u32 id_type;
> > >        __u32 id;
> > > };
> > 
> > It needs to take in the viommu_id also, and I'd make the id 64 bits
> > just for good luck.
> 
> What is viommu_id required for in this context? I thought we
> already know which SMMU instance to issue commands via dev_id?

The viommu_id would be the container that holds the xarray that maps
the vRID to pRID

Logically we could have multiple mappings per iommufd as we could have
multiple iommu instances working here.

> > > > IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> > > > HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> > > > (and just force the stream ID, userspace must direct the vRID to the
> > > > correct dev_id).
> > > 
> > > SMMU's CD invalidations could fall into this category too.
> 
> Do we need a different iommu API for this ioctl? We currently
> have the cache_invalidate_user as a domain op. The new device
> op will be an iommu op?

Yes

> And should we rename the "cache_invalidate_user"? Would VT-d
> still uses it for device cache?

I think vt-d will not implement it
 
> > > I previously drafted something to test it out with iommufd.
> > > Basically it needs the pairing of vRID/pRID in attach_dev()
> > > and another ioctl to mmap/config user queue(s):
> > > +struct iommu_hwpt_cache_config_tegra241_vcmdq {
> > > +       __u32 vcmdq_id;			// queue id
> > > +       __u32 vcmdq_log2size;		// queue size
> > > +       __aligned_u64 vcmdq_base;	// queue guest PA
> > > +};
> > 
> > vRID/pRID pairing should come from IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. When
> > a HWPT is allocated it would be connected to the viommu_id and then it
> > would all be bundled together in the HW somehow
> 
> Since we were talking about sharing stage-2 domain, the HWPT
> to the stage-2 domain will be shared among the vIOMMU/pIOMMU
> instances too?

The HWPT for the stage 2 should be shared

> I think I am not quite getting the viommu_id
> part yet. From the other side of this thread, viommu object
> is created per vIOMMU instance and each one actually tied to
> a pIOMMU by nature?

Yes

Jason

