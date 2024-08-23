Return-Path: <linux-kselftest+bounces-16177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1595D633
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB5282608
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED41917F2;
	Fri, 23 Aug 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhf4RmM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3B77104;
	Fri, 23 Aug 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442478; cv=none; b=W62IuCcapAhGw/A2WKIYOn/EAJUPWUXpbLvHEx4+g1S8jgxHW1GXTNZDVd/XJFQpQ/InPo9VeE0KXxSU27NyDlHP5dojkCMXY5c9r6bfJ8Sxtynu5QTgpliL9DBT+L2Qi/vL5wHzu73ZI/paCyV94tEHaTcif4S/gS/8HScC4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442478; c=relaxed/simple;
	bh=LFaNhVn65d/WGBzOr5dd76bsfnUDfeu0eogfazmv5yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS1oxAhvlc9e3u7eTn46B0cD6Uh6RVldA0aRxOo0TuliRpN9MskqD/b/ieioK99FMYKWGxa/8oZJ/8Mb/qgM8c/II0/vC3jEp3cP4Wb39LxBnVQFc46L9b9ekrig9EZfV8IcKmQWDHU5KjK2OozHGxhTNijiyeRJHqjMpolXhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhf4RmM+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7163489149eso1421504a12.1;
        Fri, 23 Aug 2024 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442476; x=1725047276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d983a5evamlu8aN7ZetTbrPw7uROiRNNHm7X7WRRMe8=;
        b=bhf4RmM+lhdMpQgjI8xnXJ439TlvDodOl2rlBhRzOWyOWmTsPUjrpjhKvFnGE90h5y
         0fWz72RiuNZxIElG67y9Vm7VARTjBhmYUz1htKI2GDUcjj3TnD4oLF7KgF4LJQjmT8Jy
         x1fo/BI/1hICkh1bR5PxS6DTYP8i9XyRHFjkn8iiaZVU70qnLh/C9XCqi0cHFN9BPK5C
         ee5MbN1Cj+JUCzR9yduKZKqplvV0tMd2Cq6toeIFE0gNGqDN0WpZdLPAhHAWD71np2O1
         ZMtx/MUaxZYa8QuVzRt9TIzfyr/k22RWmmjM6xIdUZrBg0EI8sE9H62LdPBMbACq5Ajm
         ZWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442476; x=1725047276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d983a5evamlu8aN7ZetTbrPw7uROiRNNHm7X7WRRMe8=;
        b=aItm/IZZzt69Bw9uyKB2y7VoDRjK5Xgr5aMD3ruwQj2mI7dH4iUSp1klWLCW7UlJUC
         qglACDThZQJXUUL6oOfAClObE08AYtywWG17Xsi3QeuzPnBGkpte88iSzMqCoMvvTR6G
         JV0Z0rleAOoDbI7WcD0J6ubtVZHqzWfU04xCreJihLkbM+bGRN+P1kv1xzZzbrH/3KfB
         uzVgkMjExJJJCTfpzXCrmQYhXTa3eh7GBcx4T0ThZohhF58srn3BHZT1yW/2MJA0+Vtp
         VRXLkpLXjGZXyfUbi/9xacJJ7Rm6RlAYr45EUtwafnNe8pW4V7byL9+ujzuzzkAq+JUM
         F21A==
X-Forwarded-Encrypted: i=1; AJvYcCXnHOpvGVZBVsN9ysFhUtqt9joMxQybBJFjqEs7zabMdaFloEHJHLyuyuJGVFymIMihtHref2K3b+eZlNtUYxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tT7R3TcRyUHyrXU9R4Eprhu3dj3bZ2Nz36OYTRMOTHy9pvmF
	er5qXv7+L7RleFSf8wI4ltJTT995I8BEKQTmPoPaxdnAWa4sWy4hFmMeXcHuTiiguUUwWvQRA7T
	x3fSAm83xsebgs9ng5OnHEGhHzf8=
X-Google-Smtp-Source: AGHT+IF/LH7+qXZ24ZQvJmWQupHogmzNfiEoihSyQ/GZnnKvSKpX1JgCymuSDosJpXH+gAiObnOPLsF5yCC9P3zMUTI=
X-Received: by 2002:a17:90a:3047:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2d646bf0e04mr3353843a91.20.1724442475856; Fri, 23 Aug 2024
 12:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <bf9275e2af357f287bc4d37dd9b43a1f8be33ef7.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzbaMbAkiRQrtOW8+4Bx0e4ahu+hAE5dVDwdPU952wusDg@mail.gmail.com>
