Return-Path: <linux-kselftest+bounces-2514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4D81FD3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C0AB20E36
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72D23A1;
	Fri, 29 Dec 2023 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEPk5Nbb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546B8BF6;
	Fri, 29 Dec 2023 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703831681; x=1735367681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a8s0a3xrlqR9Iq86F6A166ndYeSwZlA59BkkfAsv/Ws=;
  b=JEPk5NbbMbIwRzzx5m/z8cXdcN2CJvs25wzJjfgkgAu1woQyPPwtxZtx
   h5z2+1ri1w+AdDlcdVlPCkFDudCQuz04k689Hc5yl6ZnDBlgK+4LJSlyn
   B4FNq6/rWTxLa3rP1fe1VaIg8CR7ifCE+kAgYBNFt+ibladDJL1pGR3Oq
   nCxpM1yGrfxF8fRbXLQ9y+eKtGu7FWoDPtlrB4PjEo4bh8app999iXNfp
   Xw+6iKnpDPVpuOTr5nkbQJfwGlzJjH3ZTBw+RRUZUj3R1hENcHyElSOsx
   UcKveeNGhExyhTmuhLYHrWgJXeXqvnZSk786WWp1sLG34J4wj3IgW55Ao
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="463037401"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="463037401"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 22:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="1110095783"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="1110095783"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 22:34:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 22:34:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 22:34:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 22:34:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 22:34:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8OvzUWmDNOtQB8O9gjh+xtCKgQt/jJ7JCRx9pdomSFJMC6Ze7+sSdr8KyWKna/LeG67MMeBz7nvLrIyayNY7xJqSyCrZVZUL3QvPE0UXhyjVv5x4P0SisFup0SyYvE6MzOiG5mK7EtQKIyBDReOcUcVhLYulv+8yTjwShiVWEH8bWbPOlvoHbspyBJNrVBJsdTvK5GBAWKsataPsJgFU3Uqg6/ruBaMllooDLEUHuW6eyOq1Z757fbsu6Kkax5ri1kv8N4egqMgzbPBeteMpdUxQ8n4D3cJT6Bt/QvOB4ux7JzeeTVgguH2MbtFlVwPKfkSUmG5lrJXwdAseHzqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RdYaeTFrF/67KEig6vOB89aUJANYaeJHqW+nVNDdgs=;
 b=jCwscj5tw1aVI3dUfqg9mQcFJKiMK7ro1ZOG+ja3za4uqt2wBxV5opwPlm9KNyTddkSFXo+nG0tK4JGB00/VLW4xjoH0IckxYD1lWExSdoG8MR7xq9DTvJVLan/v1cSLV3BE3Kr2R6TmgGhFngKnfRAkH/HzmrREo/5xR75+2XNMOE6h2xj+syIHatD9sZqLgljXtT1ed5UuA12bIYWpYGkhPLKPAotQ/dn1f+ypBrme1Vr/O/82X9Y5JU2Qutg7evL2QJ4MhX836YL381qP9LgtM1T+m2peRDZRpsY/Vepd8RlVyFX0JU9xi3wTvxHbALz01uCvbj0RAUPSSYsHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 06:34:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Fri, 29 Dec 2023
 06:34:27 +0000
