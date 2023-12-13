Return-Path: <linux-kselftest+bounces-1837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B2811456
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F49F1C2102B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047A2E832;
	Wed, 13 Dec 2023 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tLZQavZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::605])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7495;
	Wed, 13 Dec 2023 06:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSJ3tkjoXpvD+5Rxz4s2t1JMa+Ovu3Z5qnqW5DA8On04nbA42JU10IwcV11xhJZrURowxD70pFOqvsEVadhqqGSHd5ObXTCvQHDlLy5aqvCkidwGbTMdaE6wJx4DpCvlVQ7g6aiEARMsPrbrioO7NTs00XdEn9HCbWoaYWLoPLpi87C73GKnOj9OamdM3Mh+1IxDfBbH9eqbZjD8O/oBQICDBxoOuN0VxrWs/gh8EvnaFYxgohQ88JiLCHypn+r87DgH/ElZjsjuLN6IL+SMB1BN4HCVpzYUIxyqkM6JTUhsbfHKtZ/RNekgFTiuPNqjCPySfXjAeJQ4eTk8IOWJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLa8nYtNedIbip2sdEow3VA99gPvogcDm+vZO2mF2Tc=;
 b=fBw1HFTzYEtp/r5gUYjEeKqz51qWdAVWBBcqpVk8VVFwtERnMcQC61RAiFKlwTWejleR1lMNPCAxBrA457lk7vyhQEN3I0gLJjCuset0TBnlSDPr9fuNIsOlbqxljtL0vNmG8wAJ8zjVTwLySESybP0///WzMZ4OMzDFHZWBraWyk3tnndFgWqvRR9HO3HH19yKq2B1EdIub49Uy1HJKxI7JDdXq//XD3HTcJfDcxmg5ZW9Djd+kNNnySW/efT9itPo7DbDjyy0aReAC+BEOJszKEXWeKuuT/LNTegkrMizTR0WpmqFV3hjagIDIm1mo4r0KKZHjje2f9z4w2x8X+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLa8nYtNedIbip2sdEow3VA99gPvogcDm+vZO2mF2Tc=;
 b=tLZQavZEM+38lCz3eJFuWoXB6aO24Ey366WXvgFYXwuP1gMSUje5Ak0yt6uxRPs3BW2p7WJfZildkFGrHYCasQh9IROwGa3JTFBhVaJ/fIi47Tovg+Gjixhs3MO0Ijx2DE1j/V9Ewrd3Yu7QDOecOSRBFyGBUXCEnK2BrflCQq6lS2tu56qkHwKD9rg64yI3GnNRZVCDfKPSw6Pjhjto+rsjhj9RxxI6Y4+O1PAYq7A7slf8v6hpZI/BQvKsl47RatCgsDzbpU7KFZLaf2yGQyxKwqq8P5InOW7kphIx40V/WqVWcSw9SnXEO/+y0DDVyqB1Z450HlAaBDbZLlRi1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:11:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:11:39 +0000
