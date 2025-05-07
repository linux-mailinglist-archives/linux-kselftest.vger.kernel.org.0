Return-Path: <linux-kselftest+bounces-32555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E4AAD848
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E84E2621
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA5E21C18E;
	Wed,  7 May 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OA+rtP88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83B215F7E;
	Wed,  7 May 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603430; cv=fail; b=cnQMeyy6T4Lws2JKaYg/UpuOIjM+EkrproHjE24AX56lNc+SgHV94lPjFGhvQuYddLfb8Ub4RKkEHhFVdvTF+ilq8hMQ6QaRI/vhXWfDZaZpfVQ6JZz5z2Kh6exyEJclRRIkGCQmXRtf8rriMSI/njVCOyiqb0vsjf60E4kFdo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603430; c=relaxed/simple;
	bh=6iMW+YCJnnOF3c7dVIqCcY+T0hQEoohT2Ab55GkKKug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MorBh3V/ORos+uTjw57CR+ZR8R43zmQPSjNyJ6m/0Gq3Bjpft3xo1uS1qNzeNAe/TeccFth8HCvQNFq2p184wd8IpEP+N1DPWnsF4nCyd79vN9ZbQwOmhEeATxxpjcLdfdC8MXHGoUZCYREbffHlIxTLqVomMK6Bue3RrVzu31o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OA+rtP88; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcg5+HFgpsU1zktG5ap8pm8t3kS7gUoHhRznrDvs6OEQFqkEOxeOGiFGzbJSzJDl8wnaTU0crfsRmwijL5Xc2b0uaa+4PcdqCoD3c38Z1gzX8njteUZDHHtVOvpUOgCD5dghobYZdLBZuLNujLJZndPr+VCUuS2rljxtBy1bK05rwOFTAsdReS5rC42RBKC+dI8uaKBn7+DugjmLIPZJ5QaM1kZgXXUbgDUjnbcqAm3XMiVvYbhMioyr/e9+HqPo7SDtG1wrEgTlJrpzSgC5Qip8MuevBKZ3J/mZ8zhQbYJclWJQ6ybJq+f2AtZlbAvDOqwLE9hUqH9SYOz3jf+cMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n84GjvyJIf+bmRMUoauc+Mfy9NVew7iAey1grez+HQk=;
 b=C85S8hagbyZCSBDgEPh+oY+K+L9LdTieiX6WVznejHlNYjfYHmBKz/haqKmXsin51a2d/YAcl9qfpIFj6F0o1uLlPqvhL1OxJVnXnJQYDZcheU1JZUo9QBPB7yTrAJ91dMqFbs2xOEVVszYb3QFq1EkdOqoWgbDgJ4tvT8sP0xH3GcsjRzYG9C7NO/4OI1dtP3XVmE1m8nCQWBVCbVxfiS3Z0ZL9O3cmzr6hTFbb+J5zkjLVpBknQFAH33Aufrs9q1mz423P2JdntXNRgvsv1OU4/3oNRX5vMXi5jchLRAJiNSOQ45Px4wcAknlzzv6SWqdmWISH5U6LYNf+8ygwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n84GjvyJIf+bmRMUoauc+Mfy9NVew7iAey1grez+HQk=;
 b=OA+rtP88CQn0yPOjeneSNXriU+vwZ1GyN6JXC81MyDoPch4O2Crpl151Hw1ITvj0VOHBsAGpI1tNB5FIDZG+JAY40keueUMfjsCkxTBT08QuhSM8oiGpkdaLiA0iiCl1KPTq1l0R6GphLQPwEomBkOcOMeUePICzOMholVQstaURXHML3JyxLs6YHpMGXw53Ww8JwUmlzeV7i91h6qGLMcPhWCj75rB/ImdtFAJe6rS06+NLrh/jUm/WgPanDdedgb1te4BJBSo3IFUpSdKhv6xybBUT3WZVun+jfJ4OyQJ3NMdygHqEzU+AVo7A+l5tTOod+EObOL/lMb7zWniIEA==
