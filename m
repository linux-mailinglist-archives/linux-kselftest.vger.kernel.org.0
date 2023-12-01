Return-Path: <linux-kselftest+bounces-926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B607800070
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 01:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EE7B20EE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E87EC;
	Fri,  1 Dec 2023 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLmoc4vr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F610C2;
	Thu, 30 Nov 2023 16:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZynmiXSlwhF4RUtsUs/yIASaSAInALHwViD/qEQ/fgsFeeJg9KkUkAEDvURq403LQkY17qTBPNJqrhsCqHSzYmKly2BvxbIaTEYzJL/Uvd2VIDgsZsrGzrgE3Tjj8KPXO8NIV6zV43eNG7Y9lQEyjJu/OZTUHsY+gX/RCvf0ePZjcNHkNRV3ZHUREUmlf10aHXF53E/d6hR+FxsiEuoNOqIxPt12ibZA9sgdad2cRyVpjLXf3kA2cRPahg2bhIuiWI0fjRr10PSwNwSKgNiJ9F2NZNXjcqKqIog2X/4fkLgrfR0JorXAEMY9XVj96ty1XYPNQT1m9vqg6vdzYNQ0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOjsKxdFIWMtTtt7eSoqQIeoVE2+AkUIJq5B4CkdvOs=;
 b=lLloPFe85ezCeDIWvo8Hop6AgmRZfb8RhrFRDof4B58fwOZdXteAnkm2eQdIn4CcCCUDJxNTsaw1V9Pn7YDYnBnqu7z0jmUrMcLhvYI+HNZy6Pq2bC3D6scNNgvd2z898QI8p8wzpujbQ36ghfMpWujMJSfreHOI72hL3EU/lGiAaqplxo5i2ux6MrM6SxbDYX1Sgf9x5R++EBN28O1Uq0rRixfLMntr+iwKbaxniMN2QkRXdwL7mVQ4bcH5vT5apS1v/PFPDwSa9dKHaCk3/NPuqz5Xqn62aGmMYPAX/gtPZGPHadDHFHp0hmBUGq/sZhyNKqGq5tzBgucrcRp6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOjsKxdFIWMtTtt7eSoqQIeoVE2+AkUIJq5B4CkdvOs=;
 b=gLmoc4vrUR7MqDCoiMMrZrOGy9XkgJuUdkyzc727iqbo18VQo+3fayuPRVviuepPDHSHP0IYoirSxqt2g87fgJrSZxmJo6soW1RcZo5X2qHcMZqX6Hxs8DY9AWi+4QBem48e7DlNnd6Op7kFWE5Mf7c/cU4UBLecckPBzHREAqnzM1lag33oBrm0002DhJuxBCnbP+Wsz1plSfpZ2d/Xq+MhHONouGVRPWKunGbkne03i5utjLwlNGpXoijLWusKota69LUguUNG1S1KlkH9C45lTR7tqlS3RRpHzD63wsubc1B4TM9zwZkNCnBkI9HrmC5LCXpzVO2DAb5tmn+YrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:45:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 00:45:25 +0000
