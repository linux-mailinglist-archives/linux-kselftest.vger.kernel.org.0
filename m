Return-Path: <linux-kselftest+bounces-8904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21848B3200
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F30F285A77
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA613C8FA;
	Fri, 26 Apr 2024 08:08:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DB13C3D2;
	Fri, 26 Apr 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118903; cv=none; b=dt6YgfYf1iRmtL6bgd3qKRX35U16UDjpjrpUOJQIzCKGvNiUo3oaFgXlV7vsBrClf01ZqXuczisueUalvJwA969JVWScp6pMuTdcag4Mwg/zmIWoiGGIElCKVLGdJfaZEvrBTrzRe0XoTapD3mJ4AnhkhPQCOcueB62v3ROi3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118903; c=relaxed/simple;
	bh=IkevYIPtn61bmtlN+qIWCKonXa5qxF2qnAUt/ycGBQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvjFxDPYt6+f6PXYYXdAGZzVsrRz3N9UToDmnhHyaA5Gd3Qq9g/xw3nmmSpgTS16z3HVfODojp3wWAAvmP2Y4MbKNHqitpWm95VrLCvAT++kNKRtr13kNmrwTqE9eOqDrFaGR7kYslumIDhPmjm1ssntVPh8p/nw/X23G7txtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQlhj3r4Kz4f3lX6;
	Fri, 26 Apr 2024 16:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6D7D41A0568;
	Fri, 26 Apr 2024 16:08:10 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDX3JToYCtmDrxUKw--.26953S2;
	Fri, 26 Apr 2024 16:08:10 +0800 (CST)
Message-ID: <2deeb1ef-e8f2-4ff8-9a9b-b79a40b25bec@huaweicloud.com>
Date: Fri, 26 Apr 2024 16:08:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 06/11] bpf: Fix compare error in function
 retval_range_within
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-7-xukuohai@huaweicloud.com>
 <CAEf4BzapNjmhBYC1YsmwBFNP7rdans9X2StkQ3uQDhAyf7Py7g@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzapNjmhBYC1YsmwBFNP7rdans9X2StkQ3uQDhAyf7Py7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDX3JToYCtmDrxUKw--.26953S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUCF4xCF47Gw4rtFW8WFg_yoW5GrWDpF
	4rGa4qya1qqrW7u3ZFva1kArWrt3Waqw47K395A340yw4Yqr1kKF42gw4akaySyr48Gw1f
	tF12v34av3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/26/2024 7:41 AM, Andrii Nakryiko wrote:
> On Thu, Apr 11, 2024 at 5:24 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> After checking lsm hook return range in verifier, the test case
>> "test_progs -t test_lsm" failed, and the failure log says:
>>
>> libbpf: prog 'test_int_hook': BPF program load failed: Invalid argument
>> libbpf: prog 'test_int_hook': -- BEGIN PROG LOAD LOG --
>> 0: R1=ctx() R10=fp0
>> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
>> 0: (79) r0 = *(u64 *)(r1 +24)         ; R0_w=scalar(smin=smin32=-4095,smax=smax32=0) R1=ctx()
>>
>> [...]
>>
>> 24: (b4) w0 = -1                      ; R0_w=0xffffffff
>> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
>> 25: (95) exit
>> At program exit the register R0 has smin=4294967295 smax=4294967295 should have been in [-4095, 0]
>>
>> It can be seen that instruction "w0 = -1" zero extended -1 to 64-bit
>> register r0, setting both smin and smax values of r0 to 4294967295.
>> This resulted in a false reject when r0 was checked with range [-4095, 0].
>>
>> Given bpf_retval_range is a 32-bit range, this patch fixes it by
>> changing the compare between r0 and return range from 64-bit
>> operation to 32-bit operation.
>>
>> Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback exit")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   kernel/bpf/verifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 05c7c5f2bec0..5393d576c76f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9879,7 +9879,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>>
>>   static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
>>   {
>> -       return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
>> +       return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
> 
> are all BPF programs treated as if they return int instead of long? If
> not, we probably should have a bool flag in bpf_retval_range whether
> comparison should be 32-bit or 64-bit?
>

It seems that when a fmod_return prog is attached to a kernel function
that returns long value, the bpf prog should also return long value.
To confirm it, I'll try to find an example or construct a case for this.

>>   }
>>
>>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>> --
>> 2.30.2
>>
> 


