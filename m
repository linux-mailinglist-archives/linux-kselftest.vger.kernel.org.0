Return-Path: <linux-kselftest+bounces-929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D31800248
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 04:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CDF281587
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EA4C8A;
	Fri,  1 Dec 2023 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cW0SPpfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D030310D7;
	Thu, 30 Nov 2023 19:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701402541; x=1732938541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mli1XawxeTfRWkhSA5SKLPc6i9dViFPe7QZNeE0an+w=;
  b=cW0SPpfi9k+Dg5pSNZl4beIOfDcUJi6kNmMxbyzI2+yhwzKw/ndNxWwj
   NJCO6MSK3e3ejCNN6WJDurTvawbW6e765GILVUnazKtscIpaUsgLiZQH+
   K7okGdVlPkyGDlCZSDrYPmeYoTLfreCt6B04My6HWd+mBYaxhnG5qyIXL
   WJM8zx5XyPbaEuDApDgImp9vC0+nDqjxwfVyVUh3Wvgzw55WDlMmZUl1g
   Gc+shm0e4pU8fUgHsK6TDDJxIk0/Qs/IDsai6V8bQKt1d0WBtS9eORs51
   5h0T+MCRMjvZOfYC03vvYvxc0+igCuCRLks1HJXkaQ23zixsPLwUOHq8U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="430828"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="430828"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 19:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798558749"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="798558749"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 19:48:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 19:48:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 19:48:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 19:48:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB46ZHsPdFnm2Tzp9neOFVeYRQmOgrWx9R9IY6lmj+EoY4qFQT3ig3BSqKiFxh2ujJvzfupeKclRmDc//HEkG6kaICBbLmo7vkErn1Ed4HkjvAT6ymjNIQJ8fRSS+x1FOJRePdHHr2EUSLv0MsXFBvWCALByaKqfei25gdvBlABdrqC0EfQyTJosI8wU840ADA2BjkzTdp8ECauLwp+BeqkfrXZ6+XSM7Um93KP6kDheZ+COJREizWf+T+dZyZvahmSHBfi9PwklROM9KQk43jM7xbLcJ3JMi3dXWmQCFLNqi5O5P9W1EuGgXP8ixizugrloIxI0V/5ArzP+kiPm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHRp9pgHjL8ENRSbwF1izvEWgpzofh8hTH4JTBR0jZE=;
 b=P9RnsP7Yaim1M7vnlhxzXxqkKLfCk/QphvLajiKz3s4mg8QQIzMjx69JDPdPlwpC+JMhln76V89vzzUnvagfLxC6eEPf6/NRgYE8xWaImfexwZ7+Q31E90Sf0SuXauTChn4DORVh7kUVPk6owjnzCL+4r5aZ1cuGQEcah1X7zBcPvCZH/+q1X9RVCiVswhDNAKmaQbYYIHP84qpyeA1G3YuGodOzkkvKl7A79wI0IWuhZJMzXmbApL/4c3EWTvlKKX+PQXBCGR15y31wyhizKbKRiefhEJ8K7czfRWf93PGPznRQSQIGQwo7M+zK6hoycGSBVkoI0MyL15yDJ64hdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Fri, 1 Dec
 2023 03:48:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 03:48:57 +0000
