Return-Path: <linux-kselftest+bounces-34838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9FAD7AD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 21:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31CF3B1D0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25E279798;
	Thu, 12 Jun 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXvLchgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B72C325B;
	Thu, 12 Jun 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755024; cv=fail; b=HaVmW541DFajGBtR+IshSnZW22C3O977eN0p7tyXGhBMukDpDHQQ9o/HCoYg4x0XYebY0FkmhbVJ7H0iv7yhFWc/LN4QNZB9BjJjNDl/fVT+ZrLI0GATYNFQ9J03HV6AiGcVIWXMewt7X3933ERJO7PjKy3hqyRd1uOLoqXuUO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755024; c=relaxed/simple;
	bh=9y7LBmjuLN5oAqOEc/5bgtT/IegfHIbLNX0hLCx0mxs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZS5Q73vhPcg3F3zdISIPHcuEnp3Ni9QJ40LvZUYCpdiJ/+398lkaT3nE3F5ClWqgIpVOfH91YF8WlVV94N0Hx8cxkEcUVb7rK+wII5oAwsYLYxCqSLZsM9xkv6VMpvFVHRwCSHi2a31CXrjIV+1EYqB/NKiBmeKENWSkMsKYkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXvLchgI; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8j/LdfpKOG0cBnLMcNGhHetbaz4awRvAnhk8GduymKpX5H5Szh5dFsnJmRRsH80MOg34rLo7QDoJTzqYjkoZN/B59/ab/rt1AoCa6ZPReeuZo3AqCGNLOgMyFFHta28beuPj/i7HXG55tjCXLy6SAKHnnQ4wLGBBHeqccm4c5FVKcnfMyJM5V3TErwisCSEEyrqAthw3J9sexYMgO0igAjXvi7+xAvQ2N6qukNtzz051Yq82XEB+1YGXG9WSyXdHFJAKDxsVIRfx6fw2hf+DyxZH4JWf1F24PIqpdnA0k30UaVIODSio8Psb8BQWfOAmvLn+iTKnLrPsyF+R0BPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZPdlS1rQ0VvIRt+i4YQIF0sgZYmqbfMuuc+llMdQaE=;
 b=NmKwSRquWSGaVUgiBEp79bdI+j14FoNWuvjptk9H65+dI8lizlr0TxfJ8cgFhgMeLRjvIUfppQqD/qbKj4ZnUMGgSFIB2z0jeDALBsdOT7BMQyjsmoqj5K/5wJw10Xq1nqsQCl91jMx2ia6gOC9+CCMRlc/cZEMNx1fSUK1rIMgzFfcFO9NRFmtaJ2S6JoPGesMD22WKPhCH4miB5Aqi6bMa4h152i1l2ag41WIQGN3Ut2rjEyHeItl064CoTIPRa8ugTrQynSsHNE0g1Zj1DG3deNphmnqD2PSCEYqsXPPZsMqgIfalGf3BfBpjQlLH3Zifpv/Oum92iQXC0HRZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZPdlS1rQ0VvIRt+i4YQIF0sgZYmqbfMuuc+llMdQaE=;
 b=EXvLchgI64H324uZftH0CUXDENAKgsQKBFw9uy607wNYebYkntjE7ARq91+Wt+JqRQQG/QlYk6ji88hdIdtqna48C4sbTLA02V/t7qPCUoZFlAtlqfsMiOv2o1Qh/XlJY5RlqT8gd7soa/G2qP8rYCuiz+h/dORk0RqtJ00tsjaXSGUFqKLV80B9jKQdU14OPbx01gNaIjQrogHFsqEzTM5hFjfuLKC4JMET7qpxjUDoaAL6QMSwgEQp+woznmpgudiPOodkZyZtUNDF/IxCKxx2wFMavDVVSwiMWwx/XLkrmGWaDBDApqzdGNDYiZfEqpbERi3B9kMnGEcOnA4y1A==
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Thu, 12 Jun
 2025 19:03:39 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::12) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Thu,
 12 Jun 2025 19:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 19:03:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 12:03:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 12:03:20 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 12:03:17 -0700
