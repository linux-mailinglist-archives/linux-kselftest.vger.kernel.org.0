Return-Path: <linux-kselftest+bounces-24968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C5A19962
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134143AA8B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EFD215F7A;
	Wed, 22 Jan 2025 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaaBKyzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992F215762;
	Wed, 22 Jan 2025 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575717; cv=fail; b=bZbAxZOqEw7DeVLNjcAOyLkiqzo+1vLWY+jmkp28jmIpPC0BjJUBewyUStZxZSWMCFGPsq4ch2a/GT5XuRl8BUujzGMMTB8sZjUzJoi40lDVKxmzzldlpkDHN2Dvs+UcpnYDDOmvVm0U9yxOIUb9CQfoqUn+pYliPGKsAFscSmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575717; c=relaxed/simple;
	bh=kQfrsbB/V34iH1MlcT+V8khTPUdRJfQOg7mNoie3LWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0wrKenSFETTJlm23TAfY2UsC7CmI7UKYMes2o8C52rWFSlt0zNu9oy9oy2dNx193dQPQ6cENBUSJcvQkTTQWHMzhXB50VQVVPM0Hd/h7oHJpphQ/tOLfxQoBdPINHcd244jyWF+1AgOLx+Uwx0Siy8mijvSYGm/zFHxWJc54n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaaBKyzb; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSaG/Cp2icq/OC0ALFUotBqSYqC8uCX+BdhtGTWdop3PHIlql380dnKMiSxKbFofNaLdjZEPgBGsyl3gMsD0mLADKsPRrrwVpwhVDgO5t4sWnE6D6by6JmpYEB1SVBVl72hJBZO+lr6VmnArpPI8ELGjiyE5BEh23/wsgEeG3at+Wtr/rOy6Y6VRPgxfFaUE0kM2bWNnQMiRwPGLLFTfb7cyXTC8rLo9g9r0kF1A652ZGHxQu9VI9zLvFW+Ysz6D+u8tseTLT0t2q0gJv7hT4FtQJzMbAEfMZqqQ3weK2MwnPqqGlCPatojNTbI39Z7R3FL41rLGqxbiJETMRrVQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/CkI6YtI/68hhXtKZ1CzT14Pnfq6BMEmullmCigk74=;
 b=RvsgUNf6Ab6cUiH4+WsVfUk+fFqBID1bxaJICpRT95YRWQ4N89XIXUC8JKwoZj4faoJE2RjhYOzWqQLTi1B+cFo+jcTcHSQSwlykMlF4P4qyYHVuqviCeD9tFUdFs8t8pa3nxF2w/FqlibKxD6gJrqaamEIlv6Salve7UFyDWKiKy13rg/fTnkku4kwpJwdSTBJchC4lPgE63uygN+o/EArqIN6DijTBX0YGMhX4IYKJWyukWk7kFlCc/DjfAOzRm4Kj/IbissEk66Frc+2HnmQeZW1hvpGMK/5maOU6NbU4VfEPHqiCTvoKF8gptb/gWvsisc2sLCIwO/onTNCWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/CkI6YtI/68hhXtKZ1CzT14Pnfq6BMEmullmCigk74=;
 b=kaaBKyzbATCdngkib0rIsV/X0xgXogJc2f1n8Yup5+tVNtxyd0Nt3D/XgTIUd7++Wd8iKXMIzFiSCCR/ieiU04x4TaStxq25OL0K5SC/Ox6sLDoQ9rduVQPgFfDfpqOLoJMlcExquVGyA5PnG/6Gf684Ntvjp2o3Fr7oL62J8MvoitTosVOXd/ANfTvB7AfozDkwB/yt+p8DfrlrdnwbpIPLd++ugyyT6aP2Zsxm/7Cs02XukNyM4trb7B3s4QGAMfunsaO8NH8/uMUJZdKGAsCuZ4nUaSe2zbVAyISatvvOU+txVTd5QQo90cr+DXF0U7X3yZe3+QUhRwLNAy1r5A==
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:55:10 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7a) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 19:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 19:55:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 Jan
 2025 11:54:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 Jan 2025 11:54:58 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 22 Jan 2025 11:54:54 -0800
