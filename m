Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98935501940
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiDNQ65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbiDNQ6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12209E9CA;
        Thu, 14 Apr 2022 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953925; x=1681489925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=spY+lDBwAqs4BVVdKqZv57HjOo3MKJD9m+JGRQ9tet0=;
  b=PydJZNoLALbCLGhZinRjjAm07ekD7PDWQWXhE7e3419Fgp2f+CX352pd
   80TY1bAPc5+4EjE3AFccHPXJK+XP924hKyFMMBPwWQjBMGYlZw7m1Hx70
   T1USz6vw4EiXX+ZwcD3EcXJopk3oQZn8V7gHigd0AuzuLgxQvda+iW0R9
   YnjIxxA8/E8A8FUhAnEit9SdFCxhMHFMJMZXTDe/2riidmWqPDOVc8ytz
   bbLGh53JzcO7QjtgDfj+d13lYCA2+pApj558vFm/+ycPOnMwPKFE4TL6I
   x5TIe3MsA2dC6l2czOr3OtnGEZxkGOjooypuqVfHllF/LJFpHooLTcdEx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349406732"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349406732"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="552753790"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2022 09:31:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:53 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:31:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1Yc9tICZRwQb2rDubq730ElNrOugfDLw0hitkUNGKHzn0j4oZS9h9EBav/BDgoPPSAI0CY69KDrfjkgwsnFJqXUOQPcHopLFw7frLfcmHDtiN807Lkyvk/WIdMZ76FtvDBHfMIWFLPgEBJPSwgiSlhN0Zew7EW35LZFvYMuZ20xDoPafhNnyhNiMfG8UJv4+mkmHBP8pR2SLpURY234lxQbMhg+Zuz6mpywhT4rmhfGrOtInqRYUx8HiCLeqcD5obigiShQVr4ytmjiTHAD5U4S+0p7GmGVmQB5Ig4Cd+lFJa41MKqKdqzRkQD1Fdy+/+62s6DFlJ2CoNrEUlBSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc0POJ675UcNhLKdNUdjxa+rjvAEtUJa5Bbi/mEySaw=;
 b=dTtUenneDTfPQHq8LSloyVhWrgvDgh1Z81RuomL2+AfGriErb3enzrRnob5tUS+uGfd+yfkMCln87Sx14A+V8Qc9KT0yVQTv6bE7W1AIlh3I+eB9wqTv53pku+goqOjCjBp64NmcHq/E7Bk9o3jQqrAbXI4sSkNRrl23OML7x+TSh7YwhxN/3x/myye64myaFg1Lg7lCuFMnFNRmedFo3RtCF27aAWKz9aF8Q4H6pw+U46wppDEzaMfdJC4QEqBMU4PhU2GPXbdZ7WtQH4Y5B/cCHzmO2VO4wrdqB1HE5vVAa+rKMmp3W4ufP/n9YkLfp3snOTgQ7+DFxrrroS7Z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2347.namprd11.prod.outlook.com (2603:10b6:3:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:31:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:31:50 +0000
Message-ID: <009250f0-dd3b-ed4d-b6f0-f7b2d6f8c9cc@intel.com>
Date:   Thu, 14 Apr 2022 09:31:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 16/31] x86/sgx: Support adding of pages to an
 initialized enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <vijay.dhanraj@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2293bdca025ce54bd2996783e187e209f9c0f5f2.1649878359.git.reinette.chatre@intel.com>
 <8b36c54def8948747a704676491cc18dd08b48e9.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8b36c54def8948747a704676491cc18dd08b48e9.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d7af3d6-dc58-4184-8962-08da1e3446d3
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2347:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB234718F285F8D03F822A77B2F8EF9@DM5PR1101MB2347.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MLJrmX4XSPji0CLdBeXqXTjrLR93ZovjrHvrO7LGS4JYv5UFo862iFqygCBsPQYBnyUpzuPEQ0QCK0TnBW9siC1hU2AefE0YpDG18ALjX1YMh7uP6sR293qZr4QkmGat3t66tmrWhEn+OVu4jWsstR3W7T5pUi+f9jGZctpiCrX/foT5YON10jhx6W6HpYrW+QuuzYrXMJ2IvWsi+Gi1V/2jxEcUP8YmghMMYWgQJARQ0PiLZHzkmE7N2sIOQOjlaPyxTk9yo4coEUgfqEWASqnctW7vy6YBqVHGxxalzJUdh/kzUUnNzVmRaYX5/a8vMJsEYsykqLz/EcYRRNhqpvdJCvTGaE3aUTzfvFReTuA8aXmWUkpEFtwx0f8U8JzfOoKkqPjFnlWQjPccV8/cZjPHaiMjD8vOduMwtSgB2hEqE5312YizSzAS/Hdlw62KN7uWxbvhaijunFEOw+3Sa1soiCVA+uAhay78PdMaE4AybnT7WlLr/NMamUn3lyCZDf1etjCMZ6Fwh/RFYNqpXUFUd6sgxLV4zJV/r4glnAu3g/IehN9bZaaRhZPnvNRxkbJ69eG2XMHOzRmCeueCkgv05hs7Cd8653xmpVl+cmvKDn3XlDOESh/7+V7Z/UIkrT0vQxDxgBr9vBA2yE2tDaFcVxQOFA/GFZG5kFKnAgaTxWBF/IEw71jR/gsFmhNRD35MdJKm8lDyQDSOExb8G769mXZBFVdzuW7/dlokupM4/lrtdlxM3bJHVmiE8DXPRf39TH2ErA5/acbuuu5iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(86362001)(186003)(6486002)(26005)(6506007)(4326008)(53546011)(66556008)(6666004)(66946007)(8676002)(6512007)(66476007)(2906002)(8936002)(5660300002)(31696002)(82960400001)(44832011)(921005)(38100700002)(36756003)(7416002)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlsc3ZBVDk0RXZyT2owNmMrOUUwMS91Um9hOUFQcG4wVldVL1J4ZzBYVHJm?=
 =?utf-8?B?cUJUcGJqMlVhQlo3VXlUTjhOY1BFdjBBeDhEQmZpZmRIcGM0VTF3cEJVTVJo?=
 =?utf-8?B?b0hUSXQ1Z05CclVrdkJ2WStwc1NhVGR5ZmZESHNxTmxVdGEzMzhQblZldnpR?=
 =?utf-8?B?dHV3OVcxRGd3M3J6UWhQTUZEaGRIOUhodDlmdWZIa1Z1czRTc0RpL203VHc4?=
 =?utf-8?B?TTMxNU5QZFJqODl2Q2VGZ2VIYnJoelBlczd0MnNNd3M1QkZSVkNoY2hSSE1h?=
 =?utf-8?B?bWtGUW1ESS9LQ3pJTzhiUTZpTWdiUHNCdDQvd25FWGZTK1A3dFRKRGI2L3VX?=
 =?utf-8?B?bTdnYkxqQ0ZyQWJNZDV0ZXlCTEo1d3I4N01rVy9tSVlqZ0hiR3V1WTRQcEkr?=
 =?utf-8?B?eE1xZm0ybXlheEt3ay9oQjdUcDRlbE55OXdIT2g1TG5CVnBoUEltd2lSZDFY?=
 =?utf-8?B?dnlYeDk2a1B6Q2hMT29RQzg4QngrSjR1UVMyWWNQZzR2dG1VNTFBRXg4a05T?=
 =?utf-8?B?c0dEM1dvSU9VY0dXQjNQMXVWSGRLQy83cEFFbjJPdkRpV1ZCSVhFRXlNOUow?=
 =?utf-8?B?Rkh3TytwNU5QYzRqMzdxc2Q2T2xBS0p4MGZ6am5ud0tlL0pzWDNmeGhWeS9m?=
 =?utf-8?B?SkVRczM2bTVQYnVOL0toUklUU2hndk0xeXk5d20yb012bDZ3bkk0WFlnajFm?=
 =?utf-8?B?dWNKSWZTdCtoSVV0d090R2lpUmZhZ3VLSmZBWStMWGIyQ0N3WklsbzJUSHNR?=
 =?utf-8?B?V0RiazIrNVBqV0R4L2dOUzhGdzNZYlNraTlvczZ5MklDRUNHT0QwbldzekUz?=
 =?utf-8?B?VnBOTytMVW8zY3QvR0x5b21xYUpIUXEyZnk2REFtUlgzRUZuTDVUQStSVzRK?=
 =?utf-8?B?R0pzL3lQOSs4NThrZ2NVV3o3NnQ0Y0JiRWZEV0VGaFZRQS82Z0NVL0xGK3VU?=
 =?utf-8?B?Y3I2K0NWMVIyY0w4MFA4dW9hQisyL3ZWMTVCNzMxWk10MndlR3dZbzVSSi9u?=
 =?utf-8?B?WUFtejFTaXU1akxXYzN0eURwOWJLT2graGZFTiswNFFxR281Z284b29HaXc2?=
 =?utf-8?B?NXpqWXZ5VFB5UExFb1BWWGRFRFIzZzNubTV5T2tGUjFvcGttYndRQWkzZVZk?=
 =?utf-8?B?bXhPRyt1Mkh2SmYvaUVyeXNPQUEwc0d4MDlJdEhxNUJBM3ZVZ1BVdEtQVzNE?=
 =?utf-8?B?ckhSNm9wWFVwWEVYRWVZR2E2b2pqdXpZVmQ4Zm5vMHh4Y0haWjlZWmtvaTBV?=
 =?utf-8?B?ejJGcHhxS2I3M2xrQzNJN21pSlRSUTNWME1KMitYdkxsS2l3YXFUWWFBdFZ5?=
 =?utf-8?B?ZUh3TWt3ejd1VDFQTS9tZjk3a1MrclNGZGZDRjlmdW5pWXkyWEdyd09UR0xY?=
 =?utf-8?B?d2hrRkphUU5nUXdBcHF5OHJmTFM4Z1FWaFdTYUZzWTR5aklwRFJqWFRPYjdU?=
 =?utf-8?B?d3dzY2ZFTXlFSkpmWjVxS1VQelVLS2JYc0o3cDl5K01LajgyanRHc1ZlT1Fs?=
 =?utf-8?B?d0sxWW9RSWtreXVFaXhIcUxvVzRJVVdGTk5rOWJJM1ZvZHIrZTNtd1FVbDZG?=
 =?utf-8?B?aGh5anNFUlBteEl3dDBkYjVWWC8vUzRxMytqSTNRbWQ4RkVaMG1KbXhUZHA2?=
 =?utf-8?B?VzRqWE9UUUJBdFc0THhjU2J4VGtPbjFIQ21ldEVkWWc0U25lWmRVeTlDMTJ2?=
 =?utf-8?B?NTJIV2FUZUVKa3hOQ2RFbExndHVjak1HTEZUejFNc0MxR1ZyL2pmRHFsejZ3?=
 =?utf-8?B?SzVKaHd5WEpiZkxiT0dXM0RPK0NZNXhPeXhSeXFNaTN5cW1ZR2FnbGpEa1FR?=
 =?utf-8?B?d0ZGbDhFaTRqL3hSclZkY2F4SjA0MVNaT3JPcldBOUl5UVhPL3dqOWYyYi91?=
 =?utf-8?B?REo5YzBjRERWQ25yU2UyMUp4TTBqRVFWWXlvbkxWamtDam5rZitGUWg2RHhS?=
 =?utf-8?B?MlBTZmRpRFlOK0lvTzBUdTBoUWZmRzJnZzRCTjhwQVBlM3dsOTBiSGNXSmhr?=
 =?utf-8?B?ZGhpWmdlQXBlQml4UXJSbzMzbFZodmJ1RURFb3ZDR1JNUi93MnNMbkJUOWoz?=
 =?utf-8?B?aGI3QjBqUVRvYXc5TkZSZU5UV29iOFF1T3RZcWF4RC9nbEpJbE9kcmtWRWtQ?=
 =?utf-8?B?NXc3SW1oRiszSGo5anpKaUY3OGM1aXVlcnhNTW50NWtOdGZLZWtRTnIxZjFZ?=
 =?utf-8?B?VHN4Z0RjaW1OeUh2OERnWGFMWE83bXRrUXFUZHNKK0t6R2I4ZkJkc2xjK1Ft?=
 =?utf-8?B?UGIrekxuQktJbDkyRjA2YmEveTk3MDFTckhXM21qaDhHYkxBSGN4MjVjWS9s?=
 =?utf-8?B?STZiMGxWaEpvYU55eCtnd09qdFhCRGN5UUxka0dmOEZObFRud1N2MnNFenRq?=
 =?utf-8?Q?1YB0jDWsj9SdQ8wc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7af3d6-dc58-4184-8962-08da1e3446d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:31:50.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RukwKzc8Gzn5suDawY56v0alDxObMfK38aDh7xwHaLffvGIQdd6LjTvaUAY66VGgX4Wr53GsMoC+/uBC9vdqYB0LFivv9/5Ob9emFNgamA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:20 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>> With SGX1 an enclave needs to be created with its maximum memory demands
