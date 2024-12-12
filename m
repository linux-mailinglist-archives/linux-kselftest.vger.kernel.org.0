Return-Path: <linux-kselftest+bounces-23281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C749EFE4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0716757A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352A1AC891;
	Thu, 12 Dec 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izWb+jLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEF38DDB;
	Thu, 12 Dec 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039101; cv=fail; b=qrTd7VZcONW/sDOyWJ0Dx/lfZ+MKNgoTuWFsFAmWLeFWcBPPtpXGJp1G6uYYsfMMB4UpGjXpDakioam1KPgG8gxD4nlpRm9SdhUEnVVlqkCvJLiQtQpAfomhpulsI9Q+OCouhQI6ZIVzxUJfJSanNa1orOmrR0caCsbBOqowp5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039101; c=relaxed/simple;
	bh=V5MJZjtj/ITaEx3cQlQsJM5FXC4V/mZQTr8hqiBnDyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec3d0nZkw47wFKakj4TurwswWNrrY4dRXDpBCh3s/GnNvRHU7xuGCuLlK5AFLjZjK1iYeYz3kyWLgYUet/wz4YKBypFKJDz8C9ujlTIo2zihiXWUi21EW7TifiWlpO08X+xcVz6E90ae6FJwNHZtKDI8KX22VV+MS6DohIqCi2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izWb+jLI; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGBwozStpmmTocW31+0u793ICh0kWcjUh6CRIx5QcTitPZm6etxwafWDAN72hR52JBrJR4Hwl4VlvxkV5WHJvUZcAfVxOnqnzLfluf//VTv44/Ogyoy3Ez9FaWqQBDx3/MaOY2tbJvOJmleLJmnS4f1rP6Jw6C7kIMw1Bh31KGQWS/3QSjfw1lYi6DPgILsagSPkUtmyIpV3wEyOk/+txF7uZsS47Ux46iH7XVSEa/PZUXNo369/QdsUfa+735iOFYbwmpBSC7jNVPL/WQXYpih/Akw1kjNsE5EZfQ3y4l/Z15dp1FzY/Nk+vhudoqaVI/+WtAFKBvmk77lQLhccxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CThhBif+vhRz92wc+pKxEEiw0oCAM4vT63BYscwCdK8=;
 b=vNYxA1XeU+8o4AHWzymaWVi8+UxfwqKDhXl2d5ol7ZdCDYDtzAd8E+Z2UODzeINfT6i1tnC/O/O8AfM0bnvU0nURpPA9qxc4BKPEmGURm5ERvr5Inv5MrdSvjneeaR/A5i0zmFBCPyQxYEq2RQDCOcI+SNtwO6RBqa7zkIgK2Ps91Bc9I7jmS750XpGGWalOayJ/oTdHiGOOyS8yiwGRDCbEgZWI5qugiB1aTssXDTce0JOjfbDzDv9dLAUY19x29E53RiEWf1G9xddMMUjTOsIBa703g0UqgUqAdoRCO6W60TJYhReWxHvri+6IRfDWXiivvRlACBxh+d5LcVsAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CThhBif+vhRz92wc+pKxEEiw0oCAM4vT63BYscwCdK8=;
 b=izWb+jLIib1ccBNeZ4u6DAjnmyx4tsjGMxKuVniZK2ScHw0Au8+uXMXt/ftbWkvxPtv9rV0kMa/j8dsMdcb3h3uU6375L5EmHZmtDTyueH6wjQWZvJ36eJssxLPw+kkb1RLYwrSaWwtJ2+xQHgUMpqMyDoyDpAS4R04dYUO9kCBaiUKSfRLnLKYgdgsjhFBUCd26B9Ui9XzxZS+2F8zwnp5vYwO6fodA8O68VIj7MKIiTqTxQX1+u2Cg1H4n6cGdZpE5ealqmdvUhA7G33pTp7gozIYPW+nSiw4ZT6UNJ53YZluWoP8mO8OTf1rbjuPjjdji4Ru2eiXzZwjGvZ/LSw==
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:31:36 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::b5) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend Transport; Thu,
 12 Dec 2024 21:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:31:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:31:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:31:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:31:15 -0800
