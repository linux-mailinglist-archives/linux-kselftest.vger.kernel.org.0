Return-Path: <linux-kselftest+bounces-2430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A881E4E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 05:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414D21F225EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EC4AF7D;
	Tue, 26 Dec 2023 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRjfS7tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADA4AF6F;
	Tue, 26 Dec 2023 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703566144; x=1735102144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gK24pVcSXHIch97o9NTTKL4nXKaeoYIdbdXfZSG5Q7M=;
  b=QRjfS7txZcN52o70WBlBS6PvSGeP+al9ElE1TgGG2L5xD0b8z+Kr9Two
   yWRFuZ9gll/+7mwNxCRo7w95DX4IeoZstB6XtO65Ite/+X+wnuRbtnDcv
   xjEptHxoQM/PoBO9K3pWWOnOUbkx/JU0flUTJMnhAESlzvzU76JccA7AT
   HDI5JHrO/4BjGoZMqK7WrspypdxKiBaLejZ+yLlvVbKFCrVudaZEnGUIG
   DdFgjTRtZh5xi2jfWCHvb7NxoCNARIbOaCaJH06pF/d0vWEefYKx4XdE3
   wtDWx3YQYCLC4BhVtUVCKHphZ431P4N/ylbCmMeIZg3ueIFySL4EdG23P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399105987"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="399105987"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727654180"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="727654180"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 20:49:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:49:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:49:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 20:49:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 20:49:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5KoHcVqq4KxuM/zI9C4rSfG9kBsb1AcEdaCK57O+vENdUcrS427SfEVx4ywaooxLGD0c9juFSNPlsBucQs6XOo9dxWKSMm9l9KnRkJRaMwvprmaQ41kYyQ1lHlIB7htnnG+Ph+ij1gUv30ByNjHyXzPs15L8l5CBdnl+sQH4LkqaI72/VKZ9YktlX4vt07I48UXAEgxqb6QW8t4mc097rDIKJzEuKTD2UwFJDBcBPKNXueNN2zeY6E2KYNeIWZJnq5Kn1vbjNog56/zfvr5BTyG7+iScmrnATXSYPxBDjlTKnYNeq6BsMAibDE0wzWI0z7Lfo63Adb0vNOGaMQAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Wl9el5Nk0LtwQ6+6whOGTVvZLUTemC4oZ+YaElXreE=;
 b=mLFOgElJ08CWcX6In0EzARR/4mtONmY/oaRFGdMT+8/+Qr+2n1x+0xNz9V3WKQDl+dTxNbTeQBKK9QMm2bAwCXQppTDsVE/F1uCrcqqEJ28KWxadl02RT2p/eBn9nSPo2fC8V/UJK/EAezmadGt+vAcCPEPUS6xYMcozKaDxJn0ZRP6EeL+x50udFEq123/MhyIvGZ6dF0P8PyQT1sJWRjgQV3TnUKFK+UZTKZOwN56jTcFh8tp8CEAEUAhC8VHCD7QPK9NMl4sk4tk9Gco8tTcBb5K+rp5sWVKPwYKD9WGyWRTOmsEHKOniK2wY5nGuNMUMF5kajP8RuyUGL4KnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 04:48:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 04:48:53 +0000