>> allocated. Pages cannot be added to an enclave after it is initialized.
>> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
>> pages to an initialized enclave. With SGX2 the enclave still needs to
>> set aside address space for its maximum memory demands during enclave
>> creation, but all pages need not be added before enclave initialization.
>> Pages can be added during enclave runtime.
>>
>> Add support for dynamically adding pages to an initialized enclave,
>> architecturally limited to RW permission at creation but allowed to
>> obtain RWX permissions after trusted enclave runs EMODPE. Add pages
>> via the page fault handler at the time an enclave address without a
>> backing enclave page is accessed, potentially directly reclaiming
>> pages if no free pages are available.
>>
>> The enclave is still required to run ENCLU[EACCEPT] on the page before
>> it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
>> on an uninitialized address. This will trigger the page fault handler
>> that will add the enclave page and return execution to the enclave to
>> repeat the ENCLU[EACCEPT] instruction, this time successful.
>>
>> If the enclave accesses an uninitialized address in another way, for
>> example by expanding the enclave stack to a page that has not yet been
>> added, then the page fault handler would add the page on the first
>> write but upon returning to the enclave the instruction that triggered
>> the page fault would be repeated and since ENCLU[EACCEPT] was not run
>> yet it would trigger a second page fault, this time with the SGX flag
>> set in the page fault error code. This can only be recovered by entering
>> the enclave again and directly running the ENCLU[EACCEPT] instruction on
>> the now initialized address.
>>
>> Accessing an uninitialized address from outside the enclave also
>> triggers this flow but the page will remain inaccessible (access will
>> result in #PF) until accepted from within the enclave via
>> ENCLU[EACCEPT].
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> I'm presuming that Haitao tested with this applied, right?

Yes, I will move his Tested-by to this patch.

Reinette
