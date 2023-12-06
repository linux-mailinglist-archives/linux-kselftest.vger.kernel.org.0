Return-Path: <linux-kselftest+bounces-1283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1A80702B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758351F21521
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404733454F;
	Wed,  6 Dec 2023 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mt2Nq5p8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CBCD3;
	Wed,  6 Dec 2023 04:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2ZW4Uy1I36HnwOTrwVM3AbLHB1ZRsMjO5PQffEWsgYoCfK/4y3JmeUZb9UiKWjl4f2LLC7iLCREl7GUh4zvNx82nRO5ih7WHwQZ1hexkMPWxhNSUrR0Rfjg20stOj8iwLuz+kGu392b1gogoH3vwGD/Q1nRg9pqDaqjCGduiTLSawdouHOChV/3WYch7341StK7GCc7/Iy5tHJCHkp0bzEM/TfNyYGQ4Grsx1xDPK3jcz3mEPvYo1Bo3b1D2DWRB9HG7/VKnSmxPZdDI8GL/1u778tk1s6MapWUdGqzZA0dyRZmtnW3z5k21wAKvSl36NHxJeA+TowtusKit1UrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiASVAiZSpWdhhLGvvk51Vq7VkqNO7eEICGgr9Vj+eM=;
 b=hBq9bC/gvqnJ9r9lWdB+nGBWZLZ+RGK0+N1kxq/MkqlXSUWTe+VKNKizmyyj7XI4VyyoDNdi1bQQaAF3d1ttQfikfIb3hmz+D3w2iMfI2I+LV4Df2JcLYBkchEZ9zh3yCYKhYOjvUNe3OpO2u2nYs3OSC8ZVhLRFtatNczx4dokIpSOz+6S1+Vg6Ay83mr3rMyja4NCRxst9BrQWW0D2B0ESlsgaTTe+WD1NQStsf6d/VPhLxp7LwKXjEyh59kWRXZ2hUbbblqv47ce81N11wKRjc+QX+Cy+7YVpHgAIf4QHQz51vxDtxi31Fc6lLjsD+CJxJOetIh1JY/v0xZuAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiASVAiZSpWdhhLGvvk51Vq7VkqNO7eEICGgr9Vj+eM=;
 b=mt2Nq5p8PWrC8dV928bk93R+i07GRPXi1Wp2Sv9B/B3v8K2jvO0w5ZDB8Av/r4f5aoDwuJy2hdiEZxbD2hLNAHTi0kiQdfbVNNX+BXuodgWns+64syJMAY678PsLo1YRowsYA4gr3t/Hq1QkDJdXaN2605ZENVLyTRpH8tHv05sEvVXR54SklslPiN/PUSgoyphRBfVqZ8Sc+nIZYJqm7fD3Byw+NAD6bdCT8pFqqU3+uJ/nAaSxKP++uHuT+uicwp8qoYWPU/wY+m0s4vHOsez90+9nLE8yY7PdT6UXFglRmPoitJBe/Wxxb7BhC2CSbRD9ahGA/rYsptIeVT84zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 12:48:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 12:48:02 +0000
