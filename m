Return-Path: <linux-kselftest+bounces-20976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE349B4E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBAC1F236E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7D195808;
	Tue, 29 Oct 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQquxlg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7151946C3;
	Tue, 29 Oct 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216832; cv=fail; b=Z6L/s9soJOX/vKRZhurkdOAFN/StXTnVRDtXFEDfrJTIDi9l7zxjlrp0Va4Xv3HVczzVf+qQEGgRRHoFxJKUR928YqlF2xG4ivBke0JrkYmV0p2Qk54gI9w/RbdlDOw/3Iwe58gr8aZsURUPLtBtZ/tOEVn3fvZyuVvmFzaSjw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216832; c=relaxed/simple;
	bh=vMWL5Gq86vSg6eT280frcr6OUTXXowCv3lZm9aU6FVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=estQhZfeJq4vkwMGCWsjuornxiVOMn05BZP7hqzzdR96QdrI+26L6Zme4o1194MtSjwECJraXoJ3j148rGgok7fp1Z36/+7S5UoNi40bYeTntbuAIeXNzRXhgg0CbI9dBEiVefKFk0iAsEtrjPpSjOnPsS9/4nX43TWM43dnYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQquxlg7; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgKOibPj691D7LKb512qCpE32ruQn7WAuG6SdLaT99DZBv46rl3GABuKlDxg07xJz0jwhALVccKdmGFbXI0XQn61riGBZaBQFuzEJhalbUZBA9tMeFRe9+qPCk6dkJIDR0DiymkSlxHCKVVjYAhBPwipJITESaGfxuuhSBhUooJKZPvD7A/pGfWmRSasrfkcoOx6j24px+wzydRelpa1HzaBti6yI/9d0jiHV+OyjusN6z2U4LWQKL6aYYxUGmbyKB+5kRO3MQ6dZcPyeeHyi/gHYNeBVDQcFCHSd5L3Q6XHpdfd5Ua4MYSIYT1ErUMP0Gq+XIpou/y7rSlU9jdeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kY8dXfOk2i7Aq5vjRp9CMJia3+ZImRjfZVh8pntbPI=;
 b=pPnT/zH/9yktaP8lJgAwCpQpwNM1DJxgqxOlyagxsh2QGFewAuw4mZvg4c4Uq2NrjDUZtR3fF/RucyS8UL/5wLZfFN7CmiFEIM4WJM8nObbrM2VcrGqSQmbIBLA+HEPp9sx6f17wrw87bJUdJJt0BuzPg5IL1Knezp9BMuusTu7HSvPbdMe2TnITzn1NQnzX919dJXcvfTlOmWrbP6+vLRDSPLNLAMG9ksHRX1p0QMk7NtA91f+FBfn9KihZb06tOL9n0iFfOgH+bb8T43MuM0FaM2UzIeTdGiM/JHTeR+q0JlKJ1P6JgsFMyrJahQZRrL3VMrt++G4r2Ujab6OQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kY8dXfOk2i7Aq5vjRp9CMJia3+ZImRjfZVh8pntbPI=;
 b=MQquxlg7bepYG0K7ai2Xfjctvp2GLJMA45EMtS19xbMwhy3z+v3Ro4L+8J9fuOCME0E4dXq2GZDOHUMnz7qCTEyL1aW/LHB/FtRWllY47uIRxbV3n3sfGhD1FojKuNw+OenTaUahT+XTju08fmOBFW7mLcGVgHDfdiHbI/Ra1DsIbUSScVLbUrYZLDWenll+THf8BtH90DeHuCW9aDEN9boktG/WjuqSoCvAt3pQBYyKkjfQB0xbsLPkY5Bj/4keyyHVRWPJYcn/wArzHA0ZY2morXBmKqmnsI7KNb6UL7XN3pG8GE8OYkgZwlA4aBQlIQpBan+/S+0d3i2T08cjow==
