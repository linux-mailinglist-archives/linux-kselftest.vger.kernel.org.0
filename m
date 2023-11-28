Return-Path: <linux-kselftest+bounces-724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25927FBED1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424651F20F42
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109C21E4A9;
	Tue, 28 Nov 2023 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KinhKpEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492258E;
	Tue, 28 Nov 2023 08:02:45 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aab20e828so7983526e87.2;
        Tue, 28 Nov 2023 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701187363; x=1701792163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADK4UzT2nKfv38QmGQVpz2/R0ySW0ULt4MZjYJMnC70=;
        b=KinhKpEt/BKSYRhPKaeFuJVjyTcrx5BMwKbwYVZPke8vtYmJBsFEST+ciR0G1+xA++
         r2NiOGgAoussGTAZqnkzTOQ78EAXzHby2aUHoerxMofnNwsGMCFaKUYpBqbC2KxBxJFr
         QoHE+drn5y94clRbk/kbbcbL6xfkbfIWqtZuDA7k8OtWPZZG4ACWjd74IT83EjhoTovG
         XjrymeT82p3Hx58H4vcf+F+RzkO9eSSdATY9Q0v07wLFsvYNihzPmj111kTCYY5oVYzT
         1iFLmBTt1zcfzmlXnSZoOIXvmKuCVG18CPspFpcO4ryp/LsxdroluAqJD/j7E73PyZo4
         D43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187363; x=1701792163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADK4UzT2nKfv38QmGQVpz2/R0ySW0ULt4MZjYJMnC70=;
        b=oO/lzZnWbVEcVyPO0Z4++6Ff0DqDP1YON/cpUMi1nPp9oT0L0YJ4XgeL7yeGBCb7Eh
         0C+TEu/izIqJYQ1ySuJFSu8SZqazoVga/ASJCA1+DGfzrpJBO00cCYgooiqLz+++jUbG
         ICfUm4xC9+LMUSBNmxAzSZt+ltz/KWMYwKF2ht1BalBVOCh9ZKI1RTCchfQwXNakmLLC
         ge9kx47zKjefaxRU5PP1hZRBRbpYB0AcFVUEsUlno5f3y9KJEHj4NGm9Dkm7/zjIu1B/
         xIJErGsc0BBjbb2oIMmmgfu4cAWk4t/86RlQExf7XocrT9oWP2unHcDMU/sYv0ZB+wM3
         tRww==
X-Gm-Message-State: AOJu0YzT4SPrm03vxf28Vsmp9yoBFRT7F6ryxncTc1iGyVb0p0JhRueW
	BgTcRaWRIpWD5oRZWMfhmFMSgI29w+sfiQIx1OjSH71X
X-Google-Smtp-Source: AGHT+IHVpBNXzWxOGjaZ+/ar7Exoa9BOXEqnHi4S3/80jkowAyPk5R1/bxAelfcY283RguuSs3LmPvtidVja3NbmfKo=
X-Received: by 2002:ac2:58f8:0:b0:4fa:f96c:745f with SMTP id
 v24-20020ac258f8000000b004faf96c745fmr9014758lfo.38.1701187362785; Tue, 28
 Nov 2023 08:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev> <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev> <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev> <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
 <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
 <53jaqi72ef4gynyafxidl5veb54kfs7dttxezkarwg75t7szd4@cvfg5pc7pyum> <f68c01d6-bf6b-4b76-8b20-53e9f4a61fcd@linux.dev>
In-Reply-To: <f68c01d6-bf6b-4b76-8b20-53e9f4a61fcd@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 08:02:30 -0800
Message-ID: <CAEf4BzaUSBGQ3cWcAR7R3UNUrPOq6VrPA=p8G9oiCttBcQNQEw@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	devel@linux-ipsec.org, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:06=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/27/23 7:01 PM, Daniel Xu wrote:
> > On Mon, Nov 27, 2023 at 02:45:11PM -0600, Daniel Xu wrote:
> >> On Sun, Nov 26, 2023 at 09:53:04PM -0800, Yonghong Song wrote:
> >>> On 11/27/23 12:44 AM, Yonghong Song wrote:
> >>>> On 11/26/23 8:52 PM, Eduard Zingerman wrote:
> >>>>> On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
> >>>>> [...]
> >>>>>>> Tbh I'm not sure. This test passes with preserve_static_offset
> >>>>>>> because it suppresses preserve_access_index. In general clang
> >>>>>>> translates bitfield access to a set of IR statements like:
> >>>>>>>
> >>>>>>>     C:
> >>>>>>>       struct foo {
> >>>>>>>         unsigned _;
> >>>>>>>         unsigned a:1;
> >>>>>>>         ...
> >>>>>>>       };
> >>>>>>>       ... foo->a ...
> >>>>>>>
> >>>>>>>     IR:
> >>>>>>>       %a =3D getelementptr inbounds %struct.foo, ptr %0, i32 0, i=
32 1
> >>>>>>>       %bf.load =3D load i8, ptr %a, align 4
> >>>>>>>       %bf.clear =3D and i8 %bf.load, 1
> >>>>>>>       %bf.cast =3D zext i8 %bf.clear to i32
> >>>>>>>
> >>>>>>> With preserve_static_offset the getelementptr+load are replaced b=
y a
> >>>>>>> single statement which is preserved as-is till code generation,
> >>>>>>> thus load with align 4 is preserved.
> >>>>>>>
> >>>>>>> On the other hand, I'm not sure that clang guarantees that load o=
r
> >>>>>>> stores used for bitfield access would be always aligned according=
 to
> >>>>>>> verifier expectations.
> >>>>>>>
> >>>>>>> I think we should check if there are some clang knobs that preven=
t
> >>>>>>> generation of unaligned memory access. I'll take a look.
> >>>>>> Is there a reason to prefer fixing in compiler? I'm not opposed to=
 it,