Message-ID: <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
Date: Fri, 1 Dec 2023 11:51:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia> <20231129005715.GS436702@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231129005715.GS436702@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8374d0-17c5-4d52-9c1d-08dbf2207132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJci9sikj5PsawUTCNbUFnyBzHIbWRmcsOI3mRvVFf9/TF54gMgxVV0CEkIx67dhElv+EBsOYeTDKTNArcqCoiE5alfXDQYtBUf77SILGi1U+AFqSc9UtVQ4I/q3JFnOGEWaIY7jPHMmr2BlP6c4WNVMY3PnHPnCMm0HAk31fhqd41mJ1U/lASuBRCjwBZ6/7K0K4emnJp6WKOhYXUEG/RDaCvMOzes4sGXa5kfRf/l9B+z8FTfSSvlfpTzXEsFE2UQkVXDpg4cMswCGVhdASL1Md1BA9n4NqXZbohT/gkyyGmBylVrWDO4qjBW3D6mLIFftK5NN1Jo+V6VGLrTRFqdK5tes43A2zmrUMr/oH4craZ/RscZsJFTcHV+PuJ3dhG7TkJG3yFVZFLTBpvM52GYbSLggKB3O99xRcHvTrAh1mot0Tud7WChvYdSyhl2W8YxujNC+O/Z9nuiqXa19aPwPIsllLQgtdHa5TxSX5pZrLZkjJVNlcHAwgLp0AG7kE4yhHsZGiaelTbJP92J0tnsB/YZasQZXFEtudcOvFy3wH3jf9ddYh+TnPcDksjFIZe3gRRV0Xf7sEparqpTzAe3f3ezu9/CkNlj0RV1FskOe8R+jAqpWV6wiWII5kGUE+Pttz3nEh7OanjvI8lFnpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(31696002)(36756003)(82960400001)(86362001)(66946007)(5660300002)(8936002)(6512007)(66476007)(41300700001)(110136005)(6666004)(478600001)(4326008)(6506007)(7416002)(2906002)(31686004)(6486002)(66556008)(54906003)(53546011)(8676002)(2616005)(26005)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5FcDdXMmxOcHhJUTAzN0RyYTVTRmZ5azd0SkR5VU9nWERpWWU2a3F0ZkF4?=
 =?utf-8?B?eWZ3QlRFL08zazl5cFg2Z28rMUtXbzV3UUZ6NEpYdHBPc2dPRFRtZmMzNnVu?=
 =?utf-8?B?UjhhRExvZGN6Q09UYjgxUXNNVlJEOXljS2pwajZnSkt2UmpLZWo0MDJHSHp3?=
 =?utf-8?B?WmlhT2h3VVIwWHBJZ2YwSk53amdVVmxlNURhaWUrd0ZZZjIrSENUSkhEMFJx?=
 =?utf-8?B?VkN4cnVRMjdZMUtROHozVlR5c0NGUytlVm9zcTJmZlFOYjVWNXhTNm4wWU5W?=
 =?utf-8?B?NXlEU1puOXhPcnRvU0p3L21WeENCWCtTaTdYdXBTZFE3NU5pNVdnalJ5SjB6?=
 =?utf-8?B?eXNHd2NDKzlsRndweE9DNXZsV3BRWmxmeldXS3BrVEdyS1VLYkdmMDNiN2xa?=
 =?utf-8?B?N1doME5GYXFUd1ZwUWViU1FiVDV6dXpoSEJ4NnNDRGhvQytmM0FGMnJpZTN5?=
 =?utf-8?B?QnFiaDBpaUszRnJkNnhkYVhkUDk4WENzRkQ1bHRTNitkSUxJMUNCZTM5UjVi?=
 =?utf-8?B?bEhmengyTzhLbXg3TWthNmpBeGtxU3hiQVIyZUpxMnBxekt4Uzl2QVZUL2ox?=
 =?utf-8?B?OVZRMmZyc25IcG4rOVVIbGRYRWpqcUJpYkFmWnVPUWVjb3VwZmYzdGFTUlUy?=
 =?utf-8?B?a2FMTGFGUExNS1VjeEJ5MWw5ZklKd2NFcGU0SDgzbXAzcTJsV28xMFVIRnFE?=
 =?utf-8?B?MThTb2pFMUNaZStJajJQUkhCM1FYWWlKZEdDVzVBcnN0NHVWK0F5NThPa0xJ?=
 =?utf-8?B?TE5JMVprNUVwZ3kvSGxuRkJ1ZWFMZG42bGg5U3Q5VDNTTUo4bFNEMUZFenVV?=
 =?utf-8?B?NzREeTlGNHA4dEdQQmRraXI2UmNqVWhIWWJuWXlWVmNlRjdSSElzalNPVTJN?=
 =?utf-8?B?TjE4OEdwY1BIK0Vob1loa0tsM3FDZDh2UnZ6d1FHL2tNRGV4UHRJN1ErQWdp?=
 =?utf-8?B?V1B4ZFlMbzk1Mk9yNkJLc2FhQVhoMW9XcXdNZlc5U0o3TmdLL0NGTm5YaTVO?=
 =?utf-8?B?bFhvMWtJOTMzanYzazYwRTJqU3ZpYTdSWi9JRkRUT2RSZFhZKzJRKytSbFFr?=
 =?utf-8?B?bmNZY09tU1J4ajVIcmE1eXhNUnpRSnBieEp6bGJZT3lMTklIdXQ0MVBocW8y?=
 =?utf-8?B?ZUgyYmNBMGhqR3VhNkRTamRoR3VURmNKWllCYUYrUENKMm9GV2k3Y3lkS2ls?=
 =?utf-8?B?NEZzMFZBUTVlWCtrRWdhb1VBUExjQkE2RXgwMlRtRXJqY0lqcTFReC9MQzZz?=
 =?utf-8?B?WG5kSWZ1Ui9nQlBuY0RWRFNEbE5ZaGdTWkt5c0d6QWxMUzhPQWVWLzdYd0hI?=
 =?utf-8?B?S1lMM3hKdlN3cm1XVnNJaHA4Z09ldUI0RXFsTCtvN1luZWxsZGN1akkrbWdi?=
 =?utf-8?B?emtYOUNaSmtHVVV1V3hkRDZPMk93U3dya3RHL0hOZzJuRlM1aHVacXhHNEVa?=
 =?utf-8?B?VHVTc1JBYVpkeG5GeStwNFgvZXhKMkpaSkpidjM3MnMrQTlWaE9nUlFXd1Mx?=
 =?utf-8?B?TXZhVWtndnVYc1NaOHdUL2tHZXNwc3hmNDJhSUsyeDJJL3VtVHNSZUxHQTIx?=
 =?utf-8?B?QUd6cUwvOUtpdXZ6NnVvWHN5S0I1MFA1MThMQmNGZjRxaDdQWFpndFduVkIy?=
 =?utf-8?B?ZUxhVlBGVTZocHM4dG9Gcm50eTJ3c3NtNEdXWkgyL2RkQjRjb3FCZ3IxOU1O?=
 =?utf-8?B?dytMclFzdk5mTUI0enNScGNjaVB5cFBFaVpKd2NxVHo0cHorVklwVjdRYzk3?=
 =?utf-8?B?cHlVbytZRElMaEtuZkxnUis5aWF3L3RpYXlYa3k5NG5FTWJFbmN1ZUlUcU45?=
 =?utf-8?B?ajVERERNRWQ5Y2E5SERTcVNGNW5mdnIvRFdOUkdMTVl1SUI1NFZMSkYyOFlO?=
 =?utf-8?B?T0JHRmEzdUlBbmhqMnJHYSszaGZndTdLNWZ6SUNtcytnZXk1Mzc2eGpLaks1?=
 =?utf-8?B?Q1gxNnRUaGkxaGhlR3dCb3dMbmVTc0wydmMyOUhhM1B3ZDFTRGpHVTN5QXoz?=
 =?utf-8?B?czZsb0d2N3lnK0dONlZoOVRxZVF6bEw0RHB1dWFwY056M1Z5SUw1L1IxR250?=
 =?utf-8?B?MnM2NWFHQkJ4VTMxT3o2cEZBejFsaXVhcDFEUHlUakZXd1VGVitBbTNEejBW?=
 =?utf-8?Q?86hEevJZJIGVjF1dp9wQU3CLj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8374d0-17c5-4d52-9c1d-08dbf2207132
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:48:56.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5GTNKd7+iypGIuTKVsr1+9HtxcoB9cKnwAPlmibcDMs+tHnyRW3N8GO+0qcGUJ86f++dgwaA7UXrO67G2+kvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com

On 2023/11/29 08:57, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
>>>> I also thought about making this out_driver_error_code per HW.
>>>> Yet, an error can be either per array or per entry/quest. The
>>>> array-related error should be reported in the array structure
>>>> that is a core uAPI, v.s. the per-HW entry structure. Though
>>>> we could still report an array error in the entry structure
>>>> at the first entry (or indexed by "array->entry_num")?
>>>>
>>>
>>> why would there be an array error? array is just a software
>>> entity containing actual HW invalidation cmds. If there is
>>> any error with the array itself it should be reported via
>>> ioctl errno.
>>
>> User array reading is a software operation, but kernel array
>> reading is a hardware operation that can raise an error when
>> the memory location to the array is incorrect or so.
> 
> Well, we shouldn't get into a situation like that.. By the time the HW
> got the address it should be valid.
> 
>> With that being said, I think errno (-EIO) could do the job,
>> as you suggested too.
> 
> Do we have any idea what HW failures can be generated by the commands
> this will execture? IIRC I don't remember seeing any smmu specific
> codes related to invalid invalidation? Everything is a valid input?
> 
> Can vt-d fail single commands? What about AMD?

Intel VT-d side, after each invalidation request, there is a wait 
descriptor which either provide an interrupt or an address for the
hw to notify software the request before the wait descriptor has been
completed. While, if there is error happened on the invalidation request,
a flag (IQE, ICE, ITE) would be set in the Fault Status Register, and some
detailed information would be recorded in the Invalidation Queue Error
Record Register. So an invalidation request may be failed with some error
reported. If no error, will return completion via the wait descriptor. Is
this what you mean by "fail a single command"?

>>> Jason, how about your opinion? I didn't spot big issues
>>> except this one. Hope it can make into 6.8.
> 
> Yes, lets try
> 
> Jason

-- 
Regards,
Yi Liu

