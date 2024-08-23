Return-Path: <linux-kselftest+bounces-16180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97F95D63A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08689B21049
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAED192595;
	Fri, 23 Aug 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7ItRM21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9113634A;
	Fri, 23 Aug 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442495; cv=none; b=u1qIKZcpZzKPjmCVkSOTgQ8H2J2is4MRbYz7bq5ti00m0neNg7veFsv6qqed3EgemX2FtVVvW+C34DjJ9FmYo1nGp3p7fAAQsPs8hmI1O7Av0Ug/4hbjeuhBUC8VlsyIbqUwz693rp8TBS8D4OPSw0Pjy7m3uA4EQq4MAhBwYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442495; c=relaxed/simple;
	bh=0Wd6FYm2nAQGFwdHOGxsQxACz5GbzFsHrY7+ivxHsGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnwTQDpJa9+j/nnS7Tf28k1vhSI/jiP6yZ5YZjUiCq4pQAcgdaJqaDCHhmVazXEJki9ccdks+Y1qCCepPlshq7bJ416SWwD6t+TM4o4Tq4uZl4Mw7LNmwdSW/dUwOMFCAB9J9PfM0zPH5mRIPO6StzUyK3+6uqFQQUo+cQcMp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7ItRM21; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so1673194a91.1;
        Fri, 23 Aug 2024 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442493; x=1725047293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YQeJlBC0iYKzMdYaQnpxI/5kheG6fqdtDkH58UN63g=;
        b=Q7ItRM21TDI77U2WxvSK9tjoYGDXl3XaOeDAaFtwl+n5NpvTbdPtut2Q4rm30vwX8t
         kDQ3U2jliNd+Xz19Fp6xQy9/nC+DkK8Bbj4gi0gfcWA266AAdE+Gcg1LWCYF/8SjpmR1
         AYjhTkP4cWtEFjpqac6JtWqqo9fFHnJ/36dSulBEst8kSSuFyCzpfHz/xnMIYMhXfv12
         NWdL3J1z8jZSP4++39BSleQeP6S8tVP+WaWgJtkFbK0f3sHCV2wjcOMZqIO7JfzTgsrC
         QrEB04MTJ40lp211WfzYdZMvbixyQz5tl2vklzOO2A9SUGFXPmDdPa6FIwEm/CSXVQ+M
         sKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442493; x=1725047293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YQeJlBC0iYKzMdYaQnpxI/5kheG6fqdtDkH58UN63g=;
        b=d0hwv8vNPY3mvAESiL3j1wE16Mx4TrYzHp+KEr900aKVdtQCcpgVCHumOxqNZ/r8u5
         pMK98ysZW+hFs3rNtULiURA6IpFsQI9vMLdLDeJNsg7k+H2384D5OTdG+AWAU0fcNjuB
         u4xWkNcwwqLtk/ALQEw+5VEdTfMreNp68PrtCf+v0t5Ll4o8ifVjRZ1/hya/Jt3J1agw
         PodqpI9u6mHVm+gGy+5Hly4YiJW6c4Da/OfI/hLsZHAHp76kaUvcM/7Zw7RBvOZe9/Es
         JF93nT+8RhBkmce2Gdub1mwzv1i2cHZaX8wzuEGraoUC6ApkO2Ezez9xueQv4KS4lsxw
         pOQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IxsRTmv3eM9mx2R9kIm7SuyOq/b2VP1YMCFAq7svmITt0x33UNLsNUvpFWjMKQBAlTEWusacW+6dcnPYBQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0CTo1O9RcCko1CWNEWgxcI5jzAduGcScRVrT6PvskZasvR77
	JICG0wbW9kZJuXwT/inFcRzoxpruPPI1F2XSsj1w9t6W+fXEEAPGleRsjYwuNMXnfztTGlN9bHB
	NHv6sfGRfltFR59HrEpNWUoaGjRo=
