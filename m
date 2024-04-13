Return-Path: <linux-kselftest+bounces-7905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927758A3A8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 04:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AADDB22FC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 02:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E836168DA;
	Sat, 13 Apr 2024 02:47:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA55101D5;
	Sat, 13 Apr 2024 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712976446; cv=none; b=pvy2jMc2oc10XUCqEmPSjANhZ42fu/8hiljPkU52dNBj81fGPympoTgvNck6yfxPBZ65MSoIcprlJa8d1uwNPykMipKfooUf5kt5jzpoGp8GB9qttS1r4uPm+G2z8Jh1flPxd6B/51kiHNUYKdkmhoKMJpH/FMJtE5DyEwXJJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712976446; c=relaxed/simple;
	bh=4IWaTwtyOQ2skuNnfQppbzaME0kK8u+dyItDzAgSiJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=doWoCJpgAkoKMqyQa0d3DTDKM4mLiuZ7Gj80tYxRuAKJF9g+PwrQAYYYW8XcydxgcC9vEdpR6xN6sYGVEsv1FRe8lb6bcUc1Cnjxi39Jo6Iqa/aJNO5cIPsYoj/sfL092GNtOlBFmINXuls5L7KedQUPLsCbri3QfUln/roowJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VGd7H6Bw8ztSkM;
	Sat, 13 Apr 2024 10:44:27 +0800 (CST)
Received: from canpemm500008.china.huawei.com (unknown [7.192.105.151])
	by mail.maildlp.com (Postfix) with ESMTPS id C304F140157;
	Sat, 13 Apr 2024 10:47:14 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 13 Apr 2024 10:47:14 +0800
Message-ID: <33503bb2-6248-426b-a614-9f0f92899d70@huawei.com>
Date: Sat, 13 Apr 2024 10:47:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/ftrace: traceonoff_triggers: strip off names
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, <shuah@kernel.org>
CC: <mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230818013226.2182299-1-zouyipeng@huawei.com>
 <20230821111358.7540bdc9@gandalf.local.home>
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20230821111358.7540bdc9@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500008.china.huawei.com (7.192.105.151)


在 2023/8/21 23:13, Steven Rostedt 写道:
> On Fri, 18 Aug 2023 09:32:26 +0800
> Yipeng Zou <zouyipeng@huawei.com> wrote:
>
>> The func_traceonoff_triggers.tc sometimes goes to fail
>> on my board, Kunpeng-920.
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Shuah, can you take this through your tree?
>
> -- Steve

Hi:

     I just notice that it haven't been picked in Linux-next.

     It's there other issue about this patch?

>> [root@localhost]# ./ftracetest ./test.d/ftrace/func_traceonoff_triggers.tc -l fail.log
>> === Ftrace unit tests ===
>> [1] ftrace - test for function traceon/off triggers     [FAIL]
>> [2] (instance)  ftrace - test for function traceon/off triggers [UNSUPPORTED]
>>
>> I look up the log, and it shows that the md5sum is different between csum1 and csum2.
>>
>> ++ cnt=611
>> ++ sleep .1
>> +++ cnt_trace
>> +++ grep -v '^#' trace
>> +++ wc -l
>> ++ cnt2=611
>> ++ '[' 611 -ne 611 ']'
>> +++ cat tracing_on
>> ++ on=0
>> ++ '[' 0 '!=' 0 ']'
>> +++ md5sum trace
>> ++ csum1='76896aa74362fff66a6a5f3cf8a8a500  trace'
>> ++ sleep .1
>> +++ md5sum trace
>> ++ csum2='ee8625a21c058818fc26e45c1ed3f6de  trace'
>> ++ '[' '76896aa74362fff66a6a5f3cf8a8a500  trace' '!=' 'ee8625a21c058818fc26e45c1ed3f6de  trace' ']'
>> ++ fail 'Tracing file is still changing'
>> ++ echo Tracing file is still changing
>> Tracing file is still changing
>> ++ exit_fail
>> ++ exit 1
>>
>> So I directly dump the trace file before md5sum, the diff shows that:
>>
>> [root@localhost]# diff trace_1.log trace_2.log -y --suppress-common-lines
>> dockerd-12285   [036] d.... 18385.510290: sched_stat | <...>-12285   [036] d.... 18385.510290: sched_stat
>> dockerd-12285   [036] d.... 18385.510291: sched_swit | <...>-12285   [036] d.... 18385.510291: sched_swit
>> <...>-740       [044] d.... 18385.602859: sched_stat | kworker/44:1-740 [044] d.... 18385.602859: sched_stat
>> <...>-740       [044] d.... 18385.602860: sched_swit | kworker/44:1-740 [044] d.... 18385.602860: sched_swit
>>
>> And we can see that <...> filed be filled with names.
>>
>> We can strip off the names there to fix that.
>>
>> After strip off the names:
>>
>> kworker/u257:0-12 [019] d..2.  2528.758910: sched_stat | -12 [019] d..2.  2528.758910: sched_stat_runtime: comm=k
>> kworker/u257:0-12 [019] d..2.  2528.758912: sched_swit | -12 [019] d..2.  2528.758912: sched_switch: prev_comm=kw
>> <idle>-0          [000] d.s5.  2528.762318: sched_waki | -0  [000] d.s5.  2528.762318: sched_waking: comm=sshd pi
>> <idle>-0          [037] dNh2.  2528.762326: sched_wake | -0  [037] dNh2.  2528.762326: sched_wakeup: comm=sshd pi
>> <idle>-0          [037] d..2.  2528.762334: sched_swit | -0  [037] d..2.  2528.762334: sched_switch: prev_comm=sw
>>
>> Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
>> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>>   .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc         | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> index aee22289536b..1b57771dbfdf 100644
>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
>> @@ -90,9 +90,10 @@ if [ $on != "0" ]; then
>>       fail "Tracing is not off"
>>   fi
>>   
>> -csum1=`md5sum trace`
>> +# Cannot rely on names being around as they are only cached, strip them
>> +csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>>   sleep $SLEEP_TIME
>> -csum2=`md5sum trace`
>> +csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
>>   
>>   if [ "$csum1" != "$csum2" ]; then
>>       fail "Tracing file is still changing"
>
-- 
Regards,
Yipeng Zou


