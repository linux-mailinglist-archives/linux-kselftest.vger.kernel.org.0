Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA678441276
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 04:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhKADqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Oct 2021 23:46:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:42537 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhKADqm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Oct 2021 23:46:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="231203934"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="231203934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 20:44:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="449123239"
Received: from yeqin-desk1.ccr.corp.intel.com (HELO [10.167.226.45]) ([10.255.28.179])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 20:44:04 -0700
Subject: Re: [LKP] Re: [tracing/selftests] cfece71411:
 kernel-selftests.ftrace.event_trigger_-_test_inter-event_histogram_trigger_onchange_action.fail
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Sang, Oliver" <oliver.sang@intel.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "surenb@google.com" <surenb@google.com>,
        "hridya@google.com" <hridya@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211025200852.3002369-8-kaleshsingh@google.com>
 <20211029064818.GG737@xsang-OptiPlex-9020>
 <20211029210056.6cd7796aea59cec3e9c1d7da@kernel.org>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <4194a7d6-db5c-5efe-debc-3c3121d1ebff@intel.com>
Date:   Mon, 1 Nov 2021 11:43:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029210056.6cd7796aea59cec3e9c1d7da@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 29/10/2021 20:00, Masami Hiramatsu wrote:
>
>>
>> TAP version 13
>> 1..1
>> # selftests: ftrace: ftracetest
>> # === Ftrace unit tests ===
>> # [1] Basic trace file check	[PASS]
>> ...
>> <<< [1] - [67] have same results as parent, i.e. both PASS or both FAIL >>>
> At first, I guess the robot just checks the "[number]" instead
> of the test description, but the ftracetest doesn't fix the "[number]"
> for each test, Thus, it can be different when updated it.

Hi Masami

Good catch, thanks for these information, we will improve the robot.

Thanks
Zhjian


> So if you compare the result, please check the descriptions too.
>
>> ...
>> # [67] event trigger - test multiple actions on hist trigger	[PASS]
>>
>>>>> [68] - [72] can PASS on parent
>> # [68] event trigger - test inter-event histogram trigger onchange action	[FAIL]
>> # [69] event trigger - test inter-event histogram trigger onmatch action	[FAIL]
>> # [70] event trigger - test inter-event histogram trigger onmatch-onmax action	[FAIL]
>> # [71] event trigger - test inter-event histogram trigger onmax action	[FAIL]
>> # [72] event trigger - test inter-event histogram trigger snapshot action	[FAIL]
>>
>>>>> [73] fail on parent, too
>> # [73] event trigger - test inter-event histogram trigger eprobe on synthetic event	[FAIL]
>>
>>>>> [74] - [92] can PASS on parent
>> # [74] event trigger - test synthetic event create remove	[FAIL]
>> # [75] event trigger - test inter-event histogram trigger trace action with dynamic string param	[FAIL]
>> # [76] event trigger - test synthetic_events syntax parser	[FAIL]
>> # [77] event trigger - test synthetic_events syntax parser errors	[FAIL]
>> # [78] event trigger - test inter-event histogram trigger trace action	[FAIL]
>> # [79] event trigger - test event enable/disable trigger	[FAIL]
>> # [80] event trigger - test trigger filter	[FAIL]
>> # [81] event trigger - test histogram expression parsing	[FAIL]
>> # [82] event trigger - test histogram modifiers	[FAIL]
>> # [83] event trigger - test histogram parser errors	[FAIL]
>> # [84] event trigger - test histogram trigger	[FAIL]
>> # [85] event trigger - test multiple histogram triggers	[FAIL]
>> # [86] event trigger - test snapshot-trigger	[FAIL]
>> # [87] event trigger - test stacktrace-trigger	[FAIL]
>> # [88] trace_marker trigger - test histogram trigger	[FAIL]
>> # [89] trace_marker trigger - test snapshot trigger	[FAIL]
>> # [90] trace_marker trigger - test histogram with synthetic event against kernel event	[FAIL]
>> # [91] trace_marker trigger - test histogram with synthetic event	[FAIL]
>> # [92] event trigger - test traceon/off trigger	[FAIL]
>> # [93] (instance)  Basic test for tracers	[PASS]
>> ...
>> <<< [93] - [112] have same results as parent, all PASS >>>
>> ...
>> # [112] (instance)  trace_marker trigger - test histogram trigger	[PASS]
>>
>>>>> parent has no [113]
>> # [113] (instance)  trace_marker trigger - test snapshot trigger	[PASS]
> And next, some patch series may *ADD* new testcases if the series add
> a new feature, so if you find the difference which is not in the
> parent commit but it is passed, please ignore that.
>
>> # tac: failed to create temporary file in '/tmp/ftracetest-dir.o54lNh': No such file or directory
>> # tac: failed to create temporary file in '/tmp/ftracetest-dir.o54lNh': No such file or directory
>> # tac: failed to create temporary file in '/tmp/ftracetest-dir.o54lNh': No such file or directory
>> # tac: failed to create temporary file in '/tmp/ftracetest-dir.o54lNh': No such file or directory
> And if you find this kind of new error message like above, please report it.
> This is more important for us.
>
>> #
>> #
>> # # of passed:  85
>> # # of failed:  26
>> # # of unresolved:  1
>> # # of untested:  0
>> # # of unsupported:  0
>> # # of xfailed:  1
>> # # of undefined(test bug):  0
>> not ok 1 selftests: ftrace: ftracetest # exit=1
> Also, please configure your running environment correctly so that all
> ftracetest passes. If you unsure how to do, please ask me.
>
> Thank you,
>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>>
>> ---
>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>>
>> Thanks,
>> Oliver Sang
>>
>

