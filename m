Return-Path: <linux-kselftest+bounces-15675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C077895730F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97BD1C22FA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31719188010;
	Mon, 19 Aug 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfY8tpPl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C615ADA4;
	Mon, 19 Aug 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091751; cv=fail; b=ME4302LWd92gvy5Yk7I7yx7Ii7WuVV98M95GQSruWEJtNSRBgzCa4FYYkKmy4hO9z7TzmQSWi6a/KtIY7B2jowwLlZDpw+f/rKnC+HhwOyFGYYsmKhi1XiXLqiK9vm/vKFVmDjwr6sgoGUjUSC2EVpAs2hDpBmDR+DhAPzWph0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091751; c=relaxed/simple;
	bh=i2cKpIYaeE2HeBdSK33IdaGRXpstBEoM0rRuWIhdBM0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7gHLbLbEP8E41zaTfKhXBG/AQCyuQwUpPLRq9t2jsni5BoVYmuLRAsI/kqr4rEBbTaeruQreP43VNxcvNLmBL/qqXjsBYL+weTA1HKcIj3/Z9rHDUcpCxQUrRdX8wGt4XH3/7PWgo9aPdLM/VDeTv4wQRVjdzIvoM4A+r6aLMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CfY8tpPl; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfA59wLp5viqm8EEjiY0uT9GvKqbpO7qr9/HjSu+pHBa4NecZU4om/PVgo7cGDZ45D//WIkk9tQxFG3fVyzUWEE4++skX7jWFq2SgVbY2utN7cWMyQN7HCpZnIZrN1o8yAwnOk2uS1iUGcqr39LaoiO2pnxCb6Z1olQP581Kf98Zbdvt8D2Hl7nAEaARTaB/CaUUw2N50+fVF93jsF0x976Rd5bv6i2I3v32ziEfjrcCcSKu8vCU94tT164ksaUBjB9pB+zljBO4biCzf16VcqGDwyayCls1pkv4WBjZVwWjnLcJvI7I4VhSCIdLhxTbJRhdfXFngXdz9ZEZ/23H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqeaoO0ZOthDt31XjXFbyofrq5u/8y78AafcHgJDru0=;
 b=I0O2gAdkeRbLip3W1CwKASrWtWMuNLJaUC11GDV8QapHby8Wx1FQSNLcUU6T/EZ/lTJN/9758WHOfuy/UjuD41aFh4AbzdegqJvwpTjjiJLKgFUv7s26p/UYlb6gYM9T3IIy9TQwKYcIfzg5WwoVTLY/FU+INU3Fm5lGlu70KFI/bHsH23/8QVmyk7Kx8wLesFIoPvjBGDiDsAYdFVYPj35pk6LZBpFHkI7IZ1yJlYnuym6nFjcGMBWgAob8XiFK/z9AoSuUDkFrTX24d0zS6qJyznZjkcYO9yh8dY1aHd71XblSbDTGgMs1x88qv3mXcIJ/+tr3ZfF/ArkgXx/I2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqeaoO0ZOthDt31XjXFbyofrq5u/8y78AafcHgJDru0=;
 b=CfY8tpPlrviRO8IufxKGeBeKh66/HqTDPLYNwfdUlp1UA4CV5wqqejOMJUugYYJbiZB1fQEbeIEkl1UOBDRJ/lw11NQXoICjImirAcJ6UC2GzSoIp7ox8tF9ZdmKC/hvuRLpxTwdxaoGMM92qxWwpwNHyWW7P3g592Lv4KCrCFS4oWnFqA5iuG0lZXAUGLR3ut+qzA8C5Jvte2Jsuhsc9V/87Y/yptcEoaQmjNj0srteZ16f6yKdfQEG01VY6xbL+IDxLtAqqgbQiaw7KtDa/VQbi22sBeyDifn4wX45dQmR9hCbDcD5PD0v/h8zTinJRQWR3b6KXQZ5lFhJescJuA==
