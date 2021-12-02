Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC927465B1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354661AbhLBAny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 19:43:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:11511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354744AbhLBAnD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 19:43:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236532301"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="236532301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="747746851"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 01 Dec 2021 16:39:41 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:39:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:39:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 16:39:40 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 16:39:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKIs40+qV9Ysl2nmSRuzEbAIUyYD4sJW3kAloq8b4hlmUG4XoHM6hIdo4aZbRmVWk3yyMOs2eBFQSmb1W2720mcJQw9RNikTyBEU4UrLPERWSHjwwrSZsqlA2XuuNMWoJ3PZ0Z+uJ3/YbdFb5NUaLMf/2TMcI6o9ZS10qGTUs4pHTd/kg+K4NRTkX8cTTnONsHbcqLUi8xQVo2vPnak6w8x6d1qJ57uYcmJ1MMPlyF3Dg2iq1GVPsJywPFOkid22fgNSBR5bb/nh8XdP4CY+8KOAe1hbtYSWuVml1lF16eLR/LB5xPJH53trtxx4yTCwcemJYeUGd/eU8eMbfrQ5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2+Z7s3yDgvE0R2glrDGZjXYCwJd2N/w2N2oDxEle6U=;
 b=jV2w87qivZY+D8dIfLRxeKHCYsc99JzN7TOas8+XmOJlbQ5Goy4zIrB6IZDJMR8rwAa+h2BOiGHjsMZa/47uHYWjdbF5z+Dlxxp6MSninU43+FRSqFlhEYG1PnUK8hW2Yfrauu+/Ae5Xa5E1VGjl9bgQrv7Y3B0Hp8add0In6IycGESsExFeiRF89bgDAmiENCqmjBOtZmkTSaUi6NZmHGZOIMwZYNhE2yqbm1XvCiu1bGOYE1fNfIi2cSdwQDdU0LeTS7Fp9TFUGrJuKNg5gqwKmHtxffnkF28y45SqKYbBbs4OkEW3orUhUPcNWZ98Jw5NJmIztQP1OLWOH88orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2+Z7s3yDgvE0R2glrDGZjXYCwJd2N/w2N2oDxEle6U=;
 b=X1mMOnhjhzfdkAAQFqygjlFgi4q9JE+ZmOsZ8mL2YdDaqREsL8HtxWpEwLxmiBtC5cZuqyP/hGFdoES+jT5wH3gRutNuktAdRUJLEcRzECHwxLBZxDv9xhwB8N+Z5DfKpSnHk05GPWsBO0gu36tvPGMTaZ61yn4+d5Sas5J5Kzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3970.namprd11.prod.outlook.com (2603:10b6:405:7a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 00:39:39 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Thu, 2 Dec 2021
 00:39:38 +0000
Message-ID: <c55e7903-aeb5-c117-6e56-c93e0728e46e@intel.com>
Date:   Wed, 1 Dec 2021 16:39:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] selftests/resctrl: Return KSFT_SKIP(4) if resctrl
 filessystem is not supported or resctrl is not run as root
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-3-tan.shaopeng@jp.fujitsu.com>
 <6b9ed425-cadb-15df-4c4f-eb1dc0b814dd@intel.com>
 <TYAPR01MB63303777416D1D3C0EF066278B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63303777416D1D3C0EF066278B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 00:39:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 990f4b97-c4a4-45b7-6e58-08d9b52c37dd
