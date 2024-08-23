Return-Path: <linux-kselftest+bounces-16179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42E95D636
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BD1F23EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7119258D;
	Fri, 23 Aug 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMxasa/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E718D64F;
	Fri, 23 Aug 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442488; cv=none; b=cG6C9TPAnk+c7C/XDTvSmIhjYGx+wilyka6b70xstZS278sI5JixzqnJgenm45T9uZKI6aQ74CxoDxV0z05l4+ua85XJ6zuHBavEOA5WOuD0wuUY01fw+YpYYZ1bV9zdfmQu+vD/mdLVU0wabZOzV/t766wBGFNvUAzEKUxyT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442488; c=relaxed/simple;
	bh=dtEpJRyep5Ef/3Ih/AX8vq2n5pHJQ3cPUkLJjQXZZ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQPe2x0q1bAc0TdJ/gQ2VfjshP6nHNf01a2Em7pOEpT0sExluygYWayx0FUo7BRZ8iHg4bkh0LuI2EBeuCjyJFI4LfFeF0p90Qf1PN5LoLkxvdcSgwWJow8KRSUAlcIMc1B0dV1xZ/4TflRjaJ65YdGpCUgl7tnEDmA7NN5iln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMxasa/h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so1664959a91.3;
        Fri, 23 Aug 2024 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442486; x=1725047286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFrJtqPrv+8vGvYy7f8dRxQ9FPG5ZmHGpJeWDP6tDh4=;
        b=RMxasa/hb2UjRHDrly1jASkm1QBX4XdI2oewU7b0N/2RS/u2RV778Xuw2ZxQghxdcR
         yZODnh3AZ4WiFynlMV/bdsiRhDbdGxPnTtAB9hLzSPjKEeBAv3iFiyj4NFTj7zmoU9dw
         W3Vzq5mONmwivVwK3/82Rvsop8WYzAjkUKPc/91qt3M6idnQ8ylPcckAQPiQdG9wOR0s
         hVNI/iDBL8VJxIwN3StEU1naRYwGkZFO52zHSYayMYnHkmnXH4KEPAUBVHYgrbOSK2xH
         QMiY7Z+o6T4ihUYbJ75pAq+PhbTc3jnzUSi7UxpFhFMHDtWi3egqSrJc5mZzZVc1Cwwb
         FFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442486; x=1725047286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFrJtqPrv+8vGvYy7f8dRxQ9FPG5ZmHGpJeWDP6tDh4=;
        b=re/WPXWnw+7m+GvX+uu7iXQiybXlTut4JbCWkcfPLKmHzJsH7loPuv/+ADhgdEuds/
         xqtrXXdbWSWwZmF7B2nyh51u09v1yj0Gssx5QzDsvpD1JihnmlqICX/Lo0qkYtXMtGmq
         m+ry9gKKSVDNR/yfhq4SigYGeVDt+4UAv3+gyIQ/4ZtDPx0L9hwGyDnXCwkJ4Eh8dJ9n
         DKS/2eiJqj1RaO+5onx2DfDtF2WQzUmEhygslnLM+jXYeSidNzK4//hcdqPJsHMe9pBZ
         GTMBs7VY1N7Ku4kSneN9AUtZUkOJgBe8cRvUcoyRJWdzc5sdU4fIs2a2mlfqoPiX/Uxm
         oPqg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Pu3TQf1Cpv+PVd0A13Bs2agp/M9k6d5/Ayqy9v7HvRHprUrJAAQUSzwjGyrso62olZV17Vm2LQOeUi/CMiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZI5vpS0USa1SFeOsz7dvJzIvy1KZhUO5amx1AkzLneswlDTU
	C2xeng29BRVfKkfB+tAcQ0nxGONCKxSS02qnQetre0fsxIAQUW31gmpXGRecBMmhReOPa+tli7Y
	8HefiRvEfQAjT6pAfGXbbWw3ypj4=
X-Google-Smtp-Source: AGHT+IEdCMdJtZPUfa7w1bMNPzqYvi1BsEY8fygiRKJmR6p/FsYHXBW0ZlnWHa1UBr2xti135ukqWDgq/1DDEif5O1w=
X-Received: by 2002:a17:90b:4c0a:b0:2d3:bd5f:b369 with SMTP id
 98e67ed59e1d1-2d646b912cfmr3662462a91.1.1724442485948; Fri, 23 Aug 2024
 12:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <0511638ed6191f4434be23ed7fb56001ccb5b687.1724313164.git.tony.ambardar@gmail.com>
