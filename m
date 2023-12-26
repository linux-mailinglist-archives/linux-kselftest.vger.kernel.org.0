Return-Path: <linux-kselftest+bounces-2423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD281E485
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 03:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408A2B21B2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACBA47;
	Tue, 26 Dec 2023 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDQmYslM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6CA32;
	Tue, 26 Dec 2023 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703557304; x=1735093304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jgt4McMDsILSXzzZdA0PrSIGF/N07NA4W7AaZ9zAE+A=;
  b=bDQmYslMJHLvVuYyGP/jGVVUY7MMVuU7aimJjq5xZuQmLTV/XiqHGSxR
   4RzM4qPlcWKfbsIn9qj1I4ODUznWtqipVZyWqGjs4ij0n4sKxq9p7lMIO
   ztZvLvtSZ6ytTsGDFoqiQBf0QZwecEjOz9rqEWf09Njjgkuje80xez9OS
   GwMVj1UVVwj3ftd8jIEW0y9aJq1jVycx1d+Ksd6BUqg7MgQ3Xh5xb/EtX
   gf/HJBjmV4arIvykN7ezYfmoqo47yvh03lw9lsPn7uQdRS+O4DkBPl+xz
   oWk+n+uB1nT3ljOrj+uVRsIUWQxS0Bh/lATzYQ+k1gWtOL8OWzoKpYTJ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427480302"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427480302"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="896450185"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="896450185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 18:21:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 18:21:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 18:21:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 18:21:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdmjO3XtAlnkIZYjs6JoziMFkt2rLG20rwQl9B69afKm46PTtyx6h8PSkOcyIxrmwOe9Q0s0fV1m9q5RFjqXFigiHk0znqlxGFbRjQrvRAoN9euq2PxIY3e9/c3mA13XLLxEuhIx3Jw8vnZiD7e0+FMEeezntGmaMu+LFCZzeLOKOI0nVJp6IFzb65x9x3C69C7tHof6tySeAKyAIOq2ldg3+uK46B4cCNs8aVWCgoR8VtRAIZymboaT1PmAdH26y2kQwcE/Ybs8N77SDlbCqCzbY5CmVzKPtRyQY+YmWl9JpnpVsp9B8QipA01yLcMdVKPrMBCkp9pchuMdcH36FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7UiZYnGHu4jxnqv7d5xlcJdDDcqHbld1G6RXuH1D+o=;
 b=gGoTWVMbivolPyYn0dG1CNEC6L0IhboJDdyKJqLS4YRQB9vaTGGfBtSe+zOXVVBNjqvxa0+JinNRr/Qiw9HhQ/s82gTHddyiFXOnUMQLYgUZA4zMW7MTe+uwWMEJHCfoX9VV71nAae9aYZlpTQQsFKSU/aL4DolKw84s73VgTecWZBtGu+N+SQPsaN2WXQYSCVQm2JMFoxP0H3lFZaJWlnOF+MnkFTNvWJI51v6BtgzQfvSgeJfGIzxUbdBpanGJ1SfE/X+AtBY+jQZMIySTMu0ukJ0WVEA3HSFNHnIpvN95v74688lNmcsDOM5Cif98WXNls31dtZ/mc7eXCzCqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 02:21:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 02:21:39 +0000
