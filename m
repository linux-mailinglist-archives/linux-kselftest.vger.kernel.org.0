Return-Path: <linux-kselftest+bounces-2597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032D822596
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 00:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF9428440B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB71775E;
	Tue,  2 Jan 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iA6Q09Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5C1774B;
	Tue,  2 Jan 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heqQv7jjEigGwOYgtQTlOSx++hWinCvHaikXxbfUwcdOYUWkgBZc4ub8s1Rotf7r+Br0HccO0wQCNPKWhJ+qk/TJCRSzvtezZcJy/tuA6W4CMTfo7etadpRfNekYbwuVGD1SAHzL1uisC0TMekVf97PIJ5G5myxu/g9NMqshJ/Xb9wQ9ZjN+Y/7X3Edw4m32P//sU/GEfYuIEPcoT/n95HoOkENXXt/x+KoxXwO3Yzytw5AnrIfiENbXZc2itEAR5Fxiwix+qY1iJRuElaIWHhgYylVd4tqKVijHGzWDkzSlYX3Kmcoz2gCZCH6yHMBjCbFEy0UH2QRSQWJ9auTNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64M0WdLQTn9PfDztld3HxCrwJ957aC/ktvULKNtW1DU=;
 b=IKdcP/s03s4neO/QGyqIjsnsBYftUJNLZmsYAizbDB7+pWWY7IeXTXmzwJFmJxEhGjPZxgEAaOHcrNcJ33NeBU8bA0ru3xz3ylB1i+h19jlTgy9PnOxt7/jCsr6vIl0qJy8eQrPKwOIha7uA3zXLvCU/FyyPI7BI0b074QpLoKuBVgk6iZJOlbA84pTnxPVGclq/j6cf+aPIy9mURwrslcXkmiTiyqbZi2dkjOLovgU0dLm3g6LDgkHIcsLbC7DZ/gq8C11wRz951CVX6mowsDhzSE8gwfPMLcTjiw8xQ87P44uS4O9OMwE1xyvuCLUL/MmYS0IzrAo6bP2YmWBK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64M0WdLQTn9PfDztld3HxCrwJ957aC/ktvULKNtW1DU=;
 b=iA6Q09LimsPy9cbhlDcRpm7J1Wfr3RcD2+1SvV9azqRJ6bnJcVuqQro3Lh/xYqb7cexnEMFuqqGJq0Zfsq7PWF7h7J0oDmoLk5mztMj07ADq3YkIeCL31QpH4ZS6OJay3ExdUlUKl+VYqT2cO1qjQQx+jJcCk6sZWt4b4tCzFXEZx3CEYFZKhgoHHAgxRNBbKRbqQSEWOTWBp71J127Mho6fnol2/Njj0l0VKD3gu9QXu7nCbXVKxi5C3i1Kqzr78ytxZLBJxQGSBstaO1/J1hFlOCdPvpyqjaDh9dxFezxJ9JLOehcWBFF10ZJzbDVTwG5KRwe7/V5HrndKuKdh+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 23:38:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 23:38:49 +0000
