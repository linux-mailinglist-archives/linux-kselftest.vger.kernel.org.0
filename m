Return-Path: <linux-kselftest+bounces-547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547BC7F7574
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8990B21476
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343228E26;
	Fri, 24 Nov 2023 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IB6TgYDu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF4A1;
	Fri, 24 Nov 2023 05:46:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxbfSLNi1AM/odEOL9D3sqSznQekk7v8E/UN2UZnVqUlCbfdZDUACUbArZRrHkYLKuunbR4lW0ju8r4hXo+i66oP3ieZLE+zaSvGvGXTmcOgjAbNjRN/DId7cMOVEZ6mDJVlhxfCeMOJlbt1fn1w+01khk7LqVfQjsFXrBbe1h2SU1b37Icq3/Rf47KI7fVbxflniamtX3jU1wSZoNqMqqOsvALBOgFAU2pxCFN/sqs02zQvpklyYZv4h5IYyeFnTnhPUlgECoyJUBtQkaaWokvvQs4sbxlcg1TqwcgytLNOM/I+aNuPgMb6j8cg6D2gipeR4OWwClTLNukj9bU6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFCU8aKaeEJBf7NrKalUtN3ORSiP5L46gfhpiWyhEY0=;
 b=Erw98Cgg5sxFAYxcxrAQXbTscsNXTl0CtRBOBZyC2iph/DxwqjjqepRTrgntIwmGHpmkdOfH4Pgy3Yqm19iIhRJhoMIMj5f/syMsDbp4PTs01sTtBT6+b9Nd19GoXHKEkuipNMgV6iaj8V8Gb/kKJqEkEXPcGKLhvOFRiA88Wttf+68HIqkbH0dFU0uf3gmmqzMJYLXsS3n1A78TgF4EqA5B/jt6baZ0kLWLmBrHDK4T2BIR7ViPMDk5jgvpW6S3aV1GFd7iTEbv9JW0PnHtgX8jAjWDEGBc7z8nVxeHMy3YAILLUi40oHQyKy7V9BgUAw5QxXDN55yfNVAW/e6UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFCU8aKaeEJBf7NrKalUtN3ORSiP5L46gfhpiWyhEY0=;
 b=IB6TgYDuH6Tx+QdvHO9Z3Xk4erRiMu8DZo7QvAJ9Ln+FBuGmEzS/ObXbGgmKBpC2sxigHqlcVLvDbUQRjFhNloNGhyC7HTevK5T+KcNJmkQGstsbApEQGS2E0BGtIjtLpyE2IrnJObE3UkayUEBo3UsHCdLfHjnZ5sHg/I5CSb4cC5XZNZ+otaPmcYC/ErPGcYG+Qoyi/261TAJICKob02m9xO7WEQlcGDqfYuL79n0WVq3uoyI2ssNDrWa10sYv3vn145nwGLv/ls/Emau7E04u9eH/Ca86MQTccCR4XYYFCl15zBSPFKtPHx/eQS/cT43SmropFkAlHWP2O2sxHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 13:46:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 13:46:47 +0000
