Return-Path: <linux-kselftest+bounces-35788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FCAE8B8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 19:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BDC3AAA73
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626929E0E7;
	Wed, 25 Jun 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rTxzWXXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E426B76F;
	Wed, 25 Jun 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872807; cv=fail; b=fXsEZ1rXiF1cu8duXYrz5yVwoVpGI10msEhVEhxK4yK2oY//NAE4s8SCSS+2gOw8GaraUL54sUz9/PnLK0RLZ8lpROC+JsQW/jvpkLjUGw5wW65HOYaTFtAx7FSli83X9vW0xodB+mxn7Ax0uDRod1D5KlGgneRjYeLSz1MB8gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872807; c=relaxed/simple;
	bh=+XEpzaHfnpPt1R7BMIQa8tVRUN4JvFTnX7aiLvoZUUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpUgOL4yn4ZGN+6vhXGPF0QFWEBYe9J/fHLgq4to0/GMCh36qxv0Yb9X2BeeSCJozJaeWCrBgqC2/K2eq5YCBsqvVW+p02v691h7N8cFbeLsAA5Pg5kee1qNa5XhvqVCIdPQKDlCRefi2hHx6q5jHEUnTuPXMsiZSZlN4iU3bao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rTxzWXXj; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMDQ4KE48BVzvysYtGAeiFuyzPFsp9zbyT7/j5LFxGC9knjA6Xei8TBIAlQ47o2FfPsTqw0uhHQ2gb8M3fcXlz3/HOHo5sNBWizEIonYKor1VIQ2VhUlqKVmLtP+E+akO5xK1tzrfDgUxMBuLCzBTiX+SNLwJHnu0/cWcksyTjMGa8v9fpqxCb5V+p6b/330y3sVkE7sH0t1uH0JkVY2b2nLj0yFuUI7yfKPBB0hsPQlF3vFO+jPPVNeEvp4ANL0o2XvUj3mN1E+kPPSobLI4Kv9TGD1MtILEcBHA1Uc3wPsZq13jcTXtCm4T8WitUC4zYxv2nBEQ3XksXxUW9H0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay+OoYaAjDj9hZe+qVQx/WgvfjaQQCv+QQtBOyngybE=;
 b=eTZVt9FRojx02Xtmwyv8CahpQ8guIcYQ7vHeHt0aUoBOtm5z4RmrwQ+RJ2Sts47BYofNL1qBhdN9j2zAAiRl/gP9LQiSvMyk1mRdPCLQROexAoMruGfgGjCu8WvoVHOppsPjo+wUK97EhtlEDtIF+6Xto8ttUPk2jo8saqydAToO6ExhLaYBG+k8PhUF0jCdqUXLGtEFGSbvfFE1l4OTV7AgCQhPxWTn3pYE8gGx0jz34qtHMusKk1tXSEOPjAPvFxk6pnC5Vc9y+b/VLMGfH3Jgi7UaGb1mpM4g0UyJIla66iEsocDjRhoZoxE/LCYJvHA6v5m9T22sJNnLAC7lEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+OoYaAjDj9hZe+qVQx/WgvfjaQQCv+QQtBOyngybE=;
 b=rTxzWXXjRjN7JGPzwJGr8aiJ4kjIgVZMSWEUNAh4z3sOBIUp+lmuftlnp6DlLKCc5Gs6DDU04ypPgiLF++vtB6S5fsnpQ+qQXYWSFzEosZSZuJcQPcHwF5HijTJxgvB9iEDKfemYWyA2+/Cfncfvh9NaMbmpXbi8gk0U9n5YRM/yTOFEWJrPXtDN6cOAQr8T5RsBsqZ5xCNXyY51a+lj7QfA+JpZ9QRplMTH9SjcalmI0yroCyG9slqsgHVqD7h7TSIafyubeyBbk72l5AvG5+tJraNBdbLH07q542QpZmmnZbfrXIli1lsDzcI4NhU5bOLgjc57xjTZ1f1bYoXxAQ==
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 25 Jun
 2025 17:33:22 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::9d) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 17:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 17:33:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 10:33:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 25 Jun 2025 10:33:11 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 10:33:10 -0700
