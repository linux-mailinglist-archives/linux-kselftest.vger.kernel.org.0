Return-Path: <linux-kselftest+bounces-990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41480161F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6351C20F70
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EE619BF;
	Fri,  1 Dec 2023 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fb9CYqhq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD2D50;
	Fri,  1 Dec 2023 14:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+9HYH1a1fzDPWj2VAXf8EqVNJs4WZLJh3IIYDkgfxB5VmdrgOY0Em6LDEFIGQxo4PTkfp824RQ7XkWfiQJrmyrrqydGL1dz4MUyVCGNJoHhdSDIQd/SVF9m8wDXcPrsHH9huixKQ0Fz4ZHN7YlD+wWZkZAmwbR1fr+5bfcDeej0nA3Wc/0mtEFepM2RE3OOxZPEd1h3CSqNSJGVnHduw+AAMU6pcdvl/d7q0R5dQG9PyhMuuf0uUPIvZ9+v7y96yaJa3qXEkttXp4s/F5UtGTP+bUbpRE7kafWRvz9LOia5eHoLP/zRuHUcjkesm4ry61NyWmnd3+eCf92mIx5u2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwG7RcHNJ1WfDOIkSnUPw3ww+CJToBb4NyyfEGM0FIY=;
 b=gxgiVyouyRoeEoncqNSCiXi4cFS73YwAUA/OLLKOdi/SLe1I7scKc2CvqfVKi+tg4ie0lDmGhLo5ryc/TTX42DRStQmcfwXaISIXvPl/WP3fQWV7/ZKnaShSTzQKL1iYXyQj5PayzH/0uO1z9aYvA+LQUV9t35jvZIFZP6H/BWKXKGIaWpm0OsGj0ccG1hqYhcB1ILAM+i9GEqNqBCl0nb29SS64rAcnCjomTKPA0S1rFvzYRCU3MroEjGs+yceGvVzv3n3yXLHDoUEVZQc178MuGsEjOg/G15FyXQMbHSjEzuBLieuSMJ9fLIQBF57L1SbWvs41EzWY39EljhhMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwG7RcHNJ1WfDOIkSnUPw3ww+CJToBb4NyyfEGM0FIY=;
 b=Fb9CYqhqIu4qbqVX90QmcK3p46bNsFXzbhVz4lrSkSTJfLqv6PxPgvU9FOGNqpCIgV68zF4krDj89W85t+8EFMOXtDGNn0TTuaC0onANIuGOAjX0DRpXZOTGP+Tp8175tXprG8ejXhhiebT32hOA27L0Fsa2XwcShNdoUSvI4alUxjVHvabTQycZIdIP93NGgjQycuztmdzGN9BWy8opZCoUQJWnzLBsMM6q9jdxEQkiv9kZ+tepXZklf+xo7hZ1sNAeSQ5+cpQ+dCURBE5pxJr6aV4ZnJTYzFVuUCTXy1lLljhm96X+k2NbIzu44yc/n2o1Mo5kc4FpZMPtu2DTUw==