Date: Wed, 22 Jan 2025 11:54:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
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
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z5FNDOqkiPq90c16@nvidia.com>
References: <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
 <20250122002128.GC5556@nvidia.com>
 <Z5CbGKYbwy+qPjyh@nvidia.com>
 <BN9PR11MB527600A5B8DC271075936A918CE12@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527600A5B8DC271075936A918CE12@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee871b7-42d5-4b23-0b73-08dd3b1ead8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvAnflQuJrTPMJ02yZ+aDFQoOZykqHfnaAgJYKPWpgleKEmVOVLz4Waj89Et?=
 =?us-ascii?Q?082jI93IwM9zzbqSEU8AfVxI2pch9KxcVBgfZr2jUufH+dQJKuQ9AivIc0Yr?=
 =?us-ascii?Q?8aNCttNaUmx3C4xYCEFV2M9DXTHAuzxRAKmaIRRLU6EoVq9bBvMnwFPASskh?=
 =?us-ascii?Q?1wMf6Ns6zcBzXkTcwSE1XAqaaqsDoG2CB/6ULZQdDBZLJvRHoghzY36R1ZRh?=
 =?us-ascii?Q?CP9YLvZOCAae81HHbslPO7zqHj0wCJD/3PC/CgWuuLeRhbS0ZzuM4snOybhQ?=
 =?us-ascii?Q?b4WGbFdHuQ3yi81/2teKQfMxZ+v5ADR7Dz6QP2Ku9QH/TI05eZPP+Eoz4R31?=
 =?us-ascii?Q?CqVXTCBV7Yd0gD8uw+ib0bT3678Ka/ktSLXNa3bxzlJy2VQAW18sWH7t3KUD?=
 =?us-ascii?Q?T2DRHT/Ow0yATwERWUySzHsbcRFYcbNS/CnoOfmc4+a+MTrwubLsw3tDOJNF?=
 =?us-ascii?Q?HJI5Z6GrDZ4dMtNNBSmqPvbn0ZbSrluQr9CcYvlvyA+PotL1y6xKEaSGiAo9?=
 =?us-ascii?Q?/KClrLnWiak+CvXyJqGJWl3Lxt/aZBDTGJPIcxdeb8j/w9rV6Oga37Iko9aX?=
 =?us-ascii?Q?xpcDHcid0fTtmODszrEquYheLQb9gjQcOQdpHKfIRM9EGJzfqrfk7RwLIxaU?=
 =?us-ascii?Q?Hl2jaacPSK8FL4y1txmiDGdBkr77yjdzMHRU5ai2S7R307pWKfnz6PjcasnX?=
 =?us-ascii?Q?XdPEj+f167PpYowKr7TH3Sk7wGbYdss4MHMjOgxkYstdLrxeVLkIRo8dMs8H?=
 =?us-ascii?Q?qiBsSEoDhDjyRG9wWaopQ0yWYU/rrejTK2zI3wAD21usbN7moOO02mX+FuKp?=
 =?us-ascii?Q?0jR5ol97PasVHELbwpB4g45iXXFNcF9pd2uTY7y4vh9jBu/5RyhevyX/rCNK?=
 =?us-ascii?Q?SyrEJjNs7RB0cpcxP7OI6JIYC2wPd5MbG+bNuz+uZpGtu21a3V0D8hQETarn?=
 =?us-ascii?Q?X9S6dO4ob5ml/8gLyzTaWjSoBJdhkdpYIkF3WmDFInMuj5Cf4/o3bDOWZe8F?=
 =?us-ascii?Q?v7IuFhoGi1Xf4aLaKceSXOpcBrUZZU6lK72pcZUHR91W9ci08R/Qmf9O53mO?=
 =?us-ascii?Q?bey2RwL3eTTK/OSkKWSDWfJnMqVNXIWpszNTRohfu8uAzmw8jOvkKmhecoBn?=
 =?us-ascii?Q?Ia9OyOjDE9J3uwIX6CkZ4BbLjqTefinvj25uPWEe2zwAs055BQyoKTfPb9+B?=
 =?us-ascii?Q?aRjZBKHLe5nITIyWz4UwMdh4sPerKWcOUWxpXxYg4vYTDvfeluyaAA2lPcYC?=
 =?us-ascii?Q?+nYDZNlpM/JXqphTWQNH0TFeAfJCxCCTWmLpZ70dENWPGIudpRyjWbhHH8WS?=
 =?us-ascii?Q?o8vd8nn/jDYJ3xzbO7ye+QLXLtfh8JQ5HzaL2R3ZdmFEBY/Q9zdO2vBUF+In?=
 =?us-ascii?Q?CADeq8PMTLlRlCrH1oF/pTMxtIl3rE8FPPcOViWOm7qBHRooezuvtP8kEAtq?=
 =?us-ascii?Q?gadwMn7TazD5v9RiMjkEUkz/o9x+7Tt/MA6K/S5+hVst7piFtcqHUdch4Ffl?=
 =?us-ascii?Q?51RoJxjgGApifRY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:55:10.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee871b7-42d5-4b23-0b73-08dd3b1ead8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813

