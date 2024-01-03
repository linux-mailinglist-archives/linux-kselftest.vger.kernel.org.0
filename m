Return-Path: <linux-kselftest+bounces-2599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F006E82268E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 02:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E54B283D86
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B73ED5;
	Wed,  3 Jan 2024 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/mhnsTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95910F1;
	Wed,  3 Jan 2024 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704245479; x=1735781479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HiklqFWdgwiaML2oC9DFqY2NcYVIPOMToQqZcvxMcxM=;
  b=X/mhnsTx53DEGjTZxwpEpLNhGLppNr6ahoujhocDJo2P1zCf7Sk6sfOO
   8Dv814xROU/WKV3BeTPuUjo1FJOz/n+Hr6FbCqyVhy8qQ2022nEDqCyRf
   b+KJyAIC2YQdXPv8z/ZoCjAXMWAsEUyhVckTDGyp7AYqyyPgpTco+GIkK
   vKiLl4cDuLtyA+B/4li9iEUaaDFtth6MPUhg1w1SzQhm0zHxlBJlaT2In
   Y/aUC2p1Fu8Zf4PLJzxrccWhC7F2g2SZ98HizO34LuoZiW9UKl9cYmKcK
   Q2WZFxrjzn3BMbsYgs/hW1AbNXrGBQUhc1OSfgPYkAG2qqTMWoBjzrC61
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3782174"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3782174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 17:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="903272021"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="903272021"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 17:31:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 17:31:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 17:31:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 17:31:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 17:31:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLQyno0F2GlN9w4y+OnN50ht0wNcEmXxWowT5paeznatqIDkm8VtXe5AxL8HZbw/yhHqbJ2+Ov+rrBEoidkoZF7XM+guWpcgzuHMkUti3P3GIj0zZ3yVelYUKKPQbn6JBIrGUqju0YZdgTwarovOhJMCinoczEVsqdb/wUOAVzXkbzDPde6Rdf6AwrC8Df2aLOg2WIEZe4x1BCiXOadlMMvOcwIdgoCF4SMw7D5pol1zLW1cNLODTMlJy6SttxMSCEJrBoPYiXIPCNJcRT0xFo3g7o3SEd1V76umsoJVM/X9uuuqkZOHGNp1l51MM45sKEu+/6oZCHN7Sjkx5AwqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQJMxK/k3LbywtlW1nMmbSqNsjlmD6+yGDF1WV0npzo=;
 b=OwPVGth87Bkgq2d1YECx2suN3O02rh+WSTg45lgVwtge6hcSesgUpJPaisWFsvFuxdJljGW2VaabCQkJ2aaG+wWhKFbedPZinyL+JpXJHq5I9LORqmZrkVZARjDE3mUcETETsu+ApAhdRq6RHtcI9IdPCiHVskCWtV4hwI1tyd5dtemjDTeL5tcAnV5Tvaxs3ZN2/zVDqP1UePfLtFyCA5N13EBt2RNCfelTDPUNLbydKDwh2BYt3CPx46SllM8iX4gLNQ8BdeB57tbQ4V2ysmzkMMM0LozN0I1ICwD/mfmF2S4wYfH0odQY1iGrehG2D+PqcfcJCzdY4pVY1aLV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 01:30:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7113.028; Wed, 3 Jan 2024
 01:30:59 +0000
