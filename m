Return-Path: <linux-kselftest+bounces-18461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C79883A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E028287894
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11918A952;
	Fri, 27 Sep 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1SVH5i8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583218A6D2;
	Fri, 27 Sep 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438373; cv=fail; b=Q7kjIHinhlOBvShKeUiU5egJVhO+jKIkA2DGb5GNL02pHQRTfHAvV/dwnJoMY5nOkNDAiojVxcat+Gld1S8Rn0ZMuwHwYQ9XlEwth3i6FSQxXDRHpZi3EyEmOJEih937nVXwDM5mIhfsEQl+UcL7+C5XL7A9dZTSP0ZP9i9mdgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438373; c=relaxed/simple;
	bh=oPgOpfIRi34l7hD1nYVjnxClOBxs3SLZ6DcqlMX5YGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7/A8VTmsB4QatvJwzwXoqO1TYO+JwlcYWfZeCciLg9zqLKj3HqHDbhLT6gyjveWbfTDQC4ICmRr5KnExo2GppyzU6NRT+aUDW3WsfEQMf4wyHdpMDt3jTgwxVtTpqYoZec5DZUeOo4k333c4hLnhLZB/ezUzR3NRlRgDTL4LBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1SVH5i8; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfU9u0I6xE3K5MsRlW8+ey00UNHM1idYzrGrUmva9aELL4U+ubEr0oQkDN2s53KmhAYYavMGil3OzR9rS62cerbv2sZRfNKfU6I8w0US3fCVun0JR+O/n7fowdItylyeZ184Jio2pCdpGdkNldYoouInzhGt/z5GtpulDHqpblLuMnn7nfHmEDPrl03UBpfNfSmeqeBrr2x/syARZw6RjY0NXvln/SITQOTtuQ0M7gYEhzpdpvqUcM3/cRZG0ylUX2e5Qjzq4hn+5OQ+rOODCjw8F7cPfYSAwW+9ohKVcaMAYheoGqYYFDVi5rxSSvIf5AqGKO0XJE4yvN7P+4xEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsg8DNswVT0ARWJ1C1xg2v3MBaEUgLW/9W1uuLhj2iI=;
 b=m3z6XPj/FQhWe3dHKPF6dJUG7v27PB7UyxKGv77ZmDa5vA5rnn+24NvfEWOyukl2t45eRqbOI6Q6rR8ojwT0bj+kFClHracdIF+E6cm2b8Etd4ZwbZxLMZjZf374yPZxGzNtSO+Cs1+rxH38ginYwFtVsutdt0yhqGd/+LNTjVJwWY0osT1uwMB2DIzlonH/LJPFJw3irH0l35IaqoiI9MyXIK4er2J4jcqG6RAqai9DDVS45+fiFiRYRbuDSCjaNfB2WIWcnCuUhSWPfKQnX2dT4udu+0GD9JMNjuQHRrGhYni8Y5qjUiZ6MLx9lJsFxOWQmrE34WkTkBGvZzasAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsg8DNswVT0ARWJ1C1xg2v3MBaEUgLW/9W1uuLhj2iI=;
 b=m1SVH5i8phHIgJe5KxbD0AJfQ7GvVR1qMCUBqyl3jNXQEns4Ub8Ou8r5e+9vVdRZWECe0k8ENc4HTuPp50qjmENmVYkVEg8ehlU7UB0CiLTwm4aLai3aZ/PrAe0mepettEe6wXYCENjeIK9H6XgdQxhjaBraW8nnX6iZkIeS6aAGWLHzI7d1idplZAcpkHjFd2hDPrG3SjXsiVJO3I1XOE+eGOZz47urSX5KSR8RMv3dH8zGpYlyvQIzpywzdFKR0dm1vohQi33xdLhbbvPcqLDAgge6ntedrXYXAbSqjDdlXKRA9vTjHP9I1BglgjdT3W61ExUX5zU4simMaZ4z7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 11:59:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 11:59:27 +0000
