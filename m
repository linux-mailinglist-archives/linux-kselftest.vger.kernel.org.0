Return-Path: <linux-kselftest+bounces-32152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42361AA6A22
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E4D3BDD5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE219FA8D;
	Fri,  2 May 2025 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o2Au+jkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C242F2F;
	Fri,  2 May 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746163830; cv=fail; b=IIdZ03GJFhzjdbMsYNiQ6EfqaMzND6++ePrwtxFCEavd6CU83JYlWfVkKWd2o19LnTaLG7+/Q3ZMqXkHqUBM5x2v7edvZhdVWvI6d6sZ05wrFnuBQQ671SHU33U2tdTdAfoaYRe7qeaMxdac9EeM55Yrorw+cfzBt4I0iuFWce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746163830; c=relaxed/simple;
	bh=0spCbB4+Iy1AmxZgs1ADco68FwW8EAIDLBc+L02pdjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg7WMduBTggh7DrReF6iWdmC9ws9oeH0y4JiX/5Hdw+dZFLsUrVG/zOrFY9HpIKNrvg/gllfKPSmrnF7e0oH+Ym4anIax+B9RIDbwf8cVOjAVjFoM/2laYIENWayhMmjyZYropgdotNuV5JJQ3/FYauLgeM8Q6Tx2pSDavpfFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o2Au+jkG; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKHzASEFw7OcIfWXCv98GDJKojtG6RsBpPwoOxsGMp+UXXLx3WKHE46Gb8RgNC3n5Y7xzWTL861ko96wya82j2qsp8/EVYtfj2RDT1/u5/9ZETUpDaQg6z5lxbAjXEzdWe3qJUHp4mz6mSxU3oNTm13mee+lvu0bsIEhCxSMbhxyDiqu5j4hHVwudYTM+9L4QmcfjFcphcq9M394TiOCLcvmtIwZg8kkxK0JBDf05zXK26GHHIDFxrxgwymIm78wRMxOx0lLRLn21XhPUk2pZuevBr/YxHLUdQW4Z55ZZ6rwbyP+GpTKIDhI32r4YHjxYXrXU6O5QOxrlq/C4vyRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VDGk+tekDA6ZKybBQwk6jRrhp7LDw1yJngeaMCibCA=;
 b=w2vvJXq5aR18Pi1D1kx+iBit/X8G/T7+JhciN35uFWaY251ZtYQWKYIJPo68PhCz+wj3Fs3TPaLRxdid7XKUWwuHeGMr99j9gRk/fBW7Q2+6a60jqmAyw6/Ylob5Pcd/+aLyliLxrpmKAfROoWPoX95sE27BVzXZEgVwf5q7CF7fQml8vW+LpwcaDC25NYKjSvTIXeiZM94OSKBAhyre6tZfiw7/rH7PG3qGz0Vqp9Qr3y0Hi7DRe6/xvTrqvL2C4qYO6HBlkjb4LXiWLeKkDEyLkiVaFeC9cORPIg8smA87Cg4Zyk5WntASWMStAe9Hy+BRDw3lEy7Ey4ZeyLpQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VDGk+tekDA6ZKybBQwk6jRrhp7LDw1yJngeaMCibCA=;
 b=o2Au+jkGzcd/Ggpo9eyKsEi6V4DUTOmkhUnji/3RgEodNiRfOrAYLlBpoK86XY0M9wbGk3Mchr34zYBMs9u2LrHSJgNgdKzadv6wxpwW7PetKGhV3uBvtolVGye/pkLBEluluYaig0byhAxkc3lUi2lWugiVqgggiRf66S7Vbahqy3JXGdb8xUxyi43EuRk08J+QzlrT4WS+AWiriPyl2loKZiRml7hNZ4knclMZtwTI+ZpkZdjhv2s//wufydyWodZSymE1Tbg/JiG6JsC2TPd0N1WrrXrXy630bC/o3rpphQUNE6lEhADEMqHs0+IS2n8BsRtI6TCrM2+uK/9eww==
Received: from SN7PR04CA0202.namprd04.prod.outlook.com (2603:10b6:806:126::27)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 2 May
 2025 05:30:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::49) by SN7PR04CA0202.outlook.office365.com
 (2603:10b6:806:126::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 05:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:30:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 22:30:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 1 May
 2025 22:30:07 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 22:30:04 -0700
Date: Thu, 1 May 2025 22:29:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 16/23] Documentation: userspace-api: iommufd: Update
 vQUEUE
