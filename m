Return-Path: <linux-kselftest+bounces-33090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE66AB8CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348153A90D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F8253F08;
	Thu, 15 May 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQe7iiCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA71D79A6;
	Thu, 15 May 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328175; cv=fail; b=W6UPWjZXGX3KSBNE4wG96NwsBMnX7HhCUKsZXAdi4+R1HLhnoweDeiNXkHbYFix3F6fUY0bIeMWYJGR6jquHL7RA+8qrFQIamJNEel6BdZ7NkIcZjgkeAlMFj6HS6SMa2nhCSpbvY88aWX2CmdEjEeOT8sL0xhjWokifU5H5i5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328175; c=relaxed/simple;
	bh=2+gvRNtHKh4/d+BfMuMqzRB2t5s0zZ5FqzXXXw5IjkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF2CzaAGbk6cSDU8ARdt1sn8RO+isaxf317/NJRLl4/iBS0nfvtwD6PrIwDZ0ufdkmvw2vYVSOQsC9z7uC0CxAnHQseUa4ioTAK7DLJPBWFw7U5u3iih3uW3cUQkW3OBIV6hVoUgmsQq1Q5Va0juFOvr1uctVDKqHVkHZls9dRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQe7iiCv; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7H+sxmyc937d1b+Bg4VkS9QZnHZSAnMQpPuUr4W/6F187A18DW9wxMS+Ns4mWRTMruzkoicbbFTboTg4GOW+wUq7LDEWfhoMI1NkjX1u3zQ/m6nwLJk9Kt3pombSy4KRuV4BQDizbhPL3X0noLDP81kPskPWGrpFcLVcr5+BKh6qTX2FFp/MqsuGDQbbw9A6DTD7dc87WnGl//J7CBmI/AaH/Z84a9cgaD9lwigNuZ5uaMjS5ySDX879UmWPTz4J6DVWj6CWWwbnynYfMf2pc5gDBuzkfP2osesiqQiT6MNK6oPTluY9/QZXoig0M4ThCddTTWnFjPhyZmige3gVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blSpyKtOLcjhLpc07uWi03MC1czioJvOIso1eMuTPMM=;
 b=yU2AzzKZ6aC6Jm8u7MJDewYAI3pQ4J60lbwB9BygviAzr/HIrLni8CQTXZl41W07nB8ZFre4+kEQ4yC4AtpMuHBHppnwoY+GqMkdaE2zImegZgk8n6Ezh3kbu4MilHgY7untztUtAb13woLhOB4MPrcH3yPBXQRoATIWY8I79g29XEQwsM2kdFHKOXUZid2XV77kseafQuy0U/i99RLsUnlR7pavhbuXI/IvF/53EiWIDR7xSWeVbfGKtKG3AEI6piTsfbUQQ+iMzTGO34TXu6ykyz+GE6pYzjV61USQBRxFYQsGICopzK8iDi7MPu0EzSexMkQvWOLJ3fIyTwRhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blSpyKtOLcjhLpc07uWi03MC1czioJvOIso1eMuTPMM=;
 b=UQe7iiCvwtWipF97LgRFiaQx1km4JKbrhnH6/TUOlcJslRb9YFo3Q+28hJK2G+6awujSi/IUKFonb+4YbVkB9YV2kKctPOVYdzDZWaW++/W2+YHiO5AhiYLvzu30tCPOr3hmB1FGojC/8P1vVah3Q5xHXJXnLg0UZTkTr5zjNGPetHgVCvozn7C6KuKsRI1mAdU9mnSbezq0eUVlYz2Fydh7RfuhmWEbQ8p1wn6wk2FkZuOfS4HPMNem4vUCxouEQmAFfS/dAprLORocLsGGGkOFjLxBzTQnRodTaNFWFpybzX/80N8rRRc22PzUEtnIz2oHzxYNl9OEYMRKUeCNgQ==
