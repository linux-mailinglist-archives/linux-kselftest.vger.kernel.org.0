Return-Path: <linux-kselftest+bounces-38972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC4B268F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B6603D30
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63732143D;
	Thu, 14 Aug 2025 13:59:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F054321434;
	Thu, 14 Aug 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179999; cv=none; b=WEQ9tke/1WA0Evam3/gRWJswi+66hqCblW+B5SLA91qel1Inl7VRSkdXvlSm2alX0ZjNNLZ2m9qNJoH7JFh591j4DLE6Tu2vNKS+02wsI7bCzJjp1nhHFBYpiSvhCQP4+PXhiy21ZR7JS3gNdoLhWJJlproZWSlsQM+7zWJplxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179999; c=relaxed/simple;
	bh=4w7TJU8PYCfu5IBx1JR+pz0kyrdxTR7wAUd6BeP/mg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNaA/h6j75x1W9ZEHlsWMpzY96VVznI+EzV3I0tly6rre6PORB3vPdDkl2KP9NafLYRNO+XEzHcKErFjh3+ap/N3ExlLUfBp3XnKsGA2qaUqlx1/qY9BOSO5BoBUc2drC2irJ7+xTyLTDPizvSdvlddl1Fui7+wSCcgUHAS9h6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2n1Q3Cx9zKHMq9;
	Thu, 14 Aug 2025 21:59:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B4E4D1A084A;
	Thu, 14 Aug 2025 21:59:53 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDHgq7Y651o+Q5jDg--.18691S2;
	Thu, 14 Aug 2025 21:59:53 +0800 (CST)
Message-ID: <1f1d98bc-2243-44c9-94e3-3594d19ea313@huaweicloud.com>
Date: Thu, 14 Aug 2025 21:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] bpf: Add overwrite mode for bpf ring buffer
Content-Language: en-US
To: Jordan Rome <linux@jordanrome.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>,
 Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin Kelly <martin.kelly@crowdstrike.com>
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
 <20250804022101.2171981-2-xukuohai@huaweicloud.com>
 <CAADnVQKC8HdoEnjL-Y3tDrfghJnpVddDoSsyDYxacvHLAJqFQQ@mail.gmail.com>
 <53c46f61-2901-4225-a6e7-a82c2e6663b9@huaweicloud.com>
 <27a11141-8e0d-498a-bc27-318d108161c8@jordanrome.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <27a11141-8e0d-498a-bc27-318d108161c8@jordanrome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHgq7Y651o+Q5jDg--.18691S2
X-Coremail-Antispam: 1UD129KBjvAXoWfXr1rJw4kCFy3Jr4rtry8AFb_yoW8Jr4rGo
	WUuw17Zr15Jr1UGr4UJw1UJr15Jr1UJr1DJr1UXw13GF18JF1UJ34UJry5G3y5Jr1rGr1U
	J34UJr1UAFyUJr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/13/2025 9:22 PM, Jordan Rome wrote:
> 
> On 8/12/25 12:02 AM, Xu Kuohai wrote:
>> On 8/9/2025 5:39 AM, Alexei Starovoitov wrote:
>>> On Sun, Aug 3, 2025 at 7:27 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> When the bpf ring buffer is full, new events can not be recorded util
>>>> the consumer consumes some events to free space. This may cause critical
>>>> events to be discarded, such as in fault diagnostic, where recent events
>>>> are more critical than older ones.
>>>>
>>>> So add ovewrite mode for bpf ring buffer. In this mode, the new event
>>>> overwrites the oldest event when the buffer is full.
>>>>
>>>> The scheme is as follows:
>>>>
>>>> 1. producer_pos tracks the next position to write new data. When there
>>>>     is enough free space, producer simply moves producer_pos forward to
>>>>     make space for the new event.
>>>>
>>>> 2. To avoid waiting for consumer to free space when the buffer is full,
>>>>     a new variable overwrite_pos is introduced for producer. overwrite_pos
>>>>     tracks the next event to be overwritten (the oldest event committed) in
>>>>     the buffer. producer moves it forward to discard the oldest events when
>>>>     the buffer is full.
>>>>
>>>> 3. pending_pos tracks the oldest event under committing. producer ensures
>>>>     producers_pos never passes pending_pos when making space for new events.
>>>>     So multiple producers never write to the same position at the same time.
>>>>
>>>> 4. producer wakes up consumer every half a round ahead to give it a chance
>>>>     to retrieve data. However, for an overwrite-mode ring buffer, users
>>>>     typically only cares about the ring buffer snapshot before a fault occurs.
>>>>     In this case, the producer should commit data with BPF_RB_NO_WAKEUP flag
>>>>     to avoid unnecessary wakeups.
>>>
>>> If I understand it correctly the algorithm requires all events to be the same
>>> size otherwise first overwrite might trash the header,
>>> also the producers should use some kind of signaling to
>>> timestamp each event otherwise it all will look out of order to the consumer.
>>>
>>> At the end it looks inferior to the existing perf ring buffer with overwrite.
>>> Since in both cases the out of order needs to be dealt with
>>> in post processing the main advantage of ring buf vs perf buf is gone.
>>
>> No, the advantage is not gone.
>>
>> The ring buffer is still shared by multiple producers. When an event occurs,
>> the producer queues up to acquire the spin lock of the ring buffer to write
>> event to it. So events in the ring buffer are always ordered, no out of order
>> occurs.
>>
>> And events are not required to be the same size. When an overwrite happens,
>> the events bing trashed are discared, and the overwrite_pos is moved forward
>> to skip these events until it reaches the first event that is not trashed.
>>
>> To make it clear, here are some example diagrams.
>>
>> 1. Let's say we have a ring buffer with size 4096.
>>
>>    At first, {producer,overwrite,pending,consumer}_pos are all set to 0
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>> | |
>> | |
>> | |
>> +-----------------------------------------------------------------------+
>>    ^
>>    |
>>    |
>> producer_pos = 0
>> overwrite_pos = 0
>> pending_pos = 0
>> consumer_pos = 0
>>
>> 2. Reserve event A, size 512.
>>
>>    There is enough free space, so A is allocated at offset 0 and producer_pos
>>    is moved to 512, the end of A. Since A is not submitted, the BUSY bit is
>>    set.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    | |                                                              |
>>    |   A |                                                              |
>>    | [BUSY] |                                                              |
>> +-----------------------------------------------------------------------+
>>    ^        ^
>>    |        |
>>    |        |
>>    |    producer_pos = 512
>>    |
>> overwrite_pos = 0
>> pending_pos = 0
>> consumer_pos = 0
>>
>>
>> 3. Reserve event B, size 1024.
>>
>>    B is allocated at offset 512 with BUSY bit set, and producer_pos is moved
>>    to the end of B.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |        | |                                            |
>>    |   A    |        B |                                            |
>>    | [BUSY] |      [BUSY] |                                            |
>> +-----------------------------------------------------------------------+
>>    ^                          ^
>>    |                          |
>>    |                          |
>>    |                   producer_pos = 1536
>>    |
>> overwrite_pos = 0
>> pending_pos = 0
>> consumer_pos = 0
>>
>> 4. Reserve event C, size 2048.
>>
>>    C is allocated at offset 1536 and producer_pos becomes 3584.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |        |                 | |        |
>>    |    A   |        B        |                 C |        |
>>    | [BUSY] |      [BUSY]     |               [BUSY] |        |
>> +-----------------------------------------------------------------------+
>>    ^ ^
>>    | |
>>    | |
>>    | producer_pos = 3584
>>    |
>> overwrite_pos = 0
>> pending_pos = 0
>> consumer_pos = 0
>>
>> 5. Submit event A.
>>
>>    The BUSY bit of A is cleared. B becomes the oldest event under writing, so
>>    pending_pos is moved to 512, the start of B.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |        |                 | |        |
>>    |    A   |        B        |                 C |        |
>>    |        |      [BUSY]     |               [BUSY] |        |
>> +-----------------------------------------------------------------------+
>>    ^        ^ ^
>>    |        | |
>>    |        | |
>>    |   pending_pos = 512 producer_pos = 3584
>>    |
>> overwrite_pos = 0
>> consumer_pos = 0
>>
>> 6. Submit event B.
>>
>>    The BUSY bit of B is cleared, and pending_pos is moved to the start of C,
>>    which is the oldest event under writing now.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |        |                 | |        |
>>    |    A   |        B        |                 C |        |
>>    |        |                 |               [BUSY] |        |
>> +-----------------------------------------------------------------------+
>>    ^                          ^ ^
>>    |                          | |
>>    |                          | |
>>    |                     pending_pos = 1536 producer_pos = 3584
>>    |
>> overwrite_pos = 0
>> consumer_pos = 0
>>
>> 7. Reserve event D, size 1536 (3 * 512).
>>
>>    There are 2048 bytes not under writing between producer_pos and pending_pos,
>>    so D is allocated at offset 3584, and producer_pos is moved from 3584 to
>>    5120.
>>
>>    Since event D will overwrite all bytes of event A and the begining 512 bytes
>>    of event B, overwrite_pos is moved to the start of event C, the oldest event
>>    that is not overwritten.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |                 |        | |        |
>>    |      D End      |        |                 C | D Begin|
>>    |      [BUSY]     |        |               [BUSY] | [BUSY] |
>> +-----------------------------------------------------------------------+
>>    ^                 ^        ^
>>    |                 |        |
>>    |                 |   pending_pos = 1536
>>    |                 |   overwrite_pos = 1536
>>    |                 |
>>    |             producer_pos=5120
>>    |
>> consumer_pos = 0
>>
>> 8. Reserve event E, size 1024.
>>
>>    Though there are 512 bytes not under writing between producer_pos and
>>    pending_pos, E can not be reserved, as it would overwrite the first 512
>>    bytes of event C, which is still under writing.
>>
>> 9. Submit event C and D.
>>
>>    pending_pos is moved to the end of D.
>>
>>    0       512      1024    1536     2048     2560     3072 3584 4096
>> +-----------------------------------------------------------------------+
>>    |                 |        | |        |
>>    |      D End      |        |                 C | D Begin|
>>    |                 |        | |        |
>> +-----------------------------------------------------------------------+
>>    ^                 ^        ^
>>    |                 |        |
>>    |                 |   overwrite_pos = 1536
>>    |                 |
>>    |             producer_pos=5120
>>    |             pending_pos=5120
>>    |
>> consumer_pos = 0
> 
> These diagrams are very helpful in terms of understanding the flow.
> In part 7 when A is overwritten by D, why doesn't the consumer position move forward to
> point to the beginning of C? If the ring buffer producer guarantees ordering of reserved
> slots then C, in this case, is now the oldest reserved. This speaks to your second patch
> where you say that the consumer resolves conflicts by discarding data that has been
> overwritten but I feel like the simpler thing to do is just move the consumer position.
> 

But the consumer may be ahead of overwrite_pos. In this case, moving
consumer_pos back to the oldest event is not correct, as the event has
already been consumed.


