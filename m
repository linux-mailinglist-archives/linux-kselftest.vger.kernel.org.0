Return-Path: <linux-kselftest+bounces-690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC37FB04E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 04:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8771C20AF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 03:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0163BE;
	Tue, 28 Nov 2023 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNx3g8qP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3744191;
	Mon, 27 Nov 2023 19:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701140670; x=1732676670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WWC1xVSRh8QXNL1QpFap1maC+W1IqtK+aBXuXXxqbHI=;
  b=dNx3g8qPP0AGiQbzBsVG0XMHVnFkWBOEFPDjPC3u29Jw+b07F6WCusV1
   HXxFM1IouQR525MZh92AfJFgGGTfsuBEudp4wz1v0T6aTnnciiFeUx8bp
   l2cdZO5OvUbr1I0WSd/v1yAIN4MwQOnClSCNiE1S7cV0J+Ji4nC3gFsX3
   bA+c4I8rEKOgyO0XRm0FfVF7P6g3O95C8ILYUIa8p0rs5Ljx4eb3Mq3GF
   E7ev+DREmCPqxMLuPimXwnfrFFSEhzzysWAoFS/AYZq2ruS5m0hAVUXyw
   aey24QScO5gJx/dPzLyPQQkZrYJsrH0m8yzuSsGjJt+Fzvn7UOPTqp2GN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396739972"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="396739972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834521897"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="834521897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 19:04:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 19:04:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 19:04:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 19:04:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 19:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj4GkgdsL96fdo+3fGGVjUcE0IIgxJntueBBDu3X1zJuwJYZkIddaVi2VlLqtjeKRgNlks4U0lMLy5/eGoCsg0XhlLk2LTXDasxUE5xg1wLWgk5pajgtXDou+WWs7qPK7molSRC+eByJHdF3tp+HCS7sTRI1Jjx2pS9GhdbKMXn5xocj+/FGxFFQxViKWgVCyFXnqHL+jOYl6/hrBK4gExvjigUHpvDBRDUuL1Y7HoTl2r7ZYGMRJt7hX5hq9ktCowbB5w6+lQ1/i2xL7BfDav83Hxaxl9VhsixVaQ5HTWelOHrz/hW/+KkGI7kWrTRUI97B3J6Ij3wWwgWA1JMa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT/wDMD+qg7aiUZbSrdIEg/8Dt3/Dwb4M/bU4B5rwSM=;
 b=NbCmDQfrFp63/dzuBXIxlNLqUr8Bq/i7BB6Kfrm8kBSoPE+TKY4aIRV2dflDlkZ9u03nz+hrWmjeJMrl50LpAFJOCuFMQUacldG5qm7ZHs+NVGfmwvTJF6d6+oXFjLwZlpolojH6g2dNfVrMtMhGKJMHl/YUmn3MQJSru9YrCZuzb5O51YfUZWs0fVv1imgfw+wFeHDZiFbINakM4MIp+1eCzTNZywHJ3fQ5E1meEkWKpmkfnXIW9/GfkFSKApYBtmV+M1hpxmCN8a7rI+87tdUDenbbXx8flqRR/whG4vGIlx//XDh/974aEYJNZwj2LGWRQkdtFQjTABsdo+3D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 28 Nov
 2023 03:04:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 03:04:26 +0000
