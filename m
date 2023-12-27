Return-Path: <linux-kselftest+bounces-2465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DE81EF59
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BCC282A26
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7745027;
	Wed, 27 Dec 2023 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3bye23i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092A45019;
	Wed, 27 Dec 2023 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703686332; x=1735222332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3aWlH9BrampTn6m9BH/0cvHno5FP7cXWPS6JYfOY6nc=;
  b=E3bye23i2hXxPTIDH1tkaAKr82YxHaCiNw8xm+dHRU3szTo7yIAWycW7
   XLPlaEYzBmkJnY/LbJuo3YJTHQSR7zndrFyWMKmGgLWX09KyHWoswDq4t
   mhsYeAdr0bMCl4Kz1XosxEQ3h/Iz+yFCE8iXZbPzDxQVRpeTO+fi5Uixh
   ebGgo+o7nibKpxSfske4SD1qZOaTGDRl1R7DVTycqm1Ze61uuOma208fE
   yE6r3KpiTrTZoatwyTMIQR6etwa/cfxi4pO47M+2C7fr9R61vH+tsgrh9
   78MzJgNJWX41EkhzHF3Qkh2rDmevaLf5+HEfKmMKpQDCTtL11J641mjB2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="395336961"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="395336961"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868866956"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="868866956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 06:12:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 06:12:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 06:12:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 06:12:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NreQD4Ky5lwD0hMiE9CEnokAJy2LrfuGavUqgcpr82wM/LYTJ533K4uZxSMBUwQbCHKJEb/rUabjczDoZl7GQrKGj1OQc/7O2bm0p0m3pA3EJS6hYms4iG0RnPvijqoFSAgjxMOWajRvaN/amQNrALcQaIK0IyplHvdi7YDKKITjED3deG7YGR7bT8RyERM832Lbp8EFXIliqO0w1ZAQ/M7AN7x7Dt2w+a8yA/DUTUqol8DTabqEE/qjyVDfrEl2+WUL5PeRtUZkYal0/4fjsF1vv2Lk8XtCo0dox4ayz8O9MT5bvKnEOsLDwEaIkmI+5PaPcbUVDy3JqGYFRyWGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8rCjPu91rpoVq5R/6dDYUvVkxBnae/RwytXzJ5/SAk=;
 b=QgujPZaniY8/FE1fZBL1xmYw1k5FbMVCHYouf/RkTp3e9Srdx26S3RxPRZJEYLQJoldo9nTwN5Rzdsujr1s/AfJarPMyVoaXWyoA+edxEH/YQWZA46cFHjYJinfrXMAejIoQSuMqHwZixyOfivgXskDcXKaoW01D6zU86iEMZhLDV43T3AL5sY9TVYHuib24njkIN5y0sHy42w/1PixxSBnf4l9wse7X4EUvRMu02UQXYNyBCmyGjUywgUk0otTsc8KrL+Sp7m7xat3YaSknUakv/1UGU8jOl29enIuocd0ycjzyt+JeG+vpqtCXDIPDZs20/K9UhTtLS3VU2PXGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 14:12:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 14:12:09 +0000