Date: Tue, 2 Jan 2024 19:38:49 -0400
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
Message-ID: <20240102233849.GK50406@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: f98fda61-c575-4519-df68-08dc0bebf893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZeVJmuVpzjT/N1/VZZbUclxVkMz63hh+Dicu9T0fy8UfQbqgJwsNw2dSQiwFK3L/M0vyuVXPH89/KkWzMzWIBrnLpz9/mjlYiKQR/KsOGUEUCiaHJiokZyasubPeHHcbOgxl54nl1dh8P07phBEQRgQQF0oo6/ytizd7u/AMzfSzj2xqPAdnzwQOnb8ieDWid9DFEW1AU5QwCzKDmOzVpqPK23Ef34MKl4GrnuvaxjTjM4AQLle0R/e2TCRQoNlUqxIK6Hnwf5iP80bu53Pz1v5dCbOlxHZEGyiUG6euq+qv1Kj5XlYK1teWygxJuNYYNOyIb//DHlrnQPq7r44EAZ9l5ABR6+KV/aIj1oT/EAiDXv+FYdSEUDD2TadUiqBk2uQmu3zk1pEH3IaB1mdh93whOixoYxDdF8MZJjO2T5ZZKkbuaOo5+ZhGTMn4wVMVpsSPF1j9GJcQ4RYRyA+eAQ6DAkHvRisen087yprwCtbFif9pMaJAy+v+OJxGsYOyQ7G0TE69WsVoH3Y+B1HYdLQaPqbSVVxidzTN3zx25jAqE8J5KHqUm0J5BLvaR1QW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(41300700001)(38100700002)(1076003)(8936002)(8676002)(26005)(316002)(7416002)(4744005)(2906002)(5660300002)(4326008)(478600001)(54906003)(66946007)(66476007)(6486002)(6506007)(66556008)(6512007)(6916009)(86362001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6UkIK3f4nPVWK1uiC4J+aUMMdZr/qA+fvqwI008xVo7Y4uzyPpcr0+gElv3?=
 =?us-ascii?Q?PBlRcQEWeBwKtQp1YKpO0M/Gj77hF986dzWZuVvXm/P0t7mEi1GQVzXHVk6C?=
 =?us-ascii?Q?u6V6mV3+wedCEXHyws4yVMw4xhKd1LEWsEeGUEQhDeLY7gI4t7MMCJHkHAzT?=
 =?us-ascii?Q?E1rjtnRplKWzMQp5yh0xyZW5wWpEg/Y6XLE9xuZ9ZfVfhK+z9GUSCnzWe70Y?=
 =?us-ascii?Q?jBnpJe1mPOvUQqj59JFReIR8DEwA7HIkIhm6CXTiLo0ET3ScMC1jg8/KaUDA?=
 =?us-ascii?Q?VXcETONv4t+C7F+v+BLSnMk6RMmANNLUgj+WsYaflR9epIj/HO7og51ijovT?=
 =?us-ascii?Q?JbahmyEg1N9HztkS8I82lIt6wdKqtBLtLq5H61PfBSDHjs8dlPweegR/uM+f?=
 =?us-ascii?Q?FiRHNmz437+ADtVo92mYbK6zi08oSelVzgSbJWEPCTjY6Bh4RhFD4rI2BkkJ?=
 =?us-ascii?Q?GyEBF0DOZED9p9vfYhESqOS+Zq5Tt+4ZEjxvhlcs/nxG1M2C0v4Bm9IeD8Gg?=
 =?us-ascii?Q?2MjAjUd5B4nL5bK1XTMrMbXdbd2FauWsL7dyHxQEBWD70TszbPrQvdOSAcMJ?=
 =?us-ascii?Q?aDeMNX2F7KEvfHbaCXiu+4J0VwjLxwQjwoe+lVfYxRLBf8v9v4fLxqTK9NJq?=
 =?us-ascii?Q?AG0dzYwo0xtiINWRsI/pG4zXvgCuYb10fkaTlKGA88+zhGi7JzITqRsKmUGg?=
 =?us-ascii?Q?VF2YhBpnRcMK74MckzRqEHSf3IMysFb1ekKy8DHmAeAYrv9/G7YYRygetjxl?=
 =?us-ascii?Q?P4mQ3Vm2TYgH8ISp0KBEcbhEvnJ5VJrGYWXubKCWsaH+Gcm8AI1RIrUBoD+f?=
 =?us-ascii?Q?O13QXqKGg+xtOtj7X5n22X1S6LcB5uKUKMd9RyHiBZfbrcBwba3/zVBkF5Cy?=
 =?us-ascii?Q?59I1+wYCccyEqPWfzEnnimUoSm4nWII5eWrcSaM/b+L+4lq3cD0d6+k4HaLL?=
 =?us-ascii?Q?f4rE0dL6hvqAoFkDrUR+hwhMVV05bCuHrVwZ0wuTPZj2u0SY/tpV59AyFDEa?=
 =?us-ascii?Q?MrgFGrQJnNPqXrgr43Z28kGCpvFd/F270j3t/X5GQpzdl/d4DpjJYr0hOeIB?=
 =?us-ascii?Q?P0+DlHHXK5ClIeCFIFKRiYM/dLyHMBEM8VnHnDJRvIEGMNM3tBlyCPaoRUBE?=
 =?us-ascii?Q?AFLIhu2yc1osaxRHpdB4kkEeruRl6oqmo/l/rCKYnL5nwnc/dLTPCdh8IBbl?=
 =?us-ascii?Q?WzFKj5hzCL+RwiG6eo3VHuFqr/KC5mrxxmiE/wet59kNQMXeT0QRMkOgWY3H?=
 =?us-ascii?Q?Cc0i0KtNBnW+TzwwpkU7D35Quo5qevlSPBD3snbDxtTW+vLqV67TMB2uO2y/?=
 =?us-ascii?Q?iyqkNnUvMfpJLdV/6rdajFzTeEfqOwHXKv5w7cjOZja6I9nNrNJnJzCWKMe5?=
 =?us-ascii?Q?pbUYAy8mz/g1fc4yn7RKxT6M/h7MkaiQZbA1zswncddeSjP2tlRfIeAC2ONw?=
 =?us-ascii?Q?Fzmi74XETatd7KnBlvrMoL7zVip7tlhXC+o32ve0MyWpRQZNSaoWRjWbYWGH?=
 =?us-ascii?Q?Qpt/SdWYsVyAC5eMmkeKZ42R1/v4dq+bgNU2eilDspDRSWh+eV/kW7nfRzmV?=
 =?us-ascii?Q?fihTAp4BUVegnS5wMPD4s6jRWeWZBXh/GCTEHgLQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98fda61-c575-4519-df68-08dc0bebf893
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 23:38:49.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1RqWvSk6O3uFJoPk5UsFUSH1CvKJPQPFGZgrRMmqf1e9Ym5oeRN9c4UKn2Zp9Rb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425

On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
> > I think I misread Yi's narrative: dev_id is a working approach
> > for VMM to convert to a vRID, while he is asking for a better
> > alternative :)
> 
> In concept, dev_id works, but in reality we have problem to get a dev_id
> for a given device in intel iommu driver, hence I'm asking for help here. :)

I think we just need to solve this one way or another.. Even if you
use a viommu object you still end up having difficult coupling to
iommufd

Some:
  iommufd_get_dev_id(struct iommufd_ctx *ictx, struct device *dev)

Callable by a driver (using the driver-callable function
infrastructure we made for dirty tracking) Is really all that is
needed here.

Jason 

