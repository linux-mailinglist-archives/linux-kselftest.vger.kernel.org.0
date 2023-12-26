Return-Path: <linux-kselftest+bounces-2433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB381E571
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 07:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B211FB21418
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 06:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDF4BAB7;
	Tue, 26 Dec 2023 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVXOwCLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815154BAA3;
	Tue, 26 Dec 2023 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703571180; x=1735107180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VVxfiERM4OuH5Qmf+WGF8YLAdAsEtLSqBTZOV1CNDP8=;
  b=eVXOwCLT8e+hPAc8TBdMWVjEfffAPXHE8fZsv5vWTW94j08ZJGBCV++f
   gDfpb+MRcC2rHhXCDylKyX7FT8M+YszeOXw/a0zfM8s/EMSaY/Q88fiy0
   DfRlu/zH48YjrmXPCXRs6nNGLaxB2/mg03v9ztXFB6HG+XenvUMEOjPrT
   Zq3HsTxCUSqGvmcz72SQLDTYdyaQOVoInSlITolIwwQsvQEGvfWaYp9EN
   e6B7NbyziodxgIjAZdz0JF0Zq+iAzHv+xxgb7wZriMo83d9xxyfQOfl4G
   3HnZnY77XOWyPaulVEalFJm+EdOAaHKR7BuyjMhk40oHpT4u064wwmIqM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="396058677"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="396058677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 22:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109296829"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="1109296829"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 22:12:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:12:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:12:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 22:12:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 22:12:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEs1ykJ0RJWdwpMDBwcBaHD8ZcJDS7ZZOcc4GPZKHHv5nc3Uh1BvuHJT12k1GvAAPdnAF91fPhmO80zayCUZ1L0m3YHql/JUKjXfY5K6PtQpCbqExS4xfmhUHay3AbmfBPPbydG0hS/ewee3i99y8Ul7BnMkAlj1Rz2T/kgyTQoCp418kYm+i1+rPFDIsQONSp/DA5QFZLAfoZjrOcyOmh5rUYgQpvEyhnazou/1fpMQONcrHF5xS5ojHV3lTUnFUA7HHqJGgdp7/7qunk8ODhWRoWiKu/zBwbWM4fsDBCRZsG9PtlZodSmE2AxAHWmzfGyLEG/Vy/ALQdluHbx6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfoMYENZ5644cUWiv6/UNejRVGdkZhywEz9SX6LqBMU=;
 b=gTX1S1vUNuM9t2zsCGEJy3T7Zw+rMU6OFp8vBCXcpc+U2xcowYYregqUxBQeOzhwiPFJ+kpm5L497uTCVjlAcql3WnNFmqtQUqajam71INw6pTE26HzfmZSpMvkYr5vleuD2/mxRWFiN4xtlPxjRbcdm/+g9d1L/JMnGPuOceoIDrRdFkiqgYo8ENXNQ8DM/GPCio9O8T0JmA4Ks4Ujr7z4owtwt7tiP9QkYILZTc68zqoKE0DdibWKUIURHvijSBVzgCqUKz26UyAhyqH5A6Lx9U8S1vzBR0fTrA6z11IvyDbcD3pa48OKF4KHdpFs0kFlKEba38nLu2RO9YhXcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 06:12:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:12:56 +0000
