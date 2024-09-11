Return-Path: <linux-kselftest+bounces-17720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCF974BA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34330B25EAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519DC13F42A;
	Wed, 11 Sep 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHUGHaQd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63426F2F4;
	Wed, 11 Sep 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040471; cv=fail; b=oRl+3LpWPH2UWkF9lYek/xwt4tf0PYre0Ama0G9nRcPmyPey5J9GepCCM+IDmyuKUHSIOZkcmF3PpRZFHUEfo7aFHy3fN/KKK1L1eIPkaA6W+mwy3Dae405XfzU7XW6akiMPntJUeorWXB2/L4Z+/vBNFBQWHRqaI0Vnmns0ZCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040471; c=relaxed/simple;
	bh=BbvsUqP+0SZ0SNSbhAwLLjtURKkk7uJa2xJ4pD8pfPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6hUJwQhyEaQOBIiNmgYvomN2DjWm6FKPLgbM843/0zxskk7FDzStaSnezpgxX492IkcW48jg/xhHu70RG+mioARlxWWqV9jtWsAYpuF9ldcfP++EFDO7KxRIrJP0YjbO7cKw1ouE4PcVAQZ653ODHK1vYH9T8cnUufembQNHQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHUGHaQd; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRotwUf2KcjCuVhGIarcTKrGvdf54JQkD/c5zvM+EHl2BahZHRwPccbxbULUY6jI34xeanIsOpncUBs++7RPyHsr1a3SSIWL+1tyu1nau2tNzoLCIb4S9obCpunqnHDMaR5+iP/O8GRVdmk+vLx3C8x48xKyo45KbzMHPKlidIriJqKHjtys8yqoxV81VwiIVRE7X0N8IuvyVPuY9eTpOMfpe1kGd6jTi7n0I55/KT9f6mqcdrSazYHECo4RPbQ1nNmt6tGfIdel9SIYRsE3srTqpFr6ngs1KpZxJmbwUcWnI/hs2qJ5XP3BjGa75v8CniVm+m8M8TT/E809G6df3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oHtX+Qs68TepqdW5sG9H03yjgWcJvz0Ta7hV3Z/5oE=;
 b=C1xUnqlcVbCx6q20w6hFaUBlNlo0I9RE3gQAv7GZTeMOF2aY6sEtFMuwp9D3kl8Tt7TSZ+Q7tMdzovhmWbP5nABMH4Qgnt9o5YppaY/8Q+T2BcDBOSuYKM4tUIAp/WW+iu0n4NC5yhwgPeupyVFOXVrM9i2MF7hwDVN/a58jBgseVsGHg/jW9ZOEBi+di7NBFH0xtoQfkVfnhc6tsLF+TlXxb3RyhfihAC1in8OITFjkFNW6OABIdvN7ObOT6kvmbOiE+4jKc5K+CjbXPNR96Y0gXxyn4lnt7oFZcbaT2VRm8u+Sf2l7VO9yF7/qdxOeMFZ45y6wb7WhMjvobWX/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oHtX+Qs68TepqdW5sG9H03yjgWcJvz0Ta7hV3Z/5oE=;
 b=rHUGHaQdYfiyUeXiXVQkEbh9hwrkGRcm0QUYZzDOekpcSMPl3lniwyaQkZLRbJo8M72UXRI7yARI7GQGtOEleJM72m970DIxpb/TM7Ced/JJodeKhXEl5twkIkzGgnB2hDmUj7h1LrL5HtijMuweyQlzW9T/2YqX0c5tegBekSe1pb0aV3HVKes9QEnhCLDzmlf0r65h1szEnXsbGyAbDYPl10YYUYHljIulyz16NH//ljXI9FTeSxMr98/lyofrL+RLo2c4nEf6kiXGnB0JilOjpoMMY+dFdAUl+wn6Oubpu5pOCyQ5mxI1aAE/7t9IGn/VAM8BtTwmpGjMYFyAig==
