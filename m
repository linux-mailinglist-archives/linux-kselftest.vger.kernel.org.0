Return-Path: <linux-kselftest+bounces-21236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887139B80CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248741F20621
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0D1BD4E5;
	Thu, 31 Oct 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/AmKTzE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5B1BD020;
	Thu, 31 Oct 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394294; cv=fail; b=QqAkBmzIx/FomYW8c7seagu4rO9sAOsHZhT/hNtqevA1ObEdqNLo/n0SQgAH6VqPFA4C+5h4bGZ3Hq51Vaz8uYR6PjNlFDFT2hvrGXZqzuSDp/W/pMmYv0J5tTN6AXMq8jC1Fj2cOQEVrIwueMaGC+0xUf8TDGck77N3e5zn99w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394294; c=relaxed/simple;
	bh=JHYNkfxt5Z3R/R8tZvqMhDW3P3CJEHcNsPxGNs/YHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dp/Ip9w4rNU3/CiYyfnnFBGWoK0ZXWON5hPyk/wSXa8MSq4dqNaigf13cRz03bdKPkSH4DmztHnyV8L4WTBW3QcPbLYPjUTJuFvsR4Slb34OT+yvJaEJ2JCqOze8mqO8pUvJYkFivA/zNG0bY6XKgu2tgeofk2t5N0ervWuwNSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/AmKTzE; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqMEf/8jrHaLPVesEmkxeAdlUrrVdwKgefwG2FCKs09kPJkmzRdd1qqx3Sc6EnYMqHI8rwIDQG0NEorcuqe3qZjAMPJJYzwxRLNtK4JNyGsLUq++RgDehP1Xz4si2iuTxdCcOF93HMCir3nCTgDUoGZm8YcFkN+wDSm5vHS593uvaPD1HiPdNjrj8iXeppc3WXwfBO/Zu5reTJbEZOb3Kam+W0Ft6sWkkFhCWNK2gcxM3+H62A+litZ0ivWt/hNHXpCnlPsyZdsSOJh0XP/09MBFyprLfmDmp3Gz/YBSMwaZ90rReI7za/yYMgjx8tOJy1DLalCbPbzKHkO6f1ImVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iEuguOiWjJc7q1bf0bzhZ+1VZY13fQpegNHxWWTP2Q=;
 b=OuFfTMG2mvE38eKU29q8aso7Pk+Qn+sIlFYEH/3OQ1L4z+HIbphfknq7Nd0ntMoEWTb92+3M20bexqipawibxFXWwFyqYjaj84muR+ulzhMvrkwZrNZpriMeWhl5RwFLqDe65xID52KzeZgdABv05XJD/1rzLQWV3WZpFdA2TRXvWup1s2lsf90wSX2pi4XRE+aIzaxVcKOW4U+ORldixDDg678hmM76Btjxu/a8yPmqlZdWMR0aTFObjfFCT2rNgW0+ERX2FGl50iAqcEJfbX0oo+PFd1zk7ZgGdlwzwgjHKiRvTEO/9gfmytaHtSTVfR5X/dS4XQJrH96TEXntEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iEuguOiWjJc7q1bf0bzhZ+1VZY13fQpegNHxWWTP2Q=;
 b=O/AmKTzEg2jCHlk2d0QwttpldtN7slCYWjKs1sOsKhUZBKkm9/leACw321UEQji4QgNZy7ZMklIEuFe/XcDfweec94yBjZFJtBizdF26a0VjuPvqUBzaXyhl+o5F3E5UMnWsOYBfnO8Ul9lyKsfJlvduhH6tYk296s8kYUV01qyO9rkjMjpquuF/qhYDUx4Rm/9U/250x+EwLUhI4bubW9OFQXD/Nq3//MetPfCi6tScGA4UcjWXwWgxBO8PBwZ6/Q8Imun0zLvIoFjg9Pi9Oux2qn7OvE8WC7LI0nj9Hge3+35EL8Tyv9yJXFO/xt5TqgvCgYkx00/txEDJz3T3XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 17:04:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 17:04:47 +0000
