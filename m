Return-Path: <linux-kselftest+bounces-35158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15CADBF2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931517A5D0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C763235074;
	Tue, 17 Jun 2025 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oX6n9xd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D11B4257;
	Tue, 17 Jun 2025 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127201; cv=fail; b=rEpnGxXuCXDguKBntSh8JlffhaelASqYuFoaWj3iKmeOkf2wnBSlKKRyoMpRozMS1wDKjLPHmubrCtgAr0BXBwCbk1KqBgjadiKk4yNflPZ6v7R07KNjO+bzMnGK/oD7qulHLhr0UyanzCcShgXCbWBpEE1HeU115hbIiELKWVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127201; c=relaxed/simple;
	bh=0uvDgmc6nptH5Vxx3j2ec0ycDNGGnwpEyF5GzVSG3hs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmBIqTD4dBnUH/o0syfz9pnFFo0y2D8p9Sy13zp5A5f2lhAIxJL6a8OoMZIDhLmLyTLwzWd150QScUyvTTs1PXvPfKb+oePl04SN1GMUBUxkEd4FmRvS0b4Wo+oBMmS4SWoPYDl3UTnk+NCPod60EtdkGlRqQVBvkOZDTjG5zhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oX6n9xd1; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWDTODaixvYFA6WR3L1JOMdm8LxC1j2f6OpMgRqEX04Egaue58HCSZlrbjep0DhIlhNg+Ju0ZXRHTJLz1HItrth4BuP36XZ1GuoJ4xXYHP4J54NGzGMDO65eBePA2otgdf34fFG73NVNkzFqyLQ+igLM7pvXL3yhp8cHgoaB5JBFxbGpM9r9U5DxtGzpbtke2ZWOM92rzTE/XglAK0XN8vZp+r5vYXjamxl5iNPt9NCKXDRmabFPpr7tQhpGfUP84z8w3ISp5/01tQTeIX4d19waCIZM9Stp643BtyAn6OuBPzTFmqB5bzKW2rsiRxn63J+ZDfGHRYW9a+nJ+OBN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl4j/3faL5j7IyMVPu3XMhk2HTucW21MB4nrwAkRdfY=;
 b=Ee9hft0ibMs5jVv2Ybp4oJzVUldCnaKXaSjeZniQLyDpoGW5z9+BjyovXkdrTSuISAb9QMdOL0I1Mpf+9NEZhE8/G9hpxF+qto7xo5Yfi5ZPgruS1dv97P/LK6ZXFXFN07nXOUm5nxXH36cLdV470zrxM5Ocle3icNNuvbkekQreQjrTDs6XyKRgnXKmOyRUag3Z4g4/4myM4Z39DrtcAYTz7sMkwAlnAQiHNLQg1PBZioI9k0EohfRBh2wQI83Eca2j5E2fqyBGH0MibHJQQAoKbj6zzqEjEJIf/Rb7x+V2VUpsGVBYa9DU54VbhYn6rjQ4nA43Sc8cMNB78S1Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl4j/3faL5j7IyMVPu3XMhk2HTucW21MB4nrwAkRdfY=;
 b=oX6n9xd1p0Qag/IIVVDXTI4tAqqZOk+ANL0x/6F9GKR/limDiBAKSKdu4Zks08y0PECaWxovFwreomntrV4DJ8SnkWFeiupTjWw+qRPUG0kCdQ/ES8ca7Ua4cCChM7SqF6iOUSNukZNKrXPpINzdZYFY1KOgToSF2TTpy1Q/MLm0AmAIuTtgWJIges7Rz8WUAx4WO58jpP+YZ9oBkLKnz4k/EcIzAZXg8sEj7D+PPlkOQOGMdabyTVK65uwMCWDASt4OGydlIURCjeqxBVIPmxPiqYoVWBjaeapbRJZCNCPMFYKSZz4eJIxR8e3yaOPgjdDhyRnu/H3yBLZD1aaEPQ==
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 17 Jun
 2025 02:26:36 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::85) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Tue,
 17 Jun 2025 02:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:26:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:26:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 19:26:28 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:26:04 -0700
