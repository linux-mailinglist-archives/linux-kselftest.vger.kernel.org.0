Return-Path: <linux-kselftest+bounces-32437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D1EAA9D00
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E13BD85D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB042701CF;
	Mon,  5 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFEsnu4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B625D539;
	Mon,  5 May 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475719; cv=fail; b=mDA3d/9eTNBUYXptN4uUswwb+i98oiRcSeicQk3BqayICcZuK6g8xQ892jiX4quA34raCDZ0sLm31+PTODTVpQj1Icme8wGthOouaYDvFEYFX8XAyT+YBqfN4/7o33CDwi7qs7XSLqCR4fjzO6cneyTlPzvNAQsRhlNjnrOFQ2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475719; c=relaxed/simple;
	bh=W6476yyJ/96afJZKXoRbZ1cboZgfGLgHZyhr0mn8WYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4lcH9m5BfVFdQNAf1cf6yUyhYynAmHt2AtT9mb4/7/t82csDLtWgawCCa+YcxpFKVxH94w9wqFetCQXKzstnXuVenhs7BvlIhjoNgGwBDxlWxlnR+v2GZxgI5lyaIdqnHfjUviGeIKvMmUy/tNHu9p5U9jVW/bj53ly8YEe4Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFEsnu4M; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3syL2XRARNx3aB5xrM88PvLW3+43jIgr5A92THd9c28JCIxK/mCP3W6qPESSfjkbrm4u5Q74BgJxy0UXIQCbSjaleIn3dqMgjyNBpqeEthZNRxkN7ErLTYcsxEvfpTuReayx+bQCD6SlI+AX+3i9AeFpOHuhzfbbcZrUkoRD0RFvFIuDEUzxVfbGuA4ls1jpsTMcjyruXTtdGxLjbglYAWdVpN9R7vtXa5w0a31prLLmTWLZYo5m/VZmkEDZW/xsYnud5bT7v7L1tpRGI5plTguuEqR0Pzg5YDIkudnq4aoU8P/Qk0AGIicMyDgIESCMu9ztnaTYUJynsAzow6Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJJoV9UUsoeZjNYBuBj8UVPNtIBVXFRgRqB9BC4wL+I=;
 b=IwTY6lmfoJP12iyuPAJgYTu3yelC+nmn1ZUvjaGWVZjfn9xK7GqYeofxmXyGNh4iIW9WpeoUbMucBS/akxtFHBIbp7F3mS6oL9BbeYOmvO0f3vgoGYLEyPUUrFO4nmoywURuO1TtVY2aG5tHYLLUUqO1CcggCBPQfQn7Q0+Ejd+E5y05IuCitNovpUE0bDmCVxEqX32NcA4odIkomIHhWoIhmdMN3ECxDP2fJ01fDLGwOk/HAdxVQEH9n019gr7fOxoqKKdcw3H5FoeTlpHOCpa8sWj2KuRGnkaNh8QuleZhmMReOP1WNiujrMoioZKQ3iS7kwqPPrghPgrEaJKgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJJoV9UUsoeZjNYBuBj8UVPNtIBVXFRgRqB9BC4wL+I=;
 b=cFEsnu4MTR5Cz65NYbybwcqNw3Ul8Tqqn8tWFCLSd9ZXhouaMaMT+dSqpstD2WibD354E2oPNmg0biS5pWJycE8lVElN8o2iFQ8C+//CPftUDxrPxgR/PEp1vevHVTYbs2TzASngRrgGMSYlU2xdn6+4/LjFz6Dmjrm3QScYNJD0W+3rg13i9KXs6QqnNMwWHGXqf6BThvXO6roAbU+LeAXgk4ze0Qr1oPa8l893c3Zgigo0Go/vidwAmJ5GfvEpbXz8kg6p8Jn9QDLeZtaq3jUJOgsq7qpIWpQPXdCKLJUuityOMrWqgIKpieHTUG0T3dmb07CztcwHSph33XLTWg==
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 20:08:31 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::e) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 5 May 2025 20:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 20:08:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 13:08:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 13:08:13 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 13:07:44 -0700
Date: Mon, 5 May 2025 13:07:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBkahmXQGxFC0Fdw@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505172813.GS2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d72e028-5bc3-4427-27b9-08dd8c109b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qJ91BnoVrz/HUFEM8SsSTbVUkTyTnPxZlYavrAUtvMlflA33dKFexF7rIlS?=
 =?us-ascii?Q?xqIC7KuaIc050VbqxfoiWQ2LgRaWCS7FLtGyh2N8U4Vu6Rfy32eLRPH4wR3S?=
 =?us-ascii?Q?cav2IAceYnRhYxdYBm0hW/k8QzwidSmjEfY4bjWZbbFtmAq2Rd6ugYexdts5?=
 =?us-ascii?Q?dbyjrSEi3hNnu8oHGJLECLnry2s6WM+E945AplMEACO8o3OmFW5Pm/W1DnYY?=
 =?us-ascii?Q?N/YVB/ISCPcgF05iSQsk/6UR52nDM22UKgd8pawtjTIGYSDZ8TJ4NiAK5kWV?=
 =?us-ascii?Q?0Gnicwy5GrmdnMrHSUwK46uaAvvB+v7ALpf8Sgy8Ii9j4GKDJpCHt6rZ+ZVR?=
 =?us-ascii?Q?mkEAP720C5fGj4GCgcAzVSXYQmdeaLtmnDj+OfBtqe+buGZB2u5KdjjE0Oya?=
 =?us-ascii?Q?SKJjkC4wGllPKkYouYk9Rmh1cNEk/h5umU/8S0OZweqDweNz0cdE/0e6b71F?=
 =?us-ascii?Q?WJxXgOgoKoGNWmYBf1ewrc3bsM57IM3kTMTp5xchQR4Zdhu7QpelM/R/hy/6?=
 =?us-ascii?Q?LSNIQYPkehvSfrLhil6/tm0njqQgae1QGYuE+hsBQGeAQWzMUfBOb7pLdAwW?=
 =?us-ascii?Q?qfRLF1By4WjqDdUUjsMUwJm6c9+N3OTaADzBrsOK86bLGlwVIlc4lj2DmwK3?=
 =?us-ascii?Q?YpMmZ1EXgJlP8AX+LF2SFvwpdBsLB3IecZ1zfykyi5EoRBoxuXbRTiHAcG/5?=
 =?us-ascii?Q?Wd0hdw6ARrsIKEO/YUx+OHoH/5aBlqM0G8PkImh3SeOxibubHUE4h72tXIVR?=
 =?us-ascii?Q?GMiS/27L7AE58gFS4mAbgPBgQPoiaun66zPWtmZP7BlJ6H0nrKzR61qJJ9bi?=
 =?us-ascii?Q?R43iQyVsmWSAGo4HRKFt5mQysMKBUmu87pg65Ru0Qg36zBdAqtfQsLfwEj9e?=
 =?us-ascii?Q?fIT4aYxmpAKDNGvMa6JVQdYUGHW4fMkNzCTPGwkKhunCIg3kyQthwUP+H1vn?=
 =?us-ascii?Q?ThvWGzLLRenG4GnwnPgvifAsZFTCCSeFFwYRogUSp5cgI63703r+pJuJWEHU?=
 =?us-ascii?Q?VpHTzaX5xAKleBN/A5rHa81WO78sguqcskUPBiM1acoksUHsM3Y0Y1bQL8RP?=
 =?us-ascii?Q?NGhlpsvtUwY1UXcO45cS0Ci0U5Fss5ZxU7ZWaMycfv+LZux1PahqzMz+PvhN?=
 =?us-ascii?Q?Ew2BS94aeWNWk4bE+phCSoxicVi5TFLGKduiZAfgRY2cFw6US1XyZhyzU2Pf?=
 =?us-ascii?Q?E3POKFuTF66e0xM7NKTsTL/wwF+vqtLkArq/N2IUdS33wSY+nR3Flq1H4PMp?=
 =?us-ascii?Q?ljmQrG/HXO258P7dYEJVVwIYwfKOlafzXkGvSAlcRPWxKycwmX+ZZaH6i18I?=
 =?us-ascii?Q?ewpBNAqPFxBoUyVFAvlxdnSIpcd+LlJkpCdXebMNLVeYU9eD7uD0lcHSNR2B?=
 =?us-ascii?Q?1YitqY6zJbb+2q1PdOQddwdfQqcv3GG1DtuqNunEWaN8y6baYsfKm8FfCMSx?=
 =?us-ascii?Q?HCoUtR2J1gED+GbijMN9/50iBpmuzVcU7b0DLYuQDHwbaIW95thT8i3yrf3q?=
 =?us-ascii?Q?cRuGu4mqI5UNCSAMPadiGeu+YK8CfJVxTsv9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 20:08:31.2064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72e028-5bc3-4427-27b9-08dd8c109b91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

On Mon, May 05, 2025 at 02:28:13PM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 10:21:03AM -0700, Nicolin Chen wrote:
> > > > > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > > > > +{
> > > > > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> > > > 
> > > > MMIO lifecycle question: what happens if a region is removed from the
> > > > maple tree (and is therefore no longer mappable), but is still mapped
> > > > and in use by userspace?
> > > 
> > > I think we should probably zap it and make any existing VMAs
> > > SIGBUS... Otherwise it is hard to reason about from the kernel side
> > 
> > I added in v3 a pair of open/close op that would refcount the
> > vIOMMU object (owner of the mmap region). This would EBUSY the
> > vIOMMU destroy ioctl that would call this function.
> 
> That's no good, we can't have VMAs prevent cleaning up iommufd

Hmm, would you please elaborate why?

> objects, the right thing is to zap it with invalidate_mapping_range()

Also, I can't find much info about invalidate_mapping_range(). Is
it a user space call?

I do see a few drivers defining a fault op in vm_operations_struct,
where VM_FAULT_SIGBUS is returned when there is page backing up the
VMAs. Is it what we need here?

Thanks
Nicolin

