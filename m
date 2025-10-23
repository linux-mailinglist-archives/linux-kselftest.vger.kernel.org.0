Return-Path: <linux-kselftest+bounces-43942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA413C02E54
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3582D3B13F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4934678F;
	Thu, 23 Oct 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9Sv/sLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D5273D6D;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243678; cv=fail; b=vGgb/GRfgLTx/SWWxfdwV5sjkrtYFRDYfvyPoE0bXg4Kc1T1+MlKnRqOXBg5xIUGTWiLsX4pE95DryQoxpGz/huI5ReKwTmYQ+nAtFs0caEUDIyJF1d5zufQ4kd5fbIJnwEMPLjCIQR0q9j2Gtb7o98R2GomV8BvjY+e0n5twhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243678; c=relaxed/simple;
	bh=IB8T8narzU5w8pIVqmhezT5Tv9fhnha+Ux734CV6f/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQHmrmdVVY65wJIbdttvUU6eyR+5AIXrRfS52LXH9RVfQnAUCRA0WKoKZBEvdxaRb0wNJ07RSmpHF12s2j0vC3qzRzV2BEsVTBDJLh8s9hs01XIGyRDtZ4Kxw+zDiBmZRvHLmPjHIZxzgD9iBqJZRSHK69fswnDUJni+SrrBvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9Sv/sLy; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNEF1DT4MB8SspQBTsDt7f9O0Do7d75ZaguWJomjOd2aKLcO2MgS7uMTeKXV1JEG3HI+YXTEZKVbwamRk84cENLD1Jb+twb4r7vTMdeEgBpE+L6PXozH91ZWYB9p5/CQlL8z81qtAyNdV3fFMNScl59p399L1HUhqqsftPvp0NjU33XSkAiFk3YLZiHPB2acwxfm+c/r3BZ7dRyO4TuAk3P0SoQdNBVFnfa93likwPvBPNH1WZdVLRNLpzzAo19wwxmtmMkJQQjy0qAGdZWISObhpeLi0fz7SvqFmF1oDzp1CBjR4Os0n86CNSn58ug5yjKqcDKlsLFchfqRquoVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO5AEKpLVHiczL89Bx7WXoyBVaQaFaaFBKBpyEYnUag=;
 b=Dyhj1ycvDW7XHRbx6jYR+imdBMyIfxCTFQ3NaS6f5LI7v08s6X0OxGegU/dY5/i9i7vcS3CiLnujMYBPethDp66crqcn00Fit7F2quKMUn/O9om0Dh0G9DtK8icPug4QQ/XWlGwxU/+3TGdf0pvumCq6Mm/ANW27YsGOYxhWniuud+lpbzOXjc57EAkwOXj8nN6wXadzVME1pY2Bsee/waCmGiV8I1UaEy3gCN3TlKibSrZw6k3OI87wGlWwfgTdIxdc8MFkRFzi2RUiE2u9LnJRN3anMNLFr0lnlYPXHuHiOSI5qIXiiaVJYZjnAcuhKkt3wxoXtOn0zz/J7yzClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO5AEKpLVHiczL89Bx7WXoyBVaQaFaaFBKBpyEYnUag=;
 b=f9Sv/sLy5os0ByiH8bR1iUAjKhuFNemXvgCU2Gr83koMDLY4CZoL6w7RyHY6eLAynGuvHaOPAcyiWrygkGlUC9fuYFYEP3ovOu4hmLmnvQPR4fpIRCOyihBSxyL1DmxmMU5/wJw4hhh2F5HPDK4CoI7DMww7QYAqj2xEicjJFT1fkm/gRdmz775ztKjeFArtYc96N0IkvC68gRVJSIRgXqJ78AS6XfGOBkymwGgVUFIFYasPZphmqczOg6SGoatoN4spxZC8Q4DVuxNgb+dRyZPPTm2JqUx0hfZ8F3IiWWtmqCHPPDC1UacNZeI77u7/F565s+3k3+O+76UCJK3VDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:21:02 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:02 +0000
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
Subject: [PATCH v7 07/15] iommupt: Add map_pages op
Date: Thu, 23 Oct 2025 15:20:37 -0300
Message-ID: <7-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: d41c2f56-4be2-4388-9c65-08de1260e6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afSfmpUjbRTITlD3KW6VeeS5N8e5QhUrjDePaL7sw4uiiwHgl4+jJEdtFVXK?=
 =?us-ascii?Q?Oj4ouRGxZ4hWr/Gy5vdNX0juZmELcVLSoTuh4sRseYoZo/Bu2hIJhDcHxyCr?=
 =?us-ascii?Q?/H+WLscrd/13ch84BawBefWLMKONi/htOpvsVOqbA1t6Wq0pqbufAJKsKuiO?=
 =?us-ascii?Q?9VVbJ27iv7kZmmI4ykiKmSxYlQxvyzuZibu0Snxr558OFfCdvIH4sbqlQuPG?=
 =?us-ascii?Q?ZxFb/fxwiyB/gaLuK20rPyAbTKuCt8mFE075cuKim2l5coAwFZXgqKbhdnSg?=
 =?us-ascii?Q?ScBDoXZsjpWMBUu8bF1U15a7M1viElCu1wpQhRK6abkI3gtzZPqY+v5st/3K?=
 =?us-ascii?Q?sIEGgpErf9hvR4SwGHS3X8KAHDJYWhRLn4TyfN9vjQKHFW4KbG065dAjAdNj?=
 =?us-ascii?Q?DcMXhcjzm5CiLNF2WRfMyR2EIJkM8pKj0ZtGY1NdDGVPu0SMrxkYmpri9KL+?=
 =?us-ascii?Q?FobIWwQLWiOs78A+lTGcF4uAqgfneUvSmWGvkBPtil5882jKp3botsMba+U0?=
 =?us-ascii?Q?yTMJMzv927SALFO7q+SMzoFzXEHJxq1eo9VbFfZT74E960cxFbiAWu6afR03?=
 =?us-ascii?Q?EFFI6w1zdM3iQrf3NRkfh+ZyvSsIPDKwQGUU6ez0nStpI/KslbgGFfU7AsRx?=
 =?us-ascii?Q?n17YVv0kUNSgdOpchcAIKwgbY5fkedj4PcbLV9tFFPCA4JmRf+1lYxdz42l1?=
 =?us-ascii?Q?hrCRZ1Lt2x3JahcRtsFmyujcJL+muLuz6kYSgZ0puHbnsLTO24TNk4B8MvIp?=
 =?us-ascii?Q?NtnraJ6ei49tGzw7BccHdLXWD2fA/WPKMNKWIWo19BxFuUOiSA2TtbBnCSXx?=
 =?us-ascii?Q?CKoWREcipDNvx5utgH0gvrKnKNdMGfB/lNCE9je+tGFSDFB5o3FyLZs9LbOn?=
 =?us-ascii?Q?If2kA4t6cAqZuBzC0qijiSWnshBuikTeLzjsfYtufQGO4ZgbSEXmHSThqtH2?=
 =?us-ascii?Q?AswLU6YZnOJSpkRgiKwJM+ydFfL/xYMHfan3T9g50aGXp/L3odpjLSJRUl3n?=
 =?us-ascii?Q?Yn/y3AY6fHaAmFJbVwlmhWBx5wIHFoxMc/GOMkOjbrhdECnUO0E44jTI7H5v?=
 =?us-ascii?Q?IG4mdOMuRDqBu8DuPnhib9lvkaxt/VUmZSmvPfmJr3FxuBiKqMAOZcp3ioDU?=
 =?us-ascii?Q?zuE0xj54BqtXpxb/pqzQ2uGusjykS/OxzdzEcRNHs2d/R5NnaKCDCLkSNsri?=
 =?us-ascii?Q?8aEvKtGDv6PEKCxiVs6Z6t1bN00JcE0I6uXQb7ME1Upl+RXUkgY9rV2eoXCt?=
 =?us-ascii?Q?Prv6Ynq0PMQi6wSL3bYuZGJplq0Dfaw9BM4UQNa5y1g+TGU3z3dW+Y7KqGJ0?=
 =?us-ascii?Q?XLkcTCtlhTK1f8DpYUSHtfWKuYtTKb6eewXuFE15r5/l8s1wNb588qjgr31P?=
 =?us-ascii?Q?0OHXoreygHX2tKW9JGttt4kVOZ6/BnBrBtYzBOOnGunEAKXQNjMb9onEIfjT?=
 =?us-ascii?Q?Z9J0IqPNGo232NIqd7tBWya3dvOXVHlVGc38UZbjuUFW/cguzdBLvaMUVsHF?=
 =?us-ascii?Q?oTEuAWlthnopZUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZE1faZYKPnB9uN6qngfYZXFAeCJFDhn6eZeFQfEOSdwHDNZvPrV6TCTxnlhe?=
 =?us-ascii?Q?nr5ZEYkUuVIdx1vR5Gl+0OTlLy3DExVcnykK7VtMloCJL/5MXair1huu5NYD?=
 =?us-ascii?Q?33oou/+gjlEtMCdyrcFwblzwpoFHy+NLv1YVaI1CQaaLW5o4enMJv2IPbygX?=
 =?us-ascii?Q?7WZ0QYe77OTqkv7D4SLx18QvoQVyB2VDfrveTH8RiEDW4CH+bZS5g04TZ0jM?=
 =?us-ascii?Q?wtT/tDjyEvHuM2ZsRv5i4Y4UolDt2K+kgyWMldAiGkN/Brp2CVBbW2sJb5iE?=
 =?us-ascii?Q?OSsyi/ASd/NNKUTAOml3bLRuBaaBQ5qySkpJ3mthj4Ac0PURez92P92XduBl?=
 =?us-ascii?Q?Aaj1hiEaxYLaqN6eNRXawO9S+vyMavKFEeK4OoJjlV2LwPLCTsXS4bFIPsmq?=
 =?us-ascii?Q?5TOCYE3iMpf3Hw+GdHqVQ1ZCScA8Bnwia+2mSrxrKZ9ZjWcMtMmdU67H05uF?=
 =?us-ascii?Q?0jeQWrJb04Pfev3smbMd7cdjJ3KKg3FkTIivHjazxsbekMV1KxByPNctmHa1?=
 =?us-ascii?Q?w8/Jijp6p7fwd7eKbcNGLbYihYiFrm+sHPgMx/5I9a9ICHH27XCh2OgHHhbE?=
 =?us-ascii?Q?WVOd+JmxKmy8+QEgdxuBP/uXw6JDmnwS/sgWYnGVE01dPIP1KD4TzhhY2fwp?=
 =?us-ascii?Q?8a2Xl5AMXNGEptLw127MzuWb+C2Po8eF1uSjgJ+1yhlQqOxna16ILgf6KqyS?=
 =?us-ascii?Q?QFskkJIr9QfsgsEuZ2ZI98po9Xr3UC50SeUYwzEejNZASl9h0OwY2JIQpvGo?=
 =?us-ascii?Q?zYXyt/ntpjtfTpHLDFuvK6J/BcIFTid6RvqUru4i/s7KmpfYmt10j2F0PJOo?=
 =?us-ascii?Q?5XK/yBjwEYUU8PDTzpeAokdOYCn/101GflqBRLE2UyVn0W93fZbF2OXU9X1t?=
 =?us-ascii?Q?nYylNMwLKADyfahbKQYoR+DJe398RZeU9GCkzBFTgX0un7/LTRMXkQlU+os0?=
 =?us-ascii?Q?3GGk2JbqlFZxfvp1OMqHYZPnYZW+YU9w0zS/dcfhlZkZBJ1qeCSKHgBd9LU8?=
 =?us-ascii?Q?5/gAN5ImK1pVByYR3FSmE/nXzMAprg/PbE9i/gabTtvgw6TgmdekUFqqdAm2?=
 =?us-ascii?Q?5YUIoJ3uvK9WAtn0/qB7a2w+AcTvlCt6uV6VxRcXRZW/MsvyNKqiKzmdoX6G?=
 =?us-ascii?Q?NpBF5a9ESf6GrA53ZAPUoABeV5he66qJuWj2u/sP2a6UoL6hpNepm6QDIXSc?=
 =?us-ascii?Q?eUrl9ML9ImicG9MgirB0kM5A9iHyXyaZ8jBDAp4LokXsJFh+vy2LlFpHjFiV?=
 =?us-ascii?Q?9q+cUTFWpeZNUSzEWYD/2xAry6ah8q7FSriUFdEhoyEjqV+jKgbvFDV6lT6F?=
 =?us-ascii?Q?XiGA2Bsgat7PzjdSxbB5kVzu+Voe5qZIze76h9OsKqcTz6gzsbMO+DPxwFBR?=
 =?us-ascii?Q?kR1jhDn8u2xMbp1yDRrGwrHE8IRWCn7uR1Srh8ChRH/3Dy9DEIzOTFASoKQX?=
 =?us-ascii?Q?RqjnpWnMU+5cY1sb/7NP8EdtqTPRMCwROLJ7D5Qhvv0ncTniG3i/guoCviRR?=
 =?us-ascii?Q?K6st1K4yjjuqAaOCmy49I+PS0Xu/YcGpijcY64Jatin6BRAClaB4FDZYcJZx?=
 =?us-ascii?Q?7btAozGHOeEvi8wwAqQyXNdpO4kFphUuRZxdY6dG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c2f56-4be2-4388-9c65-08de1260e6e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:53.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn2SwoilkT9TbclNyXoI9vkyAl6rTFcoZnTaypTS2uajuG5h0rNf2VUlh6hwKbus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared, but now empty, table level with an OA.
   Requries validating and freeing the possibly empty tables
 - Doing the above across an entire to-be-created contiguous entry
 - Installing a new shared table level concurrently with another thread
 - Expanding the table by adding more top levels