Date: Mon, 16 Jun 2025 19:25:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 07/25] iommufd/access: Add internal APIs for HW queue
 to use
Message-ID: <aFDSNYOTToFSbFA2@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <64145b184a0fa7c9b60532c9b475a51625edb77c.1749884998.git.nicolinc@nvidia.com>
 <20250616133719.GC1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616133719.GC1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 747c8694-7219-4b52-4f16-08ddad46624f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFke6h0kF0SM3ElO2PLYkrVXW4FFnO4JH2CiXIYjAH88eQSEtw01jLVu4rd6?=
 =?us-ascii?Q?lrAPMOE7emjBMDMFuXXydZYWmBDX4Zo+izkShubpFKbH+zoRbcDxdo9LEuSR?=
 =?us-ascii?Q?+7nhdS+u7sPt3iqcrOQoB/cbsF1VgFVY8ChctBY3E9Kr6w2yr1kkwN81FDKq?=
 =?us-ascii?Q?fZ2AbyPkUwjot/a9cuLcsALlVzcwWjfyvOqW8RccSU983e8crTdvEgj6H9L7?=
 =?us-ascii?Q?5En5ACyDO1ZL1TdbzIRFuT8WURg5QwX8R2eZXJDdM/By95RWfd8HNiOLCD8d?=
 =?us-ascii?Q?AkQK33zmKdq7q7f6TIBAI93GO4a4fmnogzeG1zQzEgprEG4+ZViRmZWumcUU?=
 =?us-ascii?Q?a/FIEW9BiQlVqoXYuDSYOXC9hry6eHnXplhvI0mCZlWZCD5SBmOrCZjYBlIo?=
 =?us-ascii?Q?+uREgGsQy3gtlfK3dcsPOg/ozQdvIRhbFkATYmKvwjkvbAXMFeJ/ZKnKJ3jO?=
 =?us-ascii?Q?SA39bWtV1CXiHZ+CLYFxUpoxXTZuV5PWLORWNn76DXUcB3g0ODZUgrByQ0PF?=
 =?us-ascii?Q?Qv2/PJedHjj/am+MqQHKb4He4kb9mSRhpIXkHbvT+Q5LdaVpfHoj3IrZSX2p?=
 =?us-ascii?Q?2p1Og2xsu7oiFC0cUyphZBsrc/4edUn2RqV4UFUJPhv4ST8Zc3gPJbnEYSfQ?=
 =?us-ascii?Q?99riZ2TWcoktvglFzxAdC0vesa/Jb37/bg8EPPsNHGGyztle56pWYfQwsjvP?=
 =?us-ascii?Q?pj6l8DTKgn5NdoTXWRQvhXjEkTPz627F/uG5pCn47G9qH0HatzE/CVkrEb0A?=
 =?us-ascii?Q?lxWsvfdorgtK7mDtpHH/SxSfCkldW9fUjOtl/suGzKQuc8fRJtwdRaUK/ojr?=
 =?us-ascii?Q?5ZLhXG/Y5EbTJyJYWMaeFL7InJG022OjfzU0p2rcvDCX/EadVO/dy9G7Shit?=
 =?us-ascii?Q?GyOeMe3laShIagqmr0xctZzpky99Tb7ArD74wKckGsZXMjZEKGFM/fxJtqoE?=
 =?us-ascii?Q?aLYXhXJ3/RLM+l2ga+3oz0ZTBAu372PHE1ElgmT4MA/QzY/cmZtKGaZpzq6j?=
 =?us-ascii?Q?3n7Xnm2xQ7VB/opRZ1BLuMzBK0g0UWdRnnAuiFI2bSjbxU0pdXoA7yXADFXi?=
 =?us-ascii?Q?2Phhh/n3/imB8NU/0GFY9wUtGo09PU5NLLyjsZ9HCZporbOHnlQsOlgLMqnd?=
 =?us-ascii?Q?OdgG5utVXd5zkX7Oj5WQS4j1gR4QkFlDm6K0slFpeDj9S8jUhQ3EUhZUapuo?=
 =?us-ascii?Q?x/mocZZ3u0XKXjQGunL32//5AnzrYu8vViLzWazhXXdWRVIjfS4CmQ61O6R6?=
 =?us-ascii?Q?jpNAox5hE42YBn8Pi37Cd4C8aMK/kHT1g+DTkz8KH2aTo18zFneJ8Wh1sjUu?=
 =?us-ascii?Q?UNZ2+sPJDDnrC9flQ4vKUrgLQQGb3vvk2L/yNshwncPa7s210F81hHuNnZU1?=
 =?us-ascii?Q?RqxM+0PlgJ1f+oiwDchuxt4fC+hQCyEEvshUJcydjrG1H0ZW2va2ljt/qn5c?=
 =?us-ascii?Q?dr3HIxHEgs23sAnfONwOzyI5kixR/iJq+26ZdhFV9ZxqcK4fYvNtndNq5zoa?=
 =?us-ascii?Q?tGnlTsdw1VtvwONVSz7cHVFA0qQ8DhhfKyOm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:26:36.4932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747c8694-7219-4b52-4f16-08ddad46624f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