X-Google-Smtp-Source: AGHT+IHocL2X2smqsmOI849Ho3GK7eotrhOUBB0bPR4PM13CggHWtAg6yzGqZGHmW7D+9al4KOHTxWowLcmxD6/LmbQ=
X-Received: by 2002:a17:90b:438f:b0:2c9:64fb:1c7e with SMTP id
 98e67ed59e1d1-2d646bbb1ccmr3632008a91.14.1724442492875; Fri, 23 Aug 2024
 12:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
In-Reply-To: <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 12:47:56 -0700
Message-ID: <CAEf4BzYixndSzU3ab97-OfDscR2Qe+H5+9HRQKRm90UM8F_o-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] libbpf: Support creating light skeleton
 of either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:25=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Track target endianness in 'struct bpf_gen' and process in-memory data in
> native byte-order, but on finalization convert the embedded loader BPF
> insns to target endianness.
>
> The light skeleton also includes a target-accessed data blob which is
> heterogeneous and thus difficult to convert to target byte-order on
> finalization. Add support functions to convert data to target endianness
> as it is added to the blob.
>
> Also add additional debug logging for data blob structure details and
> skeleton loading.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |   1 +
>  tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++--------
>  tools/lib/bpf/libbpf.c           |   1 +
>  tools/lib/bpf/skel_internal.h    |   3 +-
>  4 files changed, 147 insertions(+), 45 deletions(-)
>

[...]

> +/*
> + * Fields of bpf_attr are set to values in native byte-order before bein=
g
> + * written to the target-bound data blob, and may need endian conversion=
.
> + * This macro allows setting the correct value in situ and is simpler th=
an
> + * writing a separate converter for *all fields* of *all records* includ=
ed
> + * in union bpf_attr.
> + */
> +#define move_tgt_endian(lval, rval) {                          \
> +       if (!gen->swapped_endian)                               \
> +               lval =3D (rval);                                  \

add {}  here and for else branch, please

