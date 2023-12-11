Return-Path: <linux-kselftest+bounces-1593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47A80D4FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA681F21A31
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BC4F5F0;
	Mon, 11 Dec 2023 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaF5w75F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF6A9;
	Mon, 11 Dec 2023 10:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX2o9Tm+LccykSN8xiXCTcS5I9H5mfzSctLGWZrca+kYpFhz96bUkHT9Rab/I05G0iPitmJM3iFpOh652e0n3RVQSloMUbA5cByBdPWV5gHLof69YtzUxHSx58dvzFMiBLSV0dp5O15mLwgdXk2kjDt9ov3yGt8xlEPngBYD945XPWPoJoYUlpKxIsiRnq/1+mj6V96jTigBQLPboamef66qBRcplNWTPN5RkAQQ8zFRnJg+ZQLFBUY3yG7arwl5SMY0rNCnaR1xWJRgWJYLmDKtBHNZea4XKMAAiYJgT/CPHj0Mpbls6Mf8I1XryhBXWwZx1zw/2YsVK5Kp+n7cRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/xnC3l3SqmD6BEEg/WXtbjRHvVtgB/4cv84Tm+0O3g=;
 b=XQbq0kSUkr0FVLE0CniNsw+5kJSS2ZoVU+BelCWTQBxECy9qE6XwUDuJ0tMPn0OYNZp0CspdKB1ktStI/+HGGqK0JxhRaA7n3KspaLHbksvDdIuGR81cAxhZgu9ql0N152TpCNTmhY7XCApTeCSrK2botdS7ZqSSNE79YVfD6dLElPTnnuUIcnU8GqeSLe0GHJgcGcOnxOxbOjItAlQUKYKVzn2bf/VHvKl4h9oMvACTiHAD92efMXYv2ZRMqsTWj3DDtrLpMc4rGwomSu6xHCnk1Bz1dlL41K5MkwLovm48P7It3+ELfKyQGr7ILoc/QAvLi4zGd8DGL0DDBkES1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/xnC3l3SqmD6BEEg/WXtbjRHvVtgB/4cv84Tm+0O3g=;
 b=SaF5w75FrB4OBokJ3Q/pRwl7CFUqMqkuFQDYbNqmdUOIRwnS67pBl4iWVwhnq668SL7VqMNhFww6cRU5J2YDzyJaQQV23gqeuPMuGdyL/SYIi+XND2s7C7jjTno+s021fcyv3jsUJpOSLIQVNwHT4uTeH6V0OBGAVGjZLiCdOY9n/i2PZs0Tu2yNzYsqvW3pTDd3oWIVcqkm8UpAfy3SmaBgbRVqTWCC1oxKLWapbnXwFRbL6celHmSR3+1peNUol6NIFb3T7fNMfR5Q1g7i0pXfvNS2e2LN0TJNo3T4UMQsxuZRdBPqQpl+T2OC6cCtaIJToIB2SNpcPXHgGgd/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:10:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:10:29 +0000
