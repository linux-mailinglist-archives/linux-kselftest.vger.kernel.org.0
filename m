Return-Path: <linux-kselftest+bounces-34793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BDAD6857
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 08:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6094A179ECC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060BE1FBC90;
	Thu, 12 Jun 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQnpRuFw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3E2F4325;
	Thu, 12 Jun 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711564; cv=fail; b=jset51R8W/Vp6zMmRGywlQX1sF/+sFhxiCFHVwoAEuLJPhK3Zg0Uhw9gPq0NEVRmS+K6MPMCDkcTRzirj2INK7CChkzzCBZlT2CinVNgnz/Rl98jPFo5khgwO5fK+fyw2+qoya4hQ90HrcMFisfZCnJaqkwhGdZf3y6UI4Yqa54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711564; c=relaxed/simple;
	bh=E8z54I/oG2chlRnaYB0wdEujAIeipHt3K9YzGib9doU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+wHH8lKerQsOyP4mFdl/JzW6A0b5l+601J9zZy0imDhVFjNCQL4zc0897/b/HviRYIQn420bgePx+rOWERUjJgSrWnhSE4Asd1s2pai3JgNpxPXGU/otVp5HH2tafjTZ6YYljM/pxMpsAP4m9eB6hQMXPqv5UW0rSCa/yREMQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQnpRuFw; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E31myXa5io/xd/sySBQOUkE8O+Dfk2l0K/qNkYuO084WJl45xybriQw1W+8zo9Q5M77cB2k9XW8HayBjMqgvSau1A5+vx/A7Z07f3Ov9b7QsE/XVm8qq/gc1+ddhpxvpFzCYgQYjn4vb+OFBPYu4rWxHPddLYowTzRvbRO5e/W6BVoje3ScH49GnYm/q5wdomxvdS32ayW4HbVg+MNNKCBHUqUTjXICLm9txvaVYGtz74BtGDk9b7Ept6mK9BkgGL8t5WS2yZ8KmXo75Gwj3LXxtiH8NTFFvsc2Px9nraFOD/SenJNozSzzQoA5SGLuXLAKurxxG+BTRE913PCzhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PY+sZaBhyO3Tq0GrqOr1l1NZDcnM8+dXDEoQNdYhnA=;
 b=oZyzZyZK2uxaL/JPpK3hu/c0RCUg8g2qVza2QnntylGe1mlrAiH0mP+8dbr/YWdOwBCSLlDmatsFbhUV45ou0iTmwlzqKv1ThB871D5TFpnnpzhrYDT9tpq5ZDV8/m1aH7gzjqZnc3ORucF1+6t+DvQoULkOmJIj8CuX5hxfHMMNlJvbs6yC/AUD4K8eOOMG4AgIRFp7FT4yi2LQ8rSzwM08iQXKjToQsNPvKR7PRdB8/Z0NNzdDwP7sj6IipAalTAxmdnls7/95sfNlnjQwjLASEqJTCwM/iMwKapySFGAmlMoDciX9xZ1XCaVa8fUAq+tIXI55guBNu5NjuuEnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PY+sZaBhyO3Tq0GrqOr1l1NZDcnM8+dXDEoQNdYhnA=;
 b=fQnpRuFwlgTfvQUNlYFC1Rand6sM6FC5tkzc+9vBQNdstCwW8XK5wSYfRONDgFP7b73Wr49F9/QSDO1K6K21zos79I49NSf690n4gdd7Lt3j+0IIwU0OdNma/3MAvd5pwCNLxfaovFujS/XEs63FX5iD5l1D5DQAUJWBAR9XGLFOuALOF+HNxXlrt7YaSKjNQAlefdfX69OjX1dYYGpUAat8JVjk3EsywwEItuQCQoNjPOkeuNjemwgHppECkENn+UyVpUHP8iZZHoi4qeyeUSFUf2vYnZPyc23BKkk2qCfU0+o8h+T2HLNOn/A3F3SAzGzNB9xSjOvPqY60/Sd4FA==
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 06:59:18 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::c3) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 06:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 06:59:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 23:59:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 11 Jun 2025 23:59:06 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 11 Jun 2025 23:59:03 -0700
Date: Wed, 11 Jun 2025 23:59:00 -0700
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
Message-ID: <aEp6tGUEFCQz1prh@nvidia.com>
References: <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250611235117.GR543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dd5f9d-0bf3-4ec1-7b68-08dda97ea654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8qhOCb063KEz4n+ZG91mZGpzvc5YJpnFDko2FN9JOoa9UEM3z2/wYU3TZzE?=
 =?us-ascii?Q?e5pKwgIStFUJ5XH8hYfpUGgTdeAWUxEKutbjFc4ka+cRvL3iblXQl1u8lFDA?=
 =?us-ascii?Q?ipIK4HTig7hPKV0PzrigFBLvYFagvgmcS4nRc9xx0YnVnDWv2SfaQZykgDKs?=
 =?us-ascii?Q?DlDVf9Glup0n80ROQ+Y8JOg7jJ7E2BWs+NnXJ+9HiekrMKOPvQ4wZQOBur2q?=
 =?us-ascii?Q?bPIxnp8V7GtFFI3OqHEvcKpD+tbL0QnnPTFtIYToUu/CSZmy2WoQ7jXJ6zum?=
 =?us-ascii?Q?JU3JPfYfEJ3+lwyYWBBSqKtmeM/dnKdamlfvZWU1/sqb4eJPRvPszx4M8NK1?=
 =?us-ascii?Q?MCVjreGn/NI6SAFJreRq3YMOD+kPwDhpJQhZ2mXttoawGoDSIaCEUCLHI+hr?=
 =?us-ascii?Q?NuSFU7X4LbZZPsN2KoxCRebPEej67A/vTuVHLr3GypdpDyo1nZNvRh6pGPew?=
 =?us-ascii?Q?AKEZlZq5hRDnhNq90+l3PofaRY3Mm+Zmv1YUFg8EzT81J7Og52+XrKxACiGS?=
 =?us-ascii?Q?xrOnlojBtTKk6WxWZE0uAz1h4Be+Lgl8PeCvl07vc3EMln9XDAz0iuKZSgEE?=
 =?us-ascii?Q?KcZ14jjryXJ3JDWz75kKk8E7hmbzxviHHXl63ogPYgOtvzMbM2rjkfC4VWSS?=
 =?us-ascii?Q?ZwOX/Y124R8MhUjnTFnTTmHlHF3mTVB1cXcPHnyHvEB61QuG+5/TVnk3Wq7q?=
 =?us-ascii?Q?S6uOVtb9vz4KY/CqWXyfQQZl/swyntMjciNq7ZEpxTkdpHPvjnJ3oj7PypXf?=
 =?us-ascii?Q?nGO3sh7ZhxyWTKM3enqQnWPKzyD2EHHzhCuerHhyiCAPDU01tmv8OXFytSwt?=
 =?us-ascii?Q?JmP/I5Sfi5QL/SVOsPNmjKK+98sDpzKZbdfNgQAV9KtXk763vCf6A0coKpC9?=
 =?us-ascii?Q?sIghyp2IH5VYL4rpr/uzix6zTigEdZYIOU5VH0I4OrFDAE//FPPzahv8hIhV?=
 =?us-ascii?Q?zBlKiTOvCwOaaooD1hKGUJdK6nCUp4ZsG9fQ3knVHvkTTFwEuNYhYfaZe0nS?=
 =?us-ascii?Q?Q+cOOQg6IXGWeSHJ5O9WNA0MMHxrFVB1fEDZSl3G2ajLccYahZZITemOWi+e?=
 =?us-ascii?Q?aiLzLWEiFMZ5v/xUKoj+ifpYRPNjMNWtACq4SobDCglbWv6B7xuniZNmQfBZ?=
 =?us-ascii?Q?MNXrSmTVhE5/Gi2yCaqp08dvxvGqbOxca9ee1LjZSB4JLr2hfcOBn1B9u8dk?=
 =?us-ascii?Q?ML3hnTwoAuzNLrqnY4qd6TePYaSztaYM24YTN8FBeCIWMajgoEQVTXRFdzLk?=
 =?us-ascii?Q?/WbDBiF5M19DJnibc95gs23Z9xYRLuGZHJ14Jn6rvszjRvYyr+mJZVDIVoR4?=
 =?us-ascii?Q?lWgA29s+YLgaZD+lX+ArT/p0NNzcfEpObNIRGRsKhN7WCLLoW/8z0XHXZOXk?=
 =?us-ascii?Q?fark1eoD/Z0o/cXHxtHyK4/92+eg9FTB79oUxKk9wiZ2mrQjwVd0LTIrnYM3?=
 =?us-ascii?Q?LtWRwNBHpLyGLo5+Cnn+3fPu54c4W/53BJtqjzsEYyDa/oNC9dDIWsTm4ehn?=
 =?us-ascii?Q?w6TUVqKui5Ubo48lrQ1MZVxzRtnZosWEb3YYMjunq71oIijqA+dcnC5eGQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 06:59:17.7830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd5f9d-0bf3-4ec1-7b68-08dda97ea654
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

