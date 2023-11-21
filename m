Return-Path: <linux-kselftest+bounces-377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F937F2CED
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 13:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A97B213D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D34A992;
	Tue, 21 Nov 2023 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKy8d5yL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A5191;
	Tue, 21 Nov 2023 04:17:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuY8BIJnlfKL1hK83uZvbbQ+kBwYzeAvqS6xFClzKv4qXzYp8y2ZdxrXGlbJ+IjASgrBlAdVSs9VN12nvPp01smJgIfmq1zvtLVUY12iGc0P0/XbWE6Nzs8iNkh+9K/E0B/PhZ8DABsNFRsvyaOrIn0av8vFN/29EX4/kENTJwBcjhMsR1HKb4CTtl0cb1Nv2s2rAR2Fkxm3OamNrPU3a1zyUNPK1SoSDLn+v0er983FrZIsTJJBSnbV4wdRqRh5vrfcYRMbmrewXj4wNUYBvHk7Lk0IsyGRSmaC9hjV/pmRGalOQT+rtqw7DWnP/yFiDUSzHUkQvjAh33kxZULY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9rxtFqhYksrQR68F2vWaz3Y4BNasdyOZlnuJlBC9rQ=;
 b=kNo+K+jVn9/mtv/MGcmhR0zf6tNbXLt8Tu+NBQUpRL2sN2AzO6wxNYsNnuYezcnWtuyDhvtgPa13RH6Ud+5O5rS7XwDNznfGzbV/c/DSlaIpgm8MRoHm9lpCwbqAchFsjUz4FX5JZqtEH8UK1m4Swoyb5zGWKIRydwfvSPFPfbH6Gp6rtZ6WfF4/82Ziik6oLkMHmERErevbMEcgwW1Bgl77uarHWuPgivMEk9VHZS+eLP8DZEzfk00K9vwu95cAZqAFym0IANkUZQFBqkUIN70FoPxIyZ+EAWf8hkrkOCfGerLOpvd/1xnNA06hIX4+7/6asBNANOIKp0mvhrFzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9rxtFqhYksrQR68F2vWaz3Y4BNasdyOZlnuJlBC9rQ=;
 b=CKy8d5yLGZ+v6qWgooCudaJaQTx3ABEC0YJ8Trg8LTzjk9mPYM1VlclBFuL1vm1i3+hhXAhsQi2JqfljvsP+Ku26vze2+nB22YBwVSTUS69dBJThbi/0Ixf3PZHeAivYSUuhvnAkReQLgo7inRvSu051TfX4bI3FLPDHQKDE5ufRi3FcKp4RGaIkUZKxfu7sNa57o2rDBTNwzO7AQNWol0aDYTv2UBJNcRAxng0h4JzFlh6Wduf66DRUZPxZQFvMVSFkLhljuFeFXV3AygreAdCA+FbhWf1hr5oFN8WAp6Rzk3fRp+K2QM7NdA0c5y440cpMHKJKURZqVPla1e9hbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 12:17:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 12:17:06 +0000