Received: from MN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:530::27)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:47:05 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::14) by MN0PR02CA0013.outlook.office365.com
 (2603:10b6:208:530::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24 via Frontend
 Transport; Tue, 29 Oct 2024 15:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 15:47:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 08:46:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 08:46:43 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 08:46:42 -0700
Date: Tue, 29 Oct 2024 08:46:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZyEDYFxHZ3XkwTfh@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
 <20241029145436.GC209124@nvidia.com>
 <20241029153624.GA210796@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029153624.GA210796@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8507415c-4b76-4e59-4fd1-08dcf830f02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUJ/9TrquIEQouw81TZlVZ9hY12ptGBjYIlXmar51tDGTZq64PbrhfKzFG4B?=
 =?us-ascii?Q?Taqp2zzjKyx3v2s9vzq2QfzQ7MRQhGb0Z0XJXiN1H+N3KGwNc5HkaQJJLLc8?=
 =?us-ascii?Q?raZyRu5AThwpmp6iHXbPnLIfEv2ANxs5RfZKPJTyxg+Y1mSWFjDQtDUcSLi2?=
 =?us-ascii?Q?F2gsalf+wR0eZmzUbhPnIGxdXpx9wtY/UUVQLky2BaMt2xyOPPVt/hR8kch6?=
 =?us-ascii?Q?AJDFjsoE1BlH2GJ2LT/WvUOyiR0Mocnuep7JY1yzWh6rPzntilLDg92Ys4Su?=
 =?us-ascii?Q?NKcDhYGWWpedys7hy9MwZ5JYBLxEY0Do5PIqU0bDcFYTfTxTaT1OWU2C48tW?=
 =?us-ascii?Q?u9ueSlh61kYXYFtj0OozZuqg22msWdMX1is2LRKqLy4I2WYx4d3n2tXtfQjo?=
 =?us-ascii?Q?3VUhgXBUWIi39GjodJtAIR+EOxJbHjvyuWIscmpkYiRP8Yi4zZwafeya7JeB?=
 =?us-ascii?Q?eVtOr4opsoPiUGAGEk/ivW2FF2f9aoKLt+iaTqU88LXZOzRQM5QxXLbisFLc?=
 =?us-ascii?Q?wpgqS/VbPMsdCWn3Yo36iLMYmhbtKZrl1lHeOsRR6boujoP5Cmpciidpp4Gn?=
 =?us-ascii?Q?2C6eJ5q+mRwtK5csbdriAILcM2fYSKkTCci8hrIpwrh+mzUlvn1GU6oHU2Gx?=
 =?us-ascii?Q?eAGyHjK6Jr3T3HbG1yABeAvE6YV2KZXqbacYGUavOPutBAuR41wzZgs4qRD8?=
 =?us-ascii?Q?URT/Waz5ow9bF39q2qUXKDUrY6ezoSrV+Nu9AL8tv8rM5pwUZKt0UIAkqACx?=
 =?us-ascii?Q?w7g95S6uuuwPtx8+g7aEy84gw56fZjDsN6PRZ5LvujAV87fOdpf2cROZmZ4B?=
 =?us-ascii?Q?L2Zb63mInHxMex/ayeF3XY1zxrU/vJCClPRAQEA7CSvyjo+aAPeHGJa8GQOS?=
 =?us-ascii?Q?N6+2YzmGVher/V1LHnY08FpCjbtpyyuSWILL6+68KGFI//vhxajijyomZVxi?=
 =?us-ascii?Q?osfwKFDsUbee9QGm7UrctTOMKES6d5ia+q86IuwNFJXjMkLwVPywn9Z77gMQ?=
 =?us-ascii?Q?acfC4epQK3f3SagjBEj0/0dMAnoFfokAQRS8Uk+j6+9s4NuQCEf1OEfJN1xR?=
 =?us-ascii?Q?E30J1oxF8XlwmSLeyQTOauUb+1zjWPwYuNXN9x3Xkup3mseEaVw57FKB70Zt?=
 =?us-ascii?Q?3z23X0yieuwyqW7/TxWgrkqgLLa9yNkhTfllSPGpIY8PHwg47X9MZ7HIhIAz?=
 =?us-ascii?Q?SEvKqyookXvPkSxduw7TSBmNl/0yoac6DD/qLxzWKzzR4Q7DEQHVmivpWCtJ?=
 =?us-ascii?Q?/m9jDVq425hVIx258bN6Jms3tyt9buVJ20/2JMYN/KkNl14Shz17oK+ENQ46?=
 =?us-ascii?Q?kOpiYGhkImKiZ5OebQroQbV7mb40JiQsL9+MGkQtMiTPcmNqUwf+aCwy6yLB?=
 =?us-ascii?Q?geWFy23bF25M1uAILCinz2iedNiEqIg+0fSQN8ey5fPR4uz2Gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:47:04.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8507415c-4b76-4e59-4fd1-08dcf830f02d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On Tue, Oct 29, 2024 at 12:36:24PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2024 at 11:54:36AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 25, 2024 at 04:49:44PM -0700, Nicolin Chen wrote:
> > > +void iommufd_viommu_destroy(struct iommufd_object *obj)
> > > +{
> > > +	struct iommufd_viommu *viommu =
> > > +		container_of(obj, struct iommufd_viommu, obj);
> > > +
> > > +	if (viommu->ops && viommu->ops->free)
> > > +		viommu->ops->free(viommu);
> > 
> > Ops can't be null and free can't be null, that would mean there is a
> > memory leak.
> 
> Actually, it is just named wrong, it should be called destroy like
> this op, it doesn't free any memory..

Well, it frees if driver allocated something in its top structure.
Yet, "destroy" does sound less confusing. Let's rename it, assuming
it can still remain to be optional as we have here.

Thanks
Nicolin

