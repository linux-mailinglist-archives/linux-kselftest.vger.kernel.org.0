Return-Path: <linux-kselftest+bounces-1691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232BF80F117
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1C1F216BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5676DC2;
	Tue, 12 Dec 2023 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4et2SzF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C15EB;
	Tue, 12 Dec 2023 07:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0yAXY70N90JlYH6dbpbTEAbp7kB9p47vFkRyaISbI1Tomuz4OfbDx94vZBnKIb8juIUE4HwBD1wQW8RNF0qWBXpxSvP46cILCRt3bF8r29JPW8VvVWrlLVpZF8vzYKTPUIQlaCeNZAauuem/LwT/1mVtDaXUIkjiw505rYVX0LrJq1oh94NVTnlQ18xRjOmVqyz73JYXvyxlLxY2YlVh2YPNJy/r+eHtsruejSBA0GRA1zEHNrE6ws31U1CR+SSERthSfx9F1pxggf0soHA7Wn6Ey19sZYeOmvm/XyN+B7D7jB89aoBpxlFPds1aTtHrougCmq/cexFVYy3kK0kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml7OeEGtH+zqT2KaX+X6lbRJATkjOq13K8mGmUFr6BI=;
 b=CschBbRnUIpyW03ymk5dQOU9c/mXbdUqXDjTo8yIXZbw4Vze4TEBZ5+HKaLG0zNrrjeQ9FyqxXqHC+otsn2qLLpPRv1F1QAq9o5vJU+vyhTJv9mMUj0VNR6dP0byFS8bcaLIxFIZCteWHO3KDHeurcH1L7pk76Ms5nn8qjb/JZmHl5e3ovDG2Jye5cyqBXNF7OpcfRHtHCf5D7RHY+trS/qjU4YJYyVASwkyNOBtcAsYd5rOP1nxG1GrrCyUKDVPO6Fucr5DKK0aAlRoly4c1VebsCTho1nTlPXzcIpMT6kMtCpymG3nED9NSqo2pNjHg85f0qkWRi6QuxmYEK5nUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml7OeEGtH+zqT2KaX+X6lbRJATkjOq13K8mGmUFr6BI=;
 b=I4et2SzFqnNhj1BEpz1gkpYzx7PbMspELexFIbPO1ZcCSwGvA7XU6cNXiG2b5Il2rccFQQQrn/JOmttkGgheDqI9C69voWt6EN4lCYlmkzcAqRt1CoFNueh1+91nU0gBN43m3Jwv+aNVoo0qDkyynbHxLrz+AHPNIq8JcDDjkfqS3yqMlQ/NW2ZvblRG4WxXFVfDekgliz2hWmGcdaqE4tNmBWxMPZR2liWdQIX3CUgY1SrvFcwMNd4QZpTNHkvL0uzwFXKZvXtABYTVvAM+wT03dshFOEIf07MOnVEXpWQY5KwWgfOOHZU7yZABAAF2tgxH+Qtb9GfZ1XXSVIw8XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 15:31:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 15:31:31 +0000
