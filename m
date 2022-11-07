Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E762024B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKGWbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 17:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGWbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 17:31:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA576220D6;
        Mon,  7 Nov 2022 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667860300; x=1699396300;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8X6BMvdI2Kz+qK9z9RJfsOskys45OXoXy8RitP+hph8=;
  b=ML4SxoU3yWdKh94FE6KUEng2mZJIYoI+uRKjVToqX9SXCkh2c4OqEYWs
   M9ut303ZX8i56wrYJd6WJcQjDUDbDyq1RLB7WqgPj7LN20HI80RWmO+NI
   uTVGgZhHNGOEkJhhnthuIUPJ992bxOXT+UINlDXttdFDtBQbr/Wyv3sO9
   EdgpV2VxE0TOBVhEajPYMy3ypFvryl1Qbz8RkOLleCLfioRNcrEJvsC9P
   dqMB+cDPp63+LGLOtY3TckzbFJd4289Vw+8cbTuoQSh8soCWE0Wgvyd9T
   jyWEhrhVNTotEaYdOWvbuEngYQPHeXaIyGfbSybfzi59yWg7/eNeEQdu2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290261838"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290261838"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638545703"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638545703"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 14:31:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:31:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 14:31:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 14:31:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQD0+hL+XEHtf3ezEcTt88srytzhBWWnnemBSzQKJYaE3pKm8l6uJQg8b0WPs6Ag8Udh1sDKgs7HXG0L4cLBpm2m+d4K1mCVYCOpNWRM6k+KhOivmr3RmGpqEXq8Tv6URCV+jOqQdLuE9WZH3gujIRSitUR07clBj1tFtdI5oUi+1JqMkvZIrrLoyXCRKzRnts2pjXmeQbwgrhcnLXgotRpNPpSb3OwcvGuiTGZdW2Rqkz8ifkAizNVFmflxcCStI8ZR3IZ37KL42EGa4KtuULZB7sD54iKu055LQ/6dhWYALXVXxRoMfl/E9iUdeFzeMT/TwPNENOXxWSsdPY50Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW2qi0Rgxzzp/TK2tbP4G7BQnsApRZ68jykHPe3DKiA=;
 b=dh7bJ5SP3yEdU/O0sWzowWTFtyqRogfXqNDTyPgBSIMKposgKJ+tY0CZWuNaBUxBltDROlFTRuSVoggiciImyuVOkAAO4hMm1IDlzvjzDdQfip3xF2ZExo7HJzjr12EE9F1YqSy+mYvMOHTs2IquO12Uy3J+tBSeWqlYtg8QH71A874LHnydR61WgFMBrStqwZMfMkv0s0aJI153IDoHvccGK6rxFElT0nZcLGkcP1Ta36EjEWh/BRkFf7qMLus+7Z+mXXNjCv6kDFKDeETbVp91GefwdmSok/dE33fEeQJHiujyVch5Peu+6aD6VMSsPm4c8jVHhiZUQGf61d0BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 22:31:37 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 22:31:37 +0000
