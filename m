Return-Path: <linux-kselftest+bounces-36799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101EEAFE351
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC384A406C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A327FB12;
	Wed,  9 Jul 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ed4zSRwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F0237713;
	Wed,  9 Jul 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051402; cv=fail; b=j1pVkktw63muyYAWvB4qr4OIYnr7NW6XmOt/WPPcdPEOAcibaqn8Wlh5G5eLdSTXPnEbRy6k/vSX3MHgklvl4YcamXEOFuh7c92G1e0NNT97nWFSbZR7jl8n9+u/WSMR6MH1RoDthSc7Z2AfxmFQBjriFUUlU1yfvFPdlmSftmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051402; c=relaxed/simple;
	bh=Faqzj0UzcbKeMFcUXGSAKV+Bgz0NH4WeHcJ5wvwnqvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEK3urcYmDODjvk6XuBz4q+nRHGdHSZlbLXQwuKggR9SQ2w9u0+Na24YB5lS3Ss0UyZ+QnfN6gDEiWSfsnA6v82akgUvS1gzVJ2Mqtx+GJ+Cv8Iptmt1ST1gw5U3CCQ7A81frYjdvKPBJ48Aq/YTOCjhSY4bRsHaEJlvVsavLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ed4zSRwD; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM6uydJbqAdr8/v2Z589THIjemb6UNJ64YZtAkQlf6/ULLHcSAww/z32dIpSYfDX2a1O1ye54Tu4/5cdVepJdXJoM4HAtWSp+D+4mJj/VvG+v6SkoPMhup/r8BADcctN2Uw8e335IAlysBuETiHKifJeoxl66aLvpsLySJpuirTEKGTnvHim0pm0eDu1BeE/c/JtnyxPdXWwPvW9BoOCTigyxSRc3DsJSSUHz0oLEOT9cfii+VQ6pxYPZ7XI8h9g0bZ2IHVT+KISLFpm2b2bjbZQa0TfIp42eEYYyIVJcCvASL+HIjU9wqsGvwk9ZyBSgS/3MPWHOqroC7Z+j7KVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYpNQw3z+Vi231QIPS94sd9NCTL0Aht5ZV1vQ4NWRtg=;
 b=Cil6x5sAKMIUAqdIPEgfwAQ6jwJOocZ+GZWkvODUJQrFifWaUg1ZLhC6mquubE9eBjzn8QW1WDXObgPXb6N1sBy1c2FrLL5D42pqihJhSESTSk44fk0StKoYtTdzrf0MjRfW2FJ/sXHmHZLTiWktW7J7JGT6eEOPZ/0KJNc4J+xOgrdzJ58ZKoA70lF8WHKTj1CqmT/S6CtcJVL6VrjeHEUcmcnVc2yeTBvNUP7D4bhyhsgKa3ahpKmlVxOWEwHYfv5wjepLBS5b1TOra0DrTmFTwyZ8pmX2Mq+9ScDCjHL9yqVSYpgZr92KpjkNv2fC+uDwRYUdcgS1p0tTH/GfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYpNQw3z+Vi231QIPS94sd9NCTL0Aht5ZV1vQ4NWRtg=;
 b=Ed4zSRwDYm9x2TvrlJaLJFQ1/O4hDtCgSLJVw4oLnbyhWCAE/X4MHhQoNbWK18alm0gMZkectT+6z1b9ER9+iKrvpsgUhF9B+aMoTYBGLC3SX/ntIVsVg7KkOplqI4EsHFukh0fjt7FGzHoCg5g/5ujUEBEy8lbQMSVKtA3Zzt4=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Wed, 9 Jul
 2025 08:56:37 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::6e) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 08:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 08:56:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 03:56:36 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Jul 2025 03:56:30 -0500
