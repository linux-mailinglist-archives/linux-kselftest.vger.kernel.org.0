Return-Path: <linux-kselftest+bounces-24308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44925A0AE8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DFF16566E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF51188915;
	Mon, 13 Jan 2025 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmpvVC3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D214885D;
	Mon, 13 Jan 2025 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736743904; cv=fail; b=Kw9C1+xSQnYFQ6TZzDRH2wTAIbinhMBWdvs7pP1nh26Cz8qn/A6AZMmBB5cTEmILmHdroQHqgj1YqzYLyxWm97DlycJFirM73aBUXjrA43+ysK0VfleV0xVw/gNwfdCW2iwu38F29N2BhlsZ6B/iDHmCPqlGl8SwvNCyxBC4o5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736743904; c=relaxed/simple;
	bh=KKCZPn1BI26ueK3Z1P//ARtuL1UtHdw2G8dReSYx91k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG13A/U5hjMZEGdeNmp1dJp1NHZgfgPOfcd6gjQ7ZrscLP3lZ4P8yuJG12z2lSXvcQVDQgkJxwfXCeZUMTI1fU703dpm7ysXau0EZokncPmjPESwPcsma9joNhNlc/cQuU/bKukq7kjzu3QMmXIJWT+QIo6ZPSr6FsAU5l01PHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmpvVC3f; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkvTqVIsst09FnCY1L3oHvSAq5bTonUwSk99GZPJBDYQlQv9hN34chBBf0wcEWLUv5ozsa2+/Nfg0n6qdwIqF7FcLZ0ac6QbxK7jiZlbLJq6/IhcI3lWwSTqjC7dRLocRTbbdqbPKc4jIBov8E0cqDs/2NWuax4tpYkr3XFteFL6eRCr+62V5sH60oD0/LspGPCWYPVFwoOfCVV1xqQWF8tA7vxXUNPEpAf7CDoC49WUi80qcH57SwssrGqOfFCtZ4zX6eETdh1MHAtfsOB8cc1Cr3CzRvemdKN9QJdCU/vXIndl0C/8ezmZXEC0+FFrGygCPS8PIvPrxOWmr/nCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UMtk1xYSGUTtbGHYzhYqAkUHV7L9bGvsOsrTe+89Ds=;
 b=warV0g7cXBriDWKrskASwl2vR/dFjc+BOawqrCOKGkQ05hUdH+wBuR2VXuqMNrIXtCT4TJcLKe1tI5eig4o4KvZNSM3nN4725sluMlUs8YiIGjuPFUeQzpebIRB1nWapB316EIqK/hWsn55Q5CV/32lNozLLL8jhnoZG6dkLp3nlSJVZJNDvF8z7hvFu8blsw3wHvf5GGx4EpeTigZ/ucZFyr3ou9EmTPEj/aA6c/kL0lJ4nbnKXb/qrfTD4gjB9b9UJckduWuI5CKR0Ln1nBiHvOo/HjaDyBbi+yz6lvVEJc7AD71b2HQI+R7giP00acw4vzy71iawHhrsB2T107A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UMtk1xYSGUTtbGHYzhYqAkUHV7L9bGvsOsrTe+89Ds=;
 b=NmpvVC3fvthv7PLqqvmlhBu+CVRz9WmxC6AgTZLVt7+qxz8RUMQU8J4/5iKTtRJ+pTp7z/50GOd+py/luxKiiTH+0bEXMkHPlS6bg/uKayHOqtUyDLRv5qcxoF/wNYvpRYJASLzUa9Yv6A+4sHNEEB3IdzDh10Ma6pWwgoJM/izqhf4NUmevSL4sVFlqO1Zso4OXfxLyzsjFeEFoktl+JKkfsRCCiPFIcPnCbNzaM0TxR+Zg34z1bm2BKOu1oY5jXobcHUZqw7HpNgiRa5VvQ1DGB6j8NdRaOjie0fRgtsc756C7C1HKOVkf0JFi+4VYi5jXDrs864ISYTVQbteibg==
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 04:51:37 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::f2) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 04:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 04:51:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 Jan
 2025 20:51:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 Jan 2025 20:51:27 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 Jan 2025 20:51:26 -0800