Date: Tue, 12 Dec 2023 11:31:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231212153130.GK3014157@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
 <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9e61bf-394a-4479-6dfc-08dbfb276a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EckCOqMOwy4jPgA3Sl5ApxEUG0/HYNHcrYTNiYjMr1qdFQlvS4FmjwTSU1Tkf3fuISw4R8iFqTBvKizo6iANQq21pHteNgl/wp4rq9v0s+PAAg+5bsDCe1gQZJ3MKYT7VvV6voYjyOFxFskkdBj1JyrtoTR2TLL0T8+tOgs6iID/8s9SwodKkFo2c8CuM5673wqB/uV7fvBzlxAWSowGXWZIb016/O9pWbWh/vIlVbbh6DpA2lTGBQyY90Zmy36A2ZOahE7CCH0cpriiNftKPcAW9/LtAtrfTEcBNIsbyrXydvRtVOLL3YWxW2R9f8s1gs6Un3aaWjYdPdEGQa3q+tTzJ6x34VB1eHlQhuxcFsPXVqNL5g5kyv1tROxqbBsO1a0uJ+9nkUiadlz1m51gxi1KZ26rHiTNli+ExCoLLzRtR0wHSEzLSj2Z4NHCmGdRwAbXXCQjH+q7U6xKbuvoY7Vt9YvWRgdCJWxNlBw4UYKGceH2k1HyzjED39omgY0APFRNOcNYkSCPkARPF5xoWsVY5JcOe1nzlOvhAJ1822hBYsZRmGpKFOv8t+RfWabu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(53546011)(2616005)(6506007)(6512007)(478600001)(36756003)(6486002)(66556008)(66476007)(6916009)(8676002)(54906003)(86362001)(66946007)(4326008)(316002)(33656002)(38100700002)(8936002)(26005)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6fKD28jH8t1XDlmusErUHrezMT/tyXYMqivc36fjpeKwougPgjA5YnwZqJm?=
 =?us-ascii?Q?lYxCHoD2SczyL4uBYNHR/vlGLXGuSw64ZXeNE/Bsk3VwwORQMRG8oSXfZZ8J?=
 =?us-ascii?Q?e7/dhhUTSEXQqdtLXJdVA1SdZ1m9ABXRPqHg6dRPrKmPQTS4718jU0asZfg+?=
 =?us-ascii?Q?Mcqsbl86R9PKgrVmSFPW8lC0TKQ4+GdzoaZ6MrMBy0jhP0lGEiUHKXGW3SFu?=
 =?us-ascii?Q?UkHM0ilorlzaIl5/uJX7UpZ6VAmB38SHLV0pX0RmCAXX9uIuSZ7cyrf+85U/?=
 =?us-ascii?Q?36I6rv9Ev3dt/TKjUJytG3XjMs9QvTbNpcqIVyU9cXpsoO5i6dsDrTKFnUmV?=
 =?us-ascii?Q?yfeIXcr8MygojbZ5rgNJ9LZ7nUW8IroKBvMwhDYXRy4XKxKkeTyuLug0wnho?=
 =?us-ascii?Q?yqQ9uPoQsaQ4g40wp2JDehuY1g5v1oC8RDnp53xg3QYhiw/sbcfldtHCdDLh?=
 =?us-ascii?Q?iY2yUf33msxo9VthwGTRJkWDiIhEtKOqdlmDvYSyoE3DzvlT5zPrlGOqsEE5?=
 =?us-ascii?Q?yfh/eMLio47va9HZydD1mp7JY5hkc5+f5YPoKe6O8S0qITFtCnVcmHWb+6bC?=
 =?us-ascii?Q?W9HDfx/PrlXaxArS5EwLUvyJlBz6xa+TyMQ9k0jYjsKFBqpUj8wAq5Heux5c?=
 =?us-ascii?Q?Vw0Xq4WS2sLfURfK9xcaeh1uh5zY+n+C3ATCadSXUx0RysotI5aleIK8MMr4?=
 =?us-ascii?Q?vrOeiHmTCSUFfJMyMenpmGsqeyibaT2L8Xn/rG7KX0DZL5TuWSPjXQZhMT95?=
 =?us-ascii?Q?mPWhoXRcEPbQrKZsTU9QTjEdcIoX3ve5OdcPsKQKIbQadDkYZjKa73AkN27m?=
 =?us-ascii?Q?U+x5XOZlaFQBxjant2swbut46QmgSSdfsVqRZYscoXZk+8E1SRJVLbdDlOnM?=
 =?us-ascii?Q?3ucL+bOLpYmWuuRH7MBONlisd0f0lVRstSCmtoPLN5TlGAe5Uzh5X30phNgn?=
 =?us-ascii?Q?+In1/ir9g2ag4r1rZdENt5TD24RaGcv0+k7H/bWwXsCTp+btPB1rE748/u9j?=
 =?us-ascii?Q?KdhIctMCnJoDfroLAtn4RLQTLQRK+DdfyUv8QfpxPccq4lJAL1Z9jPuwW/m/?=
 =?us-ascii?Q?7Hh2799zKyVUgP9IuHdpJSnWtREWjd38tlAKt0j6xiPLb175Be8v1Ik0VLy3?=
 =?us-ascii?Q?uBBeJegthycRzvbmRd2GPYKGms4ziu2xfPoBo3c/8kS5jFhNtFekxCM7Y7Zr?=
 =?us-ascii?Q?/rRHwvIbMs/jhEkf9FVvWPbJbjbOlZnfcA/ULZ8sI1GX3EWMZ+M9eYr6dpIC?=
 =?us-ascii?Q?09v9HIpT9GOgrJ+80iUQB0AZL4DHSJA9sEvn/qNcFNkvcyYhitDJ9cr75ejv?=
 =?us-ascii?Q?a+wvlb5+SkB9RYavirY9SFNU78jrLjnRomF4FcFFy18bqKmtN/YDvYg1j+XH?=
 =?us-ascii?Q?9ZFM582suYC4EUO3tdD7nc9uIBw1+F6l2nJzn2V6BgvhWo6VsiUuUIs8DdWM?=
 =?us-ascii?Q?X/Q92rk34DZ7rQwCWVazY8vXWJQlR02QB0m1rU2ul6A9xA1R76Ld+tDyHFEt?=
 =?us-ascii?Q?goqvhpmn/DZHTua0ecYdJEF/BCzMxssA3zKxLZuRmOoB0tSpSk4aRVlIzjWM?=
 =?us-ascii?Q?xyRGdMtw8w2D/1lXyhDBQLzikgWSyPWoo9r7ekns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e61bf-394a-4479-6dfc-08dbfb276a9f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:31:31.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0F89YniDgzm33h0gJP1QBDL3Q3/TGlerhmR8D74Ex+wAmEWzYU6oT1NQEu5aLqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

