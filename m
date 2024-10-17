Return-Path: <linux-kselftest+bounces-19992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5729A2983
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C9E280A55
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21891DF72F;
	Thu, 17 Oct 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ozGWtMcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB81DF723;
	Thu, 17 Oct 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183727; cv=fail; b=U6+AYuplI8m4Or0K5zNolRQmSS+ylE+dEBYPD/MQhIjcuDzwAtPrdehPXJ1KT/UwPZ/1MxaTU6bltwCGMIZKB8cp/QuW4wChjluX+4/H6VDu4m75u6cHjk/GZTIfpQMrgAJW/El3LaClMSPXDvErLrvbNg6tFy2Nw/ZMpxRQsfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183727; c=relaxed/simple;
	bh=ge53cTVKjGQ7lNLNmn5opQhFbvXR6jW10QKYyi9DBL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoUynN672TRj3hS0K506fCLEjMEH9EXumMPRQwWd5V2aUzzRPjpE8kmHe5p3tC3BlGGefmc7CAqKD0CyZrPVjqCOabRW6XOSTIFO2yAxqocy2hY/lOMRMzboV4kFAFe0ciDVnES5MjFdbnRwY74/DUOO7LfN/Hr/IdHtx4ESghk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ozGWtMcC; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRyroLVHcOgH1MNQO99xhwZxmhb1ktKrornnRsijhjACOszfIzN4p59YcfZsZuUp4DIJbWNnRm9mv7O9fct5ULniaDN62ncVO3AdJlr2ModriNxWxvokLjKxLQTVj4tZBOHVprhQD7EPy9etlbt+V1ceoMoXntKNqrmQzh22/5RDuuhUIoG/uiB5n27ecA7CTQFHn4iU/s4jEhnupqaoGH6UZQHD/Pr7A3eftld0FlfTNl83LA/9DA1yz/gdb0kPAK4g/g8bs+8K8vzitJF9QtgQqGGigG8b53r33cxQ8p1knbPoSJwlluWxzIj2riaT69SZ92Vy2CcB2n926oIthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7jRaz87u+3UHHkX3f2TYygRKWgQGJMXvoAs9WJFmzE=;
 b=K4dviptUS8vRCs3vokVaoDi/2yiamXu2ekY1s8OXbf4fMsvQErQGLWGYP44V0HMIysEiGVLD4N+1ZfvyYQVhtmOKYHkvste6Ke5hBFGUxSCnsx0yrUbux71/TpN9DpJEINWR8+hPv8n6Dcxo5lOLUxCHU+ZrTYhHUx1HtzdvstngL9aWGnlSu7k9Js643gHcay71mMvi2OzmwR9KYDfgjnI47c1Ru25WZz0SBtamNf/RjvNRLZHRKFyak1dvFrItJRBpv3m1WOGEvoeCQxYKx2b3LdJRYKhARkczA0Q4jiuEDCfGChyHFHQ9rzixvpE5SInYDakei0qoXpA7u7kLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7jRaz87u+3UHHkX3f2TYygRKWgQGJMXvoAs9WJFmzE=;
 b=ozGWtMcCrA7/agEguckWbBKQ0hELMa2TC0BVEpZ5uzPe4fywQksEhu4gLycDhxlXc4VbJws8H1hDzwVKv8zrEsTK6/LKgGRrbanUurH3XMtkEJqcNtFdz0Ht42iDPTK6UQRbnOn3HCrSjtsON3WwV85wbazyPfjoc1vO+6hrZaimICPZvFav6NvGkJDVgaOg3rR0Fn2K3w1xA0HEimeHChQwqUmhjkewiQ1cLWoY80IOmNuWS3CW+l5iasIdwhMJ646D+4fDF5KBP5zwRKUvqRijShNwW90nWUp8W38mHZ8QmvnaDq9wmcHnQRmQlSGvHYDkLw7+/LCE15nwuwALJQ==
