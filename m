Return-Path: <linux-kselftest+bounces-44784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E26C33F1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 05:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5534255F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C896225408;
	Wed,  5 Nov 2025 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJo4ktLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0921FC7C5
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318071; cv=fail; b=eXMPCd32DTgSDNhI7b/k7n9Ng4mAeoOb7OoG60rtIQPY3/x+DuOXqt4TbBQNEI9pv+J8xe7Jx0Wefl5fXmJJFqszz1AJ8a0cym9faVJWc/MYMX95Ubit/OX+L7YZhRouDUrJWN27kBlo1QQ6TJIkjtJIBdFojhmzNX9dhT6fIuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318071; c=relaxed/simple;
	bh=I3bOVZ1VlN73ip51OEl1k7p2VsX+iDFsTVTfnIPvCfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqEXBFvSg14zccv5iZi4vRir8y8VkkY8kC9t7v59v8sSTKruGfDGJP2DRHfMYTVyd6JITP05OMDAo5GDLo0zKAs1E3dw5g8FNr2NFc2lSjtvyBE4N0OQo5K1kOSFAQ3Ygr7inrjEohxTsnwEubnjWBxxQooGTzEQUVMHFFG/dww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJo4ktLl; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeguZeA28eRRnkQvex8fxcOXsKaZKTJE7i5qjkRwtVllfn7krY9Ml/PZu42DOOitx7Incte6D+8vFfSunuhU8mQG7s0NbCZe/rYEwI5OhsiELH5aZ+kaY1kFAjRpl5FNDF5V+uwE7JP9ajQcqumv3G6W9H7D6U7AJDUU4m8Y/VmUSjB8pUvIJsz7lNLvN/Jaqnak+T8zDhnP5yYdrrHEDg6mop+/6EtyBMqbwxc6z7avOrPoXUUUz9ns3KS3AlwAYjS5CK467zu1DFD7nFWav2Nc9ety/n+ZH4Yy30FbMyZHcSXscJD6s3O6nF/35UADJeZAoIqK9TA8g7qSYW48fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/tYZgmkL6fhnd2uFzF7MH07EHO0i2sJa3pAirvOGF0=;
 b=xmZehMGi5n0RI1Wn3ZTB7j//5UM0ks+CawIZk3a8ojrJTtF9+a3lvCqcXUb49R/rtw1hxSFjAuMsxF47RjGno2Ew6CfSCtSVvTtUCx76iyJDiYLzmZRwXDRV5VX9qpAHs/SCxJP+2P7IX93R9CEa/E1O6iMZ5rOn7X84Qlz/WgkIFg5eLClhNpoqgOKqbchPDCFo02aINAFDPpQZe5OWxYTf5cvFKM/yBxUKygHF39mzEp7svtH3T23jgpfpEoXm9u5ZyGQ2y+iQKaAICy5nu6fI+/DRIoK6B05xxgcxz2J8OeyP41cEUwPvfo4ur4TW1nJFJL1VuvzRWRT9RiFyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/tYZgmkL6fhnd2uFzF7MH07EHO0i2sJa3pAirvOGF0=;
 b=KJo4ktLl2B0Y9JIfrPvOtVeEv96UYwXoLOOdhpj3BBCAHkxY8HB/1VhQctfsO5CsUbCFaCGimbHAzQQKl/7rGYJshzhW7fMdAthG78OZ1ACXq2d0dK2Sjs8pPNzmRqYSPLE/L3C68z5lRbzVkmOuhzC31gXXSPWdxLt0trWduJuuZfvi5852/evza9WQp2/CPt2ziB5vgFNJ5+GCyS7tFjQ1Oaeg6WB+7RGxjs5D+RV8mNEofiAOb4xIKZwtEuI68H5fsoxr6V45Mrim8qvUCyGosOMj0WChfL5G8IJ/hAsp06BHr8UNv40IZJ75Ev5q2MJqToK170u6b2sMvkl4Kw==
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 04:47:46 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::39) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 04:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 04:47:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 20:47:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 20:47:33 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 20:47:33 -0800
Date: Tue, 4 Nov 2025 20:47:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Shuah Khan" <shuah@kernel.org>, Will Deacon <will@kernel.org>, Alex Mastro
	<amastro@fb.com>, Eric Auger <eric.auger@redhat.com>, Kevin Tian
	<kevin.tian@intel.com>, Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, <patches@lists.linux.dev>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the
 range is already empty
