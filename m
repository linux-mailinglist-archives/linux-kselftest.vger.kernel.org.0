Return-Path: <linux-kselftest+bounces-5286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FB85F7D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636CB2887C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9C60B87;
	Thu, 22 Feb 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pf5Ugc6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB095FB91;
	Thu, 22 Feb 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604118; cv=none; b=fFEHtHJqNPfWgbCdyvCAqQav9dB0fc3fvum8XS5om4eq107bTaQ3amlQ8jt0W8KQBJ6OSjHQQb4xMwpxSfjFS8/Zyd/wvzTL1EfeMncJNJuo4TGK2tXJWl54B4NsB3scbPLJoVZxnzKZT69WUC71B3y/5fMp3VkfJMsjIrF1ijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604118; c=relaxed/simple;
	bh=aR0/iErweFnO6qcJO//a4sOh+50XSNo1DNj3Tma421I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFDeHYVzYDResBGTWYigC/zpH9MgEx676DaH+VcoLmbNR94so3I+WnBoaJX8JHVaYPfHO19D33DTUP2eyFuAWqTF3BPYeqEmm3ZA/nNyb7u9eapY5QtIersxPeXD1byq6xyWn5uSohoP3Gpt6lU5cFDiD2a3T5WdGLYuWJfuJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pf5Ugc6O; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708604107; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gbYCQh1oK43/frtg3H58A79hC36/GOmubLPeJsENmSk=;
	b=Pf5Ugc6ORAETVoZYrBhQmOdJMn1E47i4SLMys9FkBqFnghME1IEEFcFa59qB/oNb32KTW6ihgSNQtugXZXz6Y1wl5qYhP611yQ+xryUO8SW1JsCHTVgypkiSmkj/PO6HyJw3qaosD/JKY68oRANMGY6SHBvjDcACuKANK0c7Xxo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W10zohM_1708604097;
Received: from 30.178.67.169(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W10zohM_1708604097)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 20:15:06 +0800
Message-ID: <7420f9b5-2283-419f-8c6b-705f8b0c53f6@linux.alibaba.com>
Date: Thu, 22 Feb 2024 20:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Limit length in subsystem-enable tests
To: Steven Rostedt <rostedt@goodmis.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240205131233.13686-1-xiangzao@linux.alibaba.com>
 <20240205082120.4144fb6f@rorschach.local.home>
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
In-Reply-To: <20240205082120.4144fb6f@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/5 21:21, Steven Rostedt wrote:
> On Mon,  5 Feb 2024 21:12:33 +0800
> Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
> 
>> While sched* events being traced and sched* events continuously happen,
>> "[xx] event tracing - enable/disable with subsystem level files" would
>> never stop as it cat an endless output.
>> Select the first 100 lines of output would be enough to judge whether
>> there are more than 3 types of sched events.
> 
> It's not that it never stops but on some slower systems it does seem to
> take forever.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@org>
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Thanks,
> 
> -- Steve
> 

Thanks for your ack but I found that I missed the 2nd and 3rd 'trace' 
after 'head -n 100' in code. Should I resend a new patch to fix this and 
meanwhile modify commit messages according to Steve's words?

> 
>>
>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>> ---
>>   .../selftests/ftrace/test.d/event/subsystem-enable.tc       | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> index b1ede6249866..74c1114603a7 100644
>> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> @@ -18,7 +18,7 @@ echo 'sched:*' > set_event
>>   
>>   yield
>>   
>> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>>   if [ $count -lt 3 ]; then
>>       fail "at least fork, exec and exit events should be recorded"
>>   fi
>> @@ -29,7 +29,7 @@ echo 1 > events/sched/enable
>>   
>>   yield
>>   
>> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>>   if [ $count -lt 3 ]; then
>>       fail "at least fork, exec and exit events should be recorded"
>>   fi
>> @@ -40,7 +40,7 @@ echo 0 > events/sched/enable
>>   
>>   yield
>>   
>> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>> +count=`head -n 100 | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>>   if [ $count -ne 0 ]; then
>>       fail "any of scheduler events should not be recorded"
>>   fi