In-Reply-To: <0511638ed6191f4434be23ed7fb56001ccb5b687.1724313164.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 12:47:52 -0700
Message-ID: <CAEf4BzZ8Dh3oFm_EeU3btQ4B+WCkaoxwc7iD3CskthTMX0rh9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/8] libbpf: Support linking bpf objects of
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
> Allow static linking object files of either endianness, checking that inp=
ut
> files have consistent byte-order, and setting output endianness from inpu=
t.
>
> Linking requires in-memory processing of programs, relocations, sections,
> etc. in native endianness, and output conversion to target byte-order. Th=
is
> is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
> functions. Further add local functions for swapping byte-order of section=
s
> containing BPF insns.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 106 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 16 deletions(-)
>

Mostly just stylistic and code organization nits, the change overall looks =
good.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 7489306cd6f7..9bf218db443e 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -135,6 +135,7 @@ struct bpf_linker {
>         int fd;
>         Elf *elf;
>         Elf64_Ehdr *elf_hdr;
> +       bool swapped_endian;
>
>         /* Output sections metadata */
>         struct dst_sec *secs;
> @@ -324,13 +325,8 @@ static int init_output_elf(struct bpf_linker *linker=
, const char *file)
>
>         linker->elf_hdr->e_machine =3D EM_BPF;
>         linker->elf_hdr->e_type =3D ET_REL;
> -#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> -       linker->elf_hdr->e_ident[EI_DATA] =3D ELFDATA2LSB;
> -#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -       linker->elf_hdr->e_ident[EI_DATA] =3D ELFDATA2MSB;
> -#else
> -#error "Unknown __BYTE_ORDER__"
> -#endif
> +       /* Set unknown ELF endianness, assign later from input files */
> +       linker->elf_hdr->e_ident[EI_DATA] =3D ELFDATANONE;
>
>         /* STRTAB */
>         /* initialize strset with an empty string to conform to ELF */
> @@ -541,19 +537,21 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>                                 const struct bpf_linker_file_opts *opts,
>                                 struct src_obj *obj)
>  {
> -#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> -       const int host_endianness =3D ELFDATA2LSB;
> -#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -       const int host_endianness =3D ELFDATA2MSB;
> -#else
> -#error "Unknown __BYTE_ORDER__"
> -#endif
>         int err =3D 0;
>         Elf_Scn *scn;
>         Elf_Data *data;
>         Elf64_Ehdr *ehdr;
>         Elf64_Shdr *shdr;
>         struct src_sec *sec;
> +       unsigned char obj_byteorder;
> +       unsigned char *link_byteorder =3D &linker->elf_hdr->e_ident[EI_DA=
TA];

nit: not a fan of pointer into e_ident, just read local value of byte
order, and then assign it directly below (it's only in one of the
branches, no duplication, really)

> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +       const unsigned char host_byteorder =3D ELFDATA2LSB;
> +#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +       const unsigned char host_byteorder =3D ELFDATA2MSB;
> +#else
> +#error "Unknown __BYTE_ORDER__"
> +#endif
>
>         pr_debug("linker: adding object file '%s'...\n", filename);
>
> @@ -579,11 +577,25 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>                 pr_warn_elf("failed to get ELF header for %s", filename);
>                 return err;
>         }
> -       if (ehdr->e_ident[EI_DATA] !=3D host_endianness) {
> +
> +       /* Linker output endianness set by first input object */
> +       obj_byteorder =3D ehdr->e_ident[EI_DATA];
> +       if (obj_byteorder !=3D ELFDATA2LSB && obj_byteorder !=3D ELFDATA2=
MSB) {
>                 err =3D -EOPNOTSUPP;
> -               pr_warn_elf("unsupported byte order of ELF file %s", file=
name);
> +               pr_warn("linker: unknown byte order of ELF file %s\n", fi=
lename);
>                 return err;
>         }
> +       if (*link_byteorder =3D=3D ELFDATANONE) {
> +               *link_byteorder =3D obj_byteorder;

see above, I'd prefer:

linker->elf_hdr->e_ident[EI_DATA] =3D obj_byteorder;

> +               linker->swapped_endian =3D obj_byteorder !=3D host_byteor=
der;
> +               pr_debug("linker: set %s-endian output byte order\n",
> +                        obj_byteorder =3D=3D ELFDATA2MSB ? "big" : "litt=
le");
> +       } else if (*link_byteorder !=3D obj_byteorder) {
> +               err =3D -EOPNOTSUPP;
> +               pr_warn("linker: byte order mismatch with ELF file %s\n",=
 filename);
> +               return err;
> +       }
> +
>         if (ehdr->e_type !=3D ET_REL
>             || ehdr->e_machine !=3D EM_BPF
>             || ehdr->e_ident[EI_CLASS] !=3D ELFCLASS64) {
> @@ -1111,6 +1123,27 @@ static bool sec_content_is_same(struct dst_sec *ds=
t_sec, struct src_sec *src_sec
>         return true;
>  }
>
> +static bool is_exec_sec(struct dst_sec *sec)
> +{
> +       if (!sec || sec->ephemeral)
> +               return false;
> +       return (sec->shdr->sh_type =3D=3D SHT_PROGBITS) &&
> +              (sec->shdr->sh_flags & SHF_EXECINSTR);
> +}
> +
> +static int exec_sec_bswap(void *raw_data, int size)
> +{
> +       const int insn_cnt =3D size / sizeof(struct bpf_insn);
> +       struct bpf_insn *insn =3D raw_data;
> +       int i;
> +
> +       if (size % sizeof(struct bpf_insn))
> +               return -EINVAL;
> +       for (i =3D 0; i < insn_cnt; i++, insn++)
> +               bpf_insn_bswap(insn);
> +       return 0;
> +}
> +
>  static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, st=
ruct src_sec *src)
>  {
>         void *tmp;
> @@ -1170,6 +1203,16 @@ static int extend_sec(struct bpf_linker *linker, s=
truct dst_sec *dst, struct src
>                 memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst=
->sec_sz);
>                 /* now copy src data at a properly aligned offset */
>                 memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, sr=
c->shdr->sh_size);
> +
> +               /* convert added bpf insns to native byte-order */
> +               if (linker->swapped_endian && is_exec_sec(dst)) {
> +                       err =3D exec_sec_bswap(dst->raw_data + dst_align_=
sz,
> +                                            src->shdr->sh_size);

nit: I think exec_sec_bswap() shouldn't ever fail, so given we have
is_exec_sec() now, let's do the size alignment check early on (and
regardless of swapped_endian), and then just proceed with byte swap
that can't fail

> +                       if (err) {
> +                               pr_warn("%s: error changing insns endiann=
ess\n", __func__);
> +                               return err;
> +                       }
> +               }
>         }
>
>         dst->sec_sz =3D dst_final_sz;
> @@ -2630,6 +2673,14 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
>                 if (!sec->scn)
>                         continue;
>
> +               /* restore sections with bpf insns to target byte-order *=
/
> +               if (linker->swapped_endian && is_exec_sec(sec)) {
> +                       err =3D exec_sec_bswap(sec->raw_data, sec->sec_sz=
);

and here we'll know that size is validly aligned anyways, so no checks requ=
ired

> +                       if (err) {
> +                               pr_warn("error finalizing insns endiannes=
s\n");
> +                               return libbpf_err(err);
> +                       }
> +               }
>                 sec->data->d_buf =3D sec->raw_data;
>         }
>
> @@ -2696,6 +2747,13 @@ static int emit_elf_data_sec(struct bpf_linker *li=
nker, const char *sec_name,
>         return 0;
>  }
>
> +static enum btf_endianness
> +linker_btf_endianness(const struct bpf_linker *linker)
> +{
> +       unsigned char byteorder =3D linker->elf_hdr->e_ident[EI_DATA];

empty line between variable declaration and the rest of the code

> +       return byteorder =3D=3D ELFDATA2MSB ? BTF_BIG_ENDIAN : BTF_LITTLE=
_ENDIAN;
> +}
> +

but actually, this whole helper function seems unnecessary, just do
everything inside finalize_btf, it's a pretty trivial piece of logic

>  static int finalize_btf(struct bpf_linker *linker)
>  {
>         LIBBPF_OPTS(btf_dedup_opts, opts);
> @@ -2742,6 +2800,22 @@ static int finalize_btf(struct bpf_linker *linker)
>                 return err;
>         }
>
> +       /* Set .BTF and .BTF.ext output byte order */
> +       err =3D btf__set_endianness(linker->btf,
> +                                 linker_btf_endianness(linker));
> +       if (err) {
> +               pr_warn("failed to set .BTF output endianness: %d\n", err=
);

nit: you used "linker: " prefix for messages like this, stay consistent?


> +               return err;
> +       }
> +       if (linker->btf_ext) {
> +               err =3D btf_ext__set_endianness(linker->btf_ext,
> +                                             linker_btf_endianness(linke=
r));
> +               if (err) {
> +                       pr_warn("failed to set .BTF.ext output endianness=
: %d\n", err);
> +                       return err;
> +               }
> +       }
> +
>         /* Emit .BTF section */
>         raw_data =3D btf__raw_data(linker->btf, &raw_sz);
>         if (!raw_data)
> --
> 2.34.1
>

