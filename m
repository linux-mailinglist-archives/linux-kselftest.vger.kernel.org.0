Return-Path: <linux-kselftest+bounces-31922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93536AA1921
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9209F7B0EDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215D2517AB;
	Tue, 29 Apr 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLOM3K7X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D861A5BBB;
	Tue, 29 Apr 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950087; cv=fail; b=tTEBxyxhwKOuHVdCTiWsDO+3j/2XCnMuk2SVHyZ5ynkg4f7xqTGa3XLsaFrMeQL/RFH6aT7zkaMjyH+nACtLUVjR7FJJLzP/f1eI9W2ZuTb5NVgiSdq5xe833rumMOea9HGlo4Sj/tLAVGYe740uANjRl8a1Wq4sdXl+uRmtC+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950087; c=relaxed/simple;
	bh=Vy9BXMe31Vjpq2lw4by066RvSjaoPvtnjK+NXrpoDgQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTGxsY2BujygBltIJ1rwC9JEZzjlWgVhjjfnqSSmMl9mdOS8XYeFk75JL15UFfMoUfAIm4DWLSK4zr7yDOzoMHYSt5KGCRoU/xrZN6hJEz+dIimbZxbL1ePbLpW8k7cZXdUMiOzP/jHB+NvJ5/iPDELm+venCWmo5OxR12HYAvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XLOM3K7X; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etGMzzT+QFgLPQRK+EyJAd3fFondOXZFjVYPDovXaesxHzrubFuD90lDCf/jJLc+Vr4fC5yJ3NJq4dFiCJKu6U+IpvRzFCUzzBFg12ZQjkeQtkqG0G+VdXzsYXjyfQLLk5qs+MbfuoEA53z3CuWLJGXvdK0FhwADLQB0zIfDZeEhebjH4UAtzZnSv4K9L/CH5lJJcut1ZKDSvsyTd7Wm6tGSHL1UTfSRl0hltBLt73/nQQZNzjMihPp5bU0GehKVrFm40pLt2adQk54ve/z7DtLkhYLcXeMEl5d8+N48ifsOt5C9EZ7lXkrFExQWqhbMQ9H37VlJvoFGcNVpI7MxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIAa8RR+zLmb/ttWvevJREq2xpQTYD3f65jtS+/vWFA=;
 b=rFwL7bAe7KkR0vIT+NwQUQ0JP0xthUfr8q8kTjKuR/ltE48vq/Iv1tUDVMmr2oq8hYQQRx7w7NtoO2ABygXizJOOMiU27A9yYeDrt5Su9ADXFJY2NxGFNsdU9DoWz7gVnpnU6wd7A71rxDr5fBnSMrKx26v0QZRlvdjYqJyJAw+F62RyHvmV0kOjjW/DCkmFcrJxIHvSP50pkUMBhmUbpRze9mbJ/UDPQXMPhpJlxwyVlnA5gw+mFwnHAj4SQVp0XTSk2cm18d9kVqHXJR+0SvJZk2H4fFE6XMEJmg6CvhKNy0jRrduwvWJC/gksog/iDDR7y4/lx1N+pbX1ZN0cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIAa8RR+zLmb/ttWvevJREq2xpQTYD3f65jtS+/vWFA=;
 b=XLOM3K7XwMZhjpRn3amBAPWCN57MBkamMBSdFD+Urt0B9fYnTcZI0kMIXDydaUSp+k47gepMoD6XpuoPGC/Y1Sxpd/ZDMsQaezYEWozZb8qlQr/83ggIPJlbu1IVaT0qj42TrNSBJcMwIPH5gedZ7yUMWycqlfzlhYTe2aFfPv8BulZaSTSVjsSH4qBJq+004AcwpfNiJOc+flaGr0aW9U5UmZFQbdXugVh3QqmMfDZ8fxfXDpvUyJMxab90Bvvt8oI9kVRKs7Nepdb69hqfEvuaPS1oMkpPhTRFLaEK9lVMV6l88uTUFr0aDnldWwxOPjY0YIznWdcZfKFZnXAdyA==