On Tue, Dec 12, 2023 at 02:20:01AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, December 11, 2023 4:08 PM
> > 
> > On 2023/12/7 16:47, Tian, Kevin wrote:
> > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > >> Sent: Monday, November 27, 2023 2:39 PM
> > >>
> > >> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32
> > flags,
> > >> +				       struct vfio_device_feature_pasid __user
> > >> *arg,
> > >> +				       size_t argsz)
> > >> +{
> > >> +	struct vfio_pci_core_device *vdev =
> > >> +		container_of(device, struct vfio_pci_core_device, vdev);
> > >> +	struct vfio_device_feature_pasid pasid = { 0 };
> > >> +	struct pci_dev *pdev = vdev->pdev;
> > >> +	u32 capabilities = 0;
> > >> +	int ret;
> > >> +
> > >> +	/* We do not support SET of the PASID capability */
> > >
> > > this line alone is meaningless. Please explain the reason e.g. due to
> > > no PASID capability per VF...
> > 
> > sure. I think the major reason is we don't allow userspace to change the
> > PASID configuration. is it?
> 
> if only PF it's still possible to develop a model allowing userspace to
> change.

More importantly the primary purpose of setting the PASID width is
because of the physical properties of the IOMMU HW.

IOMMU HW that supports virtualization should do so in a way that the
PASID with can be globally set to some value the hypervisor is aware
the HW can decode in all cases.

The VM should have no way to make the HW ignore (vs check for zero)
upper bits of the PASID that would require the physical PASID bits to
be reduced.

So we should never allow programming of this, VMM just fakes it and
ignores sets.

Similar argument for enable, IOMMU HW supporting virtualization should
always be able to decode PASID and reject PASID TLPs if the VM hasn't
configured the vIOMMU to decode them. The purpose of the disable bit
is to accommodate IOMMU HW that cannot decode the PASID TLP at all and
would become confused.

Jason

