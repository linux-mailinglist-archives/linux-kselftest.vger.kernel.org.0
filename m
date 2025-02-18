Return-Path: <linux-kselftest+bounces-26886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA16A3A49D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE8B16C575
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F15270EAD;
	Tue, 18 Feb 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqhElXL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38226FA59;
	Tue, 18 Feb 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900894; cv=fail; b=TEposclnyClLmEGpcz6hGyduDVLFy/B3TbQesU22rW2Ll+3uw2bFXHH/Xp171SydEoDpgalaVkafx/2PBXSfErviuqVizBHcpdeFIxR2vKcZqBbnYn3O4wumO9hVPrtOS6fuPcRCEZcN8VeBgc7D6K1T3YreInpneZVwCKg3hkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900894; c=relaxed/simple;
	bh=dMh7bGZVd3EmChNxFSOm9kCk4NA12TfVvRFKv2SjltU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqD1T65uf4F/Zq6gQVwY+7RkZTrqBeAB08UtXFU0jnIhaKC9QdyqQveiqv0zzS+xx2VCvS6RJHe0lNMXypHt0rMr/wh/tJH1xo6/fzslbayCbq+GFja0gt0hObiHxCQLMOm7hx6n6NPJwsFMFOJNRo0I/quH7qZeQdVOzum7gHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqhElXL1; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvEZqX6IJvR4OUok4YlhE4gT83lHLqpNtaC30FB9WfJBj6C7eYyKgoiLvgRIW2gVHg7OwJtAd02Ad75wHHCTSk1KljLnXf/ByMm4rmf9U/pisodvOJrd9J9YBeXJR3NRPjD24BrPSk9tvOkn+Jsy6FikjfbhMz8A4CScTRIDZIRLXBOYf6vbw7q/RoqMYk40SJTmEfLo+Nb99re/4ms4OjqvoVSsLNbEr+gNirQN7JzRtTTSCv35b+n2eyMKa96JLal/FrHtj3X/k+BjQP5MxylEVtXVZ0staFzbsdEOl5sweG/GQKqCZ8kAknvI6HZhxCvGnaXZ85KAwC6PX3EUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPtkH+9tRj0bGHNqJZLPBv/Q2rSN8i7fVPL1WNVmhEY=;
 b=UmjO0nOGxGYPbCN1sT3Mq5pBeX3M7hWlohyeH3ZCXk/nXGd0tJlTJBszL0H0RLPSMB1Ck2eEksiSm/WfyX+ekOfLr/qAlWb98mjf1Jyu7RwhGxsc/Zmm2Z+BaV44iwOGbbmndTdIbWpShPEEzONrg5L9sZCaSunKff01GYR9GpZFnaSobBYDnsTCpW99qLjrkPnErWqUkh/EcqErTfJBhjsxNGnXTTuw2uB3em821qqbqaLngtJU1gVc6rzzY6P6N9TAxqN0RTgiDNrFk2mM6VruG1iOcS5Tt9DPw9m26eOAD0bVKJsPQ7HXHQcAzQqXRSfMjFEqmcFNHpWdEdDbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPtkH+9tRj0bGHNqJZLPBv/Q2rSN8i7fVPL1WNVmhEY=;
 b=DqhElXL1uRBHuiQD/n5wCNWOq8b6JS+3p/pSMpHZAdE7yu7yPSgxIhNgntAXATOTChxk4NRoUhf2fRrRTF16HCZRUnfmwmuY80oD7TJljNRWOi5Vptz33dZ1SgezbpVfg0/wnE/73OTDqRjFkiiQeUN8LVtvSbuGoHtnSyyxf506ULTBEIGm9mChpcoUajKTclg9taPL/JpwsYRfDzwz+whlK9Zl6juUWToKXJyj0g58xN0CFcK4c8qYqX7bhSUkRgYyC19fYrX04FraxJsQenDR/yfgKU35rBPgyzGrp78z99WXlKq18kGBTUlFqxoTjNJbyvhAikk/T2YVRRlUZw==
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 17:48:04 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::8c) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Tue,
 18 Feb 2025 17:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 17:48:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 09:47:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 09:47:53 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 09:47:51 -0800
