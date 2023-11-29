Return-Path: <linux-kselftest+bounces-785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A77FCC0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 01:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8BEB21632
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3A10E7;
	Wed, 29 Nov 2023 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFboe8Jm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A16137;
	Tue, 28 Nov 2023 16:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QibiT8iZ4SadFdjePh4gHhs8PZapIlBauDaBMvZ0wCgbLbUPgukvMe6WFC5KQj6itGu20iJOPMAsYWTSTrT7pgNH+K01byMsRhOqdwy/hND4/O6V4OmUAhJ/AgbYVLYtq8FZVrM45dOsSRprOWItf7wNGeBGed3KBiuKyjiLS0NRh2AowWqDeaAuiC8wSjMdV6XbvJNW6iduztxcHMSDczIxNoNKOQ58i4wxKywc50TvNtj3hGi9RSi6qMXrVcChECjF2BhaolPr3KEAu1VPaixdBaFTkYMTdE78imchiLmvZCr7KW8D2gt4osfaqgBE36/JY0ZaxGOkYC6mEQcpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4V12ocUeRn9/nHO66BTnzjSEUrVobZtf2LoWheKElI=;
 b=QalJpBB4S2ofSZj61MVpu2mnFIHzBq0G5U9fOcKRHYlXpwBa2GktO/yfZ3lnaJwXHJRbWhZuEQzLnMkHCu9cyD8Bm56aXR37toUIi82lHCtbn3+yPTXg7HjHhlT+BtlGzJ5K5xlDCQBfwaELY5JekJLNAaTeerISES/YHeRldXWfF8IDk7QQGTzhb0Wv4fIuNavPT5/dfywxGJa0r7bwonTP8noyzWwVRuUNJTt7FkDry6plL43KfSC+zyFia/9/pz7STYL3J+d63PCCsKIYvhQJBDO6YIMsW5JtL818M4mcATUM3st99k9j2+7HCKXH47wtrsT9RM3ZZGdPdjssrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4V12ocUeRn9/nHO66BTnzjSEUrVobZtf2LoWheKElI=;
 b=kFboe8JmZsJnHvf6w1Tm1szUxRm/7fK7LRDh8z7TM/+AzyMy3IV2TTTMhnFrRGhVM4jXU766+hKqkL0hTAw4H5ToJihzYKHNenIVHRD0eCaqmYmi+ma96xereJTRvQuRiIeNVZwOOQTLrTgmu8nv2VJILUbNokJ6+3qFA7TREJkhNhjR5XN84s0QlFaOWGT1ZOOGKHgdgYk0IeJJda3uunGqDsXOmNMI477mnyt0S5AxxgkUyZmxl9IA3n5FFG1n+hg/zhjEJTh+qOqhMdjlruLmGM+CowtXc6tMkXvcC97ML7NVqfAC2zHmlTaIGghZ2B6UEcUgUpB07KIazo6vpQ==
