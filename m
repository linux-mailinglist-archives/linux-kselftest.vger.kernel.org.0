Return-Path: <linux-kselftest+bounces-362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588477F2530
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 06:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658591C21569
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 05:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAF18640;
	Tue, 21 Nov 2023 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/umE7bD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116CE7;
	Mon, 20 Nov 2023 21:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gco2SCAinM81UXIcv7w21GwaILgYdkOY1M+9cyKoBVY02ub1tY+TSs19Lm/lD9t6OfisMiNEvyBYQn9w13rfra+lBZIAdfOpYP95oKr2cJ3YbHhiFkzqvaGiV8aCKbFBnbyJjFKxSOI9l1GyY3Wh/Tmze75N0hykoSKbD/klmxTfS6FL6mpoLfLrSfaaK8eCwCKgdFppdRF0zQGY7/fIKPHIBHa8KcjQ+V9xliTTwAbgR9ljAZVTh1z4M+IV7ANpUdmoKTEBAiepOyzEGOkWlLZDCCtP7s7CYJqmPbYbhxFwi3Smv/F6QfsK19KrnzHSuzKme96KDZQ/E6TtvPMJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpOeTLBcVDUWcX260GzEA8SaSYwb29ivbwUwdBVrVyg=;
 b=WYK5ZdhXunY7WvwJctrWfaDtq5plqjL2FcUtoFGhRe3VbIFjZinS0ldFk5g+gBVraVVLPlH9XJZ0DA7D1ajE1wKx4hs3De2f4cC627hbqED+Af+2QCxqT2TpOKTgyFIBlViXx0L9ztrVYxorR55MK/UtqtiCg18kBcqJroP/03FOQ0I4KyAlVZozo59dJNoXe1rgZpIW01BFb6J/FRp76faw18HjFV8FEmmOlI3B9krrZPeuJLRrDd0lFnFPmxN5TuzZf83zv9czM7UVbAHoqVL2IeLwY50fbxoXEVXbC2YAm7OrrkR0aw8RTccQY84cxreoHAzvi4s6vhhKVsSs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpOeTLBcVDUWcX260GzEA8SaSYwb29ivbwUwdBVrVyg=;
 b=B/umE7bDnYxuHDbtogkjoJQ61P8vPWi20v2z+per8wErlxVFua+x6wILsl6UH1jQwk1wAn++tg6rGfH2WPWi2Hp9NnHhelOneSmCEvbLX3MnNN4CbXeVY/LdPENkUz5JPxOzyidO4y/Ka/+6A9fxkNZh7V3NzyM2v5Ki+akm1io7hY8Kv/upwl21d/b+sjszfDZgNIyn/KFkpDjdw7VAwTcg/ThKccAcLwMJXjFeWlbVYuEwEaOnetnrIwwKTHbxGPYKLPMr13UC/uPHfP6DWonIkenlWG/2uGpheNqCgDq/tM/5OSshzfFaqdFFQ7H+Zqv5aJKca4UnF7uG95evWQ==
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 05:19:41 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::cc) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 05:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 05:19:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 21:19:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 21:19:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 20 Nov 2023 21:19:16 -0800
Date: Mon, 20 Nov 2023 21:19:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZVw90r3/dvgMg94Z@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <e36e856a-8d4c-4cc2-a5db-cf00673a9bf7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e36e856a-8d4c-4cc2-a5db-cf00673a9bf7@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4478b0-0cda-430e-2172-08dbea5176b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zg+vGu/OjFcctWskR2hbxhnsMnDcJAL6S/qZQ2gP4YSIKaldikndJbrXweoIdIPi5C02geK3EPW08t9FaS+GciF2uO+wDrp+XOL4BIh9zwiQtyqnPapcPSnLIk4wK9XT/pPVy6WeRqoMWoE5bj3nK5oZNPKpGXkGkC+2Idm76Zr7hwEn6GoB3kfeHRzPRteaN2aIDbKv0UHKJzDdN9BkWNRXjojibLR7W1XTVtRupks4/SiMVT/BLP2Ug3C+QrpwyqId2Rn8iYUmRVSuJOmqA+MCiB8QvddL2Yu3JHEYEA5so/WMb7GHXjdzWkJVPqT/h2whjtrsKDYC4/qUO3s0RO2qdshHzFSKRzUEyTclOsIyKwj+AxwoUaV3DtpbYnYInuTgOrchZPcxwSRGEZvZiS6zoBJ7jxLesRQtipuaV3QaMveotHKyS2JBPcsRgeOrr/ejQMxtGaj7b6gNNdDj8iIBKCzzXMkSK07K+s+dICc/zaVGwaC7TV3pAYvetbRANCS/rAYjcGsU3e/K34M+8w30CAFm++UiR0Gbp/Z926fPQ9sXqkWBU9jXRItE4whI6xPduh62J/Y7Koutdfv7NVVULrwumANF+Ao5Ct6iAquaxOH7QSyYRcCbOrFpnlGOlmQHlNVObGevZ4BrKKkc2S9SvtQ2/EuGrq00jxsUapwFOQas9510NflzV+MYzVJG7N4XoEb8BOK4wVKroDFV8Iir2MN1N2bMoOJwEAfWxtroEAFw8en8YSb2gHVTIylO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(9686003)(55016003)(83380400001)(356005)(40480700001)(53546011)(54906003)(40460700003)(26005)(70206006)(70586007)(316002)(6916009)(426003)(336012)(36860700001)(33716001)(47076005)(82740400003)(86362001)(2906002)(7636003)(41300700001)(5660300002)(7416002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:19:40.5530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4478b0-0cda-430e-2172-08dbea5176b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

On Tue, Nov 21, 2023 at 01:02:49PM +0800, Baolu Lu wrote:
> On 11/17/23 9:07 PM, Yi Liu wrote:
> > In nested translation, the stage-1 page table is user-managed but cached
> > by the IOMMU hardware, so an update on present page table entries in the
> > stage-1 page table should be followed with a cache invalidation.
> > 
> > Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
> > It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
> > support multiple invalidation requests in one ioctl.
> > 
> > Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
> > since all nested domains need that.
> > 
> > Co-developed-by: Nicolin Chen<nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++++++++
> >   drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
> >   drivers/iommu/iommufd/main.c            |  3 +++
> >   include/uapi/linux/iommufd.h            | 35 +++++++++++++++++++++++++
> >   4 files changed, 82 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index 2abbeafdbd22..367459d92f69 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> >               rc = -EINVAL;
> >               goto out_abort;
> >       }
> > +     /* Driver is buggy by missing cache_invalidate_user in domain_ops */
> > +     if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> > +             rc = -EINVAL;
> > +             goto out_abort;
> > +     }
> >       return hwpt_nested;
> 
> The WARN message here may cause kernel regression when users bisect
> issues. Till this patch, there are no drivers support the
> cache_invalidation_user callback yet.

Ah, this is an unintended consequence from our uAPI bisect to
merge the nesting alloc first...

Would removing the WARN_ON_ONCE be okay? Although having this
WARN is actually the point here...

Thanks
Nic