Message-ID: <aBRYVkOKfFGMb5Y+@Asurada-Nvidia>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <0beddeaaa4a8a7a45ce93ff21c543ae58be64908.1746139811.git.nicolinc@nvidia.com>
 <aBRA75V9l9WlI2Q3@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBRA75V9l9WlI2Q3@archie.me>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: aff26d88-3724-49f6-0a84-08dd893a6f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZ2uD2AT8L++SZZnsQoTEM4NGr7+TZPaarbLyC/sO/vSUIlsgQV4Lgc7AKUo?=
 =?us-ascii?Q?1WftLCJANoWYcoZJyIHJX7Ktx86/4bb8nFofK3coyDxNnniFXpVxA0VT0/n2?=
 =?us-ascii?Q?QKDLdT4kW5PXtieQd7j4mVkOYsAKAyNxEJz1o0/Ab+sWWBoJq//9LZXZ11Re?=
 =?us-ascii?Q?dinvsQxxysEYRwmb3GRFKsYdnpVK/wrWlwuAIgSX4sCNheXd1NdIbn1NyYeL?=
 =?us-ascii?Q?Z2mM4oOdHwU+iuP5a/5p+9eLWYulxAaCaWMycvsQWYHRXJL9ySEJwsQlztUD?=
 =?us-ascii?Q?vNMGqGVJi2t7AZo3CYZ0XsbUjs48Kuzr5eyP/J2Z93s/q6JPQ4bB+kIkOYCw?=
 =?us-ascii?Q?piiDcCWvUleBxVAYqi7qsVmTmaIVK6NTbSOmTYMJ/SZ2e50lE3GY6phcFy3u?=
 =?us-ascii?Q?ND1qxlwQa6M28tryu9F8RibOArx72CWpKDLUuCLbtp6bKg4SUvaEgED0XnK6?=
 =?us-ascii?Q?OcvIfCnkmbAh9/vMZp6bd7LmS7OUwhQ/huZVXVPVXNA13a8FSKWFt8w5U649?=
 =?us-ascii?Q?TKtwnFaCXEYk5Jd1ZVFv6i0oZnQSMCWqL+QB62pcQSlv6EeOMyFSpPj+WBFe?=
 =?us-ascii?Q?shEF4x3U3VBVYpHn51qQgAynED0fEDtXzSlT7ii5aCR1bdls6DRhE4ordszI?=
 =?us-ascii?Q?KkT2zhP2EwT0Yf0fOIGuXim5zSfUDjfZoKCOSjksFT4iH9ti6a6W4JjA1tGd?=
 =?us-ascii?Q?BLZMkKjqq7aNNa8g7KZU5JdvF+THIwrc5kcUJo9N831ykAQf5Yur5GS/tauc?=
 =?us-ascii?Q?r+DADwKo9uAHuEnEHbMWwumGRktbNOgtqHJoDSx9Iyxz93iM58+0PH0xBv2H?=
 =?us-ascii?Q?WVu5rWE1oLjrFNch6elMrRUFPt5kP1PYuEd9rxP5ICxZdOkrCrTUUY7YQ/GR?=
 =?us-ascii?Q?m0PX489zPorXJVkaNi/2NJAkaE/q93M0Tw9GHlQl2+kMUwUOUfYBV4oGxDOp?=
 =?us-ascii?Q?CqbiL8TJDyUyB/za05u4PIX1ClEv4guJwqKjl18TIbdM3hgdq6f16Cqj608x?=
 =?us-ascii?Q?NpSM0iH4f5+BBaMIzHynvihFwbTSzlNH/66O9XKN7Xbr1FjSbqBHG5pt5CiY?=
 =?us-ascii?Q?L7qS//8QxJlyPB6vHWufmHDXeYvwcx6hFAVENTcDaQBoLVbP6QDfA0WOrw9C?=
 =?us-ascii?Q?yKoCGUsX47D1/CfPNxfCHsJcJdBqB67uIPOGTDYW8DSDb182BVmB47XZ77q/?=
 =?us-ascii?Q?nGgmzEUYiiBrM+SSMJaC10WR3TtP2hgyupv5Vg44BPKEz+5u5HEdpDDiuosV?=
 =?us-ascii?Q?SR8dWIAKXi4Rj3zKF6iGJGXg3KfJ61HCREZRJhN6KZVLjkEcOk3V4PPBABh4?=
 =?us-ascii?Q?8l3BU1tYm+FQ0SHSAfkol1svc4Ic2rtVD7z6HyJQBXSZFkIZChZ8dODjyeSD?=
 =?us-ascii?Q?8G53NqbK34gQ/iW/XN32OXIqSzl3hQ2mW9i4EQL17W8q9yrCiN7FqX5qYuFK?=
 =?us-ascii?Q?Amp63HItSB2jcH1j6Uv0DV/49JA+NfPgvHS9vMq8b4vqhTUwhRAlvlLcqpza?=
 =?us-ascii?Q?HkCgM9m0Dzg5f97hLeHtn1ldxse44oyf+dSd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:30:22.7980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff26d88-3724-49f6-0a84-08dd893a6f94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

On Fri, May 02, 2025 at 10:50:07AM +0700, Bagas Sanjaya wrote:
> On Thu, May 01, 2025 at 04:01:22PM -0700, Nicolin Chen wrote:
> > +- IOMMUFD_OBJ_VQUEUE, representing a hardware accelerated virtual queue, as a
> > +  subset of IOMMU's virtualization features, for the IOMMU HW to directly read
> > +  or write the virtual queue memory owned by a guest OS. This HW-acceleration
> > +  allows VM to work with the IOMMU HW directly without a VM Exit, i.e. reducing
> > +  overhead from the hypercalls. Along with this vQUEUE object, iommufd provides
> > +  user space an mmap interface for VMM to mmap a physical MMIO region from the
> > +  host physical address space to the guest physical address space, allowing the
> > +  guest OS to control the allocated vQUEUE HW. Thus, when allocating a vQUEUE,
> > +  the VMM must request a pair of VMA info (vm_pgoff/size) for an mmap syscall.
> > +  The length argument of an mmap syscall can be smaller than the given size for
> > +  a partial mmap, but the addr argument of the mmap syscall should never offset
> > +  from the returned vm_pgoff, which implies that an mmap will always start from
> 
> Did you mean never be offset from returned vm_pgoff?

Yes. Will fix this.

> > +  the beginning of the physical MMIO region.
> > +
> 
> Confused...

Meaning that VMM should just use the given vm_pgoff as is, without
adding any offset to the vm_pgoff.

Thanks
Nicolin