Message-ID: <ae271e08-f390-4ce7-914c-63668a46bc4b@intel.com>
Date: Wed, 3 Jan 2024 09:33:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/10] iommu/vt-d: Add iotlb flush for nested domain
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
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>, <j.granados@samsung.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
 <20240102143834.146165-11-yi.l.liu@intel.com>
 <20240102184422.GI50406@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240102184422.GI50406@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: f03dd52c-3209-4c21-2cfe-08dc0bfba348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QH0qyVVHPZmZwjJJimbO9LEjVx1ASCWBWk0anvO7HI3v0x+UtZSY2/MthN0meTz/G5TLZ+fCzaNPvzf+tcxMr/3N6Y63CvfO3RnGP2QzQ7zeVzGJDOCRztM9zNej1V9Wl9fYZq84f4JwReeG62/8GrnVuZP2eKJedQ57Xe4Zu/xvYLNxLxAGjBrhW508k3ktLZaQ7Ih51D8kmSq9UBUbOmhcaWgOIv68iACvr1mbRVqfjFBrQd1iVmHOxnj0g/2fIl2w0IyH49nK4aqmS+AS7YHycy5nMIYKYV5Woesa5kDBaZ68P7dioxIw0jacRD9Ppdcn90drR2U0sf8SH9HLzSJ9Clav4Msu6HAmFWyQJzF2JdbUCtAM+ueiupgj8oakAz7rUT+IHrLDoqXMepFiwfudexULFGmdshgjPw3cnGnA1WLr0dtCJUsKXnnfhKurJcE/tNN8uEXJShW2afNs/f9mZH3dj3F38viQ39jzGerDzUf7aAk/fyl/6efQiIEsK7Y/q8fsPikteXOTThzJ3KWANtlCYzWQ9DkqQiWREXWw5WNNJxVGYNWsm+3V7zFgL7JaJk+7b6oSZ6Wvcy51gWuwaTa8t42D869WZCx7UJcSfDDek2In4N67Yjxqq8g4wXKRIDgAXEIeU5FYpPh6suF+ZBjvM8qxDBKywmbB/gE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(7416002)(2906002)(31696002)(41300700001)(6666004)(478600001)(6486002)(86362001)(82960400001)(6506007)(83380400001)(2616005)(26005)(36756003)(8936002)(53546011)(6512007)(316002)(4326008)(966005)(8676002)(38100700002)(66476007)(6916009)(66946007)(66556008)(31686004)(2304002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdodVNsQWlYNGIyN3BoOGMvUlBZQ2NKdFdpT29JSmhGTjFkZ0ZabGtxSTlM?=
 =?utf-8?B?Z29TZVJSYzhuakhsT3RSRzVnRlpxcXBROUJpQUxwZTdmNkgvcFBubHI3KzBi?=
 =?utf-8?B?d3RGYnF5K1djclBIUmUxQ2FmWHFzMldXYUxZMHNtM25IMmV5QzJrOFV0ZDI1?=
 =?utf-8?B?eTM0OENGdzZvTjVRbFNGLzA2Q0FEUFd2VUxlbVN2V0NqN0liSjBmTm5KdGFl?=
 =?utf-8?B?QytQaHNMaTFYUFdOdmd0SXhkTGVIbWJaN0VNSzREVXJBaG9wTHN4OVFMSUpv?=
 =?utf-8?B?VnFEL09vVi9wcURNWDc0VzVobDhQM1d1M1RRVk5ZdjhKRnJicHJCcDlJSm1x?=
 =?utf-8?B?WUdtNzVJa0E2RjIrNlQwbGJkWkduc3FibFVPbk1mR2RXdjRsRkdPZ3J4UzVO?=
 =?utf-8?B?ZEN1NVp4M1FxbHQvdEJSci9TNFFRTktsVGF4WVYxUC9qeEJmeittL3RGc3J1?=
 =?utf-8?B?MDE5OGxESktyV3gzWGpleFVmcXZhbEJsR0ljNDJOQmwvZzhCSzZqdTAwUnph?=
 =?utf-8?B?bjBWRGFOeldVQzVrQjRPQkVsNkxVemFuS3B2SEd1ZlgwNTRuTFBsK1ZCcHlM?=
 =?utf-8?B?ODdPczlTUnU3dlRNKzJDb1IwOXZXVFFvVEJIQU1pSjdJTkhJTjVGOWJxckNG?=
 =?utf-8?B?QnBkdGoxL3llWndOVWFtNEJGR2NhZUtWUWtreUdQTk9SRFJUTmZ4VittYzlT?=
 =?utf-8?B?SURuNStyM1dPSmtTWGxmN1lpdnFyQStEQk1LVit5eDZMdHhqbXNJUEZ6Zi9E?=
 =?utf-8?B?ZDRUNHp4YVI3STBJZGxoNnIrLzRQZWdoTG5LMEFwKy9ONml0SUhtYjhQa3Z0?=
 =?utf-8?B?cXNkdnhTTnV2d1RXUXE3cUJKVlNhTEdsZTFwT2EzOCtIRnMwbldDVEpiRUtL?=
 =?utf-8?B?bEEwWW9LZzlsNWJOUDlLMzlQSWJVeFVvZjZVcHFCRldGV21ZVnpGOVpJcThT?=
 =?utf-8?B?dEFVZkFhMGI3VmRRbmpmMmtWWHgzak93S2MweXF5QXk4MnNCM2VrT25OWHY1?=
 =?utf-8?B?ZndRcTYxNGhyUkxudGx1aWdHWkhyQWswb1VJRjBtTXRXZG5rT1d3b2w2Zi9Q?=
 =?utf-8?B?eDJYTkQzek81T0l4WWNnU09MbHYvMHYvNDVSUnVIQllsT1k5MWhWZDlwSFFQ?=
 =?utf-8?B?ZmxMUEdzMnhaaHpXby9yQ3VLck04bGRiYTB6QVRMaEtOcHcxcUdyQlJMT21D?=
 =?utf-8?B?MkMyVXlTUVk0U2NUVFQvN0JOcnBRaGwzMklRN1JqUEgwWHVDakxXSzhkTU5E?=
 =?utf-8?B?ZGtuckRBZndRS1lORzBkcDN4WlVIUm1LUU5sRkkwQmVtbWVFWjVxS3J4bmRB?=
 =?utf-8?B?d2tnR0dDNkgwLzdFUjJsS3FoeU04VmQ2MTU5UFFFOGR5YjlmaFhQN0J2TVBP?=
 =?utf-8?B?QXdzT0dDWmNHQnBWU0tVc1JrbFFtN2R0bGpDL1dEd3VvYWJsVUZHV09ETytL?=
 =?utf-8?B?a29wcGMrVU5KYWgvbXVzRVYwSmhNTXNTcDlKclhRdGxQQkgzZ3RPeXVYV3RI?=
 =?utf-8?B?VmlJQm5oUGJLek5MRE1FRU43VHNEOHI1UGJhR2VQcXpqQkZqbHg0N215cjNK?=
 =?utf-8?B?OWhjQ0lyRFZhelNQR1Qva21VNy9DcHpadlF1elp2Y2t1N0hsK25vdWhXT0Er?=
 =?utf-8?B?YUdLVnd1Z2w4S1N0bFpTTHNteDZUT3JtaUNpZVp5OE8xOUtMQVFRV2l5ajN6?=
 =?utf-8?B?RU9vQnUvRHppcXluU2lHbzVhUWNDTGpTNSs0aXBXZGM5ekVnTHhJN1dzYzdK?=
 =?utf-8?B?SW5WcUI4ay80SFlvaXF1WkxoUGJqNU5vVy8yVk5sVkw0M1NEM2lQenRqVEE4?=
 =?utf-8?B?QllwbEx2emdjRjBLZGRzVkE4M3k0V2Z6bUIrUytkb3E1b3IwcnB6aFZqeVdS?=
 =?utf-8?B?czhDTTBCeUhIRTVTbndJemNJR3kzNkp3RVNoVU0rUkYySWdiZll6VW4yL21w?=
 =?utf-8?B?WFFhOFFjb0h6ajIyV201aEJUTlA5QjJNbmlVTzNZUFdqdytCZ2JKOC9BRHJ3?=
 =?utf-8?B?Z0JEMVFPa2dYa1hPejhGT2hwclpSeXFaeWxiWXgvR1F2UDlIem1UcHc2MDNy?=
 =?utf-8?B?ajQ2cGhLZDIyYVhPNGNlcXV0UGlRKytxYXJmeFFzbWtRT2RCbW1LZUNXWDBT?=
 =?utf-8?Q?PTiRhM7DcVLgxDJa9MirJaVH0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f03dd52c-3209-4c21-2cfe-08dc0bfba348
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 01:30:59.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed5BReSn3cH/UB+W9UOkWIHMxcatDpG878m0CfMkfTB/q4x9dJI6qxJNjqgyOGgU0MBRbbs22s3C3/tIVKqYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com

On 2024/1/3 02:44, Jason Gunthorpe wrote:
> On Tue, Jan 02, 2024 at 06:38:34AM -0800, Yi Liu wrote:
> 
>> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
>> +				     unsigned long npages, bool ih, u32 *error)
>> +{
>> +	struct iommu_domain_info *info;
>> +	unsigned long i;
>> +	unsigned mask;
>> +	u32 fault;
>> +
>> +	xa_for_each(&domain->iommu_array, i, info)
>> +		qi_flush_piotlb(info->iommu,
>> +				domain_id_iommu(domain, info->iommu),
>> +				IOMMU_NO_PASID, addr, npages, ih, NULL);
> 
> This locking on the xarray is messed up throughout the driver. There
> could be a concurrent detach at this point which will free info and
> UAF this.

hmmm, xa_for_each() takes and releases rcu lock, and according to the
domain_detach_iommu(), info is freed after xa_erase(). For an existing
info stored in xarray, xa_erase() should return after rcu lock is released.
is it? Any idea? @Baolu

void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
{
	struct iommu_domain_info *info;

	spin_lock(&iommu->lock);
	info = xa_load(&domain->iommu_array, iommu->seq_id);
	if (--info->refcnt == 0) {
		clear_bit(info->did, iommu->domain_ids);
		xa_erase(&domain->iommu_array, iommu->seq_id);
		domain->nid = NUMA_NO_NODE;
		domain_update_iommu_cap(domain);
		kfree(info);
	}
	spin_unlock(&iommu->lock);
}

> This seems to be systemic issue, so I'm going to ignore it here, but
> please make a series to fix it completely.

yeah, this writing is the same with other places that reference the 
iommu_array. If there is real problem, may check with Baolu and Kevin.

> xarray is probably a bad data structure to manage attachment, a linked
> list is going to use less memory in most cases and you need a mutex
> lock anyhow.

below is the commit that introduces iommu_array.

commit ba949f4cd4c39c587e9b722ac7eb7f7e8a42dace
Author: Lu Baolu <baolu.lu@linux.intel.com>
Date:   Tue Jul 12 08:09:05 2022 +0800

     iommu/vt-d: Refactor iommu information of each domain

     When a DMA domain is attached to a device, it needs to allocate a domain
     ID from its IOMMU. Currently, the domain ID information is stored in two
     static arrays embedded in the domain structure. This can lead to memory
     waste when the driver is running on a small platform.

     This optimizes these static arrays by replacing them with an xarray and
     consuming memory on demand.

     Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
     Reviewed-by: Kevin Tian <kevin.tian@intel.com>
     Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
     Link: 
https://lore.kernel.org/r/20220702015610.2849494-4-baolu.lu@linux.intel.com
     Signed-off-by: Joerg Roedel <jroedel@suse.de>


-- 
Regards,
Yi Liu