Message-ID: <11e17542-75bd-40fc-a630-71842a47fb1b@intel.com>
Date: Tue, 26 Dec 2023 10:24:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] iommu: Add cache_invalidate_user op
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
 <20231221153948.119007-2-yi.l.liu@intel.com>
 <BN9PR11MB5276CE7AE7E2FDA1D8A045298C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276CE7AE7E2FDA1D8A045298C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf8bbc8-5139-410c-ed33-08dc05b96420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwBPcjB1zWr1+Bg1UDIy0QkYT1maWf7h7xMz+Z9nkx+7Wu5AeYach0vYVD7oZmO6Wb/LTEycsalJ33RoGcF6e2GopLbE5+BenkksA6o/m+RnO56InDrukHg8oyZtoX4ZuYho+0HjRtaoFq9oUpsnCFurOxlh6gB3B50KE29eXxmzlukGDBZDZUVku2pqe6C+Bz8lWn71N3FvcGasiKJQzf5lSWMQLAMgYeaG1PZ76a8UMyXEgjlGovsfjfJbq0hAc2EklaxXVVuQxuDoqx9MGTGEbOhhNtuv3AIdVeqadE8DlaTYf2jmZr8F0tvqvgpdEb/8hfHr0nkfmHmRx5L3/yLx8BMBrOYtmdJDE9IbDK1QWHMXxQ3ZS2NQHdHnX3eyBcMgTw5cgfIfnpYLS8Sfxie3Mf9ofsf3nwgs3GVvCc8SEmUwwAvfliL7whF/HyhtEwseCzjomfwjnDwMP11BWfCxFi+s5DZg8rr2Zc51wiJscIF94fFqMdN0BNzg+rqwkVegZmNakUWarwu0MWZPnKiTL0jkFX9QXXGbJ6/ZL0bSZqF/yS0x559OlUddJQGpKMJOhYphpdjUSiIqwrnVSSawzRP78TJRfv3RRU3eWFAVtzlt98mpUUEetpZCEwcQd3eFyJV1j6xGS8fm1KhGWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(53546011)(31696002)(86362001)(6512007)(6506007)(478600001)(6666004)(26005)(2616005)(2906002)(66476007)(66946007)(66556008)(8936002)(8676002)(4326008)(316002)(54906003)(110136005)(7416002)(6486002)(5660300002)(41300700001)(82960400001)(38100700002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFMzYzNTaE40M3NYWkdHd0JreEdmbGhiM2pMUTFYT3lWdTQzamJCclBxUFVN?=
 =?utf-8?B?cHEybUx2aFF5TWc4R0hERmJwSUhnb3BTR0ZPelBwQmxqMmkrV3Z6ZkFPWGk4?=
 =?utf-8?B?TkhYUVErRmlZNXJId3VlL2xWVzdsd0hLd2Q5bXdTbzBFdEhGd2t6aG8zSkdi?=
 =?utf-8?B?NnpBRE05MERmNzJhNU0zTzZWdnBvOW83b3N0U2xGeHVXWGpOZXhGUDk4WWRJ?=
 =?utf-8?B?bFFJS0c0b0g3eU9SZUVEVVU2NFhEVFV2N0dHSmd4VXFmRStTYytVUnBURWlR?=
 =?utf-8?B?U2FBclA1VnlkYWMxYm1jejduSHFLYmxMN1VtVXpkS3RHT0FtcEIwaDZTS0NG?=
 =?utf-8?B?bXZqK0tpTTJCN2grcHkvZ0V5NFYrOEk0Wkk2ODZKWGYxQUZDRG5nV3dGOVMy?=
 =?utf-8?B?QVlmRDZVOTE4c3hSbUlaYWxzalRscXdDaHRNajEvOEg4UGhicDAvVDlvWFlD?=
 =?utf-8?B?MStIc2FKM1hzMmlzcU9uWG0reEdvdjdBcXBrNWtabGdRcGRtSURMVVhLc0JG?=
 =?utf-8?B?b2l0TWsrOTA2K053WUY1ZnNSSnBlc0dsWkZuM1diU2pVNnhmOHBTZkszL2JE?=
 =?utf-8?B?bDd1NEVEcjA0VlRFcE8wSWxHSUF0VkxxYlhvckJYZGtlU0VZWXBKbnE3K2Jr?=
 =?utf-8?B?RWF4S21Hd3phY2FIcW10QThwaEZLYTJkbEc4SGUyWlZzTjdOU1JjWkpNOWJj?=
 =?utf-8?B?OW84VjRIellqOThhT3R4WjhoTFFFMTJxQ05pbVIyekhiN2lDTFd3dmFGMWJY?=
 =?utf-8?B?QThvY1hMRFQ3VE5lNlVUdTIvY1kxME5tM212N2JGaFJBVnM0clAyZzl2RFVL?=
 =?utf-8?B?dUhnamliVEhRamFKSlNSQXVqM01Fb1JhVU16di9jeStxQ1NVeGlHdWhKdWl1?=
 =?utf-8?B?MXpkd3JGOTljQUpvY05way9ackJCTmpMK1B4RUFHTTRUbXdTYTFuUkRpQXpu?=
 =?utf-8?B?a2IrbmV6VTFlbWdENUhqUExKSy9ycG9ZUHBjNHpvUGNReTNNTTJ2ejFRWDBM?=
 =?utf-8?B?ZUZDVVp5RTZaMDBFblIyR04yQU8rZmM2WW84M0JGR2dwSUVDVnI0ZWFuYjI4?=
 =?utf-8?B?ckJTVWdBNTBTL0NLYS9vM2JYek9iS3pHMDFVZU5QS3N3NCtXa0tGRW5hSUly?=
 =?utf-8?B?TVU4eURUamg4Mnl2aGxhazFTVUtNcEdtRFcxSWMrU2E5TmFxUWxwZWhoZ3pt?=
 =?utf-8?B?VFYyaWdLWE8veFNUSDRzVzNGcGc3ZmhjUGdXT0NXbFIyUHRQdlZCM09GVUxG?=
 =?utf-8?B?OHFIK0JLaFhKU0pOUUF0OTRVYlhJYmE4OEdUZ3doV3l3K1RKUDJqZ1FIbzh4?=
 =?utf-8?B?dkRLaldqZnJpVkNYWHRzeVZ2QXlXUnBuZWVlVDVSMnFyUVEyL2sxM3J3TVFX?=
 =?utf-8?B?MFVBYjV0bCtGOGUwZHVCMko0bmRSYmhrOW9uYldHbmRybjZLdjRhSlRRV2xZ?=
 =?utf-8?B?M1QwMVBSMXRGT2xQa29WeDFEV3RRdUNqSXJpTklIY3lkTjRyQjNub05lOWwy?=
 =?utf-8?B?T2MrS251QTJpN05RNWJHbzVnc3l6TTRMc0kzY0JId25VNWdJSVB2STNmM3FZ?=
 =?utf-8?B?V3JubHdhNkg2RHBYcFNTSUJxWjk1dXYxYXgraWcrdDl1Qkc2bGxITGlULzdW?=
 =?utf-8?B?LzVnTlY0WFNmSnlYR0hHVkk0ZTZqVEp0dTlJVHcwaFZDbFVCeGhCamN6TUpI?=
 =?utf-8?B?NkFVNFJONGNaQ1NTUzBwRkZJM2NvYWJ3Z0V2M25WL0hxZmJZRllBWEx6WVpp?=
 =?utf-8?B?c0U1OEtURkpNdVNoaElITXNrcWxLMDVUU2doSU9CUW4zRGVqaUUyNTh5QU1j?=
 =?utf-8?B?L0pQdFpPWUIzbk1HeUVsY2k1cGtJekkyVjByYWQ0K0pFRGdXN0ZnTGNQT2FB?=
 =?utf-8?B?VjIyc2puaVhZdE5JU2ZTNEFYNkg3SUhoVUpCR2hLNzFrTkNmQ3U3M2k1RVVP?=
 =?utf-8?B?SDcvWXowakR1Um9DSFl0a0RxSFJLVmFtcTh3VWxCdUpSNDlrUVRNWVFpaFpY?=
 =?utf-8?B?bndoblhXRTVNMEhpQzhxY2lqYTVjRERvRjlTNDNpVm5LaDBJa1NQb09EZWh2?=
 =?utf-8?B?d0JJSXlISXJ3aHFHSmxJQ0l4cldRZWFiMWk4MTcwNld3dkE1TmVzeG9GdlM2?=
 =?utf-8?Q?nV0y09Ut6mH0So8AlX9Niu23j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf8bbc8-5139-410c-ed33-08dc05b96420
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 02:21:39.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aXMAksF/V7ggXNSNSyokIQYXUcfpKLzF7JbkZWBkefN4od+t4JK1dLLdUjQUpZuqsd1XTUZlWgBiVXE+ocfiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com

On 2023/12/22 10:30, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> The updates of the PTEs in the nested page table will be propagated to the
>> hardware caches on both IOMMU (IOTLB) and devices (DevTLB/ATC).
> 
> this is incorrect. the scope of this cmd is driver specific.

yes. May just say the hardware caches.

> 
>>
>> Add a new domain op cache_invalidate_user for the userspace to flush the
>> hardware caches for a nested domain through iommufd. No wrapper for it,
>> as it's only supposed to be used by iommufd. Then, pass in invalidation
>> requests in form of a user data array conatining a number of invalidation
>> data entries.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   include/linux/iommu.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 6291aa7b079b..5c4a17f13761 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -284,6 +284,24 @@ struct iommu_user_data {
>>   	size_t len;
>>   };
>>
>> +/**
>> + * struct iommu_user_data_array - iommu driver specific user space data
>> array
>> + * @type: The data type of all the entries in the user buffer array
>> + * @uptr: Pointer to the user buffer array for copy_from_user()
> 
> remove 'for copy_from_user();
> 
>> + * @entry_len: The fixed-width length of a entry in the array, in bytes
> 
> s/a/an/
> 
>> + * @entry_num: The number of total entries in the array
>> + *
>> + * A array having a @entry_num number of @entry_len sized entries, each
> 
> the first sentence is redundant.
> 
>> entry is
>> + * user space data, an uAPI defined in include/uapi/linux/iommufd.h where
>> @type
>> + * is also defined as enum iommu_xyz_data_type.
> 
> I'd just say:
> 
> "The user buffer includes an array of requests with format defined
> in include/uapi/linux/iommufd.h"

sure.

-- 
Regards,
Yi Liu

