Return-Path: <linux-kselftest+bounces-43130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61374BD9BEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1570B3A0554
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E530C62B;
	Tue, 14 Oct 2025 13:35:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB852C11E8;
	Tue, 14 Oct 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448925; cv=none; b=ksUMDqHPpb/KofQVGKTaXDA0iwgJ/LrLdDRv2ijSLMg1WJLO+egb7094SjS4d+NGMUSQ0t7qmWbULvNUeBwPIFUAm7e/vx8RgIEE2D8nnOjp5c9AkGaL4j734KcMjBm5XnOWk6mhUPtq7fvqnUd+aGJepuJ1yfGP0MSQQZOcRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448925; c=relaxed/simple;
	bh=mVK39WP3LkJmeaNBGmPhaE2tMTk6V/3l97N7PYaBwy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNVwjX1oxjDH5jky0+8dGDNvrmdTZ1ieGBb+jek+GeyTR3QfIlRZ7RXAfMlr5AVUKlMc0KNLLV0/QbSmrWugmjhAoEQcSNKU0XS1HJHetOwDiB8zAeclDNtM0Kk6y1a2Wxe9Xyh2cNBKv+SLkJ+ZJ9PCI26yXiRzUMx7sNF3x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmFZ65lTlzYQtsl;
	Tue, 14 Oct 2025 21:34:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD40D1A13AC;
	Tue, 14 Oct 2025 21:35:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHSj+WUe5oZ09jAQ--.31322S2;
	Tue, 14 Oct 2025 21:35:19 +0800 (CST)
Message-ID: <445861b0-b79b-425f-b230-707c17093e70@huaweicloud.com>
Date: Tue, 14 Oct 2025 21:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring
 buffer
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
 <20250905150641.2078838-2-xukuohai@huaweicloud.com>
 <CAEf4BzaSEjQzF47BZeh0de9pFbKpaB8JqCs629hV9xZDhMyTgw@mail.gmail.com>
 <63272c95-9669-41c1-8e77-575ec37d36c0@huaweicloud.com>
 <CAEf4BzbYtaPf0jjoiv16iKWRKkv9ZTH_hBiZMUF+PkjVGOC53A@mail.gmail.com>
 <c1829ab5-2c33-4445-911e-9e72bbbfe079@huaweicloud.com>
 <CAEf4BzYAUDFH7z9x-+vkzkHD0pSG6M264yQoMCGkJxg3mFvcYA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzYAUDFH7z9x-+vkzkHD0pSG6M264yQoMCGkJxg3mFvcYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHSj+WUe5oZ09jAQ--.31322S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWrGw4rCFWktryDArWrKrg_yoWfKw1kpF
	WjkayfCrs7Jw13XF1vv3W8ArW2vr1IvF1UXryftF17Zwn5K3ZIqryUA3yYk34UGryDAw1I
	v348Ar9Ikrn8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/14/2025 7:22 AM, Andrii Nakryiko wrote:
> On Fri, Oct 10, 2025 at 12:07 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 10/7/2025 6:10 AM, Andrii Nakryiko wrote:
>>
>> [...]
>>
>>>>>> +
>>>>>> +       over_pos = READ_ONCE(rb->overwrite_pos);
>>>>>> +       return min(prod_pos - max(cons_pos, over_pos), rb->mask + 1);
>>>>>
>>>>> I'm trying to understand why you need to min with `rb->mask + 1`, can
>>>>> you please elaborate?
>>>>
>>>>
>>>> We need the min because rb->producer_pos and rb->overwrite_pos are read
>>>> at different times. During this gap, a fast producer may wrap once or
>>>> more, making over_pos larger than prod_pos.
>>>>
>>>
>>> what if you read overwrite_pos before reading producer_pos? Then it
>>> can't be larger than producer_pos and available data would be
>>> producer_pos - max(consumer_pos, overwrite_pos)? would that work?
>>>
>>
>> No, it won’t work. Between reading overwrite_pos and producer_pos, producer
>> on a different CPU may have already moved producer_pos forward by more than
>> one ring buffer size, causing prod_pos - max(cons_pos, over_pos) to exceed
>> the ring buffer size.
> 
> True, but that was the case with this function before as well.
> ringbuf_avail_data_sz() is giving an estimate, we just need to make
> sure to not return a negative value. We didn't artificially cap the
> return to ring buf size before, why starting now? All of this
> calculation is done outside of the lock anyways, so it can never be
> relied upon for exactness.
>