On Wed, Jun 11, 2025 at 08:51:17PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 11, 2025 at 04:43:00PM -0700, Nicolin Chen wrote:
> > So, the test case sets an alignment with HUGEPAGE_SIZE=512MB while
> > allocating buffer_size=64MB:
> > 	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> > 	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> > this gives the self->buffer a location that is 512MB aligned, but
> > only mmap part of one 512MB huge page.
> > 
> > On the other hand, _metadata->no_teardown was mmap() outside the
> > range of the [self->buffer, self->buffer + 64MB), but within the
> > range of [self->buffer, self->buffer + 512MB).
> > 
> > E.g.
> >    _metadata->no_teardown = 0xfffbfc610000 // inside range2 below
> >    buffer=[0xfffbe0000000, fffbe4000000) // range1
> >    buffer=[0xfffbe0000000, fffc00000000) // range2
> > 
> > Then ,the "vrc = mmap(..." overwrites the _metadata->no_teardown
> > location to NULL..
> > 
> > The following change can fix, though it feels odd that the buffer
> > has to be preserved with the entire huge page:
> > ---------------------------------------------------------------
> > @@ -2024,3 +2027,4 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> > 
> > -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> > +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE,
> > +                           __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE));
> >         if (rc || !self->buffer) {
> > ---------------------------------------------------------------
> > 
> > Any thought?
> 
> This seems like something, variant->buffer_size should not
> be less than HUGEPAGE_SIZE I guess that is possible on 64K ARM64
> 
> But I still don't quite get it..
> 
>         rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> 
> Should allocate buffer_size
> 
>         mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
>                 mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>                    mmap_flags, -1, 0);
> 
> Should fail if buffer_size is not a multiple of HUGEPAGE_SIZE? 

