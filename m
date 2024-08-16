Return-Path: <linux-kselftest+bounces-15471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7D953E6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B622873A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B191563CB;
	Fri, 16 Aug 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUKg6eCV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A225622;
	Fri, 16 Aug 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769434; cv=fail; b=UzifDosUR+B7QlaGpBvicWRAU5r5/XP4FfzoLcUno27mupmQ9tteIyM8saXLcQl+huUJR/yUm/h2UvOV9T3OOpFRJx5AxAOqpZd11PkNNpFq50YbBRhQZPLNiiSSAfSMaVWPDvOblRmkakiZFe7C3shKBLHn1Algxul6QbzoItc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769434; c=relaxed/simple;
	bh=fQysFqSNonhfL1B+6HvEVQGCi/1+5XNGBwIMPv8yFUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH9EjYgimjOawu+IFWx8YpbUOCFk4Wni+ii+Yzblnlv7T959uOrgFleFRT2ky/USgPUrBZi2DEZ9AzcJ/GPekqkktm/yPfsIwKU/nnxrgiAVp8fQKmKVRK3IoTdG8AlOez0goiH4ViV+hqeu7MtotDWADUiNOwuJUSCHNUBIkuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUKg6eCV; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhEhqE06ag4Mq/nUYyDFhaQLtnehsL3rXmZyUH5qUrNesKJwaTQQkglcgBOcrk9Orh9LT0YCSKh6jbkvWRIcXXjL4FWVWvEIbXi+wxft496m/PAe1UJ8dAsO1uTYGeHSMrsQQa4qjGdqkX+IVAVR2HRTgHqEfUMYP9b8UFU6V84IAxpJTdiq+crgE0dNNLBzHEEpHVHaSvWhTHvDNgQRBwavh9r1KEwxgOgqtV4Fen4XoLc3obo9HplNTquf8DKllNqN5iLJskQGP5rGa5touirjUM+vMP9khL5EHSfnQ7VFcyb+YyC7rtSp1fQZ1B0FKS0PrTzgNabew3kA44HdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi1LhAjkNn5pLEBjuJ6HOD2dQgt5phHBktTLsNqc0to=;
 b=MBvmQK4Ex50dIweoaJpZeT1BXZZ4mxxEfJbOirt6f6+fhtSXaXIryDufVnLQ0rk24krDtx4UF2t+IxLIzajZnpwtl5I10eq30+8PzUiDqN56PKqBIyTxqnwDZm4HVETND3LNEamJc1XDOm+Ee3nyAi0xrGyt2CeTz3eMBYeIq0h4nL+xhl+W/Ounv9wI3vPrOp+Gc0DY3OD4XODw33ynwsAWCKJSgGpC9BmohBQnKcR2SL5Y/dVZzuUewX1SJeWqlf8I1Eq5kXSSJesweWbJ9vUtAngZzFNS37xqXs+X1849boVTIdIpLbJycNqkeXrFa6TsfTeAojQtMqgBhgSq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi1LhAjkNn5pLEBjuJ6HOD2dQgt5phHBktTLsNqc0to=;
 b=YUKg6eCVJXAfC+quNz+/9lWgufsttsOVeRfh8Vzut8z3lZNZovtnCVYosv5ZZNt/0I2DZKsClL40zkOhS4vCQC+F57UUb3rrFqufsvQLdFKJCUl6AGmxBL4dZnhGFAVdBpxQoNm5pztWxPCWirR7hI/jQlv8yrL6NbItPwhp/ZurILjFTyBiGvAmcKHqz6A1AmoI1Z9s5mEkTneEqnV0W5EG1gaTi2bOZDNa5CL8VyIDgXKE/OAtf8BAVosUDgarTAn3n6PsoIBRG4ngCyQkTI9ll177YiDmOwdtyAZbHo4bS+/IRgDTXHSSFX8kldLRYNkCZxEQ9ZwDLclzwGc6Pw==
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 00:50:29 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::2a) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 00:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:50:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:50:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:50:09 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:50:08 -0700
Date: Thu, 15 Aug 2024 17:50:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815233635.GV2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e24ed8-b00a-4be7-528e-08dcbd8d6ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LI9bmQP1d4XjTaVafGxrMR54HcIkFnB1aTBOTz0x2EXtTQhVuximMJnF5vXS?=
 =?us-ascii?Q?3qSdumCYmcGItuLLTvJUWv1ovW1T48BliISJ26JW2tjmHgzYGe0WBS9iDmz9?=
 =?us-ascii?Q?FpMhbWAilFW44qq8t7bx9FKkH9xSuK7/a49TRBGWVQNeP97pvKOiVZfe5+ej?=
 =?us-ascii?Q?D9x1fD3WcrHZZ50LccoFonnNH2FHp2IUF/WzXfUG46ilhcaNHfPrveRYtKO0?=
 =?us-ascii?Q?ZUgI8OQ38fr0bWvbtAoTObCwmbeEl8IFK4p1U7pkcXB1mqfF6EqBHlv6dS+n?=
 =?us-ascii?Q?i9k4MFK6gZ/w7tM4G+dta1CDjrC77qSeT1NqWet9DVWo5wkp9Eo2AVr/v22C?=
 =?us-ascii?Q?j2uhLSMOh/fQHhQP/kHxuQyB6R6TtQxSMUribZSWze+EPsi3nR0UAh15ExdK?=
 =?us-ascii?Q?bN4EJITbMEXYhgUR3hYdxyUlPEiAIaJBeWd4jpRajSYk1/TfApzwH63joj+d?=
 =?us-ascii?Q?Rxo5HLdabMGeQxAvC8Yb5rO7qbfJwGVwfbQoDadgSN0L9IoxdM/PQHxXX28d?=
 =?us-ascii?Q?SKSdhWhd/C4vssCyFuo7oIQSzKT8J2o5BMnMtk2G7MP0swHz4IfdoO9iAaZI?=
 =?us-ascii?Q?H32+GsKA9/MUSbzSdWKojRfsHCHHavfF2g73ocA1SBF1XAn5b63CNEODcK1m?=
 =?us-ascii?Q?ACjGKP3dr/3fa89EBlZw5KIouL7wzXkipds6wOPwO1P6d4DVBd+6ADRQDyxH?=
 =?us-ascii?Q?ivH0MrqmSFjvA0x5iSrQVZdTwkp4MWEogq8nK0FyQFFwvdqdl5gF8vRb0kM8?=
 =?us-ascii?Q?QOj+s8NLhSwfzRQkGXJWmbMEBnQfYcs2aNICygOrtTT5iO9oZvwLuoako8+f?=
 =?us-ascii?Q?ru18mDeeC5TJ0j40quG/9EnpPB047JDE7zfOEdbZtB117mG/6ybxqX1hI94m?=
 =?us-ascii?Q?Ro/2Pt+VWjgHzaC5myHCUfWfeQmCpVSRDhBzNa+dOyYHFs6bQ08cWM5/gI1n?=
 =?us-ascii?Q?QqzOAxLRjMKZ4NeDwwg/cBqIB4tMoy+eg1Ii5riq6EXt2rkSFq/7CsdgZ1Rx?=
 =?us-ascii?Q?4sznJkFaQPXrdjCgmeWLD5p+YExdBfmuSUvK6IsK4/Khf8hBhatZn+P9fNb3?=
 =?us-ascii?Q?d5BkhJb4Quu5uccLfJPF5hV8LScGklNJad2umvbWa7CP1SaIGpeQe87oVibO?=
 =?us-ascii?Q?47Ld0ChpFyhY5t/0csrNMhO1W3MEySb2uu8nK0S2tuo+mWyzjOBHgY2IXt1A?=
 =?us-ascii?Q?RdkKl0fAHRjolVwEWMUFTDrFP/t4lTnFSvcQnXB1ab9/SFHSPfiByyJrTNxp?=
 =?us-ascii?Q?j0wX8R7XdKBv+DwWEOfEvUwol/poSkQUIW4J1sbEUNIOtdKbu6sG+d7qBM9b?=
 =?us-ascii?Q?ypi6wLgDcdeRrhzDWdm4zXFC8uTh/gN8J+NAMasLWpf68fGkBKI71jDJVXTA?=
 =?us-ascii?Q?KQPcAsFkWgVMjV7L4KnfdfIxNZJniAw+LB9Jm485Uzdj1TtomxMEH91LBn8c?=
 =?us-ascii?Q?aqH4gDIhKBJlhRJR7S3oGFzfox5+MT+Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:50:28.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e24ed8-b00a-4be7-528e-08dcbd8d6ca6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

