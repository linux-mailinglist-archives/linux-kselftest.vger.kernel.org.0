Return-Path: <linux-kselftest+bounces-33810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41821AC434D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328597A6BA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4DA23F405;
	Mon, 26 May 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZbTftMXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357123E346;
	Mon, 26 May 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279396; cv=fail; b=fNwh0hkOmOafcX1ebiqWqr47iqRbtZNTusHTLCnWaUU2/R2LVbw+Kdz9ZXhe7lqmYYF5tW3hYSuD4sXOzQNeoHixbcdUd9vCMt6ZB04JAZJ6lMkr8ViJnqcK+609rjbeZY/r9scK1qdb1Uj6mL6AONLsLjlUqaJOWtmChV+lC2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279396; c=relaxed/simple;
	bh=EjAR5dqrVp5vz+8X8XPlSeGPmvQ8IkqniAvkIySltic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owEm1LfnQBTjvGCn2xRbPMGIYNSnK9ZFxToJ8LH3MnpAV7Pu8HhJZxb6SRSfCv6Tk1NifEVom/qCP8waYdcoTI8QiXH2x1z3/i2yBzoedkEmhUjz2V47ASRVcaF8FKJPthwWNX3Eux3IvKqozqZiH5p5D3uxkKYvgS7jQf1zVww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZbTftMXk; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqiujSL++TOAbwbNukrxH8sJ0T4tholJGCPxPi2RJ+AGboX4slm9mlDbzKXOVVxF3vnP7B3MoHJ3Pf9If//GjW8MtGnh5qr9WWRTOKhXC+o+mjSV42fkRGHra/e/AcSg9z7osNbkCgl2VNpnpqvu6hWaUbuDRoLmbXD+kjqdSaDuJzJbl1eqQ3MMVnwoYFURqSVUG/lsILBgfLVI81iP8jKjdIvNpDFR1z1oAOoMS/GR5Da1yoSxfnEf+bqxhojnGxz/kxi8eg9OGspaPlfoFTBkvUffp7GFQSkA8mutz19imFYArVRqNkxI3h0gAglQrZ0od4GPcK002yiPqk6g9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MmhuZ3Ivdh+cdL3yE4sThAzn+4xTOP0Uha5ZDbA5Ak=;
 b=qZrX5RvqNDtcmD8enF20iSTxvF1s48BwVRd4idp7P0jqYYFEhfLH4Sp2VHRayd1wZle5A8PMPgXuuVto3H/SYlyes7e2ePfCVPA7mMH4TDkx6xsy//jlq1Kn2ZFfjj9v2qQTgjd6EQnFkf9Jq352K1KDkkrgX/oH+tQ1l9/vhPMZdj1Cipji7iUuwm4Mo+mkGpvmDKYb60j38x7OsROx2KwqqJ50KNgFSXFFKcQnumTlkfV9NpmwP5JBzqt4TuSLzwh+02Pjgs6D7bHZ+GRdLBtyBBkF0n/v33cqWfLDlwyOSiBlLx0gT2cRvvsEjvj3tsIV62w5A6FgJmZ6Vg1f9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MmhuZ3Ivdh+cdL3yE4sThAzn+4xTOP0Uha5ZDbA5Ak=;
 b=ZbTftMXkS/aSOVmvBecVhmQAGgs7X/OJLTXNOV+fsnc0b5qawEXDk5jPvP6l0aLq1yxEZF5T4dFtPodZCxlwmBbgt77zZqj7n9NHjAVh6B/TdsTkf2tQmRlgzCvTrSYoZG6dclaZq44TqQ2JVaGyhHaZpuYCo+83Wqnj3FYMxlBJ/AhUA72hgCWN5N1SEHPSY2Cut0ePA0yyKl5BBh8pdNLXX1Z64/dz6GiamuylbAuuHAkaJGxZW6fQQt8unYfMYLk3ICp6fILKmdpNiPpYzQ+/S+kl1yHMojczfYvoSXLyxCsQ/T0MZzp8/WgQF1PmewaTZ1JCaQ168ruOMrgYzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Mon, 26 May
 2025 17:09:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:09:52 +0000
Date: Mon, 26 May 2025 14:09:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>,
	Joel Granados <joel.granados@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250526170951.GD61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
