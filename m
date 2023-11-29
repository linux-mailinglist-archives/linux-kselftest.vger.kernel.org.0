Return-Path: <linux-kselftest+bounces-839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C17FE09F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D02826D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021735EE88;
	Wed, 29 Nov 2023 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6LV1RuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE78194;
	Wed, 29 Nov 2023 11:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTy+1+dw9lDg00ACCYc0lVwhizUt6CbRqq1NNcDFPCSkVLEv19p/xY9VzvG6CJygZDiXLWgNehrO4+zD9Uto0ATGMHYi6imS6dPIjz+7K8alC6ATdrCqofvG+TaU2PIGaBfRZU8lAMKzrUXBP8kn7aQFvVS3PUSbGaoaZUOxarj1pYOLnSLyWJLIhF4hsEa8Q28SVhYGZGV7JvfKhBIEREvvMzsN4Mtvj3Gtz9AMek0LdSsPFq8/KKfKQAEy/UK/s8bQz/2DMV2tAF1tPUCXNmY5nK3gvOBxm/nmgo1yjrZXdmeeOcjkvkTL9Gcr9ksjTZBpHhyaK0bxsyBcB3PZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcDo2D5d76SVHVy7HjQVohB0alsvv5eek/D2N4Jqn0U=;
 b=ZfAOc5HWwJb1JS8gV3AoWLvBM8gDedgj50oXN1ce7OVH9+MUs9gEr7JytIbEYUeQLXGU6lar7a4rtNdNPnmzH6naV2+wBrCeOgXv+cRixcv6T2BjH6kCK+1nwsg+xZEYdi7VUvWbyJo2HACXuy7WSweuFZMcImpkMAzkclUwm/3pgKH8zJ2HgkYQhocsj+ZDz1lestKv4XZecXRhOVQ+Ysbj/Hs2IV0N9fiS3LOQNxWRkkZdBBV8YrxBMFrdrDKKT5ndWd5LQHRm9BuMnbScdvZLVKQ/PA9RcMK3qNGmzi1IDAWcJ2RZjXw/fhk5koKWR2u2tZ9ICgqZIdCnpLjvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcDo2D5d76SVHVy7HjQVohB0alsvv5eek/D2N4Jqn0U=;
 b=F6LV1RuJvN41STRSsp3FUeuXhQ5PGohNuJkbqr6eGQLFmUkccL5Kq5dSovO0RivFkEK7uxGCQRhdiv/h5ieIyS3eDnMZNbkDJtDwDbdeheaoAgK0ot6cAiys3muLFu8kP0/Es+H/Ymtm56g1KP16qlFBhBh5cOLOt3uplJuQOOlKOFPt9KBfcacd06gXzf5Whpj+bdNDYLv5/lMKRbmvLusXTPNrHuOtne1z12xhvL+CUAw/qJXi9/su2kJhHeVIFXu8x6/gqgWf/GLj6yokr5YdlWKUEHv0LYUNGqLuRujVQiCowDZtm5/TjDMrbfAY7Rc+0O0MFWLacvec1eSAwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 19:58:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:58:06 +0000
