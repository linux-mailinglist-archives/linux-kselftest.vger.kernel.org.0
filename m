Return-Path: <linux-kselftest+bounces-665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082067FAAA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D2228198C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83C45956;
	Mon, 27 Nov 2023 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FF5K60Oz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875EB8;
	Mon, 27 Nov 2023 11:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc5wS1dLKhT8jT8dHcwATYf4neWH55awOOOiX7xiQpkqQEH+tERwerrdaLebvKKpbSiMCVZhLAMnwYvgGj3x8uDpCy+WHrubVbJh1B4SjfLYJZGZO9MmCaeUfD4TVt9x3X3CW7dp4d9JlZr8o0fLCOucTlmi+99U41aPd42uqKC6GrfFsMjonCG0NnqRm1WHtWdkjO2MS0vysoSHH98SEKJaR0U3KJCh6S0M9SOFhyT7oDjV23rKwJsgR+++p73zevzP9TG7/tAKsRruyTdmNP0887o6SOx52XlSHT39s740sqQjdDHGeE1yJdi/CzeDFb0LTpD+IDEANc4wRfPa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq/pLOnwq+TxmAcS9Ulb+yiBRt/seeNqlfBY8iwn70c=;
 b=OkUTPuGc6OoejG0jXzSoVWjp691GUtbtBfPuaSFzS2YBzI93/9lz8NSUsetWzFEKnNXalQm5gkjPJPurni2oR+aeAZ3zBUXhufhOJra5b2IP294uSUcXBLRE738mf2ggeTjaN37P42ATUTdImBtSf2mDZf+fwCTWxS/F9j1WWigdeI6buoOPd14mwAt5WaPHmFnWdEbqMQZQQwHNW1GjBXwjdvvYE1DKXs7/zVr5cfGhyh40Dq0fceo/UQl5TqWNRI5y+rfXWgNQxIjzPK6u6saANppIQXPWzD7XKSIFjm7KQl+cnKexif2vvPoo3F27zBZ3+mjQs7vq5CNxeYZaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq/pLOnwq+TxmAcS9Ulb+yiBRt/seeNqlfBY8iwn70c=;
 b=FF5K60OzAyrOAxO4vJ4BZ2oXonyReykYgv3EOUnnuv1q4Oj1iJp6AtqGWHsrsiGwYRC98hn5Q4xeUyi3gHrBASmKnIR3JsT8fynuZ8C7BecxZsDeIQWG/KsjognvRuqceP0PnF/lbLiw4sGD4HO/BkduWFwnbCzI/l1arBt+wmsOWu2gf3NzQ+gT4VXJe7SPMIZtT680rTWpZg5TNmGlr3ouZcp6jSZ2pihq45sj9iYUIHkwi6LB6rpEGx6srgF1zlg5pUN4UVyWrnscunSnQ1w6VlXETnXdbI4zJWAZIdEQSDqKk+BFkBpbjox/z3MiBnXKr6CZ2DzGCmjdTq83fw==
Received: from SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) by DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 19:53:21 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::3a) by SN4PR0501CA0104.outlook.office365.com
 (2603:10b6:803:42::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21 via Frontend
 Transport; Mon, 27 Nov 2023 19:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:53:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 11:53:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 11:53:07 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 11:53:06 -0800
Date: Mon, 27 Nov 2023 11:53:04 -0800
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
Message-ID: <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cf8543-16d3-44e4-23a3-08dbef828235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GqYkn2uaDstpEupCzyCwdHnPZrC3ZubtJSiJPxLEnT0G2bfIEo4ziKb0BiV95JLjc4BS5P8XUhzNIKdTV40YkL9oORCPh4gg7Ohh7jPmP2Fj+T8Qth1OXab3gtUlJnybJ1Jjoyj1xZj85HpjfjviyuDxdhl0KNxy87tfMsECENRGmdiySsaYFUL4aj7JxdDuyjtOLeHcSHw9FlK5Fxzn8r4VIxRsgGd3l1+NFe7vtJfoEG9S9DR29WvhaC9fiXPMy3Mx8+8C0ktgmortLmhThsBHVFEfbEBa8ai00pkqwDYltm33kLPGLcEj5bfxapQQ8DPzCxnaxkuYe11ZcyU3wxy5teTyxUDa4ex1F2y0Av2JOL5e6xYJI3Ju/P+/f0QQiyoJs8nGeWGOEBZizbp8wSm8BdBvrzmg4/RNdLEoLKQEsuezOH9CMUb+e9NDOdipGt5Zrv095xQA9ElnzIkHlY6WQp2glBcs4yBDR8MmXqpCAv8f4kucOyl3gHNORu9BAIZReOYhyL/lcFUtnu9EAxTnfD5PWeyGoSUhRkU8XzUZrV2xGItgls6uRXPWmKZ4+5VHZaUg6LqBmGZVTs9W098FpcUDrOXve5V21u2Yw3fNLZdFYQ7mjWsQAr71OFzLYDG37xgw0sfgcfnQUdlZezJvPSG1Mq6yEubhYyfnBDsTT1zTQSpWNmXki10y7qro4mAgeoKSH7fszJxGNJAlM86Pknwpe8fdtC7dl8mOG3e5qAjXVE/PT8JzH4UO32+g
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(36860700001)(47076005)(356005)(33716001)(55016003)(7636003)(336012)(83380400001)(426003)(7416002)(82740400003)(5660300002)(70206006)(26005)(86362001)(2906002)(70586007)(9686003)(8676002)(8936002)(4326008)(478600001)(40460700003)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:53:21.1114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cf8543-16d3-44e4-23a3-08dbef828235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

On Fri, Nov 24, 2023 at 02:36:29AM +0000, Tian, Kevin wrote:

> > > > > > >> + * @out_driver_error_code: Report a driver speicifc error code
> > upon
> > > > > > failure.
> > > > > > >> + *                         It's optional, driver has a choice to fill it or
> > > > > > >> + *                         not.
> > > > > > >
> > > > > > > Being optional how does the user tell whether the code is filled or
> > not?
> > > >
> > > > Well, naming it "error_code" indicates zero means no error while
> > > > non-zero means something? An error return from this ioctl could
> > > > also tell the user space to look up for this driver error code,
> > > > if it ever cares.
> > >
> > > probably over-thinking but I'm not sure whether zero is guaranteed to
> > > mean no error in all implementations...
> >
> > Well, you are right. Usually HW conveniently raises a flag in a
> > register to indicate something wrong, yet it is probably unsafe
> > to say it definitely.
> >
> 
> this reminds me one open. What about an implementation having
> a hierarchical error code layout e.g. one main error register with
> each bit representing an error category then multiple error code
> registers each for one error category? In this case probably
> a single out_driver_error_code cannot carry that raw information.

Hmm, good point.

> Instead the iommu driver may need to define a customized error
> code convention in uapi header which is converted from the
> raw error information.
> 
> From this angle should we simply say that the error code definition
> must be included in the uapi header? If raw error information can
> be carried by this field then this hw can simply say that the error
> code format is same as the hw spec defines.
> 
> With that explicit information then the viommu can easily tell
> whether error code is filled or not based on its own convention.

That'd be to put this error_code field into the driver uAPI
structure right?

I also thought about making this out_driver_error_code per HW.
Yet, an error can be either per array or per entry/quest. The
array-related error should be reported in the array structure
that is a core uAPI, v.s. the per-HW entry structure. Though
we could still report an array error in the entry structure
at the first entry (or indexed by "array->entry_num")?

Thanks
Nic