Received: from BYAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:74::14)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 07:41:05 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::4) by BYAPR05CA0037.outlook.office365.com
 (2603:10b6:a03:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:41:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:41:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 00:41:01 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:40:57 -0700
Date: Wed, 11 Sep 2024 00:40:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZuFJh8t62LKi3FJY@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
 <BN9PR11MB5276554A016C2A54C41C64808C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276554A016C2A54C41C64808C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: b130abf8-9a2d-4438-106c-08dcd2351793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wGE8d8SAQQne36kM9SxvKKkcwl6SLkROSIiM6Y+96eSX/R8c8BAO88winEi?=
 =?us-ascii?Q?gWi6iJnbX7yuWb9UeFW9wu0Olarqlu0QWCwAnMZlQzwQtPBDtR00ungAsMLW?=
 =?us-ascii?Q?h8SU5DN+7HbpkCc0Kzh9Upnglv1mbWQ0j1Kv8cdbdOmwLyxja+Q1sNHqNmQe?=
 =?us-ascii?Q?oI654ntkXzR2YFX5Tj5AM/Ig0qWHsOOtOeuNhhTUiKxvjQo0oAS+rvgb7+5Y?=
 =?us-ascii?Q?JlxlitV+eXKOpx90JhFrkPjIM/Kqr9VB6IRjbhEeWVd6vn0dHCXz11WwsXUT?=
 =?us-ascii?Q?dmgcI6VyTAXcWsSgP0C/s88smCdFnmZbzKZwSFQLBsL+BwA0QtrS/mExIY1k?=
 =?us-ascii?Q?jqa0MCen0Oa1M/156dyj8ow1w3flwS0hnp+AIDP+OY4wvXK0AZyitHaRPPFI?=
 =?us-ascii?Q?HZK5trmdauqOGNb7oHvroyyZ0QkDZgOVHc61CUcnorKQtuzwiFL6/WMaA3ec?=
 =?us-ascii?Q?4nd712mIjuSyMj1D0fUimmfnH8YSvv3F86wviJrtpm6u/VB1QFgk33lrg5lo?=
 =?us-ascii?Q?3BjUeXMfbRISRN0gRWiERDf3MYABTuxdhsC125FDQLaxfKV1LaGgodw0OpTz?=
 =?us-ascii?Q?drfW4ejFGVVBApIYveH5pmVwai5WBFV07M3rACXJTSbA2TZgPheoFaECZAMo?=
 =?us-ascii?Q?AY9LoQTI938xaSQ3POVmP3fQOUsB+2NZ5mj/SWGPVX7EEYfSbYsMsMPU+gme?=
 =?us-ascii?Q?/2NPExS88OCA3wfgcS5MfoW3hfMnhcHvu2camfdG4Et8++NVRsRyu4IQsbPA?=
 =?us-ascii?Q?RzHLI2izSVd+CgiJRzNBkmkSorAzGuXsxbP6TGFweXQ+J/UXtgrKD9L2SBTM?=
 =?us-ascii?Q?/gqIX7rdIxGCpJbJGfMrCntSDU8kwGYT+YgwmQCvvuJf0VV7l58SXTFHYiXW?=
 =?us-ascii?Q?miR1VK6prZESlXWfOMvNztG8nM9cxaWtgATfogL6LdtO4amm2dbcJ6kTy+4c?=
 =?us-ascii?Q?9UtXPjXlaG8bxYzJiwcSQkJ7Q99n7UeuJqqhcVQ0Kl0ozwQ3VipANpO8+KWI?=
 =?us-ascii?Q?XDM11uONR2V9Wv71RofvRzwb+BjODikdRr5usRzELtgElRnOwY+kDem7QffD?=
 =?us-ascii?Q?9/LyZ0yQQABpckMoNuA29b19d73LFdteAh7SwS7LAjvafkervg9gthU25g7x?=
 =?us-ascii?Q?TYHn774D4yylnt4uHsGolERjAXI7zLxmb8/3vUM0UZmANt7AhzoI04/5Oc9y?=
 =?us-ascii?Q?IV83lAADIpIfMG2tElrfkBzz//CoR4Zg6uUELs9vt7OfOvOOjwXZZzOBbmdz?=
 =?us-ascii?Q?q88Ti5k9Pf4SgpEjMYToMjdd6uWKxvAdu/neNCTsgJL/FRlv0Bm5Zc5vJKcU?=
 =?us-ascii?Q?ZkNaMS38b+JO+sMQ+LQZj6JzQX3t8rHvM0dXRztox63ZZfwVagAJVWb4VG4d?=
 =?us-ascii?Q?o8Xkhs+6WADAy0PgDJ3UQAhKaVtlqX8z0+hREkt2cNkJn5oDO4KA2nBsRYKp?=
 =?us-ascii?Q?Er2/jr4X0HMtO2n4mt6tFdHelK2mb4YO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:41:05.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b130abf8-9a2d-4438-106c-08dcd2351793
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132

On Wed, Sep 11, 2024 at 07:18:10AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 11, 2024 3:08 PM
> >
> > On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, August 28, 2024 1:00 AM
> > > >
> > > [...]
> > > > On a multi-IOMMU system, the VIOMMU object can be instanced to the
> > > > number
> > > > of vIOMMUs in a guest VM, while holding the same parent HWPT to
> > share
> > > > the
> > >
> > > Is there restriction that multiple vIOMMU objects can be only created
> > > on a multi-IOMMU system?
> >
> > I think it should be generally restricted to the number of pIOMMUs,
> > although likely (not 100% sure) we could do multiple vIOMMUs on a
> > single-pIOMMU system. Any reason for doing that?
> 
> No idea. But if you stated so then there will be code to enforce it e.g.
> failing the attempt to create a vIOMMU object on a pIOMMU to which
> another vIOMMU object is already linked?

Yea, I can do that.

> > > > stage-2 IO pagetable. Each VIOMMU then just need to only allocate its
> > own
> > > > VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
> > >
> > > this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from the
> > > entire context it actually means the physical 'VMID' allocated on the
> > > associated physical IOMMU, correct?
> >
> > Quoting Jason's narratives, a VMID is a "Security namespace for
> > guest owned ID". The allocation, using SMMU as an example, should
> 
> the VMID alone is not a namespace. It's one ID to tag another namespace.
> 
> > be a part of vIOMMU instance allocation in the host SMMU driver.
> > Then, this VMID will be used to mark the cache tags. So, it is
> > still a software allocated ID, while HW would use it too.
> >
> 
> VMIDs are physical resource belonging to the host SMMU driver.

Yes. Just the lifecycle of a VMID is controlled by a vIOMMU, i.e.
the guest.

> but I got your original point that it's each vIOMMU gets an unique VMID
> from the host SMMU driver, not exactly that each vIOMMU maintains
> its own VMID namespace. that'd be a different concept.

What's a VMID namespace actually? Please educate me :)

Thanks
Nicolin

