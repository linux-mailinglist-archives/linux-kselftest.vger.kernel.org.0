Return-Path: <linux-kselftest+bounces-16178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88D95D634
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF1B1C215D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82F1925B2;
	Fri, 23 Aug 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGgnNVGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0677104;
	Fri, 23 Aug 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442482; cv=none; b=Yg+RWRRsnpEtdm1cBxtKpZFWe0FYPpoAyni+C0TCL8V94x3OCNkP1KdMy0QBQzM5cyOxUJFNuyyD/y3tQdrUOgoUylUMZLXrtbdIj3fiqvhBvQ8nNfzy1VnsHMgcwWISHCArhM8JuLpdw2sxjnHtU0QBx0KWWMRfI2YH+D4qeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442482; c=relaxed/simple;
	bh=9XstFkqDCkYjAFbZnIrIJYv2szDc1sl1JDnO80eqt3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfi02KG6JrnyRMRvi4UaE+SyGGMKnyHJmBOihiMdukotANbU5v/wczXyUPAx8/WtrWsvJQFL9StebU0+o35vcrUyDAcF6uXs+8lEzEgNah99ySMdnMMq/LXzIFXqYZVxwgZ0++GVRO5zFnWt0aVsjiPMy7rHiuJBVXQxYkm1tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGgnNVGi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so1845446a91.3;
        Fri, 23 Aug 2024 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442480; x=1725047280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzq+JlEmJBf28B4cntQnu93hbThlv9ZKRKotNCqSt9Y=;
        b=FGgnNVGiPmZt13dUmXvfvlQzT/s5t6iIvM/DJozfsySGzlHygLoVEenbTOqkiMJWB/
         M9DcfAA6RGDRxBv+r26LXmoltzyOntR4CIz8UPx8ETcykRfMeEHVmJgIm6lFlZy1dlED
         TLDI1MKHWqkWdU1WC4MkVgmrQwhaOdxUzLtQsZepwHeGtfapjXLMYV9SPYqCLwrIXnL0
         W/FpKwILT9VzNZajNZQmWV05ACBjvB5fIxPlHvunNjdNoYmG4QeYqPJSdgF9sKdVkpg2
         HPOsjugRzkm2TQnuN8I7SJrw52TCf3h5jx/PZ3pX2mHO2NEgiJplJQ4DtVQ5HeGjfqtZ
         WJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442480; x=1725047280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzq+JlEmJBf28B4cntQnu93hbThlv9ZKRKotNCqSt9Y=;
        b=me6EdEzZVfXBMse8Pf49miYf/lEg9RG/MT8sR/Em68sgiCprwhoHNDP6b+J80cmv5K
         itcv5IzG5EbnTpjzMT81fPn4rvhVHCyHlbE6ZUU+yfrVYpnK7PoSHcxyW79NbWe1Flw9
         Z/rzsCLBRRNIBsOQX4g/J7Bg9/afxYrXqw4TGYXgupZFtzudNbT4GdSHBC1Cxt4RejGg
         ZtoNj3BRm09wo8WBjW8nkHIa5pEo98TeB+hquYWKnx4eS89j49qg6WbPktVydNs/STbF
         Db4RDPenyol66wnTsuZA7vkFD2qZh4xctV3hHrgeKaOs2PkbtZ+h8lntpAtCpjZfn9r4
         fh7A==
X-Forwarded-Encrypted: i=1; AJvYcCVS9LnrbRjD+JtjyDKU3Ny5Xy/0iDK0xwyuiBA3rc+tbti+kUAQpkyk40pg6t/jVtDE/4YJDTlng+JVJbiLoO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5qF1+oOLVvkcMMK1fM2jV0l71miXvkEgjbK2fkK3VWLh1JuD
	L4Mqtmz0RUZJDqUl2wUCK3tliFuLEZLrNdqWI9BAa+dSaJE7iexnOl3yBQSoqlvWBDw4eiGBBvv
	3wNq+/Dz4TBjkUXISki5JQuSNYt4=