Date: Wed, 25 Jun 2025 10:33:09 -0700
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
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <aFwy1V81mmM6R/yU@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
 <BN9PR11MB52766D0C0B12F1F10A6BE7548C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aFwlu7FlfIP85gko@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFwlu7FlfIP85gko@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3bf00f-a8b4-4a94-0640-08ddb40e60de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xvg1vGQEWv8PvdcMD90bZq63guzx/PT0227WMo3s95vpbBnYMD7wWDttUk3s?=
 =?us-ascii?Q?hR8OkpB4LqXQMNOWInvqk2Yiun2rcOvaiwNPjccu+4souQFxWF7OBKLm9LXS?=
 =?us-ascii?Q?TydMm4fsxX2+WZKQ8pWkgqnBrv2qa2xWUQmBEYPS9Yw+gEtmhkiP/Laho6Ab?=
 =?us-ascii?Q?QqpNBcrG2OQbSKe1a8lPu5ojWckUWiqGy3Yt3kpXlPQLyES9JTPBbPMhjq22?=
 =?us-ascii?Q?vr0nPnbiySSVwckzBfg67QIabIjrJnD6/m0aBFkOlH8ZJzNd1ioEp1f9N1Cy?=
 =?us-ascii?Q?KF9z4Ir1wTu6gqLosOcfn2QaC0Ejx24U5nMNkpNToO4pIDi4hFgBxUgHyW4Q?=
 =?us-ascii?Q?aGH5sMZlqT2gDE0eNR6XD2P57uWZQEX3/8RnOcwndhD/b8XVKfIydPAFpKOH?=
 =?us-ascii?Q?WEoq47RN6kKMOb+Fqeej3Hcjs+9G40hfo8gBaoFGlkGNj+8vRSolV6YyfObm?=
 =?us-ascii?Q?Zy59muMV0o+Xzz4DU5CawYWXfthMQinUEF/IFA40e+R4cuCx6DO/s9+2NpKU?=
 =?us-ascii?Q?5IERosOTsoqMECDG/LGfYmXOeuKLeq9rjb6wgqjdQEObHCJ/9TcZGz3j1oFU?=
 =?us-ascii?Q?obWTD66Ehee32h8N8IcJd5fjWFhNtH528vSs+t6RCvIIkHIaxjJYk6pEHXmA?=
 =?us-ascii?Q?aCD/5AzYYRwCUsHRFioTQy8tE6dsOzQ4bkDA7WOdUg2BBKw4n5MNIJchAHmU?=
 =?us-ascii?Q?IZQEIfuTFY2ODXSxfEQkr/Lr4nCaJ+t8R5ZBMspb+JlvQgWC/YoXAfvo5tp/?=
 =?us-ascii?Q?ZCHNAOR6u/bqdBkSpTBx3J4Dmc68dccxatRWZmv1UWNCn2iEQ8kKzXfVY3EV?=
 =?us-ascii?Q?PemV+MXX6iJgPNVWmpxqWKs9QRMnqqcPlT6kJMg2dFjR4INhz3KasuTFn0Kq?=
 =?us-ascii?Q?O5YztEuICZi0irg/VPxCxiUkXFojCZ9H/h+UKG2ssA1ERQencrV140AfMkd8?=
 =?us-ascii?Q?RWCOfXqJaMd72GVIVXWYiyDq2OT06kC/+I2PwG/a6mmZuo4/etLN4g2qPSJO?=
 =?us-ascii?Q?G+bXQrK5uXnPzCXY84wwciWzXyDcRWttERukutzfSkVzmbD4+R95THBX2Wdg?=
 =?us-ascii?Q?IeIR1Ez2e+GRKIEsJiVCtf09WFkUTVFVEhiHDzPLUjHWoxvuu390jHkKchy4?=
 =?us-ascii?Q?vYFPRuYn3zGC6X5Ye/5p3qmGOBp1KFiFhe42w57/6niu/ScHt4u7mVXRdo1u?=
 =?us-ascii?Q?g0gJ+JjlJ+68sF9pVEVYuEvo2fbUhySjZaxnsLSfz3J7NN3ZFaLJPsYNuKuI?=
 =?us-ascii?Q?R2k97t1BnXwFygweJJWicBxNrFTBuF4T4+zqc2YqTZ6L9N1IzHzxSVEfJhVb?=
 =?us-ascii?Q?IRbDgDduU1934Sa7dfwFaaxiSlCcpnbP2RV/IUSphWRUQ8SfZKb2/oCp2PTV?=
 =?us-ascii?Q?fKTT5rlpGioJakzgpQdSdbzUC3xWphZOrvdOSGJ6GidJl1Pe2ChPjzKAVzd/?=
 =?us-ascii?Q?gvnI6DMa+puyK4b/6hj7xvyjMVIZPF9xCqhbcn6aM/9nJ0aUHJehjBvhQAYs?=
 =?us-ascii?Q?QjOCg0MlNZ4qA0zWLoOsDM65oXCeJB48jDsj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 17:33:20.2388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3bf00f-a8b4-4a94-0640-08ddb40e60de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

On Wed, Jun 25, 2025 at 09:37:18AM -0700, Nicolin Chen wrote:
> On Wed, Jun 25, 2025 at 03:38:19AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, June 14, 2025 3:15 PM
> > > 
> > > +int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long
> > > iova,
> > > +				unsigned long length)
> > >  {
> > >  	struct iommufd_ioas *ioas =
> > >  		container_of(iopt, struct iommufd_ioas, iopt);
> > >  	struct iommufd_access *access;
> > >  	unsigned long index;
> > > +	int ret = 0;
> > > 
> > >  	xa_lock(&ioas->iopt.access_list);
> > >  	xa_for_each(&ioas->iopt.access_list, index, access) {
> > > +		if (!access->ops || !access->ops->unmap) {
> > > +			ret = -EBUSY;
> > > +			goto unlock;
> > > +		}
> > 
> > then accesses before this one have been notified to unpin the area
> > while accesses afterwards are left unnotified.
> > 
> > in the end the unmap fails but with some side-effect incurred.
> > 
> > I'm not sure whether this intermediate state may lead to any undesired
> > effect later. Just raise it in case you or Jason already thought about it.
> 
> That's a good point. When an access blocks the unmap, there is no
> unmap happening so no point in notifying devices for ops->unmap.
> 
> And, when the function is re-entered, there could be a duplicated
> ops->unmap call for those devices that are already notified once?
> 
> So, if we play safe, there can be a standalone xa_for_each to dig
> for !access->ops->unmap. And it could be a bit cleaner to add an
> iommufd_access_has_internal_use() to be called under those rwsems.

Correct: it has to be under the xa_lock. So, this pre-check needs
to be done in this function.

Thanks
Nicolin

