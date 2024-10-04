Return-Path: <linux-kselftest+bounces-19068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBF990FBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA11C22A70
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585901DD549;
	Fri,  4 Oct 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umUAe2si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35F1DD53D;
	Fri,  4 Oct 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069952; cv=fail; b=cnCKBd7y845hDzOamgsi1kgNo0ZfoThZBl7ys59wugeunNnAAegtnyql5atyTrSiPO2Pu+qEvVtkUsELbt2lW3yVZhhxzFFHEj2dn1Tp/fyXhP6kumiFnOEsIOeC9/t3830b5sHSiil8rhMsw1CyZtXoCdNEKOK1vyhQkKQcaNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069952; c=relaxed/simple;
	bh=5BYXFGTD61PtAfKB18NrTUDri9E+Uk23xRv6mqS+h7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC//ziooBvUU0TC1/uGeQ8UbUw/FrMkBi2e+9FA074YMSfuDdgLgHCdK7C6Dy38P8QamqVAqFWj2B1X9VMOfTpAEOlqcIVIpKgN3lf6DEKAqgPPCHkeXhLcjkQTWSPihseaR3m8Nt4Zh+7dKxEFJ/J9dXX8bePQX7JEE2jXsKxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umUAe2si; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqn6qW/NMuVWv35f0UCgnAFbv23nmncor6sYcIuUo1+R+ZAdYG0T7osRz1x8+6O1jlvjwxuDnX4neUA5F3jf9X+0eCc9ue1iBqOBw/KC723QI+FLCJl8FxVh6fM4Bs+Ry8En4fFu08OCsfftsftqOBaSooccZisYByHPrwdrR18SeMQeWPcJOvG780B7O63+IyERe5axqW52T+TpGFvv/mKZy9d6I2mmYt0N+5IzJA9yGcVGBuEPfNIFvFcCYgTNM8vbbiHLQ8aHkT8FX7jobSFipwsmzrA42+6Ms+osuc/Co1u1s1Q6YMHhAIIdxGfVcgXknTGYKZz3Gcl0KSSTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5koOAAOBfs/zoRxcjQryx9W8OWGFPhL4cMUSamYGXVI=;
 b=woct/5zgAHhtRkY+F1Oe6DqAq8OD3HTclhgmVO3nZbH5ATz6emZc/502rOSE1RaPFyiz8Zh3dtxGe4XV2sr9JWrB5aS5lwR5xCkNI+KrjFKaRwe/FVMBxJD8hKcRcWtaUlD5w82To0Y5n2iixoyMgf1ipUwbKl1TDJK+4O+KF21ikifceBy521C/F28Z0DY+trGEB4k4cHtoTV9BtzxqJFsx4chyXir8QO5U3xmAnerKcAGbURbtXADdfe+vx+xwrJI3b/ugjZsnV25fe0z6sCcuKJv1iuTKslvK8s2NqWQZWhRjfyvHlwtRfrBdc5BBGCnb31fZ6QFG4h+adoBnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5koOAAOBfs/zoRxcjQryx9W8OWGFPhL4cMUSamYGXVI=;
 b=umUAe2sizYrG6J77UJHkI0k0CZAoS6DvoXrRaGntF4MCrEdPwuXVjUUV66142pr0nJclWNNQwipsCt9fRPUvdfxgK2E5o3oefTKRmE3byfFvisOEmagjJ0pXoPytPCxMl+9/Wo27FH8A6AgeZJyi/n3m+m1oFL8pclVQUMKm7DOLf05zXFTMq++I7PZE0Yzt76X/Gw1jpIp6EVmaQvktKTHkTi93pLAjtFCtTotLchdpJXjOenDa1U6WQtbuiWG91Q12extt8eb4IFPleQfrpKOMFcEaJyLBK1kr05/UJ+w/Jc36xieZlbdo+nXBQl6+Xl69V9UVUgETg7DrAhq8pA==
