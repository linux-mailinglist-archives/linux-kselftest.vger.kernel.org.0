Return-Path: <linux-kselftest+bounces-2426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C9081E4C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CFF1C21B8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB918EBE;
	Tue, 26 Dec 2023 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6sCWbzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD0328B4;
	Tue, 26 Dec 2023 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703563141; x=1735099141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWg19hYtypgeTzZOOUjg1ldy+QwTj7jQYt5d7Uj7QEA=;
  b=W6sCWbzyASUE8p1AAtsi1aVMHHVAyBPjP83Pbz/kb/9mYBF3B4iidHVe
   QEIiUion13MXlB4I9xGPi+6FXnNtmWVkKCxSQq9RotiXw0gxdAgtp047U
   1ET6kb4/Asl06psh1hw2DOCjQUrz42uiSsEBOKGOzvR4ra8Ylv5h+t7sG
   w1pFwqQ0NOulFfQwGIRxWtNiRLKqyFMRvHyDbe4VopOmX4+P6gReTFl/v
   guzFa4oca6Xl25C7S0eVzmFBBjaN2UEKEH0kAeCjpjSc/0KVFY5mzQ9VB
   KA5yQIUYJAXnoHmXhKqi3IOgo89OVFLQrt9eka8cG2imq9X3W07KAddVW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400139160"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="400139160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 19:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777848301"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="777848301"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 19:59:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 19:59:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 19:59:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 19:59:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2G1FYpvSKnxN4UQJDv47T3GsZG/LR7bD5EtUViwQ/dGlCDcolK5wK0eJAhh0kG65WrNYfcA0qCBcEM5e25IG6GzWv07NJftnt1ry/6rpJIknaA5vSUAghPbtKxgZkEFPI9uHeBOhdbUXDMw1Pbd21HG3+qRo38NOQz6EvIBWU/xYEmeT3KdkGw957dR7RHcPWm8gFK0LKf3X+i9zeZ1Cs185TUtcVFcse9LBpHn2RzirR+mPr3zVSjzr1eWzVnXqhnfbv+tYVlqayeHu0gmzc9JHNKVMBhraj8cdByyKchNb5GYFl/uHUm9G3W4zoU7Sj/UmxsTmc8cp9CDVg3gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+VHM6cSNjJcYwqvjjpWS2cDwTAnk8HUUZ/ftrxxdwQ=;
 b=hduePG9lFrKrLkITA0+x9smaQZ6OSibw2lpDxQiepxjjEEFKJ4XnzB2wx8zk4zyOCbCexBtIDCoHiL92IPRKu85lBiHsrCcMIDv812Ly66uPfsKY4M1g1JiZzFEXYo5AiD+HI/trdgzvCxT2XJvt4HWw/7kKm776BQS5QOlvs8TIRIcUuvyg5Q5YE8FXurca23kTatXeBP8i6cPCkMUFIEImvvuK/LG49wcXyvBkZKKOJFu76mz6fG/NbifolseSZmxpXh32cZuZyi2bX1gFXGghQGXPTtHa/Y6DXqPFIxJ8HVW/Clg45hCpHbZkqrI84QpwDyvctEGHi7dwU73+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 03:58:58 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 03:58:57 +0000
