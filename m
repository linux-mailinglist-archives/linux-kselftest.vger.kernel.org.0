Return-Path: <linux-kselftest+bounces-2427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15381E4CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C533A1C21C35
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976A18EC3;
	Tue, 26 Dec 2023 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKkRvcTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56507328C2;
	Tue, 26 Dec 2023 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703563221; x=1735099221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8wJGIS1h4xMbHIESGGfFqLi49uWp3zhSgqUr8jf+Cl4=;
  b=VKkRvcTNABOCuMGfJwuRlR4He38IOufUIgnsVxa2I3d3YQ4Cay+ZVHiy
   Zv0xJcDLzW5RpTsCMRxxzqbYlxFhm6wPnbKVjm9DmBDZDaNqbXAmszMv/
   QmE0Bjf9rtLyWc/CcZ1Je5il/aGWf8ol8e4+5Ef39OppPRzc9WWvkkap9
   zIGaMX+CZ3IqQ+yfVv9mBhSA6aH84anhVSMGSdVQMFcXBhiD+jkyTVvCM
   3RPRvi2LePJMcwpRzwylshteM53Ofgao1x3QKModwtnELLEF1gyB8H61q
   usUV/1jKMPVJLC9OdKMXlTR2mg/Hu4A4VuDNJDvYXvpiYaGuntQZlvEkK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427484846"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427484846"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="951120581"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="951120581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 20:00:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:00:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 20:00:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 20:00:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SduxNYg15iJ3hveM9AavRtAU4qNP1xF84dwA1BcTzyru65Em/R72NloKO0i9oEIgelHNbYf/1EQYArUQg+jeSQEzhihxAh3eEfmN/HHf4wYebEaVEutnLV/moI2SfvDpTWbTDmI3eMiF+Ll6Fy+SCLsunq1hdrmD3q2jaUmBnpTbEweYqsBhmvXrLgdk4gQA1OGoUN0puYDoo5ZWIqgb/FNhmjDmW45QM9FGFEWjYiFU61oTepcdab6YfedkLCC9z3ePWxsjdqApmYZBNOUFdmn3189y1xXNE2nVJNuM7VI6pblJzWP8OqUcOXmt4wvxRZcS4uNsuFhRzf0+KrrX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYmEqg4LUg2hFezJi6dsTEmGJtgpMeJImn6C+0lK2Ew=;
 b=FowKFdWQy+jVeq7JyQnIY2aR7Fct4ogqWU76LFWTJbZCLpGo1pJueMd7FBVAy2Oub6jrCQBItE3dyZKeMjsJDuIpkTvf78sfH59316Ts2M3kQP8mf2CU2S5nwnf1R5K+aj1ibxibViyWLQk9DWrvGS1FZLYm6wZNtXTSt9KTJwYf4I7gsJQxI1wHEhT2Z839PNzx0mDUQ8uyO2p0xiAbULXrJHkL3iSNGMvs+ID9omaqB/7paD+Z7OQgLPRJDiDgV29q75kG9v328A5EvqBN1jSX5GsOPVpGwmN6tu9ghJTXtSQggxioE4HwlfLdGGeB2kYiONeGgIgymkrD4/5LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 04:00:18 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 04:00:18 +0000
