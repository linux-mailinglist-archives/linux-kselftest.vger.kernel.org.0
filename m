Return-Path: <linux-kselftest+bounces-238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C37EEC3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 07:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D9A1C2074B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 06:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C03D519;
	Fri, 17 Nov 2023 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzdT5X3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB2D49;
	Thu, 16 Nov 2023 22:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700202493; x=1731738493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AGe/1d0mh0xdnnYVemmqURS7GoVo7s+rwwY99qi9qaM=;
  b=lzdT5X3styau/8cA8K1YQhL30xcTuu41g57bghsOKqGr0Y609S8yEVHr
   dbT1IvGi0cKF9nfkuX+gvNNhNRhbeODX+OG4jnw5Tg0Xenpzcv60jsbKz
   /54QK2bCWgoLmcwPZybYmuj+CCy0dpDtmcgLfGZXYADy83xsLDpDad89/
   12gMrBwyvLmx9CcZg7sSxpvkeTRyctAXUrPQWVnemnPsVUfHHwNmSnafm
   5vyU0ttW1aLYmgYqVyvTMOwdsIE74fonpT6zZCfqfNamXff1qDQVmu5ot
   Xo1KNXvV0UYeLfdd+0fiE0/B+ddbj3VMcOl0Nk8cw7CjjBT1Zxf7J0v0B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4327176"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4327176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 22:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="856246814"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="856246814"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 22:28:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 22:28:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 22:28:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 22:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ+i/unfv4VtcFquY7mH8HK77zVg9CLrVMlSuVu5/JXek8uED7tzNnvL3qFykgzoloe/RdCKO/texJH0Upokh5dL6AKJKeVx+6Wi7tqDpHxXTMAy3IjvAiPytlVmMLV4EM7tWU2LuM93VmwUyXWyv+YNpKmfkfF2QtLt5XvItkEmsweTHYsIpCKaj2tiEo7CIArmmMH7RR62NE3fauj3/P2Nx/IT7LxyHMiuzXFudsEF8zJikr1A2FAvW+mWZA1cBedbuD+cRLfzf0ST+trR3U0n1Jl4iPdtOh0nNIAwMaz0teRRK0F7DHjI4E6BTKPFLExYPyuidP8EFMZuQ4NvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMOzS6KxEkO6Uw4EE+ClVrhoCOj8qS3eUBafvKRbauc=;
 b=CLD81ZwRdlwkyKauEmVWHuI1wDomDYML+PKLwVY4KsKIGZ4CtIz1lEspZBQ/2WOawyq+reIyftS+/Tr0WzX22GIG9MTJEIhGLXX2BIm4NRMhK35mHV6triPheYB6tCnIIJvXhX9LP2qMtiLZBSo0PKGOY2DeiQ4NA+rVgZDkOft5iAJKZ33FguH/PNo/kKK2TG8vCowGHCMI+YQltOTMTNPdFLtVbTGG70K9bRKBkMPHUunoyNCPuESrZjnroLEVzAYy8CCSpl3POqqxJiKd5LBjwh7Il4CcaohydcH6o1fHj5Qcg+izeNIw+rcCX+pGzbnJx/B3jJZul75bc86niw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Fri, 17 Nov
 2023 06:28:07 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7002.015; Fri, 17 Nov 2023
 06:28:07 +0000
