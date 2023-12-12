Return-Path: <linux-kselftest+bounces-1719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A080F777
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4121A1F212C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0752771;
	Tue, 12 Dec 2023 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLXCERSK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5536D2;
	Tue, 12 Dec 2023 12:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwCEkNqsvWO0NTO7T1SltoFb6wRbj1BTv4/MQMol/MFUb8FdGLkKyGFU+HM97PcJfLI1o2h+Tq7xMtGg3FuzhFDlbn2nhEf9g3fbqpJG6bFSiIEzHWJew2pLchXE+hnG4Ej9ylJc2Be/xlUZzGRGsZyp3T3P0IM/bJzC8T1Tkh8pWviTSMKBOa/ZS37SJHdcJG/vbqj20wC5sBtF6PGxgSOFXxYlZ92YXw56af+X4S1daQjVWp7FoGOM8R84QjujfFoiwE+BSYp/EcZIhRON5yBbI0WrYslQ7DPB/7RbuIimugmf1+DpA8lzTpf/kNsquOhCDJEniTAXeXjuqYXGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYmLzQ/rFCr32uNmxfEMFI3JkjhpmAP0pNDS/HmmVaE=;
 b=eHNpIQravmLRFzXadES43W9MiDIxVhnOKZRf30zG+rR9g1fV26vkg72bRfJxyDEH0HBuJxppVYkLHgduBYq1qx2NlaVuXJlrcU65XMkPsgGf8AEUp0l7M7OuDOk6DRadGuFEiTVNIpi7gJMpMWBi1Gx6qGaZ/xJCsEFt5KKAOTQ05pKtyuH+/5b4ErVK1cnyZd1RPUSfzuNNrQY3Vxa3CimjdRkI8hIrmBJWh73L3DvLaQ/bi1jrQJvms1NIyglPPMO1jVnGI+Y05wpIWZyaUYc5GIbMPFNfRgmkllqd3d5Kn954qDcCLzUNbif1BZ820c5kHtsp+j5IOlBrMlLgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYmLzQ/rFCr32uNmxfEMFI3JkjhpmAP0pNDS/HmmVaE=;
 b=CLXCERSKGosRI/BLUvlMzzascsN6nCPytnmEGa7fnQhC3qM1M7ACergBFkOPJzYof5+Ct2+76LAFXWtI73lW6ZU+dZr7irnO9hLaTTrL8Crko5tLRj8OQheBHcfOR+ZaYIzPvyL2qRqe41oR+b6P+X4jnMvTTuEOE+lE+TFUQtX1aaBAGfE4cfiWvyHYseWiP2sXV9VuYupY4nAYIxj3YNqcUJ59ZLGZi1ShA6k64Ad5WZFMW3JJPTNNvOAVY7ktkcnf2ml9XAEaw5EiSezEv9Lebb06R+B2nWEButycdYV9+3du6t7Wjb6dikoH3afI7ORV2kHyo1ERcYXGUnWcyA==
