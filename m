Return-Path: <linux-kselftest+bounces-909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB957FFCD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DB11C21240
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619052F84;
	Thu, 30 Nov 2023 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnNs42TM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D810DF;
	Thu, 30 Nov 2023 12:41:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhtq8XHKH28IJIeGcwNGXmtn7is8LcFXtvPwroJF3xHJ6CSiOgyfHdGMOsCPrZjild+w4todwyO83bGcLqvN3rvgIoyqp9654D0xZ+xDvZgL8aRQW7uKSZyN82PRGplQKtkP9iUFcA48Y2EYiokkP77WlKyQRfNcBxT6D6UUDuN1U7gTnpoMjPXfZufKh8E1EUc2bYq77dyU7srLP4NNZySYeUdEqjdEtdEx523WyVie91ofOXQ0uITgkl51KfQlTUBe7eeN1uAbvwXBHPtoKwQmXXdVOP1ka6ZQ/N85H+6M5avD8lNctYtPajNEO3fZxyRV/6a1ugR9RDuSe2DCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg6XE4LP0MWCssOY70exAojC5zQyaQlr1CoEpz7a4G4=;
 b=E0caypBJ0ekBpWpIydix8Ve3AoV0PnNQcjQBjIH78utQMeHFLspV55e/L9ENUqAjiTqJCbRVJZYiyNQkj9BOQk+Mjh2+Q1YCmcC1Nz7EHO2pifo3tQIuWJmgepw+Z4j4o+ml2IbfpllsWWD160lBoRCD5HMxiesEre3llF708cY5H7xu0CqIOAFTlIxFdoMFq44/oAy6qFtUf6QKKAxldo8JU5t8Qk/IX/qElPu5ONVaSSg/dTjb5LShc/IS4j4whrLf1UGYtW/q8vb1gJb/fdABUrXvOeRtrrVeNNnGvNbxzLTW1UUOcwQcqUt83Q3ldhBN+uZmzyuisP8giMj5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg6XE4LP0MWCssOY70exAojC5zQyaQlr1CoEpz7a4G4=;
 b=UnNs42TM+vxTSwuUP4Niv+yjKR+1yw33g5nKVLjHsXzhOt3gZNpbaaZE649wE5W97ZLyiGRJCLr3SHd918BmLbkyRC/0M2kdQwGWI3tkgnff5aAj68tpZrxu0m4Vinr3CF1nkVgINh8OZ4mjMhGA4OoxXYDYxENSxBXdg0EuoB0VGfmKh/3YNygzpjcx4U8CyQWmCJrjL1xBN4HTxqR+4UFFdUeXM76xBy+/nAKkYLAAXtfTe/Ao6K6DIq49+6tBtasjmHD3utfa/xh8lnzhRpKnK05ykSdiMmqWknn5w9RbtjeRQy3DCBiJhK/DgIWVO/A8p4LUx3F7II8O/8UvZQ==
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 20:41:36 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::fc) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Thu, 30 Nov 2023 20:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 20:41:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 12:41:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 12:41:23 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 30 Nov 2023 12:41:21 -0800
Date: Thu, 30 Nov 2023 12:41:20 -0800
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
Message-ID: <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
References: <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130000816.GB1389974@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2209f2fa-1066-48a7-05a8-08dbf1e4bef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3pTn51y3BMQt7vlSQRy55wjzzcPZgNbopuWIbSGNt7Cn50SHsudaOoN4wlPvxbxai5MV8+Y2uKL1BNVqv3E2boqUgYlnNrgnFW0SOHleORXfyEhSeP74CARyBqA0X8ydxd5AxEft5PPNcqWq8C3LGKrx63W1Jj1YD+MyYVcZhHQ5+Ewm0LQdYfnOuRLitl1hFXbf6EgVHBVGIlazADm27K4lc7IUOxeK98mFfJ/p0KSUIiZRpyr9FYz8BgH+3vqxDbkWsEgQONg5bVgHYak4rs7FSK95M1zMmP/WdSxcuWJIk3CznvYZUmifT7P7I/fVqqdvf3nkylZvetJoj6jHSO118hpXdy3+q9kuN1yTUHVhx8lBQjBJpFaSOTRCTQUDDR1BSZhNZK6mPXmyR4BP5FkvSwJ6ZnyOmFrJY8QwcvSPIkNgvSfIcwpMWZzCLdfdaSzI49xPeGmQ9veTq377XyFD25qm9bfYEChlEWtOiNs/QJMeSQH6/IcX6Y75WEkkMJNDpIaPJuSnVOMxl0/L19WAA+rKNrj5SbWqy7XRutomDmPUj4QMDUjLFZ5kBLnHaOhoti7Viv/c/DjmfsyusaJ9NoNCp3h4BZYDnG+AymsBI0YbkA8XI83gSw1N63M0j8FCTosV2SQCQ4x3/8cKcLbovsWrjNWxRRz50K3v9cUInZlfLlqHoTAJc/h5etF+kwFQRoRqhHBP6JAwGUmSheILIwsfXXAhYYvQr/fp20KcXsJ1h8AsIVkI4rVcL2CM
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(55016003)(7416002)(4326008)(6862004)(8676002)(8936002)(40480700001)(41300700001)(70586007)(70206006)(316002)(6636002)(54906003)(40460700003)(9686003)(86362001)(47076005)(7636003)(36860700001)(478600001)(83380400001)(336012)(26005)(426003)(33716001)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 20:41:36.0413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2209f2fa-1066-48a7-05a8-08dbf1e4bef8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

On Wed, Nov 29, 2023 at 08:08:16PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 29, 2023 at 02:07:58PM -0800, Nicolin Chen wrote:
> > On Wed, Nov 29, 2023 at 03:58:04PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 28, 2023 at 05:09:07PM -0800, Nicolin Chen wrote:
> > > 
> > > > > > With that being said, I think errno (-EIO) could do the job,
> > > > > > as you suggested too.
> > > > > 
> > > > > Do we have any idea what HW failures can be generated by the commands
> > > > > this will execture? IIRC I don't remember seeing any smmu specific
> > > > > codes related to invalid invalidation? Everything is a valid input?
> > > > 
> > > > "7.1 Command queue errors" has the info.
> > > 
> > > Hmm CERROR_ATC_INV_SYNC needs to be forwarded to the guest somehow
> > 
> > Oh, for sure. That's typically triggered with an asynchronous
> > timeout from the eventq, so we'd need the io page fault series
> > as you previously remarked. Though I also wonder if an invalid
> > vSID that doesn't link to a pSID should be CERROR_ATC_INV_SYNC
> > also v.s. CERROR_ILL.
> 
> Yes, something like that make sense
> 
> Presumably sync becomes emulated and turns into something generated
> when the ioctl returns.

CMD_SYNC right? Yes. When the ioctl returns, VMM simply moves the
CONS index next to CMD_SYNC upon a success, or stops the index at
the faulty command upon a failure.

> So userspace would have to read the event FD
> before returning to be correct?
> 
> Maybe the kernel can somehow return a flag to indicate the event fd
> has data in it?
> 
> If yes then all errors would flow through the event fd?

I think it'd be nicer to return an immediate error to stop guest
CMDQ to raise a fault there accordingly, similar to returning a
-EIO for a bad STE in your SMMU part-3 series.

If the "return a flag" is an errno of the ioctl, it could work by
reading from a separate memory that belongs to the event fd. Yet,
in this case, an eventfd signal (assuming there is one to trigger
VMM's fault handler) becomes unnecessary, since the invalidation
ioctl is already handling it?

Thanks
Nic

> Would Intel be basically the same too?
> 
> Jason

