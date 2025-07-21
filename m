Return-Path: <linux-kselftest+bounces-37731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432ADB0B9D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 03:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB963B8A67
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E71714B7;
	Mon, 21 Jul 2025 01:54:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039518F40;
	Mon, 21 Jul 2025 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062870; cv=none; b=NjPNERGLPPKCCF9ebaNUAzFsrb37N7Q/ZJO8CRdEVVL9pvNaYKwoxGCTOgY5hK8wu58+5I4y+qnkaDEjepq+ct/BQsyuy7J8HKQI7f5R5Iw4/9yhonTIkiNFnDYliOvaFjO4w1uJGF+ghHgs9X0seLcBxZGjw/R5E261Ir8Zqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062870; c=relaxed/simple;
	bh=lKAzAIp3dgL4Rokm+Bq94JJNgfNlAz5gm+nJYk/NyW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHkA/EDXY0KCl+nRD7ABWWfNNC1xaYzJRwR7ngSIlZU8jc2ouAgQLaGdD9k0+r2lOziRiNOKFkpm6GMoPX5s/C8qJOSZjza+LFz6AjD8esw05YLx4gCIQVNcC60i1883ihrP0mpI8xGQ6KYC3s+Grihyy/X8yi0zntrkpCM0N5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4blk3N6xS3zYQv5V;
	Mon, 21 Jul 2025 09:54:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AC2271A0A5A;
	Mon, 21 Jul 2025 09:54:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgAnoxPOnX1olwnVAw--.52220S2;
	Mon, 21 Jul 2025 09:54:23 +0800 (CST)
Message-ID: <88286bd2-a833-47e3-a0f0-896fbdd3fcbb@huaweicloud.com>
Date: Mon, 21 Jul 2025 09:54:22 +0800
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
X-CM-TRANSID:gCh0CgAnoxPOnX1olwnVAw--.52220S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWrGF15XFy3Xr45ur4xCrg_yoW5AF15p3
	4xAasIkwn3GFWYk3sag3Z5XFyrXrWvyrZ0ya15Jr15Ar1DAryxXFn7Kr45WF47WrZYv3s3
	A3WI93W3ZFyqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
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


Hi, Steve

I noticed this patch hasn't been merged yet. Do you plan to merge it soon?
If you're too busy, would you like me to help submit it instead?

Regards,
Tengda