Message-ID: <10e340be-5551-4bd1-9c0c-30254e0b1f81@intel.com>
Date: Tue, 26 Dec 2023 12:01:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
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
 <20231221153948.119007-7-yi.l.liu@intel.com>
 <BN9PR11MB52766EC5BBA4888218914CCB8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52766EC5BBA4888218914CCB8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ef97640-ea7b-44f2-d5b1-08dc05c6fc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFqpZ0OObxm4iW/BaQ0fRpFZsikvcPhP+QhMq1glJ8jmxnN6ZYzUq8VEo+zDmre1k4SQLhEh/3fBQjkbQry2Nwc8bWrW3vArzQZ8w/WCDbhT2QFKLTAHZ3vCxy++1T0SBP1qftYV7/0vk/LsqpGhq33SVs7g/PM0PfOXdNaUA5bQZs7bnqNu3tXuKHlTaqv5UepAGnO56o//CqaXSrFGELzIkkcohdkBiQxqwjd1lbwS5WVdWkMb7bgzhRpgUKPECcwjrO5BEsRlIjh8IeDlXZFUH+b/k+ye13cVfXF9iTGUdImWP2AkPofLA6vPW2Qg+VYeHQojxMfEpVzFafu+Ln5Plcuft06+VPH3BJ4hl3BFRsT7Rqlod+xZlmKnl+e1YGcLxfhd0u+M7vF9J/SjkCxINQb9XkV8wqjpDUXI4ikjJG+AWTl2VeQKBxtBankQLBGB5gkCyalMkbtMynKWNUegC65+Mg56oavOd5EOVM0IxUNuOnyPF1Da/axQVKeRJ8bpeSZLTWP3ftGmIe9NBM1a8A7WjZOLPUFJnb+VtTRdKhGsPISGh4Va5r3xch9KbVpvG//JjDijCu88WRBa/dfMgprgA5XKQx9gpCw8cD8zHOKJjUBzlUvtILBNKOjfnL5ABUFig7lYd2DgIf383Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6486002)(478600001)(8936002)(8676002)(4326008)(6666004)(38100700002)(82960400001)(2616005)(26005)(31696002)(86362001)(54906003)(316002)(66946007)(66476007)(66556008)(6506007)(6512007)(53546011)(110136005)(83380400001)(5660300002)(7416002)(2906002)(36756003)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVBTFBiTUExU2NxZDQ1V2pSSnFqeThndXlhMk52d083b29iSyswWXk5elZY?=
 =?utf-8?B?RTIvZk94SUZnWlNKRlFaTDJ5cHNYajZQWUlDNklNdHE1UnhyZzRHeWg3dUhE?=
 =?utf-8?B?ZmpYcENUVDlYZVNNSGdneUFZVUFwandSSXJSbmFtdG9jcjB3VGlCYm16cy8v?=
 =?utf-8?B?RDJOOTJWczl4TXk3dUI5Vnc1WUU5MTl3TGpUQ3Z3MXMyam9WY2lEdE8zTGcw?=
 =?utf-8?B?Z0VRZXFYT204a0YrRm1iL3FMT2M5S08wZFJsM2RsdFNJY3E0SHRzdDM5eVNX?=
 =?utf-8?B?WFprVGM5TU15UGhtZ2xGNm1WR05HNnFsZXQ0cnlqOHVDcXgzckVURUtuTy8w?=
 =?utf-8?B?QVRzQnpGREdiQjVWdWRBSnhkRkxPd29lZjZXdVBpMWZVbkNUZEQyczRKbGNZ?=
 =?utf-8?B?RzU1dnUxVlhEWnYrcllIZWJXSC8rQTVjS2sxa3hNUUwveE94clBNMlNOcjFm?=
 =?utf-8?B?WnJFRGxtQ0NBeElYeU5oV0h2d1Nldk9NY3RxSzIyWWowMCt3NWhTTGVwM2hv?=
 =?utf-8?B?SEF0MTFzT3JMYTkrMHhpSDIxQlppcE1IbkRTQ1hSRjlsMWZyMkxLNjV1cEl1?=
 =?utf-8?B?aWdNZC9TR1Zyb1owTGR3bU1naXRjRWc3ZlplQmxRYnoxZnZhTEZRd1JTaXpr?=
 =?utf-8?B?VDNEb25aajdybjkxL0svYlc5cVVRNGc5NEllcUI5Z2lBZmJ4T2FvakhuRVRF?=
 =?utf-8?B?MFlqaVE4ZEpWNUdFbVpETHMvc2FrbHJxWmd2VFRZSW5BUlVIRENrTlkzMGlW?=
 =?utf-8?B?UmFJWkRzeUJLci9uREZscDcrcStKOHRmMlNIUXZnUUh2NGRjVzlpR3RDbktF?=
 =?utf-8?B?WmR6bzBielltVWEyT1YyVjB0dTdaZ0F5aUhRQ3J5UThNZTdkQWRnYk5MOHh2?=
 =?utf-8?B?T0hkczF4dnhIUk45alFJT0gvbDZFc3lqN0ZDN0U2Z2xDRUttclRzMDdFMktT?=
 =?utf-8?B?cXArdFM0R3dFRXNiaDdaNkIzNE1NakVKVHFVbXdVTGw3bGNkVGFYYkplUmcv?=
 =?utf-8?B?TFlpbjVTakxRL2ZrU3ZUT1NWQTI4K2greDF1TmdmK25FNDlJS1YxL3MyWW9I?=
 =?utf-8?B?dng2ZWxZczBFYnJPWVNiSmovVkdWL2NFUlB0NWZBTHN3KzZkS051M2ViVDFB?=
 =?utf-8?B?a1J5b0RiamQxaUtSRmJrRllEZHNyWXBKR2djcEpHV0twdGxKaUg0c1licUVn?=
 =?utf-8?B?S0pvOWM2bmtYL1JEZ1FSdEJzNGxla0YxOU9kT0tuVVFOV0dCZTZCZzJhU1ho?=
 =?utf-8?B?eFhacXdtNHhaZnI1dWVZUXp6VkRiV0U2WWpBcVlqQmZaakt4aEtZZzdCREp0?=
 =?utf-8?B?aUZGZDIyNkNmenNWRjlDcE52cFgrWEppaW9mUTMzTy9kV0doazREb3k5WHZK?=
 =?utf-8?B?VW9iUFRJRVhaKzV3UEF1a2RreEl2VGZ1RVc2Z21iNTEzTE1iMEJNRWRvTllo?=
 =?utf-8?B?MDlQdVE2VlNSY1JpdGUyVC9BYldqRTdTUmhCNGNEcEFpQUJTZmFESW5PSHl3?=
 =?utf-8?B?VzVLaDV4Sml2OEdPcm41R2w5b0hpb00vemhKcmt3TzRjR0hDeEhRYVora01P?=
 =?utf-8?B?ZkRLUXFCMGhHK1R4aFFMZnNTRGp2NW1WK2NXUUs2MkNEVmJVZ2kxaEQ1Y2Jq?=
 =?utf-8?B?emwvTGtybXQ4SWFuTk1nY29EWDNIN2ROWFZqRFpucVdhN1cxUnNOeGJITTNI?=
 =?utf-8?B?MUN4M3pOdG9IamQ1Y045UHRNL25aRjM3ZnJJUXZ4TXZFRWNjWUdzbGxLSHU3?=
 =?utf-8?B?RkMwRVF4YUxyUjN3dkM5My81bk5aNnhVM2MwVXZPRmRLR29qUlhSMUt1SnFW?=
 =?utf-8?B?YVgwQU5xK3RaK0cra2w3MDM2c000TXNTakVVQmNnYXFiOWw4aVlYZUZ5YmRQ?=
 =?utf-8?B?dU9oalRnSWRmaTg0WDg4R1hlanhUVlNIT2liNmtKYTZpdzlOb3FEQWYwdyt0?=
 =?utf-8?B?a1oyL2ozWFhZTTEyNGwwbG12WGVZRERkVlJlUDR0bDFkdkFodmdMbnBhdlFF?=
 =?utf-8?B?UXhGYUNSWkxGVUJoN01HRUJzMkExU3NGZGxtblRnRGMzWG9mTUV6d3BOTVdS?=
 =?utf-8?B?U0RXTXF4MXJ0VU9ZSDFjWFpyUE10Umo2NGFWenUvMUJtVE0xNHFNVzRlTmpY?=
 =?utf-8?Q?FhNZ1s03+9ih+I0Z+6ASud2Pw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef97640-ea7b-44f2-d5b1-08dc05c6fc33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 03:58:57.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQubgMabqC2EbjRZJl+snc39HhQJtDWlAXdMu1bHgRpb1sGO5ULxM8bHAv3GzO0+VFowJuP2KoBy2u2ZjIj6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com

On 2023/12/22 12:09, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>>
>> From: Nicolin Chen <nicolinc@nvidia.com>
>>
>> Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
>> the new IOMMU_TEST_OP_MD_CHECK_IOTLB.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> overall this look good:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> with two  nits:
> 
>> +
>> +		num_inv = 1;
>> +		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL |
>> +
>> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR;
>> +		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0],
>> inv_reqs,
>> +
>> IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
>> +					 sizeof(*inv_reqs), &num_inv);
>> +		assert(!num_inv);
> 
> this may need adjustment upon whether we want to allow two flags together.

it was removed :)

> and let's add a test for below code for completeness:
> 
> +	if (cmd->req_num && (!cmd->reqs_uptr || !cmd->req_len)) {
> +		rc = -EINVAL;
> +		goto out;
> +	}

done.

-- 
Regards,
Yi Liu

