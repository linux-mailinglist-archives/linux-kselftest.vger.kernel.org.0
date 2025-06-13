Return-Path: <linux-kselftest+bounces-34867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB6AD82C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1469A18990C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 05:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517F254875;
	Fri, 13 Jun 2025 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiWB5SVE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27238255F52;
	Fri, 13 Jun 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794124; cv=fail; b=eVtg80MUb+5NvOCh+ynhryUe2MjzLzwMx4mtWGndrXC4/Se/Xw0fghCOqnVEKaL4o3CSrdbw2jfOUtwVVFUSyQi9IbkpL5aHB5CYid53aw2xq9KKuTl6AwBfWt6F9RkzsK1ethwDoGMgjKnH4snHbTHOLDR8grvfDEV+AqkRrbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794124; c=relaxed/simple;
	bh=lD9OssPeLDcFaVmnsNlx17jnINKQrkAssSZATSKkFLo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMb638q/Xj2iDB2TcAirACdND4hnDI8cyoXYx1oGLu0WNF+lV8O6jutA6XGXCbDSOciRf/O+OuSOyHt3WbrP4rarVxgRntbKkaMWW/c7VWuT4RyWyNziIeQbF2ZY6vWxDKpxXNZQvD3CVmSCc0B/der+SQdWvSHr/KifgnnRNjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiWB5SVE; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njPXilzUHWsfvzrIcDjBkmfXWw5koNLxre8tLhDKkFLd2KCdnxigQ66qzlOLU+wbdqyWNR3BckR8TvfRolCa+tXiAx0AWXFt4DRPYf1XuNy+9EqoTuTctOVuZdFebzb/Jx2RaS4byq95Z4GXPPFK5E1ho8u4q+hmQlsNm9RrxG4Xoahtuc7Vt/8nHPHqrJqWLtcLENfgxd2qIB7h6uT1dGQ57o4bbePZkLZKt9ClEAVXEe1NxWVKK/3TQyKdV754VNV/lmIJMPgMdZemv1Ui7AE1eBKG2GYemcfkYexB+rHUZ7kVKSiiW7wQd0hDUGb8bC7XLkcjwGfdxOqoUpsXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1JZqpVBtQZ8TcmJshh6ANh+ioAyPZNpxL5iFw4wUGc=;
 b=oNQkgWIHRxGqalr3FSSjQ1Rj+RmrfVehs01Xdr0zGpbFQx5j2oYQJAT3KJv856Dlh1DOhUa1pVrK8yFdVuVUnCOIwSrSqzEPTpQVrJqK1D14deyea/vkQ5ALZptFro1/76HcLBsiam1liq3BhtDuOw8BfoqfaJnzLFQ8/SebtF83TM0Ybyn6U68CaJsCajwCwJ8KgFJTiM8mXsW295ydd0co6Q+1Lm3l0qVYZ43LR+euEaFcqPFd8aJXZV+tjG64stBcuzf2Pp85M8dFfvtLxe7NKhjmXZ8NRWYGgr3jZG21ULoaNqiYgf2OOlmMCce4uQjmMlFViCqjWVBn/SuO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1JZqpVBtQZ8TcmJshh6ANh+ioAyPZNpxL5iFw4wUGc=;
 b=uiWB5SVE3DvCsNsP3oPVVq1YKURvVcAK64ISCtdJWDEbcjpURruZBSOPhqO59/GynBxqMV2u0RZLe1UUFS+60Gc/VIUwbCcU4Jk7RajZssQeCXaR28rVCYJ8JUSKOUnw12LJycAp1XAy036tg6KSoWQeVYDJNITX5GNVASZoOaWEUltOH1eMMa4fw09ilmJFszlDU7zVBLf8+sE/OGJ/Ez7/AkXgc4iiqWjEL8OdPAkLkgD8oixOvl6UbFiqQNSm5K26ckQBBlOOH7tasJI+72h2dOJJBhACsu6zR8Vv4frZnhqCkW1tVcvbJc3P4N8PF4QLcfVQryKtKTYxXI7nVw==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.20; Fri, 13 Jun
 2025 05:55:16 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::98) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 05:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 05:55:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 22:55:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 12 Jun 2025 22:55:08 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 22:55:05 -0700
