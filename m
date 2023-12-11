Return-Path: <linux-kselftest+bounces-1558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0EE80C9F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FAC1F2170E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB293B7AF;
	Mon, 11 Dec 2023 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPRfbcJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969828E;
	Mon, 11 Dec 2023 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702298056; x=1733834056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPeX2Z/YGUGFo3xc6wPbN5czKesMhTNxgH6ssBc7UtE=;
  b=EPRfbcJ3RzCJq09EuEVKARD2XnrG4xCpcrs8q9RzLS5vHgfIKbdOJb6o
   QfCQxncc5x0N8deMUn8FtgKD6yffgtBIIbfYT/VmXcHQ2vUCpJEjnCp5i
   U6zMMWBuuFjrD1Heifo/a+JYLIf3rDpv5XBw57mH8lA5z2Ggf0WZQB6KK
   sJTtHMMM6ODu7MH9Ao+LaMkLmZBtywxCHJ4CDp2oaUQR/OZPM+pY5r+G9
   tsA/B27ksenPx1AedZeO4OIVIA/tWgd4ScKLbpYRMB12JMVmnVw+ly7er
   puCpKiKNh6SBv5nbcdR3UUzOn/ItvVW+CNOsAVcTsMfq66bbrYqtL0NhO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="425767703"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="425767703"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="14430400"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 04:34:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 04:34:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 04:34:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 04:34:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 04:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myNZILwtwuEYwwrr+jCqfl9OmEV2K6E5/ljjFkkapud3qG/hlv5pJa6CPH5RAEGN13vIGN6J3KC/nT40H8ehOL9R4F1+64JhhhJuwdB1s9o1jKZGt20tRnwTWCtz5juVnLb0ALdbVWut3f3eANRJzwgoex6FRtQmIu4zUE1p0opavaR1MHlre8UfbWSVzBde2skqqHq9Ea1O+s1G3RzxT1Kz4l113DjoewNuBi9VU/73u4wSoGQEGa3E8r+E1cQ6QqE2HqWKwuKtvAgsZPF/yqH38RAj0CjqHh/Ee/KiybZceDxwWMlUZNsq2kOq9fKleviN5bNWKXfUyTTysxQcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YBHNJBCxSq6uZZFoRKYnazCNqbsn0RrprNaVUIVAvs=;
 b=L0AwgR8dS3q4q2kCEbz5MyE5wdY9V/uGkAripKYQH6NG1asXWeUaNHw7UXET/QVW4WwoNNWEJjMK8OuJsy33gQFJ1S9Ivl53KRxHf/GCCRBu9q0P1BwKC1EchMOtmdLWGd0R15l0K6SBqxXfDHIqWU9nDvUXPcPTaj1UsBG/nZWz1pp0aPkrXVcKSX5M8REC6K5KEz9mioqqXUKm/Fb5sWlgO3KhuUnerTCDVybaZuIGXaB7mL6/4xeub5VkrRKcuxK6/uwl3ADI55m/Ad97g1bvedmUgGLwZdTs0XbIE8P68vlZlp/juiSXtMJpkxJ6GBpD4gv0K+xhCCeJ7VsNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:34:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 12:34:11 +0000
