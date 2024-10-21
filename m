Return-Path: <linux-kselftest+bounces-20282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B19A6FEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C03B210D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2B1DEFC2;
	Mon, 21 Oct 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BzLn+Cvt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928978C76;
	Mon, 21 Oct 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529005; cv=fail; b=b6icCxsQx7fGQSogSY7A06NTVwoxLhWEhlONIv4u1FPBJhDx/HB/Vd3O434OT9vt/b7wrsvqCqJP33OkStLZsOOrMbnjPrh+ngWZyOh8ETI8S5o4kICE3LshqUY74L+7rSD7Okueh1yzVncEExk9efxSF9R9NfV6kKYXTb7sb1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529005; c=relaxed/simple;
	bh=DgNnELo/cr8T3SCm2ztR6X9ELEM//uXaJuxpZ6gIJTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZDBbYM2xlOgeL0j9D5OgW0NlzFS3uTn19+GoxBd91ZFRFNYdUFIt+OoFE4MxjFsgjy/TonZZPDxeqIrl+D3PH1qNs+POa2pzs7J7RpnQq9plpAAYcYy1W9g813oXrpGgm5I5QqrJkx3rLdfo9Bmun1MU0S2GV7wU195sxJj35M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BzLn+Cvt; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhOtyYHhV0wLnq01xOGHrP1EU0H3B7C81lw2In598vsJNsNov8/STZJBbdpZA9ZylMxIaOYAe7Ok4DGQ8uM3WzjAXTnzFN9WAVnOVj7j4pBDbOA3tzHwCCNJmV9jiWA3+DS5EWoxqivifGIHDCad8bcsLN99KwOyY2+RySiZZyAWhFYWFLjUPBCo+Q/v4ZPUE5JBT2U0ORQ3+cDYD6ImZAhqK/xuavKj1YfkY5jCRrLvAL2NsqpqtAH4HN56iW2gsDwjFp+3ZJ4kQVDcmqd3AwtaLkdshUAz/sOHqWa017I1PqfpJ50WpVGhqT/Crm4pQ2WMeMPUoJWRjvasKlI3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw3duh9Y1uxcJ96XzNb+YS4yqTY2Ka0NvAiNW10ShgQ=;
 b=CTzIKmQhGQYnPrLctWsB6wFmIYGWFQ9EIpg/E+0PQoVfrVThzliJMCaC4K59jnzER/SIizUQlifxDd3cQaqBdK8iOfuGUdcid5isEuzWLTc7c1dQV/rZLpHY7CEe8kUiwJ6yU7EzqPaNNH+rUhc5+7i2zvk1TRDo/VT6RgKy7k0iHg0XVElr/mB2AD/DVvXSCw0CHDB6+kouS4Qiy9S+8ZAvLLG0wdR1kx4esks02v2unQB3F6g5IPtZoiHk1FrUniqInRy2syPTYh+ddrpbe6YadMjWCUcjXLGz7ZaRwjXI1uQSI1XyVxCQjYTjFtWJKFCZlIkRLe2JyaJ0+SC/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw3duh9Y1uxcJ96XzNb+YS4yqTY2Ka0NvAiNW10ShgQ=;
 b=BzLn+CvtE58/xpQ0+5fYEjboz2WPFmB7yekutho6I2hsqOV02kbnFeIVcXx8OiDgOqjsSlARoeaCcFPissCv/yN2cnyljBMc2IR8XSuAEqMdIgVS1KtpHaX8nZyHhGt4lsre7JYUyYufeqWdK3F9689b8Ugb9qVo1n50aaNLjmb1EUaNuZpWgfaUv6H4hZYJbG8d97xudShaMdG5VpL3qAjeHnfr1CqibYhpUteeaf0ptldRFaor1gq8H2QMsOl1TD2JmtZNaU1QWDfN0EF6tvYFkIIEyu2PTDNdhY1btcoAGHOHMWk3nu3ZaFhE7HkQQPTu/mMaeDLKqSJC1CeCeA==
