Return-Path: <linux-kselftest+bounces-15338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF495206C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9DC1C22EBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5F1BA87E;
	Wed, 14 Aug 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s3ZqzLtL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B71BA870;
	Wed, 14 Aug 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654255; cv=fail; b=PNoVr/W3CZCRKVlDTjBekdRLPuAHlbTYls2gA9eovexvCqJlxptikQry4n4s1Hcs/DdG2RhHX8jataqdczBQGCLL0ZX6eqe2iea0R+GCPFBZXnfOQ6Wf9M7lIBJtQKPgoOVbEySp3web4gOB2CkdRTN8IWRvhWrxDEeZiuSorWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654255; c=relaxed/simple;
	bh=KMs2aforGD4l8sPsSL+wqBd8/qPr1hJsIFrFYwspndM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2SARhYZRO0tp33Dh8f/57Jc/XzqT7ALeOEpR5vSNFUmve9KJVu49LkaraViFRfRF6T4SclPl+D2qdtJedk2nedSIYmhI42/+3Je0QqHD36bs4Cp30b2OztuULgCQXqCSeCg56JeIkskU2326Slo5ZvEXOMvrl33J2tGxjVrSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s3ZqzLtL; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J67hDhtbC4u/ZAD12HCNXWHBXCW2yNtyz1Ps3ndJhfqs646aF45CBTg8g908w1bl7Y7fJqApyIRjJj/lY01JyRF3X/2FIl32NTIyiMff02FivuvpPqT56k4pK5RiweboB6EGPFjpj4XdOwp3v/wZd4pPH18soo78w+XZRUuT7YK0vbScDZ7kZqCSV7kkL3Ag4j3em6bWiKVZkqoXasMfJnzcKzma1414XrtG2kRiOCPS9Xhxl3KF7p1zaNt98X7ktfIBucX88vaWFKPOoqVSm/Sm7l71VfD/X2YYbDmzN79hy1uKQcm1tMclTXmr8Z+x5PebiFiE7rUSOcwygyGqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKr0hwfVnkU1vXXWn3jWvt7vU7H+F4oTg418YSUiH4w=;
 b=SfA+jhrP3Z2dxqJ3CZGHlm6rJFiueNEFyHfBgCaXFdmIxdgX/vwMF6g8RVF5zIrRgoeAgbr86ZdFMPIwhMDol/jmlR7f4omF7Ku3WGliIMUIftn939bknz1hQI8xolglcJ2utBTyLBE9ThfBX3Q41vmi/pwFI/cR2rVzm/5mkgzYIT8D4MXydaMo4u1zgBI4/QMRhYZmVLRCrJkK+IOIdKnHwIHdmk5vnD+1+aSF6OIqG5jm1PowJCMf7yFsn4xXjX6i7D52ijVoGCrjPBzrR29KsFbqPJpI4g9AMvSWdGob0V1jBejSOUPjec4VojYROsvEwuhH8IIr6WponkxPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKr0hwfVnkU1vXXWn3jWvt7vU7H+F4oTg418YSUiH4w=;
 b=s3ZqzLtLkmuo9TSkdWGKV/c1uyEn5gHXPcJHTqhqw7ySWu27cZkPg0Mwe46ZxLhg8izWPzD68Nqubr108VOmkWAyFQWrZ7SecsyUEi/flKh82SrKiR0x5MltsmXM1LGAmi+qUMo3Uo1+aI6cOyh4ksNEGLl1LuYkv88CejLzjdRtIFWIbanUf/I8vehrmIiI81y2WYC3HodbWyHYG04H7hEUZgPVJjj50n73JMaQNE0ip8qzZWB7kM6NzupyefoWSDuSb1xG2ubAxyvCvXjGVnjGdyz1X3l9Wg56b1y2OoOyl8wJYf1rLLwFk1ZX1wGPdwRNELABTtCSMrm86/mcaQ==
