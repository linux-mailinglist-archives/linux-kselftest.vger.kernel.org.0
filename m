Return-Path: <linux-kselftest+bounces-33096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D698BAB8D5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF7416537E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2A254AFE;
	Thu, 15 May 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbbGFFMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396731B4242;
	Thu, 15 May 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329284; cv=fail; b=oHhGwgu33a5IUdVZmtklZNGFzFB1qRMcF6w8eDQY7gYHWKJMDjYbiOjke9PF1OVa5FH+Tle+BN/zr5vnYh/gsktDIMUqkSlYx7cQ6QHmy5LBsYL07f6mF6d9KzbH35+xSyupHSpB2WiNgSph1MEKxHtWsyezqNjdfx9T1YdJNvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329284; c=relaxed/simple;
	bh=hob0DdLDp/hllrWbUDu3+x21dLcaqy9P3BPzjF8rrbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSK5PGAmWYHDQL8JZua/lIo6aL2FdIgMzejPr0vHBA8GCdF/hovg+6drhaZiU/tdCbmCMzyhqUzOzZ9J2pNqD2PWBP8OgwsFp5e2qFUY4R17Bhtht4q2jmVwNYqLQH3wf9fnv/uyXfErggLMixHzSTSc4xpMUKoK4sH27twWC8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbbGFFMz; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAbTZn8t7lZKgLgKPUcoFUFJNA1zqkRuT0+UpCp97aNBE4HhyB4vOQCqLBJRIZu0oKK7EAuyuHhccOthYDYv30vOJl8+ZM9p8KQK0bqszEK6Iw3jS5jlg//f/3EzsrqCu/FY9QyEWYjmyefuc8DBN1KkKqXjYTyRQ7g5Vvt+mBzVB3qLLpAiMT1XHbmgTxzsN8pWgVGcH6IQ9dx52+XDZ953CVzGkfs/J+znsKbM+/tajU4I/SscahwZZDoh6hrNUw+Q7kK//asmN5N+YaAhskOvJlr+2g09ukrzBhki8SnrVtiJ2HNU6z0q8iH3cbXax2YSulOAA9gXZZ3j4EAfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLCHbMBkdDfGL9nZEGs6gckAd7JzGvhr1k5kXbFLvP8=;
 b=VPLKp6sjOWHJb0II1EU1ghsBhDQlFFZL5WsOfLUwO0zkX8xvDtCGLEJvjpObnv5/GZrOZepMzL+YMcO4DwFK5DBHvgsUcj5N2lodY3FkeqxLbg4zA7B+dZL3iW4bTfpx5ftTVv9QBoFL6cvoIPuEdRvoOtbVQ2yyH6hSBx2b3GPa1ck7ZnOSKWqvUeTOARzbQlyWZWgT6NN+Fo78R+QalfbhndLFeUrvhxktBemulC8aXSoThoqWIiSwzE9xg8hRefzUczO05dQZiF1yLpsM9cfbHeOPlxm18mOH+6px1FCMld6SXFB7V/PQy4k6BhDu0TDYz/Gno5vAZwb5cR5yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLCHbMBkdDfGL9nZEGs6gckAd7JzGvhr1k5kXbFLvP8=;
 b=fbbGFFMztRa0Km09CYTwYbyidQ2VjDO+LqDtsTVy6+rSOrZ4FMssmOIOFHYI1ISeEhMKPve9z+MQM2aexdwdf/N1kGgrV4RMDMBoZyFyMy/yE5Ll76dEbeecq3fuZ48vi7jmcX1pGe9cLpMyHwQdDXqv8zeByKi6jHN+ven2r8gsQ4FIbPisjil7PSQl7WFv68UfGBGq36kCJ72mvw+GZ4ZQv3biV2Qoo8z9yNOAwEkEGzTCgAjau8zXmKX4zizW9FeMP3MObZ5iMZe3/wbswUfOXLd0jMdiskqEL83gbXLxU2WZLGmHQAmZnb9wlC2IA/fe6+UY0tCdA8hXcofmRQ==
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 15 May
 2025 17:14:37 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::fb) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Thu,
 15 May 2025 17:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 17:14:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 10:14:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 10:14:27 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 10:14:26 -0700
