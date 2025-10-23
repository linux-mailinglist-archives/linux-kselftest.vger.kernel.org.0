Return-Path: <linux-kselftest+bounces-43928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65EC02DFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1E23AEFEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5C26738C;
	Thu, 23 Oct 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udsd9N4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A22376FC;
	Thu, 23 Oct 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243656; cv=fail; b=G/0ZoOrO4MwG497hMKjMfrAEs1SzZZqAjO84XqPOaNsmgnCm7VvJtJB151vrB+YPSFIGlXPJdfnCy3D4gR60gM8CQn0hvZVmp8Jlcz6LsXqHeSdWj4k4SaFLzml5pv12NoxNcIdtvyT5q5d3LXqgetnzuhCi+TMqpAqAkoPabwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243656; c=relaxed/simple;
	bh=4aLgSaRpgFf95KPiXVJSyeWdGkMPI7SeG8M3GIgRo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+suChQtN7z8SiSKCUc6PZ6vPF3VyU3YSqsasdCKnEHUwJaJpgkOT1Ll28znXhCUI/h2zl06iAth2UySwXjlOmej6IcYdD4CNJ7xxdknZqXmN8uudiECwEg3nFOGKhBigZm4fOAC5NepN0Eaj7/XRF2dzyRb8WdtM/1abIksG1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udsd9N4M; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzPGwDSZk+y/aeKekSUfPOUQbpN6stah7fCMj9X2eJkfdwwe58CZRxX0O7lN4TF2HUPpxIhbGJfh5ybkYDNA2T40gzZSqBWLSVcMs6Z9TZrmj68OtZL7ubOdzehSdjGcuyEGYYNfRQvb/T5/ITRBhjPNMwfDJZCkWY6exLXUXeZzZ9rfBlsT/eUN1CJJ6W2ghncxpK1Wbo6ssxniFhUihd3F8nyIXwDT/gs4fDFfvsXxt5t9yOIbjgT5C4ajWAnpqS+R6uzeUYOVr0TXCul5u07NcF/7PAhJBEnancLR61uZy9G8jbdg9q9l6Qx40loVurwBIi95DBqZ7fsKi9Yd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ifrfoQL5AbwMqMdRwJwMdA1nr7miRmXJHuqu5G0uA=;
 b=jZjCludiwfffMGNQF6zGSIsxON/4bvbAT9X3+OcnpFEDt5cZH/tmHdOvJvxiD8LBqY0LWcPz0H2SqygH5Rvxpr65xbVezwL5YtyZTU4IPVoqbZdd8BFCz4YIRZJTOAucn2zIVpkpGMiTFxswEpeP8UVXBJQMReUtC4yDC/N7VYHUCu1CaXnbHHEWmVMLp4H8hGIytlJraX8HpTc+uAyaumDb4fzUiRy+rVWrAO67zST9VDBDWlJE51rvwxwNMUhnPU5FtvqgTv8jRxz8OjVn7hbU3SVU0nwMbZnrHZKzxtvNRAzk0xU2eLaURpxD9qLJETrHkMNDO0WIMP8pN0enWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ifrfoQL5AbwMqMdRwJwMdA1nr7miRmXJHuqu5G0uA=;
 b=udsd9N4M9j3UVWPgfPOQu4XJV7aS8z6q+fwGE7tklZOrbF2JAdTEyJNBUKlyq+rbYbS7SmR8RQN3dXjaVhVGTje/9SiLgoo/NuD64WBaVOd9NOUPyZiQWmOZOSFPuRaKtC85xuTBUNmxkUbsX0SFzazX8un+usPX98jJ3niObbaZ5ZVFVCUXJFDBZ8N+uogG3YH7rYG/GJ+FG9FMATiRQcfUWQph6p3X2MFsvuA0gAY61b4KxoOYKc+YVBGuABWprSoFB0kUIEoyO7HnYDZMHd1loGNWX+0ClvvmXvaUgTdoysi6g0hCnW2xpZpqhgFm7QKUpI9g82RS51IzXQ60qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:20:50 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:20:49 +0000
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
Subject: [PATCH v7 08/15] iommupt: Add read_and_clear_dirty op
Date: Thu, 23 Oct 2025 15:20:38 -0300
Message-ID: <8-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 7632c1ce-1f1f-44b7-e82f-08de1260e3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+lIiBtqdFhNOZjASbu2vfvcvxXyLph3q89vz6+T1LgT5YCf3lWsGdOYjr9G?=
 =?us-ascii?Q?cQr2NBvFXQJKs24AOtPbU7Ehgj47uKreXODeNFn6OzJilJNE+XtfO8S2M8e6?=
 =?us-ascii?Q?jmFTLFFss6TfnUgKj4RhH2v4QErT0LepkNFn0oIKlH5RTpoLHNdAbzgV+JoN?=
 =?us-ascii?Q?z3B7A4Xd1vOHV7KGFQxg/Imu1wQ2MhAD9Hp2jlzmH46nherX4+1PmTTXt4K0?=
 =?us-ascii?Q?6m6NFUR0JGOwGeo/ePWNypTy7QKXlNWyhnJSq6qLS7c/noi3E7w8HkNeIyTC?=
 =?us-ascii?Q?G8O7OSsGW15sds7UsZhAuPP9p6euWk/rV6fPut9VUE+jvjXzVtxBMFH4u750?=
 =?us-ascii?Q?gJBbM94y97ozTKZ8kW6fMMEZsYqBPlp55QyQq7FK8nib8HGxo6z9JfIBJf21?=
 =?us-ascii?Q?MZk2rlAZjZ8PqCraWH9gVSR0gHegdDAR/pzpxhZp5ixCVSpuRGa+wgV5iCl2?=
 =?us-ascii?Q?f8DyfKXIJTem83OQmVJA+20fedzCGj1SS5XxViG8fcUigCxGAAWrpK8khaHL?=
 =?us-ascii?Q?ixLQSkhjOmokCndCAo1wOk3ihaw68Qb+iId3Wk6BcBa3ncgk2DuAU3dBpleC?=
 =?us-ascii?Q?pHSPL3Z1eyzixyFI+GUiEGQJz79yoJh70LcSMswuyIHdIKImhQi3LuRkoxuZ?=
 =?us-ascii?Q?/ViiABmq7y1e+hEcGsplgqzAxbB9W5AL4s1nhW5JLjRrprvdOsHbkgZnLJXy?=
 =?us-ascii?Q?HF9HLXpG55uwMBGB8sWQ5VD3pw/J5R/DFH+ei0YG95e/X+Q76KG9mQc6133h?=
 =?us-ascii?Q?KfQXcsFww+io/BQl3VGnNEzfx5NkyQ54+F13L2faHzjGqIrKFbbbre4hkK72?=
 =?us-ascii?Q?nZI+U4P0Sst+cfm81qDudDSch5YrKd/CexD7DrADHbmLTI7YzXh7sDnnqw74?=
 =?us-ascii?Q?XArmYAwSbJcj2CQUK9Q8iQKinsQaohvuQ7oMbj+DJ0yZ4jHD79xwZ1qJRH4s?=
 =?us-ascii?Q?/b0+rXXdc9NAAM74sPt1XEmuNtAj0DFtskpaAsso29TEEcYFagFSHjs0CJwa?=
 =?us-ascii?Q?xXKwTlFh87+Ur4n2oyKZg9dUCvfzMxk3zB0JYba9QoZzBkK/yVexxxUYCQ7o?=
 =?us-ascii?Q?9I2iOuJYvp30a+2kLo2VBXyn9ftCmEVXB0Vsgw3bmW+PkG6erGDpJcTNKyXS?=
 =?us-ascii?Q?yfwPHEqroCknfgSlrwJ9sy3YBO6H/++JEH7s8P7oRmB9uwctwf4eaPQCzcoM?=
 =?us-ascii?Q?Mw304Q/j/i+flNKzFGSjz8+900AB8RNCVSdkKk3Od/fRjh8u0PO5YXjNX8xp?=
 =?us-ascii?Q?I/K2ACdC1oOuaBajOfcAYniCD8/TK6kfcZt/mPRjSjChGfNblgMghIzIzGuZ?=
 =?us-ascii?Q?KLhuWkbEOK3/ih1YSoHCsCir/t1WB7JjagmMx7gSWE2a1A+p5hkdWYkA0EZP?=
 =?us-ascii?Q?ybuTWfj7v0FDwIfwg4IqeZA2WC82CKGOv7VARgeWd8EwweEjArwBNsrHyZh3?=
 =?us-ascii?Q?fqOX8JwUloTsyiD86J8obgtUi62DNvS3jSDwWuSRet3qmHayp/nhNqa95ZHS?=
 =?us-ascii?Q?YBOBPzwqU9gUcys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2SqyA5msRMHpJn9xzB4i8yVy2Ivfk2srJ5ZxRIsK0zbEAj/uuIR+qlHxMPu?=
 =?us-ascii?Q?Etx1JisMj9DeQofCe0jAmmjFKb/en0y/gudKSwDp3Fboo973tVQxKRlTRQqD?=
 =?us-ascii?Q?iGIdGl9urLJqW5QKSVXnq2bzSOFkLnslYoJ9l3uwonl/UxZ11WHjV8eO6xMG?=
 =?us-ascii?Q?k8nU1GuYAoIBCxyFOrFCn8/X+ojYzRijhaaKU26wpDqeAe4TwAUh4/S8UcUK?=
 =?us-ascii?Q?vZxvz146TQYo4m6SR6kh4JPpt12hj+eoWTCxnYIjUaDRMlBwAUWFaN+p32kH?=
 =?us-ascii?Q?Jjr7GygI2Bv6jeD/wbQgC8mn6w3hqI1tG/K6DHXYhPLsOJeOvD7R9xnwm3JA?=
 =?us-ascii?Q?V9T4VTo88Ndu7/6JrA/IyZbWWmF74YzBk3DjkxPU54pwWsgYbhSaVhzkaMs0?=
 =?us-ascii?Q?QCd8LPSwwhT1VJvGpROTgMEvX+KxssFQ3XHTd1fWgjESe/YoMdmIvMOSzZBy?=
 =?us-ascii?Q?qr62IjZXgfuBHr7mcYUjbP1nbfKDBvMD/f54YdCATw5oOK57UIu7XJc5yCal?=
 =?us-ascii?Q?0EahDCDKSbN9+ApmP6BcX0R9GKRWsvyaStzS4KxmMlwE/SNTlbQ4NeXkolbD?=
 =?us-ascii?Q?cptqAS1zsJXINcvf9JSjL5Cgj6tCmkDaDf+Uki8xmzC8qQ7IDyiggWR7W4Bn?=
 =?us-ascii?Q?QzZX/1Xy9yogwNSZVSQJ1D1KfoBrvEZYiKRLx0jSQbIQOJdp7Nbujvz1VCdS?=
 =?us-ascii?Q?JRteIanB7jZNMVvJskSo+xhormjl4IiTs+zOOFXo6HQ/v+8YM4cKgwaFhWq/?=
 =?us-ascii?Q?wC1mcSsqoQGiNuTQcpxAquaY1WZs0PB7zhyO/Mv5tKHJo+WuytWuYHtlqZ5r?=
 =?us-ascii?Q?Au8ZPHcFJsbRKE9cZDikx5NhVxhQcISdv8TkJZuM2Ae1iqfBWsIxWgQ5zYma?=
 =?us-ascii?Q?TgGZ9xFt4UYJL9hstLWaJ7JN0cnPxgDkCIZSu3WDt4LuOdboFDRGY+Lbos7j?=
 =?us-ascii?Q?ckrnG6SgeowOJ3FloUja9GmrXT4+Lh2BvGu7OJf+kO22GjDwHpwxT833pyCG?=
 =?us-ascii?Q?HkdT4jTRi3mMKFIitfdsGQO0staYeqbyBnZMrmO7R/JIYxdS1jIhqspT+3fl?=
 =?us-ascii?Q?EuWN5GPMtRN+Zw/EGexAWXbMx+eUYVggzw1fsg4y5hLbD3CZBhU++/hnp+qL?=
 =?us-ascii?Q?IUr0aKxnRkTIeCXOIkO3wlJD3+MrUFDof8dSkNXnyXpbNefG/gxNmccF0mXx?=
 =?us-ascii?Q?hcjdFCsJAfaIm4G0tBbB1mG2HVimDB/0s3KHKn6Re/xYa3z4n87hy6S8SFzC?=
 =?us-ascii?Q?fDdP6F7ChCNMkBHE3S1pQB4ur0ie8s7UIEcCthkAjJjZk6l6smstfB07c2gC?=
 =?us-ascii?Q?CmjmsVPPxkdndMRVzejFyeDweWY3bEa3Asv0FnjgXirEVV7W6lO8q9FqpmCb?=
 =?us-ascii?Q?BfS6r3PTrp3WoQ4w+7FMBvD6t8W2bOoJ0YlNU3Cgj60cxcQ3+HscDeWmna6F?=
 =?us-ascii?Q?SKVje819G0q4RowmfokZFC/kNUb2OrPXeexculDeldTMkL8/N31IORRs45w0?=
 =?us-ascii?Q?7ijZNZj7nGHy00jV+B9jsO00z29HeY85TXR0hKR4WOyfnFCSTQPzVHyVF/2y?=
 =?us-ascii?Q?OoM+xfuyOeJZJ+gtLRhycpGWsemB7i8XdG4+DFq6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7632c1ce-1f1f-44b7-e82f-08de1260e3b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:49.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCTUyRkwK+t8tyMm4x7HR4Y1PeL1N4Rk8y/a2te5II8Atq8St7H0yX5Jgu7QeVT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 104 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f32e81509f4f09..448c5796d4a861 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -162,6 +162,108 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
