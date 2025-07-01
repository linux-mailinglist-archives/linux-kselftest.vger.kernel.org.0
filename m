Return-Path: <linux-kselftest+bounces-36216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848CAF04BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F74E1D7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D582EAD18;
	Tue,  1 Jul 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssITlE/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5535283121;
	Tue,  1 Jul 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401418; cv=fail; b=Qhjk1lFAc3M2EOKz6L0s8+CjYi+2S/aOeWcz+2G+rplMfIeVUnItG2qs6ENtGfyuz1UnL3xUcO5Rfu+drbs7ia07rE+lRqNwIohxIRef6hmiNH7f9CIfFaTHUFdM5H+gJ7jgE4Skk4HOWgkcV7VFUKFuy3f50d0K4RsLNoKf6cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401418; c=relaxed/simple;
	bh=hgM+4MMkE8wb7PerbH+Fyhie2PA4nE4F7WV22FW8bHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3eVvtaoFOp6Glw2DZlRM4W0pl3Bff1pKTKa5KHyXsNnBOqznYGqgs8NV9AEWavFJbYDYSz6kWoJtITGjNol60BB4cBD+E0FVGhQ6K18eIHJTIO+EZTdHpXUjTWc5dMZfpZZmLkj0A8IGm9e4gf3S+FJ1LYwvW+40Zew7TrzDAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssITlE/k; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6tJJzOOhJ2K5XJxosnEoVWKkl1gQ+TeRiNjWgMV/64zrITyUySYVZuxXxxhLHYPiwtzg251P9TTVafyk7fIAVlJUzZRs9j48DCFX/JSKD72hoDXamht0CwwzyRG6Htgu/IUx9VgFjxkmEBmZlIwyNl2It985rD6GT0zeN1lNcc4YCYxMVGeUeomjAfU7Y9xSSnPJONu4By8i5btI35nkhskRQhA/yind4If2p8gkaMRvZUmKmBRTjcGNoBWEM5KYDP5POn0gFXPuduoWfC3iVwk69xgbSrIeFBYB0xxo1gW0FcF2lEbOvOFuVgTgVaErEb8yAc9R3NC+kkVmtJKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qO5/1SJP7lNYtjHq8uPXjUK8SHtHrbCeu+WDZzUqo0=;
 b=dy7WnHmzhzE8DK0N31EUdqkbpy9dWXB55IRL1poJt/b0dg49OYfZZwv1MysbUkxmQanO3/Yp0gRY8vYaWZGqzPae7v9LvcREnvYmU2q6C0ei+Wcsqlv6hMt8xp7KW94QhUfOKw+e3KH7nDOARwt5uc5WySPknWnT6fVnf/0rbRs9zrpFbeVHU57mGVzae4oDWA+cI5v02HoMfzggz/qR2JsoXKASDyP9LQoifN2KagkgRQXMsOXXm/Utl/7tiPPbeqZ7rrBkQcaE5q4YYsfEKkSVLDXkZ5EEvONWZxJ2Ajq6F0TeJebifl/llq40SWDhK+anu3IN0vlheWmspqk+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qO5/1SJP7lNYtjHq8uPXjUK8SHtHrbCeu+WDZzUqo0=;
 b=ssITlE/kgXgpAxg5GHT/8cSSMBL5Ef8FNftt3SJ7CHLdszIfH2TkuvxK6M/WBGpItPnWiYpYoRF4E9hXFqXyTqdG+pQOqlkmK5Mdo3EBHZHRR3HzqdANiemnCajkMHbge+bEK3qTZeHMQ/Twhbwy4qY+PRIjh/vLjERHmf2jZ7lX1TGBNxxBTfIW0C8nCfeTaWb1eXK7doYp3pCor3PWG+1h2jIPVm7gMjx/En5K8wO6aHwTYl9Ams5jeLHkFcy98qNa4ffjMV89Z0ti9EWXW7Lw15wN6LLSk1SwR2pDJAgp6JD8jCvXg9vF9wHp0uRUPLFola+W95bmaOYiWHlF+A==
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 20:23:30 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::e8) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 20:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 20:23:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 13:23:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Jul 2025 13:23:19 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 13:23:18 -0700
Date: Tue, 1 Jul 2025 13:23:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGQ_F7Qx3scbbA-J@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e4dfab-5a7f-4ce6-901d-08ddb8dd24df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZqgsbinswoNfhGtkSurTtK9Ln5Ys7Wi5x3dJ6dz5sqoT13QCAgl9/NFRoVcK?=
 =?us-ascii?Q?59sjAp5NmXGkUTdb1Quj8DDNaO/1quZxDBJL5lSrRL1/vOKhYISckukr4F4f?=
 =?us-ascii?Q?iZni+kEqvz+VvGJKRc0JkDGZfns310JwUZeB7v2wWr+zbzKBvXFJ0C0nw/g1?=
 =?us-ascii?Q?VdpJIPZKCg8fzpESp1hl0uOywH/pvV0Q8mMnjNi1MD2/nmWb2/+5M8rUlRaC?=
 =?us-ascii?Q?ymJTKeHyNk9/D816ixYoldGolzFwwdDjAH4VkMTd4cUQD3/DeIz+2YgC0phb?=
 =?us-ascii?Q?9bjH22qkL7A7VlmoZrCTC8rUb6ZGhj+PBAztU1uHTsO3sF/b+j77EfaLhR8J?=
 =?us-ascii?Q?8XvUI8iCVlEue0b5FKeWG6ZFwFk7AotUytVT4U0h7VAdIlw85ARWMlPMkv7l?=
 =?us-ascii?Q?+GB+sXVCKI6O45o56n3dHO8qQdPEFjdwJh+qDVfAP2KsAzAPdjpGi0RuTagx?=
 =?us-ascii?Q?Ut0bVeYviOjTv9ikk5LDFGT2dyN8zEszQHhHrJG7EJFWQWK+PPeK39+jtJCu?=
 =?us-ascii?Q?iO9UL4StWz71xywlu0K/7jfHKgj2tVaOAwLGVlYNAmYx5uoKhFE28C/Nz9jF?=
 =?us-ascii?Q?bGrmlr8OfMvjNn6k2OjeL/eT1iESBRxxmjiDWXc3yJgAZ36hK+jG23phclGJ?=
 =?us-ascii?Q?5cHT0UlmcV/MgFsxVzs7uR8r0BdEtwl9rwj/mW0tv0v8PK552WmDebAw1b7r?=
 =?us-ascii?Q?waTBVxErMq4QdPEpXp2mJw6ovHJjOVbQ38HGfqciB51RxhWmBtzsfE8kVCt8?=
 =?us-ascii?Q?zlDuvsCTheQsUC6kXQAywW/D6oxqojev+nWqH1JBysulXQ+fvhV2rvMnVHCs?=
 =?us-ascii?Q?SuGX4yMuxkfv0Q8YBnxZdFHoOtkE6DCCHIcIR9yShCqPFnvPzdQ9Wwe+nWXP?=
 =?us-ascii?Q?IoArYBQawZV60nd8rNv2JfZMkPJKybiiRdHMPkZm/Wgc2sMgTRfUNAJPCJfJ?=
 =?us-ascii?Q?MT3QOYy+eWBJ/m79sKcVsJmHLPWWfNLWmWyoU0N/DbT6XFw+IS4OsqPWTKu9?=
 =?us-ascii?Q?zhHZKGvQa0zjxO5Z0xiOBC9ptXoU208pkowuOpB4KAogmPc+OW8PbMthouDm?=
 =?us-ascii?Q?/xg2EgzPgO1wgiZ75gEeytMvsbjA6XjpreUsy9Lr3ncDIjXYUX69YahoWqfS?=
 =?us-ascii?Q?hBHN4+qEJgd0PctU3Xv+/ggpdn4q/YkdfJG+ONhpVCEoa2raKm2KNoY4cnYA?=
 =?us-ascii?Q?qhmRB0JbCpc8LdNl0LfM7iiuGrgOFtWq3RYhzBABxqTf4r+LWvwgdwhUSRko?=
 =?us-ascii?Q?T9ljyaC6kP1YqDxHK5m8gax/picnmv07LKAGI3vQ1XYVhQrUOGsPDnegivwm?=
 =?us-ascii?Q?UuxUMRaehy6+84pRYw+4b5VG5XV/3BHxy3DRpcqzQwpEepWiuUvZmC1ta8aG?=
 =?us-ascii?Q?15AJ5SZYTGLBeNNQjAWLZ2ldBd8mhIh+d1dxOqJgAyY8K8Y5c7m8+VFnO7s+?=
 =?us-ascii?Q?J6YoarI4ztWcxm42okQpSTNuHMduHpmv0DV1Du6wBT2ROCR0SajcXdeYeLDp?=
 =?us-ascii?Q?GH/eNOLaMfrebB6MX30mOVagB5uyT0bg4pk7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:23:30.1021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e4dfab-5a7f-4ce6-901d-08ddb8dd24df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

