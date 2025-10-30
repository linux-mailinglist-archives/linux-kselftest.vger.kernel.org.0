Return-Path: <linux-kselftest+bounces-44397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B9C1FECC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 13:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A34EBB56
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15D335BAF;
	Thu, 30 Oct 2025 12:03:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461831D377;
	Thu, 30 Oct 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825803; cv=none; b=pSAEbGUG7FTZbLWPSWRVprkXBL1C3etSLWZ6ERK/bEJ5I8ERqd+utLW/61aWvLRkVxm727l0bKRozkvKpaR5R08k0XugDlRmqAE6buzxM0+Fpuo6YjP1+Ww2q6HVnywtXhm5smNet4Jp/Lo8HJSNRqEQX16IlmI5uThSvo2H23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825803; c=relaxed/simple;
	bh=YTZHOtTHA/gNt2NqNII9StP3tPvo/XXImIK2lbKGRvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARqKmLHc8DBtrWe7y/PO15567F72521yodo28ybBh2C8okCwlDNT9PZkTg1An0n7QZcYLHb+uRuTGKk/LLxFKLayqUIBIPoWCfOV/Faf6aT4PPPlL0pLsLMzufh4SKJ9VxKXO3SobKdeLvFHtsE7m0LVB2wsbddoyr8n719wpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cy2m52xpBzKHMlw;
	Thu, 30 Oct 2025 20:02:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EB0A31A0847;
	Thu, 30 Oct 2025 20:03:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBH6UH6UwNpQHx+CA--.42489S3;
	Thu, 30 Oct 2025 20:03:12 +0800 (CST)
Message-ID: <5dab3b98-9134-4ee9-8cd1-2498c3eab49e@huaweicloud.com>
Date: Thu, 30 Oct 2025 20:03:12 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add overwrite mode test
 for BPF ring buffer
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
 <20251018035738.4039621-3-xukuohai@huaweicloud.com>
 <CAEf4BzZQfSBTqPwHE7fMTO1CbuoCYkFthUkCGvq3qT5CnT3-Eg@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzZQfSBTqPwHE7fMTO1CbuoCYkFthUkCGvq3qT5CnT3-Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH6UH6UwNpQHx+CA--.42489S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWry5JF1fWFW5tF1fCFWfZrb_yoW5Aw15pa
	yrKFyYkrn2yFy2gr1fuFy2qFW09r1kArWFkr4xtw1rZr1UCFWxJryI9F4UKan3JrWFvr1F
	y34jgF93u3WUKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw
	0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2uyIUUUU
	U
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/28/2025 10:47 AM, Andrii Nakryiko wrote:
> On Fri, Oct 17, 2025 at 9:04 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add overwrite mode test for BPF ring buffer. The test creates a BPF ring
>> buffer in overwrite mode, then repeatedly reserves and commits records
>> to check if the ring buffer works as expected both before and after
>> overwriting occurs.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile          |  3 +-
>>   .../selftests/bpf/prog_tests/ringbuf.c        | 64 ++++++++++++
>>   .../bpf/progs/test_ringbuf_overwrite.c        | 98 +++++++++++++++++++
>>   3 files changed, 164 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index f00587d4ede6..43d133bf514d 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -498,7 +498,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h               \
>>
>>   LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c  \
>>          core_kern.c core_kern_overflow.c test_ringbuf.c                 \
>> -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
>> +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
>> +       test_ringbuf_overwrite.c
>>
>>   LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> index d1e4cb28a72c..5264af1dc768 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> @@ -17,6 +17,7 @@
>>   #include "test_ringbuf_n.lskel.h"
>>   #include "test_ringbuf_map_key.lskel.h"
>>   #include "test_ringbuf_write.lskel.h"
>> +#include "test_ringbuf_overwrite.lskel.h"
>>
>>   #define EDONE 7777
>>
>> @@ -497,6 +498,67 @@ static void ringbuf_map_key_subtest(void)
>>          test_ringbuf_map_key_lskel__destroy(skel_map_key);
>>   }
>>
>> +static void ringbuf_overwrite_mode_subtest(void)
>> +{
>> +       unsigned long size, len1, len2, len3, len4, len5;
>> +       unsigned long expect_avail_data, expect_prod_pos, expect_over_pos;
>> +       struct test_ringbuf_overwrite_lskel *skel;
>> +       int err;
>> +
>> +       skel = test_ringbuf_overwrite_lskel__open();
>> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +               return;
>> +
>> +       size = 0x1000;
> 
> this will fail on architecture with page size != 4KB, I adjusted this
> to use page_size, len1 to page_size / 2 and len2 to page_size / 4
>

Ah, good catch, thanks for fixing it!

>> +       len1 = 0x800;
>> +       len2 = 0x400;
>> +       len3 = size - len1 - len2 - BPF_RINGBUF_HDR_SZ * 3; /* 0x3e8 */
>> +       len4 = len3 - 8; /* 0x3e0 */
>> +       len5 = len3; /* retry with len3 */
>> +
> 
> [...]


