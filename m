Return-Path: <linux-kselftest+bounces-6461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3288858F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30D81C213A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE97605F;
	Thu, 21 Mar 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9SEt14e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77776036;
	Thu, 21 Mar 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023666; cv=fail; b=jfyC+IPk8wAA9MzfaIdHKnIMhqM8KZ2dsE2O3eCk+mTTT+N9r2QPJg8JJR7hqtoIVNM51R6AqdfEWM8WOReujHffH5W44DpGaxnNRB2hHD7xbmlPvLqN1tSUoHK40VfOevVAcK9/cmKBMRmPzAAfKvlmU3QcdcZ9RLdOPyQq7Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023666; c=relaxed/simple;
	bh=jQPd6cvsVu4mQktSqBfgcngJrfIVtb/wBXVFYZ9GB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ST6c+IhgmZ6y73JyjvJT6lOxuCH5N5vnuml65+0vzujAKxSicnpMtckp217yDhJ1Qu6eAMtOmOR/85ROANJ4Zg3XK8IM4Hl6CjFyNTS4z/tGoWykwT8Gy6gnUXhhUI7K8hQuUMSGndKTBjJPuGOsE9YUnDnhwoZv4pIVrCQvI7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9SEt14e; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC8UEQcqAKhpJXfGmiY1NL5KGD2DOALOh8owgQ1kGepnDQcNmRfM+2BYSRPfhmjHUhcNRpKOFkHyI0F4G+TPI0Pi9b/EJ9NHGtwhNQSiW+5sZOLGy6c5d9JichG8JW8p/RZXE6dPPZHaooYLPvESy12nSsfhMdPWp4SOmRMHTqSKbAXBtyuhFCljyhdg67DzoaANuo3qpoMoSW7lAc1H0XWThyKZtY4hHEpMHYxmnRsq3ET0qDTz1iPyAlZcMFTcsO+2v8E8AoHDStCOD4lCfBiiflF7y/p+OS9Qkr/OpPcTgVDLwgJzTqKEn9uw2jVwbQ7OTRTBY3FcWsus5BdXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT8nA4i0LOk5junzXH5nk+eGkTi7XKyhTzr6VFE9vCI=;
 b=hhVhcasvSADADVGK1nNKIZ+8R5bTqbtX3ErszqF5jbIsre6Vauf06uZUMSm8iK9TiL0cw8jbfIIE+ctuIw6SA74j0arv9KkNKQkpT012S4eg2z32Uy9U0g4fnbvSmlCtJC1A5AKG6ath0GNUWT/Epeo4RGc0wQCaXXZqF/blIb6L/P7ddpBRKGttq9r/2wEDFCLocFnMwmfqa3U+60hxlbyfEK9Icye06KNY3RgP18c4HL5xIEJnW0/gsIe4QlUXs2vDH3U/GTRVGEuwohPpWN8vdH+9916tvmt1b7P6+Jwp5ogxqg+Skk39iQHCfI82PmSA5rNBn6+/eT6rOK+Tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT8nA4i0LOk5junzXH5nk+eGkTi7XKyhTzr6VFE9vCI=;
 b=n9SEt14ehqdlXCbRrcaESHK7qDSoqiwspTn2ABikmIjj+5o+OBSAFyExhu8jb2NXyiemE2cRrMVApcjRgBO8yt04TNjSZ/iMSqO2SWsix1mYbj7jeiAAjXPn/Ck1Qg7tbS6bkQ6ORIUyglaXogDtwu74HTycpbtBKZxAXcge76dvC+sJgiJ0L3A9Lvfe+fkEmVFIcNef1tc2xBSF7kif+ybomXWBK7mmEYxO+dZZsoKC47JPVBPWF7d4PlP+GU6AFk73M8Fo25rA8h+tGvw/4ITG5l57E6cLE+mueistEaWR0HKDow4d0pBnLFQyTFNzqlG8GTg5XC3bqwWOZbkcTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Thu, 21 Mar
 2024 12:21:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 12:21:00 +0000
