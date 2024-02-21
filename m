Return-Path: <linux-kselftest+bounces-5127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186185CE95
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 04:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D681F24C50
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66E383BF;
	Wed, 21 Feb 2024 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aPoMeI13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C22B9DD
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484986; cv=none; b=k4gB9VUffbBnPLeYzFn0jh55kFkV1OmntFluatENweStWO4EfJJy3txPs3LUU8igGp/eQDWcUOFKGTMw9oEXtPaQGF5GSB9NHf5i+agP5Bm+Pv3mznB2GaJrw6pin3esLIjbttAsoTvzS5k9qw4pr07HbMAIGCfK0VfNJB9fQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484986; c=relaxed/simple;
	bh=eVJKhbDl282YAD6eGBJ0Hq2ZAxNMnXe/FenergvqHCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBUyBCH/q4M6nFPNghNDcXX6DzDRuyEFZ40gbtAyy9S+iQDYxxdgtmSEVpeBixT6lA2EfFE7bhTAVGbYt8JuaRNxZATISRl+rj2ZAwWWzuz3M3IrdbtUt0PHixLxPXZ/EpXcauoejbK5uUWU74pdZr7tJP+z+Xl0jVE+87fvh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aPoMeI13; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299b55f2344so1833489a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 19:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708484983; x=1709089783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9JAFBuaoAQzz3cyLyvinoNXI6OgqQmkxSp6hvS7uuM=;
        b=aPoMeI13SGIQNaluvdUMAm1mASqjAvrUn8XXIrgyu+SydeOpi6TKI0tY2wfB5C3xMH
         8brapFtLOFCBR0J09+D9V0Fi8Jr2v2XJv6trbRFdBUklmiAgGw6A7ZjoeUuU9fPRg24+
         s2mMIvdiKT3G6kZaUyHKbMCsjeF7vWSEsY+AjNgarwxwcr6JTe9pqhr+dtBoL43ggBkz
         6dtwCGlbWxc+by37C98pGovI4jXzpo5n8nK2EOHF1lIhV8UjD+S5l4ItzubrlbF0Idx6
         yoy2yUqysYhI/5J3ET9y1TaA2v0Jva/6jMoVOtvdfYLO3a/oZfyO5TO4mg9vcJdnyeVT
         79mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484983; x=1709089783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9JAFBuaoAQzz3cyLyvinoNXI6OgqQmkxSp6hvS7uuM=;
        b=bJx/sQUYnVPsRD5376z5+o0I4EZy92g3S6LxIA3VEBYiqJvyormN+rv4KyyFmqiT4G
         fsb8M2QRnt8r7ZNCK5VtPZJznulY+zNp4xA2GZrH2e4s5FxIblWlB9Se0AGZ9rS1xNBE
         1mcGwH91q3Bb0s5dkU3spcCCtrUvrcSby2YiLtDoH24k/avS4X0DaCw2FbLQLUAZz2ob
         dVM2rl+ywDpCndq3aE5cLLMMHAsBiVEKc6kISGwN4FKuNInyePL32NL+/+s10kv6DfeU
         1QRntiZ5KcLjBW10shi9+eC8wp3xlqoxSW3FuGe2X0mSetluFRnmZfu7umy849q2hq8u
         3n6w==
X-Forwarded-Encrypted: i=1; AJvYcCVi96zy/b+wGlXWpaEGzH9mNf+14dmUtjia0pZOfjvSZKNzVVMk/y9vgWxgZPSNgStTv7B5884D4jQn1MZZXl/Pqvqlyf1NRLluvpSs4yF8
X-Gm-Message-State: AOJu0Yyq0ejKiIeYr7cJ86xE5jxOX2x4KFupfa3PN7PL3kMGhpsblYIi
	ZSq47vPLsX4oHGCojmYQTDjwAFQDJvXx5fr7fuJvkpwXoWAINevQBrQr/P0hq5afaiwuSPv+jY3
	nMnQHzd6Y9z/n9OZ9YV8eu2uqU9WEz8NMAj1NXA==
X-Google-Smtp-Source: AGHT+IGz6pr/9xNn3AU5WmkiQvLLrCB/3YS0FkJtcuzGRfTXJQty26y06k1HPX8yIQMnSm9glOLnmX0UnQT9ooeohxs=
X-Received: by 2002:a17:90a:d197:b0:299:7848:7193 with SMTP id
 fu23-20020a17090ad19700b0029978487193mr5707892pjb.45.1708484982682; Tue, 20
 Feb 2024 19:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <20240220035105.34626-2-dongmenglong.8@bytedance.com> <81431b5d-0e0f-485a-a3ce-af8e63169552@gmail.com>