Received: from PH7P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::10)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 19:25:43 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::d2) by PH7P221CA0072.outlook.office365.com
 (2603:10b6:510:328::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 19:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 19:25:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 12:25:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Oct 2024
 12:25:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 4 Oct 2024 12:25:21 -0700
Date: Fri, 4 Oct 2024 12:25:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZwBBH+9hwuGKOstl@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
 <20241004185019.GJ1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004185019.GJ1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb0eaa-b133-47d3-a4fa-08dce4aa55b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gc7/cUAsmuM3DB3Roe2L1M+Oq+S62gnNz2sOiMs6PzgXgnjcJOL0hksi/5zg?=
 =?us-ascii?Q?3It9sZ5X++ILD9N889QAjgv3IkLUeXMdFfWRmxF2Awm668sv/+WxCwW8//VE?=
 =?us-ascii?Q?1Q4BfX28N7IAfWDy7rPK8DOdQ4cAp5bxvvTBlRe5j2vh0pmSt5oIpsgoSfd1?=
 =?us-ascii?Q?8CIPtg45UPdC2uw55/vxnjtd+65rtspEvQSHbUlFEkzkNHb2SVQguUUUezSI?=
 =?us-ascii?Q?8tN9dA/IxlmRqITEFmWQgQkNwjkrqC7GK92Iew0DhXrB7XaojZ2LbFHFX4AO?=
 =?us-ascii?Q?kEC/3YF30REKwkG5XUOBaAflQ25tm8roQD5WhaxXv1VxFk0T2tEGtd8bYP8j?=
 =?us-ascii?Q?lDIFBeeqSyjjke9c+1ZbfxtF953fQOybRC4eBpevk16qHOlpsNUTeZHeyk9h?=
 =?us-ascii?Q?53L9Xgrf+1F+Vja6TdVp0g3s77Gtj3SchT2DqWg2F9jVnRt602pIfKLGmMQ1?=
 =?us-ascii?Q?1hwKGsPp4PcvCYVWeysFniSDQHwqCn5UENcMMhMiVJUXN7MQ50JCc9lxAtFJ?=
 =?us-ascii?Q?dfcTVAvJUbY41qyqHF085XLTLmKTBRcZDsATAmTAJTW2rW/fC9R6n47iZtF7?=
 =?us-ascii?Q?RjFDmDEfpMC4uDqhOUEWzdgVLHZW02LjC5dE/IVQ5C26zSiQsqrdtLKL13NA?=
 =?us-ascii?Q?9ijiWNb8OXcjncK7uy+4bWLvlQVkZUeZJAo2+Y7SSXV5lEvA9GRjpaIH8vW/?=
 =?us-ascii?Q?s9TsqYmi7xBn5+T2/prspfEr98x9OPmjgcVe/mFVbcXmtlIIzMT2+RGZhgrv?=
 =?us-ascii?Q?RSjeF0Ep8HGMH8wwhE45z/9JHaGAIpZ/W8ttFsLe/2Fqh9vt3U0zJzw20+ec?=
 =?us-ascii?Q?iFHNXRj0gXoqPcfgruqMBgz2MnTFDfDWG75r/9z8oLdQ5L2Lb2ewTn1ydiVf?=
 =?us-ascii?Q?tlR/S5J0mfpIO/1nJR2rXzphgocfvCfSRvKIpC7mocTuzhtz0hqma3HifRrp?=
 =?us-ascii?Q?c2/Em2QG22Bj414zObjjLADUHcGbH+xDBS90J/LBKmBbLIIhB6LdNM5pCsj7?=
 =?us-ascii?Q?iRirRLyzfp2fXgSRUno4WFnVvAzSa4YOGvR77w2Pp4SsQiRl/nnLEh64wv47?=
 =?us-ascii?Q?tfIEoREYYaw+3nR5UU2b1ns9cn9eBnMWFOA99oRTDKigt/KC36ZtxTru3h8O?=
 =?us-ascii?Q?HwN/RAfglkeYMuL6unc/bajs9wsFALaZmhlYYUIrEckiOJ0kKcYRvKm/gBit?=
 =?us-ascii?Q?6fT66fURa03JX2/Kmt6fIoF437fzlnYrRmf1POIuQWsAbdVJ2SruUBFf27mJ?=
 =?us-ascii?Q?DabVtIe6CX6AfqeLNDrHdkyAG2P9itvAVm3WA1Q8rtaCWCfdLbjg95gkyacj?=
 =?us-ascii?Q?j1EaFhppyCpxLNtZajJs0SXAY8YSzfFop+IPi+n0u7AcNIUgXO4pLDzCRuZB?=
 =?us-ascii?Q?DdWCWDNLI+5lpES9//pDYR/zTwSu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:25:41.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb0eaa-b133-47d3-a4fa-08dce4aa55b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

On Fri, Oct 04, 2024 at 03:50:19PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 11:13:46AM -0700, Nicolin Chen wrote:
> > On Fri, Oct 04, 2024 at 08:41:47AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:
> > > > For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel interface
> > > > to pass the guest's BDFs for a specific host device (which is passed
> > > > through) and nothing in the kernel has any knowledge of it atm, is this the
> > > > right place, or another ioctl() is needed here?
> > > 
> > > We probably need to add the vRID as well to this struct for that
> > > reason.
> > 
> > "vRID"/"vBDF" doesn't sound very generic to me to put in this
> > structure, though PCI devices are and very likely will be the
> > only users of this Virtual Device for a while. Any good idea?
> 
> It isn't necessarily bad to have a pci field as long as we can
> somehow understand when it is used.

OK.

> > Also, I am wondering if the uAPI structure of Virtual Device
> > should have a driver-specific data structure. And the vdev_id
> > should be in the driver-specific struct. So, it could stay in
> > corresponding naming, "Stream ID", "Device ID" or "Context ID"
> > v.s. a generic "Virtual ID" in the top-level structure? Then,
> > other info like CCA can be put in the driver-level structure
> > of SMMU's.
> 
> I'd to avoid a iommu-driver specific structure here, but I fear we
> will have a "lowervisor" (sigh) specific structure for the widely
> varied CC/pkvm/etc world.

The design of the structure also impacts how we implement the
API between iommufd and the drivers. Right now, forwarding the
ID via a function parameter is fine, but we would need a user
structure once we have more stuff to forward.

With that, I wonder what is better for the initial version of
this structure, a generic virtual ID or a driver-named ID like
"Stream ID"? The latter might be more understandable/flexible, 
so we won't need to justify a generic virtual ID along the way
if something changes in the nature?

> > Agreed. That also implies that a vRID is quite independent to
> > the IOMMU right? So, I think that the reason of adding a vRID
> > to the virtual deivce uAPI/structure should be IOMMU requiring
> > it?
> 
> I would like to use this API to link in the CC/pkvm/etc world, and use
> it to create not just the vIOMMU components but link up to the
> "lowervisor" components as well, since it is all the same stuff
> basically.

That sounds wider than what I defined it for in my patch:
 * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
 * ...
 * Allocate a virtual device instance (for a physical device) against a vIOMMU.
 * This instance holds the device's information in a VM, related to its vIOMMU.

Would you please help rephrase it? It'd be also helpful for me
to update the doc.

Though I feel slightly odd if we define it wider than "vIOMMU"
since this is an iommufd header...

Thanks
Nicolin

