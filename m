Return-Path: <linux-kselftest+bounces-20610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1579AF9B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C7B2181F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609ED198856;
	Fri, 25 Oct 2024 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uqmbecnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2318F2F2;
	Fri, 25 Oct 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836885; cv=fail; b=iBNIQfoRymxx3cYcgB3UslvNg3J0adKgOGFFm6UxvwomaUg9Acr3GToqQFFkZLUwGQN9nJOT7mfyCu/2l2eLzmZluzozcInTBjxj9uFIUbg31DzgVkAYE2wf24bG/fqmCaFMdxoGJ7jZffJkw2DkHJtW/M+ohBLDaNJAnlJfsvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836885; c=relaxed/simple;
	bh=07KTbyC5j9Rfaly0wHspwEAayDQi1edPRsGxagVIQQU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRzd32OA4lOIV/3sa9DUx8khaofcJ5sl2z3+cEeeaMSDM/h6S/h9Bkyc+FsaDBgcqKbpJUPu+JcPVhW/H9d0zfsLiK1bfrgcMyWyU+gSg4MBvFdE2efQnS4f0hegRG4KcDg2pQvoMCvpShBkyVqmoQJYwDWthdC5Qm4EGg5SKT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uqmbecnb; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPHzKdprzadRCEkOIfSLWRPjz/utcK1+gLwRuJNxbHqH2c3jbW997gm/lfkS9ZV5sATdKrgDUITm5WThknydPEs2gxBhVCpxrSuc+GLLAytWW0zSbNrC1e7o0gbj2wT4x4o9lAilw2SGgIyLffHO57kabA0R3+27JzF0e5O91IZxTh2G4V74z8Expu0GF/XUuijF+3t3DALwmYd/pPoL0niQAF1HgRgtwOTkUeaqBH/T222XHEsc7eTu2vRPdLAzpR4zAApiKrSO8iIUI47d3ZIZpy4Jhs4ww43FaOqZG54tIJ1Na5sUO+M3880G5S04Nj7ojDmAvF+gwb0dS9PbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgJs3UKBunQtx/oopWEMRCgJ94ciQ4Ri20yY4RfyjZM=;
 b=RXSDOQ/6ADQBhLn42pumONPl4kdipwC7QowoIDRvQ4NmL0yKwQkuaKwQcl4PVcmrvPOWLyBpcbR5siV2tJw9N4C/+KWAigFkH7QXziTjy8RulYPD38/V6jG/yrNEVgvixmUNtes99JIGQzc4mt9/PS4QrzSoAMH/KMns6zjzQGw7NI7WfdOsnSOpXrd8YDp5k39Jua563S8+CrEqrbNx2Sh8X3ip8esO47pUCBXelhHNRfotechRFzqdwJHpQ7RIfx86ImsBvPEi3bWhv/ZuBXGXPeuQIgKA67qPzzaW02OSzTzAT/6yD29QG1oJFPM6kWlmT9kwAHhcihLq8fl5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgJs3UKBunQtx/oopWEMRCgJ94ciQ4Ri20yY4RfyjZM=;
 b=UqmbecnbMSzUG5/rZUROhG615aLfj9+b4Cgktbbeh1Qm7KOr0q64Xzmk5tRvuH5uZRVj3VYC7pv4z1bto8DbknxMmi9zlFdwa27AVlVyDeK1M+Q14I+A1nv5GlEwctqd40kubOU8y/KKx0yJshYhFNInS/VxKZN5bSlAVFm5NeZoqA8Ezi7s0n2eFkBcezqEyKqSgz/VvbNMnDksI0aWhk9gvpAf4xSI6qUQBwvYThKSRK1/OpIRcpkYYV6cm2hmFwuXCzpO9AsEgJmP1a5/WzOpqrMCpS4vblFspL//mK0JgwWFhEcc2WxVnDV/vY6tbAL7I1ml+LpbrRQt4zfRQQ==
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 06:14:39 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3e) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Fri, 25 Oct 2024 06:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 06:14:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 23:14:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 23:14:24 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 23:14:22 -0700
Date: Thu, 24 Oct 2024 23:14:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <Zxs3PYVLzmRfBf+/@Asurada-Nvidia>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
 <ZxslrakslZbphayO@Asurada-Nvidia>
 <487ebe2c-718f-405c-8f20-213eab59ca0f@amd.com>
 <ZxsvofcC9xSSEMHi@Asurada-Nvidia>
 <607d019e-25b7-45b8-8c85-3829d4b53a82@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <607d019e-25b7-45b8-8c85-3829d4b53a82@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: f04b7eb8-8261-496a-6fad-08dcf4bc4efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1p+6EvOTQPpWgpehPPbaZ6nvWsrdHtMN/AftJK/A4UQpo8M8acbZfuJHSnIX?=
 =?us-ascii?Q?kddrjF9hVnYYLrvWC74i/GymgqYeJRyFTpXMCqRwdwNXpJjR4S24gjjzn2VS?=
 =?us-ascii?Q?xEzeMQA0Wkk2X6UXo0M0D8+DMpiJbg/0Aez8KcrGi4Icd7MRo54uSLmjOZ7G?=
 =?us-ascii?Q?dbuJK7n1XPhcxqZH11sdLpA5nRaVdhTL9J44cDQc7WbuOBNM6Y+wqxWnjF2A?=
 =?us-ascii?Q?GVWjWHWINzx+hZOiLRVznOV5ae8HbW/1OOM85j/3brmf98idQJx2Ukpa1xaX?=
 =?us-ascii?Q?1nZRG7GQ6qBLAWdykP4qs9oNzsB+ZOJYKOSF7xXE4NC3uBDnptZcG7QpQFN7?=
 =?us-ascii?Q?437cmzI8pRbIcXvSytqthmPnQqw6tlMpln5XYhJMshIYXF4RZQbf/FK2za/C?=
 =?us-ascii?Q?l+lOkoe3O63Zpb/qqH5pFAG+O68Dh7TgMNWodD8Lpl5aVLeTzWIw17wjDVHp?=
 =?us-ascii?Q?Gzp2EtCf4fhBGxqTwToEaFTyjfHnd35FI31GrHkG4m/mxfDEgFbKiJcNPwE1?=
 =?us-ascii?Q?ohSx3DCbewReeGWVA7ku9k/JlY5RpmsewuV6gOjUo65VJiu1+BTVpjYaTRtz?=
 =?us-ascii?Q?qJTe+ocK3FNr2R7U9A9E4fVG4LQA5i3w1MaqHcyiJXB8PEBYGKCSuAs4lv2s?=
 =?us-ascii?Q?0BuLPPiukocKlg/pgw9B/fpPYkfQ06nDksNp6IqVsz1ijy8ygdLTZMjNQeSL?=
 =?us-ascii?Q?MSF6yImrj4TaJrXdUcXHhuB/xRNj7ohxBfySheUbwhPlderxPL6LJsQYgnEG?=
 =?us-ascii?Q?u1rz4VfuS1Zu50E595ZdIn8yxR1K6KFiEYnYTP+5sS8UJ75w/qB0XEhoE6aq?=
 =?us-ascii?Q?p2Y6Fkhl/GenUV91C8Vd9idtXMAxV8IWKJ5+85P/GimnBadCzfa7WjomnIt9?=
 =?us-ascii?Q?3tF02EaBTjoa9uQN0AMDFHdzGhr9upvaVCoOXB1w/QNKc9UkioZy3a/JBJOa?=
 =?us-ascii?Q?c+iov+p05Qt1qfNEt5P0eKLSOUb+BsCMN29t/OmTxOfcIlvcmuf2oSJZ3CMe?=
 =?us-ascii?Q?hi5zoP350d5kRt64WX960lwAbyiuo7L03EjIUZ5+TgZNo927/ZAX9h1p0dxu?=
 =?us-ascii?Q?oN8RTXkEnLfIki/cXsoD3FGTP0A3HBt/VOMJLgW2S7GZ1tZ7oO4iP2ap78W9?=
 =?us-ascii?Q?yvxNoO4s0p/SiUR3tUG8TShzVL8hAlniwEko3qEhyN32XJzVZOpSRIAQZKjc?=
 =?us-ascii?Q?FLTDuSGoXLTYCKF353eI4ZOW5RCG3tqlHwvcdnAhiCzk9xNo+HFEsc1kJDfu?=
 =?us-ascii?Q?B5Ehxh3rjz8rRhDykiPtORfr+x8Rz3YBg/wGI5x0RaxUWrnzkmtPBcdha8yI?=
 =?us-ascii?Q?IXHSQT3raENPauHaKG+qPg+Ds0ZbfFAeXgNxcKjSyvAP/S2+ny1qSr5rItsD?=
 =?us-ascii?Q?dzYD1NO5KsYwkyDQrtRIFfgbt6ZPxSE+JTfVdMpqs4OemRb8tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 06:14:39.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04b7eb8-8261-496a-6fad-08dcf4bc4efd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

