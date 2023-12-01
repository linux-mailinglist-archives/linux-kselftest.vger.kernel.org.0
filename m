Return-Path: <linux-kselftest+bounces-930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A3800284
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DCC1C20B99
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 04:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8941F79EA;
	Fri,  1 Dec 2023 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WxCnCpuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF9170D;
	Thu, 30 Nov 2023 20:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyACTiyfvXJkJONBizzV2/oHR6rwCP6jTeWBMmuTrIRzDDWKQPd3tZvb/natCI6TAY/hiT3qNsnyMpQP0bqK40lcZpB6KNE2ilxzGjPkg/1Ui4kB7vkpnItUrMjkNAFNZ9qseGkqz6nZD+tVIPX467oo83JDMvZz3V3AyNLdayL7/zX9WF5S8xdR8mko2gS50ZXRdCTeMo21fuE5guWVBlKvnK1VdvQA4rax6ifQ19K3UV9N+kTbx2LpvKF76IKWKBolBkpCQT3lJk0fy/ti2WRyVG+ggksFmRqxYJ5xoYuQgqCUX4UWbxgWwMMFSCZUKzhRclOvFVctPnOhhYNdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7bfv2GNRu619/VcJExT6hbn694ANxooW5meEWIjrjk=;
 b=eDBNKFcDrCOOMqLG7VU4MXtScHoD8Cwx4Fftv7GHKYrzyBo7k4t6A/0Nj/87JQKAk9eEBsxLzziWaYm2CJAgQKBxBXZ6QSSNKchwKv2fUCXkJRTi+ZSJq6g+qhQZUDD0rn0dHsBW/HlYlda1CZ59PSelN56LvEU00b2zIqlDNYWQ1JS4IylZSpb8+fFGQ32G6BPRwbkKstsf8q5Bhw3ptM8bsApxNwi5EdkDKIFNGa6s+RoIrs5mY4ehZ38cvX9277aA/1MI2IZ/V7HSz1Lnqek71Jqamfgk1GzUctDP7M84exNz9/jIR862yZ30hGWh4O3rwRSZdZT0IflSMFPYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7bfv2GNRu619/VcJExT6hbn694ANxooW5meEWIjrjk=;
 b=WxCnCpuSWKD7bYdi6yCe9jdHv71uVc7AtcfRch9Lmv+MuPTUvmFt1A2WJF/jl0yk+oG7e8yPFz0KhtxctVaSMul83O22b65SlK3KxyxztvRgpYWuqD6tGt8idIT/C7o295HO/ZIpIIWnvHht2ojvjN2g/OuV/N2f8rNW1yNvlp6Dq0IHtEwEaVHGy0FJToDcE8O5TNdKNcRSQXVSaBTEZ9YK/HTk92hS/AnX8gD2LtSAObCP8vIWwuhj98+oqiHY0w+bSk+rdfXzx0sGQqLFHTxAV5rqx17WYwCb59jCLmvlgJPBF041o+DVRxmDlgAujJwvfSrQOGjkqMlf1gqAdA==