Message-ID: <3e77a4a3-3be8-4e04-9435-1f66df93078d@intel.com>
Date: Mon, 11 Dec 2023 20:36:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Giani, Dhaval" <Dhaval.Giani@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a3316c-2873-4268-8d2e-08dbfa4579cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ahgjxhXRDjmXL6Bu11RD4GwStj4pg/EK+u4/3xP02Xa16RYChCXQTRbGWcw+CU6IV3HkeLIWILOzZSzXiGT6fvURkmOZGzVdgCbvneZ0UnebzIOHrNKnJtKhT4/oMvMZ32qdSiVsRNQxa40eugTLooGJ/xenX3k/jUTdBwfDPjOgyYvS2Vk5mwNNLrZZoCyB4vgzMOoae2IH/JB20yHpTAL/BFk5zysiW8E+5R3HK6LdIiIU4KbyqsXo77LaECtiQAVTyOtPTClQejXfRvGnbVeFJmF2oPi/SYq6e0/0hXNpGEwv4Ek2bjeqjpLebtvDiCBsH6BGq+1lJHPtwRh0XnaUFNIkvRvgDKzInD5+resKB2cP63Zeu3ffQnZ4PdQj/vC0NkRPcDwE48BQOwOLIXT3xeAvi84WH/juNq64aL5pXH3M/PfrC9h0tQbYtLTqfsQ9fo2t62mTHrUcdd9WPmtMrBECry2NQC6bdt+9ltjEl5aM/9nv0FgSyGg5WMNvH+VyXSDrx7wiB0Lagsba7nbQ7xkq+RLDzGPW1rwT9KQFwHhr0+k0CGa1/mgLAq5eYvy82/7aLX9D8oaz9dx2HyHk2XVLNEvwayTKO1V3qEVT3TzfGMxPB2CVsMhP5y7hbi9ED/pw/Ce3mgvOn53XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(53546011)(5660300002)(26005)(2616005)(36756003)(6486002)(7416002)(66946007)(54906003)(66476007)(66556008)(4744005)(2906002)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJvcUl2YnUzUGRjQ3ZQeGtJRVZpQThBd0tmK1FiaDBTUlJIOGgxdEtjbUdN?=
 =?utf-8?B?YW52SXlZSlJEcDIvS3h6eGtXNlBnNnpyVGEybzdRL3owT1NHcHlFT05kaitD?=
 =?utf-8?B?WmxmNlNKa1Rxc2NxbGNNcE4vT2xYbzN5amFyM3dCRDFSV3JQVkFvOWpUMFhP?=
 =?utf-8?B?cm1CZkQxNlNIaTZtSzFGbldYb29WWWd3bmVUbDhwSkZ1UjNVVlZuSzF2WGww?=
 =?utf-8?B?VytvemMzN2t4RDZ1OTZ3SlJMWEpDN0VRY3B6YjlLbFBZbVBUSzZSR1crMFd1?=
 =?utf-8?B?bE9CNmFXKy9ZWDl5ZnhOS0dWMzlSNHV3QjBBViswOFBtOGhCNjZHR1gzWW1M?=
 =?utf-8?B?RVVaYWtLYjN1TXpSd0dSNnFSRVZ5MGhuSG82UHlzSXBVaFoxWkZYTllwUjZo?=
 =?utf-8?B?Q3lTd1puVXRTZzF1dlhqUm5CVkdsbUVib2VNRGJhQkgxS3ljWG9xNngrODQ0?=
 =?utf-8?B?eE53Q3ZJNkJRUitHWE1nc3VhTTIxbEJoNDVmRW51cUlJZXkxSEZ6b3l4S09l?=
 =?utf-8?B?NFlPN0krTEkrNjhLc01QTzU4TDhYV2NrSFNxcFRQcHNrUU1hVzNJSjhmK2Y3?=
 =?utf-8?B?bmlwUFBJQ1RKTnNWSHVvMW5lU0NWSWlPVEdzbWQrTzZJZzlQNWZybk1YSGVp?=
 =?utf-8?B?T2FsQ2dPb1gzcHlIOHNzWnVreEdya3RZUWNRRk5JdmsreE8reXdKb0lWVGhq?=
 =?utf-8?B?em9pSFRIZTZBbWwzYnd3OFY1TjBobUFKOWJLVy9pd1VwWXB4RGozWDY1Rk9F?=
 =?utf-8?B?Y2t2RDkweUlvVVdRMEMzOWdXY0RjY0xPNTlCRGs0MVg0NGJ5UE0vWVprdEk4?=
 =?utf-8?B?YW96TWdqSGt3N3RWeTF3TzVUNjVGT1BJcGg0QjF5MjZJZ3VwRDh2TGZJdkw1?=
 =?utf-8?B?RGZHY0tLd3FsRStzNWliL01IclhkMDFXZ09DV3dyTStwYnFKRWhNbURqQ3JJ?=
 =?utf-8?B?Z01tK1pnR2VoWGo4Y2ZCZGhWUENUREkwemplb2QzRWdCNCsvM3pLUUM0NnJG?=
 =?utf-8?B?eWo1K0xjd2JmWnBtdU13ZFd3NURmQm41NENLdTVMK3duOUlRRUdlQ0dhZGF1?=
 =?utf-8?B?dGI1K0MyVlBLN3lsWUZDUjhueFVyZGhHOXR0angyVFFoZldVOTB1QXdCSzhH?=
 =?utf-8?B?ZUNQTSt0cHQycytoUnpXUm1DZWthYzl2MGgvZDBNYmpFaGVFS3VEdmpZNUw2?=
 =?utf-8?B?ODdBYWhkZ29aKzZqVUQrTWU2aHF4cjE1VzZad25sT05QSE1yYXFzSzBEMGdT?=
 =?utf-8?B?c0FPVG93QkxxNnFOVGZVY0w0Ni9SN1BWVWhVcEpYODZrZmM2Z1JkbkIyK1ZG?=
 =?utf-8?B?YU12ZEJxeStBMEJTVkhyZHNhZFdZaSt3MGs4Qk5iWDYyeDFuNWJ4L29xVzVL?=
 =?utf-8?B?MlZFUlB4d3ZuNzRzRFlyVjArSDR2eFc2V3JFWjQxbXlINjJEN2k0RmNXSXZm?=
 =?utf-8?B?ZFl2c2JnLzAveUV5bEVxVmJRQWJJQ3REa3ZSSVJxOGxRNXFjbHQ0M3Rtbkhv?=
 =?utf-8?B?M1hXV1k0ZGt3TnhLcWl1QmJWQlRkc2p3TGdibnBqdXZoeDFqWmNNd3U2SnZv?=
 =?utf-8?B?Wk9lc2FhUzIzMFNTZU1nSGhqdHVEYisxcEJxSUNMbnRDdEcwbEY4L3cvSzN3?=
 =?utf-8?B?MmtZd3hnN21OVTRNWEQ2Vi93eFAzYjhPTEQ5QUZjaDlYcklOZjNBM3NRZ0pH?=
 =?utf-8?B?TTduNUZ4UUlKcXJpYmp2eHhWV2hvYVhTcDFVZytIdXZVbmFOYkJoQ21WTFk3?=
 =?utf-8?B?eE1CR1RYVHI3RGEybzJEaGpZaGptUzAxbWZFY05UZmZvc01jVEEvbFFSL2RK?=
 =?utf-8?B?T1lZY3dLWVJ5U0FlSUN2a20xQkNUakRkcDdwZzBMSWI2ZVluRzBFM2JkN1E2?=
 =?utf-8?B?dFAyaTlubDhMS1MrS2IvTU9kUm05amJQanpoZDhKVEJrclROSXZXQjA1T2pl?=
 =?utf-8?B?a1U4UEJHbEdFRFZMTUtXWE13VzUyVkFrcURtcm05djBrdnpqZkVCdGJtU3h0?=
 =?utf-8?B?MDAvRHZjQXluS2xhdVhkKzlxYWpoOWhVc1pqNnlTWlM0THRReTBYdXkvdUoz?=
 =?utf-8?B?cmY0T0Zvbkwydk1jZU5ydkpIaEFzTllYS2VVNVJjb04yM0hWcnYzdC9ycklX?=
 =?utf-8?Q?9YQ+ta167mZ7pbdRvEWe7tHMT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a3316c-2873-4268-8d2e-08dbfa4579cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:34:10.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0Xddd55G0fpUoQZZQyGDk8cLHssFpXMEYciEolpzgOJER+YWmYKLWhrHmgDVqGLKox2glFj9Of2I9p5Y9S8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

On 2023/12/11 10:29, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Saturday, December 9, 2023 9:47 AM
>>
>> What is in a Nested domain:
>>   Intel: A single IO page table refereed to by a PASID entry
>>          Each vDomain-ID,PASID allocates a unique nesting domain
>>   AMD: A GCR3 table pointer
>>        Nesting domains are created for every unique GCR3 pointer.
>>        vDomain-ID can possibly refer to multiple Nesting domains :(
>>   ARM: A CD table pointer
>>        Nesting domains are created for every unique CD table top pointer.
> 
> this AMD/ARM difference is not very clear to me.
> 
> How could a vDomain-ID refer to multiple GCR3 pointers? Wouldn't it
> lead to cache tag conflict when a same PASID entry in multiple GCR3 tables
> points to different I/O page tables?

Perhaps due to only one DomainID in the DTE table indexed by BDF? Actually,
the vDomainID will not be used to tag cache, the host DomainId would be
used instead. @Jason?

-- 
Regards,
Yi Liu