Message-ID: <b8f6d4be-8aeb-4372-927e-9820f0dd3323@intel.com>
Date: Fri, 17 Nov 2023 14:30:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Content-Language: en-US
To: "Cao, Yahui" <yahui.cao@intel.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>
CC: <cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-8-yi.l.liu@intel.com>
 <99115148-d0e3-4920-aed6-669ae45aa2fe@intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <99115148-d0e3-4920-aed6-669ae45aa2fe@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 11372f20-e679-4914-4cf7-08dbe7365c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOGzlwVgrd5R3VRlaUGaQEauh5g6QGFXaMe/5YbuJuWJP8d3EzR6u540f3w15+F8DCg44K/LwrldFM5Xw1Zj4Z0CqFPPUsSAPDxqVOerBf4Qk1xUhG27znjYc8M9kxCSegckNA8+gZJSk4btAVbvVsm3XWE7NQ0CI479lBUbT9N8YBg7DRRUfPARENU1y/tU2b8WGh/zZUMHuydXyM2mLaxAz4nz1ohGW0Mzr2p3fDXeHLtsREkS4IUt/Ec1sRcAkup4P7J2+n3dvnsO9wsDKcyNLotqyZ87th3iSD+zWqbV//VzHH5nkw19cHfkopb/WKBCAXzH6mUsOzGTLm5CVtCN3ygQMS4Fu6ukCbxDMKwnRGdeimiIrEoq+hvnyEHxv2FWeszkB03La1Wa4nd6i+axHg4Zbw0Nhd6WwFl9cR6WcBxCvUZ1714X+BtArawIxgDgQo4p04p9pqPAY1VkI29OGmTpVQc63F5akK4RNWOQjgX4CboyuC2chAIqODTBA+E6vukS6QgNJvh6q7B6NBGTr6MkN4zEGlI+mCPKTB/2c+jY7OcUCWG6ZrGvaQD4yptApseG+D0ojre5cmaciHmEzlynIoA3MlTCPMd6pY6z3chI2qtSbF2b7yRIomFOnJWprobWf2afREIp/9rCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(2906002)(478600001)(53546011)(6512007)(6506007)(31696002)(2616005)(6666004)(86362001)(5660300002)(7416002)(316002)(66556008)(66476007)(66946007)(4326008)(8676002)(38100700002)(8936002)(41300700001)(26005)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UncvUjZURkkyaHdNa0xKOStOTUJ2L0NKUnRzNkwxbDl0a3psaW9YM1BZYkRn?=
 =?utf-8?B?VCs2RUJhZHBaWmpmUjZ4azBUMkx6YWFMNktBclo2VmQ5RUVnYjlIOEF3TGha?=
 =?utf-8?B?ZWUyRkovZkk5c3ZqZm5CbEVaYU1HRDFmQlFsM2g0Z1RXTzZOVUpocEc5cThT?=
 =?utf-8?B?eDI5SEdPRlZ2aFVJNlhCMFUwS2hwSjEyNXpIZlBTSjY5dldBWEVUdEdTaWMz?=
 =?utf-8?B?ekFsTlF6elBlM2UvZGVQTThBclpZdFArWHVmczUyQjJ2blliY3hrdU5OWjRV?=
 =?utf-8?B?M3ZWZ2hwUjhCN01BVjAyanRDQmpISFVnOGRXYnRWU1RIV1o3QUlSNVh2NGd6?=
 =?utf-8?B?cDgveFZ6K2d3RENoaWw2VUlObjdrQjhlYUdXTFhWbDRIbURmNm9hNHVjY2dX?=
 =?utf-8?B?SDgvZXZwVWVYOWE5b3ZFSHUrQUxKT2hZNngvcXJDQUVsNzNnQTkrTG55b29r?=
 =?utf-8?B?bVdWeVJkeGU1QkdHYjd1TDNpdGJIYkpmeXRKSnZQSUttNHREcHlhS243MWxO?=
 =?utf-8?B?dVM4Q1J5S1U0UWw4SmZPa0dMZXYzSW5qS29kVEd5WHliOENicFZQK3R0eGg4?=
 =?utf-8?B?eHdaamhNZkkrMkFVMVpWTVRjTGtrNTg1blRPc3Y1YUhJQmZPK3J6S21CN1RG?=
 =?utf-8?B?Z0toQ1Npb1hLV1ZkbmNDUERHbmtWeXVHTytBbWFsZGVZeERpNC9UeEFEY0ts?=
 =?utf-8?B?UWdNd3ZaN01uWkJMd25WQy9ZYnRvMmJOMm9SOU5PdUZ1bk1qTlhRbE01amph?=
 =?utf-8?B?K3RkOXVncVBGWWVoUzdpSGFNZTVNSDZQWTc4QktRV0dXc203S1o4cjJHUEls?=
 =?utf-8?B?UVF6ZFY3YUc5czlSS0xKWGVGZEo0cFo1a0Fac3BkRUt1c2RqUE5JV1VwRCtQ?=
 =?utf-8?B?c3E0S2V4cEV6V1JKbVlBSldZRFhvK01HVThwbW9IUHBubk5lby9DaDM3dVda?=
 =?utf-8?B?THJRUjZTZytFTkZ6VFEzM1p3ZE1EUVBwRjdUb3RUcWQzY3AxUUFPaG0wUXhE?=
 =?utf-8?B?L2tVMGVaN2txNXM4SWl6Tm5WYTNDQllJSEpIQ0NwY0dhWVgyZktzeHZGblYx?=
 =?utf-8?B?TGFGNU1aam1TTFpMa1FrRU15aUdLNDllSFN3UWF4Qmk3TmRoL2c5d0t4MkhP?=
 =?utf-8?B?RnF6cFZ5NmtoMVNLd2RJZmE2UDZDQmJZN0ZYYXQ0UVNTcVI5aDRudGhLN2Ry?=
 =?utf-8?B?dU93UituZWFudmZqMEI3bXlmeUQrQmh2NElzQ0luTWNJb2c5dXVHOHBtSElK?=
 =?utf-8?B?KzY3WWZJbEJHMTNFNUUzaTRFUGcyU1VHYmN3Si9aY2dRcHJLZGNoYlN5dXZ3?=
 =?utf-8?B?MlZkd2l6d3k2ZEE1WXdJeVJEUm9MSHg1K2QxeEhUYmViZ25kVlBuV0lNQlFC?=
 =?utf-8?B?UXY2SkhrcHZYQS8zNjR5NmZoaFdzbmhMTHlzZUxpOTJ3YmJYWDVWQnN2R29z?=
 =?utf-8?B?ajV1b2t4M1MzNDZQNFlLZEx4SzF3WTlXMi9UeThJcHNScDlwTEN1RktwYjVR?=
 =?utf-8?B?S1hYc2FzTE9rMlN3WU9pVVNYMU1Ea2NBelhIL2x3RnFuWHFFV0plL2lla2c3?=
 =?utf-8?B?QlNiM1I4Zlc3Tk5NQktkQmxhRkVHeGlpK252R0k1LzBMUGY4WDh4Yi9JTkZS?=
 =?utf-8?B?d2x3YnhPcWMrbXdRSjNTWStOM1ArS05wOEJNZzlDTk9zcnBoK3BPc1NkYjJS?=
 =?utf-8?B?dm55MXJaN1dHMU1iYVpydWVDMDVjbHJUNXVEREpBdjdXNHZDMUI5c0tNU1ZG?=
 =?utf-8?B?TzFhbVdyeTdJVGovKzRkdlQ0OUVrWFJsUEsxODlQdVc3ZEVHOFNaOUJ6a2t3?=
 =?utf-8?B?KzQ1RkVUTWZ6NDl3dWVaZm5FelBJbVFBcDYvYzBnUUJmL29YckI1Mk1CbUxl?=
 =?utf-8?B?ME1aSjB2dEh3R1B0b2dHWDh0VEdnN0txanRvMUNMM290Rng4Q0hYelJ4Y25w?=
 =?utf-8?B?cDJMcVpWUHVFb2hselNvQjIrVWg1S0N2YjhIK2cwVmliWndKSmZ6RVFwTWRm?=
 =?utf-8?B?dFEyUEdiTDBnL2RXdG1mT2l6T3d6K29sVWFPMlB6dXlIY0grM1NLSS9nSG1S?=
 =?utf-8?B?dXM5dldPNXE0Z09saUlieFpZMHJHUk5hSTd1SmoxMWFaMWI0ckc1cWs2cVVT?=
 =?utf-8?Q?09wyVunH48p7P9MblFdtQMoWv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11372f20-e679-4914-4cf7-08dbe7365c69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 06:28:07.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsny34yyW/1x+BKnvMpG5jGxnHz38lB5NitbC/DNKDAMXXG2QiaT3vnPSCN/CP71PFfU4wi8H0fuHk5/ozHPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com

