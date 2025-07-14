Return-Path: <linux-kselftest+bounces-37238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CAB03E3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CE53A9798
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A9248879;
	Mon, 14 Jul 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VvQ2V3LO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3724291A;
	Mon, 14 Jul 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494595; cv=fail; b=o3KOZXSc6ik7oE94B8K9kGA/O4p/jHwTcVTOpxf7FkQ1c0NIyManbMkMbejzgU69hwXVxh6/bUzQs5T4QGLDglmyfezrIUaOnhHrZXCK1vfoV+aIY+bDKa3x7IZqOzhRme8Z+liEcs69b9oU/6xeUinuHrJyA6IbqIoPY2RNgfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494595; c=relaxed/simple;
	bh=CubFzVyM4ezL+gbC2osOdmv/xbE94URim6OlYRpCkGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hCMN3C29I8LZVGVWeTJfcBS6o5tMv9DqVgZ7vcGcfxZGwvyG4mkF0VACzO+sscBzdZsgqvk6PosYg5w7U2c9804sD6V7KIX+GlaMNfrbXkytku9/2p6+qTKyE0bmAgIWfAmzs2K+JjIjJvsd1yED1EE+EvLdc1A4sdQwafXWLSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VvQ2V3LO; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uejUeptLz2uxsPZh58QPxdEJF2S0wbuW0cgia+jbEHKbmmhEC18jIDsuJ6AVOhfVrF/ajpM2J3jA85aGhD6D1cnn1+jDaeqh+qygP+roS23fDrtX+a3snlxHkUYp+EaNuvniSdw5V3OFyuijsVfC9I83pN9dmi/LyfEcxB5EVJxdFP3QVmypb6wfppXV45GmWMgsY+HhFTI7U2lxjUs79z6Gz7dK3bpFDl6SE5ApZKCghvXvE/qAkwqs1HLENMzpyP93J4pd3SZhYYGzwzxx4dfaVyqjan+8814+KMe+6vr1wOfXQqumGaN7WJ+hFXg38tvvcQm9k6DRG0NLh3E29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUhpJOQ0L8l1RlQScd0VmS2sbzIHS3ZRRGMICuaS+uY=;
 b=aTzc3MVua6W+OxT67NIo/etDdxPWHYhhIPJZMnkaneHoUMtWJRhSIUCnT4GQ5vbRDtrRSfXxjG88V7BB3jIwfp1KsEpwjV8J2LJQqxnWQobSR9lKqVuXn0fX2NXo/w1CxoAlKaf3rQLJRqc0SkZjF81wx6nI5SIjFJTz78M6YwzX8PMJAuN+pBHcXCPfmTjLqx0YSkJLdlLzy3vI04OyDMc4Ymq10G8ijhc6AakCDQJfoeA4gRnwkbiFVvoHh79CC8YjKnQ2whOu8mjkJFTFpAAq9xJoK7khC2jVGKOiEopg+1N352c+EIsS5OPRC7/1GhgKE8+vIOeWz7XGEF99qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUhpJOQ0L8l1RlQScd0VmS2sbzIHS3ZRRGMICuaS+uY=;
 b=VvQ2V3LO2U9Q5VkHOpX3a8jEFnP8iXqK0mfxnLLeFa2jXqRgf4UBc4eYDgfpqx/aH9iTSG1e1O+xYDBpfjYz/ZMk3D+WyBPCI2czvA0KjQi7uw24HUua7LCNOje/JSoRTiE53BXan3lA0rVF4UET9rHZeis92kW8eIrzfgGijcG7KRxNEwZQIeAln/HDV1bJcav3Q/SW9+e3VOFmI87W3jxK2ki9T5GlyVu80l/i7FyQxtzY2VTYpJuTwl7Jzk0PSxEHc7Wvv3PBB8xK1M4AyJQBx5G+awgzvrKXVmFj2bjHLewXcNNgdiR7ZtRYMW7ATPD79ktM1TQ6Y7kYRGeBeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:03:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 12:03:09 +0000
Date: Mon, 14 Jul 2025 09:03:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@gmail.com>, vdumpa@nvidia.com,
	Jon Hunter <jonathanh@nvidia.com>, shuah <shuah@kernel.org>,
	jsnitsel@redhat.com, Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Yi Liu <yi.l.liu@intel.com>,
	mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com,
	ALOK TIWARI <alok.a.tiwari@oracle.com>, vasant.hegde@amd.com,
	David Woodhouse <dwmw2@infradead.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 17/29] iommufd: Add mmap interface
Message-ID: <20250714120308.GK1951027@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <9a888a326b12aa5fe940083eae1156304e210fe0.1752126748.git.nicolinc@nvidia.com>
 <db221336-2694-4fcf-a2b2-8fcb46ba3c9e@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db221336-2694-4fcf-a2b2-8fcb46ba3c9e@app.fastmail.com>
