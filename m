Return-Path: <linux-kselftest+bounces-852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E27FE488
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 01:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010BA282360
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8350385;
	Thu, 30 Nov 2023 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5+sJXoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D44CA;
	Wed, 29 Nov 2023 16:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnD8NNFXZ4Dv54t6NgzDSatk8KyYzSGyUJhUEnFZXnBCLb4h27ZTrnkiruIFBHvyz5/BOLH0T4eZuKJ1wPr9Ul+BdPy6VIHsh2/4KpEks1vReHSuGu1gp7gyDfv3Z77GPWLwKzHoeLLg+b9coV/6/roVT+MIbr/US5lgj0ony+GglMW4VrwZffFYRpQFHYkXjEh0IZuX/6ZYY3TrA3kGifabQ/F7ovyirXz9plYH1csU0/3hkSwv4xQ82yFhDn/am9y0SbWsWkMHKhX0GOR8xpM2dUWyqN18WAyo4TpqA3fEEaqhB4R8DUpYYDEdU6oED8ikSifFewoBQV0RCmz0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE88+nCWAZZNSCLyGLpVZkQSDUQdOsJ6oiEbv52t+nA=;
 b=hYAK8G1nF7Rx4800skDiax6TYcGa068pf8XCOv7pJb7OkP9A71DZI1k9yXWSGtOmrOug1gl9jVasirf2iakmiLI0I2uOA5r7XUW5XzqdERhMjUT8mMSEoaLF7DbkfqtgInR1PR3IDE+Tx18x0D8HWDZsPXhRWB4DJTyHAeKrS3XCtEFVu/HHX8zeY+iOtmv0BkfdB7Rp0zGAGabpZuO7bs4tXyC2EAqKnmuhuMQYliHzLGnLQ9Pr8jQYoy5ZnSwsFFG9RQoMisIZwGE+/ovNTs6s5rLkbcCDWMimTnReq6axUFphWikqH4FnOGWB/Wa1ZB6RvlBkXTxhCoeN4hWmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE88+nCWAZZNSCLyGLpVZkQSDUQdOsJ6oiEbv52t+nA=;
 b=J5+sJXoJrQh2Anzoau6oYmbBxzMg+78k9dAuGWjGSZ7nrH9idgArACvItCZkiiW5jgVTSVdfmGZel1aU/BvcPDhW6lf+hGDyegdcpiVXixr+DHWMjEDHvcWORTiU0m0vtykkn5feOOI0tbCv3gA/fJHVmdsylyvFUmlDVvtociwKHk80nWsvy6i4ef2kpmine271SOd4YxTcThU32XnGIhUfoLwygSMqa/5szhx8ujCsg2eaNHsYtI6ZkQ7lHFNRmpOpWAN+dQ7/JPS8fAV7H4dT8xaqMrMRzPHCDKWSEzCFTpdEIaxxK381fpXXNpiZzJXvbQk3dBqIIfVzpIkvkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 00:08:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 00:08:18 +0000