Date: Thu, 12 Dec 2024 13:31:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 12/13] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z1tWIuiEFJyfSGEq@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <6270c905fc8537ffc51f6f2ab2db0601c9f08a8d.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB527669503B30B7C67907DE398C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527669503B30B7C67907DE398C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 144af03c-41d0-47c7-2147-08dd1af45b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUndh2F9YMH6bIFQv1UA4jJf5gPMPsdbqKoh9/fzgA9XjhNaGVaAlVNZx3cG?=
 =?us-ascii?Q?BbEnNqvShjtiRcWdzfcwruLbOd+h/Q6VOS0xLkLuO36FgZKg4yYdl+c4uw8d?=
 =?us-ascii?Q?iTPSzU/YonpgIwN2kYyH6IVZYL0qbO3j0t0LAA/KjUXF2WQ4GqWhai9gATOE?=
 =?us-ascii?Q?96PhIvLy1gK/SoZnSkFR1zYM27bq7OGA/NL15lx6Eyl0xV2MkzJsjzILxDtl?=
 =?us-ascii?Q?TpefCi7QybGHfv7FlYI9gk6QnjXZrb2NfAj7VNA1d+rT+vs90Eb6sxbe3VwN?=
 =?us-ascii?Q?4Il9IAGlF4Zffye9KVstZ39QVQd/Wj2xcP+rsc/uL6N8Js2bX49ZYlIuIR/R?=
 =?us-ascii?Q?kzMGNwzKDx2cf/Al9BBg+VQEPNIU3X+Z7lV0beFDuCVuko9r5jNcb2EXN8x9?=
 =?us-ascii?Q?UZB4EbAfO+I3Tq3rRchs/ug6MZQWBpryTvYnjJq6JWQgfu8Z4ntz1uXlW0xP?=
 =?us-ascii?Q?ZY4rHDcitQPyfSCrF5IArknsDe84FsomSApUEYHrNlDF6GavX7sB2G4LJ2n3?=
 =?us-ascii?Q?moVrxS0Ubl48QLRkf2G2QSNq29X85Dt1oiWyXKOEBlhQ83Bzh2mo969I4gY2?=
 =?us-ascii?Q?HF/s9dbssv/gXANPkJ0mEkcPkUUyBge5fnjwykO0QeIaWMyaKj+4Lel7L+OG?=
 =?us-ascii?Q?Qf45+sOy6pJ2dECBmSYl/5Y4oJ/6d5W1uoBkTtoriWf1Xgih1cVopWdIgd2g?=
 =?us-ascii?Q?UCk09J31gAfhY95dH7uBrx1IyoipuaIia9HPw+R33wKX5omioP6cnE0IVgLP?=
 =?us-ascii?Q?O0Gms6fQtG5lFSBu4ufZuZ6nEH1JRfvjQgLk/wu72i1yRelXuO2w8Xb04D90?=
 =?us-ascii?Q?iB/87JsKMtEGGWeCceNZ4ZepsmyY+O0aiFTMbHgUdAuRnfVQ9WN6OvGK4lHb?=
 =?us-ascii?Q?Zehs10tv635eNAc1fjJx6CiX2WCSmZYWBEVPMfpD4PrbXD7HUSDLST05+vNM?=
 =?us-ascii?Q?k901RfpABtTqN1eXAyPPEN8ma9CSOmBgqSTceyd4zuk3LO+JaKB73yylW7FK?=
 =?us-ascii?Q?ptQ/m+Sg/CnkcQ64eqYfFzeMc+zcN8mv7DBQP28vHhyPEKE4n6anZeI4rHzX?=
 =?us-ascii?Q?HZBIr92KoObOyVxij/lHJZzYub2i+ptTDo6FyEu75dP/adwXW+i/z2l/eLhu?=
 =?us-ascii?Q?+pT63ccnga1eL0PROeYvU0DR/XXc3xNTIXQTYp5p0di092Dl3hlBreb0JYSI?=
 =?us-ascii?Q?Lv/seC5c6pRQJPIczyKPFlDdU0+4eQKmXcx8M7t/z9FGjmexT5Ba0Lnlaxmx?=
 =?us-ascii?Q?DTo7sOw/NNd2zJTaBT2Q30YJsA5SUDhz40W1+CqdQJwL9V9U9SGZIwf282dU?=
 =?us-ascii?Q?r/Qp4nXr/pOyN3MKi7AOtmJvirc8Cj+31DzgDTAbaKPE03QA9udNSttsebJf?=
 =?us-ascii?Q?QZ9YxiPQ8aduNAySp/Jq1z0Me91vn6JEQqoUSJsfYQR0USV9vMNScjzlyCmG?=
 =?us-ascii?Q?kQjwF3+d6vz9RhFYVqIZFGkMbW5hCeOD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:31:35.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144af03c-41d0-47c7-2147-08dd1af45b38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

On Wed, Dec 11, 2024 at 08:15:35AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> > be the first use case. Then, add a rw_semaphore to protect it.
> > 
> > Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers and
> > put
> > them in the existing arm_smmu_attach_prepare/commit(). Note that identity
> > and blocked ops don't call arm_smmu_attach_prepare/commit(), thus
> > simply
> > call the new helpers at the top.
> 
> Probably a dumb question. viommu is tied to a nested parent domain
> which cannot be identity or blocked. Why do we need to change them
> too?

For identity/blocked domains, prepare() would return 0 without
allocating a vmaster pointer, so later on commit() would update
master->vmaster with a NULL, i.e. it's a cleanup routine when
switching from a paging/dma domain to an identity/blocked one.

I will update the commit message to make this clear.

Thanks
Nic

