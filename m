Return-Path: <linux-kselftest+bounces-32057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F492AA592F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 02:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208219E2580
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F871E5718;
	Thu,  1 May 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NZTwtEdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1120EB;
	Thu,  1 May 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060896; cv=fail; b=JJrYywCA8LOtpLNXiZVuYumDbMD5b4T/HGodiSV6p24JMQl6O8DIaex0F8LGwWxs5q26MpKq9DYnWpcXBiF2N7qRbLZyCAzjgXudWaAzMxN1uwklGNbq0xK0i+dYH4nKzz0riUptmFLSBd7GKov6pE+C3W0gT2rHVo9ES+Cxff0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060896; c=relaxed/simple;
	bh=AlAQbKU1JUROLn0OsNg1qC3HGVb80iAdkTdVuNui8uI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrNM/JfEAnBMXdEPLM0uwQqlfnwQhEDFXu9T9P96Um8uV1ByZheBA/QrG/ymIAtSJytnMqOTFYPR9+FusjAtlgWe82GTmgtZhWeUOgGSL1fN8gMvDL/Hc9j1Fmj/JO4YwhU6k9r2fX+hp0MNhaZoCkJ/DxbXJWcuKey6483I3NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NZTwtEdI; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3PH9Mymxaq5XiM5njVsl+iZ7yTmrUsbm+AoUG0TMltXY89klAngIw9Ychj/Qxe/c9Cz8zIRR8ECddcdHU6UuNLAmz7rTWRwKE1AZdTI3T88zBRX86zq0jxbOCZpR1DWaTytlTVVN3Nagngf2hnWuSm7+l9uSyACjh8swB6JeIukg+LMNrgu6rQgIbU0UbBIHXc40//Sv3u1mGZkwswSjprUPd+PCC9L9/yvi/pVwoz/erXcuTyBpKrnRvAbU1L5NVjMK7OnEw8maL5oRBSq7kJcJm+zlqfLEY4E6bwCLn0DLp/btQl1JlT3y/rBDvAYu57XaXn7+E42cr3o9Yh0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvilShwMKmOhEtxT64Icd0+dLsetgu0O5uyiJDBA1Kg=;
 b=speXgSh3XJ9UoFwh2yv3WVeiNFujWrVLixHX5a54b3XQKU+VAH1WW8/2neFpv3iMT6QXNd10hjNoH83Sl5RZ5HcwGlWMhB5b6t6xZvOczKMzNcqyw6XmppKQEhFxZDa0Ykdm7l9tKkwqPPffYs+9YXpOBGXQi2wgBfmMYhVKbEoGmusNXHmNaJ8rYVtHB4f30nevEkhv5ntOGAcLxJgUc+BiGwakWg5m4TbeZRx0ZNyh2vsQpZMyqtF56/wrJ3vQn6TLsqBhcZ62d+x3L8EYFPaTuLtGey1R9lNTa/A40w2Xud3gXBDLY32R3y29YjouZOr+SbbxBljRVA4ANJlySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvilShwMKmOhEtxT64Icd0+dLsetgu0O5uyiJDBA1Kg=;
 b=NZTwtEdIgc833u7B+tOx+Tcy0LyN+M5Qzr7fkGtYBTiAkYr9u0hG2ZYEPHLpqklmzbKjgbeUHGusxOc4BWeVRVbvnvjZqP9mWq9hBuSTWEVnXbGluLkTq4JDE3RAgPr5WOS9W36nbBSMXNvd6L9aeR6B4xAchcx9P1s5v+5zA0ZAZBMisKwCXVMnrz4gVMw53VrEqya7ZXHmmJ40jEOiPFmvRYwpcN/ORRDz2Df1vzl2iZEDmzaaNkJsPds5lm4VZleMM/9abOd/a6oq7mnrPNiPeFgr6fCFduA9GWA4VLpytj1GqUW+MLh3dFemPfM8axsnq2bc05jG3LapqYgMTw==
