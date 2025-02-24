Return-Path: <linux-kselftest+bounces-27393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B5A42F9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28A03A7C44
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8581EBFE6;
	Mon, 24 Feb 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IY+QAU9A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26BA1E3DFD;
	Mon, 24 Feb 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434238; cv=fail; b=WlDeYS++zGqfOs7TJIgu/FsSBALXImzIwfif2cjAcGzLh3WIE5Xe3hWNtcpzUJpq/WYYHrk4Vkz5L6CnO/K67E9SC3lw6TJqKYGlFhR8UzMJUs78tiheYprSJGVxFa+uaD/7b5NmiycUp7LSE1QGyfJJ64344Xbdw868793jRH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434238; c=relaxed/simple;
	bh=eWVo3/g4vPrjU2f98WpeCgdIeKAboa/AKCODd5Lcwfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl2tqsInbzG1ySbMPjNlL9vx4ey2JMD1V6oJW9iAo/bS4dNc3i6kGkQQ2a4iinkzv6mftR0fRYwRMphim5RGeaCAQxvMPEwCfUouzifaWMVFC9sq6CepQi0zea3uVxjKRLPs5TXp/IjJ4cH/nsmj7+XxoHdMkEgo/1UBp+ofWH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IY+QAU9A; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx1bVKufpbdP7YhOwVHO23vRHq5OtjpPS3hnac70/N+738n5Mao8Hh7/NMEhBC/kglgFpxDpiJiqKwx1b2nERyBowYM2NgupLvv3uwEL6igXyv56o6VKyYh2M/3syBHZuF9OCv4VxAUolL7tsddrv1aRUiJuOVaWEpLwuLw3mPeyncE4XS7t51b0incX7H+BMFzgqlrHAxmAs2LnGALRLJI14BiUYrybc10CcFB20BEBfISN5NVn0aeFDWuqmZaAwCUqy9oD82FLjNevb/DwHTVhDgmV58gJomwvzQzVH5ky1VBZoDrzHK95qRq/dnnwBHhbUERihdZvmLlTbG4Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w9wmPYJ4/zUGRKnQUg5+CSOB178spTQyF5++IXmd14=;
 b=etw5eo44ICSGsRBbQPUVXRPeCBrdCTDnjSf7zeKISYWw0RuAmVTOqHnWJuqjW1OH5a08jsIkB4/q4y6S274JZYVEXSYzVIBYarwlt21egu0IK7zJb7uz46iDewCV2hmKBCTeXzRZwAAio7m8CRZv00xOuv3l39l7xuHRR+IXusYvXAz/dhDy9IpHLf9wJu/w1J3pQ075LUb1cebPmOcn7o931wudHMBKgbxnK1L0yvVipKEOK3mvMwxwdE8+Eln017cNQtary1DzLAOOWuD8HT87WFqefFd8zjMDyupl7+nCCLHlaCEsWL4i0kuc8Mc1MrSxGha+XGEs5ZwhYoodlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w9wmPYJ4/zUGRKnQUg5+CSOB178spTQyF5++IXmd14=;
 b=IY+QAU9Af0iHHWqDKp6hFbiyud8n+GUpyygi6SKVk6sU/NLSjHxWfOv1UFOXa+KgFCdrJgcQDuAKgbWJS2huAuzLoP+19t7Gv/qfklXvpb2xWlNHx11SUZjKegm+jqPWCsb1d2Q2N7GMKIkJMWzU+n9VFg2q9w4KKSgHZPV/fT+32qJj+6cMGmQIYhef3w1IR8v42oUOmatYkv4Jq4TRBMarqpZnQ3iSgr14Y5JG61DEGHLim5I4/dty2kBms7d/IzaEWUkZx25eVEHgU8YKO0PIAzJBiAolL9yk2P+uIv5Ld7eXn0ka72KWlJphR/KknpeAoO8Xhxbj+J86msafEg==
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Mon, 24 Feb
 2025 21:57:08 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::36) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 21:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 21:57:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 13:56:49 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 13:56:48 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Feb 2025 13:56:47 -0800