Message-ID: <cbd97b49-37b5-4445-a8b5-717b8ce99f59@intel.com>
Date: Tue, 26 Dec 2023 12:51:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <BN9PR11MB5276A45F5355A6DAA8CBE5738C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A45F5355A6DAA8CBE5738C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BN9PR11MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6355fe0c-2610-49b0-38f9-08dc05cdf58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVMrOIbbGBxm03bMuF/X67hpCfXO8jRc82yeDw4EqFChtF5+5w/vDv9f84SvfX/CcHNSKjsZT3awRIKm84wyUSoUHB2SiP0t9XFxFDu2UYSbroIaWjrRcmKmzK+k7zDuuECFHChr98aNRbS8Lpx3Jd85dqHxXHVfGa0xgJUSOGzWTXwWgohlrdEZj8TqYuab4HWyrUa8QoLsG1Orwo1Ji4EcbYJ7J3upj8jwuY8PxbHl3loydt1duQZZXc45BpjmlZyrIY374BMXr/nyU7kTgn1GZ278+QUDq7dQGR8ds7cIFW8/F/fUy1CPMxOxdIxtD1ezgYtoeItxa2j2oprlUROfvtqOUkAaeotQfkr2w+WVkEqjakG4oeyYuTvMlA2SKUSswFSg4bDcYUXYhq5ow1fEHGu740MeUn6L6X/YD2V4azs2AKb99tXL5NoICuJIVW+vJSZjK7lO4eu6H+3Z3o51fNnB0c/kvRsTmaf9TdOzl7wyzLECGwg+K/8fn+ua5YEALNDBi+yNjIYaU5HeDDhCOiGnLA1iJhJwizSNbolW5IPFpQRR8eheCpWSKE4UDnm2boH4bOVsdRQ5ILanZVmTf8UxGoZjm29CCg6u3dSxHQQOpMPKj7jW8E349GHjrm+BVK83BvR90Nr/tO/Z9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(82960400001)(36756003)(31696002)(86362001)(41300700001)(38100700002)(5660300002)(7416002)(8936002)(66556008)(66476007)(316002)(66946007)(54906003)(4326008)(8676002)(53546011)(110136005)(2616005)(6512007)(6506007)(26005)(478600001)(6486002)(2906002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01RNUcxekU0TVNBZzF2bTZMWjhPNm9kdjd2WDBkQm1iWlJVSHlvZXpBcE1S?=
 =?utf-8?B?eFVuSGpSZjFVQnRvTkZDSGNwVVRPYkFheFdkeDBGMEk5dVFTWnRXODBrcnZT?=
 =?utf-8?B?T2JlZkN2YWhZdDYvUVpOZWtoOHhxbkxrVU1jZDRLVCtraHJyL3o4SnR5amZP?=
 =?utf-8?B?cUNwWXVXc3M5QnRpSEwxemZ6enpVWU51WXhqNVdVMVZkd29vWWYrOWR2ZDZj?=
 =?utf-8?B?bUNmZk1IZ0s0QkNndU1kUjErRmhqdjFEWVh4RzNEeW94Y1JxTGpzd1A2aDRy?=
 =?utf-8?B?QjBnRTBEWXF0NnovekJia00zQ1c1L3RiU1pQcE5uNTJLTzZPMmtjZG1ZZkVo?=
 =?utf-8?B?VjZEb09ZKzR0UHJMbW9aaHdFVjJOVktJcEhXZXpvRStZWFhjOGwzUzJmOUYw?=
 =?utf-8?B?Q1ZaME1POStmQmovRHJsMWZaRjNwYi8vUGRkT2tuVzlrS1R3TGxWSUgyVXVB?=
 =?utf-8?B?bnB0VnNPUDNDUjJWQW9KaFJoV1EvSEVxSDlUQlJUYUZFdDlmRTdqNUhhV1M0?=
 =?utf-8?B?OEVYb29LbE8zMEtpZ0V3dENCanZjQjgvTHVHcGszem9pR3RrU213VzFxa2NZ?=
 =?utf-8?B?Sjd6SFFyOVFyU01lUVN5eXBacXJBV1ZvclZQbCsxaEdhN2paKzZqdDlsVjJu?=
 =?utf-8?B?MUJYc3M5Vml0d0pOb1VHNno4S0tXUFlFWStxL0ptYldWTFYxQUtWZEoxV3RE?=
 =?utf-8?B?UEJoenZjR0J0bndCTTRLTzlvZ3RKSW4zUG1ub3I1K0JxNEttSm1WeUlvOERG?=
 =?utf-8?B?S28wdVhpVjhnME81RlJsMjYya3JaUUhMRFRLWm9ibDU4YTMwNFgzbzlTZWpD?=
 =?utf-8?B?Y3IweEhhR2N4WUtRaUpkc0grNXpXTFFTSUgyTVNQSGxaM0tLYnRrVXZWZytR?=
 =?utf-8?B?cVF5cXUzZEhYYzhabE83eFpySEZkUmdqU3Raa2dXUXk2L3VISlJ5K1ZtcGZu?=
 =?utf-8?B?VmFWc3hGdFdURVF0ajNQd2xIWExXQVpSVVc5TnlOc0R1RGJpcEFtRGdRd3ZY?=
 =?utf-8?B?ZnVVa20zYjlHY1BXd1ZBVnZwYnVSMjN0cnorbjg0QUk5MCtGbmUrdVcxaXdG?=
 =?utf-8?B?SmQ0Y21xa2w4V2srWGx4V3lBN2JNRVBaYWVYVklhYzRLMzREeFJnUHFvdElx?=
 =?utf-8?B?b1FEOXoyUk42K2tCeGpWTzdiaVpERENMdW5UWTIvcmtwb0pBQStmUjVoR2Rr?=
 =?utf-8?B?RUtLU2dTZm5wZytmVkU0d1ZjYWpHa1ZibGVkbDdqKzlNVlgvcnJXdXlVQ2Vx?=
 =?utf-8?B?dVp0TlNkQmk5Z2c3Z000WFNqK2w2bzhqRHMycE0yaXVNSFZ3NWpmdkZmMzNm?=
 =?utf-8?B?MTFKRUEyRGFyR2ZvR2txdDBMTVluNDdVV0lQZXJxNi9PL2VSZGtSRUJhbEdq?=
 =?utf-8?B?TCt1UE9JL3doV2t5R1pQcnp3QUN2L0I1VnZuYU4rSnlQa1Z2RHh0SzM4Y0lV?=
 =?utf-8?B?RkpIdlFySUMxOXBGdHlaU1Y2OE1LZXdXTUJBWmNDNUJyVU81N1NHQURoVGIv?=
 =?utf-8?B?NWpnSHRqMEhhTG4vNVRkcldWbTFOd01rbHRScDVRZjQweTNVbE41QzV0WTJO?=
 =?utf-8?B?TzR4MWRGZEdodjVyaURGdW9UUndKZHVLRFNncVJsMGdwK05GQU5nU0c1UXNH?=
 =?utf-8?B?U2JLYVovMmpsY01IQ29MKzdRd29BSUJDdGxldk1yQjRTWEx6Uk1zMkRlekRq?=
 =?utf-8?B?a3gycXY5a0pncFNxZWpCT1JCRU1NZlRRSm1VUlNRMmh2Z2E2Q0NNWFlhdmVy?=
 =?utf-8?B?UFJVMm9EUUxhUjhsdnF4MTBiZU1aM3cwVFdTM3FoenkxcFMxMG82VmRCMHly?=
 =?utf-8?B?Mk1jNkVLRzZDUFF4TTFJcDdCdGxEbEdEdlJYWEl5dFA0a2xlUW5aMk8vMU9v?=
 =?utf-8?B?UmF5UmZQS1pvZytYM1lPK0RrUGltZG5kSzdDYnlqeHlzaG90SE1lUGVJYlAy?=
 =?utf-8?B?Z2loeDdhakdITkkwRGQwUUdNaVN2UCtKaTVJekcrcWhuWG1uMXpYZlJhN1A2?=
 =?utf-8?B?ZFJicGlxYWszV2lKeEloMXB2ZFR4YjR2TzFtWFd2NjdGaWNWZGFGQ1ZvSUVl?=
 =?utf-8?B?c2V2L0tmeWloVHFxQyt3bUw0azMvRGU3V3VtbGduSFNZS05UVjA4d25ra3ZO?=
 =?utf-8?Q?GjLKC2I5qwIg40VjAvB31oPuX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6355fe0c-2610-49b0-38f9-08dc05cdf58a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 04:48:53.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxI+RNWOp21CSmOxdEfwt1uelzPK1kl7moswTkGaesCS4zjt8HxnEUE27Bi9y8lqVs8BYzXFtT/ubJsAcyvIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
X-OriginatorOrg: intel.com

On 2023/12/22 14:57, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>>
>> +
>> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64
>> addr,
>> +				     unsigned long npages, u32 *error)
>> +{
>> +	struct iommu_domain_info *info;
>> +	unsigned long i;
>> +	unsigned mask;
>> +	u32 fault = 0;
>> +
>> +	if (npages == U64_MAX)
>> +		mask = 64 - VTD_PAGE_SHIFT;
>> +	else
>> +		mask = ilog2(__roundup_pow_of_two(npages));
>> +
>> +	xa_for_each(&domain->iommu_array, i, info) {
>> +		nested_flush_pasid_iotlb(info->iommu, domain, addr,
>> npages, 0);
> 
> so IOMMU_VTD_INV_FLAGS_LEAF is defined but ignored?

yeah... it is. It is named as ih in the driver code. But it appears only
the below code is set ih. When calling iommu_flush_iotlb_psi(), the 5th
parameter (ih) may be true.

static int intel_iommu_memory_notifier(struct notifier_block *nb,
				       unsigned long val, void *v)
{
	struct memory_notify *mhp = v;
	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
			mhp->nr_pages - 1);

	switch (val) {
	case MEM_GOING_ONLINE:
		if (iommu_domain_identity_map(si_domain,
					      start_vpfn, last_vpfn)) {
			pr_warn("Failed to build identity map for [%lx-%lx]\n",
				start_vpfn, last_vpfn);
			return NOTIFY_BAD;
		}
		break;

	case MEM_OFFLINE:
	case MEM_CANCEL_ONLINE:
		{
			struct dmar_drhd_unit *drhd;
			struct intel_iommu *iommu;
			LIST_HEAD(freelist);

			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);

			rcu_read_lock();
			for_each_active_iommu(iommu, drhd)
				iommu_flush_iotlb_psi(iommu, si_domain,
					start_vpfn, mhp->nr_pages,
					list_empty(&freelist), 0);
			rcu_read_unlock();
			put_pages_list(&freelist);
		}
		break;
	}

	return NOTIFY_OK;
}

> 
>> +
>> +		if (domain->has_iotlb_device)
>> +			continue;
>> +
>> +		nested_flush_dev_iotlb(domain, addr, mask, &fault);
>> +		if (fault & (DMA_FSTS_ITE | DMA_FSTS_ICE))
>> +			break;
> 
> here you may add a note that we don't plan to forward invalidation
> queue error (i.e. IQE) to the caller as it's caused only by driver
> internal bug.

yes.

> 
>> +
>> +		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
>> +		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
> 
> why is [non-zero-addr, U64_MAX] an error? Is it explicitly stated to
> be not supported by underlying helpers?

no such limitation by underlying helpers. But in such case, the 
addr+npages*PAGE_SIZE would exceed U64_MAX, this seems a bit
strange. But I'm fine to relax the check since the underlying helper
only checks npages when determining paid-selective or not.

-- 
Regards,
Yi Liu