Received: from SN6PR05CA0031.namprd05.prod.outlook.com (2603:10b6:805:de::44)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:22:26 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::af) by SN6PR05CA0031.outlook.office365.com
 (2603:10b6:805:de::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12 via Frontend
 Transport; Mon, 19 Aug 2024 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 18:22:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:22:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:22:11 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 11:22:10 -0700
Date: Mon, 19 Aug 2024 11:22:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <ZsONUchYesfahnTl@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
 <20240815232405.GU2032816@nvidia.com>
 <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
 <20240819173056.GL2032816@nvidia.com>
 <ZsOFxI2aItINttOF@Asurada-Nvidia>
 <20240819182035.GP2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819182035.GP2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 513b1dee-30fd-4f35-33bb-08dcc07be088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0tZczVOJ9A2s+Y7jV3ybNZCwrd3FeobVDdq2ifgnxXI3Hi30pvD+zgq8qdW?=
 =?us-ascii?Q?77EYMtAUscfnN6TIKk1jqwNFZ6HGyTW3mWIzA6Ff1WdHa4LKbgSpOtkUFzbY?=
 =?us-ascii?Q?leR1jLhVD+Vhuklle77FxFaj7h32OwAZHTcbcUUDf1gm1A6QDN2Ip3e5Jf3U?=
 =?us-ascii?Q?Ztgmt4sNVGxQXTklRdHvfvrqLGPJHhPGiqGFTEc6tVmSMt937NTTSvpjvny5?=
 =?us-ascii?Q?lNjKC8RCmfMj48J/WPXFpuVjoWA20fFX4lLqRry7vLSS8txJugG3LmlR9WGu?=
 =?us-ascii?Q?KRrobGu4/DC/N4qdHOLJq7v+iPxpbaciC1UrsWWwWYMU+mrrCtqD6PaQflzp?=
 =?us-ascii?Q?1zMGUX/XxijL7tvp3Kk5U+cYgGNIKj19lnCyBlTSGvWT/ucEKhav9fmSw9es?=
 =?us-ascii?Q?udNiGnjQEhlt9hYPcup7Jvx4uMfhulO/YS7cj4zjWYkxa/oX8mlNzytXFlLj?=
 =?us-ascii?Q?c1UxbLWjNn32zOM2Jex+e0Ps7xavY3PbAt2xdVcEdjLKphlxHlosLPEdlu8q?=
 =?us-ascii?Q?W7ig2D2w9upmZBFQQG1V/HqIktVSZuGQAJJj9b2Q+zkHxhqcxXxUpKR3RNOJ?=
 =?us-ascii?Q?Jyvfleqg9twXYfxZ21Kr+ek7Se0yMoFLP1rqB3bnQU4wxmjExvb4dV/iFEeG?=
 =?us-ascii?Q?OQIChefwVjRSo+ydvF0JvE48cAdD7G9nztJ/skz5OBi/XBRTQTO1IHVJmwks?=
 =?us-ascii?Q?TczluiOMvVQ9JVmGWE3xPKaAxhGqUOuDVxBt/Tp6CqDNgW8+Zqy+4ic9ueSJ?=
 =?us-ascii?Q?kUGnDpPRRcDkti+fo6QmrpZn2w4W37bcCHk5acrnMc0CE92CQtepzQH6gRmw?=
 =?us-ascii?Q?MVAEcY+gJ+cOjhsh65lqqe4yF1hGOtuioQQ7LRoLzS6ROidcuXCbQ0OmGpmp?=
 =?us-ascii?Q?KEQT/kkRY64TEB/nR4fNeUhv1zPGXVyzg6j7HTkj/fTJQZ6v7p84M6PRdh9t?=
 =?us-ascii?Q?XiwrXrDKy4x2kKRYn7DBYhmwqyzlBuOM/bfEqAjrVoFQVsqDjAnk4HvqlJ0m?=
 =?us-ascii?Q?MrlTAAC0uixE1gdL9FUUmLN9sLFxlIeRp2HgogqQXZlHDlcbBv45ypQZbqKq?=
 =?us-ascii?Q?plcprpxiiW9wbUJmxWFimdHQjSr9GnNMUNob0vxFKBIfs3cQlcRRE3Qc7bjC?=
 =?us-ascii?Q?noPpHNAAADw4bG6YqoWMaH6D1HL7dG/ghmuHDMDWtVwGYlgZlvWU4uElxqu8?=
 =?us-ascii?Q?janH5KkR+9Rmi0Bm845gqBSDYK/rz/D6LqXGXKMn+7dHyWMP+oSM1GgZaMbQ?=
 =?us-ascii?Q?bvPvr41hXW97yXQpTqu39zk31HMkx6mYMXLpjTRL9CtvwZQCUgVrnSAkwq+P?=
 =?us-ascii?Q?nwWG+znULdvGinJViAlMEpg5tVflEuXjc7l07a66/3pg2Cqf7Ohlzhc4k9cu?=
 =?us-ascii?Q?Mh36RRWI2pcxbVEg0X3C42jkckF3OrzrrmGAAFaqmlOrqa3OTqgco/qyZOff?=
 =?us-ascii?Q?hBD62+rg7fnvqUAI/xXU7R0U0tnRZRB5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:22:25.8894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513b1dee-30fd-4f35-33bb-08dcc07be088
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

On Mon, Aug 19, 2024 at 03:20:35PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 10:49:56AM -0700, Nicolin Chen wrote:
> > On Mon, Aug 19, 2024 at 02:30:56PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 15, 2024 at 04:51:39PM -0700, Nicolin Chen wrote:
> > > > On Thu, Aug 15, 2024 at 08:24:05PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> > > > > > @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
> > > > > >  	__aligned_u64 vdev_id;
> > > > > >  };
> > > > > >  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> > > > > > +
> > > > > > +/**
> > > > > > + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> > > > > > + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> > > > > > + */
> > > > > > +enum iommu_viommu_invalidate_data_type {
> > > > > > +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > > > > > +};
> > > > > 
> > > > > =1 here I think. Lets try to avoid 0 for the types..
> > > > > 
> > > > > And this shouldn't be in this patch
> > > > > 
> > > > > But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
> > > > > here?
> > > > 
> > > > Would that force IOMMU drivers to implement both hwpt and viommu
> > > > invalidations? SMMUv3 driver would implement both anyway though..
> > > 
> > > I wouldn't say force, just that they have to use a consistent
> > > numbering if they do choose to do both.
> > 
> > But if we duplicate a driver type for two IOCTLs, that assumes
> > our ABI supports both IOCTLs? No?
> 
> No, it is just a numbering system to label the struct layout.

OK. Let's merge the then.

Nicolin

