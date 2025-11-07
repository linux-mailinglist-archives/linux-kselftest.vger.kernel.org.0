Return-Path: <linux-kselftest+bounces-45140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCCC41281
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E7854E4E45
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8F3370E1;
	Fri,  7 Nov 2025 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fg52mxGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8276223DD0;
	Fri,  7 Nov 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537996; cv=fail; b=tHcC+8w7eoF4Ui+VCQuea57ENd6fewzUsO5Tk/FHT5wki7Js1cDe1oCPQFxA3NRjraJQq0jtLq36NTCO8Bu95P4utROP+x/eJ9g4XosWGtxys5QYSqAo81zRZdPdBqiVk83KTvJBUdb4jAm7HAwqf9xxAXWrY/MwuEs1NnFg41c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537996; c=relaxed/simple;
	bh=dCCsAY3lXwxJfRVpvpHOMtx3ashRAP5aa5nsgeMlFnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDjYN/3V62BMbONeET+mrRBCjcvrtAw+WK+6JuHA80uwAk8/cOyOs5xullR/mxlwKQ7kat3O0r5OGYlr8WN+CVnUNL0sRzsfezAaPr5jILeHG2kB4nyUt1iYrdYCmzIBeUzo8Z+G4+9II82rGXgZhWdG90nhxSn0aONI0xvqOoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fg52mxGH; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2SKIqQUIARAu+C1QqVCgbptpQ9xuaazEjU4oJRQ9XZqA5gV9Ul+NP4NBFlQW3f3shi6F80gsHiyHhH0Piky9bCIIgT9pLXVbJqKyrj+35jPA7qhjBijmSvUIKmIoCpfgbwZPL/C+qcEN8vD4NUHURBiRB9A0j2Y0Z9AVslmdPG7BTW+eV8IJ40G5Vmh9YSNFX9q3d+rh4lEYDrq9qMdLkARVb+CyUH+1vljAnBONTDPK1HNJAbe3sao22J3/lN9vxGJfyQAtb44ND+O1Gf7s/IBBR12jt2n3U9wT52tDpyKU9yX4dgkFPIF8llWYodXQ9eb+UWBNyQF8eT5JCVtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY7noPUHA4SbRdl6rgASjsCdr+Huz31vC/2Dvp53Xxs=;
 b=nsa+yPbvwwGWMEQlXQlV/hneQUcSSiGVd8YM625DAJb/kNl2O51Y0gckC1tIcbu1wVu/8GpCVTRwyJt+I9X2EPAlnKvDY9T+DZ32qptitUG21CFQuvcoIDz/8ApLqhSvklSfwrbwdACoDN8caXIaeC0tvgPLC4r0dMz4UHWZcta9dJLe0skgs2Z7VrEn6ig89Q2mApmW5vIgxQWP5uCvTO9Z0mFBQXSzi8BJ8e5wYlsUz7DovKcZaGID9f9l+myi4cHydbgiEnYHg4Ao/JOhKsMb8T3Py77gPL3DoDDK3vL87QC5NlRNxasr1/5EoCMu9Uba807C3IqCMrkl53kdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7noPUHA4SbRdl6rgASjsCdr+Huz31vC/2Dvp53Xxs=;
 b=Fg52mxGHWUaMfjcnu7j2GcKXa3IpBCWCAG1mATc4HqsZJx3SmN4EmLJUghuNVc8fMeDJ91YUy7x/VnltkG2U/PQS6AM+ix7yGHUyyJ8ndGKaKthQatq01oRhOLDro/zDKpTuv7M5sm5oelnTUWpPM4JZz914UDL0mW4fZfiExzIPk+qDZpusky66Eo8TPYlcpSQJUV7c8wWeldlpSsEPvWZhZsHKXQwg9RG87quJhJc6W5TXxI/fiKZY8byrHsXcVbN0FrHla3NE4aTSlSuNh2dnGu89tIY44g81IjJtdg4JWxcoiV9kKD4yQ5UTpkxa+BPdjidcfyW/R9rJiv3ckA==
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 17:53:09 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::37) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 17:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 17:53:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:52:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:52:48 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 09:52:47 -0800
Date: Fri, 7 Nov 2025 09:52:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
Message-ID: <aQ4x7UiMMCB0m0dH@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: e28cb06e-ca58-4c16-7e26-08de1e268332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fXUN2uL9Q176+BdCcdfFgIywP7PDpR8VZQMB4A4F/Al4k2QTCEf6iZQy8Yxh?=
 =?us-ascii?Q?LP9F/tugt/yn7LeHjNzOXrD9TIAYjk45r+q3ZGx4O3tihKoZkk5FrXHgpmMQ?=
 =?us-ascii?Q?VrlgxLfn+jzHSdF+r7KEUiIrTqZuz2yr4v3xwOHyiYbUolXiwSwm4ArSQ468?=
 =?us-ascii?Q?V6gsTFddsb2/nc8P/5aMjPJ0fNh0JUz5irYXDveXvVyPdFrNdPV8L+Lmum5D?=
 =?us-ascii?Q?YoGZ62jCfxLypj3prMsGUNzgKauXTPkWGE9RNySnq1W9dY3ouOywJj1okwWC?=
 =?us-ascii?Q?MjMI2OoOANBg4A6xHyb2v78v6lXbVwnb3LSmTwrCj7+QkhcuxhSRblgcE59X?=
 =?us-ascii?Q?NLtbDYctK1plOvO93yqZCYIc0fezkHVxOeCNy8SlaIYE0/Tyw6PvwbzDO8SF?=
 =?us-ascii?Q?yxRvVZ/xU4dKsj/AnNWIqdfKREHFjKbLR9DBqoqm1/OywHw2JuV3KOlyRoNW?=
 =?us-ascii?Q?x/+6VUvzZL/cunVk2rYvCI+ksdZTdrWo3+HQgMkDVpfLyUTFGdYjJt9rKOG1?=
 =?us-ascii?Q?9FaRy3htP19Kwj+HNWIDG2tlHoKi5aN+CapO48OG2uh0pVITZmSW4s2WCdtQ?=
 =?us-ascii?Q?I/OJo8dwbl5gSjxGYVgUFc3kRrN1LwJOSfaXRqOOCNZo+/qbxV+0xhUpN3Jf?=
 =?us-ascii?Q?gRUwxlQBBodVE5hIzacSOsewX9iEm5senC0wnkEuebAryaevhZcptwmRCE0d?=
 =?us-ascii?Q?CWdBlFHNTyUTn8f88RQ/dJvqPucgqfRG2SPXe/fJfF9mC9ZHtEJZPMi4vz0/?=
 =?us-ascii?Q?KVvIdtYuMdmpew3eXcMlGJvJg6Kx1+93DnPAxtnHUM+0o8wn5SIaBpNCKQR8?=
 =?us-ascii?Q?phdc9vnO5OS4G7drWVpYUo/Th26QnMhV/hMxbpnqEHPZFG6UBfe/dgqPHwaN?=
 =?us-ascii?Q?utMtWo0k/N2Fuj7wQeomGMnAuAAU74s+6tW4gRxfkbyjLtgSd9f+v6av1TGJ?=
 =?us-ascii?Q?YBfBnaN/ZAtJpnEHiEeS7C22zQ0uJTnuUrLL88eTDWv+IFAGukymKlEqIjUH?=
 =?us-ascii?Q?6x1DXI7/ykc0cPBVSZ7COizrf0+5NEzkyjWRjk/UCvd/wXymv8YtZXcH2P0o?=
 =?us-ascii?Q?hdMfdZHvYBtD7tgt/EDMFWcDIaeMgtjuxALBJw8FPnukjAnmYgduhOZltRv5?=
 =?us-ascii?Q?DaeAMUwWROEVlQ++q5fzuX6V1XYRh+zCOqlVq3lsNOmPmvpDif/Za3RD9mls?=
 =?us-ascii?Q?/lWH/L7PrxWkAm6nuoEk1lZ+OloXw1/nwWBwEtA9oXbIne9tnUoZaeogxBaK?=
 =?us-ascii?Q?99jzF6wPYLibraR/zaOcCxliyo1maNw/ISMxpm9Tt22EFHZUViYJ/gVazV9f?=
 =?us-ascii?Q?pOo4FPuPWPpAJ9oj9yg4lAs3TfSb19TEfWP3AdiQdvcOlGROKnFc/PpAsTLD?=
 =?us-ascii?Q?JIwHQGOFjpeIN7p/nMuXTUdH1Na8WiesbZRapfFTdQuuQApzyVMcqfJcsf6m?=
 =?us-ascii?Q?5ajReyl0qAuCQqN/x42/BtnbeKI5nkWIvjBAK4f4JStn5ascq/fiNM0bNgKX?=
 =?us-ascii?Q?PqRaL8eM7RDGwQ22sb0CaKg4m2Gs180fDeBSrr4T/PvTRLVjcJuMgPA5gmK7?=
 =?us-ascii?Q?huPa+gNYXQNg3EMb0xiQBjHLKd+nMawc/0Cv8xqX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:53:08.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28cb06e-ca58-4c16-7e26-08de1e268332
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

On Fri, Nov 07, 2025 at 12:49:32PM -0400, Jason Gunthorpe wrote:
> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf
> 
> v2:
>  - Rebase on Leon's v7
>  - Fix mislocking in an iopt_fill_domain() error path

I have verified this v2 using the branch above, by drafting a QEMU
patch for dmabuf on top of Shameer's vSMMU v5 series:
https://github.com/nicolinc/qemu/commits/wip/iommufd_dmabuf/

With that, I see GPU BAR memory be correctly fetched in the QEMU:
vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 0", offset: 0x0, size: 0x1000000
vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 2", offset: 0x0, size: 0x44f00000
vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 4", offset: 0x0, size: 0x17a0000000

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

