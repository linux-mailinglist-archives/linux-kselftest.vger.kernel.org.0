Return-Path: <linux-kselftest+bounces-35236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DEADDDDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32E3B3A91
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9852F004F;
	Tue, 17 Jun 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7fLt/ml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572F2DFF3B;
	Tue, 17 Jun 2025 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195453; cv=fail; b=U5RA07CGgls+s9/c4/y1XncjOeQnRuJkAzR0amJ5dPJHFkem30p1XZi/k9tzrhOI5oXnz8w3gWtIWKzG5hHib57WovsAB6ekjzoEcemLbBmHzpOEaPSFjzN23YgFgsNPE+GtpEx+mVjwsEWuxOXXe68Q0Qlkm2CFQPqURBdIr9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195453; c=relaxed/simple;
	bh=De3FZcbNbx1d8Bk9h2OniyI0Idil3EtXhvp6pNvEh70=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niciOddMqH1gNDqr7qXfOYmaq8PyAduTjWwJsFaSw8ST54iLZNAOKPTDbXESKvpGJxkCY2ZdehfcPeIEKAO9LGPeC/yKGPdZd9a9WfYX6+1ra9l/me1cs+goR070Wj88xukRmgVh2k5pSwRCKRq9gUEfpq/k+gSoYzwpGvAPL6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7fLt/ml; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmkESv6jax/rVIpD1ErmXQBsj6qrZclIhB1Zz0jq9TfkhVAWDJH2gdOAEWG5yGVupcSFk9LVDPGmwXLIgVLMiD0XN9HJLiVuqH6NYoL2LURQ+JL2c6EVyichG2mQvKVDgdpwSNFZBS7Vfs4O6GRqWa66Jzk+MC0TZXH+/H6SOvAn3y5a/9AgII4f79+FPU3ls+DX3dUVndiOmMdvjrHtAsQ7qwy+bQ5dWu6wlcsgklBZQqddM0r8sOIx5ljt0OwetSVwmjfMDcrR4xux97dfkTVmYgdGB4cIu2oUdDUYu/NjYpJOqeTGxHgPSA32Y4q2ItkeZxFqifNpMa90hH7yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fkXq3gMVuPjDj7QK8FsFyXImsOaM2ioOAAOVA0t16I=;
 b=SFzNnI//bHuwcPJ+IisvF4GcyXibo34ZqlUpjc6j6UnDX5wlIU9WWV6IT7iMmgj0zpVFi0IjtqOZFY38K3CZ5RSRWocbe5BRvY2EgiyLwuI2fLHaeU1MuWUjofIMrBrdntku+0jxEpixdokqe+IwUUQiGcDoA/AHJvnDYg12IV4aDRltkFXqaBWTQBBu0O7GWRgANerCqTKkks2hTLbNVsZzOGfRU1HjnWSSPSMSf/hxbIdC2ZgTUJcx65ttVAWphLJlPgc7+tef8AxcZlgCvRwUx7EPFQr8ehRP5QLYjNvFqxb67FEQPbhLgJ8eqE7d3KxKZs7CIgDouUNwEc94Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fkXq3gMVuPjDj7QK8FsFyXImsOaM2ioOAAOVA0t16I=;
 b=B7fLt/mlDk/JVUYCQi7A5oVt3WzlKT/7ABV8LMLqV181U9Zz+SufdS4bMscK3zGNAGdJxc4WDKxfKg6sQZGJrgfkIs1+c18P+wiQYOiizIs+PeAPgQqbo7tX8KCa5z5PXS7q1OOamDuIzm4j54dZpqrfPuFISo4+3iWjHEJvPuiRWhLUO0TK8sFB4bU3SSgO60CtTHwUMiMpRqPnv8BuSk1vvkal01fQyGn8SHRT0c0x/mmfuWQ/Oj1l6kys6XUYC+IKTy66tlJy1TI+2FYBC9mqsi1w7++GKq93kWJADHjem9tqZn/2InVTs41rJAWFkVtfZFDURQDTOEw8V41X3Q==
