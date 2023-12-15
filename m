Return-Path: <linux-kselftest+bounces-1976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC5813EC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 01:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733F91F22C48
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E936A;
	Fri, 15 Dec 2023 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuTReeXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BBA3C;
	Fri, 15 Dec 2023 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702600691; x=1734136691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1WFzdMInm/n6g6/BbTrqmXbiN1PpBfIQBRnrIiEOGjk=;
  b=ZuTReeXkiQja5fqkymuc3gj/GH4vAvX/NBDeZf7NkW/hRc32AYF+mhB8
   J+OA9/JOgxKeSgJq3MNH5qzNBBfJ1C2JKAtXwS67Kvl2RXyyq2YsQEw9t
   FW14L2aednyI26x364KWRE1bLLZngM18qd11ZI0Zoib9zSZUqW3z029Ek
   7OuSn4bj3dcdDWTJzUBkcK3+DaybQvrruOVtfrcqzA1BP51+HYYdljn0G
   eGZVH8qGVuQ1ZscM+tJmAOBvCCLepEN8KqItQKXigpJhqsplVhVbQI4ii
   hVce0bSpNMgcz9GE85TgrXXumloY5x0b3V7lZZlIVbknknco6uhupb4At
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="481399646"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="481399646"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767786279"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="767786279"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 16:37:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 16:37:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 16:37:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 16:37:46 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 16:37:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8xR8RFwBPi90Y0Y/ZpW4Iesd2Izt7iswUVzwvsQ2oBdNVUarULQOcWYWjgTYxutw5cJ1jX0sCLbS4pTTtfoHo7/1HRoelffobGGtGodqul3z2eRRmcg6EMfv2Zcc3UW/QDNJvSZHWqxFtIMdcqMjEfK7PKsgTYYTilTJwx4EWMw6UnqFaWsuWkSiAQM5pgM+g9fZWUG+V5Mfyve9Fdw/zTXFHaL5C/36Ixv68NG5QmBt0wMneUhtML08Ppw5RENYRluAAGUSEqNZMLqrAg20isybS3Xjt4vByQO4bTM6xXStPvgEoNcVDwZIfvEDezIrvn+G/WYTYw8en6r/FHu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WFzdMInm/n6g6/BbTrqmXbiN1PpBfIQBRnrIiEOGjk=;
 b=N7e++PDsgJVu8J6k+uwtyOLIx/+YqaFWSPF4wx/C690+DAjvWyNEuUHv20ZUtawZReJtKTemKeSm148TEbAwsI/uRMyZsjoH1EpLkwmI3PjQNLSunvl9SDMNB9olDrziAO/CBVy7kCOLxcDSjtKuM96XowpBiptHGpA1G3sdMP+oqCv0PixOoHzfLhtSlWUPrJeTaPaUANL1iOfLCFOT5NNH1PqU7bFznRde49NNVU+YSP7ajHoZx+GaBHnT56+UymE94ZNfMEPgTntWVI9UpZoPNGRWgxeyTjLtifaVdeJ0QO5GBYuD3FIRJmLPJMEUjIoK+54qI280BY9WLf2o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:37:44 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8%2]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 00:37:44 +0000
Message-ID: <97e7a963-1142-4e25-b439-48e5b551f148@intel.com>
Date: Fri, 15 Dec 2023 08:37:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To: Baolu Lu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>
CC: <robin.murphy@arm.com>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-9-yi.l.liu@intel.com>
 <a19031b0-7c30-45e6-b171-c53e3578b867@intel.com>
 <4e08dc77-82ce-40ce-8a0c-ac9016186c23@linux.intel.com>