Message-ID: <aQrW4wRSqHj4Jazt@Asurada-Nvidia>
References: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bee36d1-7211-46ff-3975-08de1c267665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zf+CwWdu0RLjUJ7flyZMZPPTVwTMIC6ybbmR0PHKBBVjXtpz2ZRaRgnGXRI?=
 =?us-ascii?Q?y+qTAmHlbze3cVhZqwkLm3xtebSpRoyP51+xoV29Dsn5I+l8KT6/9qRfxttg?=
 =?us-ascii?Q?tnVYBDxmZIaEGwdu8S11imxnCqLulgbPdDmY+hCGxGo4AavuJAoiDAPAq3wi?=
 =?us-ascii?Q?p0JuacIPDyzP/a9r1LDjj0AZVl6H0F3MlTU4yMUfH3+J80+qJkRw25XUUNhd?=
 =?us-ascii?Q?lxycBaIKCMQ17OtdD2hdsbfiNvdmhsPddsyIIkiNs+J99I6ujqm5u1ATI7jh?=
 =?us-ascii?Q?PNbqVnfR9dGJ0F5ieoHJc84EMKdsJhCL9+PndkcN/e2jW094hTP/lJEP6r2I?=
 =?us-ascii?Q?BLXuqIyAxktzHnbDEhRUOaOHLqVhOaiMuyUsKnDlis5OxsFO5s5vRelSeW6j?=
 =?us-ascii?Q?PFUGhu11ryybYQ4or82omi9KpS833mq3axokzB6PtOY47EyZJ3NaEO1E5KKc?=
 =?us-ascii?Q?4W03X7KvbI/sg4e4L8XmXeCCAS+df3HxYLx5HaZAB7lLE21TEh/vfmSFd9VT?=
 =?us-ascii?Q?W46aWv0FUdGoB2nd0mWLgzJlA73uclmw8nLwemf9yItxF9/L5wn5NJCeXnlx?=
 =?us-ascii?Q?g1wdNZ0cCbIL6X4x5VFAbW97ty9Kejwv08wjamZp+vvG7EvBxnJ9hbFsNk13?=
 =?us-ascii?Q?iPqaBZz0f3d78Q2lssn9cChX8lUxs0fl9jVEh/sF7csUEJvJUxY3Y0j7yHkL?=
 =?us-ascii?Q?QdkUsYZIaHO3+uxc3HSTId+0M2aD3uUZbj7jR8Y69D+mU5nqfqcY2Hevmq3k?=
 =?us-ascii?Q?zZFL3qhRjOnSI0PPatqoCKTDTHfIIAypjF2LH4J8E0UbAggkfFuUQ5ML4snB?=
 =?us-ascii?Q?/L50VRhDolHMptCXbXrJRz1owc/dr4vl3Kb4oXUG4q+fqh3kNKSsdU0FtvsR?=
 =?us-ascii?Q?CnkuqL7taToE4sQF1nNPXKUMj2plHifhqWhdHcqbVOOS7btXQ0y1QAXHTXcp?=
 =?us-ascii?Q?DjOHbWaZcG6a71qnaKxbCrZpLlnruOU9WQZmOgA3LkCVJg/TvV3dSZOiEOny?=
 =?us-ascii?Q?VPA61vAwPd2Lu5jhddbenpYrM0jUyBiz1mjgHlqPNIIvFX6byq4LCtPmIX23?=
 =?us-ascii?Q?gDvdQY5cOw9+xbs50vVTw7ZA+pVyDZkcig0tW7hhGRSW/ABuZdszTlaN25CP?=
 =?us-ascii?Q?voTFqvA7yjHAYh7vrnWrRQvI0B8/XHzWu7JL00UBr3oDC498FNHoAEiEM57E?=
 =?us-ascii?Q?m7fDcN9n3IJZWz+BzU/djuEGIRErL2Ds4ywXlAURV4oU32vvSANV+62iKBZV?=
 =?us-ascii?Q?6eJQ7F5DgUnjGuLTZCMQLUyGvLis0e+Di1B+yITW/GYWkY5a45wjUNXRvGnW?=
 =?us-ascii?Q?ra8JarIsZ+NuFNohd3n3E96WPi+aQJMuXC8g9Feb3dplsw3k+pdAiAfHlP3C?=
 =?us-ascii?Q?S/BtB+ygghnFuwLaUwYoi+MD3iklgZwgbllOGxrekqeEsp94VynouvJis/Tj?=
 =?us-ascii?Q?MaHEN1wZbHHmlWVRJdj5KSJtuAn6/yj9KPanHi0VF1UtB9FRoR7cqu+ap24u?=
 =?us-ascii?Q?RYIZbn7sK0trKbRdIdanXvXFNO9rIYE2C5eZvrHPGK3W1u3E5eTebHcJDtBz?=
 =?us-ascii?Q?Eh6vNcb41JCKBEk4hujtA+QorwV8zN9XTp3HvO37?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 04:47:45.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bee36d1-7211-46ff-3975-08de1c267665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

On Tue, Nov 04, 2025 at 02:11:49PM -0400, Jason Gunthorpe wrote:
> iommufd returns ENOENT when attempting to unmap a range that is already
> empty, while vfio type1 returns success. Fix vfio_compat to match.
> 
> Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
> Reported-by: Alex Mastro <amastro@fb.com>
> Closes: https://lore.kernel.org/r/aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

