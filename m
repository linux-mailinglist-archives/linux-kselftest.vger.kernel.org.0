Return-Path: <linux-kselftest+bounces-31444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A2CA997F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63F94A2DE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B728B4E6;
	Wed, 23 Apr 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiLwGTce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF79F5;
	Wed, 23 Apr 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433118; cv=fail; b=F+rQMQA7/Ztw0Yji6upmBHxyZEU5NIl8OroflNxZUN75HhNMqCf3zKgo0qeBooJu4oLgTN5GhXJOg681BYaskbFMXbLqWBLP1lo2y0KQquRxdaNlfY4u+KK7Ds7gW4IONJ1qfH12X86BhkuNdQgLXJRZ2sRzdm98B6f6yV1Lmbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433118; c=relaxed/simple;
	bh=m3/UxavWxYC9Ljeg+dVeamoYVb9+1ZfhpFGC+cqJ7b4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/kY8bIjaXJF88W4pyILcpv7cKkr0TMYT5TIKk3N8viSMuVMWWvFWiz7Ridz3U435IRVFOjSNMikemgiIWgSxS7aINBJV4YVaBX+ZOaVVkFHuVu88sbnZ8Ta0X6AhPKSfZqzUZgLa8qliyqM5tzECFxCGN+QVPmD9/eL6qAvY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiLwGTce; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX/0fgNva9pskPPQVAlymX0j2Gx3HE6rEjAR+ZxFAksjJp+OHxZ8DHn9dgAi8rj9lkoXGSoO17w2anhkXPDwwcPqt5jCluEVkVhcOPKj+l7eDa7yjraEI214vmd4MsKRagSbbjmpm3U4DtbqZ4jgNIafaUO4cAdOhckTe3kb/TeuXCYfjDN2g40vtd2zBnFFvGZSqbY8vfB9fDbgKtV/vf8DzMt0UsnV/7LK3ObtN2EgNJfHPvG8BrCrcikARI8UPWg4XzmC3V8A2HgxSiWgJa2W7AlvIC2VRMD/dkO6B3kPApdO7wQ19+2QVKI10S0wUq0KlZoUWNTGDQGfyAhnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/xkZQVdcJzkXu7XZ6WxUXeOV5MPBBy8AWJjCHmm43g=;
 b=O1UOZAJmIKHeI1BgFXTL6cljFuAlawZHzl6G+7wAWBJ0kgPCcLJQrpRkaTysm1NLhoa/ZnQwO2zw9KwxjesssSJwdN797/B88PlyTqBD19jvib5TAvkvNDJfU2+KfPpy8vp3DSjAXgkaO0HV0ZP2tDZphZJOsoxIfWB1HvWyTRwa+3qm5hxEihXobJRjPpNMcuGo0b2KjVILo2jkCLXRbavLi3czRISinDhfqbEMM4RyftCsi0+WzEpJwn/jv0NGdEg58UH0UtaMnHH+5Rg92cr90/bAZu0IfZVdix/BoCfacdrUliFBOFSZdTIiM8e4hT1M6GAoxR2J5OLuHeX6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/xkZQVdcJzkXu7XZ6WxUXeOV5MPBBy8AWJjCHmm43g=;
 b=TiLwGTceToUZYF/f4o1kIrrmuqwrvCCBAV0iqCw9fMma7dDoShtZOwgRRnzxczQjeoo50zS5ks8G9ySQC26lTYDH6YpM2pztare9TDYmaASVYxGJ5psaWRZuJ/UX1BfdD22sz3vLiv50JbSF9GhK4FbH5WSybB2JfmtJcOPZ3PQq7+2l6LJhIktltXu3/tpE637xOKJ7BSwW8FeNaGWw9r6ahtMeLYDe7rAAndQ0r+tnvezep9VvRIGwz1HyGNClovTL8dsxptkykCldRrsAo9gzbXzKVJ8ZlpqcNQM1YmCKUEOV5oFeZiRgMi+DsMJTNeWa4cP2QH2rBuThM6Bmyg==
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 18:31:52 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::ab) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 18:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Wed, 23 Apr 2025 18:31:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 11:31:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 11:31:32 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 11:31:31 -0700
Date: Wed, 23 Apr 2025 11:31:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aAkyAbO5UQRySizN@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423115551.GC1648741@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f12ffc-67f8-464a-d68d-08dd82951e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P17tZnSONwsQc8Urfj63O4TZbx/PBKjm3tBCwFghG65jv7bGxW/cp7VBgXMz?=
 =?us-ascii?Q?dn0aKvuCK5UJ8vPW9GyWHKiCVIrrZs/u29qLlUeZTbgRFXUrcRxx+EjIpf6C?=
 =?us-ascii?Q?iUewOm3NzeusPakHTW/M5hd2WRatRDnxLoUQ/mvdjKqNu3gfXUlSKtWd+XVk?=
 =?us-ascii?Q?eLQp1FpCaPn5rB99IaBNysXHW/ggdwy9IMNmegKj3H7cYuGlW/WjuniE8eDf?=
 =?us-ascii?Q?j4Ib08OWiREEz6jS/TwRN7keGuneIQAcjMvAWSDLzwpRLoG6e3xnGYH53puQ?=
 =?us-ascii?Q?sevIspmeeUHzISqpGOJ5NohLwrkmGAiNjSBGRMWhmussULnk200tnoaCJJqw?=
 =?us-ascii?Q?/wnNj1/mhEPwbtlqtGhCOJHs78Jyu/DWXn6HEJtInQnbiFtXg8pXIQ36/NpK?=
 =?us-ascii?Q?4UtJ5DxODxEWYz91NadTZ/1HFBqB92D3n0Qslq8BjvvJCcxTm33oooDYfVvc?=
 =?us-ascii?Q?XQHu3jI/ELUIv8onr1qWBwFgHk0SdWvDGF0qdk9IEFl1zQuKLB+Da7rUny4k?=
 =?us-ascii?Q?rAGWd5Gbw0M8odfBT+PZah26AWRubn3vLh6GXaRe7S+qm9QgjVObcULSuBsc?=
 =?us-ascii?Q?wIrzT03hwfLeS3DLYVZEh7kLlx9FRWKK+KqAQ0QfXFW1HKtWRIix3yyCcnml?=
 =?us-ascii?Q?JQivmQ3umD4eiyqNh+HmoJkxFQGS2COtG2Fm5uo38/yJ9Pbj2gicLiinUcTf?=
 =?us-ascii?Q?Dotww4n1aUEyHoTVFOq6b0Uz8acjFgqOSsO2j4WE6YFCHPetIybeKBK1u7/L?=
 =?us-ascii?Q?ZZ+4n9ardc2zPMEVQ74oKELKJUdnkUj9mkG1OMidWWG4RBwtTtUZ1cdXYLGL?=
 =?us-ascii?Q?n81MENoeWBXJ/Fm+py5CIn/6gYzROKtkTZoIXpuxlh/yFGA6A1JytfouJybG?=
 =?us-ascii?Q?hu9hkFyVk0ZKqQVyKkGmZqpgm4IOFm4QaZYZSpOmgqpW5pWGTSYyJMsLQWXl?=
 =?us-ascii?Q?Bnwt+bvWJBNqrAvFWp5SoUc0NfL7Q4WS9WELZ4VTlpp1A6kceY6d9gqU32ap?=
 =?us-ascii?Q?nENow0biME6cpWPDYsJyHjYn+bA0dBg0U4Kuk5qYv+dVr974ayTd5BXKT3cf?=
 =?us-ascii?Q?Gp3e/5uwZybaBtMJOcNPfCge8Kzs8F+d3E/Ac6C7jwa+c7NJJV9JhzgQYKbc?=
 =?us-ascii?Q?mDCNGW8qbWW1GLujcR/KAR4aTgoj+nESeCIQ94ZXGEJQfwxiFF4Ihx2/rQVy?=
 =?us-ascii?Q?jHxpaGUuosu9mWq+KvQlneCda+pvPMNv3VM6fzotVivUEeJb9U6L+oOUMPbn?=
 =?us-ascii?Q?INMBkMk5qwZYDcyi9Wfu+VyzcnhHBnQjs4cngi53v9w5pjklg+gqeXoPdQKV?=
 =?us-ascii?Q?OClv1Ia8fPQ3nItzHQOhE0e/KRogPliGWI1ScTpaJRfPl5vRVy9xMK84E6xL?=
 =?us-ascii?Q?XkUv2o8Vdq9OC8Cp+b+tbcY8So9UPPRnkGFJp6K09fXNYHfv46hB+Q/ukQlI?=
 =?us-ascii?Q?IyypEE6zJn8u9ppzGQPtqnGR7XIgfz6pch/dlZ3A7QDMQEYASPO/AgcHmoln?=
 =?us-ascii?Q?yptRFgDGldH6Mun+wcKqDCTJI1J24lx9xDYl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 18:31:51.9909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f12ffc-67f8-464a-d68d-08dd82951e03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