Date: Mon, 11 Dec 2023 14:10:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211181028.GL2944114@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211110345.1b4526c6.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c517f4-0549-4137-1c2f-08dbfa747561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eyk8VLPxLi1wTV9d4ZK6XkVhn1m4N6aOoUet2f99g6OvN3vTCml+9rQEL5EtQyOVpcoQ3xZX+GsLjGHscMZs9pi+IfoF7/4qjEuJORJ/8PiL5nZykMp9VLwaF7/3U1ciyRkXsKtcIP2+kZ6+Re2oAO/xd18Mf0RNX3jAZa2YhOH9liBbNxmice8pEB7YDRVJl+Eon5LFekXfrrX9j8IWOZNYgOj0LbmFA4Q3D+FCTP6to+n6JFJngLvCiMZaiyP3rAc+rPtY8zybNKcqtglLsoD8r8+QZVcploolUdDrEGSsU5UT+U8yCBpEDcKH6LzvHLZaEZDa2xYSmyC+lVeLPdUCQ2rf4bwCzG16rqkqkcWl50rezZi8hfm2R/rDz6KBbHHX8ABZhmrQh6wu7Qu3pNvRnWsg4Sc6EWjlmHpDr1IDEpM9co2jJkTSdGLFbZeg3FXIe4hAPIyxsQ/yLdsErqo3PdfS6k6NBrQ/QdGNd5G9Z/0a09jo1RC15PHITTMrNESjQL6Gz1PbeUKDoV6xCQSaOSOs4FAi8Z5iFxQeENZihKX/p9tTfdS2xIOLMhgw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(1076003)(26005)(2616005)(66556008)(36756003)(38100700002)(33656002)(86362001)(7416002)(5660300002)(6512007)(6506007)(8936002)(8676002)(66946007)(6486002)(66476007)(316002)(6916009)(4326008)(2906002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rbp3zue29QjY/LJbjpWdTegJ6D5DjXuxiivSSAua91WuLTUt0Mh9dPUe219M?=
 =?us-ascii?Q?y+QMVU2r7QCzfQB78nm51pqyvk6QVH7T9W4T2fHBroopfsQGjxmcRO+Izw17?=
 =?us-ascii?Q?lQ1MT4Id+R7hygfsW9fdLxEX6h4mkG74bky+fH9Lx22eaClEn+ZnPPz02A73?=
 =?us-ascii?Q?qvLqbCp7/G9OjkiKMGFS/nW83nhh4/aXswMQGvbmWIsBHUM8996ztiWC3v7f?=
 =?us-ascii?Q?CcQs+6FG5LHUMU9ALI7PKOY2qeImoGRwHrbvgla14S6Paj5O967KPcK56XpT?=
 =?us-ascii?Q?XES50bjv1CXIHE01d30I8KGa5yddmELAR5C3dkFw3M4NUzRzy254nSHKxvS3?=
 =?us-ascii?Q?HNb2nVrshFU4Hpg8DH2FQNuv9fw7lj6XuLwXM4YAJuBITfeHUPTfDhq6mF6d?=
 =?us-ascii?Q?JKDIiLs59v6lrfOqOXehCYUllM4+A5WAe7x79Vfm8buZcYp7nmudDrRlRFm+?=
 =?us-ascii?Q?buCEOzo89KlNEkxauaPtmsf5O9BOozxmY6qJRBBX2zGpYkLjIVgnBuTZz8D2?=
 =?us-ascii?Q?5cPzBymW1fghzXqQSCJgt3q1o1Qcc0cc2Tm8mkTVBK59Q3QHLkSpJTX0lTDC?=
 =?us-ascii?Q?OqSCCWI9rh6KNfnA4aVYfhRjkXji5yIO7pYAj/tjrPkoZ9ZD5WHnhZoOTZ5V?=
 =?us-ascii?Q?/5cdmhFjcT8iS6zl73fHzEOpvxqNkluvCaUo+ojhtO3vs9CRO+TASr1MOt1x?=
 =?us-ascii?Q?xyqcTMI3Dvb5BlXKWZrPJns4QCtxMjLpmCE4coHYlnLX9yqkuXv2dc+HERx2?=
 =?us-ascii?Q?bEcrCn3SWv0I9H/vNetoZ3XREdd+8G8Vd7kGLZdZe2qJyYWknPWho9UGbkX2?=
 =?us-ascii?Q?/FEIMgeAN5XHOZKrviBtIYaHsokB3Lr21C3Sedon+S0hxf9oZwlkmmiGkLd9?=
 =?us-ascii?Q?05dIxd+XkWZQjhueNazFypCS751p+Y1MN/UplfWi8W+iQ5RkWJRaLDVZt8GN?=
 =?us-ascii?Q?+aa5vs6Rr2JDXyLh8IprlOveWpN1N2QAVmKSTDi9ZGs7hHTBtQJoZNERy83n?=
 =?us-ascii?Q?p3kHZW24aqjoNJj0bwedMrSBO07tH9kzBMUDgzDDtHQFeKkJoT7N7Rdh4ZeX?=
 =?us-ascii?Q?5HCrvlgSwOySjZSn4WKChH2ISYD0O9/QBcJbfw/4gEKtQLhrt7MLqLW3D1ZY?=
 =?us-ascii?Q?bqzpGBNBn0IsLQie9hQsU0zCN01h71dtzbj/GaCc1ll7TjspO7MgliqdOvGq?=
 =?us-ascii?Q?wiQ5BoBHCj0+7Wj0F2vyf8Q86NXGMBpXS8DH+9xt3r95tYHWOPoiOXissjFo?=
 =?us-ascii?Q?E2R0ft473qHuMQwdFLtmtxwCD6DswkOlCtxSGG7UN484S3r2fHM4ij27bZct?=
 =?us-ascii?Q?NWEX0ahzjwyzL7bz4oY1d5zC8/JaAT4I5yZdOlacDI6WuzcFvYIMQfVV6x4Y?=
 =?us-ascii?Q?e7nz3GwOuqe9jBC45s1YYglvgj+JVkhTTRuJk6XSbjgs26P0umY7ok1SfucO?=
 =?us-ascii?Q?/8GMCaTQ70A8ceKhyi128JwCTxehgGO33Atuci60I0pMIec9io1FY3cjq17Q?=
 =?us-ascii?Q?eQngr49MzIkERS0fsiLo2NSo8kA4huMS64kIr6+VQ2yEl4v2ylfu9ulj16dZ?=
 =?us-ascii?Q?8YEaer2DKV1pIBz7F3eGVIIJJia3Eihw5PXERTdS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c517f4-0549-4137-1c2f-08dbfa747561
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:10:29.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ/WO9kKQgDczZOYLqMugx7e66b9J6HX1MKwblEJSGhwitxIOXP0c+ivvkzwtMhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548

On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
> On Sun, 26 Nov 2023 22:39:09 -0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
> > This reports the PASID capability data to userspace via VFIO_DEVICE_FEATURE,
> > hence userspace could probe PASID capability by it. This is a bit different
> > with other capabilities which are reported to userspace when the user reads
> > the device's PCI configuration space. There are two reasons for this.
> > 
> >  - First, Qemu by default exposes all available PCI capabilities in vfio-pci
> >    config space to the guest as read-only, so adding PASID capability in the
> >    vfio-pci config space will make it exposed to the guest automatically while
> >    an old Qemu doesn't really support it.
> 
> Shouldn't we also be working on hiding the PASID capability in QEMU
> ASAP?  This feature only allows QEMU to know PASID control is actually
> available, not the guest.  Maybe we're hoping this is really only used
> by VFs where there's no capability currently exposed to the guest?

Makes sense, yes

> >    the PF). Creating a virtual PASID capability in vfio-pci config space needs
> >    to find a hole to place it, but doing so may require device specific
> >    knowledge to avoid potential conflict with device specific registers like
> >    hiden bits in VF config space. It's simpler by moving this burden to the
> >    VMM instead of maintaining a quirk system in the kernel.
> 
> This feels a bit like an incomplete solution though and we might
> already posses device specific knowledge in the form of a variant
> driver.  Should this feature structure include a flag + field that
> could serve to generically indicate to the VMM a location for
> implementing the PASID capability?  The default core implementation
> might fill this only for PFs where clearly an emualted PASID capability
> can overlap the physical capability.  Thanks,

In many ways I would perfer to solve this for good by having a way to
learn a range of available config space - I liked the suggestion to
use a DVSEC to mark empty space.

Jason