On Tue, Jul 01, 2025 at 08:03:35PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jul 01, 2025 at 12:42:32PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 01, 2025 at 04:02:35PM +0000, Pranjal Shrivastava wrote:
> > > On Thu, Jun 26, 2025 at 12:34:58PM -0700, Nicolin Chen wrote:
> > > > +/**
> > > > + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> > > > + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> > > > + * @vintf: Parent VINTF pointer
> > > > + * @sid: Physical Stream ID
> > > > + * @idx: Replacement index in the VINTF
> > > > + */
> > > > +struct tegra241_vintf_sid {
> > > > +	struct iommufd_vdevice core;
> > > > +	struct tegra241_vintf *vintf;
> > > > +	u32 sid;
> > > > +	u8 idx;
> > > >  };
> > > 
> > > AFAIU, This seems to be a handle for sid -> vintf mapping.. it yes, then
> > > I'm not sure if "Virtual Interface Stream ID Replacement" clarifies that?
> > 
> > No. It's for vSID to pSID mappings. I had it explained in commit log:
> > 
> 
> I get that, it's for vSID -> pSID mapping which also "happens to" point
> to the vintf.. all I wanted to say was that the description is unclear..
> We could've described it as "Vintf SID map" or something, but I guess
> it's fine the way it is too.. your call.

