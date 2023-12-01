Return-Path: <linux-kselftest+bounces-978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD68013CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22063B20EFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9651C4C;
	Fri,  1 Dec 2023 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+4GEzUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48F10C2;
	Fri,  1 Dec 2023 11:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs/AJTbZTZ6IKDCz6UJtJ0ny8lKRjADe8xvoJa7AjbZfzutykybPd5x/80ugpTJZDQBJJmu+araLGbGe/lrtNS61iS0agYsjCWyqOynFgl42bBN/5zerlimvz2QNVgq0+WvD+W8hbZ4o9U6SHsgePgVVaNiqBYNzDlDYKexx+GupJ8nijmw6DH4TW1+14Z6J7e7DDtV/IQB6CILMaxY51GqytJUnI7vLiZN34OJFFVhMK2UVe5OoGg1lCO16N/4EfXoHUo/q+TxO/hiFCR0eVxh2/OfunQpiTyqylUfd9LGD/hxBU2CzqiVEyMOZLZPdzz5I4Fh06qBYXQEjrv9Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKTAnDaV+3smz4clLLHPx58jCZ6bo6m7pF7Kr3mpo5o=;
 b=bSODKiwlWXdMOSkc3rTfVE94AHKvQTT1PCoRPDhr0DEKOWjw6z0HsTV/1lk2pAXZ6lDjDsq3He1QsK+XFk2Wd5jWEFRcRiZlt/fVvVmRloHKAakmS6uWs2ninhEVBfJr9Yi4BoU29o86R90LlfXO69Q3ZKDCg6f63KV2mpvUVBN75D1phXX4gZQNbPhSyFGZbtJey/mCLtTmp3jTcdNbwZcwCGnCxzSAoxehMpR7TkauKUq4/onQw+DrysAmUESC4ChakVXcpu3ttQwcvI/RsrbQFet8Li40SyPCzwuFj3n2E92Nh95TO+Zq5+NzCeCWPmbdfqnkzGL1qj1NuW1viA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKTAnDaV+3smz4clLLHPx58jCZ6bo6m7pF7Kr3mpo5o=;
 b=M+4GEzUzK43RloUS3JGJ1m2dJyw08YGrU4MTq3aqWfphIH7rmj59MJLuSCOvdFnm3Y9hq+zcXO8dXQ4xkYRexwQx0auAAoPkjkQJC3SuNEe7ciOiotyqkNcGFOE3aJr10nxoc+RFscL52Lw49kz+k8I10hARGnVhQUTzW2c9s5mHQ87OLO+RDnD0LcQ4RXRSB7b5GUU640ZFWZJX4psBXV/ZdR4+pqKX5gAKFtxUN7LokNtCb1JxySxdxMck8NhH0MFbawSUPq2jx27VCKY/+mXZWnRlfYrfFxrWcQ+Vx+gyTobX7S8z6StxJP8lNJLa0n68QiIfqfxis02HcYMczg==
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 19:58:22 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a0) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Fri, 1 Dec 2023 19:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 19:58:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 11:58:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 11:58:10 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 1 Dec 2023 11:58:08 -0800
Date: Fri, 1 Dec 2023 11:58:07 -0800
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
Message-ID: <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
References: <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201125538.GK1389974@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b94ff4-50fe-4429-b337-08dbf2a7df52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	feOibwmbVI89nWr0T3xQgCC5DocVXnD5SiWSph0v9DmV9uJ2vtuKnnl74dfpzbnYYUUi/NKuz3cb2cAI9gkIkNxSJG8ri92BAxKt999jQqMfAhXsD7nJzeySZ5OZxuRS6niqFRjLHP+2HS6W+edpv8lzRe+FMljyHDKOISqdyKSCl9USQAG8X8+eqlj6Igqie1Yhut1a3vKJpPbuPBJw9h8oAHz2I1Hdr8U2xi6SzuKKnsz8pUIJnmzMaEmBqxUVEJ4e4FHQO0Yla9orwRA9nzvXR7YMLa3vOAHvRJlMAVi9EuIvREGnXWULk5DOA1XCZFbf3IKtW9Y87GIDtTwYt4ogsm5xxQCsIYt074f77C44Mjh6jntruMV65/A5TFnGBLUpmHW1DCSp1CETAxiSEZzJv3zCAYQmW9iL7dDfQHYQ1cYKhjGtsRdduyR6Xwuh7zGMDGFaWEzQmqpBAdbXUGfw2f5ePcOjVSJNQc4KckQq/Kv79f4oBhyYLdJ83UqnXgizL8lCINnoHGSr33xzda3RmTFmWncqnOiPlad4pWZcpjh69G3OKrJ4Omxddl1SP33+mWjGcDu9r5BCR+M6QkIKW5BNs2PodOphuE4Xhspgx93E9gPyBsvQz8/u8znHnl5wMohAaJVNFfeO/PtHR38LjJlNWOZUBYrEV1614XNRSLkJbtZqW9w0KNYhP8ilIgcx2oOmj+wLVlXC8WHzxhy7nxcmqudxEFecxXGZseosxw8UIc1jYsUvzagZrcu/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(26005)(33716001)(40480700001)(55016003)(40460700003)(36860700001)(356005)(47076005)(82740400003)(7416002)(2906002)(83380400001)(336012)(426003)(9686003)(7636003)(54906003)(5660300002)(70586007)(478600001)(41300700001)(4326008)(86362001)(6636002)(6862004)(8936002)(8676002)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 19:58:22.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b94ff4-50fe-4429-b337-08dbf2a7df52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

