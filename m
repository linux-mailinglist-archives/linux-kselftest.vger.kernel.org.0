Return-Path: <linux-kselftest+bounces-2464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A481EF54
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 15:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE7E1C20BD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA074501B;
	Wed, 27 Dec 2023 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3TBp6rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F645010;
	Wed, 27 Dec 2023 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703686201; x=1735222201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aIO8+OYt/x20h6w7vp346Ec9mjnz+Bw+AWf6QrIm+w8=;
  b=c3TBp6rdCj4H98exjRbg7z1TXQbuKt8d9NsObeFK2G6tAYhLYDiKmwhQ
   SdXVA4WddALQ874ZaRb1EkYj2lKGuLuVOkPuR5oNvI6ZNOLKIwUjim4Hz
   JYM0RRbqxQuex12nLOwVqJtMEfAdnBUeJV15Q4HRi+FjJPIQ13np11Ruk
   eBjvMu+otmrVsr8HNk5w5tvXFzbBeuwgOPw9n1u36DOzi2tIKmfP7519f
   UyV5aJKk0vzn2P77iDeG5v7UMrqpoYicInb98in1W2LwCNyb03UPw/7LL
   ux3nifx/3hhsMi+I2QPvUwXc0mDU/0A//Wp1LMQR33P61Gv7VAgwlzEfJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="395336572"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="395336572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868866132"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="868866132"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 06:10:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 06:09:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 06:09:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 06:09:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTPTbJp0zk7iR7LFKBxgv/YzzH2+EWVOD9+W9qv0txuX1n9FiN/y1zUH0j9/9W/tu8aCmmBfawjXP/8WZ7+f9zftfuPfCwH4Xz3w2aI42GDnji8t1FeLJKxoBW9deTsOff+KO6gPhUjmMUW4RKSnRmR3QOA5HX3kaSpiStn2tVgsIlTwWfK73+4EX+4+ObqG6KdeC6Sf8uzjQ6mkzyadY/Hkxs/UUeOjWPAX6hTraVSsqOfPqV2pkQ5BJCudxu24Wod1zqTT+zODeE7mt4w5weoMu43vsLRJx+f2tiBc5zN0xd+RT1h3ZlAW/oPIa2AJeHCJOmLGObbCsb01sXtGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWfxsO5KU8xMCTWIt3x2OWbdKvrHf/8B+vvLCuOJDPU=;
 b=GHUQoRxxrFIc+xwEQj+HaWpnxcpHIw0mnBcapNqs6J0bMPT59MX2Gwgd/lyAIG+ghUDuKQen5+lmQe2bjQcq7cjJ+3H0tv1KlKNFIkdmvmkAkcojzkMpX/5wXMZV0jTBaybDFS52dQFjUW1D0uycVyAA13aUKR90w6h3LvFiPj0zKNxGQMmKPxCIpudAXUe0+XulmxTga93XtFeK8IbSiZNy3vIgPu4nZ/qTGaBOvJ3PhuizPdPTcpJ4xfgtrvQW4uT5/hcGKm/Amh1p13Z6OyHYP7z6mvt9xfaORn+sMnbQ33Bv8aBfb2d5YsRnqpD4NK7OUoVDIe4gPAgeljrugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6960.namprd11.prod.outlook.com (2603:10b6:303:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 14:09:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 14:09:53 +0000
Message-ID: <98226e62-90b8-44a6-9804-0356235ec34d@intel.com>
Date: Wed, 27 Dec 2023 22:12:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
 <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
 <SJ0PR11MB67444BD4606F7A4014801B16929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ccdace4d-73a2-41c4-aa15-2d7b54e1d30e@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ccdace4d-73a2-41c4-aa15-2d7b54e1d30e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 36096ef9-56ba-427d-870f-08dc06e57f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe92xZIyHkyMtbxVVxlB0EzuWSTT7nlxILvEI/1M+LvRSW1J/k938PSZqMpQqwy7MyJFDEkxGAD1iqQA86YLtpzsBAPjrMMVHIlqfd4XlvZDRT6LiBBsrHQTiSjSWn1yxDEHfHSE+ECcUP+14lph8H8wGio9Gtgr/YXBsvJORh40ZenghW06tOusibUyE3P32MmYs+5BQrW9jQzNH/WFMPy9LYlVtSTuzKej3mhtxF0EtALk1f6y9ZsOCOsWulm9um1uY686obmEKlXheaJocDVtOGNhhYSP+wuhSXXgdFatT5ath0ugZx5qgA52avWg+ZI5khmDf8WrRdBB9lrqGD9LnFDGGTI4ymOqBaVmisaRoksB05cTKBY+zyzY3fnQNcQ0P4+1eNSKMw1DbZu7PDvfrZpnDC2WXZ6HleweKCPV2wE56dhx08cRSafucsGMOGQbQ2MayrtkjMFCMoclHLXIe9Ed3csv3PcgUJteRYJmaxTKU4BRaaoJvkO8qsoLWW/XfDY/s4bb2J5Pggh08hsLLIFksDwSAEU8HCmWi32+sfq5kEceWNw/CzP9/fZEho2puhUHqyA6MCeCniG5ajFw1YaOOvjxoVVcsYlZVJtr2rEq/jqfVGBtWA/TJOZQwvZfLDMuGRTetGlT4UuoBybR6FAqx2Dm1EQWWzjiIDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(921011)(7416002)(2906002)(31686004)(5660300002)(82960400001)(38100700002)(86362001)(31696002)(4326008)(8676002)(41300700001)(316002)(8936002)(66556008)(66476007)(66946007)(54906003)(110136005)(83380400001)(36756003)(2616005)(26005)(6666004)(478600001)(6512007)(6506007)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVI3Uk1POElYYVBEWng3MjNoM3U4VDQzU3U2UkoySExmZWlwdGhzMUdvcXdP?=
 =?utf-8?B?MU40QSttQVFTTVdUMWp3Ym5laHZHT1IzUHE1cm5qc3NyREFwTGh5Y3NjQ1Zy?=
 =?utf-8?B?RlJ1WlhiMFdmSHRBYThqZkkzOFNPcFhXL2Q0S0NzMVFzbnBlcTh2MFhXOWla?=
 =?utf-8?B?cGU1MjFFTUlqUUJ6ZDVyREdmbno3RkZVMko2eFczWThTMFFxSHdEUWFYM08w?=
 =?utf-8?B?Q0xaaU1rZnVrWVRac0pJeGRPeUJ2Rzc3ekVrY3BZRGIwZ3lKV3UvUC81VG5w?=
 =?utf-8?B?MU1uaGROTFpJcEZNeEtyazdYTXRRVTRHbFZRejJpdGhpVXNZVWtjOVNjMVdS?=
 =?utf-8?B?U1ZBWlFubktQWFMrVml4Z0VpK1JEZlNKWW1sc0JKMjVTZkt1S3lCWUlFQzA4?=
 =?utf-8?B?aVZsY2tGWEJYVDZzM0RQYmZnQ2dsQmpXMW5NWnBld05UV09jQmNwOEhQdy94?=
 =?utf-8?B?N3o4NVkxUXNKRml0TTJ6Mm9kNlk5Y3JtY0xjVytycTVYc3M2c0g4bmR5SnBH?=
 =?utf-8?B?T2pTdk1uVGFkWnVsSnlyLytoekFxWHZPMlp5SXE0TXJSQ2tBMzZjWFl2UDZK?=
 =?utf-8?B?V3gvNW9wckVIZldXM1lOUXVQdFBiSGxhT2NOWGJtd29CUW1kcjlHQjhnR2dy?=
 =?utf-8?B?YzBKRkNrOWt1UDdnanRGMHB3N2lZanVWK3hKSDB1K1RVajF5aXkwNEJnbkcx?=
 =?utf-8?B?bk90YWU5TFQzMnh4RVhkUjVRd2hIZjdWdkFtTkQwS0pVWll0djRFSUFYZ3hN?=
 =?utf-8?B?NWxVcFdWTXlwRWxZOHAzWXlhYmhlZGNSVG5NRGZ0U21acWE2SEo4WEN2c3hE?=
 =?utf-8?B?SzE3MGo4TENjcVg4ODRtNzZhUUgyVUJqT3QwZm5Gb3FiSlFRaUg0WWg4ZkhN?=
 =?utf-8?B?RHVkeG9yTXdIUStXSW9qT2xsSmNPRGdqM1M4SFVHSjl0eHR4dUR4NWd1bGcz?=
 =?utf-8?B?ZnFCbkZjcmZZeWtRNEt3UmhXTTVVSWl2U25sUER3RzBydUVueHpLKys1U0N1?=
 =?utf-8?B?RTZvb1RMbmpseEtjeTRtQlBIMVZZTmloM1VJNXhJMjlzc3kwbXdoamJJdnM4?=
 =?utf-8?B?bXkxbkJkVkFwMHN0Tncrek4xYnBiLzByR0lLMll6ZzVSWUUvamJSTHhxZ1Vk?=
 =?utf-8?B?NVVwQjZJKzgrRGEyU1J6QmVnTnNaL2MrcUJuc3o0SWVaWUpZV0dEUDJBZWlu?=
 =?utf-8?B?WE11eGNvOXhKazZNanhNa1phVExKZ3I4Z0IxcHdJK0cvbG10bnZxRGpDaUlL?=
 =?utf-8?B?TVd0Y3BzcVUyYWdGaUtEcDNILzk4a3JlVmc5OXhJcHdqenRoa2F4VnhZU0VW?=
 =?utf-8?B?QzFFeVd1dUJBZEF1TCtMNVBGTFNUcVZRbEcwTEF6bzZpaFVuYm4wSnFpelJU?=
 =?utf-8?B?OVFLRkZTdGtQMHZTZDAxVWFka0RKbHdEcFFBTk90bVV6c3JaMVN4WHE1Q1oy?=
 =?utf-8?B?SGdlRnpIUk1iT2R2c0d6SG5XTkRNRkQrNFRDMitQMzN3dUZPSm5pYWVvZ2xF?=
 =?utf-8?B?RmtmaEI3cVVRVUlnQ01kUXBwNUt3enN5d3FyL1hKQnhVcCtqWXNJNUZKOE1F?=
 =?utf-8?B?VTRJeTlNRWNmUldOU0tmNG9XRkxPYnh0T2tNRTRISkpwKzYwUGducWN1NWF5?=
 =?utf-8?B?S3R4U0svZjQzTWZIeHprcEFxQVdpM3I2Rk9ndjBzT3N0T3Q4VjZWVUU4YXZF?=
 =?utf-8?B?UUV3ZWVNVHQyNkJoVlExSkZWZlRGYnlBRTRXMUlXR25PSUtSWGlmcW5QNFdK?=
 =?utf-8?B?VWE3c0ZiMjZsVEFwdTFDc3hsRWRtekZCWTB3cXZPTlp1MDJFY2hBdWFJVTJH?=
 =?utf-8?B?bjN1bERkWDJraFlNWEswWXhEUEdJTCt1NE9Ud0d2VE5FbXR4aEdhamp0dmJ6?=
 =?utf-8?B?R2haK21oWkRmRHFMNXRQblNnblZ1SWZYcHdlanQwT0ZHbmpzdS9qVEtITE1p?=
 =?utf-8?B?SE1Wa2hrWGhORnZob1VRNUlNd044QTJFUTk3Q0ZOR1lhZXlSSStTZk4zbndH?=
 =?utf-8?B?SGVKRUFUQ1Zob1NuY2Jld0dmTjJRMjZvUzJNWG9adE0vYUFIVmYrUEhvek5z?=
 =?utf-8?B?MndtRWwxMGVreVIxUzhFMCsxUTVrZnBYTWpNRGNuRHpHZG16akZCYjdXaW5S?=
 =?utf-8?Q?Ddop99c+NHjleYY7PRHaqGVt1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36096ef9-56ba-427d-870f-08dc06e57f4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 14:09:53.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZfcOPPkDSqIZhElviqXdDWNEwkIJFQ0c4JpTMxywOPV/sEpjrIRzICMVyAg+VBlzZyUEZgWeUJlXocAp8RiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6960
X-OriginatorOrg: intel.com

On 2023/12/27 17:33, Ethan Zhao wrote:
> 
> On 12/27/2023 5:06 PM, Duan, Zhenzhong wrote:
>>
>>> -----Original Message-----
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Tuesday, December 26, 2023 4:44 PM
>>> Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return
>>> the QI faults
>>>
>>> On 2023/12/26 14:15, Yi Liu wrote:
>>>>
>>>> On 2023/12/26 12:13, Tian, Kevin wrote:
>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Sent: Tuesday, December 26, 2023 12:03 PM
>>>>>>
>>>>>> On 2023/12/22 12:23, Tian, Kevin wrote:
>>>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>>>> Sent: Thursday, December 21, 2023 11:40 PM
>>>>>>>>
>>>>>>>> +    fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
>>>>>>>> +    if (fault) {
>>>>>>>> +        if (fsts)
>>>>>>>> +            *fsts |= fault;
>>>>>>> do we expect the fault to be accumulated? otherwise it's clearer to
>>>>>>> just do direct assignment instead of asking for the caller to clear
>>>>>>> the variable before invocation.
>>>>>> not quite get. do you mean the fault should not be cleared in the caller
>>>>>> side?
>>>>>>
>>>>> I meant:
>>>>>
>>>>>      if (fsts)
>>>>>          *fsts = fault;
>>>>>
>>>>> unless there is a reason to *OR* the original value.
>>>> I guess no such a reason. :) let me modify it.
>>> hmmm, replied too soon. The qi_check_fault() would be called multiple
>>> times in one invalidation circle as qi_submit_sync() needs to see if any
>>> fault happened before the hw writes back QI_DONE to the wait descriptor.
>>> There can be ICE which may eventually result in ITE. So caller of
>>> qi_check_fault()
>>> would continue to wait for QI_DONE. So qi_check_fault() returns 0 to let
>>> qi_submit_sync() go on though ICE detected. If we use '*fsts = fault;',
>>> then ICE would be missed since the input fsts pointer is the same in
>>> one qi_submit_sync() call.
>> Is it necessary to return fault to user if qi_check_fault() return 
>> -EAGAIN and
>> a restart run succeeds?

no need if a restart succeeds. I would add a *fault = 0 per the restart.

> 
> Issue a device-TLB invalidation to no response device there is possibility
> 
> will be trapped there loop for ITE , never get return.

yes. This the implementation today, in future I think we may need a kind
of timeout mechanism, so that it can return and report the error to user.
In concept, in nested translation, the page table is owned by userspace, so
it makes more sense to let userspace know it and take proper action.

-- 
Regards,
Yi Liu

