Return-Path: <linux-kselftest+bounces-37059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D98B011A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 05:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6081CA6502
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 03:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7F19CC11;
	Fri, 11 Jul 2025 03:37:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9D16F265;
	Fri, 11 Jul 2025 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205044; cv=none; b=ZyB5q53hOHmoz4AjiTMFV1pR7SQHL6E+kyNSPh6ajTzRruZoYV3sCynu6EUjhYXQ1wp1U85EcV2e8CMZWxsw8qbK3k5nABP2s47+UQXXQOJ8CWXjkDe1HCRh6j2qIYt1iW+lvP9vp/Zslm81MdIalCAGr6wRYGuvZXaIciQz0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205044; c=relaxed/simple;
	bh=Due+ZsEVsVqHWbezajRnc6wVUa4NOCwIiPko78BclaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfXpzFNZYG47QeVHnkHxJ2gUhCvUGF7rqu/Ge+6UyzldP6CU/GLy2VC8dRTY5SRl8dh5FXdeJjL+Er/l8WIerBjfqEb9VP0EqKhAobJHN27+TnwKmJixRxT2KxBSOMIjvbrYPvnJ9cqXx7qw4vaZNV4V04AAEbSI7uOrJmsNr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bdcpl0sr4zYQtt8;
	Fri, 11 Jul 2025 11:37:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E4BC11A18F3;
	Fri, 11 Jul 2025 11:37:17 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgBHDTLqhnBokcFWBQ--.9098S2;
	Fri, 11 Jul 2025 11:37:15 +0800 (CST)
Message-ID: <6fc6cf98-516a-4121-b593-57bc4f7f36cf@huaweicloud.com>
Date: Fri, 11 Jul 2025 11:37:14 +0800
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
 <2bf277fb-a1b8-47f8-9133-e3ca27327eda@huaweicloud.com>
 <17189AF8-34DC-4E5C-9233-ECADAECBBD26@goodmis.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <17189AF8-34DC-4E5C-9233-ECADAECBBD26@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHDTLqhnBokcFWBQ--.9098S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47Ar13uF18JFW8Jry7ZFb_yoW8Ar4rpa
	y7JFnxKF4kAr4ft3Z2gw4DAryUtrWktryUCws8tw1ruFs0vw13tFyUArWUuFZrZF4Du3y2
	vwn0q3ZF9ryq9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/7/11 11:22, Steven Rostedt wrote:
> 
> 
> On July 10, 2025 10:48:54 PM EDT, Tengda Wu <wutengda@huaweicloud.com> wrote:
>>
> 
>> The patch works well - after ~50 test iterations, we haven't observed any
>> recurrence of the test case failures.
>>
>> However, I'm concerned that using 'cat trace_pipe' (like the original
>> 'cat trace' method) could bring back the stopping problem [1] on slower
>> systems.
>>
>> Could a slow trace_pipe reader (slower than sched event generation rate)
>> reintroduce the original race condition?
>>
> 
> Only if it doesn't find three different events, in which case the test would fail regardless.
> 
> The awk script exits out as soon as it finds 3: unique events. It won't go forever, even on slower machines.
> 
> -- Steve

Got it, thank you for explaining this. I have no further questions.

-- Tengda

> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a4ea83a6e67f1415a1f17c1af5e9c814c882bb5
>>
>> Some test details:
>>
>> $ ./ftracetest -vvv subsystem-enable.tc
>> [...]
>> + echo sched:*
>> + yield
>> + ping 127.0.0.1 -c 1
>> PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
>> 64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.538 ms
>>
>> --- 127.0.0.1 ping statistics ---
>> 1 packets transmitted, 1 received, 0% packet loss, time 1ms
>> rtt min/avg/max/mdev = 0.538/0.538/0.538/0.000 ms
>> + check_unique
>> + cat trace_pipe
>> + grep -v ^#
>> + awk 
>>        BEGIN { cnt = 0; }
>>        {
>>            for (i = 0; i < cnt; i++) {
>>                if (event[i] == $5) {
>>                    break;
>>                }
>>            }
>>            if (i == cnt) {
>>                event[cnt++] = $5;
>>                if (cnt > 2) {
>>                    exit;
>>                }
>>            }
>>        }
>>        END {
>>            printf "%d", cnt;
>>        }
>> + count=3
>> + [ 3 -lt 3 ]
>> + do_reset
>> [...]
>>
>> Regards,
>> Tengda