Date: Thu, 31 Oct 2024 14:04:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241031170446.GQ10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
 <20241031132941.GL10193@nvidia.com>
 <ZyO2xfe95Y1TCaqG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyO2xfe95Y1TCaqG@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: e172d566-7895-4c6a-d071-08dcf9ce2015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GPJ5CeMB2nHhK1Wf3tCgpzbgQYjrzjIV+Dtx7CQzm/3MM7soTtEEcUHxoOBF?=
 =?us-ascii?Q?THBDseIb5ZlYRHV9yqWalghpN5W3RGve7U9FjfdHGjtnd+j/geW8+C2S8EPc?=
 =?us-ascii?Q?MIXkRoSEe5QX8M5vqAOtXXdVOnbLwYZYRb1a2qETbwNu+j1MQgi8wgD8HvpY?=
 =?us-ascii?Q?Udeih3h4Agx8KiEQkGRnuTscGK1YPs+nxc0XqgGpxDtvMfE+pGIeZfSjsQN0?=
 =?us-ascii?Q?2DcWgy8BE650gIxlDmRhxYSBmUpzawM17bCWh/crWVYxpwLoP1EdIb3fJu+N?=
 =?us-ascii?Q?nv3V8wXJOC92H+1+0pgHmYBhfD14Ts/ttUb6+X8aAxriMRD48xe3ZWfkCq/0?=
 =?us-ascii?Q?EVpHCVVZdDVEvNR0+zVwKfJXIhutCxX2hMPPNMWCiJTflajpmdGV9i+97YUH?=
 =?us-ascii?Q?oOFBa0bHZYOu4lap3WFvMxQ15LTHXRhwAVA6tLbur/RYhSvcQkqTyPjCNkaC?=
 =?us-ascii?Q?Gq3QJgut33MLMM0DgPhLAWC7YLegrzJzF7Qoao8NPLbtcKBld+OZ/ltCRTqz?=
 =?us-ascii?Q?6pS1TnauzfGvNugKfF7nnvIlZbaP7yEC3xbiQwCqZTUrMGjL2ggoK/raOc2w?=
 =?us-ascii?Q?sCeheX7RJTNJmZUn53kygOH8UKZTjPjidjajIne6UMDIzlrAauBnaX6jK+Ng?=
 =?us-ascii?Q?iFvQ+/SEAhUrbJstQUNMZ/6xTdcKZyufQ5j8NTbxyQ9n5qGzoNL/b87QyfEd?=
 =?us-ascii?Q?XQhWKJeCY6V12NZzP6ETelLpADuxsCmxvES18tdZI65T+n8w3Ox/deUaAqrr?=
 =?us-ascii?Q?TNnBG8J70qYddKbVNpi+c63nF16wwcjpDwPFb/wfIuk4t9u6B/pfra/TcHbP?=
 =?us-ascii?Q?72Z862JTJFqFlaLHTIi01obh96S65n8B6sdtIlGqcHWYpLwoHwwfRsVshdcd?=
 =?us-ascii?Q?qRUd+UG5UiXadJ8A8PXIqilxbnu3RQvN2Gerx6JB0BvgxUty8xsgMxQLqqdI?=
 =?us-ascii?Q?w1fZVmt2jPl+D42ZoxkhYKylv9/IXdr9uT5KWxMRPqx8V1dL7zq6093zDtki?=
 =?us-ascii?Q?/0VPMBVXdFUuxWh1WW8zTWhEnrFe/wyAA7IK1Xq7hjU3PxeNYtwskbWb9fm0?=
 =?us-ascii?Q?RvrY21qNjsMXjESFes1F9UdLaIRYew4mNBjPl0eMNJaUnlAw3e/LjJ7ocgG3?=
 =?us-ascii?Q?hpPy6V6o4uXje21RB+SZQVInJQjbcjBSP08a8FwUUqUe9mzALejOUf1Bl5mc?=
 =?us-ascii?Q?cLC9aAN5T8FRmVm/iAr1WLq9W2XrYRntabEOMYgkzZV4dABGU4lrzwxnDbi7?=
 =?us-ascii?Q?2Sh+7/953TGOWQTtMu7Kiv/RjCyOEbN+qy1JOAXeYwriBdgGL0oej9q+fYHU?=
 =?us-ascii?Q?HWdETu4pmLHcqsX0/qzwxy63?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwsAMnhbYtkv6xsJsRyqTEMym35Kvx2gKHjOP8Mo/fMza8kWpllQ8Z/d+RVE?=
 =?us-ascii?Q?F0we3UDNKoi+zY800fGfUGntx89AFWi5poN4hQdyXOHFbLiMout/z1ac3BKl?=
 =?us-ascii?Q?5fDoN7ofT7WuXOSH9+LOxj7BRpuB4CaO5DAVhnJYchsQukJoyI8h3Uc+S7S3?=
 =?us-ascii?Q?cK/UEyca7DVBRFcJN1upIGTllY99KXPnigmEae7eR/hqTG5gmBYHs1Vyl4Md?=
 =?us-ascii?Q?UJNQXMo/pkTU3nEzwmlWHMOJErXUCO/RWtqMMEokylwiUWzymqEaoY+rU56l?=
 =?us-ascii?Q?qlsxRiifGgG7PW1NXCzMLnx6Z0et0ogMLjvw7oxOmy5Ga0oF7/Dt8hzIilun?=
 =?us-ascii?Q?sAkcd1jaKeUjUHu8UqRHg/IZtqs6vNTSoibqHGoGaWOVDLRVeEdw6zGNcyAe?=
 =?us-ascii?Q?wfvgljikApAXfUz38Sz5Pu4C97BrNhGYnGr0WPH9y0prHqKoZ/TtPVzcixYj?=
 =?us-ascii?Q?BIvnJr5mF491H5BncgH92ovFZmjNDEsrFzkB70KEaNLSGSMQrEMyc9b9dibU?=
 =?us-ascii?Q?IjtfKvXF8+RwWZlDYhICnAgMXIQh82gUHKmKacUAnmtWBVHbx1Sq5aNfP2Z9?=
 =?us-ascii?Q?Wa1Q9hvXGWZXMVQTSKkUkq0F75GjSRYXZ/ngQ0YMq+PhEkiHA+/6f7F6sOL5?=
 =?us-ascii?Q?yA0YButLEg9VQjxu+WfWhjYZihMtLKx4csE+tSURMVUIJkGcDU10JWIY6lRS?=
 =?us-ascii?Q?INTmKCY6W7MZLlZbNolQzGSEk6sVrWaitXPZpu5J8E8CYPrCcEmTPqb5DYRg?=
 =?us-ascii?Q?QKf/kd/51bnf668MAT4Bzw3fgLchG98U7LxUk16dlJk3oj4jop2oQy4Jwl85?=
 =?us-ascii?Q?nYYx9cq9geMTtn0TS66HYcMbRXiOBrzVGEZk/e3eaf4tZPSre/rO3O5zwrTk?=
 =?us-ascii?Q?oFr3yvtRyaFvoQ1lYmhBTn6538mnwELLruD+2KKT3JDgD/h3yud/Z5N1X33I?=
 =?us-ascii?Q?jwv5IHw0eYwoPQN9ykToQweioS+CmID3/anoQBHp2FKuBsOUhBIBnHq0b8/x?=
 =?us-ascii?Q?Dc8EuqNVP0M5UckzdMbaSiDiCs6UApZEVe8FkEg3/LNN+TdCBed+24hTCcxI?=
 =?us-ascii?Q?hLT43/5t4LxGbzxhNo4SZDG6PLQnCrhKEu/l7Ub4pgxfkPhE1EqNh8tLRSSQ?=
 =?us-ascii?Q?/3aasfYpX3kXS3phS0rXtDRoGHqcmSHkCMaJjrw+q7oYzIkkAkyuHa022xA0?=
 =?us-ascii?Q?eV5GwalVv2HyN/yCwNjXndSRjCNFMYUVXs5YwwAfbD1sYW4a1bVyPs95Xlpv?=
 =?us-ascii?Q?T1z0jvoOq5US0DBE93MxjBlvwgPVven1QG919CGhyXT6nilUibYQGcNG0BWP?=
 =?us-ascii?Q?JbGYZVXZHETa8lOJNkuL4sJgbfhUgvNtxjHk95IdtkzXkajiqzVmZKsMA8F8?=
 =?us-ascii?Q?OPDYuCrZj8Jn7/LCKqoon5onATbJ2Po/V3HxMkWHJGa2G6cPjluyMk5ZWuhQ?=
 =?us-ascii?Q?ykaAHGXXfjDlCg2XDTUPxVv/WfwYwafq6qVQB1E0h4o4y69S+zBpfY/VY3uH?=
 =?us-ascii?Q?/i1VFuLwBsGELUNqlW6NQooLgZ59TWzLL2UjMc8MlQBhmaNJzZBTovwIXeNY?=
 =?us-ascii?Q?6rDXhalNjtr5aHI9i/I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e172d566-7895-4c6a-d071-08dcf9ce2015
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:04:47.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a6UKMq3GV5OhannEO0OBx+bogjG+lfjaeGEDTTOQr1nzvQWKBOp0XmcewenuL2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447