Received: from MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47) by
 MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:56:06 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::1) by MW2PR16CA0034.outlook.office365.com
 (2603:10b6:907::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 16:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:56:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 09:55:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 09:55:50 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 09:55:49 -0700
Date: Thu, 15 May 2025 09:55:48 -0700
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
Subject: Re: [PATCH v4 01/23] iommufd/viommu: Add driver-allocated vDEVICE
 support
Message-ID: <aCYclPLg82652sLN@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <cceddd59f04599e120e4620ed001f5d16fb66ce1.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB527677AF23F5CF1605666B388C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527677AF23F5CF1605666B388C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8ff3e0-81f6-4660-9b07-08dd93d162aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57t7WqjS7qj5EAqyjA16x9DY3dxImdoxg19kFQHEwKmIO9FHE8866M2mE/RQ?=
 =?us-ascii?Q?IAMz6M0D0EThcFGAmkuQq8nG4b7tv0ULMCnVB+soJwdRP2Sg5zdiP29Q9sf+?=
 =?us-ascii?Q?NtRgTnadMfw5fdjsmEDKO8ssCkhvveSuFtAnM+5bNzezyrxzIzSWehqqq6HH?=
 =?us-ascii?Q?yRl5K9r4wSsDekb3izyIUkaP8Crt41+l4G5+oYg74JTPDeQoG6v11ggnhP2l?=
 =?us-ascii?Q?jUZDHvwDxQ54OPWxjW2+V+XFrfY3DaH2GmSuteqSfMcdPv9oZ+Usxs+Ve8DT?=
 =?us-ascii?Q?iUAWbwy6h1PeESf07o048OucAkkmU1kjLSTCcMMnzjw2j8lGQj+T1giD3Ewo?=
 =?us-ascii?Q?y7nXjG59jXJcOIKUUoc34809k1mo9sJHY3HraATQA+TxutVbO7qRMzF4c/vQ?=
 =?us-ascii?Q?QgHFouJhcK3EMBBZ25BAlcwqWVytlIIS+dWc3jE2ayutjoq1PVRyHoQ1dNBd?=
 =?us-ascii?Q?v0fLyyfPs37XnEYXSu7elZ/Fr5LKAMCQ8BJYJTOKNt/WzrkPDLPhkMcfLacY?=
 =?us-ascii?Q?aoS+mES7qvNMjnt1gn5Cq0gYf22qmFjVBm9PrWlvslk8vky7TuxO47GBEO94?=
 =?us-ascii?Q?Xl0nzkrS7pNwenueMjC7lrj/T5MqUAPeMwzWhG3LLEXmO9IQ5nCSNjHdlPIK?=
 =?us-ascii?Q?/PRNqmdu2TgrRI0lGzvWWvb/iGQemInaEmyH75d0CsBhAPfkn1sL3pwG2E+Y?=
 =?us-ascii?Q?OPdIXWRLK0e5DqWSHcXzXyEqo4T1d1IqoUb55ZonQzDjDwQrO3nmlPwtJEDP?=
 =?us-ascii?Q?pVGESlstETtKdce+cEKKTPY+k4N8ex6EGnC4WDRiH/EO/BU3ixeTHhN5WNQp?=
 =?us-ascii?Q?a8bHIlf7pRhHnFibThFGTBdIUTgVHmpZjU1u4F7JoT9QYuc+tjhkv3v4a137?=
 =?us-ascii?Q?4B4TyBmD/kXRJjObwJCzglLoS2xPbVPTs7hNaWod6aP6uKnVwCLsoPq7zxW5?=
 =?us-ascii?Q?k7ztoVdO/hRNEmOnqED9238aDtwDqu2q6QJaB292FR+RwsR/1r0lhSP245b9?=
 =?us-ascii?Q?I6CUel8DYENCQ/TgfoHHT9euzLgn4NoEFovgo2kxrz4kDrXA4oKfBAsAQgEu?=
 =?us-ascii?Q?5AgNDAmepsy0OPFQMUEYM77wKf1NhlVFdCMN4ArOpbbfIYPyL2cBHUgVBtEn?=
 =?us-ascii?Q?zRtTSPWFNbA483ou/anG27PkrpR0GORA/BEfoYv+fjNWFvPuJHJOH0b0uuwc?=
 =?us-ascii?Q?+nxNZSw+ZY4KDd1g2Rzp0v4bzbpO6E19ZDGQ78pfdWOVzK6d1BEBxJ9k1RDD?=
 =?us-ascii?Q?AbBwdbig1lRt8iKHOo2N5su6vckP07oiDjoR1el6eDoRHraL60t1ctXTkHIJ?=
 =?us-ascii?Q?CcNUo0TDke1FeRskO8aAFnwChADeKf4XURC13crMtyPspm/rjXDUGzFuqbJW?=
 =?us-ascii?Q?9VG1W6eqKbWLPjvByQg1/f8jApSxxxk6Lwjy+lgMzRho3lt4gi6aR9PezP9o?=
 =?us-ascii?Q?4/aSaOj7s2x0Z+bzQrLsDUsMXAx1pUjbwcVkBmon956WOU9kBqKezxjQTrZY?=
 =?us-ascii?Q?VLJZcPnK/IbP4cQLe6YRvumGtuokwyKWb10S?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:56:06.8347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8ff3e0-81f6-4660-9b07-08dd93d162aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

On Thu, May 15, 2025 at 05:42:46AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 9, 2025 11:02 AM
> > 
> > +
> > +#define iommufd_vdevice_alloc(viommu, drv_struct, member)                      \
> > +	({                                                                     \
> > +		drv_struct *ret;                                               \
> > +									       \
> > +		static_assert(__same_type(struct iommufd_viommu,
> > *viommu));    \
> > +		static_assert(__same_type(struct iommufd_vdevice,              \
> > +					  ((drv_struct *)NULL)->member));
> > \
> > +		static_assert(offsetof(drv_struct, member.obj) == 0);          \
> > +		ret = (drv_struct *)_iommufd_object_alloc(                     \
> > +			viommu->ictx, sizeof(drv_struct),
> > IOMMUFD_OBJ_VDEVICE);\
> > +		if (!IS_ERR(ret)) {                                            \
> > +			ret->member.viommu = viommu;                           \
> > +			ret->member.ictx = viommu->ictx;                       \
> > +		}                                                              \
> > +		ret;                                                           \
> > +	})
> 
> viommu->ictx is set in patch5, so logically this is better put
> after that.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

OK. Will rearrange a bit.

Thanks
Nicolin