Message-ID: <2ab9ca20-c757-7dd8-b770-2b84d171cbfb@intel.com>
Date:   Mon, 7 Nov 2022 14:31:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
 <39586b57-aad2-d9ca-df12-67f1dfe60258@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39586b57-aad2-d9ca-df12-67f1dfe60258@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: bb35c83f-434d-4f29-35bf-08dac10fd53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH/OicenvO8UtSFZpwyVgNOh823MTKpUXo+a7ERUxKNOX+0wSgx+avwZvdGaWqxRmJni7ufMr0UJ6VMEobU2UEzhPJzbmIGhBcR5Z1fLV1KJylvkTKkUSNH40GFyItPte4pSz9Til3+WR+xvQ6DrdmXmO+E7t0p7MWcm/00ZrpGi3vx7lIk6vYoz9yKa8yQ/ImxofYiEmVuWm5Zs/HjOoSmJ+AukqPMDtwhsihus1aKRCK9BogmX/bXYdnKd/XMPMDpN0vhLBRWqGldfKF2C2qmZYC4jIRBhE4kJoe6p5GRUeERVga4XRk4j0NQEPVsAirQUNHu7gaEgaARnHvXq/s10ZEOT/ukVZqYgvaLmsqQgAfi3C8tQ2jlpN3v/d21XfkqmNVM5C5FZndyGHI6Rv4AwLQamGxh4fGFOQ06fqd3SXLIuEIotF5kyR+M/h+VVP4XFSesl8IC31MWgBPrq7JqV58wslh1x382gcE+E7aE9jsLonbWeOvgJppru5csyJR+J1MEAQU4ysGNsM5sOcLPIjqmSf0GKuj7P5fuu0VNDW8LglCQlTzuZPxxpuWzY3dFEFrDZTWa85J7sFj0QWN12wndqcSlj3SF0XeL9KouRSF40c1vfAgadGPEGN/KyFkERlLA2xBmTocwL4tY3gPMkT71k9sjzsaO27t/9g97xYAvvvhW3sdYStfi0BAZp6b5Cs/6pAs6ONHBnINA+MS8AOm5qjka36xgHgHAU9GeZqGNJp1xIVp1yUZC7rf/FrZZFSHRCAR1ZwVZyHJaRBAcC8fVhqtSkQqXDg1aw8Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(2616005)(186003)(31686004)(86362001)(6666004)(316002)(110136005)(38100700002)(31696002)(36756003)(82960400001)(83380400001)(6512007)(6506007)(53546011)(26005)(478600001)(5660300002)(8936002)(66556008)(6486002)(44832011)(8676002)(4326008)(66946007)(41300700001)(2906002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXlOWGYyQTRkYWdjR24yOHdRaU5OM2JjOVhmWW0vUjhqY0ZVcXB6aGpqYWlH?=
 =?utf-8?B?QllOT2prM2ZPRDdMYlA4VnJFLytxYTV0YkpwSkZjRzJJS3RhZjRZYlM4WHpj?=
 =?utf-8?B?R0xjMUNIdGsvT0QwaVJBU0xrajRpVHREanpGNlJRZURKR0JIZ2Ixam51TFRh?=
 =?utf-8?B?dXBHUUJobnRqRDBoUEtEWFpBbzdKeEtYcXJxQ2NHR3gyVklNUk9GNGNRS1FJ?=
 =?utf-8?B?WC91c2Q3cC91b282TzZPY04ybHdoRjV1RkJabXpTZE1VZmthNEQyRXBVeitt?=
 =?utf-8?B?QTZVSUNwd3hlcjNKc3dwQ3BySlpocFJJRVBSRktNQVlhaU9sNWdOc3lkTktr?=
 =?utf-8?B?bFdka2lleEFwbmxBOUtPS2pkSjQ0ZVBJUCtUSHMzSlVLaGhXbW9WNDk0QXdI?=
 =?utf-8?B?WW5jMnU0TERJYmY3aHpVVTZkRENRV0FIcm5JdjgzcHZnRW5kcm5MUVZCdlM2?=
 =?utf-8?B?ME9uamg5dm5xMlp2czJDdjdDM1pTc0pTUXZjMDZ2SmdWT0lUbW5qa2ZPNUJn?=
 =?utf-8?B?Nk4xYWxrS1dZN2t1dXkwQkNxWDZUQ201VFhUeDBmR3QzY2FrbGp2Z05YTVBF?=
 =?utf-8?B?TGc0aGhLUUFEYkVpdjVzeGJCdGE4bFlvWGgwL084dm1Yc3BpMDBLRGVYWERB?=
 =?utf-8?B?eHExVVVjOVFEdUdVWkUyeWFFbUtyKzdNWmwydFAwNC80TmlIQzJTbHVKNHpQ?=
 =?utf-8?B?WWFzWWtJRzZwL1N1UmNlczVYZ2Q3a1FITDZHSWd6amlYaitCQXMrdDljRTBV?=
 =?utf-8?B?N2lPMUMxN2RpVmFISnhVc2ZyOTRYa3Nzd2lLNEEvSDA5MStRbnBPcllMVXpO?=
 =?utf-8?B?ZUdMUzZSdmErN0VNM29aeHhIbzZBelF4b1NTTFhPelhHa0NXRm5DMW1MalJN?=
 =?utf-8?B?aGoyaTZoOWVnOCs1aXVwQ09PMWdnZDB5dzhsa2ZlQTREVmIvMlBpbWZqV2s5?=
 =?utf-8?B?ZmhLNHQ0dnBDZEkxSDFkblRXUjM3WFd1L0tOYWkxYlJTTFdzTDY0bWxidFBV?=
 =?utf-8?B?MUhlRkdZVGtzdVROUlhSYlVwVmNid09WbUo0MENTZVQ5a0tPRU5wMU8zT0c1?=
 =?utf-8?B?SitrZGxuYjlTVmJCTHpUb3dJN0k4Q1dxRys4T0ZHcHRpVFJvVHFia0MwVGl2?=
 =?utf-8?B?S0FlYXNuR1BKeUxocEFGTUk0K2M1a05Xem1XU3pDcWpRNVp1OG5lNFJrNm1w?=
 =?utf-8?B?eEtCdlZxOHBOYmkrUGkzd1NlcFBTTkYzNXFLbU9SMkdLbG9hRVRXbVFkNkI2?=
 =?utf-8?B?ekowRmh1ZVFwQitpaWpUK05ZdkEyK2UyT2ZiSk1yU0xiL2pMR1kvWWFVVm1O?=
 =?utf-8?B?T2tMeDVMd3h0NkFLSmFVbU4wdzRWUFJwNXVZc296RHlzTVJTMktQa01NRXFk?=
 =?utf-8?B?dXdRT3gySmlmWFRtRnhLbXhPRVFMK2dOcnlDb09rb2lsL0thYnZJaW9vQkhm?=
 =?utf-8?B?c2tqY1drSDc5aXhPTmVZYm44Rmt2VFQyaWVYa3JDbDdVKzBidnlYbVFianFw?=
 =?utf-8?B?OUlmdWNnUzVKc2F2Q2F4dXVSRFZxMzJQWXZFS3lPemdLUnVUSmpOOVpkZC9u?=
 =?utf-8?B?bXdaWmhKNWNCVEJ4eGhlUVE3ck0wRlZhT0xhZ2VqNEYwR2JMUlpXYWI0QUhU?=
 =?utf-8?B?TGlVS3N3VU1iaWc5OEVQY3h0czJMaHExRHZtWjlqZ3Bpdkh5dDJrTmNsOXlS?=
 =?utf-8?B?MnIzY05xMmh2RGthdEIxa2luclFxazZubmFmQUZIa1dZTGVoTnFaQ0xhdW5Y?=
 =?utf-8?B?V3FIL2lXNlpyYmdJMHdaazJpM0swVzB1bHc5SFJOODVxQVdpVk9vaXZvSTNr?=
 =?utf-8?B?bERmYzhlbFRodzBJOFlIT1duVHVxd0p6Zy8wNml3c0wzcUlpZkIyQ3NhWTFY?=
 =?utf-8?B?Tlo3OFNWUXZFY0M1dS9EOW1sTitBRGYveXIwQnBRTlMxQUdTaXlLTk1Ic3RK?=
 =?utf-8?B?M0hhQTFva1hMc0hOeTRvMVFwYndsVlNZRGcrcDJ2TkRkcGwzUmxqdVJRWkVy?=
 =?utf-8?B?ejNPd2JvWXQ2MmpOOFBHYStRdGUvdEhrYk5VSFF3VCtIQXUxMFk2K2JMVXZI?=
 =?utf-8?B?UWNTNlkyUGk1OVhyeTJ0UkIzdm5yTzY4TWRoNW5ETStqbmNTc1c5SHBraklO?=
 =?utf-8?B?Z1dJR01YNzVtNmNrRVczeFdXc0s3VHNhWXZXSlVueXFXRGwzeDA5SzNoMUZZ?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb35c83f-434d-4f29-35bf-08dac10fd53b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:31:37.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry8AKFPkOSD5KaSQBX9N/+JTkXtNkRFFN3td6U9Spka4Kd+P32REJIYJPB94cv45XWQEMCFnoOBTWjHLUvlMuT03zZ0Kt1Vr5MpggBjWXxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng and Shuah,

On 11/2/2022 2:41 AM, Shuah Khan wrote:
> On 11/1/22 03:43, Shaopeng Tan wrote:
>> After creating a child process with fork() in CAT test, if there is
>> an error occurs or such as a SIGINT signal is received, the parent
>> process will be terminated immediately, but the child process will not
>> be killed and also umount_resctrlfs() will not be called.
>>
>> Add a signal handler like other tests to kill child process, umount
>> resctrlfs, cleanup result files, etc. when an error occurs.
>>
>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> ---
>>   tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++++-------
>>   1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 6a8306b0a109..5f81817f4366 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -98,12 +98,21 @@ void cat_test_cleanup(void)
>>       remove(RESULT_FILE_NAME2);
>>   }
>>   +static void ctrl_handler(int signo)
>> +{
>> +    kill(bm_pid, SIGKILL);
>> +    umount_resctrlfs();
>> +    tests_cleanup();
>> +    ksft_print_msg("Ending\n\n");
> 
> Is there a reason to print this message? Remove it unless it serves
> a purpose.

This function appears to be a duplicate of existing
resctrl_val.c:ctrlc_handler(). Could the duplication be avoided
instead of refining the copy?

> 
>> +
>> +    exit(EXIT_SUCCESS);
>> +}
>> +
>>   int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>   {
>>       unsigned long l_mask, l_mask_1;
>>       int ret, pipefd[2], sibling_cpu_no;
>>       char pipe_message;
>> -    pid_t bm_pid;
> 
> Odd. bm_pid is used below - why remove it here?

There is a global bm_pid in resctrl_val.c that is made available
via extern in resctrl.h. This is what causes this code to still
compile but I would also like to learn why moving to that is
desired as a change here. I expect such a big change to get a
mention in the commit message.

> 
>>         cache_size = 0;
>>   @@ -181,17 +190,19 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>           strcpy(param.filename, RESULT_FILE_NAME1);
>>           param.num_of_runs = 0;
>>           param.cpu_no = sibling_cpu_no;
>> +    } else {
>> +        /* set up ctrl-c handler */
>> +        if (signal(SIGINT, ctrl_handler) == SIG_ERR ||
>> +            signal(SIGHUP, ctrl_handler) == SIG_ERR ||
>> +            signal(SIGTERM, ctrl_handler) == SIG_ERR)
>> +            printf("Failed to catch SIGNAL!\n");
> 
> Is perror() more appropriate here?

Should we be using signal() at all? "man signal" reads:
"WARNING: the behavior of signal() varies across UNIX versions,
and has also varied historically across different versions of Linux.
Avoid its use: use sigaction(2) instead."

"Failed to catch SIGNAL" also seems unclear to me. This is
where a signal handler is set up, the signal for which the handler
is installed has not arrived.


> 
>>       }
>>         remove(param.filename);
>>         ret = cat_val(&param);
>> -    if (ret)
>> -        return ret;
>> -
>> -    ret = check_results(&param);
>> -    if (ret)
>> -        return ret;
>> +    if (ret == 0)
>> +        ret = check_results(&param);
> 
> Why not use a goto in error case to do umount_resctrlfs() instead of changing
> the conditionals?

My understanding is the code that follows is needed to
synchronize the exits between the parent and child. It is the parent
that will run umount_resctrlfs() and it should only do so
after the child is done. A goto by the parent may thus cause
umount_resctrlfs() to be run while the child still relies on it while
a goto by the child may cause the parent not to receive the message
that the child is complete.

Reinette
