Return-Path: <linux-kselftest+bounces-33204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E351ABA217
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FA24E6F24
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478A27817C;
	Fri, 16 May 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQAd8iHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BA27701C;
	Fri, 16 May 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417354; cv=fail; b=jZzpSyB5sa4yUjuj73+axemCWxkDuCdgKh5+Tr6Mluuyd9+KfeXu57Txe7ok0xHYmA59vcavWuHxQIYlBUEpIgGt86eVu+5Lmxx6wAtTW8ZIapp9MeHYvtFrZwa2V7spJ4WUjGzwETu6zrKhmd8SEajDKLGgVkVEpXifwkbkFqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417354; c=relaxed/simple;
	bh=STQnDVT7NIjB782rkHrbl0ojbQ+9b4iHXVfFRGlrnbI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOaAriOCQ3UPKRsLa0Ij2WtaH4Qq7QZi34zMHX7wvSBVyTvZ5kgwc/zBbhIlXKYL9WkKzr6FgcU+GewVQnpSmguBFYX69DubgrhbNC86FrB45Sb/jtt3acJVczOCSswHWU1011TuIUO0hhQ3NHSq5TQ6ONpv+iXmcEMdpM7M9pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQAd8iHE; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBvbZdsAyyhW7cbRBIF3z9fnsU4OwRTUt/cwmJDCg8qwUzXzgcQWsi/XIuLMPqpwp+an4qgeZtYUN6jkhlq9pCWZ8wvXJRSkU/wYO6sM9iC1vJQDA8I6UZrvVStxlzSZ5NOeXKyUw4O31sWB92k2nLyHEPZAqvuDWxZDKKzZsXsGBgOz2ZaWpYpupnIKwFisRW7/f/83Uh2MYOCq6rS7spFxSrHcjGfx5wm8hx5fQ8+trYfcU0XEirH9q5AuVpGKE7ZlLnlrT5USJo0xy7KWcCag4WOeqvHfzfqBawp7n2Few8I9fqpdXmLSk4cE1o7Uy39hlT6Dt74VEXWBhlaajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBuix9+5i4O7j2nW/2+lOP/4K0j9Eh3l3iuhLALehy8=;
 b=vq5Avv0cVv/8pGgx94pnU5Sc1o07doIvZjoNcuHAemF/xAOzr8kjbvVMlUImFcmPuHihse/LLZJ3h49YlMxCyl4bWCfJes4Rpol9FYp7RwzchDVidabU5VEUCzbZwkZVD7/94o2wYGWScFbR1MkL80HFYSBtuRcJWY3VrajhJXx0OM6yXnaKfRxAXgOQ4N3fMs61TIYL0pFpbwZEGfbce17b/VlKk9Vyxx7sWagkfTDps1TOrfQjQnjHgxJ4ObTbMDmxxp6bxuKo0z93d5nFUkjqGtWzxuErTk9LMod9R1RUnjfxhrdbUD5C7+VcZDCeVJDiDdlInv+v+j+LUo3ZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBuix9+5i4O7j2nW/2+lOP/4K0j9Eh3l3iuhLALehy8=;
 b=oQAd8iHEq+SPoeIfkCuJW6h16jEX4nMtXIpkzWFttuQgz7oXkO4n1Mw77Yb6zKQfwwtuK3Nwzo6DzG9ZPshvqtZWpFvsM0CICm0Ba/SedQOUgg9CA836OPFzu8uh5M3av4amVayLy977Cj5ywInFI+Sfl7dnw9yGNq3pO5a/6mvxNmf5xqG8H8ovggxwnVZkvMi8VXA/UQ21cB4xts8PeujlNcyW/sDfRnpV7qaoOJkQu8ShnExamVqZ0aWo/pIdhhQyde/H9J1ZuD1LFgrYOvArbOwTXsuPDeqnWn+9iEu7Ij4TVYYWGPs+d2aNee+HVYusBJHe3xOgp+ruQWP/Lg==
