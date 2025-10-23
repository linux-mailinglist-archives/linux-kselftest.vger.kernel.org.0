Return-Path: <linux-kselftest+bounces-43934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B549AC02E1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14CC4F19B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37126F47D;
	Thu, 23 Oct 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDaZwmXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225C272813;
	Thu, 23 Oct 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243671; cv=fail; b=RsS9keA53P5zeLeiwRmlVQuFxm614ffTyVbRFkii8E66aLe5Gionvxm/XzP60u/c1SPAxX1GhgjtoT52RlO0AjpXIjtRzhh4Ha51OuNQTMAXEIhoJ1EUSfaR7WPaIc8ykGJQqwymfxj3FAA0R19Mop2eKnXufjKPEMhh3PNFbPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243671; c=relaxed/simple;
	bh=pemEZlX7tnwy8Mfs2M06euQ6+kzI/00YcAnjBi0tvaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jds+vYypHD8lpH0db86ZJjdvHZQqc51ZE8tk/WtF4QXX7zcsoBzvh/aoFNadk1mpoFRXVdKfaFYSLH7bHwMGPZnjRRZ9WE67lJ3R+8azQsDi2i8JvNmAA2ZRtG9KSW5YAOsuXoRbAdG7G/Tr3IUWaqYO/6DhxGMFJBC5USSV6aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDaZwmXW; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywM0+fppqBhfeqYiD9mQv9PHNiKVO6xJo1Fp960NfH6C5FgW8DdTrw/L3owCZfppnEGWe9P6yqMqczQ64SklGxHru4mZGsCVv8DjqmGNoNrjkOT6Mzy3j4SpiPZTHNqEF6DPNt1evqfnvsd9e0CksRWS9N7+Zw5m7n2fHA5TKmLrz/pJvdIF1SvotVtR+XJw2mGV14bUm2ZyKb4Nsj0PnzaN3mUNXjjqgE8aM5TvoSOblCGS0eeJySCi5dAQ/SOcqOpgZlzR160NIWIS1SPZpvI4vl4xe0xRnDPGeYVtIbLZrHLCSACRyIFp/xQZDCbQu/kdr1EwiR7mHuBrjuc/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uccshr91AHqknIVOBJUr2tAbgHgq+clQ7oPGmUah0gM=;
 b=QLu/woCyL+pLtYBe205h0O/HEt1BWRzpS7M/0UmmdletoLIuIbJ2iJiAabncxzgVfJyRMXJJSh8WOa1A4OyP74d1ehSwBhHyF1n13l58QZBXXx2QKQCcKvKbbndsoe6etPiV13iB6CsGmco15I4t7YL+4Q+6dtQRpLMIVOy1XzisdTahviV9TQtZCdVl5hyNBTncAELscGwL4/3akx1k/FViE8bYEB1m4cHNOjnikwynzS/GtkHuTjjkgqBanFw6FCjVagF3HJ5utGWpYpmZRdhDCAvRhuni2XmGW/tpoFx7/LxoCpd7UMjfU8pJOHHoDjlC8Z+yKWXn4k2Bbd3bKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uccshr91AHqknIVOBJUr2tAbgHgq+clQ7oPGmUah0gM=;
 b=rDaZwmXWaNz6QUli6vMpBCisfrawQtZ773sZvBaIKuAO424VgHdOSkFO8bK8KC8ncr15MYPdXraI2reeLOgd1sFMsvrqY1r/xX8lfHK2LX8E6hthbU+NTVpIA9ysgjDQ79S2DGspXwV3ZIMG8B9AGzvAobjUKTqD0zq8CK8dTUYG23TijQdA0q2U2ecVldZy28a3Gg7oqtctqLAUNeEfM8TwN9tEy56ob3WTLPncf84u8PiG+WMD6Dvv1fB0JevNJXVRqV6AK8NHQkYe7YZuM0/m2aEKC7Ny1YlJFBNRBdDNvbfw3Pc5L7ZAvdKCaitsngSjEI6+sRSAziaq3T75bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:20:55 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:20:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v7 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Thu, 23 Oct 2025 15:20:40 -0300