Date: Sun, 12 Jan 2025 20:51:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z4SbzRB8/me4kbDF@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z4GRMEjAIoBjHnMe@Asurada-Nvidia>
 <BN9PR11MB5276AAC06F5B90D09923677F8C1F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AAC06F5B90D09923677F8C1F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c8aef-4191-4eda-bfa9-08dd338df69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/lwC05Paox/t9/FAWhcPvFCAgpit1B8T07RuPCzMCAUFajKJIEeU2k97lgu?=
 =?us-ascii?Q?gbg5ONNuisIg8+4focIENqK5W4voIW0js8aidwAetymhODo2CfLUES5AqRRR?=
 =?us-ascii?Q?1h1M/ycX13Eh+yYAlaIfIf/VWifDl74RhrxDBIABiT941Bg+FdsRzA3WTw4R?=
 =?us-ascii?Q?Dt+YZjtHS5wkQzohOjGuUMEDzxHhW5jEG82tjsDNHprmE+5o5A1qzagEYg2s?=
 =?us-ascii?Q?mnZfz6GNHT0gbkuWigzlilqi/RHVCgtpNeqIAXc2m8K3sxapRBeFHmJ18Tft?=
 =?us-ascii?Q?FVKm4qLsAYrlxaQlY9FVdVZh6zwEVVfVAASXH0ZIg/tLZkLMmJ7c9Q8ZL54f?=
 =?us-ascii?Q?rKG+7KuD0rh2IarW4XFggW5oMc0LFrgxSwjhAegzbdqPs92PN/yN/GAIMg41?=
 =?us-ascii?Q?Yp6JuXGkNjRHnKJm6eCKWuejjNiUAr9GAZs2qFHMhaZaCxdOk1a12y8NODMB?=
 =?us-ascii?Q?/ug0gl81sVX3qnX0QbJ5ZUL4n8ygF67QILUmrL5v7bpqd4Vwq7qRloyaq8n2?=
 =?us-ascii?Q?db/awduWTJC1ua6Mj8NiUFVHUtNHlQBD0MEl0lH5aoKuZVq/Zu+EdCNKzHW+?=
 =?us-ascii?Q?7eApm/fr3D02y5jowZcmNOXlRnpPqPbx0dk71GCmLNN7LEbnxWNWuD63iLUw?=
 =?us-ascii?Q?1IMEQlr1lpt8+eoeDez2RdaFLdIXAjg+w/hlbuNimlCspai0aFxbTE24f3qm?=
 =?us-ascii?Q?qOC0nh2ywOwqXCq7z/t1CGjuFv2wvgWy26N0ntIMf7VCafFTiBCwXaXmMxTi?=
 =?us-ascii?Q?+Kz+gt4DKGT2m6bCL2wKNuJ6OIC/Aen3FMM+po/tdqDbUEazeTqhPToTFLX8?=
 =?us-ascii?Q?Xl9BKh8aA2SNfWnOd/sI4HKFzDnZfF1zveBquk7hR9Lo9swCH6TbJwFz8vMQ?=
 =?us-ascii?Q?KoRkIh33Pq3GGMZLH825OxrGbuD+xD2EoSTHPaId4uli09G5dkw3JSGdZplw?=
 =?us-ascii?Q?8xmaLAJn5N89qjWHvIq7gI150y9gikRk+KLNTrcjoTQQ7kBH7jawsEI2LHmC?=
 =?us-ascii?Q?L/DX6iS1S7Sy4q4wWOUPFL4NKoDjvM6zXr5eWgzzUcEeLsciOI93pfP59ZhW?=
 =?us-ascii?Q?geVBXBVEjTa5YQZIRt+Z5iVQw7b6+8ZTR/16htpAQjE5IWGSyLLqNA4cAw+5?=
 =?us-ascii?Q?Cgy8zLNDIv+y1px0vDo4zVytBDjY6kluQy5eYJyXKFxCm+yS6SH8fSK/FB6o?=
 =?us-ascii?Q?rckkEE+lVU/K+04YjkC7WYTnJOZt3hMmwepOgr2aXL76lJvq+jABHA90cdNy?=
 =?us-ascii?Q?HuxrNv5/t0qBNjll863KRIAXMJJMS5po1EbP8ZghSyAqRRJ+oYZ3IM6zs7vG?=
 =?us-ascii?Q?AxJk/2nWUcz4dlAqSLZhuH6rW/8mNXHI56Gf2vkSGGm6Czv/0aTzlk7cjB9E?=
 =?us-ascii?Q?gp1JDxGVwPGeiIdoRH9wJLtszwS1ncRwptrHkCdFmSwotf8cv/yd7WYIr1iy?=
 =?us-ascii?Q?DxGXi6EMh2RCnK/EVm9Ngjdwow2j1voAbwXzxRwFaaefjhLn7YZwYl6Sq+OO?=
 =?us-ascii?Q?ZsK6T+5IJkZK53k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:51:37.5945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c8aef-4191-4eda-bfa9-08dd338df69c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

