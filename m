Return-Path: <linux-kselftest+bounces-398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C07F3C9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 04:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4FB280EEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE78F4D;
	Wed, 22 Nov 2023 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwdhR/lL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9DB90;
	Tue, 21 Nov 2023 19:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700625014; x=1732161014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kxsDZzowGJBBS4I9xfFkXhposLbs3qWR5LFefIg5Lto=;
  b=MwdhR/lLFes2lnJAzJD8Bn549u/Nlf51Wv7UkCGZRrrtOat1/VtGLXNQ
   Fi65TvZAWHhJ22Zt1DhCJf5sRL8gOnHXtauEX5h8/wYpNFOroMdGV1ey6
   F/FpdCy+VLND+obBoius4gC5K80Gek7tyJN3eV7IkI22EgIWmHod3NSxV
   Q9vY4jiU+8tfbm7N4RyFWjUwWYDHLZerpwKG5yiF6fbxsfb02SJ0/erTD
   6epploYDS77RcZ5XzvHXBrWXUQQf7kMzgPmS0bBj9Zs1US/0oS21yAXvq
   omEf/FFvaU7J2uh4lVRQ/a40RZHvcizck73MePe5Bm4WeUyofs9fHB5Te
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13525319"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="13525319"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837253168"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="837253168"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 19:50:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:50:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 19:50:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 19:50:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUgNagnDmAueIHdidpsYwPyb276Xml1Vgt7d2vsk9dmBHP6vUYsdrhwgobsjaUI4Zv/gBde/3difCWPp+Kx+Dkg6yMyTiDYsyImj1LJN6fmGxG1U5/+xOzsP6UFuR0igHRZGOayXwHEZF2DDtcgoLh2ixI4oAbrX5HL+bLKJd5hvP62c6Myyzecx1FhsdbZiiuL11GMTdw10zd/u01iDzmEZuo4NnsEZGkDF9ZBLUkIz9l84D2pVIdM7Liu9i66cQ2007LS7xiFeCDlCTwnqja+zHvICFD3ksiuZHkZH+O4/7lRN37IvKTsM1mJtZJbi6JkvL8p48Z7UmRMzTgdlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PUFrLBoNHjM483AVKLDaGw6yd8csTPx1WXYs6wMmLg=;
 b=ZeKnJj1nVYtnKMrImWwaexIz0OnXvRjTdt3zbdaFnkZR4efJthJs1xIJFoxkUK1dlsE58aHAs11aYii6b8dRg4eCzA5b2CrUylUvVUDoCDcQQGNiAkXY3It48bcNFkrOJsIvTFMCY+pOvus5V2sO8r7gL4NuUIfVl+DEiV+sMwlRQ+2cAuNRGOczc+lfAoXrWoyTp29+qXIprKLYSVo6DpKcgjP/K636nZFq9WZl4cGld6tsnnFs/xpdISgZDl7Zaa82r41hTnr9Ndv1k/f2xAcIwISCs9+zcK1PIMk1QSZW0cZQ0kMjs1Pq0gFBHuZiw5IoYJRcmfN9tNjla4h9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:50:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 03:50:09 +0000
