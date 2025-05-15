Return-Path: <linux-kselftest+bounces-33115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCDAB8F56
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715CF3BAAA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CD26A1DE;
	Thu, 15 May 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iiRBKYAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EE25A2B2;
	Thu, 15 May 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335154; cv=fail; b=rfXa+3ijRJzf+6wUtvoO8ASuqAFkmmSctP77ZMza4h0S/5vjarVwrv9LrLeC57sr1MseTARmXyrSKAHB60tO09UkQW/xQk2AgFNpqgQgYDH1so2vrhEYfIeHrwXe+AWqSPrkechLUB6bFNxDNNwaZuyXcZJW2IKZSZqk10DaEQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335154; c=relaxed/simple;
	bh=2zQAbFw58vyqscbZ6yUKoWKlU1iLHXXkdwscFLZnOIo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gntDHHpnItMynd86wN1havnbxItWVabYjiT41DeJw5wgxiT7hDbENmEupuCkBd1PiIh7wgePK7VYCntZaby4Nc4JWW0u8x/K9aarwpbTPBT1U+9iNdeyY8J24D3H72R4rZVusITGoADu1+LmZl3zeIpcrMNnIrkO/V876AKEhjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iiRBKYAX; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDPtkEfgsbYq+JBpAOTdOsx5EbJKtu4EurOnLD1MtNSht4F1iFzIq48ELUEzye2w9+K2U+MDuhuZkYuCDKA+o1eOcl77cn9gX4b0EXUE1G1Iss1jTvX56V8i1y7V7EnEm1fWkdGQ0oyBdygomOW8ZC7owJTcaOR16D9JtLHImPd02Pwp+Iq9MofaCkH7PFm+xNNv2nKDwc7UYL0gSRlR5ll3Q4e+0NtzZojlzxLr2ETHgBwVD0iRUZgu51IECe0mpxciuBb4fNG0yid2tVmwo8vGLvZLbb6tBl43h5P0vqrvwbxCbJARDWe+kYmyl5YTG4+3wXGWYNRElMdqNMN+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY365Mj7xlmlA7Xq1rOxopFj80d68PKcZqqIWlHOUs0=;
 b=NsJaANgV3z+gDZnN0nFHqfMPxNupPStb/pHlVY1uu+e/ecRa0NIAcMeZlgGS0u0VGKVozR4cOqZy/ekSo1yD2Ymu6yJY6UHojZE+1siWFeL94tzl0n2IXF+qMefNiP6AZ6JOiPiX/u6lHL98068ipfrbhJEvcGYF6eVuCo6LmwY77xNiSBXZChi3Ao/1MvOFbddPrlgpDDU8ZF7fKz5pz/CMi5cby8oNuC5XxWPUrx0uvAUsFdbjhjbC4tfeeiBHHGP6wzZ3Ih0VNMtZgD+5qAuM4kybbHaLKAFz0FkC/h7WkXD9hwaI1ARzYwELcX1IxEI2caYk+fLEAS74AIgJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY365Mj7xlmlA7Xq1rOxopFj80d68PKcZqqIWlHOUs0=;
 b=iiRBKYAX+1USc60guNRbXWo44aRLVvqfIJeqpb//wb8Ul4G9t886uL+8JeRhLKT9mFqwmvVeqdopG6NOAQPYjJ4wXcwNtWzei4ePh6JcALfz0VhNk9nh/yIXh7Bk7oGvFeIUwtdHgS3yaZoC8mizbJCsYcyrcFhMeiUy+rgmW6wnJCKEkoPW4Ob33V2lYzJ0xhvHkzw5+ck6ChkQ3sqY4gOVRo0pqIS1Di9GYk/d5Xaz9R4U5EuR/IYDrdeS1DdEh8lwr1CUExoYCSU7WOpDYZPwA7ApNHoYwt7OeGQb+mfUOEEpFhSUWpKaT7zod7Xpbgq3FSUpmfIMuHTiFh+xJg==