Message-ID: <f76965db-5283-46cf-9654-eb80a248bf55@intel.com>
Date: Wed, 27 Dec 2023 22:14:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <SJ0PR11MB6744F3EC34CA79A67548336D929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744F3EC34CA79A67548336D929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 982529cb-bd36-4f5d-0488-08dc06e5d011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC6FVNsZgENzTCFaLgpSJrjKHWfgWTRnvAJV+g7WgQBBMCmYUGJjznoy7DKEhh7s6kVNuBg4XsobxNfV6Q51ok0S8LhVoiZwWENMSHrJcJfBmmFWURxjSqq24du+vXHdxlRFoJi7mVAikiW1nBFdV2Q6lnk1d749n8Ba3ZhJCsGhZEeQwViox4LFUc8ZR+JsrNyvmvjGDqMyzJeeB0pEiygZdaj3QLexQPmkutKpcGeyzIsLWHk83xBtPKHCkID8QeNreGobVs9muGYnJSEglG7+b1odDhgi60XU6XwKRsIlsL7e7cUSm+sd/79haZFE0xQP2sK9ABdMdBS/ddsvWe4jlDMdjbNk6N4i4wWX1wR6IN66uLCAmfBA4OTZHfeXnqphCJFjabwFVykorkyRsyf6CiFo6xrM37tQOvNImvUfy/m0OKrLg28IFop+qFyWIvIreKM/YVK9meFXTR0Ib6kFmtmngM1NY/g2apEoLZiMwPGdBdNhw4EhkzMtIw/Wh7SReb133SRrMIEgA7N0a6K/+pMakCstxbSxwWOZz4Q/DMAxjEmtKYTBLr27STXoCUUcjziY9BuBYpmvMJt5DmYkp07KzuzaYVpDrlKYYas9vaoAiJSz79IphaPYwgPML1zv1otx+ipjg113EJA4NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(31686004)(66556008)(66476007)(66946007)(5660300002)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(53546011)(478600001)(2616005)(36756003)(6486002)(6666004)(6512007)(6506007)(26005)(86362001)(31696002)(83380400001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUliVlp0NUkyMmp5dnJ1QThBRGFrM1pxY2VobGVPZmg1bFlJUXJ0alZvdkhT?=
 =?utf-8?B?NlAxdFdVUzUvNFhUeTllaXYyVWI3ejVXTTgrTkRRN2pIaS9DR3ZSOUFzVEl3?=
 =?utf-8?B?dzNXdzV1eGJ6d3MxVGhHSG5KVitLeVpBaXAwbWpDajFYNnlPQTFSNldmWGli?=
 =?utf-8?B?ZFV1VlRjayt0U0lzM1Y2cFFrY1dVdW5VU1RsSVdOVVBTV1pFeUQxRnRLSVlr?=
 =?utf-8?B?dGphc09UbUVSSnh6VTZQTWY4RkNkU0kyVld2a2FxTHNkKzFnY0dFejhnNzIy?=
 =?utf-8?B?Z01HM3hXRFVWcEZzUTkyU3lSYzF4REJxOGJlZWZLbG93T3dKTm5jejJyandh?=
 =?utf-8?B?TkI4a3c0eTRFODVvWTlBQUM1b0ZDMUZ3b0lQemdMZndFck8yTDZDUVN2Qndn?=
 =?utf-8?B?dnlsQUN1MzlEWXMxUG9HYy9hQnlEN1d6VVJtazRBa0VPWDR0MU4vOER4Z1do?=
 =?utf-8?B?ODJESGlNRERBQWFNb0VBY2FWUHphT1NhdHNmRS8yeGN3dlB2QVpvaGg5OUM1?=
 =?utf-8?B?a2pzb3dSMW55eHRuTWcya3J6WXBIdEx6K0czRlFpU0dvNjZJbkMveHlKcURw?=
 =?utf-8?B?dUd2NXprY3VBMVFJRlRPZzNMdmdyQWcvZ3Vzd3RQb0gwWk5LQUJMSFNjb1NR?=
 =?utf-8?B?eDRldk9IbDZ1NThPZkxrSXhqMzM2NEJ3ZnpkZjBLTm0vVlFod1F6ZkpBRS9F?=
 =?utf-8?B?WWNnc2ZyeS94RHlQclRDYlp5WkZCQTg3cUJ1d3Y2c0NlRUFOdXRUeXVYNUw2?=
 =?utf-8?B?QU1RbVEwb2lBQjRVZStBSS9zSHljdDAwaHBlM0lQTVpWZzE2dW5lc052cGNX?=
 =?utf-8?B?N0pzQ281Rll2VEUzUE4vdmhQb2IvREJZd3NiSjhqc0h4MHplV053SVZuZTBU?=
 =?utf-8?B?VDZIeTBTcUlMVXVmQ25ldWRDMFhUaEg3NGZLUUJ3SGVmNVpXMURlU05QUHhx?=
 =?utf-8?B?VHNaNmpWTjI2aHpEeEhmR3J5WngvMjBTNGtTV3M4ay8rWjllWm0rc0dFenlV?=
 =?utf-8?B?OU9yeXZnTFFOVU9ab0lVcGpXbCtnOGl1eVpWRWZYempxa1BEd3BQWWd3THE2?=
 =?utf-8?B?WDNTVmFMV0tqUXZROFNwUk1BMzJtMStUcFNFbXNnekpBMGwweld2bXBsSWEr?=
 =?utf-8?B?djVuZ3Q1VEV3dDZhN1VacUxMaVdHZUNHcksybjRUL044WnIrcWxGS2hFMnZs?=
 =?utf-8?B?djZ2Njg5SERXS3dIYWxSQk45RzN3QVhScVNYSmJNVmlpOGpFUXJjNnY0cmNi?=
 =?utf-8?B?UjlqUlg1WWE3dlBObnc5MVVSWERIdXhvcC95dUY0bG0zSjM1bHR6WjM1WWtY?=
 =?utf-8?B?ZHZIRnd2SmhUWnBzOEM3emxqTXZaaktHUFNvcHVsN1UyaEV4SFc5ZWZrcFhS?=
 =?utf-8?B?OTd4TG05K0VPcWZ0S2dJRWY1N25xWThiaDhwaXFnWVVyVnNOTDd1MlF3dWdq?=
 =?utf-8?B?SE1OOFRXdzZDenZYNGpDL1pKSmZQN2g2UjZrWmpTaVkxT3ZaZVpTUFJnVktQ?=
 =?utf-8?B?ZTNJeUpWQlJvMWpvWDlsakJZbGlSMndablc1Vmd3dXhDNElzcU5rSXdkZXpT?=
 =?utf-8?B?RENhQWhDdU0zQ2lIOVdnTFA0WGYyWFh3TGlRMlNxVFdJamQ1NnRTd1Qxc2pK?=
 =?utf-8?B?dk00eGw0cnA5d2x0TC9RK3hiQXZWc2ZPM2NMRUNCNHF2UEFBT1ZTMDJlcmFZ?=
 =?utf-8?B?OU9FWlBwMk9OTGJpRGVTa3ROeFlnS2xqSDAreXBxRmJtNUVTSFptSkJ5YzlC?=
 =?utf-8?B?ZkRMZUUwUFNVSXovNG5kSmxSS0VaRm5sK3lxZkgwcEF0WGh2Qzd5K2ZKc1Bm?=
 =?utf-8?B?NVhkcjhiL0RoRUtzbDFjK1JkQWV4M1ppWEE3R2NtekFSNTdXV3p0VVUwTlJ3?=
 =?utf-8?B?UUZ4aXExSndUNHZOYUxxZ1FKMHBYS1FiMFE0dWt0YTJRczJ5aWJ5d0V4SjRO?=
 =?utf-8?B?ZzJRQTF1REJmSWdaYTI4eWZRZWVFdHhaR0xzQ25wSFhKdWdNcllUbStJc1NM?=
 =?utf-8?B?cUhFdy9SU3I0UFU4YWtZSTI2T3RzNlM5eFRDLzRTUlliQXVsV3ZUYkdweFBH?=
 =?utf-8?B?V2V2emVaK2orcTloMVdrTFU3cnpLZkJJN1I0dVpCQlVnTGRzQUZ5Qm5hMWxn?=
 =?utf-8?Q?2KN+Wt5CuULZZjD9RXp5on9KO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 982529cb-bd36-4f5d-0488-08dc06e5d011
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 14:12:09.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsewuCh2FdZ9XGReKePcMXRGYjsYHHp2Du3gzA6rYaUig5abuKGKk0VHSm4xVfgRUIieVaiZhHh3PMZHwR7YMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6239
X-OriginatorOrg: intel.com

On 2023/12/27 17:27, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> This implements the .cache_invalidate_user() callback to support iotlb
>> flush for nested domain.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> drivers/iommu/intel/nested.c | 116
>> +++++++++++++++++++++++++++++++++++
>> 1 file changed, 116 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index b5a5563ab32c..c665e2647045 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -73,9 +73,125 @@ static void intel_nested_domain_free(struct
>> iommu_domain *domain)
>> 	kfree(to_dmar_domain(domain));
>> }
>>
>> +static void nested_flush_pasid_iotlb(struct intel_iommu *iommu,
>> +				     struct dmar_domain *domain, u64 addr,
>> +				     unsigned long npages, bool ih)
>> +{
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&domain->lock, flags);
>> +	if (!list_empty(&domain->devices))
>> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>> +				npages, ih, NULL);
> 
> Is it optimal to check if domain attached to iommu before trigger flush?
> Or the check is redundant if intel_nested_flush_cache() is the only call site.