> >>>>>> but the downside to compiler fix is it takes years to propagate an=
d
> >>>>>> sprinkles ifdefs into the code.
> >>>>>>
> >>>>>> Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD=
()?
> >>>>> Well, the contraption below passes verification, tunnel selftest
> >>>>> appears to work. I might have messed up some shifts in the macro,
> >>>>> though.
> >>>> I didn't test it. But from high level it should work.
> >>>>
> >>>>> Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particu=
lar
> >>>>> field access might be unaligned.
> >>>> clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
> >>>> alignment requirement. This is also required for BPF_CORE_READ_BITFI=
ELD.
> >>>>
> >>>>> ---
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> >>>>> b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> >>>>> index 3065a716544d..41cd913ac7ff 100644
> >>>>> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> >>>>> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> >>>>> @@ -9,6 +9,7 @@
> >>>>>    #include "vmlinux.h"
> >>>>>    #include <bpf/bpf_helpers.h>
> >>>>>    #include <bpf/bpf_endian.h>
> >>>>> +#include <bpf/bpf_core_read.h>
> >>>>>    #include "bpf_kfuncs.h"
> >>>>>    #include "bpf_tracing_net.h"
> >>>>>    @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *=
skb)
> >>>>>        return TC_ACT_OK;
> >>>>>    }
> >>>>>    +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({          =
  \
> >>>>> +    void *p =3D (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);   =
 \
> >>>>> +    unsigned byte_size =3D __CORE_RELO(s, field, BYTE_SIZE);      =
  \
> >>>>> +    unsigned lshift =3D __CORE_RELO(s, field, LSHIFT_U64); \
> >>>>> +    unsigned rshift =3D __CORE_RELO(s, field, RSHIFT_U64); \
> >>>>> +    unsigned bit_size =3D (rshift - lshift);                \
> >>>>> +    unsigned long long nval, val, hi, lo;                \
> >>>>> +                                    \
> >>>>> +    asm volatile("" : "=3Dr"(p) : "0"(p));                \
> >>>> Use asm volatile("" : "+r"(p)) ?
> >>>>
> >>>>> +                                    \
> >>>>> +    switch (byte_size) {                        \
> >>>>> +    case 1: val =3D *(unsigned char *)p; break;            \
> >>>>> +    case 2: val =3D *(unsigned short *)p; break;            \
> >>>>> +    case 4: val =3D *(unsigned int *)p; break;            \
> >>>>> +    case 8: val =3D *(unsigned long long *)p; break;            \
> >>>>> +    }                                \
> >>>>> +    hi =3D val >> (bit_size + rshift);                \
> >>>>> +    hi <<=3D bit_size + rshift;                    \
> >>>>> +    lo =3D val << (bit_size + lshift);                \
> >>>>> +    lo >>=3D bit_size + lshift;                    \
> >>>>> +    nval =3D new_val;                            \
> >>>>> +    nval <<=3D lshift;                        \
> >>>>> +    nval >>=3D rshift;                        \
> >>>>> +    val =3D hi | nval | lo;                        \
> >>>>> +    switch (byte_size) {                        \
> >>>>> +    case 1: *(unsigned char *)p      =3D val; break;            \
> >>>>> +    case 2: *(unsigned short *)p     =3D val; break;            \
> >>>>> +    case 4: *(unsigned int *)p       =3D val; break;            \
> >>>>> +    case 8: *(unsigned long long *)p =3D val; break;            \
> >>>>> +    }                                \
> >>>>> +})
> >>>> I think this should be put in libbpf public header files but not sur=
e
> >>>> where to put it. bpf_core_read.h although it is core write?
> >>>>
> >>>> But on the other hand, this is a uapi struct bitfield write,
> >>>> strictly speaking, CORE write is really unnecessary here. It
> >>>> would be great if we can relieve users from dealing with
> >>>> such unnecessary CORE writes. In that sense, for this particular
> >>>> case, I would prefer rewriting the code by using byte-level
> >>>> stores...
> >>> or preserve_static_offset to clearly mean to undo bitfield CORE ...
> >> Ok, I will do byte-level rewrite for next revision.
> > [...]
> >
> > This patch seems to work: https://pastes.dxuuu.xyz/0glrf9 .
> >
> > But I don't think it's very pretty. Also I'm seeing on the internet tha=
t
> > people are saying the exact layout of bitfields is compiler dependent.
>
> Any reference for this (exact layout of bitfields is compiler dependent)?
>
> > So I am wondering if these byte sized writes are correct. For that
> > matter, I am wondering how the GCC generated bitfield accesses line up
> > with clang generated BPF bytecode. Or why uapi contains a bitfield.
>
> One thing for sure is memory layout of bitfields should be the same
> for both clang and gcc as it is determined by C standard. Register
> representation and how to manipulate could be different for different
> compilers.
>
> >
> > WDYT, should I send up v2 with this or should I do one of the other
> > approaches in this thread?
>
> Daniel, look at your patch, since we need to do CORE_READ for
> those bitfields any way, I think Eduard's patch with
> BPF_CORE_WRITE_BITFIELD does make sense and it also makes code
> easy to understand. Could you take Eduard's patch for now?
> Whether and where to put BPF_CORE_WRITE_BITFIELD macros
> can be decided later.

bpf_core_read.h name is... let's say "historical" and was never meant
to limit stuff there to read-only or anything like that. Think about
it as just bpf_core.h where all the CO-RE-related stuff goes. So
please put BPF_CORE_WRITE_BITFIELD there.

>
> >
> > I am ok with any of the approaches.
> >
> > Thanks,
> > Daniel
> >

