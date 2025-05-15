Return-Path: <linux-kselftest+bounces-33084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C7AB8BD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827CF1BC2E63
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48D21883F;
	Thu, 15 May 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YX1CGs/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31C14F104;
	Thu, 15 May 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325189; cv=fail; b=Zd8xvRG7s/OivQQIEKGGOmNRMYCqMpFzC5sdaIF0YTPfb/8f0VJqmqr+Fn0lPggoDPE+cP9qA7qQhnkVM9tUb8163FBdH2fqou7nSObgEkCLDUXMp2tYyEFZQ/YeXelAVGPZrAAfuhhgbllT4hmnajfEAjzGtSVF5VsugQvqVqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325189; c=relaxed/simple;
	bh=p8V6Snq0cKyGVrkHXCqYtK0V/fGstcPO0QZ6Te1UEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hO+8qcmn9nGqCR+/Oy9YcYQRjgzgA5zcVRLvjYLty5zQ41uUtKWDdXf1KNe3E/iouSs2ymDMt/fHkWiI5q/wAOVAko6lJm4IxHPBawXRgIgyZXHKtxD1U12zHkmZtojAjPHZQT7VzZgprkUz4DmzIW1pLSw2Wx+bcTeX0pa9AtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YX1CGs/O; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw5qhOkriAdc/Vi6oOuvmuRRPfxDG/EZsFO/5nzYTUBWDqr4P47m6I/IL3M3zw6u1/W3plT9toJ1wNLY7DqHufKWRMD0KONTMxNkRj+hZTzhSuw8IsAL64bPOzIFdN+n6cYcEba4Ogy/piQtRwYawsfG6LXZrXdOVyb83zwrV6wXdngItlaHd8eGsNuqfHkIISaGZfhqShUnJKLyCGJNY6TZv2sggrLlF3ftLjfapcHadcjdylhmQjLTGGr9bcWS75QHtpIsYwhRRfcGCNzyG6FmACRPqqr4YZFKi7y545hz0C2BvKzWCLGHtJIj6v10aL6BI7DBYrMwaOpXP0a+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ91qb0g54QhN1jy9gzcQgMJWUdCjbl5aurLZFsTiOQ=;
 b=Xp//i4/zYeTdKLOV+L/6nq2dI99Sf8+BP06XcDKLQsQf8udlDQYKDyte22POFHUbY3Ze0M4zf5NCXO+KjK/+xShzefOHeSzV3gI2dYxRQP/kT8yLYBFyrURO+nw8AtzniNMhtzmPRzO8TbI/OxY/dd/H3yLNzX41Jp6KyzxaG6q9Crkd6RVtESCQCp2gSFa+pnrLz0167hr4WzhRLXh8J0VheD8l9zQUB1mtcaMYOCf90Jh4xxt730ie2dQpXpq9372JEaGze9V40oIkCbA7XwM8M1kBQLWJKJ5HzO6WQ9XPQxyNvEio0eIHVRJbUmLmYNLyKtPEBlwN/1mCi/YdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ91qb0g54QhN1jy9gzcQgMJWUdCjbl5aurLZFsTiOQ=;
 b=YX1CGs/OtwDhZi6uBic3/4zX6uJVR8o7hH9o7GMcI1xY8joigVGg3oxu54OpsGBxyG6xjzzCNTo/cga01JGPcRhZVka4NNHOnx0OjFJMBeU8YGBA0AnEA6bi9NJz18Kl+3XOJZOuUFIoxBHbqSCINcVzPNcewj7D55r0Y9NkLRwZjyZjHXZotJF+RnmgIU8z1oZNniGxKG39D8Ut3GkcPYVXapGdy04F3KE/B/0jgxAxFKGpPAVT3PZ1DmsAz8VDJWLVRtjbdcNcd9hPZR1IItbm1b8pNq+KQmSflaMPOM0+R5dlPE7cjpDx46RzyS3nEPSHV7nAFnJZEQKhawiXFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:06:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 16:06:21 +0000
