Return-Path: <linux-kselftest+bounces-19820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024879A01C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5AFB22AFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FD193072;
	Wed, 16 Oct 2024 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JMc3Pja+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F21925BF;
	Wed, 16 Oct 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061537; cv=fail; b=bwEfyF3vrQE6u6L1lzVh327yn4PSk32OOUyg3ZY0vjjxaKkn0IOfxLNSpk45e6/iUPa0V7BIGmjab2pmM8nrQcZA6uLaTjA3/KhO4kZgvczZv3f/Z4K6ay0PmgeEfdInIHxPXeAirTN/wkYNCfwoXMXmF9Mv0a7wQMF1v5jewe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061537; c=relaxed/simple;
	bh=T1acIc4gHswJWr+Uw5EVxLjNN51wmG/U0tD3MvOG7sY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYIYLNE546TV34/8fIkoGgJ9f/SuXn/GFEbLWyY2rwFaSbEzMDI8qlsXYHuGJ20AtrtNFia93kh7LJxab45ltVsGqbyvWcTWJUoIXhi+APz7Cbav2w1qB/u9HZwloc0RUu9mh78tGUoCErwFW7upf+Cbi40MnOjmgaa0g8ssylM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JMc3Pja+; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyRuwpGAxPzXrUDSYH9iJVewVmb/W2nq9iCewFOrlKKHqWYPWs6yxkN/Qr1EhZiIvddpw9ga6Rwl0ZuJe95McVvg34Pb4tAkl2vF6jUHGnbakgZlP4pT2ZfUwhjXjx40jdgHa9d0hDhhkByRT1LskNRtWtWI7I4ePaL8YnwXLOt9jsCNyat2WfNMS10wyTcYVIEyUqFF0pQV0zfN+khZXo8+davredzHWf/hiwz/5PkXBKtH0Lm8w1ZiOsblLZsUY/LzX19AJ5ue2BUfKTvYk5FDVVlBsPS9Q6wt773ezID7WXXvJW00c3ye4EIr93eCpdeU7mg7oeQXFNRDsqG5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWGny2zaGW33Xh5laCRiwMF9F4pfllBcCiDjhJegLcc=;
 b=qWxukjheyYzUbxWSJfNAa3EHr65SBdLYbOQrgIkA1fNk+eIpjToMt6M7nJm3PT7tYCt2M+aEOaWwNv4gGIl9wFoLILJkmHsIFzhEuONqeIC9sfbWnmUs1It670gbA/nsdQ/fuBOFLAhVyuFrNkW1SGVKQWsNzdQr9lEPSN3dqRqT6rqj+F7A1En/IKygiulJThfXYya1e1I/FgYMhn0n0/un3SOjBmA4AbXmBtWs8a7RPr1ytKnp4ucHaIM0FULKtxYAm4ipyhcD+HwtP8lAIiHgMT0qB1iY1TbSWlVtIvlmzfvnPvcU0yjAbUe2OaKH3+rObmyBCfIyO+gpMw3X+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWGny2zaGW33Xh5laCRiwMF9F4pfllBcCiDjhJegLcc=;
 b=JMc3Pja+LEaPBiBSXVJtkx/AtdqrHpYNcHqXQdEXd+fhEAoVepneA5lA2cYINp2SIL+YkrOMmgHJQ7ZzO81g/UXoazIwC+GKGiNWq36LaMgjfu4O1Dv4mInCCZKVUsE2lPLpiW12Eg3yLpUXxJyUJPZUCKvbfRltToX/C1BrUPLRepbFOSiA3JVkK047xoDa7LSOPdRFw/nmGqBgevB2GXWBe6V/HdoMyCiLVpPkbaqhbBA0wPyqX1tcMfk/vd51k1kumD9JZlHYOh3QNM1MsxnSmqKnhpiw7++5izpsFDTFyDXJ3FNOW/R+88JQtvbbD+rzZ45rSkuCBCxKCq9pGw==
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 06:52:12 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::56) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 06:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:52:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 23:51:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Oct 2024 23:51:59 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Oct 2024 23:51:58 -0700
Date: Tue, 15 Oct 2024 23:51:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <Zw9ijVgDlvRajsSY@Asurada-Nvidia>
References: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
 <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia>
 <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
 <Zw3M/h1KYe9MjcZK@Asurada-Nvidia>
 <Zw64C7bQicoAmAM3@Asurada-Nvidia>
 <CABQgh9Fea006HPwVTAuxk7KGh-7-YbjRhoUttVo_iACjAbr0CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9Fea006HPwVTAuxk7KGh-7-YbjRhoUttVo_iACjAbr0CQ@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 08787815-814b-4a6e-0954-08dcedaf0fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2D0OnpGvw2eGHDF8uuytpjBjeorwvO1+JJ1deX+mARDyi1PL9jH7CiOnBre1?=
 =?us-ascii?Q?JXVewTMTzrrQsjo0bO6SyuE1Cb2+9W1+pn4Idij6kJ8yckHTct6+zNde8nEv?=
 =?us-ascii?Q?EEebDw/b0G8iuKIuTox8M7wcV6hyXHNpAxKLobp5f42uO6v9CZNl/TAvs70J?=
 =?us-ascii?Q?1vCAfoTqV+2YMzcr/8k3FInna3sC76Hw2wvM7gkpbyIA0jRM42ylU1GQ2PDX?=
 =?us-ascii?Q?/W19HDuW9HgrZgpuZWwmWpOa4pfCn1NPicFb9xDGFo9nHU9N+jKL5kxHgXiv?=
 =?us-ascii?Q?/t7B14/5Fm5iE5gJfbfsR82DwYbXUZOmPDAnB6WPpTeo6AtKv5RO4eSrUXPm?=
 =?us-ascii?Q?sTeNHf08dlRMcK3j+RnYoZobftxyCX6wBcwxWU6SG2IqAeoNDIo73cZilKty?=
 =?us-ascii?Q?vGLBh+pbM39Hf2Xbd4VOXx3OF1wSm42zExEEmkuf2eIrQWaPmhaq9J2a2BYf?=
 =?us-ascii?Q?bU7+yuLE65MlMqCBiC6dP64oaBg0Lz0spGNKLSPjrNk7/zHOV04zYyyRpiwE?=
 =?us-ascii?Q?Ygjtl/SLO5201zn7JumLCPEuUnvBi02NL2Zy5NcLnLwtDlHXOW/CFIn7gxZb?=
 =?us-ascii?Q?BB4kHgIC2irVp5D/AKCeKFqIY1CtEIIqyPw4+dFn5O0MN4X6ng5x6gMIOC2L?=
 =?us-ascii?Q?PZ+Eb4oIRpPTO/sx8axXjJwJ6UJxllwAs6r2MatMUFzNAHog+HeC+CXVF6eH?=
 =?us-ascii?Q?O+vqe5BC4p3D98towevIdcFeZra0sWeHgrt4CL4ohdNgsyrJ6nIgrOmlnvLf?=
 =?us-ascii?Q?S/kxufwUoWHEMeSk2Fdw/V0Wry4WBZ3hJ82RigJAIOJpXmcdXeQsG9l/ZSnB?=
 =?us-ascii?Q?bgbQO39g0v+K4T/dNoh4KPEi0/65tk7tKiG9zTEDv8Mpy+7A8rnGzqYtKzsK?=
 =?us-ascii?Q?G0k5aNLLVArXNTEftA3JdrcpRvvFgaxJRKIFvbDy2uwNjXtpD+CSi1JNqXt9?=
 =?us-ascii?Q?dtSKWX7meYUrjOhfGpKVPsGwn4x68nmzqGRNHfbGPqYrhzOsGu+MAwxkurTf?=
 =?us-ascii?Q?Z5YF/4PY+dFPfyqzvFNXJZbu6AHKl/mHSlJJu+xxsGSh3nB8qokmdrgSjRmi?=
 =?us-ascii?Q?9fYpGaDzITtMC05RdLVU5n4knRz9GG1xz/vl7tBZ8K3qBjV0G6NjyndY2MQQ?=
 =?us-ascii?Q?JBQ2GVEq0WqFE4JP0OEbIsF9FDAaRs7UB4JWRQbzj2qvBKGJlhLVP90/1gvd?=
 =?us-ascii?Q?onuo4Chz86Y2fTze+fuilUmvg+1jxDN/6TsNtD7G0ApbfB4cQ+dgni2lb5UZ?=
 =?us-ascii?Q?ECDE0snzPDr+Tf+pq7klrucuf+w0QPgmDUasNgv5s29sh3bftMZFZWlUhx4e?=
 =?us-ascii?Q?2TC4hT4tBxuq6ChjYCDMbXlhjBzxsxRS5HO2APsrzmkc9eo+FwP1x59+uGXp?=
 =?us-ascii?Q?VsP7ubK3zHe/x/HOtaY+DhHfHDyA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:52:12.1793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08787815-814b-4a6e-0954-08dcedaf0fff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