Date: Tue, 18 Feb 2025 09:47:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z7THxrq/6sYP/AIi@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
 <20250218152959.GB4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218152959.GB4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0f3359-2756-40b0-f4d6-08dd504464ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgTMqKW5hKOMQcpxMRRIiovFtqBSEBPE3lk5W6KvxCZO9wBpCTaKYLLITCoa?=
 =?us-ascii?Q?Aw8obeza1JEKfwDAwxYGiwGaHIx+Y+YpyUReyKtA4jeydSnVz2NM+CA81Eov?=
 =?us-ascii?Q?/DJQxA5nQBcZGffW3xLO1hL809dxPPU2j38aDxMz07fAPogy8BnmJ/9wtxbK?=
 =?us-ascii?Q?6fWScqfZw8kvdUKvHL9kswyCvG3z2I7gcFPUy9JlNU/aNqnbWYgcLGYnxYgJ?=
 =?us-ascii?Q?gSBquYY8nZQMdMEZObYjnmgl8/o2oHicqknQDZejeFB0ZjaaHfEoiTFlUoR2?=
 =?us-ascii?Q?+YLXJoapoLjyyuh2q3oQHBkCjVntvITNny4Su9sLT7T0KAdsLGdF2tbt8Gls?=
 =?us-ascii?Q?b2kU2hc5ayWp0iuXQRNxPYXXzaLsmA3IK543j72kp7fdtLTkBZDMgJ81SmIb?=
 =?us-ascii?Q?5IFGmd38Q852kDcL6KJ7tkTRRiOItWabctBlnDSEwvZniZmbDdqzKsvxrG3G?=
 =?us-ascii?Q?0kCxw0JAk2JIKKiQqjb+DTzn0D5/17XWAWaJEdcWbrL60d/bfrp4UMpA83If?=
 =?us-ascii?Q?a+MnS2agW1E0A/Gy63GZKf/0QTSg+Bx1P5htTcPEP4O/bIna2MwD75WoeWTE?=
 =?us-ascii?Q?7dKRj81dS1psXsyG9zoYIT+qLGRDdECgZMjHTOGHYFfGBToSR80MTeISg2TR?=
 =?us-ascii?Q?LeT62e6ivy6QXbKCH6GUaoE5AmJ1WsZuVuMdijq8r1+GJvCa2hS4txcr/35C?=
 =?us-ascii?Q?JxPadIeFC9Tj6NFBqHeosySI1YtobwV16ZMis3Nv4E7tEX4+s1nxvNrjsK6G?=
 =?us-ascii?Q?RmCjjnD1MXRwX1aZiE1quUEEGiJGOV64UBiNpfoH1hhrMX0078AJlVRsc2oM?=
 =?us-ascii?Q?TN5N95RfFWbuOaZEKLP7Lxl0FS88DYpqSaaisFJDq7rRZFerfB9taS0/fPIL?=
 =?us-ascii?Q?tv0JPWFypFkA6X8cc1yZJyb7kn2Xv+LF30Ts3FaRMKpt/kCw+S5JRQ7U3zME?=
 =?us-ascii?Q?bJ/BE4IT/FH6Wg/eviGvZABxrSs20Xi7541acYfvQuGhtupSw19fvpcu6Xpz?=
 =?us-ascii?Q?3L0HllBMafCO9phtZOsXITvcrxA5Gxi8S5zqKhv/z1cPBOz9tZpXL5jjcFX4?=
 =?us-ascii?Q?byFSCXSRIio1Vpzdf5tNGlxLWrMHSiFNHuADNMoJU+gGubMLcmWnAfJJClCB?=
 =?us-ascii?Q?eJFpG3Zfp9PYJoFbVTxp7vmkeBHiZsVfYvm7sFVQSdvgCdBxeKKjmrpt+gw1?=
 =?us-ascii?Q?T6cJwKRhjwNoHNkZoKE3VZUpf2XZisJg7v8q11rhsqRXsM6Vzi1O+ctRo2tQ?=
 =?us-ascii?Q?m17RiyHEz6PEKIXIQPGI3MKdloVDFdgfvFny66mdxrzfZc+BrAGf6xIfJGFj?=
 =?us-ascii?Q?jNO6fMO9lOAVmNShc0F66pKSYzynSwGpJLuERv3URGUH//o6EMMM09Xl3zZH?=
 =?us-ascii?Q?0xUBxZyTSs3IraxsXoTcawWiomY546gLKe0FqZMZrsjHCpcgBLvfKGj0FLZ1?=
 =?us-ascii?Q?OOvzDYewjaoynVVYtUMkTfDfHzIoGXxMlKFRIskOCpWGEMXUI7XRzfzGLS1g?=
 =?us-ascii?Q?umGJOmbZmHQH8RY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:48:03.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0f3359-2756-40b0-f4d6-08dd504464ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