Date: Thu, 15 May 2025 10:14:25 -0700
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
Subject: Re: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aCYg8UsHWn0wCyoW@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d359fe4-b553-4e0d-35b5-08dd93d3f860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kB+lRK40fYCq1bFIV70N7evTYnK3pKeAUWvbIfX10tSWCLBQo6imT1zdXAKf?=
 =?us-ascii?Q?BMPLyuw7G9VfrX4LoqLwa2n/+lPuhb8IZx+azpo9fQKF53KlSeBykuVU0uz7?=
 =?us-ascii?Q?xr4vnZwAVqulr3zpLgT78kLpIk43oa1JPkL4/cKxRZx/fLkyc6ACyiI++6Sw?=
 =?us-ascii?Q?wdo1Vs/exRobuCb1sg1k8Ru0///7w2N/rnNEDU3gFJdfx406kmcxPKET0fPn?=
 =?us-ascii?Q?fJruLz9UgWF9wOr2ZlhnSMd/AI2sAvDfaw1iIIWfLOLmEIPoVDpLAGWnuNLr?=
 =?us-ascii?Q?JeR+tiSxZtqtVFJt0pP1CNHqXgLya9xxrk1kMCfIXsa+M2+FdvMBSGCStEZK?=
 =?us-ascii?Q?TonbLA61Qojd0cO8CfKmZWPU8eIRMxqd3yTcMMJT6q+FM6ErRvlXm1DUFV/U?=
 =?us-ascii?Q?MEV34kFR8ScuPwi/Bn4xQSTCZYrQqXrqBpCQQmlZovLB5q13T50KyzsTcXHk?=
 =?us-ascii?Q?25YynT7bK8D1bbc3ZSODpfw9KejrjVo3BJvgvSfFq9moDmkUg9HNcwVYBlVc?=
 =?us-ascii?Q?BS8slpPi4jKs86R8VmES4BEFa2CSL4uoyKxp8lEQrc+pRp1kuGa5xCKOV4rH?=
 =?us-ascii?Q?ldWaNTF0e0SwH717M1fzngDhM0nYQEWC3L0uVpzGDAKqbKBUJHS+YWP5VyJ5?=
 =?us-ascii?Q?tTwAGy80JUA6ZP2dxWvxuD4J7BYaO9GgAkApx2QuAz2tAoMErtYSC/euJpbU?=
 =?us-ascii?Q?vWgt7y8u771TUZsuebdTsNaE8dd3RKg85KdchaBOlB0HgXF6fDkSPI5g0Rvq?=
 =?us-ascii?Q?5FiRRCVysSPlsg/2GPVFIDmTOQBVlA++bQ5d7fsx7FJ7U6/HQJlsoasbJGsc?=
 =?us-ascii?Q?PMlXPM6js/dtnX99VnYMehyN++um62uah91VT28CyJXq+GKhdQuv+dHZgVVF?=
 =?us-ascii?Q?Ijr81RMjBEX+gI6e3gZcCVFnuu0kWLsGG9gM9FuFoKRl8Y1aTvuSjsTy2HaC?=
 =?us-ascii?Q?JtRYJySpzUSk+6CcamhT7Bsr0H0steosZHBmTRCqX5qjYNko3YILLnMotG9s?=
 =?us-ascii?Q?38uhAMdoYedszBqoKCbx4XSfwUg0fh0v8dZVcibyTXXQ+1wsZAkqFArpxi/+?=
 =?us-ascii?Q?KbwcHunf7Uw09F0MciiXuQ1CysgcFrNynkER9mKJWjLiEOQComapE4sSXFLF?=
 =?us-ascii?Q?rMSInnp7b+o4BYM9fkajLVyktpMe5jY7i4iUklh+MieLCuHUyA4EUyVqvybl?=
 =?us-ascii?Q?uF69g4N/PhQWN08kswBGXKgYC45CZQ4Cp9UonN2tz26QtgxOdXSnYZwhL3ky?=
 =?us-ascii?Q?2zMVLKFv51rGzPEkZCO0d569riDqAGWbFR1Q1P1nJ6RWcM4R6NFJFnLxK6j6?=
 =?us-ascii?Q?LjRcJH1c2tCpU+SlR4YpnvJC3z6PpppXy0rJAPwKtG7oDecULwqIRpD9tD1y?=
 =?us-ascii?Q?BQ3hcvWcuNnw5shUzgG9fgWX0eUmjdBbbySW3xyXJlTMNZTuyZWnTqfHloc1?=
 =?us-ascii?Q?sjLMhSwBJWur+xhXWgSbd6HGYttzApSE71p4BdsOIJb9HtvE3dvEgCBZzOMP?=
 =?us-ascii?Q?ghr7BPjXIsMJKPKtiDJ0+60GGflQPYQv+fAg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:14:36.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d359fe4-b553-4e0d-35b5-08dd93d3f860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8

On Thu, May 15, 2025 at 05:58:41AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:03 AM
> > 
> > Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure,
> > representing
> > a HW-accelerated queue type of IOMMU's physical queue that can be passed
> > through to a user space VM for direct hardware control, such as:
> >  - NVIDIA's Virtual Command Queue
> >  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
> > 
> > Introduce an allocator iommufd_hw_queue_alloc(). And add a pair of
> > viommu
> > ops for iommufd to forward user space ioctls to IOMMU drivers.
> > 
> > Given that the first user of this HW QUEUE (tegra241-cmdqv) will need to
> > ensure the queue memory to be physically contiguous, add a flag property
> > in iommufd_viommu_ops and
> > IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to allow
> > driver to flag it so that the core will validate the physical pages of a
> > given guest queue.
> 
> 'READS' is confusing here. What about xxx_CONTIG_PAS?

Sure.

> > + * @hw_queue_alloc: Allocate a HW QUEUE object for a HW-accelerated
> > queue given
> > + *                  the @type (must be defined in include/uapi/linux/iommufd.h)
> > + *                  for the @viommu. @index carries the logical HW QUEUE ID per
> > + *                  @viommu in a guest VM, for a multi-queue case; @addr carries
> > + *                  the guest physical base address of the queue memory; 
> 
> s/@addr/@base_addr/
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nicolin

