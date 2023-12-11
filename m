Return-Path: <linux-kselftest+bounces-1521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428E480C7E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A261F21210
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302936AED;
	Mon, 11 Dec 2023 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndhtUdeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEDFAC;
	Mon, 11 Dec 2023 03:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702293854; x=1733829854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lr9XwkHuclPGdgq3pdi00s3Az9VOgOYQVu+ZxJvNES8=;
  b=ndhtUdePJ0IAVfOeVfdtKc3KgVpZ2JZqPe+/VQSwwslyyW+geF2I33sH
   FTT1SefvOg6b1O8qOGIfG6FX59CSrsEqLguiEWkYIRtYVc2AWewFIbUZ1
   QoGJ9cOGZA7p3TAa+NJlogLcxJGWtC8dbQA36b/nb+wmUE2RpdKwlQr0Q
   f97CBu78ZiyrtADmJlecyw6R6v8r/jwLE3s/K05qmTd0hcQ4RV6W9tOG4
   bo9Ml0lXSX9yzuTDtv+pjQymm/+T7H1DBLhQmzpVYtYvxrmztKCCAtZVJ
   P2VuQjxQ5QORfl4XGi+bLYrQ1oDSaC6hnc1Pxq3mr/cfvZmV1+HYWb1YI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7984050"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7984050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916801549"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="916801549"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 03:19:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 03:19:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 03:19:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 03:19:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 03:19:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgZxVU2dilBNpXXd7UIB5QrHgkuSyKPY6mFrJRcuXO8JYNc6Mgggab9NJl762nOEqgvYhYprQ1Kq/Ucu4Omq+PbCNmCkfLNP1NCJotU6C2LKDMBz7aRFup7G874vwsbCdDm4fXuFIBX9wa8Wq1JximjCRuh2RJekaDwamom32jzs3eSvLEqOCmAO8CPjBE59teB+yjdGNO2NFHmyyW5ah3nQRuzdcu+Q3YRhDGcJbQ34zqzweSweKya6enRqAvqVWOHaLAdR+6WMSyV9+S+VAzO0hCcC6HCp8WIq2UXCVyft/sNjoCC2vZP8jIYs47IGXJ97jdg5x8tqfsfqrvGynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEuBFUfmB09dRXw/OIryyB8FIEuUqxR+9NMaN9SAxc4=;
 b=DIuBybQhO4H8FbMTclUGZyB/vvnu2N+Owe7HurBX00EyUeg9vHyoQTSjkF0pezLH5pcjqnDRG7WQJfSOIufmOrcuN0Ym/1XKUJ5AdcbRkuQsMNx3FERGQ7x3j19AMIyJwrX32gKMfIAPZQUQ4n7G+fM3Sv4J08htkq0dPz+bBFrwMeJiJGkttTX1hfSU7U59rOBOiXwmhR9Q7L5FvKiIJ8tu94VTtDgXeZwd0Z8q0VSkbQwhY1ozZSjACVK2MWome0obbMZwIW7Dn8YcfthnYUIUCt/DwtiPZkqfIvAnIftyhiaHMFfTPbArUwhnOp1wXDIlp7nHmnV5tpdyx5wb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8548.namprd11.prod.outlook.com (2603:10b6:610:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 11:19:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 11:19:08 +0000
Message-ID: <c019a91c-3412-41fc-ae20-d8757d87a83e@intel.com>
Date: Mon, 11 Dec 2023 19:21:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] iommufd/selftest: Add
 mock_domain_cache_invalidate_user support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-5-yi.l.liu@intel.com>
 <20231206181636.GX2692119@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231206181636.GX2692119@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8a9dc0-5563-4b84-add3-08dbfa3afdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eni9MP8XZEXXHTjNaxdNeIvzUKfTmr0b3lPWfxx5NG+4bvfNypxRwLTEMdekjeXXa6ShYbX5sOCZj2dq/amlD0m/i5f04PdYWNveYEyaKXsMPW+8L9mnIBGw46MvgFBvRkZyJSeK6deCA719kHZudO9+NqyBRWgBJJnu0RPl0cXN8ky6+Ux7p0d43DndEEqSEtjre+mrouSyZ8TDbUlw3edsaFMKbL5iDCk1FTqWew3ZplJ00BvSOpv2KXPIAP9pklQw1MODYH3Hx3oiHyblZKiWgj/umznTfC921ca8cAaHtCDsIG1rfV+vlBNuJ45Xb3wuuzyxnPrPr6RveExjJH5BV0n/ynEQFc32Pf9GDMBSY/aMBf04wW1mQTKfdgKowQb/A9MLn59vowsbLWfWyNKSSnSLAfih9guXEOluizH1Klcu2bmPTI5ECTGjWRIYe12TKmgrzKiPC+f5NvxZbcbgn+taT4H4Qm/GfVV0A9VToZcnPUdcflOdHQRz59dXEMHu2KQdujEwPDe7KMaV8KL+uo6CCPTxpMyoUEYGjGVyK4cJsqwu5gobmx255aah0l7AlPhm2Lf4C4AUnA7QT80xEzQY1IcP2/zTyie3Ngh3OhniOrU05kYdmLmkYrS2dT5Z01KasI6grv+oRWfx7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6666004)(6506007)(6512007)(53546011)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(4744005)(478600001)(6486002)(66556008)(8676002)(8936002)(66946007)(66476007)(4326008)(316002)(6916009)(82960400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJOU0lpdHRPSzJiTHNvd29SeGE3aWtJV2tHUEFvdTVISkVSUzVqZnBCci8w?=
 =?utf-8?B?OEg1OFRKdVFDVnlvdlJmUE5yTVhsQzliaXVYd0VybUxUd1JjN0gwZ1NjM1Vu?=
 =?utf-8?B?d05CVzEvQk9ra3M4ZkVIdXhoTUg0a1k2OFdqUUVtTXBnTFRhMmZ2NUVCTko1?=
 =?utf-8?B?U0M5dWNhTzBWQURGMllwclNSSzBacmY5eGpoSTR2RDFvWHlHOVFiMG43ZDh6?=
 =?utf-8?B?UmtIaXBGWEFiaGtnQTRDeVlnWGp1MmtON0l1VGtNTStYcWtVZXB5UkJGcUNw?=
 =?utf-8?B?N0FUQTBBYlNBRWQ0N1BVN0NWMExtOC84dytZa1RDMTBLM3I4eml5SGFISFEy?=
 =?utf-8?B?U2l1dmsyNmNaWVl6M3hDMENNSjhNREVEVlNMK3BYSE9XRjFITUQvalErdzZD?=
 =?utf-8?B?V2xjQmdFd0VrNmMzZmMvSWpzQm5ad1JZMHNHcEc3ak96aXNlbVRLaVorSkZx?=
 =?utf-8?B?Z3h1bzZacEhmKzNxQ0wrcWRoSUVVczFyTHRRWWZJUEl6UnlSamppdUMxUUNj?=
 =?utf-8?B?SHowY2xnYklydGpYbnh6cFFKaE11cUFuYkMwWWJNcklqMXVDYitUL0VjL0VF?=
 =?utf-8?B?bmMyUjdZV3BLZlI3Z2llWkJnNXd5WU5VRlN4RlBDdU93QS9ibjhkMFpEU3d6?=
 =?utf-8?B?VXBmNitMSU5kYmgxOCtLeERMbjdseTJ5SHhVaTZNNmdZWkJwOG1lVUozMEpp?=
 =?utf-8?B?aDgraG9ZRUZVMjRLeVltNHRYRnJ2Qk9IWE56ano2UDl5K1k0Z0haYXgvZHdl?=
 =?utf-8?B?MUFoWmJ2V2ZNUWRndFRtQ1RBS1NNc1Y2VElKQzJ1ZzU5UG1HMi9QZ0J0NEJk?=
 =?utf-8?B?VmxUTFBMUFgvOXV4ZkF4Z28xZVVoMmR6a1N6RFlNUGd1VnBGNGtDMnY5L2M4?=
 =?utf-8?B?d3ZJKzRYMVFIU2k1dDlvVzAvSUR0M3JvWElBY0o3TncwQjF4Y1J3WExaQ2ds?=
 =?utf-8?B?RTNSbnVUTklZRHZxUjYyZnhiYkZMcEozMDQzQUltQ3E4MkpROUhQNll4ZTBD?=
 =?utf-8?B?TEVrWkNBNnp4czZVbUpOZkl3QVA2bGlKTEowWDkrQzBvVy9uZ3Z1MStscklI?=
 =?utf-8?B?OW1qR3ZCbVMraUM2WUJLTXRPUkNEdHZQZWlobWd5NWVyYVU2MmJpMmpzRjc1?=
 =?utf-8?B?QnlTWmtPTnQwUXFtQmlnajU3eERqTVdaWHAycGV1MXo5ck9lbTBZSGZmcHMr?=
 =?utf-8?B?MTN4QlF4Y21iL0V5TjRhSVFyWnZKWkNWd3hYWHkwc1h6YTJZWkVyUGU2SHdk?=
 =?utf-8?B?ZWNENFlqRU55bTJyRWFmUVBHTjVQTlZWWGxOWFM3NWdSaW5GMkN0MXgrSUdw?=
 =?utf-8?B?U3NXMmZXdmFuK1RzSUVUbUtsdTgydWo0YVg5MURLMUlaMWpRY01xd2wyQ0ZC?=
 =?utf-8?B?WTArZHc1L3ZPY2VNZE40R3BJVVY0Y1hPdUhFQUprSG8zUU1HY3M0WS82VDZp?=
 =?utf-8?B?SHhzZFg2Q3M5aWVtS0JrMU1odmRlOFRNdklHOTFUczVzemd5V1pIb0ZvMkMv?=
 =?utf-8?B?VUFEcUIvWmRnazVnSGxuQmFJUjNCcFFnRWF3dm00Y0M4RUowUDVZcWFPSVNt?=
 =?utf-8?B?aU9UVGVBUnJWMSsvT0FYdmZoVnNWeEJjS1paY1BMTnYyVFBvZ1lVOFpXTWJY?=
 =?utf-8?B?anQxRzFWNi9GZDFmT3ZralErMGdJVmZLTGdwQTY2V3AvbG43cFh3Rzliazhy?=
 =?utf-8?B?dkU5cE1UOVZzWTJSMnU0TFlvUDQvMUdQSnFZR2pxZWhQMHNuYzZpaXlZSjJM?=
 =?utf-8?B?VWJHQ0l6bDlhM0NBUnBSYVRTMzMvUHJHdFBvS0RteGJ5TW5nekdvQkpxRUJC?=
 =?utf-8?B?WURKYTdVSzhKQzAvS0wvd2ZOcFFDSXVubVhpK0JWNG5HamZ4L0NLNm92WUF4?=
 =?utf-8?B?TGFBWDVuZXFQb3hCZjNhMkF3My9ZblVGMWRMbHVmN3dHTEFKRWhPTmhyc2Z6?=
 =?utf-8?B?c3FQN0dhNnlPM3NTYVR0UUFiV2poTVlONHhBYlhaaGVmVTNobWtVSnhxcHI4?=
 =?utf-8?B?WExCbFJnMTk0clpBdXh3a1VBcE91dW5tM2RQWDdmaFQ0eVdXdVNISVZkSDg0?=
 =?utf-8?B?Q2JZL05XT0xabnkyTHN2dGRLK0NiemNJekRpZU9hS2xpaC8rRlVSQXFOdUpQ?=
 =?utf-8?Q?l/z/CIKZ1/Mw63GkjPhD4feWD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a9dc0-5563-4b84-add3-08dbfa3afdda
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 11:19:08.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCrKGhWfdq7fQ/uz0jBNTIMSXjdrDIzlmpVltAOrxmENzzFey5LIZUhJ7FWw3LtfztZFkc8pi2U9OAyTGJiZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8548
X-OriginatorOrg: intel.com

On 2023/12/7 02:16, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:07:15AM -0800, Yi Liu wrote:
>> +static int
>> +mock_domain_cache_invalidate_user(struct iommu_domain *domain,
>> +				  struct iommu_user_data_array *array,
>> +				  u32 *error_code)
>> +{
>> +	struct mock_iommu_domain_nested *mock_nested =
>> +		container_of(domain, struct mock_iommu_domain_nested, domain);
>> +	struct iommu_hwpt_invalidate_selftest inv;
>> +	int rc = 0;
>> +	int i, j;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_NESTED)
>> +		return -EINVAL;
> 
> The core code already checked this, and it is only present on
> domain_nested_ops so it is checked twice already..

would drop it. thanks.

-- 
Regards,
Yi Liu

