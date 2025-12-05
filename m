Return-Path: <linux-kselftest+bounces-47209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00ACA9291
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27743305D3A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E6329C48;
	Fri,  5 Dec 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NNfAB/da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C128325494;
	Fri,  5 Dec 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963995; cv=fail; b=rkimANnQbDvCvfnOiJim0xxJl5SM53ScN8lm2qDPP2urecmr9PTVF1iu7Idcjm5a91xuLi5rgf2pjCgdZU9mUpb5gflHWWkobaUY9S4uNP3j8jmTmw3lmU/wCkyPwQNcQEbD0A8s1MYEpOOWEep8l3VYKnAdatptXhIpXFleL4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963995; c=relaxed/simple;
	bh=o4B3D2WvYuh/r/u5yYX/bqoBEITP7vPTjspB6Nq58RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUns7Cmfa2X+HgmpHOIvyUMnegF51j+mgIpqPJ1crPCIPMIlsjo6vn/gSu5wBRO61y8BH6mYtFpbR3uieCTbRjxZ5Twi6MsdIiDovc48oNNy8b5/oxV8Bk7tORj1J6ObeWjmgYwQLG1OXlGVhV0ZSBP+KL7ZNzFyWwXaAsVjKp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NNfAB/da; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPKrFE9uxZNUF9XffVoJUkzYit262B5y9ypWDzampYa5DSyzz1Cij/vd88q2t6DcivYL6Xjxixp2oTGjn9cx5dh7GkBI3xUTAR8+vTPwcgq1ZV3vvtvf50g8IhLuFxkho/CFTflPU5I4ZgPK20MrXalXAY1sxXN4VWagp4+w+6LzEntUpcsrriAGfQA+yLWcJOC44kX6AZVZciDyK3eUMBILO9NkWrqd+VngcT925icpjec647lWsmtGuGDcKT5dy0XiKq+eDMJo5pqk/+EQc7CY3Ilaeq2+nLrtBXXl9L/HWEp54gybHF4i/ZjhgFrRn4BzeH16H1btDHj9rWQ1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fR1oB6PQPaVuw2PREXNtVVjDcozg6+Wpt5oG1lfe0o=;
 b=AGEBzMZjVOQZ5PJ0//ZCLg7t5af2wyQ+jFcu2fHIhfJjV//9KgjFUpWRCQNOXV9ZC7gTkgU2qZeHhwqo6YYmjfsE1l7ZEroK0eYORcwBWTji7+sq6EAzzPFq92Ox4aSQx6N3z3d5MNz5eYkOjLSVa3fhkjoUfTBeoe6BR57RiKwzudty4UTGEUkW5yCYYcu5c3Km/PnwATUh3lnaLrdPq3YSLbaQcvXEJ0JINwjPIgE9SymKAR63VTUxVuXR6qHxD5Re+yhlyEJHuAqUfjWiXOXUUvHUS2AuH2UFF43Ad4C24g0zxVPGZpRDlIrOCaz1imZQP2iyBtZyBLhJdqOvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fR1oB6PQPaVuw2PREXNtVVjDcozg6+Wpt5oG1lfe0o=;
 b=NNfAB/daOFfRO9gQSM4xdCpzrtLoHjpnhHvdppcbxdpcGwpULv+WRGuj0MxsBznHOBEb6/6A/75vLBptxLDAJADLWSgtGdK/9Zbx9WC469J2Nh0DpDXn0sqFdMJ2OL3D1VJgIFyOM/oZttJT2qgA23X+kIK/VLjNvhW755eipW3ydDt1rB/yo3VlnWOkxd+nW/M0TI9MQWOOVJ8a9f8YvpZ48xihC0ZDZUueQAqAXrX341JufoniaIxHwk1VbKBGHjXJpipXsKA6baP5hAPGokhHAPWuKjXLdUA94+1NUWV/DSzp7mlXg5fiNtnKePSDf7Awz9wry1hvFrh8MfAMbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 19:46:31 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 19:46:31 +0000
