Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5B79F15D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjIMStc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMStb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 14:49:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18CEB;
        Wed, 13 Sep 2023 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630967; x=1726166967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DHMFgvfbMRRZvxVPWym7Fx4uQex5OifDkPI7Z3ObhL8=;
  b=LN0AAYLsmVI/o6527FCc6kPUFGyvc2NaPLKSlxN5DnO347Yn34FN1lYp
   qluef7Cv2sssZ5BIXGESJCO79jpjBXz8aOzyXjlXLKQN60SluIAwgRhm/
   S04iHGofjC4PKFpawci9OvxbCszwdOebeYFagDboCJLRCn6uBMK8a48pc
   4EGwU/XlXMYheGvlwEkh+CrFHePD4zWJwspyywEkNW3/h5l9pJJIICYgh
   WkxMrxvpMbQ1bJvsYt7zv5XSjgOBMWnWSfR+icjj+A/kVDGIErtRiq6Yq
   mWaWS9jkK0TQPfX5fwlkgtwDBWHLFAUC1F+UeSYVlHGQevGq7Ts2mBh8t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363793284"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363793284"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814349765"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="814349765"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 11:49:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:49:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 11:49:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 11:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHcTvJFo8kv6+OlJPE68xYmM8ZCnRpa+JbeTi+Qi4zBB/hD5W9TKc/EjGn//QQaTCCYEfeJnz73yAhk27LnCTl++67vAMrJdC9LBfkYLge6YkW8Oz66d8YtKWvzm217Hrj29TqZRYCX2ZBI/fqfnxQZvZXYJ5Bmj/99Pb/Znkc6a4qtnFB0r2pGiknOLggG58SeziM0Pk1Qa4qQ7JXh1XQumpyP9emleX0hDyD+HoIHpnfdR5K34WJ7jzjoPzNnx2W/EzrsQsDTQFDjwagMsK/W4NEg3eEzSkv8qlahqL1Za0vYVWX/NiR89+Og5DHm9Zkw3VUykt4UNMziIbUkPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7wjKQhg649zCCPUVca4U3rUvCtxzFdDHSPsJW7rJQI=;
 b=h1Tvzd3O0xmQd3gO17mbClMwjgK17W57lUj/w2p5zQsbHoWxE5381oUawTK+fuNzhs/hS1d6LMqDGdu1u0dMI+Uk9opdcV50ZMpLosfQ+cLtnrZC1ivotM/dmFPCicH+vmrOwH6cf0RC2ztXPTPuma3yK/G2R61UjVFUAwGXfdI1z4Bw0yxjjzcvod0bKDYnN56VoLVjaz/yi4p+my/oUOC1kDnWxT3Jigc/i3L5Kg9cuDFGvZz4Ubnlw6gKvpQuHNvwzYzq9EjF5JNsc4R74bwajKnhSysv/BvJzaOj1fUO+wxe2QkKvUaaSuMZD9cxTTXIDlNP5du5zAI/Fr8I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 18:49:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 18:49:22 +0000
