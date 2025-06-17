Return-Path: <linux-kselftest+bounces-35156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1630ADBEE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1203ABC0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F631A3BD7;
	Tue, 17 Jun 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIoVwK+b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF418E750;
	Tue, 17 Jun 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750125760; cv=fail; b=EH4pteymn51rvMb81EzrFCF8cPtWgAyeB8hvOOxJZoaDAIlBr21b4OSDAu8ZbTJ+QT72fLKIsjg+2xQuwek55PYTlPrxVK+4Ccpp/BcwUyK2x9PghPgK1hHb278+Bl9Xc9TOYKg3GppWTDabUFcAI9DTuzIt1PIp1G2f+Hx0EKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750125760; c=relaxed/simple;
	bh=X2G6NV6OwitpkciLZcTEKob/lbIgJsyZK4MnvFigTWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8PlnQXMxvpcpdxSJObaJidiRCK24HuTuothHkYoZotF9vZ53bzOmgSMk4pomKo3LgeGNNkKC5YOitmel/JVlZLzBDi7I1lCabWLewwcohDeE6oNhexiww+uIPCufhWktQJKemDCDvKaiR7+vpse9i/VYZxLoGtBIOiQX6b6vvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIoVwK+b; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDyXq6s7329qh5UDjt/YNMXRekGf/RI8AITama9fZ7AhcRLHc2lBAxUfGncxWVLis14grJWBK/4PgXE88k/CErGltir0MdKVSqHwO5XiSsbPHIl/uLvA7XIbbwC0N7FZrVEBh3debLhjmWRenkKglpZG4eZuJmgD+R2kRq9nimc2VwIMdn5AyibedFHpZueYthXztE2UYnZj9iXTImjeOQFndLBd5F4FPjm2NC98XkcfbTiWlUHWwbvNavBsdrbi2cLXIwz6iceWLP3sTtacDpbpDxqM//Hrwmu1fCCz8QzTauUZhkWkvNvWQFRU2Af6qv2BPbnlMAhwKVh7ibZ2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5V2MZCewiYTfGHWtsxNqGoQDjFQAW7KWkRCV8OKVZM=;
 b=A4Gm2WfePCt5W2mPGTxDWplPDUs3NJzgNZJj8lTvm244Ffl4HEhWue5zSgnKM0E3ukZVP3xaohCI4j0SqC9pQ9XBLsLW2eBcBsexCRQkB8BU1/xc3NhTfDyK4MkTy6HCQasItWnCiVnE5qkjevLXnmkdX20uQLEmqp4xgoTdriHiymcdGQ0FJrEHN7cFdTSLrkAjIFo9XkBSOjIhU3BxCOCGScrNjrNKw6hDAYtJg4TSJ+eE4+KaQORK/X+DxJIHrdNF56Me/u3aMg6BE4BFUR2kBvKcAKuNAIYdVB1/rkG6dQQj2RMzOxT2Vqw6BWW/efE/rK1Ay2XQ4VDA5noHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5V2MZCewiYTfGHWtsxNqGoQDjFQAW7KWkRCV8OKVZM=;
 b=aIoVwK+bPnkIkzlsRQRudLJ0eFr6ZKvoSdEQlYxkatGwpB6fiT5eOx73buKzl5FAKysi+LMgkdl048Ti+CRTWRTx6iPUAsf3vIMD08s1OMBRC/2hYs5Fh/T7kfcgap17+yBywuy4b0vH89PMEohBhrQFOOMetr03P+twaVeLbpnat00stBwzo6HjD08yMys+KX1BaOQKHVxtgV6bDy2evfTMdD2o8RFVm1+aUPdhhb3BarbdpDGwsDVztNGBwtf4yT8Ju61gtMasT6iqjcV9PayiWpkjDHymNdg65a1fcXKfAcL1k/msWC00/gK3b1r6wusqXoNMsZdTh+3aWlUQNg==
