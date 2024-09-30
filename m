Return-Path: <linux-kselftest+bounces-18691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3998AF83
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B951C2121F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E680187578;
	Mon, 30 Sep 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2T9ttEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73C17F505;
	Mon, 30 Sep 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733610; cv=fail; b=VOB76T35lfT59wIshwcKIHCVmh5V2Hj1cv5lCezmWSXTjVYnXhok/5FYm9+RdXYJXQ05oIe92bb8y82SkCJ4RqrYea23GavKxH/L5I6/XXt53NxCPiuKcQqnXHRDlTIqVY+m9/h4NVJL1/xcOq07E15gyZzMXPVEnAxX543tf0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733610; c=relaxed/simple;
	bh=ajKDx0QWQbu2gv+8ipf4QRmckUJ/EqogJNaI2BSiZ4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaXd+CP8Jks7tCpBND5RKQhlUHgoFvGyi53jIWr0srBXmYqEp63yHvdJYeN2cFDd7mZR+0bR0zXaB+4EyDwqIVaiUA9gJ1hBGFuci6ve/DNjkXjxIsaMlPHPHdsI0uUg/CksjAjgU08xrNoJgA+pYh2GzQ5+oXZ/6YIn0dS5KcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2T9ttEu; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9ALFCPvghIbW8uAaMGOFLa9/rwksQx0vtRruRPwwgE8mgwNZRDCDx9fYoD91VRMZKM//3kjrmIb5RuwOeRcUDwK3AR8nESB1rMFPAHTdmpdNZYx2jQdt/KxaRQWBO5HEtFFreRmFNPaG1Wl2J1KexpFPK+dyWzrDWmJjDfC326aqzqJPfTjtrTv/u07EfARKUezzeo9plG9qF9l62YlFM4vajS4h+PXZjAX4/ISG7I7bNiBya0C8x7uyXJ3T0OjExol7/R7v/tqvS4VZ6MQVSX3KZvz3M6RI9mvU73d/qFx/9gY54ommhRpZOc4Dm4ReJsdLMCKbdwECvplJmeU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWO8Rbzd1HWSytRzd9R9DgyrIPXTBza6CCfnEacnHsU=;
 b=ItZv9QNNSdWLN2kXhKLxNaIhU61VKLCVYzNAelGWnFdGDh8dxaXEPfke7r1Xlo2QO0wnZp0ZAlHb6ghfc4wjARtxUQB8+8hZmi05blFy5MfI1oC+9Nf28k4TBxbYe5aPytjzPKpAC+DPlPsYpn6dBZjljj32g2NuMvdH9694ULo0ECBozjF2xmLoN9yOxl4GaMW3mFBYkYDkqs5b6XTZXTXTjADXjEoxHjuOjz02oY0rer/2o60qTLpX4f7C/7lqVHx7mUuP8oYK1xSb7VPMOrxKBWvs9BrO67XWJN9ItJsMU8a1r05M208W8ZHnzqTvZIJWfv/ipg3CWngoC6gSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWO8Rbzd1HWSytRzd9R9DgyrIPXTBza6CCfnEacnHsU=;
 b=i2T9ttEuRAmrPIcWuAooEIzJ/6xZfIMNZfK+znXj8dkvt6X5T0rzR+xbOHu068lU8Q9pgFaVNqqWbDjxgLSVPoFY+By21qB7xNISLOqjVfIwmPyACLTyDJtz5AAFfbDSWDPWJvVhrTgnk3AwZ9pHWaBrk5SYWkJxIMgUFXlnVbOMuvh2UxYnGkRWVvntJ3pLs5vn9R1yH8XtoNTtNjtHxCB/GcmzXpdN+Fp1Sgpw6VrfOdWREp8oOMtq32M4/qilUmpAiLmkbYTln9zHYMzfZHIxq15Dtb1sQVJvTLfRAR05vnlLW6CV3R4lZkYmKL2rnLt/Iipa4jXK7NjlYeV4CA==
