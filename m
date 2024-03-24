Return-Path: <linux-kselftest+bounces-6517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06B887B92
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 04:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567FE282219
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8FE1C05;
	Sun, 24 Mar 2024 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF+Q4iQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1917F5;
	Sun, 24 Mar 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252413; cv=none; b=MBt+nUsAYs7hbvCxpmqxtdBm0nW0RvjIpY/pTtH+8GxtI5ktTkRhaXm09ddvijB/rkCBkPCn1jV8d6qpjb1UXJjTQvKAEm/mxZhwSK2htyxskTCn4ReNvxzvLH7Hs5F+iBeThsF6WCERZYlZAFyV3JWjf/tMfAVPTSMMRH0mp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252413; c=relaxed/simple;
	bh=AlRmmQeVDpR7lhkl0NgJoUadOzHLH0O8B+vplE8G7EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDDwsyI1QdDjATn4eskyB2vAoq4JplcLVgEuNvqI0uzfSIe3b/HvCIZbPzbx62M34inXdicnT9Wji7b2va67hYRzcWvo/Us6Y9AkRhdTqutKXVFDrIC/wnEbi6Vj/oYq1VIKRU+j4FvBTriM+A615ksdo66YM3/i/I3/BGygx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF+Q4iQX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso2231374f8f.1;
        Sat, 23 Mar 2024 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711252409; x=1711857209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1vERHDjQTdDqBz7KqXEq1TPmE/mhc/qMX+GQMq+CEo=;
        b=DF+Q4iQXnipj+sShZCSRUq3s1osYEP3h4W3Ef3IgEFaIBKo+WyUmwQiCX/ssEsII5F
         OpKpEAzuj7MF+0LON9nSaHVcq6QMjt1vDzgWuhDFM3sV4kUYhMh7gpkI94snU6HOz4Gz
         ePeRC7wA5Xdt7bfwksjdrQYXI8dTYQkeqZ1OLlsb5AHhrvEOx2oQPeoh4KNzedvkgcs5
         7znKoDIGgOgktFNEHj5f2QuvSagOxx3c4COBjQKur74bYpuShWguCmeJ4ZFSbk6DJsvj
         NupkvcBz+H5wZxWQPKyUlaylY0Y+S+pIxDll+ECMW7RlDlKyW8TlcUsuzriqycs6zegX
         uyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252409; x=1711857209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1vERHDjQTdDqBz7KqXEq1TPmE/mhc/qMX+GQMq+CEo=;
        b=CoPheld6My8PvS6NSIJjUCcFI2wZixkSk2J68YYegs0hoOuzrmtwDx2Osja1hlJGQ/
         Vxaggj7TUXcVRtnwIl4un0ZR7ovLG7rDaaIgbv9QbuGOXo/p/sZ85fgl4WBIfCLQjzXK
         zIBq6bXO/FKXxCkCXMi7iwxsQ/Lp5IG7l/RHj4+0t1G3yh+zx32GjDZTDzJUJhEGmHO4
         JoNrGHNGhGRJ6IN06+HAZQHFzDB/JvU/AyDFOBo0GWTePPvRSx3UjPtdQf805hHM8TTm
         14Og7Scda8SYYfennCAyAS21+fLpkY5/Eo4CnwZ1aMgaixX1aXRYhBYGsVrFcytXFfu6
         gAmg==
X-Forwarded-Encrypted: i=1; AJvYcCXA0vkGriadeIaH2sBo8kVPn8ET0gSKMoYKl1naxSD+U9jq2Lzrs2/i5qRhuc0LSlRV/fdLU6kX4mgL8P4WaROCqpd3l+1hJKHtydtX2uzxY12iENVb0m+Lam4tNcf5eGb9K52twGK451j2bkOMDXOwWZjLD7Z8YkCbI0uRrP8AAV6A
X-Gm-Message-State: AOJu0Yz4b/T79WRtQ6lWGaiFOc13011uL0eIMJqFxnPZtgQJEhfVlFis
	353rL4TssNtr6TDyQR2ChijtaGntFgUO/FqToSnS0WH+Cf7hXkWIB7DLpVfRuoXmoAzBjKi1iRr
	3vyNZsP+C8tSsHeaOmfdKqSTOJEU=
X-Google-Smtp-Source: AGHT+IH40dCOTL7gZfoPcdy3oSQyvlO6tK/QyFZjDGnxFFgLHK2UTj3rIkCT6DMabVQThNF/ubagCse5hrwan3A/VEY=
X-Received: by 2002:a05:6000:4cf:b0:341:984d:e389 with SMTP id
 h15-20020a05600004cf00b00341984de389mr2023885wri.21.1711252409175; Sat, 23
 Mar 2024 20:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org> <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
