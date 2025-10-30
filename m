Return-Path: <linux-kselftest+bounces-44396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A602C1FEC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D0654EC413
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4912FDC29;
	Thu, 30 Oct 2025 12:03:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D518787A;
	Thu, 30 Oct 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825795; cv=none; b=KeASUMmVSfGer8iSTYo+YeSqOl2OBMnJ2Fm+uRJjIBE7e37mnYrsDQDidC4fQ8v2X93+qS/HlrYcQczFDV9QlOyutUBdWyagUfJVSa2tRrUtqdsHPk3yAYDtX4DdJSnKNFuzedPuVAXuQSHTJBes/5xRDNlj1i6SQocr/RmKDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825795; c=relaxed/simple;
	bh=9r+0TIYxx6dVKl+SDmfQ4DYdifsKQsP5dqbkZYrj2ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym351hNWW1eFJ7BOmH73ZfHd+2tSjp6E7iVUy+IQ1QLYqnmXQYJkWSIo0BlCzFinMGr/3SzAz2HepR/uJRq9pdZRqDXRxWKX6Ku75wDus+UW6KCHoYYmN5KcoGzzD87MRXXwpErBKXriqfCMeG3FcyAxFNFJTbbNud1sgPfChCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cy2n10D7xzYQtHw;
	Thu, 30 Oct 2025 20:03:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF8711A0B5B;
	Thu, 30 Oct 2025 20:03:07 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBH6UH6UwNpQHx+CA--.42489S2;
	Thu, 30 Oct 2025 20:03:07 +0800 (CST)
Message-ID: <85762e7f-49d3-44ea-b23f-4f258959470b@huaweicloud.com>
Date: Thu, 30 Oct 2025 20:03:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add overwrite mode for BPF ring
 buffer
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
 <20251018035738.4039621-2-xukuohai@huaweicloud.com>
 <CAEf4BzZqHo0kOa1Zc-syy9GZHUhEHEK0_0zLxFFpMhSZUc2_Qg@mail.gmail.com>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzZqHo0kOa1Zc-syy9GZHUhEHEK0_0zLxFFpMhSZUc2_Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH6UH6UwNpQHx+CA--.42489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw17KFWfJr4UXr1rZFW3GFg_yoWrWF13pF
	4YkF1jkrsrZr1UWr109a4xAFyjvwsFv3yfCFW3Ja4I9a4qgF13JF9ruF1F9r15ArykXr1I
	yrWj93sxu3y0yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 10/28/2025 10:47 AM, Andrii Nakryiko wrote:
> On Fri, Oct 17, 2025 at 9:04 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:


[...]

> 
>> @@ -72,6 +73,8 @@ struct bpf_ringbuf {
>>           */
>>          unsigned long consumer_pos __aligned(PAGE_SIZE);
>>          unsigned long producer_pos __aligned(PAGE_SIZE);
>> +       /* points to the record right after the last overwritten one */
>> +       unsigned long overwrite_pos;
> 
> I moved this after pending_pos, as all these fields are actually
> exposed to the user space, so didn't want to unnecessarily shift
> pending_pos.

OK, that makes sense

> 
>>          unsigned long pending_pos;
>>          char data[] __aligned(PAGE_SIZE);
>>   };
>> @@ -166,7 +169,7 @@ static void bpf_ringbuf_notify(struct irq_work *work)
>>    * considering that the maximum value of data_sz is (4GB - 1), there
>>    * will be no overflow, so just note the size limit in the comments.
>>    */
>> -static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
>> +static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node, bool overwrite_mode)
>>   {
>>          struct bpf_ringbuf *rb;
>>
>> @@ -183,17 +186,25 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
>>          rb->consumer_pos = 0;
>>          rb->producer_pos = 0;
>>          rb->pending_pos = 0;
>> +       rb->overwrite_mode = overwrite_mode;
>>
>>          return rb;
>>   }
>>
>>   static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
>>   {
>> +       bool overwrite_mode = false;
>>          struct bpf_ringbuf_map *rb_map;
>>
>>          if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
>>                  return ERR_PTR(-EINVAL);
>>
>> +       if (attr->map_flags & BPF_F_RB_OVERWRITE) {
>> +               if (attr->map_type == BPF_MAP_TYPE_USER_RINGBUF)
> 
> this seemed error prone if we ever add another ringbuf type (unlikely,
> but still), so I inverted this all to allow BPF_F_RB_OVERWRITE only
> for BPF_MAP_TYPE_RINGBUF. We should try to be as strict as possible by
> default.
>

Got it, thanks.

>> +                       return ERR_PTR(-EINVAL);
>> +               overwrite_mode = true;
>> +       }
>> +
>>          if (attr->key_size || attr->value_size ||
>>              !is_power_of_2(attr->max_entries) ||
>>              !PAGE_ALIGNED(attr->max_entries))
>> @@ -205,7 +216,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
>>
>>          bpf_map_init_from_attr(&rb_map->map, attr);
>>
>> -       rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
>> +       rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node, overwrite_mode);
>>          if (!rb_map->rb) {
>>                  bpf_map_area_free(rb_map);
>>                  return ERR_PTR(-ENOMEM);
>> @@ -293,13 +304,25 @@ static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma
>>          return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGBUF_PGOFF);
>>   }
>>
>> +/* Return an estimate of the available data in the ring buffer.
> 
> Fixed up comment style
> 
> [...]
> 
>>   static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
>> @@ -402,11 +425,41 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
>>          return (void*)((addr & PAGE_MASK) - off);
>>   }
>>
>> +static bool bpf_ringbuf_has_space(const struct bpf_ringbuf *rb,
>> +                                 unsigned long new_prod_pos,
>> +                                 unsigned long cons_pos,
>> +                                 unsigned long pend_pos)
>> +{
>> +       /* no space if oldest not yet committed record until the newest
>> +        * record span more than (ringbuf_size - 1).
>> +        */
> 
> same, keep in mind that we now use kernel-wide comment style with /*
> on separate line. Fixed up all other places as well.
>

Thanks for fixing everything! I think I should update my editor config, it’s
still stuck at an 80-character line width.

>> +       if (new_prod_pos - pend_pos > rb->mask)
>> +               return false;
>> +
>> +       /* ok, we have space in overwrite mode */
>> +       if (unlikely(rb->overwrite_mode))
>> +               return true;
>> +
>> +       /* no space if producer position advances more than (ringbuf_size - 1)
>> +        * ahead of consumer position when not in overwrite mode.
>> +        */
>> +       if (new_prod_pos - cons_pos > rb->mask)
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
> 
> [...]