Received: from SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::11)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 00:54:48 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::16) by SA9P223CA0006.outlook.office365.com
 (2603:10b6:806:26::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Thu,
 1 May 2025 00:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 00:54:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 17:54:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 17:54:45 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Apr 2025 17:54:43 -0700
Date: Wed, 30 Apr 2025 17:54:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBLGUby2dIiYCe7S@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
 <aBKdMaFLPFJYegIS@google.com>
 <aBKmk6PNFreeyfLh@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBKmk6PNFreeyfLh@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b930f59-710a-474a-22b0-08dd884ac5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|30052699003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jn6dCGp051Z8XcnHtzGRmDo376T+yPyqMZZD0PxCtRwXjmL9eR1UbYxcA2F5?=
 =?us-ascii?Q?iVVWpk/6GZtwWdKJX5DdPzNx7pdiL1fUKL6MJP8aOS+brnB0RGrfEgpa0mod?=
 =?us-ascii?Q?rpN1nAR7PtzHaNLalUGaHrnpUzThTVGCycrC7ksJvnEh7gVjF4MqQaFyjq1X?=
 =?us-ascii?Q?WAxfnRAfr3yGUzapXT9UJeytVyMbOTSHBCYWnqLfgozTrW244pHbp9FjisIU?=
 =?us-ascii?Q?uxbalxf449cvbBlhtT+uDWcYMxeiaQI+e3kAcEqHaff/SJKn5tXT85NSrCGt?=
 =?us-ascii?Q?u66MrC8py3DlFiTnBcHrW/szkvYQa+41hEVA7WLI9jggY9JkDuNlphin5iBx?=
 =?us-ascii?Q?kFBSkVuB1og6S5wlF4u12DZ88Q7JJqAJ7BQj1w9Kb23YWhsDikC/3wNnItFg?=
 =?us-ascii?Q?Q2otdfpmm3I/30mj6/qcDCCJv4VRjlcHiYBbx3y1+U4jKQWEvruJxnG46fVW?=
 =?us-ascii?Q?wJsimLrnZpQAh6kiSD2A3ahyfIU6DRijEYBeWGebexJxHcO4FL41CJiEhx7K?=
 =?us-ascii?Q?7QDXe9WGTvc8gYcaiFHvx1QmD2PbFHGBZbKMEF+q9igOB0qaMDSOq/LPk8qr?=
 =?us-ascii?Q?Mbp8nbEwAxkHyvWBsSBIHrrLS3lyCN5IPAMYocQ8DLCMNM/UP2hoz3dMw02g?=
 =?us-ascii?Q?Ps7R32Tlj2Fjl1BG8ikhSUyRTqoLSwrXLSjush8LC3WOn2jLTkOorhDE7TD0?=
 =?us-ascii?Q?Jjl0yQ7+L8tF2rukNN5n+SkYRVg3NGbyUEyNvm9Ut1UAZzIqxHi2XEIwGLq1?=
 =?us-ascii?Q?wtmzi1rdJIEp2V15nbl4vUML7vcb7Qmqq50x5TOrDDIVqzVzHN0s7ZFb2XjU?=
 =?us-ascii?Q?5uFXDRcuo7IAboTJLsOvn0TTQSCkXKpvyUeQcT0GWgEx/MpLoyemGCc7CnzG?=
 =?us-ascii?Q?pOtHTfQgzmlLV9HHm8yK24Yh2m1n70DWnNgFnw0GK5ywg9ykUkFQ8cehvJPR?=
 =?us-ascii?Q?99+oJuygiA0xeP35OfARsYJPNM5PnaH3yhlSXBh1N2bJGepuPEyLZxVSmQmX?=
 =?us-ascii?Q?Jl27KUcdwteaqyhunPF4KKJsmcbX8O+0lGvlOvPYpb7jsqAnb3MytBqVDWSB?=
 =?us-ascii?Q?RbO3SDYtxd4+QLq3QHGaEk3c6wS8AGZtckTW+2n7aS1fwVnMR2o8JiLWSGkn?=
 =?us-ascii?Q?rnkcEhpeubWaW/jz7Q7jwmUBijk94swtOKD39eVPatMcaRUFR7SfcI/C2blH?=
 =?us-ascii?Q?nIi79I22RZIUJQrNIV7luPMpxsLsFrDL5pjbi/0luMhgx0my7BWfHvjiNmlD?=
 =?us-ascii?Q?f1boTtCDRctZBdQKk6+P9rEXzmiLDwzr4WhYcgmB7QK4vMpMLKFNxbQy0Q0Z?=
 =?us-ascii?Q?6tqPaAEFzEmIjffNYt3EG7PeRgIVuExgMUJD8Y3ngKVHr1QeUgXXfC/lLv12?=
 =?us-ascii?Q?LxjYrdnba7SVIa4PM/MHWpz6wPCPeKyy/k1kmJDOGA6pEOaMWXWoIWDf0TlG?=
 =?us-ascii?Q?Ud2ih5YgSDqKUGcmlkMkkMda4/PLaNY7kn1hV1YeWMR5anaA7DszpP1delu+?=
 =?us-ascii?Q?xIWLlgOV8NCIjvqWcgirlMAp4qz6mEcQC3X3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(30052699003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 00:54:48.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b930f59-710a-474a-22b0-08dd884ac5e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

On Wed, Apr 30, 2025 at 03:39:22PM -0700, Nicolin Chen wrote:
> On Wed, Apr 30, 2025 at 09:59:13PM +0000, Pranjal Shrivastava wrote:
> > >  enum iommu_viommu_type {
> > >  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> > >  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> > > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
> > > +};
> > 
> > This is a little confusing.. I understand that we need a new viommu type
> > to copy the new struct iommu_viommu_tegra241_cmdqv b/w the user & kernel
> > 
> > But, in a previous patch (Add vsmmu_alloc impl op), we add a check to
> > fallback to the standard type SMMUv3, if the impl_ops->vsmmu_alloc 
> > returns -EOPNOTSUPP:
> > 
> > 	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> > 		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> > 			master->smmu, s2_parent, ictx, viommu_type, user_data);
> > 	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> > 		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> > 			return ERR_PTR(-EOPNOTSUPP);
> > 		/* Fallback to standard SMMUv3 type if viommu_type matches */
> > 		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> > 					     &arm_vsmmu_ops);
> > 
> > Now, if we'll ALWAYS try to allocate an impl-specified vsmmu first, even
> > when the viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we are anyways
> > going to return back from the impl_ops->vsmmu_alloc with -EOPNOTSUPP.
> 
> That's not necessarily true. An impl_ops->vsmmu_alloc can support
> IOMMU_VIOMMU_TYPE_ARM_SMMUV3 potentially, e.g. an impl could just
> toggle a few special bits in a register and return a valid vsmmu
> pointer.
> 
> It doesn't work like this with VCMDQ as it supports its own type,
> but for the long run I think we should pass in the standard type
> to impl_ops->vsmmu_alloc too.
> 
> > Then we'll again check if the retval was -EOPNOTSUPP and re-check the
> > viommu_type requested.. which seems a little counter intuitive.
> 
> It's just prioritizing the impl_ops->vsmmu_alloc. Similar to the
> probe, if VCMDQ is missing or encountering some initialization
> problem, give it a chance to fallback to the standard SMMU.

I changed to this and it should be clear now:

+       /* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
+       if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
+               vsmmu = master->smmu->impl_ops->vsmmu_alloc(
+                       master->smmu, s2_parent, ictx, viommu_type, user_data);
+       if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
+               /* Otherwise, allocate an IOMMU_VIOMMU_TYPE_ARM_SMMUV3 here */
+               if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+                       vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu,
+                                                    core, &arm_vsmmu_ops);

Thanks
Nicolin

