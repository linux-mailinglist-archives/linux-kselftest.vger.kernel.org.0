Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A972EAE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjFMSZ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 14:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjFMSZy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 14:25:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3019A8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 11:25:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97668583210so852789666b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1686680751; x=1689272751;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndSkO2qkti4L/SsRIO9nUQau8kKaAI3Sxaq+0HhunWc=;
        b=ntRa6AW6ValrHAqkuzvskPZkjppT1UiqWn5XgLaJRL+M66yi9z5SuBsJJtsg8gSyVk
         ZTIikpoielPrbB8yOOTgCPTe0h3G8snlfV3i1tciBEYR0ULVrQlaH6ZlloWRNz123Gp2
         8aS+0U465JGkaRt7VZb5swDwBi6W5as5+c8JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680751; x=1689272751;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndSkO2qkti4L/SsRIO9nUQau8kKaAI3Sxaq+0HhunWc=;
        b=c/B9ppeFdDpgFc/ZMR8hQTKiVwuFH4ZSxo8BfpwVFxfDGJVg4PoOUwjQ0IcvikZrCa
         Y8V7o+NOKoA0sjAjy4m7QznYwBxzIEn0fjZwwgRghysvDCEFjZHTpxiOQ+okkUYGIQ7z
         lQ8rfrYPwQ9gHASi1XbYSCMaJLZHV1GlS73S1c4oUxDaA34Z1sTYkM5YStthZnzzwWMy
         s5iORFnbtVv0ot//Qz4/Yi8L8yaBA/JYVZYoO+xFsKw+dWgK8p4wB1jc1DaKa4zodh3P
         InAkGLk1PL3J/TnHiztGbIzt+y3R1V3wguLYgOgRpmKq+xxUhWF4F8Pm1ru/y5JKlYB3
         6vuQ==
X-Gm-Message-State: AC+VfDzjQx5zE3O9OKXBQq68IUhozDPgs+uqnoSCvQmz5zBUZ+0K/PTc
        OdBsQsgtOuxdxxoCbmyMyVbTrA==
X-Google-Smtp-Source: ACHHUZ6L7PTRLKSYbWQ/tjcT0d/XBC+vGVXO4zTlysaNeyin+mwYf/zWWNDpzlfMXEPA3fN2f50m6A==
X-Received: by 2002:a17:906:da87:b0:974:1c91:a752 with SMTP id xh7-20020a170906da8700b009741c91a752mr12713028ejb.5.1686680751027;
        Tue, 13 Jun 2023 11:25:51 -0700 (PDT)
Received: from cloudflare.com (79.184.146.33.ipv4.supernova.orange.pl. [79.184.146.33])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906b21400b009767c4235absm6869904ejz.219.2023.06.13.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:25:50 -0700 (PDT)
References: <20230613084315.62021-1-luojianhong@cdjrlc.com>
 <6228af14241b831be4bae6ebcd63799e@208suo.com>
 <53510828-ee5b-1d91-0f85-b79da4422741@meta.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     baomingtong001@208suo.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Remove unneeded variable "ret"
Date:   Tue, 13 Jun 2023 20:13:00 +0200
In-reply-to: <53510828-ee5b-1d91-0f85-b79da4422741@meta.com>
Message-ID: <87pm5z9q36.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 13, 2023 at 06:42 AM -07, Yonghong Song wrote:
> On 6/13/23 1:50 AM, baomingtong001@208suo.com wrote:
>> Fix the following coccicheck warning:
>> tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c:28:14-17: Unneeded
>> variable: "ret".
>> Return "1".
>> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
>> ---
>>  =C2=A0tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c | 3 +--
>>  =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
>> b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
>> index 4a9f63bea66c..7f0146682577 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
>> @@ -25,10 +25,9 @@ static __noinline
>>  =C2=A0int subprog_tail(struct __sk_buff *skb)
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Don't propagate the constant to the ca=
ller */
>> - =C2=A0=C2=A0=C2=A0volatile int ret =3D 1;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call_static(skb, &jmp_table, 0);
>> - =C2=A0=C2=A0=C2=A0return ret;
>> + =C2=A0=C2=A0=C2=A0return 1;
>
> Please pay attention to the comment:
>    /* Don't propagate the constant to the caller */
> which clearly says 'constant' is not preferred.
>
> The patch introduced this change is:
>     5e0b0a4c52d30   selftests/bpf: Test tail call counting with bpf2bpf a=
nd data
>    on stack
>
> The test intentionally want to:
>   'Specifically when the size      of data allocated on BPF stack is not a
>  multiple on 8.'
>
> Note that with volatile and without volatile, the generated
> code will be different and it will result in different
> verification path.
>
> cc Jakub for further clarification.

Yonghong is right. We can't replace it like that.

Compiler is smart and pull up the constant into subprog_tail() caller.

And it doesn't have the slightest idea that bpf_tail_call_static() is
actually tail call (destroy frame + jump) and control doesn't return to
subprog_tail().

(You can read more about BPF tail calls in [1] and [2] if they are not
familiar.)

IOW, we need an r0 store to happen after a call to BPF tail call helper
(call 12) to remain in subprog_tail body for the regression test to
work:

$ llvm-objdump -d --no-show-raw-insn tailcall_bpf2bpf6.bpf.o

tailcall_bpf2bpf6.bpf.o:        file format elf64-bpf

Disassembly of section .text:

0000000000000000 <subprog_tail>:
       0:       r6 =3D r1
       1:       w1 =3D 1
       2:       *(u32 *)(r10 - 4) =3D r1
       3:       r7 =3D 0 ll
       5:       r1 =3D r6
       6:       r2 =3D r7
       7:       r3 =3D 0
       8:       call 12
       9:       r0 =3D *(u32 *)(r10 - 4) <-- this must stay
      10:       exit

You could take a shot at replacing it with inline asm, if you want.

[1] https://docs.cilium.io/en/stable/bpf/architecture/#bpf-to-bpf-calls
[2] https://blog.cloudflare.com/assembly-within-bpf-tail-calls-on-x86-and-a=
rm/