Received: from MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 20:06:07 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::21) by MW4PR03CA0226.outlook.office365.com
 (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 20:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 20:06:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 12:05:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 12:05:44 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 12:05:42 -0800
Date: Tue, 12 Dec 2023 12:05:41 -0800
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
Message-ID: <ZXi9FaPSkHkCm679@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
 <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
 <20231212144421.GH3014157@nvidia.com>
 <ZXiw4XK/1+ZdsFV1@Asurada-Nvidia>
 <20231212192100.GP3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212192100.GP3014157@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: cc82d36a-c9df-452f-b3d5-08dbfb4dc6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t6QxDy+zjupoL7UWiD3n/UTT08lLeiurm6D7bQKEfJAxzTgzBgHdrRnZmTyP5yuHCY+PqFr6U76mYXYKbwOcrzhtcGWEAxKknbUJCaZBNK2wds2M0FAk4greLGsomz2/h6RUgFrOlUyZlktq2Up9mln2XIQ2LPxnQfQtJ89BFd6rQkUbx26Pjy7WRu1meY8uGVTHXimKSx+ggD1tH1YjY3NsIwmhtCK37nZXTpsEjAr1lSw4l3jAN+ROI1Tvl5XJA2KBLzmwQ/fihDJv83u+2nTrh3WvlH+RBdvBRrwz4paHTz50tx7wj85X7m1JXNuNu9lqHwuME/Q6Vw3Q5et+SN+rZEGX1I/22z9DV2Uo07rQQmkSL7Fucx5+UTrA99ckhrDOBijS5Fqot6Ej6rnXJDxCGD5LuMWiNv+aCg7mIiBxm2ejF1I6D1irmYq9epPxujZtaFh8NcibsP9Rsvq2dWzSAWl9V16lqiVdorjTf8HKKqtnPLS8QuC1eNIf//RAoNM7Tpja80AERYyQhbyYI4YQiTe7aqURSpPKB/SJvASZOPyl9nOB7pcO5ludVYG9JmpY6q7I/uFwSpwG5GKsULMvfJDLLoMf2fhHM5nMX/wv/5cFbg0tsix1Evr3eRDpJUnCFZwErcqIuFLZk1lV+3/kkg/OeGEQP8p3lNrxZwqxe94/ZfgGALFqv08cgKxqGS3WxNgxF3bQ0PaXjVange/RsCQ1hYCbnh0PyjSkPvS9UyGagl+ksCAqMXWe5qcd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(7416002)(33716001)(41300700001)(36860700001)(86362001)(82740400003)(9686003)(356005)(336012)(426003)(26005)(83380400001)(47076005)(478600001)(54906003)(6862004)(4326008)(5660300002)(6636002)(316002)(70586007)(8936002)(70206006)(7636003)(8676002)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:06:06.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc82d36a-c9df-452f-b3d5-08dbfb4dc6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

On Tue, Dec 12, 2023 at 03:21:00PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 11:13:37AM -0800, Nicolin Chen wrote:
> > On Tue, Dec 12, 2023 at 10:44:21AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Dec 11, 2023 at 11:30:00PM -0800, Nicolin Chen wrote:
> > > 
> > > > > > Could the structure just look like this?
> > > > > > struct iommu_dev_assign_virtual_id {
> > > > > >        __u32 size;
> > > > > >        __u32 dev_id;
> > > > > >        __u32 id_type;
> > > > > >        __u32 id;
> > > > > > };
> > > > > 
> > > > > It needs to take in the viommu_id also, and I'd make the id 64 bits
> > > > > just for good luck.
> > > > 
> > > > What is viommu_id required for in this context? I thought we
> > > > already know which SMMU instance to issue commands via dev_id?
> > > 
> > > The viommu_id would be the container that holds the xarray that maps
> > > the vRID to pRID
> > > 
> > > Logically we could have multiple mappings per iommufd as we could have
> > > multiple iommu instances working here.
> > 
> > I see. This is the object to hold a shared stage-2 HWPT/domain then.
> 
> It could be done like that, yes. I wasn't thinking about linking the
> stage two so tightly but perhaps? If we can avoid putting the hwpt
> here that might be more general.
> 
> > // iommufd_private.h
> > 
> > enum iommufd_object_type {
> > 	...
> > +	IOMMUFD_OBJ_VIOMMU,
> > 	...
> > };
> > 
> > +struct iommufd_viommu {
> > +	struct iommufd_object obj;
> > +	struct iommufd_hwpt_paging *hwpt;
> > +	struct xarray devices;
> > +};
> > 
> > struct iommufd_hwpt_paging hwpt {
> > 	...
> > +	struct list_head viommu_list;
> > 	...
> > };
> 
> I'd probably first try to go backwards and link the hwpt to the
> viommu.

I think a VM should have only one hwpt_paging object while one
or more viommu objects, so we could do only viommu->hwpt_paging
and hwpt_paging->viommu_list. How to go backwards?

> > struct iommufd_group {
> > 	...
> > +	struct iommufd_viommu *viommu; // should we attach to viommu instead of hwpt?
> > 	...
> > };
> 
> No. Attach is a statement of translation so you still attach to the HWPT.

OK. It's probably not necessary since we know which piommu the
device is behind. And we only need to link viommu and piommu,
right?

> > Question to finalize how we maps vRID-pRID in the xarray:
> > how should IOMMUFD_DEV_INVALIDATE work? The ioctl structure has
> > a dev_id and a list of commands that belongs to the device. So,
> > it forwards the struct device pointer to the driver along with
> > the commands. Then, doesn't the driver already know the pRID 
> > from the dev pointer without looking up a vRID-pRID table?
> 
> The first version of DEV_INVALIDATE should have no xarray. The
> invalidate commands are stripped of the SID and executed on the given
> dev_id period. VMM splits up the invalidate command list.

Yes. This makes sense to me. VMM knows which device to issue
an IOMMUFD_DEV_INVALIDATE from the vSID/vRID in the commands.

> The second version maybe we have the xarray, or maybe we just push the
> xarray to the eventual viommu series.

I think that I still don't get the purpose of the xarray here.
It was needed previously because a cache invalidate per hwpt
doesn't know which device. Now IOMMUFD_DEV_INVALIDATE knows.

Maybe it's related to that narrative "logically we could have
multiple mappings per iommufd" that you mentioned above. Mind
elaborating a bit?

In my mind, viommu is allocated by VMM per piommu, by detecting
the piommu_id via hw_info. In that case, viommu can only have
one unique device list. If IOMMUFD_DEV_INVALIDATE passes in the
dev_id, we don't really need a mapping of vRID-pRID in a multi-
viommu case either? In another word, VMM already has a mapping
from vRID to dev_id, so it could call the DEV_INVALIDATE ioctl
in the first place?

Thanks
Nicolin