+struct pt_iommu_dirty_args {
+	struct iommu_dirty_bitmap *dirty;
+	unsigned int flags;
+};
+
+static void record_dirty(struct pt_state *pts,
+			 struct pt_iommu_dirty_args *dirty,
+			 unsigned int num_contig_lg2)
+{
+	pt_vaddr_t dirty_len;
+
+	if (num_contig_lg2 != ilog2(1)) {
+		unsigned int index = pts->index;
+		unsigned int end_index = log2_set_mod_max_t(
+			unsigned int, pts->index, num_contig_lg2);
+
+		/* Adjust for being contained inside a contiguous page */
+		end_index = min(end_index, pts->end_index);
+		dirty_len = (end_index - index) *
+				log2_to_int(pt_table_item_lg2sz(pts));
+	} else {
+		dirty_len = log2_to_int(pt_table_item_lg2sz(pts));
+	}
+
+	if (dirty->dirty->bitmap)
+		iova_bitmap_set(dirty->dirty->bitmap, pts->range->va,
+				dirty_len);
+
+	if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
+		pt_entry_make_write_clean(pts);
+		iommu_iotlb_gather_add_range(dirty->dirty->gather,
+					     pts->range->va, dirty_len);
+	}
+}
+
+static inline int __read_and_clear_dirty(struct pt_range *range, void *arg,
+					 unsigned int level,
+					 struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_dirty_args *dirty = arg;
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			ret = pt_descend(&pts, arg, __read_and_clear_dirty);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && pt_entry_is_write_dirty(&pts))
+			record_dirty(&pts, dirty,
+				     pt_entry_num_contig_lg2(&pts));
+	}
+	return 0;
+}
+
+/**
+ * read_and_clear_dirty() - Manipulate the HW set write dirty state
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
+ * @dirty: Place to store the dirty bits
+ *
+ * Iterate over all the entries in the mapped range and record their write dirty
+ * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
+ * the entries will be left dirty, otherwise they are returned to being not
+ * write dirty.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
+				    unsigned long iova, size_t size,
+				    unsigned long flags,
+				    struct iommu_dirty_bitmap *dirty)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_iommu_dirty_args dirty_args = {
+		.dirty = dirty,
+		.flags = flags,
+	};
+	struct pt_range range;
+	int ret;
+
+#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_is_write_dirty)
+	return -EOPNOTSUPP;
+#endif
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, size);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __read_and_clear_dirty, &dirty_args);
+	PT_WARN_ON(ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	/* Fail if any OAs are within the range */
@@ -1015,5 +1117,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 0d59423024d57f..03a906fbe12a83 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -12,6 +12,7 @@
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
+struct iommu_dirty_bitmap;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -182,6 +183,9 @@ struct pt_iommu_cfg {
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
 		struct iommu_iotlb_gather *iotlb_gather);                      \
+	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
+		struct iommu_domain *domain, unsigned long iova, size_t size,  \
+		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -202,6 +206,8 @@ struct pt_iommu_cfg {
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
+#define IOMMU_PT_DIRTY_OPS(fmt) \
+	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


