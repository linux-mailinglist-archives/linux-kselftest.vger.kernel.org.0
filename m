Return-Path: <linux-kselftest+bounces-1559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141C80CA7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 14:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EA8B20D86
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC73D960;
	Mon, 11 Dec 2023 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqvMgi4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A9CB;
	Mon, 11 Dec 2023 05:06:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdBAdF66gPa+LIJjaEXXUx8Sj6EoLqcDy+AwlJ1EeNr6kMEes5gi3Z8DrPXdUdPmHoNAb4sWWZ5Qb+2GLoB8etqa2xZdG6w5aIkVkMVOs0GRBdf4mmg7tEOz7Q7Nv5aUrat8LgCrU6DMwE15abV6szUfV00EUwyl9y9GSI/7x3iqSWrn6sfuHcYBS6rYsqgXAYSBnlg/SMPj+srPxRLR2fb4AQ2rjOLHJvJIfAaapMx7wmywchBiZ9+drFUiSVOWZ/GgGgmpwdUsiS15NnVQF+RrskFDKAynccuIvgsi+jhzrtMuAewYk0tukJXBdMuBqPtL1q0gsIB3GrGyA5o5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uuuozPXFWcnqZaLXUZITS6AAVkAkq9II+YK1e6s60Q=;
 b=kYSNfoh75iGdBzjz9BljVp0HlhmchwFke4QpTi6m4UFLnnWyZQRhwDbz0MjIInAVDMtNphk4eB7loE/co8m7ZMpc6k0VKeyI8/NUYXm8NvmBu5H5qW/kwo3Tcb6acBYIZqnMjeIDFvT+jdSf8MhWJ2QQuuu3hWhcdXbaKNYeW+YAi563EtFdqn5D/MyoH0MB0UhTGsMIkv44EEeBjD/PMN5fU3kujTbXV+rZZdEtyRCw4NZwMn0cT/HA794e5JsT/8E7mpNxWfl6SdHNmtVL4wS4lZVjCiMt0swzbQEr5c39beExGwkc/CuvpTrvmiYGtorjEzJj4nv5qJqCEJuzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uuuozPXFWcnqZaLXUZITS6AAVkAkq9II+YK1e6s60Q=;
 b=ZqvMgi4vNKDQcel7nKNMeGPnHselDmUbBGnbzlgbcNzwieCpHHBoB8//D0CBObLfQk/PdOXQdtFZ5lj5SNfctn+mTC2jd6GBUbyUiQhkPCKGbElL6TQ12PbM7uSzlOUK/6hzkRW3yj6A/Jna4wkHFR4wbDh4FcNx84y24DzLRRxkg7G7QTtapd1JkqvHJNVteMSzdUGPdq+zgWW+pIruSMONFlNhwSZWFt9Fg9ClY5zrcGxDY7WpEXeu3lP8AL9oLxLGzGK3HycLbbv8nqEGWKQQ5SY/R42i0ioyvMwMChZ+rFneYkimnAI6XJnF1bTR3f1x55/NB/DIezQo2hHHRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:05:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:05:56 +0000