The "replace" word is borrowed from the "SID_REPLACE" HW register.

But I think it's okay to call it just "mapping", if that makes it
clearer.

> > > > +static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> > > > +	.destroy = tegra241_cmdqv_destroy_vintf_user,
> > > > +	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
> > > > +	.cache_invalidate = arm_vsmmu_cache_invalidate,
> > > 
> > > I see that we currently use the main cmdq to issue these cache
> > > invalidations (there's a FIXME in arm_vsmmu_cache_invalidate). I was
> > > hoping for this series to change that but I'm assuming there's another
> > > series coming for that?
> > > 
> > > Meanwhile, I guess it'd be good to call that out for folks who have
> > > Grace and start trying out this feature.. I'm assuming they won't see
> > > as much perf improvement with this series alone since we're still using
> > > the main CMDQ in the upstream code?
> > 
> > VCMDQ only accelerates invalidation commands.
> > 
> 
> I get that.. but I see we're using `arm_vsmmu_cache_invalidate` here
> from arm-smmu-v3-iommufd.c which seems to issue all commands to
> smmu->cmdq as of now (the code has a FIXME as well), per the code:
> 
> 	/* FIXME always uses the main cmdq rather than trying to group by type */
>         ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
> 					  cur - last, true);
> 
> I was hoping this FIXME to be addressed in this series..

Oh, that's not related.

The main goal of this series is to route all invalidation commands
to the VCMDQ HW. And this is where Grace users can see perf gains
mentioned in the cover letter or commit log, from eliminating the
VM Exits at those most frequently used commands.

Any non-invalidation commands will just reuse what we have with the
standard SMMU nesting. And even if we did something to that FIXME,
there is no significant perf gain as it's going down the trapping
pathway, i.e. the VM Exits are always there.

> > That is for non-invalidation commands that VCMDQ doesn't support,
> > so they still have to go in the standard nesting pathway.
> > 
> > Let's add a line:
> > 	/* for non-invalidation commands use */
> 
> Umm.. I was talking about the cache_invalidate op? I think there's some
> misunderstanding here? What am I missing?

That line is exactly for cache_invalidate. All the non-invalidation
commands will be sent to he arm_vsmmu_cache_invalidate() by VMM, as
it means.

Or perhaps calling them "non-accelerated commands" would be nicer.

Thanks
Nicolin

