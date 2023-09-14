Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFB7A093E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjINP3r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjINP3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 11:29:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE6C6;
        Thu, 14 Sep 2023 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694705382; x=1726241382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fr240ORMzBKrdt86kXvonVWGI8VFRc1AiMvh/UgJSo=;
  b=CsfLubl6Qdo6DyUVuL5+9nd8yuVxsUTY82/oH3Fk/t3sFe1s+AcmYGQ5
   U77mBISa58YrrwgHjceAbVOXljpmlrXXEFCQVHJUDVo5nhCbuZglA1pPL
   I0Oa4TZuAkLc7ADsYs+CNkvBa8g/GyWa7HFh9viP7q4azIJTCm9AxO1zX
   w7GyZhXmeupE9tyEzBCosMfYUffMFSq4Sb0P1sJjkOUgQIY5QVQdaloXi
   DcVCs9VY6+Va+cg8/mInayUaKcdGI3KQ+frQSlv35Tx2b4AHWafriXznu
   6Jfmv565D0zCqg4eB5hqXOeGFbKCQEq42iVbLQnoRvQy0LDRvp67r36FL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381693667"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381693667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="773925924"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773925924"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 08:14:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:14:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:14:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 08:14:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 08:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9corrYj988M+jvUM9KAWac21qeQy6u0drJmPIDpJFNCteDcA5Iail2hADBlQP0DiySBWxaAuQ82PcZKT6PQQa1sB2tRFfeh6roQ8B/gssOOnFw+fL7uif52GGxU1of4csG0+HbsK1M7YOlp8qRRIcQra9EiLmssGbxrdse3DpbxdWGwDBu52zoMH8eJtTozmz5a17K0GZ/IgsR1e9c1otmi5s1raPQoBLZlTjV3AxPop5BKNzWvalL5Ve4v9zlKm+ZYLWU0kdjNrWtKMXmykQS0SB/ZrmMj7g27m9gN/b1e8womLkKyivF9y/JcSC4B5K2ulrGSQFm+6A7x0Ayl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XabtePTw7gpkikxX+ask+Ume8rA7f/1mewsyXinM298=;
 b=SOVekzV5d3QyjKClYbKWFYv4C8QTTAvcoyTwLv5MCUw6Lt4sd4AEx97n851TWtT85WSuUru4EsD3hedcF+Km9l9sTEnqREGBN70xTieZsp60SitO3Ka3BpNuiyrfaZvtidwmH2fZkHWkejQpBsMQe11rtiOVNlrU7TbIsiC2xqZUW1MbtcxjuhHiRb+2ABUg7NpCurlqQC4Ji3ES9HlZkwrbgpkcuS6CkoqvwHEgZri6mLvxngKeqikKjLTeDXtfwxaVEKuEdFt99AViHt29CYoidwu13Cuvsu3GlDQNVoKRMX8b+O+377Lx+MnRTUQJLw6oNBZ54eX1lSqWcPhiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 15:14:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:14:28 +0000