I think it is possible that userspace issue an invalidation on a hwpt which
does not have any device attached.. Though this is something stupid. So
checking if any device attached before flushing still makes sense.

> Thanks
> Zhenzhong
> 
>> +	spin_unlock_irqrestore(&domain->lock, flags);
>> +}
>> +
>> +static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
>> +				   unsigned mask, u32 *fault)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +	u16 sid, qdep;
>> +
>> +	spin_lock_irqsave(&domain->lock, flags);
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!info->ats_enabled)
>> +			continue;
>> +		sid = info->bus << 8 | info->devfn;
>> +		qdep = info->ats_qdep;
>> +		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
>> +				   qdep, addr, mask, fault);
>> +		quirk_extra_dev_tlb_flush(info, addr, mask,
>> +					  IOMMU_NO_PASID, qdep);
>> +	}
>> +	spin_unlock_irqrestore(&domain->lock, flags);
>> +}
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
>> +
>> +		if (domain->has_iotlb_device)
>> +			continue;
>> +
>> +		nested_flush_dev_iotlb(domain, addr, mask, &fault);
>> +		if (fault & (DMA_FSTS_ITE | DMA_FSTS_ICE))
>> +			break;
>> +	}
>> +
>> +	if (fault & DMA_FSTS_ICE)
>> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
>> +	if (fault & DMA_FSTS_ITE)
>> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
>> +}
>> +
>> +static int intel_nested_cache_invalidate_user(struct iommu_domain
>> *domain,
>> +					      struct iommu_user_data_array
>> *array)
>> +{
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
>> +	u32 processed = 0;
>> +	int ret = 0;
>> +	u32 index;
>> +
>> +	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	for (index = 0; index < array->entry_num; index++) {
>> +		ret = iommu_copy_struct_from_user_array(&inv_entry,
>> array,
>> +
>> 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
>> +							index, inv_error);
>> +		if (ret)
>> +			break;
>> +
>> +		if (inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) {
>> +			ret = -EOPNOTSUPP;
>> +			break;
>> +		}
>> +
>> +		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
>> +		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		inv_entry.inv_error = 0;
>> +		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
>> +					 inv_entry.npages,
>> &inv_entry.inv_error);
>> +
>> +		ret = iommu_respond_struct_to_user_array(array, index,
>> +							 (void *)&inv_entry,
>> +							 sizeof(inv_entry));
>> +		if (ret)
>> +			break;
>> +
>> +		processed++;
>> +	}
>> +
>> +out:
>> +	array->entry_num = processed;
>> +	return ret;
>> +}
>> +
>> static const struct iommu_domain_ops intel_nested_domain_ops = {
>> 	.attach_dev		= intel_nested_attach_dev,
>> 	.free			= intel_nested_domain_free,
>> +	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
>> };
>>
>> struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain
>> *parent,
>> --
>> 2.34.1
> 

-- 
Regards,
Yi Liu

