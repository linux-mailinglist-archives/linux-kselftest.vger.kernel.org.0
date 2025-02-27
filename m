Return-Path: <linux-kselftest+bounces-27797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF5A48934
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9B16D6DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89C225A31;
	Thu, 27 Feb 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRCE+vsG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADC1B0425;
	Thu, 27 Feb 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685677; cv=fail; b=T1wg7gcrDSvqDBF7Q+KjKn24b4Ayxs6HcxRq4GfcPMMGOAvIYuK6gYTF33UNhs0d6rzwIsI2Kxx+E5OQ/b92DaKtgK3vJWVsCCSO0bla/PPvv9uK+CZSTNKHFtCwx4Dj2gwthP2zlgxE86ZalufLpdsEGehFAgBKGw+xHJA5KG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685677; c=relaxed/simple;
	bh=dipho0LzA//HxmRzXHi/qUPjN+abOcZoLEy/GShd0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sH52itBQFKDq2+laZpOAW+UABSD3K/vXdYdBJcD1NrvL7V4xPv9ewNRB3l3AaOQriYiX+ffwF9Nfqv7a/3pbGPeqr5VtkdDvtDgT/82BKGTlowUWf8ajzckSw1SZlG253nYKWl/n17ITNJJbae3TbplsQuMN7qZPjGHZjSQJyko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRCE+vsG; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpXSGaiv4O7c6MssykxaKS/iBAb8afgN9o5/bJOhPBlZOeMnLI5KDFrdsmA79aQtFlRRhOLqK8xSul624MNNWQkIO9QyqOx6yQPeqIw2ZeX+3Q/WSScmKE5toEOJHctY7QPw8gkFCEpoUlrie1blFYqEm//0w2J6b5zwlV15E7wLT+BV6uF5hGcP7BOMuLuwMhdkE6se5SpzHXLb/uGfnDyR0T9RztKZxMYpPeHFJmj72jDtan36uBxlIF6XvIavUrBC0XpNJSfbOoC7teSskFOEH9wazey7h2rEgqn55mt1EdKas6iMOxFZi757/0tlHPJLbaYLrEy/Dt9IkO1Thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo6Af390/8cgPwykuGWyG5M/Gb/IOo8tRb+gBMc95NA=;
 b=nh+1xwmSvAsaxuVKdP+3Ly8coRpe2GEF4TyAiTCjX1Ksarxx/iJlELRmKZieU3a1SJaxbP0jfiP05mulhTq1Cdvv6M3h/Y0n8bk/nqZwZInzO4ihbXWFlrLicXl1eWn/Pirv/UAq4cEkIXDOMVA2dwyflQIcjoL08IoE+VxN7XH0OlpCNfMeZHIf4JDc43l52WsGKqSL7fKsM3UIlC6ZSmYlbwMtU9Zr/h+1HJtEVlXrgfQvLVG2uVuzRJ7KLTChvHtBoCPFXKVM4uE6rvaVpHhucwYuUApix8Mw9r70KUmYs7DkN5bL4K7n/F/KTiZ5IK18wwkZrEYOy+kXZtnrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo6Af390/8cgPwykuGWyG5M/Gb/IOo8tRb+gBMc95NA=;
 b=HRCE+vsGgg9/QIiwJsRx4olVzU/PrC55bp8OicShzB0zw7iFYzTAZKlnCP0hlq0XbTffaKsVy7Gvj2gjwTJRjrZYByZPo0x/TRUl1vvXIGH48pbKIrkrJP0dif9MgN1PkwP6U7N4c0zPOiOxY1wQuomcDdis0Qjb3XJacqT0nvfdC6AvE36BDvhGaCPdc1KfvArw26C8xEMNUIj1LIBlduYlRaGsAZGGb5+5mb9COqrZTkSfJHa71n5MFLd13GKhRGyOdP9Y0Wi2cxX+iEa45uWcPjr7y31jX7T+lGZwyK5UjNZlWOYbTT7MBOkBaZeiGXMJEGJyXruAwQgoBY5WXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 19:47:50 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:47:50 +0000
Date: Thu, 27 Feb 2025 15:47:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
	tglx@linutronix.de, maz@kernel.org, joro@8bytes.org,
	will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
