Return-Path: <linux-kselftest+bounces-6518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A99887B98
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 05:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE29A2822FA
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14C211C;
	Sun, 24 Mar 2024 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkRN0Y5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59B17C8;
	Sun, 24 Mar 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252867; cv=none; b=HGrq1nSAXSCzNf0Y8fEsK7Jh6+YvTuU9Obe1Bd9F6Ta2MnJfJZ2Sn24vz963TpbIeSjb+ns6NWCUGyX2IuZ25x6uEQSh8qqmxc3Gkf1XAgCqB7+njnFEHk0OJiIhC4WzjZYEBLh4tQU+xnMZqk8iXilo4k1Q0gneVSOqk8JhAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252867; c=relaxed/simple;
	bh=VxW0hTIU7/1Di972vVC2gKE9T8ENvKn/ReXtdbG5jm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QL1H8Il8EO5Lxnh74wj+R9i3hQaViZxanZ+hhas81ZtF/1xWU5gwOCvWH+I++ac1V3+jkfIztM2JcKCK0dgCXzwO6FKTMS7UdGYKAWPDSBaOhqNe4g1uEj0FXMA/Qe/crZdd2x0fB2MS/DssQOIrcmdl2v8CDztD3nZDHGMHvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkRN0Y5o; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a474d26fb41so43139266b.2;
        Sat, 23 Mar 2024 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711252864; x=1711857664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKH5gwVrOpXhIMHoIkhwahFI/xDXtpZdAl0Gq2TRalM=;
        b=WkRN0Y5oIFXOl+GSxcRIrAkOs4EZ4ILiymfOLlQe91eZfWyd/R4fm1e5KO5tzwpy/m
         ZjibjqjXC6zU49R3N8pR9P2vbxiXpm+0GQ7GkYjLf5l6ycrCGTCBJ1k5ZgS3Ks5LDpkV
         r5J7Pnx2tlGkktsz/FrB+jqxQtVK4KLhlnd5g/r/6tTpGWz8DPeKOqTCy+I5n/uXRs/P
         BkwN16j9P/J2PSo/8CP4vWRJI1Siv58Q/uEFcM99JUIWR4BUPOyJJq7BNBMMMWD++to2
         mA5HfqUtcWEi2my5uBqjHVKzq4tu8l+9dPICj3rdK0NE5PqmAADbRkGmJZl0Qg0UTQ6X
         PTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252864; x=1711857664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKH5gwVrOpXhIMHoIkhwahFI/xDXtpZdAl0Gq2TRalM=;
        b=e4nQaT1S+GlJ7MGpn9lMsigbcW2bLsZVTxq812/SAuWthCaWRKXVaW+Y8PB2C4kwZX
         zLy9/saX0tdp5Q38M7SgQgzOa88lyprZOFjjpJEyObAagT3AB7d2kdqBO3Ypp1pBFzT3
         0vpoxDzNH9tfdS2VZ67h/9ene4i56GHUb5D1qr7WP7bh3TksJ8Ph4dVD3z7FY3hSUDKr
         9U7LRV2xAjQ8pEtlJ0LWLYHwnSxtxFNRVZp+d4D2jMOe0YhSA7y8A99QHdomPVV44QdK
         QJqSHsyoiZWRXUZxo1ICFk6GL4i2VM09Yel4puJF7uUyWDqkMKDNFtpmoycMXcXSXM8t
         SzYA==
X-Forwarded-Encrypted: i=1; AJvYcCWzmJssuri4DsguaSDO1cHAyUm868wScs3K05ryWby3q/qU5zzz0f66Nx1w4gVfZRjEHjvyLesBcHkmWJUtsx8fqMng1A3hktjpJf9RQRVtjo3YYRazZN1xAD8DR3SjRJlbvQQIXeUN5QQXoKU+PW9YMFQ0gVcahTdNonzuM/2Amesn
X-Gm-Message-State: AOJu0YwUWiLE/GRS0I6KQHVevb+JqTn+8XEBUsAXK2s1XogSXs9okNS2
	N/Blt3nMgBFgyT1IG346mgYz3IjG7uroKLS2+BKpZnd5c/bJanGi3dxfGDs9VwkFjn21LtwRocq
	ZeA5vchlqAbr8aiBuCxIJf9xnY+jtHVQ09SJ6UQ==
X-Google-Smtp-Source: AGHT+IHVaNVEuHKdbDvrm9MtesOHqZTViEOaKTBB9MotZGaSpIx4FT6oCNP9LWUd/XiNYNECr1ZODpP1SsU5Idn0BgQ=
X-Received: by 2002:a17:907:72cb:b0:a47:496f:dacc with SMTP id
 du11-20020a17090772cb00b00a47496fdaccmr1733005ejc.5.1711252864152; Sat, 23
 Mar 2024 21:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org> <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
 <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