On Fri, Dec 01, 2023 at 08:55:38AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 30, 2023 at 08:29:34PM -0800, Nicolin Chen wrote:
> > On Thu, Nov 30, 2023 at 08:45:23PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Nov 30, 2023 at 12:41:20PM -0800, Nicolin Chen wrote:
> > > 
> > > > > So userspace would have to read the event FD
> > > > > before returning to be correct?
> > > > > 
> > > > > Maybe the kernel can somehow return a flag to indicate the event fd
> > > > > has data in it?
> > > > > 
> > > > > If yes then all errors would flow through the event fd?
> > > > 
> > > > I think it'd be nicer to return an immediate error to stop guest
> > > > CMDQ to raise a fault there accordingly, similar to returning a
> > > > -EIO for a bad STE in your SMMU part-3 series.
> > > > 
> > > > If the "return a flag" is an errno of the ioctl, it could work by
> > > > reading from a separate memory that belongs to the event fd. Yet,
> > > > in this case, an eventfd signal (assuming there is one to trigger
> > > > VMM's fault handler) becomes unnecessary, since the invalidation
> > > > ioctl is already handling it?
> > > 
> > > My concern is how does all this fit together and do we push the right
> > > things to the right places in the right order when an error occurs.
> > > 
> > > I did not study the spec carefully to see what exactly is supposed to
> > > happen here, and I don't see things in Linux that make me think it
> > > particularly cares..
> > > 
> > > ie Linux doesn't seem like it will know that an async event was even
> > > triggered while processing the sync to generate an EIO. It looks like
> > > it just gets ETIMEDOUT? Presumably we should be checking the event
> > > queue to detect a pushed error?
> > > 
> > > It is worth understanding if the spec has language that requires
> > > certain order so we can try to follow it.
> > 
> > Oh, I replied one misinformation previously. Actually eventq
> > doesn't report a CERROR. The global error interrupt does.
> > 
> > 7.1 has that sequence: 1) CMDQ stops 2) Log current index
> > to the CONS register 3) Log error code to the CONS register
> > 4) Set bit-0 "CMDQ error" of GERROR register to rise an irq.
> 
> Which triggers some async mechanism that seems to restart the command
> queue and convert the error into a printk.

Yes. For CERROR_ILL, it replaces the commands with another SYNC.

> It seems there is not a simple way to realize this error back to
> userspace since we can't block the global command queue and we proceed
> to complete commands that the real HW would not have completed.
> 
> To actually emulate this the gerror handler would have to capture all
> the necessary registers, return them back to the thread doing
> invalidate_user and all of that would have to return back to userspace
> to go into the virtual version of all the same registers.
> 
> Yes, it can be synchronous it seems, but we don't have any
> infrastructure in the driver to do this.
>
> Given this is pretty niche maybe we just don't support error
> forwarding and simply ensure it could be added to the uapi later?

If arm_smmu_cmdq_issue_cmdlist in arm_smmu_cache_invalidate_user
fails with ETIMEOUT, we polls the CONS register to get the error
code. This can cover CERROR_ABT and CERROR_ATC_INV.

As you remarked that we can't block the global CMDQ, so we have
to let a real CERROR_ILL go. Yet, we can make sure commands to
be fully sanitized before being issued, as we should immediately
reject faulty commands anyway, for errors such as unsupported op
codes, unzero-ed reserved fields, and unlinked vSIDs. This can
at least largely reduce the probability of a real CERROR_ILL.

So, combining these two, we can still have a basic synchronous
way by returning an errno to the invalidate ioctl? I see Kevin
replied something similar too.

Thanks
Nic

