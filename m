Return-Path: <linux-kselftest+bounces-15670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BA957264
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F20EB21743
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40018757F;
	Mon, 19 Aug 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVlsFYAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6EED531;
	Mon, 19 Aug 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089821; cv=fail; b=GV+Fh+GEQn7YLsIWeRpe/OSJuxioXFfHMm1YInBJGakMKfYhWieOF9PD7xrvBxU+bkK1LS5afPpTC1cmX3NHuTkfkiU7aMIqUkphug7Ww+41Vkt14F1F4Y/oRZ17t8TYnR8vWFYRD7cK44iN/i6LwBGpdFmJcH5VWC+ULDmJlP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089821; c=relaxed/simple;
	bh=vP4sCKvm/P3ZjmhMIhIo7b6WJVIf7bvP607YaO7XAO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onv+25PoL33z2yipYi46D2UPYPfj2v2Mr7VfZR13wwCJGoS8RNsfEKAywCN8Bj3/gqPFZjvgOGZlEyHXCAAbl76DhGQM2rFis56nYh/9QyFkzFSDXvM+ctRmeRoFb5f4u5vs9Yd8KedXm17L3qmmr0fEyiogCtZAvWh5nEg6z5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mVlsFYAp; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL/ahk+2ODsneu62hngvLMzIM0hsQjsqO0yeSTGvqIB5k9h2QCejyEegYgRjFUu5qUsqbBM0GJ0ibt9WsdDaYSA9jMd/yfXGMn8uKOOjaHoBXuMXBroyBhA6Wli3jtUhBoorafBM6dGGHU8200G9x8UMwuWrxOs1/88/CJi7hpzOnqRV51nnV/kghKChhGktOA3Cl0AUqdnHzi2Wxgiw6FbIvKDx2pgA5QzCpTGJL5UnjvLb45B8rcoyw+k/W15KhOrkaVv74MJxgJkOmCnO+lnDhS3OEnHZUVp72uYP1N1EUKBbmxF9g8YomBXnO66xX5M6XtuoS8RUS4GVNRfRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyu2/nygCcaWiQN9k5+RVr5BSNFDesDvI0VTPDJjLfk=;
 b=DXH2zNDplx2CQTSPoXG3qpKl2pJ5wIRoQztIFMjTakU65RGQiEeEj4TphOnq5rb94kVpVWJHQp1CnSVg5eOu79dkUsLr9IFvrzUsiwdYlL3qZf5X8jvMgSNrXYvpo+uu3MXPJSismcWHpmCMfIFnsyU4UYvRwEMLpgBcwFzPTYde3nXWjFWNZ4SoRJhrMbu+hRq1YePiL6kP6sZzljBnqgxA1EeIOOvUMYfeySh5AF4LzHPW50N6r8Z3tFCVO154zKsBqFFzOAfilApPOwsgKvXf62xoAyFplyUzAnMfjaBDOaUm6r7yNCBChg84eyXHL22B3U3zu283zs01Zlq6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyu2/nygCcaWiQN9k5+RVr5BSNFDesDvI0VTPDJjLfk=;
 b=mVlsFYApDSsAz8AlbFIL3msioDyTOPb5i/sCET3exPyq40SQL10I+E38kl3AK4k4vtQKyPkBTDXelRnjyj5uzOArRREexsGPgologFcQiQER1Rf4juvVbHcv+c+4nxk+KyLFpiDZw3NgbCiJs128AIEf4fl1+pk0m85w8kBmB1/6R3fALqlNiEEP8ZhaBWQAOrJ7jw9oJ8gc0Yb/rEjHPZnsvKSjPvidtk3G9aCWqTy9ocX0rQkYYzYf2hM8WX1QqcDejYkYoKj976bfUVE3F20T4NrSe11jvyDo1D5TNhNiuDnz16HE5RX2uOcFizyguEPwLWR/d6CZKRmi++a0aw==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 17:50:15 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::d9) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 17:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 17:50:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 10:49:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 10:49:59 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 10:49:58 -0700