X-ClientProxiedBy: MN2PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:208:e8::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 07994209-aa5c-40ec-c55f-08dd9c782109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5JWkYwMJlY7diqugp1h3WTnKSBEU+Dl+I3AQtwvvqwh3s5GIZzAw6kdsRnPx?=
 =?us-ascii?Q?7dmjUCd9F5aqg72kzrZQPUVKWnkKt58rtDl7ETDH0y1taG+M1GloZjNGXAYD?=
 =?us-ascii?Q?d4apPvdIWJA//YyEgXNhviMaGaMsOl7sO9y+xyIb5pRVIpcc1e5k8+QaBL2P?=
 =?us-ascii?Q?jHCmmBnXHnHmwdI6QmepFAhncKkNhubYTAwSzewwY2xcvqWU9ngnGOlPeYDp?=
 =?us-ascii?Q?ZxU35T7QtCRNlksN/YNNq+c/QcdMItc7MwfH+A6YrXfNCaqv/swRXJ6fORfA?=
 =?us-ascii?Q?AVb7tOkhKVmvx15g/l2y/GeRCLnmQTzgncE6Kk1PJitj3f63R5IPNVJvRUq6?=
 =?us-ascii?Q?ZJ3DltC7n9Ib6Bwxrl+VcxtlKLUJCqjDd9MceULj6yB4Jw6LGYbhsJrKxs18?=
 =?us-ascii?Q?LL/V9HgN7T/Dt4BDFIosHPjg9ChjADIn0P4T6EEaWEIEIJbMviyMbkJruXW8?=
 =?us-ascii?Q?W3gRie2klne3guelHtD8rtpm3cG0JGaqSc3oy3glnitQwsSpKsgmmo0eUja3?=
 =?us-ascii?Q?wSw7fhLxONkYK0YoW75eAiheV/GsiguKBW8+EoYqtrIzM9mVUTXbMDf6eNWu?=
 =?us-ascii?Q?+hQM3dBly96x/opKqmy2k6Llt3kUdIwGwo8IztvPSYuCSQOwGqz+SdbbNyjr?=
 =?us-ascii?Q?BxGMOyqleitjPgg9xY2LRKr9K1/T53UFgClMxFa0g/No2oy8qFBu1Z6p8Ige?=
 =?us-ascii?Q?4UZO3sKtCes7QpZzhaCQkgQEH5zxTd33eGq4jzOLiqTRnXmQFRNWFTYM9p2x?=
 =?us-ascii?Q?2SVfBHDTlpvSjlvYeMY/HncfKGlwuo+7fK+bUEJhN6K2OTVZYfFu/V/LqnP0?=
 =?us-ascii?Q?xtQ9JcsEk3j2vp7mbWnN3iEY1BcLhgY8H0MALOPe9i3VHIYdELEyKMNleZbA?=
 =?us-ascii?Q?IlIiS8d8t0tLto6eL6m47KApWFTuIW1bG90hR5FSmY1Qmuc58wt+ZgAhM7YE?=
 =?us-ascii?Q?gh7p9/mzPaVqoDJ9qCtj7Kuz/gq3Q6FUswm4DeBHu2VOWZv0f2rUnpeMLfnE?=
 =?us-ascii?Q?oBztNi674UUem9yeqhQGIHUBI2DbPOtsjNNrDAy55fikJHykMALtCoul0Zox?=
 =?us-ascii?Q?AdsMViwX/HsTzDtA8OK6r5q+7HPn7Y4eS6higuHxT84GKpkIyFSeXSttsWWh?=
 =?us-ascii?Q?yoZmS/0jMdytHR5YVIby2O1oRSVVmgoxhX8SgwrOsjxEkAxa9wz4hmb2bKTO?=
 =?us-ascii?Q?YN6cj/lOnHsKyTkmYUOVb7FVU4Xnx+SK1gx7sjgO0+qiAwlfjPaAXAV8AssX?=
 =?us-ascii?Q?0Yqtv/NK1zUa04NjD+UaytgGljrodi5zA/RSmlEew4JMmBPAk2ClNUUwr8ll?=
 =?us-ascii?Q?aQKf6INKyVxCCaq5uDyy24lj3abo71H/X7uIi62ZTdMjtYv0kmN1j0QDqDTT?=
 =?us-ascii?Q?eYc+tfHHN87B1dEkwa41uTiJkX1ADfiUlV/bW+f1ImJx837apVwnblw6m2ri?=
 =?us-ascii?Q?LTXIZFqRTd8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?raNk2ja0rx5TJhHQoIZxS2cjHK5QipgxrLoUueZ789Jv0gSFypKbPLF6/y+M?=
 =?us-ascii?Q?bvKIivRfIoLsoAV+T8guIyDXZ1UiuKtP3AaYVAEsgW+4GIuKyw/exsv2bJP4?=
 =?us-ascii?Q?7UbVWJAjIy85kbhG7L4yRyg7Ico33PNh+HEI4P15tSJns9Z8Tn9Sj89kp3zj?=
 =?us-ascii?Q?14cLTWx/EXuIeh0fqw9aWB7edSmpvoH7pbUQUZt1F6JIVePUqxWH37fiuR9P?=
 =?us-ascii?Q?LzFNG86t852TeivJJa3Tf8Lft+zoj8p36TM4UJjg4Bt/bxNJk2bHKQwu4gRT?=
 =?us-ascii?Q?DybJjzpLzOXjLjfjuDSSbd9XKFj8OfTVVf4EoYD7SdhDjlbMkWPmFUjwyLn6?=
 =?us-ascii?Q?0tFYeMkjCezLRY5veCx8us/A+H1qxSUC2l27dmnOWN256i6WnncvwShjCv4/?=
 =?us-ascii?Q?m2KRKdlnaPr4U8W7tgPRaRKa27U1nHtvZxm+dMe5y4Rmb5UnYbIxunCryiV5?=
 =?us-ascii?Q?HGSwHbtO9i/LO1qHDn2tLMwepRwz48m0/a7aajKM5RLcCiqvzHQRr3BsI1PU?=
 =?us-ascii?Q?dhxHKNbF6aD+WXZ0Fs/YkhSHEVW3Uz4m0jjE+eoIOROebk9GCkiGHKi8jtjW?=
 =?us-ascii?Q?FdGCf7MgdpcQ67d38lcPpJVpkwmrk2YT5i0epfr1zTudSxnu5szOKzOaeF0R?=
 =?us-ascii?Q?3fts6Uc3HjVhd6ak1ear5lgQYKEprVCu1j6J/sk0zenoHPKbjRvXoA0a2bn/?=
 =?us-ascii?Q?M3jWLrcq9zbgIifSdkWryUpusU4InhFdHH3o5cXalCaXlpJXMUKXbTAz3NLf?=
 =?us-ascii?Q?mHYmXKf5YWF0+5NLOBSc3NaRzMlvUXwBI6cEiAgh4LCgzz+CyXaiBa6HqCdc?=
 =?us-ascii?Q?o1HFBGVnsACTc0gyQnibnyyBwJcS2SjkyKAFXjCyzpACuM3aRwFKLphCdHhb?=
 =?us-ascii?Q?gpv9p1i2tNKhxZxHMoZebxLv9tFuKsFMC1aGTUPsZlpyJxbwPyYtYbWzV5Qc?=
 =?us-ascii?Q?c1PrH9Ff80Y5cd0rnN6gdX9oG/coUwak90dfS4D59xve5+SYjsNLhcZBL7x4?=
 =?us-ascii?Q?+gIYEpEGwqBFUvrCRiVUEz6S9F9d6Hgy/LLcIg8Lz2srS3mYcoWm2Qg0Ult9?=
 =?us-ascii?Q?bpt8azYOIJnUhaf9FfGjy3OQ/bpc3r8narNTa11yKLPioNN84T97Xn3ze0Y7?=
 =?us-ascii?Q?cYb5li3T2Zfk+Ts1t0IIwDMGoGxngKH3cPX8x3fVVeG9wa8IVw78NWm9a0EB?=
 =?us-ascii?Q?qWUsAtI+SjRc3GTyR1cjJ/A300cOpZgvfGDktEqVhyUUCO0LMZatCashvIle?=
 =?us-ascii?Q?QxamZ7LffpRXQY7dep+VYrSnP6txCDnxrWIm2sdC3duxxqLoc16MkzeAcAQi?=
 =?us-ascii?Q?rkPpfNP+bqzxDgS7eKS/qPSYaN9ae2sj701SoFQixuuwcYwk3v0y8A4WAfGl?=
 =?us-ascii?Q?EnccM96qbaqttZgHksz6XO5GMVsC6K53zAG94sEMzVc9hfuSADPkISILIopn?=
 =?us-ascii?Q?fLp3pL1YR+rGgeO0vKe2zq/aLqnLiu6kUOXxCEuLoU+ZYb6iekPkkZO2AVQZ?=
 =?us-ascii?Q?ftPuR2nVXJkwc0KntE0uMN3yfgtuW0sq96G5Joctegd6qQf87IELw3aBUHIX?=
 =?us-ascii?Q?72DLQx7SiPqPsH1Ev/qWnBk9c5Xd2L032MCtevL0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07994209-aa5c-40ec-c55f-08dd9c782109
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:09:52.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6NxAEd3u2gOX8TgoZDFFpzByXy2biRcM3DQ36iOG2DdDjsI0GGO6xc3vKM8AZhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