Received: from ROAP284CA0133.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:42::6) by
 CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 21:24:09 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10d6:10:42:cafe::73) by ROAP284CA0133.outlook.office365.com
 (2603:10d6:10:42::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Tue,
 17 Jun 2025 21:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Tue, 17 Jun 2025 21:24:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 14:23:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 14:23:45 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 14:23:43 -0700
Date: Tue, 17 Jun 2025 14:23:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <aFHc3UujzDIfmKeT@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
 <aFDMoMX8eL7azoUL@nvidia.com>
 <20250617115948.GV1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617115948.GV1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0476c257-efd1-4ae9-e044-08ddade54b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE1GYUJDMjZyc1RIaDFGaW93anRhbmJLQnVnb1FXUWd1QkRGV2ZNVFh0T1g5?=
 =?utf-8?B?N2JyTVRGOVFoam9kSWEvZzg2UmtrVytFYXVDZWVMZ0hpaEVmOXhnNHRJTlBr?=
 =?utf-8?B?TWpRbnU1UmhFWEN5WU1yZ1pWc3JJWGhZWHIrcXJWaG0rNzlxQ2p2QUV0Nitj?=
 =?utf-8?B?clh1M211ZjY1R0ZlcGI1ZTBQOWFWcVNZUEk4RnJiOTI2OHc5QjFOM0ZZVTQ4?=
 =?utf-8?B?cEhtN0xxcFVNVWx2WnNSNjFTUHhHNi82bGd4WVdGbTRXYTV2MFZYOG8yekVx?=
 =?utf-8?B?Q3BGYjcxRFBYNFFjd2ZaemwxY1B4SGx6SDBRZnFhUk9XYVk3TGxkbEZJaGV4?=
 =?utf-8?B?NDQ3aGN4UUdSY2p3eWF3VFZFZ1JoY3kyME8zc2ZsUUVGTUo0WlhjYzRPKzcy?=
 =?utf-8?B?Yy9uTU4vb25Id1ozK3ZXT21vNVZzcHVLQmlUbit2M00rWVV1SU1vSHBrVmdr?=
 =?utf-8?B?UG9veWNSbmRKcnVJTStYVm9pbUFoNnZNTFowY0dwaGV0RHZ5ME1rUGpoU083?=
 =?utf-8?B?amJ3Qjh6Vm44d25tMkxZVmpzcDYzcEFOOHJnV2ZjajJFNUs2N1VtQUJ3V3ZE?=
 =?utf-8?B?RU5YenF5ZlhNL2JGU1NxN1ZjaDVMbDN0dHZNZU5ickJ3RjVwNUJWUnBEcGZH?=
 =?utf-8?B?Lzl2UmVFWlZBQnpKeXVid09mYVJtWmcvdHR6VXNqTGhpRWk1NERZYVM4eU55?=
 =?utf-8?B?UjBsQW4xcjlteDhGanU1Y3pMUXRRaTlHR0pPaXFaajcwWGdDNmVFWEtkYmpK?=
 =?utf-8?B?U3EyRHFxN0YyaE9zM1BYc1ZGMUxpdDBCaHhUOVVqU003V0Z3OVdvb3BBMTAy?=
 =?utf-8?B?T2VRd3o4YnNiT1UxU0tsTm9EZnhSMnJwWnoxMG5VTjRZRmxlOHpEZXE2WXRZ?=
 =?utf-8?B?VzNtbUJ6WnE1TnQ4QWlNK3oyWHhQckFOZXdXejhTeDI5ejZTeDhvc1Z3Tncr?=
 =?utf-8?B?TGR3NVA3R0puY2dyOXErQ1dvNWVIR0JYYk5PWDlPWlJNL0NBRVBRcUVzdXV6?=
 =?utf-8?B?OFNBZEQ1QmRLU2F5VDB3QzNhTTVhWXY0TExqUTRIS2RLNGF6bHBOV3M4MmNM?=
 =?utf-8?B?VWFlMWFUUkpUelNmSG5EeHRuR1ZaOWlIR0hiM0pvTkFmMDBCT2YxY0pXRFpD?=
 =?utf-8?B?cG9ncjFwQkFEWjZDaVd0bElqVGd2T1NnNjVuUVpGeDhXeVY5Ni9IanZmZlcy?=
 =?utf-8?B?SFBGdUJlZ2hBRFRTOEdwOEhGZlNjTFFSRDJYTTgyWWtxK3ZCaXJXWk9QbGk1?=
 =?utf-8?B?TXcxVm1yNXZuM1owZVNrejBnQ1VkZERxQW5LRzlMMDJTaVROdXJPOW41N3Zq?=
 =?utf-8?B?ZFdmem9sTG82Z202M0NnZVNOcm1ETHBEOUxQNHFWVjBtemx2SlpsVHFSR0o4?=
 =?utf-8?B?M0FIelR3Mk5od3J5R0tqSlVNOTU4dFFzdnVRN0dOYmZGc2tUSVdOQ1JJbWZY?=
 =?utf-8?B?bVQ1b2ZVZG53RjlIWjVWa0czNWlJTG9pOU9QZmtPZ2FXeUJIOTEyNFpuQks1?=
 =?utf-8?B?Q1hRUnBZYzlheWtEenpOMGlzYXBRYnBRd0FVNnkrUjBhMXdBY2hocyt4NnNC?=
 =?utf-8?B?MkdtakQyUVlpcjVvUGNsSmt4a1M4eHcwOENxT3U2TlZVdUlScUZ3QStwMUpN?=
 =?utf-8?B?ZkI5SjM5K3N6LzlFdkNGVkFKY2hvanVHaEhVcVhQOU8relV6SmFQdXNmTWxi?=
 =?utf-8?B?UHhyUG9wMUg4UE5HNU5PQWUxdTdkYUF2NVNqam1Mekg5UzlmOUNRM3VTcjEx?=
 =?utf-8?B?VjZNWFIvdTZ1dUdTT0NRQ05NM0lRNEM3amNHbkNDOVN6RVpjZW5rNkRMN2Z0?=
 =?utf-8?B?KzdMWkQyQk5zbGxiUk5qbkJBd29XUUppd1VxMFo3Q1d6VXVEZWJXcHdraGJo?=
 =?utf-8?B?SXR0M3l5aGx0RmZwNkk5VlBFNU1qbGRPTkV4Vk1kclhhSUVpNE1nQ3RhNjNn?=
 =?utf-8?B?TFdGTDY5cnZST3ZhTWpBajI5bUp0czF4U3daVE16T0JkaUJKNmloZlk0SVF3?=
 =?utf-8?B?a2k5ZE9rV2p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 21:24:07.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0476c257-efd1-4ae9-e044-08ddade54b2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

On Tue, Jun 17, 2025 at 08:59:48AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 16, 2025 at 07:02:08PM -0700, Nicolin Chen wrote:
> > ---breakdown---
> > After `posix_memalign()`:
> >   [ posix_memalign() memory ]  ← malloc thinks it owns this
> > 
> > Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
> >   [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
> >   ↑ mapped
> > ---end---
> 
> Yes, this is correct and what we are doing here. The allocator always
> owns it and we are just replacing the memory with a different mmap.

Hmm, if allocator always owns it. Does that mean the munmap() [3]
will release what [1] and [2] do (allocating and replacing)?

[1] posix_memalign()
[2] mmap()
[3] munmap()

> > // Step 1: Use posix_memalign to get an aligned pointer
> > if (posix_memalign(&ptr, alignment, size) != 0) {
> >     perror("posix_memalign");
> >     return -1;
> > }
> 
> Also no, the main point of this is to inject MAP_SHARED which
> posix_memalign cannot not do.

I see.

> > Instead, it suggests a cleaner version without posix_memalign():
> > ---code---
> > void *addr = mmap(NULL, variant->buffer_size, PROT_READ | PROT_WRITE,
> >                   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE,
> > 		  -1, 0);
> > if (addr == MAP_FAILED) { perror("mmap"); return -1; }
> > ---end---
> 
> Yes, we could do this only for MAP_HUGETLB, but it doesn't help the
> normal case with MAP_SHARED.
> 
> So I would leave it alone, use the version I showed.

OK. Will respin a v2 with that.

Thanks
Nicolin

