Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952F75408A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjGNRiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGNRiP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:38:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49489E4F;
        Fri, 14 Jul 2023 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689356294; x=1720892294;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BY0oN9bnuD4qy/KqspIs9iQmN5b65Hrqu1RapUCd4ls=;
  b=SUbLy1EhmYF1hDQTW+P1bb2lW4tlA7iTn9qqU4dkWXTg/KqjgVDg9UvP
   oozaZwbPxTpanMhMlZa6K7nXfoV5Muh/RdkRjofCN22SpR3RkaPFkKpm6
   hl0dBDDQttmLa52HJ9WAdje4xjDekU/sA419p9DSBNeTq8OIHXheRUpT5
   uQ5KUnntpTA3Nt22/3m6IyJp6rVvi9Z7xdpy1dJZ4Q8sXc18ib84QXAXm
   aVNb7b3W5Xpr4MqgZXpHuJ4ndZ0Hr1SapihS3ptwZoLelF4Koht2rusYN
   QGE8WKHstvOBHSBaMCJan1bbnGlVSHUq7P41Ol76kIJeCTRhOdmFNixRI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="429297869"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="429297869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812533918"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="812533918"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 10:38:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 10:38:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3llhsoVvmfMJzpBGAsxmxK+eg9xKNKaDKneCuCwOSuZ4EyNVyELFp3/Ugep7qspyZ0ie9wX3+qDv816Hi44gFpwPSd9C/lVEns4MHAw2ft9qW4j3omoCVdvYEP0+mwE3ipZp7Nfw+6tGIi9NRDnqHp7cb0qB6d65wG3NRMpSvUG/f8RCerrJWAWHXN/aZ3OVnF1ja9XJc39K668ipEFonrtza5BtIY/bEE5nWb2JMYMA6S6Sz63gias+1GDRhwb08Nc+wEuxzS8+HLHOF2HG+x6eN7JIg3tfY6keq63mI8u6FxruvsoQgU7tyEdHPew4jugff7iADsd/yW1XvALzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8vNA2idduvbQjd0a51xS+H64YC112TNi/PRpFz9QVE=;
 b=I0ZIkHI32NFrmpMpooLT0T4MvrfktfZCnf1KhDsOxgyN1VomsRD5jHqgCY5t22Bv/CHPFCn5EzSZQftUoOswwt0Mgp42m130AWtA7IhXrtyjs5hJJqObb1Q1nIFhvSDAhceqkf00nKNA02XUQcjduGryTtlT010qoPrLrBEQ7wC2wDOI2m3ywxvUIvFFCnmGTtphW6Au03Iee1Qb7uYUswRKk96JdNWNpb3VG3gyCk8DRXQaBj6yQHI4YuefbuoeU4lIkgnzL9ScXkvuHent2PMW+vcmEVK2ioNLPxzNjafzuDPiI+Ui8vuiPIWLgV/N3MLmWGz0OyUuaV0L09BtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:38:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:38:03 +0000