In-Reply-To: <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 20:53:17 -0700
Message-ID: <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Mar 22, 2024 at 9:31=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.org> wro=
te:
> >
> > We need to extend the bpf_timer API, but the way forward relies on kfun=
cs.
> > So make bpf_timer known for kfuncs from the verifier PoV
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > changes in v5:
> > - also check for the reg offset
> >
> > changes in v4:
> > - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
> >
> > new in v3 (split from v2 02/10)
> > ---
> >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 63749ad5ac6b..24a604e26ec7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10826,6 +10826,7 @@ enum {
> >         KF_ARG_LIST_NODE_ID,
> >         KF_ARG_RB_ROOT_ID,
> >         KF_ARG_RB_NODE_ID,
> > +       KF_ARG_TIMER_ID,
> >  };
> >
> >  BTF_ID_LIST(kf_arg_btf_ids)
> > @@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
> >  BTF_ID(struct, bpf_list_node)
> >  BTF_ID(struct, bpf_rb_root)
> >  BTF_ID(struct, bpf_rb_node)
> > +BTF_ID(struct, bpf_timer_kern)
> >
> >  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
> >                                     const struct btf_param *arg, int ty=
pe)
> > @@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(const str=
uct btf *btf, const struct btf_par
> >         return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
> >  }
> >
> > +static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf=
_param *arg)
> > +{
> > +       bool ret =3D __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID)=
;
> > +       return ret;
> > +}
> > +
> >  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const =
struct btf *btf,
> >                                   const struct btf_param *arg)
> >  {
> > @@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
> >         KF_ARG_PTR_TO_NULL,
> >         KF_ARG_PTR_TO_CONST_STR,
> >         KF_ARG_PTR_TO_MAP,
> > +       KF_ARG_PTR_TO_TIMER,
> >  };
> >
> >  enum special_kfunc_type {
> > @@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
> >         if (is_kfunc_arg_map(meta->btf, &args[argno]))
> >                 return KF_ARG_PTR_TO_MAP;
> >
> > +       if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> > +               return KF_ARG_PTR_TO_TIMER;
> > +
> >         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[b=
ase_type(reg->type)])) {
> >                 if (!btf_type_is_struct(ref_t)) {
> >                         verbose(env, "kernel function %s args#%d pointe=
r type %s %s is not supported\n",
> > @@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                 case KF_ARG_PTR_TO_CALLBACK:
> >                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> >                 case KF_ARG_PTR_TO_CONST_STR:
> > +               case KF_ARG_PTR_TO_TIMER:
> >                         /* Trusted by default */
> >                         break;
> >                 default:
> > @@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                         if (ret)
> >                                 return ret;
> >                         break;
> > +               case KF_ARG_PTR_TO_TIMER:
> > +                       if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > +                               verbose(env, "arg#%d doesn't point to a=
 map value\n", i);
> > +                               return -EINVAL;
> > +                       }
> > +                       if (reg->off) {
> > +                               verbose(env, "arg#%d offset can not be =
greater than 0\n", i);
> > +                               return -EINVAL;
> > +                       }
>
> This won't be correct. You don't really check whether the timer exists
> at reg->off (and if you did, this would still restrict it to 0 offset,
> and not check the variable offset which would be non-zero). What I
> would suggest is calling process_timer_func (see how dynptr calls the
> same underlying process_dynptr_func to enforce type invariants). This
> would allow sharing the same checks and avoid bugs from creeping in.
> It does all checks wrt constant/variable offset and looking up the
> timer field offset and matching it against the one in the pointer.

Observation is correct. The patch is buggy,
but the suggestion to follow process_dynptr_func() will lead
to unnecessary complexity.
dynptr-s are on stack with plenty of extra checks.
In this case bpf_timer is in map_value.
Much simpler is to follow KF_ARG_PTR_TO_MAP approach.
Set ref_id, ref_t, ref_tname to bpf_timer and
process_kf_arg_ptr_to_btf_id() should work as-is.

You still need
+BTF_ID(struct, bpf_timer_kern)
to recognize that argument in a kfunc,
but the selftests will be using 'struct bpf_timer t',
so KF_ARG_PTR_TO_TIMER would need to match against 'struct bpf_timer'
and not against 'struct bpf_timer_kern'.

