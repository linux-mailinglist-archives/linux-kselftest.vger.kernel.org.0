Return-Path: <linux-kselftest+bounces-33089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28CAB8CE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E0616B5ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE3253F05;
	Thu, 15 May 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hr7tepxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AD19D07E;
	Thu, 15 May 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328133; cv=fail; b=ZcESZj+nzt1z6v/K8yepzhoMn3v7b8Wh9uthRN8BYq0Hn3dnn7D4lobhTkf5Xunc24V5XAyLryJ6UEnTTblyWF/y7R92sCjgH6jUATqk0itJRrvs+4dhtxW/CoCqYLAHrmBAW+Bf5y9FoFv/3WvSPTgtBhLkH6NoWwz+Ne1iVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328133; c=relaxed/simple;
	bh=A1iNlQWImGc81lLAJsy9Tr8PM/t9zU/Gqqf4oPLx7ZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlI/F13MwJdSBjilYEPc1wt4kxBiors/V2dcOobyrMXJFW1FMpp7pRvcSAZ1OlficJGsXDj0bRxoQXW4BGVp4EPMqlx5MCeUpwkeUtm2S3Ozpqvlme4D6FbgnkKaS1wwukBcrxH8duCKcdZInuqdgjVzk4p10bOvmAGExAllflE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hr7tepxC; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFke+S1s9eSn4Hd58+Cbo41W0UNacmkX/hE8loHJs2QsC0G0B4bxxIwFIr5teoAjekFwkmZWTkpv1r2W6a49nRm+Ok4U77FpnZw50MFuV0xB2gvrwWz+wbYHexvkHCDXQlQ5ZxW+I03BYHVSp3ArYGDe9FEE2jAC0Ltpvkpw3fouo13GvIhox9cWAktJpJ7BV3tAoNqSA5BMk+/693LgxabPNbKs36bvwNMHL+XK7CbrSZcxd1NGtwEc7IfAyyZqngyobtWbEQOoZxXj2kDWz62ocGI1WRzqqLbu0Ny/kfRFDMkIpCmMKQ+m1wS/C7p2Rukg32d8wdu6moez+vMDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7vO5QmpkZBVAc5jDnPvqioKpGnntI754bo8zKekDyg=;
 b=m38c9nalADTBxBatu6pDrk0VLDSs6iF9lcLCE7J2pDVWGIYLjTRYjDCaC1eb7KCu9mNsumvZ+eIUT6Nj/UgbL2nJ+Qe7s+u0elAR9QTdLFNfGJqe/r0WOnngnZAvfVlhaTm9O8cftr8ay+J0sF/YOB+8H4tCvhodo+ygW7UrnAcRxKZTuCm2lnjJkSmzkApgDaAg0K1EMEQB3BMEuNiW8fE3ZGhFkMMpht3XPfYUKRuM5bdHyOLoYAuYqLo7+3VpSe1SXclU2F5cGIqO9khy/74GJ6v41vQhTXeikELF8cJOd+D2U0figuO3W/3FudSyglKFppoFqXr85HRyz55/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7vO5QmpkZBVAc5jDnPvqioKpGnntI754bo8zKekDyg=;
 b=hr7tepxCQufFwrbpZJcCMs8fSiEIsiv2G3PGpnHJQ5jHYa2JwP/uB4czOEq2igBiprBLUUGF8bLdj+x6Ys1B40IbnRuLTsJNTybzEMpiUYjtUIGWsS0EBcbeqmznGx0pnczsKxTqUHycN+MQ4H6l3wI+ZCXb/uTjwq5peEDUU7BlGIpNSX7Z1lAO2Y2NthZxv4MPerSJHFfyj65Mvod36II652zpwOpFLiSRbf0SJXsk0DCBQgcyksnZRkrygecFzcXhwofCpy7h6EgWuJkc5XNreM2kKfa6L8e5apTQDWE9+WUH4AS3o9qXb41exVtyXwtOays8P2yS9DX1lgvYjg==
Received: from MN2PR11CA0008.namprd11.prod.outlook.com (2603:10b6:208:23b::13)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 15 May
 2025 16:55:28 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::f2) by MN2PR11CA0008.outlook.office365.com
 (2603:10b6:208:23b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 16:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:55:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 09:55:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 09:55:04 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 09:55:03 -0700
Date: Thu, 15 May 2025 09:55:02 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 06/23] iommufd/driver: Add iommufd_struct_destroy to
 revert iommufd_viommu_alloc
