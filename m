Return-Path: <linux-kselftest+bounces-34200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B0ACBFA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 07:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEFF188495C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E951EF38E;
	Tue,  3 Jun 2025 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cxje8MgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCC13B293;
	Tue,  3 Jun 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929291; cv=fail; b=sRUhi5FIpsj53SmCnK3Gh6J37PmEuJEez1XX/1HtqYJaY1qrsJk84CubcFCQCYg6asR8oQ1ycQHXsUlEIhUDJdcDb3+mePbOnN1qts82xOqtb5E1Om+LG4HDs8rTB36J6TKIztKwzufZdxqIgwX2JPo5B+ZkZykq4Mdkn11xGyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929291; c=relaxed/simple;
	bh=u2uvhyU+SFRwL5vp8XNU8rysw9V6BuEmQUMdYguJBVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtEaCI+XTwmxkmnG53CWiw3jV/wOyJpLb1UwAZXYerhA/Amcna7/tBZ4MRWHOdFW2f/SD18gDream5xwTM0OfICAW4Wx+T+MfIw766w4gOjev3wEOCEhzgc1CeA4K2p7Z85V9FnKa8IfnVkIRLvzG7+X8Y9zo4t5UqKKXsMn8uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cxje8MgF; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8g9AdseMXY0nyf+lILSeemJP8/XGkY1b4C3TrbvqX+WvN/qU4RP9wIRBcKpK/urTDPmGBbR8x32UY57liG93L+CjKOXwKsv4OuIse9t9ZhW8pf5YFv3959Onl8FrgSaCTmwzTAhFKS6rwSd809+M9gAJz+pl1OX3im+Uc0T0J2OIKD152MCSPVLX+0Rh2UgJZro46miCAXX/+IPwRnjleaKRLLUPeCAvsxqICW8fYbk/x3q8sEkoajN1+7TqTr3zlUL0h2zwQOM0jo7q8SaZ1UOoRh+OFv2SeGRQidzs7/woqAH9OnKfXaAsgi95+da9k/GywSXvIdk9IU3sa4X/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSeb71u7Rm1nsA4Y5jWWgVcHnIHOUuaTeIOiZirOzUk=;
 b=HWAK9fpPBv6/MPdUctfgLAP0xri67TwO4DBYQ67gJjczW8KbuK0sFjxx9jMgJsMjSm7AkwukYF2no+ydPgIn4mRSIGcqPr0w/PYFPgAvfdORd0VhtABW0tlUPNzg/SlRwQOOgDKLu1FzcaRZN+bX4a+X9VQQB0JE8bfxgwXhiEVqCfj/GGQ1zIN8up0Abh5AnazmYgFWTFyf1HyaEPKktwSwnlVa0Z8d50e88/2NbRl26j4oZX7OyVmYQXzkZgjJ/rCi/UbAz89C7PCbdHRdBvLkdKxrAuXN1r2u8msJeyX8PkOvpEkC1MWH6EzqLUkJBtjgcOsuurydaVPM+y8dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSeb71u7Rm1nsA4Y5jWWgVcHnIHOUuaTeIOiZirOzUk=;
 b=Cxje8MgF2bskXF1P21dDp7HXny3d8DMFXf5CPS+rhesfgAIvFhZ6NUp3pGzq8/6nWRy7b9QR4TfqAhjm0hsSrjSkFxTUy+xtQKUtx7H7j2lmzFaOUnm8CKbdoRS2buq6qxDWkaQBPZTxoEAa3VI8T5itUdct9lejdmwrOyhVcM+l3WLFJx3S/zSwbdtvrJnYeDKkL5Z5byoqDU030XMa3kXOlyERG6JILYIvyEGkQnA+7KsIpxe/z9tmdtE+9GgK6GnDXoRiPMwhEp/l5+j028S0c8k/Bhrxr9aYhjg/nBEA05XiugU8l9mRLHyHtyUNvbxhBMqGyjfBn9djeEvLgg==
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 05:41:24 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::c4) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 05:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 05:41:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 2 Jun 2025
 22:41:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 2 Jun
 2025 22:41:08 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 2 Jun 2025 22:41:06 -0700