On Tue, Feb 18, 2025 at 11:29:59AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 24, 2025 at 04:30:34PM -0800, Nicolin Chen wrote:
> > +	list_add_tail(&vevent->node, &eventq->deliver);
> > +	vevent->on_list = true;
> > +	vevent->header.sequence = atomic_read(&veventq->sequence);
> > +	if (atomic_read(&veventq->sequence) == INT_MAX)
> > +		atomic_set(&veventq->sequence, 0);
> > +	else
> > +		atomic_inc(&veventq->sequence);
> > +	spin_unlock(&eventq->lock);
> 
> This is all locked, we don't need veventq->sequence to be an atomic?
> 
> The bounding can be done with some simple math:
> 
>   veventq->sequence = (veventq->sequence + 1) & INT_MAX;

Ack. Perhaps we can reuse eventq->lock to fence @num_events too.

> > +static struct iommufd_vevent *
> > +iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
> > +{
> > +	struct iommufd_eventq *eventq = &veventq->common;
> > +	struct list_head *list = &eventq->deliver;
> > +	struct iommufd_vevent *vevent = NULL;
> > +
> > +	spin_lock(&eventq->lock);
> > +	if (!list_empty(list)) {
> > +		vevent = list_first_entry(list, struct iommufd_vevent, node);
> > +		list_del(&vevent->node);
> > +		vevent->on_list = false;
> > +	}
> > +	/* Make a copy of the overflow node for copy_to_user */
> > +	if (vevent == &veventq->overflow) {
> > +		vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
> > +		if (vevent)
> > +			memcpy(vevent, &veventq->overflow, sizeof(*vevent));
> > +	}
> 
> This error handling is wonky, if we can't allocate then we shouldn't
> have done the list_del. Just return NULL which will cause
> iommufd_veventq_fops_read() to exist and userspace will try again.

OK.

We have two cases to support here:
1) Normal vevent node -- list_del and return the node.
2) Overflow node -- list_del and return a copy.

I think we can do:
	if (!list_empty(list)) {
		struct iommufd_vevent *next;

		next = list_first_entry(list, struct iommufd_vevent, node);
		if (next == &veventq->overflow) {
			/* Make a copy of the overflow node for copy_to_user */
			vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
			if (!vevent)
				goto out_unlock;
		}
		list_del(&next->node);
		if (vevent)
			memcpy(vevent, next, sizeof(*vevent));
		else
			vevent = next;
	}

> > @@ -403,6 +531,10 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
> >  {
> >  	struct iommufd_eventq *eventq = filep->private_data;
> >  
> > +	if (eventq->obj.type == IOMMUFD_OBJ_VEVENTQ) {
> > +		atomic_set(&eventq_to_veventq(eventq)->sequence, 0);
> > +		atomic_set(&eventq_to_veventq(eventq)->num_events, 0);
> > +	}
> 
> Why? We are about to free the memory?

Ack. I thought about a re-entry of an open(). But release() does
lose the event_fd completely, and user space wouldn't be able to
open the same fd again.

> > +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_veventq_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_veventq *veventq;
> > +	struct iommufd_viommu *viommu;
> > +	int fdno;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
> > +		return -EOPNOTSUPP;
> > +	if (!cmd->veventq_depth)
> > +		return -EINVAL;
> 
> Check __reserved for 0 too

Kevin is suggesting a 32-bit flag field, so I think we can drop
the __reserved in that case.

Thanks
Nicolin

