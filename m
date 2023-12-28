Return-Path: <linux-kselftest+bounces-2493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDB81F5EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6D7B2261D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110B53B4;
	Thu, 28 Dec 2023 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lt5HCGcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505F6131;
	Thu, 28 Dec 2023 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752198; x=1735288198;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kBgaPZ1tgnlkrLSqzw1kHlsGJlIBADY1vEMv9fnmv5k=;
  b=Lt5HCGcUeXsAiiI2wgKqjrL1RZa4PytVrNDT4M2mwAG1EoXGxle/uYHv
   NSCkKQdvR/q8tolnIix6+E1CFcUDqVI1DEI7eWBuPqav3epOfbyky16Im
   +xALMVbHPCwRRn13DxtWakGn266k9LOWqQl/hv+Uvwo3nmUbw/HbKYjg2
   6rUnoXW86xXPy2cDWr3uIHtm3ztDqCSaWdsfpHXe0PNIgGYT+DUJHdY99
   CWsN13AJSG0+HhFXLEFQJu+OAu9miN60cuasILPyQ6nmj2/25vKVXoT4R
   JMBXZLK9gGWq+np7jvxxRa/674v2FcRUAIs1T7+42hWXUvAQ6ysyKWiCP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376013455"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="376013455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:29:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754683882"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="754683882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:29:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:29:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:29:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:29:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:29:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncyBveM9UUHRMMfHMBTYwu7gW0KNvTfkglM3LP4rzTMnCsjt9sdLhNAaXmQikFSRNTM4zkXditmz41GjkLqyPgPL0fMJSdMMd14+RR+59TZLa4FCuYg8q294GN8nsFDPE3TMe0xewGzq+CRd8sUJz+rjIOZKjuV1b+dPQQun9Bm2edhIjUrwuJMMJeuinTTlZerr3MhlvKOltO32sZRoYN7PPQJjrwF7s+q5tf7mWsRmDYfYuUsG45P91O0rP1zvTg/PkabNRsrtM/LRzy4csGzDY6TKw2DMQ1hyILrrceWU31a9RNEBL+ep+/yuf3d+OiOCVuxnSEO3DvIDz4ZCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci3urkIsnH1HNwpzRF7A2wS8Fai6U23QojeO5HKU7y8=;
 b=ITaGMXZg5R3Xa8gpCNe4b3fwaO3q1S8pNpl2xyxPMoeF0n7LqzDI41j302qQg4kK0KPRJQjxwH9EpuKMiR3HUT1cQQnkM4zEoeaYWA1JNfpWK3ek2UfTqFgGETjTvurN9Qzbi+dQZxQatOYEh0AX2dsO9JmmWz9NzpTIYCCtr9cEF3UdsrWUYHvYcU5H2rT94Dsr0Q1CE3mp3LcTmPnq5filLxOcresVkRGiZ+M18yIE45cvj6/iR6aRhdloyY0thpDlxMJ7mj15u5DqC9IKTGS79k07DWh4xogoai5Auux9m+oc0Vzf3GAe3A7Ju5F5mWTYFNq/8shOccl1TQoq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB7163.namprd11.prod.outlook.com (2603:10b6:303:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Thu, 28 Dec
 2023 08:29:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 08:29:52 +0000
Message-ID: <eb560b8d-e7e1-4af8-a585-78e50352c8f0@intel.com>
Date: Thu, 28 Dec 2023 16:32:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] iommufd/selftest: Add coverage for
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
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-7-yi.l.liu@intel.com>
 <BN9PR11MB5276DEF13D2F64D244A932C68C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276DEF13D2F64D244A932C68C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 012e1db5-678c-4776-d360-08dc077f29b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KxAHUQqf296Fy5YopiAsJAC0d+ElQvQNpHZPkAOVTzEEj7fz/GR2mmiJJV5+EFwIFtfq+6tK1SjCGiPZ8n1/fFHGViHx2iVhExuuxvVUTr6fiKF/6rgbMrx9NOHT8m/NocenDWsJkzcVqbsSD3UFJsDnBaYibF6wddNstOFmWIY2mUc2qARRe8K81P7PnN+K5RTcTJBIOHKmUt2B9SW7zV0EQxXcqDtxk1DZxxdnXpS+nK3WI7P4qlabmBMGMGTHVxYXvjBpr9hv5jQYTz4OHq42M3fqYsDy1efNPKLemDDaxLas+Rd7kh1WPdi/nvekcr0ikK7u9etxO1mVEpheJBkez5qWUOc2iTaEV1e76/33bBAOH7NqjyM9B3fzKYqg764hIN5CY+Hu4I5qeTogGPqsx4id2SBPW4ZOHNQKuRTerDNtJpKFFHjLLQv/PTs18azscDzRIYsLoqqkDymP71PNBrCJvKxPxJ2MhvLOqYfX08EFTljauFwVclBV3yYXyUrrMhDatTGtwrQhxfV43XAb1uC0Ihl1EB8PKYaaZKR/rS013TQv2c+NHYjdQm7XD+3D9umoRv7waAbUJf5O6CDDmVgrQ8Yet0ft/iqT9lo94DpsQSnYyVmYYbUO5O4BZTTsmqbqWG+2jC/bQsRQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6512007)(2616005)(26005)(8676002)(4326008)(110136005)(31686004)(66556008)(54906003)(316002)(66946007)(66476007)(82960400001)(83380400001)(6666004)(31696002)(6506007)(53546011)(38100700002)(8936002)(6486002)(86362001)(478600001)(5660300002)(7416002)(4744005)(2906002)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTl6Qm1pYlU5WmpGSmxOdlZIdjg1ZmNDYVpiRjFlSkFGdURoa2dTK0pxUzNy?=
 =?utf-8?B?dzRyNWV5K3lKOXo0eElmWnZtTVByYVpYMmZ1NE03R1cwTTloRGJnSTZuSlhK?=
 =?utf-8?B?RjUwZUgwemtVbXRuWlhJRHVJVDBrbnNGTno1YzZxQUZPbmJDRmptUzY5aS9q?=
 =?utf-8?B?TjZlRTVnanRrOUk1K042clFRUFhmV1NNZFNnVTMvcjJGNlRRYU1sblFuMEpn?=
 =?utf-8?B?QzRZK0Q2NXAycW10eEdjRlRNVWhBVDhEYlErQk5BUzB3ZnpKRVFkS252MDFU?=
 =?utf-8?B?N1pGQVRXMWdiVDBwS1BMTmNZNDh3VEhVZi9HYU5nRzlwRGRUYkRjZVR2ckEz?=
 =?utf-8?B?OHZNbEFnWGRHZmUrNnBvTUFpeHdmYzJ3UjZRNmdzVU1rdDJYUENudE9FREVP?=
 =?utf-8?B?ZmJ4eTByNFEvM2JmSGdhbkovVUptSHExeDlOTmR5TFU2VUtrcmlGTnVRVjlh?=
 =?utf-8?B?OVQ4Nk41TC80Sko0V0VCeEdDYkIxVjRwMW9CUy9Od2E3YkwyR1JuV1JIYzk3?=
 =?utf-8?B?emtBcTJaZENHNXZhTXhxMzhwL2JIL1lSWU1UMzlnc0pISGRLK2RNVmp1UG9i?=
 =?utf-8?B?WkFNNXdjQUpzUEJHWFFDZWxURThveHpwM0lvR21SMGV2TVd2dlh4RDc1L2pX?=
 =?utf-8?B?YmIyKytuczVHSmdxTHpKcnczUFIzL1lVVGZMQVdFUy9ZenNGdWlEejFua09t?=
 =?utf-8?B?SWkrUS8zaktHbzJpU0krdGhFMFJVOHZYSmlBZlkvekdTTm8xRVZ3bFA1MjRD?=
 =?utf-8?B?bTg5VDZkU3JoblpjakJXNkVFbCt1ZUpVR1NtYXVrZHJwZ0Y1ME4rOWt0MmNC?=
 =?utf-8?B?NmRVK29EcGpZcnk2ME5zQzB4UW05dms0Z0x6a1NvR2p2ZUE1SUtjREpvK3Jh?=
 =?utf-8?B?WVF6c0VUY1NCdjNnVDBEbXBlUitGemJYcElRdEdrb0ROeENZb0FsNnYvTG1X?=
 =?utf-8?B?UWFKNFdjTGZXZzNJNnR0OVBGL0NLSjFaeitTOHpVZnRZUTcrcE9RbktHc3E3?=
 =?utf-8?B?QmFUTmlRSmhvbW9ORWk0R0psNy9hU0tweHg2QnVTQ1BYcnpiYUNNWHlYaUlR?=
 =?utf-8?B?RFZSWVI5d2dYbGxtS1RQZmQ3VEJ0WmFGTTlZbHhDOFBuakFHa01IeWhnQ0lH?=
 =?utf-8?B?VjJKS0xtWFRtYityUW81Qkt2M0E3M2Y0Nk1CMXhXQUwzOWovME16MEtOOWt1?=
 =?utf-8?B?M3hXZ0JvTDdYZGNPUmliYlo5NGxZcTdCMGw0UmdVTWgyMForSjU1eHFON3oy?=
 =?utf-8?B?QXE0MlVFT25oQ1I2U2ExV2lXM1g2MTkwNm11YnhTU3ZRU0Q3RXBqN1dNaGlk?=
 =?utf-8?B?SkZHVWZVYkJuWGd4eURZTjJ4SUxZQXVmUjJVajl6bzVPcDc5TGhWWFF5M05V?=
 =?utf-8?B?Vm1uYk1pZjVKUGlCVi9sMW1hUWtIZVc4UWFnamhraTVQWEUzNGpnSHRJRVBa?=
 =?utf-8?B?Qm1KUkRXQ09COU9lVUdQbXpIN3haeWFYRzRvcHRTRDdmdkxxS3pYTWFuSTJu?=
 =?utf-8?B?YWo4UkVYOUNsTWtwd1NtSDEzVFBBNkRuOEpxVEticXdLVzFuMlBPTUpQOTNB?=
 =?utf-8?B?MWpmb213cUgyZnpYREJyNVJab1dZOTY5SlBtTUc4a3VQd0sxcXhRR3o4a1Z5?=
 =?utf-8?B?OHVYdEsxYWFoVWFVT1lla2l3alpXWU4wL3J6MG1KZXlZeU4vcHlDbTVQdFBS?=
 =?utf-8?B?bXRIUVVjNEFlNVJ5RTQ1WHQ3NDh0bTBDZHF3VFNKL01lOU5xQi8vK2VYMEdF?=
 =?utf-8?B?TXlIR3BQQTdtQm5YeWloRWwzSW1Ca3hldHg3TDBmUkZoWlNFM1EyQVNwT1Vz?=
 =?utf-8?B?Y0Vldm5lcitCL2Q4SDhKcG5aV1dJTmNtMjUxd1dVVFRzSGJJN01iOE9YZ3pN?=
 =?utf-8?B?SGdmNkVPR2FCaFpqazR6M0dHNytTNTcySHRxUmJPZUN2VXJTN2lUWitnRmlI?=
 =?utf-8?B?RzkySEhTRVZ4aUFVM3Q0SDBHSlM3NHVvejBXUFlVMlNwQWlCaFp5cTQ5UHF2?=
 =?utf-8?B?OHlVb1V3ZHFuK2VvNHJlVlRFNG41dW1RSTNoNzNNZ2FBRVlTT1A0L1o5QVF3?=
 =?utf-8?B?b3Y3clA4NzIwUTZOSXJUWVdqeFBsSU8xeWI2a0JXbGluYkt3N0dQeVcwN043?=
 =?utf-8?Q?0fdNShfpH6N6Rgm360jDr5MHb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 012e1db5-678c-4776-d360-08dc077f29b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:29:52.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGeZE4H+sg9fk6HLd+u3PnxabrZsVARzaXAPZfuyjxum5uCUzfaTgI4GVXV80SHkOOvY4+Zwt6wetiQFvM+snA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7163
X-OriginatorOrg: intel.com

On 2023/12/28 14:14, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 28, 2023 12:14 AM
>>
>> +		/* Negative test: trigger error */
>> +		num_inv = 1;
>> +		inv_reqs[0].flags =
>> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR;
>> +		inv_reqs[0].iotlb_id = 0;
>> +		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
>> +
>> IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
>> +					 sizeof(*inv_reqs), &num_inv);
>> +		assert(num_inv == 1);
>> +		assert(inv_reqs[0].hw_error ==
>> IOMMU_TEST_INVALIDATE_FAKE_ERROR);
>> +
> 
> instead of removing TRIGGER_ERROR|ALL err check, it makes more
> sense to keep it but making it a similar case as above.

yeah, but the config of TRIGGER_ERROR|ALL would be valid. is it?
Your point is to add another test case to see if "error" is generated
even if there is other flags set. is it?

-- 
Regards,
Yi Liu