Received: from CH2PR05CA0068.namprd05.prod.outlook.com (2603:10b6:610:38::45)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 22:00:01 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::ef) by CH2PR05CA0068.outlook.office365.com
 (2603:10b6:610:38::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Mon, 30 Sep 2024 22:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 22:00:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 14:59:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 14:59:53 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 14:59:52 -0700
Date: Mon, 30 Sep 2024 14:59:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvsfViW28vF+v6uN@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
 <380fe58a-934a-4e57-aa18-f4e0841b5fb4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <380fe58a-934a-4e57-aa18-f4e0841b5fb4@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf00f09-68ac-4eb3-85d7-08dce19b3b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONhqXyA12XlVHlboUzB6OHK6rxQTzNzP0g8NSTbam8SYXyLvBIn8sjKuQR7Q?=
 =?us-ascii?Q?L1bG9n+AWomdg01sIojCWnIJBOi1JdyYmdlxgW2DsWuIcYIGjWcpqAgbfqq4?=
 =?us-ascii?Q?G0UHnc9UHQ4Ydbb2MPRVa7ggruYrczGzmeWJbAqbNbymA8yTuO6/CQV629qH?=
 =?us-ascii?Q?GjPSDsCWeLV8YConBiQ09klbd9JXBu2NDQzbkrn96QeO80Y8Ol4EVcdvHYDi?=
 =?us-ascii?Q?6ic+prZlcXGCUOiRKh1iEiMPwUPWqUmAl4zC5nLQWPJQWb7hkvmQl34d54TA?=
 =?us-ascii?Q?biRzvTphMXQdaMxK0Yb5Qj82urJOUhpFOtSNu9bnwt3FyLs+AVATRNyBWiFt?=
 =?us-ascii?Q?7UJsLwYPKgbX7U4LRXvOqYn4L1gPkJ8V9aKtJn5Qp9hjChknbRKN5gP8vlDX?=
 =?us-ascii?Q?aWW3fGw2CWnlYKIsDEvpQTt7a3prjWw1EyhvZVWU3MLeJXwwy7TDu5z08hyy?=
 =?us-ascii?Q?2Rd9a2t7/bufDPLa1VYHSJy2QOcxYaJTlsfVGZDysC46QwyVGwhGKSJLzV3H?=
 =?us-ascii?Q?zGnRjybnl6B+VUXm8GtX9DboTCC4ICsQ3UPFfalew4OOOrP+f7R0kKCgJ1Lh?=
 =?us-ascii?Q?jwqI8b43NCdJTREN7K18FO5w+0d8TEQYCq13ma5jQvHL9JNAa5PxiUWzT2L5?=
 =?us-ascii?Q?WB71seF6IONqZ/E56EYANxYNxWeWe8GIvk5MYmb+OQZj/LEVURepTuZ/2dDc?=
 =?us-ascii?Q?TJ4GDyzqfij5cOTTgWK+eIY5KiIxEPLyuy60rUjGlhn+PWM1YGdZ9qmtfZgL?=
 =?us-ascii?Q?0FqwqAJE1unDX1xxCJKyRbiSKZL/VKux7tgO4PlVu16BIvE1GCse5hLkXGXS?=
 =?us-ascii?Q?G77T06IiIFdYuGi8hUsS2uHuEaFjEBV8t4vfOUPrbpj5YfMf/areAftVjOAw?=
 =?us-ascii?Q?AI9BCoY56m4q/3Sj+UTsFc1SzgaEE5YhHTho3Ph073qObhpJFCMsCBGulv+T?=
 =?us-ascii?Q?SeQLJiDXfoS9tc6nQlodkKEvVBOh3fI564ahJzI1BgXdqfZmzZdSxA5ymC96?=
 =?us-ascii?Q?B8oo9IbjoeOfxcumGteDMu99LBMUynVBis3vWJxoP34R6RTXOPcz+Ha9+6um?=
 =?us-ascii?Q?KwUo4wsp7nIQdR5hz6kX0BMKqnkvqWYLB/VAllTMbgp8ARFfRp9zmJX0Du2E?=
 =?us-ascii?Q?HfAIfWwycs+TDarxT9c3D6oqHcpbOVg2u/b3s1sJaIRPwR2lD7f7I9joZYFA?=
 =?us-ascii?Q?pRbV6SPUAFKPbusZEZzGWgpz+Xeo2ZJAuilL52z+31Ww5rm/ywqFSFteGvWU?=
 =?us-ascii?Q?xDKVFYYj8ZUX/l6pNnjMw4fKu7xpaLYZ5oW43bpzzGSPIKKqzLHsuCIscz9V?=
 =?us-ascii?Q?FW8AUDZuJ6NPYQPmviazjyA21zIWaLS5g0f+jvwwUP4zCbcaRNxULp2R+tHI?=
 =?us-ascii?Q?8LfHjer6ZhNms5bcrWsiiLO1Txr6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 22:00:01.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf00f09-68ac-4eb3-85d7-08dce19b3b77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

On Sun, Sep 29, 2024 at 03:16:55PM +0800, Yi Liu wrote:
> > > > I feel these two might act somehow similarly to the two DIDs
> > > > during nested translations?
> > > 
> > > not quite the same. Is it possible that the ASID is the same for stage-1?
> > > Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
> > > devices use the same ridpasid. Like the scenario I replied to Baolu[1],
> > > do er choose to use different DIDs to differentiate the caches for the
> > > two devices.
> > 
> > On ARM, each S1 domain (either a normal stage-1 PASID=0 domain or
> > an SVA PASID>0 domain) has a unique ASID.
> 
> I see. Looks like ASID is not the PASID.

It's not. PASID is called Substream ID in SMMU term. It's used to
index the PASID table. For cache invalidations, a PASID (ssid) is
for ATC (dev cache) or PASID table entry invalidation only.

> > So it unlikely has the
> > situation of two identical ASIDs if they are on the same vIOMMU,
> > because the ASID pool is per IOMMU instance (whether p or v).
> > 
> > With two vIOMMU instances, there might be the same ASIDs but they
> > will be tagged with different VMIDs.
> > 
> > > [1]
> > > https://lore.kernel.org/linux-iommu/4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com/
> > 
> > Is "gIOVA" a type of invalidation that only uses "address" out of
> > "PASID, DID and address"? I.e. PASID and DID are not provided via
> > the invalidation request, so it's going to broadcast all viommus?
> 
> gIOVA is just a term v.s. vSVA. Just want to differentiate it from vSVA. :)
> PASID and DID are still provided in the invalidation.

I am still not getting this gIOVA. What it does exactly v.s. vSVA?
And should RIDPASID be IOMMU_NO_PASID?

Nicolin