Received: from MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::22)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 29 Apr
 2025 18:08:00 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::69) by MW4P222CA0017.outlook.office365.com
 (2603:10b6:303:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 18:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 18:08:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 11:07:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 11:07:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 11:07:44 -0700
Date: Tue, 29 Apr 2025 11:07:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aBEVboMt0OtZmt4Y@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <aBDIpz7w8wxIn_AF@google.com>
 <aBEIBKdjuecVHgpU@Asurada-Nvidia>
 <aBEThP2Bn0YDgXfu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBEThP2Bn0YDgXfu@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 163d541c-ca00-4a4e-bae8-08dd8748c6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ppra6eN75TASdIUrhblXnbohqu29kNJ+aeK7/tSM1hAG9dpcbbn48h7hHl6b?=
 =?us-ascii?Q?yGDRDoqOq0pUZ8F/1A9JJhI+f5fJcnn5T6cqYrgSO5vtkQIg/G0/HfhzCgJ7?=
 =?us-ascii?Q?rzPSCW+k7IR53YshSTdAbz4Apmyk8HxfKzUpb2K0+Wb4RnNFn+vt56uSkc/g?=
 =?us-ascii?Q?R3QewYbKdyKXwaVQfOkPtSw0ZXW2MGA5M+5LrC6DASk9Oit2bLPsmNxTDdBT?=
 =?us-ascii?Q?vFqnNpYYtzWjJhkFs2pTCcVqSMrsWuhEbZlu7B7+1wlKFJbmsBfg+pDaIuVp?=
 =?us-ascii?Q?9dl/85209rOv2ZY2936hWRzwRXMN18+9Tn/F1EAeoXBUEMklr4RLozuQ5yBy?=
 =?us-ascii?Q?gYRp+w86DEOvawB6ZHtvlo/g/XzgNIsBDveygY5M5LIcMeii5s9mDlC4IRQm?=
 =?us-ascii?Q?Qw+uVivOW9I0OuteJF272zX8g3arESZDfHaWilM0ZcjhaaEtad727GDfyyFa?=
 =?us-ascii?Q?aKlodCdqDQHNStuwl45QDimUolCRBbrX4fbErWEp2L0CuYxeBXz/TCLRPcip?=
 =?us-ascii?Q?YHfEapjHh6Nilu/8o75FgPp7eJk4Zaqw/8+g26owUDSc1N0Q5zj9cKUmzBca?=
 =?us-ascii?Q?+68UFlabt5QY/cRyfBDoF1an2ww7/5aiHnxJxdBx4TDI7azgWS0irE4GEJyU?=
 =?us-ascii?Q?VgrFl/fcFsilpNIvToAjQnfZKycdrRR9DKTBEjwIZS3pznx1OdvUgo2vI154?=
 =?us-ascii?Q?I8lKmPBSSC+p5LkDdIJrUZnV1snAMa2n4zxcrUzuBFlomZNZzORHXZKgs4KB?=
 =?us-ascii?Q?56nggJDEQK7j6s+LnbgT69E0VGKB04hsWkFJs5aWAqgHzV15vyZTYUGRlFr1?=
 =?us-ascii?Q?asmq3+6DZwQ20/06zjqXdlBCvdn4J4GtBMDrYX0aA4kWjn6tZ/BH2+Il+DK4?=
 =?us-ascii?Q?qs8Qm1/iRXE7B/z1IPmxMTOGnV5qYeCaz3x/STMr5+A/cPsAxPgFPu0lQdVE?=
 =?us-ascii?Q?mHKAve9pRjUNdR4X5rit+yLN7iu7ZmI6Gdh2yCTI2ID5RSz2ZRY2uB1G+sLr?=
 =?us-ascii?Q?MtbcuuxmILs0tdSP9jqDMTSNIstrExVHr5psV/NhY7daLHjdGh30/NV5AicO?=
 =?us-ascii?Q?esZeEwBe0PsvuFlO9RKk5899rlq0nSOayzX9OItbuiM+zG6En4xvLDWeBdCR?=
 =?us-ascii?Q?lLDLpmfTgI3c8lSey/yRKMhZTQ77jk+nqjYjnwqEGac6oyFs1/82PdLWHtaB?=
 =?us-ascii?Q?xPh3tZ9iQbeFaADh99d9ZZ8lMovrVp7XVDqk16P7imUEhBBTxgVF8N9H+H4b?=
 =?us-ascii?Q?Z9irjofWWJgda2YtFwvZCFsbfoor2oJnjxvQg4rkUPxBnn1/cYOdfQtI+Bz5?=
 =?us-ascii?Q?Z2LdOtiPxCDVBeaqwoZrIQXAbZBRNSPB7Wu4mmNi1AjUeiF7IcixOqwixe7C?=
 =?us-ascii?Q?nQTozv7F9+SH4b5HLlqxtHeVBTV0roHQI+b0UTFPIj79ST4vNMesRCsfQQZ1?=
 =?us-ascii?Q?6EDtzU3HkeDlvUxvghn9fdP3BsKA2OiFtkQmZeoSM6DPpwPwDNIjVpatvpP/?=
 =?us-ascii?Q?59VFcEt9p5LKhG/vyWsNRLxVS8MEfKlYFknl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:08:00.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163d541c-ca00-4a4e-bae8-08dd8748c6ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

On Tue, Apr 29, 2025 at 05:59:32PM +0000, Pranjal Shrivastava wrote:
> On Tue, Apr 29, 2025 at 10:10:28AM -0700, Nicolin Chen wrote:
> > On Tue, Apr 29, 2025 at 12:40:07PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> > > >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> > > >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > > >  				       unsigned long vdev_id)
> > > 
> > > If I'm getting this right, I think we are setting up dependencies like:
> > > vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
> > > which ensures that the unmaps happen in descending order..
> > 
> > Yes.
> > 
> > > If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
> > > core code itself? Since it's a driver-level limitation, I think we
> > > should just have iommufd_object_depend/undepend in the core code and the
> > > iommufd_vcmdq_depend/undepend can move into the CMDQV driver?
> > 
> > The moment we added iommufd_object_depend/undepend, we already had
> > a blur boundary here since we had no choice to handle in the driver
> > but to ask core for help.
> > 
> > The iommufd_vcmdq_depend/undepend is just a pair of macros to help
> > validating the structure inputs that are core defined. It is quite
> > fair to put next to the raw functions. I also had the notes on top
> > of the raw functions suggesting callers to use the macros instead.
> > 
> 
> Well, yes.. in that case let's call the macros something else? The
> current names suggest that the macros only setup dependencies for vcmdq
> and not any "two sibling structures created by one of the allocators
> above" as mentioned by the note. Maybe we could rename the macro to
> something like: `iommufd_container_obj_depend`?

That's the intention of the macros: to validate vCMDQ structure
and help covert a driver-defined vcmdq structure to the required
core field, as we only have vCMDQ objects using them.

If we have use case for other objects in the future, we should
add another iommufd_vxxxx_depend/undepend macros.

Nicolin