In-Reply-To: <81431b5d-0e0f-485a-a3ce-af8e63169552@gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 11:09:31 +0800
Message-ID: <CALz3k9io7c6oGvCjfYr=1kb6Ndrh6RVgR5pHC5DzW-F_YGqjxA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 1/5] bpf: tracing: add support to
 record and check the accessed args
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	thinker.li@gmail.com, zhoufeng.zf@bytedance.com, davemarchevsky@fb.com, 
	dxu@dxuuu.xyz, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:22=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/19/24 19:51, Menglong Dong wrote:
> > In this commit, we add the 'accessed_args' field to struct bpf_prog_aux=
,
> > which is used to record the accessed index of the function args in
> > btf_ctx_access().
> >
> > Meanwhile, we add the function btf_check_func_part_match() to compare t=
he
> > accessed function args of two function prototype. This function will be
> > used in the following commit.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >   include/linux/bpf.h |   4 ++
> >   kernel/bpf/btf.c    | 121 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 125 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c7aa99b44dbd..0225b8dbdd9d 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1464,6 +1464,7 @@ struct bpf_prog_aux {
> >       const struct btf_type *attach_func_proto;
> >       /* function name for valid attach_btf_id */
> >       const char *attach_func_name;
> > +     u64 accessed_args;
> >       struct bpf_prog **func;
> >       void *jit_data; /* JIT specific data. arch dependent */
> >       struct bpf_jit_poke_descriptor *poke_tab;
> > @@ -2566,6 +2567,9 @@ struct bpf_reg_state;
> >   int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
> >   int btf_check_type_match(struct bpf_verifier_log *log, const struct b=
pf_prog *prog,
> >                        struct btf *btf, const struct btf_type *t);
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*t1,
> > +                           struct btf *btf2, const struct btf_type *t2=
,
> > +                           u64 func_args);
> >   const char *btf_find_decl_tag_value(const struct btf *btf, const stru=
ct btf_type *pt,
> >                                   int comp_idx, const char *tag_key);
> >   int btf_find_next_decl_tag(const struct btf *btf, const struct btf_ty=
pe *pt,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6ff0bd1a91d5..3a6931402fe4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6203,6 +6203,9 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >               /* skip first 'void *__data' argument in btf_trace_##name=
 typedef */
> >               args++;
> >               nr_args--;
> > +             prog->aux->accessed_args |=3D (1 << (arg + 1));
> > +     } else {
> > +             prog->aux->accessed_args |=3D (1 << arg);
> >       }
> >
> >       if (arg > nr_args) {
> > @@ -7010,6 +7013,124 @@ int btf_check_type_match(struct bpf_verifier_lo=
g *log, const struct bpf_prog *pr
> >       return btf_check_func_type_match(log, btf1, t1, btf2, t2);
> >   }
> >
> > +static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_ty=
pe *t)
> > +{
> > +     const struct btf_param *args;
> > +     u32 size =3D 0, nr_args;
> > +     int i;
> > +
> > +     nr_args =3D btf_type_vlen(t);
> > +     args =3D (const struct btf_param *)(t + 1);
> > +     for (i =3D 0; i < nr_args; i++) {
> > +             t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +             size +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +     }
> > +
> > +     return size;
> > +}
> > +
> > +static int get_ctx_arg_idx_aligned(struct btf *btf, const struct btf_t=
ype *t,
> > +                                int off)
> > +{
> > +     const struct btf_param *args;
> > +     u32 offset =3D 0, nr_args;
> > +     int i;
> > +
> > +     nr_args =3D btf_type_vlen(t);
> > +     args =3D (const struct btf_param *)(t + 1);
> > +     for (i =3D 0; i < nr_args; i++) {
> > +             if (offset =3D=3D off)
> > +                     return i;
> > +
> > +             t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +             offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +             if (offset > off)
> > +                     return -1;
> > +     }
> > +     return -1;
> > +}
>
> This one is very similar to get_ctx_arg_idx().
> How about to refactor get_ctx_arg_idx() and share the code
> between get_ctx_arg_idx() and get_ctx_arg_idx_aligned().
>

This seems to work, I'll combine them in the next version.

Thanks for the example code!
Menglong Dong

