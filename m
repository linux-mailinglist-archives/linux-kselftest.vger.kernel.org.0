Return-Path: <linux-kselftest+bounces-2618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC58230EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4171C23A54
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D051B283;
	Wed,  3 Jan 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AyS6IZh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C911C693;
	Wed,  3 Jan 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju7J3XH8GQBh7Vm6yO3ThiEAA6AnzYV0pQ22y5N/NF3ft56+j6x3d14XSjwa8cL5F47IHojjOF61kDSJuOSirjs4bkCJWftxd7o4762meS8YvWHLLe5TyHOEQx6ZeBA2o8i0f2Qqw+5lDXUuMEUzJ6wjYZlK5pdDK3iC2r6adnxtlofr6oSbxdI6nQea/ruvSn/yzjiAUDtQGv0ARd+QnGm4yPOPk57h9N1UfjlAeYhdqV2K/ib9TGm5tha0ZAV581V1WdvR8dv1+DNWSgFgKoHHfPXOeiAKlH4O7WZByVNGvLF3V/pd6DY9rDJJWatnk4mMKc2Dvxvg8C3dsZOZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/aRLpfRzfhE2uuygvzqqsMAfkiKSNkfHOcGjqCSExQ=;
 b=cFV3CG1RnOh/KBAr1b9IzPtaDle8Ulyq0U8J3SwZ+eH4+gJ09h4CW5wI6m1IAa5xlG024z3o7lUL6t6KWJRET1WQxY5a0qSAh3EkEj1tBRlnb0OIng/W5/Hy2/8q0u66SBx48Kq6WCx4KdNoerbnQmiWM7VPTSX6uBZJ+uKxWSrvKgbuCJ1AkxWc7SOk72/jlPQivCR26e21RlASJpFEjdc5yKul0PUxeN+cDgvO4P+9OPy08kkAzHP/UfP77JPUo7QrLJz7q+vlNBLWhPiaJQQr79SkdZY+rvqE+U5JzBygazc10/haWENWqHTBXTwA9dorNYSHPbSZwuSYDUmkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/aRLpfRzfhE2uuygvzqqsMAfkiKSNkfHOcGjqCSExQ=;
 b=AyS6IZh9NTtYxCuY/+Xtlc7hyva+f6dc3+Gb+/p+KQWxKsQr263R5nymrNz42GmECv5hevJf2oMHH+gfeT938hCU7/KRoqlgRV7eTQD+e0yl+1Igf7djty0Zwpn1TlthEzebSZh/6TeVy9dSGMJR3xIZcQ9IuSLkhT9LQnOMPQ2Z1PEMGtOpnVoZBwngOLm5JKxZMaPTvHmLypN0NRWuGZ3MOP+96B5RgoBqRmXqLW7A4ZCtOihchGiVKhuGULYKEGHmaHhajauRWmLUBYgm/pquXrXwRIw3X+7FsK2uCIF02Z2RydSVfaU8t5SjV6I+Sp9be3EUyJN1UaQvwBkaRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:01:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 16:01:09 +0000