In-Reply-To: <CAEf4BzbaMbAkiRQrtOW8+4Bx0e4ahu+hAE5dVDwdPU952wusDg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 12:47:42 -0700
Message-ID: <CAEf4BzYkTkPvy3KdeW1YSK19Of+GEvvTA8Wqqha37ozmDmU88Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
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

On Thu, Aug 22, 2024 at 4:36=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I ran out of time looking through this, I'll try to get back to this
> patch set later today or tomorrow. So please don't repost, but see my
> comments below.
>
> On Thu, Aug 22, 2024 at 2:25=E2=80=AFAM Tony Ambardar <tony.ambardar@gmai=
l.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Support for handling BTF data of either endianness was added in [1], bu=
t
> > did not include BTF.ext data for lack of use cases. Later, support for
> > static linking [2] provided a use case, but this feature and later ones
> > were restricted to native-endian usage.
> >
> > Add support for BTF.ext handling in either endianness. Convert BTF.ext =
data
> > to native endianness when read into memory for further processing, and
> > support raw data access that restores the original byte-order for outpu=
t.
> >
> > Add new API functions btf_ext__endianness() and btf_ext__set_endianness=
()
> > for query and setting byte-order, as already exist for BTF data.
> >
> > [1]:commit 3289959b97ca ("libbpf: Support BTF loading and raw data outp=
ut in both endianness")
> > [2]:commit 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext=
 support")
>
> Is this some standard syntax to refer to commit? If not, maybe drop
> ":commit" parts?
>
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c             | 163 ++++++++++++++++++++++++++++++--
> >  tools/lib/bpf/btf.h             |   3 +
> >  tools/lib/bpf/libbpf.map        |   2 +
> >  tools/lib/bpf/libbpf_internal.h |   2 +
> >  4 files changed, 161 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index cf4f7bd7ff5c..cb4ee4ed4b5c 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2884,6 +2884,52 @@ int btf__add_decl_tag(struct btf *btf, const cha=
r *value, int ref_type_id,
> >         return btf_commit_type(btf, sz);
> >  }
> >
> > +/*
> > + * Swap endianness of the info segment in a BTF.ext data section:
> > + *   - requires BTF.ext header data in native byte order
> > + *   - expects info record fields are 32-bit
> > + */
> > +static int btf_ext_bswap_info(void *data, const __u32 data_size)
>
> pass btf_ext_header (in native endianness) as input argument
>
> > +{
> > +       const struct btf_ext_header *hdr =3D data;
> > +       __u32 info_size, sum_len, i, *p;
> > +
> > +       if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
> > +               pr_warn("BTF.ext initial header not found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (data_size < hdr->hdr_len) {
> > +               pr_warn("BTF.ext header not found\n");
> > +               return -EINVAL;
> > +       }
>
> and we already checked this, no?
>
> > +
> > +       if (hdr->hdr_len < offsetofend(struct btf_ext_header, line_info=
_len)) {
> > +               pr_warn("BTF.ext header missing func_info, line_info\n"=
);
> > +               return -EINVAL;
> > +       }
>
> we have this check in btf_ext__new() already, do the swap after we
> validated this and keep this function simpler and more focused. You
> are mixing sanity checks with byte swapping, it's confusing.
>
> > +
> > +       sum_len =3D hdr->func_info_len + hdr->line_info_len;
> > +       if (hdr->hdr_len >=3D offsetofend(struct btf_ext_header, core_r=
elo_len))
> > +               sum_len +=3D hdr->core_relo_len;
> > +
> > +       info_size =3D data_size - hdr->hdr_len;
> > +       if (info_size !=3D sum_len) {
> > +               pr_warn("BTF.ext info size mismatch with header data\n"=
);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (info_size && info_size % sizeof(__u32)) {
> > +               pr_warn("BTF.ext info size not 32-bit multiple\n");
> > +               return -EINVAL;
> > +       }
>
> same as above, all this has nothing to do with endianness, it's all
> sanity checks. Let's extract them into a separate validation function
> that can happen before byte swap.
>
> > +
> > +       p =3D data + hdr->hdr_len;
> > +       for (i =3D 0; i < info_size / sizeof(__u32); i++, p++)
> > +               *p =3D bswap_32(*p);
>
> this is very suspicious, it might work right now because all fields
> are u32, but I'm uncomfortable making these decision.
>
> I think for byte swapping case we need to make sure that BTF version
> is exactly known to us (i.e., all record length is knowable for us),
> and then do more verbose, but correct byte swap based on
> bpf_func_info/bpf_line_info/etc records. Just treating all this as u32
> is not great.
>
> > +       return 0;
> > +}
> > +
> >  struct btf_ext_sec_setup_param {
> >         __u32 off;
> >         __u32 len;
> > @@ -3023,24 +3069,56 @@ static int btf_ext_setup_core_relos(struct btf_=
ext *btf_ext)
> >         return btf_ext_setup_info(btf_ext, &param);
> >  }
> >
> > -static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> > +/* Swap byte-order of BTF.ext header */
> > +static void btf_ext_bswap_hdr(struct btf_ext_header *h)
> >  {
> > -       const struct btf_ext_header *hdr =3D (struct btf_ext_header *)d=
ata;
> > +       __u32 hdr_len =3D h->hdr_len; /* need native byte-order */
> >
> > -       if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
> > -           data_size < hdr->hdr_len) {
> > -               pr_debug("BTF.ext header not found\n");
> > +       if (h->magic =3D=3D bswap_16(BTF_MAGIC))
> > +               hdr_len =3D bswap_32(hdr_len);
>
> why so complicated? just pass hdr_len as input argument into
> btf_ext_bswap_hdr(), and then uniformly swap everything, no
> double-checking of decisions we already made
>
> > +
> > +       h->magic =3D bswap_16(h->magic);
> > +       h->hdr_len =3D bswap_32(h->hdr_len);
> > +       h->func_info_off =3D bswap_32(h->func_info_off);
> > +       h->func_info_len =3D bswap_32(h->func_info_len);
> > +       h->line_info_off =3D bswap_32(h->line_info_off);
> > +       h->line_info_len =3D bswap_32(h->line_info_len);
> > +
> > +       if (hdr_len < offsetofend(struct btf_ext_header, core_relo_len)=
)
> > +               return;
> > +
> > +       h->core_relo_off =3D bswap_32(h->core_relo_off);
> > +       h->core_relo_len =3D bswap_32(h->core_relo_len);
> > +}
> > +
> > +static int btf_ext_parse_hdr(struct btf_ext *btf_ext)
> > +{
> > +       struct btf_ext_header *hdr =3D btf_ext->hdr;
> > +       __u32 hdr_len, data_size =3D btf_ext->data_size;
> > +
> > +       if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
> > +               pr_debug("BTF.ext initial header not found\n");
>
> "BTF.ext header too short" ?
>
> >                 return -EINVAL;
> >         }
> >
> > +       hdr_len =3D hdr->hdr_len;
> >         if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> > -               pr_warn("BTF.ext in non-native endianness is not suppor=
ted\n");
> > -               return -ENOTSUP;
> > +               btf_ext->swapped_endian =3D true;
> > +               hdr_len =3D bswap_32(hdr_len);
> >         } else if (hdr->magic !=3D BTF_MAGIC) {
> >                 pr_debug("Invalid BTF.ext magic:%x\n", hdr->magic);
> >                 return -EINVAL;
> >         }
> >
> > +       if (data_size < hdr_len) {
> > +               pr_debug("BTF.ext header not found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Maintain native byte-order in memory for introspection */
> > +       if (btf_ext->swapped_endian)
> > +               btf_ext_bswap_hdr(hdr);
> > +
> >         if (hdr->version !=3D BTF_VERSION) {
> >                 pr_debug("Unsupported BTF.ext version:%u\n", hdr->versi=
on);
> >                 return -ENOTSUP;
> > @@ -3067,6 +3145,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
> >         free(btf_ext->line_info.sec_idxs);
> >         free(btf_ext->core_relo_info.sec_idxs);
> >         free(btf_ext->data);
> > +       free(btf_ext->data_swapped);
> >         free(btf_ext);
> >  }
> >
> > @@ -3087,7 +3166,12 @@ struct btf_ext *btf_ext__new(const __u8 *data, _=
_u32 size)
> >         }
> >         memcpy(btf_ext->data, data, size);
> >
> > -       err =3D btf_ext_parse_hdr(btf_ext->data, size);
> > +       err =3D btf_ext_parse_hdr(btf_ext);
> > +       if (err)
> > +               goto done;
> > +
> > +       if (btf_ext->swapped_endian)
> > +               err =3D btf_ext_bswap_info(btf_ext->data, btf_ext->data=
_size);
> >         if (err)
> >                 goto done;
>
> nit:
>
> if (btf_ext->swapped_endian) {
>     err =3D ...;
>     if (err)
>         goto done;
> }
>
> i.e., keep error handling close and at the same nesting level
>
> >
> > @@ -3120,15 +3204,76 @@ struct btf_ext *btf_ext__new(const __u8 *data, =
__u32 size)
> >         return btf_ext;
> >  }
> >
> > +static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 =
*size,
> > +                             bool swap_endian)
> > +{
> > +       struct btf_ext *btf_ext =3D (struct btf_ext *)btf_ext_ro;
> > +       const __u32 data_sz =3D btf_ext->data_size;
> > +       void *data;
> > +       int err;
> > +
> > +       data =3D swap_endian ? btf_ext->data_swapped : btf_ext->data;
> > +       if (data) {
> > +               *size =3D data_sz;
> > +               return data;
> > +       }
> > +
> > +       data =3D calloc(1, data_sz);
> > +       if (!data)
> > +               return NULL;
> > +       memcpy(data, btf_ext->data, data_sz);
> > +
> > +       if (swap_endian) {
> > +               err =3D btf_ext_bswap_info(data, data_sz);
> > +               if (err) {
> > +                       free(data);
> > +                       return NULL;
> > +               }
> > +               btf_ext_bswap_hdr(data);
> > +               btf_ext->data_swapped =3D data;
> > +       }
> > +
> > +       *size =3D data_sz;
> > +       return data;
> > +}
> > +
> >  const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *si=
ze)
> >  {
> > +       __u32 data_sz;
> > +       void *data;
> > +
> > +       data =3D btf_ext_raw_data(btf_ext, &data_sz, btf_ext->swapped_e=
ndian);
> > +       if (!data)
> > +               return errno =3D ENOMEM, NULL;
> > +
> >         *size =3D btf_ext->data_size;
> > -       return btf_ext->data;
> > +       return data;
> >  }
> >
> >  __attribute__((alias("btf_ext__raw_data")))
> >  const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32=
 *size);