On Mon, Jun 16, 2025 at 10:37:19AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 14, 2025 at 12:14:32AM -0700, Nicolin Chen wrote:
> > Now, access->ops can be NULL, to support an internal use case for the new
> > HW queue object. Since an access object in this case will be allocated by
> > an inernal iommufd object, the refcount on the ictx should be skipped, so
> > as not to deadlock the release of the ictx as it would otherwise wait for
> > the release of the access first during the release of the internal object
> > that could wait for the release of ictx:
> >     ictx --releases--> hw_queue --releases--> access
> >       ^                                         |
> >       |_________________releases________________v
> > 
> > Add a set of lightweight internal APIs to unlink access and ictx:
> >     ictx --releases--> hw_queue --releases--> access
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h |  8 ++++
> >  drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
> >  2 files changed, 58 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 4a375a8c9216..468717d5e5bc 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -484,6 +484,14 @@ void iopt_remove_access(struct io_pagetable *iopt,
> >  			struct iommufd_access *access, u32 iopt_access_list_id);
> >  void iommufd_access_destroy_object(struct iommufd_object *obj);
> >  
> > +/* iommufd_access for internal use */
> > +struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
> > +#define iommufd_access_destroy_internal(ictx, access) \
> > +	iommufd_object_destroy_user(ictx, &(access)->obj)
> 
> Use a static inline please
> 
> > +int iommufd_access_attach_internal(struct iommufd_access *access,
> > +				   struct iommufd_ioas *ioas);
> > +#define iommufd_access_detach_internal(access) iommufd_access_detach(access)
> 
> 
> >  struct iommufd_eventq {
> >  	struct iommufd_object obj;
> >  	struct iommufd_ctx *ictx;
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 9293722b9cff..ad33f1e41a24 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
> >  	if (access->ioas)
> >  		WARN_ON(iommufd_access_change_ioas(access, NULL));
> >  	mutex_unlock(&access->ioas_lock);
> > -	iommufd_ctx_put(access->ictx);
> > +	if (access->ops)
> > +		iommufd_ctx_put(access->ictx);
> 
> I was hoping we could null the ictx to signal internal? That didn't
> work out?

access->ictx should be NULL for internal. It should have been:
+	if (access->ictx)
+		iommufd_ctx_put(access->ictx);

> I would at least add a comment here this is filtering internal that
> doesn't have ictx. Maybe a little inline 'iommufd_access_is_internal'
> is appropriate. We'll be sad down the road if we need ops for
> internal.

Yea, an inline will be cleaner. Will add that.

Thanks
Nicolin