Message-ID: <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
Date: Tue, 26 Dec 2023 14:15:43 +0800
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
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ee96fa-6584-46ec-1b93-08dc05d9b331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awgnAkBtUpRcPosX680yuTwRXDXGcGACvBm4LDDlZJJKAsP8fgG45GastmsHR088u59wt+LThNfniJI3x6I4RwOKrAFXgDdKNHWNcUo5hOLiWCwi9K0flEao+BKyaGaU7/9M9lsytd0pa9a8ofgHT1LWJ4OBA05iNjiMC7IMAjsFU3TYFw+QcalUb5esymMqsmUBPAVMl55FZR4o78bAXFAy4Rg2O7GipKURghsBEcIONv/H8Xhyx5tl3gDw/U7ZYZ9MujSBQvNgFQx0kmsklrcuXSuK6noELAVAl8IZ7vtzKHqNp7ICiBuu0TVVseAAVh1ukVyvgPiLvuRT9NbQv0qu4dTMSSXsYM1awjszulpCmsQLhsIjPjxPD1ptB1M00o+DNZpwlgliyk0uKZKXcSiC9XjEpTwlH+JncYDMdPIPOz0O0ZMqUAXUvw7nO1NRvoCz6bN6lN1+8H1YtgQBtF+QdTJSgu+Ecvib8QLm4WFT05O14kzFitinGDNbyCmwZeENkB3ApFlopVo7Y50jVMmOV3T9hHRhovh2eWoSdAGdOmBE75xfck9oHLj5sCORXzbsZ1B6HzvAqKS4wPdZsgxGPfVMUkbdPH4mAQOgxjDWGuRLjTMDHjegu5LSJtnkbTs3QZJw6Pj/G8IMxpd/MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(8936002)(8676002)(6512007)(6506007)(6666004)(4326008)(5660300002)(7416002)(2906002)(4744005)(6486002)(478600001)(110136005)(54906003)(66476007)(66556008)(66946007)(316002)(41300700001)(38100700002)(31686004)(31696002)(86362001)(36756003)(82960400001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVwSENzVkU2V2xyS0hTS3liYXB1NGtFaUtlNkcrdENOa1ZyVk1TbHVwTUhN?=
 =?utf-8?B?Z0Vka2pmdjJ3cElKYUN0cWdDbitVMk02dFZMVmd5cEJjTWUyMjErRTNWcFh6?=
 =?utf-8?B?ZFZtYXA2QW12NTc1aVAxN21RN0UrZmlMQWptRHpwVkFpUHg2d29acmd0ZElw?=
 =?utf-8?B?VDcvUWxHTHNjWGlFTUtldk9nM2o5THBIK3ZQNGFBWGFJRHpTUXlVT3F4Qkli?=
 =?utf-8?B?azhaaktiQmM2Q0svZjBVc3pnMkdKQ1JYOEFsUGMreS9xdDBZaEYzK3RzMGlr?=
 =?utf-8?B?SFJxaHo5b1EvUGtBWk1saG1IY0E5cXR5ME9oRGFVS2RLMGFITmpnaHl1Z1ZN?=
 =?utf-8?B?ZGp0dU4zOTQzaG9JYzVKSENKc0hESk5kc09xVDZpeVRoTDUybC80bDRVaGoz?=
 =?utf-8?B?UElPMDV5SFdVQnpZVXA3bVhISjdkM2FObnhkMkhyaUNNQ0hFekZiQ2dpVy9h?=
 =?utf-8?B?eVJuWnQzQkl1c2dWSEgwWm9rODZDUW9TNFV2cDlBK213eWJNa21tdHVtdGE5?=
 =?utf-8?B?N000SHUzNEZQYVNmU1FMQlpDallPcHFSWll3d1gwdmd5akt1aXFHSUdWRUI4?=
 =?utf-8?B?TVJuR3FIT2JmQUcvMjlMalVSZGNlVkVZQmtBNnAvQ2ZYcUdyTUFEZEtmazNk?=
 =?utf-8?B?RmN2dU5BV3ZzNVRCTjNBbytWWDc2N2RLZ3haTGYxQ25rQUZGdDNiL09PeDNX?=
 =?utf-8?B?bkFmQzllc3llOFR0Q28xdzBqVmJ1MjYxazl6UE9NVVZBdVNxcFNpZVVaNUFK?=
 =?utf-8?B?K1l6VWNNdVJvK01keUwvUktGcEhiY1NLMDVvalNWQXh1VE1QRVRHWW4zMHg4?=
 =?utf-8?B?ZHY2Q3JEVWh6TXJyUTNQYTNQdktHa0pCSFNyWWhCaElobTZwcXN6RFN2VS9z?=
 =?utf-8?B?VHozTDVFYk5aQmFoKzNOOVREcTNLMlAxVE9ZTURValBVd094MkFmV1RIdk5v?=
 =?utf-8?B?NTVqMThMOFQwSTR3ZEJTVFJnbVZSNHRIeG5RaGd0ODB5RTEvNmtENm9TTE5N?=
 =?utf-8?B?VlRucnI3Y2UyUTIzejN1QThtYkRmUFFOd0sra2VSUDYwSTZtNVNlWWkwZGpN?=
 =?utf-8?B?WEQzYW1MaUZSamtSSGNLUnlDVEFpbkJOU0dXejY1TmVWcFlKNTVsQzRMZXBn?=
 =?utf-8?B?bHpjZThSTnBTTHdnclg5OHpxbkdBUS9pamY5WkFOemhGOUxMc0hrVkJIYVMz?=
 =?utf-8?B?R3RYQzI4a3h5aDBMUS9oR1lGazhIUERoL1JjbzMyQzJiV2RpMHA2enhWb3dz?=
 =?utf-8?B?QnZBTTlTNUFIbVAvS1BNdmRVdTZhbnpLU2Ezd3JsVzQ0NTB5bTVNditYYzRo?=
 =?utf-8?B?Z29VaHIrWjUwZXBnZTEyVVoyUE9iNmo0UlIzcEN3bXdCbW9rSGI2am5mRVdk?=
 =?utf-8?B?a0NUNmU1TSsycDZldExUanlVRjQyY2xpSCtQTlBpQlo1V0NBLy9hejlQKytE?=
 =?utf-8?B?Y2hDbEVQZlRRL21rcTBOWnhRZGxFQ3NaWHlOU3NDU3FFb0VqVlBVZkYvdUUv?=
 =?utf-8?B?N1VYaitmcDVPTmlhUGowbnVXd3dwUGdTekF1MzZQK1ZyS2NFcXRNUURwQTZZ?=
 =?utf-8?B?aGowRmlYTVNzY05OVEZQcnJOaW5sVU83VWJsS0x5NURmWmc0MkMxYXRGZENp?=
 =?utf-8?B?bGErYVFTT2xYNThhSlpZNlRkNW1GU2dKY2JnMk1wYlVKcFEzKzN1akd5ZFJQ?=
 =?utf-8?B?SlpzazlCOUk1Z2tVV2p3RkRiRUtrMkJwODJ2RHNUdnlXclRWaTdWR1NaMjc5?=
 =?utf-8?B?WEpyYnZ6QVhWdHRoUUhZYm51MjN6bHN5a2tVS0craW9yR1Zva25sVEJtTkhL?=
 =?utf-8?B?aXNCNmMxK0pTbUJleGd5SWNmY1pWcWhIZjBvVDNyTms4TzRJQTBVMCs3eTVY?=
 =?utf-8?B?aHJPNmVTN0xBanJyTXVXQVM1aWhBWE1wNU1iZWVsU0dBS0hDQUtpWDYrem51?=
 =?utf-8?B?bWQ5YkJtMHBBcXQwSkhoNTl3OEhiVms5UmowUUhpWSs5dzNpdzFhSEpvYWgx?=
 =?utf-8?B?V0ZUdmFjZFlGaVFxbVN2UjNCNTBoUXBac09ubDBGRmRsUEFsY0h0VUpNVy9X?=
 =?utf-8?B?MDlUb25JdWI2ZGlxTFBaTDJNRnFHd0FLa2ZBUW1qejRBSWRMeW9rN0xKN3hX?=
 =?utf-8?Q?X8DCscjsN35niQ4v8uJOEajFo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ee96fa-6584-46ec-1b93-08dc05d9b331
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 06:12:55.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d01g+kFzjRjZLFHVDIajPMOIklnwXCZQXnQhZYwmm7/IT02SJd3Z1gswHaJ03eVGMdxTMYLO8XhYn7+L+WsPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-OriginatorOrg: intel.com



On 2023/12/26 12:13, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, December 26, 2023 12:03 PM
>>
>> On 2023/12/22 12:23, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Thursday, December 21, 2023 11:40 PM
>>>>
>>>> +	fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
>>>> +	if (fault) {
>>>> +		if (fsts)
>>>> +			*fsts |= fault;
>>>
>>> do we expect the fault to be accumulated? otherwise it's clearer to
>>> just do direct assignment instead of asking for the caller to clear
>>> the variable before invocation.
>>
>> not quite get. do you mean the fault should not be cleared in the caller
>> side?
>>
> 
> I meant:
> 
> 	if (fsts)
> 		*fsts = fault;
> 
> unless there is a reason to *OR* the original value.

I guess no such a reason. :) let me modify it.

-- 
Regards,
Yi Liu