Message-ID: <10-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c378ac-47bc-4324-f8b7-08de1260e668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWGbQFp810RZzIG8QE5Y/6phQpNYDZOKygIXfb782kZVS52BZFCI5hgUOJEP?=
 =?us-ascii?Q?Ymi0gQGCH+c+Ss5dqs84CF9G2qvyttmnvpYwuRqLD9eQhqWhYH+ouQYOWi6t?=
 =?us-ascii?Q?ev8Dz0YPLJ9QmvQBEGJ8O2ZyV0UuYsaxdQPOCybQpG+SV+WRqs2fPxZUBXU9?=
 =?us-ascii?Q?DpNH3qCNdeysWfSiGp2uFvv5uOOl8WK3DET/iycvK2WhuI1RTFgbxbpBKMz+?=
 =?us-ascii?Q?oj/dtpoPuJbssuixpvog1szgfFWcQFIuVXKsY8JFMk+vZj2lEhv+7KvhVxAL?=
 =?us-ascii?Q?B0jlg0uzKATxF9U8w7/isSNVP2thb7QDuNw4DbcaHVhY2PplS2cBYhCVPm54?=
 =?us-ascii?Q?hm4zJi1N8ryYfi+Qt/bQ/+P/R6H+2YPp74eN8JPR5LOnfYWbt6CJHNkGiS38?=
 =?us-ascii?Q?XIHaz+Hu9d1ZXPOvbKakPJg4za5Q4DSa8qXO3HRKkNweHMK4gwqj/XPnryGR?=
 =?us-ascii?Q?0TW46u0zGa1JBS5E1feGz5ItVgH09ZGM/2uPZqMEuRLNBVzOE11DWtFhT4Qo?=
 =?us-ascii?Q?lQYisKtxoTCgS6edSTNHe8KIlejBr/a8Rzu4v05sKFpFmrVqtOmtuuyc6s9Q?=
 =?us-ascii?Q?ZlQ9p26vmRvc1bZK9wt+ZeG+dL1BrSURnUC3W4tONxcSO8MsY8ilcphPzTZY?=
 =?us-ascii?Q?LI1+jKsrpdf/Q9HSGEWWpTts7s2OCrOxzClYiZNcY0mDf5RmfFbq4vKZJKzt?=
 =?us-ascii?Q?MhEXHSb2KDqVjkFn/ThHZbLMEBiEY4oXiVMQDAazgx0LfieRoEpihYKYbGtH?=
 =?us-ascii?Q?0BgA9SB/bskUFRNl0Mt7cvRxDrF6qy8KzSttMDWsjcRkCXnsARYA4B/R5c2J?=
 =?us-ascii?Q?6Og7F/A6NhEkDIcGGWztdtNKAWmQn9EWP92xcZZiPq8bXOhNkFRcBsVTzj8R?=
 =?us-ascii?Q?FzjYvi6rkcRTEk6OO5HNN4qR4C9GFcEDxoAYS3VEaqPpfTWehb85lmkftB7v?=
 =?us-ascii?Q?w0QCoP/GUoPF1Tzdi8niDgAtSn4hFqD8zvq1xBYiWQrmYFNrsBfbHzb+Ysaf?=
 =?us-ascii?Q?LrgND44DJhekjnR/3/mNhxcttW+gcGyPKDfyglgMhXv75xUFIWw9G6Wywv8i?=
 =?us-ascii?Q?df1am9xap5801uWV2KWzPNIJ/fJqW0rL2Bz0y+5EcshhL3tdmtZXecuAChT2?=
 =?us-ascii?Q?jkMEe9GX+rGRCoiZGY2JOoj3qZttg2VNz6SAaMxYVE3ife4kNg200oU2j2Pw?=
 =?us-ascii?Q?V9TrWv5iBthQREHoRWaMVDkbqEDg3iRxWqhB3LVr69e8IdntL2v+7XdTAYBS?=
 =?us-ascii?Q?31X0gr5AIZeFZxiCacPcPpCi1Dnx78rlRNbqmcTNheneD+qVvlIX4Hh63qzY?=
 =?us-ascii?Q?8uvJu9gixV7PdT+gLCBEqJy5hFvjH9HUEXl0DQ2MUhYMHiB96V2Qh9Znh9Ar?=
 =?us-ascii?Q?rcLvwFD60lk1lG7Kvau23f1HtCGhxWmxRWmJFfIu4xksGm15DXf4/GpKBiyH?=
 =?us-ascii?Q?i3Fo4WOqWxmZsg9KkuBvYV9/0njzGkMfbE8Nxr8ntW4hJOqLG8I/PYN/Scjq?=
 =?us-ascii?Q?FyvP1wxRc3iRRGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxpnuC/68gET6uPhaOpdb/eDUqJOtAQ/q60PUqSW8khAmEfbsdKTO/2vvzF/?=
 =?us-ascii?Q?p2vs1cjRNytAQvRmh70KPwFTfYd3To9qSIjj4lNMnHTYbpg+MI7V6BE+SBsS?=
 =?us-ascii?Q?hOgNl4jEldWVURDS0L3Ft/4E61LdA42Lk5TTYCM/eIjjhfpGgLaTFMhD89cw?=
 =?us-ascii?Q?rY4e87tUZ/iD//IaefLZO+EDptEGuwRrPDygZQx6St3L41wgWh/BaYsvRBA1?=
 =?us-ascii?Q?wY+xjFOhZ7A7nlya8J3a+A++OpJnfxEHNtMdbxQ4tTX03R3rSERU3Nb0/wTy?=
 =?us-ascii?Q?wgsNzlqQPD7Ftz5bsjRkjy7YmPGQzJKygs3jFeEg6xYs1x0ozc9OEGrfSeq+?=
 =?us-ascii?Q?pD3PX4fFRPFMXZ+HiAy5EPUgYsNzRcJM28IYnFdiELyKptEYIm8zMnpU39CU?=
 =?us-ascii?Q?KdcbfuY/RBYj9mReRFrhCAAaVzjwLtSVNWIunuF44Iek0W66ZiadTzU2xrvE?=
 =?us-ascii?Q?3GwXJSV11QfGMH1/fRbAmBQqyu8qqdB3/byzafo9oH1sP/ARHk/l7Vq8yner?=
 =?us-ascii?Q?svlmsc4XssHlMJe+fTPn+RFIoigLhqupFVyQGnXhn2KoG0Vtji39wCpkQX1+?=
 =?us-ascii?Q?UaB2azl73zsQfpS3sqM38AHvyFpQeWeI/Uyl8UFTIcMOu69fTflWhWPWzTcb?=
 =?us-ascii?Q?oOARu48r/Qv/0rEVyCzTTfbYn6oQUqD8MS9fIMj6HPokpYFjm1vIpVA7vlzZ?=
 =?us-ascii?Q?OkXI/VWyrPjNgaD+VDZKCv/5kBzyIXTt4RTgAhcYjFB3fVZmxN8tI1v+m3xV?=
 =?us-ascii?Q?yD1qf/HkwJdKxPzS582DxV2TJvMILAhm8Nwqy/nP8RWPhjlS/0sO9g+qLGxq?=
 =?us-ascii?Q?ozGW5MvlLCTJ8ce53Y2SOld8Gh9fsWie/9V9i8LGvc7avtqH02a1c9w9UPCg?=
 =?us-ascii?Q?2m12Qb0RB91b3ys9mMnB+K3ZKj0sZEdi/5f11yI6IT9wOhP44dV2Zh4m4fCE?=
 =?us-ascii?Q?VdY0VLIKOpuo0KmTPcYOjZHJJEKCRTo8KIFdhrSox6+llM7ovheLuAf7SlS4?=
 =?us-ascii?Q?3troni9lsssC9A8SAKlXJsGQOIlG2My/kMjtNsR1PL7+cAe0IBDO2y0s5ubS?=
 =?us-ascii?Q?EHnSkxeTmeFiom7EWwn6QDy+7KaZm20a2tsDpG07rs0Ml6zTuJilgIcN8Ba9?=
 =?us-ascii?Q?PIY7Am2sPAASTpFzL3+Qrhh2I6yCiYZ4Kphs8G/ZCe2ReV/HybhYrKEmQgAc?=
 =?us-ascii?Q?IWH0SChK3XORM5u06NsZxw36JkTcVYzL/WAvUcJt4jrNf78/r6tGVUQtuvJ2?=
 =?us-ascii?Q?wIG7WkiDj2hzzfxl1N2AmKw1QYYajni2b75QUUZR97b4jWO2sOG99wsnKerX?=
 =?us-ascii?Q?bhAvSTv6S7ZCyvwPmIyxChllTnQ2DPFJDFdGhuRg0SQi/fJrPPmTRMZ4ohTq?=
 =?us-ascii?Q?7vijvTjHC8YAttlZ4LyvFqqxodGbrchaUo1J8NrAE2/04IoioG6E+sRFmF4g?=
 =?us-ascii?Q?SfzAI49hYIqBvDZSOzP5FdSv85asi/3aJNhigw3YJ4RRO2NFktg3YSPS/24+?=
 =?us-ascii?Q?6b54gpzf6MvkdTh0KR2hWOwTFwqwLCj3IZXdAMyvqT+nYNt2q09lj+l2+og8?=
 =?us-ascii?Q?9tmw2fxsYzsu0YRSiNWk9tAhCJw9wlO7KvUlx6Sj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c378ac-47bc-4324-f8b7-08de1260e668
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:52.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn9PWRiwP4Ogb73hCdZdg6NuOuOarUzQGL5UWrNVcBvm6855YN4syYKj8YoMoJiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 706a70c8603017..81ced24585ff93 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -378,6 +390,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -388,6 +401,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 03a906fbe12a83..848a5fb76272a9 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -237,6 +237,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


