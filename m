Return-Path: <linux-kselftest+bounces-9110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801868B6943
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15705283E2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039E1118C;
	Tue, 30 Apr 2024 03:56:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE116FB1;
	Tue, 30 Apr 2024 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714449404; cv=none; b=gmJCFBa1esXOgVPdXZ4USK3g3CodDW5tCBnc3TIroEYZdwWt7psJAzX1ih3/Y15HHW55YsTvPkqSVAyMMRqrSh/IM6j+pomrajJCuDSP7IwO4VisL9GVFy5l5WCkuTe8rz5swK38YkqzE7EksqPgeyh0NAdzq24cZXflrQgxpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714449404; c=relaxed/simple;
	bh=6ALl9UXSaL7NBK/D77wblFzZOFOlnA04iNtl2Y4884U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMa6FfrjQUgN+ib0QOnIim+N2CAdfw3c14csuxQj5y5m267jHdJVe8n9/KiRAKR3kDNJxENTpb00say9gKGMPRD/UNLO3NbnkmBMY/HuTqW0jIs5nK8ZTFauJtWii9oMKpFWlThSM1jNw130rtaYOE3XbS1oSRavnViIH6XrIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VT5wY0R61z4f3nbv;
	Tue, 30 Apr 2024 11:56:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 80EF51A117B;
	Tue, 30 Apr 2024 11:56:38 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBXufz1azBmMmhpLg--.27247S2;
	Tue, 30 Apr 2024 11:56:38 +0800 (CST)
Message-ID: <9e49be2a-ec07-4265-a55a-45c1eb19c565@huaweicloud.com>
Date: Tue, 30 Apr 2024 11:56:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
 <20240411122752.2873562-8-xukuohai@huaweicloud.com>
 <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com>
 <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
 <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
 <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
 <CAEf4BzZb38EemdD8ahX4Px3vWCp=ani6vcX71Z-1_MLeATNjwQ@mail.gmail.com>
 <7cf8b58011156af99816391d3afd5c52e48ea8b7.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <7cf8b58011156af99816391d3afd5c52e48ea8b7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXufz1azBmMmhpLg--.27247S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DtF1rKFyxZry3Aw1UZFb_yoW8trW5pr
	WDGFsIqr4kAayUZ3sFvws8ZrZ5Xr18tF1xCr1DAa4Iyr17tFy3try3GFyUJrySvrs7Jrs2
	yF17W39Ivan8ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/30/2024 6:18 AM, Eduard Zingerman wrote:
> On Mon, 2024-04-29 at 13:58 -0700, Andrii Nakryiko wrote:
> 
> [...]
> 
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 8f0f2e21699e..b69c89bc5cfc 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -13478,6 +13478,28 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>>>                   return;
>>>           }
>>>
>>> +       /* Special case: dst_reg is in range [-1, 0] */
>>> +       if (dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0) {
>>> +               var32_off = tnum_union(src_reg->var_off, tnum_const(0));
>>> +               dst_reg->var_off = tnum_with_subreg(dst_reg->var_off, var32_off);
>>> +               dst_reg->u32_min_value = var32_off.value;
>>> +               dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
>>
>> can you explain the logic behing u32 min/max updates, especially that
>> we use completely different values for min/max and it's not clear why
>> u32_min <= u32_max invariant will always hold. Same below
> 
> I agree with Andrii here.
> It appears that dst_reg.{min,max} fields should be set as
> {min(src.min, 0), max(src.max, 0)} for both signed and unsigned cases.
> Wdyt?
>

Agree, since 0 is the minimum unsigned number, the result range is
equal to [0, src.u32_max].

>>
>>> +               dst_reg->s32_min_value = min_t(s32, src_reg->s32_min_value, 0);
>>> +               dst_reg->s32_max_value = max_t(s32, src_reg->s32_max_value, 0);
>>> +               return;
>>> +       }
>>> +
>>> +       /* Special case: src_reg is in range [-1, 0] */
>>> +       if (src_reg->s32_min_value == -1 && src_reg->s32_max_value == 0) {
>>> +               var32_off = tnum_union(dst_reg->var_off, tnum_const(0));
>>> +               dst_reg->var_off = tnum_with_subreg(dst_reg->var_off, var32_off);
>>> +               dst_reg->u32_min_value = var32_off.value;
>>> +               dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
>>> +               dst_reg->s32_min_value = min_t(s32, dst_reg->s32_min_value, 0);
>>> +               dst_reg->s32_max_value = max_t(s32, dst_reg->s32_max_value, 0);
>>> +               return;
>>> +       }
>>> +
>>>           /* We get our minimum from the var_off, since that's inherently
>>>            * bitwise.  Our maximum is the minimum of the operands' maxima.
>>>            */
> 
> [...]