Date: Wed, 6 Dec 2023 08:48:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231206124801.GO2692119@nvidia.com>
References: <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
 <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
 <20231201204340.GA1493156@nvidia.com>
 <ZWpaTD9dVge+suyv@Asurada-Nvidia>
 <20231204144850.GC1493156@nvidia.com>
 <ZW9e6hxyDmkK8bfe@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9e6hxyDmkK8bfe@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0340.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0f0899-9d06-4740-6e16-08dbf659958f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mOgMpZsx9n8zk+A9EbUBu1gi3JN0w2cJHWEpaQ59fbDMSOSdQKJF8H60jTggp9/mJ+neWzdPn1dy68V6mRJkd20KN5kr9vqmFs8pFWf9cvjElKQV3ScZPlucMnZrna0TYE648jjXNhGcTiCjIsAe3dv6zR9mbUZ1pf4Kk+y1pjsl8G6fcRZH+gtT8MjERDQlAajVBCaIG6YExVoxWTAfEza+L5+7XAhRhD91bFxoEw8vHQiHAKlhPvCCt7qrjlxKYmuCr+kRYrPP9bfcEALizhcGCD4/hFfTrmlpezcZVLMk8G9nEA3JK2FpsGEnbZ30TwKZzI1swww5u8+MSUCTaOxQcIvZ5xqk6ozkmm3gL8hwI7/6DUnGtajXNY6inkB74pHyaTrDdS+RO79a7jikp5p/cc3wEj3kMCC8Qx68amjZMwU0IsTcVwfXYWfkqU+hfyY3VYQ/IrstsFCzMq+m3fPbQf+zi4xdaiTIxC5BnD1KvFgdz8stH2evU4mToPVkby4Fu8Efed8EEQCyZUI61ndtVymHCILphH+VGzkS2M0P7AWa8akiNZtnRLg6QvvD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66556008)(4326008)(7416002)(66946007)(38100700002)(4744005)(2906002)(83380400001)(86362001)(5660300002)(316002)(37006003)(54906003)(6636002)(8936002)(8676002)(6862004)(66476007)(6486002)(478600001)(1076003)(41300700001)(6512007)(6506007)(2616005)(36756003)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFEK02X6s2M/S9RY4SydiV2SEPKPV54zhHv6YUN8Y9ujRVJcqcTHIKaCWnM7?=
 =?us-ascii?Q?hT4K/ZPaPvsC6UC3hOVlklouwu8zCavYB/eNuSq1Ct+KsvPLEAl40jZnzppj?=
 =?us-ascii?Q?+/Ysb1WR0BT3Kf/igW2yNbqh8H+YFrGZmPFCILllBCeIv+jQ8BQKSsh7E8nl?=
 =?us-ascii?Q?JsX6ut7QlyU1cE8XmUck5/AUytbEZP2GL040HhE+MEc8TvxDsme2zMLe4Uy6?=
 =?us-ascii?Q?Yk00kzMznqH1u2P9+QexcfvgYD+aXDcqHaTa389Eo7rYjCJP6LqQQl3NY+mI?=
 =?us-ascii?Q?UXEs3TfyWoAv59fasBLt7E8KzTidk1EclHq43lLe+lxCXczweuWPXLJdkwCo?=
 =?us-ascii?Q?Iv+6AyvO4iVN0OkCfxoNEv+IIQs6Y2mmarOs1l4WSuG75qA7zAp0bRiSECDL?=
 =?us-ascii?Q?JOWy/pVQzBzeNr14RFb92wA65/CA1UblDzgqZSgWdDI+iZ8f11ap7/0+LBzY?=
 =?us-ascii?Q?H6h8NanyzZ2rC9iFBfBGsoh4Q7gviZPZEbruqWbUKHdMu30U1RbxBjSUqgzC?=
 =?us-ascii?Q?fpE3H4j4rgwFPopEzKw0CJYp0hH89pxvDyPcjRPy1zM8SWBP7ulakl9iqIyz?=
 =?us-ascii?Q?l9ZsQdUBY/GawfoDBmBb+/e7Uyivs/9VjHV90r/wt2LKPlO6dELB1NcVnwdH?=
 =?us-ascii?Q?AU3zXo61AbJbo0+u3scZFVRAbBC5ejC5uk3a8GrGw/XBo8VfDW7WAGSGYagM?=
 =?us-ascii?Q?BtGdqxROFfub8Q6Ci0fHaLdMPA/7LPTZUHnmS3iBv55dVWneSrXZIYYv0psb?=
 =?us-ascii?Q?tdt15JpIJb/ifD5vWmGAuxrXclbYjxuHKpDrKPzaOyOslYh6nDeg9WUreApW?=
 =?us-ascii?Q?Zh2+3MQwf+oqVIBSx0gsQUunwL1EAWAScXcG42ND2C1FgdLNRIeakjCVCR53?=
 =?us-ascii?Q?Lw2as6V04If8Z77aorC1t6nlDH3cEfaQ6YJcepPAwBt8Jm7/Mvk8pDOQzVba?=
 =?us-ascii?Q?+azUeM9egBvOZlNrTJrH695eZ0c8oVs4qi0QNWpIqXdLy27498CVAOmPaF32?=
 =?us-ascii?Q?QkfDwZbNtHfw7/5rFbaCPPLZ+BN4iCIRdGlgFBOWDIHSV8kXQmrQZC5dbfHV?=
 =?us-ascii?Q?lIc47+ccFsecsp+k+4yphAE3IIP0FogdTytQQg3RmM+NdDjwqH/Q7W53mq2H?=
 =?us-ascii?Q?YER5imGVHT2ghQhVXQ/df9TE0Jv6b1OuEV6WDiKxxXy0YOKofYaUTtl1DZII?=
 =?us-ascii?Q?RWYQoKvS4aTR+rixvK/sZuVkodX+d3Wx0/Kaqjjm3VJV+7OuGSEvS8RHtm4i?=
 =?us-ascii?Q?5VTuM4QDckVqWqASUQdLTi6Mj30yqFK4RjCE6MdbbkTyfRBL9xIyHuqyQ9Yl?=
 =?us-ascii?Q?qRMcylopZvkGnoonJCAxBeu6kDD2cuZzPr10XE06fzLvtu2oKknUfPw6RVB4?=
 =?us-ascii?Q?IIfWC5vZwq97bpYZZeveN4xwN6JWY7ZB4Dbrw9KTNMQ0GO0H0k89xrNlct8f?=
 =?us-ascii?Q?GlyU6G+oPhFV4QTaiYVNJ4jxPptn6bEfznbd6Fm0MtlCp5BH8Jagul05v7oY?=
 =?us-ascii?Q?hcuG4/bDHYnDBYpqQPk5BdRM8HfJPzUnBKDPlh45S6gXCevSQfpPmdAjn7Gs?=
 =?us-ascii?Q?VuoHy2FVI4Tu+CBS1SiMLi+sF5Rq3fc2IAGYFXXk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0f0899-9d06-4740-6e16-08dbf659958f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:48:02.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlIZnIS+D7NqEn11AQXRsqiXcrQ84jq2JQ0Xm7GRRiOnzhxHVXmzaEefz6sFD9Oz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111

On Tue, Dec 05, 2023 at 09:33:30AM -0800, Nicolin Chen wrote:
> On Mon, Dec 04, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
>  
> > > Or am I missing some point here?
> > 
> > It sounds Ok, we just have to understand what userspace should be
> > doing and how much of this the kernel should implement.
> > 
> > It seems to me that the error code should return the gerror and the
> > req_num should indicate the halted cons. The vmm should relay both
> > into the virtual registers.
> 
> I see your concern. I will take a closer look and see if we can
> add to the initial version of arm_smmu_cache_invalidate_user().
> Otherwise, we can add later.
> 
> Btw, VT-d seems to want the error_code and reports in the VT-d
> specific invalidate entry structure, as Kevin and Yi had that
> discussion in the other side of the thread.

It could be fine to shift it into the driver data blob. It isn't
really generic in the end.

Jason