Received: from BYAPR11CA0063.namprd11.prod.outlook.com (2603:10b6:a03:80::40)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 18:52:29 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::f) by BYAPR11CA0063.outlook.office365.com
 (2603:10b6:a03:80::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Thu,
 15 May 2025 18:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.1 via Frontend Transport; Thu, 15 May 2025 18:52:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 11:52:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 11:52:08 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 11:52:07 -0700
Date: Thu, 15 May 2025 11:52:05 -0700
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
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <aCY31VOs62/OAaca@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515171706.GN382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: e8abf8a4-abab-4d85-c227-08dd93e1a332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZC1wGDbfOgCCRYWqc7eOJg+vj/rdDMpV1E+dS6ty8SLQq/LgE3BX7sChoOFr?=
 =?us-ascii?Q?6MHSUatjpmRP2zoSrAEnzqMp1IDCcL9WNXlK/tLiEywZMZPip2I/2HE+T9hA?=
 =?us-ascii?Q?x2Ak+XTI1iNUwRndSnuraVFYwdOavYl2u5GgPdfR1V1eeZwmrVEeTmkaEvNo?=
 =?us-ascii?Q?O/0ylRW+j76kW1S5shll+7PyauIswbTuqkdBOVd5FpPRpZ0SsSY43vvLZZHG?=
 =?us-ascii?Q?C2X0iK0IxLhFh77mtZALZ5d6gqSyVkOOOkPg8l6hWoIN3lNY+JAhCdp4NIG6?=
 =?us-ascii?Q?6CoIzElvERJIkL+9zjjaTFPPhFeekY7xMN2IYm378bQSYsUJGZue0WldAK+F?=
 =?us-ascii?Q?3gy1TVwqa4+Pja1HHIVV4boiSxmMs8Mn/gPmqCdyiEPhW1O8sCfQ5mLmpeOU?=
 =?us-ascii?Q?7fFqkqpyk/84vSX5GDdcQNuvvBDRurcsj/s44Xh7x4bwvSq6mCQQFKK6bHs9?=
 =?us-ascii?Q?DynyR8xITFR6nJUXgr/HFontzsLw4+b/Ya+FD/sExi3KQbZS7Ip5623A+yFb?=
 =?us-ascii?Q?X0EqHPik6SoS9JnRI6/5ytHQlyVzXND07K8VksidaRhwjmHkAd/1KgXSfM23?=
 =?us-ascii?Q?HjkZdYv1sBs2FLOEg4N3heJ3cXtsccV/Xp8cwj4CWQ3fhH4vMrwHLKjdlnBE?=
 =?us-ascii?Q?srmX/21otRPO6ZZ1mGKq/mRuGMubOo3s0LuTIc7F3eBMfbW5kj7dr0kp4k82?=
 =?us-ascii?Q?r+cEqGu8N2uRpc82kPfbnNW2A80V4hurYf7cjp7ZT8bHSEr4YswQM13p58IN?=
 =?us-ascii?Q?g72EBNwg8xsxd+5wZ7dxLNLe2mbIWZlWcDLO6JOk4OVAXCkHrRz9IQdk8L0u?=
 =?us-ascii?Q?8kArKiE0UlfFf9BahKTq7OVzDxTj+7A1zmB/yoYwQgzK5BkiCA8m/QNBx8d9?=
 =?us-ascii?Q?IB5mOvsIBFEhrNNuaOpd+RLl8K5eXefOSJVGyCjz5tVs0078v0YW2TtCm8nW?=
 =?us-ascii?Q?zdA0ymhjmKZ7ftnTzQ2qTwVKWAnEgqN8ngDBw8zaeepPPDrMKPUDU/LJDxcm?=
 =?us-ascii?Q?+kmwkoYyG9QzrNnskDRWFUy2dvXGuRXRNz0+E+xb5PcvjhzzxpQA82VwLL3B?=
 =?us-ascii?Q?7AjPY4ffz9KhQ6OkvEpCXqful0H9Eh6He4KkWthZMpsG5aYYCWkd5/GeTvR/?=
 =?us-ascii?Q?yuFaX2hUoHMHw3VJlD3FI63lKiT7Gr0DyJ2JndUorX1cu3EdJzBlR1LtypE9?=
 =?us-ascii?Q?+QB8E3Uz26VU3n65zVromQtVxKXeS3oYodI6k0NlDW62Gpwh5Wuq7XUpRgmv?=
 =?us-ascii?Q?3SvaykbSOQgKq04SatO5tYHDYzUWbra2NF1C0nFGUy14doWs1GoEjwM/BNNx?=
 =?us-ascii?Q?oAG4PY9qt4UUohCLzcA9WhOKThjdPJcxRQCQ8MFcToj6lzAtHyEzmpc/YdqO?=
 =?us-ascii?Q?L5veAVWO8fDVZ/KTBHiAAp+cAFqUOz/NjY9hbgYN33V3WGVwBURTVz2hYAIA?=
 =?us-ascii?Q?8RSnhoveH/FiwAnXHEojvT9JNMOoPb2I0fEsfbpH8sZqi6k1QnuNTwz0gvBz?=
 =?us-ascii?Q?IOhES0QWyFPLGMThQaj8H3aBwQB/h5vqMfLn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:52:27.0675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8abf8a4-abab-4d85-c227-08dd93e1a332
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981

On Thu, May 15, 2025 at 02:17:06PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:39PM -0700, Nicolin Chen wrote:
> > Repurpose the @__reserved field in the struct iommu_hw_info_arm_smmuv3,
> > to an HW implementation-defined field @impl.
> 
> It would be nicer to have a tegra/cmdq specific struct and a way for
> iommu_hw_info to select it. 'impl' isn't going to scale very well if
> something else wants to use this.
> 
> We have out_data_type but we could have an input sub_data_type too. 0
> means what we have today, then a simple enum to select another info
> struct.

So, there will be two hw_info calls back to back right?

Should the first call return out_data_type=CMDQV while returning
the arm_smmu_v3 hw_info data? Otherwise, VMM wouldn't know what
to set in the input sub_data_type of the 2nd ioctl?

Thanks
Nicolin

