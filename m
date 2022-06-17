Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEEE54FFD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358481AbiFQWVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350694AbiFQWVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C6760DB7;
        Fri, 17 Jun 2022 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655504492; x=1687040492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AwK27hVZVLJqA6EFFXRj5aJ3kvjRSN8Mxug7MyG3/kk=;
  b=JbuG6tU/MrYZwkMB8T0CQO0GGxhjKAtumclp1sD6LrhCTr5eVByn7ic8
   +uxRlluTxYPdJrtXoTkK1lcljMstu5cgeqypI9s7OeyoaeYnrBKq2DRH9
   YIsQSqsMaZmlu1rKjVcqTSOa1G3Hiz7Sgf0vP51tZ9pawd8pBeoFJ1gIP
   ipVHD4tGM1oKmRrpa9yEuQBDjZyknvEAtzZeYQVYYZD8xNFrC1cZ+Cok+
   vWU4pgcic2V685J1FbDJvP+mfz5/Qb0mhv3sq1Wmbej/74moIZ/0EfcRG
   fe8n8TLgd1ipo5ARM3VCVvx86uufSc8rqEihuLT3N8EBhOUjIgHSiZfer
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343587806"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343587806"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="560729937"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2022 15:21:31 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 15:21:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 15:21:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 15:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k23Ksn4g/CDv720WFIxF5T1S6K/I05Vxyw2aeZBsv3SlWBaWPQk8k0ll1zEK6fVswvjI5mgxNI34KaHZS+rFeO+9akdEDCSZEsY5aYG/DZvddr16PCjy7AW6sv8j4KhNbqaX/l3AXeU36+3SBjtZnLOA/FnxIS4zx4uy5cxcbCAu1xyk1i+ea3SEEH34P31RxUUMK/we5HHeRtRm6YcP0KQoBeUNsi3Jmdp+HdxCitgkUQy8L6hmbLIKdkw21Bhx4wFHc/tYcAN+o7b1Gujmr2VoSVAAqronqYqYim2ofmwQ3oPTTbmpEuEEUCAkehC62bn6ehXGoo13m1uknw5pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEuHhaLnis4Z0ayzj2OlzFI1ctO+JtA7nrcdb/bOLRw=;
 b=JAzG/f/+sUDqnTa8YtddaGaLfQvoch6fETI3HozhBu/IkgHKaXF4hoORyQLsBPWeBvqOi36Qtvsk+MMTXFZK4nwbbv0d6grhOk+0zjWx980IB6VNmRiXlEMDrGPAhNQI6fYE1Hct3o2Dor5FQ/Wow4/nksZbnRJDvmdlqyE41+4IG4OlEEep41DhJvyt1RYm7aH5YtPhOQxUhcBff1OQkGoDDVR+pMBXuwSp0cBMnO2m8AOpmPUWdabXBKLIxnzPt7fh0y4obpAmkxpbHb+6QH/1V9M1S4/jakDiCNEeE6HCVFf7Wg/JGViN9JeNFTRrdcdf5pCzQlolFoicTA92AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MN2PR11MB3614.namprd11.prod.outlook.com (2603:10b6:208:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 22:21:28 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::8484:f106:3adc:33b3]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::8484:f106:3adc:33b3%3]) with mapi id 15.20.5353.017; Fri, 17 Jun 2022
 22:21:28 +0000
Message-ID: <327cde12-daea-84ba-4b24-64fe12e89dea@intel.com>
Date:   Fri, 17 Jun 2022 15:21:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] selftests/x86/amx: Fix the test to avoid failure when
 AMX is unavailable
