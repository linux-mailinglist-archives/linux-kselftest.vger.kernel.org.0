Return-Path: <linux-kselftest+bounces-24400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B48A0C133
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B6A3A4937
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1591C5F2B;
	Mon, 13 Jan 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jgP2mMYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781E1C5F20;
	Mon, 13 Jan 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795947; cv=fail; b=WdQb4dcdcgWGdrthO9M7b0nEl2IcATne9ub5OzG1gU/W3MbdcGQT65QhqRp/hB9EZBhwV2/HJcZiLhQfgI+H9zoCGODg2HwmK25hrTWiHrkY8eMlaES3wSB9evstYQswLlK4FBFn0sTS03Q85gjpL92+pE500HKCbuClmOh3aT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795947; c=relaxed/simple;
	bh=j6IKB23w+1aifZ46oZCpEsiaLy6b6WOTEwNjALbrG9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUmdCCBP7H9F50TL4TS2hHI2Y9diHLbKV2RBjQqIk3h2gHx25Dq0STKdgLyiyCapatGlH9DhrO8f8y7mymRXf6L+xdX2D15hDmvhVSFBy5sOe3pTDNo6dGiPyxVX7MpPKUyCy1i4N3W6QJEfSXUu9tYtAlfDF6znW3mER74rs7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jgP2mMYa; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q19rNWitLXfNvU+6Fr2mgkmdupVwqa0yJw47xiwkLxuMSj+7CilV7C0L27LAYEiYeePijmyNCcfa+SZGSaUTPU7dWqgkB5gmpH8zVRiR92J22YVBfii8sYJG5Fq1QPWpKTw4qcuzbrcB6fsPwzFmgyY0r6lvHAiv4Vi1dfGYbpu31pfANNGEnOYgYbgqyPpwhxOhYe7jkepoaTuXHRB5XhJN9ohVjs/WzT6+PQcIA4UWPfvsyl8zpPH+/W9i+KqeFhIDhmamIlQjjFfXzt0jAjgfpd6ekQpHKDnSY4nXqY4WLWqRSQJHfJHh+Rgvm0S14/MtF5f6aPF0rD83TbjtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVuex438pZ2IGTTayxBj8xY7Q1dwj++eqUN4/bsvYpI=;
 b=vPqyp+g1ObsNAzOV/Vegy0+V5L7XltcCP+9Zc0kTUTAykaa07sl5HpjAufavhYPmePIonB9LUxPetdCz/pSxtUff+t2X0un9TCjLrg4NaJEL5ExP49FRfWy5l/cBP5zwyY+Ye35+QIBC2/JBS9Ec0AHn+lZobsTO3abd3XOHyTW0B85L5scTQVPquuR/OEHg4SAH+sfguDDRb8DKHVRBC35eQp5kH3qwib3/SPGXjhfOtkJHo/8fO/4x4cZ4pDkPcYTBqqhY0idPOFFAfzxDcWQWPFZUC2+w48WfQPKn+WlnS0DMPCR7YmvOAhwFGPR0NUYiYy3VKf0P73U1N3puOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVuex438pZ2IGTTayxBj8xY7Q1dwj++eqUN4/bsvYpI=;
 b=jgP2mMYa0CZVIU7I1Kk07PI/GpK0cI871Nv3mLIR4DGW1jOhrfEFNLGAl1pjh79Odz+COMcoLs7wjAaDD9Lo88qC1XJCjtoKk9Pgj8u1dQV3wkttQ9i2sYzlLK5intSAywHQuPYQ3yM8uKNwhZON6yUlWiCDs6SwKULPAqinNoEi3QkXuj8dqlo4d7ICledwP8H8BLfBpZ8r7AsM44TOKVgFcjaL4ckMQOyGFgfqrivWm5NpQYQ7avK1tdSe+/Q51QRHxNC0N+7tC4xn7HDIZ38kh7sT5+ahxrY09Ei4Brp2pLj2wmTVum8TmhPuSmrgZId4IOK0HZYmzAmLVX5+Mw==
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:19:01 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::37) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 19:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 19:19:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:18:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 Jan 2025 11:18:53 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 11:18:52 -0800
Date: Mon, 13 Jan 2025 11:18:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z4VnG2PSeH0MCfGs@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <20250110174842.GI396083@nvidia.com>
 <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
 <20250110194950.GI5556@nvidia.com>
 <Z4GX/R6lRwuhlBJQ@Asurada-Nvidia>
 <20250113191225.GS5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113191225.GS5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 484d9825-15fb-4625-36c8-08dd34072350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdfEqEzohrbPn6H/32PuD+r0eOGBQDXEConVMCq9piUlNL4Wle3qLd5qTdVI?=
 =?us-ascii?Q?Mz/qSzGioxQ1k4r1YVJ7Sxx/ZnHqk6QGktRfTWhH6kvKeB4XtYsX3O1A9Fio?=
 =?us-ascii?Q?1vgDpLbanFEVPr9L0pDZ68DFTgCiW06wPrOcPHhR7aeN+oS2gkDTtjO4aLmD?=
 =?us-ascii?Q?nHzKboFOs0+WU90StAzZvzScYxqu8CaWLXW12h1A43Rr2c8sfBR1/6AQxtah?=
 =?us-ascii?Q?f5MoXsSFw2YkgTPotdqzgGF9ORRhnIFJHF0Kin0xvrOHNcK46ITUGOmSCwKU?=
 =?us-ascii?Q?zwS3LgXeOBZfvpy419QLN84D2Wa/agmkgUz4rlMxR3a393/rKrzkoRbhwExD?=
 =?us-ascii?Q?xhlmj8TlKUiUJ2nsU3I08YeCzTw/YaZg/nhdTPfmDhM8gbc6gOZMwwsyBf5p?=
 =?us-ascii?Q?KJ1T8bh30k8nevy0v7URcvHuabjCYlwXfFmOhSi36Z141Jo8c/ifsqyGkwMB?=
 =?us-ascii?Q?ukI34DTpiOUn3EClszjKHJG6hQzr1f3sZHYeViYWaXxtQXDF223GzoFCFVw9?=
 =?us-ascii?Q?irT98O8N19slTY4sBX8Sjvek8AZPv8xGAOnw4mlkG7SsBIBr9EFkL0OPbhPI?=
 =?us-ascii?Q?UMeb3FOZbWH/xFR5PnbWko64O3Gue0bDd0i1yGkAfgdpa7NXifq6gvMKHLsf?=
 =?us-ascii?Q?8Nw3at9lfTAUn9Xd7iWofmog6gLtkruKlblbTfaE3MMU8n3WXEvys6NF/Sqn?=
 =?us-ascii?Q?iDhPsF7GSjUUzNqluyFzDRWo+k5trIxrbaXYxw/KOnTZAAIYWmUS+jJF6ZZP?=
 =?us-ascii?Q?U3S4uI8xkUZw3m9b8cL+g8PkcyUx9Mdw9v+sz3yB8CWAXSyWX5Kx2Pg4rg2u?=
 =?us-ascii?Q?3ttkyBmp9HaqKeqGmbrS4ZqA5HO3PlJb+OcMCfoSlO9Wx1HzfYIAmPj24Qiz?=
 =?us-ascii?Q?Mhh+LNazN1ms1jzJMJs/+X+1Z4b77LKCK8IHUbcNW6BpOesSoZHaBzgoDnib?=
 =?us-ascii?Q?WExMfsaWyYxhrxB6UMvXcvaFzqFofY9EDHZ6vwqqUwaA2II6SYEagwYh2ige?=
 =?us-ascii?Q?MI+UCDzwC71naQ+jFxzRGhONPpimy1OTJonywJadGoUnIBFUMdiPTapFpuy4?=
 =?us-ascii?Q?yxyFMKu6gRcCPLVXX0EWYY2omZLsteCJja1AWlbBmyAiKGdDE8cayeSN27oP?=
 =?us-ascii?Q?LGmP24YqTzdPkHigwH1YbYfTZwDVj4c6OY0IA8hYObjZcaokgQ/v+iug/3pF?=
 =?us-ascii?Q?aCS9vcHKFjXKlIu9RWjSYuM0OpVXF1AFD/ye6BM45YGg7y8oq75e69QMTGk9?=
 =?us-ascii?Q?Fk+3hHB6ki16MHXCwlbCo5bO28trRi23Ht01RVV7fsrRPmNlOcvQCPUS19Ml?=
 =?us-ascii?Q?DjwqgX3c6a4sYHMOh6Of3n1mQ4eSwfsP5/S1l7StkQh8yaLyuYtDPTosqByB?=
 =?us-ascii?Q?x/0NTH9fX4QOnu8qMBoPpyjfr2vVDym7gSMXRhOX4t6tgTKdbhjk2tzPOvsZ?=
 =?us-ascii?Q?AkoqC7NfOsnDkfvcLOmwrHAu+wOJzTrHMuZW3ikNVo5S9PNhZmK4ZA2ctnTd?=
 =?us-ascii?Q?2e+a5UuJ11RVGOA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:19:01.6478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484d9825-15fb-4625-36c8-08dd34072350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

On Mon, Jan 13, 2025 at 03:12:25PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2025 at 01:58:21PM -0800, Nicolin Chen wrote:
> > Hmm, it seems that I haven't got your first narrative straight..
> > 
> > Would you mind elaborate "copy_to_user() can block while waiting
> > on a page fault"? When would this happen?
> 
> copy_to_user() is a sleeping function that sleeps if the user memory
> is non-present. So userspace can cause copy_to_user to copy to
> anything, including memory that is non-present and will take along
> time to page fault in. Eg perhaps by abusing userfaultfd.
> 
> We should not allow userspace to globally DOS the iommu driver this
> way.
> 
> So do not hold locks that are also held by the HW event path across
> copy_to_user().

I see. Thanks for explaining. I will add a patch fixing the fault
read() and change the veventq read() accordingly.

Nicolin