Date: Wed, 13 Dec 2023 10:11:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Message-ID: <20231213141138.GX3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231207144208.GJ2692119@nvidia.com>
 <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
 <20231211132135.GF2944114@nvidia.com>
 <DS0PR11MB7529AA3F28F4418A80D869B0C38EA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <20231212144025.GG3014157@nvidia.com>
 <SN7PR11MB7540259246D97147A224B486C38DA@SN7PR11MB7540.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB7540259246D97147A224B486C38DA@SN7PR11MB7540.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c47e41-91bc-4772-fe90-08dbfbe56c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjpEwudCtqHiQ6s5BM+PmznwN7z6XZrTg9ztzMMej/zzPG5TedIL/EtCgByWlY1ELAIlVLNfagv3d79rRCvw7ZUnsCNceL9l1VRh9RI426mtsrHoIyoAl5y0ZToZIQqRzf38PoAhF9ebbScikCRiOwMBE4SKm+1wXPBXdyNI+b3X4gfQ4DbSUFuIUfoJ7nyslhxCG/agP6FNFeHl4LFObw+awzxMRBW3pm3wQ0urJiEQJuUA9F4ximW8C4UxFQm74rPeUKH+h7DY0Gr2wl/PEe983kxApgVxwTI5NK478emPo4PWPn8FWZqBqV79LPrajtrBrMjm1tw1Yssq+W60uaAhe4rJENxEidFYM9GQFSLui212pWSJHpXcb8+bncJnsze4rGb9MFLLCn+ZeQmBJQnmkW8VqdkX6/aWtY5WUL6AUb+PvJ8y1Yj1oXfmhIyqIdpelgSb1CEqYnMmSLh5JctYC8Fs4q8hlwn8MLqEcw7iH2o6RbPN82Q5zswXbIbXto5gedYt/aen9oflEGApERq2MAIJQZ0LCkR9OlcGqG0nZZAde70UKBGARYDFp+f+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(2616005)(26005)(6512007)(6506007)(86362001)(33656002)(36756003)(38100700002)(5660300002)(8676002)(8936002)(7416002)(4326008)(66476007)(54906003)(6916009)(66556008)(66946007)(41300700001)(2906002)(316002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Orfq7LpW2Hmppk5WyunT2UmUirmt3tLTo9gxzx7Vu1x0MPMBJ9016R26oDN?=
 =?us-ascii?Q?UVmwzzRfzRQYSmGvD/c+FT7sWkLsNmRo9dy5SDXuIMG5P87fmU3mbhoqXOFW?=
 =?us-ascii?Q?4Ilxq9SHzkt5X1Saf5B4sBN4f0qw2AuIZMJ4gTu0sF5BZC04Lz9iQ05lGo0A?=
 =?us-ascii?Q?8phLv0bVGWHwa4tXRgT7vTeWXAd5ajwwizA4AmaDkNRKyAw1QHhB5DWHHW0+?=
 =?us-ascii?Q?dWjwE4VTr4hiAjBOjfGXtWo598OJHFpkJsMpyubfmkBzfG5zr4FWBzxxuj8Q?=
 =?us-ascii?Q?WHbTNez4A6WP7urT/nAabK6hNjUPkOsODK3pyjdrC+4gEq8BXccOTjB/NivN?=
 =?us-ascii?Q?kfs/KLQ67VFbJNcV/8P2FI39pFif9w2hPLjl2lARzHlPw0SjjhlZ13Rth0ED?=
 =?us-ascii?Q?sIphFuVLtBMBRU9jMfz+1Px6GLgQlTWGFqbQ+6bcS+KqF2AJcAMsuagishHs?=
 =?us-ascii?Q?m3dysop6YG7rT/QcHuI5nwubBAUFZV4M7iXjpDw0Nl34nR7h1e4FIqfnMbA+?=
 =?us-ascii?Q?5YsQSQc/Bb7Sj/StDgqXkCcQXQdNNUYKPxiMJrJlHIkcANvB6p6JNZB80UJV?=
 =?us-ascii?Q?rKfnuYijPCu+fon7sWfTAz16yxU1Ylxwp8xbl3Pm4NgoTBbBUv4IHSff59jG?=
 =?us-ascii?Q?vzEdZcx3kU47xrluxlMSVBFCMSU7593Qs+R1sMq/893o1E1mtVQkvSoCDeQ7?=
 =?us-ascii?Q?AOvKuaS+bwsnpKNurUCBgXjHS/o3g8PVuPdr0phsi5ZiqRjXCdKbg4u2Qtst?=
 =?us-ascii?Q?rlpGSkAPmCbVxgh16NgrO7yw7KPqGSxMpTjaU3f2i0WQxb/i4UmGRE+Rkm2o?=
 =?us-ascii?Q?g8E4CKnEcWykX1J6oIJitk2gjVi9IM3D9O9nEkDvMaTqO4NEyirOt1cZaAfU?=
 =?us-ascii?Q?WYQ2KbJ2vv1wcrg5V5/nLQSUUmFw4kkvN9jORZ7OEVVi7iUaN1NKjEf6+zwE?=
 =?us-ascii?Q?9Ro4xZEs7wTTE5+4QSle2HXaSHtuSiqE95gE+vP5DApTyWCbxwlGKGKiwQER?=
 =?us-ascii?Q?/Y60zohY/q4saoJvcdpFaUwxhb0c4HguVsDp5GAaZ86Yca+DL3UrEvlZHBEC?=
 =?us-ascii?Q?sbNpVJwaPpKjETkQFoNKIiNh2HL8C3Bjh90Vu7Y70WA0PdbOl8uJMeu4ywyi?=
 =?us-ascii?Q?qqnoc9W0zmyq4xGLxplTnyDP1RJoObiI+xwDLfbHgJbjkJdMRbV+DGAg1dPc?=
 =?us-ascii?Q?LMrMHCcl8oi3dy7RrtpL8J3rERBYz31bL28QTWn9Z91lTOXw/MQMbPhaE3R4?=
 =?us-ascii?Q?uvFGmb0uFHQMPD8ZPkcveDhay4g6lHtB9o8Sbe1akIFp+mb+QtENaWJjzNpP?=
 =?us-ascii?Q?LiyEpEn4f0+AuvarYzduer71cZPYlnQn5EJ20MoxL11kaC25YRecWZs2fX/6?=
 =?us-ascii?Q?AhtPyx6WxIiUxgmb71mB8Ep6A1UjRoEhAPX4GPw4Bj8XFogpng5qVSo1YaQS?=
 =?us-ascii?Q?kN+Bq2N9DkbMxNrI8mLCakWFgo+jBp86xh21fXXmKrjYCwYJcwU93led947p?=
 =?us-ascii?Q?1+AKetJcgr/rniTp3+FqUaMQfGkibOFN+5is1p3YZ3hAAED8zb8zAD7q8PYV?=
 =?us-ascii?Q?I9peSA4M+x0JXuBVPXI/sRTRCNMqUHMSWjNILibW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c47e41-91bc-4772-fe90-08dbfbe56c8e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:11:39.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNHWJpFrwZs5HiBWyS3xvypVA2Vx7mCWBkWK8FlGzggw38qbTcci3GQrUKAeDGzR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

On Wed, Dec 13, 2023 at 01:47:54PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, December 12, 2023 10:40 PM
> > 
> > On Tue, Dec 12, 2023 at 01:45:16PM +0000, Liu, Yi L wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Monday, December 11, 2023 9:22 PM
> > > >
> > > > On Mon, Dec 11, 2023 at 03:53:40PM +0800, Yi Liu wrote:
> > > >
> > > > > > >  From that thread Jason mentioned to make the invalidation format
> > > > > > > part of domain allocation. If that is the direction to go then there
> > > > > > > won't be multiple invalidation formats per hwpt. The user should
> > > > > > > create multiple hwpt's per invalidation format (though mixing
> > > > > > > formats in one virtual platform is very unlikely)?
> > > > > >
> > > > > > I think we could do either, but I have a vauge cleanness preference
> > > > > > that the enums are just different? That would follow a pretty typical
> > > > > > pattern for a structure tag to reflect the content of the structure.
> > > > >
> > > > > Is this still following the direction to make the invalidation format
> > > > > part of domain allocation?
> > > >
> > > > I think you should make it seperate
> > >
> > > Sure. I'll add a separate enum for cache invalidation format. Just to
> > > see if it is good to pass down the invalidation format in the hwpt
> > > alloc path? So iommu driver can check if the invalidation format
> > > can be used for the hwpt to be allocated.
> > 
> > I would skip it in the invalidation. If necessary drivers can push a 0
> > length invalidation to do 'try and fail' discovery of supported types.
> 
> I think you mean keep passing the req_type in cache invalidation path
> instead of the way I proposed. For the 'try and fail' discovery, we should
> allow a zero-length array, is it? If the req_type is supported by the iommu
> driver, then return successful, otherwise fail the ioctl. Is it?

Yes

Jason