Message-ID: <48391b05-ecbb-4053-bed5-2740806ff06e@intel.com>
Date: Wed, 22 Nov 2023 11:52:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
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
	<yan.y.zhao@intel.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
 <f5b27724-7c86-4823-ae86-76c92a2760b4@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <f5b27724-7c86-4823-ae86-76c92a2760b4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: a847ad89-e270-4c4f-77bc-08dbeb0e1eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLQ1Jt6ioyyzYOnjds0h+Lplzoq+yZJmlhbh6aEdqp7qWLDJasRU+mJht78TtYeiLD0tDeXcFeeUXxCQFcn0IRZFtqwt+bT4jKPbCheUJpxGK+7LvzBaxTb1UiKtr1HxDypsAK6jZsdiXhA/yhxrZbOSUOGcFYZcrJvZuloiskmaoOGNJ980esdoy8YNFdTgASw+25ieFadw6LRWgLnmusM+eshZgUCrmhjXKCIyp4qCGsrWjWe1biVdZt/EnJcuZYFYCBbkJYDuC8hy2dnRuRLOSsTVH1evCanQ2XLSd7eTbxjZs2sxZm61H1MmtPLRel7+eAVO2pJcSvBkKvXiz/JDj1QW8TgPv5ZxTdt7muMTN1/3gF21CA2VQNFFb3zcR6iESanND5pKQcGJrSFEkfCfEDIHROnwF7p9X4pOCjRb1Q34SQ5C7fs29kL67Dt69Iu42y1jhL5FB2JQHwnhYZK5zG4vlyNJ/ncCHijbJm4ktUjRv5FWZkSVgyha30qB8DtBtQlANg5pNhlqMwz3P90MN2TgGi4Stio+QDUOjtRusfrSsokP9PkzlQpP2N119I3ZjqOUL+dbTT3c7RTUCgksp+eBjhHbpkRYTup3KR748qwYqFvwe200yYDpy3lfdXfqUHQf0Pd7N+eVGxmqWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(5660300002)(26005)(4326008)(6506007)(53546011)(8936002)(8676002)(6512007)(83380400001)(2906002)(66946007)(66476007)(66556008)(110136005)(54906003)(6486002)(316002)(6636002)(6666004)(478600001)(31686004)(7416002)(38100700002)(41300700001)(36756003)(86362001)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdLaW02TGxORVZKak1TbTY3TG8xVjhDZHdLQ2p1eXpBallhMzU2VHZQT05y?=
 =?utf-8?B?STNDT2tmN0tOSTFBemttdDZxMUd2d3VUTWNMMWZtMmovMEJ0M0hRUVJaYnhS?=
 =?utf-8?B?WnR4T2pHU0QrQjR0clhDVWhKUHNBZDdqeWp2TEVDcjNBZ1dTT3lkY1hhb01G?=
 =?utf-8?B?a1cvbm01WlNIckRkRHBwc1hrUXViVUdKUnRmTkRMelFzdzNhWkViL3lUeWJa?=
 =?utf-8?B?YzYxbVZLTHdGL0p1NVFhYXhYaWVMQW1tNFUzaGdGajRYSHpSNlVEZk9kSnl2?=
 =?utf-8?B?eUZlbkpFeFlENEF0dXlreG1XQ2UvQmQrKzl2SnlydWR6dURJc2xRc1oycExw?=
 =?utf-8?B?QXRYbENKWlo1VG1QSVV1UVpvN01xUVE5WXBoM3ZlM3NCbElRR2krdytoUmtV?=
 =?utf-8?B?SGRqUVZnVWVmODhQd3k5OTliK0dIQ3RuTmZ0TnJ4WDIwTUVGZU1JbXBTWVhB?=
 =?utf-8?B?eTdYZ0tDNEFwZ0xVVHdxa1RWS3RRWVVmaitZQnk4Nlp3alk5MGVZaDV2MnhT?=
 =?utf-8?B?bStBVFlVVDJ0VDMxbHIzYi96Sk1lbnJQL3FRekZySUNiL1dVOGFVeXNlb1ZQ?=
 =?utf-8?B?aDBWYnNNYWtsZmV0bjZBcitNaHpLNGl0UHpyVkpkQ1RWencwSUdDV3g0d3Fp?=
 =?utf-8?B?TWRXTFBaOXl2bmlCTjFLOGFrbDVhOVlvREFUY214bHlyVTg4Sm00VzhEZjcw?=
 =?utf-8?B?K3NJc2R3L0R4SENWeDZDZnB4Zkx5QURTblJOdzBFUnBZSGJJUXRYR25mbDBB?=
 =?utf-8?B?VUljZ2VZK09kazVETUl2a2xnV1RkOGRBQVJ2ZEFreTFQcHlic01uSzFncXJD?=
 =?utf-8?B?Qkd0L0daWjNIbDVZWW5CL1JzQzZrU1ZlLzNNUThKTWdHRnZvaDdpNVdXREox?=
 =?utf-8?B?ZUE2bnNIQzdYOVBUU1c3NEcvaXlEeHlvS3F0VmhmamZCc3J6SHZuakR5dzFB?=
 =?utf-8?B?Vzd3MEZwejA2dmtsSnoySEt5cDhyRHZWMTVvVW9jZSthVUtqL3ZBUGZrSE94?=
 =?utf-8?B?TjVjZ3VxZDArV3REeUhrdXJLWGFZTVBXMGRzSjFpenhpL2tIR0VpdjdsU1pn?=
 =?utf-8?B?dmI4MDY5eGZIWHhmSmtTc2FTMW9oeXRqWVF3eThNbjJDWXY4T0NRdi8xU2xT?=
 =?utf-8?B?Z1J6Nkl3WE5HMk0wM0laOTYvMmdnZ1E3Um44aGVVcXRNUFM3ZkdRdzZ0NjBy?=
 =?utf-8?B?Z2R0TkZZanE4TEVvVUY5SlNIL0FEeFJ0elZROHVWcnppUnBURHR0Skd2RUZo?=
 =?utf-8?B?TkhZZkpMU0lmelNQSlAyRzJLK2lvT3NYR3ZZSysxUVJuOUE5cmgrdU14Qklw?=
 =?utf-8?B?cE9xLzlhNlVXaFQ1UWpaS04yTDI0MzhKRVhucU1GTDdwY0FoWE9zMGVOT3RN?=
 =?utf-8?B?UjNSOHFtbUVrZTk0WFhlWThDSWkyTUd0MnlvemIrblFtbzl5Q3J6czVnYU5j?=
 =?utf-8?B?L1dqVWFuZkdCM2c1Zjg3MXVDQ2k2ZDJ4Yk5FRW44MXBBYmNJbS9OTU40elA1?=
 =?utf-8?B?TWNZVnd5SU5KYjVCdGk2NnF3cjlvbzBXUWJ6M1c4clJjNDRrditnMW1YNlhU?=
 =?utf-8?B?SkxEcldFWmxQN3M0aW0rV0M5akpNNGgrN2tyZFhmMVR2VWlJVjdyNE5OTkZp?=
 =?utf-8?B?bHhJK2tlM25vc3VuT09IaXFaUzF3QjZwc2NnaTB2aHBORkxZTitrYW9JMk1X?=
 =?utf-8?B?M1RnSjJIdXd5a3pIQXF4Sjh2Vkk4ZmJOSG1scG9CNWtsUVFWajVKL2JTN0FW?=
 =?utf-8?B?anNIeVM5eWR6UC8xWWRGYmNKaFpTeUdxRk5zd0kySEZMdDRKaDNic1didU5T?=
 =?utf-8?B?WUNDMm5lUER4cW5nYi83bldwVmFNVXlrZHRJV3pwWmR2MEtIMFhybnd2ZERQ?=
 =?utf-8?B?ZThYUHBRTW1YS1lkT2NES25CdEJnTlY4cXlyL2owYXlqcDUwOUVIb1ZWNkZp?=
 =?utf-8?B?enBkWFFYT0RUd0duazJlVXlFOUt4Q3FyYVgwVEJaQ3B3MHRMZVJrNXR0OGJ0?=
 =?utf-8?B?TjFrSjlPc2x2Um9ydFdobkdkeGljdk5veWFmQnVOOEFnR0R4YVVTZ2NLV2k4?=
 =?utf-8?B?QnlsTXd1VWpPV0lxMnN1ZXFPVGNBaUhkNGZQdStKZmVmejkyd3lnK3RudS9H?=
 =?utf-8?Q?NosOhgIqyy11H8dTE8JrHWdPB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a847ad89-e270-4c4f-77bc-08dbeb0e1eff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:50:09.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w67BP3S9tLotKXCLJW9BweLmXJOeI01pYc+E/gKxNOLUpO1p71wGsasGtxSRHLikFW9mQGgRDskSTiivgc4Mww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com