X-Google-Smtp-Source: AGHT+IECDA0JI6PHqVQon40zYRBk33I0QHCwXm9xMLvGN0Waji9F131tOmDEgzBiDLWQXhn8/MwqhHasv58aI7sOzSQ=
X-Received: by 2002:a17:90a:3ea5:b0:2c9:9f06:bb2f with SMTP id
 98e67ed59e1d1-2d646bd1c3fmr3578656a91.6.1724442480438; Fri, 23 Aug 2024
 12:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
In-Reply-To: <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 12:47:47 -0700
Message-ID: <CAEf4Bzbr79SQxfsmhB=5cbNdLRvsLXJT7+s0HvmvHghmyFC0MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] libbpf: Support opening bpf objects of
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

On Thu, Aug 22, 2024 at 2:25=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Allow bpf_object__open() to access files of either endianness, and conver=
t
> included BPF programs to native byte-order in-memory for introspection.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
>  tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>

Instructions are not the only data that would need swapping. We have
user's data sections and stuff like that, which, generally speaking,
isn't that safe to just byteswap.

I do understand the appeal of being endianness-agnostic, but doesn't
extend all the way to actually loading BPF programs. At least I
wouldn't start there.

We need to make open phase endianness agnostic, load should just fail
for swapped endianness case. So let's record the fact that we are not
in native endianness, and fail early in load step.

This will still allow us to generate skeletons and stuff like that, right?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8a0a0c1e37e1..a542031f4f73 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -940,6 +940,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf=
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
> +               pr_debug("prog '%s': converted %zu insns to native byteor=
der\n",

"byte order"?

> +                        prog->name, prog->insns_cnt);
> +       }
> +}
> +
>  static const struct btf_member *
>  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>  {
> @@ -1610,7 +1625,6 @@ static int bpf_object__check_endianness(struct bpf_=
object *obj)
>  #else
>  # error "Unrecognized __BYTE_ORDER__"
>  #endif
> -       pr_warn("elf: endianness mismatch in %s.\n", obj->path);
>         return -LIBBPF_ERRNO__ENDIAN;
>  }
>
> @@ -3953,6 +3967,10 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                 return -LIBBPF_ERRNO__FORMAT;
>         }
>
> +       /* change BPF program insns to native endianness for introspectio=
n */
> +       if (bpf_object__check_endianness(obj))

let's rename this to "is_native_endianness()" and return true/false.
"check" makes sense as something that errors out, but now it's purely
a query, so "check" naming is confusing.


BTW, so libelf will transparently byte-swap relocations and stuff like
that to native endianness, is that right?

> +               bpf_object_bswap_progs(obj);
> +
>         /* sort BPF programs by section name and in-section instruction o=
ffset
>          * for faster search
>          */
> @@ -7993,7 +8011,6 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
>         }
>
>         err =3D bpf_object__elf_init(obj);
> -       err =3D err ? : bpf_object__check_endianness(obj);
>         err =3D err ? : bpf_object__elf_collect(obj);
>         err =3D err ? : bpf_object__collect_externs(obj);
>         err =3D err ? : bpf_object_fixup_btf(obj);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 6b0270c83537..f53daa601c6f 100644
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
> @@ -590,6 +591,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *=
insn)
>         return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
>  }
>
> +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> +{
> +       /* dst_reg & src_reg nibbles */
> +       __u8 *regs =3D (__u8 *)insn + offsetofend(struct bpf_insn, code);
> +
> +       *regs =3D (*regs >> 4) | (*regs << 4);

hm... we have fields, just do a brain-dead swap instead of all this
mucking with offsetofend(

__u8 tmp_reg =3D insn->dst_reg;

insn->dst_reg =3D insn->src_reg;
insn->src_reg =3D tmp_reg;

?


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