Received: from SN7PR04CA0157.namprd04.prod.outlook.com (2603:10b6:806:125::12)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 17:42:27 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::40) by SN7PR04CA0157.outlook.office365.com
 (2603:10b6:806:125::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Fri,
 16 May 2025 17:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:42:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 May
 2025 10:42:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 16 May
 2025 10:42:08 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 16 May 2025 10:42:06 -0700
Date: Fri, 16 May 2025 10:42:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 14/23] iommufd: Add mmap interface
Message-ID: <aCd47XNQPL2FUx8S@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
 <20250515164717.GL382960@nvidia.com>
 <BN9PR11MB5276DD2F2CDC313FA04155C18C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250516132956.GI613512@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250516132956.GI613512@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7131b388-4b87-4d0c-e4ca-08dd94a1065d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcrO2OwQ1sge5Un64RarzrYVdrEoowPt9m81uwqTcckXQZIl7/MpbdLewgI8?=
 =?us-ascii?Q?xkFAUVtD02/c/oKYWLZYjkDFDizD+HDyOWAqzUTYswDQvoQfFWB87sNbKxou?=
 =?us-ascii?Q?PxwzgLXOywsCorXjTec9c0MXJgbiF4YkQPhctgIhzhtrIH/KnMzhfMDUtSNc?=
 =?us-ascii?Q?PF/fimBsdtTn2r548XpYyB2O++8rSbn+0ylGrgUZWn/P1RlmRtr7YNO5YQho?=
 =?us-ascii?Q?DGfOmzBFyh7Ik/USKGMs6yX9flEHVx6rtYCKPi0nJ1AI/lhSugeW8KOquY0/?=
 =?us-ascii?Q?1RltOLmSFLzHTLq9cjDApF7xlXnPuvDLjpUeGNTe8pI1qtKwSaEXx1NHR0Mx?=
 =?us-ascii?Q?KMLYA5FBEGpuqdPekAdi13UcSoHeIsvWIY5A+1Uog8V9wDMnq4hDlXwK3dXg?=
 =?us-ascii?Q?gcUweroVgpiDiD2GFSsMCnyf4gc5chHFDh6Vt3nIR1gqYfNE57hj4tt2uFEz?=
 =?us-ascii?Q?liAQP5/w+zZEQ8cozHdI9BCD5c/b3bW3CBiKu8lFy3jQ4JfDSHFnCNSi9+xl?=
 =?us-ascii?Q?QwiFs2eCBEu7sfZ+IEBO4SvN1ZBvyOY41enGzgnr9CNnKhiKx3whiqMclk+p?=
 =?us-ascii?Q?uj4tHS9Yld8p3Oq+XtsyoxxN+SJ/p3YRnCgAMw05aEIlUHgUNji2WLbbCO/O?=
 =?us-ascii?Q?M/znRCFxvOF3lj8suJ/+hha92tocYtP7+9AK4egK0je2A6ZEe6j+EFM6pSu8?=
 =?us-ascii?Q?wB3+BFy+oYVCgXKSvRAZc3e5q5th/abQhmihARTpU72vok6lTx8gdRmifua2?=
 =?us-ascii?Q?zLCx3G0EmYsqICFEV+8wE3PK4thLck06YKEle37dDOhZpdl2NJb4u8HZWl6W?=
 =?us-ascii?Q?nTv/wwnKOtTOpRn8lNE5o9+Y7p4bsYwBa3ZI/QiDI6hMZPUuZNukB+vDXLH1?=
 =?us-ascii?Q?/Y4UJKBMkZ1o8Q1jOX1HT/93gmhUyKSPFNMbZRb7I8qdmWRTjsSXTAJwh6ES?=
 =?us-ascii?Q?z9J0h79J5lL6T3douUD8JfGskRC5RrUQg8MHfVSU3P1tvjU7LdMmj7VsEbMW?=
 =?us-ascii?Q?vvhVdZGEQZ4zgUqcUEeodqXcJLVBH5pmd75M7ORiCGnhWltwpPOITaC81VLH?=
 =?us-ascii?Q?2KgnQ3VQFbJVkCJgBMo9EeBf/T3lVly14LvPD0UkvilnPI8ijdRUpke/YurO?=
 =?us-ascii?Q?nPO4f+OVehoglUY4H9jibxQt8Dy7pMpXuVcvhNgztS3Rgw+Hn8JYy0L1qfFf?=
 =?us-ascii?Q?WrLjx+FNXnYGPmfyUJ+Bgil++QXmnlmxKi/WMi4dT3mKEHWMMkHBhihNDMrf?=
 =?us-ascii?Q?cF5OgdO0b2Rxiv18j2R1DmKwEYYKOeX8Q+zTQt3iQGxk+v7/8NkYPN9UMYUq?=
 =?us-ascii?Q?7kC4gUTZteLcZK2Oijki8xitRs2wWtzw+ua+H7izQEYV3ZDwa1Cv25tmCQDu?=
 =?us-ascii?Q?zL0vPMjtbOI7KqSuZQXePnRzJeNDEoQ2Ncl2q802wZrrfhktok1B7uMeIGk+?=
 =?us-ascii?Q?D5xzTw9CX0A3DW9UDq0UDkBdrUCUPKA4tMHRA64eyOfUFvWOeaqKA1MgvRRj?=
 =?us-ascii?Q?i5aHfmgTHGdVRS9IfOY20Bk1dNYiWO9CdmEz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:42:27.2542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7131b388-4b87-4d0c-e4ca-08dd94a1065d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

On Fri, May 16, 2025 at 10:29:56AM -0300, Jason Gunthorpe wrote:
> On Fri, May 16, 2025 at 04:08:25AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, May 16, 2025 12:47 AM
> > > 
> > > On Thu, May 08, 2025 at 08:02:35PM -0700, Nicolin Chen wrote:
> > > > +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> > > > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > > > +	if (!immap)
> > > > +		return -ENXIO;
> > > > +	if (length >> PAGE_SHIFT != immap->num_pfns)
> > > > +		return -ENXIO;
> > > 
> > > This needs to validate that vm_pgoff is at the start of the immap or
> > > num_pfns is the wrong thing to validate length against.
> > > 
> > 
> > vm_pgoff is the index into mtree. If it's wrong mtree_load() will
> > fail already?
> 
> I'm not sure? I thought mtree_load will return any range that
> intersects with the given index?
> 
> Otherwise what is the point of having a range based datastructure?

Yea, I can confirm that providing a vm_pgoff that's in the range
(though not the startp) could get immap too.

I am adding negative test coverage for the vm_pgoff/length input
for the following ifs:

+       /* vma->vm_pgoff carries an index to an mtree entry (immap) */
+       immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+       if (!immap)
+               return -ENXIO;
+       /* Validate the vm_pgoff and length against the registered region */
+       if (vma->vm_pgoff != immap->startp)
+               return -ENXIO;
+       if (length != immap->num_pfns << PAGE_SHIFT)
+               return -ENXIO;

Thanks
Nicolin