Date: Mon, 19 Aug 2024 10:49:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <ZsOFxI2aItINttOF@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
 <20240815232405.GU2032816@nvidia.com>
 <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
 <20240819173056.GL2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819173056.GL2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a620f9e-890a-4eb3-657e-08dcc0776172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXAyrWQ98XtQi2U7T5ZcvmrDJRiWPHF1pQRshR8bNHkUo5SwYcBD7UZ2Y2M6?=
 =?us-ascii?Q?3pQtRHinXYnZqGvPIPhXRGKWkItJFHz6wduDi3njef/bmVsiYKhA07WATnuK?=
 =?us-ascii?Q?wHc/JK/OIjjXUUIBuPEM2aIC/9wOc3MM5yI3/JAqcDQSyz3pGFK2kjzHFzOO?=
 =?us-ascii?Q?qHM7qWa25IXL4exnCOs340k//4AotwO14/snTFgOii/BKEQPLYQnm/Yhs4Pr?=
 =?us-ascii?Q?swjFn8WojSE/puVRLjErpoikqPU1IrGT2ytEc+qUMenoDj+U4dUvMd0SRmZ7?=
 =?us-ascii?Q?KjR3Ziq/iFKof1I1gZMyZJVMo4KeWvceCVRt92CjG3+84stITIXpf8vx1/Ty?=
 =?us-ascii?Q?iTQydA8nUCi/1YGher4NKXXeEM9U0E1RI6inKBRv3RF5657DvJ5/K2Ovx6BN?=
 =?us-ascii?Q?t6klLZwjKmlZ7PToRsNoevaIWCv95zxqU6O7RuDZwdfarFUMtsLewQJsXk16?=
 =?us-ascii?Q?LcsnPUdsThcKZc7PhVfsdsDlUuX58hGeTtIWb1F0i4PPgHMM7vVTxbxzGdgi?=
 =?us-ascii?Q?dNMQo21lAQ1eQhCSpFdgK3OoOgKls7Kfs6fcHarYjm2vDLvtq3EwxgsmVYMK?=
 =?us-ascii?Q?OVJUM6gHbtdjwKwHPQ/qu02vSQHH/51sl3JbKzSXznVe8wJSH/+Z7QTsKdKQ?=
 =?us-ascii?Q?1lMEV5nJMS/qyw+bzNj/PHagQMVMkNeR6PGVNJ6DFz7AFFeSDEYaguIfFlU1?=
 =?us-ascii?Q?bbuSv3rTZSrj/eNNVxNEujaY4NP+aDnRfWdKmFLPzyTPolVjhbXTyJFE7lUa?=
 =?us-ascii?Q?8DlPfeV1lVPHmLmhVJwx7pnaAr3r1YTCk2PWN+xVNiJJjJrfAwtYN+E4TXBQ?=
 =?us-ascii?Q?fpTGjsWz9DPhZRCSB9O16ZaIEWNHrQWY9ufK3hFoFVxBxKA06dQvxtSh1Q6h?=
 =?us-ascii?Q?I9QDk3bFSueEzw71ObWCWHnGPNzDpTv2IRpxC/W/dyl3x+DZBl8648DnP5Rf?=
 =?us-ascii?Q?Vig/Kcj9PgEbSSU0nASA/mr4ZbU+9iplogod3UH0y2xSpbTGlQbENxTSQnuy?=
 =?us-ascii?Q?IOm50SvEA/+cVe+Og1J9qFafML1gV4XVqdHyLDmi6LsgyVLN9DzFhsnnHzXm?=
 =?us-ascii?Q?xSQThCqH02FCt/rZ53W4JaXYkfbsjHzqaLe1qV5E4ZSQqJdti5ml6zMT5At1?=
 =?us-ascii?Q?mlu8Fr4G1vfRpcvJERv02eCfU04zBBt8BsbGmXIxgEBLQoljC1EzqCZpCney?=
 =?us-ascii?Q?+1RXXRJj3AH2tDDpjSdU0IVPm6FEIfL6AOIAsigMWvztpHxxWrgIQ8CaAVp4?=
 =?us-ascii?Q?AyBwhVuIFPA6n3/OwAMgerdJVWu/ltCXrsI9JKFLnwi2lXctXGZVIdaro2S9?=
 =?us-ascii?Q?0gluR08qjadFKnGUBb72JGfhEhY8n+wpnqtcGhJpGHiWgt8O3tSQ5Sxuhk9p?=
 =?us-ascii?Q?Q1+eAJ9uKB5sX63jo9eF87GKa8Gu/u7BzJNkyAt7xkMYu8SEvDws5jIXKbTW?=
 =?us-ascii?Q?OBxXLJ+XVBRh8C8XB0HEwvan2VCkeDvW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:50:14.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a620f9e-890a-4eb3-657e-08dcc0776172
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

On Mon, Aug 19, 2024 at 02:30:56PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 04:51:39PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 15, 2024 at 08:24:05PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> > > > @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
> > > >  	__aligned_u64 vdev_id;
> > > >  };
> > > >  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> > > > +
> > > > +/**
> > > > + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> > > > + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> > > > + */
> > > > +enum iommu_viommu_invalidate_data_type {
> > > > +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > > > +};
> > > 
> > > =1 here I think. Lets try to avoid 0 for the types..
> > > 
> > > And this shouldn't be in this patch
> > > 
> > > But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
> > > here?
> > 
> > Would that force IOMMU drivers to implement both hwpt and viommu
> > invalidations? SMMUv3 driver would implement both anyway though..
> 
> I wouldn't say force, just that they have to use a consistent
> numbering if they do choose to do both.

But if we duplicate a driver type for two IOCTLs, that assumes
our ABI supports both IOCTLs? No?

Thanks
Nicolin

