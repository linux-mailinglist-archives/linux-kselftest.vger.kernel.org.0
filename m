Return-Path: <linux-kselftest+bounces-2777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023482910C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2208C1C244E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE23E48E;
	Tue,  9 Jan 2024 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cngmUbnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0953E480;
	Tue,  9 Jan 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso3742572e87.3;
        Tue, 09 Jan 2024 15:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704844565; x=1705449365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCona3v6onYyB9IuV+M2B43GdQFvdO/v3FuNvf1zkBU=;
        b=cngmUbnHqGWZ2v3qAUStBV7i47BXi+y6R/ZoDa2wlSi/BfLKqyrdH00ZYRMOjym6rc
         GWYOXjMwKtX9iQnyCqmIl8ec4kYVH3cYIsb+l0G3OL47Nwf8kpoeGBJlFkDE+FBOgSWF
         Z2XQxBrpF7gutc0UtvEmZ83D4cJrfx+JadXhk5R6fnSqyPtXJuiT9RA79w58ylv8GLUR
         RB7uGyEYgIGqLLCQv2K5IFikCtopzqPCO71J9ffldn4wX5cfvZuKSdkULqAX9R1j13TY
         GrffSTu11EuObGT9XTwRx39FYolvrveBpC3NBi2R1n8a+q0seiSMXHDUK4Z3iMvazoa8
         aMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844565; x=1705449365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCona3v6onYyB9IuV+M2B43GdQFvdO/v3FuNvf1zkBU=;
        b=m9KFpkZ8SvwMz6BiI6OPFsrvVNFOr5TlQRxeFDKShmXP0Eji21jnQyXy4RyQ2BN6Ir
         PC+sQ2mR0ypFHog1HCTxTez8uVUNaUoCT8YlA/QBTLfSm+371bcPKRvhVAYtshu/J54p
         ZbfOBFBWIc8pMzWPCdWeSIy4NV+hLA+GtI8yKQkooL8Vw3k9STawnCYUBeoERf90MXjN
         He1BqkIAVdtXh3Hpixlpd08Ac6mHBAeTFPUAhl/yC4eQfE4fKdT0osDdCFRfY4Geum0m
         1SH7g8888GkyX0AxPHJERl9yRWaHqqWVUgljTdfsI/nYn0vPMGcx19EQGdqIH6JQl5bu
         7WFA==
X-Gm-Message-State: AOJu0Yz+xnBRRNW0AchpSj+r58uAvbCVEVNEEcoqrXYLZUKgAEkzW5Xy
	oLsjKZ+Jmg7lInHq50QNli2hy03TKIjbN72eV20=
X-Google-Smtp-Source: AGHT+IG4D6zX08qL43tDPBD8elQbBkfnvRkR3rtCFv5GibmyydifywmykWmDQ4eeZLBqB6mkkuJCMVqJIgv11zXJ22o=
X-Received: by 2002:ac2:5f75:0:b0:50e:d7f6:efd6 with SMTP id
 c21-20020ac25f75000000b0050ed7f6efd6mr44185lfc.35.1704844564916; Tue, 09 Jan
 2024 15:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-14-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-14-maxtram95@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 15:55:52 -0800
Message-ID: <CAEf4Bza3S_HmhHEz34nVDauOB9r09dDW4fZcL26as_hx4XQsWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/15] selftests/bpf: Add test cases for
 narrowing fill
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> The previous commit allowed to preserve boundaries and track IDs of
> scalars on narrowing fills. Add test cases for that pattern.
>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index fab8ae9fe947..3764111d190d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -936,4 +936,112 @@ l0_%=3D:    r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("xdp")
> +__description("32-bit fill after 64-bit spill")
> +__success __retval(0)
> +__naked void fill_32bit_after_spill_64bit(void)

I guess these tests are an answer for my question about mixing
spill/fill sizes on earlier patch (so disregard those)

> +{
> +       asm volatile("                                  \
> +       /* Randomize the upper 32 bits. */              \
> +       call %[bpf_get_prandom_u32];                    \
> +       r0 <<=3D 32;                                      \
> +       /* 64-bit spill r0 to stack. */                 \
> +       *(u64*)(r10 - 8) =3D r0;                          \
> +       /* 32-bit fill r0 from stack. */                \
> +       r0 =3D *(u32*)(r10 - %[offset]);                          \

have you considered doing the BYTE_ORDER check right here and have
offset embedded in assembly instruction directly:

#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
    r0 =3D *(u32*)(r10 - 8);
#else
    r0 =3D *(u32*)(r10 - 4);
#endif

It's a bit less jumping around the code when reading. And it's kind of
obviously that this is endianness-dependent without jumping to
definition of %[offset]?


> +       /* Boundary check on r0 with predetermined result. */\
> +       if r0 =3D=3D 0 goto l0_%=3D;                          \
> +       /* Dead branch: the verifier should prune it. Do an invalid memor=
y\
> +        * access if the verifier follows it.           \
> +        */                                             \
> +       r0 =3D *(u64*)(r9 + 0);                           \
> +l0_%=3D: exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32),
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +         __imm_const(offset, 8)
> +#else
> +         __imm_const(offset, 4)
> +#endif
> +       : __clobber_all);
> +}
> +

[...]

