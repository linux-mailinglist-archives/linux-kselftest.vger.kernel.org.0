Return-Path: <linux-kselftest+bounces-33081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A4AB86FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F18E16377C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2629A9F8;
	Thu, 15 May 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQ8nko27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A8296D27;
	Thu, 15 May 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313365; cv=fail; b=m7Qrl5vR344vqNuDxdVx1dK4aZnmoGRHV23RNxBZsu3X0NsCtulCdjHlLKBjOb2X4ctmaabNFsq6SOja3bDbZS7likwOPcmlbS+Y1E+/g9WZGRqiwt0e18ODjstRD3jFKj3LMJvWNsr7ayZbxBSSPknXSoGD61khlL7dDqt+29Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313365; c=relaxed/simple;
	bh=Bk+qsVwFKmwHSro7sHiPT4YpHXRWpHzkh5fGBEjh4EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aW80r1L7PPIjZSHN2qHOAYUZpotI8H4czJPlLnwuit8Dlywa0ORcZKO1JRuCL1hp/lwQPTgJg029COzSF9Z/FpfMq+EZRVw7vvFz6E0YWeQcU1VqM3vPO4lGB5lsxa2xPlGpfope03sGLxQB5NuMzoObPCZjBObHfI+bqJAKiW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQ8nko27; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0qX4DZP17hKND9p2GdIYp5WpOMJqP9S+O4KThrR2WzxpanPzHrmG+Nh9awyNCit8F+Z2IvVGcz9f1qFkkrFaa13UfK8xEqr6a/BXWa750No1EgQKpvsGcEuONndexGYeI8Osj/dQjVjSzd6wYGZdRasT+rqlDVE2R6MtBwT6UXGAPg6WBp24huCLn4TWVa1SW5wpbJNEo7lL66cY/2qunL/o7DAO2vWhrbat4UoMRk/geZ/1icoUT4imzPYjVgchHKrwGIwpVq36sjwlyFyL3I4XOdWmkDXWTBTcR9smBbgjqddqxGf4DU1URW+fHdiE2b1RT0IaIBsHgUd/PnmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UBA6HkDqq5eGG/MPwR7VC+rXvspG5c63cUf9jkzM9I=;
 b=OZU6IZ9Pk1jr2S0hl5lFNyBmJZfwz1kZM89sBJpgylSZ0MgQUPnzIQGLT2c8GovVvNm0snPFghW4zsioaGZ5s3zzb7dau1W2Iz/zXXx+LyIi1Sz5J+oZWa9dd8wMsUHFkJgQ1UwbpHy1uE7vYTl/bU+Iwev4REjoDQj6aWZNVqyDlzeIL4fKlNwxI4thh9OLaV0taxxC3B8UBRakkXrUpUos2OZkhbbDYhCDMv8fH6w7ShAtCmvqz8yoqCyxvLsGb/smbEbb1WElkkFg+wu1Kf/vsw0Cc97nb3jCEN+lXr1NXq+foJr8zldE/qeDEt8Bn+qzTN22MX2K3sJWssj9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UBA6HkDqq5eGG/MPwR7VC+rXvspG5c63cUf9jkzM9I=;
 b=WQ8nko277Qa0kUiFaHk0C3VK5HeVrgtTovlrLxWm9iEgJe2QX8C+ZV8AYJ1xCTDoXE6X2EhevpnqC5w0d8yjm7cwmrnMALJXkmD+bEqRfTA+SsJF7Z9o8lzWvcxmoSctdCPnyG4LSd+quWvVye+UVrv7GFC4cwSLWKyDESiuBgzlYIgJUo4tMqcgeGOBS6gUWka/Z9YyLIdoq839UPdJqbQNTE/0Irvjuu/O9Qs7AGEP5+vFGRbYX9Aanpn1b8Vfks9b4t/Xz06hi2I/5yiRILBE2GY3HOBzftvY91IW4FF3W1Y8baEHIhxCBiNl/5kgjVKzfvlxFLqk/qnLToIXQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 12:49:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:49:12 +0000
Date: Thu, 15 May 2025 09:49:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 06/23] iommufd/driver: Add iommufd_struct_destroy to
 revert iommufd_viommu_alloc
