Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488801A9053
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392484AbgDOBTh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 21:19:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42002 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392479AbgDOBTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 21:19:35 -0400
X-IronPort-AV: E=Sophos;i="5.72,384,1580745600"; 
   d="scan'208";a="89041964"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Apr 2020 09:19:30 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BF15D49DF126;
        Wed, 15 Apr 2020 09:08:56 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 15 Apr 2020 09:19:25 +0800
Message-ID: <5E96611B.10100@cn.fujitsu.com>
Date:   Wed, 15 Apr 2020 09:19:23 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     <shuah@kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, <mingo@redhat.com>,
        <ice_yangxiao@163.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Check the first record for kprobe_args_type.tc
References: <20200407063419.292821-1-yangx.jy@cn.fujitsu.com>   <20200407095400.2a13b821@gandalf.local.home> <20200408003026.24627a881c8f1eacb01cea48@kernel.org>
In-Reply-To: <20200408003026.24627a881c8f1eacb01cea48@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: BF15D49DF126.AD5C8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Sorry to bother you.
Steven and Masami have reviewed this patch so can you apply it to your 
tree?

Thanks,
Xiao Yang
On 2020/4/7 23:30, Masami Hiramatsu wrote:
> On Tue, 7 Apr 2020 09:54:00 -0400
> Steven Rostedt<rostedt@goodmis.org>  wrote:
>
>> On Tue, 7 Apr 2020 14:34:19 +0800
>> Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>>
>>> It is possible to get multiple records from trace during test and then more
>>> than 4 arguments are assigned to ARGS.  This situation results in the failure
>>> of kprobe_args_type.tc.  For example:
>>> -----------------------------------------------------------
>>> grep testprobe trace
>>>     ftracetest-5902  [001] d... 111195.682227: testprobe: (_do_fork+0x0/0x460) arg1=334823024 arg2=334823024 arg3=0x13f4fe70 arg4=7
>>>       pmlogger-5949  [000] d... 111195.709898: testprobe: (_do_fork+0x0/0x460) arg1=345308784 arg2=345308784 arg3=0x1494fe70 arg4=7
>>>   grep testprobe trace
>>>   sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'
>>> ARGS='334823024 334823024 0x13f4fe70 7
>>> 345308784 345308784 0x1494fe70 7'
>>> -----------------------------------------------------------
>>>
>>> We don't care which process calls do_fork so just check the first record to
>>> fix the issue.
>>
>> Looks good to me, but Masami will need to ack it.
>>
>
> Ah, good catch! I had fixed similar issue but missed this one.
>
> Acked-by: Masami Hiramatsu<mhiramat@kernel.org>
>
> Thank you!
>
>> -- Steve
>>
>>>
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> ---
>>>   .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc  | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>> index 1bcb67dcae26..81490ecaaa92 100644
>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>>>     echo 0>  events/kprobes/testprobe/enable
>>>
>>>     : "Confirm the arguments is recorded in given types correctly"
>>> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>>     check_types $ARGS $width
>>>
>>>     : "Clear event for next loop"
>>
>
>