Date: Thu, 30 Nov 2023 20:45:23 -0400
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
Message-ID: <20231201004523.GJ1389974@nvidia.com>
References: <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: b9193dd1-c593-451f-a729-08dbf206ce56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oRG5ljgT84xbzjBZnl8jCoUBR4KhMZ052hb8uwarPeMmC+Ul4DhF0ib4tHig3tMC7OXRT2Oe0ZIntNhE1OGdotPgWalXiDiZJxN4d49S3br89L8sp3rWRzJ27IudJQFnthe0k05fW578j+sJEy+1N3nXzaMQFatUXLgfL8HJRYg2jHh4Bk1iS+uUHOrF2CEj11x6V9gdYpu+N0uY4amUhb8u0yL9OuRanFiW3SJqFSx5KbPc+aqxFCZ+mju9iLyXCytZAcrQISG6JoEMik4juNrwHvrePj1iBglGKcYHm62mosNRRsnAngBJkk0q1L6aRoVxBurk9sTZNqMgigMvVFAV5xdi7M/GNAHXMCRVmrNT0howiPslxHlyXVR5VQL9VmR/GxBM+FWPv1rt/0WuwdipAdSB5Lt4s82njN8t7PU15NFZUhNhIaEWe0+hkE78CBibgDW8l1ofKOTp8qmnUlfHyyRsAK2ueuN0uvZf/0+6842tX7o7jVUW7S1tUXX8xM9+DkD0p+6YbRVZ4xEv+YHL4RPqhJctja9UD7OZK1QRNChH23RsSdLTRYd5IAwY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8936002)(6862004)(8676002)(4326008)(36756003)(66556008)(54906003)(66476007)(6636002)(37006003)(316002)(66946007)(2906002)(33656002)(41300700001)(86362001)(5660300002)(7416002)(26005)(83380400001)(1076003)(478600001)(6486002)(6512007)(38100700002)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chAu73OmQUzKoXjfB+rfLk4N6MIIpiiYW+kbImqoXPtPyTKkYGLJXVjn/rsE?=
 =?us-ascii?Q?taI5B2U98Zsmd7624J3aKHT/pOJWCmIORVunDxeoWUZkrWSgYQvHGviGjS29?=
 =?us-ascii?Q?/hTCGrzu+Zf339H1euK7qSXUcrdmCWgg4ruldP66/ylpsOOlNo6zfLXKzm6T?=
 =?us-ascii?Q?gCBLoVdeZCKPR61yXtIddfw5o3q8TVIK8iW4L0/vNmhJa9tug6TD5Vz33PX/?=
 =?us-ascii?Q?IITMW3LMN0Bm0RHE77Bf7xURbTZlodpt2/IwTYS2dwmgLjyIJfMp9Rdc7LFA?=
 =?us-ascii?Q?wD2ExEZsftU5Bfuz4OlYVAbQKSlvnIKXy/fVvwzyxoHCUO1QK58aDSWkw9j3?=
 =?us-ascii?Q?sdfLPNd44pT1ehlUYRO5UQcHid/c4EqGna4Z3POlXRjtQA9DmTz9TocU8XL4?=
 =?us-ascii?Q?hNdkrBfrNrgKJaY7BRuaptYN1CosAG9Mkaeix/2tEzqhQMShU4qxNUen4jOk?=
 =?us-ascii?Q?3fCi3KqZOtyTua1+5wOsL3HVZMYu8HcFbLypuWIsoGtgobTmwPi0zBJphMOg?=
 =?us-ascii?Q?HnErN581x8phHfPeLXKHv3JRslMHg5M81VwiAtClUmu2fWui1vMZAiWacAkg?=
 =?us-ascii?Q?frBEPosgA9HT0PYQli8i1bZtBoJdqdKTH5fDRJYcsv7c0WaAN1UYecslhHdJ?=
 =?us-ascii?Q?b67RShGmTAQdz+kyc9NbpB/vGaz+Nq86IvwsVWGl/OsPzOTwB1PrkK1cgkbz?=
 =?us-ascii?Q?Hu0yqFbaUQcch2MexSfMRXbFsoW8WKb28utt9C/X3purG9QeIzofCb6YYI3E?=
 =?us-ascii?Q?AhRGmGkf8CxKZT4KPOaWqSyv1eAHAsr6Ug1+f3TAQKYmt8FdFCqMghSHdEne?=
 =?us-ascii?Q?wdJBcB+a60nJaTwOf9j2kuDWLA/y9UxcHyCMXWyYlh7oIRP2367Azf/d8BrY?=
 =?us-ascii?Q?Z+QkT4UThSuBc1AbUe4CqZ3MdpMbZOebFFfN8hh0YY6sw93mwB74oTocgWdi?=
 =?us-ascii?Q?ZR7R/8xpSWX1Q6TTmtaw4x1PgLpZJI86d2surzy5xFPoCO0QPLy3nzWDqIOP?=
 =?us-ascii?Q?YmbP9/It9FwvwLcZYzMumQNWA7/Ncf5nbeJuTWe6y6DgUK2HMEWhdhDiximl?=
 =?us-ascii?Q?uM/mzl0Lw3E/G5EGfVhKb6dON68ZqwlfaU9yfB4TyaEox+qVx1B24/E1z+ZX?=
 =?us-ascii?Q?/G32dy0w7/rbzFu/TnZ2NVHeX8wTnWQAVBfRCz4kaD8mvsDUtOsBlW5HX9v4?=
 =?us-ascii?Q?Av6XxGfNTwa4pwxjSXRpPBX16neDdLQ92Zh03lU0KnT177omtmVYb8OBEeVK?=
 =?us-ascii?Q?i9PHgkKf8Mdj6HyDHauIvYQddiHr+dHCuanRTFDyKLzQONRry0kVhhR6H9gk?=
 =?us-ascii?Q?ANYJ3ahSNhm3to/JdXcAUBP2YHz2OPz0ltTpfAN3vHFZksSXXLI3pjX6rtfb?=
 =?us-ascii?Q?xYXRB4CTemVbNDJV+9Wh144eDExpYtMNgduNWylqxrp/R4mE1G9Xv6AbIlJU?=
 =?us-ascii?Q?OjxFQdUZCxitbmMsVrTmf+X9xu27LHYXNk00NfKr6Lfd7yfj80IzxSWS3i2p?=
 =?us-ascii?Q?anCqkol+UstqnDqB2ogp4Y77rzwB3GqIHgzsc3JEgw0cD3fscjy7rg0TtFLI?=
 =?us-ascii?Q?4jciWWNGKQTnkTBCtzFTHqHi0tgMcv2V8Ww91HVM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9193dd1-c593-451f-a729-08dbf206ce56
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:45:25.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNAm1m3Topjrt+n4jbb9hYXLYNK0dwVra0CNjGIOu9+9HjmMK7ebdnF5VwdC3g2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Thu, Nov 30, 2023 at 12:41:20PM -0800, Nicolin Chen wrote:

> > So userspace would have to read the event FD
> > before returning to be correct?
> > 
> > Maybe the kernel can somehow return a flag to indicate the event fd
> > has data in it?
> > 
> > If yes then all errors would flow through the event fd?
> 
> I think it'd be nicer to return an immediate error to stop guest
> CMDQ to raise a fault there accordingly, similar to returning a
> -EIO for a bad STE in your SMMU part-3 series.
> 
> If the "return a flag" is an errno of the ioctl, it could work by
> reading from a separate memory that belongs to the event fd. Yet,
> in this case, an eventfd signal (assuming there is one to trigger
> VMM's fault handler) becomes unnecessary, since the invalidation
> ioctl is already handling it?

My concern is how does all this fit together and do we push the right
things to the right places in the right order when an error occurs.

I did not study the spec carefully to see what exactly is supposed to
happen here, and I don't see things in Linux that make me think it
particularly cares..

ie Linux doesn't seem like it will know that an async event was even
triggered while processing the sync to generate an EIO. It looks like
it just gets ETIMEDOUT? Presumably we should be checking the event
queue to detect a pushed error?

It is worth understanding if the spec has language that requires
certain order so we can try to follow it.

Jason