Date: Mon, 24 Feb 2025 13:56:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
 <Z7zmErar4YvQSSxw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7zmErar4YvQSSxw@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 41997a08-81ab-41d2-9b33-08dd551e2e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPhQ1dW2rS1Kix9KJkv2zNfu2PpyOwTEXrnZeB8oqAo+dOwMkUWUyI3Nt9gV?=
 =?us-ascii?Q?qdwHNIn0ceh8+e3dUlJrdB3A3zOiX+TyzU3pMqM6zaXZE7w5I7LmgxoWOfjs?=
 =?us-ascii?Q?/wBnGoe44fNl8Gb0jFOjUpZ2c1MRD4tT//YCe8jZL5CtS/ALxQdmvQTCBzfR?=
 =?us-ascii?Q?nF9I8S0LPrGvve1cK9tWKoyD1W7RfVrg2TPQ42ORYorbuNS0HnIaAeFDKqD8?=
 =?us-ascii?Q?ofskMwGknFKAuUoDkoBOBWCzxSwaUPpgrFjfxqQnItoAksb9LLAogNxEkNL0?=
 =?us-ascii?Q?83R84L1JrUAzBJ3xWKh7jdLlXX4GBN6VNxnBk6ZzQqSxwFTaOOnTUf2fyvwu?=
 =?us-ascii?Q?wtlj2I1lGwgc1K8bOwGkXnd48zKN63l3jd1FEWqQVMkex2utA0hpwgt/0vBK?=
 =?us-ascii?Q?pBx7jFYpv3+flisuZi54zCIvb6zZPgaixfkwWJkvks6rfknBI43Y3h1Ls+TP?=
 =?us-ascii?Q?RcjSEEohd5L77O4ifOGKeu/NIuHfdIOeEdXxQ73BXs/0EBs7k+mq8GOVIvhr?=
 =?us-ascii?Q?bVMQ37UXArE5bEHlAZiZn/dExN7TNzDwFufcZy+ESWbmYTjq9uHGRUtS5mVT?=
 =?us-ascii?Q?Q8Tr5LXREC0JpuSAlzDXCzFwEIKiWFFr6yFdNP4KwvV+ysNQtIPvAVuXveER?=
 =?us-ascii?Q?HKb8ARXua9lcwg4HCI/tEbnRGlzPu7i+keChW2DpMiq1XVjlhIh+jYdDFgsL?=
 =?us-ascii?Q?f1n1Ka0TpbCBuH3NYbqEYfvkOBgN7AS6FxnZVDm+laVfCdWKSUsZWZ6PAm+L?=
 =?us-ascii?Q?UY8yW7Ji2mEBnTbEW1IGZQyDMKhpR+FO+cpf4GWOhMMun6DZAb8JuKSyAh3f?=
 =?us-ascii?Q?/rRezNUuNKiRWtHUC+xHuhp76sRVhycDBFHDjWALjjzcpNVbqXzJD/omyFVr?=
 =?us-ascii?Q?QNEx1daAMSBRG2C6w0pe5hoYoMCGO4KZT6TJQzWc+oi/X70g70Ak5vv/z81x?=
 =?us-ascii?Q?ZIsXKnLq0XU2fCoVsIi2/L+8pomsny3tOG4shqYChsNgDCOv58nMZP7IMDDS?=
 =?us-ascii?Q?qe5My1yOikV5FaFnGXbVnDyJjStq0qQU08ZrJAE4v5lZmX81mB3QcDqRpwBC?=
 =?us-ascii?Q?1ie6wdAbiz6JKzbG9Cf98B7wMJffZpzn+8tnoeQUR1j+p1HUaq3gEpou+UNd?=
 =?us-ascii?Q?OfCubQZk5AtOCnRK5szcgjTb5nud3s/5tBfMXazNh0tBjoHabyvEDvsL+Kw8?=
 =?us-ascii?Q?IVfbnbeJZ8PewezRuyudZZRHGNTvh3DoD9TMj3fZZ5Tgq8GPl4Chhqnz8lC1?=
 =?us-ascii?Q?pIMFlbxM0IB4/qSqQe/wbYfZuzic0W4+HbNOwOI689ICaueL/NS9KuYhxHlO?=
 =?us-ascii?Q?rYwK+J06nMsGcjT2dK3C8PL/57GT7lz45X51186NlUk92ZGY243ZKnMD9dZk?=
 =?us-ascii?Q?ZytoO8kVoNct/mczsOYvVcWt/NeHQ/anAi36JnNScNXs+yMHdjAaJlMlhJfx?=
 =?us-ascii?Q?BqE1K26OGxcUq0XMD7A/ExxA3ODJaR6v2oWW9jQZ8RjwiXcJRN984CJ64yqC?=
 =?us-ascii?Q?NIVTnv0crdNLaO0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:57:07.3549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41997a08-81ab-41d2-9b33-08dd551e2e8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902

On Mon, Feb 24, 2025 at 09:35:14PM +0000, Pranjal Shrivastava wrote:
> On Sat, Feb 22, 2025 at 07:54:10AM -0800, Nicolin Chen wrote:
> > +int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> > +{
> > +	struct iommu_vevent_arm_smmuv3 vevt;
> > +	int i;
> > +
> > +	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
> > +
> > +	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
> > +				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
> > +	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
> > +		vevt.evt[i] = cpu_to_le64(evt[i]);
> 
> Just thinking out loud here:
> I understand the goal here is to "emulate" an IOMMU. But I'm just
> wondering if we could report struct events instead of the raw event?
> 
> For example, can't we have something like arm_smmu_event here with the
> sid changed to vsid? 
> 
> Are we taking the raw event since we want to keep the `u64 event_data[]`
> field within `struct iommufd_vevent` generic to all architectures?

The ABIs for vSMMU are defined in the HW languange, e.g. cmd, ste.
Thus, here evt in raw too.

> > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	if (event->stall) {
> > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	} else {
> > +		if (master->vmaster && !event->s2)
> > +			ret = arm_vmaster_report_event(master->vmaster, evt);
> > +		else
> > +			ret = -EFAULT; /* Unhandled events should be pinned */
> > +	}
> 
> Nit:
> I don't see the `arm_smmu_handle_event` being called elsewhere, is there
> a reason to return -EFAULT instead of -EOPNOTSUPP here?
> 
> I think the current behavior here is to return -EOPNOTSUPP if (!event->stall).
> Whereas, what we're doing here is:
> 	if (event->stall) {
> 	...
> 	/* do legacy stuff */
> 	...
> 	}
> 
> 	else {
> 		if (master->vmaster && !event->s2)
> 			arm_vmaster_report_event(vmaster, evt);
> 		else
> 			ret = -EFAULT
> 	}
> 
> 	mutex_unlock(&smmu->streams_mutex);
> 	return ret;
> 
> Thus, we end up returning -EFAULT instead of -EOPNOTSUPP in case
> event->stall == false. I agree that we aren't really checking the return
> value in the evtq_thread handler, but I'm wondering if we should ensure
> that we end up retaining the same behaviour as we have right now?

Oh, it looks like -EOPNOTSUPP should be returned here. Will fix.

Thanks
Nicolin

