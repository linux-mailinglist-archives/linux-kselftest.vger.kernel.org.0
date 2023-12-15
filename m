Return-Path: <linux-kselftest+bounces-1999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59A8140AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 04:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CA5B2205A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DD5382;
	Fri, 15 Dec 2023 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKLyUDij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96894CA64;
	Fri, 15 Dec 2023 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qee+1FP2EB7mtT9cV2yyH1Zqb3jCmoxpfj7UKyJxWj9pyBb7KPZS7ZrP3u6F4wwJ5uKO1Aqj2Wr2ZHJDtLo59b/xVupBLWo34JiSVQ5inhyIwG/pEZStjQKd5kVhQCE177U+JHhv+0Rtzbir+YqHfcms/B8FmJc69h+pW/NEId5aeKfae6CK/cwsBZXVnggJI2MzHbjVFakmkQVH6ESzgnEn9jTj5chDVelHEsbMGYEjt6Pd13IkzhManC7eEYit6Z+Qozvn2CtDYd21/Hlgg/WmMItywzTDOh0JiUlrOvTPBIOF6i/b/jtIT3hbWRMQ8lWi3PzlnC6W+quCXfcwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyjGi4ObX3NHk3lO21RwvEoSmrWt5eea14/t2U46MXs=;
 b=hSeZWihqH39xnUKk/6D7AVpHqIQ8X/yls/Jub+PlbwI0ARYTdlxu/AaoZ8utc1EQisijosdpW1G2lMnOp6l54unYEcdJGPxTAqTV6eWW0DXwv2rAdJfyg2g7s+Bk9M45otNDUKbowMcB7DOIu3hHUjF6rcDPgKgd3cWwMCCSzm9864xeZL1FREDhAfiSOJCWL1eE8OLsIO69f8cft2RzLGxKWfop2K2zobAgWRvCdNiFPTmr50ZnxE8B7jTBEBt+qcemsaXflgdeWe4e6P1bvZp1cFZM3gM99BpJQg9vBG0aBWWxkNkrCSQB3+5dyJgp+83pmBTCCzdEPiIltYEldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyjGi4ObX3NHk3lO21RwvEoSmrWt5eea14/t2U46MXs=;
 b=nKLyUDijfKFotkXeEm1HViwoayXMAEeSTKiUCCmn88kLbFncXPtFXnpS30A4i49yW7jJjarvcpH4JNknyDicwZPcFcn8G0BkiSyH8eVYPsnDeC7/MHbYP12WUTa+J4ejyVVJs5up0gsCYqMZrPKAG5aPKQPrbkWzWf9XWYdAVDtiRz6ULYFQKmUR1m20sGPCppdEhLyeKWJ3cZO83a2adgTFvhpATHwDjLkfTihs46u0nIPLzSlI6KXAf31u/zwVrkJxPdW0kIp3DFLce9/TyDl2005ntMOKk3vDNJgY1Nf8M8BFlpcAMxrDrG2BOuZQxz60rdGyXB0a9xGiW96Bww==
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 03:33:04 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::5d) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.12 via Frontend
 Transport; Fri, 15 Dec 2023 03:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 03:33:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 19:32:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 19:32:44 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Dec 2023 19:32:42 -0800
Date: Thu, 14 Dec 2023 19:32:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 925208fa-dd8e-40c7-8976-08dbfd1e8bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bQiBqpVEMDfqgBQA3oQe4+QEOKDex625gksc/7UPBpdtfEUgNPMwU/iQUOaVcpL2RehMfghgSJD+jVynt53JTEuWc1wZKNHxfTHYUODAtnycZnmuO10v959l8AEdCkAfoCB/NYvf0JJONByYFKSjjxl3VgVsvmnffyPppRt4iD2raJFGiifC2jpK/WcDrboxAEsJxakSLTXPLPBYB5cU0Hr3p2q4AlQiqeUPqS+Gqz82c5lIoW3vV6WfE0tUJMAnqzrisNNJU09SvLD/FsHC3gl3+CF1buGUc4QBlk+gZ+KScaw3jkjhSS2SB7jep2XIpBaRxFdxMeQa4B+QWDCd35n1a0IfQuj/+2KlV6tqtQnAW0S34sU+nNr3evTzP7+PTIpO7I4o0tZMNz4T1e/L/9FktKCgBsYeJvH9SvxDfpXE3UEkcUn9e+m0euYnHM+GNH6DpopOVZ4jhN1x6eXQUgwLfaIhoMY0mfvijTe4nJagkaVhf00i7lUnwkLJoCeGzkCoqKWTih0o5jZSqhcS5MrpvB8imn4ithj8nB6kb4kMv5+CbCDygs5kyg1dwZ3vB6h2E+OmzJVMZFCQkVrMS3JnjdNsqY2fJLucOCzNxr0TgIJumSWRESk9Q/Yz3MULnyAVNS27pSY8CxxjHLnfMQLJ2nnBcvuCPuq7364MyoAM/GaWi7pvuQ+gihsHtgbAhFe9sQP+n8dG9oDpt1pb43tl4/+8ovLR4NbJGeX4pMygRNHZHXYSn3ZlFb8wz68
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(336012)(40460700003)(9686003)(356005)(40480700001)(83380400001)(36860700001)(7636003)(426003)(47076005)(82740400003)(55016003)(26005)(478600001)(41300700001)(70586007)(70206006)(8676002)(8936002)(54906003)(6916009)(316002)(4326008)(86362001)(33716001)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 03:33:03.8161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925208fa-dd8e-40c7-8976-08dbfd1e8bd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

On Fri, Dec 15, 2023 at 03:04:44AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, December 15, 2023 10:28 AM
> > On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Thursday, December 14, 2023 7:27 PM
> > > >
> > > > On 2023/11/17 21:18, Yi Liu wrote:> This adds the data structure for
> > > > flushing iotlb for the nested domain
> > > >
> > > > +struct iommu_hwpt_vtd_s1_invalidate {
> > > > +     __aligned_u64 addr;
> > > > +     __aligned_u64 npages;
> > > > +     __u32 flags;
> > > > +     __u32 __reserved;
> > > > +     __u32 error;
> > > > +     __u32 dev_id;
> > > > +};
> > > >
> > > > dev_id is used to report the failed device, userspace should be able to
> > map
> > > > it to a vRID, and inject it to VM as part of ITE/ICE error.

> > > and for this error reporting case what we actually require is the
> > > reverse map i.e. pRID->vRID. Not sure whether we can leverage the
> > > same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> > > and then store vRID under device_domain_info. a bit tricky on
> > > life cycle management and also incompatible with SIOV...
> >
> > One thing that I am not very clear here: since both vRID and dev_id
> > are given by the VMM, shouldn't it already know the mapping if the
> > point is to translate (pRID->)dev_id->vRID?
> >
> 
> it's true for current Qemu.
> 
> but there is plan to support Qemu accepting a fd passed by Libvirt.
> In that case Qemu even doesn't see the sysfs path hence is not
> aware of pRID. otherwise yes we could leave the translation to
> VMM instead.

I think I misread Yi's narrative: dev_id is a working approach
for VMM to convert to a vRID, while he is asking for a better
alternative :)

