Return-Path: <linux-kselftest+bounces-30272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317BA7E942
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EF1188F09D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE35217673;
	Mon,  7 Apr 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9JlJlYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230882135C7;
	Mon,  7 Apr 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048860; cv=fail; b=Kx1FoeBUxHaHgAcRnWSkLICnqYtH5WXzw1/tvNtFV60IUL27pbcwOl3R6fFhCDPFBgebjadIh0qXizGUvDqjI+9QSDnwresPTZePOSfHttd8Noe7HKedStR/cqLBneGfAPAhNug/IjT48NGAGxOzUgLQ9XnwQK8BpnLsR0skw30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048860; c=relaxed/simple;
	bh=+l/KDTSBmrFFdrRwDDiHtYA+p8P4DyZeHEh6IHruJlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwexKWDaduhsXyH4IWiKYPp+TFhD9WfJvzMhzcyDuT7mE7bh/y3Y/qK1Gtw4evmrvudXW4Q/nwImpokrAkJzTOGuiu35lgnLGx7oozJzPRBYEoJffnK4CRH43buBOhRkpdyMofk6vzovUjjOMSc02A6bM6R5mTz3q9+YgkqRNSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9JlJlYM; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF0rhKV6ZcWvp1JLyazK6sFr1+s3H72zNJbekXEPVUFDdBrxmTtmTYm1FCp80ZBEqBwzz6I0Gj+k9kEmzrx683eW7+1CFqUFuvCQTqCVC/V8QFZy3sfaPHssJ6gh66VVwrrPH1RRm0jQ5YldzMGcNDvRSJs0A7A78oVQCQcQziDeFFDNCzm4FvxmRdYYnM29ESpq+JPFd3AQlxjyTc1+guuCvHx4PYSvskeeqQmS8erH73BxFPFZOPmy6PV2Bq00V5saOWeFBH/FzCy+coKMqEPKmBGf8c8DbjjId8pjX/+ZBidw/+tG1DFnMHISzM8HYJbP8hHBkVCWn8ECRTehYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l32xApiI+gg24AXpOHwudkim+RE+PX7NDLCeLuFfkYc=;
 b=J19RJcc1IG9TRWiXzoMSifpMGHvu1gxB7Admla5dzj0pONrD1Mh2QZwcqQoIsp8zfn3sXkjlKGmsVWLj0CU+IC9kxcS/SkwqvtYKfRm6KMLKKqbjh69bE/5z022DCKZvvtJsyYt/aO/5t4/wA0wDUeBIw8pZAD7gsIDlOYPb5UDAApM2HTtDgAoHqwfdwDP3LOtny42W1mtyQu9TGWmNwngxGDzNJlcOKeDP97dS8RoLRsT/Ft1PW0gpk/rKvN/E3UtfoIac3Et7UkgE4n+4eB2bq6Fnm9X2DjB5kj0M1JiF3fkRNaKMgF75f9S75vvPZZW4rlmlWg4i+VbHsc2/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l32xApiI+gg24AXpOHwudkim+RE+PX7NDLCeLuFfkYc=;
 b=Y9JlJlYMLzSsNbQdCRCYDhkUTZ1iFwNT4yliGR1eCz+WuQY+Z/oNQVzTQQPOWdMIS3+xPiKiYBhbrNA6bEvRMtRlKwYokxjzrdg0PPHwd2sQlQrQ+VZSfk+Ajp2n73Kmngw+Q6iVHQH58JtbmDcPgQhF6fy/5hv0OEnqkO+TQoK8nd7SkqKuhpv68MM6GXgd+GjJ01E6K0InXysS7Cn0lTtkx8KJkcLzywzpIwS9JWgrxHC8RQy2Un5ivcBZ1V0toC3CiSM1NVoqY+6aULlL46ZDk9luto4uDUqnM7ZmlvLPEPESPhLJ7ZWwWgrNSaQr/8qZtQhI9Iz3xmbd2kWRbw==
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 18:00:56 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::4e) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 18:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Mon, 7 Apr 2025 18:00:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 11:00:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Apr
 2025 11:00:31 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 11:00:27 -0700
