Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904B6E26D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjDNPYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjDNPYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 11:24:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4FAF38;
        Fri, 14 Apr 2023 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681485879; x=1713021879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRYw5SBKy/QQ8+WnW8uO7dDtFTjf2Q5bkTQVzwlg0Ng=;
  b=HdwvBZdG/KGiTW0KbhLDDAOTS8VoBHza9Wa22V9/8of14Rn/PM1gwP4f
   v9TfatMxWHkW6iXlf2fJ+vhJ4sx1U7T36Bd9an/pRYp3nnvbQ+HctMJEp
   VPs4/Z/6wPGiuWd7dihovUID0P9YnJAvOeF1nNtuGVX18TzOYfaoZrk6x
   S14KfTG5Z4rZFam4jDq4OOUhwWaCL6IvrYE0ESGxYZ297gYU91xSoZVo7
   04q+CPpupISyTPY8PKp0O+5MRmhB/YGMg/z5xeftb9xhUN0plVRo3oZyA
   uIZ05sM2u5zVONZJN88NZFZMTau93U19IlYLydvTc6aYnIePwL/4pp4KJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="328638563"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="328638563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:24:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="683355146"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="683355146"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2023 08:24:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 08:24:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 08:24:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 08:24:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 08:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA53lvB3LcRalEeMSUXzEjA/LBfBDb/ugAVF/g4LQH4uLcovOF2L40SPEtQeuDolMUeHVN9CZU6K+gFHjhjK87yWHCzHYAbTqycH0/flqUfqmp+KSVx0meWkfc5Vl6TZXgeC1AEooANlmw/s1NRe2ki9N4X8+kovYmGXcX9zGtCv4YjisywDzP1Uv2orjGfYJDpc9til9cLBg+1zpVpAl2nu9Nr2BgZCDb1DMvmIW0vjp02k75eAYsRKDhkBMFgi3LGbeY1G8zEzeSQ3Kn8j8gsJeQj2X7Q6MXcZFCdhrqtBXXt5pAAq9/YKwD0px1dlnulPN5CgSjvUY/cqWk0arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXE84wDhEnsfQlRFvOnNRFMMta6rjCgokRLeJLukLy8=;
 b=h922/3cR0ZheWNZVnxEKo6rZaa3RDuw7MHRi+X7Bzg2QQ5H6R7fKX7EPjmdm9WT/53OQFw2koZVFfSESzALjr26SWdwIDUmcZoF8fJ7xkjDOQaqW0Q4iplIYYtPlneSBBKZkdIWv3GGz2DA6WXGLKSbIizARF7r3j/PWkfFbbdFPZmJMANGNOSw1bters8gA/52k02MNootA30n87NUgmHeed24kYBe0n5344tyOWXhSMwS1GAse2Vw/FO8MWTqySbwMrntD7WDtufSubjtQ4Szafhyp1EDlNm5sMVQQd7+zoYXAGnjTkJD9WxxXd91sZes42zD2mtzwcgZBFpM5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7812.namprd11.prod.outlook.com (2603:10b6:208:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:24:35 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 15:24:35 +0000
Message-ID: <2536d041-c361-5fb7-84d9-3b158e7fc52e@intel.com>
Date:   Fri, 14 Apr 2023 08:24:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v9 1/6] selftests/resctrl: Fix set up schemata with 100%
 allocation on first run in MBM test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
 <20230413072259.2089348-2-tan.shaopeng@jp.fujitsu.com>
 <bb65cce8-54d7-68c5-ef19-3364ec95392a@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bb65cce8-54d7-68c5-ef19-3364ec95392a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4731273c-2bfb-4fe8-39b3-08db3cfc59eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1Vv192HEql88RoxxWRv/hkJrUuNH3QI3CizF+Inyg4EDao51grIhQuqqlURcHDu8cBFIgrxCNz/GWraw2KTwXF1tIbAUUJLB1Q1ThpkRSYb/WT+1910j3sn8qPqDxQEoZSGg0oSxDGAlHqCkJkTKy7g9uyYfhC3tquA1A1x3yPEdfi4xjxRA0n2RCHA0yreCN8YoxmVvd75sTO2CGKYPTQzgO8tjks11It1OY6CK1aNOnxks/OrCC3EJA5k4EQ4Lj+WYMDhI4CczL9U9y7hg86roq2zo1nV7XBOjzo3PH6NJTPep7c9uDCPlAmD1a+xMlAUBXXvZ2/nLCHSpepFQarKl8ZLReKCx4IVpU4nd5u2xjBZZkXGcvHEHKjN7/ux+fuMULJ6RwAEembwLANi14w/T0ec/S7kPD9X9m/gnCpNBWeD0Nnsv6eBz55ZjYAY2WvxSS7BJ1LZQpJmhxlcQQ1iZEy/iraXzf9zRLfk4YPulCd6M366fuVWJ+aVT/V8ASpfs8Ye9CS8hmR7XYqv5uYU57EwK/Ag3LQTEifnBQIUzwXQD7QyrQzGz2TKzNOJOQ3Jfn2jhUISoYWcafcbNWfCvONz9OA+Kq8rOXNRjHOsRL78Ms75pyAhRX6n/wkWQy3ZAjznVCM6vbNMTqAdYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(316002)(4326008)(38100700002)(82960400001)(66556008)(66946007)(66476007)(66574015)(5660300002)(41300700001)(44832011)(2616005)(6666004)(31686004)(36756003)(86362001)(31696002)(6486002)(54906003)(26005)(186003)(6512007)(53546011)(6506007)(2906002)(83380400001)(8676002)(8936002)(478600001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFrVEVMS1RJZ2pTRzVCUGV2TExBZHlJSEZQNXlNVjI1eDJXM1doMDJGSHdz?=
 =?utf-8?B?YzZ4K3Jpa3ZweXFLYWJENkdrU2pRL0IvZ3BjSnBMVmI0Q0N6a1ZzWlhoNDhz?=
 =?utf-8?B?T1dMQzFHUitiZi90L3J6VHByaURVRU5Gc3NkcXExTEt3OGp3Y0ZXMU50S0Nk?=
 =?utf-8?B?dnRsa0JmMjJ3VVFTaG9XVk9wdTNOUTVROXJzemZBMmZXdUhTbzkvLzVVY1N6?=
 =?utf-8?B?SGU2eW1vTlRCQ25WbVB5bkh6VGtWRU4yaWJJMEZjY2hGaWxTT2NGTmgwM2R1?=
 =?utf-8?B?aDE2dzVSNnNWckhTTWlKaDJMNW5pdjYvNnIydWQyTXA5dURQVGFiMkxCQXVl?=
 =?utf-8?B?RGU3RzN4c0ZIT1czaEZJOGZieDBUa1NIYUxKTk5FUm5BSzl3andyYmMwbFNY?=
 =?utf-8?B?cEhQWHRXaURZaFJXSVBpcG5DamphNGdVUGVFWTYwUnEyUnZMZFltRVpvYnFq?=
 =?utf-8?B?YnBXL2RQczVtb1VVNERYTHJEaVFHVi9JT2FjMEdEbGM3VmNNV3hNVzhaTW84?=
 =?utf-8?B?SVZDM3JxOEF6QXpRM2JWZHBNL1dPS0ZUUlE5ZCthdk1Bak41K0dnTjFNRkhh?=
 =?utf-8?B?aTB6UlZUUkNHSWdnVHpmeDQ4UXFDeWRERFZkL0IwelJZVWlVYm9PN0FSb1hH?=
 =?utf-8?B?U0pUUm5PUlNYc0xlNU82MEJJcjR2dTI3MHVPdFNjZjJUK3BMRVAxdE9yQUFt?=
 =?utf-8?B?UFZ4a3F2QWE3cnlLcWxINzVkQnRBRHBMTnN6dzcyMjVLbk9tVFhoOS9rOWJL?=
 =?utf-8?B?WjRWSmlqS2JUTEY1b3NGWDZMK1dkcFRHbDAwb0UzZ2o2czRTcUwzUWNLYWQ3?=
 =?utf-8?B?c2NEQ2lNKzYwQ0w0VHpIN01LcHpBV0V1T01pampKL3R2dEJQUHM1SkEyYUV2?=
 =?utf-8?B?RUJxWGx3ejljV1VpcktzWThIb0NyRFkxcW40VXBaZUZTdmFmT2g0ZS9zQzNu?=
 =?utf-8?B?UHE1TG1kc2NRWHBNNklBeTRuMlR6RVJBWVVVbFhjTWQxaTQwdkViR2dmOWRk?=
 =?utf-8?B?YXdLcldWeVFZWUgrSkwrb0dpUG9BQnlldUYzQzBBeFRsYkFIeE0wdnNySE5Y?=
 =?utf-8?B?MW96bk5DRDFBSzJuN1FHei8vMTN0ekZSUEtzMFJ4SG9lTllpZTFodko1c0Zx?=
 =?utf-8?B?eEF5NGdKUWtCR1RPbzlHbHJJZFJzSnFyMVhKbEZCRmIyajJ0dnZQSXpmajZD?=
 =?utf-8?B?TkRBUTRkR3Rkc2NzVzdXYnZTSCtUM3czbXVaNHNnL3NCVi81c1hqV2ljTXln?=
 =?utf-8?B?K2RlNlc5VGFlSW1ESDdNUzFVWHhBNENnVTNTVkZ2ODB1TXF5NnFOcTA0R3ZO?=
 =?utf-8?B?M2VqdTJ3eGw5dFFTWFFGUzRJT2hiR2d6SkludU5zd1pMT056eUsxbWJidXpC?=
 =?utf-8?B?VEhLTlZLa2M1czRITGZwZHpBMGgrYStLL25teU1zRG0waG45TVpOdjRXNEVP?=
 =?utf-8?B?YzVLUkNGcHpBVThCWUZYYWp2MWFwcWMraS9RNURrdXpLWkZqclFzZEozdStl?=
 =?utf-8?B?c2lzN1dCT0tISjQzNlVDY2p4YXN3T1FVT05GSkRobm03dEJINENMWi96NW1W?=
 =?utf-8?B?dzE3c1RwLzYxTUpaWGowdHRlNXZrT0RSaFk0RTZPLzVYTVI3VSthbkZncXdk?=
 =?utf-8?B?WUVlVHRQSGtTVms5UjRyc1h0a1FxOXFoRk9zVlB1ZXRWMncySHRvb0VucytI?=
 =?utf-8?B?ZzMrSndEc29TTWNFdUxUVGpiaC9YTDlneEppZEp4R0RCeU50T3Q0QXhicU1s?=
 =?utf-8?B?MUVrUnhqNzM1ZGtJa3dhaGE3M3ZzM29tY2xSZ0piSGh0cjlWUGZUU0svTEFn?=
 =?utf-8?B?b2hIQzJsbkFJOWhuTCs0V2RoSXE2bUhRRFoweE1sQ1ExZk5zK1VSQzhzc2Y2?=
 =?utf-8?B?UzNBSjZFWk1tV2xXdVhFQ2RmOTJWSW01NFZITHQzUUlES254T1dYN2dOMWgv?=
 =?utf-8?B?c3pqTTZOY25TZHVLdGxtWTRyTkh6bG0yT0NhQVpWTWxxS2hrRitFblAyWUdR?=
 =?utf-8?B?SWhPL2ZIUk85ZjFwZG5pUHBDRVRRYmVreWhBOGE0VVYzb25PNHc5RFcrTVhZ?=
 =?utf-8?B?eUJmNnQ5c2RQdVRYa0cyZm1FdFlPbmQ0WU1WaWpVL1BJNW5pd1J2SEVGcmh5?=
 =?utf-8?B?dFQ4djg0aktBeUlUd0hja0tZMDZKTGZzaXNJS0lBblhyY01ZRVU0T2ZmVFJy?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4731273c-2bfb-4fe8-39b3-08db3cfc59eb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:24:34.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pn+MhwLhMsWtpYdWj+aVqAN4EcnOZLtjt2kE3i7YcPUh6p2F6GqMEmL4knpU9Wd2K6wlYLWkhPNwy8pE4OaPzH/ITGVzHA9clfR86A0SVyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7812
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/14/2023 5:31 AM, Ilpo Järvinen wrote:
> On Thu, 13 Apr 2023, Shaopeng Tan wrote:
> 
>> There is a comment "Set up shemata with 100% allocation on the first run"
> 
> s/shemata/schemata/

Having the typo may be ok since this is a verbatim (typo and all) copy of
an existing comment.

>> in function mbm_setup(), but there is an increment bug and the condition
>> "num_of_runs == 0" will never be met and write_schemata() will never be
>> called to set schemata to 100%. Even if write_schemata() is called in MBM
>> test, since it is not supported for MBM test it does not set the schemata.
>> This is currently fine because resctrl_val_parm->mum_resctrlfs is always 1
>> and umount/mount will be run in each test to set the schemata to 100%.
>>
>> To support the usage when MBM test does not unmount/remount resctrl
>> filesystem before the test starts, fix to call write_schemata() and
>> set schemata properly when the function is called for the first time.
>>
>> Also, remove static local variable 'num_of_runs' because this is not
>> needed as there is resctrl_val_param->num_of_runs which should be used
>> instead like in cat_setup().
>>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> ---
>>  tools/testing/selftests/resctrl/mbm_test.c  | 13 +++++++------
>>  tools/testing/selftests/resctrl/resctrlfs.c |  4 +++-
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index c9dfa54af42f..9b591c35310f 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -89,23 +89,24 @@ static int check_results(int span)
>>  static int mbm_setup(int num, ...)
>>  {
>>  	struct resctrl_val_param *p;
>> -	static int num_of_runs;
>>  	va_list param;
>>  	int ret = 0;
>>  
>> -	/* Run NUM_OF_RUNS times */
>> -	if (num_of_runs++ >= NUM_OF_RUNS)
>> -		return END_OF_TESTS;
>> -
>>  	va_start(param, num);
>>  	p = va_arg(param, struct resctrl_val_param *);
>>  	va_end(param);
>>  
>> +	/* Run NUM_OF_RUNS times */
>> +	if (p->num_of_runs >= NUM_OF_RUNS)
>> +		return -1;
> 
> This is not rebased correctly, negative return values mean now errors.
> To complete tests "normally", return END_OF_TESTS. Please see commit 
> fa10366cc6f4 ("selftests/resctrl: Allow ->setup() to return errors") for 
> future information.
> 
> With the forementioned problems fixed:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Thanks for catching this. Unfortunately this was just merged so a separate
fix will be needed.

Reinette
