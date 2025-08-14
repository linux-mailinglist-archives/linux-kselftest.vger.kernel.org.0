Return-Path: <linux-kselftest+bounces-38973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9BB2691C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11952AA3C56
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1721B184;
	Thu, 14 Aug 2025 14:10:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C119C569;
	Thu, 14 Aug 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180615; cv=none; b=Yeh6jpSloLwUpcb7jpnVXHiqIKpYIl7zBhjq4ab0pejLmLAp3O5UXdk0M0clnW12hF76K6SVoHcBh0lDsA8PA4RUXM2NwNcSPTt/NwcMkz3XEB3iLIbbbF3LIg5XQKJvl8f/Qj7Lu5Fc2y+PIGP14FMWW/DMZO39Z+OXQigGDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180615; c=relaxed/simple;
	bh=sOSWtwaggT08IQ917pbTV5IdSxjEcB7zrNQ5o7nafW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqwRNa2o0fzy8QBJWmOoj6W5cWvbDCTzznUFe31SBvsj7zxfVNbXkwwLIBcfogCtWFSVZv8M5F6lnV32VP2gHDSSpr5eQtTk4bKW4Kf3S+OGJVR5O1kw3d7hEQhuaCkVZkcKtBK26HtxaeGEjjkZ+eosA/fyRPMN50Q67GAylPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2nFG6ZfTzYQv8m;
	Thu, 14 Aug 2025 22:10:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 852E61A08DC;
	Thu, 14 Aug 2025 22:10:09 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCXExRA7p1oVmqpDg--.50608S2;
	Thu, 14 Aug 2025 22:10:09 +0800 (CST)
Message-ID: <9b8bef34-128c-4fb0-bbe1-0b9d697aaca9@huaweicloud.com>
Date: Thu, 14 Aug 2025 22:10:08 +0800
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
To: Zvi Effron <zeffron@riotgames.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Paul Chaignon <paul.chaignon@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
 <20250804022101.2171981-3-xukuohai@huaweicloud.com>
 <CAC1LvL2AiNpN86+fz+30ap0Pm5W9C1MtV5sPvupU2uFGoJ94ug@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAC1LvL2AiNpN86+fz+30ap0Pm5W9C1MtV5sPvupU2uFGoJ94ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExRA7p1oVmqpDg--.50608S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4rtF17KFyktFyUArWkJFb_yoWrtr4kpF
	WYka15CFyDZF17Cr1S9FWSvFyrKwsavr1xCFyxt3W8A34qkF1fWFyjkrWakr4xJrykGr1F
	vrWDXas7Cr1UGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/14/2025 2:21 AM, Zvi Effron wrote:
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
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>> tools/lib/bpf/ringbuf.c | 103 +++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>> index 9702b70da444..9c072af675ff 100644
>> --- a/tools/lib/bpf/ringbuf.c
>> +++ b/tools/lib/bpf/ringbuf.c
>> @@ -27,10 +27,13 @@ struct ring {
>> ring_buffer_sample_fn sample_cb;
>> void *ctx;
>> void *data;
>> + void *read_buffer;
>> unsigned long *consumer_pos;
>> unsigned long *producer_pos;
>> + unsigned long *overwrite_pos;
>> unsigned long mask;
>> int map_fd;
>> + bool overwrite_mode;
>> };
>>
>> struct ring_buffer {
>> @@ -69,6 +72,9 @@ static void ringbuf_free_ring(struct ring_buffer *rb, struct ring *r)
>> r->producer_pos = NULL;
>> }
>>
>> + if (r->read_buffer)
>> + free(r->read_buffer);
>> +
>> free(r);
>> }
>>
>> @@ -119,6 +125,14 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>> r->sample_cb = sample_cb;
>> r->ctx = ctx;
>> r->mask = info.max_entries - 1;
>> + r->overwrite_mode = info.map_flags & BPF_F_OVERWRITE;
>> + if (unlikely(r->overwrite_mode)) {
>> + r->read_buffer = malloc(info.max_entries);
>> + if (!r->read_buffer) {
>> + err = -ENOMEM;
>> + goto err_out;
>> + }
>> + }
>>
>> /* Map writable consumer page */
>> tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
>> @@ -148,6 +162,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>> goto err_out;
>> }
>> r->producer_pos = tmp;
>> + r->overwrite_pos = r->producer_pos + 1; /* overwrite_pos is next to producer_pos */
>> r->data = tmp + rb->page_size;
>>
>> e = &rb->events[rb->ring_cnt];
>> @@ -232,7 +247,7 @@ static inline int roundup_len(__u32 len)
>> return (len + 7) / 8 * 8;
>> }
>>
>> -static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>> +static int64_t ringbuf_process_normal_ring(struct ring *r, size_t n)
>> {
>> int *len_ptr, len, err;
>> /* 64-bit to avoid overflow in case of extreme application behavior */
>> @@ -278,6 +293,92 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>> return cnt;
>> }
>>
>> +static int64_t ringbuf_process_overwrite_ring(struct ring *r, size_t n)
>> +{
>> +
>> + int err;
>> + uint32_t *len_ptr, len;
>> + /* 64-bit to avoid overflow in case of extreme application behavior */
>> + int64_t cnt = 0;
>> + size_t size, offset;
>> + unsigned long cons_pos, prod_pos, over_pos, tmp_pos;
>> + bool got_new_data;
>> + void *sample;
>> + bool copied;
>> +
>> + size = r->mask + 1;
>> +
>> + cons_pos = smp_load_acquire(r->consumer_pos);
>> + do {
>> + got_new_data = false;
>> +
>> + /* grab a copy of data */
>> + prod_pos = smp_load_acquire(r->producer_pos);
>> + do {
>> + over_pos = READ_ONCE(*r->overwrite_pos);
>> + /* prod_pos may be outdated now */
>> + if (over_pos < prod_pos) {
>> + tmp_pos = max(cons_pos, over_pos);
>> + /* smp_load_acquire(r->producer_pos) before
>> + * READ_ONCE(*r->overwrite_pos) ensures that
>> + * over_pos + r->mask < prod_pos never occurs,
>> + * so size is never larger than r->mask
>> + */
>> + size = prod_pos - tmp_pos;
>> + if (!size)
>> + goto done;
>> + memcpy(r->read_buffer,
>> + r->data + (tmp_pos & r->mask), size);
>> + copied = true;
>> + } else {
>> + copied = false;
>> + }
>> + prod_pos = smp_load_acquire(r->producer_pos);
>> + /* retry if data is overwritten by producer */
>> + } while (!copied || prod_pos - tmp_pos > r->mask);
> 
> This seems to allow for a situation where a call to process the ring can
> infinite loop if the producers are producing and overwriting fast enough. That
> seems suboptimal to me?
> 
> Should there be a timeout or maximum number of attempts or something that
> returns -EBUSY or another error to the user?
> 

Yeah, infinite loop is a bit unsettling, will return -EBUSY after some
tries.