Date: Mon, 7 Apr 2025 11:00:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z/QSuMzJVGOcTx60@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: e4693767-7e8b-4f05-7f89-08dd75fe24f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZMMJBDqR09E0oemVbJbqZblT6tQLcEW0A/718JWvA1pBM6nNujzYZbWkfHj?=
 =?us-ascii?Q?VNqm9DBpx1ZU/WzNtC3u8ARY6cMtoJ+TYsOqQsmw8TEkLiOagb70F6W0fOU7?=
 =?us-ascii?Q?TF5yueUh7nh72O9oeGHkEYLGZVQwbwsozHzYI3FE9IbydsPoBRGxklmeFkG4?=
 =?us-ascii?Q?cTrSol1MvvTachUBjKNI2yHFjmEhwuz9zDZARl2Az9IXDs0IJV5qy0M/2Y7U?=
 =?us-ascii?Q?hRPxBKDE59PDnIY/HCM8uID1v8/Nh157kwWscbVpgR+1kvz2QRzmhMzEYjp2?=
 =?us-ascii?Q?G5jxgKloq7jmusCkSljde/MTBIi8rpPeTwmmHaP36fkaoozcj+8tE8zY1Xn5?=
 =?us-ascii?Q?TWlTT9XSdOeNfkVWtcUEIhLudEmFgFnOoqdpMmnWZ/psKXIeqGsi0nkegm4K?=
 =?us-ascii?Q?39rHW9QFUVKfbVq0d9loW4TZyxaF9XBuzGhyLPCZzKO2M2TGp3cGaypVFJNV?=
 =?us-ascii?Q?tkpmyuojlnsx6P+J9Oz8ja2LfRChrlp2yrxhGF/QRfqPjSxtjo3u9LkTCI8z?=
 =?us-ascii?Q?WuCBswTv7ed7f2J2Hwmh3vp5k/lAq3mjG/bEPtjP+irFBBMWIg/QCQGYgKsw?=
 =?us-ascii?Q?GBTEwIMNTWKljSSbz/hspVL5Gw3SDXUHO27s43dhzJwqzl+D6VEziMBb9rV4?=
 =?us-ascii?Q?8PZoLN4SMDHcv6T1OjjSAo3e8O3etF2vS5Uxz/FArRBVmTzQj9kSd1cobgO2?=
 =?us-ascii?Q?7XmTcAoy2V/JF2PzW4ebzhk6aySomGAjR5tlKQM6iWq7KAJyYbfynCHANM/A?=
 =?us-ascii?Q?gkPr+EWkFH37Gi0WOu8cUN1YGe7mcESPn4ZNTYte7gj69nRDaTI54WtBYBAy?=
 =?us-ascii?Q?z2ymskTjZ2ge8Sb1SUIPOlfjIdiVYWq3y239lujb6IzLRnQeeA5b8borITLb?=
 =?us-ascii?Q?jG5OQun1/ZhZIB6pmCuN574XsS2eks1aBf2piESxsxQh9bu8oxaIa6JGw+HI?=
 =?us-ascii?Q?QievnsmAPYKdyP36Idzi0MW1buF2nLDG6ORfBXpUqTmHRZGpsUyDEr2AiqN4?=
 =?us-ascii?Q?buSlNPkEgCRl2DnKEWNAzJH8/QyZ80DgD2v2T7wBLHF2AljDGvoZaOAHsIxt?=
 =?us-ascii?Q?bR7lEvsPCQKoKgf4/co/rOtd2IzC7dpzFIa2/3vqZFJLcBgwV6rTnbbDs+fp?=
 =?us-ascii?Q?69Hke4O6iGcxGeO7jpwTxKa2wS9K1KCx/rxHqe6bwZiwO0PIkg4W6Xd5czTI?=
 =?us-ascii?Q?VYNm/Qm2eQoRhlKHNXePchnRD/IS1OACzJy/dhXdLS8wbbqDi3lnMo5rEbHT?=
 =?us-ascii?Q?L0ROkXikeyGu4J43OH93Cd8Q6lp1u7ZnKgPoZ+zB4sOnWESnDp/zluPaewkR?=
 =?us-ascii?Q?1/C7CSkzxeXtZEk4xzXCyTWGpDA15w1d2/UzuIRQHc0Jw6DQzToMl0yXkh6B?=
 =?us-ascii?Q?49HovViT+UJ/mDjoAHqs0IT76LDtxCb3zXNscMkodHmKYWs2FKlsHdjDQMKZ?=
 =?us-ascii?Q?PVfhyaGYXh1PQRTpBrVh4rq1ZEBZCfWzWp9jnjMO2LxonbpnBII8A4CuoNXP?=
 =?us-ascii?Q?xFhawRSpWRLnWBo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:00:55.7267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4693767-7e8b-4f05-7f89-08dd75fe24f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On Mon, Apr 07, 2025 at 08:08:57PM +0800, Zhangfei Gao wrote:
> Hi, Nico
> 
> On Wed, 26 Feb 2025 at 01:35, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> > be the first use case. Since the vsid reader will be the eventq handler
> > that already holds a streams_mutex, reuse that to fenche the vmaster too.
> >
> > Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> > or unset the master->vmaster point. Put these helpers inside the existing
> > arm_smmu_attach_prepare/commit().
> >
> > For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> > add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> 
> >
> > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > +                                   struct arm_smmu_nested_domain *nested_domain)
> > +{
> > +       struct arm_smmu_vmaster *vmaster;
> > +       unsigned long vsid;
> > +       int ret;
> > +
> > +       iommu_group_mutex_assert(state->master->dev);
> > +
> > +       /* Skip invalid vSTE */
> > +       if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > +               return 0;
> 
> Why this is removed in v9 and 6.15-rc1?
> 
> I tested 6.15-rc1 the qemu failed to boot with qemu branch:
> for_iommufd_veventq-v8
> "failed to attach the bypass pagetable"

Here is the problem: v9 isn't compatible with v8 :)

Would you please try for-v9 version?
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v9

I also asked Shameer to integrate this change to his QEMU series:
https://lore.kernel.org/qemu-devel/8fbdb07be20a43bf8281143720a0c10e@huawei.com/

Thanks
Nicolin

