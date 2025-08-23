Return-Path: <linux-kselftest+bounces-39788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3EB3293B
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C7564622
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF025B2FA;
	Sat, 23 Aug 2025 14:38:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4971448D5;
	Sat, 23 Aug 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959917; cv=none; b=WvBKFwi4rSKED7Yx+jOk5Jjhl70frA+K9ZmwrvpgJN7JXmsDF36/3zD3BNfvBA6sIfqlxC9mFvdT/2Go1GI29qrxQcbdQKJMx69swV3C1IVs8rhhCVKp6trNhd2bIAY26Rv7NmwK2wI8pfYNOsaoze7HKVv02MfIdCwZgFbIcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959917; c=relaxed/simple;
	bh=Nh6YA7zHVUidyfs1irsqbpNd4HNN14VNgJLyf2nJm94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWik5lzqcZYVIsRJyozDDScIJucinBO6NBQWBb7YeBLKEmBPj7ao0Ib63UswTiWNd4x/vzCrBfrnMiwlro0lRe7YpzdGu6Suel2lRcOuvQA9RoewcKZvPm3Ue1nuF1UMOSBiw3BrMPiYDDQCZkulOQYExQFSxUS9ilT9rnZSl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c8KRr54xmzYQvZp;
	Sat, 23 Aug 2025 22:38:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3F99D1A0FCF;
	Sat, 23 Aug 2025 22:38:31 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAXsmll0qlo2m8jAA--.52530S2;
	Sat, 23 Aug 2025 22:38:31 +0800 (CST)
Message-ID: <1af26519-6113-43fa-b220-8beb2059b4d3@huaweicloud.com>
Date: Sat, 23 Aug 2025 22:38:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer
 process
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
 <20250804022101.2171981-3-xukuohai@huaweicloud.com>
 <CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXsmll0qlo2m8jAA--.52530S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15tw15ury5Ary5XFykAFb_yoW5Ww48pF
	y5Kw45KrnrZr12kwn3X3WIgFyrCan7AryUKr4IyF18ArnIqF13WFWj9F4Y9F13ZrZ3Kw1j
	yrWDuas2kryUCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/23/2025 5:23 AM, Andrii Nakryiko wrote:
> On Sun, Aug 3, 2025 at 7:27 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> In overwrite mode, the producer does not wait for the consumer, so the
>> consumer is responsible for handling conflicts. An optimistic method
>> is used to resolve the conflicts: the consumer first reads consumer_pos,
>> producer_pos and overwrite_pos, then calculates a read window and copies
>> data in the window from the ring buffer. After copying, it checks the
>> positions to decide if the data in the copy window have been overwritten
>> by be the producer. If so, it discards the copy and tries again. Once
>> success, the consumer processes the events in the copy.
>>
> 
> I don't mind adding BPF_F_OVERWRITE mode to BPF ringbuf (it seems like
> this will work fine) itself, but I don't think retrofitting it to this
> callback-based libbpf-side API is a good fit.
> 
> For one, I don't like that extra memory copy and potentially a huge
> allocation that you do. I think for some use cases user logic might be
> totally fine with using ringbuf memory directly, even if it can be
> overwritten at any point. So it would be unfair to penalize
> sophisticated users for such cases. Even if not, I'd say allocating
> just enough to hold the record would be a better approach.
> 
> Another downside is that the user doesn't really have much visibility
> right now into whether any samples were overwritten.
> 
> I've been mulling over the idea of adding an iterator-like API for BPF
> ringbuf on the libbpf side for a while now. I'm still debating some
> API nuances with Eduard, but I think we'll end up adding something
> pretty soon. Iterator-based API seems like a much better fit for
> overwritable mode here.
> 
> But all that is not really overwrite-specific and is broader, so I
> think we can proceed with finalizing kernel-side details of overwrite
> and not block on libbpf side of things for now, though.
>

Sounds great! Looking forward to the new iterator-based API. Clearly, no
memory allocation or a samll allocation is better than a huge allocation.
I'll focus on the kernel side before the new API is introduced.

>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   tools/lib/bpf/ringbuf.c | 103 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>> index 9702b70da444..9c072af675ff 100644
>> --- a/tools/lib/bpf/ringbuf.c
>> +++ b/tools/lib/bpf/ringbuf.c
>> @@ -27,10 +27,13 @@ struct ring {
>>          ring_buffer_sample_fn sample_cb;
>>          void *ctx;
>>          void *data;
>> +       void *read_buffer;
>>          unsigned long *consumer_pos;
>>          unsigned long *producer_pos;
>> +       unsigned long *overwrite_pos;
>>          unsigned long mask;
>>          int map_fd;
>> +       bool overwrite_mode;
>>   };
> 
> [...]