On Fri, Oct 25, 2024 at 04:58:33PM +1100, Alexey Kardashevskiy wrote:
> > > > > Is there any real example of a .vdevice_alloc hook, besides the
> > > > > selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
> > > > > question. I am trying to sketch something with this new machinery and
> > > > > less guessing would be nice. Thanks,
> > > > 
> > > > No, I am actually dropping that one, and moving the vdevice struct
> > > > to the private header, as there seems to be no use case:
> > > 
> > > Why keep it then?
> > 
> > We need that structure to store per-vIOMMU virtual ID. Hiding it
> > in the core only means we need to provide another vIOMMU APIs for
> > drivers to look up the ID, v.s. exposing it for drivers to access
> > directly.
> 
> Sorry I lost you here. If we need it, then there should be an example of
> .vdevice_alloc() somewhere but you say they is not one. How do you test
> this, with just selftests? :) Thanks,

A vDEVICE object will be core-allocated and core-managed, while the
vdevice_alloc is for driver-allocated purpose for which there is no
use case (at least with this series). You can check the vdev ioctl
in this version that has two pathways to allocate a vDEVICE object.

A vdev_id is used to index viommu's xarray for a driver to convert
the id to a dev pointer via a vIOMMU API. Dropping .vdevice_alloc
just means the driver only lost its direct access.

Nicolin