Table expansion is a unique feature of AMDv1, this version is quite
similar except we handle racing concurrent lockless map. The table top
pointer and starting level are encoded in a single uintptr_t which ensures
we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
that fixed point as its starting point. Concurrent expansion is handled
with a table global spinlock.

When inserting a new table entry map checks that the entire portion of the
table is empty. This includes freeing any empty lower tables that will be
overwritten by an OA. A separate free list is used while checking and
collecting all the empty lower tables so that writing the new entry is
uninterrupted, either the new entry fully writes or nothing changes.

A special fast path for PAGE_SIZE is implemented that does a direct walk
to the leaf level and installs a single entry. This gives ~15% improvement
for iommu_map() when mapping lists of single pages.

This version sits under the iommu_domain_ops as map_pages() but does not
require the external page size calculation. The implementation is actually
map_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize iommu_map() to take advantage of this.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 501 +++++++++++++++++++++++++++-
 drivers/iommu/generic_pt/pt_iter.h  |   2 +-
 include/linux/generic_pt/iommu.h    |  59 ++++
 3 files changed, 560 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index e3d1b272723db0..f32e81509f4f09 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
 		ret;                                                     \
 	})
 
+static inline unsigned int compute_best_pgsize(struct pt_state *pts,
+					       pt_oaddr_t oa)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * The page size is limited by the domain's bitmap. This allows the core
+	 * code to reduce the supported page sizes by changing the bitmap.
+	 */
+	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
+					      iommu_table->domain.pgsize_bitmap,
+				      pts->range->va, pts->range->last_va, oa);
+}
+
 static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 					     unsigned int level,
 					     struct pt_table_p *table,