Received: from PH7PR13CA0008.namprd13.prod.outlook.com (2603:10b6:510:174::15)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 00:51:42 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::fb) by PH7PR13CA0008.outlook.office365.com
 (2603:10b6:510:174::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 00:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 00:51:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 16:51:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 16:51:24 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 28 Nov 2023 16:51:23 -0800
Date: Tue, 28 Nov 2023 16:51:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
References: <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: b93850fb-437b-4629-f2e0-08dbf0755a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	09thnlgSWlpeL27whKlJsgkhblM7dVQrgLGKz60dJoVHf2Eti/4pWLuX4gyQiuEOF+VMVUdOXOYajIR+YzCBCH2IipYpCYfO1/zccjgS2rO0WR22B2jWO8YEgjnUAK/SKiQ8WY3izFDQHM0HzFyt4A1PG2SnVvKD8g4idWPQuu62bIvKZGUeS4bsgdBXPFToSYgTL243f58iFZj3oPo/HRbmVgxOY8A0FP09JIy7Iy5JdmaCFOJKUcrxHNhyZ6J22QDoGNWC+TRLhtLiJWsjzgjb7PLsvtyFx+NJ4rHwAdX6LLaDAjw7/wXs+yVOklBl7XhrTP7XqDn9K0MhgCEr06HIJoxRPnJkIpz9MqOlIsavBiYFs1rUSrULJ35g6DUg96CDYvBRkpYGxwjk0o2GLbB7RlKfW/id/lsc4IBXecwrckSFGDn7KWC71qArPUFgkHnsHUfH89nGhh4QixkmjeyVHQhd6cOyMM+QNI0PTfWoyGoxseO9xVi+wvzbB7Un5DRSl5q9BaI538OSC2obTv+GgUphnfTq/m+ZtQscwmZmz1MAuf8Vy2LFk5PYmvfzWiHCuI+hs3VWsgW+DbYv7+uDmVpSH0GonGNtsfWQZczzpl2LWrwaPmVxQn7qAdSmOLW1M8KWLxTWiA4CLGQ3c96YSRTxkjn2zKKH0obQBK4Xev+7Mqi1803onF2oUhVVgENE6Qc0WV1VSkko8rnQZhtNRfMTFKsKECHVANTs5mLbI4sIBzUfj1l+y6agEO7X
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(8936002)(336012)(4326008)(82740400003)(426003)(55016003)(6916009)(478600001)(8676002)(5660300002)(7416002)(86362001)(70586007)(316002)(70206006)(54906003)(36860700001)(83380400001)(26005)(47076005)(356005)(7636003)(2906002)(40480700001)(33716001)(41300700001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 00:51:41.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93850fb-437b-4629-f2e0-08dbf0755a2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169

On Tue, Nov 28, 2023 at 08:03:35AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, November 28, 2023 3:53 AM
> >
> > On Fri, Nov 24, 2023 at 02:36:29AM +0000, Tian, Kevin wrote:
> >
> > > > > > > > >> + * @out_driver_error_code: Report a driver speicifc error code
> > > > upon
> > > > > > > > failure.
> > > > > > > > >> + *                         It's optional, driver has a choice to fill it or
> > > > > > > > >> + *                         not.
> > > > > > > > >
> > > > > > > > > Being optional how does the user tell whether the code is filled
> > or
> > > > not?
> > > > > >
> > > > > > Well, naming it "error_code" indicates zero means no error while
> > > > > > non-zero means something? An error return from this ioctl could
> > > > > > also tell the user space to look up for this driver error code,
> > > > > > if it ever cares.
> > > > >
> > > > > probably over-thinking but I'm not sure whether zero is guaranteed to
> > > > > mean no error in all implementations...
> > > >
> > > > Well, you are right. Usually HW conveniently raises a flag in a
> > > > register to indicate something wrong, yet it is probably unsafe
> > > > to say it definitely.
> > > >
> > >
> > > this reminds me one open. What about an implementation having
> > > a hierarchical error code layout e.g. one main error register with
> > > each bit representing an error category then multiple error code
> > > registers each for one error category? In this case probably
> > > a single out_driver_error_code cannot carry that raw information.
> >
> > Hmm, good point.
> >
> > > Instead the iommu driver may need to define a customized error
> > > code convention in uapi header which is converted from the
> > > raw error information.
> > >
> > > From this angle should we simply say that the error code definition
> > > must be included in the uapi header? If raw error information can
> > > be carried by this field then this hw can simply say that the error
> > > code format is same as the hw spec defines.
> > >
> > > With that explicit information then the viommu can easily tell
> > > whether error code is filled or not based on its own convention.
> >
> > That'd be to put this error_code field into the driver uAPI
> > structure right?
> >
> > I also thought about making this out_driver_error_code per HW.
> > Yet, an error can be either per array or per entry/quest. The
> > array-related error should be reported in the array structure
> > that is a core uAPI, v.s. the per-HW entry structure. Though
> > we could still report an array error in the entry structure
> > at the first entry (or indexed by "array->entry_num")?
> >
> 
> why would there be an array error? array is just a software
> entity containing actual HW invalidation cmds. If there is
> any error with the array itself it should be reported via
> ioctl errno.

User array reading is a software operation, but kernel array
reading is a hardware operation that can raise an error when
the memory location to the array is incorrect or so.

With that being said, I think errno (-EIO) could do the job,
as you suggested too.

Thanks
Nic

> Jason, how about your opinion? I didn't spot big issues
> except this one. Hope it can make into 6.8.