Received: from SA0PR11CA0130.namprd11.prod.outlook.com (2603:10b6:806:131::15)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:43:20 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::df) by SA0PR11CA0130.outlook.office365.com
 (2603:10b6:806:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 16:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 16:43:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 09:43:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 09:43:02 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 09:43:00 -0700
Date: Mon, 21 Oct 2024 09:42:59 -0700
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
Subject: Re: [PATCH v3 01/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <ZxaEk6SAuP2VeF2T@Asurada-Nvidia>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
 <20241017184556.GQ3559746@nvidia.com>
 <ZxRecZKbXd7cLOqy@Asurada-Nvidia>
 <20241021122148.GP3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021122148.GP3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fafb4e-4b6d-46fe-7e01-08dcf1ef7874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gL4XjfxgVqFVVdNJohsBA2JRK+zMYOaGsJe40UBozUCicHJbx/Y8/9PmtPM?=
 =?us-ascii?Q?nu/DkG+/+W2BXlqlQARftmyHGLoJa+Si3Su4hMOepaKr3GUNSci9fGvoneQm?=
 =?us-ascii?Q?Fw8pNHMJQ83YAc3IiQvaxfH0mpkDqv0366rlfVNBWmp195jGM6eG65brJMKC?=
 =?us-ascii?Q?8x5S7jK1YZR3ndPG8Cv9BDl3Dsr6GsIPgP0T5ZYbS+jb1/giD57Z1iD4nvRw?=
 =?us-ascii?Q?3I3tK3yAYUhUITc3uPeQuzw5rza3nhoUTrf9kwkSuGgoNPLYF3nExYBr6btq?=
 =?us-ascii?Q?x8SJJCucZPmHK5HupfF0/r8/bMjIOOiPKF40CvXf8dGWCYsdSM4uDrrtcOPQ?=
 =?us-ascii?Q?j0qCKrGW21a84YLp0ntAN9ee6dRiuAgyfvOwMMRRMbkfpQR+nTBCqpU60thg?=
 =?us-ascii?Q?Sn6UaftgRj8EBXKp/5KX3+ssNgeeJDk6ItpsXlHBAXAbfXyO6Y4Aut3OISHa?=
 =?us-ascii?Q?GTeJZ0xicYDsearH+P8jk35q290GkDYVsmw70epr0Hmo81ZTQJpggzYfggHj?=
 =?us-ascii?Q?8/wSnBYiqXFzJpCVMSLkry9ycQ9ZmNso0KZSCE4Sy4sqDB9auhGIZ+iSxHw/?=
 =?us-ascii?Q?/L8nK9av2jxGbSqI5E4BRFig0QlFERy8G7Mffi1ogEgFVKqAp8RWTuQIERDp?=
 =?us-ascii?Q?zw4dVJZqLt6+uvU2Sv3TDuKXw/4dCVY4lXVbVFGmhkmXe5gEuTuYkmLL6Rr7?=
 =?us-ascii?Q?S47uwMv3IiBaP2zsElPhbu4Lb1Ib0U0M6ZYMqCh85mAIxeXKxXTk3fLKIQOP?=
 =?us-ascii?Q?mMJ4+wONjar0/ePRfcYMYZaldb8IqVOcK1v2EMiyWfpUqKILq/p82l0e+tXJ?=
 =?us-ascii?Q?t2QD72B9rSVA6UKQ4wLR1S5pCp2lQWErPJsfneGRYn3kIBCh7nGax3njyOa7?=
 =?us-ascii?Q?8MYMXVurffcu/snJrSI2oRupX58a3gdR+iOc/Bx9KUf4OqasJiD9Zhh02XJQ?=
 =?us-ascii?Q?Aar/feCW0qNikJHdh9+qmsM9UOGFwGIaqRztXAJF+xG9hJETdvJtwSwL5eUU?=
 =?us-ascii?Q?2n+7XMyNcy1x/yTUD4hIGmIVFpXhwbgMFQlt4kEc+0Pq/mXULAdmQOccaPnw?=
 =?us-ascii?Q?nnX2guwhGNu+lL8soqLngji6uVBt9RQjQtaAcU7zk0Cf1OuyfeF25JTZb9wP?=
 =?us-ascii?Q?W1acVR8RoABNN9rXLs8/4cmEXrSlLShY0p3u6h9mivPz1HtB8xdw8CHz2dLj?=
 =?us-ascii?Q?+DnU3IsZaSQl7HyZ9FuBKdiDA8VubzNQUbYduGyOAdyRB9oPb5hiaH/K1GTh?=
 =?us-ascii?Q?JN3Lm3e8baMCuqAdCYr0PrNXNWc0IvdN0cDTYwyvpktqXQqLhjcMmt/qMq33?=
 =?us-ascii?Q?fOSSsL4CJaCZ8+BS4O0n4OsWl5rDuyYVgTmliuxTQE+eXC+120D31jvjmiW2?=
 =?us-ascii?Q?6+Y02NWLnOcM2R7kb55iuZTGhAsZeUcsF1IjvA7PUNfP7cs9FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:43:19.8427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fafb4e-4b6d-46fe-7e01-08dcf1ef7874
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

On Mon, Oct 21, 2024 at 09:21:48AM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 19, 2024 at 06:35:45PM -0700, Nicolin Chen wrote:
> > On Thu, Oct 17, 2024 at 03:45:56PM -0300, Jason Gunthorpe wrote:
> > > > +struct iommufd_vdevice *
> > > > +__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
> > > > +{
> > > > +	struct iommufd_object *obj;
> > > > +
> > > > +	if (WARN_ON(size < sizeof(struct iommufd_vdevice)))
> > > > +		return ERR_PTR(-EINVAL);
> > > > +	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VDEVICE);
> > > > +	if (IS_ERR(obj))
> > > > +		return ERR_CAST(obj);
> > > > +	return container_of(obj, struct iommufd_vdevice, obj);
> > > > +}
> > > 
> > > Like for the viommu this can all just be folded into the #define
> > 
> > It seems that we have to keep two small functions as followings,
> > unless we want to expose the enum iommufd_object_type.
> 
> I'd probably expose the enum along with the struct..

OK. Let's do that.

Nicolin

