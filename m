Return-Path: <linux-kselftest+bounces-841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242AA7FE2AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4834B1C20CA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708C4CB4E;
	Wed, 29 Nov 2023 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWgjJ7jF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::604])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF1B6;
	Wed, 29 Nov 2023 14:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGPJjuL1A2ghX19Z4GKhWMkdNmV4VX7TZ+4zjyrH89JXZWBol+sBmW+PH4FV40HsJmJ9gE8FwYOnz9/RcwnY9bu1hpKvSTEYWcRccOLxVpF4KhqHlQ3k7digLNc/T/7W3fCvMpFRmTRTLqVp6lQX9q3eZyrNI1CdOvUDs91mIAnUsK6e48Dv9y2XZx6FLLSmaYwg5HuY5H9VSrZAKU5TaAOMmRP3tWWWzHMoFB6gjVQ+JR3KUiyLiVcDPSYgAllzMbkhLi8UBWKDJfUvGKwrKhd4rTsge7tEX6NT2VE18EwoqhAZFv1vRfPTmP/3pYjOnC0AykJZNweFdeJwLvQO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUUIYiooi48U7gokQs+cOO59oRM8q4QpIhJZPG4jd+0=;
 b=lz3QlKU/JrAMwxaGJhnMF+EOdBt1olN6jgamtXE1iuU2/g+HE6RyYu1oHHOXO6m1Wt3LK7gzEJUsdW2aFk2khuJHQXRq37NJPk1ZxwJpPyntFttgyEqT6y8MvvEeiw9NPnI3kFciNJs3BRtGKts11EEPUl9icLT2cPFN5NiCAjCnPp4X46lHEzNL/a4VMX3Qg8E7fHMNJ65YI4ZlBWzdQ4WXWjHl9AY0Z2SwB4ko87zaCWHzQ+vhbEsuscGubCl250Yo/krIF6keiAuJKVM0GOzaXO7cvbz16OlbLeP2UzOaxcDQ9O1jxAMH9XTflQ5Vwg5+uv3QP4xyP7Mj/5Pv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUIYiooi48U7gokQs+cOO59oRM8q4QpIhJZPG4jd+0=;
 b=kWgjJ7jFINnl9Dy+wunfrK7z8xH0nXqbMluuFiw1pdOpuKUzIbWTydfvNK9aHfpxhspYA42yd/ba3+F2xu0jG3DpWEolf6fIIkefGWlmGWm30RZLTMRPwOKS0Nz68ecg4wK1022f3aedxx2SUGSwJ82Ab+BlxmJc90cpGD8BGXeQMlIhV8R1ejMOKqp/IaSgduKzwfK1x3/W4UlMNrNTJxddrv69B1JkRbASZeAQkkBRUbZWINJjsoX826E0lOF9aaYRMe7Tql717nxxmBYcpn+EHZTBK1ddC4fhDvpQOIXWqpqUCiwh01gT3KhbVYHAIqTNxArl4u5KJuSI6jJHow==
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 22:08:13 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::1c) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 22:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 22:08:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 29 Nov
 2023 14:08:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Nov 2023 14:08:00 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 29 Nov 2023 14:07:59 -0800
Date: Wed, 29 Nov 2023 14:07:58 -0800
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
Message-ID: <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
References: <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129195804.GF436702@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4159509c-2c24-4c5d-18f0-08dbf127ae32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zKiX52CTXxtFxC4CzhllXqk1yHguA2ZzganmjtDKXbpK9DOeBSTDd//XOWv+AgPUOyTWyPzqVg5x0lNDOXZjlOB3HlCdbtHMqMMt8OG4YK4b/jvBZErX8EwM2Z+L7mQGPtkbP/Qv6ZwrIRht2P9DtG2GggxOZzefPSw2znXRsha0stqyQ1rnDymXIxZ4Lunx4RNUwXuMJQ92jdh5JTTj8YfUSlKv2dsbwb0u9zL8Rl8N3PKrqiu/VJhP3OmPzLRHK3W3ZuFUGjBhF08hu6JRaFxsORLDwUZVux3qCc/cssoln2PrKOlLAdTRW3IYwBYSgbfV/7odeGZTwWMZKtEfQ5ILqgb0F4dc3Lsa7c2o+T3EHW+0A9WvPyVc1nmHNvqBYUVtwPFpCHgQFU9z/Vaxnw4w+R8S/1eme9ttwPqQNG6xjNkoCZE+kVTcULIfoNkzW3iF/MaEyY6uj7RGh0uZ5KnBoBuWhdwwxyenMDeP9OgH8RJbocD3c1x3YiI3XULqDdSEc0fi21SgQkGLXDtILJ1SEbuX5zi3kEmDq5YP7Fnv8+XG3nwh7f0mZt4bgD36GWZDZiMM2eJdtIYnuZUiPxDW6UF7CfpEMZ9yzcjXeN4kp9HA6lzZp8giDovRoPlixsMbqfBvJwBPWzYARVc4BuZ+kjcRhtIa5/1KqeZ4RdMrIfNSheV2IbjnedhwidP+jVseasdzeHHIEuSJ86TR8RphVmd2VTI5n+Dq7qGV1qU0aAQfqtMBrv+Vw1LpY4+4Sv94kKr0Wo0UZeRsdmoLALZZfdq/zqbaAD6oLJXgwBQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(2906002)(7416002)(86362001)(478600001)(4744005)(33716001)(426003)(26005)(316002)(4326008)(9686003)(8676002)(6862004)(8936002)(70206006)(6636002)(54906003)(7636003)(47076005)(70586007)(82740400003)(336012)(83380400001)(356005)(202311291699003)(36860700001)(40480700001)(55016003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:08:12.9563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4159509c-2c24-4c5d-18f0-08dbf127ae32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971

On Wed, Nov 29, 2023 at 03:58:04PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 05:09:07PM -0800, Nicolin Chen wrote:
> 
> > > > With that being said, I think errno (-EIO) could do the job,
> > > > as you suggested too.
> > > 
> > > Do we have any idea what HW failures can be generated by the commands
> > > this will execture? IIRC I don't remember seeing any smmu specific
> > > codes related to invalid invalidation? Everything is a valid input?
> > 
> > "7.1 Command queue errors" has the info.
> 
> Hmm CERROR_ATC_INV_SYNC needs to be forwarded to the guest somehow

Oh, for sure. That's typically triggered with an asynchronous
timeout from the eventq, so we'd need the io page fault series
as you previously remarked. Though I also wonder if an invalid
vSID that doesn't link to a pSID should be CERROR_ATC_INV_SYNC
also v.s. CERROR_ILL.