Date: Wed, 29 Nov 2023 15:58:04 -0400
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
Message-ID: <20231129195804.GF436702@nvidia.com>
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
X-ClientProxiedBy: SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d87845-c4a2-483c-ed8e-08dbf11580cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M5cC4oTTseKbr2ygssH+do4sTfmQqT4etUlfAUyE7orjvtXdptL9Aa3jakeygmu0n8E851YHKdIJnqkx04dl3gxSTIejkTStm3xt6fjMFLpLCiSWND9UMgu3tww0mz7TkfgO6VCukVgbcdpGJ6+MzW5pBHc4UOSmEZCwSOuk4r0ZjTog2bkDtdS4ygC8X2eW1SA/QxuympCTj/Bj41p8qE6lMWf488bxSiEs4ar2X6AOMVab7pO3a3tB+sT98WYoke700zhJHVMj1OlFruZdrpvC9RWZjwrTdo7nGSdxStSkCw4mNvD1URKl7AmnAaWjrVdLz6Mo+q/S7KW7VaTQrUTJyM+c93dO+7TPQPkVBlqdQoybiCnCt61oE8TUNTQUGo9U871IupwH3y02Gse6eWzMSRIxGNk2ADQ6SqTY00JXgTzhyEHvKrJBDBvPJ2EKW6i546+pHlmdL8XATrPPE2qWAmxhxhl/9dGAHWjWXdqFyZIOVT6Wkpa/F24eXDtrbk/OSyR3ENIxqRnliCqjGXhkv/v6JZ7QRbTnzyCRkfPB7jyMTG+0JPY+tOQFnxeNgLjB0K4SI1AnMeaiAnN85fXm/fIBgh11RDR7oqBrczEbPkTc7VZI6NQyISJ8fPMRMzU/SXgGDA45Xq2Wv0y5oSP6tBxOYW5fiDMfeI3HndA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(202311291699003)(6512007)(1076003)(26005)(2616005)(478600001)(36756003)(86362001)(38100700002)(33656002)(4744005)(2906002)(41300700001)(5660300002)(83380400001)(7416002)(6636002)(54906003)(66556008)(66476007)(316002)(6506007)(4326008)(37006003)(8676002)(6486002)(6862004)(66946007)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wk6RMyyfmUj7c+6yPj6fdNMNPj9Zne2uPvWxAmjvTg1wtXUgQekTo/8N5uyj?=
 =?us-ascii?Q?rOcpBk3yhK5Ms4018Ffr62kIPw1h0ekx1mUX2szna+v+zqpdpohhxYYqd03D?=
 =?us-ascii?Q?7kQe3NdpxoCOS9patNVDhyFAHcwsqcAsmCwWVvHQfHiD6rCQJR0/sHgg4pZQ?=
 =?us-ascii?Q?BScgSLntdGX4kSuo5nInh8q31509fSec5NNglQZZFziHwSz+MDjp6Wwlsm46?=
 =?us-ascii?Q?ltEWF8Eog+TNds6cYwwRMLxaBWRxWiGrgL2z+Cqnlk9L+LYYJkxxdi8HJkKI?=
 =?us-ascii?Q?i25Qv1G8/Smd1ARCCuOAOB3FcJhWiaHwEDxRpdkrKQth8yYr/gAtxXc6oKjm?=
 =?us-ascii?Q?/B8Z/4h7oxQSjNvoFxS+gYm1oCL05kER+rCZDJQXF1N3dw8wwVZbkZbmEBBx?=
 =?us-ascii?Q?gXQvz0ZplI5rqwe/U7Epp5/EorYl0Qf7jzzaJlqEylGd1TIUwjQzjhTPFXRF?=
 =?us-ascii?Q?MFRf6n2cy+dkqI7+wf5P25rzGP+ju4XhKL5wnm/x2zxTRVviHuLRehjytlDI?=
 =?us-ascii?Q?8hxgJIPFEaB49ug1ASY7TMc4vHTVSYMRy8XJQfzt6g7gOhYZJKrd7rn0jc64?=
 =?us-ascii?Q?6/FJQk/IqRyHmc3h+6BVHuKtubsQr05l5itul4XAAw2cyXLEwhGEO2SNEfBN?=
 =?us-ascii?Q?4n0D+MTo4NTxPKUFzPhB38J6mOX/IsWr6vJOfa6JyZNSZ5GXD7VL59Al32Nk?=
 =?us-ascii?Q?AgQvt4ao9tktntsFzCBsADWRPptA3jZNc2KaGjg8ktwZnxP4i+Mk31l8P4zZ?=
 =?us-ascii?Q?ap4Ol3iZng8g7mlAtHAOmQYRNYmk/dIjp7CUq0C3QLBA0CmahRJ8u/6sRi3z?=
 =?us-ascii?Q?MxjJR7NsWLKQcbJnO84/ioE8AkcZFm7SNcqexoZDJ+NfOK3GRjp+WuyQ5cJs?=
 =?us-ascii?Q?+HET7MQwevxbMX6Cc2EeEXrgTjMo9sDKT20x9APBxBam9NLEE1AgG1u/i9oD?=
 =?us-ascii?Q?QQt1newzO8MMOuU2xNBEum6B1G5KWRl8uB5PGt4iXgdAZMDRCiYhm1qWIpEC?=
 =?us-ascii?Q?tBW3GawVv9Uq7sDHPAStpmCPWLdo76rTz4FR4oT4bPCThD7D8VZvDrGdEHEb?=
 =?us-ascii?Q?uFzqUE8PpdxDIgAjgJMBvy1P17k+CBRRBy9pHOVK0+cDZIZydu+2YG0ItNSe?=
 =?us-ascii?Q?boFwFjQfNyciJfv8Pf4qSYs6kVU7C+u9zkvg8yjH+Vq4DjyppjPLlkiELRsd?=
 =?us-ascii?Q?2YmkuoBIaE+CKM9GOtaVjgHhphRbDes6sE92dIDZl44IvUv0llgBm1ySMp6M?=
 =?us-ascii?Q?hzTYPuqKT62/56sgTOXM+R4OAt9ffaCjA5INiSRnjKjhqvPownCeHxJpOxXu?=
 =?us-ascii?Q?AEEgB3fHB43C7ptLn0+2VAG2Eh3GJTpCLA3kfkHl39+WEUFFF90irzYgOKOK?=
 =?us-ascii?Q?2v75eDWRAsIS7TSodFtCdsrp5AMJnZt3zHnNR6QFVGudmJsef33YMAuXAKNF?=
 =?us-ascii?Q?eITEvOWYCM/HyXjh/uGVPH1S0cBnxGAzpBnBOWwKUl3DhPX1FB/lmJ6/DYn1?=
 =?us-ascii?Q?IY1Ld4UD1qdEXYfnDbUYi+f9hLroefB/jRKODwE1+QXFXv9eid5p0qpLIzVD?=
 =?us-ascii?Q?NNaavvw1VvWblrJu7J2qCR9lFZEDjgT25LBd/cWw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d87845-c4a2-483c-ed8e-08dbf11580cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:58:06.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izIl6WKOX7mY4j7pcm4kS3fD1+DWcY9X+MuQPTPI3WoYv/uGZKfUB7uwO7nsld9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On Tue, Nov 28, 2023 at 05:09:07PM -0800, Nicolin Chen wrote:

> > > With that being said, I think errno (-EIO) could do the job,
> > > as you suggested too.
> > 
> > Do we have any idea what HW failures can be generated by the commands
> > this will execture? IIRC I don't remember seeing any smmu specific
> > codes related to invalid invalidation? Everything is a valid input?
> 
> "7.1 Command queue errors" has the info.

Hmm CERROR_ATC_INV_SYNC needs to be forwarded to the guest somehow

Jason

