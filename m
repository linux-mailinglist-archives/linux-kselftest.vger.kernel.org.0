Return-Path: <linux-kselftest+bounces-20281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A899A6FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D0E288F09
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45AB1D0164;
	Mon, 21 Oct 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NKsHe8hl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739278C76;
	Mon, 21 Oct 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528953; cv=fail; b=SkXIyjzA9yn/ozB0GULGb4T3B3gz/glEfs+odfsMZDMqNqVOljMj+uahQ102Ac278YiSxw5jArWS0YwOz3SEyqxZsgHSmSnH2KSQtmQZY2eBc2MP+vxrrEqfjdrlt3+8/rKbgPYcfJJ3HBLkP8KZwZQRLI7IFCe+uFyccR9YN0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528953; c=relaxed/simple;
	bh=+O6priFEsDBuv+3/KJOW6j6EZn8bRtP/mFxnoMXmleQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgzF9PMx5eB1zgt32PPr+cZNDCcVnrhQySZsZBH4dPn0qd6sHiAG6MZgz3uBNFXgIhf7ZJyCOGkYGtEL30EAXkquA73PoZYe8H1NYuHimtnOjNCS3Y9q0XwXrWqLBJXgYoJpZTjOFsQi83+l6qv7NdrUdk9dJnjqKhGgMMhbVRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKsHe8hl; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2cpO/ajIhsLNaGjl9EyYtsx4ncV9AL0DCB/ww/GaxGMX0G3xPXe0OiGJHjoyMCfGqp6seau7DyklAfjG/lOG9Rxn50EAEkjwRhbgCc6s6IoWbPdSKmT1T1Ewc1fqNyfmsR80lPzl9+X62PRCDHyh/VIze/T20Nd803UVAiLP5Dt3yClufDP8uyQwtv4udtEOw5Nvw+7zhAuhf9p0E1Lk1wGbJrdJXzNqPfiCFf4DTrgOMxrX+MHgRCgLQIKHU6yBuPDtMzDyWFE6Sft0FGZrLyikWwo5fDAio2vls8+dloToSA2vMhVN6R25cFdLFbKR8GKVZjPM6JycV56w9Yi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMgyLQd27prmEheW+y/EmFw+qTr9idP0UvdDCE3106w=;
 b=NoqR3vsvQG5H79xphhnJBQwd6Dzjj1HzkifXXR6+UKmY53434T+esW7bYX1U542b5Rs1jbqAuu0S//fJ+hhemqap8fNQLlF8ODXeoB8FcZgyenDLwr1HhhXPNOVFQqoc6uAp2B25MhwHch7Rstu5ioKsfQ461oxFZzASXI/kQ+xcYF9jA+LlRigqLsTsNZLNk/846GCU0iHPE25WK9X8VAleYeeZqY7Rj+Tal3fdpdE8cV1kKmKPiYKX0iCxzIgKfTjfUnga/cPH5BUssESLuvoSrlRvaQk3rxQw6EHxSAmzkVzshZWdWwQTzJmieBVeE1Y1+cEDrkEOFUYmrsLeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMgyLQd27prmEheW+y/EmFw+qTr9idP0UvdDCE3106w=;
 b=NKsHe8hlv7imcy+rQuA5hk2Yy5dNBd7a/ognhpMPDvvAy/scA2b+Z3cQ3ILQxtfeZCZDnRSX9hDnLGW3BXcCmjwtbYtNKORyByixg/DaKrekZGFggXbOHr6SCqmVqUs/pnV+LFnnRQfwF+dCDL9ksNPZLQIw6EG/w2PfbSeHGv0gF9iTw5fEA1OFBZjAkJEfiAYm7S/oFjIOkTjS6GQYYLA2zr15uct3C+8OYXdTvNGZCO9CqXIr49WOYUY7P0isOoJ/kNRlsVsWA43EjC4RsCq8nK9nLiKXwwzdywNabqWdoNTVr4QidFf013oTl6XAw27WKa4Y+hlzmoRnLEmPkQ==
