Return-Path: <linux-kselftest+bounces-32778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478BAB1D49
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4C5247C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919725D1FB;
	Fri,  9 May 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDdfn53F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43F237173;
	Fri,  9 May 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819050; cv=fail; b=hVwW76vhvAgklx/4LBovB8VJlYUIf7sUseT4LQzV4HtttpW2dRUuNokNEB/0lq99D/K+G/bvw1iIPqJ81cBBvc5/0LJCefxocEDq85l4S/K+dRlO1R/Iyd2No0KiIY1mVRigC3oUTGQZhutMK0iGZmFkhoVIyAaAvcO0vzNRXNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819050; c=relaxed/simple;
	bh=dT9ivRLf8W5mYMdi8MWSIWZnuzPqdqoPWcjm1l8tSaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyquZ5unXigZ9+AMJXGpCXCnPNT7tIE+2lYXA31uhxyNu6qVm+XNOEJt8PrKbmpogGRo5yM2vx2yyE+BsaC2G2KjHGX1EDNxWohn9jI95zrGziBaTqG2Sz5pZTHbTYxbqfsEXE1l2H1Q+7/pMjHYB56P++xYmc7zsgMmtlh3q2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDdfn53F; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6rANkyFaY8TS4qF6Q+vRCJRbNJPEDRv9OCgmTUs/8D9MrobPCk0iVg5wyrPXoE90ksSJpIh7D/SJj4rxnB4Cbw1W5mraeY+x40zarMp1Bp3gMxTSNpNAgebo4LljmUaUwz3MYRPk6ldgBgWgjjSdxxCNV876VYydJjMbmtMF6L1b8cNOPJFMwdt7CjfZp4oIbzsNow2T5RXJPl7JwzH5CDy5L55HA8l0qtyHRNUJ1363HwnTd4PkAABjdgXZjPR+iousfE2GEDkz6LA0lI7LuGGDGBs5DKjpSOylFhv0cgd0OaQ9oUdDtBBQWBBX3kkSEYaOWSEEh2IBfJbNmfrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE0Kz/IjOqS/PsGnt+6+i4dfJNt8icpzkbWuxm0yhTg=;
 b=ioyJ3/n5eBN9LEiHY9oLyeVkeuWUWBe9ltTk3qV68cQXeZ5QXytzll0VpATLlnfL7E86/5+AubVQ//JF3jvqhqY04ffn13kQMITYxFcMkc+Nq+VwAUGmaaUWQhb1sD4bQsbixAEJxT6hSQpS6+JCha+pKOD4Rpux9/3m18eohPPaUdRk+r68W0n6T10SgsDJkw/4gOVkoedH8yFgXWWvGTFoWAd6M7F3IncGlj2MoomulU7r1M07yUqMAa1e6zJhtJDrt2s7gH4zgzY71vWpNzILqqxtY7LhzmlKxw34w6qu0VCVZip+wydV78EtU4E2z7/HaAn5ST+kbvWubG21mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE0Kz/IjOqS/PsGnt+6+i4dfJNt8icpzkbWuxm0yhTg=;
 b=SDdfn53FKDuBLkaqzRClaIDy5maRcJ2V/hL0B4yYSNzPjwuTQRUW7UmcPZxnvKdkMZkuyCrofnUlVoaLitG7EJCY/tGpBW05/YyRyO/vW8N6VZoKKzcq7F3GHtreGGhumVMH16cBRIaCK1ChOYKRGD9wx41InFqGDjw/uIKhq9BCh/4mPV8ZYh/4kvkKz+jxw9zTEtOMlzgIcQvsvXObX0fgK3S73Y4VFI8H8uMa7kSEKzARR3O/A/XO6k12zVZoRe7xrp7yLA0CFyKLOYdqrn3LwiAGGSk3fj0k71FhYrTdNbYFQ7RguGXWsun7CqO448FDx7HrrGCxDSLLn2L2ZQ==
