Return-Path: <linux-kselftest+bounces-1606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2280DB49
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704D5281E59
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7953808;
	Mon, 11 Dec 2023 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGOZaqcd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B7D8;
	Mon, 11 Dec 2023 12:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCO56p2f/hJJVt4trapfi+2mY0z5QHKgWtEDy2xHwEKB4yQzIPEjMgQWc2KAkeJ+G+BDhdZhOlu/Uj0/Wy139fkwiSkrTsYd7SKZyGgn5/tOGot90ZNFAwfnqG4ips8Y+Nnz49h7+UP00JQmhYK1AOyvmKP8XpPAmXnP/UgkOKC8fr4dYThV98x+6Y6FtkW53qUJijlbLVM1G2Nk5kQPnpdCHJnL6z/YO8ynL66WjkiYqhLW3EOE+EPFvF2C1qrmRI5+MqM2RyXkrno0Hdfvf0gOl6jEQ3sqOg3s7IrUJpZ7+bDglUkVIlbsry7bTRxTb+cjUUNEAdCb/Qa9voTp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGBcpctAsuvv1BQ2+Cx81ERhehDJ0sZrjsjKT6lX0/I=;
 b=AQ6MIpN2SWLXfpdHDzNAxBvHzTxG0or9/gy2v+BuEJbBI0gvlehZTuojAghUeLio3oUDM80ar77Q/zY7fnpevHuEGq0QUJGUpJQskGIypBFAKKllOKS9AokpN2uc5X03ELuWjwuRuI98xyA/W6NE3Bk6lhuIC9d2EV0FlwUcIoHYvlf+/3OmMLBhZOufsEhT1svbufwJIjvoGEO52Ic+iMW3SK/Gbh6+JJSV8C9CDUm2Vzi9IsPv8i8KEsj0I2DycR1DOh6m2ZDuOYN0G8uKtY8fC5JnRbfmAxpVJ4PmlanlqvRO8UZndwbRq0t6tx4NrT+Wh6pTMOE4d3ugj8b8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGBcpctAsuvv1BQ2+Cx81ERhehDJ0sZrjsjKT6lX0/I=;
 b=KGOZaqcdw9qUBjHfu7W6bEP2pZp4u5jS2P8N7vIes6CrY8G9JmOBQsbQqtzp4rDtUEitG57FnZVwniyQ3VtS3rsZS0zMgXvQxEP4cSazbZxpdZgutYfuvvMnIsMKGo45iv3yrKoVAu47CuQXE/RC8DPmIesNSnlcwMLOEbvtEiQHzdsbjI1u/4VYj78/RQoPHmekh+UZxnsOPU9Hecb95pOALtbgNKL9RKWWoLvZhLPsow7rqVW8DOZz0E+bUCizVYdpG5+ZwgyrT9Fk6ygkOiun3P2RT2+r/WQx9vauCeNOqFmGo/PNSmNSomJ++YhE6aaQsKmTh1YL8HNn6Bx7fQ==
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 20:11:44 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::f2) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 20:11:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 12:11:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 12:11:27 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 11 Dec 2023 12:11:26 -0800
Date: Mon, 11 Dec 2023 12:11:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>, <xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <ZXds7V0Dz0ycF5IR@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <77ac47d0-2ef0-41fa-86c2-091358541465@intel.com>
 <20231211132041.GE2944114@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211132041.GE2944114@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 348ab46a-cbd1-4c1f-f1bb-08dbfa85656c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DxpQIPYlNjgIeKYB7doBOlOK5N49fOpsMDYFlLcfsZK07ZlF9kGePziCQiS1tfnO/NFrGjlpdO67qQMurDKJN7wbyE1l+07rOOijTKGxcPeIU/RZYWknWlJdvSEMbjCo9Y0iJnNzopV7ac1syYkk62yAipL4L6G6b2sv1PSBoA0PsRR8JtI5/nli93pGU8NqNUa4tYkkBpRSNv8cH+ABvfuDC+lu1IvEjGVRAcBjgOXHbdR2ywDPvRnpvUCxl85AgX5/gLYnSOB0aProTHaDY7nn/Xe0qE/6m2XhLKO0O4R3nxF2K34wzSGSbjfkduIpDsGNMJ9IHrY/qsAKhl/5YMLtNiRhAEBbd3ObNT8PRBKuxLAvi+yrtoHOlIiMR8gxb0D0n2t6FxsUi4rzWnaAMLBWEVdsh9JG/NYW+Ic23kibkAGa2nIwynpFU0QVKeGhomjZUKhSCOMXcXnDKIZFhr3VkKnDbFuqFr2SuqjZWoXluIl3zCGxwZFRHYMELo9ul8ATDLO7PyZo63yjzku2Zwh3iMu+addfOkbpHV4ca4NXAbWIwKa4GD653V5/iwc2weVnThzMS8oJT0aiGsEgbUfgGbT20GJ5PoRvJoPsI5wxQMKnuCsNNJUtczKhTsFHZ+doUjCjo5OrnPj+8P9hICAQ2M/LED/nFOxzVzeOWP8/8RmOCi08tWUR50CVrSBsaWq+XsvF3bjRouG7jrG/3+7tdIhLgiR9g2H6J8klTbmmxCb+4WafAh1X/f/3nLm8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(55016003)(40480700001)(66899024)(26005)(426003)(336012)(40460700003)(82740400003)(7636003)(86362001)(356005)(47076005)(70586007)(83380400001)(70206006)(5660300002)(7416002)(36860700001)(316002)(8936002)(8676002)(6636002)(54906003)(9686003)(478600001)(4326008)(41300700001)(2906002)(33716001)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 20:11:44.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ab46a-cbd1-4c1f-f1bb-08dbfa85656c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399

On Mon, Dec 11, 2023 at 09:20:41AM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 08:35:09PM +0800, Yi Liu wrote:
> > > So.. In short.. Invalidation is a PITA. The idea is the same but
> > > annoying little details interfere with actually having a compltely
> > > common API here. IMHO the uAPI in this series is fine. It will support
> > > Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
> > > setup to allow that the target domain object can be any HWPT.
> > 
> > This HWPT is still nested domain. Is it? But it can represent a guest I/O
> > page table (VT-d), guest CD table (ARM), guest CR3 Table (AMD, it seems to
> > be a set of guest CR3 table pointers). May ARM and AMD guys keep me honest
> > here.
> 
> I was thinking ARM would not want to use a nested domain because
> really the invalidation is global to the entire nesting parent.
> 
> But, there is an issue with that - the nesting parent could be
> attached to multiple iommu instances but we only want to invalidate a
> single instance. 

I am still not sure about attaching an S2 domain to multiple
SMMUs. An S2 domain is created per SMMU, and we have such a
rejection in arm_smmu_attach_dev():
	} else if (smmu_domain->smmu != smmu)
		ret = -EINVAL;

I understand that it would be probably ideal to share the S2
iopt among the SMMUs. But in the driver the objects (domain)
holding a shared S2 iopt must be different to allocate their
own VMIDs, right?

Thanks
Nicolin