On Fri, May 23, 2025 at 11:29:45PM +0000, David Matlack wrote:
> Drivers must implement the following methods:
> 
>  - probe():        Check if the driver supports a given device.
>  - init():         Initialize the driver.
>  - remove():       Deinitialize the driver and reset the device.
>  - memcpy_start(): Kick off a series of repeated memcpys (DMA reads and
>                    DMA writes).
>  - memcpy_wait():  Wait for a memcpy operation to complete.
>  - send_msi():     Make the device send an MSI interrupt.
> 
> memcpy_start/wait() are for generating DMA. We separate the operation
> into 2 steps so that tests can trigger a long-running DMA operation. We
> expect to use this to stress test Live Updates by kicking off a
> long-running mempcy operation and then performing a Live Update. These
> methods are required to not generate any interrupts.

I like this, it is a smart way to go about building a testing
framework.

Joel had sent something that looks related:

https://lore.kernel.org/r/5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgbjufd2@yw6ymwy2a54s

IMHO it would be very nice to lean into what Joel was thinking of a
'libvfn' where the above device stuff is inside a library and it can
be re-used for other purposes.

We keep running into scenarios where it would be really nice to be
able to do DMA testing and we just don't have easy ways to build SW to
do that.

A reusable mini-driver framework that can trigger DMA is a huge leap
forward.

> Library:
> 
>  - Driver support for devices that can be used on AMD, ARM, and other
>    platforms.

I would be very happy to see a mlx5 driver option. mlx5 class HW is
widely available, cheap on ebay, and it would make this usable by
pretty much anyone who wants.

Jason

