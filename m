Return-Path: <linux-kselftest+bounces-18510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E3988B62
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE2EB20F33
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14E1C2449;
	Fri, 27 Sep 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2lm1paT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9181E4AE;
	Fri, 27 Sep 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469865; cv=fail; b=CSNyj/XSaX+qH2pbMG3tsadYB7VZIT7BOPOF+JX5RTjbDGh1B+DoJp9vMUqxqBoyHDgfZeLriqHaFN1TB2s7pZBk9Ppri3ZItop2WsPNiT7+9AvkOYk6uKqS99CHZodNuIsDOqUILioUv9MfeOjOmztq9UkoTi6OX4IKH1wWa+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469865; c=relaxed/simple;
	bh=MxNakRgcwLQkPCPX5mmeGfOXJSjP/L/qI5xLxHsaO9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/MYLgJX1yhTJciog6M8v7x4zFeIbaHVQ4wlt+OKOkgy9rh3pRBfWcuk1RQF9WTFivePH2iTRkqZjoN/fX5k6ZKGRbjnIwBi5M5GeOErBqtbLVZdqsn7lYg0wSUAKdjyzmDC47qmZU3OKXO6HSWj1kbcB5LSafeIZcPrVr9DT8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f2lm1paT; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kblS7hrdxouyN0tL20XcxqXhlUy0IYH779w/pPT/lR06f/PAQUqpg3mZEnsoBAG6B5FWZa84pNoKwIjpLxBlenb0/q/w9qSKm17sCJFYjB1pt+xDjI81iBoXUm1WL4ihFGG59Sx/sjtapFvhRqDeIoGVDqcn/nusDLgJrFrKFBw+bxwbnDVAN1Pr49YFBTF2jNG0bhkf5F3n51cJ9QN/20/3ghqLP6NirsPCv8+39MXTw5zwyMvqvAG7paDLOOlvTrLWCyf6OoeTPCitzxmFwuTeScGkT5eXi/zAT81qLwk1wcRWQ9Xj88Pc575P3ITPO1n5UsUhSAnj6Zk4vUOnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWhOd+csSt57Wle1XgkQ8Vr2H7MNBgXyHyv1XbbzMC8=;
 b=pdaL+JeFbo9gpUJjF0FtIEdT8eioFt+R57qj6BP22xBm2UG8M3u9WHzIS/4qqgtAMjjUQZNMZgM3duanpUBVfm+3mGVelCz1PHKTLyxcYjN4YAyAo3FPjjj2u5sXRjSOOcwlCnFcF1MbT67MwsCKzfogN/1py/VobjereWIyMw6DSRnKKUOnT+pOCeI2D6CT1Ph6tAvzLgTe1UH9ZDUw5mtW75cJYBRGEJIawoqPtkk+Hp4djmtm1xS5SfGQNBE/tLWe1o7FuRD1LztcMYiWSaekPQEMKu2rHOGX6z1XtVOr6MRwfBZoeMFRu0YtcJOrVVR2lyvRahy6eo+faIqKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWhOd+csSt57Wle1XgkQ8Vr2H7MNBgXyHyv1XbbzMC8=;
 b=f2lm1paTflzLRzkFGcJT2fXD5vsBmtWnC85+5yICXI8622Vr8vUPB8Rd05B3POdnNev2i3LZ+jqJ/CFtvYF8bWsr43esGc53N6jLzmWhxoAnWu9ZXrdAyels+6w2jG6oD4uF1/RvcSN7cgUjy+xjnqRC+DhcxhLs4k/O84Mf1sYhiVkpXbXg8PF0AappQ2fW22PqwWQc9VMfmrr0fM4TnmaMy2cCbVjk5i2qL8orP97DeDphf2WRwRLGB06j3yY1OiSCluE41M+VRRlnyV6kHNpJpkJt1ooV+3WQS6gVaj1u74vSx5dpaA1Rm8WBdba7w3qe28DXXU0aJ3+g11E05Q==