Received: from BN9PR03CA0703.namprd03.prod.outlook.com (2603:10b6:408:ef::18)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 07:37:00 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::ee) by BN9PR03CA0703.outlook.office365.com
 (2603:10b6:408:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 7 May 2025 07:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 07:37:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 00:36:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 7 May
 2025 00:36:45 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 00:36:40 -0700
Date: Wed, 7 May 2025 00:36:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBsNhsVryZs2c+AT@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F5A464ACC68D78465578C892@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBpgWNitAgNenOPY@nvidia.com>
 <BN9PR11MB5276090879BB4C76CB27909E8C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276090879BB4C76CB27909E8C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 306dee50-16fb-45fc-052b-08dd8d39f450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ygvtrctIaAAWW/d7C5vWtO6eWE4wsWqGE5x0ZfxusHa2OSLUTD6LnzHP7dZ?=
 =?us-ascii?Q?y1L5UPnOArHC+QFrVOf7R15fAxnMSA8jG4k2iYMCoPvUwEPIv4WgsEmh2Avz?=
 =?us-ascii?Q?3Mhm8IuwjqsATPbB4NWJdB7o2BNi3FqKthFhLZJ7Qqjh509jDDKXPs40YnUQ?=
 =?us-ascii?Q?ji+NBm7mdu9tZMHSB1NQY99ajnpjlR8cBH4GjFiOG0MuGWeoU3MkaV+78V+X?=
 =?us-ascii?Q?fduHNYR7WS/36+ttr5RogzC8e6sM676kpbfTjbhce38Xdzrw3GuEwj30KouQ?=
 =?us-ascii?Q?bJ4ecTEgFdCNwNF3cQA0+dZicpArQxHLY8E9e5xec9fZRzV+WzyEGd2s6BhT?=
 =?us-ascii?Q?u2CLn4tTBHkiyOYIaLvaOepmMLocE5bt6PLrUH5B0rw4ZtEVhSTOpEiTGPd3?=
 =?us-ascii?Q?7iDo0kmzM54sr0EQgCRm+iI7eaxCVlFIsXU2SB67j0/M+tiWd6DoRIPZZF+/?=
 =?us-ascii?Q?gK7ho9pV3agxO8spX+DVxEelkN3JNuV3oz4YyGpBVvuQDo87NeqPh4mHLg5f?=
 =?us-ascii?Q?5Ih8htKb2uCP40mMijTOtxAbiEq5i5L6gn2v1fNL1Uq402MqrMlllCuBlhn0?=
 =?us-ascii?Q?6KWwZVKGgxmxpWqxmcohkyGQhmtSDKQ0KfHLlhhl9X9POv5eUREnkWRqaLr0?=
 =?us-ascii?Q?j3WXG3l5+AUFL7zF9mBubnmDQB1SxIvYuF14eTlEAlhjy5ZUw2xX0nFseo15?=
 =?us-ascii?Q?1P2aO4U4jIRfPemPXwlK1xdSKrD3r3PiM5OseyG6wWWnNgTW09FeVYkTJ4qU?=
 =?us-ascii?Q?ZS+VEWBVmQgPvZsbqTZFnw5sKPHy3vGL1zLoaBHh/xCXmCx/x6gMofF7ag09?=
 =?us-ascii?Q?kAeDuDYG6oyb/K/DthMfeasasiJl6A3UK4sARnE7IVxlD4uRNmj7xw7Pmv2E?=
 =?us-ascii?Q?8/HNm4gzhAIoloVSK6GJTHvVLhXgPTiik4az6ZuyG9cWlD36r1tg8229e6fJ?=
 =?us-ascii?Q?AIdobfR9slUM641Ttwq2r0knxH1VsZ2AsDfWKQLiQ9uA08aLTYvXOHr48bOV?=
 =?us-ascii?Q?oal84Vrx6eC5isL2Esg/x6+jnmeaNHy062cLGeTjxhjeuw1AUTzO27JxlpZm?=
 =?us-ascii?Q?SRRnYXDrLT1ssbIvaTaDtz0n5VC4Q3qmIC3AdXXo1y3HpsVL8Y0yYgT4jsXn?=
 =?us-ascii?Q?BItkQ/l104x5B182FUYtq8JQO8U1LGg4byjNG9OrB0/O3XQP/6gPjZKH75Yh?=
 =?us-ascii?Q?Z+h8fH9QzFp8eHYn5DElEb99e699+yR9/AdN/Qccw0XwHwuG39c8EMZ26tZT?=
 =?us-ascii?Q?S6DIHNP/cbCxmQlHILz36L6J3QQLlIRzPRuX9JkNPshLuYcZGUpPYU60w4ay?=
 =?us-ascii?Q?eDrIJqWKbp/TrELLtvZA4WbFM9A3IlI2NfHWwgAd3fmRdGXl/LjJlj8oN70h?=
 =?us-ascii?Q?JmhTPNLP4t/h63Y+OwwyroqjLpwA3RSZm3jxYS8iDYnANexZoCbG7y/b/6dY?=
 =?us-ascii?Q?MuB3QUZouFVcGcJIw8+TDI/eKvGQXbF91SjSLyZtQbgnkG659Q2RoN/mvivv?=
 =?us-ascii?Q?ayllQOsnDAV91loYeQ7GmTIW4ooZ7hIaLPtM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:37:00.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306dee50-16fb-45fc-052b-08dd8d39f450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

On Wed, May 07, 2025 at 07:22:24AM +0000, Tian, Kevin wrote:
> > > any reason why this cannot be done by the core? all types of vcmd
> > > queues need to pin the guest buffer pages, no matter the IOMMU
> > > accesses GPA or HPA.

> > But I am doing in the core. I have iopt_pin_pages() called in the
> > core ioctl handler iommufd_vqueue_alloc_ioctl():
 
> IMHO we just want to keep the pin logic in the core while leaving
> the check of PFN continuity to the driver (or have a way for the 
> driver to communicate such need to the core). 
> 
> It's possible for have an implementation with IOMMU accessing 
> GPA of the queue which further goes through the stage-2 
> translation. In such case it's fine to have disjointed PFNs.

That makes sense. In the iommufd_viommu_ops structure, we can add
"u32 flag" where driver can define IOMMUFD_VQUEUE_CONTIGUOUS_PFNS?

Thanks
Nicolin