Message-ID: <fb1f6514-7e5e-4b42-b37c-c107f0277671@intel.com>
Date: Fri, 29 Dec 2023 14:37:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
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
References: <20231228150629.13149-1-yi.l.liu@intel.com>
 <20231228150629.13149-8-yi.l.liu@intel.com>
 <BN9PR11MB52768F21FE29A81060ACA4AE8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52768F21FE29A81060ACA4AE8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a6b37-88f1-427b-58af-08dc08383462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKlTTkrMAEJzBpXEuyBZNSlEDhYOtV0g/+ineN1WFQyVhGoCdmiVkosv2XWcXcC/wpE4hw0fyv1E6+wYeqRMPq6d3iQo+W7KU81OslJhAcijfKVm8ei715M5rbjJRzmiTPPGpazRD16/6gaKGfSKfhRAKfqZQVwiq8U78RTWELoxV24uJ/2L+lQVLRcWCBYWly4kZEcJkFARuH/15VSmKpj4wvt5NAN0oo91phQnC6++3rGAR4H0dqBZMbuGXnU+Q+5WwFj2Zg238vtA4SDGjzBuk94694xTbmfVP3ZQqwS75nerw1LV9YFChVQW8Ws5F3qDd9A8WLdV0tV7kDbCYKfL03G6YJBsVA8ziA1LBQ8/rSpmqGxLf41GTe8WRY976WW/Y7r7XGOZCVXDhRKvsbKGRMIiq+2Rtkg2jl0FTiocNMLRPKxjxhH79u42D24cy8CUKefbSUTTbV1oLlKeuqpozmFR4Vd5pN1URUCNF2cD9n4x8OaKCzNe7Q8qRT88mBt67MwsSqi8cOvyFzqk7d36ripM6fWyCg6qE4Tru4EkZAIDkMBTR0ms4CLb3WM7kJLmdInQedw342SWqYy0stl7R5AVPfxaa4jH14BhuzyM1lzP6z6t+hV8Ed4hWnmutIWutPo9hgtWNThAby5yTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(38100700002)(41300700001)(54906003)(31686004)(6486002)(110136005)(36756003)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(86362001)(2616005)(4326008)(26005)(31696002)(2906002)(6666004)(6506007)(6512007)(53546011)(5660300002)(478600001)(966005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkg3YVpuK1BmZlc4K2QzYTdjSmJpUzdFb0JHN05DTE9GTjVDNkdWbWFuaEhD?=
 =?utf-8?B?cFVWKzBOcHBzNCsySG9TbC9wL1ZLZE5HVjBSczBXVkFRaUlFOWV1cXQvTENH?=
 =?utf-8?B?em9jZ1dFRjhLMTNzN2ErMnBEdGUwSy9xeXptT3ZGcTFoVHh6aitLOHJKWFlS?=
 =?utf-8?B?OEdTUUlzMEtiU013RTlYOUNJSlBCWmFSRCtHODJuZlh4L0NUV0RoTjJCa2lv?=
 =?utf-8?B?blZFc2NQV0hPZkgyYzFwYktUa0xmaVluclJDb29UNWZrdW5XcHc4Mi8vU0ZD?=
 =?utf-8?B?amtJZ1dsUWZxcnV6djc2eXlsMnBjcGtiMHdXUWNYeTlKUE8xZGFpR1NhNGtY?=
 =?utf-8?B?WVEvVVB3aEhZZ0VROUdPSFdFWGVxZEp6NHJqME1MMHArQURpc09aakZ0RzZD?=
 =?utf-8?B?bTVtaHdBRkxBSGIrQ045YXN0dHlJTHB3eUF2OGRWSVVVVXk5QnVJYW93K0pU?=
 =?utf-8?B?N21PWkVRdGx5TWRQZVNMZ0VZV0dBZXdHTWM5clQ0dU9MR3hncWs0bGN3Y1pT?=
 =?utf-8?B?eU0vaHM1MnlpVEJSaWN3czIxdENPUUJud0ptdTZOM29TUDlWRGpjajI2Ky81?=
 =?utf-8?B?ZlRWaXVTS3lPQmFkblg5aldOay9KR2d1N1lHeE5EVW9qS2NSVUtHa2p4S1M0?=
 =?utf-8?B?VXRVblVJSk1kUGZoWWFtc0ZkemVKYVZzdVU5U3kvTlNRbEU0eWZSNmxNalRP?=
 =?utf-8?B?SU9IcFQ1S3ZNUXF2V1JFZHJ5Tk1OMUZXWjRWUElQb3BsUWtwQmQ4VXI2QzdN?=
 =?utf-8?B?eHgvc0t1S1BxdTNkL0ZCMjVkRlY3S3dVejRFb2ROSWEvMktGWkpreWk3eEhY?=
 =?utf-8?B?QWowZDcvMThVUTVibFNsQXVlWW9lajhWMnpySmltb3QvUnNhL09zV2tpNFNp?=
 =?utf-8?B?ZHZjN0pRRWJKS2dzSml1ZkdtUWlGWmhVVXZCdnNiWUlhMHZ4T3BTS3dTN2ps?=
 =?utf-8?B?WWhxV2ZaNytxRkFLR2Y0YjBEVlRDWGdIZ01nQldOMXZuak43SXRpaU11a0RL?=
 =?utf-8?B?aDVoV3lMTndwaW5vQjN5QkpaYVdNalBEYlBrOFMvNWwvZ1ZBSDYrRitDejdQ?=
 =?utf-8?B?dnljTDA4T0lBaUVVdzB4TXJWL0RYTUo2aXlLZkkwaVNQL2g5RHNidjFtWktK?=
 =?utf-8?B?c2Z4dStmc1MxRmJvRGIydWhVb0theHRaM1BVb1N0T0xNenVrR0NuTnNQK3lq?=
 =?utf-8?B?ckZJV1NkVXlWaXo1VmNoS2Rjb0ZjV25OQSs2UUVkVE8vM2g3M2cwdUwxUUJz?=
 =?utf-8?B?TmNGODFEb3pRWVFHSWlrRkl0V0JlRVg5ZytaOVVWTnFaT1lLdzY5NU1hOEYv?=
 =?utf-8?B?SmFBT3RmRXJMTGpGZktTYU5SY0pvU0ppSU41UE0vcVpPUHIrQ2MrNjFDUFFw?=
 =?utf-8?B?NHJvMmZ2L3JzQnBkQXJpSXVjZHR2UzFCK2o1NjZoeUI1UUdBb3JkZmFkdGhB?=
 =?utf-8?B?MktyanlWRGI3NXRRa0hCWUh2WUhnaE0yNEhwTyt4L1YyeXA3dFVMUnF0TWZQ?=
 =?utf-8?B?eVZya094d1pZd2dqVFBhUS9vZmphejE4NzZ5dTYxMG4zaWVFVWtpcDBtWW95?=
 =?utf-8?B?cU54Qi9Qd3YrYzZla05NZW1wb3dnOCtXRHRiY3c0KzZ5V2p0c29qenFiU1F3?=
 =?utf-8?B?WUtMZ3dVbDFUTXRwWW0zQk82cFZOcGF3MGxiZnZYQmNadDVpSDZiZEs5ZWli?=
 =?utf-8?B?YkN4eU4xZENtL2FzTXJIUHFEWkxJUFVtb3JqVVFaSU42UFBHcWptV0pLcHE0?=
 =?utf-8?B?S0E2MGlkbmFoSlJvR0pyU2dBYlRNdFVtVTJGV1ltWDl4d0RnUUVFOEszVUNr?=
 =?utf-8?B?ZHRndUpoenJNZHZDZzg4SVZ3TTdyb0o1cWJDOG44S21CMkdZcEthYzhLWVZ3?=
 =?utf-8?B?bkVmOUtnRFhFTlZ5eGdHSTZVNVFlZHNhTUpMQUdXZkhnYmN0ZElDN1JvbVdk?=
 =?utf-8?B?d282cWlPb2JWZkFCZjRtbU1pN09pMXJ1OEx1S2hxVStoWHJ2TW9CZUV5NmZS?=
 =?utf-8?B?c3lXSHJldzI4M01rUXVKTXlLbFFlSHVSUVVKeUVWTXZmUWgxbjNyamdsanRN?=
 =?utf-8?B?bkRLV0gxaTFacGYwM2pOUmpTOXFjaDRFZ0JTd2ZsMHh6Rk5OWEJmNm45blda?=
 =?utf-8?Q?7DufYGnjN7Jt8YZV/JpuJaBcy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a6b37-88f1-427b-58af-08dc08383462
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 06:34:27.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtMdurQZw6DDBdGLhp+h6hgpMf9P52nimXF1R/r0hEf/aliDWgzlYkIm0nFwOc5XpcjPBZlUj39C8XF8vDYD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

On 2023/12/29 10:52, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 28, 2023 11:06 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> This allows qi_submit_sync() to return back faults to callers.
> 
> this might be useful to add a note that the retry logic itself is being discussed
> in a separate thread [1]. Here we keep it intact and just make sure no retry for
> the newly added user domain cache invalidation.
> 
> [1] https://lore.kernel.org/all/20231228001646.587653-6-haifeng.zhao@linux.intel.com/
> 
>>
>> -		if (qi->desc_status[wait_index] == QI_ABORT)
>> +		if (qi->desc_status[wait_index] == QI_ABORT) {
>> +			/*
>> +			 * If the caller is interested in the error, no need
>> +			 * to retry, just return the time out error to the
>> +			 * caller.
>> +			 */
>> +			if (fsts)
>> +				return -ETIMEDOUT;
>> +		}
>>   			return -EAGAIN;
> 
> indent should be adjusted and it changes the original logic which returns
> -EAGAIN only if QI_ABORT is set for the wait_index.

oops. this is a mistake. :) '}' should be after 'return -EAGAIN'

> the simpler form is:
> 
> 		/* No need to retry if the caller is interested in the timeout error */
> 		if (qi->desc_status[wait_index] == QI_ABORT)
> 			return fsts ? -ETIMEDOUT : -EAGAIN;
> 
> otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

sure.

-- 
Regards,
Yi Liu