Received: from BN9PR03CA0514.namprd03.prod.outlook.com (2603:10b6:408:131::9)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 9 May
 2025 19:30:45 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::b6) by BN9PR03CA0514.outlook.office365.com
 (2603:10b6:408:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Fri,
 9 May 2025 19:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 19:30:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 12:30:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 9 May
 2025 12:30:27 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 9 May 2025 12:30:22 -0700
Date: Fri, 9 May 2025 12:30:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 14/23] iommufd: Add mmap interface
Message-ID: <aB5Xy67VU0ZNQpXH@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 934a96da-1996-4991-9b10-08dd8f2ffe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JLhE+Bb1wrr0yXZ2nc8ke+prk5JtsebOrrWUU1jX/l+5kOl16Ks2FlaiHGlF?=
 =?us-ascii?Q?91DcgNLhYLc/Mf16eGlsGSp091CiokAtIGqXdGBSACuEwW2a+IK4lvNfnkPK?=
 =?us-ascii?Q?sTEB1RhKdsCiei9m7+f2+Au+LPZDzZts7zY5BeJcb04k1Q09PcTlg/E5WH0M?=
 =?us-ascii?Q?cGjIg+HdT3O2AF9U9eCcOqgtxMIsASGk/DolWt/Ee7tss2IHus9sYvlV2LsU?=
 =?us-ascii?Q?Drc2CDC/VluCVHohBqJgBR07xV61Yy5s+Z7ZLKo2V+V4XpKQ1V0jdG3QyO1z?=
 =?us-ascii?Q?yEhIDJp9dlT9v+J6eSFF8BPtwsEXcF0OlQSdtF2NTUdd+UugE0lGnU2N4Z0J?=
 =?us-ascii?Q?6P8FnBArOufsrq9oIM1exSkrbJB+tJnV5KahbPLGiz2BjWKkKQC1GLhBkAcA?=
 =?us-ascii?Q?yy6bJVYPCJ6vRlF9Q8szO7AKo9NR8GSg/aCn+UobdQrnk8/dF1JGc1kaMc55?=
 =?us-ascii?Q?elbDiukB0YcxguIb+gk/0YmptjfYeQAluDt3vuKtJ5YMydA3IvHxMyL0sKhJ?=
 =?us-ascii?Q?qdM5x0eRlH+m4Ec6NgjAISss6hv3t4QQt2nnUJxc54k80c8h+KG6uwZ38hxV?=
 =?us-ascii?Q?8IG2xPlqyS7Fmz19MhxyEgyJW53XWe4dQhZUNhJvKkUIfTsjpy3WxfaaBNtM?=
 =?us-ascii?Q?ybuiwpqXz0CpQ8X0/Xovx0Z9I9SJpOgQwVQoO9axBZ5G5BcwuKRfBReMWAYa?=
 =?us-ascii?Q?+7m7k7O5t7q0Ib/snYwPhcxtGy0cjKxwvSo4T6U3GGMli2zSvCzxHDcVrY1B?=
 =?us-ascii?Q?6eL+p/p7FpL5gOnIZGtXaityQ9dQt95IbziehqgPAqp9B9Z1/tGSJypqth1/?=
 =?us-ascii?Q?TAzUk+JYnUPcIy+IMGFswJ6chNA98L1RbgfzHvsfrmzNXR30F9Md8RccgbsT?=
 =?us-ascii?Q?Y8Lq1Oyjze3gaOOx4iG+y0f7NWP7YUKtq/0VQTqg72IBe5WG5MO/DHoBVl2X?=
 =?us-ascii?Q?0KKGGugrKPdvv1MndHjtoaFLRwnmqLQkK7+Ei2AEuOA7TUdn/kPILV/ns5fr?=
 =?us-ascii?Q?tuFgC/6TCu5aQ/HJCPSHBV6HZUd8V15vS1Toa3tvTqEnnKi42OFXpSPbC4lM?=
 =?us-ascii?Q?61Sr35ojUsjLVGCbIBzS5lWzqoTZOeMBRXlC6Xp6j3GQ1+PAfoqORAqj/H9c?=
 =?us-ascii?Q?ZpWFgqzMpv1APd8R0ZIGKwXwWghfsbpHvp5+0Q4xQg5doJbuvxJxJEkcciWz?=
 =?us-ascii?Q?+RweWt6U7YB4L0XeG9NlHCMhzIAEZh4AlpRxNIRDOm/WBkrZXVZC5uvVyQU8?=
 =?us-ascii?Q?dUDDU2aMOGIPPTbzRrAken5DTqP58hJGifhdWbOQx+Q91j/I9FnDb/55rPdE?=
 =?us-ascii?Q?0VgtzI6g3BIYh6N9OU6fMsaTEmvxki/rQFEmUWLzyxbh8VcG1HFXhUGId98B?=
 =?us-ascii?Q?6fwqWqRedNI6oaI6pisMJG08by7b6cKhSpp5Uxv1gQxVfhTwP9EwF4iPQl7I?=
 =?us-ascii?Q?M8mUcozO0bL+A9mpxptmFrywxiYPQY/dT2kdwmgqFz3gluK+0tra/E1/14Ge?=
 =?us-ascii?Q?lwSmZX9jNHHx0XVKSvI/tsPt4U2LNUEsuoJ3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:30:44.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a96da-1996-4991-9b10-08dd8f2ffe5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

On Thu, May 08, 2025 at 08:02:35PM -0700, Nicolin Chen wrote:
> +int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
> +			phys_addr_t base, size_t length, unsigned long *offset)
> +{
...
> +	int num_pfns, rc;
...
> +	num_pfns = length >> PAGE_SHIFT;

I forgot to clean away this num_pfns, as "length >> PAGE_SHIFT"
stores to immap->num_pfns already.

Will drop this in v5.

Thanks
Nicolin

