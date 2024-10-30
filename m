Return-Path: <linux-kselftest+bounces-21085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C059B5BA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 07:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405B4B22807
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C31D0F47;
	Wed, 30 Oct 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZ/YmFam"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942A197A99;
	Wed, 30 Oct 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269021; cv=fail; b=aRGwP7IZ0xyF+tzXHhLDdmZWjE/wzaDYYN+56Zf5lMdsdMx1uuLkYtMwbzfuuDS1BeIYdAw17r8hgCYjglG7eXs5IhARpTXvFBs4VpyWj1AUBJrpWmLTzTzE+loVPXr92VWRDNVQoLp3NtZIr2IE9bfi1MLuWrUtPJaf3CiV+HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269021; c=relaxed/simple;
	bh=K7WtYIS3aSNexNoZsTcsr1mms44phiT6y4G7c7DebeQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg0iHEgyabMtechpi4jroVXX8WJZSYciIJ9gRb62MTxRWwZwgMOWdi1H9n8crHrlMI8RLKRyL199VIVjqEe1sXmaGlu9CXgNMPJdEIH9R1HdPCXzS5UbGudmrQ2Eh+dFL9BSy1SEhaCmq2Udy02udRQujTp6qjljASSqPYA9rjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZ/YmFam; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCBT67n6gtiF42RV+7xzTbWbjKyGV9oTsa4pBpqhHkw+gRUksNUVHFEql2ZhyW/FSA7Bx94IoaaCXwnYKlsOHw0FZ43I2z2NhUuHLU5YY6KK7vipmcQWs4ZgnP4dt0U0sd/6dIE5Uc0xsTigUM28GFa5/HxC76NUam2dW/3px9jygYyhLd0gzsW5MSbpV9PnZwmr1s0KwzLGqNjFNMxejITwnRNrHf6Xhh29EpALjVCmqK6v9p+Lb2TOBGqtAKZdaQq1YRY833/ZVvhpa914N1g8VaMUxLfYlnb0XsFFqXmoWjzbreaP5Gzn9+WfVeujJCkyqUrqhAfbMLhdRMjwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpyYCH7QLT9DoGf41LynrarYKDZ2Xuj+nRV/JHMqPOY=;
 b=dYi6F/KDlOKDEsmEWx+FRT3nrVvp+4VtTWUrxgJA79pqejHX2/LFPqpPpY7h5ZrWV+TjtjBWMC6wOJg4NXPtTF2KOIUYH7KfoAF2EXzdRHBDAOqeEzUp7m/kIqCVSHnrYjQNmet75pGK7yVpqmkzfxOQimVLa6JYRbCgWE0QORnaeFCpJoA8IWUKd8IGHgbpu5PAoF/FpHP3RLI8F2iJd4EWSUnpttWd38cjZ3yKhMAIBS1b8om/ZoJm4M3axJ29E2E4EHLBAhTyoaSc3lC90vJ3tOFt0i4j4o6JbJEkDUM8JN+V1nLM2VBps5aIFRSIcKSI/6DBI3PI2RLWA4/zMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpyYCH7QLT9DoGf41LynrarYKDZ2Xuj+nRV/JHMqPOY=;
 b=nZ/YmFamfWTCyA2tEOrpSxU59Mk+wsgQDJjnuwM/Ft104NJhyDvhO8OYeB+aFO2Hc729V2GSj+9rfBsh/2v3bEHZbV9gD3WDSUe8NPD6NVvK4gkZgpp4scA97s6WLl58PHsR2BK9KRl8yQeOcUUQA06kSmi2Cu/b9FyBErtILnQOXLPltVv98ZF9XE3+JzG8PyRr4uofS/4Wii0fo7liOWTv8hsbY+x4hKv95eYkPtLMI4HfymuWEqA1YtkEbF1aHilIzcrEpyJnhmpApq0VkwLovC7c+wYnnTWwIMWFxl4uTPACJAAPRYBxIANUlSAf5N2BR0Z8jzOmEI9WlDw8dg==