Date: Mon, 11 Dec 2023 09:05:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
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
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211130555.GB2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3e77a4a3-3be8-4e04-9435-1f66df93078d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e77a4a3-3be8-4e04-9435-1f66df93078d@intel.com>
X-ClientProxiedBy: MN2PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:236::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c98f8da-6d53-4fe0-3d6a-08dbfa49e980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pTFYdRxKZ3Av+GDGYmsDsOVZv28v6tjQftgnlT2MHRFsNMlmrzXP8ExV8iB5TLq0upcu6TThBpcguGRswBTSorG/Op98Qe3hTJyC3GptjfMbWV5KeHE13szFx/fwts8Gxmyir6U5RcleDI0fOx/AlUA66bIy5jci9QCPjyAkntGmHass5XzGlD2BaZ+xetLfvDEPuRuaGlXolx83GXN7NqbGsi5hOX34RSsas0oeBLZQDy/+gTfNi9ElHCuCsayzp4EHa9D4FAdjRfkLyJCe69jXKT6MnN3jdl/hZubP3pNNBUtRXOKs1JqEsQHqlLf4eVREn7XwrP3wcYMe/xdcKxoIa+MZnVWY527IVgA3/3wA0LH5TgzJim5yKSEtLl7QG9gvcu/xP2yLJTvRAVZy8Q2tOh67nBTxC7JgBm79d+AzBX5OMVna9UQYu9gM9Uovtfle8EeUWH52PMv4CA/fv0ylv9BlDOIEE4qKnZViQg97MHMW6Ie4zs/O8YAPPct072J5KAKmR8L1dnbj1wSWMWEf8CeKAXYv9lz9oCMOTdhAykHPyp7qgZ84amyfr+z7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(1076003)(26005)(2616005)(83380400001)(33656002)(36756003)(86362001)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6512007)(6506007)(53546011)(66476007)(54906003)(66556008)(6916009)(66946007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQ/0ZnFQbUAgGSwdgKzbrSpYqOjOAt6Tj9bs4RXMn5OWjGL1vEmlHQuBvzdt?=
 =?us-ascii?Q?LFvBEx9dKc/tyMXjD1VN/Pn4OI2n1upZBJ8OIhqOVoW58ycLhIEquO5qvRrT?=
 =?us-ascii?Q?jkvAH/Z82tzoVpoJm9aeI4wj7RE9mIlmJhbu4BQsKHigJpPgjVvjHhWps0bX?=
 =?us-ascii?Q?1xm0c2Dak01ZM27oDVp5X0IYv4vxHjOw6DYUWR/zO1hjowpzdVs3/AOYitDR?=
 =?us-ascii?Q?b2PjgZM/ETDEweK4IVSVSpPe3vcBD11zvokg7U5mhj3HAvG4JsObLqgbqmYe?=
 =?us-ascii?Q?o8r27qXAUTeUNHwUyIwe7y70dKIi2rrlDzZB1HRXFVgxU+uwfFmypw2dr9LP?=
 =?us-ascii?Q?XUC+qesdCfvGf1X2xn3mZMdP6lJ+oV3jPVtPdLG0/sSWai9k4ouTDuByjeda?=
 =?us-ascii?Q?D+aoyOKTs40XMD1Izmj923KvRn4G89gTKlzbHRjxKt61jk2gE33qCQ5LuGdn?=
 =?us-ascii?Q?nMuwr5AZMyjp2+W+sgzkuTwA0HLNqTcnDyGD+M0csuVvpxbwRoafppAshXhi?=
 =?us-ascii?Q?58RtrEAbe1WYbLVcweoHXfLumD3x9sg+AcMGCknKR6oM/MO+wgbGlorN5MX0?=
 =?us-ascii?Q?eilgZsouDN8GM2fSX6Je2sd5q4wsC6UNswLeJZ/cPf6WC9b0Af3JP7HAI/B+?=
 =?us-ascii?Q?iPrmgg762lV718vt2ELafJIb5qCedvnidVzZ7rfvD1NHbJRp/3OZNyJomXSp?=
 =?us-ascii?Q?WytQ1KfaISbS9VNRJ8vhM5Qh6pq0ewjwIDhFzWChZT7e2xFDDxHbvZCxjEyQ?=
 =?us-ascii?Q?UIXgZHpdAwGHnKmX/zh5+ASD2i9l8j0mK6oJz8hxL6ZmUBZqWKyXfPF7eHTb?=
 =?us-ascii?Q?gqN3iXfaXswyRmTD0qcfq4tPo2WJ5jXInWoVfSmh86KF9mHfqw06YYkn0Nw0?=
 =?us-ascii?Q?F36QqToc0BQ+DkV6jPGf6yhJiGl0gBPntlZDeqZfhzQRkiRfvtU/TkZRoc8e?=
 =?us-ascii?Q?g7tbbiXi3gKZ4G88R8owRvB9kX+QY0E1RPiVlj1PCsclmHUriA+rQc2rce2P?=
 =?us-ascii?Q?HROCjcp41Xvfra/7O2yG3EMTIXb40Q+yi+73/KHrg4VnZXI089fv8BvztRKs?=
 =?us-ascii?Q?aYzonZIHgUrHO2iCxTmw5l65EGKNTPME7hewKqtB3WY6KwhY3pqfXAqAVc26?=
 =?us-ascii?Q?bPzbzbKkU4r0MrBAbguxv7AukOOV8AToRXm4xD7ilr2bNK1UWG4oWSvJqOZC?=
 =?us-ascii?Q?aal/Pj91osDd2m5jdVwxL0jLD7nFgROwCZxeaVaNLsUpf5B3ZoyKbz9wrXHP?=
 =?us-ascii?Q?zt6gh2xj/NL/tYOyhb1IegxesQq4a8iFlVr+UqGV5/inZpeCXbndI9N+CJDg?=
 =?us-ascii?Q?xiPwfYJgAAsSmDoTHyR+iJvSbsHVMXsajT4iyn7hSI4+3VjVZZ2Hon7XKuL2?=
 =?us-ascii?Q?jTMTyE4kzeadc+BPLOigOL8rP+TFh+OpLpe6/z/RYZNTKKOfVGBllHTJoZZO?=
 =?us-ascii?Q?x2VD+z+FxCvYo/KRcqiR7UXGMcV3/K2PTvlOpWgvn4s7nHikPh3GJQU+II09?=
 =?us-ascii?Q?UZbGCsggGk3AzGogW6HpLnL79/K9RnKBMO2SucN5Mu69sGKqBEZjN98RNWtX?=
 =?us-ascii?Q?hyh3uOh8SXxZRVDacsD5/sLyyXwS7BitP7zS/x00?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c98f8da-6d53-4fe0-3d6a-08dbfa49e980
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:05:56.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl1NxMVlPH36fhnI57gL4olEY3poLRAORF97GpV4miv/Q/geFfW8ERCw3gc0wZO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On Mon, Dec 11, 2023 at 08:36:46PM +0800, Yi Liu wrote:
> On 2023/12/11 10:29, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, December 9, 2023 9:47 AM
> > > 
> > > What is in a Nested domain:
> > >   Intel: A single IO page table refereed to by a PASID entry
> > >          Each vDomain-ID,PASID allocates a unique nesting domain
> > >   AMD: A GCR3 table pointer
> > >        Nesting domains are created for every unique GCR3 pointer.
> > >        vDomain-ID can possibly refer to multiple Nesting domains :(
> > >   ARM: A CD table pointer
> > >        Nesting domains are created for every unique CD table top pointer.
> > 
> > this AMD/ARM difference is not very clear to me.
> > 
> > How could a vDomain-ID refer to multiple GCR3 pointers? Wouldn't it
> > lead to cache tag conflict when a same PASID entry in multiple GCR3 tables
> > points to different I/O page tables?
> 
> Perhaps due to only one DomainID in the DTE table indexed by BDF? Actually,
> the vDomainID will not be used to tag cache, the host DomainId would be
> used instead. @Jason?

The DomainID comes from the DTE table which is indexed by the RID, and
the DTE entry points to the GCR3 table. So the VM certainly can setup
a DTE table with multiple entires having the same vDomainID but
pointing to different GCR3's. So the VMM has to do *something* with
this.

Most likely this is not a useful thing to do. However what should the
VMM do when it sees this? Block a random DTE or push the duplication
down to real HW would be my options. I'd probably try to do the latter
just on the basis of better emulation.

Jason