Content-Language: en-CA
To:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <bp@suse.de>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
 <20220401221014.13556-3-chang.seok.bae@intel.com>
 <aaab50d2-592c-69e4-58a6-0a0926669de3@linuxfoundation.org>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <aaab50d2-592c-69e4-58a6-0a0926669de3@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To CO1PR11MB4849.namprd11.prod.outlook.com
 (2603:10b6:303:90::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cedbad-abbf-421b-8c6c-08da50afb4e7
X-MS-TrafficTypeDiagnostic: MN2PR11MB3614:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB36142B1AE1D3F9DC5E084836D8AF9@MN2PR11MB3614.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAn6U4zQKEVe2imYPHiKPEL5vBPN5r/Y/iZYgxfiO5wCdLW1BP0bDO7MpTlwEnFfxPbSoh759TGNal447lnOzMRBoQBGm74j5AUr0sOMVhvNi9dLT00UqCDNwTarPRLyvyNeRwCvxF8Wx+xFXnGJDkrDK4L6XaFZHJ6jjFtME3mNRlf+uGDFaJhPPZLv3gRjTg7UDOI7rmCMss6a9uaCsrE5M1MWuVh7w8vGE6yJvQjkBXRKUU8xrHdCnZMjbNo7E8JFa3t7FCVtkO5IvkSL4ZX4CpAJybJpyxKqin2LgzsPgCz4dztQ2u0uJ1kdJ9Hxv3url/8EuTjWZn8BsJ03DuMJDZrrFzdoFEFQwAYd4vUfnUjYnzg6v+SkBw7KGRf2EANm8Hu9Qavd/pY/cFJ7ISk4OLsuFUFZDlwnTfichCABFuczAx/57V5cWbQ5vfCu2QalVNG8jkRKOk/NZoMKJ0/iSGlqZDw/P8X1/7ZZYl6HiWXxwvTdg3PtnVJA891sXNc22ursFdlHTnHCYfQ+a+CjaANT/mu+XsfI4KldV5s3JrZoeEoUDF+UXPgceGhdVnLBAS+Z2wFLuRqZSefeju8sWuQX7bV4o+ylx350Fnqnz8vxuYWGRSb5Fy1iyUvKepqoMgXV2lFjd2+RnFIkSKx/RQ76R5EUURuLnS3BxKN32NDh1ph7oeKMug6IGFiKMlt5rqkT3PTHqZslfeFJMnb7w7NgQIm56arZwVYDYfKcw/2/y9Qs5of9weweyFXxp4Myyw/eNZatbV96+kduk/BCPfyE4inn1d3+CpI7gjZZdziSARUrIyquoFo1hWQ8NuVcZkMm15YWzcwn5au2VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(498600001)(966005)(53546011)(8936002)(31686004)(6512007)(6486002)(26005)(4326008)(66946007)(2616005)(316002)(2906002)(66476007)(66556008)(86362001)(36756003)(6666004)(186003)(31696002)(6506007)(5660300002)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVlZ1NQN3BxaVU2MXA3ODhCTmtOaUhDUFFCV0JVOTN5WVZxYzJPd3lDZUtB?=
 =?utf-8?B?bVl3QW5helZ0MGZPUHhneWJERmNQbDFxUVlMemNGKzU3dzE4Q2ZYYkZlNE5S?=
 =?utf-8?B?aDhmYStGRWh4ZzFESWYxVUFER1BHRTVWMUJkelBXakkrSmZGM0ExYzhjYjZU?=
 =?utf-8?B?VUNaYm00UGdRakIxU3ViMEdSbmY1SnBtUUw5cnBSTEtzdFpmN0ZsamIxSHBE?=
 =?utf-8?B?OGVVWU1kRFNSZU5kbzBvdTFWK3NpaWFCd2VLakxaT1lPOTlDa3VucFFvUE03?=
 =?utf-8?B?V0dFeFlkVU9qV1lObCtLWnQ0YjdKUzFwR2JBZUphaTdFWjNPU2VXK0FLelFQ?=
 =?utf-8?B?dS9LdWx3QWxFYWlvZ2hoQ2hYdWNZbmZkUDJNRU9rd3hxQm4zRlJ4R1lzbkxI?=
 =?utf-8?B?amhBc3BKTG16ZndiWFlnVWozakNub1ZPSHdVcnlFOHNwNjJ6di84c05ieEw4?=
 =?utf-8?B?YVZ5YXd5djVRRGc2MTYrNjlSaXNyUkRHRHpKcXRKbk9KdjFwNFhSLzdqc3Np?=
 =?utf-8?B?UHczUkwzRHArMVNpNUxTQ3hwYUl2TW03eUp3SHh0RHFVTU9HTi91WWltYWNh?=
 =?utf-8?B?aDdQVGRSVmZBVmdYMG01M0ljZkcrY1NJQXgzdWg0YXREN2ZkVDltQTJFU0Vl?=
 =?utf-8?B?ZFltT1IzSDMyenhtU2dSbkgrQmNTMTZWZlJHRFNia3FhMGpwNk1UeDA5TVBi?=
 =?utf-8?B?WlBpVS92YXB3cklhb1dabWpZaEJzcWpjcEwyeEJnWlpZMCtHZEVCVUNwRitr?=
 =?utf-8?B?RFQ4Rnl0RWRTRThNQU9xUHVtUTIwaFAyeElGa3oxNjVtYlBuakMvWkVGeDZa?=
 =?utf-8?B?ZUV0d1VHQWVTaUdKOGhMSHFVdW5aUmFLY0lvV01RaEVzSVE5a0dodVBtSHVP?=
 =?utf-8?B?RHhZbHI4a1RjMUxTZjZHS0FGNmFVV1o0bTVoYlYzR2tiRmd5dE5hemFJb2Z5?=
 =?utf-8?B?eS9OakJhbHF5U0tOOGIxYyt0aVY1YVp5eHgxN3ppNmxXanIrTFBFSUVmNnFM?=
 =?utf-8?B?b1gxTEs1SDJtTDBEMTgwL0VlaTZaWjkzelJSNUtWVFNyRTdYemVNakJpS0NW?=
 =?utf-8?B?MG1jRTAxZHhQeFNGTmZPL1JxQzZxM0NnM2RnOWs3TnlpVmJCcnpiei9yRnMw?=
 =?utf-8?B?ZHQ4M1E4MEMxMTdmRXcrSCs0bkYxczFCMjg2V0ZQcGtEeERjcm5kTzZkUVZm?=
 =?utf-8?B?ZGlyVzNMNkpORUp4QU55RnE4UWJNMk4rSm5iSDk2a2FXZitVUlpFenFLaFlo?=
 =?utf-8?B?aWo4MUlGMUZ6Q0dmbjhpckxKTndGZjBhS3RhR3NRT0ljRWMwQy84QXFVVU1W?=
 =?utf-8?B?YVZKWnJTNHlQUHp4WGNHc3UvTWVsRDN0ODBQYUNFY3VqSFRKYWZyazJwMlBL?=
 =?utf-8?B?Y1FvZUNCNWNjdDVkbCtBSVd6cC92YmdxbENYbFN4QXFya1ZvMGE2ZDA2V2Nk?=
 =?utf-8?B?UDBWOWhJM2JERjNTM3hDT2YvdzYxa004ZmJsRk5NZE9ORnJzbEE0bnlYWEM4?=
 =?utf-8?B?R3M5bWZVM0FFM0pqZ1pKZ0UvNmZQcExNeWM4aS9uNm1uTXdZNEludEFKaHB3?=
 =?utf-8?B?WlpBVzUvZzVDM2pjaUhOTE5mK0trMFNNS1I3dkxReTNFUEtUR1lKRGhSSmZw?=
 =?utf-8?B?QjhCRG9yVURuTWhNYWpiMnNOR0RCVnZTV3dFb2RTTm1mTjJkM2lzVEVWWHhu?=
 =?utf-8?B?cmttMnNTSnBYQU9xRDFSWGZ2T2E1cWdRbWU5TVptSVhpakdHMG1NZ3lVMkxz?=
 =?utf-8?B?ak1EcExJOGdMZTloaDltV0dSSWVWT3paWGcvUE5CMDJQNDI2bkRQZ2Rneldi?=
 =?utf-8?B?SVZLZU81UTluVEx3NDJWRDFzMHE0R1pMYXJYRGlQMWs2UEVrU1g0STkxK3RM?=
 =?utf-8?B?bGEydUx0czl2UFNDVVQ0SlFyVFdwTGNRTUVjSTUvMWJuK1RjYnlVTWJocmtp?=
 =?utf-8?B?N1NoUVBzVXU3SE5EeVc0Y0ZsNUZVMTVXdkczUmFzR0RBaXR0K2FodGw5c0d1?=
 =?utf-8?B?RTlocksvckdkd0kzRGM0R2hJOUZlMkE3bldXUHo0ZzhPVGdUbzRrM0cvL1F0?=
 =?utf-8?B?N1UvakM1WFI4bWFGWGhBWGU1Mm5TZ01UU1dpR2RXdGRwYXRvUlVPdDBna2R5?=
 =?utf-8?B?M2J0bUlSNUlrZFA4d0ZGZ0JiZzBvT3RQOUhBdllSSkkxK1hVOU1Nb2dVZ1Nw?=
 =?utf-8?B?eVRNVy9kZnF2WHpoUHR3aGRzTXNsTG9lbVNCZWlRdU1Qb0dzN05mTU5URGt3?=
 =?utf-8?B?ZEhhRi9hMCs5VUtIbjdJTkFCOEVOSS9BcDdKK2VnTENLQkxyWGxiL1RnVlhP?=
 =?utf-8?B?TG5RZmcrSUlJRmFpWklhb1FMTE0vQVgrSnFDNUUwYVl2di9YL3paek5iN2pm?=
 =?utf-8?Q?6F48cmtAm5oRH85k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cedbad-abbf-421b-8c6c-08da50afb4e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 22:21:28.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtKYpB0fwrasczJZ9Wz17v4+VaKBpMi97q0kGYnCMOfTUM3FnoErethlzsMrl2JVDGPjDWt5lpr7EPaIc8lJpXlBgnUM8nqvyzQ8DpEnse8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/16/2022 3:54 PM, Shuah Khan wrote:
> On 4/1/22 4:10 PM, Chang S. Bae wrote:
>>
>> +
>> +static struct {
>> +    unsigned xsave:   1;
>> +    unsigned osxsave: 1;
>> +} cpuinfo;
>> +
> 
> Why is this needed? Also naming this cpuinfo is confuing.

This came from the below CPUID check which seems to be moot.

> 
>>   static inline void check_cpuid_xsave(void)
>>   {
>>       uint32_t eax, ebx, ecx, edx;
>> @@ -118,10 +124,8 @@ static inline void check_cpuid_xsave(void)
>>       eax = 1;
>>       ecx = 0;
>>       cpuid(&eax, &ebx, &ecx, &edx);
>> -    if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
>> -        fatal_error("cpuid: no CPU xsave support");
>> -    if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
>> -        fatal_error("cpuid: no OS xsave support");
>> +    cpuinfo.xsave = !!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK);
>> +    cpuinfo.osxsave = !!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK);
> 
> Why add this complexity. Why not just Skip here?