Makes sense, will switch to producer_pos - max(consumer_pos, overwrite_pos).

>>
>>>
>>>>> And also, at least for consistency, use smp_load_acquire() for overwrite_pos?
>>>>>
>>>>
>>>> Using READ_ONCE here is to stay symmetric with __bpf_ringbuf_reserve(),
>>>> where overwrite_pos is WRITE_ONCE first, followed by smp_store_release(producer_pos).
>>>> So here we do smp_load_acquire(producer_pos) first, then READ_ONCE(overwrite_pos)
>>>> to ensure a consistent view of the ring buffer.
>>>>
>>>> For consistency when reading consumer_pos and producer_pos, I’m fine with
>>>> switching READ_ONCE to smp_load_acquire for overwrite_pos.
>>>>
>>>
>>> I'm not sure it matters much, but this function is called outside of
>>> rb->spinlock, while __bpf_ringbuf_reserve() does hold a lock while
>>> doing that WRITE_ONCE(). So it might not make any difference, but I
>>> have mild preference for smp_load_acquire() here.
>>>
>>
>> OK, I'll switch to smp_load_acquire.
>>
>>>>>>     }
>>>>>>
>>>>>>     static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
>>>>>> @@ -402,11 +419,43 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
>>>>>>            return (void*)((addr & PAGE_MASK) - off);
>>>>>>     }
>>>>>>
>>>>>> +
>>>
>>> [...]
>>>
>>>>>> +       /* In overwrite mode, move overwrite_pos to the next record to be
>>>>>> +        * overwritten if the ring buffer is full
>>>>>> +        */
>>>>>
>>>>> hm... here I think the important point is that we search for the next
>>>>> record boundary until which we need to overwrite data such that it
>>>>> fits newly reserved record. "next record to be overwritten" isn't that
>>>>> important (we might never need to overwrite it). Important are those
>>>>> aspects of a) staying on record boundary and b) consuming enough
>>>>> records to reserve the new one.
>>>>>
>>>>> Can you please update the comment to mention the above points?
>>>>>
>>>>
>>>> Sure, I'll update the comment to:
>>>>
>>>> In overwrite mode, advance overwrite_pos when the ring buffer is full.
>>>> The key points are to stay on record boundaries and consume enough
>>>> records to fit the new one.
>>>>
>>>
>>> ok
>>>
>>> [...]
>>>
>>>>
>>>>>> +                          unsigned long rec_pos,
>>>>>> +                          unsigned long cons_pos,
>>>>>> +                          u32 len, u64 flags)
>>>>>> +{
>>>>>> +       unsigned long rec_end;
>>>>>> +
>>>>>> +       if (flags & BPF_RB_FORCE_WAKEUP)
>>>>>> +               return true;
>>>>>> +
>>>>>> +       if (flags & BPF_RB_NO_WAKEUP)
>>>>>> +               return false;
>>>>>> +
>>>>>> +       /* for non-overwrite mode, if consumer caught up and is waiting for
>>>>>> +        * our record, notify about new data availability
>>>>>> +        */
>>>>>> +       if (likely(!rb->overwrite_mode))
>>>>>> +               return cons_pos == rec_pos;
>>>>>> +
>>>>>> +       /* for overwrite mode, to give the consumer a chance to catch up
>>>>>> +        * before being overwritten, wake up consumer every half a round
>>>>>> +        * ahead.
>>>>>> +        */
>>>>>> +       rec_end = rec_pos + ringbuf_round_up_hdr_len(len);
>>>>>> +
>>>>>> +       cons_pos &= (rb->mask >> 1);
>>>>>> +       rec_pos &= (rb->mask >> 1);
>>>>>> +       rec_end &= (rb->mask >> 1);
>>>>>> +
>>>>>> +       if (cons_pos == rec_pos)
>>>>>> +               return true;
>>>>>> +
>>>>>> +       if (rec_pos < cons_pos && cons_pos < rec_end)
>>>>>> +               return true;
>>>>>> +
>>>>>> +       if (rec_end < rec_pos && (cons_pos > rec_pos || cons_pos < rec_end))
>>>>>> +               return true;
>>>>>> +
>>>>>
>>>>> hm... ok, let's discuss this. Why do we need to do some half-round
>>>>> heuristic for overwrite mode? If a consumer is falling behind it
>>>>> should be actively trying to catch up and they don't need notification
>>>>> (that's the non-overwrite mode logic already).
>>>>>
>>>>> So there is more to this than a brief comment you left, can you please
>>>>> elaborate?
>>>>>
>>>>
>>>> The half-round wakeup was originally intended to work with libbpf in the
>>>> v1 version. In that version, libbpf used a retry loop to safely copy data
>>>> from the ring buffer that hadn’t been overwritten. By waking the consumer
>>>> once every half round, there was always a period where the consumer and
>>>> producer did not overlap, which helped reduce the number of retries.
>>>
>>> I can't say I completely grok the logic here, but do you think we
>>> should still keep this half-round wakeup? It looks like an arbitrary
>>> heuristic, so I'd rather not have it.
>>>
>>
>> Sure, since the related libbpf code is no longer present, I’ll remove this
>> logic in the next version.
>>
>>>>
>>>>> pw-bot: cr
>>>>>
>>>>>> +       return false;
>>>>>> +}
>>>>>> +
>>>>>> +static __always_inline
>>>>>
>>>>> we didn't have always_inline before, any strong reason to add it now?
>>>>>
>>>>
>>>> I just wanted to avoid introducing any performance regression. Before this
>>>> patch, bpf_ringbuf_commit() was automatically inlined by the compiler, but
>>>> after the patch it wasn’t, so I added always_inline explicitly to keep it
>>>> inlined.
>>>
>>> how big of a difference was it in benchmarks? It's generally frowned
>>> upon using __always_inline without a good reason.
>>>
>>
>> The difference is not noticeable on my arm64 test machine, but it is on my
>> amd machine.
>>
>> Below is the benchmark data on AMD EPYC 9654, with and without always_inline
>> attribute.
>>
>> - With always_inline
>>
>> Ringbuf, multi-producer contention
>> ==================================
>> rb-libbpf nr_prod 1  13.070 ± 0.158M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 2  15.440 ± 0.017M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 3  7.860 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 4  6.444 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 8  3.788 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 12 2.802 ± 0.007M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 16 2.560 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 20 2.227 ± 0.006M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 24 2.141 ± 0.007M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 28 1.960 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 32 1.913 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 36 1.854 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 40 1.818 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 44 1.779 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 48 1.758 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 52 1.812 ± 0.003M/s (drops 0.000 ± 0.000M/s)
>>
>> - Without always_inline
>>
>> Ringbuf, multi-producer contention
>> ==================================
>> rb-libbpf nr_prod 1  10.550 ± 0.032M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 2  14.661 ± 0.024M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 3  7.616 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 4  6.476 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 8  3.806 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 12 2.814 ± 0.001M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 16 2.608 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 20 2.337 ± 0.005M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 24 2.270 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 28 1.977 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 32 1.921 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 36 1.862 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 40 1.827 ± 0.004M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 44 1.912 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 48 1.860 ± 0.002M/s (drops 0.000 ± 0.000M/s)
>> rb-libbpf nr_prod 52 1.824 ± 0.001M/s (drops 0.000 ± 0.000M/s)
>>
>> When nr_prod=1, the performance regression is significant, dropping from
>> 13.070 ± 0.158 M/s with always_inline to 10.550 ± 0.032 M/s without it.
>>
>> However, since the half-round wakeup logic will be removed in the next
>> version, the changes to bpf_ringbuf_commit, including always_inline, will
>> also be removed.
> 
> Ok, thanks for the data! Please send an updated version of the code,
> and let's have another round of review, thanks!
>

Sure, I’ll send the next version later this week.

>>
>>> [...]
>>
> 


