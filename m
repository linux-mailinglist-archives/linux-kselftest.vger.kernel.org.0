Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52869FE54
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjBVWPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 17:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBVWPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 17:15:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F14741A;
        Wed, 22 Feb 2023 14:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677104074; x=1708640074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LBS6UQcWlANPeNeqlziFixpBVKu6XrBWvi6Dds8XoiQ=;
  b=L2/Npeoolz+wp9MzTK8jt9MWjksOdWHEpF9wyQIfMjsfNzywX2CsKElg
   ihGlGhYEVoAw/9wwTVy0oRIDK7+un2R7KvpyQP+zKR/06TUwoAlqIOZGF
   n8HoeRU6+pO90fUjWW1pL28iiNRj3cjcQ7xOoUuHpc7triAT7BEcdqlip
   4gQQk0Bokh9o09de/qSqLht54NW2Dx3OVNrsei2Q8dmbKYh9/6SdpoOHh
   OxGseb8GmJzrSDX/acVqd7aCTs5hFsZUYkMLT7i6jQIQoIcrxbdUuZLvV
   CiX5YDCwFI/UB+eIxNZGUTAKMLuTeUwAeF1dQQRw6Igswlqpr2ZP1yaIQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="333052838"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="333052838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 14:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="649714179"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="649714179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2023 14:14:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:14:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:14:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 14:14:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 14:14:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF8PY7YZiwmGnGD9jjTLWaho/maVio3fb4SZNMyyD4SNNWaDNyLqVSvtol1azLB+IZ2QbYh23CgzinfuM3BzRxkwgbLCh1jIeW2M/7jKwBfl9M4/XixZ8UbbG3PT454iGoFfqMERrT3MDEv5bJlSZnH/4kvC2ec1/aOmdFK7rL+yyPDoYtaPmyiks+ZsJL/wFPfRAZt9deex4fquZZnboRfQJJVZeVfZSs6hku4OBHYGqiiIt0hGkWP2Dw0EDJZI9zbg1KL7rey89r6GR8eIdS6aneC1HUxl/tVa0Fdsuqhy8h984sxNKLKwUuGNbGxKNv7IoSjBXUxIdIsNQs5zEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqithEIKyTyIIGqagbDu01cnhpwgyPxRrFxSB8RJ06s=;
 b=XOYVOvpw/kGIsNUai0UuX14T/bBr4Jeo+3DctJjXaR4D/RGWMmiCsPVm89aXwFZHtjweh6TyNzjNZeENIv1bZCXyaH8Vm4ihUNcUodmN3eXY6Oqu1iKuI0jG6G5/Tf1wUREz2kQsdTc/AWzZO6+O9ooeGB0i/ND6UdFiI0Nbcg1/QGx2qcEcPXabwrtyTguib+q6CxTwl0vDBTFH2VMAT/tv1pWG9VDw1AeXBhWZC/lkfeX9nICXeADuhwIOANgg2WczQufRxWnD89OaE+TJTrP6ioUh+yGQ6e/C7GMjmoawmy6YsyAKg+zkc3y7pCppY/eRhjRkWPScvylcoJ+S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by PH7PR11MB6673.namprd11.prod.outlook.com (2603:10b6:510:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 22:14:18 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::5399:45f3:1436:ce94]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::5399:45f3:1436:ce94%8]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 22:14:17 +0000