I think these CPUID checks can go away with ARCH_GET_XCOMP_SUPP.

> 
>>   }
>>   static uint32_t xbuf_size;
>> @@ -161,14 +165,31 @@ static void check_cpuid_xtiledata(void)
>>        * eax: XTILEDATA state component size
>>        * ebx: XTILEDATA state component offset in user buffer
>>        */
>> -    if (!eax || !ebx)
>> -        fatal_error("xstate cpuid: invalid tile data size/offset: 
>> %d/%d",
>> -                eax, ebx);
>> -
>>       xtiledata.size          = eax;
>>       xtiledata.xbuf_offset = ebx;
>>   }
>> +static bool amx_available(void)
>> +{
>> +    check_cpuid_xsave();
>> +    if (!cpuinfo.xsave) {
>> +        printf("[SKIP]\tcpuid: no CPU xsave support\n");
>> +        return false;
>> +    } else if (!cpuinfo.osxsave) {
>> +        printf("[SKIP]\tcpuid: no OS xsave support\n");
>> +        return false;
>> +    }
>> +
>> +    check_cpuid_xtiledata();
>> +    if (!xtiledata.size || !xtiledata.xbuf_offset) {
>> +        printf("[SKIP]\txstate cpuid: no tile data (size/offset: 
>> %d/%d)\n",
>> +               xtiledata.size, xtiledata.xbuf_offset);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
> 
> I am not seeing any value in adding this layer of abstraction.
> Keep it simple and do the handling in main()

Sure.

> 
>>   /* The helpers for managing XSAVE buffer and tile states: */
>>   struct xsave_buffer *alloc_xbuf(void)
>> @@ -826,9 +847,8 @@ static void test_context_switch(void)
>>   int main(void)
>>   {
>> -    /* Check hardware availability at first */
>> -    check_cpuid_xsave();
>> -    check_cpuid_xtiledata();
>> +    if (!amx_available())
>> +        return 0;
> 
> This should KSFT_SKIP for this to be reported as a skip. Returning 0
> will be reported as a Pass.

I think that's a good point, thanks.

Now, along with the on-going documentation [1], this test code can be 
simplified like the below changes, instead of having those cpuid functions:

diff --git a/tools/testing/selftests/x86/amx.c 
b/tools/testing/selftests/x86/amx.c
index 625e42901237..83705c472a5c 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -348,6 +348,7 @@ enum expected_result { FAIL_EXPECTED, 
SUCCESS_EXPECTED };

  /* arch_prctl() and sigaltstack() test */

+#define ARCH_GET_XCOMP_SUPP    0x1021
  #define ARCH_GET_XCOMP_PERM    0x1022
  #define ARCH_REQ_XCOMP_PERM    0x1023

@@ -828,9 +829,14 @@ static void test_context_switch(void)

  int main(void)
  {
-       /* Check hardware availability at first */
-       check_cpuid_xsave();
-       check_cpuid_xtiledata();
+       unsigned long features;
+       long rc;
+
+       rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+       if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+               printf("[SKIP]\tno AMX support\n");
+               exit(KSFT_FAIL);
+       }

         init_stashed_xsave();
         sethandler(SIGILL, handle_noperm, 0);

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/86952726-53e6-17a9-dbe0-3e970c565044@intel.com/