Message-ID: <aCYcZmDEcWZ7Plw6@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <fd387a4e4efda1905e270d28986e4563dfee52d5.1746757630.git.nicolinc@nvidia.com>
 <20250514182600.GF382960@nvidia.com>
 <aCTtQXQ61LLbHk6U@Asurada-Nvidia>
 <20250515124911.GH382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515124911.GH382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8c9234-fdc0-4e7f-043c-08dd93d14aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ax+2zGXNizUu9ZGsbKBmlGUzboyaY5R+tedlPE1EU5eR1hOFQEpXYkTVS7hv?=
 =?us-ascii?Q?9M3nN6G7J4gf2wYGY6iiTBSg3dC2IZTm04OckA5ZFY490sPOYuwaTqa93E+w?=
 =?us-ascii?Q?okksCxyzHMQz6aAY9mHLJsCvLRbckNDB3k2oEgBzAeoiw/Vd65iF7xx1Xbub?=
 =?us-ascii?Q?AXORFqvwKH+dzFZTJhpllRr5sGZGQzmT4ojm4QkeBaC1fieLRnv7n1/w7g9O?=
 =?us-ascii?Q?d1dAmlLgMH1vZIQtC6LI+aQ9X6p2iESloTzDm3mB3/p88SI2zHp7kgCh/cWH?=
 =?us-ascii?Q?bAfTPjUETfiubHqfI3k8RmlHXJtDGQGUg/sWctTqYjF0nOa5ZXVjH/4uoL4M?=
 =?us-ascii?Q?We0yZCVMQrvW5TwuU7MtZ3UFy1ymOkaj3jpkenimfqBkOWYNcvft+lozGQsA?=
 =?us-ascii?Q?CR7e2UZKj56CKySGKTYmepvuSdjBjPBd8R4xa6pLExMiJe0BiPCw9PgDFDNj?=
 =?us-ascii?Q?TOIvFl8Tee27Hki9l3xyRW+sGz2CxU4ykWJHZb65hM3fLHw7R6Z8QQ1QrylN?=
 =?us-ascii?Q?A6RCuoibjhnhdTYyEvReaD/ceIRQvRVvl1zw1n95V0780mEgsz7bKnr44hvX?=
 =?us-ascii?Q?P9SIKmaF4nj5U7N5zmxq3Xa4JhiorEKBef0YbU4IRJvCdLrIzc3FYfsuXJsd?=
 =?us-ascii?Q?1uWkjvIWPFeqc+rpPQ9KVbzWd5BzTlyM00DtBXhA5W+psPSi2ekpIvAjZfCG?=
 =?us-ascii?Q?Eg4WTdA7lVLVf2obmXGvEWDi0Mbu2jXOLsk2vQe8y/RK3TEZrc/G+IUoWAOh?=
 =?us-ascii?Q?PqU7DzKl3bcfAFGLZpbD5GyBTezB6FZ2dKpVp94OY/2Wch1/Vaxj1M46NrEh?=
 =?us-ascii?Q?mlIOw4r++btGiChWo4018gK3L6xL8Hx6gO7N819q2w1dYGk+wHnokhpldpnI?=
 =?us-ascii?Q?gySM4G9v/VyRWYxNa+abDIZO9tF025+x37rF3g3eKiZZ4LU1eOvJ8TWGEvBF?=
 =?us-ascii?Q?zq8KAjE863UpyJnYeNoCAf5B8mc2S50I1y0aHiNxvtInKyFKW/p/KyAkNCfy?=
 =?us-ascii?Q?vyW1OC7kiO5dRlkJoZb7d1o4ydtUbSbPs+beVC4CFnRY8kSL9yW0yjJ1GWqL?=
 =?us-ascii?Q?vVKN0NMQypoMEM2QmtF2NsEwpp5W5SE0wqq9GHnp1YYr3vMX8J2ot8Oql+hr?=
 =?us-ascii?Q?3t82Iy0PcdCxubsXWzeqaJuphNfD4wVn9tgpZnRqcsvSWqSFFFME4SE03f88?=
 =?us-ascii?Q?j/vOYQh+2xqNB/XEhEO9sLyDc1F7DKgzzcqL/OQnaa8+yn7X1Q5GsD/kw99/?=
 =?us-ascii?Q?tDWGkUWr5vdG4xJ4rrG2V+ywR37BxI+x46uI0Zz2NVAwCUeOgV6lq0p/2GAt?=
 =?us-ascii?Q?KOetr/IngIJG0h/F5bMYXNiyNAtcAp0h5Ob0ZoY6lw4CSBEKJa3Nxg5LdSg2?=
 =?us-ascii?Q?VLITbQ/L/AbUT2iyaUIJJBiGJKIJe/vTlFkqtJY5UZfeQWY46FrWWxBDzOlL?=
 =?us-ascii?Q?cFg/5tcEIhZ8HFvDdEYwJ6g8c8nWvtWLaogLKIMF+2j9qJEaQq9XCXwUY5bs?=
 =?us-ascii?Q?ClPhDrIVmawpaqw/UIfrDtbJz51cyPE6lCE1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:55:27.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8c9234-fdc0-4e7f-043c-08dd93d14aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690

On Thu, May 15, 2025 at 09:49:11AM -0300, Jason Gunthorpe wrote:
> On Wed, May 14, 2025 at 12:21:37PM -0700, Nicolin Chen wrote:
> > > Then when the command is over the core code either aborts or finalizes
> > > the objects in the iommufd_ucmd. This way you don't have to expose
> > > abort and related to drivers.
> > 
> > I see! Do you want this to apply to the all objects or just driver
> > allocated ones?
> 
> I would do all the ones that can work that way easily
> 
> I think it would just be one patch, replace this patch with that one.
> 
> > We would need a bigger preparatory series to roll out that to all
> > the allocators, and need to be careful at the existing abort() that
> > intertwines with other steps like an unlock().
> 
> Those cases with special locking couldn't use it.

OK. I will add a patch in v5, replacing this one.

Thanks
Nicolin