Received: from BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::27)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 22:12:53 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d7) by BL1P223CA0022.outlook.office365.com
 (2603:10b6:208:2c4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 22:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 22:12:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 14:12:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 14:12:31 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 1 Dec 2023 14:12:29 -0800
Date: Fri, 1 Dec 2023 14:12:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZWpaTD9dVge+suyv@Asurada-Nvidia>
References: <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
 <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
 <20231201204340.GA1493156@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201204340.GA1493156@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7795332a-641a-45b8-230f-08dbf2baa9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7chh8agSdNuTSQy1Ys74nq7R2zKWIGtfuTMCdCPEqz5fshSfyZXOxkaIzDwU8Sw4e/Cn3PWwbfaSK5CuJCvzWcDjwTNG1BUMqucl2uLnq/kriBe8MM4e0Im5wOrPndUXoLWoW3jV077AEuYqqGXGS14hJagWKvLxaZO7Mkx8LVHyGexMUc8Y/MYVjD90NqXXod36p+rZDdgG4KRAcoiw+6QTCObUbVXkyTxbjSt50f5/CqkNLd9Uj71fNTSB5LKYHozOAdapgyEVZklMhbskoIlrhOIAVls52kjEUGPBYzRJdSPy6ABGSIM23qes4nUXz33JwrQJapLKImZTw2HIhmPd5IJvJztABzYdtehWZx7pZ4twgs6xfODW1HTT4w1vEjfpD9Th7vxTalHcUozhuInb8dXTgM1DQajFMzdm5QZ/PvoIzrLpsvHubGEaAhCcQsHivjZeLxZGMpirM7afRJ7P0KmnfbZ+4+juYIIRDAtvlNsTcuMcVJkL+7hRmQTs82fxoElxHUjx9UpgEvpjp9ViWgWAaA//ANvey75f4KxLsNd8XAdHVi9wp1Ww7bvWuelRp6fKR/+PztEn66vWoIBmNRvrqo/EzQRHrbtHV50dhqFCtYjBo7UR0ybZK8I/+8pfEABHzehKO7Lai8QPkK9ORt+36uI/oCGf+4ip6iYFodzeGIdwUrC6qA4C6H4DT1z/hHzXriycliSSOxO1aUMMZRaASy/WNKuhk8mJmUM70YHf4kasdU/neFDk1WcXIO3Yu1EndkFtcGE5m05k/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(26005)(33716001)(40480700001)(55016003)(40460700003)(5660300002)(36860700001)(47076005)(356005)(82740400003)(2906002)(83380400001)(336012)(426003)(9686003)(7636003)(7416002)(54906003)(66899024)(41300700001)(70586007)(478600001)(4326008)(6636002)(86362001)(6862004)(8936002)(8676002)(70206006)(316002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:12:52.7264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7795332a-641a-45b8-230f-08dbf2baa9c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096

On Fri, Dec 01, 2023 at 04:43:40PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 01, 2023 at 11:58:07AM -0800, Nicolin Chen wrote:
> > > It seems there is not a simple way to realize this error back to
> > > userspace since we can't block the global command queue and we proceed
> > > to complete commands that the real HW would not have completed.
> > > 
> > > To actually emulate this the gerror handler would have to capture all
> > > the necessary registers, return them back to the thread doing
> > > invalidate_user and all of that would have to return back to userspace
> > > to go into the virtual version of all the same registers.
> > > 
> > > Yes, it can be synchronous it seems, but we don't have any
> > > infrastructure in the driver to do this.
> > >
> > > Given this is pretty niche maybe we just don't support error
> > > forwarding and simply ensure it could be added to the uapi later?
> > 
> > If arm_smmu_cmdq_issue_cmdlist in arm_smmu_cache_invalidate_user
> > fails with ETIMEOUT, we polls the CONS register to get the error
> > code. This can cover CERROR_ABT and CERROR_ATC_INV.
> 
> Why is timeout linked to these two? Or rather, it doesn't have to be
> linked like that. Any gerror is effectively synchronous because it
> halts the queue and allows SW time to inspect which command failed and
> record the gerror flags. So each and every command can get an error
> indication.
> 
> Restarting the queue is done by putting sync in there to effectively
> nop the failed command and we hope for the best and let it rip.

I see that SMMU driver only restarts the queue when dealing with
CERROR_ILL. So only CERROR_ABT or CERROR_ATC_INV would result in
-ETIMEOUT.

> > As you remarked that we can't block the global CMDQ, so we have
> > to let a real CERROR_ILL go. Yet, we can make sure commands to
> > be fully sanitized before being issued, as we should immediately
> > reject faulty commands anyway, for errors such as unsupported op
> > codes, unzero-ed reserved fields, and unlinked vSIDs. This can
> > at least largely reduce the probability of a real CERROR_ILL.
> 
> I'm more a little more concerend with ATC_INV as a malfunctioning
> device can trigger this..

How about making sure that the invalidate handler always issues
one CMD_ATC_INV at a time, so each arm_smmu_cmdq_issue_cmdlist()
call has a chance to timeout? Then, we can simply know which one
in the user array fails.

> > So, combining these two, we can still have a basic synchronous
> > way by returning an errno to the invalidate ioctl? I see Kevin
> > replied something similar too.
> 
> It isn't enough information, you don't know which gerror bits to set
> and you don't know what cons index to stick to indicate the error
> triggering command with just a simple errno.
>
> It does need to return a bunch of data to get it all right.

The array structure returns req_num to indicate the index. This
works, even if the command consumption stops in the middle:
 * @req_num: Input the number of cache invalidation requests in the array.
 *           Output the number of requests successfully handled by kernel.

So we only need an error code of CERROR_ABT/ILL/ATC_INV.

Or am I missing some point here?

> Though again, there is no driver infrastructure to do all this and it
> doesn't seem that important so maybe we can just ensure there is a
> future extension possiblity and have userspace understand an errno
> means to generate CERROR_ILL on the last command in the batch?

Yea, it certainly can be a plan.

Thanks
Nicolin