Date: Fri, 27 Sep 2024 08:59:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20240927115925.GX9417@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
 <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvZKfUQpiv33MQw+@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: ccea1778-34ce-4173-b554-08dcdeebd5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gzSfoF5+0pUO0OAMV2rm9x/lWVmLfMUHnHLIJQp6T+9R0vy9YM0hpVAfwsf?=
 =?us-ascii?Q?URK6btlLd2y3LcqP0MOcZDp/8JkgPZWbqsG3sBxK+m7MzfsKhcjJJsma/Q5Y?=
 =?us-ascii?Q?BQ1phMSWYTWCEZIBXsJDrPbzTGAbiLzhoOW6xVaNiz20/BPrKS1Ck1fxMOrg?=
 =?us-ascii?Q?bapVjasIQhgX4htWshAy4OBJOS2t9otNA9cOZ9dc3g6iFfxbIdieg8Al1PWT?=
 =?us-ascii?Q?2htoaeS2T1eX81rgktcv0FXUOo+CXUv69qr0M1jWbLD3K5TMoOh6w9cP+bSl?=
 =?us-ascii?Q?8gnypjJmDSYU5pUx2NkauXvyyyg/4QljvEg7Qx1bLUjJ8t2keamhYl1ZSlIM?=
 =?us-ascii?Q?fh/OBxW5KBbnwlcxoKXWvprTbK8xMKGjDxcskykfoGgtWUMKJK5YRDtUAa9B?=
 =?us-ascii?Q?agN4igDuerS8BoDU3f+anmYEOTFQ9Ti8wlbufWxskrCbGikqjMuvpqbe9wlC?=
 =?us-ascii?Q?Qo6IZFhire8TSfs6UNhOhnYN4ytNXi3hSnByaQNp+KIGLabx2z3o8kMbZf6L?=
 =?us-ascii?Q?ErKvOC17dMRpWz+gBcA0Ko/TYop6acanJTl6eNKsr4z8QgJCFyMPR6wh+nI6?=
 =?us-ascii?Q?PNMjXW413JPpwPcgU0JTZM3/sUhWj537mLlG0EBAO2qpLw0kQYyKb1hk49E6?=
 =?us-ascii?Q?4uAL2PyqaI1NOIxcvacMifyaC/F3I+lLH0amAOkVNtV0x7nRX8FsMT2Hfpx5?=
 =?us-ascii?Q?VmfA1y8KrU6XS/mRPzCupA7A0deg+IDOnyUBOTMeiYuo4jryatGPdjKx7kFj?=
 =?us-ascii?Q?FdI0j7eEy3+X7Vic9Hj2C/FJRUhzhjQ5lCp4I0kABmS7+RVNUvYrCgOgzFWg?=
 =?us-ascii?Q?19uGW5VnfWlAgT+tZTEq46+eQ1FBPF8pjyFIye31IOPVmGd74cVUWHoI6+XS?=
 =?us-ascii?Q?DdneqdTSC6FDbFv8u9Kjtg3GHHv4d1eXlEfbHO3GNVADEP69nUMAIB0W3O8m?=
 =?us-ascii?Q?XGnfXCbx2DyUaAmUUSakNxdTOTY3dLR2PRpLcOm3PZVIZwmxl5jYwoCXYF1g?=
 =?us-ascii?Q?TSDfG+FiCYyS3uI05D+nFKecKj/FOjWSC29Qmhmu6dpF8MxRdYQQS6DsNvod?=
 =?us-ascii?Q?KqdFYDGLT7oul43m/oEo+iciwHVPib9P+A1vrgp77fgozg0q+V1kS6V/U1dt?=
 =?us-ascii?Q?tg3AwFqzUJxwvrBjsXvgz3AIyjgjN9rbQunMDkw4G6IspjEabdzwGpd2Q7hR?=
 =?us-ascii?Q?JRwhe2jgBwxiwr8lyLh/BgmPF4mxN/TDzm7rGL2xXAUcZEhU1+m9M5KbN0QT?=
 =?us-ascii?Q?z+XYFteYICCBqKQ07DW1Q4zwVWyFLuzAHa5CJGg1+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcsf8MBCpteAR4kviWaFq+3PKIMJpN71QQ/4LNXoveBZXqwt+UYnR3wrRJz4?=
 =?us-ascii?Q?2Lj/EyQHVDjHaxQxuu0ZQhwjeyL73DDp2zZyLWw0AyrLrVQ/lsGc88/W3Kb8?=
 =?us-ascii?Q?dFXVAMtsbBLZ0QZ8wg57xTLJXGz69tPlIuJAojkZv9HPTyCG3jaalxZ+nIy4?=
 =?us-ascii?Q?+J3KJiRwQtrglcV/4SowbzJXwdg5BOSP3n4iZbEjkzFMOeADZAURKGyBTJb8?=
 =?us-ascii?Q?MZirJKAX2zgnYhS1kXfQ/SbtWUl81xjdPKsdNB2LOyxiannmlFEl2Y3mKiQj?=
 =?us-ascii?Q?EcANg7BVxAx7ju+L9QgIw2AismnRZm1RYMfPHVeBWGe5RJ6HPq2fNydtTa3d?=
 =?us-ascii?Q?WWoKhUztV27+xMNcnb/KfgG9yPHjPKcKbQy3IiJwvT4R8dJ79LydKIQTzRLU?=
 =?us-ascii?Q?6zDSKPYDWHjlIc4hSGlcKCqpZVIqghvcFw/4y0jeoWSJ6V61Y/dGNQqStPF3?=
 =?us-ascii?Q?JDmJSEE5bbG7NZVVsYe2y8mxlVdVEsj9DmnP/3MorfvXYEct+pDXmNeQw5aA?=
 =?us-ascii?Q?BNp+sGw7U52Cf37hH4v0ZDXL6FDKpwi38Lo8RLmE2foQ87P2JqIQBumXeXym?=
 =?us-ascii?Q?thhDNrH4sIrJVIBb6r5LgxyHXYzabH9JUESQvZMj4gZHnw1ECOkfbbkCY0ws?=
 =?us-ascii?Q?5VQ2kONGZuZpC2Q4BBd/k88ZDxSkKLgU3e/JTR2kcwUcEtO6bKHJSxHIf+kL?=
 =?us-ascii?Q?geM1pUIcW3XbNX2jb23J1nfZkG6nZTNE1qtj83nafGAh5Y/fGHdByHeGRS48?=
 =?us-ascii?Q?zv90W3vDL/IPjJ0T77T1R4/15DIRookYctgmb/Rgamg4D5SetyNT5eEYEDZr?=
 =?us-ascii?Q?GiuzwOUNJQNKPFEzJDQUknouxl9NktDB9s+Tnww81GSc/842SperKBX4tOom?=
 =?us-ascii?Q?nkEPxgbTp1//XlFjK1xrSPx0PQlmaXJfOpshnAzbP8702QjQGWe/gRYQcNUW?=
 =?us-ascii?Q?wdcBMawqKXYZoDsrGHedH1mHbl7VISDZxfS1vxzBmQ4mjEHWxpTGyw6b7vBL?=
 =?us-ascii?Q?DX/HUJZmwyyX7WMHkNJxbFArRkYlKrZl4RjO7jsm+/3OBHY363jsA2uF05FJ?=
 =?us-ascii?Q?rJqfwA+fvbpxAZu9BX2ovgw2ngaBk7j51XzTxJW3x/jw728iS+QKBxLstf8S?=
 =?us-ascii?Q?YaEBhMMfKSrP8d7XMpLWxgKsONF+7iy5mL1IPbs97b6q9xOAEWtGWQ6qI4D1?=
 =?us-ascii?Q?5BwOhz5DlEZ313dbv/t2mAW9AaWor+k2aT7F1T+FxZOg8ggdMhcWRmXu9w/G?=
 =?us-ascii?Q?O44MBILDiHPbVu9Qh4muljF+oxRS50vtzQftXf6XeLQZLb6fzaFus0esXaAA?=
 =?us-ascii?Q?BRyJV85BHRN2Q3/EKZtYREYRpw0trXnZWIUFmNqoeRkEyzsxyU5roVQdSGGq?=
 =?us-ascii?Q?5kAEYxNjopi4glMzV+wkNHAeCLGUXbrpNLkadG4pBveRZXdMC4FUhtMHBzkg?=
 =?us-ascii?Q?GE0pnyM9kQ9X0+QHcKq++47Qk+qCH4UXETpteX5aW1qKqmONrIkV1Yvvqsmk?=
 =?us-ascii?Q?q4dFn/dyfrB40i9lYNs39K5W2FsjfqItzU4y6BEH64R8NLGxefvIk4W6cR2E?=
 =?us-ascii?Q?y59avI7Ls6VAuLd46ok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccea1778-34ce-4173-b554-08dcdeebd5f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:59:26.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJbZxuDE6PVxU89oGfFV6VPCYFOJQl2mCgA+nRHRrSlSsQ9Cy++tQH4e2Gk26Rbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

