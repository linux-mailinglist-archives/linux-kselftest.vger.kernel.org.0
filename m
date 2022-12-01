Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75063F74A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLASOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiLASNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 13:13:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F3102F;
        Thu,  1 Dec 2022 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669918358; x=1701454358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g3LETkMvljpgtFuP9WvXK5r2qx9VhVWBZqHXCfq9CI4=;
  b=ZZ8Uc4xHljNQUHIg9AdH6VMzCN87CGu+1vIfhu3BL2bGQbrkVXvGVmV4
   myf7PuV4ZPQ07yd3mzcAOioWv0oWuBrOqbc177OhAsPLdK8+v22EpSBAe
   6ci8c2IcK32R02RPlpSlO6BQyScG+pqgsYmtDPCxREYkBd9rp+d9M9CUt
   O+iZfEqkxVCG+52ymidfo/fxQy4xfCNXJ7cS3iuvwWCtgUPSr2GhSEgx7
   udJud05ig8ScBG9BoJWXhcZ2jSvaRA4D7S5AKtiHLK4WlA1pH7WnP3r8a
   X1rLgVYUsOyqsMDqeAwEZ1+IIIEdX8C9PQ4phzmdqbuZ/hyp4AFUcda/T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377919961"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="377919961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644737398"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="644737398"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Dec 2022 10:12:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 10:12:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 10:12:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 10:12:35 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 10:12:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcd0TIXobYQb9oGJOplUSeuYKmqXYJrtm+bUiU3jPGrM0spML6wQ6aovQnwC2rG8clcCkhX4wxmNKdMKXoqlKNV6Z6MGe18zxzUT7Qo2UdfKcZ99cI+2RBh4k+Wbl7qeWxpYb4hEK6gQB0CeN/SohrolBzpltTdmD4nu/7G2N5KWgBBAoxNN/gQh8SqQ809yvYYRnSU+6Ip64IqEIo2aQHQnUwARhUCUCT0M+nsRuJBxRPWpzI+Twy/qb45WWCVN47vjDtjggqijyoqNrmaRqCwOcVnAp2ZdDRLzWaRpTj28wOGByXbXxqL4+ZFNZjfLtZ82IWNECI+zbXp3V2m6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCUNcQu17shUUkzfG9+VAxhSosQcoIwb6MFZO/QQebA=;
 b=HkYFOtZubaFGK6qr9sRwra2WKWb3PcNHxqqSvZ8VgOEMb7pIxIP7nrjwOhnDJ6A4GhBh7xRK0xvB2Xl/nIEMqBeaNGV6Rngtro55GQxlOeg87N7p6GJEr1S9fRCduxG9HnGktNem4WtZRoXW/6TsrIQiLQLsBI2/4SNQF9MTW43tcmqoUpCfICsBlWGEc3u6DK49DgfHb0LyImWbc6Shu3BiNmXX3FbVegVl1onwGUiVfT/XOCYt20pIXXxg9SNlwaz7Bqpssceuxua+2qKXiXsXsPG61Z2vGBupf/6ZzGoh7bl+iI4NdIK0zCX/csuD6HLpSZHf8x8rJiNKkzh+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 18:12:33 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::d60b:8480:204c:b5d2]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::d60b:8480:204c:b5d2%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 18:12:33 +0000