Message-ID: <20250227194749.GJ39591@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
 <5b9e15e1-8081-46ef-b9db-3872e98a6f35@arm.com>
 <20250221164400.GN50639@nvidia.com>
 <634c60ea-fec3-43ad-923a-cf9ba5e76065@arm.com>
 <20250227153242.GG39591@nvidia.com>
 <Z8ClD4jMtSH31IqA@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ClD4jMtSH31IqA@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:408:f9::6) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 45111ef5-2e12-4b7d-01e6-08dd57679e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a85wE2RuHvnQUAN04NQlvYwU/DwlhUrVVXMW1FYyuOJAJ7mtbCoBLmuVdX2h?=
 =?us-ascii?Q?2WeSN5o4LAACpE/OHAIDXYdp+InVpDtu38ud3M80WDUBMBmO/qmw8wJJz1dY?=
 =?us-ascii?Q?Q043I7cGrdiL7e7ujv2i/PUirjeCWsU7KHv4vw94tgBzYPGUTdQBaJ2NUw4a?=
 =?us-ascii?Q?Tka1vBAm+CY1LEUpqlVTVxcF9h9kEc8YY/6jM9D7RtYQ7oLOml2iIonchhZK?=
 =?us-ascii?Q?zGmHc3Vx64vHzTEfSTZusQaneQzCJ+t40p+/yyk0rRtgLi7WVNBnctEtG8JZ?=
 =?us-ascii?Q?tLqwbQ02KaB9/A8rrVMf+QORkq7qHaN8BOJpIQwvf0qw6UiVO1zHdP9EvJgu?=
 =?us-ascii?Q?k5w31s7OY+upSUIB3iPBK3aR8T+c/TYFB340JiQOdDQ6IrWZu7UERN/O06M+?=
 =?us-ascii?Q?rgjLVMRiJ8VwJP+JrkKv0nglsyv8sak1biHitWzv3L/tzdaHxdanHwtuTyAO?=
 =?us-ascii?Q?ib3CzGoZKU90xdZvxR2ywNJBvG75LqyxaoqpWQaH6ghNg1BSEhtcbhhIZA1c?=
 =?us-ascii?Q?YzXAmo2ZnAfB8knNDpX2WLkkTQ36Gb7CWQeX0zefhMQSuNsNKMinlFUbAQNq?=
 =?us-ascii?Q?DfpiV95Gp2TMHdmjPGRA24ccPDMuXd71M0X4Oq6leCZUsik3W7c3pP23eLH+?=
 =?us-ascii?Q?e0EUMsFcOzdkYpG0/5JOyDDTUYXzw3F8gRJKbvXykG8dcYbK8D02wtZBM0AL?=
 =?us-ascii?Q?VR+f4RSbOxrVKByJ/nQ2fiTCjdymNLi1D4cmisYUjnkBgO1KdSLN5a18G40W?=
 =?us-ascii?Q?ipbqV58YKgLiSJvygDxsmLUJF1g/JPCl0KlmADS6M3koVxYLY2kenCn4gMK9?=
 =?us-ascii?Q?u39zBYASfFlMXJ4SCm0rUWM2A/aNL0aSZ0z+08E3ZMGl84083its1SY6tQWP?=
 =?us-ascii?Q?7XDgbxbXFxj7N5L3EP8dgXJ3du+JPj/8abrvQI9oCe7oa+0V1fTC87r8y7aB?=
 =?us-ascii?Q?cAhoA92QQ8pbezcfbeYuEslAJzTYmBinCBbP8LXlZowAAg7R6p6enSGByiHG?=
 =?us-ascii?Q?GbAZ4NxlBLs6zbdpdXtvcmZjpRcTLviYIOB7NV48pIDCRG9a1uITaHPqFykx?=
 =?us-ascii?Q?8il8jmO+/2uCEOXbRss48BPYtg5GIELNWeQZDptroIMtjXTa50Sz0ikyx1/L?=
 =?us-ascii?Q?YQn3Q9M0IPqJZUGirUKarYqqeXVZMpUL8/mAWYqGCtWS958KvzINs09b1aQ+?=
 =?us-ascii?Q?tEaxwJQWvobqOtA8x1nz7r3e4iqz/uNQ450Kzk1JRLtxbIdT2zfOOQ4V/RSc?=
 =?us-ascii?Q?joqW5iueD7FqbxdlYMO5foWrF1UpkfGm9uzk91HYI/FPsr7Hj7v9zQeknJ29?=
 =?us-ascii?Q?zIYvHZBiGTxd5pKCdm2Mh4PtAE7FTzYoVz7tcg3tgKHJutDlMp7pXLm7q2qg?=
 =?us-ascii?Q?olNgY/r2te/WDuFgKJyvXuf9h4/N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1dd7J73b837xU/XkZamKI/1MDP35YppjJWINsKOIvfXVAs5KMdp5vvBD+X/?=
 =?us-ascii?Q?yG2nOBIej2SCy7G4bdo65ymEeBnZ2e51jG7U7P+DLC8+HR713aDUq4RI6vpQ?=
 =?us-ascii?Q?HFSqOJjf0Tv0GF6WrpmGVzsR6Z5XyX+qw+W37APJFm0dC1oqkaFIK4zQroHP?=
 =?us-ascii?Q?FfhCqvFjao1Jb+505JLyOw/skf6EJOea1q30LTr6dYIyaQUzcY2rCfG2aOx0?=
 =?us-ascii?Q?f4O4VTKgUjxAnOhaIutA4pCb3ch6NjBhGAX4a4ZYx0x+CR1wo2k5KvlK6TQx?=
 =?us-ascii?Q?eBYl0PqgA9D9PLhzVwcQF+Q7vfH1wDWn/VE7IhvCI30C9TVJvZB1xsliJFm/?=
 =?us-ascii?Q?1I+i5N1p8gTT0zHIre8Yrp64NUCB76w6HOVL1+VirsXU5hDnrZTWfDlDCeWf?=
 =?us-ascii?Q?19WyMjd2/g8WBOyg3iYct/zaj6DNLkM2FBYDdoMMDAFyITM/S+S+N8SlGiE3?=
 =?us-ascii?Q?lnN6lDSNR3xIa3j/1pA5Q2Ww4aLXyNLkh7TGW8fr1vZslmlarrdfJSYWmZG3?=
 =?us-ascii?Q?Mk/apxTp6BffRR5XbFWsq/4heVsVNWqgINR1hbTukQ4Z6KCKRxo4EKPRbQHo?=
 =?us-ascii?Q?n7I1qzCHpjjMgFrUVfGsGiWRhA9hBFkv7fb08Ade0liFVPAFfk+cZ948IdiT?=
 =?us-ascii?Q?NjSlQB0fRj9oyDdvfe5vegONlOKxLmgr2rYYzX9QCEpvdwGBI8C7dTJ2gt+K?=
 =?us-ascii?Q?EueUXOv8PXoP+On5tW8M1sXwDBCKVjWPxum5WPWdeUAVoPGc5UC4pivpAYyc?=
 =?us-ascii?Q?oSfx2b7FeHjAxUBWB07zyR5GnJd03hPdTApwmWt+Sh5yJHAr27Mc43Z7eitF?=
 =?us-ascii?Q?gruwC7jrRawGXUAn/+VMjvfBBEydiZkf37ygSnF2XJpbKdKdXHIVVvIVYjYN?=
 =?us-ascii?Q?3tnaOGAcxyimNU+LeBcU9YQJTs6MNR33xvsNUq+ua6kOBG//VyAQfv28Xjmx?=
 =?us-ascii?Q?abvs2HlHjHQ3XNp06zEhSjStz9vnSnMNeC2QxACfXg1pG3KWYvkrkeuuJzZG?=
 =?us-ascii?Q?RndiL4Mfc/jxVgNbhG2KeXC85DaQp/53mLGHQuDQhVCvJSAGnTvg8TXpVBUX?=
 =?us-ascii?Q?JBD4N5KOEYmP27qJujme+JRZCznN1rjd124x8omvQIKzO4ci3wq4u9ub4i29?=
 =?us-ascii?Q?l0LdsdmPftzMdKlPxL2ZkNTfNFJDE1DRz+kC0ojtdLOIXAjX+1vDIzja3zwl?=
 =?us-ascii?Q?B0ntlwv8boqumOnIcHmyyxZQnAlw6EJugJkwCYP2zIdKO+UvPh03va4BBP0l?=
 =?us-ascii?Q?zWfcMEjFWbTegu/o6Flpp/6XOZvEFWKcinAcPkiGH8bfZJ4fcoUwnnEX8yZC?=
 =?us-ascii?Q?M8WKtnVaOs3Jeuc2/mKvj7CY6hIPBJj5L9oqPrlKlYosPDNQ8iuuK5XUabxi?=
 =?us-ascii?Q?io+B1DvwlhsANmTzBMTkvRW6T1CbW92VY+r6NFbOPHaiZ4KCz+cq5+5duYdw?=
 =?us-ascii?Q?AyE/qXMA9Ej9MH+0yUAtFYKnS6IXeOdyxN5CsLKIIvPBbYYrMuWR4VvL5Jyd?=
 =?us-ascii?Q?cvnKNHO1Vx8grS5KYdBpLIkAeeWme/h7uoI+8lG9zECcObB1e35hUggX0XFB?=
 =?us-ascii?Q?MI7/muiyH9ix1T+PWXZfi5RCDzxCuY5NpJbsDywQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45111ef5-2e12-4b7d-01e6-08dd57679e4d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:47:50.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOeon68V/JNMe9grmZc6opSNQhnbcfc/cKeKZ+aOY/CZw/QcSgMdoWCQoQzE0pXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

On Thu, Feb 27, 2025 at 09:46:55AM -0800, Nicolin Chen wrote:
> I found a bit confusing to use "owner" as the domain->owner isn't
> the same thing in this context. Maybe it should be "driver_ops"?

Maybe, but I wouldn't churn it

> Then, "owner" could be another op structure that holds the owner-
> specific things, such as:
> 	enum iommu_domain_owner { DMA/VFIO/IOMMUFD}; // or flag?

I was thinking about breaking type into something like this:

u32 private_data_owner:2 // DMA/IOMMUFD/None
u32 translation_type:3   // paging/identity/sva/platform/blocked/nested
u32 dma_fq:1             // true/false
u32 dma_api_domain:1     // true/false

Which is close to how it already is with just some breaking up of the
bits differently.. Get rid of the word unmanaged and drop the
IOMMU_DOMAIN_* defines.

I also wanted to separate the "policy" enum that determines which of
the three default domains you get from the type. Lots of type
combinations are not allowed as policy.

Jason