Message-ID: <6fbc0b65-0f02-3c7f-bd7a-5183d24a1fe5@intel.com>
Date:   Thu, 14 Sep 2023 08:14:25 -0700
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
 <6d6dba28-a7f0-1f49-3f59-4e0026d0c2b8@intel.com>
 <ycbcan5wcxtz2mbywz6zdoyfus26vrhus6enipe543x2ejyt77@m3l4ksir7k2k>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ycbcan5wcxtz2mbywz6zdoyfus26vrhus6enipe543x2ejyt77@m3l4ksir7k2k>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:303:86::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d388eb-3ecd-498f-6c0a-08dbb5354a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ib/qEKO8sw8UmRTiQc5Wkps+w5oJkUiTaRoNZfUgkIpGF9ZC8FxVYLpBVAjsETGZfcqJGFzpsGGobIv+VOfdbxKdWsXFqH1yGVUC9K5F744G8TFjve9LIWTLv2OxTyzpvA6C/+BqTN0Sg4+YHstApAs6NFwV/hBOhUsA+52OeveWBA6zevNZ8g6MTlGwOLH/e8MpomKqE/njZVj6bquBzpP1jgPHgmtVqDWPOH7kWXi0Sso3CSI+rmqpcCHZ4QU0h+pYgYx5Ouoz21BbYB2H4z+mnivoTwOyEicVGd0Su/CI91FE+KqUFOnUoT4b+jWPIxTSO9G2VjuCbKjGaJTmz7PI0vWFjsb2NV6qqfCMU9422SSb5zksLiFtXbmamzOc5WfVUHzlobNSbyzGMpS1cPkM1A9ra8oB1klywAGFrjRq2yACEkeblggTCrMdDMin3OV0qj62jfZ9Mq4uWTkyhkbxtIwoAQeXbDWl7Hhs+mlXvkMQ9LZeeQqq5oAvr35q0+ZVTahYso+NY5gBXHBy2S2I+eQFfuq/5JCpnsndVwog2woFBPBRzHkdGZ5ZJ5AxhXOYm7bTxgglgkYSugW9x8+VVIQASe6NvREUhHjqQWrmTGQXUl48qyUTnvCrqr+zY7udksyyvtA5/aqBJ6hqKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199024)(1800799009)(186009)(31696002)(86362001)(36756003)(31686004)(66899024)(2906002)(966005)(478600001)(82960400001)(38100700002)(5660300002)(6506007)(66574015)(83380400001)(26005)(2616005)(6512007)(6666004)(41300700001)(53546011)(6486002)(66476007)(66556008)(44832011)(316002)(54906003)(66946007)(6636002)(37006003)(4326008)(8936002)(8676002)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlAyeU1YRVdINXFIdW5vRW5TQ0l6a0FVU2ZvNU1TSGVIT1RBdmtxTzBTZXBK?=
 =?utf-8?B?QXh0M2ppZ3BNOEdoREQ4WkxWMmdkWHVnWHRtTkQwV1krVmRrbVhVUnBsZjYy?=
 =?utf-8?B?eUF1ZkFpa0NmZEVtYTBGc1hZa2VRcVJZdUhaQlNjZi9mUnVyODBmbGNaR0ow?=
 =?utf-8?B?UW5DZHdNQ2thOWxtbXJvbHV0NU5xNGt5UE5sWmZkQXd1Tm5xam00TnZZeFZK?=
 =?utf-8?B?L2FSUDJlanA2VlNkWGoydkNtRSt4ZzA0N3NxT0VQS0RpRU53Zkp5U2tWalNx?=
 =?utf-8?B?ZmhPT3dtWHZOekt3WHZEL3h0TEc0VCt1YzNQN3hpaUt2cWI1YVVJSEdRS3pz?=
 =?utf-8?B?cEtRcHJlSGt3U1p2NHR5L2hBUzRKZ0pGQ3BmVlc1T25ZSVJQUzZaZUFjTm84?=
 =?utf-8?B?elNQdnh5ZEZENS9zSlZaNDYyaVBNelUrdmtuUERBam9xY1FLaTh4ZDFUVWY2?=
 =?utf-8?B?bVNDTkF0alN5UWpPWGtxU05HeU9lV2QzYTZpVlNrTnNDL3V3SjFOVTRqVEZl?=
 =?utf-8?B?SDVtUW5MdmtyaFVUS2t5djJLcXEwU2dPTENadGJxRXlyZDgzbzZxeEdpQzAz?=
 =?utf-8?B?NVV4bmJUNVV4ZmVVM25VWlMvY3pEcWh6OTY0MXp2b2dyNUtKRks2MDQ1Vlpr?=
 =?utf-8?B?dm1PWjZEZWw1NGI0NWxRQktxUEVhQjJ2WGJXV1k1ZTZGK0RVQm9qUEhvZVcz?=
 =?utf-8?B?Snh3Y2QrbGViazRnWTREOWdRS3JCeVYxenJQUXhqRkZndlFYeFZSWkhWcDRD?=
 =?utf-8?B?aXJhSS9PTmVHRTJ2M0x0QnNkaHUwTFBJaExqbG1tRVp4OGlqdDA3dmpwam1z?=
 =?utf-8?B?OTBxRnZ3cjR0T2F5amNNNjF6cUhQQ3o0NXgwWHA1V3V0cG9rQkh1VjlTZjhq?=
 =?utf-8?B?cXQyUThBZEpjZ2JTN0ZZK2g3UHBidnVLRzJScXlscm11UE1xSytualVTU0tk?=
 =?utf-8?B?VVRjeEQ3c1psdGJtZGFjNE9Jd0Z5YUtiK29oS3ZlaWh6NjJhTUdMVFV5T1h6?=
 =?utf-8?B?UnZoQ3lBVlhaNXRZd0J0S3BFN2FWMHhLRmNCdG1BRm1DS3ROZUd0U1kvZ0N4?=
 =?utf-8?B?Nk42cE1RTU1lbGlnU2Q5L1kwVUFlK1dkeDVaK1lTVHBlQ1BLSGlIcURCQnJK?=
 =?utf-8?B?YWtHekNtVWdSUlhDUDN2L3V3Y0MxbGZZZ2t0U3Fkd1J0cE5DaC9KRXZqZ2d2?=
 =?utf-8?B?VFJrN3A2ZU9FY2JaMU8zUGNIeVVPeW5JWVF3bnBYZTh6eTBYajhadUZKdHBP?=
 =?utf-8?B?RmdyZjFnTUJsTHJXbGpLQitUUE1DbUVOaFQvOTRNVWxZVkFpNVJxOTlGcWRC?=
 =?utf-8?B?TjQyRjZER3pmdFpweXgxWnE3Y3d6QnZBb1NRQ1djb0grOHVsRC9FK0JWaGdJ?=
 =?utf-8?B?MXIwNlBJWUVrQ3dJZTJMU3dnSlQ2K0VlbGY3SHU3OVptb1BLZEF5Z2pMZGQw?=
 =?utf-8?B?RWdRbUx5L1daTGZRL0tEZUxqNmtJS2lKWFZaakY5TmVEWHYyN09IMGNCalRV?=
 =?utf-8?B?ZUdWd1Y2engvalB2Z0NFTnUvTklKRWJGbitsdFh3Y21taTJZM0xFMlBBQUJw?=
 =?utf-8?B?M1RONVR6M3ZnSkJJTG1KQXFKeVZYQWUzQm81QmN1cEdRbExGS1l6T1BFZ0ky?=
 =?utf-8?B?c0VvTHZkcjhXSHhOSERMMHAxdCtoNHNXM1lIb1hZMy8wNU53czYyUjFTSnRx?=
 =?utf-8?B?TUNIcCsvVktHYTYvbVVPc000cUdXNnRYbkppNHAyMGw0MjdYMnlZSGRPcmtX?=
 =?utf-8?B?a09LaWNlRVk2R2pQTGJtOWxxZXdlNnQwWUhIVTBZalpTSnZkUURiOEZ4ODh1?=
 =?utf-8?B?RVJGMjdoc2xzbUZ4dkRLSHY2THU1YjBSeHJnb2lTZDFpZUMyMHhxTzNiZzJy?=
 =?utf-8?B?UnFjYzhXcDdkWHp3TzFFbURPdzMvRitXMDRvY21tMmlVRnc3ek1jVVJwL3ly?=
 =?utf-8?B?cjI0YVpvaWpPYkh3VWY4Sk5XRFZ4RzkrTWd4ZEN5VG4yWWFGQWJoZmNyMDRD?=
 =?utf-8?B?SjB0NVNTbWkzY29xTzNRUXI0azhuWTB6TkRKb3NVd2M3RjJlQWpydERPcGNQ?=
 =?utf-8?B?aHN4cXh1b1N2eW9jMS85Zk8rYW9xUkhQTjFzMlY1OHZkNmRna3cwcHhXaWor?=
 =?utf-8?B?Z254U20rcElKamlWZXFneS80Q1ppR2tsZ1VRNWs0allVSFpBQlk4bWRnK1pN?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d388eb-3ecd-498f-6c0a-08dbb5354a14
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:14:28.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOyvI91pMdTEpcyqARfgX6GSRhOLDIUEE7AA0xRpnfyDAuwZBG4C5pe2zb3qLa0ebNENTKoF3eWpCoTtFK0NK+D9g3ntOxl13dW8aIe4/ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/13/2023 11:01 PM, Maciej Wieczór-Retman wrote:
> On 2023-09-13 at 11:49:19 -0700, Reinette Chatre wrote:
>> On 9/12/2023 10:59 PM, Maciej Wieczór-Retman wrote:
>>> On 2023-09-12 at 09:00:28 -0700, Reinette Chatre wrote:
>>>> On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
>>>>> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>>>>>> Hi Maciej,
>>>>>> When I build the tests with this applied I encounter the following:
>>>>>>
>>>>>> resctrlfs.c: In function ‘write_schemata’:
>>>>>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>>      |              ^~~~
>>>>>>      |              popen
>>>>>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>>      |                                 ^~~~~~~~
>>>>>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
>>>>>
>>>>> Hmm, that's odd. How do you build the tests?
>>>>
>>>> I applied this series on top of kselftest repo's "next" branch.
>>>>
>>>> I use a separate build directory and first ran "make headers". After that,
>>>> $ make O=<build dir> -C tools/testing/selftests/resctrl
>>>
>>> I do the same, just without the build directory, but that shouldn't
>>> matter here I guess.
>>>
>>>>> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
>>>>> source directory. I tried to get the same error you experienced by
>>>>> compiling some dummy test program with "open" and "O_WRONLY". From the
>>>>> experiment I found that the "resctrl.h" header provides the declarations
>>>>> that are causing your errors.
>>>>
>>> >From what I can tell resctrl.h does not include fcntl.h that provides
>>>> what is needed.
>>>
>>> I found out you can run "gcc -M <file>" and it will recursively tell you
>>> what headers are including other headers.
>>>
>>> Using this I found that "resctrl.h" includes <sys/mount.h> which in turn
>>> includes <fcntl.h> out of /usr/include/sys directory. Is that also the
>>> case on your system?
>>>
>>
>> No. The test system I used is running glibc 2.35 and it seems that including
>> fcntl.h was added to sys/mount.h in 2.36. See glibc commit
>> 78a408ee7ba0 ("linux: Add open_tree")
>>
>> Generally we should avoid indirect inclusions and here I think certainly so
>> since it cannot be guaranteed that fcntl.h would be available via 
>> sys/mount.h.
> 
> Okay, would including the fcntl.h header to resctrl.h be okay in this
> case? Or is there some other more sophisticated way of doing that (some
> include guard or checking glibc version for example)?

Ideally fcntl.h would be included in the file it is used. Doing so you may
encounter the same problems as Ilpo in [1]. If that is the case and that fix works
for you then you may want to have this series depend on Ilpo's work.

Reinette

[1] https://lore.kernel.org/lkml/dfc53e-3f92-82e4-6af-d1a28e8c199a@linux.intel.com/
 
