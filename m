Return-Path: <linux-kselftest+bounces-1563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96C80CAD1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D931F21851
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9A3E467;
	Mon, 11 Dec 2023 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DAy1nsJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAFDF4;
	Mon, 11 Dec 2023 05:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1QDlmJ+5USfIwg8RTPReGMpWqqhJT0mbCTz5XjmFg7uG4/AKjlG7B2YI8fdWWjddaSTsMn87DkpA9uNmpQjv3ltIs17/uUxi8fmy9rVPmqCijK4nbPEBWSDNYtBPHIhQNiwuRY6pc24wRrCk9BQXt+dLA6BGLVqelWraxlqkdIwjmnKbKLmV473syhcD4BvPdTc0JbuCZ/KY1Kj+jnuDpI1bzccohMC+o00P32rcsEKt+5esXeUj/BjsNMisoOqjLOA2H6pVAJRTpzRyUACUM9itDCqxPTebdtL+6b5/d5HmGs/qLXmf246jrF/inv6/m0jaGKTrYc61MHhgnO7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPi3ESgEafJlRf6NKn/aLh/T2IbfPkmB5EPw2y6hltE=;
 b=gg0G7rkm0SGTh0BWW6v8rD81PzvBGsnx6DvovDiSxCxNrIgGhUDHQXIKQQB97uUyVdIY2fLCM82enLk1Cg9kAKbfAuQaG9vA1tFJKBYWKukoPCIW3dJPsJuNEztBhYEigyZLCtols0Q4qZpVEfqOD2KZym55ezNTKaiwRMBw6rQyljP0N3/SFEjL8MqrGyk3fiKDeVPfEr74mtxwT7b6wElP04XueumXu8uEcR86L3Gb3gNcs32H14jeECrSZSEsz8NSOGf9+6C9VVgxkim/UwpRw5GPLP1nBvxZyE3ptxRQbegm7Hb602aZnMsSw+lNxbN8jhwZ1NCxK7JH0XNnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPi3ESgEafJlRf6NKn/aLh/T2IbfPkmB5EPw2y6hltE=;
 b=DAy1nsJLx63oDyU1bxoRHJYWv80rxDNjgBjhbj5ADxn2a67WXlShI5TJvUs2TCWJfOct2FBAe1KCuJjcLVHL4AuJbi2GApuwV8XlMTLol+XFm54/A45FfTH6b5pkiLagVeoQSzps6kIbYVmllyq4EyHpvLwD55XZXwUk7woN+/c81RLf3KpIoiwPVYiPJbmE8KmHJ7p4Sh8XUFSr25ZIbYgsc112LCpg6IudWkI8mORCrJITR+BlvdD8PcsmIXOEmE1ZdHNKGKzWJK55HGcZN6qpTpd21Bwpw0LacnjdkWm0PM+2fhiysO6WzJFGbUHY+asWXPbBu8Fc758d+VUv8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:21:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:21:36 +0000
Date: Mon, 11 Dec 2023 09:21:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
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
Message-ID: <20231211132135.GF2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231207144208.GJ2692119@nvidia.com>
 <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
