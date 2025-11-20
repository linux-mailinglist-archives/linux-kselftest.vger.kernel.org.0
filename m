Return-Path: <linux-kselftest+bounces-46133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B0C75BC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1202E2FC3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A96263F2D;
	Thu, 20 Nov 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioH1WkcQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CF7260F;
	Thu, 20 Nov 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660121; cv=fail; b=B3/RcEQTOOD1Gk3H8syWsrzQh2mx3fqG8Mco8jK7ReTrsKoiUetcSh8qoN3uuYjVWIQpD7S9bnAAFoWhHOPWNsuegkr4RTi0PWKrFHA9K2mBbCHSsvXK/bWQiD9gRN4Mx/FmYj8Yv+73XderLQ91V0GeY1DzoWt2FE2BkGbX+FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660121; c=relaxed/simple;
	bh=UoK+VOA68Ab0e8XgptwQv3xeVi7cMbw7PH741Cg+Eb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1xbKMCe4ZUZ7maA4kugYxaLS1kHpRJr2rW5EklOdMbItNxWIDe96bzui8dPL0qXrpgW/RRpC8HIB935m/LDZmHn+AVugIMgkiWnPbez9HDWa2j6LIcSuoiwCQ6nhbO1Z+qIwx1jXZM2zPoi/0cju/Ks63YJgLOGeZbwY62oshY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioH1WkcQ; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJBewdhhHx6v1AN/YcSUzGFiDM8QCKcK+8+vjwnvzlKxoVGXDYrgmbPQwES4skdt5lTFdc88QEt81o1uS4gsYF6XEkDittghgWza9sQ8NRgSSP/dOMWx0jUbkjHyPazvhxNyi2z6u2CsDqvzasDQAfH/NL3bghCMs1XDGvQ36lsg3XUnesE3RZ5MTTri81AOAGGNqe3348KfGRf65stX7VXwawYf5sIgglhL3HlzcQTRgrTIflgeJn0mCg8259pHnoY48FaJx8Zxq2s8gR0l9YLVeaK6IYxfErQqv3C4ACv1M8LrGJAZ2UzWhgvt11rBxnqqn0oHTsYPNiqJelxMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOwGtsvmUyOAB3WlIZusz9JGYAOR2EypyVZsDmCO6bE=;
 b=uBTn5Sk2nFIzvof1mdfGxeJajF+hH+BgTr7Ek3ab7buRM/Vd24TkqZiwk7AXLzRVhOsxN9IfPWo+tP4MMlZcoAYe9K1QxtKDlWmyYU2YmwV0Y02TaU0y1pH8pQVqF3ede7dATZP8YfplCoXQNuYzIsBJ7iV5K8T7ACIbiaeTB1YJwIpqi2Y5GKPox9KKPJHcZmbzUTx1R7D09XvNyU5tgs0yxx7gHU1N8TUciVUboDTAXqZ5YeKahGWFwIJR7BSW0LWVHSwsNvCwdtUXLrSCVnpc5OZq7OR3S2j37MV4Pfgx9REHLX3uO6tbMlRpoUDbQLQuGjzjluSoGDA04dYH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOwGtsvmUyOAB3WlIZusz9JGYAOR2EypyVZsDmCO6bE=;
 b=ioH1WkcQ8miNjomXxvb9rFeVrBmkxJESTE93JFnq6H6EEuCHQxpnK9PUcMfUpsw9zPcZ2l5xdOySgj0L91/1CinA4hhdBluRRIKHsoykgYn9P3lm2TBRc3FEHzHu5N0sf2lAKckVbtjBPvbCfqyhZjPYQsaYosHIuwuVc3loEi9914pJIzI/okFfkutSpA658sJsa7PYd6kSAH4HdxRCa3cvZJ46Rx0DZGaf4TxvpmFQ0eaQ6uOqJwxQ+YBe+1X24bzjPSvt6sTweDSwI2xyzD2giqHskG4S5TxdtJdYWNPPsnlQGMNVzGP0OWbzpc7JCLA301BSyy9LNxOe/MnEmQ==
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 17:35:17 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::91) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 17:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 17:35:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 09:34:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 09:34:58 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 09:34:57 -0800
Date: Thu, 20 Nov 2025 09:34:55 -0800
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
Subject: Re: [PATCH 1/9] vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
Message-ID: <aR9RPxtQIsoKgGHk@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <1-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb638a1-0534-493b-ff97-08de285b2b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Lst3yZAVOq3nvPhtnWZzfhIJklW4ZJzf8TcqZuN4P+HbSHTSt0q3YEuP+uH?=
 =?us-ascii?Q?RjysqBTRWsCMFTEnUR9sjK9/yH699GU9pJaTtAFBqcydk+VON3Vb78aBBW8E?=
 =?us-ascii?Q?nNEhpN71r1Q+BD9C2GUG8oPB+Lt/OpFGc52L4PR0X2fPmLmu9z1jr05373se?=
 =?us-ascii?Q?EKajAM3iEpNqay75YCqymqEHBj0orvb2cz3W//Ng8UsWjVpjpf4oHa6RewxN?=
 =?us-ascii?Q?ZO7Jqh7048wQ5sK7qQUt3g94DqB0Sgs5W6maXcsUywTsImwM1Y2ZVXpa5WrV?=
 =?us-ascii?Q?MGY+XapkSfpiBzRnCanLPz/XRWACCqkGM0ju3rBx34yq5hGJdrXIvdub1Yv0?=
 =?us-ascii?Q?XpyCyPMNhKJ5/zlZ6Qn8GpkrDv+/NxCRjtIXQfBsk2Blbkhf6l73SjRLf9O9?=
 =?us-ascii?Q?ILAI6GYa+8qQ3dMbfm11AJNK6pOFnlfSC7/rQgoJ1gBBnCCIJU7Y5vyGm9FX?=
 =?us-ascii?Q?lzWxAUkDJcpoyKrz3McEetzCAEkUHt/16UIYRbhObXZS4jDjV/zbN3m0lgQb?=
 =?us-ascii?Q?XBDiVqD6swal2r/jOcg9Uu3FRq504im7JY1T6bLS6bj7NMxd5Rxr+l2yzxV5?=
 =?us-ascii?Q?y6YsrdxZtR2QbkmLUxsMV6x9DNvlqVePBm5AQveo+Z/GU5WPKXI/xY6IgomN?=
 =?us-ascii?Q?I2yt+ZgMVN06poALRchs6aZMVlaxZhrSSjJwAYp57lTFz83fCHEC3qA0Uprs?=
 =?us-ascii?Q?uvFEziBSv+nCoiz9wqn55seJwMd1lBEh6qQ+checpSdXy+jb3u/6GXxL3VR1?=
 =?us-ascii?Q?WDUKQJDmyYrEbPMl7D23fEubf/d3kjG9hE/fJlzyL1xIBivtz/tYJl1/LfX6?=
 =?us-ascii?Q?ns3VjXj1rnVgt+KssFjR8jl/2soBViOp4mugBqBP02naqB+ITi5tCMnz38Zs?=
 =?us-ascii?Q?D4WYQtcfWH73W2CbdW4FZkl+qOe3qjsoR8MMhfY4e/X/ensIi/8uqMo/00cd?=
 =?us-ascii?Q?BOFSr8dVQ3t89Mwc0+e8Io1LiVlm1wNjhZ/h53m++XrkWPwp4TWY7j4j1LlJ?=
 =?us-ascii?Q?LXw8Xnz6L76HY2KlxSZSgbqsgabSbqLsDQTUxTztoyUreJcaqXmbZ9q0YSFG?=
 =?us-ascii?Q?pgqHLt7tKIhR7tplp+dOtEei9/BvMe7nsDyo6qSzTGalOGba3WFgK7EjBkYG?=
 =?us-ascii?Q?+LTNBJ+AC7X/y4atQb3phVW9lM5Ge5Q4WPDNUiEZvGLl7LUT3n3/As+kkqhH?=
 =?us-ascii?Q?ToDfudrS6ELsI/nJltXWtO4I/s2DfJW+4BchASaDcEt3AWSXcheOn2x2fX6G?=
 =?us-ascii?Q?A0nFc8gT+OJ8pg2UKxnLTWDpOEu/dN1nMatjL7vYUswuzahexwLhapFoXBkR?=
 =?us-ascii?Q?9t/Cc11pen03Dt/aVfJ2GJ65QmkidRitcY5ajHJkXKnEc9KwYdJZ2/gwozgu?=
 =?us-ascii?Q?znieIJu7dMxxRoqtNIOHB906it494B5LGqMKi6FFijj6tPi4o9V2W84QsxQC?=
 =?us-ascii?Q?NVz0ZWb9bN0i2bcb5hXTRXO3eG1cdt5K54uuWIXgNzeKPJ1FyXVkorLeDxdF?=
 =?us-ascii?Q?u7MH05l9E10J5h1qHE7fyGgWVaxCo2HfO9XPFBTNmxcuSMsHWzjbrAKjoefF?=
 =?us-ascii?Q?/qeTGlb0WBkiFDYjYO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:35:17.0671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb638a1-0534-493b-ff97-08de285b2b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085

