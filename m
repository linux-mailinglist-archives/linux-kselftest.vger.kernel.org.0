Return-Path: <linux-kselftest+bounces-18715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6798B2BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 05:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58391C21707
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003B1A287B;
	Tue,  1 Oct 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAL7K/VE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBE1A2850;
	Tue,  1 Oct 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753807; cv=fail; b=szufcPxZzjD0GochG/krX1OG0TT5Yd+fkZGmy0/ZC77NeeydaEqse22WFE6PuippKHVUTNLyBTC8YMEkzYtJw9twsgr1AHaqViARl6IlYIEQyiex31nH2pAN3jUcqJsLPqjzzEpJSpxTr/MxQHcdzMfS9L5iNz2ryPSmm5EmrTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753807; c=relaxed/simple;
	bh=shej4pUBs7TM7wcUqgt5ZgbgaLBza5bK5FR2lK9zEXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIHYzz9lrfzVNfdSFFDp9uJnLvEaeE1KOZpbVWU2GrIc15shdEGtfcyH4JnbDAuI7i2rNLbvfzYsAvqmaqg7qxzYKnYgoVs2HcKmN2Prl2z4sjafUt+SB0Z5fKXLaCw3csYmL+r5asavEXhLA/07r4vjrY9v/KWa1XARDQccNV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAL7K/VE; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsL14vaN/1poiZ+F1DcrcSC3BXLY/NwQMm06pGL+L41M9sULORJ1V4gBzolBc/YbqR7Y5CKIq+rni8qwTfmUNLZFSRg7lip6CFrbH475CU3qR6RR655+dbxDk3MqPxlfVOa69oN7vkinCHlZIpnkA/UGb9/VeHUPAbjDUj2vl3yQbXrTt563ZR2cpPF1fPf4I6/ZnCM/fZ8p8fk3MiDRDl9va+6dica6EWfoofgs9K+8Rihn+Rs9sT+T1M4cUDC3fJjiAPSU4jsBn7kzBvTeYyRox4Nwl9nn3KJmrYUtSxdMdmiqyLfRr+mN2N6iqSy+qyqxctAfecjiyzQRw7Z4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmtELzU0ZQlox+h5Sq0THfTkyL0RJRjJowDOVjASx7Q=;
 b=bl4Qmuyo6khTxtVgmdkrsokYegpAKMVeN+1zjXKZ//ZgCsnqhlo7+aYjz1iVot8y7VYkZbCG5/zf0DHg506Hy/QPUoYk7iPB7FWpGX86mwDmdV2uEDgS4OY+9xjHZOkX64s6zFkRs8IWP+Kw3ax9tzU32seHG5MP4VGqe866+fvrIYPUK2t+ow8sJ7vdSM+gvRGOFAnxtSN331sT3IIEEWrgxUq1uinmDVNjMd11jbDLk5lbvUrJDa39iqfTDntQOspAJwf33pVSfvkDTEHowubhiUPpemdV3TprMGmV0Se6t5JXEjuQP+4OJp/VHDufmdS0DpwTmQGoJ6qSr1Xc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmtELzU0ZQlox+h5Sq0THfTkyL0RJRjJowDOVjASx7Q=;
 b=JAL7K/VEg6kFG1LEbNATrPvLq0nC7K2jrvqcnXmoHJXTqUzUcPYvFlYiiHQXWRBmzuA6cO4HJdK4PHtdRV98Fw/XpJMwduMUgsiwUrkuNWjIRoTQsw1O3FNMmV2zXH3v15tns4zoAb6YWjdoz5UD56EXAR0qaCdXzuQwtK4YUX16ny9/0ODh4Hirde5QJaSZk2Zm7Rm3ZUDTq/elF/rpKzsSbDLav/NApDgO8xl68r2nYI7CqNZiEcaCrO5kY++mBF6FQGU1CG43hyhpcGWWo4bqzP8RzF5oM6n+SDACq4oY+PLiMst1tJTrnkosQZ8/L0T7MbxERBKu7fCyKUKFTQ==
