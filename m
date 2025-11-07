Return-Path: <linux-kselftest+bounces-45141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC983C41314
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F954E1B70
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F24326D50;
	Fri,  7 Nov 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TsBCZNda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94DE2F83BC;
	Fri,  7 Nov 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538593; cv=fail; b=ePoslO5KKkdjE70R34G6r9H2OimsQ9PUC/LnTkJ1kW8z785DPLHYgqml2XSrcr6vB3Gd+XtVdq3nV+JmfM+7dzwG/el+3Z4+yYpc7nLFSU+LH4pWa8C5OR/yXjjTVSKW3SvBk8soZ/FWWs7pYhvCTkM5p7WkXJALGe3h+bz3p0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538593; c=relaxed/simple;
	bh=/JciPI7HVsdyWEgPwgNzN1rDdNH1vLEq/I2zeAuV3qM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny5oiTEOnpHHjZFg2opIFPxLmkg+4iGMYXGXuE+idnwH+Y+pSBiMBmjEZNBZulhyaSlFxnQMmBhLFtL538P2OTgKMKZ1oYEcLoL2TY/S40vxb2avJ/ZIO8Ib9a4kswDi9mWItW6Oc3nIpg3ggqH+nbN+Xtu9hRQ4Zjfu5s+63QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TsBCZNda; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdeA+1Ng2yl4p5LONwSdaM5hG6jNcXfW+4o1gXfiTgnCCq8rSQvakizn5Gg4yyKgGxNRm5aCcqx/efcWWWmWuRVEndkNT6/qK6oGs8X7T/ThlM5MnFCJf0dm6oMta0iLW3jGN+6kcgt23+/KLvoxsleIRJNwLl1Z27MoQ6rfFjOBg9tZi9h3SHa4ThwSR+LA2SersVeS8lnYa3dm4Qpt0yB5UG+lwcuCxGiwi8RxzaatWB/3HpszKdERWde4UwY5nAur78Whk1I4CuUlPW931eqhHqe47WHpRHXgs+SJXvou05/duonwE2zLQBBnc3FRhoFu2hVEjrlalXp5qp9KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRvOtu72YLOpEgGNjZb1sCUAzE7uD+JeDNW/KPy9ZBQ=;
 b=cCaTQZy6OPJc2UaOnTV92V3sZ/w9QdEaFRmvxtf7xphklGwcSmcfE+61XaVNFmQ2xFPuPe1K8HPkjRkjysD4rZwEgoNwNche1v4Iqdz6XYZ7E3Z/V+jvCGp+s/Hs13OjQieDLv5W7mOa12mtP4l5Fonjk7mO30fltrhTEt1TVWi4azPEjX9NYrTjSHH1kGaOrJd3mCHESXJba2HCSeCHHGwH0uArBxC1QV5tioPMXUn54KvUVY+jHn3zefiLBOePWnDr/BptUjEH7wAvhjNkylIwiF9XQ8VIRGjG7w1bvBxwXW/DTHVQ/mM/+4mBPTFyzJAG0fFxQE4L7XWLFkzrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRvOtu72YLOpEgGNjZb1sCUAzE7uD+JeDNW/KPy9ZBQ=;
 b=TsBCZNdad6OlSz3I6gwAbMUNZmYbNhBcUEKzhMQklN59BYbmKdolmYGn9m1KY3gm2DznJuMUO7TVpiE8PRhEuM7V7c72PzN4jLv6iJE9a0ItvfIaCsajt7LNWke2oWlQ65Y4KQCTL0RSv7i5vF+beH/GRJW5Bz0CKSZnEgi6WeOghHI+fqWgbRWCJ7rDGea44jM6/K5S7evXWFvOc/2H/HYDrkIbp32JsyTZK0yH0ALBORR7iWWJL7Quu8kJK12hAFe+A5uyfZmxx95MzLrvSjDHh6C7POUqkoKEPsKMrexnSPEo9gPGG1qYZlTrRRkjRnolIpfiBiOXJrt4XuOEKg==
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 18:03:04 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::3f) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 18:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 18:03:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 10:02:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 7 Nov 2025 10:02:50 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 10:02:49 -0800
Date: Fri, 7 Nov 2025 10:02:48 -0800
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
Subject: Re: [PATCH 2/9] iommufd: Add DMABUF to iopt_pages
Message-ID: <aQ40SOjespJjyB9K@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <2-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: d90d3fcf-8da1-477a-d617-08de1e27e5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zu1+3OsDmLzt0hC9xFseE3au5rT/DgGPJkGImMDCErdNmj9zt/dQjan+d8sD?=
 =?us-ascii?Q?kdpM1rvhGDuREkgNgdpUHAsidrOksPk63f2cOIkEDa86x1rp8QYZx5F4Kiha?=
 =?us-ascii?Q?woAiAiA2z/X3FQ0EjhcPqSh+gwpazFrxlwSxWmJ0vuDPZqRC7oA4Hzy2kyOh?=
 =?us-ascii?Q?LHvwJ52C9mjBo3sRFfIQzCtRSWuJP3zvlbYlSJmpN8SD3KCYB/79OSexfNMz?=
 =?us-ascii?Q?o/MvwSOjhWzFOhrePu1uV2BF5Ao4cCpKqu0BlmBnjNO5uBv6iqsvLDvmk1a9?=
 =?us-ascii?Q?CtKeqGYNIFye9dSjwPwt+uKqdFbqCeDtc7zhSsqaMoQXJK6uZszi3zn9yc6k?=
 =?us-ascii?Q?3w9Ud8QhsEKAWiDSLbfxFcv+vi5W1qvK5FnptT+UTj5ufcjt0CyGgp4KUuL4?=
 =?us-ascii?Q?iIf1SM8Q+eDYOGP/RwMGymMHfyRsP677t/Ltik+jAYpNQp0rasqC+0bcJ77L?=
 =?us-ascii?Q?zmeff9ghmkyqOr4Z8/Xa9E/E5Lf/r0HfWz7wKPZdOz0eZ/Es1W2K6Gty1pt2?=
 =?us-ascii?Q?H5AVv9r/gXolSGL4+ERdVzvBJUcZ7Jdhfa0ETVuxRW1lwkmKlC3kzsh8hGy8?=
 =?us-ascii?Q?rypq7OKyZwGnAWxk2EjC8ltXP9m89KrsGDmqzC+lZtkdm2HiKYowhhsqZHwh?=
 =?us-ascii?Q?NH/zllT/ofnzt7304lX4X3ADR3Kmkei5R5rfuqnN31ew7luHj7fpw1VjZla1?=
 =?us-ascii?Q?y22UH09IhNK08vluF948TSwJzN48lqJo2DtAFv2JtGmiFWZlfwTomHRsj6vh?=
 =?us-ascii?Q?lqgvM0aDMseBWkiamFb2B4gO1N3XzjiX5Y5iKidI15wXOzBugSvTZrUgtwPT?=
 =?us-ascii?Q?ZnmEsblp3/T8Ivj2vvogVL9LaBsNYEg8bD3jGnyu+7gfZSfjYQ+HQ+L+hUoe?=
 =?us-ascii?Q?ueAOUz+31kog8Rx/wzLOCRnsPRtlAxfaXfCkulojCFm+zf7fAcZS9cYDJX9E?=
 =?us-ascii?Q?mTKdrA+Fl3nfjdHhxeWugV7YJA24G+1lwJ0oEhpfQFaYCU0SEoZqap9Yjpy5?=
 =?us-ascii?Q?ofViOiE4s6U5mM0oLHCjrbyAV7hl5ZBr82tHmKeiVjM0laKbGpyzskh4h+pw?=
 =?us-ascii?Q?StWT6IFcmjV3YJAEHYLwvvea1j/IAaGRzn9kYN9ZkzCphe7OBDl1pdLf3IW1?=
 =?us-ascii?Q?CQXDg0PgBSIZb/xxl6XnsgFyK+oJFJRc1IoVrd0pxIOWQyi7zKJ320SoLVRg?=
 =?us-ascii?Q?qoxC1eExcd8VGlnIRZys5CpaAS8hIJWOtNeitbOGrkqa4bNdl0kffCWOLhZY?=
 =?us-ascii?Q?sOsuI8KKj52hvdtLdUrPi7KUe9b/UvAwHjMgcs/g95qzC/0nr31nx7DD3RuI?=
 =?us-ascii?Q?o+dkeRe1EYG2D31e+4h5u7gp3dP74p2nXy6wQ0ZlxIkIlS8Qs8Owele3uycO?=
 =?us-ascii?Q?D6GirqbRBwaBXjz3udzalnvoMDBIorrCjFNxjU9jNpuI/00JFXHLIWjX0PYu?=
 =?us-ascii?Q?cr4gdUNEKItPh5GJ6DxkNqFDTRptkg4SnhtvenUDB3btzwqg0IG5lcXQcKMD?=
 =?us-ascii?Q?CfVj5WaKXMDkv5Dyrw3hZTG1XKBw4wBij/sSU6ne4ikMFSKGPB303tMkHwqK?=
 =?us-ascii?Q?p3QX46ycew6zm16KMus=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 18:03:03.6857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90d3fcf-8da1-477a-d617-08de1e27e5a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

On Fri, Nov 07, 2025 at 12:49:34PM -0400, Jason Gunthorpe wrote:
> Add IOPT_ADDRESS_DMABUF to the iopt_pages and the basic infrastructure to
> create an iopt_pages from a struct dma_buf *.
> 
> DMABUF pages are not supported for accesses, and for now can only be used
> with the VFIO DMABUF exporter.
> 
> The overall flow will be similar to memfd where the user can pass in a
> DMABUF file descriptor to IOMMU_IOAS_MAP_FILE and create an area and
> pages. Like other areas it can be copied and otherwise manipulated, though
> there is little point in doing so.
> 
> There is no pinned page accounting done for DMABUF maps.
> 
> The DMABUF attachment exists so long as the dmabuf is mapped into an IOAS,
> even if the IOAS is not mapped to any domains.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