On 2023/11/22 10:32, Baolu Lu wrote:
> On 11/21/23 8:17 PM, Jason Gunthorpe wrote:
>> On Tue, Nov 21, 2023 at 02:54:15AM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Tuesday, November 21, 2023 7:05 AM
>>>>
>>>> On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Sent: Friday, November 17, 2023 9:18 PM
>>>>>>
>>>>>> This adds the data structure for flushing iotlb for the nested domain
>>>>>> allocated with IOMMU_HWPT_DATA_VTD_S1 type.
>>>>>>
>>>>>> This only supports invalidating IOTLB, but no for device-TLB as 
>>>>>> device-TLB
>>>>>> invalidation will be covered automatically in the IOTLB invalidation 
>>>>>> if the
>>>>>> underlying IOMMU driver has enabled ATS for the affected device.
>>>>>
>>>>> "no for device-TLB" is misleading. Here just say that cache invalidation
>>>>> request applies to both IOTLB and device TLB (if ATS is enabled ...)
>>>>
>>>> I think we should forward the ATS invalidation from the guest too?
>>>> That is what ARM and AMD will have to do, can we keep them all
>>>> consistent?
>>>>
>>>> I understand Intel keeps track of enough stuff to know what the RIDs
>>>> are, but is it necessary to make it different?
>>>
>>> probably ask the other way. Now intel-iommu driver always flushes
>>> iotlb and device tlb together then is it necessary to separate them
>>> in uAPI for no good (except doubled syscalls)? :)
>>
>> I wish I knew more about Intel CC design to be able to answer that :|
>>
>> Doesn't the VM issue the ATC flush command regardless? How does it
>> know it has a working ATC but does not need to flush it?
>>
> 
> The Intel VT-d spec doesn't require the driver to flush iotlb and device
> tlb together.