Message-ID: <ea9d7394-73dd-23c0-ea05-d0ec4fcebb55@intel.com>
Date:   Wed, 22 Feb 2023 14:13:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
Content-Language: en-US
To:     Mingwei Zhang <mizhang@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com> <87ilfum6xh.ffs@tglx>
 <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To CO1PR11MB4849.namprd11.prod.outlook.com
 (2603:10b6:303:90::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4849:EE_|PH7PR11MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: cf38f1a8-ab86-48e4-7a25-08db15221975
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zv5o+XjFdM9yoNKC4A4TBWkQePiH4loWRQwBlHRftXvx3xZlMn9f0yMHC1f7XiSKw7nfI4fSyRScxSegU4Mjqw8cfbvwSw7lLlrnLhLs2+qdkbTfkv1hFz1BUZ6bfxih80VfhXc68h26Qv5uakB7FI8DzmS4MZgnsMMblE5ggmd99ZMIwpRQQTnDzBmfpMxPyg5bsFKgYJzd3S34ReFrXBvZl31JH8ObHXW1wMjmBEv4wDOonV906vGe2caXxWplVN0Pifa1KYUqVzmspmcQtXjUwvIZRxpMlmivWioO19yLhS+9zvklaejo+dWXyPD4P374HOKEKiKwmeGNnnYt+bxKqBbu20ul/pDfNlKjxho/yYNGP2HeI8WN66jC0G/7tBs6x103OEJtZAqweJY5bMaC13wzcxN6sFmdbMcEk8DCXCNidq+WJz6rtDWRB2qyawFvuu1sEjOlKEdjBl/z5uVKaiq1YdmU86NyNoZcFpWiB/oob8w7TSjdhbEQKSN1MgyfZxEsG3QFq0xS3CqZKE9pw4x2HChka69KAO5thOuBvB28aK5TKiJftf9QXn+9K8H3kc3x8CHEZxSyo5KGaazZzDK9OFp6xr8sjsXTeyYHWbZ85W8F/nuS7TtF6WkPUJVXlCw6f7U3EG6veeOT3dVLcrICI5bol2HdEASbVtl5r8XTULc6wnWJDCAkdvPAcXWy5aoSQj6dIw1FgRndUpprAeDirz+6hFZXSTNNREc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199018)(8676002)(66476007)(66946007)(31696002)(316002)(66556008)(41300700001)(5660300002)(4326008)(2616005)(86362001)(31686004)(107886003)(83380400001)(6506007)(54906003)(6512007)(186003)(6666004)(6486002)(26005)(966005)(110136005)(38100700002)(82960400001)(36756003)(478600001)(2906002)(53546011)(8936002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9EV3JKU1Via0wrQ01PVjVhTVB4M2NVdWFMSW1xZzRQTWh6ckFrTCt3MXZk?=
 =?utf-8?B?WlRaa0o1NTBkclN6WGpXN1pPWll0MU5DUWV6REFlT05COVpNWlk3Y0VaMEZh?=
 =?utf-8?B?TjVLQVEyWXhaajZuTElaTVBldGtFOWZNMkE5bGl3Mm9QaUJ6T1dsME9tWXBs?=
 =?utf-8?B?Qk5Hd1R3NU13Y040dmtFem4wM1BMdkh6ZnMrckpveU1GdEYzYUhvVVh2U0li?=
 =?utf-8?B?NlprcHFUOGd5TkVpaXN1eUlubFdpWkhNS0RtVEsvN3ZHdWNncXoyL3ZWNDBW?=
 =?utf-8?B?L2dMZVgvNGNzTUJwWWJhZlMxNmltU2NPY25BNkVxeWhEVE9tMCtuWjFUVnlV?=
 =?utf-8?B?cSttMHJIQmZocmRGSG43Q3puSnYwaG04ZTdOb0NUUi8wcWQzN0xlejhEQlVS?=
 =?utf-8?B?by9GNXM4bGladjlZUGtyZTB6ZHJzb08xTEVZTFJ1MmdndmlRTDV6Nk93S0Nt?=
 =?utf-8?B?R04wRE9GWUxXRHdDb3haSEg5N0xBYnl0b25xZDllMmdxYXd4Y2FlcVZvVG1E?=
 =?utf-8?B?OGVJWTAzelgzalFadENrOXRrTThyQjlicnovem9jRHozYSttWVJyY2tlWm1v?=
 =?utf-8?B?OXVQdFFLZWZLaGVTK0ptcEtaU1dEZExWZUV5N3V3QXZ5b0tPUFg3T2NvWUg0?=
 =?utf-8?B?QjhZN3BudWM2NGxpZ3FIdDhJbWJ2Rk15c0lad015bEtNQjVzS1hqSzkrZGpQ?=
 =?utf-8?B?Z2szaEM0bkRlSWdVYjRtQ2twMENRd0IyL09zcm9zNkZVK1NxS3RIdTE2bStq?=
 =?utf-8?B?UTVXQmZndm5BQjN3dGx4YStZeUJlc1RKWmRmMFhUKzVLdHA2UGZ4Si9NZ1dH?=
 =?utf-8?B?UjR2Qm9tZXVsTmdTdW5FM0UvbFMxa3pERy9NcmRocW11RXhDdm84NXRMaXVn?=
 =?utf-8?B?cDQ3VDc1d0hHZXNnUURuVGJ5WHFjRkNXaU50QUZ1SDBjWE1GMnh1R0h4ZDN0?=
 =?utf-8?B?Ymt2R0VlMUtIY3lBNzFSK3R0d2lrcWRISFAwNm5kV2hDV0Y0UmlhcHBiYWFL?=
 =?utf-8?B?cWRjQk5vMFMvNExlYnBsZUxOQmJZdlpwZmwrcnJIc0xvclkzVll5OHBkSUsz?=
 =?utf-8?B?ZWppVjBmOEpMOEYwemlmeklIblpLcU9DYlhJeG0xMEhscU9qMmNqVGZDci9p?=
 =?utf-8?B?OVZJRGtaT0U5Nm1WYjFjb3RmZVp4amFEQ0FSajhjLzNYS0VLbERaRm9SVlE0?=
 =?utf-8?B?R24xeENEdzNRMWc0RTBWTHBGekx6dmx3a1JydmMwSEg2R1EwZU9HdUxlZmFa?=
 =?utf-8?B?YStFRVdZanlxY1kyK2lMd0Rna2haL3BDeEs4SnZUWFJmN2FFU1p2V2ltQUpv?=
 =?utf-8?B?RkFtU0t3VitMWDhteEw1bXVCZzZRaTl2NlFoL0xwNGZOclJXMmVnM0diT0w2?=
 =?utf-8?B?a1I5cWR1Y05Ia3dNTVpYempvekUyMkFzekdGUGhYNFJ0ME5LNThuQ0s3ekMr?=
 =?utf-8?B?MU1hVFR4dHpXNkZjTUg3dUluUVc0b3FHVDdjUnYybkppRFB1NEJoN1k4VFl6?=
 =?utf-8?B?ZnVkeTArU2RxMUZEbTBnZ0xuaG1YZlU4aE84bFhlVi9MRWtzQVVVTUsvbWRi?=
 =?utf-8?B?QWtla2F2dTZ1STFEVHdwMWdFcG9KWEQyNU9iL0pZanFRa3pBZm1qL2xLZ1FV?=
 =?utf-8?B?R1FTWDhMZkxTRG9iclpJWG91WUF4K1VZSUFjVnc3MWVBaGlnYVd3UFVhdlUy?=
 =?utf-8?B?WURvZE5lN1hPdWVGSy95RGVhT0Rjeng5alJCQTRBK096emFNUXZsRzVYRG8z?=
 =?utf-8?B?UkYrYjhYdzhvR2VUS01VUE54SVdiZmY4a1lrSlpEaStuUXFTRncyQXRsR2tr?=
 =?utf-8?B?cUNoaWNhOWZMME9EM0RGYkhRWmFyMU1naW9PY1RwNmtndzk5Z05CQ01OeVNO?=
 =?utf-8?B?blh0N0NaYTc3UmJmRXk3Vy9FOXFsNm9TQy9Tbkk2SEszcXVSUDRvM0JGdDFB?=
 =?utf-8?B?cWE1UTA0K3dVTlNyeU5FM3N2M01HMkFHVTFsNmNvK0FhRkJPODgrbkZVdGti?=
 =?utf-8?B?M1ZDajdZVXVxb3NwemlzR202Tm95SHJvb2EwQUhLUTVHeVhTZ0ZZTExzVUhW?=
 =?utf-8?B?N2U0WTV6ZGlMMnJLZTJJc3RwWWg0cTg3MEhuaHE4c1RSRk1WaVN4T3NuS3NS?=
 =?utf-8?B?WEZ5QlcvWXl2bk5XQzNSNWEvRGQyOFIxKzB2U1NpUVZMWjVONkFGNVJ6NGFF?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf38f1a8-ab86-48e4-7a25-08db15221975
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 22:14:17.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x4zqR8yCthuOYtOHGS5hQr2bzYrK8XqU2nH1YQrNG6tushakd5nRIqWSuBsz661UtLSXxi/AqFsPKWUbrOFt1pU+yaUPARe+DQnjTLQxjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/22/2023 10:40 AM, Mingwei Zhang wrote:
>>> We have this [1]:
>>>
>>>        if (fpu_state_size_dynamic())
>>>                mask &= (header.xfeatures | xinit->header.xcomp_bv);
>>>
>>> If header.xfeatures[18] = 0 then mask[18] = 0 because
>>> xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm
>>> confused about the problem that you described here.
>>
>> Read the suggested changelog I wrote in my reply to Mingwei.
>>
>> TLDR:
>>
>>          xsave.header.xfeatures[18] = 1
>>          xinit.header.xfeatures[18] = 0
>>      ->  mask[18] = 1
>>      ->  __raw_xsave_addr(xsave, 18)     <- Success
>>      ->  __raw_xsave_addr(xinit, 18)     <- WARN

Oh, sigh.. This should be caught last time.

Hmm, then since we store init state for legacy ones [1], unless it is 
too aggressive, perhaps the loop can be simplified like this:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166cc25f2..2dac6f5f3ade 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1118,21 +1118,13 @@ void __copy_xstate_to_uabi_buf(struct membuf to, 
struct fpstate *fpstate,
         zerofrom = offsetof(struct xregs_state, extended_state_area);

         /*
-        * The ptrace buffer is in non-compacted XSAVE format.  In
-        * non-compacted format disabled features still occupy state space,
-        * but there is no state to copy from in the compacted
-        * init_fpstate. The gap tracking will zero these states.
+        * Indicate which states to copy from fpstate. When not present in
+        * fpstate, those extended states are either initialized or
+        * disabled. They are also known to have an all zeros init state.
+        * Thus, remove them from 'mask' to zero those features in the user
+        * buffer instead of retrieving them from init_fpstate.
          */
-       mask = fpstate->user_xfeatures;
-
-       /*
-        * Dynamic features are not present in init_fpstate. When they are
-        * in an all zeros init state, remove those from 'mask' to zero
-        * those features in the user buffer instead of retrieving them
-        * from init_fpstate.
-        */
-       if (fpu_state_size_dynamic())
-               mask &= (header.xfeatures | xinit->header.xcomp_bv);
+       mask = header.xfeatures;

         for_each_extended_xfeature(i, mask) {
                 /*
@@ -1151,9 +1143,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, 
struct fpstate *fpstate,
                         pkru.pkru = pkru_val;
                         membuf_write(&to, &pkru, sizeof(pkru));
                 } else {
-                       copy_feature(header.xfeatures & BIT_ULL(i), &to,
+                       membuf_write(&to,
                                      __raw_xsave_addr(xsave, i),
-                                    __raw_xsave_addr(xinit, i),
                                      xstate_sizes[i]);
                 }
                 /*

> Chang: to reproduce this issue, you can simply run the amx_test in the
> kvm selftest directory.

Yeah, I was able to reproduce it with this ptrace test:

diff --git a/tools/testing/selftests/x86/amx.c 
b/tools/testing/selftests/x86/amx.c
index 625e42901237..ae02bc81846d 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -14,8 +14,10 @@
  #include <sys/auxv.h>
  #include <sys/mman.h>
  #include <sys/shm.h>
+#include <sys/ptrace.h>
  #include <sys/syscall.h>
  #include <sys/wait.h>
+#include <sys/uio.h>

  #include "../kselftest.h" /* For __cpuid_count() */

@@ -826,6 +828,76 @@ static void test_context_switch(void)
         free(finfo);
  }

+/* Ptrace test */
+
+static bool inject_tiledata(pid_t target)
+{
+       struct xsave_buffer *xbuf;
+       struct iovec iov;
+
+       xbuf = alloc_xbuf();
+       if (!xbuf)
+               fatal_error("unable to allocate XSAVE buffer");
+
+       load_rand_tiledata(xbuf);
+
+       memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
+              &xbuf->bytes[xtiledata.xbuf_offset],
+              xtiledata.size);
+
+       iov.iov_base = xbuf;
+       iov.iov_len = xbuf_size;
+
+       if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+               fatal_error("PTRACE_SETREGSET");
+
+       if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+               err(1, "PTRACE_GETREGSET");
+
+       if (!memcmp(&stashed_xsave->bytes[xtiledata.xbuf_offset],
+                   &xbuf->bytes[xtiledata.xbuf_offset],
+                   xtiledata.size))
+               return true;
+       else
+               return false;
+}
+
+static void test_ptrace(void)
+{
+       pid_t child;
+       int status;
+
+       child = fork();
+       if (child < 0) {
+               err(1, "fork");
+       } else if (!child) {
+               if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+                       err(1, "PTRACE_TRACEME");
+
+               /* Use the state to expand the kernel buffer */
+               load_rand_tiledata(stashed_xsave);
+
+               raise(SIGTRAP);
+               _exit(0);
+       }
+
+       do {
+               wait(&status);
+       } while (WSTOPSIG(status) != SIGTRAP);
+
+       printf("\tInject tile data via ptrace()\n");
+
+       if (inject_tiledata(child))
+               printf("[OK]\tTile data was written on ptracee.\n");
+       else
+               printf("[FAIL]\tTile data was not written on ptracee.\n");
+
+       ptrace(PTRACE_DETACH, child, NULL, NULL);
+       wait(&status);
+       if (!WIFEXITED(status) || WEXITSTATUS(status))
+               err(1, "ptrace test");
+}
+
  int main(void)
  {
         /* Check hardware availability at first */
@@ -846,6 +918,8 @@ int main(void)
         ctxtswtest_config.num_threads = 5;
         test_context_switch();

+       test_ptrace();
+
         clearhandler(SIGILL);
         free_stashed_xsave();

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n386