Date: Thu, 15 May 2025 13:06:20 -0300
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
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250515160620.GJ382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ee7947-1d73-4a0a-4126-08dd93ca6f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJn4WNIozgy1IIHP4cIblkkeQR6utUXpjnCyLREgE7/OYbNh3nzF5gUghh6w?=
 =?us-ascii?Q?5knXqWFYFtLRUBEmjXivYYIEoxShtzdbjPQjFY9jS+DmGCpXfT5wKQRLgqJa?=
 =?us-ascii?Q?IFtxR37HU8GAB810ljrM6FfrBpiFc40i3hvv2/SqRL4iS+TnCOkpqUnI9SOU?=
 =?us-ascii?Q?GZLAr7AmGckWVh2R57jUOxeVHz0IO16sbBSN7Mmd9wSUb1vSrPQ7c/W0aB0v?=
 =?us-ascii?Q?+ffHuttz5z7DdE3CisK5qnprxRerke/I7+SxPiutQoWcdc8KX3dLLn1xKctk?=
 =?us-ascii?Q?D3V85g9WWkjNzjl6xrbXbZ9gNc1dVwoRxWv8nkKlMM6KrzJWmhrletWhyG3x?=
 =?us-ascii?Q?QqBl1k3E43AmVA6OV+5Xb3qnZthGNZd1uv/xrCSN5JoKmty29mUKdjJC4Tvh?=
 =?us-ascii?Q?QEansGsdUVRfUFbBOVDtaCLfMVScJg4qe9Znjp8cAdH/NCtjbWqR90hcEv5o?=
 =?us-ascii?Q?ZA+de9ljXVmZYETHLS+dVV0jv8/8sLtgG/ug2GXtUDI7JdJNuT/ZNoQ/W5jD?=
 =?us-ascii?Q?QJDuey8RyJ2V/9qQkTCINry512Bhy/eu8XWM4UmuS3/y6p23W+ZKSublajIc?=
 =?us-ascii?Q?ceE6lB9ezzgTdqS5/vW71922PLJvQlFYCnYrIwUTfAeAQOH2CtgyclWmxWIT?=
 =?us-ascii?Q?UOhaojSXhVXvZfdlCAOc4aMPhAsIgL/baTzquFD8nVQJ7A9DRwkacFSYLxZP?=
 =?us-ascii?Q?YwfohCjKJ+3m5ODx/xziP/pQlK2zVvpGUxVSNJrjMComL+6OwmhuaVm0Qy1F?=
 =?us-ascii?Q?sXfgXPQaeSyAMhexplDoIZcaSvCqFoyopTuimnl0ME4L+bdFkXaW7O8xagMD?=
 =?us-ascii?Q?NmcvMJYV4oVaN+6lRQO27x0U0ZkYrTX9hU2ZgIF6/Z29S0ss9KEBdEC6RuqK?=
 =?us-ascii?Q?6pEBtAxYpUl237552Hy4jZ7kTy8BrmIAlKdoa9kwuRcEmPvXqvSzAcl+WN+I?=
 =?us-ascii?Q?SEVCf+rBXHPmKl14K5Zia+FHDvhr+D7U0B0XzCJqy2MudkiK/9hK89WY8tCT?=
 =?us-ascii?Q?ZpstVSsT9q5WCEVWHZrA4RfQzcZztIqC6rZvUDx+V3n6wOLgkQDTEEfbKBca?=
 =?us-ascii?Q?dCLCyBwcER4mxA21+yzlZYuH46s6NNexBOxu1Wmhbg2WADq61DqAVQFYlU2E?=
 =?us-ascii?Q?oj2uDwhRQJR0NpmKTzKwZEznOlNGH26kV7d2aXEgAS5h3TsVsnfos1WPkpYm?=
 =?us-ascii?Q?q9J8Uj/VwQ7zz1csNxij0MiUHKnnNQXleuiUVqJc+O2Ixyh7gTkWzo1ZFZkB?=
 =?us-ascii?Q?nCABi4JYtr9pEaSu5KzSbPV3kFCyA6LDpQSAVQ9wtUL1mBJ7KVcU0498spbR?=
 =?us-ascii?Q?R5Yc9GIIXUdAobCwx8NXKOjfkFBd+r6UahQqyHt9KaKZU40eB6f9ZqpUtZA2?=
 =?us-ascii?Q?dLeV6ekznP59Az0TwbkSt+WrtJb45ImnKzk5f7w0EC7GAbfKJOZC7UoFMjnp?=
 =?us-ascii?Q?AHFCFmjFhSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79YRmOnJZpuUrTN/jPKCsPHWAUhmjK/s6N0N8N/Z+q51tHRPAWgYmOw+uL4L?=
 =?us-ascii?Q?cbFfUNhC8zuI98hy/Zm5ZM3FK0cAigm2MvF15u9rUMUWj5TT9qDJSpobYOM/?=
 =?us-ascii?Q?Os5Irxj64ROKQbstYInL5RCF8Xu0E+UVT3W6iRWovR22NYjr+D4ktUmiF66P?=
 =?us-ascii?Q?lJ/oN5a8sYtB5Rt3e499FR/mL62zH0S2uA7fFh7wFEOPawwPQ3vt2BgWFIxL?=
 =?us-ascii?Q?S9t9/KJKRYeCZrrEOy8bkbM7x3OofTnoyP4cQswP57ElPvY6ejUgAqKUpweU?=
 =?us-ascii?Q?04y6lyR7UFSQLJz8qUnCNub2irS+/Q223RQN9Fie/VlQbrOYMuPZUJnyHvn7?=
 =?us-ascii?Q?7vjIySQL/Ez/RcdC6ZdEF4rn6jIk07uFk1LDAeNo2o3JCGTRbFvdxWhbWZi6?=
 =?us-ascii?Q?3SHbcEDO0XPExfBkwjr4+oGQjJGCq4mjlbbDbFUnAH+hcDqCW/dnBLKilMM8?=
 =?us-ascii?Q?fJYt9WYsE99QnOk+eDM4PBaEuE/GtDsrws2uMK7h5tP8NO/yBlzMoHVq23qA?=
 =?us-ascii?Q?kGu2CpuDPMwr44n7/zzqZiEXsF7ySExvyy/pasAd8bDft97V//v3PPqq5oG4?=
 =?us-ascii?Q?in3YYd1C0D+otKptILA8kszUs9TOP5T4V5tNWubH7US5bZlnGmc906DDQnQX?=
 =?us-ascii?Q?mR/ztKfO30CLGEhY0F35/vGw1L12Znr4bGPr0FhIYXPkA5eixojoDF+JiyJO?=
 =?us-ascii?Q?mi51mJQGQUPlOT2EWEbJ4zzzWjyk9D1A5bejjspj4L7Yb7k6jJbib9IbTmKo?=
 =?us-ascii?Q?YPG4loLPCCL9VHmI9M5JZSJkmLdemuz+Tjhut6iipPBaVszizKWC9TsaGy+V?=
 =?us-ascii?Q?f0TW7kkWjGIhSXLylNbU8KuYCKyDG5X0qFevwxJHivDQOEojdHQVkftASkME?=
 =?us-ascii?Q?bEpXn5yn0zgYAK6M6RTYbhZox33iMTM8hPz7eEFD6IeUQQPprIjZC6UhbSff?=
 =?us-ascii?Q?Cd+SvpfQhZKJV7RnD/ejHHvloccrwE9vbOF6/85gDdcON7DDI1ciw6ZLdeiM?=
 =?us-ascii?Q?El+ap/zuQVP2CrZH0Sp3IwU2ITbKJ5B4UGnI8FYTy9mbeHdBKnfDqAd9H6ul?=
 =?us-ascii?Q?LF8ESQ4ThQVn/00eqO+q4GK2m9oMHRNSUIY2NEVgzBiHBTzCpukLgR7L0tF2?=
 =?us-ascii?Q?SKa0Yh4EY2GbGPcjBA/sllmV0RabteRnpotPVPr+JPugxPnoBmqRqSQTE1PE?=
 =?us-ascii?Q?fygddJvRILSbiYkyZaZq6fVklmbOtJpocjDs4182r+sVo9aQrBSi56tGy7Ba?=
 =?us-ascii?Q?BIQhTkGb/3yYgBi1OfDN17zHQ8b4q7WFm96qwiSzCAIQW0T7EqYyCdaMDzpp?=
 =?us-ascii?Q?zlNss5/Mt+YO9ea28LcwzxVPfp801npic39oSq54vxeQ506CSnvcHr9zqeWm?=
 =?us-ascii?Q?VJKwRC84+LNErhzlQEjZ0j6sa7bY5WwsuJKKUfwhJVWvox3/s6DvIFmbqC7X?=
 =?us-ascii?Q?pCW/F+rcKBIdRabDIrGTnoCyfmy3J8r2nxkyHckGnPbElRjOD3nbU1kCCERR?=
 =?us-ascii?Q?bS2lzpD/znLgKCLPM0XLaCGqe5u0W6JUen8e5fwg7p/duwzVKCZkkW/MVAE5?=
 =?us-ascii?Q?yPUjxoBvOD0nHTepGic+IbQn4mbYHVD6lJ5Nvcyc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee7947-1d73-4a0a-4126-08dd93ca6f4b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:06:21.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sRFc/GFtn8r+CuS3ct7W0mzpkXPpciS0gCg2TlPu+Sae5AEM2rhyGTeWxuHoxKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