On Mon, Jan 13, 2025 at 02:52:32AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 11, 2025 5:29 AM
> > 
> > On Fri, Jan 10, 2025 at 07:06:49AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, January 8, 2025 1:10 AM
> > > > +
> > > > +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> > > > +{
> > > > +	struct iommu_veventq_alloc *cmd = ucmd->cmd;
> > > > +	struct iommufd_veventq *veventq;
> > > > +	struct iommufd_viommu *viommu;
> > > > +	int fdno;
> > > > +	int rc;
> > > > +
> > > > +	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > > > +	if (IS_ERR(viommu))
> > > > +		return PTR_ERR(viommu);
> > > > +
> > > > +	if (!viommu->ops || !viommu->ops->supports_veventq ||
> > > > +	    !viommu->ops->supports_veventq(cmd->type))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > >
> > > I'm not sure about the necessity of above check. The event queue
> > > is just a software struct with a user-specified format for the iommu
> > > driver to report viommu event. The struct itself is not constrained
> > > by the hardware capability, though I'm not sure a real usage in
> > > which a smmu driver wants to report a vtd event. But legitimately
> > > an user can create any type of event queues which might just be
> > > never used.
> > 
> > Allowing a random type that a driver will never use for reporting
> > doesn't sound to make a lot of sense to me...
> > 
> > That being said, yea..I guess we could drop the limit here, since
> > it isn't going to break anything?
> > 
> > > It sounds clearer to do the check when IOPF cap is actually enabled
> > > on a device contained in the viommu. At that point check whether
> > > a required type eventqueue has been created. If not then fail the
> > > iopf enabling.
> > 
> > Hmm, isn't IOPF a different channel?
> 
> We have a fault queue for delivering IOPF on hwpt, when vIOMMU is
> not involved
> 
> Now with vIOMMU my understanding was that all events including
> IOPF are delivered via the event queue in the vIOMMU. Just echoed
> by the documentation patch:
> 
> +- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to report its
> +  events such as translation faults occurred to a nested stage-1 and HW-specific
> +  events.

Oh, looks like that line misguided you.. It should be non-PRI type
of fault, e.g. a stage-1 DMA translation error should be forwarded
to the guest. I can make it clearer.

> > 
> > And a vEVENTQ is per vIOMMU, not necessarily per vDEVICE/device..
> 
> Yes. My point was to verify whether the vEVENTQ type is compatible when
> a nested faultable hwpt is created with vIOMMU as the parent. then when
> attaching a device to the nested hwpt we dynamically turn on PRI on the
> device just like how it's handled in the fault queue path.

We will still have the fault queue:
	if (error is handled by PRI)
		report via fault queue; // need response
	else (error is handled by vEVENTQ)
		report via vEVENTQ; // no need of response
	else
		dump unhandled faults;

> > > Then it reveals probably another todo in this series. Seems you still
> > > let the smmu driver statically enable iopf when probing the device.
> > > Sounds like iommufd_viommu_alloc_hwpt_nested() may accept
> > > IOMMU_HWPT_FAULT_ID_VALID to refer to a event queue and
> > > later dynamically enable/disable iopf when attaching a device to the
> > > hwpt and check the event queue type there. Just like how the fault
> > > object is handled.
> > 
> > You've lost me here :-/
> > 
> 
> Hope above explanation makes my point clearer. Then for a nested
> hwpt created within a vIOMMU there is an open whether we want
> a per-hwpt option to mark whether it allows fault, or assume that
> every nested hwpt (and the devices attached to it) must be faultable
> once any vEVENTQ is created in the vIOMMU.

A vIOMMU-based nested HWPT should still enable IOPF via the flag
IOMMU_HWPT_FAULT_ID_VALID.

Thanks
Nicolin