> +       else                                                    \
> +               switch (sizeof(lval)) {                         \
> +               case 2:                                         \
> +                       lval =3D bswap_16(rval);                  \
> +                       break;                                  \
> +               case 4:                                         \
> +                       lval =3D bswap_32(rval);                  \
> +                       break;                                  \
> +               case 8:                                         \
> +                       lval =3D bswap_64(rval);                  \
> +                       break;                                  \

I'd also go for more compact:


case 2: lval =3D bswap_16(rval); break;
case 4: lval =3D bswap_32(rval); break;

> +               default:                                        \
> +                       lval =3D (rval);                          \
> +                       pr_warn("unsupported bswap size!\n");   \

case 1: is unsupported? It just doesn't need a byte swap, so please
add it explicitly and avoid unnecessary warnings

> +               }                                               \
> +       }
> +
>  void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
>                        __u32 btf_raw_size)
>  {

[...]

>         emit(gen, BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_8, offsetofend(st=
ruct bpf_insn, code)));
>         emit(gen, BPF_ALU32_IMM(BPF_AND, BPF_REG_9, reg_mask));
>         emit(gen, BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, offsetofend(st=
ruct bpf_insn, code)));
> @@ -931,11 +971,34 @@ static void cleanup_relos(struct bpf_gen *gen, int =
insns)
>         cleanup_core_relo(gen);
>  }
>
> +/* Covert func, line, and core relo info records to target endianness,

typo: convert

> + * checking the blob size is consistent with 32-bit fields.
> + */
> +static void info_blob_bswap(struct bpf_gen *gen, int info_off, __u32 siz=
e)
> +{
> +       __u32 *field =3D gen->data_start + info_off;
> +       int i, cnt =3D size / sizeof(__u32);
> +
> +       if (size && size % sizeof(__u32)) {

nit: () around mod operation

> +               pr_warn("info records not using 32-bit fields!\n");
> +               return;
> +       }
> +       if (gen->swapped_endian)
> +               for (i =3D 0; i < cnt; i++, field++)
> +                       *field =3D bswap_32(*field);
> +}
> +
>  void bpf_gen__prog_load(struct bpf_gen *gen,
>                         enum bpf_prog_type prog_type, const char *prog_na=
me,
>                         const char *license, struct bpf_insn *insns, size=
_t insn_cnt,
>                         struct bpf_prog_load_opts *load_attr, int prog_id=
x)
>  {
> +       int func_info_tot_sz =3D load_attr->func_info_cnt *
> +                              load_attr->func_info_rec_size;
> +       int line_info_tot_sz =3D load_attr->line_info_cnt *
> +                              load_attr->line_info_rec_size;
> +       int core_relo_tot_sz =3D gen->core_relo_cnt *
> +                              sizeof(struct bpf_core_relo);
>         int prog_load_attr, license_off, insns_off, func_info, line_info,=
 core_relos;
>         int attr_size =3D offsetofend(union bpf_attr, core_relo_rec_size)=
;
>         union bpf_attr attr;
> @@ -947,32 +1010,60 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>         license_off =3D add_data(gen, license, strlen(license) + 1);
>         /* add insns to blob of bytes */
>         insns_off =3D add_data(gen, insns, insn_cnt * sizeof(struct bpf_i=
nsn));
> +       pr_debug("gen: prog_load: license off %d insn off %d\n",
> +                license_off, insns_off);
>
> -       attr.prog_type =3D prog_type;
> -       attr.expected_attach_type =3D load_attr->expected_attach_type;
> -       attr.attach_btf_id =3D load_attr->attach_btf_id;
> -       attr.prog_ifindex =3D load_attr->prog_ifindex;
> -       attr.kern_version =3D 0;
> -       attr.insn_cnt =3D (__u32)insn_cnt;
> -       attr.prog_flags =3D load_attr->prog_flags;
> -
> -       attr.func_info_rec_size =3D load_attr->func_info_rec_size;
> -       attr.func_info_cnt =3D load_attr->func_info_cnt;
> -       func_info =3D add_data(gen, load_attr->func_info,
> -                            attr.func_info_cnt * attr.func_info_rec_size=
);
> +       /* convert blob insns to target endianness */
> +       if (gen->swapped_endian) {
> +               struct bpf_insn *insn =3D gen->data_start + insns_off;
> +               int i;
>
> -       attr.line_info_rec_size =3D load_attr->line_info_rec_size;
> -       attr.line_info_cnt =3D load_attr->line_info_cnt;
> -       line_info =3D add_data(gen, load_attr->line_info,
> -                            attr.line_info_cnt * attr.line_info_rec_size=
);
> +               for (i =3D 0; i < insn_cnt; i++, insn++)
> +                       bpf_insn_bswap(insn);
> +       }
>
> -       attr.core_relo_rec_size =3D sizeof(struct bpf_core_relo);
> -       attr.core_relo_cnt =3D gen->core_relo_cnt;
> -       core_relos =3D add_data(gen, gen->core_relos,
> -                            attr.core_relo_cnt * attr.core_relo_rec_size=
);
> +       move_tgt_endian(attr.prog_type, prog_type);
> +       move_tgt_endian(attr.expected_attach_type, load_attr->expected_at=
tach_type);
> +       move_tgt_endian(attr.attach_btf_id, load_attr->attach_btf_id);
> +       move_tgt_endian(attr.prog_ifindex, load_attr->prog_ifindex);
> +       attr.kern_version =3D 0;
> +       move_tgt_endian(attr.insn_cnt, (__u32)insn_cnt);
> +       move_tgt_endian(attr.prog_flags, load_attr->prog_flags);
> +
> +       move_tgt_endian(attr.func_info_rec_size, load_attr->func_info_rec=
_size);
> +       move_tgt_endian(attr.func_info_cnt, load_attr->func_info_cnt);

this is quite intrusive, maybe instead of imperative move_tgt_endian()
macro, develop the one that could be used as

attr.func_info_cnt =3D tgt_endian(load_attr->func_info_cnt);

? I.e., working as an expression, taking into account the need to swap
and byte size of the argument. Should be doable.

> +       func_info =3D add_data(gen, load_attr->func_info, func_info_tot_s=
z);
> +       pr_debug("gen: prog_load: func_info: off %d cnt %d rec size %d\n"=
,
> +                func_info, load_attr->func_info_cnt,
> +                load_attr->func_info_rec_size);

[...]