On Thu, May 08, 2025 at 08:02:32PM -0700, Nicolin Chen wrote:
> +/**
> + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> + * @size: sizeof(struct iommu_hw_queue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> + * @type: One of enum iommu_hw_queue_type
> + * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
> + *         model
> + * @out_hw_queue_id: The ID of the new HW queue
> + * @base_addr: Base address of the queue memory in guest physical address space
> + * @length: Length of the queue memory in the guest physical address space
> + *
> + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
> + * allows HW to access a guest queue memory described by @base_addr and @length.
> + * Upon success, the underlying physical pages of the guest queue memory will be
> + * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
> + * destroyed.

Do we have way to make the pinning optional?

As I understand AMD's system the iommu HW itself translates the
base_addr through the S2 page table automatically, so it doesn't need
pinned memory and physical addresses but just the IOVA.

Perhaps for this reason the pinning should be done with a function
call from the driver?

> +struct iommu_hw_queue_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 type;
> +	__u32 index;
> +	__u32 out_hw_queue_id;
> +	__aligned_u64 base_addr;

base addr should probably be called nesting_parent_iova  to match how
we described the viommu hwpt:

 * @hwpt_id: ID of a nesting parent HWPT to associate to

> +	/*
> +	 * The underlying physical pages must be pinned to prevent them from
> +	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
> +	 * of the HW QUEUE object.
> +	 */
> +	rc = iopt_pin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd->length,
> +			    pages, 0);

I don't think this actually works like this without an unmap
callback. unmap will break:

			iommufd_access_notify_unmap(iopt, area_first, length);
			/* Something is not responding to unmap requests. */
			tries++;
			if (WARN_ON(tries > 100))
				return -EDEADLOCK;

If it can't shoot down the pinning.

Why did this need to change away from just a normal access? That ops
and unmap callback are not optional things.

What vcmdq would do in the unmap callback is question I'm not sure
of..

This is more reason to put the pin/access in the driver so it can
provide an unmap callback that can fix it up. I think this should have
been done just by using the normal access mechanism, maybe with a
simplifying wrapper for in-driver use. ie no need for patch #9

Jason