Date: Wed, 9 Jul 2025 08:56:19 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <6onfcdqxaeq55fd6csdyovudfbx2f3baimonejkmgisab23os3@fzj3mjelpcob>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <15-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f91073c-0f5c-4270-5688-08ddbec68335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXf2ZWuP1/We4DSTku25fisGqDSZn+Ox8XFIFivCnjln3+Kky95VIgZ/QmWm?=
 =?us-ascii?Q?K1xw7DQPhxMK8uEVd9bKbztkoAOk7go09Vs93D+IXHoa8fC0Pq1pk2HC45Yb?=
 =?us-ascii?Q?NXguWIwmtBn5TQN44Q+tF/5bkLU2XXt2t4iwYC9ZxIQq4qwodqOjmAp3Wl0E?=
 =?us-ascii?Q?kLKRjVmdzzmV6BWNkOBaOIfs3XbDtizr5VfMFu6SfKzg0wivHTFukx/qpMDL?=
 =?us-ascii?Q?aktfmIo2DHL4/07Gt1xdDiNDxW+jIeV7ZOEQgk6kMj6V644fVaEc5anxoEEB?=
 =?us-ascii?Q?u3BDIroJEu8Y7LyGwhyP2x3AFZiTAEgR0rAHWYv3zXjkkMtWm4Vq6rNfCLP2?=
 =?us-ascii?Q?NmGDMpceMc40xn9OoUyzLx+H9qs1UY0zBvi9It7jlCVzWTw7QprwIZowkDqh?=
 =?us-ascii?Q?10Orz9lPPNHfsPF1hFlCm9K9fRIsjS3hKC9LFf+lGflem97Uxrjoh7D7/pGJ?=
 =?us-ascii?Q?NCMhB9qayb4Pya6+taiJDD+XX1Y/AXmWhOgvX7UXvB1rzXfJVxrXUPR8Uyir?=
 =?us-ascii?Q?J8084h05q2YKMgUUTjpTAcmUEEQF6SOauZNVJTSy4T+cWfbl46LW5526cvC9?=
 =?us-ascii?Q?OSmO+zbNY3oRjOBpnYR6ixMz+A5DK5IlkE4wZKwEL8f/ngAE3jDuisy4HxRk?=
 =?us-ascii?Q?wxhciKKypI/w6dg7hJgj4au7sYm+VsfXgl8YrNaAtZbIKJGKoMOVkYb2OwHx?=
 =?us-ascii?Q?eoCW06RlPc9v69/lLrRbHXBo9A/2T9a1B8jt9DZ8Zp50aI1WyfbxSYRJobZu?=
 =?us-ascii?Q?8rNY9B0JuLIL3aW2rdaCGOoHyMnJhUYtIOY8V7X0Ntb1t8H/0uKqhNMPyRsk?=
 =?us-ascii?Q?09edDBB1OgI/+N2Xk8NW7N9ihk7L9FY53iqa7PZ0rZjFuM2TxIzCdoypa3e5?=
 =?us-ascii?Q?BAiB4SXpylM4VKtQc3ByILTAol/ucLE5asTD7pXQLfcvw4jXUyOYPVceKhXh?=
 =?us-ascii?Q?ycArvbzLhlQXep/KJPs+IqKAJtPD9UBgyTdHMCF6RDyVvLS/+iG85z0aCQK6?=
 =?us-ascii?Q?8v2e52Ryhw4SDFjDsCUMpEtYRlvNEkv9eQXsTfxMwAHDIzmVTql7DJIG93vK?=
 =?us-ascii?Q?iW3g2K89MEMN/g7lRolkpIct8I6S3mTEnzUrVQIuVoON1yl8qwQKsw59CUM3?=
 =?us-ascii?Q?zWF+PSGik1ILJsLvxZZG94yf84tFaXU4MoAss35vp02Syk8HwO0iz+Gy0AOC?=
 =?us-ascii?Q?7WlmvQXPuKZLy/GSVoXnAEvMQFJTdl5jMjJdmmRakDWeG00tJoIVmx/ZUsA6?=
 =?us-ascii?Q?aEZPqmO8VIrJjS56m214p46kQLOjFToA5N0s5r2ua9m53HmmEpX4VpmJSUA/?=
 =?us-ascii?Q?SwIIMNCuAs6/ksPPDuMArOWVfBykOADrd1sdSOeCrdWbnJan1yGDF+8RBy6e?=
 =?us-ascii?Q?s5cuzP9tpqxf2/Ptf+QVy6pYcpHpfvzlM7tXDxX289d4E7wrsc29hAc8vPXG?=
 =?us-ascii?Q?+wghv8LPZrVyG8oTqP8C+wkvXTizw2+sXezws4rdwikMF5XxDUU5QNUkRcWF?=
 =?us-ascii?Q?dCcn4gbW6vQkgvmnT+Su5Qx4Ahpg4wwpV6Il?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 08:56:37.0052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f91073c-0f5c-4270-5688-08ddbec68335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105


Hi Jason,
I noticed a few minor nits that might be worth addressing in a future revision.

On Mon, Jun 16, 2025 at 03:06:18PM -0300, Jason Gunthorpe wrote:
> This intends to have high coverage of the page table format functions and
> the IOMMU implementation itself, exercising the various corner cases.
> 
> The kunit can be run in the kunit framework, using commands like:

The kunit tests can be run...

> 
> tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=100
> tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y
> 
> There are several interesting corner cases on the 32 bit platforms that
> need checking.
> 
> Like the generic test they are run on the formats configuration list using

how about "Like the generic tests, these are..."

> kunit "params". This also checks the core iommu parts of the page table
> code as it enters the logic through a mock iommu_domain.
> 
> The following are checked:
>  - PT_FEAT_DYNAMIC_TOP properly adds levels one by oen

s/oen/one

>  - Evey page size can be iommu_map()'d, and mapping creates that size

s/Evey/Every

>  - iommu_iova_to_phys() works with every page size
>  - Test converting OA -> non present -> OA when the two OAs overlap and
>    free table levels
>  - Test that unmap stops at holes, unmap doesn't split, and unmap returns
>    the right values for partial unmap requests
>  - Randomly map/unmap. Checks map with random sizes, that map fails when
>    hitting collions doing nothing, unmap/map with random intersections and

s/collions/collisions

>    full unmap of random sizes. Also checked iommu_iova_to_phys() with random

s/checked/checks

Thanks,
-Ankit

> -- 
> 2.43.0
> 