> >
> > +enum btf_endianness btf_ext__endianness(const struct btf_ext *btf_ext)
> > +{
> > +       return (is_host_big_endian() !=3D btf_ext->swapped_endian) ?
> > +               BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
> > +}

nit: this looks correct, but I'd prefer consistency with
btf__endianness() in terms of implementation, if you don't mind

> > +
> > +int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianne=
ss endian)
> > +{
> > +       bool is_tgt_big_endian =3D (endian =3D=3D BTF_BIG_ENDIAN);
> > +
> > +       if (endian !=3D BTF_LITTLE_ENDIAN && endian !=3D BTF_BIG_ENDIAN=
)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       btf_ext->swapped_endian =3D (is_host_big_endian() !=3D is_tgt_b=
ig_endian);

nit: any reason you didn't just stick to the same style as in
btf__set_endianness()? you clearly took that as an inspiration. Were
you worried about crossing the 80 characters boundary? Don't be, the
limit is 100 characters. Anyways, unnecessary () and I'd inline
is_tgt_big_endian given it's single use.


> > +
> > +       if (!btf_ext->swapped_endian) {
> > +               free(btf_ext->data_swapped);
> > +               btf_ext->data_swapped =3D NULL;
> > +       }
> > +       return 0;
> > +}
> >
> >  struct btf_dedup;
> >
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index b68d216837a9..e3cf91687c78 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -167,6 +167,9 @@ LIBBPF_API const char *btf__str_by_offset(const str=
uct btf *btf, __u32 offset);
> >  LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
> >  LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
> >  LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext=
, __u32 *size);
> > +LIBBPF_API enum btf_endianness btf_ext__endianness(const struct btf_ex=
t *btf_ext);
> > +LIBBPF_API int btf_ext__set_endianness(struct btf_ext *btf_ext,
> > +                                      enum btf_endianness endian);
> >
> >  LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
> >  LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8f0d9ea3b1b4..5c17632807b6 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -421,6 +421,8 @@ LIBBPF_1.5.0 {
> >         global:
> >                 btf__distill_base;
> >                 btf__relocate;
> > +               btf_ext__endianness;
> > +               btf_ext__set_endianness;
> >                 bpf_map__autoattach;
> >                 bpf_map__set_autoattach;
> >                 bpf_program__attach_sockmap;
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index 8cda511a1982..6b0270c83537 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -484,6 +484,8 @@ struct btf_ext {
> >                 struct btf_ext_header *hdr;
> >                 void *data;
> >         };
> > +       void *data_swapped;
> > +       bool swapped_endian;
> >         struct btf_ext_info func_info;
> >         struct btf_ext_info line_info;
> >         struct btf_ext_info core_relo_info;
> > --
> > 2.34.1
> >