Date: Fri, 5 Dec 2025 15:46:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v8 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <20251205194630.GC1219718@nvidia.com>
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <aTJGMaqwQK0ASj0G@ly-workstation>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTJGMaqwQK0ASj0G@ly-workstation>
X-ClientProxiedBy: BN9PR03CA0597.namprd03.prod.outlook.com
 (2603:10b6:408:10d::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: f6475958-d1b5-441a-46af-08de3436fd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EV3h4WDarpi2qgk9+SW8Mbugk3VbZY2Ps+fLso3tTl6MM821w9Jk6LeJ1djw?=
 =?us-ascii?Q?Lhjvr28zy7wFDSbN+DoWoOQKVasgf9PrrCRYsCEFmK5g//9UQaCYXm2R4+aE?=
 =?us-ascii?Q?cBwkjxcWmEltmJ862zbmNtZcFk4vNgLzY7pS5EJ9t5Aw12Pv79+eG9Kd7SSe?=
 =?us-ascii?Q?WbC+d/iIQRn/x33TYj4N9Do0v62j5//a13vTL2whK7pVQJ5VF3gOjEsJtaxf?=
 =?us-ascii?Q?7r7GBYnDrm1Zu7laK9SkXYx3Cufwh5lkKIy5GZckmcQqnVH8NB2fsvVc0S1r?=
 =?us-ascii?Q?zilHkVbSpYtbFoBeUSsCWyyhKV//Efe9JCkmkgvi3852abyus1wkG2Yn//Ya?=
 =?us-ascii?Q?cFrqcGy/QslVLbTNSySgsVUh4mdGhgaI545AHVhL0eNln4gsnldFZCX/satB?=
 =?us-ascii?Q?IQ0ATYKiQ5LtQOv3w3EKZNZLKfydmDFfTpA7bWP3oUIv5qdefMFDpSWB9whS?=
 =?us-ascii?Q?+6qA1NleIdEs2ryVCEDp0BO+cUXk9Uh957p5e7gZJLXHDDRVW4wco92BvYdj?=
 =?us-ascii?Q?COQckILuSIyKJn3J4kZUmhJ3OrFCUYOzajMpk/FfWAldP12OxYHsBRgNHWdg?=
 =?us-ascii?Q?bBV+Ksdt8Hz/N8dq0pKvIVh5luNTE5hh0DDXTXkXhs5alOwtNNsbiAcuPwzb?=
 =?us-ascii?Q?xHIhTqMd4PGvqiWTFm6uEJ27SkIbopkQyYy8qXI8P+X00AgJ3tRcZAayBaID?=
 =?us-ascii?Q?rD5KHcTggaNSNTJOCksMqcA6xJFLCWP5RYXrwwjb/DoEj+Cwy6iX2G0NUYDE?=
 =?us-ascii?Q?uG2CTyhYI2luEr3T6yeLs2GmocUXwBj/r7k+r8EFoayxMpsHs+WDo7+GLxsM?=
 =?us-ascii?Q?3/SG6mR1ASbfNTB8wyPtt3aibBqW58HECLCIs9YMH9UouWUQyT70I6rjQARI?=
 =?us-ascii?Q?az4M/q/EYOVeZ1FqvPut47j/NYRUdoeKg209/B8wU9vo/EjFI2Qb/sOg9Kbq?=
 =?us-ascii?Q?Iz72yPz3BVD4eYH/z80D3SYxb+g+fHLEBfU5VupeCk2emQ70337eqLjbz73Z?=
 =?us-ascii?Q?o5/L9HvIcboQDpLXlDrTSwWMR8JzSPulqkDm4CghkDn8v6MDWw+d9z6jXjN5?=
 =?us-ascii?Q?r2zToTFOZZ25xKP7kpc+w7bSXt/hBiJXrvulvjGdAbFwECPdLwCpCikiJVPI?=
 =?us-ascii?Q?nnuqML7iOy0+7Rylp2Sdr/VUPUPjxtDL26Clw3PpDGOkotGRY4YPQ/LywqaA?=
 =?us-ascii?Q?+ec1X7KU8teOtVn/Inhtz4odx1KeT8D0BXTFqLwnDNhHMXUlw9epkcWKX5kv?=
 =?us-ascii?Q?OVEmYs3U7F5HepTlvQoGSzbUwq/Qyzxa+EWW2mLMvk2kmS5/BSqs3TNDj6nk?=
 =?us-ascii?Q?F5SRqgYy8hLThy22yFui1CDF2Z15UfvHB4dpjKDMd88UHPnKlY2mqoOymcsi?=
 =?us-ascii?Q?cWgpb4CsV1bdQ0/mFYZmWT5UoX0DOFd8eioAR6MYslrRCw2XDZO5tqGpkgdY?=
 =?us-ascii?Q?h1ZX3gFekIi+dGdfJqrv4bEMZI0QnURm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AD92K9YLrFaRuSyQFxXGanMAXjVBuGFVzUqPbwT566xXH85fxOYv2Igk1mp0?=
 =?us-ascii?Q?okwga5t5igjgU3Zc8HZUA5nGkkLCIdA1NdzeEm28JMOHSC9oVhjkdEiBwSDa?=
 =?us-ascii?Q?noAenUdv4nf4Iq8UwZs50NnAG0izcvtWk4RHfztEUBp4fZl1rFPztzCIZZcQ?=
 =?us-ascii?Q?+v4j1yNO9sLO6eX2o3OtzEWVYULLW3/LJu6hn27kcTCQjaj4vETkSPDMhYo3?=
 =?us-ascii?Q?kpdsxGgZVIOhEkHKOsnHxEQ+75eXct2axTqQPyAcPXi4TtlNiDQw3EPSQosO?=
 =?us-ascii?Q?TA9+zYOUXbNVHK9fd3m7MP0/jf55E4tu5mvVNn+I1ukZgC4Z9SPCPQ471S3f?=
 =?us-ascii?Q?24HFVs9Zcj21TmAHRTkJ7XpWSX1O4xo/SCvahlxvhlZJqK/Szz4SDgzlD3nn?=
 =?us-ascii?Q?g9w8dZt07McLIRgyKxbEjauvTTZTjvvUSOnmwZUPtydADZcaysFfSjYRB/fl?=
 =?us-ascii?Q?qb80edoJd3AQVrOzor8Ucc2O2xIpLrPBWvQzdd0CEyrI6UibLf1tp8QkMgHa?=
 =?us-ascii?Q?mDfmwGtgq/pGGmLl+lkaC8eWej4RkNN3/VU7VUYnO+ydF4QKdXUXrbI8aDWD?=
 =?us-ascii?Q?k4L8JzMLxm0NZxbuElNKJBvuU0TqRJEMD8k8GMom9uDj0yKYY68T8qh1z6a7?=
 =?us-ascii?Q?/x45e0N1jSRwjn6J9PVA9Cc4p7kqH2OoG15XRXAj75d8bBnjvLns5Wyi9o5j?=
 =?us-ascii?Q?fJPJVoWtAgyLgfi1bM1S29aqB4mm3upHkAKTJuydL+kTxw5OjQ2tFBb3UbiP?=
 =?us-ascii?Q?LS78tgxE5pAw8tQw9ShYfTw2dDbEgcO+dNfN4QGp2BGVouZ/G8IoEtBir5KH?=
 =?us-ascii?Q?tOP3lJWlPjrihhGoU6eD+aMqRawZxN2CxnkGeJhOFXC+zy2DfBSmp8W/Iud9?=
 =?us-ascii?Q?1LhM7VJXLt0ukjBTDLo6kO52jI3pmNYLvr+wpNBv4vwMk4/rhZI8myIj2YKa?=
 =?us-ascii?Q?CkTTS2Q4GEPmEXwEVGDBUoPZonTtNewNhFHZSci9R1ThSzDNq96KTwSDX3xq?=
 =?us-ascii?Q?ZUJWAwg38EWWAKFqYY6v9YWTeL5FQ1QtSHsdYh7lM2A3mWWcEIqXO9GwtFlF?=
 =?us-ascii?Q?0QYKyXBxqYgROugseaRsnqfI47m1tm4XWsQTYhplWLueKiS0CaepRqR4mO0c?=
 =?us-ascii?Q?tbPNw6hzV5U/kMfW9jc4eUaUjQjU34rzYB5hCZlU0xpqu7YKTXOu8K1YxeAt?=
 =?us-ascii?Q?rPl4rgm5LvBJF2QxQDi5+Cwr+PHi5aOY5jXqttMeyN25tqnD8eElpkjY+Cfi?=
 =?us-ascii?Q?m3Xm0MmiwjJAnrgyKfuZUvdIRZIReXh+zPzIBXrBMPaHsGSO4SVzpNHypxda?=
 =?us-ascii?Q?FmNgqjyJNhpXxO8ZVkjLzd3pNO0zoYrp79jPh8xWggDQZx/i3fd8yaiLKtOc?=
 =?us-ascii?Q?iVImmlvzefWZRJWdh8lqpt/tBvBW6v+U4wFhqjDplrVPqvAgIvAvR1janZmi?=
 =?us-ascii?Q?m7jfLQAk/d+/5+4o1NAbjeINTKQub7TVkCr1pjWxN5aJgcq/08LmUo435/1B?=
 =?us-ascii?Q?vUvas1MidCc3NuDp3qin5YQo6HT+BePtCPPVQOe1Wk12mBUHhPMsWoDFXjhj?=
 =?us-ascii?Q?kwoz5hTbnafOjp83wqU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6475958-d1b5-441a-46af-08de3436fd24
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:46:31.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIzWYyAYWJCzn7GM6nUODef5IomQz4gPyoS66eVtLuvld+9UBcDd/+7XZeNtWi4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

On Fri, Dec 05, 2025 at 10:40:49AM +0800, Lai, Yi wrote:
> Hi Alejandro Jimenez,
> 
> Greetings!
> 
> I used Syzkaller and found that there is WARNING in iommufd_fops_release in linux-next next-20251203.
> 
> After bisection and the first bad commit is:
> "
> 789a5913b29c iommu/amd: Use the generic iommu page table
> "

This bisect didn't work out, it is close, but the commit is

e93d5945ed5b ("iommufd: Change the selftest to use iommupt instead of xarray")

It is a refcount leak:

@@ -1215,8 +1215,10 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
        page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
        if (iova % page_size || length % page_size ||
            (uintptr_t)uptr % page_size ||
-           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
-               return -EINVAL;
+           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end)) {
+               rc = -EINVAL;
+               goto out_put;
+       }

I'll send a patch, thanks

Jason