Date: Fri, 24 Nov 2023 09:46:45 -0400
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
Message-ID: <20231124134645.GE436702@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
 <BN9PR11MB5276BC5DD9824923C8A3ACC18CBAA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231122132542.GM6083@nvidia.com>
 <BN9PR11MB52764F692E78C1B396D175DD8CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764F692E78C1B396D175DD8CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:130::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c651f-50fa-4c36-51ce-08dbecf3cd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rIH18kjDupH0B4cfnVVpG8cKrjOoo+2j4MexIgnJP6/SKjMPbIbFFy/GUCGanEJoR2ovG/DIT6froF6yBZuyNH0e4/3zyH2N5xPQiAv8lKolFtkGAf2Wf3deglv6qcly1yJBeQKucDZ+q3Iz73fGHJOcB/HcMftWJJrUHJyHds5RbSynuiirBRHbk7rHRU/LGb2tNehamqLtAEpP7L0whKXu/o0qtkf5I0eEw2ukeFSP6+b2/NM4L14p5pDSEPtWS4bhUKQkipCIQyGbwTmS+4T9YYtV+BxcatQjTt5wUV7ayg1iTkSSDwtC6kaoY7wrkGxzqmktUS/7VwmSYPVwfq1YnQ0zJVV5wG9yrLfencR8JHAdBgRVe+20Zi5HEeJH9Papnu5eJvxPropM1it63CfHSaMrQNT6K+yZNWBocZp8MKKDWXQTlyGDo18srKNDCJPtGqU36Mi9swmLuO7spODeSaI46g41JjbPLIlCzj0jgTdiqeRvd98glvJDWYMItt3OI44wAJKhLExPCpxrkkMlgEtbia97ATXRPFhFjm7Xqgy6yEi3lxwsbffkt/RIH2otUzhdjUChgNXAW+zu3/vsBxZXOvN3rVPlImcFYixGgQJ9N9Nrm2lpP86loGVk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6916009)(66476007)(316002)(66556008)(54906003)(36756003)(6512007)(66946007)(26005)(2616005)(6506007)(478600001)(38100700002)(33656002)(86362001)(6486002)(4744005)(1076003)(2906002)(7416002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvUHhEDMtUOK3ewBpX/GDoXFNkbpISrbmZVKXnQmn7lkPi41zADTWi8wGeRm?=
 =?us-ascii?Q?1m9XW0i52j8B6ZY4u93KZgOYWTWvYLjme3XXNwSQ6EDFSg5Ppmbod6YEXb/T?=
 =?us-ascii?Q?D05s20bhVyBMgWlOOuoTuDiT5cguvE5r2JTOoLgl4EBCFrvYVJBrktSFwqUZ?=
 =?us-ascii?Q?KpreBQOAYjFe15dQi0c5iOyhpynMrlpIdgVaPTHozaxoFTW7KZiatXr2sqfO?=
 =?us-ascii?Q?XaxOz15CSYHb38vhZHNi8F2vSb0WSvvIMeB0Mw1rJYiyfff6H53xlvNRWz5q?=
 =?us-ascii?Q?FuUV3oR+pdjEQT7iIjqM8d5qMHYhuz8p2NViSBJA3OGboi3oMmFyaa7ASEWd?=
 =?us-ascii?Q?sBB+yfiemas8h5HYsffPXth0PcSkefc9g9fFU3VidiAg6WXpfq4tzukrkgjc?=
 =?us-ascii?Q?hu388X176izgqAyEi7erl20frzlGNK1wDS97QH7oAyEg52rw5kU4yx1SIGGn?=
 =?us-ascii?Q?PVV7Gg55vPP6mb5MWX18KiR8mRKWvuKp4Q2EEN2JJnc8mb3zu8ScRvKOwIDx?=
 =?us-ascii?Q?8XeoYw0gOmAZbDPR4pAAtZw3XxvKDT236Gn6HBV5LjRe7qXlamdOTd90D9aw?=
 =?us-ascii?Q?qswVtJ2Yz1p09cba09vNvEn8UtdKlQPq5KOG1uA8LNG6qcXsVwuZ9C+DfRcO?=
 =?us-ascii?Q?lM1dIFovTwthqf3lJMUvvI970PPAgvZoicY2pUMqhZd6eH+ihFdyXJ/GDTxv?=
 =?us-ascii?Q?0ASljEuropwjaJTolLxlr9zUPQugSQOB8ok5cGkwgOCfFu1S9wyXyVZfcrtP?=
 =?us-ascii?Q?zgovwMwDCJWTyYVtzdZ0e6k5Dubpw4rsIvE0TsLSxV1iculmYTZeZAulUClH?=
 =?us-ascii?Q?TAC1HOVJskMOwukb/Np6ZEz4X3p5B5X0CmGSjFk2fFuP1Djnhm17E6rKKweZ?=
 =?us-ascii?Q?8ZPvezbudhk9m4Fht01NC+xv6j9CLTQyy6wYOo0RpVNv+BVj0MHF6uhiE16k?=
 =?us-ascii?Q?xjIZDwgchdqyv+71dFT15BkIjLQJhDrJ5fMLg6en8GDJrRtts502lNIo94Dv?=
 =?us-ascii?Q?+dWXneGLO0QbO7fWRieDw7L0K505f5tU58tz19Ofd+Vr9TFCl2FLoDUUgmUW?=
 =?us-ascii?Q?7ePEvM/RV1cfGru3OEdt4VpZ/DG6OKjhm/08k34fNGAO6X+JKmf8YDl+VDDT?=
 =?us-ascii?Q?Jfug8qSnzAijq89ojAyWvLvgzEXlnD2UXgguOC0Rvxypu63iKP5pIsykLGtm?=
 =?us-ascii?Q?bkZRFdbNeJrsGQNoAKKutDH/oHP0zjM8qNbZ8oqmUxAw2nBub7htnURYkVjT?=
 =?us-ascii?Q?B6mJwHali0n4PMtvjBGliZ7nzT6ANjLZsM0LQeNwaPq/aDPnkuRs8eTTkVnt?=
 =?us-ascii?Q?3E5GqciTjwQxkwLFdpG7m4m7yXpF5D443Kb3UuvZhEP4WamG94esu+H/Da0l?=
 =?us-ascii?Q?31B+mI+D3rDNhGT7mjrUQnKGV7rWflTbTRy/bbGwTN+sAfm37YZb0YNTTMUS?=
 =?us-ascii?Q?N398XzTaVzH1+goHqrjIapVqlbiBnIRQPdS4nF0BXRCFijFOdPCMFAyrf7BJ?=
 =?us-ascii?Q?2vthW7uSi03/9YKGEeSs7EHFnzj23KJ6es7pDXhlCjnWBLGX6DmtefwvWCnm?=
 =?us-ascii?Q?B/xn0pkx7hr42DkofOibN338RlnPRrTlYAHb+yTD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c651f-50fa-4c36-51ce-08dbecf3cd8c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:46:47.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TmZOpXxe22Ea/kSgOXLsstH9JMzRDLZE2JC1kj5YQ6GA7GpPZfbP0vuTwfFCc4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477

On Fri, Nov 24, 2023 at 03:00:45AM +0000, Tian, Kevin wrote:

> > I'm fully expecting that Intel will adopt an direct-DMA flush queue
> > like SMMU and AMD have already done as a performance optimization. In
> > this world it makes no sense that the behavior of the direct DMA queue
> > and driver mediated queue would be different.
> > 
> 
> that's a orthogonal topic. I don't think the value of direct-DMA flush
> queue should prevent possible optimization in the mediation path
> (as long as guest-expected deterministic behavior is sustained).

Okay, well as long as the guest is generating the ATC invalidations we
can always make an iommufd API flag to include or exclude the ATC
invalidation when doing the ASID invalidation. So we aren't trapped

Jason

