Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C477EF20
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHQCer (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 22:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbjHQCe2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 22:34:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA22D5F;
        Wed, 16 Aug 2023 19:34:25 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RR8D10G9PzVkPs;
        Thu, 17 Aug 2023 10:32:17 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 10:34:23 +0800
Message-ID: <301d92c8-2932-e58b-d1f3-d642f1119189@huawei.com>
Date:   Thu, 17 Aug 2023 10:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] selftests/ftrace: let traceonoff_triggers testcase
 without md5sum
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20230814025918.2726807-1-zouyipeng@huawei.com>
 <20230816162023.79ad9a47@gandalf.local.home>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20230816162023.79ad9a47@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/8/17 4:20, Steven Rostedt 写道:
> On Mon, 14 Aug 2023 10:59:18 +0800
> Yipeng Zou <zouyipeng@huawei.com> wrote:
>
>> So I directly dump the trace file before md5sum, the diff shows that:
>>
>> [root@localhost]# diff trace_1.log trace_2.log -y --suppress-common-lines
>> dockerd-12285   [036] d.... 18385.510290: sched_stat | <...>-12285   [036] d.... 18385.510290: sched_stat
>> dockerd-12285   [036] d.... 18385.510291: sched_swit | <...>-12285   [036] d.... 18385.510291: sched_swit
>> <...>-740       [044] d.... 18385.602859: sched_stat | kworker/44:1-740 [044] d.... 18385.602859: sched_stat
>> <...>-740       [044] d.... 18385.602860: sched_swit | kworker/44:1-740 [044] d.... 18385.602860: sched_swit
> So the problem is the <..> being added?
>
>> And we can see that the saved_cmdlines in kernel was changed.
>>
>> So Maybe there is no safe to use md5sum here to verify whether
>> the file whether it has changed.
>>
>> >From my point of view, we only need to verify traceoff event  
>> is valid there.
>>
>> Maybe it is enough to check first that the tracing_on equals 0,
>> and then check that the total number of rows of trace does not
>> increase?
>>
>> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>> ---
>>   .../test.d/ftrace/func_traceonoff_triggers.tc    | 16 ++++------------
>>   1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> index aee22289536b..180c60605d7b 100644
>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> @@ -77,25 +77,17 @@ if [ $cnt -ne 1 ]; then
>>      fail "Did not find traceoff trigger"
>>   fi
>>   
>> -cnt=`cnt_trace`
>> -sleep $SLEEP_TIME
>> -cnt2=`cnt_trace`
>> -
>> -if [ $cnt -ne $cnt2 ]; then
>> -   fail "Tracing is not stopped"
>> -fi
>> -
>>   on=`cat tracing_on`
>>   if [ $on != "0" ]; then
>>       fail "Tracing is not off"
>>   fi
>>   
>> -csum1=`md5sum trace`
> What about just changing the above to:
>
>   # Can not rely on names being around as they are only cached
>   csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>
>> +cnt=`cnt_trace`
>>   sleep $SLEEP_TIME
>> -csum2=`md5sum trace`
> And this:
>
>   csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>
> That will strip off the names an leave just the -[PID]... part of the line?
>
> -- Steve
>
>
Hi Steve:

     Thanks for your suggests, this is indeed more effective.

     The problem was that <...> filed be filled with names, and it 
causes the md5 value changed.

     I will send v2 in that ways, thanks !

-- Yipeng

>> +cnt2=`cnt_trace`
>>   
>> -if [ "$csum1" != "$csum2" ]; then
>> -    fail "Tracing file is still changing"
>> +if [ $cnt -ne $cnt2 ]; then
>> +   fail "Tracing is not stopped"
>>   fi
>>   
>>   clear_trace
>
-- 
Regards,
Yipeng Zou