Received: from BN8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:ac::43)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:48:41 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::4a) by BN8PR07CA0030.outlook.office365.com
 (2603:10b6:408:ac::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:48:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 09:48:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 09:48:26 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 09:48:25 -0700
Date: Thu, 17 Oct 2024 09:48:23 -0700
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
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <ZxE/1+Pe82Rrjd8N@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
 <20241017153749.GA3559746@nvidia.com>
 <ZxE3U+9lUXwDEBx5@Asurada-Nvidia>
 <20241017163507.GC3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017163507.GC3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa1ad08-6e81-4ee7-da49-08dceecb8e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tGXmscu3gSRKWO3iq6VIk98XpdMfvYBLf/6qlNavIhlwFbTb0A+D0qeMElcX?=
 =?us-ascii?Q?Mf9UFkVS0rXnERPsbfpriQ7alwkZGDx0kKlA+rUR3TG45oe8PFWp0lk5VwpI?=
 =?us-ascii?Q?0GSyWc5kiRiJohpRtPOUW1HNbXhUtCNaPN1kgG2KFj6xPtpLaVlJwvBmV786?=
 =?us-ascii?Q?8t86LGwVvR9liwywQ3vMqI5CtfbwK9lc7LNRWcfx5LvRG2B4jH2hM76PqoEp?=
 =?us-ascii?Q?lGUoBYIfdVAYj1sBtNGYGD4+lWEr5IDRU+1nXv+RMQYCQddIEMcZIc3zqWb6?=
 =?us-ascii?Q?+HrdTtfoabHAkutiPdqdGCtpx6m6f90MIPFSxEDkmbwXi1XE5s1/v1ULJXwH?=
 =?us-ascii?Q?2kFTYJ6dpk6upEhGK5kgGKYdMo7zH0OZV/06u2u+zQLABd8IWvaHAm1NBk5w?=
 =?us-ascii?Q?kTUPJ5BRm6TkEVjQKK1q1eAeeYCh9EObmbC0mrj/JydAjesQ4MtYfjo+mkhp?=
 =?us-ascii?Q?qHkSdO6NJO3Fbs/LZLyFG25ywZQxo2ijPA1qYtAL3VxBzBsrEU7FIS4Ui9nK?=
 =?us-ascii?Q?cNzuU25SEuTU6hWqeFd3tggu/O+R7rKHLTOj4ikX79NFOEvdNGWVjyJrUDj9?=
 =?us-ascii?Q?I5RWMh9SC/GTnRkz9q0+cEac9nPAplobbGZ3KTaNtWlJtp1ojTn0y7++9spo?=
 =?us-ascii?Q?Wz7D6dyZmplqCBenO/1omfj1k+4IC3xyYXIqol/3MYa14br/UHvXXlsiTw3q?=
 =?us-ascii?Q?lgxW1XmDD5MhZu9EvvkfN9JaBO5bU9wFtBrYUULTT4JvfkMsgMCuUbDStAq2?=
 =?us-ascii?Q?/VUAnZx1o4/xdd6imS/WlrYWsJAPkVV1zVLM0WVfXA1+48/tLlLEEcoY1+B0?=
 =?us-ascii?Q?pyFS2xJeb2Xny+pgtZZZzqiWJbg1tp6tA7zqk4UJhE7ySxkWqOmYUbYgETgJ?=
 =?us-ascii?Q?jG5JEspB5Qd+GYdQ+DvSLRWD/eR3Csa7o3k4CSO14A5CKZo2Pm4U+rW6dIMw?=
 =?us-ascii?Q?N8hoRBqs8M8VHsqjVSDvvjxPfCs4z7ORgkQNGivzGlf2RJDUZ5u9OVjNt5St?=
 =?us-ascii?Q?RjJOpbGpNd6W1HGFkdFbUtVbYR1gxNHPgQiGj4Fef5/TXNsJW94Y/uttjcQz?=
 =?us-ascii?Q?E2s/IwzebHemwBRkk8CiB+zxSnlv3U9pNwJIJ+QU1aQjnrXHCgFJFsVWJcxQ?=
 =?us-ascii?Q?/DivQGRmHGe0V3Vh4YLT2+cGZavIs8InR+7guG8XqS1Y28s/iOovkvREV53+?=
 =?us-ascii?Q?HbxtgbhS9I3e5fOWQrUgJczmMx/w1aMPa6ozWSxi/i7oxIy6mBtC3qRpRCT+?=
 =?us-ascii?Q?muoOeAizfTuPuYgiGLPtapK9vB0HsdJJwlBPxbz167P9glx8Twb+icyzryxc?=
 =?us-ascii?Q?RAGn9ATISQ6EtSdSwTG+u7F85gRAj4nP2s/TGyfGZUpEOnKll3E7pp2MScIt?=
 =?us-ascii?Q?VCyO/sY0p8wJU6G1FPoju+scoTk9+XIIJpT8cx64UQHg+tIsJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:48:40.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1ad08-6e81-4ee7-da49-08dceecb8e01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

On Thu, Oct 17, 2024 at 01:35:07PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 09:12:03AM -0700, Nicolin Chen wrote:
> 
> > > Then you can keep the pattern of _ being the allocation function of
> > > the macro
> > 
> > If I get it correctly, the change would be
> > [From]
> > level-0: iommufd_object_alloc()
> > level-1:     __iommufd_object_alloc()
> > level-2:         _iommufd_object_alloc()
> > [To]
> > level-0: iommufd_object_alloc()
> > level-1:     iommufd_object_alloc_elm()
> > level-2:         _iommufd_object_alloc()
> > 
> > i.e. change the level-1 only.
> 
> You could also call it _iommufd_object_alloc_elm() to keep the pattern
> 
> Maymbe "member" is a better word here than elm

Ack.

level-0: iommufd_object_alloc()
level-1:     _iommufd_object_alloc_member()
level-2:         _iommufd_object_alloc()

Thanks
Nicolin

