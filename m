Return-Path: <linux-kselftest+bounces-1678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3480EF00
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB57281AD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5C745C3;
	Tue, 12 Dec 2023 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kd95a9GS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FFEED;
	Tue, 12 Dec 2023 06:40:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+wkAozb8bKz6X82cuDKsNVgP+t6hDF1kqrXbAayyaP/bkBeBCoQOoVqct40QJ6rLTmubuMGTswnQ5tgAXfMAsCVesPdHgsOiX2gHxpO9btHOC8ZbaaqGk+5OO6y/KIlL9e8lhUSh0wdJlQbAAdmYl+oot3qEdHC5daQu5j8uNTpW/vMZRd68LJK7raz6SVaHRQAtn1aNWp30Wi1+0EQe4oU23e6JGANbACQ3tyqYBBs+b5rHp2jaYPkVKHqPni+NXc0kyE2f80mhAiJn4Hh0VIWCwTLtglK+DYp4x7NhFsairto/U/xTE7VKTAk/3t1Dd0M/mEOAGb9nGHybiuiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDTXpaLgs1+Zy3R6wji7SbIY2mOoVNbRZ4MbX1KDZlg=;
 b=HBGcNDVWWgNFD2YMKKHSiwfb8dcbB+x8NyWks9i0PRzNSHtfLGjAy7lrWt9uN8CKOmkIuTsLdCiA12DDjrmeVj/zZexMrWBwuP+4RRsPSkrUocQHwSCrTlTkSwTDq1wu8qm1IbRPoiwRDe9EMEtS/tIViIDmoaXQd0iAJaiTEZG9KP3sU4oCNFWOS8nJ4blws3bOspzYsLkEciyE9bOz42Gl+dSTjpCOIRSCW0PYtwX6995ut4edt7nDJy6BN2CLlMgu0s39QgtDyDbai7mPKoDkywLyTZmPaKHoLaad30IUvtceusOatQ414LNoqQVLNqfIBCxUYIAUIaQkzHPUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDTXpaLgs1+Zy3R6wji7SbIY2mOoVNbRZ4MbX1KDZlg=;
 b=kd95a9GSvYmfLaXpzgof8TSBfhNTsRnv57ic/ZS48rmXVMotitgbo9KLEJy8KkgC9VekSyZh89HxOH1G33TtLJpGEuSC99TbVVo6oWw7LP//MyCqhexp0c2SpOJN7VEj3dILO3TZiupoaqVr5suHodPbmJK6u8CxKQGmOVoCy3bDn7dZPa/0DrtnlFH44RhjfH+9dIIoCmafRy4JumAFU3n/bEAgJagZpoMVxnLzGxshH+4bUWXoeAyi32rudWqztznzEy9y+zXF31O/GJOLPWfJICGP4k3cmiffGdf5hWWEFczq7Cj67cl1JBGFxJdgKWHFIANm9O0V3HIqGEPW0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 14:40:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:40:26 +0000