Spec has below description. Although it does not say iotlb and device tlb
should be flushed together, but there is indeed requirement that both 
should be flushed when a page is unmapped.

Chapter 6.5.2.5:
"Since translation requests-without-PASID from a device may be serviced by 
hardware from the
IOTLB, software must always request IOTLB invalidation (iotlb_inv_dsc) 
before requesting
corresponding Device-TLB (dev_tlb_inv_dsc) invalidation."

> Therefore, the current approach of relying on caching mode
> to determine whether device TLB invalidation is necessary appears to be
> a performance optimization rather than an architectural requirement.
> 
> The vIOMMU driver assumes that it is running within a VM guest when
> caching mode is enabled. This assumption leads to an omission of device
> TLB invalidation, relying on the hypervisor to perform a combined flush
> of the IOLB and device TLB.

yes, this is what the current intel iommu driver does. However, whether
rely on caching mode or not is orthogonal with whether we need to uapis
here. I think guest iommu driver could submit both iotlb and device tlb
invalidation request. But Qemu could select if it needs to forward the
device tlb invalidation request to kernel if kernel iommu driver has
already covered the device tlb invalidation when get the request to
invalidate iotlb.

> While this optimization aims to reduce VMEXIT overhead, it introduces
> potential issues:
> 
> - When a Linux guest running on a hypervisor other than KVM/QEMU, the
>    assumption of combined IOLB and device TLB flushing by the hypervisor
>    may be incorrect, potentially leading to missed device TLB
>    invalidation.

Hmmm, this appears to be an intel iommu driver bug, it should submit both
iotlb invalidation and device tlb invalidation requests. But as above, I
think this is orthogonal here. KVM/QEMU could define its own uapi based on
the implementation to gain the best suit.

> 
> - The caching mode doesn't apply to first-stage translation. Therefore,
>    if the driver uses first-stage translation and still relies on caching
>    mode to determine device TLB invalidation, the optimization fails.

yes, caching mode does no apply to first-stage translation table. But in
nested translation, guest does not need to notify hypervisor when there is
page unmapped. is it? So whether caching mode applies to first-stage
translation table does not matter. TBH. I didn't see the problem due to
this reason. But I agree that linux guest intel iommu driver needs to
submit both iotlb and device tlb invalidation request to guarantee it can
work on other hypervisors. And there should be other way to do the
performance optimization.

> 
> A more reasonable optimization would be to allocate a bit in the iommu
> capability registers. The vIOMMU driver could then leverage this bit to
> determine whether it could eliminate a device invalidation request.

this may be something spec can be enhanced. But again it is just to make
guest intel iommu driver to gain performance optimization and also can
work on other hypervisors. As of this uapi design, considering it within
the linux ecosystem is enough.

-- 
Regards,
Yi Liu

