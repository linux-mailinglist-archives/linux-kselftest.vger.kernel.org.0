Return-Path: <linux-kselftest+bounces-363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFE7F253F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 06:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BFF28296E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7718E02;
	Tue, 21 Nov 2023 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RL24gG3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25020ED;
	Mon, 20 Nov 2023 21:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAM8nxEHHwklIGuUmEWXe+FBgB/Z/VQ+Z68pcEffBdGyF3wPDAAHCfu14Wcc8WLSB9BlHkCGSAMrxTbi/d8Hu4V6vf/TbzTf6xXiknv+xJ/O4LTvozlZjsUneVWZdyMdJmqDR1Q1IDJ9BUQriPWkrpWietO05WgRDlHn35ax4vE2n3y9dz0JiWTbLgkchCOfU1a2HcU8RS9pqWG17WBOpZ33SEfVjmji7tPqtdxk5jTs++J33G+Itu8b0ANadno0+drpUQdyHOsHjGnpWb3RqUohqS4Pmp2XFcPFD2z4za8Z/ZzqQvmuE+9q+nLOUECoZ67Qq/qVlHv2iZLQPh6U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jd+qZXrI+zmmj1LQaa6DNhZw13hyiphqninkZpsE9w=;
 b=C01H65GHnHTldvOaLRkr4XGmZdueC+cLWYEO3/AKADffgRFG4PKR9FFzD3DGkmD85fJyrAFdCuke0V9StfESzy6Bz7VqR0zua6jdK/Oiw7ZAPW7s3on5+eee6r05k4kjgn42MlhHvmqHLLeW2TLHdFEnw6OpZX2VTXqRXXUztwnfP29jxq/Z5rebqJKMT/0uw9jYA5POTkZPeQJ+aXG3X0miMPMav0RZFt3Jydt0OjWwGZDhdbt+lYJd49j8jwXgo6+tuqx0rNfEwO6tX5F/BrHuAcRItpF7I73hiPZH4Ex4N9ENkOxNJgKjbRti1SJjbmWRq5qzyI01/AMvMKelcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jd+qZXrI+zmmj1LQaa6DNhZw13hyiphqninkZpsE9w=;
 b=RL24gG3OzPdNcdRsiLcVQ11EGQ2vGrsrCeaaz+5g3BNtVd8cpbiDs8XITRg4Bj5HlwoZEh8/mXGOw6TdWiogoK7yknrTq5uCZsfjyFrAhQ771cWd5jfcM3qA6UC/ydZkna7i0n9P1ooz0LUyg7G7tUYthX9L42SzptZn7PXOzfT81h665Rlf6sDG5LAZqsOR6a+FXXcPK1JsVx0/XxvIfQKcyoy1MdRQzykMoVPB6IAHKf8/TjfRw3M5GxFXJSI5hWcOb2mXeauUBojmtgSTl0JhHvE2T5K7GAmUKUZ/744V9s3qrzriRSDtcA0IzlyJE0WbtxWA57b23hPvykjTlw==
Received: from CY8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:4d::29)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 05:24:39 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::c6) by CY8PR02CA0009.outlook.office365.com
 (2603:10b6:930:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 05:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 05:24:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 21:24:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 21:24:24 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 20 Nov 2023 21:24:23 -0800
Date: Mon, 20 Nov 2023 21:24:21 -0800
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: fa434992-7961-4045-47e8-08dbea522852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0C3JXABCH0gcc5rbX4OzhyXUgM037EqxJk0Shv0L0ssJC8PY+Zl14AhyzWJjhjJfWJx52c/auvjRbeAoHTbWkGZ76VdxtFYxq41/riiW5PnjBTLBV81fMIwUCGQbSWLbx56r61H3WAkA8d5uw+PgCdEzQ5kUXPlAKj/Ngd1S5H33kPWp5wThd10jJypu3ceoTGlOJHo8Tfprc7YMO27aOoWaZHWAObSgpQeYQ3mZFCjivCKOk4q4UWyPHnxrTH7+S09gqZb1kE1tOVF9K3uavxOkOwamofOzaBy4qgkWmV0UZPBdRbzpnfgLNR/WJObIxrzUro8SEavLxvTpAp9PE+5hhSXiBZwU8yZJ8/RaZWnivxE2S5jpA8/RTEFVEOPSfY44dG6If5+55JuyAzRSWFeZaMKt0MwxmjfU4IihoI7X0qAzpGSR/SX/cc6VfT0bage/YAPTntB1/GvocuxD7YylDZqKih7zP477x2I3GjqA+3eGzb/ESStq3K3LBDIzRjqfFg0lKeQEp9D2bNbiYWN0SxkGP/BzoDcBHSJVTQWtMeARyb2F1sK9cPtskpWTWVZbn2QCU/lGAvNrCC80MdotuCfo00bJ/oRNpQBgXLrbpaEd3UlotVE8Hw6XI5+0GtvWRZL59jBp6SbFce4orC60ou9L449Hwz+ectNdjvywMm7Fvt48PscnyucgaJsQ+daw1108kJ7M8mXWaFV/y/pbCmwvvkMtTJ7uwwVDCAe1pSYz9pGbNfobVH+sftpg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(47076005)(356005)(7636003)(53546011)(40460700003)(36860700001)(41300700001)(9686003)(426003)(336012)(83380400001)(33716001)(26005)(82740400003)(8936002)(4326008)(8676002)(40480700001)(7416002)(55016003)(478600001)(5660300002)(86362001)(70206006)(2906002)(70586007)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:24:38.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa434992-7961-4045-47e8-08dbea522852
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

On Tue, Nov 21, 2023 at 02:50:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, November 21, 2023 1:37 AM
> >
> > On Mon, Nov 20, 2023 at 08:34:58AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, November 20, 2023 4:30 PM
> > > >
> > > > On 2023/11/20 16:09, Tian, Kevin wrote:
> > > > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > > > >> Sent: Friday, November 17, 2023 9:07 PM
> > > > >> + * @req_len: Length (in bytes) of a request entry in the request array
> > > > >> + * @req_num: Input the number of cache invalidation requests in the
> > > > array.
> > > > >> + *           Output the number of requests successfully handled by
> > kernel.
> > > > >> + * @out_driver_error_code: Report a driver speicifc error code upon
> > > > failure.
> > > > >> + *                         It's optional, driver has a choice to fill it or
> > > > >> + *                         not.
> > > > >
> > > > > Being optional how does the user tell whether the code is filled or not?
> >
> > Well, naming it "error_code" indicates zero means no error while
> > non-zero means something? An error return from this ioctl could
> > also tell the user space to look up for this driver error code,
> > if it ever cares.
> 
> probably over-thinking but I'm not sure whether zero is guaranteed to
> mean no error in all implementations...

Well, you are right. Usually HW conveniently raises a flag in a
register to indicate something wrong, yet it is probably unsafe
to say it definitely.

> > > > seems like we need a flag for it. otherwise, a reserved special value is
> > > > required. or is it enough to just document it that this field is available
> > > > or not per the iommu_hw_info_type?
> > > >
> > >
> > > No guarantee that a reserved special value applies to all vendors.
> > >
> > > I'll just remove the optional part. the viommu driver knows what a valid
> > > code is, if the driver fills it.
> >
> > Hmm, remove out_driver_error_code? Do you mean by reusing ioctl
> > error code to tell the user space what driver error code it gets?
> >
> 
> No. I just meant to remove the last sentence "It's optional ..."

OK. Would it force all IOMMU drivers to report something upon
an error/failure?

Thanks
Nic

