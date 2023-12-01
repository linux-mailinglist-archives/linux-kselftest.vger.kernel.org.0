Return-Path: <linux-kselftest+bounces-931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45F8002A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213761C20BA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 04:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAD1FDD;
	Fri,  1 Dec 2023 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSs2ATVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1110DE;
	Thu, 30 Nov 2023 20:50:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgJ0xJ485nu4lNqeXID+SDeeFbRTDVTO0snMS84mhTcc6SlNimM9iu3i+X2qBVnT5Q+X8EEqqV0fpkl/0wTd4xU5EcyYWJl4THw02Q2/GcRy5Zj0PHhv986KNFC48VO2eU4SI5Bdq0Wfq+0sjt9NtNRvQbyRnZbqaoF5BOC7/O59rOuwXpg8dDjH+IvX1OI4Iq/r09G2Prp422vAZru3HOYCoFYxws9Piq6fnxP5B4aTmeGa/+GgGNPINpyK0kdgeSeiTVBnoHxKrxBhzO3R6kMw+HTmz+lqjhTkTDD2wcmpblmaGTeefR/QH/TsoNvR7vpe2u2iwfly+9Yj6JNVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thYPPq2k4CeKMVcpyS/RRZCpA7n96oLmYgTv4phq+lU=;
 b=fXjKSNN2d832PSYOhw9B/CMlzBr1jN4dC+R4iUrB2M+RRmQaeCD0Q/S6fsOzRVVl11fKZVUPS1re89CKrxo3Q8Gx8ILpf5HlMd7ypQ3D4k+p/vtE6+6NEXFRpyl4K9wKe8GgF9Pl4mY3TdgwLTOHml8UbvEOBoJDnQHC8TPftvl9vmD2UFPvt4YzZTJBPfy/qvsB93kJ15JDcSWH5J9H6EagxHJSH8/VtkuSm2PsnQz5eIfUfdiope5/ZfDoAZC21gCq8TWD/Pbz+7vqhkSlXFGbrmapLtznz+eYX9pGUda4INKJMtJApIUIYwqHVTg7sXJfNs67sBRwfTgGlzghWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYPPq2k4CeKMVcpyS/RRZCpA7n96oLmYgTv4phq+lU=;
 b=OSs2ATVtZewnWLirCBSdRXRUB4558DiZCtEwz1Vp3vrLpbrNIjNc4XcTjYP30MJMD/OCGZTnn2Yyu2mL4h6wrzNp2Vr552+44eXuCWbqY4Q6V9KSoRrdYB8ebYTSHJOa4Va8boJ8ayIJLA1dfGM1QVRf7Kb8BGEX6r17xfN1k6YmbR8TnUphSWWVmSnhu74o2pJ1zj3sBAAgr8EygDyEINIBcMfGWrJWts70Pp6dsCHNUE4S9W8ihZMC4pniRjc7zvcbuqu2hFush9bpPm9Na6KHDXBB8UPv9uUeiuxNIVBjhYxw9JZKODl2niVZ//2bmV+/MgiMHQ9r2LjhM9aDOA==
