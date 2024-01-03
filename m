Return-Path: <linux-kselftest+bounces-2622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79879823266
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931FD1C237C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13F1BDFE;
	Wed,  3 Jan 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Plulj2X1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30071C280;
	Wed,  3 Jan 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaemrqydJ6z9OJFrT4B5p05SwffqJhuKSVGRgf6CxsgIxkG+JqKo8yu3w97fL6zlodUBZid4Q3g8z9J7E1H0XQ4giA5iticngnCAJ+en/JTGxofowM/79CNMh3VNb0eeTWJV1fwkW3m2Ndk/0MZHNx6fEbCmFGZ7Wz43f25uaq5UK5kPh2idmpIVu5Ffl2npAEUhRe38KERMyUYQAdm247s/gGdqLD8qtwZsWbJB4Ipgr72EY+rNxFLVldKvD7+B/gn7bilp4OiXZ9RFJxAlVhpsa3Hy7UMZHQ/QL+fZDlUbarz8rVno50UAWshUr6YAzk9mL6wP62iv7hjPTdArbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5Pi0w9qkg8mxlZ8S8Y+0rx94SxYmUPuKyRWDDfetj4=;
 b=dyVezEChwolURC8/4kAZedjOHDodCRcuB7lTsAoADEoY2oEeWanmH2a4LO90n+GoHTbbGYsLB2MPIzQ6ScANd77ZR2Tptilc15oKt6gmcv8tJUl283bi1MHX+4NHep8qJWa+ZYM8L2pEvgbxQKxaIji4RwMDhk+HhPs6LQlLouDXPjdlz/LPSpSVEqLCxocNoUHpQGjlnkgW9a6oIf9sadAe6P4W2dL+6VRUmyyvme06yWS4GxO/GASdCsiWd9FXquOAQ7hKtUlAFIAJvnGPbOm2t5RJbilsHMX2pKN40ooyZUxsOY1r456Mu1jGqIbT0O0EXs6RYWjCawV1Cd1W1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5Pi0w9qkg8mxlZ8S8Y+0rx94SxYmUPuKyRWDDfetj4=;
 b=Plulj2X1P1yG0wbJfeM70kZKRzN5pQO0yzJYX00EMLTdS67PTH2GS50fvFwtycHgtJRKU8DA1TGqaUCKu/jrvzSYjMacRjPpsn8l9h90RUjUraYByIvTT6XE0BymqBVOORaSMXb3kL+Rbb/a9oohzdMjMjOkyU8gYI+srsk33onqCOliEpA1TZzpz2AgVyaPakiFq5oOLzdh/Z85zL3NIUfkuflK/VTlyRVWaPinsBzyCdO2nxLU1hhOkAQqa3jxyLTULNAFlEEpQHZAcfmuQdyFzd6X/qVksaAWpMLDbzIYFvSnyBB8QI4Nx5yxdfmOmXDsaYoRYPqEAYHrs+C4QQ==
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 17:06:39 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1d) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 17:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 17:06:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 09:06:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 3 Jan 2024 09:06:26 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 3 Jan 2024 09:06:25 -0800
Date: Wed, 3 Jan 2024 09:06:23 -0800
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
Message-ID: <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
References: <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103165848.GR50406@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: e0542146-6dcb-4599-ae85-08dc0c7e592d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tN07VYu0ifmDx05lf5rBVMRXdP4URTq02LeRsZKDGkdnc9KDZaz1AnpcsDAd/fgI4e4eMqLbGRhg89kOxQl1lESDSc1x+9QqT3N5r3B47e9JOnVXknV6yBPip6bQFkhO5rY+iMSgq3cMRNPcN56PV1JsK4f5bVObBPfj91OmlPh50kxJKYNMF7xK53xw0UTRxgTdyXJpl3hRmTrRFvJTRCZ/TlY17w3ksQ2zRYaitLWcOEk/rlzrxEGFOjrALeiSWo4d45gFmQCRvrPZswUjSnKW+/GZ95gvcqEXlWtdYWfX9Ia+pXM7ZlB3LCbJbKhWcCxs3aBepmYDNrN7z403yrEh23qnNlUgwVjk5VZfDYct5iwkmvLrnEI9vbdQFI67BG0VsKBD7OC8rdLKPOuEnMXS/P6wDgH0i9MybZOTwV/ZpHqD/7DY4ncSfUztgx62ONZqth2BTelSRkR4krCCFkS/FMTiv9sjYI6KOo+B+2bPyMyk3eGkvIzJvCJ7+54jxxksVBPMjrvnH923JoHWl3S0V0whH5bsiWClcWvmafs01FuaxRKFmweDhmKsw4SbglSiwg7veLPBwYi6h3AQAUpca9HkFPI6El7LxbDlE7ZsTYhQWqwyXSW1uF9wXFX2Kj2nvD9bIBq02v3kW3w+iVTtkXnRiwlI3KSXhmoTcLHV+yRDJpPM+BADJGRRpEmj8XfhuGQ7jcsr0OMKFOsb8pQUWlYCmPxh5Tiq4yET525mF91tClgwgbO6pyZBmu8V
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(55016003)(9686003)(70586007)(70206006)(86362001)(7636003)(356005)(336012)(83380400001)(26005)(47076005)(41300700001)(2906002)(7416002)(5660300002)(426003)(6636002)(478600001)(6862004)(4326008)(82740400003)(33716001)(36860700001)(54906003)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:06:38.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0542146-6dcb-4599-ae85-08dc0c7e592d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Wed, Jan 03, 2024 at 12:58:48PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 08:48:46AM -0800, Nicolin Chen wrote:
> > > You can pass the ctx to the invalidate op, it is already implied
> > > because the passed iommu_domain is linked to a single iommufd ctx.
> > 
> > The device virtual id lookup API needs something similar, yet it
> > likely needs a viommu pointer (or its id) instead? As the table
> > is attached to a viommu while an ictx can have multiple viommus,
> > right?
> 
> Yes, when we get to an API for that it will have to be some op
> 'invalidate_viommu(..)' and it can get the necessary pointers.

OK! I will try that first.

> The viommu object will have to be some driver object like the
> iommu_domain.

I drafted something like this, linking it to struct iommu_device:

+struct iommufd_viommu {
+       struct iommufd_object obj;
+       struct iommufd_ctx *ictx;
+       struct iommu_device *iommu_dev;
+       struct iommufd_hwpt_paging *hwpt;
+       /* array of struct iommufd_device, indexed by device virtual id */
+       struct xarray device_ids;
+};

Thanks
Nicolin