Received: from CH2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:610:53::23)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 1 Oct
 2024 03:36:37 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::9f) by CH2PR17CA0013.outlook.office365.com
 (2603:10b6:610:53::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 03:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 03:36:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 20:36:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 20:36:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 20:36:21 -0700
Date: Mon, 30 Sep 2024 20:36:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZvtuM1nG8UCeCLdM@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
 <f6899837-b908-4401-bbb7-5e205b6b3a88@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6899837-b908-4401-bbb7-5e205b6b3a88@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: a22cfb74-bc5b-447e-6988-08dce1ca4151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hR7lzzuOJUho7XqhQbMRdnkxKvsh/Cxe6aUK05+apc5akKrdhN+MP6l73tlJ?=
 =?us-ascii?Q?a3EBfNb65hw11+b+5xLZZvXYMhZqQi1WWFmsWRW81uRO5AnTc+afM2N8gyMM?=
 =?us-ascii?Q?Yma8upYzDBkxOt+qIUOs/V6+y18ZgMGO6xZ7hEyAc3vvWO6qQDgajKeN5yIH?=
 =?us-ascii?Q?pttcQoJJNUDTh5VRYUNDthpSuKarhon5PCuzmehS/lZG3tejg7uN8JFz0ywt?=
 =?us-ascii?Q?mmd2NRv9wDq2dfS5L8n3rYxncINTsGNOfSJW4knnFeSbj4T6bEUkDNOkdgoQ?=
 =?us-ascii?Q?eXWEXTI2VWcWm/s2VxLyt6qVYVmPaB+g/xAeAaMcaFPf5RbjHX5JG67pNsa2?=
 =?us-ascii?Q?vJsBg4H3zL2REk9MizJlQKa6FfiIy2yRz0Ysubp4N6LPtGM6CWmTraUM4PS2?=
 =?us-ascii?Q?qkDgNCYe2aeB0cUMzReL7aEYLZ+EVpQN4LPzlF/Bqb0qviYNBdELmwNmvVi1?=
 =?us-ascii?Q?gT8IXrES6N1Jxi/U7qSbP9FUBFC/f5IZJvqM5Mr5CgvvfMp1uqdzfA7Of80R?=
 =?us-ascii?Q?Q4QvFm4UEu3cncoZRLpC1ovDa3U6ZA3rxx8RKDojyyjX/Jwx/GCOrccorP/L?=
 =?us-ascii?Q?eGSnIPT2I49hlK/wvij8RNtBSaIKi3vbkfAhvdIb6JmHXxj9ScgDjlG9/n0P?=
 =?us-ascii?Q?3ObFAZseYqeXRP22PoXx5paTle8jcNozsWGY58/yCMUS7Ch6MTtOu5H2gmBk?=
 =?us-ascii?Q?RiMgS3ogchHWry4+Xc3xVvnnjcmz8E12epe9RgdrOHczj3yd1wTeIFh782Ur?=
 =?us-ascii?Q?6Uh0LGl9T8WDkO0nrletd0RV4AtyrXQ3lEfOZQv1r5c+7LN5nqyLDAyQZ2ro?=
 =?us-ascii?Q?veJVJFbAriZIQiO7eZgk+LuzpU+lq/D8PDx2jUMV2fZfe2B7NwhuP4W6WgW4?=
 =?us-ascii?Q?T5l+e92dLxvwq427ULhhM3rnaoxV8X4HQyB558rcmlRKeVDLs2j1j688xZXO?=
 =?us-ascii?Q?IXc//zAedwry0PAl7SJSDX7DdUU0O4cgvYQHyKhPJgfRFR+VNff9PAIEquFS?=
 =?us-ascii?Q?NAWucNgabIP/Z+2TzGNp68a+UPzy33sksqwMpVvRPuQdM1UFVWtjdJHYKTyL?=
 =?us-ascii?Q?pZcQBnSj9UbM/w2jdTe0XnoiHykMIUBDBFGIkaXZFdPuFJGkAxV51BZMUv6g?=
 =?us-ascii?Q?n8pvLWpgkKcjwbtLntgMe3aoBlMBXbHz/SnuS4G9QtEKauWC+O3+Czy1o4LD?=
 =?us-ascii?Q?CJlk1SD+Awmh7PGgSugwFXHeegh/1ge5K8FvvLmgibF8QDh3BL/bze81LvXI?=
 =?us-ascii?Q?qCjSmv+ydI7b/Y7a/bIQRj1Xtg/wnUK13IESHOF/NswLbNPts4rh8vf3BHft?=
 =?us-ascii?Q?cfQTalm+RtHxyggoODpceBMvnr8Jhg5V6s/X2+EqSKZsgbZpoBQ0BUvF+iQn?=
 =?us-ascii?Q?cbmKeOvYBlz26u1ltHnOydH5pH62?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 03:36:37.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22cfb74-bc5b-447e-6988-08dce1ca4151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

On Tue, Oct 01, 2024 at 11:55:59AM +1000, Alexey Kardashevskiy wrote:
> On 11/9/24 17:08, Nicolin Chen wrote:
> > On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, August 28, 2024 1:00 AM
> > > > 
> > > [...]
> > > > On a multi-IOMMU system, the VIOMMU object can be instanced to the
> > > > number
> > > > of vIOMMUs in a guest VM, while holding the same parent HWPT to share
> > > > the
> > > 
> > > Is there restriction that multiple vIOMMU objects can be only created
> > > on a multi-IOMMU system?
> > 
> > I think it should be generally restricted to the number of pIOMMUs,
> > although likely (not 100% sure) we could do multiple vIOMMUs on a
> > single-pIOMMU system. Any reason for doing that?
> 
> 
> Just to clarify the terminology here - what are pIOMMU and vIOMMU exactly?
> 
> On AMD, IOMMU is a pretend-pcie device, one per a rootport, manages a DT
> - device table, one entry per BDFn, the entry owns a queue. A slice of
> that can be passed to a VM (== queues mapped directly to the VM, and
> such IOMMU appears in the VM as a pretend-pcie device too). So what is
> [pv]IOMMU here? Thanks,
 
The "p" stands for physical: the entire IOMMU unit/instance. In
the IOMMU subsystem terminology, it's a struct iommu_device. It
sounds like AMD would register one iommu device per rootport?

The "v" stands for virtual: a slice of the pIOMMU that could be
shared or passed through to a VM:
 - Intel IOMMU doesn't have passthrough queues, so it uses a
   shared queue (for invalidation). In this case, vIOMMU will
   be a pure SW structure for HW queue sharing (with the host
   machine and other VMs). That said, I think the channel (or
   the port) that Intel VT-d uses internally for a device to
   do a two-stage translation can be seen as a "passthrough"
   feature, held by a vIOMMU.
 - AMD IOMMU can assign passthrough queues to VMs, in which
   case, vIOMMU will be a structure holding all passthrough
   resource (of the pIOMMU) assisgned to a VM. If there is a
   shared resource, it can be packed into the vIOMMU struct
   too. FYI, vQUEUE (future series) on the other hand will
   represent each passthrough queue in a vIOMMU struct. The
   VM then, per that specific pIOMMU (rootport?), will have
   one vIOMMU holding a number of vQUEUEs.
 - ARM SMMU is sort of in the middle, depending on the impls.
   vIOMMU will be a structure holding both passthrough and
   shared resource. It can define vQUEUEs, if the impl has
   passthrough queues like AMD does.

Allowing a vIOMMU to hold shared resource makes it a bit of an
upgraded model for IOMMU virtualization, from the existing HWPT
model that now looks like a subset of the vIOMMU model. 

Thanks
Nicolin