Received: from BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.28; Fri, 1 Dec
 2023 04:50:48 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::f8) by BL0PR02CA0082.outlook.office365.com
 (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Fri, 1 Dec 2023 04:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 04:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 20:50:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 20:50:26 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 30 Nov 2023 20:50:25 -0800
Date: Thu, 30 Nov 2023 20:50:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6588d784-f456-4331-1c6d-08dbf2291625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PZviGfzrdEPbRKZMU7qM43ayvYKrV+u3HogpZaDTcJPn/yhkFKm+mDowfjQNzFvXtPc8Cpj8I1UCCVTL+ZI93JM/G+9dScNt1QpGCho1/NLVjPJfieY5lA84N53sH/U6N66IaXviJbbfIsIchFYGJo53HjQ3FnDLlVVA7gCrN6MnBSmYwKiVtdCy01pGvMZnn3lsJKTny/VvFTMhHw0LGcMvOlyR/ObKBrLQc6wNrt+0hmAX+vkk0tuBhJd5Ut5zzYIOCdfCXZSU73jSt71B5v4SOszJkpoH7d6VJZOjwvRFXOB3caDNPzpFIP+cUSjEpHO/BlVBO3/Yq0zYFxoisYQZ/vWdtELkz3BzyexPiQjQ2wdNtus+1+vmTPI39dOc4wIy/VhOJyoaDdZQGegDe6RGli6zHvIpzPrJQo6/9hGCZL2Ym8jbt9sAXjJhkfg7RmGtN0Q+iO70xQT7bu3PVuB0FscBbPH/DX8mDp0eoVUQDj39zNVHn+XAkC36VC/dHfns3g48c6+QBWKZYVSky8dtt8cvY3JzxcD56Tp1IBXlc+nJBiJj0NnnUjBYDdWPrQF9/xV6wS2omQClkh5NSRdkICkEQVUgW64+Ngyx9/Pspy0DhVLRHSbjEwQTJwhSB4s/iEg0BzAsyupC2Mrel6DDD6FjmiJA8tnr7FY7uOi/jn9+UudF/4jHUI006KFso0zTLZ0ZwpFozqLCCzmB8gnzMa8dx36nQ575PQLHKuOXZ+rByFvpAuCLUGv8jb29
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(55016003)(40480700001)(40460700003)(70586007)(70206006)(54906003)(6916009)(7636003)(356005)(82740400003)(86362001)(47076005)(36860700001)(426003)(83380400001)(26005)(336012)(9686003)(53546011)(2906002)(316002)(33716001)(478600001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:50:48.0137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6588d784-f456-4331-1c6d-08dbf2291625
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

On Fri, Dec 01, 2023 at 11:51:26AM +0800, Yi Liu wrote:
> On 2023/11/29 08:57, Jason Gunthorpe wrote:
> > On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
> > > > > I also thought about making this out_driver_error_code per HW.
> > > > > Yet, an error can be either per array or per entry/quest. The
> > > > > array-related error should be reported in the array structure
> > > > > that is a core uAPI, v.s. the per-HW entry structure. Though
> > > > > we could still report an array error in the entry structure
> > > > > at the first entry (or indexed by "array->entry_num")?
> > > > > 
> > > > 
> > > > why would there be an array error? array is just a software
> > > > entity containing actual HW invalidation cmds. If there is
> > > > any error with the array itself it should be reported via
> > > > ioctl errno.
> > > 
> > > User array reading is a software operation, but kernel array
> > > reading is a hardware operation that can raise an error when
> > > the memory location to the array is incorrect or so.
> > 
> > Well, we shouldn't get into a situation like that.. By the time the HW
> > got the address it should be valid.
> > 
> > > With that being said, I think errno (-EIO) could do the job,
> > > as you suggested too.
> > 
> > Do we have any idea what HW failures can be generated by the commands
> > this will execture? IIRC I don't remember seeing any smmu specific
> > codes related to invalid invalidation? Everything is a valid input?
> > 
> > Can vt-d fail single commands? What about AMD?
> 
> Intel VT-d side, after each invalidation request, there is a wait
> descriptor which either provide an interrupt or an address for the
> hw to notify software the request before the wait descriptor has been
> completed. While, if there is error happened on the invalidation request,
> a flag (IQE, ICE, ITE) would be set in the Fault Status Register, and some
> detailed information would be recorded in the Invalidation Queue Error
> Record Register. So an invalidation request may be failed with some error
> reported. If no error, will return completion via the wait descriptor. Is
> this what you mean by "fail a single command"?

I see the current VT-d series marking those as "REVISIT". How
will it report an error to the user space from those register?

Are they global status registers so that it might be difficult
to direct the error to the nested domain for an event fd?

Nic