On Wed, Apr 23, 2025 at 08:55:51AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 08:05:49AM +0000, Tian, Kevin wrote:
> 
> > It's not a good idea having the kernel trust the VMM. 
> 
> It certainly shouldn't trust it, but it can validate the VMM's choice
> and generate a failure if it isn't good.
> 
> > Also I'm not
> > sure the contiguity is guaranteed all the time with huge page
> > (e.g. if just using THP).
> 
> If things are aligned then the contiguity will work out. Ie a 64K
> aligned allocation on a 2M GPA is fine. I don't think there are
> edge cases where a GPA will be fragmented. It does rely on the VMM
> always getting some kind of huge page and then pinning it in iommufd.

With QEMU that does ensure the alignment when using system huge
pages, I haven't seen any edge problem yet.

> IMHO this is bad HW design, but it is what it is..
> 
> > btw does smmu only read the cmdq or also update some fields
> > in the queue? If the latter, then it also brings a security hole 
> > as a malicious  VMM could violate the contiguity requirement
> > to instruct the smmu to touch pages which don't belong to 
> > it...
> 
> This really must be prevented. I haven't looked closely here, but the
> GPA -> PA mapping should go through the IOAS and that should generate
> a page list and that should be validated for contiguity.
> 
> It also needs to act like a mdev and lock down the part of the IOAS
> that provides that memory so the pin can't be released and UAF things.

If I capture this correctly, the GPA->PA mapping is already done
at the IOAS level for the S2 HWPT/domain, i.e. pages are already
pinned. So we just need to a pair of for-driver APIs to validate
the contiguity and refcount pages calling iopt_area_add_access().

Thanks
Nicolin

