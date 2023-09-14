Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1C79FB74
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjINGCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjINGCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 02:02:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CC8DF;
        Wed, 13 Sep 2023 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694671319; x=1726207319;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x4m+hBPfEVAPKF/DgbzPIFCQ9IMRP66naWb9YtOIHNo=;
  b=HFdWYIJq2umV0kYNBW7wTVQtSa9HZ2wJIZ0s3MSy8eZtwSCtKngNIYs9
   w54KCA6LVIlMeM/EjTrHFMhFqe+KAQQpY4hENW3HK2k26lFKhv4XLCEVm
   w3ZZqB4saugeE/iBsbuv6g8Pc+No/Oo4eGiHkohdXnHKa6/oNPFHJ29+S
   BIxuTTBxLGdnUZ/jiESI15qwhEzhAFYwMOF00lKAGCjRhjS4Yb20CcSvi
   BSx4GCWBv11abWERJtn6M70sdpt1ij16D/CXzJmqOHicGEBuYgOzbxdaB
   F1Pd+Sq+gzrkBhiwey2FJMOxCjbPI/6bIcyitmytmdnxU7rDQ22PjgArl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363900164"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="363900164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 23:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859569041"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="859569041"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 23:01:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 23:01:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 23:01:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 23:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9uDXprOalhke1TQ1/rTew3Vm/HYrTRcUr3iOZviVBehM2YSNdwpPFvLu8h5Hca6jkrZ46dnprSlghMKQW+VjnlTIIttIAmdazgTgNBU+aj5mB5ndkviXNK93+9Y3pOABLdHM1geMKJR15l3w7QFKv+kSEMJj0aJnPctv3U8PZ2EDUecilck6VRE9oDfMWzt9EIrLPWPCkuzPDb4aMgCilHBjdLbvo/yE+NYSRbJGtpx3FS+neePGHmZIYV9yGszPeAmNMIIvMt9G0Ns0OsdwLIbWcrIFlM5ZnFfBsRIbo9vvrLVrJyb8M8eeJ47ecoybhjet7MYQALuF9mdMGuQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQf2snuFnqc8bQdW9H0dxUIFcFLcNABWt1iv3Ec8cAQ=;
 b=WWk3UdtQZkMzvxoOOxD0+f/LHmNdwehwwNM6lSD+Ulf582HZjtOviIBnAOScupCXpiSsxDKrkNx6r7l5hKjMN8KaybEtWUsUnGHgwE54UeL00yOgf++lQjlcKJEsR3LSUhfFfE29hm/GvVQnsfdv/9DEIuFTM4j6QWi2FE/FhbL32bkCp5ksHkkz1Rg0k7LNPLQAW1EvLEJw3T2maV4jYrFEWOhcTOEG27Dyv9qmIDlxtV/Up6dSkTLYsWaYhWLrDaqQ6+pD3jtzlYAfAOHmSHIWTvSP8aS77VpDEvkOEaDEMN5Pz8ujg4Va37zEYgAQHfgnwoe67tgAaAzYSmpvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 06:01:55 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 06:01:55 +0000
Date:   Thu, 14 Sep 2023 08:01:50 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write
 error check