Message-ID: <90c4bc5d-fd09-46ba-87af-6763a46c2276@intel.com>
Date: Tue, 28 Nov 2023 11:06:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
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
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-3-yi.l.liu@intel.com>
 <SJ0PR11MB6744B5CAC867EE643958078D92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744B5CAC867EE643958078D92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 927cbaa6-3037-4a57-cb8b-08dbefbeb9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewSM6pnp1B5petKXuIB/mds0faLwb8mOmuQ8LQLVnywHQWkwWFaEwKhYzLQ+UxjoK2/ibmBbEeOA9IlME9eiHK9teKSQJoXYirJUL792oVKYHydhZ5mseOrILlRpU1VfWNMWxoVa8VEeyD1lpyKtQYA4U2pVtgBcZ/I/HE75xXdQ6vXJva5XY1nTdkW/axiUJ1uroxYJLgyWB+tWuO52xQYRRqiojbWHFJRHJ/niwgzKAACp8Y/cTPwUAgb0pA3HX4AuGD6rGGLvXrqRsuMtNgOfWNJf5yoX/ugNJinh4sbN2wDUTyGPj7DXLvX3k+2mLfUFJdoygYb0TpfzKWcSvaB62+C025dEqZOPlnhWj9QS9aBExX0eofxMSoF733au94w8i3opJ1xYIkP4otuDzOlvhVruR2+sgUwUaUjHAbrk9rosPkjHM6rusWqT4djENhLYoHNN3XI4mO6Cu6IEeGlIynqxGhNFg1JRBaQSyORf1s7P33ROzSofRRN8yMpXkBRsbTUOfxeElDdaiCRxkFM/ugxpZdMuxAHMSnvHJMXrY8+r0BD85o2AlBhuPN5uIRofrs0OK2gePx3RWDMkvbuoGpvisS2rEKJv3ol6YE7UMqM5tdm9i803GBQW4JyFjsRGl45dqfTY53ap8/Z1/c4RGN/5hhYj2IyoUobrHp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(41300700001)(2906002)(8936002)(8676002)(66946007)(66476007)(54906003)(2616005)(478600001)(7416002)(53546011)(5660300002)(6486002)(6666004)(6506007)(6512007)(31686004)(26005)(83380400001)(316002)(110136005)(66556008)(38100700002)(31696002)(86362001)(82960400001)(36756003)(83133001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2duRkFlbDNJbEttemM1V3BQMVVYTGtVOVpobUZCTG1FV1ZZR2k4alVZbTdE?=
 =?utf-8?B?T3NJZVpoVkZjeWUzVjFRSXNxOVlwaFV5UEtaV1E3ZEFmSm16aGlWcXQ0WTNo?=
 =?utf-8?B?bkJCaExUbEQwRG9oQitFT0ZweHZ2ZU4zRUZWYlovdFZRNlBkTDBEemxQWDA5?=
 =?utf-8?B?Q0dPcTIvRFFrOWJ5bGw4UTRTT20yNGdVcTRiNTBzSGNHcTdlMnJncHJIbTE5?=
 =?utf-8?B?bFdmMWg2eEJmVk1EK05WdWJkK1ZHbjBOZUl5ZnNycXg5ZUhQSzZkQkhkdVJY?=
 =?utf-8?B?SUJFbFVxTjJ0NThVZHc5V2dTTnROQURGTFhCY29sWjQxTC9hRE8xTGx5SUlJ?=
 =?utf-8?B?c0tVT2ZjUHJYU2NFQ0tWZHZjbldSTkhKSVZidmJIeCt0a3BGMmRTa2p5NTVn?=
 =?utf-8?B?aXR6emdvWDlWM0dIWHZHMU1WeGdTLyttK0NlTXBSY213MWlGcmwwQW52TWZa?=
 =?utf-8?B?amNIODJaTGRGVzhBTnpuVyt4THpvNGlyUjBsaDYxYlVxRHZRZ2RWVk1BcFZI?=
 =?utf-8?B?TmpJalFWSkkzTUE4NGovcmF5RzB0U2ZQNllDNm52SzRQeXdCb2NOUXUvMVJW?=
 =?utf-8?B?UDN3eVd1a3gxSnlJcW9ONFdTdGgrWGZ4dXJubHN1Qk82Yk1GeDFJQzlBZHRC?=
 =?utf-8?B?ZGJTUmxoZGpicE43N2pwdTd0QnFoNGxrZkxrQUY4WlhKTzRnNjAvU1RrSU5x?=
 =?utf-8?B?QlB0SHdxenZUbGFjYmsvZVZpaFZOSDV5ZWV6L2VraWc4NW50Y1ZyangzTXBw?=
 =?utf-8?B?d1hHVW9CQnR6RWt2cWxVajhvMUtRblZ2QitRUDBhRUMyODR2cm1HSWZzdTl1?=
 =?utf-8?B?OWRoZmlBeTNSVFRJRTM4K2FnYkFKbTdBQlpIM0NsMmczaSthZS84N2M1QytK?=
 =?utf-8?B?Yy9KM3RCVHhCQmM3SzMyTGtGZ3JTSGpyazhiWktWVDlJRjZhalUydm9JRnFM?=
 =?utf-8?B?aExHdFlUWmRHcW82QzdvSG9mZ2JxMkYzZ3JmcUFRZEV3N3NYMnVwc1JBZklk?=
 =?utf-8?B?ZDU4M3UzRXh4c1pjYlZtZ0ZPbENnVURycjk0Qm15cHhiWjBySmFZNkhQYXhY?=
 =?utf-8?B?K1o4Z1grVEtLcHBMWU1tTUs2bGU2QVFDaGtkbE1COEVaek9GMm4yeXd4ZVpm?=
 =?utf-8?B?VHRLdnVFWWMyd1lHbXJFZWlDSEIxMkZHRFJ4dWVPc0Q4NVpSWkZOVWszYTBa?=
 =?utf-8?B?MmpyTzE4NXFROFBJYTBoeUxoeDh6Tmc0cUQ1dlliOGNYanhuN3k2bEk5YkRy?=
 =?utf-8?B?Y0IvQXlnQm9pa0Y4TnE1akd5QndQbEVFSkNpN0JuVzFJWm1SbDFkY1ROaWFH?=
 =?utf-8?B?bWdDdFhQYTdKMWdIdTgxbHRDZlVraS9VenFLOXZNOVQ5dW1xZ21icjA3T1E4?=
 =?utf-8?B?a3VDamlxYVdCL3lwRFlPTTJNU3J1cjlUMnlNc0hHdjVVT0JVQzB2Q3J2KzJl?=
 =?utf-8?B?ZWRIME4yVG1JeklDMVc0VXZLOXhhSW5TWUxuUURhU1REdGpEMVBaRDh0MjQ1?=
 =?utf-8?B?QmR2ZjJzdmhNRUZJeDJpTmcybng2aXplLzNzSzh4ajhoTGhRVjRWbDUyL2VL?=
 =?utf-8?B?WEFaaVBiOEN6S3dxTnl1dkw5b1hxeXNRVlViY1pDdlYvUmVZWWwwMEhIOVdp?=
 =?utf-8?B?cDJTck1QaVVqcDIzR0ZaNXo0MGtGcDlFZXl4ZEZxamVRaDcxSC9wUGx5ZG1L?=
 =?utf-8?B?QmRHdW9xQ0lzZUJuNXBiVG5uZHNwYm83THdUZHZLbTU3WkNrU0ZtL2pTOFJs?=
 =?utf-8?B?ZXNDTlZPbDI4TVI4d1U3cW9zTnNBUVc0Mkw1Q2JNNHlFWXIvL3hhSW81aDNG?=
 =?utf-8?B?dGV0YklENzZjQlRUQ1hUU3YzYS9LTDhKUzJRSHEyTStoclRtNTlXYkh5Y2ZD?=
 =?utf-8?B?bm9kelY1T3dEU2IvWVZTYkhianlsOHhsbitTVmdSb0dXb0NLTVJVckFwMExX?=
 =?utf-8?B?dG0vbHpxMGF1eUlZMnhDNnlUZmVLa2Q5VXVlVkMrSnRraVJla3lwZ01tRXJT?=
 =?utf-8?B?Uzc1SitxU2lnWTI5K2lwZmVXV3pmZVdSdWMxRGxyaDNaWXp6YnczK3dwUERE?=
 =?utf-8?B?OERCbjNsQlpYZ2Z4enNCVTErWTU4alNZNFlzRU1sMTh1YzRSc2hpZzIzNnd4?=
 =?utf-8?Q?FesqWYCTADHSq5InkPT7RwrKI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 927cbaa6-3037-4a57-cb8b-08dbefbeb9c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 03:04:25.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JopuHqu95AAV4m1Q4gbEFYpj9ZmzuZAB6X0Iv0bW4EHmn8rTG0K2sk2WES9kctxdY9YaZ6qea94c6VYy4CaA5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com



On 2023/11/27 14:50, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 27, 2023 2:39 PM
>> Subject: [PATCH 2/3] vfio: Add
>> VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
>>
>> This adds ioctls for the userspace to attach a given pasid of a vfio
>> device to/from an IOAS/HWPT.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> drivers/vfio/device_cdev.c | 45 +++++++++++++++++++++++++++++++
>> drivers/vfio/vfio.h        |  4 +++
>> drivers/vfio/vfio_main.c   |  8 ++++++
>> include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 112 insertions(+)
>>
>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> index e75da0a70d1f..c2ac7ed44537 100644
>> --- a/drivers/vfio/device_cdev.c
>> +++ b/drivers/vfio/device_cdev.c
>> @@ -210,6 +210,51 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>> 	return 0;
>> }
>>
>> +int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_attach_iommufd_pt
>> __user *arg)
>> +{
>> +	struct vfio_device *device = df->device;
>> +	struct vfio_device_pasid_attach_iommufd_pt attach;
>> +	unsigned long minsz;
>> +	int ret;
>> +
>> +	minsz = offsetofend(struct vfio_device_pasid_attach_iommufd_pt, pt_id);
>> +
>> +	if (copy_from_user(&attach, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (attach.argsz < minsz || attach.flags)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&device->dev_set->lock);
>> +	ret = device->ops->pasid_attach_ioas(device, attach.pasid,
>> &attach.pt_id);
>> +	mutex_unlock(&device->dev_set->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
>> +				  struct vfio_device_pasid_detach_iommufd_pt
>> __user *arg)
>> +{
>> +	struct vfio_device *device = df->device;
>> +	struct vfio_device_pasid_detach_iommufd_pt detach;
>> +	unsigned long minsz;
>> +
>> +	minsz = offsetofend(struct vfio_device_pasid_detach_iommufd_pt, flags);
> 
> Pasid isn't copied, should use pasid here?

good catch! will fix it.

-- 
Regards,
Yi Liu