On Thu, Aug 15, 2024 at 08:36:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 01:10:56PM -0700, Nicolin Chen wrote:
> > +static int arm_smmu_convert_viommu_vdev_id(struct iommufd_viommu *viommu,
> > +					   u32 vdev_id, u32 *sid)
> > +{
> > +	struct arm_smmu_master *master;
> > +	struct device *dev;
> > +
> > +	dev = iommufd_viommu_find_device(viommu, vdev_id);
> > +	if (!dev)
> > +		return -EIO;
> > +	master = dev_iommu_priv_get(dev);
> > +
> > +	if (sid)
> > +		*sid = master->streams[0].id;
> 
> See this is the thing that needs to be locked right
> 
> xa_lock()
> dev = xa_load()
> master = dev_iommu_priv_get(dev);
> *sid =  master->streams[0].id;
> xa_unlock()
> 
> Then no risk of dev going away under us.

Yea, I figured that out. 

Though only driver would know whether it would eventually access
the vdev_id list, I'd like to keep things in the way of having a
core-managed VIOMMU object (IOMMU_VIOMMU_TYPE_DEFAULT), so the
viommu invalidation handler could have a lock at its top level to
protect any potential access to the vdev_id list.

> > @@ -3249,6 +3266,19 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
> >  		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
> >  		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
> >  		break;
> > +	case CMDQ_OP_ATC_INV:
> > +	case CMDQ_OP_CFGI_CD:
> > +	case CMDQ_OP_CFGI_CD_ALL:
> 
> Oh, I didn't catch on that CD was needing this too.. :\

Well, viommu cache has a very wide range :)

> That makes the other op much more useless than I expected. I really
> wanted to break these two series apart.

HWPT invalidate and VIOMMU invalidate are somewhat duplicated in
both concept and implementation for SMMUv3. It's not a problem to
have both but practically I can't think of the reason why VMM not
simply stick to the wider VIOMMU invalidate uAPI alone..

> Maybe we need to drop the hwpt invalidation from the other series and

Yea, the hwpt invalidate is just one patch in your series, it's
easy to move if we want to.

> aim to merge this all together through the iommufd tree.

I have been hoping for that, as you can see those driver patches
are included here :)

And there will be another two series that I'd like to go through
the IOMMUFD tree as well:
VIOMMU part-1 (ALLOC/SET_VDEV_ID/INVALIDATE) + smmu user cache invalidate
VIOMMU part-2 (VIRQ) + smmu virtual IRQ handling
VIOMMU part-3 (VQUEUE) + CMDQV user-space support

Thanks
Nicolin

