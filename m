Return-Path: <linux-kselftest+bounces-1643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACE80E317
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 04:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243DF282866
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB45BE7D;
	Tue, 12 Dec 2023 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+OKzykH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E768E;
	Mon, 11 Dec 2023 19:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702353412; x=1733889412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YyYiw+x6CmSh+3IRMF7aGK/2pcCSXztQnOzkF5LisFM=;
  b=f+OKzykHWfraue+Pq8OrCD6FGOWAWUmGkNs+SBdIQAFZTsZaK2rM1Zz2
   oWaB2yFvsTXIcjsia7Rc+thPiMwUUQTgnqw+RiECE7XdVOZuytDl1/5JT
   u55gvSIISyXIiKKwSAmwwyXHHTv5fj3uAL0Y0FDFQf+lOeXoK8D8JqRTK
   CEhlcWYG+LtgWwbDgqo/8g6xCU2eoaORMGSlQjaKMAlJ/1isbTFzd5VeP
   TgMPs2XkMRbYT4kb2G7oOwy/w9cUX+32QBRo8LFSCQJ2p5ENuiU3g+d8w
   vrNn0WhLL4agKEqBy+mIOBUMhT4TNiH31wEiKIU8bYLezdRO0KTlRjomo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461225551"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461225551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="723073359"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="723073359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 19:56:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:56:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 19:56:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 19:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUREAGlAOtfa5JT3IxiyjzXqJ7KoTH+mR3bRdp53MHkJGvh0DnANyN5M0yFsF6keaMSOxwukK19N3xzpcQq1iEORjZaqDRKOgWHdbGtLIIbxRtlzXTac4Cqc0sDcz6MGB/u8Ef5Lwn4ySNqZWP2rHzg3Ue+mGCBZFJfMRNa6e3oFJeQ/tmOMgfRbYGWF15P+jIdxkm1wxa9I9Rlt6m+Fiu+gPSKjyLNdss81+9NF2KsA7/eLp+L47hN0bDhjsWJLP+7PhRLv6q7/phnefCZu0ON5sSRbGXYiWKpkSJitgUdXqkLaV+E2I1T96kt2UersJ7mJ8DHqRUc1IBdcUhJ9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYR5VAE/TWoMYR3KFBqrYMyxZYuqUCXiqUCYfLrADuQ=;
 b=ilHiHNGCqS0n9mLu4VYUh5O97zxbM2k9ZKvg/H6nZg/1VPI9jNZm07aBQRYUC8ibger/faUocs49T9xS6+FsAjPS6p90DkaMuvZHzvWu2yU658hSvqB8qDSg9rRonW7f2Z22NJuV7RzeI5t6OO76JsYTd1Zi6jfVoAfbLKeyJv3SGukkvwXheWyqBfjc7hAONr7Sl3m0l3PuENMH0Am1kUY00ZJJ4ufcDyfY9j8HiFGpztDxgFaIDDDCwOQNT/CNzRfUpIvMExFFWXOm9B8WzvGSLbL4jMr+y8EWbasHIEs955184pP6BP1/5oRdpfptA1UQ/zTuhe7F5V+hhvSJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 03:56:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 03:56:49 +0000
