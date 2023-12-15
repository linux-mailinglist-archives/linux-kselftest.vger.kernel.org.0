Return-Path: <linux-kselftest+bounces-1979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC34813FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7D1F22D45
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A0A48;
	Fri, 15 Dec 2023 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h1dTzdee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EE5677;
	Fri, 15 Dec 2023 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOGESuB72tf/ws5D0yhdmJvO8B+WxQpJySMyeTHqPnqywinVxEoLJ2fRKvnGiQwywpQzDSey1x0UCunXRe5xEMIEGAtgPP4sxuMj91IkM74p7Z3yf1NsQBFT4iMbpiaBNt1l8lFhiEFc9Vv973+02DKinAMop0eH0ycCSzw8Ows4lI/hRLShRz6d5jR2vJolQY7gR4o+9nZXuRutmS5qvE6PFfD66Z5KDEiNZ72zUcfHESipVk4RIX6ZNdXgPwJlqcOjzlPE+lsjd87aMw4x5tx8weL6D6dYRw5KW2LtF4JfMUrefACkQDJwAbvT7L1Ul+/jkGxwxH34D0HhsQmlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXJx2X7/7VnCZmUPtiFwmo3ijKCHE3OHxjfOVVOhuz0=;
 b=DKE8/8DvJT3EGnfACK4A0dBXC8VGxPCG+BAb2h9nK5ZFLejoMux4Ib6FvT8R2inq4VzvaEi22Kv7D9HLDtHGTYcvDR694QDessZH3z7i8qKjPGjdNI8E1lclPSm3RmpBWlMG+0y852oJnBydmsVgVZrvUmn7P+HU7tc4JM+tU/zHLK//ny/Qt8VpUQ7maegV/S7ZTe8etpVtj+r/f7eheUelaqAen/ZJVxi+/IEiiCMFV2DI1REENiYtfw3F3WY75ngMETWwv1hx2Mk53dAOQHtEy9YNtZiR0RXHkuCRRiZfe28DDLmTBVeGTuVOJjSH60bqTiTImMnLod4y6bxjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXJx2X7/7VnCZmUPtiFwmo3ijKCHE3OHxjfOVVOhuz0=;
 b=h1dTzdeeKQyQ+jxzgF64CS3PccsBrFzgkpoaEjB6z2XwZ7Tx4xCxjm2bmNURYqryPxGhxJfctG1jJA7IXSiYRk8kJivakAnCYHbCTicUZ7X2fKBy0mWbXKGyFHeSr94FSQFLuRb8Mk579rU34YRovBV7y3ZNk8WIvAnrBJgFbnFtQ6fPS98IU8ddV7A8mASS/kNvuHatS+jza8Ru69eVR+ngB/6V9BNN8Ze6Y2riWtcZfMWuvdaJdXUg4xwHDy4a1RfSJ+MxtgZw8urYzlCYwjCwM/J2mnVqhM2IcIJatjaAFT/jxcT4wcKMrZPWb7JM8uh0Yy5INy9m3t0tlZ1H9A==
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 02:28:42 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::2) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 02:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 02:28:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 18:28:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 18:28:23 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Dec 2023 18:28:20 -0800
Date: Thu, 14 Dec 2023 18:28:18 -0800
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
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZXu5whlIGfiq16wF@Asurada-Nvidia>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: cd61511f-5548-4b3c-9a38-08dbfd158dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HUOlvk6Okm8+UBPG+WRaV1WjBGWg7XAKXupDSAPhNp/N9+eo/FOsuqlN/zmynKuZoFfd/GYEiuC23I/XqOMMFVkhPYk40yELyOko88SABD8/YgfrnNX+BmvUrHKKVsjEt7S9hyZxGiAGZE/5rTVsuC4Px/+pGjZmHLYUqb+itIsJwfvnlDSDVOgcueOUofDNMbb3SnFrRYtWINU/ch4QG1SGOqtd2Di44syAOHDPZrODeCvibMt8wPhB+ay73HjS1JsDWQbFzmmhXTdBB34g5KMkD3EgJaqVgfdha1DiTL1PfJnqUkphQ7Zn/HZCw87nCuZED0iN4ChCEhY9nDXluEwbppLyDtgxeD2plo/9bB50AqYxt0lwZ/jJAuVxbMyFlv7ZHry0ayBJSRuHlw8VUP+WH7gvEVteaKhIYMD1fmn0g9lCq87wsMI7f/NFnBEoi1h7udZAUX10wcimIPuzYEeylWbaRK8DuHanT+YYPR20QhRbpP4uZciIozfMKuiBj1Sz5m6cZbRf/SJqlxvF+Ka9jLpCWE8MGSgqlcq4ApCEB7Yv3iZSyUQwxSt0hGn6rcRSaKhVyAET2HnotaIacr1WXC934S4IFrZtJj923tq8aUe88MihQ5IUINFQDrigwucuQ59QSxOboJZFG26ajlJw3RiY0iiR8Vad2prdlI+Bu0H2G84c8w9MXi5dxJfpOL+DefiapbM+AI3Wfshvgjm/6wK9D392kiV7fL+QpfW994J9MgJMqXW5iuA0P//7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(5660300002)(9686003)(7416002)(86362001)(33716001)(336012)(426003)(478600001)(36860700001)(47076005)(82740400003)(356005)(83380400001)(7636003)(41300700001)(54906003)(70206006)(70586007)(316002)(2906002)(26005)(6916009)(4326008)(8936002)(8676002)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:28:42.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61511f-5548-4b3c-9a38-08dbfd158dfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, December 14, 2023 7:27 PM
> >
> > On 2023/11/17 21:18, Yi Liu wrote:> This adds the data structure for
> > flushing iotlb for the nested domain
> >
> > +struct iommu_hwpt_vtd_s1_invalidate {
> > +     __aligned_u64 addr;
> > +     __aligned_u64 npages;
> > +     __u32 flags;
> > +     __u32 __reserved;
> > +     __u32 error;
> > +     __u32 dev_id;
> > +};
> >
> > dev_id is used to report the failed device, userspace should be able to map
> > it to a vRID, and inject it to VM as part of ITE/ICE error.
> >
> > However, I got a problem when trying to get dev_id in cache invalidation
> > path, since this is filled in intel iommu driver. Seems like there is no
> > good way for it. I've below alternatives to move forward, wish you have
> > a look.

> >
> > - Reuse Nicolin's vRID->pRID mapping. If thevRID->pRID mapping is
> > maintained, then intel iommu can report a vRID back to user. But intel
> > iommu driver does not have viommu context, no place to hold the vRID-
> > >pRID
> > mapping. TBH. It may require other reasons to introduce it other than the
> > error reporting need. Anyhow, this requires more thinking and also has
> > dependency even if it is doable in intel side.
> 
> this sounds like a cleaner way to inject knowledge which iommu driver
> requires to find out the user tag. but yes it's a bit weird to introduce
> viommu awareness in intel iommu driver when there is no such thing
> in real hardware.

I think a viommu is defined more like a software object representing
the virtual IOMMU in a VM. Since VT-d has a vIOMMU in a nesting case,
there could be an object for it too?

> and for this error reporting case what we actually require is the
> reverse map i.e. pRID->vRID. Not sure whether we can leverage the
> same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> and then store vRID under device_domain_info. a bit tricky on
> life cycle management and also incompatible with SIOV...

One thing that I am not very clear here: since both vRID and dev_id
are given by the VMM, shouldn't it already know the mapping if the
point is to translate (pRID->)dev_id->vRID?

Thanks
Nicolin