Date: Thu, 12 Jun 2025 22:55:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Willy
 Tarreau" <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEu9N7f0mfQM5w49@nvidia.com>
References: <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
 <aEsUGP8xPTDjG0ob@nvidia.com>
 <aEsiJFku+wR9KxE8@nvidia.com>
 <20250612185613.GX543171@nvidia.com>
 <aEskchlFcNL3T6sO@nvidia.com>
 <20250612233138.GY543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612233138.GY543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 959c6dbb-848f-43b4-f1f7-08ddaa3edebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbY+NIlGTkcu0ibctWYbZnjcuox700vl+ptVs1JrIA6Ygzcc7cT1ZfWfpWU8?=
 =?us-ascii?Q?FiRu6/7sZz8FcEvzlQKdxblG5vKoLPC/ynuzUTrgwqVxHSuvIbjwhm3GWAyu?=
 =?us-ascii?Q?infFDVLwfl4PB6wI72w1kMJKikY7gcjjOwSquD1eojcSf0oYgMZMoC6m59kL?=
 =?us-ascii?Q?07RnF0jVrOxSJ1A4XkWr8X/FFi9Tb+Yo4aGlxTagBFtdffUKL5HJqN2dsBvQ?=
 =?us-ascii?Q?CUkCRQ7bwyP+Sjz63I9CXqUmySwAHab/qn1fBWRE9iUSaXETLbwrbO+z3364?=
 =?us-ascii?Q?fES1N7ettkSEBM6cN5eW8mhhHf4JK72KNODZo1aLSsByS56GMc4zMNCs/Cow?=
 =?us-ascii?Q?1xQaL9AkQ+KFxSWVwtZ1Azr8OIrN1ZmuUL82GcqTkT6FBhKN9Sy+z5E7uPMO?=
 =?us-ascii?Q?MlXwKoJzKxcllKJIyFlLsxXIwPaAMnZdaS+B8LLo4qQ690UIRin7c5N5rSIz?=
 =?us-ascii?Q?3fmzdmlGfECU0rPc6v1yt8ktvbpkTbk27jpZORhclQIFJza8Nz52awVBN+zc?=
 =?us-ascii?Q?fpK834d65Si0ZPUZ0TOx8b5NOK1O7S8NwSCDtfzb6w/IKGpnjSDowkt73YEa?=
 =?us-ascii?Q?7oNxpCdHMmeO9iZxhICh0kdsk0c4gX8zLkx/6uRcnIgUJTBdc+LYBtJ0pELr?=
 =?us-ascii?Q?V0mNZ8dbg184c/lnR4pngUuRIa1bdM+YwbI22BX0nrKNHF2Tq/adOcU8XERC?=
 =?us-ascii?Q?9XnmL8LDL/18tJIKCy0SNi5XnNPBLBdK71lHRRqd67Fcb0P7IBbQCxTD4aJA?=
 =?us-ascii?Q?ge9E04sG+wRcwfQWNXhUPhbfP0VD1cgBQ0t7HjBY7fz8e/mvIYzHvkPAB7Qv?=
 =?us-ascii?Q?yJhDRs62ofwjBi23gu/bmr9JwK/BL4W68106/l7Vtohsrb49cyyz2FOPqxd9?=
 =?us-ascii?Q?i1ofHqPYkn8AtzyqV7mbrmfMzhdcDj5T82IwUuCHHk1A38EOoN3m8UkaoZYF?=
 =?us-ascii?Q?j31WTevKw4+HjptAfD+Onfd5m8V7z1fUh29+qWieS+2SqMQ9DqC2i6b5ey+k?=
 =?us-ascii?Q?ZjLxKC6Xj/XCdJECuHnVT5o0YQ/GCbjUU6RHKvnZxTf2UdOio+eIm0sKg4tk?=
 =?us-ascii?Q?qvKSu3+ubwlaHIBxUJlMDr+ffh3ffXztZSjwLvFhyZ3VM6wdyUD2ThPbAn+6?=
 =?us-ascii?Q?JyfMsrf0cJkBP5W9UkZPL+HvLGCKMmQX3B2xCyT0pcT8E7IrLda8pmdptk5S?=
 =?us-ascii?Q?93+xrqiwJQhstCrsscDJGJh7uG0IGuWaWiPaulcSFTDGj/UwnrwcLG/b8vLh?=
 =?us-ascii?Q?u2wWMTlar2Zp/MMxyDZkELvHyXCGddCTC0scMtb3+IE7l7LO4SqaIjyazbos?=
 =?us-ascii?Q?9WwPSEHKuUrZH+wMi5YOT4864nA6oZePTCe7hHxee9s1bYwLh3ugexnUMSbO?=
 =?us-ascii?Q?TYUe/YWqJOU6+0H4shc+oWW8TslUkKFAYZa3ZsWWoC8NjJ5lILQXxeR9IGIO?=
 =?us-ascii?Q?SbyeHTfbCQ+5wzsZ0zBqO62rm9b+LX9UoP+7iqxjgEDA335se/EExFOyv8M+?=
 =?us-ascii?Q?+OLBCH+Z0nrIJvaH79RQmXufAKtlP2FtpawN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 05:55:15.7584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959c6dbb-848f-43b4-f1f7-08ddaa3edebb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

