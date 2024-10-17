Return-Path: <linux-kselftest+bounces-20034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B49A2D60
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D0283AF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF921D179;
	Thu, 17 Oct 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ry1Q5o3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09B21C17C;
	Thu, 17 Oct 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192190; cv=fail; b=g3hRh62qyCV5e0vVhex88RTOzVh6KKQaY4rIvbBpoutxBU1A2nMX2kptau0x8S73WZV0li5vuGvT1lYqerCHPbsSI1+aDzoLLjQlktHdu6w5K3/wYBYMPZnaFLOmz2StVFht25nw7qop8rR+E9xNs2nwUIgm2f/uzpN+gLxlUnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192190; c=relaxed/simple;
	bh=uLoEP8tqTyl2Vg1Z5LP3cRk0gq1427jxGWdQtXH3ftk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVZT1pPfYdKX+DpBWJUZEXOXfCqyKLmPO8MTKEYOd3oGLhph5QhypXFVIaQpMPyLmksVX7Z78rsizJHlm3ISDCPPIKw7eH05Muz4iT4jpijwxc0zpW+/bbJS2wfwx6sI/CE4mXWKrBZ7Knp0f85Yb+jJT5gCsZWHcW5n5e17ft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ry1Q5o3v; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbFUZvycRZsoTmmpWeBzfU1Wdc+7B7ePaR7URe1weaO6vY+OS6vC8wiI1W1PH6J4szBzVRxqqKtseQPkxMQ5Ax+6f8YfBhNgYmQcpBDaWahdXa30Qo3OL6Tplkyu8bnuNHKYS8KofZMlyqX+6RnL5IBazuMzQ7k6hYzT8rhOFr6vjg2HQQETBJTI+pIjZ3FnSOKty4sRK2dzQ1WNFuiF7OSWN3t3X7WUQyUWWMwRBpisjIMmqBsuHtEbqCS6GoSZU1t9EZTgE99SEJbcUrDZEd5nMHoKPYXiDZH4y/CPcYaeDQtde64QpoT7k8HJRyBAh9WVQ8jFMXXDFGfUvHl1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGiuKh0SZRnJmIS2T9SJoOObxKAZ3grFTEYp0QFd6zo=;
 b=O0IzqMUJVtIlH0/bEZxEY+rVh/GDRLaKBo3unGUoeuB9aD5xb0cekuOl4DDhz3GNsin+TINQCSDT8v0QXFPjKJ0JNTVK/G8I59S5nd1R512SVbYIgfUeh5GGcRCN+Yr5gQJk7eZ2goVQ6210TgB0EJerQaoxP3WbgEeiuvA1yAIkea8+IOe54B0dC9Ptz0fB5oIn/lYODmPQCnurpbQfY4me59OixSG2EV5zN4iRw2Hk7ABny9inR7LwmSj7thU7ytDxnpfpQ3KmjUZVGQPFk3VxhIdo7OlpmK59x5PP1q/EVt0klVYV6vLtzXIHj9ipzE37DttLuPmhxZLrZLWfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGiuKh0SZRnJmIS2T9SJoOObxKAZ3grFTEYp0QFd6zo=;
 b=Ry1Q5o3vZX+wGpc6o/7kWCg6YZLhIXciVYc8MluXdc3YWD9zCO2pAlQLmqdFU44XutvpjDokA2iSTGQJFY0NFyHRPQo2247H0i1vyl7oYRa3wasByfD+P4auFFNnXrB97DQ6TRyMeDH0PDVvK9NkLPNS1WfFJe25FsUTrluzFDZx68IJGLfenLrPbH7YSethCcmzWNAT6t7PZT6nzSgSkA/12mCDhhh8IZY17UWxGKhLzjT0pvFWz/fjqFePJX3U8c5xCej2esFt5zD2R4l5Uhgcq8JGqmHrBkk2nTSPLandZokYw41NIzWpkUSIMBoIOYClBaJ/RbP/W1ev5AamTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 19:09:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:09:41 +0000