Date: Wed, 29 Nov 2023 20:08:16 -0400
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
Message-ID: <20231130000816.GB1389974@nvidia.com>
References: <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: c61fa23d-f448-4cea-2364-08dbf13874a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qlCS5fnmzD8kZWjahUXBUGaoMsQPoHzUw0FgCcrG4gJvsVnB9FD60rACgNj2OF9eWx6d5j6J5q9rb/e+BEI/2rQnMzC7OEJay/sTvMEyRE1P3m+VrET1Ad+oieZPG7Ygk94Kz4EPpFUnmBuN2dl3oY7KRf3HQ9pvmOoHkgnuG68aK9k9HA1Xd0Tz3omY3s3H1ujGJiCjRRXL83cBJ2tl84AJMbV0Cnp06JxGBO+mMeWtW3SqUHGDulUyaFL+T2C4ZyRDHCJxZf36nG3+NS+QXvKyyQTM5LlETfYQ283D0FQvT88c9zBjqR1yNu22Y3vjKoWN951w4e6D2g8B45dQsahMT4zkhL8nEf26A7sPHb8xx9YWb+bsyhEaRClDkQ8M8rTWlj3WnYyxg0zCvrPun5POOoAmkKUXpbPxrSeGhLKCNsZ1/YAkqLwKJYZ6/zayt+atj9xWsHsT8h//3crEmzaZDLCWC0wk+LOEamW8TIV9mgglbho5oAVU5LZO3WE5Ke5ON7qJLaMN4bC+sS5GYGr641a/t+KbQK+w7tRcegY1nVWYkrRK48YEJe4dOx4PmrkYD38Lzjv+muIfvfGmmy5JlpltM4e+60UsEBDROwnhSjW4zK+VygeTqqk1Xl3E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(2616005)(6512007)(26005)(6486002)(1076003)(6506007)(83380400001)(2906002)(7416002)(41300700001)(5660300002)(54906003)(66946007)(6636002)(66476007)(66556008)(316002)(37006003)(6862004)(8936002)(8676002)(4326008)(38100700002)(36756003)(33656002)(86362001)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/r4Z81OPDtFfQIhYUp8rcAfxnSKFMFj8zb1QGLIzXYAPTTBSq7YNMzo/R6a7?=
 =?us-ascii?Q?nmQlSAME5vjlOo7I/mUksGoy0xeboHx/1cZAcQntoQ++L11LVzoakKh8V4XL?=
 =?us-ascii?Q?cW8duQEXvv5xYXPSAW2LL2UjwBXN21qq3/+ts+N0cWKN4+s10YCxIJVYA8Ir?=
 =?us-ascii?Q?E5QYP/KcrCG7saMFQVNWdH/ck/0j3JjZvUuPhSlCXY9Dy3GiN+5FIRbyD3Ud?=
 =?us-ascii?Q?o1bFPdkUCYZEHke5kLnRxaCpQAZ4Mj0WQ0wg1nfojfSZsaIARxlanNWpeDc7?=
 =?us-ascii?Q?0bzO3wkvron0q6vA61hwd1tQ/8alK+2P/PVIA0Zf3DiGNXJxEwZWsYM1kiui?=
 =?us-ascii?Q?5PJpNTYjF2spGrG6zcqFpOgu87lxyvvmfEaHK7JxBzDaunXvkBZN9aCPp9rn?=
 =?us-ascii?Q?j5xieXa+rZrR8Qz8NpZsI6cLkWNlhamjeL/j8DNmnkezwGvtCyczfu3f/lUN?=
 =?us-ascii?Q?M1EhLB9BJIZQHxl5cC85wpFNHOi9cVNrvlgT+Pf6Nv6DA4dBEnwfd0rc1dmk?=
 =?us-ascii?Q?ddj8FGlB+xJzQywoQNYRCsC4pUd9zSWtN+F4wi70Z0f5tRsGbRkONjRZ7V/1?=
 =?us-ascii?Q?JajHBJf7uSKhWQIyiin5FzRR1H7rkaHpTyheCRvBTqVXpPYcU59/ysDO9CiZ?=
 =?us-ascii?Q?UrfG/CyKkokTlRENUIW4SALZGvp9W7Ff8ZdPSATm0YM7ghHGlalxKEh5M7O1?=
 =?us-ascii?Q?YvzZ9fTbznNWWKT/XUAG/uXmNpPAMd90T4L9XLTlhV1rTHFfR5YrSqii/s+n?=
 =?us-ascii?Q?9Lixha8kk7mjAjHiUJCenXy0nuzrpRxoYKflcBlGn5nXlkYCiKjTIWRt1SpW?=
 =?us-ascii?Q?ZrUD+fs7vLGK762xBwQ0Eje5ISvnLEAielzSBXXumJhn+mrIj2CSrE7/mkKp?=
 =?us-ascii?Q?IMmutec9srDLWd6NsUhCvGDuzYrrM1hr6ERTSgGDaUzNhmiWrT/lEIhqA1IU?=
 =?us-ascii?Q?+pcXE+Vt1+hrjGQZ0BlQ367Ajjl+QFshEKgtYrAuDQ8g5A6InoEJBcptRM26?=
 =?us-ascii?Q?BegT9cYVse1p1frODAD+Skkxw52JXhbr8hYejaZn/hk3v0AiI4dBWVHnqU7F?=
 =?us-ascii?Q?b8gt4jrNd6adhQega5Ak+hQTmfu+aga9OeHngA2Zlec93YBqMAQP4Sw/bkrF?=
 =?us-ascii?Q?hHpsTwQz/EXAwuIay4WMeU80lf7MuuU1Nwu6bfRt/hiewWSC3ypQA3APrGTa?=
 =?us-ascii?Q?40GZCngzJEJKKfqSNxeNX3v83gBuWKDQfQZ8An8Q2a54Ff5LaT0RVmu81tcY?=
 =?us-ascii?Q?GhHfwZ5w3oG5lIASP/byzmf14XUJeA8oVtogsOncUBaO9vFb4sthpLW0ggPw?=
 =?us-ascii?Q?cRnOlkPpDa5vqIGRWzcAtFS4s3MF0w9rc+I2tiHFdLOU3wTXezZB4yOcEvhN?=
 =?us-ascii?Q?RujL8q9T2pVyGzQVpDv5clBX0SuVyjZsHUlcaQ8st0EpxSv6pOv75ipSo8Lt?=
 =?us-ascii?Q?IR6CgEEalji9UGmmbsryHMA7FI/ab1oT057n/2Q5JfRWO9JetLcZd1/2iNhJ?=
 =?us-ascii?Q?xUYb9SgCRvUZMWR1xPOUZH7Y9cD4gYpmzn+nBDgxjdYRVx6zSgl/bdTckAfa?=
 =?us-ascii?Q?c/EzZrbClV0jx2kIURd6xvhFA98DGtMcQhaxZpKk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61fa23d-f448-4cea-2364-08dbf13874a5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 00:08:18.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4nZmuRHYb60eN9dLVc3vIpwQWkDhYdbfEQSpOje5FVgebeiXH2wH3O3g6ioo95W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194

On Wed, Nov 29, 2023 at 02:07:58PM -0800, Nicolin Chen wrote:
> On Wed, Nov 29, 2023 at 03:58:04PM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 28, 2023 at 05:09:07PM -0800, Nicolin Chen wrote:
> > 
> > > > > With that being said, I think errno (-EIO) could do the job,
> > > > > as you suggested too.
> > > > 
> > > > Do we have any idea what HW failures can be generated by the commands
> > > > this will execture? IIRC I don't remember seeing any smmu specific
> > > > codes related to invalid invalidation? Everything is a valid input?
> > > 
> > > "7.1 Command queue errors" has the info.
> > 
> > Hmm CERROR_ATC_INV_SYNC needs to be forwarded to the guest somehow
> 
> Oh, for sure. That's typically triggered with an asynchronous
> timeout from the eventq, so we'd need the io page fault series
> as you previously remarked. Though I also wonder if an invalid
> vSID that doesn't link to a pSID should be CERROR_ATC_INV_SYNC
> also v.s. CERROR_ILL.

Yes, something like that make sense

Presumably sync becomes emulated and turns into something generated
when the ioctl returns. So userspace would have to read the event FD
before returning to be correct?

Maybe the kernel can somehow return a flag to indicate the event fd
has data in it?

If yes then all errors would flow through the event fd?

Would Intel be basically the same too?

Jason

