Return-Path: <linux-kselftest+bounces-19819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7C9A0183
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608C2B20E44
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103A18DF72;
	Wed, 16 Oct 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="laZU01K0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F818C32E;
	Wed, 16 Oct 2024 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060728; cv=fail; b=WARSfQZUTKNuU66FXwLhPbVsWlmraODjiN1b3ZJrG9vUSwqVgpoFtoLuc7Neyotby3jVPcMWV+F9bbZTRxUH2UxNF1wCBOBEPo2Vmy0gW2LGhDc377Wd+FZDRjZlaSEiFuzFkJWl6T0GUzKTYcmiV+mTsghW27/XJPSXAxzYusU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060728; c=relaxed/simple;
	bh=2Im/jVVq34H1YDOTXlfAb4hUVdxEPu+kmmhNOIOzD1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEaVhEyIt94Pkd5K+2UgKoYp1AZl5wSgxWHSkhD1VRfpbCf8RkHYp4DM11/pmHdvsUtl2lynZzYbiqUkibzkO9Xs+25RNThfrJTJlIt1cZV7fFuLZZ8+/9IAW2EzgD3Zkq5YY8RuRy2lvpX4iLieieNN6Bhq5Kvp66XgS+6glUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=laZU01K0; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFX1Xn+g3yTxxq5rx2Mfc8hGnNt5qk+F3v08uI1KTaCqZn5ow9ZuNk2OuWhLzJhtNHm9q6Qk5/GRJQqrII1CkPKwXN88Gl0hQ96k3QsUz7Q7s+rLsTdbEsd4UH3Tkd7R82R/cbrx8FLixmvR2proB70l+QOU6uQMz7iLGjX2Du5tZS5Aaoz0O56h/B+R1SD0RgwykdulHD3KB7qLovGboa6TH/b5q6TDwO2SOOg3g81N7faoq7MC2jafWpBfcwkPStBCPQLUObsLkifCgCNaVW7ElygnUNscFQRRM0unw01EQZCzrbKQMzFfZ5V1mu52ps4YKP/2hz6mNUjWc9VBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBXFExlUqGMu0Izf3lXC1//Jhy3W+wmxvU5IOo7joAE=;
 b=IQQ30ySWYf+H3R9d7wA6DGjZkwx58tKHUDrNHM/OCyb7dBTYCG/8Bx5xt3vYB48UIZig1+IfIYZBRvvjxXgkdvoEBF6JGhk2gVmJiSKlqXZmhWgy4SqZb6ArlX2+gMMdHFObnkXFTJNokRgHn4BPhe8s6khtd4whfjmE65oylNGAX+knTUwoM3vMSAcida/3vRCbrBsYQwlq8kYJa7fMTF3BLhm0i59eEYRxVBLHd2+oU8ds3cI1UsuKScM6n/8+ra5+juwZOBH6wB8gAWR7oyD3f4gajGgtcFrOzMuMhAx/DkgvG4cSPvZYgGYz/hZNImDBMc3oJRTS/mcbnoRi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBXFExlUqGMu0Izf3lXC1//Jhy3W+wmxvU5IOo7joAE=;
 b=laZU01K0jZgSFJp8uL8vG6yPrQND0hTmMqq3A4XPP+aufP38bfchpIbz4WUokH26sqARGsYFAzSozIQ9aZHl4FvO/ugdZLRsMKmgDdzDsdZJ/DUa/HjmDrzd3jHa/LpPA0KtG0vcc/hfCPMsAu5bOY95c6Qf2WoXnNK6ZCWk9U9fkBvzOOrDEXW8ZuAKOpSMkGRrlvIQjkabflEcIRqn8Ne92ZMPHwd4CVDoYmNoFeZxAkdSLM/wGqGYATX3p9Liy2P4Cc5DX3pR2iDlqOXuGHa018VSgtGcmgW2YdHrmK1oaSg4QjAV8ZyQfEmkP1LDji7hHqmtaiVdhJVoptO67g==
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 06:38:40 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::e8) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 06:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:38:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 23:38:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Oct 2024 23:38:21 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Oct 2024 23:38:20 -0700
Date: Tue, 15 Oct 2024 23:38:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <Zw9fW2wx7aBPrbjH@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f76f92-48c3-47cc-7571-08dcedad2bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t2XtZlFf9yGxcpsj7MRyWV/hViczMAx5wul6qJwhm90zrJi+lwt5YxSQZR6G?=
 =?us-ascii?Q?kf6kITYOpaTWcnTWF+CUkLgOrqiil/aJoAd3O5PcWXdcHiVzOI1UNgW8kzST?=
 =?us-ascii?Q?c1qCLz2NAvQg98rbNxNm08JUKVtsVAXiIJHJygVEtBoNGkc9fchcWdV1+gxa?=
 =?us-ascii?Q?f+j1uQxFtv4Zjh1zm07peb4W+n2mcbt/y8lPu/Z+YD1OPSVuD4QHCARgIiDu?=
 =?us-ascii?Q?p1P0zGlBimTcG4iEPHLua2fn/pYmv/kKY3TaNx2nbxyc0pZIuWI27+65vdg2?=
 =?us-ascii?Q?odou945aE8Gz2KjWAGvo+O8wQiVr2ET6otdA+8zj1QhDwfyo5UOLkdI56J3H?=
 =?us-ascii?Q?XtdHcfPpdKEsi032hU7tT+ZbXkBe6VtEIHhdL3issE2NvoWlt2tZvtbmVIDN?=
 =?us-ascii?Q?kE6ofeBiPy3VjeLxcb/9Jj5CGkv8z66tl1j74yaf2PQwmjtCX38ea/uGrsUQ?=
 =?us-ascii?Q?CmAd653NeF09/2raB0sCnhcA/GGKp2y6ahJjCjoxzoxtnFSmaVFUyKxF1KW/?=
 =?us-ascii?Q?zlmTABT7u977oK4BrAt7qnIu4tSh9hV9rfSPbInv1CyvtX0zW0E7D7EoMgYe?=
 =?us-ascii?Q?QeE4fYBcNfvZt6QGuzbZcXLq9qNBKJOv1Bsv9bflI0s1vIFfXUAKcULgP5mD?=
 =?us-ascii?Q?XBP0nTPZCQTAGYZu0QXSQOVWLP2Bke4b4xxvOGoQa6DeLTatUR+XyBPFKHfp?=
 =?us-ascii?Q?VnmdD07vpp8Kticc+QcbPFEvUL2kW+Jdmq9Ar2batKwIxT0TXZEsIP5QTaY9?=
 =?us-ascii?Q?beBWj0r12emnpjgeUa6owMmHCVLYdXFzKEgqeu7BSNqf42qUWCsXBf2+goqb?=
 =?us-ascii?Q?TtaU2myXFOw1sBJhnWRQeZiYSXKZKzIe9Q7Z+/iZdtBDuyR7l7KkfttKqFrL?=
 =?us-ascii?Q?mbsCS43yiwmmQyInGGArFhGZjK9FV/wA+Iaop4aT35EnpfA69xYSnpESyM8x?=
 =?us-ascii?Q?MyhiQzKbddCO+xSl2CMwEUGUG4jAm/ndS+qESd3Ih/drVRYqALXdPsflok3i?=
 =?us-ascii?Q?IyFCQGRDvQ6nN8nhsgOvHNosrGCv0SVsfzHbMAYhsg21zZmycFt/TpHC78UP?=
 =?us-ascii?Q?jJswoalGVeOW3lPzEquRl7hgg6nVTGAOn1c6elqYBJpt1ow4gYbyyAt8HI4+?=
 =?us-ascii?Q?dnzs6gBgXaC1pcjNc5j8KW39siaDUC4Z7PnPbtZVfaZXahse5G0JtWwJvYuG?=
 =?us-ascii?Q?+bIghx0OcU8xRDV9yY1G45wXf7P1GxjftaDWAGeYntg5mnYWau5VfLNLl5fc?=
 =?us-ascii?Q?Rja8qUgXtD552GICDTagrGH4xvekK2vuuvlbvkxvcbrgOP7WaD3O6uI+lIvb?=
 =?us-ascii?Q?ASYqL6SZ2jJuwM3DJ1T8Dx4Hku7k2kKn8EmzVROWB4ozXzNR0gKA+xY5lkYL?=
 =?us-ascii?Q?epZCjdQo3ttrd0RT/hdQlRRkIAB1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:38:39.8875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f76f92-48c3-47cc-7571-08dcedad2bc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

On Wed, Oct 09, 2024 at 09:38:04AM -0700, Nicolin Chen wrote:

> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
[...]
> +       if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT) {
> +               viommu = __iommufd_viommu_alloc(ucmd->ictx, sizeof(*viommu),
> +                                               NULL);
> +       } else {
> +               if (!ops->viommu_alloc) {
> +                       rc = -EOPNOTSUPP;
> +                       goto out_put_hwpt;
> +               }
> +
> +               viommu = ops->viommu_alloc(idev->dev->iommu->iommu_dev,
> +                                          hwpt_paging->common.domain,
> +                                          ucmd->ictx, cmd->type);
> +       }
> +       if (IS_ERR(viommu)) {
> +               rc = PTR_ERR(viommu);
> +               goto out_put_hwpt;
> +       }

While reworking the vIRQ series, I found here we should verify
this driver-allocated viommu object if it is allocated properly
via the suggested API (or if it is properly init-ed as a legit
ictx object).

Likely it needs a helper doing a comparison between viommu->obj
and the returned obj of xa_load(&ictx->objects, viommu->obj.id).
And the following vDEVICE alloc needs it too.

Nicolin

