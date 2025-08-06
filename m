Return-Path: <linux-kselftest+bounces-38358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B108B1C132
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541E63B9B67
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46F218ABD;
	Wed,  6 Aug 2025 07:20:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D3211A11;
	Wed,  6 Aug 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464853; cv=none; b=HMCz/RVeQW/FvT8SHRydUCXQJI0sZKjSzPTp6ZwKmoM3KoFkFv+PnQsnrERxVdcXSmeWY8xUtVFYvba5krasT2G1s18fnDPpiz74UM1du0kRmQQNDAhImimA7sXyGNF/rX2dnPaBJ4S1heSUSEbfAzDOE5yuZcDy1IYFXjYVDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464853; c=relaxed/simple;
	bh=vIFlUEQ8duZaV++ql5qnFXORdx14T1OmC8rb2hvrisw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrfZzU13tCEqmtEpKSf1sp3WzaK8BErkYiOYv75GLEXQWSkYaO5yFetpkO7rKWrF5r0/HKQk9P2piqSLjNLM/U9aXzMqN4rbDFlypQ99YVvEDqltux8RPLeQAisCBJQ1BZUtxhVMfacmrDlQxOl6BE3FZELg4I8awqOHXZj6heQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bxh4d2QtTz9sRh;
	Wed,  6 Aug 2025 09:00:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EE6QsNR5sOkc; Wed,  6 Aug 2025 09:00:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bxh4d1G7Tz9sRg;
	Wed,  6 Aug 2025 09:00:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 119908B765;
	Wed,  6 Aug 2025 09:00:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4moU8TC_Njvz; Wed,  6 Aug 2025 09:00:00 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D0D438B763;
	Wed,  6 Aug 2025 08:59:59 +0200 (CEST)
Message-ID: <e8c39250-e9a0-4075-92b2-ffa2344a9212@csgroup.eu>
Date: Wed, 6 Aug 2025 08:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next 1/6] bpf,powerpc: Introduce
 bpf_jit_emit_probe_mem_store() to emit store instructions
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
 shuah@kernel.org
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-2-skb99@linux.ibm.com>
 <e65548d0-14aa-4b9c-8051-7c91c5dffd1f@csgroup.eu>
 <8cfa1cb2-57bf-4984-a64e-53c82440e87f@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <8cfa1cb2-57bf-4984-a64e-53c82440e87f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/08/2025 à 13:59, Venkat Rao Bagalkote a écrit :
> 
> On 05/08/25 1:04 pm, Christophe Leroy wrote:
>>
>>
>> Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
>>> bpf_jit_emit_probe_mem_store() is introduced to emit instructions for
>>> storing memory values depending on the size (byte, halfword,
>>> word, doubleword).
>>
>> Build break with this patch
>>
>>   CC      arch/powerpc/net/bpf_jit_comp64.o
>> arch/powerpc/net/bpf_jit_comp64.c:395:12: error: 
>> 'bpf_jit_emit_probe_mem_store' defined but not used [-Werror=unused- 
>> function]
>>  static int bpf_jit_emit_probe_mem_store(struct codegen_context *ctx, 
>> u32 src_reg, s16 off,
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[4]: *** [scripts/Makefile.build:287: arch/powerpc/net/ 
>> bpf_jit_comp64.o] Error 1
>>
> I tried this on top of bpf-next, and for me build passed.

Build of _this_ patch (alone) passed ?

This patch defines a static function but doesn't use it, so the build 
must breaks because of that, unless you have set CONFIG_PPC_DISABLE_WERROR.

Following patch starts using this function so then the build doesn't 
break anymore. But until next patch is applied the build doesn't work. 
Both patches have to be squashed together in order to not break 
bisectability of the kernel.

Christophe

> 
> Note: I applied https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flore.kernel.org%2Fbpf%2F20250717202935.29018-2- 
> puranjay%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0468473019834e07ef2b08ddd4179b9c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638899920058624267%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=iZLg9NUWxtH3vO1STI8wRYLzwvhohd2KKTAGYDe3WnM%3D&reserved=0 before applying current patch.
> 
> gcc version 14.2.1 20250110
> 
> uname -r: 6.16.0-gf2844c7fdb07
> 
> bpf-next repo: https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fkernel.googlesource.com%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbpf%2Fbpf-next&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0468473019834e07ef2b08ddd4179b9c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638899920058644309%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=OrMauttrzPbaFYhzKdkH5l%2FltISc95MwitnUC7YLhJQ%3D&reserved=0
> 
> HEAD:
> 
> commit f3af62b6cee8af9f07012051874af2d2a451f0e5 (origin/master, origin/ 
> HEAD)
> Author: Tao Chen <chen.dylane@linux.dev>
> Date:   Wed Jul 23 22:44:42 2025 +0800
> 
>      bpftool: Add bash completion for token argument
> 
> 
> Build Success logs:
> 
>    TEST-OBJ [test_progs-cpuv4] xdp_vlan.test.o
>    TEST-OBJ [test_progs-cpuv4] xdpwall.test.o
>    TEST-OBJ [test_progs-cpuv4] xfrm_info.test.o
>    BINARY   bench
>    BINARY   test_maps
>    BINARY   test_progs
>    BINARY   test_progs-no_alu32
>    BINARY   test_progs-cpuv4
> 
> 
> Regards,
> 
> Venkat.
> 
>>
>>>
>>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>>> ---
>>>   arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/ 
>>> bpf_jit_comp64.c
>>> index 025524378443..489de21fe3d6 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>>> @@ -409,6 +409,36 @@ asm (
>>>   "        blr                ;"
>>>   );
>>>   +static int bpf_jit_emit_probe_mem_store(struct codegen_context 
>>> *ctx, u32 src_reg, s16 off,
>>> +                    u32 code, u32 *image)
>>> +{
>>> +    u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
>>> +    u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
>>> +
>>> +    switch (BPF_SIZE(code)) {
>>> +    case BPF_B:
>>> +        EMIT(PPC_RAW_STB(src_reg, tmp1_reg, off));
>>> +        break;
>>> +    case BPF_H:
>>> +        EMIT(PPC_RAW_STH(src_reg, tmp1_reg, off));
>>> +        break;
>>> +    case BPF_W:
>>> +        EMIT(PPC_RAW_STW(src_reg, tmp1_reg, off));
>>> +        break;
>>> +    case BPF_DW:
>>> +        if (off % 4) {
>>> +            EMIT(PPC_RAW_LI(tmp2_reg, off));
>>> +            EMIT(PPC_RAW_STDX(src_reg, tmp1_reg, tmp2_reg));
>>> +        } else {
>>> +            EMIT(PPC_RAW_STD(src_reg, tmp1_reg, off));
>>> +        }
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>>   static int emit_atomic_ld_st(const struct bpf_insn insn, struct 
>>> codegen_context *ctx, u32 *image)
>>>   {
>>>       u32 code = insn.code;
>>


