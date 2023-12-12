Return-Path: <linux-kselftest+bounces-1692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A450380F124
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C901F21399
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4537276DBB;
	Tue, 12 Dec 2023 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FD50YnUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFDD95;
	Tue, 12 Dec 2023 07:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfT+FJeFGIMEJQ3cPJ6D+qT2+Hw6zkX8DS6NMbT7NhgpAT0RuWTDdx+LJ7kR2yKB+AgC692+ssB/UaWEb5sFMvg7dj4+CRgKLd7ytDodRscb7V6iAAsT+3QeaKS4Ak5gXhPVJdoTfZoYzavonIY96ilQCZcbb11Wehqas4MBRANjXxSQN2upMfIMWczVlTiGH/95ofBGH6y3hnpCGbKbehD1nC6bslWYDrEQWpporo6Z5hNkLKpxz3m1JP3sLhIyViYYfhe/1vXCRbLBvvIBHWQCG4y5Hx8gwWqy5607lcyzkvVNhlrjTU2x55sUkHv6SAdA1U4X3Ms66+IR4wZPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUMrgHmqVVlL5srQ3cIufu0V11MfT2Xjy6T+jg/iiJM=;
 b=mI4ZjZdWMFYRJMNf3J0I2N57FlMdS2tvkL/H7dUCtibhuK/zLInK3kYFpEduTcqDNqkVlE2YdX2zp1S1xH9XaO6g52tTPPZ37LNAgCmlC2jsmnejlWtr9/ha/SW/jqRlLHP6voKIPG93lacpNRrcaskyrKWDs+wLuBvfIroYGkFD3xEaCrRDEJn2QjbFafbGEzHoWxMDkZ5NED1WWaKcO2V3FY/U9MsKAQs8T2KalYicERqtjUkHZYllQtEL4Nwtz6hGGgriTaG6BLwZeC5+/URprX9pUotMBIcgOh4fyfgdozVDgSrUhqhRSrKk5Xc5C25teEbvgjJ5Gh5VxvgOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUMrgHmqVVlL5srQ3cIufu0V11MfT2Xjy6T+jg/iiJM=;
 b=FD50YnUr+yo94e2m4TP1WSNOM0gMsh1tWEfY+QK1pPWKC0qFd/ev3rAVDnCIWMdJd2c87dNbKjtZs4KLvS4E0tSQfElR61OW9hfQrylKyMWw9SdKA90AWHagkrRor3Z6x9szrbD2GJv6PfM+AWTZnmjF76s5ORyN70FHdnrRPH5kaAmzOqosY9WHJZKBUomhfGqb/IuevZr2zrWO2vfYRrFi9W0sm/zpbpA98wu5Mip6xmecAjUgybG095Uf2mcH4GwuKooKjS6qW44zYmWr1HC6R3YWKqHDOESt8JLii7jV28+W9Hw/5Rl94edIkfaN3Vy1FG96JhcJJeKlBT1CQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 15:35:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 15:35:05 +0000