Received: from SN7PR04CA0223.namprd04.prod.outlook.com (2603:10b6:806:127::18)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 21 Oct
 2024 16:42:28 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::65) by SN7PR04CA0223.outlook.office365.com
 (2603:10b6:806:127::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 16:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 16:42:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 09:42:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 09:42:10 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 09:42:08 -0700
Date: Mon, 21 Oct 2024 09:42:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/16] iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZxaEXy/nKTNC5k1M@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <df942c216c0e5d1740ba5add73375becf0713dfd.1728491532.git.nicolinc@nvidia.com>
 <20241017185230.GS3559746@nvidia.com>
 <ZxRgBq3wPy6xHUbb@Asurada-Nvidia>
 <20241021122248.GQ3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021122248.GQ3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: d3abe9ff-158d-41f4-ca7e-08dcf1ef5964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7j5wcHM8bxfyRIuFLWdRTnHvy54BUTuvCZKpV4wzomQMitwy50w4zvQ1iZKF?=
 =?us-ascii?Q?rrJukU6t9E5MtshK78RuXLT8qTMl3szGYWIK2wvgQPIrgqOFMGZgF1JDx+/e?=
 =?us-ascii?Q?wt86Bk1sO3SJ3gR+BfxL6lfqSjfE3x+CPbco15tkEKD0e22QO8EcMhm61GXk?=
 =?us-ascii?Q?K1ldpEiuEMb8W5zDMfEEQ+j3oCZ+uDjDeqGLeCg97FYvJvsaC4HCqNfI2c9f?=
 =?us-ascii?Q?d1zCCNwFK+zAo3gfK1LEre5KMcphsSRNTWtOlH/DqzpaYkjSJR/CuVvadFsa?=
 =?us-ascii?Q?ud0kCRYkWQmHM4gy4hIv0gxjmugs/dRjhBv4VQYAkJ88ytuOZDgUaocdp0yt?=
 =?us-ascii?Q?5ob704ZCiCxHLn/C3wcShITNuWnKxPN9xOKCrUd5Q6+zrCv+qSdq/VfERHug?=
 =?us-ascii?Q?y+2HBsp5w/zXTFnB90iN+HyhXRSUygTQGmgesJKC23xz7XipIpDxmvpiV7p8?=
 =?us-ascii?Q?uiybvbcPJRsZSWehf/ig0AfU32DHTexHkfHgxWY/sJw3I9xoA8V5lFZjc9Kl?=
 =?us-ascii?Q?ejunFS4ENLFlypd5khCxuR9jTgGx1ogdjtsA/JZRm4szZUOarY1t825QQPbL?=
 =?us-ascii?Q?5zFr7oOyI7/xdzsGm8VhQ/7cgEnD/vCEkdUD7BjLBMwwVpQvgdihuFkrSxMC?=
 =?us-ascii?Q?y7YYRk6dvzR3ux3BFvmdCPISwoJILVAg6PLL8XUyhoZK8zxufok62Fke8ecH?=
 =?us-ascii?Q?oY2hIVNRSXomTHIwMBlzadNZTKgzaVueyKVD20eJ8XkYWdLTwZYPeMnwEApa?=
 =?us-ascii?Q?2HEmLVmdcfG6d64CabvCmCkffzdMyzUBjD3eiGtxbId+gM5X1Uk0iSF9JrSc?=
 =?us-ascii?Q?e13NuaHpxOrD/bq6zNhNR9cUGtaV6J4zCA+jkc3hhewzHsg4wzUFUvr9SbYD?=
 =?us-ascii?Q?F7eczlAUhSfxa9lz2m4GDlIIaCxLlu5WxVgW0wCSZhOVBVeX37+/vnvM9msI?=
 =?us-ascii?Q?8pvG9lOiA8NnT9oEH5I3ZhmsXpmfl5jMARKyp/aIzZYqSjKENLl2FPefr0ER?=
 =?us-ascii?Q?83G/dX1I+o1skLETTr8PxV+OXHilc6lZLcnqjm7zxiGDLRaZcERMJuh+n6HE?=
 =?us-ascii?Q?pA7YPL44dz0qAFaKzpGjTn/OlFJhp2tDLKzibgfjgneeqmHqTI1wL2eb2ahQ?=
 =?us-ascii?Q?Mx0II73zoiPMAyJP+mN2u6pYdeGLZ6LW8MHrJk7Or1PiyHfeihMLPP3EH2c9?=
 =?us-ascii?Q?NzmzJvoc+lZQSu7/+xl7e4Hn4YavEqbN+/cO76fizR8S0GOEyp5uhywZ0Tt0?=
 =?us-ascii?Q?OF8UnK2c+KTTD8bqYH8sx0ZbZUmNkmkroOiR/R+EMduK7CS09Q12Ni7mKk+N?=
 =?us-ascii?Q?wpKA3q0K5kH5dEvtAYjS09Fqj2MnfYlbq+ysQH9YGBKtPE0tX4yoB0J8JssA?=
 =?us-ascii?Q?PWjArDYOoxC30xD31gwSI0DMF/5FobYhV18mDyS/x8F1XkaJDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:42:27.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3abe9ff-158d-41f4-ca7e-08dcf1ef5964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

On Mon, Oct 21, 2024 at 09:22:48AM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 19, 2024 at 06:42:30PM -0700, Nicolin Chen wrote:
> > > But be mindful of this abort, it doesn't want to be inside the lock if
> > > it also gets the lock.. fail_nth should be updated to cover these new
> > > ioctls to look for tricky things like that
> > 
> > I added an abort() beside destroy():
> > 
> > +void iommufd_vdevice_abort(struct iommufd_object *obj)
> > +{
> > +       struct iommufd_vdevice *old, *vdev =
> > +               container_of(obj, struct iommufd_vdevice, obj);
> > +       struct iommufd_viommu *viommu = vdev->viommu;
> > +       struct iommufd_device *idev = vdev->idev;
> > +
> > +       lockdep_assert_not_held(&idev->igroup->lock);
> 
> ???

Oops. That's a typo from auto-completion.

> > +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > +{
> > +       struct iommufd_vdevice *vdev =
> > +               container_of(obj, struct iommufd_vdevice, obj);
> > +
> > +       mutex_lock(&vdev->idev->igroup->lock);
> > +       iommufd_vdevice_abort(obj);
> 
> When we get it here??

LOCKDEP wasn't enabled when I tested it.. Just fixed and retested.

Thanks
Nicolin