Received: from DM6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:5:bc::25) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 02:02:36 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::eb) by DM6PR13CA0012.outlook.office365.com
 (2603:10b6:5:bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Tue,
 17 Jun 2025 02:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:02:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:02:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 19:02:24 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:02:16 -0700
Date: Mon, 16 Jun 2025 19:02:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <aFDMoMX8eL7azoUL@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616162501.GN1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e52e82c-309f-473c-46b8-08ddad4307eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERLMGc0aGlLRWxuOHl2T2RWc3o1emRuOFlIWDNEc1JrQ3o1cUd6c29Ra1I3?=
 =?utf-8?B?VWIyOWNKUWRSMkRYWWpIb05zay9odWdBQVlRVGw3YmlBTHdPcGpSTW9ENCt0?=
 =?utf-8?B?cU1ieUs2REdCdjQ5VXRYM3A3M2RNRjFlejJJNHUwbHBnYjBxdkxVMlFJZHRx?=
 =?utf-8?B?WnA2UXN6NEd1S1NPT3Z3OFdERldvVi9hVXA2ZENxSWFBY2Z1WHd0dm5nRkNj?=
 =?utf-8?B?akJ0RFZLMDRzNWdRbnp6YkJYdE9iVXpocDF4Ri81MWpVekhoQjFzRFMxbVIw?=
 =?utf-8?B?bGM4aTM1TWFMN1ZIYUl0L0tSN20zUmFJRUJDS1ZzYUxuY3JtRis1VEhEcUEv?=
 =?utf-8?B?YUZTb1FJdDlkNUxhejBuRnQyTCt6OTV4dElkbnhBWVB4LzhzMVRDNE9Zb3RL?=
 =?utf-8?B?cEE1K1U0ejhIM3dwdHNUVDJiMCtpRmF1MVpFb3hrK2FjL0tFcmZVS2JtcThp?=
 =?utf-8?B?a01PYVY4bEhDWmdlUEh1bUphMVBMKzZuZEc4V2p2WU9qK3ZNV2traW50T1F6?=
 =?utf-8?B?aXFIWm13QTR5aVVZWGcvOTdpZEpHbU9mUk9HTFE2Z3JldE50ZzcyQ1dSVWE0?=
 =?utf-8?B?MnF3bEJyYmNINURLbkxPZ3RaWWkwMmw5a2RkWnBHKyszUjdwdlRnTDZxdmhu?=
 =?utf-8?B?NTQ0VzMwZldqWEY2bitrdndTcUNUdy9kSTFTU3VXeUFJS29ycFhYcjdhQ09U?=
 =?utf-8?B?NGx4WXZqREc1c0xVTzVRVjBZL0YrdDIwTVdSWGR1SzZmWENleEsxc0tXMk9y?=
 =?utf-8?B?U0hzMFQwcy83OWh5b09vLysrRlQvT0ZMQm5obHEyWjZzc3pjTGNJS3NnUTRN?=
 =?utf-8?B?NzY2OFE4U2hRN0wxbXFWcnZrYWpEL1hJMC9kb21pdHZoYnRVbDFST2lERmta?=
 =?utf-8?B?K2YvYjMybTVQV3ZoVDdmSzExNWFyUU54bmFMc3R4NHJSUHRjMVJ5ZzJiaXFB?=
 =?utf-8?B?NG9GaTNJZFFSS1VvZHdyZ3Jvc05wTG9zZ05pQ1lBYkxzSVpjcUQ1UWx5aFdi?=
 =?utf-8?B?Q014WE1NVEZXZDUxUmVQMFQ1Um1FeEJaNW9QQ2ovb2xsOUo4OE9hbXFyWFJ5?=
 =?utf-8?B?eVZuRVhoTHcwOURXcUFMb0ZKUVhCaFhTZ2M5Mlo4V1FxYldRb1dYSElPL05l?=
 =?utf-8?B?N0hkZTYrMGNCRTNmaW5WVTR4VmV2ZFZSYVJUbnFlQ1c2WUhhQWZuU1JCbnQ1?=
 =?utf-8?B?NytTbVJFeDFzRzBaWmtyK3RZaHQ2TzlkRXRrM2swK1ZIbWJ1TFNUVzcxN0Q1?=
 =?utf-8?B?eFFzekllZi82cEpYN3p4dG11dG1OK2Q1eC82c2M0b1ZGWVYxbURWOWMxcFpo?=
 =?utf-8?B?aGxvNzZmeitxTVp6bkd2d3ZnendiaGpxYWpwdlRLTVVuZk95VVNiU1VtZUs4?=
 =?utf-8?B?dDR2bHUzMkJ0U0dJb29aemRobGNuc21mYzUvWjNMVG5BaVFuYU1sRFpQWTY0?=
 =?utf-8?B?RlRLRXBRZ015NVZNOWEzbkJsbDZOVDZPNWpLM0Rld3VnMnAwOUdmaHFYRTcv?=
 =?utf-8?B?U0pvRjZNM01MMTNXRElQdHhVaktsK2U0eXNuQUNUR0VKSHdVZjZXMWh5Vmd6?=
 =?utf-8?B?dGp5V1Vpd3NvVVNEZ2pIZzN4bTViTExsU3dvRE9SOVIyY21OellEL1NJU1Rx?=
 =?utf-8?B?RDNFcGtBRWtsSkRMUFZtdDNuZCtUdHJIWnVJQ04ySldVbERUQ09XSHljQzJt?=
 =?utf-8?B?QzBXQTdJWWIrZnFIYUpnK2lyeE91alhHVjIrTExkR0tKQUsvbzJEUlRHL1Za?=
 =?utf-8?B?M2ZsQUdVZXhvbnF4WTgvKy9Nb0RZRmlTUEgrc0hkSU1jRmFFZ1BnNkNiVjdx?=
 =?utf-8?B?b0pBNXdTRFdqdUJjK3ErdXZiMUNyNkxsRFEwNVU4YVd4VWJuelc2RWhhYWRz?=
 =?utf-8?B?NDIvaWJsU05ZRytFN3RybEtmOVFXcjJDTDRiV0FHY2dGbk9RWk8yWkxEaS9E?=
 =?utf-8?B?YkRPUWxhQTZGYm5FVjd2Ujl3bWJocXpiL3pmV3UwdkZ5RkFtRGxFTERsdXk4?=
 =?utf-8?B?U1hOOTFFYVovM0VycHlBeWlxWEtGNTZDOUxId25uc0tHNlNXNkdIUWVJeHBk?=
 =?utf-8?Q?1/rdPD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:02:36.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52e82c-309f-473c-46b8-08ddad4307eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

On Mon, Jun 16, 2025 at 01:25:01PM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 15, 2025 at 10:02:03PM -0700, Nicolin Chen wrote:
> >  FIXTURE_TEARDOWN(iommufd_dirty_tracking)
> >  {
> > -	munmap(self->buffer, variant->buffer_size);
> > -	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
> > +	unsigned long size = variant->buffer_size;
> > +
> > +	if (variant->hugepages)
> > +		size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> > +	munmap(self->buffer, size);
> > +	free(self->buffer);
> > +	free(self->bitmap);
> >  	teardown_iommufd(self->fd, _metadata);
> 
> munmap followed by free isn't right..

You are right. I re-checked with Copilot. It says the same thing.
I think the whole posix_memalign() + mmap() confuses me..

Yet, should the bitmap pair with free() since it's allocated by a
posix_memalign() call?

> This code is using the glibc allocator to get a bunch of pages mmap'd
> to an aligned location then replacing the pages with MAP_SHARED and
> maybe HAP_HUGETLB versions.

And I studied some use cases from Copilot. It says that, to use
the combination of posix_memalign+mmap, we should do:
	aligned_ptr = posix_memalign(pagesize, pagesize);
	unmap(aligned_ptr, pagesize);
	mapped = mmap(aligned_ptr, pagesize, PROT_READ | PROT_WRITE,
		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
	munmap(mapped, pagesize);
	// No free() after munmap().

---breakdown---
Before `posix_memalign()`:
  [ heap memory unused ]

After `posix_memalign()`:
  [ posix_memalign() memory ]  ← managed by malloc/free
  ↑ aligned_ptr

After `munmap(aligned_ptr)`:
  [ unmapped memory ]          ← allocator no longer owns it

After `mmap(aligned_ptr, ..., MAP_FIXED)`:
  [ anonymous mmap region ]    ← fully remapped, under your control
  ↑ mapped
---end---

It points out that the heap bookkeeping will be silently clobbered
without the munmap() in-between (like we are doing):
---breakdown---
After `posix_memalign()`:
  [ posix_memalign() memory ]  ← malloc thinks it owns this

Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
  [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
  ↑ mapped
---end---

It also gives a simpler solution for a memory that is not huge
page backed but huge page aligned (our !variant->hugepage case):
---code---
void *ptr;
size_t alignment = 2 * 1024 * 1024; // or whatever HUGEPAGE_SIZE was
size_t size = variant->buffer_size;

// Step 1: Use posix_memalign to get an aligned pointer
if (posix_memalign(&ptr, alignment, size) != 0) {
    perror("posix_memalign");
    return -1;
}

// Use the memory directly
self->buffer = ptr;

// Access/manipulate the memory as needed...

// Step 2: Clean up when done
free(self->buffer);
---end---

Also, for a huge page case, there is no need of posix_memalign():
"Hugepages are not part of the standard heap, so allocator functions
 like posix_memalign() or malloc() don't help and can even get in the
 way."

Instead, it suggests a cleaner version without posix_memalign():
---code---
void *addr = mmap(NULL, variant->buffer_size, PROT_READ | PROT_WRITE,
                  MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE,
		  -1, 0);
if (addr == MAP_FAILED) { perror("mmap"); return -1; }
---end---

Should we follow?

Thanks
Nicolin

