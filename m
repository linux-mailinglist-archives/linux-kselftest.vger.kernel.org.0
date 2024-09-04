Return-Path: <linux-kselftest+bounces-17171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C0996C7F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39062285EF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286381E6321;
	Wed,  4 Sep 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijOUBowa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689A40C03;
	Wed,  4 Sep 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479440; cv=none; b=jbppiVjOibvUGZNcSGFOEUe2vT011SgssjpOFa7AeyRm2HW0clYtuNU9F+XgphBqES7L4vVOJRLUI3GOhBVmF1DfLCK5Vepz619jo1N6ZrAMtVgRGsd80YK0Fx1v4SI6syswk6ZJD6ivMwzUjP4eLg1LMLRjdrumtSLmmJ5DUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479440; c=relaxed/simple;
	bh=bp5UaINubNIG2e2Xwo/So9Cl0VCWLw6WFeZjNl9O3ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbef2SLpwSX4Eyv0K42TAfuwIDKMhBKyAZy2GG/XZQbWfAKKgdnEaD+wQfNB+V15nVKku/Tb+OF2t7aNMuCECBNOn7AGKnOUT/0kLesFoFT3duWMg9oWIQ3t+VQlKrU57Gks0X0dZUnGV8iBnmF3vcd7bPP4NWFOVJ8BhETpF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijOUBowa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3715215a91.3;
        Wed, 04 Sep 2024 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479438; x=1726084238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XGI3mDxMj5otIzS0t4zz85MLRULpc/dqATU2NnzNB8=;
        b=ijOUBowaI5pvviumYiPswxEwTDD4HJGFv05mCfBX1rP3qp5pZCE60Z7ywowPuqxH2H
         3ZxZARdno+lyv9BvUCBQnzsYN+twNwXosuEivZ6sxowxYKvNEK9DMU/RLBxr4nLoUD2B
         WFoL7CQUnloOZEZBvgwKuNmmFK5fqSRqhvbVAhnoXx7j2GzPUdbLQEoCmgmzsoS1s7++
         tFJ7y0DwALBCwkCDLWDRq7snolOXUjYsCuTUgMPIOKvjon6v7VGmS04/7A/AbckkkYem
         zdVKCoy4adhc4yP1hsuFKk8XN9RJ04xkPw7e8TXvF7uBon3q10RSln5GxrXkp5fy/mj7
         +mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479438; x=1726084238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XGI3mDxMj5otIzS0t4zz85MLRULpc/dqATU2NnzNB8=;
        b=haX9JFkZbuIEAwaac8WuyGo7Ugk999NiQczgg6igMpe0wwCYkrOnDJhtglEZrSVslg
         L0ouvA3Zy33vcKO/6c4b1SOoIK0kpKaW2+/khfux/ppCJObE4+3qSnL5EpLuQrjyWU8g
         Q+ObA+FQYdS2ilpwxJmc4/otxMrCDlm5F0xp+vZLscs7qlarIH4TiZAv+c17ouqEFOTY
         Ztoa4na+mS8t/WuiDloLwn4TyUn4/61kKK1RFVPRIHfYtNoSbGKnroBNShOE4SGyKEQx
         Jn3RsPiMM/yrKByR8lGT8sD4ruYelgmMAnRYdfyCMzc6ePlZreHW6Zt9kwn66p9XZZXM
         gakA==
X-Forwarded-Encrypted: i=1; AJvYcCX7TSOMf2AIp7Vwryg19cfD2z7f3Cbhyo4AQrqAaevzq7yWVteu85tPpb41fwiK6jSwhur1sXSyoebxIHB28Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJEWz1IAY9jEFm5xH6UzFNHeAzMCHHcpJNtq/4g/T9hWhEyn4
	ZKtzUp39XvP5loWX5+QEi4F7tNI+nTHnauUdRNUR3v6sPCsux15SYo8ph2+dxDTjBKIzR02b/5D
	RTHgLl0dHFOnpL/yQACbjeKmPqto=
X-Google-Smtp-Source: AGHT+IGrsoHW6vlUCjX+mbzYmrJgoECjOv7FQltuOhfjn2jp3tuiaH6pskiFjk3s1g35v5VpwA9pi/DiX1U25LtefsA=
X-Received: by 2002:a17:90a:1342:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2d89467eca7mr14363585a91.37.1725479437676; Wed, 04 Sep 2024
 12:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725347944.git.tony.ambardar@gmail.com> <6f2af9efc5b64d5c4669d48927393b97b0232497.1725347944.git.tony.ambardar@gmail.com>
In-Reply-To: <6f2af9efc5b64d5c4669d48927393b97b0232497.1725347944.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 12:50:25 -0700
Message-ID: <CAEf4BzZ=GWRRZU63EsXmaNcE8-mM7XWAg_NmHbXD6tAk9zqukg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Support opening bpf objects of
 either endianness
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