Message-ID: <3c5840c1-7526-4275-becd-ad5af9fc78a5@intel.com>
Date: Tue, 12 Dec 2023 11:59:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
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
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-4-yi.l.liu@intel.com>
 <20231206185657.GC2692119@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231206185657.GC2692119@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bea3ed-fede-4c57-ce73-08dbfac65dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfW/s25WEOb5ICSHPV5toQEK9C7DqYha0rUpt2BauMtlSPSS8m9VOFNZtzTgxsw2FuB3SKN5mf9E9jK/Kr2SoJ+XC02VXl4unilImx3qcVg/0sJS+lSBQ6C25XfitRwSuJ/L3M4W92g7SYplQHACJMznOiRbyXty9nDCWGh2V96SkjEDXDEYp9nkg+FN+lLwEScQltmaCyog5gPryNtfOd/U3Q5RFQJ9Rz5mD/juEwfJfwCyJKmAFvM2tMvmeHu04FpM7Txn5xdgGkTf0vHcP0kIjIyLp+Eyt5kKnbcD7OlKgmUzDu07y8PZ6eMTO5LIHktuYpShqjz6WcRQMukrs9hZTDhaNJz+LK+WmleGkgI07t64DEFbaTt9nYP5RzhnjAuWYubv8t3FArCR91XOKQsa/oNdV7qvJgCD6Ya5rPPulqJ4P2xOqeSYF7qEy/ZE7+3mDwh2i0E3m+1QgiWFP6iJ9YYrnzpdcjaXI1hXvDxd09EhsuP6E6Sqdh1UE/wJwGVgQQiGgDIH3cjZu7bLCctRSFpFrwdRd9Bq19e8bu/cEj6nEediFzlTj+sB9rkLpG1ZQF0nxzF9Q95kcNA5ZAUCmk/So1PJTKl3bKGrp9eV7oIwsKnHpVQE2+DyUCsYCY+YPski54ILWAPdSb8zYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(53546011)(26005)(2616005)(6486002)(6666004)(6506007)(478600001)(41300700001)(83380400001)(7416002)(2906002)(5660300002)(66946007)(6916009)(66476007)(66556008)(4326008)(8936002)(8676002)(316002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNnM0xGUTRieVYyR3dZSVlXSnZ2cmp5WnI3akpDQmZWQXRsSlNBOWtEQjZ5?=
 =?utf-8?B?eUdWVGlRY0xXbXNiYXlhYTJ6a3VlY1VJcXNyeFE0Sy9GOStha2krZ04zYTdh?=
 =?utf-8?B?UHV5T0RQOG9jZWEzQzBZbDhMNG5wVXNGNW5uTzBhNi96ZVRBZlNuQmRpZi9a?=
 =?utf-8?B?MHlZdmRQSHZDa2NVMW11VHo1YzdCaG55bjhzNFFQaUdjUzJYWEtybmYyYkJD?=
 =?utf-8?B?cXI1WlNicXk0L3RuU1gvaVNBS2FycHVkNDdQRU9CaTEwc2NOYkhmZ29pRWt6?=
 =?utf-8?B?bUM4Z3ZURlZYWWxLQ1gvQVpDbGtsVWNsWDdIN2JJcjR5bTRpaDlRMTM3R1Ji?=
 =?utf-8?B?Rk5zS2JwQXcyNi9JVWR5d0NoeWlSRXFTUnh2QTVtOEl6d0hyYkx3ejJ4ajRN?=
 =?utf-8?B?SEl2NkQ1ZHdoelJvRmRBTlZWY3VPdEhlV21LbHR2aGJMeGtNeEZBOTRrZUYy?=
 =?utf-8?B?Q3puY3JvN1dMZWs3VS9sUTBEYWdJMFgrbFNGYlIwVTNDc2ZPbkRPSDZEQ0xK?=
 =?utf-8?B?bm1yQ3laUEkvSVJnYXhmTzZkZDE1VzVqMGVZRlFVRDdVaWlPV3U0Mk1maFI0?=
 =?utf-8?B?N0ZXbFE0bzNSdFlrd1lFUEJ2b2crTWZjRWNvd1dCLzJIM1cxSmNuZnU5QUVt?=
 =?utf-8?B?RTQxOVUrSDd4aldvbE5vOGdQY1Q2RUtmcXBxK3V4Um9CcUE2NEcwTVRjaHZT?=
 =?utf-8?B?Q3FBRDFDUCt2dHYwaFFZcGtjQUZ1UHdFcTVYUmIwZkUrMnl2M3EvckpqcW1U?=
 =?utf-8?B?RGRYQVBvWjUwQU5QT01ucy9jcGtTSFhKdU1VczloVnVmcjFyYXlWVk9GUEZU?=
 =?utf-8?B?Nlo2cjl3c2dZRlBPdk1zd1ZLaUNBdmVFSTIzdm5OMDFUbkhQZHROTVRLQzRw?=
 =?utf-8?B?RmpnbkhzN3B1YzdlSmRkeHo3OVdmSE9uS2s3aEMza2hKcnhQRnRiQW1rR21V?=
 =?utf-8?B?QUxSSWw5SG9mY3hTMUlsK0YvcjNKZ1J4LzRkaFE0bDlBVWNiUS9HdkIwUEhC?=
 =?utf-8?B?eVg3RHpiQVprcGR0WnRadk5xZ3pKNFhuZWZLQUprT29QWXN5aElVM1BzMnQ4?=
 =?utf-8?B?MFZVMHFNTkN1M0wybm1uMVluMlBLSEtxRXY0cTRnbHV6VzVvMitKV3JXL25O?=
 =?utf-8?B?RXVQSSt0KytFZmhGbUNRTlAzWkM2VlMzeGNHbjY3Y2d5UGs2K2ZkT01ndm5D?=
 =?utf-8?B?T2IvL1dhOVREamNRSTdqYXJNN2V5VU5iMFMyRVlqRUFyUHdpTFlBbFZzOEtr?=
 =?utf-8?B?NVQrMnVKU1BMdWJhL0dNZkNTa3lsbmQvM2U0c1UzREUrTFUwc1U2QVhGV094?=
 =?utf-8?B?cFd4V3Fwd3F6YnlUL0NOZHBlN3hVOGFXalluZGRNaWU0ZTRjMzd0WEZmSGVB?=
 =?utf-8?B?NXd6RVFMOWpoSTByQ1ZhdWZLc2QrTUYzblFUZ1BmMnYycjVyOEFmSmhhc1o1?=
 =?utf-8?B?TUcrcENPNmJOZ2lYT1NBaVN3N3MyU3p3ajJoWFNmZURRT0lnNUJMVWdkT3Nq?=
 =?utf-8?B?YVJSVHIzRFFDbjNyN1dTa1ZydDRYRXU1SnF1KytCTUtpMjFSaDJEU3V5dmEz?=
 =?utf-8?B?SUNGQXhhNjkveHh4TnJOYmw3MHhCZ0d0NjV5YlAwNVdnWTduOE5zSHh3QS9B?=
 =?utf-8?B?a1VIdXFyeGIwM3A4OWxSRUxyVTd2OG1mRVlBRG51WVVrVkRRL0V0Ym1Ba1kv?=
 =?utf-8?B?aHNlYTgvRkoyLzhlN1ZSWG5tc2kzNUNsQzlVWktFM3Y1eXFxWURUd2RvSVlC?=
 =?utf-8?B?RlNCYlFqVVZsSm0valFPYWlyclhTVFZzM3EvalJhd3J2NEMrcUhwMTNCb05C?=
 =?utf-8?B?eTlZMzVENUdKbytnZ0xHaHVYNXNub3hwNUJkNGlTam5jek54WStZSk5sQjFk?=
 =?utf-8?B?R016ZzlhZjRuUE01QjJqNCtDUmJUSzhQamRjeW9Zai83QWkwbTBwTEVZaTNq?=
 =?utf-8?B?Y1RrdWhuVWRsN2V2NDhDUmlLWTYrWU1yd1p2OUp0MFVXc1Y0YktFY0pqUzhR?=
 =?utf-8?B?ZzJoNnpIRXU3R1NNWlJXc1lGeHZzYjcvUzdad2w3bFkxQnlNTTNLaW1YTzdz?=
 =?utf-8?B?VU1PM3Jnd0FuZzlyRndTeERjMmU3OFJrNVRocFRWdE5wWE5GSU5uVW5kQ0ly?=
 =?utf-8?Q?Ggwn+jHLXcnW2AQbZ06wUNxG4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bea3ed-fede-4c57-ce73-08dbfac65dda
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:56:49.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb85pqasjCLlwtvvpJe0ryMgDgaJAxZmxQvkp8G9Lu6uW7y0sPDQDgiYx4MPd8ewSprqMv0YcQlg3Bd6pMV6+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com

On 2023/12/7 02:56, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:18:16AM -0800, Yi Liu wrote:
>> +static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
>> +					      struct iommu_user_data_array *array,
>> +					      u32 *cerror_idx)
>> +{
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct iommu_hwpt_vtd_s1_invalidate inv_info;
>> +	u32 index;
>> +	int ret;
>> +
>> +	/* REVISIT:
>> +	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware,
>> +	 * but no error code yet, so just set the error code to be 0.
>> +	 */
>> +	*cerror_idx = 0;
>> +
>> +	for (index = 0; index < array->entry_num; index++) {
>> +		ret = iommu_copy_struct_from_user_array(&inv_info, array,
>> +							IOMMU_HWPT_DATA_VTD_S1,
>> +							index, __reserved);
>> +		if (ret) {
>> +			pr_err_ratelimited("Failed to fetch invalidation request\n");
>> +			break;
> 
> No error prints on ioctls!

ok, will remove it.

> 
>> +		if (inv_info.addr == 0 && inv_info.npages == -1)
>> +			intel_flush_iotlb_all(domain);
> 
> -1 is clearer written as U64_MAX - same remark for the comment
> documenting it.

sure.

-- 
Regards,
Yi Liu