Message-ID: <ycbcan5wcxtz2mbywz6zdoyfus26vrhus6enipe543x2ejyt77@m3l4ksir7k2k>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
 <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
 <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
 <jyxp5mspjn7xbmclj5sumbsuwd424fqmdvntiiuq24tiz5yqb4@qunho7whbamf>
 <6d6dba28-a7f0-1f49-3f59-4e0026d0c2b8@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d6dba28-a7f0-1f49-3f59-4e0026d0c2b8@intel.com>
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc625aa-e624-4e8c-c69c-08dbb4e81947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CjXj9j8TPIwVL8gYvTumrb8hqHebwhupC0bXMViQ3Ck0FkOplHYEqnEtZ30UG5Pu66m/dz1dak9ZkO7Ff6Juyq9CYqXC8cdSkNqLyAOVRnW622/yMk9f3Yd0gpAI7qNMCGhhOcEupnyB6LVPd5qaPA5i4pYiaKj3179XM0xCJ3pnMALm88A5RymzJ3bgXRlxDxU2eiTs/fNQSVRTmyfx7DbmwUnZc+L4j4867iR2OVYUPR1swyoOpICobP+FCN9/Idz2PvP1l3iY0TEJypuXBHz8ezt5VvNMqdbBP8/1821xgIffOckmYnJNptRx5LhWq9AOcegeGWqPKOl3R5i6FXppgEDtpZTv1NYSE6Ii88FlVpV7Huvt0mqKRLilfUc7ZofaIJtXw0dVmJTRXo1LiINqODRf4DStQOP6yUoh9AIJV8/LNUcJZAQtL0bHtqvmq78XX9YwfXvO3Ts3AJUX912UMbUlcLxEyzfxc8xJzyqfV2AwGYOWC9jp2Tumk3Hohq8i6xLNNf46MRPxUiOeqj1o/Q6VQk/zSqaedczxY6CtFNWh5kLvdPE3kaF3ULT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(26005)(5660300002)(66556008)(9686003)(66476007)(316002)(6512007)(54906003)(6636002)(6506007)(53546011)(66946007)(38100700002)(8936002)(4326008)(8676002)(6862004)(83380400001)(41300700001)(6666004)(6486002)(478600001)(66574015)(2906002)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE04azhoaWg1QzF5aEdsT3ZBSUxSOXA0K2swekdQRU5IRG93aE9MKzQ5TjYw?=
 =?utf-8?B?QWxtai9mQ3VQa3N4Wm9sam1VYlFXdHhBN0xLSmcrNUovWjRSNldQblVWQngy?=
 =?utf-8?B?bkkzUkVnZDZhcXlXbEQ3MXVoMHI5bWJmOHdFQmFlOXY4eWNRVHlLWFZicjM3?=
 =?utf-8?B?SUViRUNDRTFDeHREN1hpQUU2NjlzQjQzU2RMbGFNZlR0TStkb2NudFp4eVB1?=
 =?utf-8?B?V1lDNGdLT1E3Ky9zL3FSRWlrOE5vc1ZCNlY4Q3BRUCtlUmR3ZnZZcjRzdTlN?=
 =?utf-8?B?QkNHeHZmL1FxL00yTUpJY3F2U0ExM3JuQ0dRL0FOYmlpTGE2VXJzOFV6VG81?=
 =?utf-8?B?QkhzbEJ3dFA0RzVpSlFsaVo5cklqelUwRGE2SkFEMnUwRDZYeGp6Q0RaVEV3?=
 =?utf-8?B?NVRFSXdYWlJSZ0k4TkJrOGVzQXpLbVc2eUs1NnRzRGFYbGNtSmhKMU9RMzhO?=
 =?utf-8?B?cGZjdFpNRVByWG1SMkZuUFVldThEeU1BbVkyN0RqTEJsQXk1NTlEdmRHWlg5?=
 =?utf-8?B?bkF3c0loanA1bjNZMGxEKzgrREFGTU85anJEc1VuK2FybWNBWTBvTUdIQlJZ?=
 =?utf-8?B?QzNGNVRwb0l2MFBWVWpFSUM3QzdYMXQzQmNXWGNHa2pzNDB4NTl4RnYxYXZk?=
 =?utf-8?B?NkZnTEhSMUErTmZYZ1kzbHhkMkY3WG1rOTQ3OUl2OXY4Nk9UeElnbW9wMFVI?=
 =?utf-8?B?dTV2bXJTaVY5WTdkbUdCRTVWMHZlQWozQ1dUK3dYZ2ZlZlVEeEpNN0pHT0dN?=
 =?utf-8?B?ZUxUMDNkSGZRUTMyVWFFUzJHR1UwN3N1b1Bud2Nsbk1tODRTaUdqSXBQak5C?=
 =?utf-8?B?Wm13eFFZMkF2M3hVcHRYSlc2Z2ZoZzJZUWJ4cnUxQ29vWGFKd2RIUGJBRCtj?=
 =?utf-8?B?WmxQOHhEcWhvTjd3a2E3Nko4NWlzY1hGcFp1Ykk3Wmw1N1VyYnQvSXBPNmpO?=
 =?utf-8?B?YU9oSzN3cDE0T0pqSy9TOER6a1FWRGYvQkQ5V2R3ZkVaR25PMVlKcU93RkVS?=
 =?utf-8?B?aGZ2QWI1Y0MvWlNLTXJpQ3VETFV2UXFJTGRSUTdIOFdjQnMrQmgyZWZLZ2xm?=
 =?utf-8?B?b2cxMHVWZW4rMndJbmhmU3dsTEZ3YStCSzM5Nzllekt5bm9BNlVWTmNhVldG?=
 =?utf-8?B?bjJRUDhwUVhQZ3BSeTd6d0o4Y1pVVUJlVnExRnF3bHM1OUEvQ0psUW1KaHhB?=
 =?utf-8?B?SXdrMGRuYzhxTXVjaE0zUmNZeVlzM0NQTjZaWklmc1JJK2ZqMVVoNURZbGlQ?=
 =?utf-8?B?UVZWVXVxODN6N3ljdkkyR3lqVTZmeUgvbXJLWlNhbE82M2cyc2ZIQVpmTTl3?=
 =?utf-8?B?RHRxanN6SmNCQitCRURuR3Y0ZEs2NFJhL21YWlpDcDg4T2RTZkpLamxPTjlx?=
 =?utf-8?B?Nll5QXEvRDYveGU2K2pwOXYzWnFjc0VnbjFINjlNSHF6eWg3V04rWVFxOEQr?=
 =?utf-8?B?U0FtSmFBNzJrNUZGdThPdUZPeEVGNWh4MnhZSWJkLzQreVlnRU5BcEFKWll6?=
 =?utf-8?B?ZmdmbnBRT2QyazY1aTJuZ2hlaWhmWG52elpOZC9QUmVpeVl6V2VrSGMxSUls?=
 =?utf-8?B?S1VqZldwWnlSSFlaY215dXBOYkhUTU9OdTV2VUg4b2UreXVPUXRocVdtbGNx?=
 =?utf-8?B?SmpKeDVmUWJoRC9ybG5SWWQ4bTVaWCtXOUYvOXlHMFpLMkdmQVpyMkg1L2J2?=
 =?utf-8?B?N09ZRlZOcCs0VURpb052MXZGdE5xS3lnNzd0elVydUtTZ0Nva0ZPN2dSOUhO?=
 =?utf-8?B?d3VxRzk4Mjd2OGpoNVg2OGNPT3FCOU96ZVY1SHJlTm9WbTBxeERwZkRscGxq?=
 =?utf-8?B?K2MvMHlmdHc5ZHY5cmRaVWZZbWZ3cTJ1dXVLbEw4ems0ZnBZNmdNL1lkeC83?=
 =?utf-8?B?MkFOWmpNelFzejM3bThsVTk3M1pManR2OG0xSkh4L1RCUlVmVm1TZ0Zzdnh6?=
 =?utf-8?B?NW1wbTdESnZhNnAwUWtGTk1CZXIxKzh2M2UrTHJieFh5YzVWL0pwNzhBREpI?=
 =?utf-8?B?WThVYkRBWHhUeEZVNTB1SEg2RWowMjNQd2JWZWpTaFZ0eGM4d2l6clRGK1Bq?=
 =?utf-8?B?K2FETVc2RjVSTmtVTGtQZnBLSDR3TjVWcWZJQ1ZXbFgzRkRoZmtUOEs1Q3dj?=
 =?utf-8?B?TUlTQzM4Z0Z6MEJLb1dxVXNJZ2s5OVhYMDFSTVQxTHBhSWR5R283L2gxQmJU?=
 =?utf-8?Q?7twM1eslHFE4WQGmY0TQDl8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc625aa-e624-4e8c-c69c-08dbb4e81947
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:01:55.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2ZCwzZDODyqIEbWOCJsIwX4ZudYlgwKMQ8mZzXePBXOgrPap1beFHu3PHDHZzYs0jNmGqnsXQ05ZaGFtzIoaw/n4nxE90kAk/zDnkIsmP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 2023-09-13 at 11:49:19 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/12/2023 10:59 PM, Maciej Wieczór-Retman wrote:
>> On 2023-09-12 at 09:00:28 -0700, Reinette Chatre wrote:
>>> Hi Maciej,
>>>
>>> On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
>>>> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>>>>> Hi Maciej,
>>>>> When I build the tests with this applied I encounter the following:
>>>>>
>>>>> resctrlfs.c: In function ‘write_schemata’:
>>>>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>      |              ^~~~
>>>>>      |              popen
>>>>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>      |                                 ^~~~~~~~
>>>>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
>>>>
>>>> Hmm, that's odd. How do you build the tests?
>>>
>>> I applied this series on top of kselftest repo's "next" branch.
>>>
>>> I use a separate build directory and first ran "make headers". After that,
>>> $ make O=<build dir> -C tools/testing/selftests/resctrl
>> 
>> I do the same, just without the build directory, but that shouldn't
>> matter here I guess.
>> 
>>>> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
>>>> source directory. I tried to get the same error you experienced by
>>>> compiling some dummy test program with "open" and "O_WRONLY". From the
>>>> experiment I found that the "resctrl.h" header provides the declarations
>>>> that are causing your errors.
>>>
>>>From what I can tell resctrl.h does not include fcntl.h that provides
>>> what is needed.
>> 
>> I found out you can run "gcc -M <file>" and it will recursively tell you
>> what headers are including other headers.
>> 
>> Using this I found that "resctrl.h" includes <sys/mount.h> which in turn
>> includes <fcntl.h> out of /usr/include/sys directory. Is that also the
>> case on your system?
>> 
>
>No. The test system I used is running glibc 2.35 and it seems that including
>fcntl.h was added to sys/mount.h in 2.36. See glibc commit
>78a408ee7ba0 ("linux: Add open_tree")
>
>Generally we should avoid indirect inclusions and here I think certainly so
>since it cannot be guaranteed that fcntl.h would be available via 
>sys/mount.h.

Okay, would including the fcntl.h header to resctrl.h be okay in this
case? Or is there some other more sophisticated way of doing that (some
include guard or checking glibc version for example)?

-- 
Kind regards
Maciej Wieczór-Retman