On Thu, Sep 26, 2024 at 11:02:37PM -0700, Nicolin Chen wrote:
> On Fri, Sep 27, 2024 at 01:38:08PM +0800, Yi Liu wrote:
> > > > Does it mean each vIOMMU of VM can only have
> > > > one s2 HWPT?
> > > 
> > > Giving some examples here:
> > >   - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
> > >     kernel holding one S2 HWPT.
> > >   - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
> > >     kernel that can hold two different S2 HWPTs, or share one S2
> > >     HWPT (saving memory).
> > 
> > So if you have two devices assigned to a VM, then you may have two
> > vIOMMUs or one vIOMMU exposed to guest. This depends on whether the two
> > devices are behind the same physical IOMMU. If it's two vIOMMUs, the two
> > can share the s2 hwpt if their physical IOMMU is compatible. is it?
> 
> Yes.
> 
> > To achieve the above, you need to know if the physical IOMMUs of the
> > assigned devices, hence be able to tell if physical IOMMUs are the
> > same and if they are compatible. How would userspace know such infos?
> 
> My draft implementation with QEMU does something like this:
>  - List all viommu-matched iommu nodes under /sys/class/iommu: LINKs
>  - Get PCI device's /sys/bus/pci/devices/0000:00:00.0/iommu: LINK0
>  - Compare the LINK0 against the LINKs
> 
> We so far don't have an ID for physical IOMMU instance, which can
> be an alternative to return via the hw_info call, otherwise.

We could return the sys/class/iommu string from some get_info or
something

> For compatibility to share a stage-2 HWPT, basically we would do
> a device attach to one of the stage-2 HWPT from the list that VMM
> should keep. This attach has all the compatibility test, down to
> the IOMMU driver. If it fails, just allocate a new stage-2 HWPT.

Ideally just creating the viommu should validate the passed in hwpt is
compatible without attaching.

Jason