Date: Thu, 21 Mar 2024 09:20:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Message-ID: <20240321122059.GF159172@nvidia.com>
References: <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
 <20240318165247.GD5825@nvidia.com>
 <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
 <20240320123803.GD159172@nvidia.com>
 <65c517a9-72dc-4342-b2f2-c3c44735bfad@intel.com>
 <7a4777dd-2359-4bcd-839e-c2d0b5f6be14@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4777dd-2359-4bcd-839e-c2d0b5f6be14@intel.com>
X-ClientProxiedBy: BLAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:335::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d5742d-4024-4f24-33af-08dc49a15e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VwPUh74zcyOir6DFPClVxZFKgm6l8KhFwvb93BWMlGc1GpprObBqMXMDeHnfual6Fu11hvtEDMmEe4YMh/SlJfrb/R2od9jpGOC3U1ubZsdXGHzT7fylR8wZhF6a44LHYl34uuMiXaaZne+wMuVGaHd+sc5w69WZECryMTrblix2iVaIap/tZHBLfg5gp2RopdASJoMakeIMdY8WmIlRNJJJ7+iljAp2CwsxDhF2uI9gZlIu+82reMef3N43yzGi/1/WEykY8+TUnxiaLTApDPDTlXCgxW776l3UY6Frum/rUot80V8s973mf3bOC85mBNejYJXAY6TZDN72W9mDqo/FjWmGGuqipDbsqcwIY3SnDK/Cv0KnTXewCvCkShJ7m9bE2+gDS+QDlZdET80aKuMniDwXgdVy39ypsc762RIe61YiEpH/KEmWuFr0ijPJbPeRkqzFIF7n9MLGSI3BuCYvt5FS6rG802jpBMXxjCo6ruKSw75STZfUsKVk5pYCmNMiE3Pq3bQEyWPCspydgfzBbNToZt8+/IaPmJyz7G0jBa2NlVu7tEQ830TN7n82B3uSDMKLZ5FSkOoOCh9kxBIwC2LzO3x5qY56Lhh4C83lIU9yt5jDjEsSc3mLehlCIjUZ+MQOnHs1qmJUVt9OVxwrX7gDLPMHbryWH1AV7nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zWrlVUZyxNYv7TY/qnbzek2HMFETLZ/Kh4rRtLn5TB0ZM7G/7Yhh5vans7x?=
 =?us-ascii?Q?scHwusie6tucSdOy1yWDPgEbczh5wfh1OVZFMa9yqT8mF3fgTMPb47NSGVHN?=
 =?us-ascii?Q?JYeMZqFnBAy1EKKfT2nwzBBKHFppUXlhsSIvrgIUdEnwGO+I6AcUM9RaipOM?=
 =?us-ascii?Q?9kNm59lrlBf+JtqoYp2ZykRr6sXXULSODOWraTL82GfrHd12PG/Z/PWz3KXc?=
 =?us-ascii?Q?RQXNaj0QhdmmCn7GnV1RhSkxYBzPKFaCrC8FYv3GSR1UdLBTKYziedE4RbwN?=
 =?us-ascii?Q?5TSy24h6zGvRE1GzHroO04A/OfMNEDX809Z5RxCeA/ZGmKzpNl7EoEyuZ2R8?=
 =?us-ascii?Q?4lDSKKmM6HEPpA3J6C/vVcr0vfwWTfA+C70G2KOKAsVPOlvwP58a2fWrrEWS?=
 =?us-ascii?Q?Z2b91y4AWOm2RQfWntpXDluRGpwpL4GixAZc5hPruS7Mcoriu2VvQ1w73nXN?=
 =?us-ascii?Q?jBQJTykxV/fBVEs+o4COmstn/hNmMAc7mDbevizymJLkmHK4tKBCNAjm6KW7?=
 =?us-ascii?Q?eRoCw/EFCUy8LSC42vHHjcOgNQgDJginBiU8goB4vXo6r3MNeHcWlmWwqerQ?=
 =?us-ascii?Q?4M0skb24uPns7XAOxUPr0+YYL/InDBLNrL95/kFPsHP+3/uX517t2LDv66St?=
 =?us-ascii?Q?A0mYo21z00/KIKPJ0ZrFDij3JyQs7GUXzFe9lJpzH/weO+7df+RGTf1GONqe?=
 =?us-ascii?Q?7DAXOORGPacvlh2srtCc5Sl4MS1opD6KPxdWC+c5NkSfc50YU7xyWOZgo0pk?=
 =?us-ascii?Q?Q4KkQmaNI5IScCEolRLkL/C4U7XhsOQahgrnKAz1sMq1m9XeLjQRvtG6Pxre?=
 =?us-ascii?Q?jXLs00HZ4SX/O5qUddbmg0U1uz01FVmDv+SN6sye2mAy8lzEvrbL3WP4+Km9?=
 =?us-ascii?Q?B0ekQKrRLVaMG9+P3e3fAXKoZWW8qa/OUQB+3bzg/W6h/VtUPs9f2HbsKxp8?=
 =?us-ascii?Q?MPxY237fGf9q+BMLOCeJl/1Pc8mNdfuFQubVxYN+S17xH2BGNg1v9GchZXEp?=
 =?us-ascii?Q?yAV3iC7fos8WRO2kHdyTVZ0HPeclT0ULe7gWdM3fNtf3kGiV/KQLVRthLIkJ?=
 =?us-ascii?Q?u1RT4ydfytDf0UAVmYIFTXMV7Yb5z3q3Tn4tdK736kOr+TIdeqHiHNnZuY1o?=
 =?us-ascii?Q?VLkIVmpRDZJxHxK84ajoDOXo/3ikKxXi0EMuQcCqn07lMqdowBCXZ9InLIRt?=
 =?us-ascii?Q?95e4Zu7Tiit0NU745j61mIE716N4A+X0qPSJoIpDkKPYNSbpCij5J9NYUgOo?=
 =?us-ascii?Q?as5Ku2uzWaG3njFNQrubckEfusc8qlWrEdP39dusi6z1yg5K1TmWMF7iW0gr?=
 =?us-ascii?Q?4qAL2SqyHFYNJFd+y2I1ce6QYq7xjVBUmmk6Kqd//NyO6+bd9X/bKlsdaNyt?=
 =?us-ascii?Q?QSKmbNzMBazGcSPli44PM6bnFWbkz6b24GGclq2sH28bi6tZuB+KCDK8MpQF?=
 =?us-ascii?Q?RnsPVa2i4hNXSYPo3Swssvjz3feZSv4+vNL5XNRjYjTB6RMDhHpS09SKmVyb?=
 =?us-ascii?Q?8Tdll1v6la+3+WUIOFJPR1i+F/pPK8Hx+cct4Y+oEdkorV6hmxNra0tTuMqV?=
 =?us-ascii?Q?4DDIZmCMZqDV/22SxmYUUd57fuqPh8tiadviIAnR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d5742d-4024-4f24-33af-08dc49a15e5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 12:21:00.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzOUFdPR9Mpb3auK80b61qne9uemaiYPO8MvN7CUqyU4Y3cbS2n5NqrdohcqoEwu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On Thu, Mar 21, 2024 at 07:26:41PM +0800, Yi Liu wrote:
> > yes, the correct way is to undo what have been done before the fail
> > device. However, I somehow remember that pasid capability is only
> > available when the group is singleton. So iterate all devices of the
> > devices just means one device in fact. If this is true, then the
> > current code is fine although a bit confusing.

Platform devicse don't have that limitation.. It is PCI only.

> > > And the whole thing is easier to reason about if an input argument
> > > specifies the current attached domain instead of having the driver
> > > read it from the xarray.
> > 
> > yep, will correct it as a fix patch.
> 
> Hi Jason,
> 
> It appears there are two solutions here.
> 
> First, only undo the devices that have set_dev_pasid successfully in
> the __iommu_set_group_pasid(), so the problematic
> __iommu_remove_group_pasid() call at line 3378 [1] would go away.
> This also makes the helper more self-contained. Draft patch in [2]
> 
> Second, pass in the domain to remove_dev_pasid(). Draft patch in [3]
> 
> Either of the above two should be able to solve the mistake you mentioned.
> BTW. They are orthogonal, so it's also possible to apply both of them.
> Which one is your preference then?

I would do both because I also think it is not nice that the drivers
always have to have the boiler plate to read the xarray in their
remove..

Jason

