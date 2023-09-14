Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C37A0AA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjINQUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINQUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:20:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21399B;
        Thu, 14 Sep 2023 09:20:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso1944994e87.0;
        Thu, 14 Sep 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694708444; x=1695313244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J95EVnvedQGsOXFf9YyeDY6M57brRLbFCl8LMxPg7Xc=;
        b=pVoCwqsjbNrDMr63tfrSXgWlY/ABLBXMtFHPCklw1HnPobi9MjUjzAvoxpAfUPGg7y
         oP68t/OMVp+nEc38UfIkGejWupRin3usi5AyDDtXQm+qZ6mqaOcaMkd80Y3f4xL4lp7Q
         TmP9KqCaETofJvw73TkHKc/lQWgTS5dNMOa2S1jXYNW0iNKgbf5bikLCLPVpZjXgyBf0
         bTcIfBSSCADBtaj58rppzKZR/jMq0PRvnPCXMOY2wUXFTmuU8FoTZEUjXxPPgyYtR6y4
         UKPCTs0OfbUzN10PSKVbMPBBTnHoWbes+ckgb3bRPE4t/VCrcliCbCq/I2Wut9NLH1uj
         DjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708444; x=1695313244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J95EVnvedQGsOXFf9YyeDY6M57brRLbFCl8LMxPg7Xc=;
        b=pUPVt+TtMPLS6958QokQ0XtYv/1mzlaZJw8No55NDMMw4wLsBqhS5gS3S/yW3Mwk4O
         9KuW5L6YXz1prpoJVKj9y4059ZpXXnC+QoyxBtXAPEOmF+UuU3WZ4jVLUmzWsrglMzQ0
         S/90++vxII1kvdDQvv9W2MgDDpeLNaKpv0XqP1GL8/fQ2TYITrOni+m/IBn7huzSwK66
         tUD1TAOjDTVYNPMP7QB/vyKGJqNGvhS14HAYqUK4H+/ip4Dl/XM+Q8FXphFi1dEUEthi
         SD5704TWvg2C72K1a4lfAh3W8TbOW5en4jf32kJrTClXx+psbmILToZAlo+nEacT+A/D
         i1jw==
X-Gm-Message-State: AOJu0YyuKsfcq2/BWXtgUDfbdP7jIfHtKHEhltTriFdQc3Cya+OjW+JS
        TQnnKom51smmPrRrj+aqxfiZAsoVv/2Zl3XFcSE=
X-Google-Smtp-Source: AGHT+IGq5hOj8vL3TMQVdZKjYxMC3LkGk25J0zeXmYONkzwmZ89uatlv3waUJU08I2cSoeHLfS3oHQvDBmnDcOmiyRc=
X-Received: by 2002:ac2:5394:0:b0:4f9:5580:1894 with SMTP id
 g20-20020ac25394000000b004f955801894mr4511518lfh.15.1694708443569; Thu, 14
 Sep 2023 09:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de>
In-Reply-To: <20230913122827.91591-1-gerhorst@amazon.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Sep 2023 09:20:32 -0700
Message-ID: <CAADnVQJsjVf3t0OJCZkc3rNpHMi_ZTtwLa3LBMi6ot3zufnb+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        gerhorst@amazon.de, Ilya Leoshkevich <iii@linux.ibm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 13, 2023 at 5:30=E2=80=AFAM Luis Gerhorst <gerhorst@amazon.de> =
wrote:
>
> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
>
> To mitigate Spectre v1, the verifier relies on static analysis to deduct
> constant pointer bounds, which can then be enforced by rewriting pointer
> arithmetic [1] or index masking [2]. This relies on the fact that every
> memory region to be accessed has a static upper bound and every date
> below that bound is accessible. The verifier can only rewrite pointer
> arithmetic or insert masking instructions to mitigate Spectre v1 if a
> static upper bound, below of which every access is valid, can be given.
>
> When allowing packet pointer comparisons, this introduces a way for the
> program to effectively construct an accessible pointer for which no
> static upper bound is known. Intuitively, this is obvious as a packet
> might be of any size and therefore 0 is the only statically known upper
> bound below of which every date is always accessible (i.e., none).
>
> To clarify, the problem is not that comparing two pointers can be used
> for pointer leaks in the same way in that comparing a pointer to a known
> scalar can be used for pointer leaks. That is because the "secret"
> components of the addresses cancel each other out if the pointers are
> into the same region.
>
> With [3] applied, the following malicious BPF program can be loaded into
> the kernel without CAP_PERFMON:
>
> r2 =3D *(u32 *)(r1 + 76) // data
> r3 =3D *(u32 *)(r1 + 80) // data_end
> r4 =3D r2
> r4 +=3D 1
> if r4 > r3 goto exit
> r5 =3D *(u8 *)(r2 + 0) // speculatively read secret
> r5 &=3D 1 // choose bit to leak
> // ... side channel to leak secret bit
> exit:
> // ...
>
> This is jited to the following amd64 code which still contains the
> gadget:
>
>    0:   endbr64
>    4:   nopl   0x0(%rax,%rax,1)
>    9:   xchg   %ax,%ax
>    b:   push   %rbp
>    c:   mov    %rsp,%rbp
>    f:   endbr64
>   13:   push   %rbx
>   14:   mov    0xc8(%rdi),%rsi // data
>   1b:   mov    0x50(%rdi),%rdx // data_end
>   1f:   mov    %rsi,%rcx
>   22:   add    $0x1,%rcx
>   26:   cmp    %rdx,%rcx
>   29:   ja     0x000000000000003f // branch to mispredict
>   2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
>   30:   and    $0x1,%r8 // choose bit to leak
>   34:   xor    %ebx,%ebx
>   36:   cmp    %rbx,%r8
>   39:   je     0x000000000000003f // branch based on secret
>   3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
>   3f:   xor    %eax,%eax
>   41:   pop    %rbx
>   42:   leaveq
>   43:   retq
>
> Here I'm using a port contention side channel because storing the secret
> to the stack causes the verifier to insert an lfence for unrelated
> reasons (SSB mitigation) which would terminate the speculation.
>
> As Daniel already pointed out to me, data_end is even attacker
> controlled as one could send many packets of sufficient length to train
> the branch prediction into assuming data_end >=3D data will never be true=
.
> When the attacker then sends a packet with insufficient data, the
> Spectre v1 gadget leaks the chosen bit of some value that lies behind
> data_end.

The above analysis is correct, but unlike traditional spec_v1
the attacker doesn't control data/data_end.
The attack can send many large packets to train that data + X < data_end
and then send a small packet where CPU will mispredict that branch
and data + X will speculatively read past data_end,
so the attacker can extract a bit past data_end,
but data/data_end themselves cannot be controlled.
So whether this bit 0 or 1 has no bearing.
The attack cannot be repeated for the same location.
The attacker can read one bit 8 times in a row and all of them
will be from different locations in the memory.
Same as reading 8 random bits from 8 random locations.
Hence I don't think this revert is necessary.
I don't believe you can craft an actual exploit.

Your patch 3 says:
       /* Speculative access to be prevented. */
+       char secret =3D *((char *) iph);
+
+       /* Leak the first bit of the secret value that lies behind data_end=
 to a
+        * SMP silbling thread that also executes imul instructions. If the=
 bit
+        * is 1, the silbling will experience a slowdown. */
+       long long x =3D secret;
+       if (secret & 1) {
+               x *=3D 97;
+       }

the comment is correct, but speculative access alone is not enough
to leak data.