> For example,
>
> -static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> -                          int off)
> +static u32 _get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> +                          int off, u32 *arg_off)
>   {
>          const struct btf_param *args;
>          const struct btf_type *t;
>          u32 offset =3D 0, nr_args;
>          int i;
>
>          if (!func_proto)
>                  return off / 8;
>
>          nr_args =3D btf_type_vlen(func_proto);
>          args =3D (const struct btf_param *)(func_proto + 1);
>          for (i =3D 0; i < nr_args; i++) {
> +               if (arg_off)
> +                       *arg_off =3D offset;
>                  t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>                  offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8)=
;
>                  if (off < offset)
>                          return i;
>          }
>
> +       if (arg_off)
> +               *arg_off =3D offset;
>          t =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
>          offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
>          if (off < offset)
>                  return nr_args;
>
>          return nr_args + 1;
>   }
>
> +static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> +                          int off)
> +{
> +       return _get_ctx_arg_idx(btf, func_proto, off, NULL);
> +}
> +
> +static u32 get_ctx_arg_idx_aligned(struct btf *btf,
> +                                  const struct btf_type *func_proto,
> +                                  int off)
> +{
> +       u32 arg_off;
> +       u32 arg_idx =3D _get_ctx_arg_idx(btf, func_proto, off, &arg_off);
> +       return arg_off =3D=3D off ? arg_idx : -1;
> +}
> +
>
> > +
> > +/* This function is similar to btf_check_func_type_match(), except tha=
t it
> > + * only compare some function args of the function prototype t1 and t2=
.
> > + */
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*func1,
> > +                           struct btf *btf2, const struct btf_type *fu=
nc2,
> > +                           u64 func_args)
> > +{
> > +     const struct btf_param *args1, *args2;
> > +     u32 nargs1, i, offset =3D 0;
> > +     const char *s1, *s2;
> > +
> > +     if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(fun=
c2))
> > +             return -EINVAL;
> > +
> > +     args1 =3D (const struct btf_param *)(func1 + 1);
> > +     args2 =3D (const struct btf_param *)(func2 + 1);
> > +     nargs1 =3D btf_type_vlen(func1);
> > +
> > +     for (i =3D 0; i <=3D nargs1; i++) {
> > +             const struct btf_type *t1, *t2;
> > +
> > +             if (!(func_args & (1 << i)))
> > +                     goto next;
> > +
> > +             if (i < nargs1) {
> > +                     int t2_index;
> > +
> > +                     /* get the index of the arg corresponding to args=
1[i]
> > +                      * by the offset.
> > +                      */
> > +                     t2_index =3D get_ctx_arg_idx_aligned(btf2, func2,
> > +                                                        offset);
> > +                     if (t2_index < 0)
> > +                             return -EINVAL;
> > +
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, args2[t2_ind=
ex].type,
> > +                                                  NULL);
> > +             } else {
> > +                     /* i =3D=3D nargs1, this is the index of return v=
alue of t1 */
> > +                     if (get_ctx_arg_total_size(btf1, func1) !=3D
> > +                         get_ctx_arg_total_size(btf2, func2))
> > +                             return -EINVAL;
> > +
> > +                     /* check the return type of t1 and t2 */
> > +                     t1 =3D btf_type_skip_modifiers(btf1, func1->type,=
 NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, func2->type,=
 NULL);
> > +             }
> > +
> > +             if (t1->info !=3D t2->info ||
> > +                 (btf_type_has_size(t1) && t1->size !=3D t2->size))
> > +                     return -EINVAL;
> > +             if (btf_type_is_int(t1) || btf_is_any_enum(t1))
> > +                     goto next;
> > +
> > +             if (btf_type_is_struct(t1))
> > +                     goto on_struct;
> > +
> > +             if (!btf_type_is_ptr(t1))
> > +                     return -EINVAL;
> > +
> > +             t1 =3D btf_type_skip_modifiers(btf1, t1->type, NULL);
> > +             t2 =3D btf_type_skip_modifiers(btf2, t2->type, NULL);
> > +             if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
> > +                     return -EINVAL;
> > +
> > +on_struct:
> > +             s1 =3D btf_name_by_offset(btf1, t1->name_off);
> > +             s2 =3D btf_name_by_offset(btf2, t2->name_off);
> > +             if (strcmp(s1, s2))
> > +                     return -EINVAL;
> > +next:
> > +             if (i < nargs1) {
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     offset +=3D btf_type_is_ptr(t1) ? 8 : roundup(t1-=
>size, 8);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf=
_type *t)
> >   {
> >       const char *name;

