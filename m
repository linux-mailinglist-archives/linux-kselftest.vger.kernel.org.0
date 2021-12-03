Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80646802B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Dec 2021 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376301AbhLCXLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 18:11:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:31719 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359288AbhLCXLn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 18:11:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="224322752"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="224322752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 15:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="577637249"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2021 15:08:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:08:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:08:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 15:08:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 15:08:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIwS4AYGwuSaEl6PMmdxLtHmZLZwuDutP5+6CfRiRRMB3tlE6OjF3qsijBNuCISxYQhoixxNbUj/4vVkmlYesvGRq4jZ7nbG9ARPmJem0XtW9ovXr0Eq7P8CzOvFyiby1W0tOOpUG1BSRcS1V3scl8EzzGS4sBjmQLTpJpGXsY3b6nEuW7P9JS1yLM7t4UYBlf9ZVu2iHE8Sw/rm/CChLvdSn18ZgmgLLal7rmwlSYcJuX1tF0bexfRQxyO7lcQAzZ1+i79tnGvzoPieiIj7GOd6obrQTy8aTib/hF0RxiU7xeKD5YyqG2xNgI5cVxaaTG6oXnExmCIfhGaTRuFztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBug4W55b/0SOaCEp2Gfo92n6MaTecwL2GtKygJYbqI=;
 b=K2T1in7CU02l5AN74WTcjbxUg6YCFmLki/DE4iQMb8zytseJmxKcjokbH0ZiRR2s1OrzNpf0cDTFlpNitGjDTfNy1xWtXVkMKAG9ISp7PfaCPLYeNLjZL60aTkh4qpABTGCC9VNEdEM4eHv6F6Atu2OwB6kjCErOLqHehXHIU2XDrT5V3v/uMoZJcjHDAdtlzCJQiq6KMFVzzIqfTAuGvjqY2T0Ce4fujnTILBwFfVX4o5m/BTbr25jZ05hb+2mAchl1DBellLOoHTnpL9wZQzjCPgRXYyYXxQno2asTIZh8lcJVIXnNFJz//qM4tXLj9XWA5H14AYCVm65nz5Ixqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBug4W55b/0SOaCEp2Gfo92n6MaTecwL2GtKygJYbqI=;
 b=GvycuFZ85IyefXa6r0rFIqTuk5X0qS63ODkNVqa55x41oPZGbPyIfTCVWBB06P3o9FOZzU9oovQT6JBtXkgSp7ndbpwIZ5D3mVTwd7oeHSgav6BquP0qR7yadAvoOv8pb7Fqt6HHBiR5hZK1f7GqbO6xy2K5keIDajHtuvuot0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1729.namprd11.prod.outlook.com (2603:10b6:404:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 23:08:11 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 23:08:11 +0000
Message-ID: <e26efdc5-83f8-93e8-9aab-7e21ceb99254@intel.com>
Date:   Fri, 3 Dec 2021 15:08:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
 <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
 <TYAPR01MB63304F1E1A04D48CA7632C658B6A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63304F1E1A04D48CA7632C658B6A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0065.namprd18.prod.outlook.com
 (2603:10b6:300:39::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR18CA0065.namprd18.prod.outlook.com (2603:10b6:300:39::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Fri, 3 Dec 2021 23:08:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22329ad0-ef9c-47ce-44a1-08d9b6b1c6c9
X-MS-TrafficTypeDiagnostic: BN6PR11MB1729:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB17296837300A58EE5CDC9A00F86A9@BN6PR11MB1729.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdyAbV/etQAOkT4N3GGuhLuhIZPee1P6rOnCMshcdMLUXCIZfzWvMDUMTs5f4uoaa/WgkrVdZ21rzFvEXsmnCSdr25BFE9sPwKlpS104tteOipwD4fXY4QhzchzQW7RwDqSEu6b2K6ZV2RVA2M1r4TNrX4a5BJjTwux3Q2IZo1+1r5CEa7ep4D8jPxNnVe2TCXni5v32ZMHwiMSD7N4ZmpvVGp9f2+/CaIwCpPvocGxcossr180JxK6F0rz8suGEUFz5uAfFYH9X4uTFy/drvbYOtavHvIflUMQZNqbTXS15lvaC7hLZAl37VdWNCfwqVsaRGoT46vYrN2otrSnANhQ5fnggo/0nh0BfbNj+qjiTBJ3B35UKjSEt/1dhiM5upVnZHfdf2iCHARzw//ARejAeaitFraV3VBeQ8XLXbGaFUJRGe0rFypGSblsn9wnmBYX8sl9cH5U4ggzKNJLBEQgc56roUeho7JO37YNXOEES97psv7VUUNAEegVG934zQSgZktlXr0X/PblWgxtoxRL82bv0+8o0KbAnTdbRSwEC0JuD/J6LR29oqxgVv/NN88G73YYbzeEe63PQsI7lzGIqsPaibmR3ZJ9OFmMJXGGj210YggHFFwuYI47mIL8+jpdbRsZw0q1wxzPLeM7BuDokH5JInmwpGptSuELA14uYfGvO1oHeIUC0U8lrPuhycmz07yc8aZlgOzTJTrADA491MvqRPZd/XW5jA4AEmdnQeasRWP6U1j/A6sNH7ORm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66476007)(2616005)(186003)(956004)(66556008)(6486002)(82960400001)(38100700002)(5660300002)(86362001)(6916009)(54906003)(4326008)(53546011)(31686004)(83380400001)(36756003)(508600001)(44832011)(316002)(31696002)(8676002)(26005)(66946007)(8936002)(16576012)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3V6UERaOTVCSU9KdldueUtpYkgzZWlKRi81anpidEtiU003dUJuSEZVbVcv?=
 =?utf-8?B?UHpYb1pLWG1QcGo5WEM4MHZCNXJWSmlPU0pUVXhEckM2bDZVenhFTDZ2OGZH?=
 =?utf-8?B?dnNGc1FCaFdENzhmbGJUcUdPL0dTQVVVVVNzZ25leHR5aUFINzVvNTlMdGhm?=
 =?utf-8?B?LzA3bEJZMWNTbGVSWWNvMmhONEFtbkxybW80UzFZOERFb3NCd210SjJlbXF3?=
 =?utf-8?B?Qnc3dFZiZWszMWUxbVVVdWcwUThhKzRoMnVrYkt4bWdkSUlCVXJSVWFrTXlV?=
 =?utf-8?B?a0psc3MrOUhRKzE0RExoeFNrOU11Q1ZmeVZUaUw1YmVOT3B2eE5mTG14N2pU?=
 =?utf-8?B?alBvZzQyNVJNdGdxSHVVaEJUdkpzYzh5Z2JjMVZidW10SXBxS3FUOVJyeDRs?=
 =?utf-8?B?aXBJYnY4RjJXQ004ckJST1dTQ05vWnJnckFPTXVCZXcxTTVjOTZoeURmaTBu?=
 =?utf-8?B?MzZDM1VuMjhDTGFNUkNvY1podGhrd1M0MDlabnVMRXdKYVF4WEE5NlBQYXFS?=
 =?utf-8?B?bHAwa2VzYnNSSmhMWUtpdXV1cCtjcWhUM1lpcnpGNVFJWG1ZcCtRV2JXcGhy?=
 =?utf-8?B?bURjd1FYRHZZYlVsSjdQTXJoaW1IV3pRbXJkYVMzSVI3bFZVVk1HNlM4WWxl?=
 =?utf-8?B?TitsSWJPeGdBcER4bmxtU0F4SjlmSEUvRUJ0NEprSzFEemNKWjkxRFVDOSsx?=
 =?utf-8?B?TFNLNEhuM2s3WmpWRHlZL3pzNmVwQ3J6OGpOVXQ0bi8yVUlHOHF2Q09KVFlr?=
 =?utf-8?B?YmhlNDlEUFk3U0czdG9NUW9DYTZIaUVQNVdMTlh0R2dkNnFwekNYMk9QenhP?=
 =?utf-8?B?ekdkNytLTHFnTkFjQ1NySHpUME45MWY2SUNyS1VqOFhKRGc2bm5qamJiaUcw?=
 =?utf-8?B?K3E2T05DakJoajlPWlFKaFdmQzVNcXRpSWFUNmV5eDA0WTQ1eUFKbTNyYzNX?=
 =?utf-8?B?S3ExQVNScHhCT2JDQXk2bHVDUTBpOVNwMUl2TjBpZTZGdXNDLzZ1NmhRZURn?=
 =?utf-8?B?WDNWcGcwSUxTMlM0VDZvUUh2Z2tOWE1kYWNObCsyWjZyS0ZxTTk4cjNlYnhv?=
 =?utf-8?B?bHlaekZYd2JYcmhWQWpQdFlZK2lBUnRtZVJNRllueExiMnMwQ3dzM3FSc1px?=
 =?utf-8?B?L1RzeHVlUStORG45bFJtdWluSi9aUmtqSk5JeUlTWVZaWTVLaFB5a09ETFB1?=
 =?utf-8?B?djA0UTk4V05JMjFrbzJTZWpqSVM5dlF3NGRyblpML2w5eGs1ZXZPaldpdGYx?=
 =?utf-8?B?aG9rN1dvMDVPVnZCOUp3RXh2ckx5ZFZXUHVUbzZhMy8rQlQxdjJucTRQd3l1?=
 =?utf-8?B?UFpKaHMxd2VTOHZ3TWR0bG9KbnJmUEJJY0tjYXlaL2JlTUhCWFhHMVNVWWRX?=
 =?utf-8?B?TVRoTWFsclM1MVpveGlsdlFFbFkwNUhqS3V6ZWtYYkVJUlhid0wyVkhmWFU2?=
 =?utf-8?B?SFI1OVV1TUJPSWVWR3JPOTRMK0hSZFRRMDIycENVU1lGd3R0eVZiZnlISU1y?=
 =?utf-8?B?TnlJNTZlUHpsY0pESXFzcXlHQjhPMnhkTXJQZ2JacmppSVZqdGVQVTFwdTRK?=
 =?utf-8?B?b0orcUJvY1F2TEtlODBWeGVlWDlONDFMOE1GZzhheFVaVGFjMDBZbFBFSm1P?=
 =?utf-8?B?dTRHbFc4K1JpazZSQkZMODlWVWdGdFN2THpWTjlrK3hPMHdFZzQvUk1oUjFS?=
 =?utf-8?B?M25SaDVQSHRZcVBYQ1YxQVA4TEk5NFJYUWNzZXJseTUxRkFOS3F1dDdycXhP?=
 =?utf-8?B?dlZRSzFDV3ZENXlQNC9BMmNwNWtzZ3B4cUtxejBqa3BqcjRoUzBMK21XYVFx?=
 =?utf-8?B?ZTI3Q1MyYlRJNWNMYXNUeHlBRE9tN3lwR1JWWmJZZGdFc1ZHL2FQK2ZqdUU5?=
 =?utf-8?B?MWZ6aGh6WkNIOW5DUTJlVmkvT00remtNcXlBVHJ3TkI5dFZ2RkFYQVJaUFpK?=
 =?utf-8?B?MlRxRFczVEduMlhEZkNzOWZweFp4R0IzTnRnYzNMbzBISko3aE4renJVMGxo?=
 =?utf-8?B?UWRaeWoxMnRQVmV0Z0hlck1Yd1VJZ05PbWZEdlBFZmZwanFmN1Q1MThneC9P?=
 =?utf-8?B?YXJmZ0JKNmlVUXhOTW1ncWpOTDd0NVlLNFNpVlpuMjByVEkvbU5VdmZHMnBN?=
 =?utf-8?B?TDBHSjVIaTRRLytEL0x4TlJiQlhKdWpicjB5TjBzOVZ6aGZjbS9zTm1rTUVH?=
 =?utf-8?B?MmUraFc5QVFMdnVIOUlWZnZiNm5zN3RCM05yUm1xM0QzYUg1OFR3cUhzeHdV?=
 =?utf-8?Q?r23ukoeMsQW7hNLPUSZlqow5sL8Amct95DXLjMzaeU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22329ad0-ef9c-47ce-44a1-08d9b6b1c6c9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 23:08:11.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMkDe5Ves6C0m35GOIrgcg77jgjdVB2cHaFU5SPIQB9tZGXvSPGWcDlHKFjSW4mgNLGFMpB9GNmRd+DBF70LMY0hrL9nBusYzx1c7Oc7B2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1729
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/2/2021 11:21 PM, tan.shaopeng@fujitsu.com wrote:
>> On 11/30/2021 6:36 PM, tan.shaopeng@fujitsu.com wrote:
>>>> On 11/10/2021 1:33 AM, Shaopeng Tan wrote:
>>>>> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>

>>>>> To ensure the resctrl_tests finish in limited time, this commit
>>>>> changed the default limited time(45s) to 120 seconds for
>>>>> resctrl_tests by adding "setting" file.
>>>>
>>>> How is changing the timeout related to the resctrl framework changes?
>>>> Is it not a separate change?
>>>
>>> In selftest framwork, the default limited time of all tests is 45
>>> seconds which is specified by common file
>> tools/testing/selftests/kselftest/runner.sh.
>>> Each test can change the limited time individually by adding a "setting"
>>> file into its own directory. I changed the limited time of resctrl
>>> to120s because 45s was not enough in my environment.
>>
>> Understood. My question was if this can be a separate change with its own
>> patch? It seems to me that this deserves its own patch ... but actually it also
>> raises an important issue that the resctrl tests are taking a long time.
>>
>> I do see a rule for tests in Documentation/dev-tools/kselftest.rst:
>> "Don't take too long". This may be a motivation _not_ to include the resctrl tests
>> in the regular kselftest targets because when a user wants to run all tests on a
>> system it needs to be quick and the resctrl tests are not quick.
> 
> I think 120s is not long, there are 6 tests with a limited time over 120s,
> for example, the limited time of net test is set 300s.

I am not familiar with the specific kselftest requirements in this 
regard but the test duration is surely something that needs to be kept 
in mind. Consider the systems performing integration testing on kernels 
everywhere - running the kselftest framework is a reasonable thing to do 
and test delays that may seem palatable on an individual run may not be 
appropriate for all test infrastructures.

Needing to almost triple the needed time from the default time is a red 
flag and really deserves to be in its own patch with a motivation. I 
would also recommend highlighting this change in the cover letter. This 
will bring the issue to the attention of the kselftest audience who will 
provide a better informed opinion (whether they want a long running test 
as part of the default framework or not).

Reinette