Date: Thu, 17 Oct 2024 16:09:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 09/16] iommufd/viommu: Add vdev_to_dev helper
Message-ID: <20241017190940.GW3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <d5326ed6354a9f480a90b3557744ae0a7452c8bc.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5326ed6354a9f480a90b3557744ae0a7452c8bc.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:408:143::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313af05-4d66-45e1-2f85-08dceedf40f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERqLacZoJJhWLeYxuAojvESz96FkVPTGIKPCDeVV2qYtmbzhkr9Y1gb25ZAv?=
 =?us-ascii?Q?qR2zeUR789cGb2mdOek166MGjQQJaZMeZkyXzyClRMce0fKsVZhH+LZ4u1U7?=
 =?us-ascii?Q?I/74UCcDLsmzn/x6NoyZK6vXMUuBnRWrDmJUNdskVSsTSp2KTFwTg+lEXOWB?=
 =?us-ascii?Q?qgPBkrnjJBS471TPxaD+P2vg1rI7oXtaXYdgTZJEsBVhb11Dj+oqfv50wByw?=
 =?us-ascii?Q?JCdhHTPf4/qktb/YLmlSEbzAtx5NaMXBa0FZ1iFT5adn0/VTU2EUVzh41r92?=
 =?us-ascii?Q?hwpXg7YJg3SSTrpd0YWCo4JQxdq0p5JIAbVX75NXpP4VR9BP9EHSjRk6O/4u?=
 =?us-ascii?Q?gcZmK3FvSMC3nNeea8u5DMGL7CoF4sZVuUauEIyZZiVLv4df/N8+pAaLjdob?=
 =?us-ascii?Q?PXStNrsefnegSG6eMV9IrQSekSNRQUdF8x9yn5pjuxSddqa3MmvJwDVHW7XJ?=
 =?us-ascii?Q?slf2X4PmF5oR0tzA4iTtFOvIawZoP+y7ATyrl9yvSgmBZX0P53JJf3u+9CAS?=
 =?us-ascii?Q?THb+nf2bpseqWRRKZzq+6oEb9mwMPsK90e/BbsJUWnquNLni8tih5unkxaTL?=
 =?us-ascii?Q?izjZ2bf/JwV2+cPgFb+cO5DBMb1X+soBbH4d3FvT8zBkkFanWHLkd1dkYUGO?=
 =?us-ascii?Q?ISA8gOh3rRUXNDWSRQzWpmvJz7NVZbwo5tKszKHnWqnEK0/7aoE0V48UvZ6o?=
 =?us-ascii?Q?Zw0E67zboixCaa1OSuqO94PQXrnennl2MDKnP072jKLNrOSwR3P17mO6y3dz?=
 =?us-ascii?Q?Zk68cGJPMkhvS0P6SSpcohPprAvdez91IjEF0iVd0MrDMwSkwC9MU0/m9xjF?=
 =?us-ascii?Q?wYcyKJkmnv1Sj2uNXJBU5MOqgGm6UBIownfBScbPk9DuhmhGo8L5Y+CjET/I?=
 =?us-ascii?Q?ZbsGE/CQaG8hCgQsJhIrCb0yt4vzJH4NINjZBdu8fplrtui0xI3+Rr2F9ETq?=
 =?us-ascii?Q?0/0ql5e5H3bIVnUJ7rIl/EppO+hoLoU23k6XJsee4941JIOTJu7u4Cp66lGh?=
 =?us-ascii?Q?SJtJfLtJRzZOb4kw39GRQnFKLl6vbFMeFjt5opsaseOc7pGIk6YjFcvRFoUt?=
 =?us-ascii?Q?msE0nOCu44cJbbWVu/gSurXyRcY6Tarb+IxvGdwUwch/GWMFV+ql2D/mAcug?=
 =?us-ascii?Q?lGF4ld2SugGdh0kGAq32KJ1rUjcSUVX51x4aiaFoxuNCo7z/93a72JykLcKx?=
 =?us-ascii?Q?noGGowicNwy4EhoLl7j6nv1PJsrVq4U+uqnQlGBchsL3vapSgyAZCa7cjVJT?=
 =?us-ascii?Q?NSc/WfixVKm085AW4eJOMbJyxrr+r3wAE2lhfrDVOOGGHwptnSh18VDqhiy7?=
 =?us-ascii?Q?Sm35U7wHtYBSqFm1elkNcOoU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DcLM65Tb2fcLLy7cuGPlh5tnOlicRofgCyeZVdpluJM0Yyuw4wvG7DvMzPU4?=
 =?us-ascii?Q?zbR6YExqgtAOzdecJv4V6RYHKKwCY7NQg7EaLA6MyUaavGSODw1NSpfPhcRJ?=
 =?us-ascii?Q?DS9p4KKjUrajgRSbhOhiIX/hhZq95TILs+kp9a86d4M1w7sD/N7MBmzYSpUT?=
 =?us-ascii?Q?AjAwJph/cndkFYW2sqx3/OlbjVu4D8dkAJuMTcurSoZ5x6wRvfsoWR6tIkPe?=
 =?us-ascii?Q?9jorEa4Oa2+0wFpUVEC6qX+Wfi9gVO7FfYNmMCPVoDH3d4edlDGttiA4FpuJ?=
 =?us-ascii?Q?IUY9jqGRN+6OrsfKRUGC/Pw3qRsGdETCMQ92+zXoYfnoLWbhv5OuiVHJSKaj?=
 =?us-ascii?Q?s17ZCRd9w+38rPbBYWoW1W7e/WPDlMERJrhGzJ7XjrjCl51Q9lAjGHk9LQM3?=
 =?us-ascii?Q?lPAOPkbwgxxyHTJWGQ/iv7Dv1wP78yS00gesSLJ2u+Gl5cITLXaijwYCjDq/?=
 =?us-ascii?Q?/NUgJa3i7kPzgSVKwNExY9BdN/zsaR2KtppdJPcQ2sHUc0Rru9t2ETtBHR8j?=
 =?us-ascii?Q?0Bi6Po3lJHkCLwbsxZYweEubrreENJbEgsDgLyu+ZZMYwZrzMWivDgE8KYrv?=
 =?us-ascii?Q?TSmES0LDR1XlA4g25dqOp3oB4UTBipzZvyM8CrzFfQ3T5nN8jPynv1v+9XCC?=
 =?us-ascii?Q?AEtWosZs/T+Vd8qaDLeEZUBsGxmK7Nvn3Y8gR9EHQM2T74a06Y6MnpcA7uN5?=
 =?us-ascii?Q?kmjugwGukxed+MRkZPgl0gWaW1kZ4j4thFCFrBaZ/DEfXLYS4yMdtMlET56M?=
 =?us-ascii?Q?VzEmdjskQlXH+Qk0l1+QFY+SVcMfmLVnNtmCGTBgMWUe1Ys3rOALBEZhLt/H?=
 =?us-ascii?Q?bAcvRbfNFZp2XQt+YKqH6f/JDLVtqt6evsGP8lK0jvYVHpPEpUUTzzu1hf+j?=
 =?us-ascii?Q?moQ6tGv18KBJo/3ug+ZVr8s71gw7A/Gjvx1IFS3cQfxStv1dmJZhvdjXe3xo?=
 =?us-ascii?Q?FSyY4k6rQpymL4k/LC6Gaoa4xxw8DGbtCZL73mPCVU9iTMCbXLnfeTkuD6Y7?=
 =?us-ascii?Q?SCdQZF1VMzw52hudl4tnkzhvrH49wPsTXcNidl0rWZVL0NGFSqCt6dLtPMLf?=
 =?us-ascii?Q?VWn7I9a9n1G0be0wO0L2YkKkoYgt5Izmd5q6wQhVo+2z6eBSRPOQnabzWFeA?=
 =?us-ascii?Q?0ui0OxQHzkKAYpsYdcQUZ04DMQANIURJHXE+dX0DXtwgVG8JP4370tizGnLW?=
 =?us-ascii?Q?tKgGdM7rVIfvGjEmNC+HBLUbkJ//F7hQlKC6kwYQJC7s50ORVt4DXh7fvfN/?=
 =?us-ascii?Q?/ZAZxNHi9vtZQHivb32R7U6MLxfu45qM628gmg98/6xSJVRVE06Sh1Q1Lkx+?=
 =?us-ascii?Q?2oYW/y3nBzpOAu/QXbc1l6bQYJR4YggS8ohO/vls/LmTJWcR7dJLemY6fcxd?=
 =?us-ascii?Q?ZMdDixZPYMnFdF8LKwZZSgew1Bwf2h3N9M2oo54KWB+MoUbE9taXqO7kdNzc?=
 =?us-ascii?Q?3x6p+jDmw2lFJpdQTYKdXB2kPkp8O8DUc58s1BXuakoQKyw+NQMx/3yd12ux?=
 =?us-ascii?Q?CjTD5eO0+YY4bTVFu2A2lDL8qVp+dXl4CKMkvHDy6Myr6xGAImIjbWIDMhsF?=
 =?us-ascii?Q?lv0MU360pVEF2dgRs+o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313af05-4d66-45e1-2f85-08dceedf40f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:09:41.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVwQit5pEJt5v09OHQ8GXUF5QeXvNrIF0gok253HEghv0NMFKz/G+0CD9VX3EWdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335

On Wed, Oct 09, 2024 at 09:38:21AM -0700, Nicolin Chen wrote:
> This avoids a bigger trouble of moving the struct iommufd_device to the
> public header.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h            | 7 +++++++
>  drivers/iommu/iommufd/viommu_api.c | 7 +++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