Yea, I think you are right. But..

> It certainly shouldn't mmap past the provided buffer_size!!!
> 
> Are you seeing the above mmap succeed and also map beyond buffer -> buffer + buffer_size?
> 
> I think that would be a kernel bug in MAP_HUGETLB!

..I did some bpftrace:

ksys_mmap_pgoff() addr=ffff80000000, len=4000000
    hugetlb_file_setup(): size=0x20000000
        hugetlb_reserve_pages() from=0, to=1
        hugetlb_reserve_pages() returned: ret=1
    hugetlb_file_setup() returned: size=0x20000000 ret=-281471746619776
    vm_mmap_pgoff() addr=ffff80000000, len=20000000
        do_mmap() addr=ffff80000000, len=20000000
            hugetlb_reserve_pages() from=0, to=1
            hugetlb_reserve_pages() returned: ret=1
        do_mmap() returned: addr=0xffff80000000 ret=ffff80000000, pop=20000000
    vm_mmap_pgoff() returned: addr=0xffff80000000 ret=ffff80000000
ksys_mmap_pgoff() returned: addr=0xffff80000000 ret=ffff80000000

We can see the 64MB was rounded up to 512MB by ksys_mmap_pgoff()
when being passed in to hugetlb_file_setup() at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/mmap.c?h=v6.16-rc1#n594
"		len = ALIGN(len, huge_page_size(hs));  "

By looking at the comments here..:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/hugetlbfs/inode.c#n1521
"
/*
 * Note that size should be aligned to proper hugepage size in caller side,
 * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
 */
struct file *hugetlb_file_setup(const char *name, size_t size,
"

..I guess this function was supposed to fail the not-a-multiple
case as you remarked? But it certainly can't do that, when that
size passed in is already hugepage-aligned..

It feels like a kernel bug as you suspect :-/


And I just found one more weird thing...

In iommufd.c selftest code, we have:
"static __attribute__((constructor)) void setup_sizes(void)"
where it does another pair of posix_memalign/mmap, although this
one doesn't flag MAP_HUGETLB and shouldn't impact what is coming
to the next...

If I keep this code, the first hugepage test case can pass (64MB
buffer_size; 512MB THP), but all the following cases will fail,
as I reported here:
https://lore.kernel.org/all/aEm6tuzy7WK12sMh@nvidia.com/

If I remove this code, the hugepage test case will fail from the
first case with signal 11. But this time, it is not because the
mmap() overwrites the _metadata->no_teardown, it's because mmap()
call itself crashed...

And, in either a failed case (crashed) or a passed case, the top
kernel function ksys_mmap_pgoff() returned successfully, which
means it seemingly crashed inside the libc?

Thanks
Nicolin