On Fri, Nov 07, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> This function is used to establish the "private interconnect" between the
> VFIO DMABUF exporter and the iommufd DMABUF importer. This is intended to
> be a temporary API until the core DMABUF interface is improved to natively
> support a private interconnect and revocable negotiation.
> 
> This function should only be called by iommufd when trying to map a
> DMABUF. For now iommufd will only support VFIO DMABUFs.
> 
> The following improvements are needed in the DMABUF API to generically
> support more exporters with iommufd/kvm type importers that cannot use the
> DMA API:
> 
>  1) Revoke semantics. VFIO needs to be able to prevent access to the MMIO
>     during FLR, and so it will use dma_buf_move_notify() to prevent
>     access. iommmufd does not support fault handling so it cannot
>     implement the full move_notify. Instead if revoke is negotiated the
>     exporter promises not to use move_notify() unless the importer can
>     experiance failures. iommufd will unmap the dmabuf from the iommu page
>     tables while it is revoked.
> 
>  2) Private interconnect negotiation. iommufd will only be able to map
>     a "private interconnect" that provides a phys_addr_t and a
>     struct p2pdma_provider * to describe the memory. It cannot use a DMA
>     mapped scatterlist since it is directly calling iommu_map().
> 
>  3) NULL device during dma_buf_dynamic_attach(). Since iommufd doesn't use
>     the DMA API it doesn't have a DMAable struct device to pass here.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