Date: Tue, 12 Dec 2023 10:40:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
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
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231212144025.GG3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231207144208.GJ2692119@nvidia.com>
 <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
 <20231211132135.GF2944114@nvidia.com>
 <DS0PR11MB7529AA3F28F4418A80D869B0C38EA@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529AA3F28F4418A80D869B0C38EA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 148009ce-d941-491b-c73f-08dbfb2047df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eYb4yCXE2uKsZFtO7setF6iEEV8ceHRiRApKAsUJ1TgD98pM3vcB4aJdfpDVDlI0F7nmYS7qlSBV3x6dbnrZiyraNg78nRIP2LeFly8ijK41/VWYAlPKmp2E0Dm/ujnzEmJQJf1wirQlUjSj4eoE2JLKU8I19heYRVpa9uLPoSzVOrt8HwhY4NN62jloU+5gV0VsYP3oyIA21l2g3Nh9SmMUD1GNiROYhY04NEcvbmMkoVGM2omhHh+b9RXA5HB3qFvZlqEDHkRk3DEAKKJtyb+Rob8PYF1tCMy6v2uGM2T9DotBdvgf+x2vIaAI7Sy/cUGs0RkeaNg/k5fiycjBuVqrIq1Fx+ALxMK+s2Y8/21tc9yLABgTN37i8AYKio5xKAXkkFFU/b8fXEbtoClXcOQfBN/0T/EPWSDxwQGYP3be4h4rrzBaxnHBU7voXUQqpqZ5U3Xo/DMD7pIZICun28RxMyNEps2yhaYPaiScsMfa51O0lS+zk6pWEnE17hzHx2Piu2661O+lYTR59+dQCyExjy5lglFIZfDIL17pcjNPT0S07mLk8vg7n76TdSbP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(36756003)(33656002)(6486002)(66946007)(66476007)(66556008)(6916009)(54906003)(7416002)(2906002)(86362001)(478600001)(41300700001)(4326008)(8936002)(8676002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rd1KWf8xVQMNG6GuHx+02nbDscaB7KIZu4ILMyYMTtGIx8KxhyvxnODgEZts?=
 =?us-ascii?Q?r1a/agHpVbcKVKxfRciyZQrURdTh2fVOpKF6dH3SVArS0dUzLktRS9kEsAgA?=
 =?us-ascii?Q?gM9gjh6nQ0XF81x9aClyhERaSKsh0KvZkotelWZMkthdMT4SwEuHXEFfI6l0?=
 =?us-ascii?Q?hllzdL/u7u4JO9UEd2iWNAU5HUa+F+3ExCKOKO3p/6Ii324mDA0/rh+e+4d8?=
 =?us-ascii?Q?GnwjCvTK00JRgKDmP9F/kVM9LYoq7Y0c0OTSd2MNkklhvGWsnslROp7M52rJ?=
 =?us-ascii?Q?5iskC3j+a81T2lrdtPL972TiBDRldi64Z8s3/HiKeNfpq9V6mZhHgiwiIxKv?=
 =?us-ascii?Q?QceGxUTbYbbaeodZ9dSPT2X/sBMJkEWmgatMQwmTA5gaI5lGtUQg5BQinja8?=
 =?us-ascii?Q?bkBNts0u/q7d0D0p2zMSJPPr4ChLDfGyRqh5DyiIleU7jS9XFkO9mscryGgn?=
 =?us-ascii?Q?s5dLMjVK1zMIH3pI/h7ipol4E25iIwS1+2dPjGBi/UsiGCGFZluhRD7rqabx?=
 =?us-ascii?Q?ZAa1QvTmqmDCVdZoGmRUSKyUJbEnw2kYT+XxXie7Ew5FGFzuJfjldqrPOLKm?=
 =?us-ascii?Q?KeyI/+6NrKn+FGIJ9Nd5nwuKfMkJdreONUUrzD68C2Jxeru+oNQB0o3Yy7dg?=
 =?us-ascii?Q?QaVUJl+AydQJweCWawWwhqUmy4M8MYKPLth3wahjf3eJ0hg5HZOtlXjAGEc8?=
 =?us-ascii?Q?Ce9iVKFSgJGPz5iYcgiMEWRnNGZHqFkW3Gzt+D0sEojcijEpxqxeqWJ1eUU/?=
 =?us-ascii?Q?gdWMNur3W55TDeptpQzZhxLaJ1Gp4sI1G7e7WXxxHzaU19nH6jf/IsYRVdc1?=
 =?us-ascii?Q?d935Go1nFbZ3qYxim2Q1JNdHJgL1s+HbyoOTJTi+FNHmxTODuJJS73964zRK?=
 =?us-ascii?Q?X5T7tJ2YJei0ZG37CFbfVXXbHe9SBfHyfAjeCYqRt7UWlBzWJnO+CcjpLq53?=
 =?us-ascii?Q?1y0fH/uJZT4f5FN3Zu5eoZH5P0xvhJeBvWVXWvn08z60e+NahN3QrYAc+9f2?=
 =?us-ascii?Q?d0nRt4WUWF9J4/ye/OgDaaKgw6lOcN/g6rlMy6bCxjp/ppCQYi78odUajzUe?=
 =?us-ascii?Q?29bL9OHbIZsaEg3UuEssNqUPNdQYBZ0Iz6VsdsxNHNxPsLpnOzv63GcJq4zn?=
 =?us-ascii?Q?UxE5qlEhq8MPsPIg0u1cigqgCOHCrWI7fn3LqG+dq6aFiv5bvfVs7jeb9KPC?=
 =?us-ascii?Q?xMvzTcSabW3mSTWMNfahR0GxAYRG3M35KFoI2PO0qoZln3jAUDXngl4S1rIu?=
 =?us-ascii?Q?B/Ajd8d/BHtnba0ypg7T2JJC9FL3rx67I0ve1AN2Hu9hjYSv0Gwzyc2td420?=
 =?us-ascii?Q?6uHFE7ZWyJTOTqGn6VaiqGoCo3n3yqI4v+nr0Wxew74QFPaF5+3R9WPMdVvo?=
 =?us-ascii?Q?vzxfcDKMEny5vysMllolvMn7G5bnX3BcYqwtrNuy7vuLMIQAp1c4JU9wPZeV?=
 =?us-ascii?Q?Z3noCGqLlZgZwHjvtE3MQuUseYkuZ3XXSHaAxDyv8oJk3ivjeh1BpG3Bkp42?=
 =?us-ascii?Q?STU4MfI9N4y7Etyj69/wln3Q9v5HKaTa+/d/gdAmRWzP5LA08iGtnrAcPvox?=
 =?us-ascii?Q?uh9756XGuCd/An7EnhZwWLWgJWuyAyJc0JNlSxdS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148009ce-d941-491b-c73f-08dbfb2047df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:40:26.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwvPWGy9hdPeURbmK+hHGc60jkYh4ZEFti05MuWfqzEPRxBJJYoJq9g2I6O0BaEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390

On Tue, Dec 12, 2023 at 01:45:16PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, December 11, 2023 9:22 PM
> > 
> > On Mon, Dec 11, 2023 at 03:53:40PM +0800, Yi Liu wrote:
> > 
> > > > >  From that thread Jason mentioned to make the invalidation format
> > > > > part of domain allocation. If that is the direction to go then there
> > > > > won't be multiple invalidation formats per hwpt. The user should
> > > > > create multiple hwpt's per invalidation format (though mixing
> > > > > formats in one virtual platform is very unlikely)?
> > > >
> > > > I think we could do either, but I have a vauge cleanness preference
> > > > that the enums are just different? That would follow a pretty typical
> > > > pattern for a structure tag to reflect the content of the structure.
> > >
> > > Is this still following the direction to make the invalidation format
> > > part of domain allocation?
> > 
> > I think you should make it seperate
> 
> Sure. I'll add a separate enum for cache invalidation format. Just to
> see if it is good to pass down the invalidation format in the hwpt
> alloc path? So iommu driver can check if the invalidation format
> can be used for the hwpt to be allocated.

I would skip it in the invalidation. If necessary drivers can push a 0
length invalidation to do 'try and fail' discovery of supported types.

Jason

