Return-Path: <linux-kselftest+bounces-37057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEFB0115C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814EB1890F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 02:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50A157E6B;
	Fri, 11 Jul 2025 02:49:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FF189F20;
	Fri, 11 Jul 2025 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202145; cv=none; b=afv2DKcZCeSW29Sj0L1/GiztC5RPlOsjl1pwFjFA8AAgvkui+y/tk+UbiXcal7iw4POqH3C7HW725hBl++lHLgzeYipRZa//y62JsE9BaEQRPhHf1CtO5HD57Iy+54OUX1v3PPJBl3YiFFaR8HHwx9ra5L0MvMJ+UAAozypLLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202145; c=relaxed/simple;
	bh=4BeCAP/+BtC4wdS7oU++uxyIbmD56XBumE8BT5LB+mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIvmrUaiTBJxr7M7lBGn0YPftP6TB+hj7pVmxsL4MxPViUlgnFfVuRGpCVNVLMBCNbCo6+9FR0bWuLbaTOF3+R8DAV3V325zNE5fJWdx9kn79OzxG0DIcJ2Ahn5mtwfifupqfZsgx8E0LFo9zTYD6ozLjXJCNeqkoZvSlHAV1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bdbl10GSdzYQtrx;
	Fri, 11 Jul 2025 10:49:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CA97B1A109D;
	Fri, 11 Jul 2025 10:48:59 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgC3fzSWe3BoU_ZSBQ--.15473S2;
	Fri, 11 Jul 2025 10:48:56 +0800 (CST)
Message-ID: <2bf277fb-a1b8-47f8-9133-e3ca27327eda@huaweicloud.com>
Date: Fri, 11 Jul 2025 10:48:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] selftests/ftrace: Prevent potential failure in
 subsystem-enable test case
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Yuanhe Shu <xiangzao@linux.alibaba.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250710130134.591066-1-wutengda@huaweicloud.com>
 <20250710153409.3135fb17@batman.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250710153409.3135fb17@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3fzSWe3BoU_ZSBQ--.15473S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWrGF15XFy3Xr45ur4xCrg_yoWrXFy5pa
	4xAasIkwn7GFWakasag3Z8Ja4rXrWvy3yDGa15Jr15Arn8A342qFn7KrW5WF17urZYv34f
	A3WI93W3ZFyqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/


On 2025/7/11 3:34, Steven Rostedt wrote:
> On Thu, 10 Jul 2025 13:01:34 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
> 
>>
>> Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../selftests/ftrace/test.d/event/subsystem-enable.tc     | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> index b7c8f29c09a9..3a28adc7b727 100644
>> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
>> @@ -19,8 +19,8 @@ echo 'sched:*' > set_event
>>  yield
>>  
>>  count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>> -if [ $count -lt 3 ]; then
>> -    fail "at least fork, exec and exit events should be recorded"
>> +if [ $count -eq 0 ]; then
>> +    fail "none of scheduler events are recorded"
>>  fi
>>  
>>  do_reset
>> @@ -30,8 +30,8 @@ echo 1 > events/sched/enable
>>  yield
>>  
>>  count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>> -if [ $count -lt 3 ]; then
>> -    fail "at least fork, exec and exit events should be recorded"
>> +if [ $count -eq 0 ]; then
>> +    fail "none of scheduler events are recorded"
> 
> So if there's a bug that causes the system enable to only enable a
> single event, this will no longer catch it?
> 
> I rather not let the slide.
> 
> Can you test this to see if this works for you?
> 
> -- Steve
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> index b7c8f29c09a9..46a9e6d92730 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> @@ -14,11 +14,32 @@ fail() { #msg
>      exit_fail
>  }
>  
> +check_unique() {
> +    cat trace_pipe | grep -v '^#' | awk '
> +	BEGIN { cnt = 0; }
> +	{
> +	    for (i = 0; i < cnt; i++) {
> +		if (event[i] == $5) {
> +		    break;
> +		}
> +	    }
> +	    if (i == cnt) {
> +		event[cnt++] = $5;
> +		if (cnt > 2) {
> +		    exit;
> +		}
> +	    }
> +	}
> +	END {
> +	    printf "%d", cnt;
> +	}'
> +}
> +
>  echo 'sched:*' > set_event
>  
>  yield
>  
> -count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`check_unique`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -29,7 +50,7 @@ echo 1 > events/sched/enable
>  
>  yield
>  
> -count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`check_unique`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi

The patch works well - after ~50 test iterations, we haven't observed any
recurrence of the test case failures.

However, I'm concerned that using 'cat trace_pipe' (like the original
'cat trace' method) could bring back the stopping problem [1] on slower
systems.

Could a slow trace_pipe reader (slower than sched event generation rate)
reintroduce the original race condition?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a4ea83a6e67f1415a1f17c1af5e9c814c882bb5

Some test details:

$ ./ftracetest -vvv subsystem-enable.tc
[...]
+ echo sched:*
+ yield
+ ping 127.0.0.1 -c 1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.538 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 1ms
rtt min/avg/max/mdev = 0.538/0.538/0.538/0.000 ms
+ check_unique
+ cat trace_pipe
+ grep -v ^#
+ awk 
        BEGIN { cnt = 0; }
        {
            for (i = 0; i < cnt; i++) {
                if (event[i] == $5) {
                    break;
                }
            }
            if (i == cnt) {
                event[cnt++] = $5;
                if (cnt > 2) {
                    exit;
                }
            }
        }
        END {
            printf "%d", cnt;
        }
+ count=3
+ [ 3 -lt 3 ]
+ do_reset
[...]

Regards,
Tengda