Received: from CH0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:610:119::14)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 16:50:50 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::d7) by CH0PR03CA0390.outlook.office365.com
 (2603:10b6:610:119::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 16:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 16:50:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 09:50:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 09:50:29 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 14 Aug 2024 09:50:28 -0700
Date: Wed, 14 Aug 2024 09:50:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZrzgUkagKokrjjXp@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: c1995321-a5e1-42b9-883c-08dcbc8140bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IixZLS/p/aB6F9tzGV0pnkye96+wUa1PwgpEGXoR943vzFL/UeRt4yYO7jdy?=
 =?us-ascii?Q?oR8rkU6lTEHJR0+gXd+3CLUUolyHJ4mV5xJrmZCl57lh4DchMCW/Y0q406Hj?=
 =?us-ascii?Q?qRGz95QCO+GrgazKzgeYSjmI7ef5vUbNldKBHJALVBpCSg1Cf4oU80xJoG6q?=
 =?us-ascii?Q?lXoWjW+ZuJT0jUjjy/9t3yXEBWAeCK/XJKXmv8pkFZHROd5pxHobnruJkMwl?=
 =?us-ascii?Q?LwYCs0g2T9nKQczrZvXXjyUs9C90a4x+LA/QpwQ06PR/G0zxUFx8bW+Rpy0G?=
 =?us-ascii?Q?lEPfxSQttr16TkMmbmID97IkCL7KZ8AZ6/Ph5wEkIjJvQ0q4d/H3Nr+4mk/d?=
 =?us-ascii?Q?BOUjlS24v6RVu9WTZJGJyvl+E1rOe/2z+oU1mSQCek9Iko2H01R0igptwre1?=
 =?us-ascii?Q?Uf6i5/5SgReV2NrVbT/oVKNsSTpsEitck7CZlfHguK+CIEBLwxQvpDh3POcN?=
 =?us-ascii?Q?OlHe4YVEp2cV4EDUczt3r6WxPfMbWmCxXrHHv3fOpUH6gFR43KfuBXlKUwXP?=
 =?us-ascii?Q?mwL0tcGml8vLgPQhC1WjwSmJIeCWRz4yklAzctG0a+V8cw89gNy5xcvV9w8P?=
 =?us-ascii?Q?HrAze3PqIenwZLBsnFjmultd4TXdWEBbM5+O9l8urpAwm+Y4g1lXFBbWrKEF?=
 =?us-ascii?Q?xrs7MnLOZUSigPGdmOR01Ew8QHSBPhT4581URVr48ISh+9l/BDicRD84/h3u?=
 =?us-ascii?Q?GQRjF00Q44zNAOkeWcSAy9NEMXDXEypLKxwPmZtC1Sv6gv0EOwreNLK35EiR?=
 =?us-ascii?Q?QNODLSZttrKiLE+ot5TN5ak0X5PnR4FBAn9301VkHTOmN/CrO1WB8VxH1qjf?=
 =?us-ascii?Q?Q4NpVCJqhrGKQbS6+fCn60MzkIwKI6Vah30kxe6lVSOxuHTmJYMRtAPCsplk?=
 =?us-ascii?Q?59q+sR1NuP/fia5+PIX3dQk/2aSTcJOAbQJIF9tIIF500sWbDXR1DCbnT17m?=
 =?us-ascii?Q?UkDjgDnvbOGSfwTjtakz5wNDfgKh1qD09oR4Cn1bKhxHkw3SxhQ6xkdvCY2S?=
 =?us-ascii?Q?AC5GR56yBWqOFhRPM3vwsTMWTd08V2XrMbzvGrES6SKiwAyqSqWzjYJWdzPl?=
 =?us-ascii?Q?UyptcctKN9Q3F46EdDq3eVCQ/WxL1prjK5Sz+SpXOG9qAeqPvX3AcGSjQZRE?=
 =?us-ascii?Q?WaTNVToEJk8whRppEsee5O9bZ23owc5i8vxt+RR1vyarlMOB7TyNke8WTYiT?=
 =?us-ascii?Q?kS4K0dDISacPl65+tyUI+v+7MLOJoFq3Rz/fWU3mk+Z4J8pD+jim3CVY291B?=
 =?us-ascii?Q?0FS7asZXD+mMgqLuTPw906b7JX6RXJTPswugoShD3cX1yvDyELFG2fSBRuG3?=
 =?us-ascii?Q?8vcV0ndhT6IDL5MBxFSjUlbrT5QtYW2J3JWvm5AkhjuWaVhVBkyt0njwEZi9?=
 =?us-ascii?Q?5S4ctzGTjhPSP9T1CwOEHZOInnBKJnzYjhV96k11rJL0gRSx6nNo/qJrcx19?=
 =?us-ascii?Q?p4eQmKdyfkq3kL1WFpvmcEwNT/JrPddN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 16:50:50.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1995321-a5e1-42b9-883c-08dcbc8140bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

On Wed, Aug 07, 2024 at 01:10:42PM -0700, Nicolin Chen wrote:

>  /**
> @@ -876,4 +877,33 @@ struct iommu_fault_alloc {
>         __u32 out_fault_fd;
>  };
>  #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
> +
> +/**
> + * enum iommu_viommu_type - Virtual IOMMU Type
> + * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed VIOMMU type
> + */
> +enum iommu_viommu_type {
> +       IOMMU_VIOMMU_TYPE_DEFAULT,

This needs a "= 0x0". I fixed locally along with others in this series.

Nicolin