Received: from SN7PR04CA0153.namprd04.prod.outlook.com (2603:10b6:806:125::8)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 20:44:20 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::9) by SN7PR04CA0153.outlook.office365.com
 (2603:10b6:806:125::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 20:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 20:44:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Sep
 2024 13:44:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 27 Sep
 2024 13:44:07 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Sep 2024 13:44:06 -0700
Date: Fri, 27 Sep 2024 13:44:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 578282f2-b0b3-4a59-48ff-08dcdf35295f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEreRviyPRQsrM7sP+xgpNclKylODlS6v9dB0pxXugGcDq3sZ0fPXOHa4Oax?=
 =?us-ascii?Q?9/ZS5Jyg4ksyL1M2yTxYU9/LUzqzyg0rQZwYfhoSAxgufgqdfARHyeRjpi9t?=
 =?us-ascii?Q?RIv6+vRPgVY31QyPWj+RbbYwYvBEdPD7/Va2/Rr8aXZw+kayzMZBkNQOVcTq?=
 =?us-ascii?Q?U1fwlHcf/vgbsvlPS7JWi7VXoNQ4l/XKIUWlDmtl4mnXcR+NDPptOK8JWqYD?=
 =?us-ascii?Q?gX6BbIJ26iM24WrT4qbOkpcLjfO2Us/3TSvkfAB+zDCPj5LF4HajuFgvwHY1?=
 =?us-ascii?Q?2r2iHIW0/XbCioGhAtbzP3BKrCOJHH5LztZ+saGypt8dg+aJgPBziJwQokSr?=
 =?us-ascii?Q?o6At/SQOR7pKJherdmRZ3q5fQQKCFPvALVcWo4Gs/PyX0TkJ+RlNkEENEAPW?=
 =?us-ascii?Q?UNqUpU/6sTtrSWy33mtcK8UeRieDWz4plgPjZKDDUVkWGiL3KyNvwZOyAcTo?=
 =?us-ascii?Q?dVK6Hdp/KjLS+odQFTVr+TCyY/qoh+oyeyP/o/yuYHdKY/GOYIVEUE4gXd5S?=
 =?us-ascii?Q?kZexgu7jbpWKMpPyeMyfTnh75jrxXPauk7/gS/c1njG4AfMc//5ZVPibjX1K?=
 =?us-ascii?Q?uZp2wMRrCbUe+l42a3pvUIX3jdKdH5HA9bMrUAnL3xT45sl7yKArURVoky4y?=
 =?us-ascii?Q?PWZP9yTXIrLcTujYIEgScVD+D4aH51gJ4xgrGZ86oHWiT9ewC7lB0n5+14As?=
 =?us-ascii?Q?sG5IYIa8jvlEE5XHH0DUeOLPY68ykRmj2OVekb5Rfq1EzJAB833flK5Ser+2?=
 =?us-ascii?Q?cDQiLv7o53KJnmhQ/SzLUsW33ZjQc79mpJl8yElnVcuwOV6wJ1+E3bApRXyV?=
 =?us-ascii?Q?+TpOVhXm5g3ZcXUUIpWGsI1zGnuNrCvwp9wqJychCssKdrFr/XcUhDoqL3en?=
 =?us-ascii?Q?bHRJSMSVtcvdX7WT2oevJXNolIbdHKOGKZSr+yHE9XCSvbRotJOrbJAAgUNK?=
 =?us-ascii?Q?opDAnapnRFVT1NhAwQ47ZM1YIUsspiPeitP9mENO1oNvn+N0/q2sZdQgMWi6?=
 =?us-ascii?Q?lsGPT8paY+wV0MbDUAQt13Qy8WqvtyfSfpsTmqdE2MSX+zrdQkQo6RiUWZBo?=
 =?us-ascii?Q?2DYGnZT27cL+n8m6S5RFB5JHeIxXejdQ1EsprxfoMxnXHaXt8vFsJ7S9lZO/?=
 =?us-ascii?Q?Tn57C7uSxmq/k3AkgpbLMmmA28o44ZyokzRTD3pzZ3pR/snYPCg8mHAze1Qx?=
 =?us-ascii?Q?4iE/n9rjjzQsJyutnGN83cK6n+FunRvdfcocIEXaMPVL3laKvFuw0luZnGeD?=
 =?us-ascii?Q?GCu+54pVewBKXoq8JhZIh+/Gih6zMAF79zvy0aWn8VbBdc4fZ8s8K++kXobh?=
 =?us-ascii?Q?L+JsOd9k98S+D5kbFYRwIK29OisOKu3tc6uCrAXshZppkt1wRsMDRyl9IpW7?=
 =?us-ascii?Q?KEoATXsVx+XVxQ8by3B2yOtSntNTHAAW8mIE2Pv/QuSPYPxtjDhHJv76eZpE?=
 =?us-ascii?Q?KO8IzMTzXqcyz/qU15y1kBoQ1pGeBrbc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:44:19.8732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578282f2-b0b3-4a59-48ff-08dcdf35295f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

On Fri, Sep 27, 2024 at 08:12:20PM +0800, Yi Liu wrote:
> On 2024/9/27 14:32, Nicolin Chen wrote:
> > On Fri, Sep 27, 2024 at 01:54:45PM +0800, Yi Liu wrote:
> > > > > > Baolu told me that Intel may have the same: different domain IDs
> > > > > > on different IOMMUs; multiple IOMMU instances on one chip:
> > > > > > https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
> > > > > > So, I think we are having the same situation here.
> > > > > 
> > > > > yes, it's called iommu unit or dmar. A typical Intel server can have
> > > > > multiple iommu units. But like Baolu mentioned in that thread, the intel
> > > > > iommu driver maintains separate domain ID spaces for iommu units, which
> > > > > means a given iommu domain has different DIDs when associated with
> > > > > different iommu units. So intel side is not suffering from this so far.
> > > > 
> > > > An ARM SMMU has its own VMID pool as well. The suffering comes
> > > > from associating VMIDs to one shared parent S2 domain.
> > > 
> > > Is this because of the VMID is tied with a S2 domain?
> > 
> > On ARM, yes. VMID is a part of S2 domain stuff.
> > 
> > > > Does a DID per S1 nested domain or parent S2? If it is per S2,
> > > > I think the same suffering applies when we share the S2 across
> > > > IOMMU instances?
> > > 
> > > per S1 I think. The iotlb efficiency is low as S2 caches would be
> > > tagged with different DIDs even the page table is the same. :)
> > 
> > On ARM, the stage-1 is tagged with an ASID (Address Space ID)
> > while the stage-2 is tagged with a VMID. Then an invalidation
> > for a nested S1 domain must require the VMID from the S2. The
> > ASID may be also required if the invalidation is specific to
> > that address space (otherwise, broadcast per VMID.)

> Looks like the nested s1 caches are tagged with both ASID and VMID.

Yea, my understanding is similar. If both stages are enabled for
a nested translation, VMID is tagged for S1 cache too.

> > I feel these two might act somehow similarly to the two DIDs
> > during nested translations?
> 
> not quite the same. Is it possible that the ASID is the same for stage-1?
> Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
> devices use the same ridpasid. Like the scenario I replied to Baolu[1],
> do er choose to use different DIDs to differentiate the caches for the
> two devices.

On ARM, each S1 domain (either a normal stage-1 PASID=0 domain or
an SVA PASID>0 domain) has a unique ASID. So it unlikely has the
situation of two identical ASIDs if they are on the same vIOMMU,
because the ASID pool is per IOMMU instance (whether p or v).

With two vIOMMU instances, there might be the same ASIDs but they
will be tagged with different VMIDs.

> [1]
> https://lore.kernel.org/linux-iommu/4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com/

Is "gIOVA" a type of invalidation that only uses "address" out of
"PASID, DID and address"? I.e. PASID and DID are not provided via
the invalidation request, so it's going to broadcast all viommus?

Thanks
Nicolin