Date: Mon, 2 Jun 2025 22:41:05 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aD6K8ZuAH+zjXIx2@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530161455.GE233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3d182c-7bda-4590-1504-08dda26146e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdF7qz4h0uLSjSVDDnx7RQvoWkNqOHSTQWiCtMdUKWLbyC9GoTjCwRn1PzSw?=
 =?us-ascii?Q?aSXo6hQSR9PWdYtO26yTp9RB2OkuNvVezWgDjrQGmzXRCT2d1TTROF0eoscM?=
 =?us-ascii?Q?EvHjN1Bx25V7Enua7logzDO+2NH6McQYLq74HKE1R9RMo72XoNYsCQWe37Km?=
 =?us-ascii?Q?rdkXqNxLGg87ALD+TGM6C5/5ZWkeY2AHANh6dd/04ZkFUaLv17HYD0NC8kFc?=
 =?us-ascii?Q?ntw2v0E93lw3kUgrMoC5gcUHkx5ibqxPbCb7ixgztHr1EJLNMDArMhutlRy3?=
 =?us-ascii?Q?TZ8ZhDL7qvOQgAgZVjzlSaMX1nDtluDr2uL0ow55yQHaemkpujaoOTKgSaWh?=
 =?us-ascii?Q?kM0lWuZdT435/u5TQx/szcQ+Mq0zxjxlDTgzPMe7fqA4KUH8s4EA+Jgy5Nmz?=
 =?us-ascii?Q?7tJm3UJpOnOvdAtkXZCJMHUBrABuJ/8u4uyDBEm1m3SCDJ17D14jGLApP1eY?=
 =?us-ascii?Q?lOFiwARn0eNJms1rMT8nNfbQQ1DrVT7Sb/JGyRtlfSQqQ+Vdq4uChE/CnETm?=
 =?us-ascii?Q?/M0QL+H4idctx/PStHkmabiVaF+tSRRTtixAfj9ppPJbhTA+hdFY+/7ZzvMA?=
 =?us-ascii?Q?s+fJP60m09gE8ezSET3ii6NWQrw8erd2GUIzimIgOTakbgc6SN7SeLhYc0PX?=
 =?us-ascii?Q?2j+VVpcrxRf6vtT0OD6iNr5a7w7Em/nztUcrNC61QJzZtG2GcCwmQgTYSuV8?=
 =?us-ascii?Q?ALGyCgeqZ8Y5PIvsFMdu3lXPcRasNSxPYgRhlHtXLjHlG6NBr/ABgq3RIjUf?=
 =?us-ascii?Q?3Gz/PqJ9ZRym6YGaXY//CVB5mM05joWCUHTSPDYDKnuTzbRb8lSvVtwes/hI?=
 =?us-ascii?Q?2Zdl9B2SNg/fsvCqsRUso6gKDAo5e8pslPnyTDNKQfWB6NJ1oj2MKAyWxVWP?=
 =?us-ascii?Q?9hAOxbya8s2OQ0XqFe1Sr5M6c8DnXMV67TL9yHxS+wrUCWfhrPe1d4jvQmC+?=
 =?us-ascii?Q?hODe8OY5mby0pHIFXo6f9Ou+7i9pIgi2v6wS0P9DoiO+PEfj/1EE1V1A0uGZ?=
 =?us-ascii?Q?F7MeawrPVruxpO7+mzJxjmpAuADdw4BHZreAyV/3IszFFmWpYwBznfBW3dCk?=
 =?us-ascii?Q?vO4t2PRUXUpETVJtrD60JCeIA5LX2PR76SOOem9RebyWI2iwVBEurZ9OkfPm?=
 =?us-ascii?Q?hLWeibqSX9dZGO3OQd4ojfLxHBb7RGoCXIXAIoRr4KafJ39t6PsadSo/dpcV?=
 =?us-ascii?Q?9oPUYVJsdFwJJwfASEw+r//VU9j4wueBEZWXhmqxGeqbfbQMTwT2NpuICBkv?=
 =?us-ascii?Q?9qzOuDyCN7FP1FtYxWhdCmwEfgBVT2uLrmWNCZM1C6kPLYFdMca05Wxa+6RW?=
 =?us-ascii?Q?96vMdt/PMiKOX7gE3yob/61xCe3KpWE1bNwU2+AbjQlN7HZhRFD0O5fGJVy2?=
 =?us-ascii?Q?itJXEfI6Ic/rC0Ax9oK/llYmrubfTsLV80Rz+NBcLmtpSxq+WLixcwyRmLoH?=
 =?us-ascii?Q?wkyM5+RVdjsGUG1iIUP04yHnO21bFEP+ecslosSUMEJc98hbYAkfIq1xFVQ+?=
 =?us-ascii?Q?JAL23pxXxbNNE+ussUjzKOy/uU3sYcil8oUG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 05:41:23.9594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3d182c-7bda-4590-1504-08dda26146e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019

On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> Put a size_t in the driver ops:
> 
>  size_t size_viommu;
>  size_t size_hw_queue;
> 
> Have the driver set it via a macro like INIT_RDMA_OBJ_SIZE
> 
> #define INIT_RDMA_OBJ_SIZE(ib_struct, drv_struct, member)                      \
> 	.size_##ib_struct =                                                    \
> 		(sizeof(struct drv_struct) +                                   \
> 		 BUILD_BUG_ON_ZERO(offsetof(struct drv_struct, member)) +      \
> 		 BUILD_BUG_ON_ZERO(                                            \
> 			 !__same_type(((struct drv_struct *)NULL)->member,     \
> 				      struct ib_struct)))
> 
> Which proves the core structure is at the front.
> 
> Then the core code can allocate the object along with enough space for
> the driver and call a driver function to init the driver portion of
> the already allocated object.

I found that the size_viommu or size_hw_queue might not work using
a static macro as that RDMA one does:

 - The size in vIOMMU case is type dependent. E.g. smmuv3 driver
   uses one iommu_ops to support two types: vSMMU and vCMDQ

 - Changing to a type-indexed size array would eventually result
   some driver having a big size array, as the type number grows

I came up with two alternatives:

1) Define a get_viommu_size(unsigned int type) op: use a similar
   macro in the driver function to return with:

#define VIOMMU_STRUCT_SIZE(ib_struct, drv_struct, member)                      \
	    (sizeof(drv_struct) +                                              \
 		 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +             \
 		 BUILD_BUG_ON_ZERO(!__same_type(((drv_struct *)NULL)->member,  \
 						ib_struct)))

	if (type == SMMU)
		return VIOMMU_STRUCT_SIZE(
			struct arm_vsmmu, struct iommufd_viommu, core);
	return 0;

2) Let core allocate with sizeof(struct iommufd_viommu), then let
   driver krealloc during the viommu_init op call:

	viommu = kzalloc(sizeof(struct iommufd_viommu), ...);
	...
	viommu = ops->viommu_init(viommu, dev, parent_dom, type);

I am guessing that you may prefer 1 over 2? Or any better idea?

Thanks
Nicolin