On Thu, Oct 31, 2024 at 09:56:37AM -0700, Nicolin Chen wrote:
> On Thu, Oct 31, 2024 at 10:29:41AM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 30, 2024 at 02:35:27PM -0700, Nicolin Chen wrote:
> > > +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > > +{
> > > +	struct iommufd_vdevice *vdev =
> > > +		container_of(obj, struct iommufd_vdevice, obj);
> > > +	struct iommufd_viommu *viommu = vdev->viommu;
> > > +
> > > +	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
> > > +	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> > 
> > There are crazy races that would cause this not to work. Another
> > thread could have successfully destroyed whatever caused EEXIST and
> > the successfully registered this same vdev to the same id. Then this
> > will wrongly erase the other threads entry.
> >
> > It would be better to skip the erase directly if the EEXIST unwind is
> > being taken.
>
> Hmm, is the "another thread" an alloc() or a destroy()? 

I was thinking both

> It doesn't seem to me that there could be another destroy() on the
> same object since this current destroy() is the abort to an
> unfinalized object.  And it doesn't seem that another alloc() will
> get the same vdev ptr since every vdev allocation in the alloc()
> will be different?

Ah so you are saying that since the vdev 'old' is local to this thread
it can't possibly by aliased by another?

I was worried the id could be aliased, but yes, that seems right that
the vdev cmpxchg would reject that.

So lets leave it

Jason