Content-Language: en-US
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <4e08dc77-82ce-40ce-8a0c-ac9016186c23@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|PH8PR11MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: dacea726-cf41-4c9d-dcfd-08dbfd060d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: farPZn4KuBvoOyGi/qvZa5IIV4facMHHsDlgqTUPPeXqnRsE8flRtODLiAuwccO4sUv6w4JIeFQej6+t6QW8awHDqL13/iruVld1wqHpWDvC7FinOyqTXmVxKlScLcxTCEPQ4oR7BO0WsvYSuTrZbmhiHzOKM0TRIj3DgSwdfI/m4Bhvafn9V0YVv3cShok1nWDIkTve86O92Lonj6vlG/yRTVaGkxF4CP1wJtbKdoQrxYb10ut43EcbMvp0kTVKz8lmQRtHCa2VJk6EpnLyxoJubHp6Pwd2xvDigVh6HZPegAnLYioYK6v9no0a6ju+pPad6z82wwuhtf50S4Yof/oeq3LMf0IzQGBTDtwIyKpk27sQNs4Q+e74aIBo3flO6cdKWa8chUDbcKrb5WI/F+j0NJzY8CAbYWKVHrB1Jg6K8h7a+/BC/Uq3zDRphccOb6BpJ8/RBzhckrzsLTjU8FiGUAjeGkw/Jtt21mqoUEQe8IJzzSzCTlkvPTKRzUJfLAGqtKHD+6NSALWrm7HeCmOfzdmlkLV3G04v62fDMeshE0kmg3RRtcsQK7qSY5eorQCAHtfd9t6LWNdYru0pWFVQkgf+VQAtVcsNwjGWhhtvH+Xq1KJwHRqHZJa4xSx9lfKVq+WimJYcMeVqxnZH+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(26005)(83380400001)(2616005)(86362001)(36756003)(31696002)(31686004)(82960400001)(53546011)(6486002)(6666004)(478600001)(6512007)(6506007)(66476007)(6636002)(316002)(66556008)(8676002)(110136005)(66946007)(4326008)(8936002)(2906002)(7416002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFUZXpaaVpjS05DdXpCUXMxcit1OEJjMnNKT3Erd1QxVHBUdDArakJadWhy?=
 =?utf-8?B?RXFvNHZlNWJzQmlPKzBRMWs0a3AxMm5MN1VLSy9PV1c1VDJKaCt3TWp5TFg2?=
 =?utf-8?B?TzdkWDR2UnJ3OGp3VHE3dUlOZUVJbXo3N2RjREU0L2ZPMWhwSkpKQ2NsVDVQ?=
 =?utf-8?B?NG55Qzg4dnBoZ3NHYk13akhkT2c4ZlNpK2NTcnRWenlka2ZTZmVtZzl4M1E4?=
 =?utf-8?B?MkFIT1Z4OGdXOFIvNEsyYmNURjlEVTJwQVFQY25OMEdFZVFOcUZJM0YxWm0x?=
 =?utf-8?B?WWZEK3hqVGRnWDNRZW43eGxFT2EwclFDRnNEZmV5aGtHY2FCUnFYeWMxalFm?=
 =?utf-8?B?cDFEczM5TVA4cUEvUjBZVHhvcktaaEw4cFlCNXpzdlVWRWFaVitZdytzT1dO?=
 =?utf-8?B?RjVCb1Q3VGNFcTAybVpaRnZLSjdKOVk3czJTWWtGSm03YTE1K2tDTEtsZU92?=
 =?utf-8?B?WEVZOVVQVGtMMEpYRERlb0Z5TmV1VVY5VmRRcUVVWWJFdHBrVjh0TGtQUnVl?=
 =?utf-8?B?VU0xb0ViczY3cGJYUGZYdW5Pb0NOTitiQm9yK0hNS0ZnZlFvYUFZR0RyRXIz?=
 =?utf-8?B?WGsvcmZSMUhzc2dVcXBJcStMSzZ6eWhnNlpSdUx0YTNSeFRyVEYvK091eml6?=
 =?utf-8?B?UjVnZ0M0a0ZTN2xPTjhMWFhKeVBCTzRaTGJSU3RvYTB5eVNTbzhXUEF5QkJW?=
 =?utf-8?B?MW96NGNVTGY1dFZhQTlCVnNILzh1NW5HWjBDTHpmUHhxbEdkM3pZVk5qN2M3?=
 =?utf-8?B?eTNQYk9rMml0ZGs1ejFtNFJaSUUvWitMdEhUdmJpa1I4U3RVbXF6a29RTGNM?=
 =?utf-8?B?ZnVta0hDWjYrc1FueHdWS3FnWlVLR3F5eEpIdEtmSmwzZVZ1LzBtSTBKSHcy?=
 =?utf-8?B?bHpXQmEwRXVxTFExcEF2d1BNYjJVcEJqTDloY1ZiWHovSGs1V0NQYnQ1QWMv?=
 =?utf-8?B?ajNyN2VKYUVXQ21nbG9KcHhJZGlBZDlHTkwyNjYrUlVLbTZDeW1PNFdFTjd3?=
 =?utf-8?B?dzVXb3VxMGM2aEpFaHZTVHN2YnlXa3Zya1ZqOXRmY1VFc3k1MnFua0wzSE1W?=
 =?utf-8?B?Zldnc1JicTRac05OZk15bmFnQ1F3UXVGYW80VWZMeXp4aXRQekljcmhNWDkx?=
 =?utf-8?B?djVGQkFxQ0crT1hGRWZrSDU5Y1ZnV2lGd013MVBQQTFqaGtOOWNaeWpYOE5k?=
 =?utf-8?B?RUpvN3AyUzhtR2k4RnJJK0Q0c0hlNlJRVGlPMTIrbmhXRGJlTHhSYmQ3N2tp?=
 =?utf-8?B?RHByMmZ5UDgweExrdnZhbXIvbVZMUU1lUnRWQ1lwUUJlU2JGUTBqR2hYREd3?=
 =?utf-8?B?N2lnbThEM3M2T2RQL1REeTRaVE8wRWZvNkI0ZDRNUk54REcwVWl4Q1FkQTBw?=
 =?utf-8?B?L0tXSFB4clFGc3dvUXdqZFFOLzBTRXB6R0pRbFJMUVB5bFJnNTE5Sy8xa0Nx?=
 =?utf-8?B?ZWxmbGFYd0oxMW9BSlZSM2ZWWlAwWkRPK2ZBcUhDeWcwdTBKYWtaL3BzNXMx?=
 =?utf-8?B?Z3ZXdklsT0ZHanN0Nm5ZT0lqZ20walZQQW9CdjhFc3hWNzBvVTZhL0d2bnNR?=
 =?utf-8?B?NUtTNE1JSS93UkRFU2dFWldmbnlKYjdDM1dBUVJTSkVkR3JBdGFKdzVtL1FN?=
 =?utf-8?B?NmtHZFJyd29JeHAxQ2FHMFFCYkdVQ0VMajhyMXJqK2pjdUw3RXg5b2FQUHk3?=
 =?utf-8?B?cTMvQWloSUpBQ3R2bGFKak93QTlaNEtnMVNRSFBrSktnekdGTkdWV3AxTnJ6?=
 =?utf-8?B?bTk3UkRKMmh6UGFvTUlHR1F3dlA0SXBzcU5GNjFjUEZHNUg2VFNrb3J1Um94?=
 =?utf-8?B?MnBlSWdCY3JvTUdKUWJ1Qm5NbmZvRHRXSThDRTY5MGVXR1E5TmJqZU5nbDBS?=
 =?utf-8?B?clBwakxPeEM0ZUNUdWpkN2o4MkllMzRGV0lsNkNjcVpZaUZUS0l1bGVmWkF5?=
 =?utf-8?B?czV1Wk5pSDNvYklQSEVlWGl1dTg1THNMZ2ZmOStld0lDekF2SWx4aU5XVUpt?=
 =?utf-8?B?aEk5cmo1NnRVZVMrK1JzYUpGTGVvOHFpOWpCVzNORjdrSmlmY1J6bmhnUnUw?=
 =?utf-8?B?UGR5TDQxZFkrMitLUWcybnZ6REhjdUJkU01wclhSR09GV3dEbTA5WUlWMjhI?=
 =?utf-8?B?M3FnWHNpOXJtTTF5N3ZjVlE3dTJKSk1jdVpUOGQvMWNCVE1FSnFXb3lTeHc3?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dacea726-cf41-4c9d-dcfd-08dbfd060d2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:37:43.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI4rS11T7Wp0tUBpVRJn6EFLyV8hdch0mvR8Ff4h1DCxHY3BNb4NpoIUfnQRiO9bOM6//56CrE8tmyFUpz5GvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com

On 12/14/2023 9:33 PM, Baolu Lu wrote:
> On 2023/12/14 10:55, Yang, Weijiang wrote:
>> On 11/27/2023 2:34 PM, Yi Liu wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> This allows the upper layers to set a nested type domain to a PASID of a
>>> device if the PASID feature is supported by the IOMMU hardware.
>>>
>>> The set_dev_pasid callback for non-nest domain has already be there, so
>>> this only needs to add it for nested domains.
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>   drivers/iommu/intel/nested.c | 47 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>>> index 44ad48db7ea0..f6f687750104 100644
>>> --- a/drivers/iommu/intel/nested.c
>>> +++ b/drivers/iommu/intel/nested.c
>>> @@ -68,6 +68,52 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>>>       return 0;
>>>   }
>>> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>>> +                      struct device *dev, ioasid_t pasid)
>>> +{
>>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +    struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +    struct intel_iommu *iommu = info->iommu;
>>> +    struct dev_pasid_info *dev_pasid;
>>> +    unsigned long flags;
>>> +    int ret = 0;
>>> +
>>> +    if (!pasid_supported(iommu))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (iommu->agaw < dmar_domain->s2_domain->agaw)
>>> +        return -EINVAL;
>>> +
>>> +    ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>>> +    if (!dev_pasid)
>>> +        return -ENOMEM;
>>> +
>>> +    ret = domain_attach_iommu(dmar_domain, iommu);
>>> +    if (ret)
>>> +        goto err_free;
>>> +
>>> +    ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
>>> +    if (ret)
>>> +        goto err_detach_iommu;
>>> +
>>> +    dev_pasid->dev = dev;
>>> +    dev_pasid->pasid = pasid;
>>> +    spin_lock_irqsave(&dmar_domain->lock, flags);
>>> +    list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>>> +    spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>
>> ---> list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>>
>> dev_pasid is linked at later time, this leads to domain->has_iotlb_device is not correctly set, which finally results into a missing of device iotlb flush in iommu_flush_dev_iotlb()when it's called.
>> Check this call path:
>> domain_attach_iommu()->domain_update_iommu_cap()->domain_update_iotlb()->domain->has_iotlb_device = has_iotlb_device; The ugly fixup is to call domain_update_iommu_cap() or domain_update_iotlb() here again before return.
>> The similar issue is in intel_iommu_set_dev_pasid() and intel_nested_attach_dev().
>
> Yes, domain->has_iotlb_device must be updated whenever a domain is
> attached to (or removed from) a RID or PASID. I would be grateful if you
> could post some patches to fix the set_device_pasid and
> nested_attach_dev paths.

Sure, I'll post fixup patches for the paths, thanks for confirmation!

>
> I assume Yi can fix this series in the next version.
>
> Best regards,
> baolu


