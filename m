Return-Path: <linux-kselftest+bounces-32567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0ABAADF32
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F8C1753B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9F279917;
	Wed,  7 May 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dPiuqllg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA51FAC23;
	Wed,  7 May 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621076; cv=fail; b=baZo3C9Or0imVp4PgYMXAJKTCjTVnGszvvyQbK8fR6tMpjnLrjFzVqz+9u6p1/8TG7s08N+3zFWB71E3MMQHaEjYpuz1ex6rGslSTR4N2l7TiIrBMmdk+j1VuCIiDF/lHc6A82pNM/476CVqC8AzULgIZZiUkNKgfY4clag6Npg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621076; c=relaxed/simple;
	bh=5jNET30WIvAGHIFbqfh6h7smSvx9g35a7DYpZgx1Dzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5Zw9dvjraVue3mwQ6TORcFmlgfC7fNr2A51PVd85cRo4Aqd0opoLOhCvizTzvPYD7hpgL5+duFzuVaOKqA4PU8qeLNcAAKrB8t1tRCj6Rv8GgS3xyMVhdhDaSE+qtJ4rjJh8omDwnS/9QdW/WtZp0t4DxqJKyu1XM1LiE7DmC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dPiuqllg; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHbeyuIND07I+1w9I9J9iI/QkumTDATlcoGVbUx0I30tqABjH4n+74aI/m2FgLxHsTpT6zQvjXno6gkKLV8lGHOLR0nb2ygZLcEO6mWrt3ch8hSoq8crtfLkHsJXI0ky/chGbjfB2L+DJfGRIn7Paqd+wKxzGLH7oNr9EvieCqBT11rnPnHh315gWpN8YsQoQHjDtrzUJp5TDCYhrDBp7EDGUABS7AmPxfi7fzDIQEPvmwMciYbRq4modNp4Irp+skG0zbBhhzQt09G8kEJjzeq/gZ/Mpe6veaSS7okezYVU623LDVBz/9J9QIwqEQqwFwLBqpsYxstKNCzfAqmk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLwgThZ5JLGPIZLxeeY8bRB9DW5YkDq8CFE425nngY=;
 b=Di0HxZUDpk03hQdi+k44aGLce1dtZ4Hwd0U/bxreOMudIc3i1jSVdGpdsxc6GR6l0OSAwivEI04cvacapaWDbaXHJ4G3nhpbejTuR518V4leic/NmB9taSFl8kz19n32imwrw7//XUCBxsOTdcL8xkQXsgcZegt2775zAl+GfxkGFNIBWQ7Z+Ttimnw/veuXlTNXbZJ6HSV2UX5ZHdcZYy/rtX5z/eBe3Kqut/V64MqF5vohfEE4ijonHDSTFT4wwQ3aJ6Xg02zfMVx5mk9a3UCPPi6f1noIpaPtMrSKLNnaERdhKx+xKHYLyl3vkRejqKKjB8KrrSHT4ThWP5rTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvLwgThZ5JLGPIZLxeeY8bRB9DW5YkDq8CFE425nngY=;
 b=dPiuqllg/3gUPOGQbwL8MsRTqFxKI9uWALSxuukzEUqYbbeTNUYpHeMPmc0gTQw0JEOW7kXeTai6RjZbqDMB95O6bY9ZlzmoShBSIg097NX0fuY9Oco0+LE5G2YyzEESlJQstRsl7KUpAyPerGYVHskq8D/CpARr99hBNDXS0dgYRPDEeM04HzKokNcdjyhhJFBFCwT04Uub/IKhvBPUfSnuyXjkNZ8Az+oarUUPYMIPULWE8EPGjgCgDGQF3Xn9T0UQSsyY+GOdyICjoMXno63+RQuO1NlZUIuGarzLeBqsI9Ov2462enXBk62jGlYi9UzYX3lh6vqFxJCvoHfpGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 12:31:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:31:04 +0000