Date: Wed, 3 Jan 2024 12:01:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240103160108.GP50406@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
X-ClientProxiedBy: BL1PR13CA0268.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbb165e-ed07-4d1f-5982-08dc0c753364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dXONLMo/2J2tjM1QVnkz132gC74uIYQyhoMtQ8bKo3JCh0S8Z5Vm7dwaZxFbO7g4C4l5o3Jtyoi02PIVh556RYUrxQmD15qkQLsp90OppIkOUgaULPVYKWYsfUV7Hx5ld4JhFaMmQGATRlGP4jC+lq80M9hQWPP8YA17wjeEUjGK2UwqJPhm4OuGSMNmOeblnXy/d/7iMCK1Eard3RS7fJ464wBCGTk/oxLE/wg75iZryob9WXpvLs+aoD1X+e1CGyr+tGRQbXyPS07HSFdTAXhaADrUeCvdcJz/8zTZipZUhCs2R1OdPWtqoJnul8N9Fk/1bUXC5Dck3wa5LOZWHNhm/TGOSqHWaZxJRoWOIckR8Rbia78wIKRhXMTc0KyqPhJX8Ji3684QmHOhAly+Zc2a4hXGnaLRWrVo5/52MuHGFFZix4VHa4huNpyBRnfe0+HA3A0ghJfMgPxGUORdL8nm4pRjJE9eVnibsDw8nmU5YFhxq48IMUiIzSdrhs6D4PCSH/FtcK0h15ktFVpjlGZ0rb4f3fNiCl0fa8rB7D/dPWiOyGea08VdfyX3bIFP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(36756003)(86362001)(2616005)(26005)(1076003)(6506007)(6512007)(53546011)(316002)(478600001)(6486002)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(54906003)(66899024)(83380400001)(33656002)(5660300002)(41300700001)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0eB8JeWl8iVrOPvLE/Q7NzADTd9/CsCebsgm8y3VwyEDxwJRUKuaS/Hd8szJ?=
 =?us-ascii?Q?ycvwdZpafo97Phhaiz/4mS7DyIihUoFX7Ql29zBAloj6j3JuzarcyMwFLnto?=
 =?us-ascii?Q?jtqdURvCLHmI29VPCH7t9lfD6zAHri+w2HR27x6LuV03YWRG5Kw2LGDNzjmN?=
 =?us-ascii?Q?x7IiQIxbGDYnh6HkXxEmlRO7J0y6w8F6eVsjJmrpCSFao0QPWTU6YzIFOwWW?=
 =?us-ascii?Q?m5UbNyauGCijKZhQHTuukPsEPGmbdHwFqHfWs/fl399tTcFNr9lk25JExmey?=
 =?us-ascii?Q?qN3hsdkD9bGva3Z+kGqfD+Ar5AlS3EZ+dm/8xSb3vjOehasTLbsTyBBgkeuA?=
 =?us-ascii?Q?RNgfKCEelf9FCawqElLeGi4xjvWtBGFzPoKK2SnQzRplYEtXGGUfcq1CVa4S?=
 =?us-ascii?Q?CEUhyDmt8GnX5nFhT8GBRIqmQfqp+5V/UjECHvc3+cv93QTfkZ8Lydx5x+YD?=
 =?us-ascii?Q?SHivpOG+szS/frUhIoGIbs175eZu96QXWOIA2hvJamqK8c9Bj8GVM4ypjGTL?=
 =?us-ascii?Q?a2CFl8cD2zOcMXUqGersJX5zMC0N+ozb13eICSI6QFW8KaBfazjrTpVufPhi?=
 =?us-ascii?Q?6imPf8JwVbDPFXLgz1nUY2Jwt5cE/qVeGPXXZEYy7ZAxJKvnlt7hqlUrTjbf?=
 =?us-ascii?Q?JqlMT3Ny8ZOy22SbwVPRLUtZtaD3f/LvKyvbEyucwllMS06nJIY20n5TLESI?=
 =?us-ascii?Q?smhJaAJfD/VO6VhaTQ87SKCnTuhtJdbS48pKWmS0Rwg8zPnVgwWuZZXMnFz2?=
 =?us-ascii?Q?wqH7JvQcVkppMA2djZzQxE6ExhuHw05kMa9u7tVkLJIt5xHppjDIkdKYqesI?=
 =?us-ascii?Q?99gBLRwMcM+985KH5b6BRDpeDkLseTcDnciTxp8RONmBNGB1KFpIEREGxY5A?=
 =?us-ascii?Q?inPIyNFaSRM3cWChQhTtwts9NKtdHFnmNmklOUwypPFqu3xXqJuUkSEmTJQH?=
 =?us-ascii?Q?eJXVyuaejELUTS4TmxJaYugAKyx/aDDO4qzJTS37RZDKZCuD9Z5ue/oflQZp?=
 =?us-ascii?Q?f/8o2glQkFBEN++8WM+cUStLZBu2P30Wdtwrrhn0XQrOnd5hITAZwo7UKpsz?=
 =?us-ascii?Q?SdmdJb+SSpPUdZbsu321QSQX62FgBxIbJHfWUxtoGAmVlpEcIb0Q/4l1xmS1?=
 =?us-ascii?Q?cAXtPVl+ybfPvcic+swCktvIr+9YuI7dHfZQ+NQwiVaXNJDlOfVya5NlbxP1?=
 =?us-ascii?Q?r6A1cFkAP+6V1cq10kV8km++CZKnFmFQVcIyHmVMoRwiQA+QRHaK83lv6yCF?=
 =?us-ascii?Q?mMMwDUp3OQ4W5qEvrn7E7WMBRrn9YgFl9oW3VpH4kwwAfPiPMZMzbcB60JhR?=
 =?us-ascii?Q?9VgpeEtWXnpyV2xX9VoUzzELHL7seuLEnI+6AIU8uqBQ+rYpS04IPHjSDfPU?=
 =?us-ascii?Q?Fob4Yyong8Gh3pZtw2neM2DezEtfUvMn2M5DvSXjAhEDJSlqDqqkT4rEJ73k?=
 =?us-ascii?Q?6mfI4oF7NoX88SkoHuLEe8qrGaToKuQQtFi8eWKa1l2cwG3Yr5+8nbxdXFt3?=
 =?us-ascii?Q?Viur98pi62DcIVvyFOOaRxgTmYgvXRsPCMRjJmvYRIorbtPlaaqcLTjpApt6?=
 =?us-ascii?Q?l7R5jHIdVVbJqzRxRh98bQubPuTAqrmNn8G+9cuN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb165e-ed07-4d1f-5982-08dc0c753364
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:01:09.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVZlX6fTn8rvqo4itswMyWMBNnLabcwOh9gSfbgSdKQdlGi8GHXANcUIpHE37WlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