Message-ID: <6d6dba28-a7f0-1f49-3f59-4e0026d0c2b8@intel.com>
Date:   Wed, 13 Sep 2023 11:49:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write error
 check
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
 <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
 <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
 <jyxp5mspjn7xbmclj5sumbsuwd424fqmdvntiiuq24tiz5yqb4@qunho7whbamf>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <jyxp5mspjn7xbmclj5sumbsuwd424fqmdvntiiuq24tiz5yqb4@qunho7whbamf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: ca38a311-56b8-4e00-8476-08dbb48a24d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPKg6q/lO15zCF1mGi/h46C/cT2hLzGJZPicR/A8c5GVui1VVXkmiPu9FmmtzDG9PZQY4PBei2MktpKmUZT6gIXG6oOnK+xgUbT7l3RzbnSZtJ8GWoiKXHFwO/86TJ07B6Wz6oZaNUeNVP47iDoJ6wGoOKZUc1kuw0URkziwUA119+4yPjnpGuANWhGufmXiO9vFliz5qoCm/H/pvpqWuhnXpe+GxWgBa4B5ImCZK8LYyyQt+2t8QFV3wzXdx7eeMx+jGMMmbI4TShHWgTTTPX9+0B04BW5JZQ2M4nZLabXWPiByjo74PyBdtaSr7RpUhdi9ibz4YEQyNrmq6HZTvD0xNtecValG3aF7gXphvOu0HI4oCvOj90jCEpk2uNT24OxrHigT0GgVEAeBOSrDynA8ehPwD/k1ZK2fMqozDkg+ObiH1NUpQBkmIRv6SmpBU6bxjNEAWEWWmKobqhEpFzdvjtYbdohoXxDO1JzsSP1hiNNJ3gs5w61AC7wIK7Dme13Is5HavPYUXg1KIwkTteKG38NS9KOo7kIUtA3+h6ATy587Jos3Bclh5OqVzLS93stdHNGD0Yjxd8auN12a+8Nzw2ehWRZJdUJqjHfFLeAqSOQCBaIYIO9FFas3brUy7uf7Cjbcouos7y7Z5LEOtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(6512007)(6486002)(6666004)(6636002)(66556008)(66476007)(37006003)(54906003)(66946007)(83380400001)(53546011)(6506007)(41300700001)(316002)(478600001)(31686004)(26005)(8676002)(4326008)(6862004)(8936002)(2616005)(5660300002)(44832011)(36756003)(38100700002)(82960400001)(31696002)(66574015)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpxNTVoMERPbFQybEoyUlEyMjZQWWVZOWxWZEJNcDV1Q005dUpmZFpwTG1v?=
 =?utf-8?B?NHVjSjZDUnhrZ0FVM2lVUjlNbitkLzhPeDFLU1ovOWtKdWszbGhDbENDN0Zh?=
 =?utf-8?B?azlCUzgxYkcyVkZOb2Y1U0ZrZUw3ME5ndGFpbFdZNm8rWmpLQWd5ci9WTVg1?=
 =?utf-8?B?endYRTJ0TEZBcW9vbkZoM0lpZlZnV3hzRlpNYTdOZzBMQ1JyZUdKeHBBai90?=
 =?utf-8?B?TkdxbGJmRGNDS1lHWk9pY2lUS2ZPMWIvTlh3TnlBYWw1TnJvbktrdVVGSGdO?=
 =?utf-8?B?dnNmRG0vY3lqNFJxYTlOdzJFU3dBeW8xNkNFMUlyNnFjSWFVRzVmaG0yQ0gx?=
 =?utf-8?B?SUZKNExjWkhDSHRxM1BUUHM5ZjJPbWRjeXJSV000MjZRMER6REJjcng2ZG1V?=
 =?utf-8?B?UFNDb2pMREU5NitzNndVTXNVdEFWc0N0ZHlsRjQwNW9uT0xIcTRRd1VBc0Vn?=
 =?utf-8?B?eDR4aTZJOVI3bkpFdUFzN09RRndncUlHZjQ3OHhVZ3U3K3lpS2J2SmNyZEVU?=
 =?utf-8?B?b1hSam8rY2phUGh6MHNQU2Q1NzhFa004bDExcExKR21JOFJud1o1Snk3ZzZP?=
 =?utf-8?B?QjZuMEtWYjR4RFRsSU5RMlVJbm90Z2FJODhwMDdBZU5pTEU4NFoxZVR0cnYw?=
 =?utf-8?B?aitOVHduMk4xRXhyK2VnbUMySEs3T1htZ1BwcVlPV0hxRnkzOWxmQnZvRzhQ?=
 =?utf-8?B?SkZra2Rwb1NIblBHNEg5bkwzeG1XMTNaRjlhaG9YQ21SL1BPc3E1clhRQ0hv?=
 =?utf-8?B?UHFrRjJSRU4xTVlDeGkyQjF3R1Z2YXg0eXl4QjZjcTZjVmFjYVl0Ly92Z0xx?=
 =?utf-8?B?TlRIbWtETzdYN284NEgwaG43MXpzNTR2VTJhbHA1YUxHMzIydFVVL1hCd2U4?=
 =?utf-8?B?T2pMZyt3U2xCRkZlN094M3JKbFMxVjZvZmdmQmhMSUJDblh5VWRpY0RlbWUy?=
 =?utf-8?B?bmYrMGw3M3h5QUh5b2U1Y1VtT1BDTXBPajUyOVlDb0Y3d1E0VXJBMGdVck96?=
 =?utf-8?B?VkRpd0tDUEpFelNLQTJkZlpoUUJnaitlWjJ2aTlLb1ZsMDFkZEZwQldOdHBl?=
 =?utf-8?B?L3NkT2xTRThyZlZDcEw2cGQwOFVWcW95YVdQbVNGRHFldzQ1OXJaZVU0cmhh?=
 =?utf-8?B?QldlWEoxZVBjdVlmNlBnNjBJZEIzUVNaYmFOMUxrYzIxVlkzMzl0MDZacWh1?=
 =?utf-8?B?Rk5wZHU5MlJBcldOMzZoekxHL1J6NVJQZTJKVEt0NWxRTERmRlA0Rk1KSDZC?=
 =?utf-8?B?WDh4VXZGaGUxSHZJVEM5M3M0T3ZyamtCZ3kwbm1qUGFWYXdWUk1vd1hwVnYr?=
 =?utf-8?B?TExjWVgrY1RCT003aXhrYmpzY0E3NHcxWGZSc1hLa2grTHhNZmY5WGcxaElR?=
 =?utf-8?B?cjNCeENOR3BKeU5qbXV3K0F6Vk9vb0oyNWlPV0tnbWw2dHYrVThKMExuQVdx?=
 =?utf-8?B?MmtyY0VkOGdxNkhSeFFUMmR3T08vLzBydUo2ZXR2dUhOVWhXN3VvNjFScVNz?=
 =?utf-8?B?bXFiVkFQVUFCZjI0aGpiRjZqZFIva2c1Z1VQRHFIRXZOdDdSeUFPR0ZDck5Y?=
 =?utf-8?B?UVlEd0Z4N1RJcCtFaDZZNEx4MjY3cWtWMDJ6MUUzWE5taXFwUklnUkpSK0Nw?=
 =?utf-8?B?eW5UZXdLdjVleERoQ0t2azM3ZmF6WnFkMDJDRnZ6NW9qeENVcnJ6NUFsNzZL?=
 =?utf-8?B?eDlZekMxOEdsTEZLOVA5cEp1dThwUE56Y2NTRktsNFlnUDVZbUJtUUowV2ZW?=
 =?utf-8?B?OXpwYUxremJ1eWxFY3grRTh4ZmxvSCtYQU05VDdzMmZkbDFUdDVuOWF1TmVU?=
 =?utf-8?B?UG5zM0ZHR1I2ZE1nU1FtN3lqKzJsY0NLRUtMMG1WZEJFTnZKMXJsN0dPK3Fq?=
 =?utf-8?B?TkR5OXJndXViRUFEVFV6aVdUSjcvRE9pVmtic2xITHNHV01pT2RtRUNDTG5h?=
 =?utf-8?B?YUg3S3BJQXV3NDJyZkdTcXRDRXpwQjI1eTNaaE9jK01JeGpCZ0NPUFpvNjdG?=
 =?utf-8?B?b3l4TEovQXJ4Z1ZjQ1FWVHhzOStPYWk2NVdpb0RScHR2aHFZYXIvUmhFK2pR?=
 =?utf-8?B?ZGJuWnprYTFPQmN2RE5MZ0o2Y0ptcmdvbElQWnVpdHhQSisxS1VCdjFtdmVZ?=
 =?utf-8?B?RkRPU0l1Rmpqa09FZFFibmtZek1HMEh4aVNCV053S2JxOHI2c2RJUmNiZjhD?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca38a311-56b8-4e00-8476-08dbb48a24d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 18:49:22.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4nwLJg8Z3BrVQUvgwT0HhGy1zMG0ePoqo03EdNjcMLxQVLshwyImJ4tXwLA6RqviFAox6wdEDMKuscB+t1Rxp1XQmVBX68GxqEprz/U/Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/12/2023 10:59 PM, Maciej Wieczór-Retman wrote:
> On 2023-09-12 at 09:00:28 -0700, Reinette Chatre wrote:
>> Hi Maciej,
>>
>> On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
>>> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>>>> Hi Maciej,
>>>> When I build the tests with this applied I encounter the following:
>>>>
>>>> resctrlfs.c: In function ‘write_schemata’:
>>>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>      |              ^~~~
>>>>      |              popen
>>>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>      |                                 ^~~~~~~~
>>>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> Hmm, that's odd. How do you build the tests?
>>
>> I applied this series on top of kselftest repo's "next" branch.
>>
>> I use a separate build directory and first ran "make headers". After that,
>> $ make O=<build dir> -C tools/testing/selftests/resctrl
> 
> I do the same, just without the build directory, but that shouldn't
> matter here I guess.
> 
>>> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
>>> source directory. I tried to get the same error you experienced by
>>> compiling some dummy test program with "open" and "O_WRONLY". From the
>>> experiment I found that the "resctrl.h" header provides the declarations
>>> that are causing your errors.
>>
>>From what I can tell resctrl.h does not include fcntl.h that provides
>> what is needed.
> 
> I found out you can run "gcc -M <file>" and it will recursively tell you
> what headers are including other headers.
> 
> Using this I found that "resctrl.h" includes <sys/mount.h> which in turn
> includes <fcntl.h> out of /usr/include/sys directory. Is that also the
> case on your system?
> 

No. The test system I used is running glibc 2.35 and it seems that including
fcntl.h was added to sys/mount.h in 2.36. See glibc commit
78a408ee7ba0 ("linux: Add open_tree")

Generally we should avoid indirect inclusions and here I think certainly so
since it cannot be guaranteed that fcntl.h would be available via 
sys/mount.h.

Reinette
