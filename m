Return-Path: <linux-kselftest+bounces-1646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71F80E4D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 08:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA71B1C21413
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF39168DB;
	Tue, 12 Dec 2023 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TILEy6is"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B7AB;
	Mon, 11 Dec 2023 23:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNYxG8TdojzxaXxTYNDg68kmL+5E3GXhhTAEr7X6G9NLjgBVptuuX0kVcwrA7yZPqY6jJYzg+xEO5aEKrzUojfNOjMkd22QoXoO9w2VdqA5g302Z5z8H7a6/m157wMoBcj1taeqiHMJKpgJQkbg8HFLgQT9D61DHV16rG11tIEQsOaKaOAUI6z/Yo/7VSbVXOKEK/HSDsVAoScYZrmn4+OrJthQcFwMVxjU4scPwj8UIdmQo0/mOkWTpc1o4sTyW+xrOaVrKyRAC2/a4gyfN8oVSRhNu1hv+LIsHAgk7s69YK2Ya7FiW8Ir2H8DkJ0ssIVtKph9ovyD2t65/J+8qHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XptjxMBNQYJ7lZXSwFu+Z2T6o9exH+CjGyIcjOSxTEk=;
 b=TUVR3ypC/GTGsaNnUbr50BfE/c1cNv8z049o0echtZH6670eNqNwhOCieqROqhu3WBhh+NhfOpO9v23bQ2G52rLj7z+21yP8ZNDpHjIl6mC8bjTzA7RUybNoHe7BGB0qeDQq2RMFU52wgvUgDx4PDNSrDbJuVY50ubI9gYyrbfwsXpA9Z8R7tFFKV56euQod8qqQwPYI0OpC+/t3+5fNDaPWWSCLdWyVntmiiC49wm73v+mHuT5gdCOc7xbXvbI8D1mDVtQTFm4qMRRtn/x20SiVZXwVDAqDTbnB3bCp96QBeuNct9mdVRUoMvTTrbVyVqgMwmJENIcrRgdP2XJ2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XptjxMBNQYJ7lZXSwFu+Z2T6o9exH+CjGyIcjOSxTEk=;
 b=TILEy6isH6pkxFQHXiRmb7Gw7+5gplp4b7cXJtT6B39dB0roE/xqUNAX5ijWbNTXX9jG2DVOjdVTrMXhXtPpZvHaSTXYXbdqGI07uKS/gjSvVPPNpHP0nHXZ268uHOsJzNVSt9VvQClX8hB4euPlUcuFuU7fIeyWhBFZHRXqyXSM/BLBCn17TADC4rKDa2/xmkOpvNRXjm/58qn+GHGNTd+l1qj0DVX+ABDwLEV9jgdPK1Jstqs2niBXoCNmwpeVh++rrZ2MlnqmOacSnyO7E/KaFFbFoEJRezlhJ3zznJH59cWBMj2NxEOX1Jz1MMnjfemAgG/4FPYbcVbJKnJqbw==