Message-ID: <ba080508-5f55-a56e-db78-299d8523a88a@intel.com>
Date:   Fri, 14 Jul 2023 10:38:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
Content-Language: en-US
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
 <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
 <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 37068bc4-4f11-4a52-4059-08db84911302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG0Da9TtVGQnWjKv5GBSvjXbEkljEX4Lo+rhPI8HlefWCWcajBNUaAbr3WSeKqLkaSGsW/q1ua3KwC16eMJRR/Gzj8dk03l2Eut/b3Ouy2+uLxq1aBmLN1Cu3TuKoxtjQGvFyGnOpNvgf0DH8np0qRS0zmzkgFJ8Cq3+BwZAd/S7OWEqulUVvt0qKPv3hth6/DUcj6HK+LIS1a6rrbYXA8s61Uw5kpHGyItSsOE8mxhOraaqa6TFeXdUy545sMG2M6OaLRA5aYxcolN1kogy/Ed+6pciJ6Oi2qXy+JN/LUX3AMi+7hq//66L+iuGznQdPwyL+5uf/mTS+DTQbmH81AbujWJA0XG61UdJ7R3q6Lg80fS852A0FdOavjcu5xS/J6A0MKC5YfXPLQ17Tug+RG/1ULN1iPfgK9ar7XvdIpT300RzXxPhwVZlN6O31kBlPeaFjRuseraVGmLbKaOcPhJvToE0JJ6EwxZ05F9n2Zil2Q4mLyk7GDXwET+NtYOGewyUFiz6DumtShWIyrnjOMvzX+k28kTeJ8e9sRmwnXqZsRz9lswEKVO++pvMdzNfJL5TO7aztkKbkxMpiLMnNq6t9dR5kJunAtmgH55W7287jtpomLlGGXBm6vNQpd2accX2wq0zS/lfmVxCm5NhZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(6486002)(478600001)(110136005)(186003)(53546011)(6506007)(26005)(6512007)(2906002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(44832011)(8936002)(316002)(8676002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OERaWmpWTTZOQ2MxUXBEUHBJVENrRHdjdDBnenZRNXFQUkNTMHNaVyt5RUVo?=
 =?utf-8?B?Ti9HbFJDdTFpNkZqMzlqaldLU2lBZnVMTVFFQVBpdVpEZ1lTTlRxZnNzYWJl?=
 =?utf-8?B?eGE0SEJnb2daMEE2eDBhMUtBQktYZll4YlNvdllTWjFoYytMKy9oS0k2MS81?=
 =?utf-8?B?T2JpeExLYnpnNXBZbGx3eUxyY0xPZWZTUDVTdlg0TG9PbnpiU2hzV0UwNWxO?=
 =?utf-8?B?N090SWY1SXM3ay8rc1BrS0M4bE9yQlpWeWphak93MFNjMUFjTVRzcVhwbmI2?=
 =?utf-8?B?MmZzZ1kwVXBxemlDdEs2eE0zekFNcmVUOXRTWGJlWmJrZG03L3V3YlFHSkpR?=
 =?utf-8?B?QjhOWHM0Z3MwK0hCM0loNEVWaXRUYi9jWjBHSnlnSFh0aXVWZTRsUkdwelF6?=
 =?utf-8?B?NUsyZ2NoTmcvdWF4RjQ2bkR3aHNGNSt5WkhDc2VtRCtocWFaWCtBNlh4Wmp4?=
 =?utf-8?B?SnRKSUh1YkhYTUlKVVBTVCs1N0FCVmUyTDVPSTBEbnN3Wnd6RFZVQVZ6THVU?=
 =?utf-8?B?MkVrSG9VNVhncFNKVUhBaGc2RFNRK1VWWFFUTDg5M0g3RzhHcUpUS1NKbE9n?=
 =?utf-8?B?S1d0b2N4YW1pY0NvV1pIRHN5Y3U4RUJ0WVp1em1xQjBUT1Bra21hcUdYWTd1?=
 =?utf-8?B?eUxhcGFLUXk2ZnovWnZMMWZIL2k1c2tUS05CN2xEMk0ydzBaNExuYUUrVVNw?=
 =?utf-8?B?dmJ4dG9FdFFwYVBvcUc4UlRabVJqSVJYa24yQXRHdlNueU1wV1RHWDdibThC?=
 =?utf-8?B?S0dKUzM1bE1SYnlOTysrbVFDTjlqdXIvZGk5NG83SHZHWFBwd2pmV3VKZEgy?=
 =?utf-8?B?WU02YmRMUnNjRUxJbmZzYk5CZ2RwdTBMR2RQYk5pRG9oNTRvODZsNEFxQjUx?=
 =?utf-8?B?ZzVmU3I1a3o3UkVVT3JEUDYyK1VEU0xUUmV1WUhpaEFSRU85KzBkRGZPTE5n?=
 =?utf-8?B?UXdLcWZuVE0veTM4bVdmYXA0TTk1VzFGY09jdUc4THFXS0RrT3Z1UmFVUnZv?=
 =?utf-8?B?bWdQWUJhUkZQYzdRa2xsSFNGVkxVWnE2Unp2bW8ydTFoOTlOeUltT3JZNHhp?=
 =?utf-8?B?dDVxb09iWVJSWjUvVE9GMmJqV1FKUVUxYW1VbGkxQkFvZk4wTWNlTjBOcWhY?=
 =?utf-8?B?WVVEUVZTVmc3VXhobkdhaEQ3ZGFaUjU4bXZwNUhZY0NRR1VTb0k3dUhUMlFj?=
 =?utf-8?B?bE1SOUNqOXdBTDNseUxKMTZwMDU1NnlxQWJjZk95bWdUdHk0dGJvQ1VldTdZ?=
 =?utf-8?B?N2ZpTWNQNlBhU3VJM3JCV0puYURCQ0RpMy9PWis0Q2puMWNvTHJwNXNVcDVu?=
 =?utf-8?B?aWRHSk1lcWNDaEVOUmZ6c0xvVHRmOUI1NHN4a0tFT2Z5eE1qV0ZtRlBleURY?=
 =?utf-8?B?OG0rS04yZUplcDg0cHFtbEhDdGRwR29rNFordzZ4Ty8vUkFWWWZTbTdkb3NC?=
 =?utf-8?B?L0p6YUtOWm9TcFhWSGxVLzFkSVdHQ05xZWNPM2hLcjR4c21yVExEa1V4MjVa?=
 =?utf-8?B?dTBHeCtNVkhFbEpkVG9Td0hUQmplTVByNDJZQkJVOTdwdDRCUnJHQnVNNDRr?=
 =?utf-8?B?QU50aXFLZVZ1YlFBUDJkZy92Y2RXSDBpY3BDNTh2dndaVU5vUlRwWWwvZ1Mw?=
 =?utf-8?B?M2VQaEpGVDUySFRMaTZzaEg5ZzQ4ZnZqendIS3BtaXhLQ3A4dW9GWFJxOW41?=
 =?utf-8?B?d2k5UXY0cVFLeitzU3Z3VFZ0VXppVFk3WHk1azEvcDJnUTBKVm9FSDJPQ0JT?=
 =?utf-8?B?ZjdDUkhya3JWMkxMUnFKd1lsUTEzbTM4MTFHSWlva0ZQdGV6bEJxYjU2Z2lF?=
 =?utf-8?B?Q0t1QzRBUng1ZEVVS2RWaVRGT1daM0ZuRTBoQkdLWWJxeVZtVDlvZ3pEcEFa?=
 =?utf-8?B?RG1vVHNFZ1ZmMGtKWDkrUG5ZUmpvc2ZraUtrNnd4SGh0ZGN3OE42bnBwaDYy?=
 =?utf-8?B?QXA2MFE2T3BVVWdwRUdnSFp6QWltMmUxNEZNUHFjLzI0d1dyOFZ4ZkJDb0ds?=
 =?utf-8?B?M2R3bHpvZ3gvVDd0N3RyWDlXLytXeUNSRDA5dVZiVkFSTHQ4ZUw2VnZhbkxs?=
 =?utf-8?B?aklMLzZMM014S2creCtreCt3TzRwUis2UGo5REw2QXhjTTBGaHorZENtRWph?=
 =?utf-8?B?VEZhRkNOdm5USVhlYk5JeUJZMnpUbjYxWVowSGd2QzcvRVdsa2dTbDhIMDF3?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37068bc4-4f11-4a52-4059-08db84911302
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:38:02.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU4BCKfm7Eh8rqoWkedl8YBbp9/KLu5Ckpgf2b301BrpktmfPyg50cxiz6sema8AuylsY4bQITvfUGcPX8EWl5jvfYsdSQYY8bZfokWqaP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 7/13/2023 11:43 PM, Wieczor-Retman, Maciej wrote:
> Hi Reinette!
> 
> On 14.07.2023 01:00, Reinette Chatre wrote:
>> Hi Ilpo,
>>
>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>> MBA and MBM tests to use megabytes to represent span. CMT test uses
>>> bytes. The difference requires run_benchmark() to size the buffer
>>> differently based on the test name, which in turn requires passing the
>>> test name into run_benchmark().
>>>
>>> Convert MBA and MBM tests to use internally bytes like CMT test to
>>> remove the internal inconsistency between the tests. Remove the test
>>> dependent buffer sizing from run_benchmark().
>>
>> If I understand correctly the intention is to always use bytes internally
>> and only convert to megabytes when displayed to user space. The above
>> implies that this takes care of the conversion but there still seems
>> to be places that that do not follow my understanding. For example,
>> resctrl_val.c:measure_vals() converts to megabytes before proceeding.
> 
> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
> the idea of only displaying data to the user space? From my
> understanding it reads the number of bytes and only converts to
> MB when printing the value. Or did I miss some detail there?

For MBM and MBA tests resctrl_val.c:measure_vals() converts data
to MB before it writes the raw data to the file. Compare to CMT
test that uses cache.c:measure_cache_vals() to write raw data
in bytes to file.

On a high level I see the MBA, MBM, and CMT tests in three stages:
(1) A "benchmark" is run in background, 
(2) raw data is collected at intervals and written to a file,
(3) finally, data from file is processed and results displayed to user.

From what I can tell MBA and MBM tests continue to write data to file
in MB while CMT writes data in bytes.

The changelog claims "Convert MBA and MBM tests to use internally
bytes like CMT test to remove the internal inconsistency between
the tests.". This claim is not clear to me because from what I can tell
the three tests continue to handle data inconsistently after this change.

Reinette