Received: from CY5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:930:69::14)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 06:16:52 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::80) by CY5PR19CA0072.outlook.office365.com
 (2603:10b6:930:69::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:16:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 23:16:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 23:16:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 23:16:37 -0700
Date: Tue, 29 Oct 2024 23:16:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>, <will@kernel.org>
Subject: Re: [PATCH v5 12/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <ZyHPQ5ReteROO42X@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <82a05ca8880c3613120fcf6875d083b25c5478be.1729897352.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82a05ca8880c3613120fcf6875d083b25c5478be.1729897352.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: a5236b06-0445-4155-46ce-08dcf8aa720d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWekdujxVVHbga3hSPsfQqlsz51lQUNV3rh77qqhmpO54W4L8RJd6kRQ42RL?=
 =?us-ascii?Q?Sr7oy4VruB7OWjpVCH54gFNP338Qi00xilszG37eepQnRiePr+bVrAjMSEUN?=
 =?us-ascii?Q?9gsktszkiuXWnxFzcDyRhm4wZ0eLScBJ0aAhev0cDycJHE8XEj9xJip0KYA6?=
 =?us-ascii?Q?Wq/2Cw+i3UIMAPguS2rXxneyyEs4LqmtMa/zVTJRSOzDln85FovTh97bUzXl?=
 =?us-ascii?Q?0IxaX3bfY+RSbsJyOk/QrqwcZxMbZwA+tyR/OYNsZEY4KBiuOSm4iU09Ei6z?=
 =?us-ascii?Q?PfBP9n5xEYMl7qwF6s1if7jNYkC6erIyu+1SAWADdgrDqvCJKXzJbiGzFYqT?=
 =?us-ascii?Q?dcatF5mrqurrkEOHqb7ll4x7h2gA074ohXH83CfNU9NNODca0TFpVui/Py2x?=
 =?us-ascii?Q?6VFlgnc5puhBDNg0gIhM/GORHf4q5UYy6I9H6K4IqIzHyD/fVvVGf3JopYz0?=
 =?us-ascii?Q?pVAoeiuGhfBTO7XpzAWj2iUGVHsM3oEce+VVle/+nDHRkP0PgdqE3WlhtjDo?=
 =?us-ascii?Q?9XYcvY+0+HSg5q/SnzaXd/14P8QvgX9yp8LPYc8jkDxoBThES5z9RjGe8hO/?=
 =?us-ascii?Q?2wnbOXtcEvM+P5Hem47qGlQ3SC9uzorBQqmS0uHEEblf7d57utl3qAHKavk4?=
 =?us-ascii?Q?GwHbPL5IR42PrJ0h5LtxvxfxXsAJMmCqLA6a/yQd+lg6myBRSzjsfCGdMMVN?=
 =?us-ascii?Q?zFa1T5Ig2Dfe+zZw+akxr2HitX/z7eFq9Ty9ZLxb8pwOXVZKCZ8A8Sb4eqzy?=
 =?us-ascii?Q?b9mardizWu3fY7eN/DCvLWats6DFVNmZHn/+QkgKMgtZOUMKzb8MBKK2xK3/?=
 =?us-ascii?Q?fUaXQV5GY77zHaVh567lp6IR5ibVhcy3PhdtdO2gjCpzqVEFo/gtAnDqJ3vR?=
 =?us-ascii?Q?4G6i0AFK5IgZvwogKpJEvqyZWEHWdjdNxNwHsS1Y9IZu7SX+epOvnSiVwkQB?=
 =?us-ascii?Q?cdW1WyT+Ctf/vYTmr4DYxn2lKyM6F2nIRAAlunVil7gCz9UrJaqKoFZ5s8qW?=
 =?us-ascii?Q?sOW7G3jV8V10ToJXnw3g7JZnkyBKmFmor8ewjCbVBrKExAHr5t1JuWS1gN0d?=
 =?us-ascii?Q?oTeBo6keyC4kfJDO1QgGOAppXvf1EoD5H3tZqYboxFHUx8XxDUUk/PkCwGs9?=
 =?us-ascii?Q?n9IEZMEiV+e3kDQ6oRXgNtD1g6ufUrQ/y+pN3U961R/XhA/1KNmX134HxRvl?=
 =?us-ascii?Q?3w3qFHbPCrx2ChDj/WXXv07FJSy0vM70zTbVMUebN8Gg6i4oulPPlZOeyyzW?=
 =?us-ascii?Q?UWseeDMsyp6M3fSRymR7G4ISwO7rhwuQpse40lhkhAAM9LDzRv2uvpHRRXqa?=
 =?us-ascii?Q?5B0oNo7LBk1NZ6KHlCynzzpqKj0sPGqOBi30CNd6l6S84ub/WT+NHxxIJsK6?=
 =?us-ascii?Q?IquYmtqnp/QHfLls1bID34z4qwOxCTESv+TV+D06JooFUJxhDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:16:52.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5236b06-0445-4155-46ce-08dcf8aa720d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

On Fri, Oct 25, 2024 at 04:49:52PM -0700, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc to reflect that and add a new graph.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> index 2deba93bf159..92d16efad5b0 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
>    space usually has mappings from guest-level I/O virtual addresses to guest-
>    level physical addresses.
> 
> + - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,

I just found an extra space at this entire paragraph, resulting
in the VIOMMU/VDEVICE chunks right-shifted by that one space...

Will fix this in v6 and confirm with htmldocs. Also, I think I
forgot to CC doc folks/maillist.. will do that too.

Thanks
Nicolin