On Wed, Oct 16, 2024 at 09:56:51AM +0800, Zhangfei Gao wrote:
> On Wed, 16 Oct 2024 at 02:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 07:01:40PM -0700, Nicolin Chen wrote:
> > > On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:
> > >
> > > > > > iommufd_device_bind
> > > > > > iommufd_device_attach
> > > > > > iommufd_vdevice_alloc_ioctl
> > > > > >
> > > > > > iommufd_device_detach
> > > > > > iommufd_device_unbind // refcount check fail
> > > > > > iommufd_vdevice_destroy ref--
> > > > >
> > > > > Things should be symmetric. As you suspected, vdevice should be
> > > > > destroyed before iommufd_device_detach.
> > > >
> > > > I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> > > > this issue?
> > > > In checking whether close fd before unbind?
> > >
> > > Oops, my bad. I will provide a fix.
> >
> > This should fix the problem:
> >
> > ---------------------------------------------------------------------
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 5fd3dd420290..13100cfea29d 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -277,6 +277,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> >   */
> >  void iommufd_device_unbind(struct iommufd_device *idev)
> >  {
> > +       mutex_lock(&idev->igroup->lock);
> > +       /* idev->vdev object should be destroyed prior, yet just in case.. */
> > +       if (idev->vdev)
> > +               iommufd_object_remove(idev->ictx, NULL, idev->vdev->obj.id, 0);
> > +       mutex_unlock(&idev->igroup->lock);
> >         iommufd_object_destroy_user(idev->ictx, &idev->obj);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> > ---------------------------------------------------------------------
> 
> Not yet
> [  574.162112] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000004
> [  574.261102] pc : iommufd_object_remove+0x7c/0x278
> [  574.265795] lr : iommufd_device_unbind+0x44/0x98
> in check

Hmm, it's kinda odd it crashes inside iommufd_object_remove().
Did you happen to change something there?

The added iommufd_object_remove() is equivalent to userspace
calling the destroy ioctl on the vDEVICE object.

Nicolin