Date: Tue, 12 Dec 2023 11:35:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231212153504.GL3014157@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <20231211181028.GL2944114@nvidia.com>
 <20231211114949.273b21c0.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211114949.273b21c0.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:208:19b::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8e4706-2061-44d4-30ab-08dbfb27ea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6rsgQMyZ/cg/RzfEyCL66AAZtHanRHA4LtRdizDIGxDWNczvblFnkGzeG68X/AyncAofvWxlwv685OEf6GCM0RpLGUJV0F4+C/XRsaSV65EeWNJgnMejbO+T10+DiyBniyD67Yd1qddlKgczjnD+MHme4e5137G2ZRh2vEEtAUu3uVwVSlw8OCKnyEUV79sUmYRpMQieiDZNJRyGecZ6J0nsYCocPN/5cmQ3LfR7BWN8MxM4eaJpKhiDPe41JbND6EjcCs6g1RXsiA7HDXPh82OqK6uFm2OtXCMY/YDoA5g+/x5PglCC+HUApzRuzvDLpUMnX8ufJX7u3PngVQuNio749CnqvaO/tsz+P5GngexAO/tQ07Ta71Mw5XTaXMx7m06GN2tLkKPNdSr+NVTDjmC6JvHS/2aFOG95WkuKXKyVpcVQ/sYtiIdbYMYi7l3GmpYJo71/66s0YLISwyetnzj9JXtPVAkgqyuzS+3RevwXGKHknH8N/sc+DF9pRVc2BZo0LwIAwNM4TVeGIqSjiK8x5HqQviySRC9fBqZ6axxRUnn1RX6iWkdHBxN4xNW5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(6486002)(33656002)(86362001)(316002)(36756003)(66556008)(66476007)(6916009)(66946007)(2616005)(26005)(1076003)(6506007)(6512007)(38100700002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/3pGY9YuUAmH/wOYAVmlw3Xm9Bh5LUrwu3nlH7PA8VINP7IjLm6tW6JBvkz?=
 =?us-ascii?Q?U5g/U7cSyMC16K/CqzY1DMlnF0XReiHpwayTgzbIuNSKeXiyrKXQ5JbzV8CY?=
 =?us-ascii?Q?P8DJ+QyPyaznsUMiKvkxX6AmhyPjw+Euo7BxDUuzRJiZ+J7pMmdDFp06UrCB?=
 =?us-ascii?Q?OIt7TfV5tuqVTgVaXrUypIhj6WVvJ9MDIQxshR+qjPSwrwx/TAs3URyILvIk?=
 =?us-ascii?Q?GBbLiJcWzubzNZZSsyC86njQ/Fvx1uuI4/4XXq9ddQu1b0EWsHka3GEDRpjq?=
 =?us-ascii?Q?C0uYEn7XRAoPRUwAnELVf7ViDNOVQOUnWUkv4gRo0QwlRnC98x5kBFCguilo?=
 =?us-ascii?Q?PsMyqIB89/2ehb44kY3BXb9CCXjPJvaUKUKRo3ZkO+J5QFs0crq6H0yfOICq?=
 =?us-ascii?Q?h4jtH6nDRcn0ZG67M2zK6bKj6QTmw/cIXBjRrlG5m9xr9zuw5voxaKBGm2oW?=
 =?us-ascii?Q?fpV0lABKNT6kiltVVO1DEjlz+xBljpsNQwwMQvjVGbfnluq/B7A/6al6WlFX?=
 =?us-ascii?Q?OjZKQVFTGanXY+gFa9Y0inFxlG/PlUpLtPYNaLSCvJ94KJVnspJK9xz+lgUs?=
 =?us-ascii?Q?E9j5PDpFeflKdnZ1Va89QGweTPlbM5b47ZqK+xv04P1JsMAT2Qt9DUPcwZYy?=
 =?us-ascii?Q?hiZg/KtHI2lXyoN/OOSStltxWDrr1GSOT4P+0+cFjhUb2cvMsV9Sg3eTvM8j?=
 =?us-ascii?Q?NHvShnlYWxo5B53VY68Ycr/+/UG6c5iTFsTrYvbK05OEhLVvkxBWyPhj+I2n?=
 =?us-ascii?Q?KGiTIDGnaNAfKs2UhmSKMLJQfiGnuUTLtpGr6Dr6La6xm6fLGvxdIqVmJEoT?=
 =?us-ascii?Q?bbmTQU5GFv2mY9s1ZLA0NbqaNm1ch/y5kxzJyVSQQVFJtGRjDEiPy3pM8PFH?=
 =?us-ascii?Q?usefjCaaMiqrg8bImTDSIm3ArsSOVJtzemW7JoefqRglLCeNarIJn+HOCXHj?=
 =?us-ascii?Q?J/yhIoj5tpqofYjE2ZqRE/FwbMebWaGE+abxSNshT6fhBXkcFNVkX71WfgF2?=
 =?us-ascii?Q?0KcXrOuAJMGfc3Z+co5NLLHk1Xi3gCvPItBFOrj8vp2CgSczvFMLraCPn7uE?=
 =?us-ascii?Q?h4iQmVWmADJZnIuWDt0M1LyYWcrtjVI7ZhJFTPKiIOnpxY9ZISynnPkan/TJ?=
 =?us-ascii?Q?nTKdZvrwTQUiNC3uDgeGxv+fTAu1Guw0LIeq2Uw3FnT2u+hIDTHih0Zy1l5u?=
 =?us-ascii?Q?4DYVsERAJoxPlzB+8qyxwWujA2P8n1lJApp+LQh2eR33hHLZra9YLK3ZmQ4D?=
 =?us-ascii?Q?AvOW2rwioPd993EX7xDKEVkJUTmZZWRzYNTHuJuoyvHUFdKNJ+yJgcy6zcy7?=
 =?us-ascii?Q?atMXx17NDuBDMJpc44OcZqwcdogSVNvF9OpfosWdCZ/nG5ADvtbRRHHL7db9?=
 =?us-ascii?Q?xM+0XaPOTUFA645Arl6fB4kpcA8EYYe29ohtOr46fBOQ2/ZP+EoF8DSYy51H?=
 =?us-ascii?Q?nKTSmcjyAtIVeYW8bF5W/Amps76PGYZjyvjeaZCXQEyz6bYRGRGTODAkxN8R?=
 =?us-ascii?Q?5a1srxJmbS/1PCkYnfyCzbRTPh+PCM32CCRNaR9ghY79VSu324dp3aboFq8p?=
 =?us-ascii?Q?xoFrn47/m45JzSkhb3vnrUdpjTGvj4amFRIiWlJR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8e4706-2061-44d4-30ab-08dbfb27ea13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:35:05.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3aBEEvZQFC2/3N/NxJYZVnW9s39rcaappZLg2Dtw38NGcxk1G158Ql+KYaJmzMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103

On Mon, Dec 11, 2023 at 11:49:49AM -0700, Alex Williamson wrote:
> On Mon, 11 Dec 2023 14:10:28 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
> > > On Sun, 26 Nov 2023 22:39:09 -0800
> > > Yi Liu <yi.l.liu@intel.com> wrote:
> 
> > > >    the PF). Creating a virtual PASID capability in vfio-pci config space needs
> > > >    to find a hole to place it, but doing so may require device specific
> > > >    knowledge to avoid potential conflict with device specific registers like
> > > >    hiden bits in VF config space. It's simpler by moving this burden to the
> > > >    VMM instead of maintaining a quirk system in the kernel.  
> > > 
> > > This feels a bit like an incomplete solution though and we might
> > > already posses device specific knowledge in the form of a variant
> > > driver.  Should this feature structure include a flag + field that
> > > could serve to generically indicate to the VMM a location for
> > > implementing the PASID capability?  The default core implementation
> > > might fill this only for PFs where clearly an emualted PASID capability
> > > can overlap the physical capability.  Thanks,  
> > 
> > In many ways I would perfer to solve this for good by having a way to
> > learn a range of available config space - I liked the suggestion to
> > use a DVSEC to mark empty space.
> 
> Yes, DVSEC is the most plausible option for the device itself to convey
> unused config space, but that requires hardware adoption so presumably
> we're going to need to fill the gaps with device specific code.  That
> code might live in a variant driver or in the VMM.  If we have faith
> that DVSEC is the way, it'd make sense for a variant driver to
> implement a virtual DVSEC to work out the QEMU implementation and set a
> precedent.

How hard do you think it would be for the kernel to synthesize the
dvsec if the varient driver can provide a range for it?

On the other hand I'm not so keen on having variant drivers that are
only doing this just to avoid a table in qemu :\ It seems like a
reasonable thing to add to existing drivers, though none of them
support PASID yet..

> I mostly just want us to recognize that this feature structure also has
> the possibility to fill this gap and we're consciously passing it over
> and should maybe formally propose the DVSEC solution and reference it
> in the commit log or comments here to provide a complete picture.

You mean by passing an explicit empty range or something in a feature
IOCTL?

Jason