On Tue, Sep 3, 2024 at 12:33=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Allow bpf_object__open() to access files of either endianness, and conver=
t
> included BPF programs to native byte-order in-memory for introspection.
> Loading BPF objects of non-native byte-order is still disallowed however.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 52 +++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf_internal.h | 11 +++++++
>  2 files changed, 54 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0226d3b50709..46f41ea5e74d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -694,6 +694,8 @@ struct bpf_object {
>         /* Information when doing ELF related work. Only valid if efile.e=
lf is not NULL */
>         struct elf_state efile;
>
> +       unsigned char byteorder;
> +
>         struct btf *btf;
>         struct btf_ext *btf_ext;
>
> @@ -940,6 +942,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf=
_Data *sec_data,
>         return 0;
>  }
>
> +static void bpf_object_bswap_progs(struct bpf_object *obj)
> +{
> +       struct bpf_program *prog =3D obj->programs;
> +       struct bpf_insn *insn;
> +       int p, i;
> +
> +       for (p =3D 0; p < obj->nr_programs; p++, prog++) {
> +               insn =3D prog->insns;
> +               for (i =3D 0; i < prog->insns_cnt; i++, insn++)
> +                       bpf_insn_bswap(insn);
> +       }
> +       pr_debug("converted %zu BPF programs to native byte order\n",
> +                obj->nr_programs);

Does it fit in 100 characters? If yes, it stays on single line. That's
the rule for all code, don't wrap lines unnecessarily.

> +}
> +
>  static const struct btf_member *
>  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>  {
> @@ -1506,6 +1523,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
>
>         elf_end(obj->efile.elf);
>         obj->efile.elf =3D NULL;
> +       obj->efile.ehdr =3D NULL;
>         obj->efile.symbols =3D NULL;
>         obj->efile.arena_data =3D NULL;
>
> @@ -1571,6 +1589,16 @@ static int bpf_object__elf_init(struct bpf_object =
*obj)
>                 goto errout;
>         }
>
> +       /* Validate ELF object endianness... */
> +       if (ehdr->e_ident[EI_DATA] !=3D ELFDATA2LSB &&
> +           ehdr->e_ident[EI_DATA] !=3D ELFDATA2MSB) {
> +               err =3D -LIBBPF_ERRNO__ENDIAN;
> +               pr_warn("elf: '%s' has unknown byte order\n", obj->path);
> +               goto errout;
> +       }
> +       /* and save after bpf_object_open() frees ELF data */
> +       obj->byteorder =3D ehdr->e_ident[EI_DATA];
> +
>         if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
>                 pr_warn("elf: failed to get section names section index f=
or %s: %s\n",
>                         obj->path, elf_errmsg(-1));
> @@ -1599,19 +1627,15 @@ static int bpf_object__elf_init(struct bpf_object=
 *obj)
>         return err;
>  }
>
> -static int bpf_object__check_endianness(struct bpf_object *obj)
> +static bool is_native_endianness(struct bpf_object *obj)
>  {
>  #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> -       if (obj->efile.ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2LSB)
> -               return 0;
> +       return obj->byteorder =3D=3D ELFDATA2LSB;
>  #elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -       if (obj->efile.ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2MSB)
> -               return 0;
> +       return obj->byteorder =3D=3D ELFDATA2MSB;
>  #else
>  # error "Unrecognized __BYTE_ORDER__"
>  #endif
> -       pr_warn("elf: endianness mismatch in %s.\n", obj->path);
> -       return -LIBBPF_ERRNO__ENDIAN;
>  }
>
>  static int
> @@ -3953,6 +3977,10 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                 return -LIBBPF_ERRNO__FORMAT;
>         }
>
> +       /* change BPF program insns to native endianness for introspectio=
n */
> +       if (!is_native_endianness(obj))
> +               bpf_object_bswap_progs(obj);
> +
>         /* sort BPF programs by section name and in-section instruction o=
ffset
>          * for faster search
>          */
> @@ -7992,7 +8020,6 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
>         }
>
>         err =3D bpf_object__elf_init(obj);
> -       err =3D err ? : bpf_object__check_endianness(obj);
>         err =3D err ? : bpf_object__elf_collect(obj);
>         err =3D err ? : bpf_object__collect_externs(obj);
>         err =3D err ? : bpf_object_fixup_btf(obj);
> @@ -8498,8 +8525,15 @@ static int bpf_object_load(struct bpf_object *obj,=
 int extra_log_level, const ch
>                 return libbpf_err(-EINVAL);
>         }
>
> -       if (obj->gen_loader)
> +       /* Disallow kernel loading programs of non-native endianness but
> +        * permit cross-endian creation of "light skeleton".
> +        */
> +       if (obj->gen_loader) {
>                 bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_p=
rograms, obj->nr_maps);
> +       } else if (!is_native_endianness(obj)) {
> +               pr_warn("object '%s': loading non-native endianness is un=
supported\n", obj->name);
> +               return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> +       }
>
>         err =3D bpf_object_prepare_token(obj);
>         err =3D err ? : bpf_object__probe_loading(obj);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index a8531195acd4..eda7a0cc2b8c 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -11,6 +11,7 @@
>
>  #include <stdlib.h>
>  #include <limits.h>
> +#include <byteswap.h>
>  #include <errno.h>
>  #include <linux/err.h>
>  #include <fcntl.h>
> @@ -616,6 +617,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *=
insn)
>         return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
>  }
>
> +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> +{
> +       __u8 tmp_reg =3D insn->dst_reg;
> +
> +       insn->dst_reg =3D insn->src_reg;
> +       insn->src_reg =3D tmp_reg;
> +       insn->off =3D bswap_16(insn->off);
> +       insn->imm =3D bswap_32(insn->imm);
> +}
> +
>  /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
>   * Original FD is not closed or altered in any other way.
>   * Preserves original FD value, if it's invalid (negative).
> --
> 2.34.1
>