On Wed, Jan 03, 2024 at 10:24:42AM +0800, Yi Liu wrote:
> On 2024/1/3 07:38, Jason Gunthorpe wrote:
> > On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
> > > > I think I misread Yi's narrative: dev_id is a working approach
> > > > for VMM to convert to a vRID, while he is asking for a better
> > > > alternative :)
> > > 
> > > In concept, dev_id works, but in reality we have problem to get a dev_id
> > > for a given device in intel iommu driver, hence I'm asking for help here. :)
> > 
> > I think we just need to solve this one way or another.. Even if you
> > use a viommu object you still end up having difficult coupling to
> > iommufd
> > 
> > Some:
> >    iommufd_get_dev_id(struct iommufd_ctx *ictx, struct device *dev)
> > 
> > Callable by a driver (using the driver-callable function
> > infrastructure we made for dirty tracking) Is really all that is
> > needed here.
> 
> yep, I noticed IOMMUFD_DRIVER was selected by intel iommu driver when
> IOMMUFD is configed. Maybe such an API could be compiled when
> IOMMUFD_DRIVER is enabled as well. This does address my concern on making
> intel iommu driver depending on iommufd. But still need a way to pass in
> the iommufd_ctx pointer to intel iommu driver, and store it. Hence intel
> iommu driver could call the above iommufd_get_dev_id(). One possible way is
> passing it when attaching device to domain and clear it in detach. However,
> this seems not ideal as iommufd_ctx information should be static between
> bind_iommufd and unbind. But we don't call into intel iommu driver in the
> bind and unbind operations. May need to add new iommu op. Any suggestion
> here?

You can pass the ctx to the invalidate op, it is already implied
because the passed iommu_domain is linked to a single iommufd ctx.

Jason