Date: Wed, 7 May 2025 09:31:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Message-ID: <20250507123103.GC90261@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
X-ClientProxiedBy: MN2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:208:134::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d7389f-8e24-4bc2-ed26-08dd8d6308d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43iCf+hcindcRwOctu5BkAPvHQiZCydB4m2BmmRLBwVr2asw8NWHQb+sL2CX?=
 =?us-ascii?Q?i3huG/CFT1MwknN17T0PPxivRr0rX77ZDO2bt6onh8wWXu6w4CVRO2MqikFi?=
 =?us-ascii?Q?WZqMejjQ2OVPgnBwNtPf6FNPrn1WxcMz0orxdew+JA9hwRVpKhPSKocuwfzP?=
 =?us-ascii?Q?0/4c+TAwiaYfsgA0URAHt0ZKXBCGpK99s7tmGM1eu/DC0JCQCnI1ShtIPRcF?=
 =?us-ascii?Q?kZ+wX4SNTgmDf4+qqWZi0zdHexlVRTIeEvC9ox2ytcgC1HzJFkcqGwBIojAk?=
 =?us-ascii?Q?9yVp03ILMJTEgE1Q+hPQ1WU/DKYF3xddnzfIIR2zqkWj1r/rbPlxcItqBFVW?=
 =?us-ascii?Q?6h0d/a/GFPOXbFNB4nb96o6LKGn7e8OoT5MKQdjz8EyITFgZpcyFAeCCgbGb?=
 =?us-ascii?Q?RPz6H9yE5sqq//3LRz6WpyAsJRo+xiH4GFpP8NtblZ5MjAWCL06EFbM3uEBb?=
 =?us-ascii?Q?cWxgHHiRYIwYwipJ86foIsk/+Na/2iChXdmp933II8svEvrxKASsHZhEEdc5?=
 =?us-ascii?Q?/rnMPmgi92LFl/5W8WXUQotPt0vweW9wxFfnuMPS1tfFdNNDEx7x+PwqK2b7?=
 =?us-ascii?Q?tq4rZ6Po/5Ykp5o0b0ZMIBoH8iiUDBeAfUm4lh1FY0ZBX9KlQ9WTMGDLmuGP?=
 =?us-ascii?Q?tB+nKDZlDVK9df5qU7QeXT8+m4O5YCMyzEBAEYJdzlTVWGJuEHW4bueNajPw?=
 =?us-ascii?Q?pgVkuZjkQcjwVN2fnuYmLPsPYStCwG3k5KYJ79MIdPCwBUkHBI/JurgINXVP?=
 =?us-ascii?Q?KrAvXoWxLUpVl7LFb+dlj41vX7e+SC7KrXRBgkZR9zjDBhJr3GxIYxYFBzj5?=
 =?us-ascii?Q?m0uecYXeOtOM4LOxf2JA7NuNafWqMA2J1/7Qr6WM17eUHqxi9mfKvMYdOY/r?=
 =?us-ascii?Q?UfYzh3lJJVmtn6FotGTsiXAmBNa3wxWntSRdYVE6RXoMSHfcKi3Waa5QMKlZ?=
 =?us-ascii?Q?iIfo/RxjXa+UIuuEpkHNsyGzZFVbYGUbTqphqx74KV8ml9btDwNiqhHlTW9l?=
 =?us-ascii?Q?1u0v39aLyK+Sqk0cwF43/4aDzE2jGCXoOb2RokT3fiBtiC35JeoXA1q4cDSp?=
 =?us-ascii?Q?5IiL6SUDi/VGIvblspNNGyTDZMNiXif0lukKWZInCuYxGpjNGf2woNn9oL/M?=
 =?us-ascii?Q?Q+naowu5tVpaBt6m983w+t71YdXA4msCOK836qYTpsaHZ6u1DAoO1ZGMlvOF?=
 =?us-ascii?Q?/hSZq5KlZ8bfoK5uNQKtbhahX/r2QHwTp/FEgPnFlQc/h4cg22bFFtWuq7vu?=
 =?us-ascii?Q?crUq4bMCvWA68OngyoBOVILN8JgWTyke84xprw2VA5eX+Uj6d8yzaIVX4lZm?=
 =?us-ascii?Q?ho/3ZtKwyeBVMO2wl4Z5jFuZaOiDc1HyjwSU0Rur71nr2/lMkihqo2f31UOl?=
 =?us-ascii?Q?3j9H/L6j+sS+pL32tX2ugyBYw67s9zn9a6pkvLtQ+Wa3fbDGnAME2NZLxzgx?=
 =?us-ascii?Q?sYm5esKK844=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mDUVqCs/tWhNaWfE6SRQINah1CJ/nBzUgyoQJ5v0fozuhZn3FGzcX7+241aK?=
 =?us-ascii?Q?lwK7UDOl43Ii46bAlRyA5EqQRzrWpHUop/+cKUhRPNd2VDD7FCfb0ALxembv?=
 =?us-ascii?Q?5Mzkw6hX+XTWq4syUa3cVXIpMaGmrwmvQ8bsAgB//2f2+yIntLsYQJeCJk6X?=
 =?us-ascii?Q?anZVvszmGDsZ/cZmI8g1s3bU6djDCM1Y/cpXuv1HDA1TFO292ARZbyOZO6C9?=
 =?us-ascii?Q?EOvybv+lez1jDBokn0XYkmQzarQ6zcCCSQYk8spLLrHjuYL0mur7R9VCogOQ?=
 =?us-ascii?Q?Yw3xI45NQyOqiLBbgR7F/S3FctFjxsC9cKT/EnGzI1JCWleHvj5IR2lk3cbG?=
 =?us-ascii?Q?kbTKBxd+nR2UF/gahDsOSNBEcJf7FHPXxiFlX3NXzco4eXprb1PLIUL84/Fl?=
 =?us-ascii?Q?YpAGDnYrRJIhXchD01usy9aQxmkvjwyz4SXOeZBFX9ke/uxLNPTP8NwxdS/j?=
 =?us-ascii?Q?lFW4OrxLLPwntzlqdNCT1hmO5noxxvFGSl10jhbuNYeM9dy/bSj7b8FeqzsQ?=
 =?us-ascii?Q?78+aklLAaN4qMMoiN9UlE8cdRuimOzADkHMOTJkWRfBSx9O/va7O6b/iYREc?=
 =?us-ascii?Q?oWsIQS2HqkAghfty5v8u98lcrXex+X7TKrkQLBXv6kTgVZo7/2RYCt62gWKQ?=
 =?us-ascii?Q?A9DM8L9QckO/3JvnLLLvEViq3rfzPbfacVE6cH6So2ZwCa1WDvtj28gZRzra?=
 =?us-ascii?Q?RdUjKeRReATiDe7dVV+xTeVnop854EnSqViKuW9xVJBz0d8FEfpGORQCe2O7?=
 =?us-ascii?Q?3oCso+Rmg/g0LEdZQV9oeWsCjMykcAikaul3IEHN2g/CtsNs+fE+6dkyp/XQ?=
 =?us-ascii?Q?yZauR/wIb4uTPdR6/J8Wrg4uT9jKFC/JH+Ye9FYlRtCrt0O310oDOyVXPDDQ?=
 =?us-ascii?Q?1+j4vTIzeGz5YP3U97lC4TYN5WVwvRD/D69LPJsLcTn0y07bTSwJWqXyUCp8?=
 =?us-ascii?Q?I/2r/tLSUQFWw92wnR2cYqVwerAta8od0psI9UHvRmIL7yc+LRw/bPXZ38CN?=
 =?us-ascii?Q?/vB3D2ex6DTYhSIEadAWOcLtSuqKWqIhB9BRyFGyW1bUJVNohyuyfhBoN3fp?=
 =?us-ascii?Q?QhHUGLOdrIj77JHX6WbgymmNunMGNPo7/RIDcm9k4XGct0r0SGsbDIbDN9Ss?=
 =?us-ascii?Q?4QYisk87Awr8j8tUb2kW95U3i3Zfv1WiS6DgYjdBNPPZFzRp4KuTBv6spr7B?=
 =?us-ascii?Q?xavfD0MKh/vGDtrNKPsGAsejH7pzhzzIq9xm9NBY+FiyLiJhnK3qQt8EqRBG?=
 =?us-ascii?Q?N1Jn1/s1yryW2I+4lkxgzxnOrFKakIqaou5qXgcKaEmB3ckyzINPsy+SfdQm?=
 =?us-ascii?Q?Zs+oJfz+v4Mz7vq4h5NMZeZcT5yYUfG3zK7FBu0sO+PABVk7rlaE3RyWTCIa?=
 =?us-ascii?Q?bng5z5CZSb8GzbMedVBDsL7vkvPrgjyxf1OcPjm/uQEyEz7lQfgCEM9A45q/?=
 =?us-ascii?Q?dVzUxc9AWXhn2+ggwNo/k6bvy7Pw8M+T8e3124ZiSzcMhxuU3BRA33HlZuZY?=
 =?us-ascii?Q?bOHk4ksvS4tK6UJ/u1Fa86LqDDsNlVIyv03lDelIV0L0h+fadCmAyF+ltlrg?=
 =?us-ascii?Q?myoynI6h8FqI7YqGZhW2zEUy27+1s75R9uCCc690?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d7389f-8e24-4bc2-ed26-08dd8d6308d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:31:04.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cm8VKPWt9bGRH5drs8H4L89XLTyWNftmRjz/BYFTe71j3RVM4chzT5mOjIf8gvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

On Wed, May 07, 2025 at 01:11:43PM +0530, Vasant Hegde wrote:
>   -  MMIO Offset 0018h IOMMU Control Register
>      EventLogEn: Event log enable
>        * When guest sets this bit, qemu will trap and will send queue_alloc
>        * When guest disables this bit, qemu will trap and send vqueue_destroy
> 
>      This part is fine.

Ok

>      EventIntEn: Event log interrupt enable
>        * When guest sets this bit, qemu will trap
>        * this needs to be communicated to Host so that we can program VF Control
> BAR and enable the interrupt

This sounds like modifying the vqueue? Or maybe on the viommu?

>   - There is other bit "Completion wait interrupt enable"
>     This doesn't related to any buffer. Instead if we configure this for
> completion wait command it will generate interrupt.

This sounds like a modify on the VIOMMU object?

Jason