On Thu, Jun 12, 2025 at 08:31:38PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 12, 2025 at 12:03:14PM -0700, Nicolin Chen wrote:
> > On Thu, Jun 12, 2025 at 03:56:13PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 12, 2025 at 11:53:24AM -0700, Nicolin Chen wrote:
> > > > @@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> > > >         self->fd = open("/dev/iommu", O_RDWR);
> > > >         ASSERT_NE(-1, self->fd);
> > > > 
> > > > -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> > > > +       if (variant->hugepages) {
> > > > +               /*
> > > > +                * Allocation must be aligned to the HUGEPAGE_SIZE, because the
> > > > +                * following mmap() will automatically align the length to be a
> > > > +                * multiple of the underlying huge page size. Failing to do the
> > > > +                * same at this allocation will result in a memory overwrite by
> > > > +                * the mmap().
> > > > +                */
> > > > +               size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> > > > +       } else {
> > > > +               size = variant->buffer_size;
> > > > +       }
> > > > +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
> > > >         if (rc || !self->buffer) {
> > > >                 SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
> > > >                            variant->buffer_size, rc);
> > > > 
> > > > It can just upsize the allocation, i.e. the test case will only
> > > > use the first 64M or 128MB out of the reserved 512MB huge page.
> > > 
> > > The MAP_HUGETLBFS is required that is the whole point of what it is
> > > doing..
> > 
> > I am not quite following this.. MAP_HUGETLB will be still set.
> > 
> > And the underlying selftest case is using:
> > 	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE
> > 
> > Does it matter if the underlying allocation has an overshot?
> 
> I expect munmap won't work with the wrong size and the test will OOM?
> 
> You'd be better to correct the actual variant->buffer_size..

I saw test passing, before I posted that.

But you are certainly right: while mmap() handling MAP_HUGETLB will
align up the size, the munmap() doesn't. So, passing in to them the
same variant->buffer_size will result in a size mismatch.

I don't think we should change the variant->buffer_size, because it
affects the bitmap sizes in those dirty_tracking test cases. And if
we align up every single variant->buffer_size, the variants of 64MB
and 128Mb will be two duplicated 512MB cases, right?

I think we can just add this on top of that:

 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
-       munmap(self->buffer, variant->buffer_size);
-       munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
+       unsigned long size = variant->buffer_size;
+
+       if (variant->hugepages)
+               size = __ALIGN_KERNEL(size, HUGEPAGE_SIZE);
+       munmap(self->buffer, size);
+       free(self->buffer);
+       free(self->bitmap);
        teardown_iommufd(self->fd, _metadata);
 }

This FIXTURE_TEARDOWN() didn't free the memory allocated by the two
posix_memalign calls in the FIXTURE_SETUP()..

Thanks
Nicolin

