Return-Path: <linux-kselftest+bounces-16855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F9966B3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08228B20CF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFD61C0DD2;
	Fri, 30 Aug 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx4OyS7J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC821AF4ED;
	Fri, 30 Aug 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053121; cv=none; b=u27Er7ceLQEKrnI5WLI9GI3nEf7Z5QtLG3R7kFugdKRyFpxjxAtWTmn2FRgPoe8XPm9CKQHiOJS1kHDd/4SAo2KwDRsv/uKZmofnYYPPe8WVb8cs9iGbhdt2JNkGyC2cVHUvwOmljn4LOAAZ8qZoGTKCgYWYQ51tVviCVyC/TPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053121; c=relaxed/simple;
	bh=rPz/q485yBIalXVY+btWqlICxqvVZ533vFnAClRpkPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYYewNY4WHaWv/LvCh+UdASQcrpTmdCbJ92jdZu8ThDhxOwIrXmzL4c4sAxODpJwQ80jvHJ9IuSK5SMtIya4532mRRUPKwcXSE1ikkbbenT1Fi2zqtoBRVXJ/CayoqvvqWrcCKFeIKuY16MHhkcEpGkaXFnfrZWx7RvfavvKlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx4OyS7J; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd9d408040so1667975a12.0;
        Fri, 30 Aug 2024 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053120; x=1725657920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjhGtWVyzHYVhRPn36eiffIR2x+RtiSWrNsG8Mrh5aI=;
        b=gx4OyS7JQ8omb57b2XGZ7LlTbCODTClhsbeEb1L0roNSQ4cNWD+c6xxAGfHnLEHHU0
         /wHt4LelwQU2ScV1UpAxujB+eOGRAaa5W5ctHg1wIH41g6KGRZGtdEYYs3OWQ/Ko2WL4
         wR9HtlOh/y7Fj784l29zpcOI6WwaXO8ToctK5UYnW5mVOkqNVoC9JGionf5Qar0IsvHn
         bQPrVCbNmYykgvuqNclDWBbASxJRniSNEuAfGL4CknDHjcPq+o8+ryjjTr4P+hG3oGug
         qMZFL0fUceNsiXapC819xu1cen6q4vWvKmTu/Yd6ZfsJcIm59DWMrlFQE274aQzYnNbi
         Reaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053120; x=1725657920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjhGtWVyzHYVhRPn36eiffIR2x+RtiSWrNsG8Mrh5aI=;
        b=bwpIJtRjm9ZtkWpO7RPJ/Nheu58VzupTP9BAi9q7b4VLZhxXyqNZnafDdIFd7Ywqkt
         zHrNSaHlvDF8yyqeG6azwas41YE12H2uRbJuL0w49TY17Ub2lIFLhJHEyhAX+01ppq8N
         63MOhhCOCdyw3hwanouwogz0JaDeLydTkKJjwsyO9bgKMQ620oOYwPIDEk7Z+Q7yQhDH
         NzhKwa0JiyDGehC0/KmjMgNoPDAc4SzkvPmmFZXJjK1t51k8yssH0WvaNxm1GEwqSm4j
         m8/IOjBEpO1aICzgRNEtAUwujSrGHX58yk4MYQ+WaUbItVJzKJA0EdzusPYzTg6eHNoz
         GErg==
X-Forwarded-Encrypted: i=1; AJvYcCUKu08lk4LSQtMmy41qUIzIVRjYbw0NM+pMQx5StJP91LCIzKob4GHO2E2jtuV7RgyAI8CnFSFRhRxCNc5U4vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeBDuIlYdefCHKRErO63ezQ47PRxwjmBAobwkVJkBUEnKMnti
	dOfU4Ai+bPI07O10xg4fWLVB4BL7LTs38VkVQS3ZCXWYaZNtHpxyiMQMtsn4hxVZ7C178C0+byH
	BnwGpL7S71QKYD4yFIlLp66Ds0M0=
X-Google-Smtp-Source: AGHT+IGrSuaFjORQCyCkTOApwX5FUipaJYS6ZAehS8szyiT2ql2cNg6+o1iHxIkyQzLr2CmsD1hWxfNO3Ib/2ufUN4c=
X-Received: by 2002:a17:90b:524a:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d8564a50cbmr8589079a91.39.1725053119646; Fri, 30 Aug 2024
 14:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <895753fe6de5a06dee8ac110f0c05571db73e70c.1724976539.git.tony.ambardar@gmail.com>
In-Reply-To: <895753fe6de5a06dee8ac110f0c05571db73e70c.1724976539.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 14:25:07 -0700
Message-ID: <CAEf4BzbR+3Y7WoYCut-S_S7TEh8rna9033m3Ug9jw2Weff5tNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/8] libbpf: Support linking bpf objects of
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

On Fri, Aug 30, 2024 at 12:30=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
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
>  tools/lib/bpf/linker.c | 90 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 74 insertions(+), 16 deletions(-)
>

[...]

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

this shouldn't be checked here, it should be assumed this is valid and
was ensured by the caller. And make exec_sec_bswap() a void function,
please.

> +       for (i =3D 0; i < insn_cnt; i++, insn++)
> +               bpf_insn_bswap(insn);
> +       return 0;
> +}
> +
>  static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, st=
ruct src_sec *src)
>  {
>         void *tmp;
> @@ -1170,6 +1203,10 @@ static int extend_sec(struct bpf_linker *linker, s=
truct dst_sec *dst, struct src
>                 memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst=
->sec_sz);
>                 /* now copy src data at a properly aligned offset */
>                 memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, sr=
c->shdr->sh_size);
> +

the check for size % sizeof(struct bpf_insn) should be somewhere here
(if is_exec_sec()), right?

> +               /* convert added bpf insns to native byte-order */
> +               if (linker->swapped_endian && is_exec_sec(dst))
> +                       exec_sec_bswap(dst->raw_data + dst_align_sz, src-=
>shdr->sh_size);
>         }
>
>         dst->sec_sz =3D dst_final_sz;
> @@ -2630,6 +2667,10 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
>                 if (!sec->scn)
>                         continue;
>

but no need to check here, we know it's correct, if we got all the way here

> +               /* restore sections with bpf insns to target byte-order *=
/
> +               if (linker->swapped_endian && is_exec_sec(sec))
> +                       exec_sec_bswap(sec->raw_data, sec->sec_sz);
> +
>                 sec->data->d_buf =3D sec->raw_data;
>         }
>
> @@ -2698,6 +2739,7 @@ static int emit_elf_data_sec(struct bpf_linker *lin=
ker, const char *sec_name,
>
>  static int finalize_btf(struct bpf_linker *linker)
>  {
> +       enum btf_endianness link_endianness;
>         LIBBPF_OPTS(btf_dedup_opts, opts);
>         struct btf *btf =3D linker->btf;
>         const void *raw_data;
> @@ -2742,6 +2784,22 @@ static int finalize_btf(struct bpf_linker *linker)
>                 return err;
>         }
>
> +       /* Set .BTF and .BTF.ext output byte order */
> +       link_endianness =3D linker->elf_hdr->e_ident[EI_DATA] =3D=3D ELFD=
ATA2MSB ?
> +                         BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
> +       err =3D btf__set_endianness(linker->btf, link_endianness);
> +       if (err) {
> +               pr_warn("failed to set .BTF output endianness: %d\n", err=
);
> +               return err;
> +       }

link_endianness is always well-formed enum, there is no need to check
errors, here and for btf_ext__set_endianness, please drop both

> +       if (linker->btf_ext) {
> +               err =3D btf_ext__set_endianness(linker->btf_ext, link_end=
ianness);
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