X-ClientProxiedBy: MN0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:52d::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: b08226b9-53b3-414f-2cd3-08ddc2ce6663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GADXLJKGnBaBIQIKi6dcYYBry8t7Qil2pHba8VoPU4ukZrNql6xlQ6QW98Zq?=
 =?us-ascii?Q?xrf9Y1pLiL8T33lmRxg7ZI2uOgkWFSZpyKIwsJTs6xaVD9enQEzHQH9iDd4X?=
 =?us-ascii?Q?9GZLS+FKTH6pmDHoKCc1iWF/lbwfV6Ro1kGDQ3qJ/kOCminvN7shUC+MC60q?=
 =?us-ascii?Q?V3vr4eAFXQYAWNhnAUo9QpzzQ0Fpn8cTqX2q9IsJTUxO3c3GvDkH1YK9YqW3?=
 =?us-ascii?Q?2FJg3JMNyRCqcv4pzUecPjKVVQXJnNmpUqaYk6REpWI+SWNREdZKuEKjc+Op?=
 =?us-ascii?Q?+Z8qeJiiUgRxxB4ietynQX3aAt9z5+DDxBKExjPfZhT5xriU7SmnyzEYMTWZ?=
 =?us-ascii?Q?UUGLYG7rs3mN38EneVDZYM/bYvOk9WOUXNRoz4g3gyrSGzUyi1Bd86SlgEs2?=
 =?us-ascii?Q?eRJpbHwlek1o41Cj5LEmyY3wq2xHjjnu4AqSdgRhLn5RxXfijC5hwUpyem6c?=
 =?us-ascii?Q?ZQqZd5ZJjsctCJ2je3pfN/E11+/VNXT5/s51SqRRXhGXmOUYobqBkp0fVLnH?=
 =?us-ascii?Q?k4KianGAZWjrzzR0x2d0Ma9JTc5NXW0qieUmB6oApnJEy+t2Bfmwr4EvXAwb?=
 =?us-ascii?Q?+W05W/7YxYmTm2IgsCSAGW/AeEwq0/0Ku591dy34rHL8+oXhAvMbjY0v/2T1?=
 =?us-ascii?Q?YM6G0yJDmKyU4g/i9LNyW93FaDE5XFVH2E6gZ33S2yW9K4PBarjUDffHbQY7?=
 =?us-ascii?Q?52HuNQ1akPjWmp4BLYEkkmRLsvzAf+aIBYZhNexXIwT+uWn0O6gvr3EiPCQw?=
 =?us-ascii?Q?ltFt9UbXeOlTZ/QoT0LnNOXuBM84wbczT2Ljwahu9nbZkedJd4mKjRtvflq1?=
 =?us-ascii?Q?ZPx7P3eiQ3nBEowFQcYsvVyKH3sbJsuCGQPaxoQzn84rVpfcT66Okp8fLG11?=
 =?us-ascii?Q?km3U5ymBT7Xn9vWSPIF/NtSUrvgRzhGfFPkjxAOGcIXbctw+xQ188ixMLED4?=
 =?us-ascii?Q?n8v+DVAXVYVTwi83m3Vx6MohlzfIE0gxt1CeuE/0S7BFRaUs3Lbf712mMZBa?=
 =?us-ascii?Q?W5s38bGMWRmqBXYVazMB65OSFdSLZ7mFW/xGowVABjuueP1NKTZ/FJLC5JWF?=
 =?us-ascii?Q?BI6g/uyZROVTWF10AHPdraKpYCLh2pcuW334LokMyRWNOVRat0t8Jav4eiaL?=
 =?us-ascii?Q?RDEsc9GGGNpIRZ5IsTp9mPLy7DzoNMcr0iRwWLVuRQcuesWRak6NCNvLVpoo?=
 =?us-ascii?Q?mM4O3Ce7ShjKMlWHaEvgZanQhRhw0C1Gm6HLNVTCYmKmKfhPWnxhSccKyZlB?=
 =?us-ascii?Q?01+g2GVF6w8guLOGWglMnqiv/3V17Xc2TTyjSfRG9ZBOVU6Jjz39IPOWccIO?=
 =?us-ascii?Q?WsHg7oFTg38Iq7A1UsmO1ThRSOakV28rvT59ukpNi0EPb09weecnMu/XJseL?=
 =?us-ascii?Q?FLh96zxjwXaWruDqB0G8UBirz9L5RGzNgVPrMaVrySWJSxrXaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W4g+6YVBBzZ7nddEh6LRZ7D19xDtu8aKz3PkdeISuI6bZaI4pG2UBCVT2hvY?=
 =?us-ascii?Q?mXdSO6BbvlrYPJ7oES2tMvTsRHA2M68wIDft+vItwVsq50nUsfGn4nmCiR7Q?=
 =?us-ascii?Q?5PHFmEn/EdQcS1y2rF/oFzZshroAiw0UeDryuQGza8Xsop06Bf7kuqi667LJ?=
 =?us-ascii?Q?aa47+JW7FeMWzpMNGbpZawB166R642y7Jz0gQ57/U2uCJ0HO7uyD3NBnzo7Z?=
 =?us-ascii?Q?HoG3fOs0fr+atJi4bq68BIwC04H7T3UWVPxOB3Lqnn4dCsm1NZB1Md0lW3ef?=
 =?us-ascii?Q?ojiERCfgHVzzYDY+6+v5qD87eV7WSKp1l7mXwJkE26UL6zknVgP/YboMc+SU?=
 =?us-ascii?Q?iCxZXPiGLSAzGCs4KsXf0lg2KnLGZBAlvLzQgx5M6BSfi2DmvuCdIz+WP0hf?=
 =?us-ascii?Q?D1XXvVVNRWP06FHviovwzbfWexGtVg8XpYfwPmp0c8of6WYwWUfunw6ctiPC?=
 =?us-ascii?Q?++3UWpxLC89Nu8/weVO5RACM84+vlB8EcNJ6wd7K56xox5BAsJaJvCsk6xOy?=
 =?us-ascii?Q?Yyuarltl+DmqwSYmrjDNeZV9b9fFZIjM57fYwmMTXOjRLykQhrRiTpF3uSpp?=
 =?us-ascii?Q?ysUb+ZMUUaeehy7LO23hXO+dV6d/gQGynNS/wPZ6mWkYBiLgBdF02aIg4FzK?=
 =?us-ascii?Q?Y8sxwb+TwE8UmX9BAnKft3x8IkcFiAfpyFOCry9YQCSC6IPXWKg9QyH9bfbJ?=
 =?us-ascii?Q?1goTIwKkg498AwbjQ5fwInGbgpqABboj+3b93/Upgisd3o4RR4q3zq8S1/RN?=
 =?us-ascii?Q?aMRZZm0Q8BlMm0R5UYt9FP5KC4ITMvEeQ0/j1qR7ayEEXPFvtR5EzSD+k35R?=
 =?us-ascii?Q?dJEOWGdUxGH4DMGev5R7z7bi7MNZdCcIxhhNMr0aGanBp3CygNKIwwT8RVaH?=
 =?us-ascii?Q?FDCug+plTpV5cq5hJq/YzsocAqcgrX4q4BNRDbRE7ndwbOONyxaUB4EJVGr6?=
 =?us-ascii?Q?Ywh8i9CXErEBS5S/USoqvvRNvlewMw/lkrPlka9oqPZcEAEFKqE4h5QT5CH+?=
 =?us-ascii?Q?l8tNYN3sKQqlz1HcfOsRt1uBuOp9SEA61PNtkRxjI8wD8oSS2yiRy+YB3zzT?=
 =?us-ascii?Q?azcm0DwZzWITN+HAZTEx/hNfEJAMkBsIF982IrLx0y/EYnj7yRGZEs5gm+Kc?=
 =?us-ascii?Q?vFhpiHhxwxAv59v1aHY+K01H+5C1bCGFe1HXCNWBYfkprACiox61newSMp4I?=
 =?us-ascii?Q?8OhLsazPE1SnArYGHky1MfZAe+VheYcMV8GOqpUnY/blfZaTZIAMS3DoV+hE?=
 =?us-ascii?Q?yOsnyy0Rau4PmVMbCPcWUdlX/6N/7qAAvmlSCniar2PiJmb5tzHD7ASflQJh?=
 =?us-ascii?Q?8pTPnzwHqMVgp1d8VxSseiJZ3jTM3mCoKxmLvTYmhdfhImajeJXaF9tVnTwu?=
 =?us-ascii?Q?4EHsSTAgLDlHK5YgkIBIJPjfOQUSmbqAWyterVVy5Y6a/T4DKQwqLvyCvliq?=
 =?us-ascii?Q?04scDSSVbkeaNJhVXWKrxXVmWdyrlSDxlQLEk0m0JJKXRDR9Jau/jm9RhLck?=
 =?us-ascii?Q?OjX15Zs9/L6PceGm0tj8++acky4rJAP57khL+fNBHPymBKJNWuWUZzGtzZ/i?=
 =?us-ascii?Q?Ebm1C6XwCR8oJWqe570=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08226b9-53b3-414f-2cd3-08ddc2ce6663
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:03:09.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJiu+8HlHZpVtr7QGpUMcQ8HWnilJoEEQfWrU3wubbGdDKfOUDv+93J+UDBL1DCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

On Mon, Jul 14, 2025 at 08:08:21AM +0200, Arnd Bergmann wrote:
 
> The mtree_alloc_range() interface explicitly operates on 'unsigned long'
> address values, so I don't see an immediate workaround for this that would
> make it work on these machines. On the other hand, 

I fixed this already, PHYS_ADDR_MAX was just wrong, it should be
ULONG_MAX. The thing wasn't a physaddr in the first place.

Jason