Message-ID: <9801fa7f-5971-1f5f-1b63-0d672c32fcf1@intel.com>
Date:   Thu, 1 Dec 2022 10:12:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
 <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
 <TYAPR01MB6330FFB9E5BA7CCDC652EE3F8B149@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330FFB9E5BA7CCDC652EE3F8B149@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdf7e76-f437-4c3b-cf04-08dad3c79d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUSSgT2zEsIMmMxS2kZz8t5Fk8ch4WpZJm/6A0OTgcqtdSHe8MC6JtqIS6Exgd9TWbTdB0jkbc3zWg9XfnZgv/TKGlXy2EEiH2DIdZGzd2Sz+ykrPPs16igEEJxVhQjjfu6b6KjONi936BLDoiaWKjTH+uW3fljwn2YpYI9k+P1RpsgCSdBOUCP2EhkT+RUT33HribXBgqppTBjhBGC3z+WmrOFBB7N2JVT7bwiN6pwtlsoO+jzExfQxsWVZunuL5u5CguI+ZM9jIXvZ8YloaiqMg92IzvESUyVj8tvZXTtTmVocxFm2+ucd5jKViUlx2cLo6lLr4Pq07RZjKHCvYS/L6dCn23P+zIPxM5yDGvuI51Hz5R5qoLM3tJv44Nhpx0bW8SGgTSCaL/cIuRKf52uMbeKGmbih4LuiSR4EhmDOF6vvgHq3lgEUS+34Ysw/5+2yTCwMU5ie8Eug0/JEJBYTOtXQLmNJTFRqQvHriFtVhAroom3Q9Qw/jAo/SohDtiCOogXWJb8Rh8SpuJSd3B2VFceP5V6HuD09DaZuD9Z995J1QbjabBOuV3sGznU5rgzlq3usYrVzCz49/YXwNiNqQTLQ/nMWSj7c6uLEYA3CLQylh0zxA+A9MOP/Bx4jPKPvl13jYXnmz5wvDtcYgPwPfCG8ydEYpXlte8OSjDVQRjt5Jmh6A7nGXbHPuhBv+welNM/6/ug+l2BkFZfyN9na4fSJ0A5oZt35HZfPQog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(5660300002)(44832011)(66476007)(8676002)(4326008)(31686004)(41300700001)(66556008)(8936002)(6486002)(110136005)(54906003)(36756003)(478600001)(66899015)(316002)(2906002)(31696002)(6512007)(2616005)(6506007)(86362001)(66946007)(186003)(6666004)(53546011)(83380400001)(26005)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhPaEMvYURnQ3BEaDRjcWE4d2EwamwvTnNEeitZMFlUL3pON3dwWGpBSmYy?=
 =?utf-8?B?dVhqMjZuZlU1MERLTkRFSW84V09lTEtVYlhmbXFqSGRSVHJFa2wzc3NRVVAv?=
 =?utf-8?B?bG0yR3RkNFlCQzFrQll1MG9vL2hUcmdvRWNFVmN2dUJLNTBIUndlM2ttUjFH?=
 =?utf-8?B?UWZRdmF4dGQySHNQejgzWUJER3VTYWVmWUM3QWE3QXlZM2l2V1Bvd0dPVkhU?=
 =?utf-8?B?ei9ESFZyT0FyNU1WVkJ3ek9ScGhZdDVlS2Y0K2h2dWQzbG85M0J4VW5zdlND?=
 =?utf-8?B?Q3ZHUDFZRS8ydm1zUnhCMzRrWGx4eHI1Ri95NlpLSGR2dG04RHhjZXZIWGRz?=
 =?utf-8?B?REx2UjdHd2d1Ymt2T1pMQWdLbWxDeXU0YytXc1ZHaHQrK05UZGRXTHo1RHMv?=
 =?utf-8?B?WnVGZXRLM050amViYnBtUVRiUFlBQUlwTjlEdzVLeFV0dzVGanlWZGRlaGxO?=
 =?utf-8?B?K1ZxbWxKaU02bEtDTDVMVXVOVDUwWG1TZzZWeVVNaEdMdU5KR1JoMjcvaDl2?=
 =?utf-8?B?NXhwOUkrd2ZQNWh2R1RmczRnL0RvcTl4RUdpYWtzOTBxdWlBbXZ6YnczYU92?=
 =?utf-8?B?R0oxdEdUZjZ4QVFyWnJHTnk2STJNNGgrOVpoWUVJOGlZYnovMUV3N3Jlam1P?=
 =?utf-8?B?MTRCcnkwU0ZmbUQxTU1XYmg1RGFWeVUrdTM2MXovcTNyUmQzTlFDeTZtaS9s?=
 =?utf-8?B?RkhIUlJnTXhlalJsd3AxVGYzRWpVZW5qak5HQSszVnR5RmhkNnVIWkJ5R1FJ?=
 =?utf-8?B?aWdidGJVUmd5bEIzZ3Nmc215bkYyZEQ1R2VabFY5V0ovUkRRKzdKT2hTalNN?=
 =?utf-8?B?dE44SjI3T0kxeExBWEtEUE9qRW5MU0xWbkxndHRUWUNCN0t2OGxBamlGcGRY?=
 =?utf-8?B?Y3lVd0xJODBTcmZLOWlzMXZwdlpGUDNRRjQrSGZvU3VjMmpJV2lIMHpBaldj?=
 =?utf-8?B?MkgxcG05cFIzZnhMcnk2aVdIM0tFZTlwRXNnUHpWMFRQTTZwRXJ2ZmJaY3Yx?=
 =?utf-8?B?VXlSamQxL3ZEby9BdE9HdmQrQ1d3ZHJVcW9iY3ZNL3dEL3M3SnNqUk9YbmE1?=
 =?utf-8?B?Mnc0QUVzaDNMN2R2THVZQ2pkWTBzMjVXU3BRWHNqOEhadjFMYnhOckw3VitO?=
 =?utf-8?B?SjdZY0hPeWlSSm9PQXRvOVpIN2FmRnl5Y004UFlUaG9sZUEwcVdkZGw0dDRk?=
 =?utf-8?B?bkh6QkNkc01oZE1uL2lCS1FpeDh6aHFQQzFpaHdqR1VDQVVsRmoyemlrUEtR?=
 =?utf-8?B?TWNtV1NPUTI3NjQvMktVczBYazZSNmJqajFQcktHaXR3YUhDTVA5MGJmNENP?=
 =?utf-8?B?Qjg0ZGNNb251Zlg5NmRSeHd0RDhmbnJUaVV4S2Y4elkzM2Z1WmR6NEMvWXd0?=
 =?utf-8?B?TWd4V3ltTnlaclJ2YXEweVRETjA4U2I5WGszWEJNUm9ZSU5GSGd0NkZwWEZy?=
 =?utf-8?B?RGdoRzUyNkJoQUt3SkFUU2l1VUh1ZWV6OVVMT3hrWWk1SnBVQkM3TUZzWUxl?=
 =?utf-8?B?WkVpdUNFaDA1Q3dIY0Z2akloR044elFRSXZWbGkvVzJaUWEzalhZZVV4NDY1?=
 =?utf-8?B?ZFNJS0pJcXhaU0VRRzVSdk94UTV0bmcrMDNudU5UTEtvc1BCbjZJOUh2K3g5?=
 =?utf-8?B?eHU0Qk1uS0xsamR4a0xhM2xacUZnRUZobVlGN3liVGVpVEtDdHpndS81dkM0?=
 =?utf-8?B?dkxZSmpRODUrYVRqUkZhNm1TTzFRdmh1bllLaU1aaG9pek5pQnJqRktDVzJw?=
 =?utf-8?B?TGlOTENLV21mblQ1dG1iL2VuUHN5dVlENW5uWlprM2Z5enZXVXp6L3plMzdB?=
 =?utf-8?B?T0Q1cHJtaERtbUxUTlZsMy9WUk5VaFBsRXZSdUR4Wm5QMHQ1cktPZEozVjJp?=
 =?utf-8?B?Q0oxb2pXVzQ2MmptY0dGR1BjTFpBUFNFWWgwVWlEbnhBMkR0cEtzYi9RT29V?=
 =?utf-8?B?K2VGaEhHTUpleWJMNDZ0Wklzek9tc3N1NTA1bU8xNkJXTytlclh4M0V3NTFt?=
 =?utf-8?B?eEhiRmE1N0x6OHQ0c2RYYmduSU1zdGJ1Rk5EVi9EWU9uclhxVXB3YTQ2blJJ?=
 =?utf-8?B?ZFBsbmNpZkNxRVVrM1Z6ZmhhNHFjZDg5djU0NHB5MGdWc2c2YllLVlN1T2tu?=
 =?utf-8?B?aTFNMUNSWWdoa1pFYlNtU2IydUpMbldXUy96MTh4amhQcDUzUTRlRzQ1dkdS?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdf7e76-f437-4c3b-cf04-08dad3c79d5b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 18:12:32.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3myWc77wMBafDyOIwFyAVXQE20dXCh/LQeZtcLLsnE/OzyzEuwazxfhdWRQXFFL0w6cHJA9PDqCIoAq8qRG1klKaFU4+8HVdqHasJtoeXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 12/1/2022 12:20 AM, Shaopeng Tan (Fujitsu) wrote:
> Hi Reinette,
> 
>> On 11/30/2022 12:32 AM, Shaopeng Tan (Fujitsu) wrote:
>>
>>> Removing ctrl_handler() is only part of the fix in the next version(v5).
>>> All fixes as follows.
>>>
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -98,12 +98,17 @@ void cat_test_cleanup(void)
>>>         remove(RESULT_FILE_NAME2);
>>>  }
>>>
>>> +static void ctrlc_handler_child(int signum, siginfo_t *info, void
>>> +*ptr) {
>>> +       exit(EXIT_SUCCESS);
>>> +}
>>> +
>>
>> Could you please elaborate why this is necessary?
> 
> If enter "ctrl-c" when running "resctrl_tests -t cat",
> SIGINT will be sent to all processes (parent&child).
> 
> At this time, the child process receives a SIGINT signal, but does not take any action.
> In this case the parent process may not call ctrlc_handler() as expected.

Apologies, but I am not able to follow. My understanding is that the
ideal in working an failing case is for the parent to kill the child.
Could you please elaborate why the ctrlc_handler() may not be called?

> Therefore, ctrlc_handler_child() is necessary.
> 
> It may be better to ignore the signal, then code can be simple as follows.
> ----
>         if (bm_pid == 0) {
>                 param.mask = l_mask_1;
>                 strcpy(param.ctrlgrp, "c1");
>                 strcpy(param.mongrp, "m1");
>                 param.span = cache_size * n / count_of_bits;
>                 strcpy(param.filename, RESULT_FILE_NAME1);
>                 param.num_of_runs = 0;
>                 param.cpu_no = sibling_cpu_no;
>                 /* Ignore the signal,and wait to be cleaned up by the parent process */
>                 sigfillset(&sigact.sa_mask);
>                 sigact.sa_handler = SIG_IGN;
>                 //sigact.sa_sigaction = ctrlc_handler_child;  //delete
>                 if (sigaction(SIGINT, &sigact, NULL) ||
>                     sigaction(SIGTERM, &sigact, NULL) ||
>                     sigaction(SIGHUP, &sigact, NULL))
>                         perror("# sigaction");
>         } else {

Reinette
