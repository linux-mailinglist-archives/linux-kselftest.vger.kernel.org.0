Return-Path: <linux-kselftest+bounces-34413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D98ACFC09
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 06:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0105F189769E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 04:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C11A9B48;
	Fri,  6 Jun 2025 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L161cLuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76B1FB3;
	Fri,  6 Jun 2025 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749185211; cv=fail; b=A1s7ecz1YOxwadarOGxZo3ZDheXC2XWYZBsJCCRmoh8+AfLUsHGNmdjEys+7yMs68hqpzfFustVj61wnpgmEM9ACObKzgCaC0ecKho8erH5CR3vN8j/tx2v4QDhGoyQkrVRiXEMkfuMAJqSQeQ/pfRHfOv6h0//FWovZGXofKJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749185211; c=relaxed/simple;
	bh=+opEEGLq3Yv8bpVx1bAPq0fYi4cwRvXeqzJMaIeN+k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfAtuAkDxoIFyq09ijsVv5Yr2qk1T8qBmolcFtg+aaPsiCq/CklLsl2ZaIa1SIpXmH5DEd6tYMl94aWcPhhBVmZXK16WIuAkq4U7O8OjxKo8PVwZp5tZZp/GlK2pteSmvBfI4zj3ri5xy4NZ9t9dUqwmNQuYZK2dqxWG/1RBhSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L161cLuS; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvvNzVCcEZlqPLTlcpLt/Nw3gcjdBiwhUz8DpGiU2LykE+heikMi60rA2oP2ky9+JqZzsokYWJQf7SeKctkbR1hQEiiEvZ/kvVO0wsPqEJsR1mr4xV5/bnEmkFReu5iiwylZnK3LCpnEaqlhXGAlbXVwcbN3Em1UFtG9uYc6rdebHMPoF358F08XyNkSR1OPP7HoUrr2BEX+6GYPYM55IfPbl0fBaJkFBGRi/5HeoHh957MXO4eoMhmsvwXEehwuRk/JIN4EeuypdC0DrNyUYZDsSq21CjKOx7qCt2k2yxND7quvy7DWZxgTRHT7Auw071r3dQd00ysDCr2mpCTtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDMBr25Rd5V/4UNv3zTo9MCi6cLNrHYng1lWkmFyUmA=;
 b=FTcDdNMTCo7qKxcV6L9EY7P0zPCMDU0ZBM+ERKH4JdJL++oD94uYVrPkKwAds6pH1Ypgb+vgz6dKgiWP7ZTuzgFigRUD5YCyu7A/SnMJbU2wjFoCLMHUps2IgO59uTI9kebDWhrtjbR9N5JVC5F8OQy3msDSkLes2b2tLCct/MJH7SwKs00OitK9LjqQPWqqsi615FTyQa/saDzyQ9twJyPMmCInirAgDWe54c9rjX1U/Go/6Y6KfXyUmZgFLQix/+A15Wo4K3gs4QULvA4cQzNc5EsfYCB1cplmOFLupTTavjMvHm2dbMk4fMKxyGL9Sl/ShxVqqad4PG4ZL5fNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDMBr25Rd5V/4UNv3zTo9MCi6cLNrHYng1lWkmFyUmA=;
 b=L161cLuSOXA+uQ+QpbQpk5BhOXXyOpIbnvsAZXjEvXGC/boKaCDwutYtTDOJ2eezMO4xit7IvI3s8KHrmPHX2XIKzE+oFVS1q83GF+udmAqtcLxgRpxHNDx7p2usAHolupsnb4WCWKbCNBVyPTgOan1ieyPgjVjT9h9oBmNaY+4caKkojhdxj7ZHuuwXdUyz0v1w2CPL4X+py4ASgkU4gW3YQJBTluxmLnaAN/E0nGhVXC7L0UZ3PQT9aEWWbFSPKPF+l6d0uhiPCEJpz/JvW3igb/RbY+9DDpnowmA3ulx3USTZTGkba2Zq1YFI5eFH1rwQQy3G0q1cl5m/0U40Hg==
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 6 Jun
 2025 04:46:45 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::bd) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Fri,
 6 Jun 2025 04:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 04:46:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 21:46:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 21:46:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 5 Jun 2025 21:46:30 -0700
