Return-Path: <linux-kselftest+bounces-2625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B482366E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 21:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78C5281BAC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC711D6A1;
	Wed,  3 Jan 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cudjj8zo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B91DA22;
	Wed,  3 Jan 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIO/LXh92c42RCc8sukOkjKnU8o15Fgadg57OvOI4KDoEvOsaUuU0bi5Det5Z6jOeAfQ+kZEoDewws5WjD2K1rlddhaGLSENSBv8X87trjkRVLPH4EwyGf9aE1LV/bD06BdBRWrw1xOxmsyhuE/zpqrmHDqmA9LkFJV7rq1HeSZ1em/MuvghKS5el/08qd9a969K2x6YlfC3H79Wj/hLB+BS8VMZhNrJ/WrhYkQOteRlCQ1vtdCJBVXmANy2NsLJFJQSCF8CxJuJ1o6U+k4kmJFXv4wkP7Cy8lGP3aIG0+Syv9D7CJfnf7ypbSTrThtz2AnHWX35TH3glQiTPl9vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jkzvf45R652jTNTistK6FIpzk5K5NTE1x/nlt5KJjg=;
 b=niCkWzzRyx/9G1ju/rGUeRjHWVv9bwnT8pJ9gcD8RCOZ0kbCSXv7V/RqXuF6EaKHJ0W+JW0z4LMfoOGZP24kVzc5RtOGEYFAJZXNtWD4fW166qZkVhUMk+dj5TOwT+W/rYCDB2Eu7Uad35fcVQ32goyn7sLTcfKa9pGyi/qNGcVQFHCTwW0JZNt+AMVay+IrbVyqfGraFdaIZdWH288K70K8LZQ3/XxnGEbf8ejXxSc2INSdwX83xXzwfwYzvA6a0R/mc4xtyEYmgjk90B+XLU8C1wP10MJjJDeYzfKHJK/C2GakxYdCPzfWow4EMHMOW0zGWYcqg8pSMw4/MNKcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jkzvf45R652jTNTistK6FIpzk5K5NTE1x/nlt5KJjg=;
 b=cudjj8zoOGTKywdtHbQ0ZQxegR7VOILFwtnnzRvFyqcJnSffrJCc9UauSvqv2iqPTpftiWGm1gDhdogbe3U1X8c5sE3C1Gl3hzmX5MayHu01K3RV22vlbL2PN28umV5E2Y7ynptCdrj6a9EGkbRbilR1nXkzp6fQS1K9T7Pkoh8o3Sa4ruoJ0pqobQAcZDMVAuKEkSD1duadj63w1nNT5VRpCPSt8kaFEm++9dXHmZ1sh2Ry7TNBI3wcb/Rfi/AIOs+NlfnZHf+YOo18VHDTWyx0lduaxj/3EO97DREenlTyBSnC0YTpD7sykwnaA7ORFTdGO4Wr17gP7nyFvpS6BA==