Message-ID: <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
Date: Tue, 26 Dec 2023 12:03:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
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
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN6PR11MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: c988914e-06a3-44dc-4c8e-08dc05c72c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub1Ifk9shsRieBclu3xaqQCxVkuNtUDxDXfXy+cSWbAYiDf5D83piM/ZIceKlXgJegsdeE/2u4qsZVREmxXJ4s0TqaZ3asFeQB/n+L91fPmw00GONj7lvUunzxPArjcLM2seEzTh0zHb4YpHvzJsuQ2lFSClTUpphrDrydeM7CKm3ugEzdkShqj11TtaiaRP52Ar9bZPerQVdj2BK8Ta2rtbM37Aus0NhLOMcr96GRVX79XW4vufjZ0TTOWH4rzQBQj+KdilXekq/Kt8KnDvFBzSb+86LZZNsS7CgwtDMqoX2qetwjDeyLNH+tVOFg2ogM9vszmoavXzZchNd6s8d/Qx+XKWHW3k/YmQB2C6shhsgLcsb5IUkZIpMj4bWh8ZeoXMDAXzUPlGhf52uGAdiWcN92wQJIKIXZt41otlAGFZMGf4hR15xi94tojArq1lpfZRXa4/gvjiaFnMaLuvZ2wq68nQjeQKYK8WKCkgdEssekVs4EGnv8lO04G+XjZtKmXFx1n5Phoe9gdFFx00XcSSMIrmghyPtDVpojbv3GMmYUaK8Y/0N9mEypaeYB0LP2iucnM31BUmut/mDoxj7mOlMVMStPzQZkU1kbhtOBiNJHlf2jRuYBNfl7UUd/oPC0vRud7mIBlU1WVVqoLU1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6486002)(478600001)(8936002)(8676002)(4326008)(6666004)(38100700002)(82960400001)(2616005)(26005)(31696002)(86362001)(54906003)(316002)(66946007)(66476007)(66556008)(6506007)(6512007)(53546011)(110136005)(5660300002)(7416002)(4744005)(2906002)(36756003)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdXM1dETVlsWXBnUzRydE0xZ2xsN21INExaQXhqMXJvUzNEbTd3MnNwMzRU?=
 =?utf-8?B?KzgxNEwwVFJ3VmcvRkZ5RFo4cit0UE9nY2VqUnFHUWJrdTFjU28xRmdPY1RM?=
 =?utf-8?B?NnJTUkNFVXFqdUlnSS8ra0FPelpCSUJZdTE5R1czdlJUc2lZMjMrTTB1c0Jq?=
 =?utf-8?B?MDNhdnU1c2p3eUFEYzk0aS8rRHdSbjhiT0R1aUdMUkNEVktOMnI2YThQVWZy?=
 =?utf-8?B?VE42c1pVZmpnVXVrOUs1cjhYamgyZkhwSGcrSTJHcEZpaEZNbjFlNkVmRnha?=
 =?utf-8?B?bkM3OWhSWk1HZ0Q2ZkU5MjlsUllwWkI2c2JFZTUvRU1XQzRGY2w4enFOVThW?=
 =?utf-8?B?WlBlWHI2K21kNnROVXkrU01ybTJZM2NOT3FmNjdpbHA0VWIyQzRqcVBzdWdt?=
 =?utf-8?B?ZGRRUG9ta0F4WGMwMEw4ZjBubXd3ZkJacUdaMnlsM0hXTWVLaXVpZk53TlVQ?=
 =?utf-8?B?VXVDQTdrNmV6RmFmNlpxWFhZRWF4RldLWFFnTDgzWXZxYmtVMnZmQktaclJQ?=
 =?utf-8?B?eldBcDhoT1RYWVdWUkFKeE9zN0Mvb3l3UEswSlBLVXFmVlpCeTVKNHo2RDNB?=
 =?utf-8?B?bFhLblc1YjR5SmNzNWRxTEJZV01Ickx6bEVxeFlMc0U3QWdPMXpJOWZ3YXEr?=
 =?utf-8?B?ejhDMGlvSk9uVk5FNktMQ0syVjNCazRQUXBWTHNQNG1IS2ZCWTM5dUgyL2FT?=
 =?utf-8?B?cnEwR0Z6cVhOeXJIbVZBQU5kamhySEVtNzRIcmVMZ3lkVXNVUFlxUEpkQ2tx?=
 =?utf-8?B?K01SQnFQTmdpTE9IdjNlb2dIMXBSa3dMZFFsL1F5Q2ZNK01YU1Evbm14OE94?=
 =?utf-8?B?Q2k5SGVNRFhhbEJKV3NTMFFGTmJmQTdFcnVIVENhSVFINjYyaUNjY2EvZEI3?=
 =?utf-8?B?WGVQa0tHVmdjcGI0ZmJQSHYvRFpHaEZVYnA0d2tmZitzK0k1VHRTWHpUSjRt?=
 =?utf-8?B?THRIZWZ6VDdvaTR4c2M3ZXJDakc5aktZT3gzWEpzaVdWRFZaYlB0eXVTTUMv?=
 =?utf-8?B?b0NPTzNZY3hVTDJDSk1hMldWU0ZQbzU4VS9VbmQxdDV1cU9EQjZTZWFadUFs?=
 =?utf-8?B?RU1VUXROZDNYNVVWbm5aOXZyeGRYWC9zY01BOEp3ZkpQTnBXZG4zT09mQ1FZ?=
 =?utf-8?B?RjNTbGJBNFNZbnQweEw0NlVIdkNHZFVyUjQzb2xhQnU4YnZ0T3N5UndHdUVZ?=
 =?utf-8?B?M2RRaVRwTzVFeEQ0MGE0Mm5WQ1NRSzNneXorVlErdC9QSTFkMGpZa0NnSjNs?=
 =?utf-8?B?TFFkdjI3NFJKdmVwZjZLWXVldXFwTzNwd2o4Z1B0ZVZuYmc2K3Fxc0lEcG5J?=
 =?utf-8?B?MStBNks5Y1BpUWpNa3lHZ0VYclF0Zm1LSmJGOTBJeENmWUxKN2NlVm9CZmdk?=
 =?utf-8?B?Wk1GS3d5YnpNUXNQY0RmdldWR1F3VURveUJ2VTd5cDFOSXBUbGR3YzYxRXNC?=
 =?utf-8?B?OGNhRVdnWWtFRThraDFEVUFvY2xRVXU2OFBaa0Vnb0NqVm5QTTZGeVpQZFRL?=
 =?utf-8?B?T3J5MGNsK1dFclhGUVUzdVdZMkVBelFvL0JKcjZ3Wlp6QVowbHFZMDUyUFF3?=
 =?utf-8?B?TDhMRzFXQ29ZbkVDYlN4YWdWSmoyUTUxNExYSEh5MXhTMG81TGt5QlZTRTFH?=
 =?utf-8?B?NkJsWExNb3A0TmtSSG5ndVdhZUtDYjFHSlFtb1hnNy93OURaY2krZ3h3bGts?=
 =?utf-8?B?MURsVTlZUWQ2cG9nR1hwSWVuL0tIaFRJZjNVdGdnT0QxdVRvNnJDZCtzcmY2?=
 =?utf-8?B?MFlBUXVudEdpOGp1WitkQnBFMHE0cnBKNmc2MjVXcHRvclFEZEg5eWRzbG5Y?=
 =?utf-8?B?NmhoNW9yRUxnME5yZ0VXbUtGNU00TTBwM2hmZXRTenczMmhyYWlKdVVucWVr?=
 =?utf-8?B?dkFsTnd3RjV4SVBORVRVcUZ2VVYrdkdjMjlLUDhEYUJBR01taXZBMWxuWE90?=
 =?utf-8?B?aCt0TGd5bTFwYmxId1M0TGMxdEptQkU0ZW40aWZnM2gzMkJXeXJUQjE3MEMr?=
 =?utf-8?B?Z2xJb2RZcmQ0V0NQZit5bEM2ejI5QWhjamt2dXE0VDM2ODRtQlFGaTR4bUtQ?=
 =?utf-8?B?a1pQcGd3amIvYVRTQUIzRW5sUmNUVEZsWkx2Q1pFcjNaZm1zdVV0Q2ZjWkpn?=
 =?utf-8?Q?ohU7SZRob3tkQkI/iI6pQaT25?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c988914e-06a3-44dc-4c8e-08dc05c72c2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 04:00:18.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Z3BKSgrwLtdOceEoIC97Pxg1vGypCINQOG/fHd6HyxfcXjFceefbgnxEB8w8Xo5Q2LkkSyKjTRKJrKZswkX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com

On 2023/12/22 12:23, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>>
>> +	fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
>> +	if (fault) {
>> +		if (fsts)
>> +			*fsts |= fault;
> 
> do we expect the fault to be accumulated? otherwise it's clearer to
> just do direct assignment instead of asking for the caller to clear
> the variable before invocation.

not quite get. do you mean the fault should not be cleared in the caller
side?

> the rest looks good:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu

