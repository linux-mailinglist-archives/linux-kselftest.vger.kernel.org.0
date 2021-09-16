Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789F40E0E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbhIPQZe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 12:25:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:8049 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241970AbhIPQXh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 12:23:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202758070"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="202758070"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 09:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="530223362"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2021 09:14:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 09:14:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 09:14:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 09:14:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 09:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXzkRKUKabLFUseZ5QZ3IDcQj4l/ZIdE5503flesFqDspnr5lh7F0UCIGMvw5i5nmJH9fhDx66JXn2lclRSEOsFZK+lcVljGtDB4SdIlNOQdXaJRAN+TK7EASU9PUx7NRNS2VnlM9vgtXdkHrV37axd5eXi2dJBZDN8CQH3cqvhsks+pe5psCQ985b2kMGLvY9SW7JPJnxT4Hu6yJfFM/vV16/VPdbGJj00aafoXG268DMGMFgNI3dA1hncQjQUn8gpNN4AmEpPogp7AP1wiDukj/UGqZ47Fj+JmiVY4fgV/awui1jNdzWAaL+yPSBpoE/R1U/yXBuSklc8xoq3S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=i21+yJETE8qcdGJw6tY40v8/824SXgx6EsH8O/kRyCA=;
 b=OwDILMASzK5siuyk43MLuwjge4l4PZqYgWBQsgnzkgwnsIpYUDJ0WU1GZV6N19I6J9UhYDYl/Xs5uFgEXm7pJraSIHmUAG0d8Yu/OHEcvwgRj5P+I5EkZ5Lh8P/HEexnIGEO2U9ri7xVM1Z1xo+HuQpnlRmn3pgc4r8hUFQ+2MzMVWDKGMUpsyyJWc82rq2L/y1YZOI5bH9B00Tss3u8VxTtTGz5tjiYLeRohByaQt0lRMVLtkR2wqcIs0mVdyP+BvHQK2MfO5WS6+heKwt57yWmrRnhQ8kFv0+nc40mg/frmQ+WYAYRsZTxIPpsPy9+JhDBrO5Z40TMFhtM5QdW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i21+yJETE8qcdGJw6tY40v8/824SXgx6EsH8O/kRyCA=;
 b=h1tss3xURQIhHyY5xalgtp+2kHLFTUpe8nQq+YhgIVY46qcktSD9HoXZrMjee/2o2dXHxFWXFtZ5WsbwLDtUzvcK2PCMR5ETppzv2Eqd1VebTOgRdBXcTdqavqrtWu1EXqkvfcv6wCevYjWdCKey0q3VCMz5CkvGw62vED4KAAQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2260.namprd11.prod.outlook.com (2603:10b6:405:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:14:26 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:14:26 +0000
Subject: Re: [PATCH 00/14] selftests/sgx: Oversubscription, page permission,
 thread entry
To:     Dave Hansen <dave.hansen@intel.com>, <linux-sgx@vger.kernel.org>,
        <jarkko@kernel.org>, <shuah@kernel.org>
CC:     <seanjc@google.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
 <c1f48aaa-5ab7-e44d-14ef-11c05a531d85@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <ee323912-ebb9-9262-a599-b7e22527f892@intel.com>
Date:   Thu, 16 Sep 2021 09:14:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <c1f48aaa-5ab7-e44d-14ef-11c05a531d85@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 16:14:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92acd5f0-fe2b-4764-273b-08d9792d0d55
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2260:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB22603EEED178BE45D621C7A3F8DC9@BN6PR1101MB2260.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iN2V7OLhub3AD7u2XavrROVD0l9xbAaXH6zk0Gw8eRPVg7P8mfNbzPNvWHWADzCscKe4ikCUuRuIga9gmBJhkN8LLQ0I6h4W6DA0kQqITNoAlYQjiAR4HEcqemW4dLBYx5mY6kEYGeNhbh2pNfwcC9e36YH6dYod014g09T8PXDNZgiChwPAp4A+nWUcqyPIbkF1sia/zPZ//ANJsyXBKuhtxk+hQeyM8t7FHekOS9Ohm4SJEY5cpjgXZpQW2yE7pVU+eFqrWrgCrUXGMZO580CAsKluYWxRmAdEKcIBKL+ZvKShK3dQMLw+zSteHkDxqtpGR5JhAoN4fkwEUJxlZSADd1XiJKpCGfKeOCetgErij2Xc3izb5CRdf4RuROKD4SjvHhCjDK2E2SnFE2/P8Im+xx+NtcbL58HNlQJPsBweno6GEzS1XqQASZPypOwd1unJJBNX89uUbom4vvDxxWdfHlQOLEmvaa92Roln410QcoyN4/tVsSwpIaoYXhgIhkzqWQOXYynVwtbhlW+jVOouf54Z9fmoO09QwH2L/8It6ARV0HlMZKCHYxrFlMz7ve2qfhJl8u7mFiAEJ4SVoge6/ZyKN3qkKipVetH8ONPASQLVgoOqNDnfPHfDWIEkQW/wFLq8Deuxe485oQrTqETSdJT6m36z/THiQf+RpfKdXnhLaCsenJNg4kLFbaCdh/x7AZjJZ6tnuN0GVbcFy5gOeqC8BW2AnjyvDhsD33s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(316002)(8676002)(2906002)(16576012)(4326008)(8936002)(86362001)(26005)(31696002)(478600001)(53546011)(36756003)(66476007)(66556008)(6486002)(2616005)(38100700002)(5660300002)(31686004)(956004)(44832011)(66946007)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRPRzVGdnBKK29YcEZSclZMcTdVNUs1V2lZYi9zNCtCanBnK3JlT0tpNmoz?=
 =?utf-8?B?UkxBL0Yzc2FJMU5tYzd5VGpvTk9MajZFSDBJeER1LzZrZ3dwNnM3MkxsR2U4?=
 =?utf-8?B?a2diRVhFaW0yc2xWV24xQVM1OUttVnV1SXZBWitoTTB2T0Z2WXNoWS9tTDNq?=
 =?utf-8?B?MFIyd3BpZkx5Zk5Ja1ZWN0l2d3B2RW4vNnc3Ri9GS3hsK1dRdXJDK0doM3Nq?=
 =?utf-8?B?aXFyZ2xBNkE4L1A5V1lLLzBaMURzNXFhcEFOS2xEMVhGdEZpTVVGaFNTUHc3?=
 =?utf-8?B?QjdIV3ZRYXByS1cwa3hVWG82ZXY5TWRBTjlUdEVQcXlGOHFiWnUxbTZuUGhN?=
 =?utf-8?B?NmlqNk1jd0tUVnI0RHVQc29ueG5JT1Y2UnhiQlJMYnBkckpNSm9QaVY5QS8x?=
 =?utf-8?B?SVBwR2llaGtmNmt4Wm1ObTNqQS9ZYWFVQlk4SUEwYTFPNjEyV0ZnSkQwUllt?=
 =?utf-8?B?N2FKeFpjUDh4TzFDMUlCYnpKMHllSmRTZUtlRHJlMDNWcFBmaUtTV1pualUr?=
 =?utf-8?B?VGpnMUE1TU4zVmF2eDlTYkJDVUxUYVUvd0YvWHhZeFc3ckJQZGJVUURJYXg5?=
 =?utf-8?B?U0V6RWZwZ25LcUVmRXJrZTgxb3hkRHE2SGRqTm81VWZ2cXhzS2lYOWZIc2Y1?=
 =?utf-8?B?YkZSVUhpcEVpNmJqemk3bkl1a3J3dkRyb0I0cVZCZVZyZk9DUE4zVVkwNG1r?=
 =?utf-8?B?N2ozSHhLcVJDa0Zta3l1MUt2bHlHa01OZWNDVlF2LzhySWYyVjhDZStaY25v?=
 =?utf-8?B?M3JnZFVFNUx6YWNER1IxZ01JVytDYTVBYTF0cGI1SzZPRzhHODN1MS9GNDUy?=
 =?utf-8?B?bFdMZFRoNisvN01kTUU3c2s3dW5aSHI3MC84MHlrZDJObnZqRDJZR1UwTVRG?=
 =?utf-8?B?YnNpdjhzSkhwd00vWExEZ0VoMHJTTGVjNDNYWisvekMzWWt3eWUxbk94RHNR?=
 =?utf-8?B?VkxCQlFCeks4TjZOOEJmU1lwWTVNL2t4VFgxUmZBellwNUtxTVFDQTBENEJY?=
 =?utf-8?B?SXV6ZTl4WTdsdVpiOWdESFpXM2hEaXZFc05MNnBmeGhHblpMVTI0OFZnNzZq?=
 =?utf-8?B?S1BKclYyMlUxVURxTnByQ1p0SHAvRGZJUmlUZTVGZHNsdlBZTEwvMmxQL2NG?=
 =?utf-8?B?bFJqemc0dGlITVJqMm1mTW1oM0RmSGlZNVlXUXl0NVVSNjRVSGdkWVYvS3pS?=
 =?utf-8?B?YzBkY1p6M0N0SjhOMzJRaWpxS2pFa2F4MmhmMmlwdVIwV0swbnhGcFNBQThs?=
 =?utf-8?B?c3hHMTJVOG5XanVudEI3OW5iOFhrbTYyWnFyRXN4TTBPR3J2M0dBWW5NUmcz?=
 =?utf-8?B?N0ZrUTlHQXJmaFlyYmZkYXZ0S1c1ZzlGcyt3UG1nQzA5TmhZVURUeHM0OFMx?=
 =?utf-8?B?NjRKVXlBYzY1aVJMZGVWTkFXdlF1VmxFVGJHVTR0UHY0V1lUQ2hBTXZGSjll?=
 =?utf-8?B?TnVlNjVxblREaSs0QTFFQlpITEl3d2VLVlFPei9WWU5KTUR5QkdiL1NmTXRQ?=
 =?utf-8?B?ajhiVmplWmZRUkZFdzR2N0F1TGVGWlRkZW5ZdGl3L0NHL3crYXhYU0pDQjdI?=
 =?utf-8?B?TkYyRHhOM3ErSitrNFYzRWtwS0hWajBnMWREeHJRUEJFNm5CK1NXd3QvaWFW?=
 =?utf-8?B?Mi9jZ1dQeDlidmlLWG5odUUxOHpEU1N5UnVyYzhiaVhzWWVYd1N0VkpvTUVu?=
 =?utf-8?B?TmJmbGVIeERCYzI1Ui9DSGEyY05wa3l6b25NbWVYc053MU9uSnN6UXdibHpm?=
 =?utf-8?Q?sxFiHJFQeWXypzEdj3ezeGD4o0TcYwAMDWhTqMP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92acd5f0-fe2b-4764-273b-08d9792d0d55
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 16:14:26.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRo5hkcT2brZ3qc1gVGFFt9R4FvPpK2gDFrQu7rujpcJ2Zspi0jr3E5oenI8ZHBOR2eTa8O9RN4D2H4lreflROfYNzySVc9qW/t3X7NiUQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2260
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 9/16/2021 8:37 AM, Dave Hansen wrote:
> On 9/15/21 1:30 PM, Reinette Chatre wrote:
>> This series consists out of outstanding SGX selftests changes, rebased
>> and gathered in a single series that is more easily merged for testing
>> and development, and a few more changes added to expand the existing tests.
> 
> One other high-level thing we should probably mention: Building and
> running enclaves is a pain.  It's traditionally required a big SDK from
> Intel or a big software stack from *somebody* else.
> 
> This adds features like threads to the SGX selftest which are
> traditionally implemented in that big software stack.  This is a *good*
> thing since it helps test SGX kernel support with only code from the
> kernel tree.

Will do. Just to be clear this support for multiple threads is essential 
for exception handling testing. An exception that triggers an 
asynchronous exit from an enclave could be fixed from outside the 
enclave and then execution could return to the original thread, this is 
demonstrated and tested in patch 12/14. Alternatively, it may be needed 
to fix the issue that triggered the exception from _within_ the enclave. 
In the latter case the enclave should be entered at a new entry point 
(new thread/new Thread Control Structure(TCS)) from where the issue can 
be fixed before execution can continue in the original thread that 
triggered the exception. I have tests for this scenario.

> This is similar to what we did with MPX, which also typically required a
> big toolchain outside of the kernel.  Despite MPX's demise, I think this
> approach worked well, and I'm happy to see it replicated here.
> 
> Feel free to add my ack on the real (non-stub) patches in the series:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

Thank you very much

Reinette