Received: from MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 04:29:53 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::fc) by MW4PR04CA0306.outlook.office365.com
 (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 04:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 04:29:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 20:29:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 20:29:38 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 30 Nov 2023 20:29:36 -0800
Date: Thu, 30 Nov 2023 20:29:34 -0800
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
Message-ID: <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
References: <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201004523.GJ1389974@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 70501838-9144-4d8a-9c4e-08dbf22629c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FuA8/wrxLDrwDPGQmMsQ5T1QiGX+7cJS3ZFVN1AD055ZRlddIKpX5yLJo+t/y3Czf0Zh0ND/Q59GjitWGZgZv0E8Q6RMXeAA+AtV+UZIhw0UuH6ytIbH5wS/etF97FYPSvNt5/X0huObRdxL6TW6aBil19+A7UVK+Ul2ohV1d4RSIZXy8EEusBkV4dP0El0+jlS6MNn/QJQwCgOVAcO8BDZX/f2gQROu6Btl3ezdHdv6TUEjrlgPkSbS9GOdOhAGEB+fO1OqffnVVafUph5uWvleZOrIobUCPKuwSID1W9YvEp9T3Qvx8N9NehxlnGUIvR0Wc6K0QKPv/MDxzwcoe5vYxeS9/c776YoS6yIgqHyI8J8mC3tuSU4eOv8TRrkVau9TSZ1ms4Vs4rVfAGSdZULg0IDsELbJrBB+35oS0Fxgh6fSPdlL0I0ZIeq0zaVtE4Gt92zzGb/1rC0RSfxq6vVn0qk+6ur/NJHbdmnQLAjmI6rv0orM9s7gI7C3lEA3M/6y2gJmV7I8vvO+tDoOGxFhy2jccGJ8YXJdRS5MGBS1tsbunOEWpaVUpFNqNCMLBAZ/XCqz75rcTECnNBYv6zRXDj5WmTOnZ4mNzNapko+6L/eSJxT/6LvOFMB036O+cvyRKsqXo3ceVr5b9T1phX5p0VHehYfXfCgmVMlHhuWKqnPJJmMJx7wmqnvtdOuKZlxbd/z1EOc7Y2deqXG27kgTOF33BT+mBif/VOEjBFOcGJjNxOw9K0CHykj3djGo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(4326008)(2906002)(6862004)(8676002)(8936002)(55016003)(41300700001)(336012)(26005)(316002)(70586007)(54906003)(6636002)(70206006)(7416002)(5660300002)(9686003)(426003)(40480700001)(83380400001)(47076005)(36860700001)(7636003)(356005)(86362001)(40460700003)(82740400003)(33716001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:29:52.5746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70501838-9144-4d8a-9c4e-08dbf22629c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

On Thu, Nov 30, 2023 at 08:45:23PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 30, 2023 at 12:41:20PM -0800, Nicolin Chen wrote:
> 
> > > So userspace would have to read the event FD
> > > before returning to be correct?
> > > 
> > > Maybe the kernel can somehow return a flag to indicate the event fd
> > > has data in it?
> > > 
> > > If yes then all errors would flow through the event fd?
> > 
> > I think it'd be nicer to return an immediate error to stop guest
> > CMDQ to raise a fault there accordingly, similar to returning a
> > -EIO for a bad STE in your SMMU part-3 series.
> > 
> > If the "return a flag" is an errno of the ioctl, it could work by
> > reading from a separate memory that belongs to the event fd. Yet,
> > in this case, an eventfd signal (assuming there is one to trigger
> > VMM's fault handler) becomes unnecessary, since the invalidation
> > ioctl is already handling it?
> 
> My concern is how does all this fit together and do we push the right
> things to the right places in the right order when an error occurs.
> 
> I did not study the spec carefully to see what exactly is supposed to
> happen here, and I don't see things in Linux that make me think it
> particularly cares..
> 
> ie Linux doesn't seem like it will know that an async event was even
> triggered while processing the sync to generate an EIO. It looks like
> it just gets ETIMEDOUT? Presumably we should be checking the event
> queue to detect a pushed error?
> 
> It is worth understanding if the spec has language that requires
> certain order so we can try to follow it.

Oh, I replied one misinformation previously. Actually eventq
doesn't report a CERROR. The global error interrupt does.

7.1 has that sequence: 1) CMDQ stops 2) Log current index
to the CONS register 3) Log error code to the CONS register
4) Set bit-0 "CMDQ error" of GERROR register to rise an irq.

FWIW, both gerror and cmdq are global. So we can't know if
the error is for which master or domain. So, the only way
is to get errno from the arm_smmu_cmdq_issue_cmd_with_sync
call in our user invalidate function, where we can then get
the error code. But this feels very much synchronous, since
both the error code and faulty CONS index could be simply
returned without an async eventfd.

Thanks
Nic