X-MS-TrafficTypeDiagnostic: BN6PR11MB3970:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB3970EC5DF9B453F0570504EAF8699@BN6PR11MB3970.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tpHdKwUZkuPwZLbuO6rUZgRpYHdrskJpTBG03y1lHxd/cMpJuLNkdliE+xaoR98ncTuWmq1qVXwbTUmRZfM/Zw/pyIeYZV93sQE5OHg3VfbVtfqXBJdcC24VT8X6siAhoJf3marLFq9S63qSLNCTcl2liK8LWgnZ9qTTtFB3Kq8oZEjOvtaGWmTyY2g3W4Vlphs2FXb1sIlI669z/SNYFneIVPjENi9NRUU99aB5LbPkbQjTtPKCORLfkMvOPRe0cx7pKTaNtSFYAFoeMixI4XYlo1MCsmGJsm4NYUE1w3qdni2yvQ+gpu6KAyUvE8AGphxjOQbBqAMATECHaHMwEv15miFui6Fb4p5lIR0OuICCznMQYrGVmMDEF4hUE6iY3iCxw7W/zMwWlwFRMHmyrz70Ow9N9PctJGfV1bzLJA78iYb1Ky6TkFy9K35QjrD7It+STbcPof2SkqgSdST9w2UmExLMuVu3irG1e7grVIGhAw3VApuxSMUXOutOLj6lSW6GQK15GQ6mLGoOyxFLIerDhV90VD/tK4MPMvZAbbFckgyjMF9NN+kWLdG9OrMzckS/6fQulfhc8vGcjsjiRAKyj2mpykuMkZbEVFoEOlWKpqZ6SRj4MsO9hUTX1u70D6hkevumtZH+QJvZXIWSE+w8MjwG+l0Y8SY2vFtEoow7QB9O3zA10P254YlBgFU2tXB6crGQtCxVNLOEdpnimd4bfq1VuCEvMGuUCgaMsiUTAlJQ7UsRHziVSEeV6v8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(36756003)(956004)(53546011)(2616005)(66476007)(38100700002)(508600001)(66946007)(66556008)(4326008)(316002)(44832011)(26005)(31696002)(54906003)(8936002)(2906002)(110136005)(86362001)(83380400001)(5660300002)(6486002)(6666004)(16576012)(82960400001)(186003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjN5T2Vuc0o3a3lkZWdGdlIzTWlUdkRpQjVtWmpuaXVMUHVXZ3pQTHBZMUJP?=
 =?utf-8?B?b3NUcGsrejMrTzVWdWl1WTJRd3BodzZ4d2tzeDhrT3dEVWJMbEV0UVF3WnFW?=
 =?utf-8?B?eHp5RlBHaFRMa2RvU090NTVwS1ZMV0RQOGZ1ZUhrS2xrbnRGRW5QNUhWTEJY?=
 =?utf-8?B?Zk95UzVaaldYVkZZTDNlMUdYdmV4NUJQdG1teDhWaWgzWVdxVXQraDh1R3pP?=
 =?utf-8?B?N3lwOG9JRS9WTUtqWThvWCtKWmJGY0Q0MUlZUTZubzJ4Tld1a2pHNEx5V3lV?=
 =?utf-8?B?RmNIOThyTHBUVGVoSnhTbnp1Ym1TQXVjL3hOalpjOWlaZDZoamlkV01CS2xn?=
 =?utf-8?B?TCtXUDRMRGYwSkdBUkFTaFB1b3JkMGdUZ3FudlFxQ1pMZGh3d2dtNU1pL3ho?=
 =?utf-8?B?TVgveGRQUWtCS3Q4TzRIL0loN0Z1WEtCKzVJMDJHT2o1L25lRjVpUXg4TDht?=
 =?utf-8?B?a2RuWTYwamtQVzJuRUJmVzN2Mlh3ZkpsdG9EQnFEL1FyeWo1Z002QWh4dzY3?=
 =?utf-8?B?TTBWOW13eTBPcmJ2OXhNWWZDbXM3VGVyVmtrZGg0OEdzSFJaalhpY1RHQ1dP?=
 =?utf-8?B?U0c5dDEva2VXd2t6bHdCczViTkFnMjMxdEVCcEwxbjhNcXZVb3FURGRSVnlw?=
 =?utf-8?B?K1kzZElOT21uNE45QnJIdFFKRTJ4UUo1SE1JSWI0YmFVZWVtMlVOZlBBVnZ0?=
 =?utf-8?B?NzhpbTVSbDFXUEVKcjJNMklUK3pZK201T1RwWHg1OG0zQStocGM3aDhBL08y?=
 =?utf-8?B?U1QvOEVBQkkxYWFiNkxZSWJyMDlraytteFcvaFBDRTFTRFNqTzNXOWRFblJu?=
 =?utf-8?B?aXc0bGhteWwrTDl4WlEvK1VwaDB6UlRvblhoT0FqdDNZa3ZKT1l4MCtSZFZL?=
 =?utf-8?B?ZWVrSEQyc3BHeG1uOW45aExIeU1WV1djVkFIczd0WkRwQWsyODhxSGQzQy9M?=
 =?utf-8?B?Q3hlUkFJTk5idElGSXFTYTJCUEdqQXZ2OWdwK01PVG1YVHQ2bmRwR2tyYjht?=
 =?utf-8?B?SDE5Q2h6UW9iYmNUQ3E2a1ZXTzRscmhuOVhRSFNsVGQ3N1ltd1pvQUdJdXFR?=
 =?utf-8?B?SmJ6a3l0K2tMOXpkdGdSL1ZqK0t3N3pEczQwVVRuSjdRYStWZTdrWlo5TGk5?=
 =?utf-8?B?QnVFZ0hKQ3ptVnBEcU5iVGFLSUNaTUZNY2cvVW4wUFB5UVRiSGcySFo3bnVq?=
 =?utf-8?B?N3g0ZERxbTVjdTY3ZWhXV1E1ZmladVBzb0hQaHEveFFUU1YzZWxrcUo5blMr?=
 =?utf-8?B?ZjRNNVJVVWtkR2dMT0k1Nk11a00rN0NDVGorK2xXYXdaNDVhS01EWVlzNUdW?=
 =?utf-8?B?dnRYRnp6djJXZmJ3ak1pbVhueWxxU2kxY0RLWkJabEQzdWVvYmxJSjlpcE9F?=
 =?utf-8?B?TEczMzAwa3R4NVVJdjNIemUwZXovMExsZkFuRWo4MDRNZHVDQlFnb3JFeXRn?=
 =?utf-8?B?aGNZb05RZmFkaEFGVWY4R0xORjBUY2dQS0hzdHBCSFBYL3BNU2lIRHlLZjhV?=
 =?utf-8?B?N3gwTmFweVN0VmhwVUplWVFXZVJ2K1FGY1pNNHhXU2JzTXJvY3E1VTIvY3dk?=
 =?utf-8?B?MFRucVdVZitFNHlCeWxtbWxJTmt0WUVaSlhQYTZBbGZTajdyTHVkS2tCcTQ3?=
 =?utf-8?B?ZjNlQ2lFOGwvbGs0S1JQQWRSczV0clUyRHVoYy8xemVrREFkSi9TSWNXNmR6?=
 =?utf-8?B?cW5GeVMrdU9aMEloUURzY08rdVRoZ2l2a3dDdEFFV3N3eGJHREpPZ1BiZ005?=
 =?utf-8?B?c0p0R3kxQmQwTmo0bzIwN0JNVjF5dGd5UE5YMlF4a2JQaitDRDkvT2dBNVRO?=
 =?utf-8?B?NzNjMTB2N3JqTDNQd01hMTllTS9UQU4ySEdnazQwQ1d3aHhPWjR4T2dRZi9z?=
 =?utf-8?B?UnJsT3VWUXU2ODgrQ0dnbk05dHRaa3VOMVZvZm1yVWp6b2hBTjNoYUpJVENu?=
 =?utf-8?B?SCtGZ25iVHoycWpjVEdNbXo2VFJZT1hzMEZxT2lTd3h6OHFkbEJ4SVRLK2pG?=
 =?utf-8?B?MFBYcHdFOUVJRExDSXJGZ0lydjFtVUtwZkY3ZkhjaUZtUGgvN01RRXRxUXpP?=
 =?utf-8?B?b3FNSCtad2IvZkR4WHZ4d20rQkYvRS9rUG1EWjMvd09pVXhMMG94cHZYUVZW?=
 =?utf-8?B?cWI1dVRveEgxbWh4VjZ5eWJiMW5LemZUSHUyc0JPMlVvYUxWZWpqYUJNWVRB?=
 =?utf-8?B?OU9adzZCa2JNMDR2MDZBa3FNRjBsMUMyL09takhtQ3MrZTBZMHlhYzVUdGdE?=
 =?utf-8?Q?h8S/Cy0+l+gvNOqbmoztwiRGR4vwpPm94LkDUyxCBQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 990f4b97-c4a4-45b7-6e58-08d9b52c37dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 00:39:38.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKFsGZN+nlm3FeXuANHQGFb9ldzJ4/qjyw2I43CtPQT9QyO/nwagjyP2xFENPO5RaRVh7lwUjN7WGOCRK7m0TgLXDXqGekUsyyEjJE5UW6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3970
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 11/30/2021 6:36 PM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette
>   
>> (subject line and commit message: filessystem -> file system)
> Thanks.
>   
>> On 11/10/2021 1:33 AM, Shaopeng Tan wrote:
>>> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
>>>
>>> To unify the return code of resctrl_tests with the return code of
>>> selftest set, return KSFT_SKIP (4) if resctrl filessystem is not
>>> supported or resctrl is not run as root.
>>
>> Could you please elaborate how changing ksft_exit_fail_msg() to
>> ksft_exit_skip() accomplishes the goal of unifying the return code?
>> What is wrong with using ksft_exit_fail_msg()?
> 
> In selftest framwork,
> if a test need root privileges, but it is run as user privileges,
> the test result will counted as a SKIP item, instead of a FAIL item.

Thank you for the details. I think it is important to highlight that a 
skipped test is marked as successful to not unnecessarily report a 
feature failure when there actually is a failure in the test environment.

Reinette