Date: Thu, 5 Jun 2025 21:46:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aEJypNAzkGGT375k@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
 <20250528171754.GY61950@nvidia.com>
 <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
 <20250605151648.GD19710@nvidia.com>
 <aEHOI522eucrOZyI@Asurada-Nvidia>
 <20250605194034.GF19710@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605194034.GF19710@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 699a4de5-c5a2-4073-9ca2-08dda4b523a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzgwbogu5Hwb6Bg92lwYHmC1OWuoUGYVGV3KTDtA7Ubx1IFkSzbmIzsVYLje?=
 =?us-ascii?Q?hFC9Mkg4HQ/sp2bQkcV37R7c2Hd3N4s3umYIJz1WNiXHHRQ8eEuHmi4nG1FK?=
 =?us-ascii?Q?k3Nb5AjCHLp+kHpnF8FTePrELgXOPVfapUNYpNpZqpzJrO5yXrgALsW3Vqet?=
 =?us-ascii?Q?Cm9z7NbP/v8CoUGt65k4v8WSbNcUF5rxdOcPi60xKYKaS4z6SRXjviGsbftC?=
 =?us-ascii?Q?p0EYLucx+nQR+n5E2wrHELSKg+TwbSPfgQFrZPDCw+XrY1A3I86/NQZ6G/uD?=
 =?us-ascii?Q?dqV2BoVXEBu17GjPCC7lwTrZNnUPqlUmut2RmrN+r1WokoL8Xi0ZHF88AD8V?=
 =?us-ascii?Q?kCm0BNPOey4TS6kpUSZNNsJi5sEhq3galp0M0NLFjU3PgUlgk0YxM0Klyv1C?=
 =?us-ascii?Q?xvrUKQ60D8rEe3EBAk1sMnj/s3HZ8+TMp+iS0x0jy9yJs3jHvv71OA+2DssM?=
 =?us-ascii?Q?TsKqf9TRw/sXPcqNxW32IjkVHRRegnRvqTlPHgHTbaTbjtItLHea7BDoR2Hf?=
 =?us-ascii?Q?HJjmOb0/HK+TzfiAFVSGLdVuo5YVPsbQdeiLj2mzdxj8TVGAyerISpOSxoCw?=
 =?us-ascii?Q?A1R55nzkmSLJca5hNhAwIITOFzcD2Zn6LNmZoIprzeX/Lx5XR7FvTUEpTx5b?=
 =?us-ascii?Q?Ur/Nc45f+JNY6OnxJ8XmflnkqkVKjLk5UukFNQdTslq62A08FbF6UWte3VnI?=
 =?us-ascii?Q?4LoJgVVokWgfmFNg0wTaPhBz25bH4KYpa88Y7YyPGMlx+ITDJn9qKdD6FNss?=
 =?us-ascii?Q?DSak1tIpnirLJyj9ame3Tz8WS4B0Dr6LYDLANC5jBCq6Up+GHEWbOSL5IKPB?=
 =?us-ascii?Q?Fm8M7z1idAsi3uDdZO9zeGY5Kwz4ijLD2gFW/Iwd+wnCsvF93OrlFCNpKm9Z?=
 =?us-ascii?Q?f23uC8GEaHTsHlTpkm1DJrCaT1qFNVXlNYqdsyGL64J//X/UVIUk4M8A8Etz?=
 =?us-ascii?Q?hbGMYAo/zyki07YX5nQNeZBjMr/AHA37dO+jLJ11VwWLi8DzSOLx9HvRvRUT?=
 =?us-ascii?Q?1v21FGXMzwLSz4a/tg5Unntg2Isttsj5Usxi6oD+nvUDUzvwioYGlQrgeohu?=
 =?us-ascii?Q?w0GtiVYAkx5NdRBwJ2IdhDOwDPJ7BiDQNGkiC2dtrgPdbBv0n6sf+DKpzM2n?=
 =?us-ascii?Q?xs0fahXBmAByz311zb5DQ/G6t+LtbJV7viixGODBnwQ6ybWryzfwH67M5A/Q?=
 =?us-ascii?Q?d1n0Vkzbtu2XU9r0DgnylrbHWfOwkCodcQUSIPEf4mFogHVttWosG4R3BqFN?=
 =?us-ascii?Q?2Bo6dRXmvZy7uOUEyMUIZaY6II4aKV5hy5dt3yudQMOVvy5qupLDXL2WIiMj?=
 =?us-ascii?Q?DUTxWFP2hWnIRJo755OGRhmnUrbSV2vG/JH43Os4HDZqM9UEIOw2MT4LzYRj?=
 =?us-ascii?Q?xk0gd/J/wNst7SnePCC1r0LmThNlL3dR+TsJE7jtgyygWl0fCCEI+ftWA62y?=
 =?us-ascii?Q?j7InS8luWdX9ez6f0buTYk9/gexI6WL3OtWP1Y7uiFcJ+8HKrP44+mC3XkOg?=
 =?us-ascii?Q?BDn3i/H+g8RcOITYxnYs6MG3imrK/Rskoder?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 04:46:44.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699a4de5-c5a2-4073-9ca2-08dda4b523a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

On Thu, Jun 05, 2025 at 04:40:34PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 05, 2025 at 10:04:35AM -0700, Nicolin Chen wrote:
> > On Thu, Jun 05, 2025 at 12:16:48PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 04, 2025 at 09:11:07PM -0700, Nicolin Chen wrote:
> > > 
> > > > I found the entire ictx would be locked by iommufd_access_create(),
> > > > then the release fop couldn't even get invoked to destroy objects.
> > > 
> > > Yes, that makes sense..
> > > 
> > > It looks to me like you can safely leave ictx as NULL instead of
> > > adding a flag? That would be nicer than leaving a unrefcounted
> > > pointer floating around..
> > 
> > Hmm, there are a few iommufd_get_object calls using access->ictx
> > in iommufd_access_attach() and iommufd_access_destroy().
> 
> I counted:
> 
> iommufd_access_change_ioas_id
>  * Don't call this
> iommufd_access_destroy_object
>  * Don't put if null
> iommufd_access_create
>  * Don't set it
> iommufd_access_destroy
>  * Call iommufd_object_destroy_user directly
> iommufd_access_notify_unmap
>  * Check for null access->ops->unmap and skip the lock_obj/put_obj

Yea. And I added a set of lighter "_internal" helpers so the caller
side looks consistent:

	access = iommufd_access_create_internal(viommu->ictx);
	rc = iommufd_access_attach_internal(access, viommu->hwpt->ioas);
	...
	iommufd_access_detach_internal(access);
	iommufd_access_destroy_internal(ictx, access);

Thanks
Nicolin