Date: Thu, 12 Jun 2025 12:03:14 -0700
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
Message-ID: <aEskchlFcNL3T6sO@nvidia.com>
References: <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
 <aEsUGP8xPTDjG0ob@nvidia.com>
 <aEsiJFku+wR9KxE8@nvidia.com>
 <20250612185613.GX543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612185613.GX543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 55034f0c-3173-4384-8b1d-08dda9e3d76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERcuyYppuELCD3x5oiWrn1NeHO1U6F+J0KWUDdlLuPHuOgT3hSvSaqiYjv7V?=
 =?us-ascii?Q?HO7kGceMTMCbXZjWPUG04tnV28QbVqpGCKo/cxX0D7bJQ65EJRyErxvBfKGa?=
 =?us-ascii?Q?6QDyrfMjnF2xWVoZChRpNpyevq6WUNW42WjAZH/t9xsmDrQs6CLKitH5qqpi?=
 =?us-ascii?Q?rfiapQkYt+j/S+GS3SclxjwBfHcxjdvIuwGbHA47ZbIZYfEWfpXiNJoa8eT2?=
 =?us-ascii?Q?nJUisI4UoJM+u7iKC/7CfTdWNjPndIU1r5lIBct9kjV7JsQA6LI+NHqS+8YL?=
 =?us-ascii?Q?Xc3mXzyMYKOSrGXcFtqEx5cpANDh0XX43ZJZ+0ydh7HqbjcaF2y3/9SQE8u0?=
 =?us-ascii?Q?MQdYKORGAkeHaFs4jqai7I0Ag7zXtiLYtQiMhK176XILhe7cc66eABj7Z8A1?=
 =?us-ascii?Q?hRn3RMp1P2mTDuWbpHyXjSdkbEl/0IVHYB/VNdeQctXGDxLZlSU6gWdC0dh5?=
 =?us-ascii?Q?JVL7hbZ1vSY/QG2R1Kx4feEFHULm4ZmHtJG1zEvLHtzOQC75cABOEDHWq6TN?=
 =?us-ascii?Q?2vOw46X9xLIKNu41FIVS4L9p525hp6TOykdnd5vGaaL0oUjbUDSsBxeq5gPe?=
 =?us-ascii?Q?gmcrsLoO1jf5zPJkWST0EE80cf3co2lF4+llLqoAn8NPz2XN7p4i+LEQeITh?=
 =?us-ascii?Q?KR9kLUlfOffdNdjvImhVXJX0UT0QnEENB9bSn1Mow+w5nUb1DLf4nrAcFgwL?=
 =?us-ascii?Q?vC/bT0upFYlLMYodbFOS4fa/qJsdoui1dx6cu3pWT7CO6iQsUDSxN3BbSw1h?=
 =?us-ascii?Q?7qFxIfeEwPNV7jZDY2Pm6n3XsCNPGOEkTzEXxhVDeG0rAy5SdJp3qC/OxsZf?=
 =?us-ascii?Q?tmgPMslDFfxWpHTV3hxCrOyCbuYgxyaRBFEJmacNMnRodNuq+4auC+grEfWu?=
 =?us-ascii?Q?thUGaIn4mNKD5HZtzi1oIudD1tGyI0+tdSePjpwu1R4FKBmeezq/GNpxUqn2?=
 =?us-ascii?Q?+GPu7sA4vsJLtUhZuBCpnjqhDkyI8GeQe7j6dt5DPc75sWdMJrcU3jkGvKZq?=
 =?us-ascii?Q?C8IwgY0mi1TU3U3qfpjF/91PkcDkKmL+vCSeFtWcQiyWAcnSF9eUCNj5YHwY?=
 =?us-ascii?Q?mat2K9BUYsvwPmA2WC9gNZBl69tpvK5iwpHPIuNajG70e/9gX6JSqwxj+iaY?=
 =?us-ascii?Q?yVZ+y18h+2sKtQNUkbS35uOOaAoegO3cdMqYugjUXuvfXWdDp+7XBMSP2hWw?=
 =?us-ascii?Q?D3OIewM8e8c2IEZ3vnpysySzn/gpxUqV/lRi96112Ci0oeIEhPxnl0++z84l?=
 =?us-ascii?Q?1j3yZYZPekKqgbP/mSj9U1EtZU9jct/3WDnbJeX/RCRlhYWrX6ya9AketAnY?=
 =?us-ascii?Q?U+4Co4jnItt6oLaR2ehBIGfHWBsls/QgWuof/nJkjfZYAUZCdp9Ly4r/veqM?=
 =?us-ascii?Q?1dSBgkQCKPZuBaVYN2UFavHJjlLBc8c13erSEJHPlNFIDxxfNP15wa3UZdwF?=
 =?us-ascii?Q?xOykxNgH+ythO2JaimUuECBnPgOxxmsFTBrWRxCw1vfd26BQMdWCop8iSTs6?=
 =?us-ascii?Q?XyioI0GG80zv0Sr2W1n/5AncH3X4jTSBfKjT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 19:03:39.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55034f0c-3173-4384-8b1d-08dda9e3d76b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On Thu, Jun 12, 2025 at 03:56:13PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 12, 2025 at 11:53:24AM -0700, Nicolin Chen wrote:
> > @@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >         self->fd = open("/dev/iommu", O_RDWR);
> >         ASSERT_NE(-1, self->fd);
> > 
> > -       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
> > +       if (variant->hugepages) {
> > +               /*
> > +                * Allocation must be aligned to the HUGEPAGE_SIZE, because the
> > +                * following mmap() will automatically align the length to be a
> > +                * multiple of the underlying huge page size. Failing to do the
> > +                * same at this allocation will result in a memory overwrite by
> > +                * the mmap().
> > +                */
> > +               size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> > +       } else {
> > +               size = variant->buffer_size;
> > +       }
> > +       rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
> >         if (rc || !self->buffer) {
> >                 SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
> >                            variant->buffer_size, rc);
> > 
> > It can just upsize the allocation, i.e. the test case will only
> > use the first 64M or 128MB out of the reserved 512MB huge page.
> 
> The MAP_HUGETLBFS is required that is the whole point of what it is
> doing..

I am not quite following this.. MAP_HUGETLB will be still set.

And the underlying selftest case is using:
	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE

Does it matter if the underlying allocation has an overshot?

Thanks
Nicolin