On 2023/11/16 13:12, Cao, Yahui wrote:
> 
> On 10/9/2023 4:51 PM, Yi Liu wrote:
>> From: Kevin Tian<kevin.tian@intel.com>
>>
>> This adds vfio_register_pasid_iommu_dev() for device driver to register
>> virtual devices which are isolated per PASID in physical IOMMU. The major
>> usage is for the SIOV devices which allows device driver to tag the DMAs
>> out of virtual devices within it with different PASIDs.
>>
>> For a given vfio device, VFIO core creates both group user interface and
>> device user interface (device cdev) if configured. However, for the virtual
>> devices backed by PASID of the device, VFIO core shall only create device
>> user interface as there is no plan to support such devices in the legacy
>> vfio_iommu drivers which is a must if creating group user interface for
>> such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
>> the device driver to register PASID virtual devices, and provides a wrapper
>> API for it. In particular no iommu group (neither fake group or real group)
>> exists per PASID, hence no group interface for this type.
>>
>> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/vfio/group.c     | 18 ++++++++++++++++++
>>   drivers/vfio/vfio.h      |  8 ++++++++
>>   drivers/vfio/vfio_main.c | 10 ++++++++++
>>   include/linux/vfio.h     |  1 +
>>   4 files changed, 37 insertions(+)
>>
>> ...
>> ...
>> +/*
>> + * Register a virtual device with IOMMU pasid protection. The user of
>> + * this device can trigger DMA as long as all of its outgoing DMAs are
>> + * always tagged with a pasid.
>> + */
>> +int vfio_register_pasid_iommu_dev(struct vfio_device *device)
>> +{
>> +    return __vfio_register_dev(device, VFIO_PASID_IOMMU);
>> +}
>> +
> 
> 
> Missing symbol export here.
> 
fixed.

-- 
Regards,
Yi Liu