Received: from BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:30:16 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::88) by BLAPR03CA0121.outlook.office365.com
 (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 07:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 07:30:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 23:30:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 23:30:03 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 11 Dec 2023 23:30:02 -0800
Date: Mon, 11 Dec 2023 23:30:00 -0800
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
Message-ID: <ZXgL+GCGPgH+hlXo@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
 <20231211215738.GB3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211215738.GB3014157@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 20950ca9-a22c-4845-c095-08dbfae42f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wptgO8K+EY7Z6iyZjoTb+IvXsZ0S8NVAgh7y4Pkt9+JG0JOkdYCY4+HY3jmsX9ZtRvtKu/2ScZblP1Poy19ml6IOnUSmcCcurQ4qADDiRww1QGXfGAaqO5llcNd2Fx4r634EsookGDv2yJVNQk1HP1q35uIKf1LJbKTj5Pld+ClHi5glBUo6HizYoFS94FixfK85RI8DoCGW5FoLQZQvBfXLJLPy8xztprjbhtm36fm4dvWYn96FQzNV6K+Xq9txXozUytfDf1XbU5CwyIu9vLP2JcNeLCUevOaAkSwXJGVO/ma/wEwRwFsuyzfoyCx958u7NZbRPX8W3QIBxIjjbxfxKSrK39RSGagiZW0Ww8tzWOkzaenNa0IB49lYmfqQtfmiglUQjqpcqKRHxi+ffNxNnNox5LMluFalBwOv+m/Per6SQzp9NbhilCqlhRQ4c6TwI5Vave2PAj1EKDKfC/hfnje0YdK/KibjgCHwkuSgN8avs5RM1xg/xLs2xlYDYJVtE5fBnnRLWY6hbnTZDw9DUKfpBfh0TzFletp40oxIzc7vbOxSKWAoQZgi0Ea+7KXtWQwue7+AoecyX92YJzeGwQg2qqOT85qjesjXsRguW8D2bljtlqkdmS1wTcpb+/oPUILQVANWpQSbsxitYRCuADcY5d6clwZ1vnLhxiie60iz1FIX2Jwnen6UIaRDOVY5mEvlSXFwBkgA4TWInOzKk9i5lm+bTiW3x9PWgKQaxVB1fpUK4Wxj1tKpZ3Vi
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(7636003)(41300700001)(8676002)(356005)(82740400003)(478600001)(8936002)(6636002)(70586007)(70206006)(33716001)(86362001)(54906003)(316002)(7416002)(26005)(5660300002)(9686003)(336012)(47076005)(36860700001)(6862004)(2906002)(83380400001)(426003)(4326008)(40480700001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 07:30:15.3114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20950ca9-a22c-4845-c095-08dbfae42f3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

On Mon, Dec 11, 2023 at 05:57:38PM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 11, 2023 at 01:27:49PM -0800, Nicolin Chen wrote:
> > On Fri, Dec 08, 2023 at 09:47:26PM -0400, Jason Gunthorpe wrote:
> > > What is in a Nested domain:
> > >  ARM: A CD table pointer
> > >       Nesting domains are created for every unique CD table top pointer.
> > 
> > I think we basically implemented in a way of syncing STE, i,e,
> > vSTE.Config must be "S1 Translate" besides a CD table pointer,
> > and a nested domain is freed when vSTE.Config=BYPASS even if a
> > CD table pointer is present, right?
> 
> Yes, but you can also de-duplicate the nested domains based on the CD
> table pointer. It is not as critical for ARM as others, but may
> still be worth doing.

Ah right! Should do that.

> > If we do implement an IOMMUFD_DEV_ASSIGN_VIRTUAL_ID, do we need
> > an IOMMUFD_DEV_RESIGN_VIRTUAL_ID? (or better word than resign).
> 
> I don't think so.. The vRID is basically fixed, if it needs to be
> changed then the device can be destroyed (or assign can just change it)

OK. Will insert the cleanup piece to the unbind()/destroy().

> > Could the structure just look like this?
> > struct iommu_dev_assign_virtual_id {
> >        __u32 size;
> >        __u32 dev_id;
> >        __u32 id_type;
> >        __u32 id;
> > };
> 
> It needs to take in the viommu_id also, and I'd make the id 64 bits
> just for good luck.

What is viommu_id required for in this context? I thought we
already know which SMMU instance to issue commands via dev_id?

> > > IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> > > HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> > > (and just force the stream ID, userspace must direct the vRID to the
> > > correct dev_id).
> > 
> > SMMU's CD invalidations could fall into this category too.

Do we need a different iommu API for this ioctl? We currently
have the cache_invalidate_user as a domain op. The new device
op will be an iommu op?

And should we rename the "cache_invalidate_user"? Would VT-d
still uses it for device cache?

> > I previously drafted something to test it out with iommufd.
> > Basically it needs the pairing of vRID/pRID in attach_dev()
> > and another ioctl to mmap/config user queue(s):
> > +struct iommu_hwpt_cache_config_tegra241_vcmdq {
> > +       __u32 vcmdq_id;			// queue id
> > +       __u32 vcmdq_log2size;		// queue size
> > +       __aligned_u64 vcmdq_base;	// queue guest PA
> > +};
> 
> vRID/pRID pairing should come from IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. When
> a HWPT is allocated it would be connected to the viommu_id and then it
> would all be bundled together in the HW somehow

Since we were talking about sharing stage-2 domain, the HWPT
to the stage-2 domain will be shared among the vIOMMU/pIOMMU
instances too? I think I am not quite getting the viommu_id
part yet. From the other side of this thread, viommu object
is created per vIOMMU instance and each one actually tied to
a pIOMMU by nature?

Thanks
Nicolin