Received: from BLAPR03CA0066.namprd03.prod.outlook.com (2603:10b6:208:329::11)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 20:18:48 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::8) by BLAPR03CA0066.outlook.office365.com
 (2603:10b6:208:329::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 20:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 20:18:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 12:18:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 12:18:38 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 3 Jan 2024 12:18:37 -0800
Date: Wed, 3 Jan 2024 12:18:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZZXBGw9dJyvb/5r5@Asurada-Nvidia>
References: <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
 <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
 <20240103175202.GT50406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103175202.GT50406@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a37cf-0c68-447d-36a5-08dc0c993177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1JeP9scPdpI5yaSzg1u9k4VBF1pBKy0IMLNohTEOQPy5Cu1W/hy6BTDAM7U8oCO3vSpOseatrrOxKpNa/mZxPMTgj7UqhUm5x/m87O/g7ys4VO0l4lolK9aKN44j4y40pAiFzzOwKKuArEPwMdR+I+oFtJDfPCf34txyGDfooH3oBec3sJK0jDCg+V+4OEk1y6gD0Br7vhvDGqW/jFSQObuxLZXsFqPcX1VvbUthIBgd7LT+HnuEaMD/sukf55wNBZ43Myjj4kogZOBYYu4mKhbrYJ+ikYpWQbg9bk4WKqhAUl4N/0PEYqolqffxoUM1YJdQF92oPDnaNjsM4ZN+IU0b5I4BZEkrzwlD5zUQE57m+Bt5ahdnj4JbVH7jRyMi7JD/3OnMqDOjbfN7uNECbnPbi0U4L1N0+5CpdBM+HaDji27q3flzbJlkMvKmxJ9DV7We6OlfQvFXDW2z9X9AYqJOdLWVpzjEfVK+htLldyRx/23+Hp1Qa51EsE6QsYDIA83riJTtvw6L1TaZ9qpWj+eqdgi+jpw7Fbgi/VmkXOIXszmbxkfskxA42tXsJ9jAgvMcaLtOLHO0scauSeciqZigFhRgezk0mZH9HHLxtHS1HlwfJadiAe0s3njqAF+4kc1Drkqt1tHqBog+H9/g/sgXC9ReMmfdozexbLo/fF4FnUb6E7Ry22IHesvtSE9lY9kMZEkVxxoj+WI1MzoaxciGAOgnxW8Vn3RDbvfeokeiuePdwMSYVwxkZ1uLbD55
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(55016003)(40480700001)(40460700003)(70206006)(70586007)(336012)(9686003)(86362001)(7636003)(356005)(82740400003)(33716001)(426003)(41300700001)(47076005)(26005)(83380400001)(2906002)(5660300002)(6862004)(7416002)(4326008)(6636002)(478600001)(8676002)(8936002)(316002)(36860700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:18:47.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a37cf-0c68-447d-36a5-08dc0c993177
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

On Wed, Jan 03, 2024 at 01:52:02PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 09:06:23AM -0800, Nicolin Chen wrote:
> > On Wed, Jan 03, 2024 at 12:58:48PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 03, 2024 at 08:48:46AM -0800, Nicolin Chen wrote:
> > > > > You can pass the ctx to the invalidate op, it is already implied
> > > > > because the passed iommu_domain is linked to a single iommufd ctx.
> > > > 
> > > > The device virtual id lookup API needs something similar, yet it
> > > > likely needs a viommu pointer (or its id) instead? As the table
> > > > is attached to a viommu while an ictx can have multiple viommus,
> > > > right?
> > > 
> > > Yes, when we get to an API for that it will have to be some op
> > > 'invalidate_viommu(..)' and it can get the necessary pointers.
> > 
> > OK! I will try that first.
> > 
> > > The viommu object will have to be some driver object like the
> > > iommu_domain.
> > 
> > I drafted something like this, linking it to struct iommu_device:
> > 
> > +struct iommufd_viommu {
> > +       struct iommufd_object obj;
> > +       struct iommufd_ctx *ictx;
> > +       struct iommu_device *iommu_dev;
> > +       struct iommufd_hwpt_paging *hwpt;
> > +       /* array of struct iommufd_device, indexed by device virtual id */
> > +       struct xarray device_ids;
> > +};
> 
> The driver would have to create it and there would be some driver
> specific enclosing struct to go with it
> 
> Perhaps device_ids goes in the driver specific struct, I don't know.

+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;	/* maybe unneeded */
+
+	int vmid;
+
+	union iommu_driver_user_data {
+		struct iommu_driver_user_vtd;
+		struct iommu_driver_user_arm_smmuv3;
+		struct iommu_driver_user_amd_viommu;
+	};
+};

Then iommu_ops would need something like:
	iommu_user_alloc/free(struct iommu_device *iommu_dev,
			      union *iommu_driver_user_data, int *vmid);
	iommu_user_set/unset_dev_id(union iommu_driver_user_data,
				    struct device* dev. u32/u64 id);
	iommu_user_invalidate(union iommu_driver_user_data *iommu,
			      struct iommu_user_data_array *array);

Comments and ideas on better naming convention?

> Not sure it should have hwpt at all, probably vmid should come from
> the driver specific struct in some driver specific way

The idea having a hwpt pointer is to share the paging hwpt among
the viommu objects. I don't think it "shouldn't have", yet likely
we can avoid it depending on whether it will have some use or not
in the context.

Nicolin

