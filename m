Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73075780301
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbjHRBUm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 21:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356890AbjHRBUf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD03AA1;
        Thu, 17 Aug 2023 18:20:33 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRkXG453JzVk16;
        Fri, 18 Aug 2023 09:18:22 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 09:20:30 +0800
Message-ID: <76880784-7daf-3165-594a-302918ac7302@huawei.com>
Date:   Fri, 18 Aug 2023 09:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] selftests/ftrace: traceonoff_triggers: strip off names
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <shuah@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20230817025028.3953490-1-zouyipeng@huawei.com>
 <20230817141603.7815300ef7a15df1872bb603@kernel.org>
 <20230817090233.1e0a139e@gandalf.local.home>
 <20230817090438.1d784051@gandalf.local.home>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20230817090438.1d784051@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/8/17 21:04, Steven Rostedt 写道:
> On Thu, 17 Aug 2023 09:02:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> Shuah,
>>
>> Can you take this in your tree?
> Actually, hold off please.
>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
>>
>>
>> On Thu, 17 Aug 2023 14:16:03 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>> On Thu, 17 Aug 2023 10:50:28 +0800
>>> Yipeng Zou <zouyipeng@huawei.com> wrote:
>>>    
>
>>>> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
>>>> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>>>> ---
>>>>   .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc          | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>>>> index aee22289536b..c5783999582d 100644
>>>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>>>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>>>> @@ -90,9 +90,9 @@ if [ $on != "0" ]; then
>>>>       fail "Tracing is not off"
>>>>   fi
>>>>   
>>>> -csum1=`md5sum trace`
> Yipeng, can you please add the comment here:
>
> # Cannot rely on names being around as they are only cached, strip them

Of course, There is need to have some comment here.

Sending v3 right now.

>>>> +csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
> --  Steve
>
>>>>   sleep $SLEEP_TIME
>>>> -csum2=`md5sum trace`
>>>> +csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>>>>   
>>>>   if [ "$csum1" != "$csum2" ]; then
>>>>       fail "Tracing file is still changing"
>>>> -- 
>>>> 2.34.1
>>>>      
>>>    
>
-- 
Regards,
Yipeng Zou