Message-ID: <20250515124911.GH382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <fd387a4e4efda1905e270d28986e4563dfee52d5.1746757630.git.nicolinc@nvidia.com>
 <20250514182600.GF382960@nvidia.com>
 <aCTtQXQ61LLbHk6U@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCTtQXQ61LLbHk6U@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 197f97c5-c284-4bf0-eb10-08dd93aee46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/Nokqczrjeb3PnsvQaTKFXpIaXw/OOofF1YnPZWXYkIFoEc8z1iOMWlz/y1?=
 =?us-ascii?Q?kceXb3UGVHmelcnf2Jd3pjgBYjOe3IHoziZA23grvc5IpcnKD4B3RvIUU9Ae?=
 =?us-ascii?Q?8cIrS3WMSB5eQl9j3FvUuQa9l+8oRJ8TdznR9JfRc53D+z2sXaD68S+mobUF?=
 =?us-ascii?Q?zhP6dyZVv1Itx4gJsd72U+1vZDDhMM2RFFhvjslD/w7G3WlbqLLnxCT3pf2V?=
 =?us-ascii?Q?5gtkm0hPWDMqrOFBHmTzbljOqtJj14xh1uj9parbT+M2xlm0EhuYNg3c1Bdd?=
 =?us-ascii?Q?v/ciGe7GZlezKQq11FFXwAu2/bpCHIDyk8+fVhPwBUx/ZEC/dSTMFwRgMsZ3?=
 =?us-ascii?Q?uakEuUbilzPTf3D6C6T445tnBfH/erZHOeHKjdhVA7T4ud84J5SNuefJZhcl?=
 =?us-ascii?Q?O8YRQxwsGXDSywgEsfXSxpcEWm81YzUYx5WOLzev15n5XcvpGXrYsLTB4TNC?=
 =?us-ascii?Q?hs3Oq0K7+Ow86DZd0yGbfevuMJsuu8em6+oQt/FuV13cWF1c1N3ek8ITOGmP?=
 =?us-ascii?Q?e/MzVjRN59a3jGs3tSsw7GQBUPD9zU2jhELA1MDioAbqfUkSNHbUexwWUcCM?=
 =?us-ascii?Q?ueg4jgFqTk5OYtJWzq/7LYo9cCF+9tN9+fjWBDONnh1enTWcv8t1sHTwxecZ?=
 =?us-ascii?Q?uWD6vmJJMGRcPoYsBrubxCG0IVE/XlXOjiHvznkm0fLN/j4+srdHzFn+yvW2?=
 =?us-ascii?Q?99m2bejw8eudpYOipem2Ir15omw7e0epUZXXdC1vN1+Swy2DGkrqxA31R5Qh?=
 =?us-ascii?Q?qRkwX0xfyF1Yj+pVLom3Ta3eIC9PmVyqMkEVsMO5naMEqEvr3OnoXLeUSEkL?=
 =?us-ascii?Q?bvEdQdkau5SG5Pw46ZEJKKII8E2i9KRIXoLsKqU/ZSQ6BFJHn5I47ki5EjeY?=
 =?us-ascii?Q?dwo783ENqicEhF0vqMnssHagKraXPo+F9W4IvOfD5MhXeEiyVmJ6te4QKUqP?=
 =?us-ascii?Q?zfxbhwcH2qYQPSovU3kbNDIpDvES506R/wCzkFYzSO4KHkETuGczbKyp+Oxp?=
 =?us-ascii?Q?wdQJNfXz6Tf9I2T+ZM/5Ps9GlLmcVSqEiKI9+1CIAU8TYIFHcR/yiUPFot8Q?=
 =?us-ascii?Q?T/liD1GkOocqtj5CsHWJ6Vo1Dt0XKjTnph1dNErsUjVFW9ZJNhpm5Zf0gvTn?=
 =?us-ascii?Q?CR6Md54CamSLrVXzngWhkffz/YEZB1+8pN+UBTnU0p4SmYJGy8vVK27sgCDG?=
 =?us-ascii?Q?lJP5sHz0/qqP1WLR/NsXfOE0nRQ9iZXBDT7WbUudo4O6Nh3LVPCm8eNzWZl0?=
 =?us-ascii?Q?mKq7c+7GEb084TwAcoKslgMr5FAWwXx5pYMKdHatIesknztYsV5Q2eE2de1+?=
 =?us-ascii?Q?tFLm2SG4ivIclBqtF28/w2qZZo65i0xuDzvUayR4vjAn5iwdDfwU/1tpGn+K?=
 =?us-ascii?Q?GmMPWMB34lZY+FEP4pw574iX6Ebm0XOBuMuGaEjDQncwTAMRAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DIfM5bwxAYhpj6m6QpiZ9RJQlqD6Uy94b138CgO7XPMJQnFHa7pQZZkFeowC?=
 =?us-ascii?Q?U3MxJd/4CIXLLWlY14fAazpEiIkZo7tJ3QhXEhtljZpRPpDcYwinsRHdVlxs?=
 =?us-ascii?Q?eDG2K+sAzd3BaTAwo9yUFz360SXDbcictZGF0MdX//GUI8FtiMGiT872G8mN?=
 =?us-ascii?Q?6UUu9i6B+f+FZO2t95kLgj9khwB3eHzfnQ+ZPnswIY1RSaRyG7EmA4aHs8nD?=
 =?us-ascii?Q?+Y20SjHF0mIkZhzGdLJbBS28y3dppV8Gwp49EoEgZww9hv/sHK8JTrqQlneU?=
 =?us-ascii?Q?a9bHBBMZ0CFqr8dtwxJ85xvdQ0JmSZWKm9ixUFMSRWVLmmeMuIPPFAWpFl1C?=
 =?us-ascii?Q?F+vnQQXPgc3/VkEaxGuuyWFiEqS/dY3HxJycsNpSepGVuyiXBfGKKp5AAtD1?=
 =?us-ascii?Q?7dzBhQccYARz+ghyyAz7NN45rrnp0c6rvOsAfOBEWPDZ+yWSJYcAbNyK9OuM?=
 =?us-ascii?Q?+41YC27+AOt4pV8v/fqN6yZwJAM6tsgFn97ogaxEUn7Re73xDnbMXaKX4Lf/?=
 =?us-ascii?Q?+DDerWLs6/Z27XzAs0YSLRKLTsrs+7kq6qi26Gq0+bycGOrLP5T7p841dohY?=
 =?us-ascii?Q?ZGdgIfSINBkN+mU26H990rCBehUuAhHRDq0jmA5ARvzmejFyQylZzqSUwHxd?=
 =?us-ascii?Q?p9OBr5pWFRhbCXt9Dj6jr6Gdu8c/tyJlx+PrjsV84urU/NYpOv4UxcEeP22U?=
 =?us-ascii?Q?jFyVlWZKQEzukJrZSNrM32S0BgGkBHvv//VRYoNwDHRBZkM0ay5msaZd/kIQ?=
 =?us-ascii?Q?TS4LxN5sFmpaaD70WMeXQ5431G5ozf8/bnj/jbpF0P8p1KgAjzRR1yA182Nv?=
 =?us-ascii?Q?ZafVgwaPYWldPYmLhrS/oJ6F7fx64C5UMyBxYo0J8BS3XhvDhicqJ4zEGut1?=
 =?us-ascii?Q?VO7X8EQsIdtSZ13ZwyzU5e3GPSeOQpNbnUzfPSAwu1ypEfu+7Hfo7FQ5POJ3?=
 =?us-ascii?Q?ncby6A1q7+ZknyecrsL6wwJTn9JVjdzzYMLeZY1SLZLubY1+hlOr3kEYOaC9?=
 =?us-ascii?Q?PZ4SIi9D0Y4CQxx5W+2E6C6dOzcNIbP7gB+4GL7bw+mjnXHfiR/BbH2x7OiD?=
 =?us-ascii?Q?NGKxIspIojNT5L2tVg30c0J31BUjZkeXW+p5XC0m6oXcvcjB6lMsauBL4Y9V?=
 =?us-ascii?Q?lRgdZ73gLtbD05ymYuhhUQ8tYOdN0m/4G1fqdXKyyN4mayRuinePEqdMDbX1?=
 =?us-ascii?Q?pjmUR4Km0hGuzVnxWyDvEsGAidDbVj4HHKHa3P/FPvRAo+z4HJNLNy5OE9RL?=
 =?us-ascii?Q?VTpMzTbLKQjgQQGmmfKiKVn3Wypg6baBL3tWlq6TIlC3ke2bPlnZoS6ET7vf?=
 =?us-ascii?Q?0zp56m6XfVwmZe6FcWFw+vcxxPYQCQvAORZWkVW421tNJvbrb84QrhbWDBVL?=
 =?us-ascii?Q?ib0v02gVPNagTRQJnJ4fbxBGb1lqsra0zlEKii0hZxnDjVKbYgg385lYNrL4?=
 =?us-ascii?Q?GagV6WG0u4D3O66xPX3H1nxfpDG4pv69NPpQ3IhbXuvdrJP6FqF5BfwYo6yl?=
 =?us-ascii?Q?Zh/PQoL8gORDzSyE3r6LZWhLHH4NJf1S5oDPIdDn7pHss9LAcq948KFqTLpS?=
 =?us-ascii?Q?PtWMoQm7QAsU/ZkiUfcQRSTd2hRe9Trbzh9ig+f2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197f97c5-c284-4bf0-eb10-08dd93aee46d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:49:12.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsUMq0+w36e1jSgt8fuqqJzScE1UW99uFRMpFWDXVnmfMtoTO2o3Djcvv6G9iC9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994

On Wed, May 14, 2025 at 12:21:37PM -0700, Nicolin Chen wrote:
> > Then when the command is over the core code either aborts or finalizes
> > the objects in the iommufd_ucmd. This way you don't have to expose
> > abort and related to drivers.
> 
> I see! Do you want this to apply to the all objects or just driver
> allocated ones?

I would do all the ones that can work that way easily

I think it would just be one patch, replace this patch with that one.

> We would need a bigger preparatory series to roll out that to all
> the allocators, and need to be careful at the existing abort() that
> intertwines with other steps like an unlock().

Those cases with special locking couldn't use it.

Jason