In-Reply-To: <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 24 Mar 2024 05:00:27 +0100
Message-ID: <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 at 04:53, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 9:31=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.org> w=
rote:
> > >
> > > We need to extend the bpf_timer API, but the way forward relies on kf=
uncs.
> > > So make bpf_timer known for kfuncs from the verifier PoV
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > >
> > > ---
> > >
> > > changes in v5:
> > > - also check for the reg offset
> > >
> > > changes in v4:
> > > - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
> > >
> > > new in v3 (split from v2 02/10)
> > > ---
> > >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 63749ad5ac6b..24a604e26ec7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -10826,6 +10826,7 @@ enum {
> > >         KF_ARG_LIST_NODE_ID,
> > >         KF_ARG_RB_ROOT_ID,
> > >         KF_ARG_RB_NODE_ID,
> > > +       KF_ARG_TIMER_ID,
> > >  };
> > >
> > >  BTF_ID_LIST(kf_arg_btf_ids)
> > > @@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
> > >  BTF_ID(struct, bpf_list_node)
> > >  BTF_ID(struct, bpf_rb_root)
> > >  BTF_ID(struct, bpf_rb_node)
> > > +BTF_ID(struct, bpf_timer_kern)
> > >
> > >  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
> > >                                     const struct btf_param *arg, int =
type)
> > > @@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(const s=
truct btf *btf, const struct btf_par
> > >         return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
> > >  }
> > >
> > > +static bool is_kfunc_arg_timer(const struct btf *btf, const struct b=
tf_param *arg)
> > > +{
> > > +       bool ret =3D __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_I=
D);
> > > +       return ret;
> > > +}
> > > +
> > >  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, cons=
t struct btf *btf,
> > >                                   const struct btf_param *arg)
> > >  {
> > > @@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
> > >         KF_ARG_PTR_TO_NULL,
> > >         KF_ARG_PTR_TO_CONST_STR,
> > >         KF_ARG_PTR_TO_MAP,
> > > +       KF_ARG_PTR_TO_TIMER,
> > >  };
> > >
> > >  enum special_kfunc_type {
> > > @@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> > >         if (is_kfunc_arg_map(meta->btf, &args[argno]))
> > >                 return KF_ARG_PTR_TO_MAP;
> > >
> > > +       if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> > > +               return KF_ARG_PTR_TO_TIMER;
> > > +
> > >         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids=
[base_type(reg->type)])) {
> > >                 if (!btf_type_is_struct(ref_t)) {
> > >                         verbose(env, "kernel function %s args#%d poin=
ter type %s %s is not supported\n",
> > > @@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> > >                 case KF_ARG_PTR_TO_CALLBACK:
> > >                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> > >                 case KF_ARG_PTR_TO_CONST_STR:
> > > +               case KF_ARG_PTR_TO_TIMER:
> > >                         /* Trusted by default */
> > >                         break;
> > >                 default:
> > > @@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_verif=
ier_env *env, struct bpf_kfunc_call_
> > >                         if (ret)
> > >                                 return ret;
> > >                         break;
> > > +               case KF_ARG_PTR_TO_TIMER:
> > > +                       if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > > +                               verbose(env, "arg#%d doesn't point to=
 a map value\n", i);
> > > +                               return -EINVAL;
> > > +                       }
> > > +                       if (reg->off) {
> > > +                               verbose(env, "arg#%d offset can not b=
e greater than 0\n", i);
> > > +                               return -EINVAL;
> > > +                       }
> >
> > This won't be correct. You don't really check whether the timer exists
> > at reg->off (and if you did, this would still restrict it to 0 offset,
> > and not check the variable offset which would be non-zero). What I
> > would suggest is calling process_timer_func (see how dynptr calls the
> > same underlying process_dynptr_func to enforce type invariants). This
> > would allow sharing the same checks and avoid bugs from creeping in.
> > It does all checks wrt constant/variable offset and looking up the
> > timer field offset and matching it against the one in the pointer.
>
> Observation is correct. The patch is buggy,
> but the suggestion to follow process_dynptr_func() will lead
> to unnecessary complexity.
> dynptr-s are on stack with plenty of extra checks.

The suggestion was to call process_timer_func, not process_dynptr_func.

> In this case bpf_timer is in map_value.
> Much simpler is to follow KF_ARG_PTR_TO_MAP approach.

What I meant by the example was that dynptr handling does the same
thing for kfuncs and helpers (using the same function), so timer
arguments should do the same (i.e. use process_timer_func), which will
do all checks for constant offset (ensuring var_off is tnum_is_const)
and match it against btf_record->timer_off.

> [...]