X-ClientProxiedBy: MN2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:208:a8::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: db85f659-f780-4562-443c-08dbfa4c1a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GYHkxDxxm6PrrIw2v825Lr5st9R9NO7xVqFcSY3oKIe3S6kc9OPlbzU6GgLgZVtzn5Z1ZGkaTT4PnPBl+tTEgyXe0WAqnHodJV5f+FE8DkfDE1cTtN0EIBuRo05NrJj2btWLTB2OafvPOE1JA5TGS8sMprIzPA5Am1BOU5AloYS/Xqt3yLsSBynFvznDHbD8oDhl/js/4aiMfqO55zbghG/RWChzv++74j39EqKVlxThfBNAeuHvsOWoLHV5UHMEviXaMdmvzuyrVe/F0OjpYUcLJo5uokwz7Ab3cUh0jO21nPuGngu7m0LDu+BY/fxhluGXiiD7mZ3QHS+cSF0l+a2Xx0H7B+l7a+/74OYc37GcwSYkcadDsWtdS7KsNgKk61gSwZ8y9hQ5ABJltJZYWU2vSWMrs5L4x1h7Uz3P+Oe3sLhkcQn+IkpEPp9untnGZHdksa8cvJpg58l3SEXK0sMwGXLqRTlTnRr8rtkFVSdLmRZCM64T6go51C4cHbmaJs6aceeBbRsrUlB2A1x46l3YrVqGfrIEm5eMieJurzGfEyUDolXMoB428hhreNLM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(33656002)(36756003)(7416002)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(4744005)(2906002)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sdv7MKXdrSWYFyf1D5Tr6m9jWm+cJ3E7KCnvYYkiyZoOiAe5BCJTIk7vz96x?=
 =?us-ascii?Q?Jgx2bFsGJNhJHl+pncaiFUfx5Z/daKWwkwxghV5MEZD22CIgo2V7LnttQicG?=
 =?us-ascii?Q?2aM9Yj7pwPftbLE9/Ef81OsXTmmOVKboOnzuYzKFtKePdHVsPiruhWZmrNVe?=
 =?us-ascii?Q?BMqERmga7hcC+eb7L1qwOZ6fsD22JlCvfBmGaGCxgqVUSfX8YRgciflxw6R7?=
 =?us-ascii?Q?fxr0B+uiWcaZRaf0lFbf6Lh/inO1ntSJ+P/h+vtkKhKMrwMRAsyisu9biQXQ?=
 =?us-ascii?Q?ukVHZ+q9BqOtye1yvKdXosbEysDf93zSUwc5lniVi3ujlWVmLzl9r1KmUdwN?=
 =?us-ascii?Q?Lg4hLm3M/+6Kcg9202APzue83GfNQWS1IZRzauOpR0d18raB166BWJgDdAGD?=
 =?us-ascii?Q?7qPmAMKgeNHWkUZcdSDS2XPxeYZEVdbgI67tGjs31/liw2m5i2S7DjappJXL?=
 =?us-ascii?Q?gRuijZ2ntLg1IYBQhVRRhlAsA+2t3UUUYea8wzf+NDaSDB/RaInrrfKrnr6a?=
 =?us-ascii?Q?+3RYR4UHEaF31wNDZrnNlkVPxAAO+zTngBY2iGQXRlufESodi+QIhg4DC2g7?=
 =?us-ascii?Q?XTdFff579TBCyxJdk6OhnpR9kaYKfZ+RroC6zL3pXAuVKkgJN+zoJFpWDvjT?=
 =?us-ascii?Q?4LwBCotCPXkaEQnbyrfEE4dLy4TB0D5n+3w61h+TEz+XBS7MXhLh0/2xmLjE?=
 =?us-ascii?Q?ISSkoRb1TjpaZcJRiEGYzt02WvOjTS1FLe2IFu9shNoCZ3XlS1fF4przSNUH?=
 =?us-ascii?Q?s1QqBbPb/ABQbsUsX5XEPLsukrGPJ9g5YNOz3jvvp85TLhntJNhKmJljgypH?=
 =?us-ascii?Q?7Kh7sGcdM/HvmmIwr75F94ysrblQW0bqWe6uKEUGgsyJcQPhIZwuJSnKooxV?=
 =?us-ascii?Q?s9K+SeNCXylN2UzADQffmugCloWsoObhP5Dg0/RR6Bqki5lfFTWP4JdvWeEf?=
 =?us-ascii?Q?KoRrqhm3wi/GNb0lQSj+n0czjiY4vnFdqoK39xxnLtwTRk9vp1rJoQt6DLEU?=
 =?us-ascii?Q?m14ASP0Ut/B8HTUUT/55/hZsThzVnWFcdhuQNm/H8C71VWjenD3eI6qHZDw+?=
 =?us-ascii?Q?p8PjmmNqhnK+ExYe8LqMhGGZryxycHFpGLi6D2QSRDB7RskA7zOiDdVAjYzN?=
 =?us-ascii?Q?yaE8HEeksaVau92xQpyg6NCYDoJOyqU+u2tZAj/z9GFhys5fVbXN26wNW3Up?=
 =?us-ascii?Q?Q7Rhmc8FcT1WWYF16Uxe8XHIs0vFRJfFv0E0hXkLEQhOqtKLeUQDEi33BxM5?=
 =?us-ascii?Q?qXAWbmQXLkvKbVrhpqUhkwFoLFUEne7T6HmlPSTpEhw527XWS0RWeivnsBNv?=
 =?us-ascii?Q?4sLAXTMX4PuWosyKqXC1C5FujKwKPUk2bycObiI4dpYV2bCYGKP87hRdm+3N?=
 =?us-ascii?Q?ELnpu6y2VJQhqfTWxzqeQ6XtE66SgdroK/4H0fWdm+9qSloNmvTYjQnjFAl5?=
 =?us-ascii?Q?lWQMaaXPSQTNkIm14dDrMle0OysjuH1azDlT1usw0u3aFYo0Y438v+kyN2Ft?=
 =?us-ascii?Q?NtOC332D92CwTyBn85KB4o6XG8TVdXnefH1x8KmGJtsJ8FqJZygnK4fFggMV?=
 =?us-ascii?Q?I6qM4rleC2vOLWB/v/LARPN8LeRRI1FUeBJ7EKH+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db85f659-f780-4562-443c-08dbfa4c1a0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:21:36.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPeEVzlaltvTVgqWJ2qAR+eBBtIDz3mLFB54joTh4WfyE7q05soFXZA96hVf3ENF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

On Mon, Dec 11, 2023 at 03:53:40PM +0800, Yi Liu wrote:

> > >  From that thread Jason mentioned to make the invalidation format
> > > part of domain allocation. If that is the direction to go then there
> > > won't be multiple invalidation formats per hwpt. The user should
> > > create multiple hwpt's per invalidation format (though mixing
> > > formats in one virtual platform is very unlikely)?
> > 
> > I think we could do either, but I have a vauge cleanness preference
> > that the enums are just different? That would follow a pretty typical
> > pattern for a structure tag to reflect the content of the structure.
> 
> Is this still following the direction to make the invalidation format
> part of domain allocation?

I think you should make it seperate

Jason