Date: Tue, 21 Nov 2023 08:17:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Message-ID: <20231121121704.GE6083@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: be1833b6-2813-454a-1863-08dbea8bc6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RIMHxYIMJ97jSDaT2lmNWGa4spCxECXg3r/TpMkfp/zBifd3llbsOGg0cSOia/Cm0XcO22m8VUcwwLaYlFZHdMR8GSrs0OF5KbuDFUlJvyAlEBERQmKS0Net+EbJqVZLj5+FMHc5GSyydi6mqYToxIGiwmIaEXoXjwPAl5T96ywrTJHH/LVat1X7WtDPaKPbVgWSJNS4SEQOyz/tbrlz79fLXZRIHo6efeUI0QXZWivReCoXHBCemXOPnGlUsap0qh/kRF98+vEl+xP8RH6A7qupDUrN0GZ91TEMIPuJZocVL7K12kw9gIB/wYRq6mXPozn0vm+g5eflLJ2RK/icHYkdaXQT5F18mdeZF6tBLN+bcDKqiTj7uUIRWPl7UeRYR6nLYTFLo31XqbVlwjYnx1YhZhOsmz6qd+rmcp5JFMZLioflUGREDE4VWq8AJalVa7Cu5TLtzY1WRiWvu2f9GN9aRMMs/xNYDd5A7Ur996/740PvZr7bY+tnC/zscrdP2/pz6ujuL6FkW/crsdQO1sn9PCR7C2FUvEb3dY+T2Pub+6SaBSo+8FWB5CIUxR4p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(316002)(6916009)(54906003)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(1076003)(26005)(36756003)(6512007)(6506007)(2616005)(83380400001)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFZFvtU+jfM5vIGUT+kNMAhIGJKEV70iOLiEDB73tUnnQZiPxgU3WReSVnNs?=
 =?us-ascii?Q?f2/3Dk6PblZJtOjNXtrY5U8XJHBKhQ6bw2zqMg2znvqNF1g0S7t2dqKbvk0o?=
 =?us-ascii?Q?TchCqHeTgbOKP8Dox8rJOdG5SvFbDCDh3JdDQo9kyLEni+G0booujbotTnUZ?=
 =?us-ascii?Q?hrnm9gGCCEYO3Z7baB79rkZVF4xcaMpbopyeNCCGv+7tGLhb4+d+Q3To+XBy?=
 =?us-ascii?Q?tizhSof3KoNdYLFJGpU+S3MlJHonYbFATuv18O9mu3fkLe1vunI+1GSE/k/n?=
 =?us-ascii?Q?/eD4Qttg6uaoBx16X5ik3J/QpN3EIvut4gp1pVPgKdi9X3aH9PPg14a/q9vP?=
 =?us-ascii?Q?otLG1qK7fpKqhtAbN41V70itPreAJcFeIuXtuP430Gf6GWqGggQJFYFjBYhq?=
 =?us-ascii?Q?IiUypFc1uQuUhKE3RBLS3t7nABIqQfD3Fz1yK5L6l3K/rI/TiQ2N1joTeXH8?=
 =?us-ascii?Q?GceIKvQWL48TojNzCfAiTr2YnIkMy3G/1v7VUKcYN2GeP91vetoBnyo+uI2O?=
 =?us-ascii?Q?wrTct8afnNb/0hPgknrWSZMlMYtXa+X0bmSQKSIpS9/E0rXKquLKH/Eg4ukM?=
 =?us-ascii?Q?elNR44YlaZs0VBGSPGjwyz9qsecnegYHzsMS29f+f0kNO6uZ9d0nof4iTGJu?=
 =?us-ascii?Q?Ge6nVPMwoYE9NNcWfPWwy2uQjjmYv7r3pdopTz7OQHfMEiAlJcJ+inRY2WPk?=
 =?us-ascii?Q?pj/Ow+vj4NBxzYvP33rfQ531pZUuonifDJlrjHOgc7Njirg3Bm2SSiD5BooF?=
 =?us-ascii?Q?s1CADz/ET/DH6p1UdWxf618OxNhhFylphIfa3Q6rwhIhbA8Kl8sPMW3OzFmz?=
 =?us-ascii?Q?42R8AQ94KaP9OHvNECfulaxL0d0WzOzUXT4Mk9/qBAEsNx71C1m6zaAoR3kf?=
 =?us-ascii?Q?NH0Oa+NwiNisYG6IKuj5gGCeQDQ3E1r8+f9J/YIE2XDj0aF+/5hqUGK8j4yS?=
 =?us-ascii?Q?LqpLrmchufh2as8aY8YdPtrp1NcyceowmjWH4Th8nP1UuQTbKl30F0PZWmbz?=
 =?us-ascii?Q?2YdVZGRA7KR3LnFBSBwacXsw9MXjSkp4UMgnaFpiDTf2jcI3M9F9KIaSDhx0?=
 =?us-ascii?Q?UtGm60+zulaCZhFndMzUkWbXe1pE55RzQOoRCRtUiC2tLz6/IDstEZKIrYPO?=
 =?us-ascii?Q?tyNzD9rBdodrrpGOqF6A8T8kIZ65KTyymnq34IXqVHsdJrc9igfLCKeHaNkU?=
 =?us-ascii?Q?0WNRy0BVh+N1wuVViJzyxb721racUehlQ8JcCDTx9VTpxhDohXEnhvOfehnB?=
 =?us-ascii?Q?cx5+DuivnrXWnlYmgUKA09aeIbdibL50PJvObkiSHQyu8flrD3fKP5tJP+H4?=
 =?us-ascii?Q?9OhzMkz+RuG2Zxkw9GnInok6If6WX2I1YvTOSg2DwIS1YtZa0o7H3TnX1od9?=
 =?us-ascii?Q?mkSorvX6XNiHhg31PkmwjTX39f1alKkm4/QQINSH7S7g728fflR2WbT+qo76?=
 =?us-ascii?Q?AnWjvIThJSKsnV+A2eU1Jy9RAlnkTYcYc0R2gHRJCnO5nr4J5gwhKaLsuS0B?=
 =?us-ascii?Q?mmCm9TEQv4cOgBrla3cCwd48+zwiExU2R8ZCti1dQMFv71P5H2MAxNxJUYwu?=
 =?us-ascii?Q?BBYTqlOjFADlsKD2IQpwgSZOSsBpslBhUdor/eQT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1833b6-2813-454a-1863-08dbea8bc6d4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 12:17:06.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH103AjLPJ5jgyKQ3BMpjaLo7aw5UtMPl2GFAnUNDRfpVJXh263goMIWHnJZuxsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091

On Tue, Nov 21, 2023 at 02:54:15AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 21, 2023 7:05 AM
> > 
> > On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Friday, November 17, 2023 9:18 PM
> > > >
> > > > This adds the data structure for flushing iotlb for the nested domain
> > > > allocated with IOMMU_HWPT_DATA_VTD_S1 type.
> > > >
> > > > This only supports invalidating IOTLB, but no for device-TLB as device-TLB
> > > > invalidation will be covered automatically in the IOTLB invalidation if the
> > > > underlying IOMMU driver has enabled ATS for the affected device.
> > >
> > > "no for device-TLB" is misleading. Here just say that cache invalidation
> > > request applies to both IOTLB and device TLB (if ATS is enabled ...)
> > 
> > I think we should forward the ATS invalidation from the guest too?
> > That is what ARM and AMD will have to do, can we keep them all
> > consistent?
> > 
> > I understand Intel keeps track of enough stuff to know what the RIDs
> > are, but is it necessary to make it different?
> 
> probably ask the other way. Now intel-iommu driver always flushes
> iotlb and device tlb together then is it necessary to separate them
> in uAPI for no good (except doubled syscalls)? :)

I wish I knew more about Intel CC design to be able to answer that :|

Doesn't the VM issue the ATC flush command regardless? How does it
know it has a working ATC but does not need to flush it?

> anyway this is driver specific contract. I don't see a need to keep
> it consistent for all.

Given that ARM and AMD need this and would have serious bugs if it
didn't work this way I'm mildly concerned that Intel will be missing
something here..

To my mind it seems like this is just a hold over from the prior
design.

Jason