On Wed, Jan 22, 2025 at 09:33:35AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, January 22, 2025 3:16 PM
> > 
> > On Tue, Jan 21, 2025 at 08:21:28PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 21, 2025 at 01:40:05PM -0800, Nicolin Chen wrote:
> > > > > There is also the minor detail of what happens if the hypervisor HW
> > > > > queue overflows - I don't know the answer here. It is security
> > > > > concerning since the VM can spam DMA errors at high rate. :|
> > > >
> > > > In my view, the hypervisor queue is the vHW queue for the VM, so
> > > > it should act like a HW, which means it's up to the guest kernel
> > > > driver that handles the high rate DMA errors..
> > >
> > > I'm mainly wondering what happens if the single physical kernel
> > > event queue overflows because it is DOS'd by a VM and the hypervisor
> > > cannot drain it fast enough?
> > >
> > > I haven't looked closely but is there some kind of rate limiting or
> > > otherwise to mitigate DOS attacks on the shared event queue from VMs?
> > 
> > SMMUv3 reads the event out of the physical kernel event queue,
> > and adds that to faultq or veventq or prints it out. So, it'd
> > not overflow because of DOS? And all other drivers should do
> > the same?
> > 
> 
> "add that to faultq or eventq" could take time or the irqthread
> could be preempted for various reasons then there is always an
> window within which an overflow condition could occur due to
> the smmu driver incapable of fetching pending events timely.

Oh, I see..

> On VT-d the driver could disable reporting non-recoverable fault
> for a given device via a control bit in the PASID entry, but I didn't
> see a similar knob for PRQ.

ARM has an event suppressing CD.R bit to disable event recording
for a device. However, the stage-1 CD is controlled by the guest
kernel or VMM having the control of the ram..

ARM seems to also have an interesting event merging feature:
 STE.MEV, bit [83]
 Merge Events arising from terminated transactions from this stream.
   0b0 Do not merge similar fault records
   0b1 Permit similar fault records to be merged
 The SMMU might be able to reduce the usage of the Event queue by
 coalescing fault records that share the same page granule of address,
 access type and SubstreamID.
   Setting MEV == 1 does not guarantee that faults will be coalesced.
   Setting MEV == 0 causes a physical SMMU to prevent coalescing of
   fault records, however, a hypervisor might not honour this setting
   if it deems a guest to be too verbose.
 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

Yet, the driver doesn't seem to care setting it at this moment.

Thanks
Nicolin