@@ -147,6 +164,8 @@ EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
+	/* Fail if any OAs are within the range */
+	u8 check_mapped : 1;
 };
 
 static int __collect_tables(struct pt_range *range, void *arg,
@@ -156,7 +175,7 @@ static int __collect_tables(struct pt_range *range, void *arg,
 	struct pt_iommu_collect_args *collect = arg;
 	int ret;
 
-	if (!pt_can_have_table(&pts))
+	if (!collect->check_mapped && !pt_can_have_table(&pts))
 		return 0;
 
 	for_each_pt_level_entry(&pts) {
@@ -167,6 +186,8 @@ static int __collect_tables(struct pt_range *range, void *arg,
 				return ret;
 			continue;
 		}
+		if (pts.type == PT_ENTRY_OA && collect->check_mapped)
+			return -EADDRINUSE;
 	}
 	return 0;
 }
@@ -187,6 +208,477 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+/* Allocate an interior table */
+static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
+					     gfp_t gfp)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(parent_pts->range->common);
+	struct pt_state child_pts =
+		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
+
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_num_items_lg2(&child_pts) +
+			    ilog2(PT_ITEM_WORD_SIZE)));
+}
+
+static inline int pt_iommu_new_table(struct pt_state *pts,
+				     struct pt_write_attrs *attrs)
+{
+	struct pt_table_p *table_mem;
+	phys_addr_t phys;
+
+	/* Given PA/VA/length can't be represented */
+	if (PT_WARN_ON(!pt_can_have_table(pts)))
+		return -ENXIO;
+
+	table_mem = table_alloc(pts, attrs->gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+
+	phys = virt_to_phys(table_mem);
+	if (!pt_install_table(pts, phys, attrs)) {
+		iommu_free_pages(table_mem);
+		return -EAGAIN;
+	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+		/*
+		 * The underlying table can't store the physical table address.
+		 * This happens when kunit testing tables outside their normal
+		 * environment where a CPU might be limited.
+		 */
+		pt_load_single_entry(pts);
+		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
+			pt_clear_entries(pts, ilog2(1));
+			iommu_free_pages(table_mem);
+			return -EINVAL;
+		}
+	}
+
+	pts->table_lower = table_mem;
+	return 0;
+}
+
+struct pt_iommu_map_args {
+	struct iommu_iotlb_gather *iotlb_gather;
+	struct pt_write_attrs attrs;
+	pt_oaddr_t oa;
+	unsigned int leaf_pgsize_lg2;
+	unsigned int leaf_level;
+};
+
+/*
+ * This will recursively check any tables in the block to validate they are
+ * empty and then free them through the gather.
+ */
+static int clear_contig(const struct pt_state *start_pts,
+			struct iommu_iotlb_gather *iotlb_gather,
+			unsigned int step, unsigned int pgsize_lg2)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(start_pts->range->common);
+	struct pt_range range = *start_pts->range;
+	struct pt_state pts =
+		pt_init(&range, start_pts->level, start_pts->table);
+	struct pt_iommu_collect_args collect = { .check_mapped = true };
+	int ret;
+
+	pts.index = start_pts->index;
+	pts.end_index = start_pts->index + step;
+	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			collect.free_list =
+				IOMMU_PAGES_LIST_INIT(collect.free_list);
+			ret = pt_walk_descend_all(&pts, __collect_tables,
+						  &collect);
+			if (ret)
+				return ret;
+
+			/*
+			 * The table item must be cleared before we can update
+			 * the gather
+			 */
+			pt_clear_entries(&pts, ilog2(1));
+
+			iommu_pages_list_add(&collect.free_list,
+					     pt_table_ptr(&pts));
+			gather_range_pages(
+				iotlb_gather, iommu_table, range.va,
+				log2_to_int(pt_table_item_lg2sz(&pts)),
+				&collect.free_list);
+		} else if (pts.type != PT_ENTRY_EMPTY) {
+			return -EADDRINUSE;
+		}
+	}
+	return 0;
+}
+
+static int __map_range_leaf(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
+	unsigned int start_index;
+	pt_oaddr_t oa = map->oa;
+	unsigned int step;
+	bool need_contig;
+	int ret = 0;
+
+	PT_WARN_ON(map->leaf_level != level);
+	PT_WARN_ON(!pt_can_have_leaf(&pts));
+
+	step = log2_to_int_t(unsigned int,
+			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
+	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			ret = clear_contig(&pts, map->iotlb_gather, step,
+					   leaf_pgsize_lg2);
+			if (ret)
+				break;
+		}
+
+		if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+			pt_index_to_va(&pts);
+			PT_WARN_ON(compute_best_pgsize(&pts, oa) !=
+				   leaf_pgsize_lg2);
+		}
+		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
+
+		oa += log2_to_int(leaf_pgsize_lg2);
+		pts.index += step;
+	} while (pts.index < pts.end_index);
+
+	map->oa = oa;
+	return ret;
+}
+
+static int __map_range(struct pt_range *range, void *arg, unsigned int level,
+		       struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	int ret;
+
+	PT_WARN_ON(map->leaf_level == level);
+	PT_WARN_ON(!pt_can_have_table(&pts));
+
+	_pt_iter_first(&pts);
+
+	/* Descend to a child table */
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+
+		if (pts.type != PT_ENTRY_TABLE) {
+			if (pts.type != PT_ENTRY_EMPTY)
+				return -EADDRINUSE;
+			ret = pt_iommu_new_table(&pts, &map->attrs);
+			if (ret) {
+				/*
+				 * Racing with another thread installing a table
+				 */
+				if (ret == -EAGAIN)
+					continue;
+				return ret;
+			}
+		} else {
+			pts.table_lower = pt_table_ptr(&pts);
+		}
+
+		/*
+		 * The already present table can possibly be shared with another
+		 * concurrent map.
+		 */
+		if (map->leaf_level == level - 1)
+			ret = pt_descend(&pts, arg, __map_range_leaf);
+		else
+			ret = pt_descend(&pts, arg, __map_range);
+		if (ret)
+			return ret;
+
+		pts.index++;
+		pt_index_to_va(&pts);
+		if (pts.index >= pts.end_index)
+			break;
+	} while (true);
+	return 0;
+}
+
+/*
+ * Fast path for the easy case of mapping a 4k page to an already allocated
+ * table. This is a common workload. If it returns EAGAIN run the full algorithm
+ * instead.
+ */
+static __always_inline int __do_map_single_page(struct pt_range *range,
+						void *arg, unsigned int level,
+						struct pt_table_p *table,
+						pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+
+	pts.type = pt_load_single_entry(&pts);
+	if (level == 0) {
+		if (pts.type != PT_ENTRY_EMPTY)
+			return -EADDRINUSE;
+		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
+				      &map->attrs);
+		map->oa += PAGE_SIZE;
+		return 0;
+	}
+	if (pts.type == PT_ENTRY_TABLE)
+		return pt_descend(&pts, arg, descend_fn);
+	/* Something else, use the slow path */
+	return -EAGAIN;
+}
+PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
+
+/*
+ * Add a table to the top, increasing the top level as much as necessary to
+ * encompass range.
+ */
+static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
+			struct pt_iommu_map_args *map)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
+	uintptr_t new_top_of_table = top_of_table;
+	struct pt_table_p *table_mem;
+	unsigned int new_level;
+	spinlock_t *domain_lock;
+	unsigned long flags;
+	int ret;
+
+	while (true) {
+		struct pt_range top_range =
+			_pt_top_range(common, new_top_of_table);
+		struct pt_state pts = pt_init_top(&top_range);
+
+		top_range.va = range->va;
+		top_range.last_va = range->last_va;
+
+		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
+			break;
+
+		pts.level++;
+		if (pts.level > PT_MAX_TOP_LEVEL ||
+		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
+			ret = -ERANGE;
+			goto err_free;
+		}
+
+		new_level = pts.level;
+		table_mem = table_alloc_top(
+			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
+		if (IS_ERR(table_mem))
+			return PTR_ERR(table_mem);
+		iommu_pages_list_add(&free_list, table_mem);
+
+		/* The new table links to the lower table always at index 0 */
+		top_range.va = 0;
+		top_range.top_level = new_level;
+		pts.table_lower = pts.table;
+		pts.table = table_mem;
+		pt_load_single_entry(&pts);
+		PT_WARN_ON(pts.index != 0);
+		pt_install_table(&pts, virt_to_phys(pts.table_lower),
+				 &map->attrs);
+		new_top_of_table = _pt_top_set(pts.table, pts.level);
+	}
+
+	/*
+	 * top_of_table is write locked by the spinlock, but readers can use
+	 * READ_ONCE() to get the value. Since we encode both the level and the
+	 * pointer in one quanta the lockless reader will always see something
+	 * valid. The HW must be updated to the new level under the spinlock
+	 * before top_of_table is updated so that concurrent readers don't map
+	 * into the new level until it is fully functional. If another thread
+	 * already updated it while we were working then throw everything away
+	 * and try again.
+	 */
+	domain_lock = iommu_table->driver_ops->get_top_lock(iommu_table);
+	spin_lock_irqsave(domain_lock, flags);
+	if (common->top_of_table != top_of_table) {
+		spin_unlock_irqrestore(domain_lock, flags);
+		ret = -EAGAIN;
+		goto err_free;
+	}
+
+	/*
+	 * We do not issue any flushes for change_top on the expectation that
+	 * any walk cache will not become a problem by adding another layer to
+	 * the tree. Misses will rewalk from the updated top pointer, hits
+	 * continue to be correct. Negative caching is fine too since all the
+	 * new IOVA added by the new top is non-present.
+	 */
+	iommu_table->driver_ops->change_top(
+		iommu_table, virt_to_phys(table_mem), new_level);
+	WRITE_ONCE(common->top_of_table, new_top_of_table);
+	spin_unlock_irqrestore(domain_lock, flags);
+	return 0;
+
+err_free:
+	iommu_put_pages_list(&free_list);
+	return ret;
+}
+
+static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
+			   struct pt_iommu_map_args *map)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	int ret;
+
+	do {
+		ret = pt_check_range(range);
+		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+			return ret;
+
+		if (!ret && map->leaf_level <= range->top_level)
+			break;
+
+		ret = increase_top(iommu_table, range, map);
+		if (ret && ret != -EAGAIN)
+			return ret;
+
+		/* Reload the new top */
+		*range = pt_make_range(common, range->va, range->last_va);
+	} while (ret);
+	PT_WARN_ON(pt_check_range(range));
+	return 0;
+}
+
+static int do_map(struct pt_range *range, bool single_page,
+		  struct pt_iommu_map_args *map)
+{
+	if (single_page) {
+		int ret;
+
+		ret = pt_walk_range(range, __map_single_page, map);
+		if (ret != -EAGAIN)
+			return ret;
+		/* EAGAIN falls through to the full path */
+	}
+
+	if (map->leaf_level == range->top_level)
+		return pt_walk_range(range, __map_range_leaf, map);
+	return pt_walk_range(range, __map_range, map);
+}
+
+/**
+ * map_pages() - Install translation for an IOVA range
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @mapped: Total bytes successfully mapped
+ *
+ * The range starting at IOVA will have paddr installed into it. The caller
+ * must specify a valid pgsize and pgcount to segment the range into compatible
+ * blocks.
+ *
+ * On error the caller will probably want to invoke unmap on the range from iova
+ * up to the amount indicated by @mapped to return the table back to an
+ * unchanged state.
+ *
+ * Context: The caller must hold a write range lock that includes the whole
+ * range.
+ *
+ * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
+ * mapped are added to @mapped, @mapped is not zerod first.
+ */
+int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct iommu_iotlb_gather iotlb_gather;
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_iommu_map_args map = {
+		.iotlb_gather = &iotlb_gather,
+		.oa = paddr,
+		.leaf_pgsize_lg2 = vaffs(pgsize),
+	};
+	bool single_page = false;
+	struct pt_range range;
+	int ret;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+
+	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
+		return -EINVAL;
+
+	/* Check the paddr doesn't exceed what the table can store */
+	if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
+	     (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
+	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
+	     oalog2_div(paddr, common->max_oasz_lg2)))
+		return -ERANGE;
+
+	ret = pt_iommu_set_prot(common, &map.attrs, prot);
+	if (ret)
+		return ret;
+	map.attrs.gfp = gfp;
+
+	ret = make_range_no_check(common, &range, iova, len);
+	if (ret)
+		return ret;
+
+	/* Calculate target page size and level for the leaves */
+	if (pt_has_system_page_size(common) && pgsize == PAGE_SIZE &&
+	    pgcount == 1) {
+		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+		if (log2_mod(iova | paddr, PAGE_SHIFT))
+			return -ENXIO;
+		map.leaf_pgsize_lg2 = PAGE_SHIFT;
+		map.leaf_level = 0;
+		single_page = true;
+	} else {
+		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
+			pgsize_bitmap, range.va, range.last_va, paddr);
+		if (!map.leaf_pgsize_lg2)
+			return -ENXIO;
+		map.leaf_level =
+			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
+	}
+
+	ret = check_map_range(iommu_table, &range, &map);
+	if (ret)
+		return ret;
+
+	PT_WARN_ON(map.leaf_level > range.top_level);
+
+	ret = do_map(&range, single_page, &map);
+
+	/*
+	 * Table levels were freed and replaced with large items, flush any walk
+	 * cache that may refer to the freed levels.
+	 */
+	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
+		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
+
+	/* Bytes successfully mapped */
+	PT_WARN_ON(!ret && map.oa - paddr != len);
+	*mapped += map.oa - paddr;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -445,6 +937,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->driver_ops = cfg.driver_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -478,6 +971,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 	if (ret)
 		return ret;
 
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    WARN_ON(!iommu_table->driver_ops ||
+		    !iommu_table->driver_ops->change_top ||
+		    !iommu_table->driver_ops->get_top_lock))
+		return -EINVAL;
+
 	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
 	    (pt_feature(common, PT_FEAT_FULL_VA) ||
 	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
index 87f4a26c1a417a..c0d8617cce2928 100644
--- a/drivers/iommu/generic_pt/pt_iter.h
+++ b/drivers/iommu/generic_pt/pt_iter.h
@@ -612,7 +612,7 @@ static inline int __pt_make_level_fn_err(struct pt_range *range, void *arg,
  * This builds a function call tree that can be fully inlined.
  * The caller must provide a function body in an __always_inline function::
  *
- *  static __always_inline int do(struct pt_range *range, void *arg,
+ *  static __always_inline int do_fn(struct pt_range *range, void *arg,
  *         unsigned int level, struct pt_table_p *table,
  *         pt_level_fn_t descend_fn)
  *
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index ceb6bc9cea37cd..0d59423024d57f 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -11,6 +11,7 @@
 
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
+struct pt_iommu_driver_ops;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -43,6 +44,12 @@ struct pt_iommu {
 	 */
 	const struct pt_iommu_ops *ops;
 
+	/**
+	 * @driver_ops: Function pointers provided by the HW driver to help
+	 * manage HW details like caches.
+	 */
+	const struct pt_iommu_driver_ops *driver_ops;
+
 	/**
 	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,53 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_driver_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain derived structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_driver_ops {
+	/**
+	 * @change_top: Update the top of table pointer
+	 * @iommu_table: Table to operate on
+	 * @top_paddr: New CPU physical address of the top pointer
+	 * @top_level: IOMMU PT level of the new top
+	 *
+	 * Called under the get_top_lock() spinlock. The driver must update all
+	 * HW references to this domain with a new top address and
+	 * configuration. On return mappings placed in the new top must be
+	 * reachable by the HW.
+	 *
+	 * top_level encodes the level in IOMMU PT format, level 0 is the
+	 * smallest page size increasing from there. This has to be translated
+	 * to any HW specific format. During this call the new top will not be
+	 * visible to any other API.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
+			   unsigned int top_level);
+
+	/**
+	 * @get_top_lock: lock to hold when changing the table top
+	 * @iommu_table: Table to operate on
+	 *
+	 * Return a lock to hold when changing the table top page table from
+	 * being stored in HW. The lock will be held prior to calling
+	 * change_top() and released once the top is fully visible.
+	 *
+	 * Typically this would be a lock that protects the iommu_domain's
+	 * attachment list.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
+};
+
 static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
 {
 	/*
@@ -120,6 +174,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
+				       unsigned long iova, phys_addr_t paddr,  \
+				       size_t pgsize, size_t pgcount,          \
+				       int prot, gfp_t gfp, size_t *mapped);   \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -142,6 +200,7 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
-- 
2.43.0


