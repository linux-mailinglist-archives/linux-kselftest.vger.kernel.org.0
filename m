Return-Path: <linux-kselftest+bounces-2416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567081DDDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 04:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB61F21318
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF73805;
	Mon, 25 Dec 2023 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw6TXAlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AFA4C;
	Mon, 25 Dec 2023 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33678156e27so3308414f8f.1;
        Sun, 24 Dec 2023 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703474154; x=1704078954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k42dv9cULHqbXBuZcvQpqJeLLWeESM/hS6ldT4hs2m4=;
        b=Nw6TXAluWJ7ZW4Y7/AtyKCejGj/yMZrvb3QAQsBuhjRAZKgJcmRVkwavoDo5g+mj2X
         q1kFXr6nIma4zbsD07twvqwOR51/f8ScW5EssH6rVr9BcPzUBDW5THZg8Bps757rAf6+
         a2RvcIFG5O003dGd5W44bvjxT7oqawYJS5fHTHrZ5IKUYco1ESKWpEAcKcJH5tx+Wwjg
         P/mt5TH3F90t5cWSghWQiksiSCBXGpRtAGGR2g7PM8mTwZaCqu9TIGblUFswzONsT6rX
         M6i7UIQHB6i8J8V4W/VtRvDeqJC27fDNwqC6scxmWNuZwg6mW7RO0J2dpJFMEOixMFIm
         nHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703474154; x=1704078954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k42dv9cULHqbXBuZcvQpqJeLLWeESM/hS6ldT4hs2m4=;
        b=vlGjnYbNBwuYuG2lNJROWnVvr2vb9c5AMdxJofrsWFoyfDQaPxDvJMGAXobomNQ+hc
         rz4bAc9LDYSNWjuRjMq/6mD2QQU8nTTcXtRqFWmesC1+IMPAl9bsXvDooUY2hyQ0FonW
         +YGZtxiLidC7BQnMe1msUbLunjxJ/Qz4DIOCHh45NJbAzAUQ57IARFua4Pe6LJDXVICI
         OmJhrlpBxN0b2YLLfvmOKpmUaAUiT4+zCYWajtmcvkozC5aIVrOYNKgNoVogLcbpnja8
         kJ1IiOx9nZbX4Hpm7+3SusTmMSX4WRLZAH3Wd0AzKnO4HKeCdZ2DS4/iJXuZK6wgnx3B
         DduA==
X-Gm-Message-State: AOJu0YwzqT7BpM2wPSbu9ZZqOMsAkyvocxFvXX3qm45JsgaRrkpb0JBe
	tTNitliaMCIZlk/ReSdqXejbNJNK8BfGeS5hi3c=
X-Google-Smtp-Source: AGHT+IE9Xxxg8/YGHc1yVs4qvYx066zi+QA3Y13LmGiJ6dKfo6+ofO0zpnvnrIDaKLdNhGg2/KikhwwIzuJ2MnKPcM8=
X-Received: by 2002:adf:f5cc:0:b0:336:6bf0:a005 with SMTP id
 k12-20020adff5cc000000b003366bf0a005mr3030980wrp.92.1703474154305; Sun, 24
 Dec 2023 19:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214013.3327288-1-maxtram95@gmail.com> <20231220214013.3327288-9-maxtram95@gmail.com>
In-Reply-To: <20231220214013.3327288-9-maxtram95@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Dec 2023 19:15:42 -0800
Message-ID: <CAADnVQ+6MjSLRq5hFy=kHosoWR=RDOSuU1znCrkcRp-WeD5CMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/15] bpf: Assign ID to scalars on spill
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:40=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> Currently, when a scalar bounded register is spilled to the stack, its
> ID is preserved, but only if was already assigned, i.e. if this register
> was MOVed before.
>
> Assign an ID on spill if none is set, so that equal scalars could be
> tracked if a register is spilled to the stack and filled into another
> register.
>
> One test is adjusted to reflect the change in register IDs.
>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  kernel/bpf/verifier.c                                     | 8 +++++++-
>  .../selftests/bpf/progs/verifier_direct_packet_access.c   | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b757fdbbbdd2..caa768f1e369 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4503,9 +4503,15 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>
>         mark_stack_slot_scratched(env, spi);
>         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && e=
nv->bpf_capable) {
> +               bool reg_value_fits;
> +
> +               reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_BYTE =
* size;
> +               /* Make sure that reg had an ID to build a relation on sp=
ill. */
> +               if (reg_value_fits)
> +                       assign_scalar_id_before_mov(env, reg);

Thanks.
I just debugged this issue as part of my bpf_cmp series.

llvm generated:

1093: (7b) *(u64 *)(r10 -96) =3D r0     ;
R0_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256) R10=3Dfp0
fp-96_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256)
; if (bpf_cmp(filepart_length, >, MAX_PATH))
1094: (25) if r0 > 0x100 goto pc+903          ;
R0_w=3Dscalar(id=3D53,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D256=
,var_off=3D(0x0;
0x1ff))

the verifier refined the range of 'r0' here,
but the code just read spilled value from stack:

1116: (79) r1 =3D *(u64 *)(r10 -64)     ; R1_w=3Dmap_value
; payload +=3D filepart_length;
1117: (79) r2 =3D *(u64 *)(r10 -96)     ;
R2_w=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256) R10=3Dfp0
fp-96=3Dscalar(smin=3Dsmin32=3D-4095,smax=3Dsmax32=3D256)
1118: (0f) r1 +=3D r2 ;
R1_w=3Dmap_value(map=3Ddata_heap,ks=3D4,vs=3D23040,off=3D148,smin=3Dsmin32=
=3D-4095,smax=3Dsmax32=3D3344)

And later errors as:
"R1 min value is negative, either use unsigned index or do a if (index
>=3D0) check."

This verifier improvement is certainly necessary.

Since you've analyzed this issue did you figure out a workaround
for C code on existing and older kernels?

