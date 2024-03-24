Return-Path: <linux-kselftest+bounces-6519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF536887BA7
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 05:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144B3B20D6D
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 04:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3712E7C;
	Sun, 24 Mar 2024 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djw6QFtO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2E12E63;
	Sun, 24 Mar 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711255081; cv=none; b=uTSgpf41G0871VitisSgMoYQoZgJA0/O7B1eXYQoBmpnGS/GmpMhXmPVhmkKDZ5wdHJB+Rbb7T/o55ksojW6q0aSVKHLm1daSEIY/AES999mdqEBTW12Jsok71sJfab4wqM25ImpfmJ1dSTwjC6RpUEmN/QNAy1x7+aytNX2kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711255081; c=relaxed/simple;
	bh=906kS615/8DRiV00fgC7GfhzJnASWdGCBuP8l04Xl+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boZAg1KACL9w6T1CNzoe04nTE+sd/kgARMlikFLUbN5WhH+i4h/45aI8UjkcjLylUbtWDO7tgr35xlic4yudBEgjIPbSx0aWAWgHwsNANbV6r89iO6O3+3sLFhQqeBXXZPFusC+Yz/X7oHRIFLNwlij0j+1esqTcjK4OX+KqinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Djw6QFtO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e570ef661so1691379f8f.1;
        Sat, 23 Mar 2024 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711255078; x=1711859878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FjIyFLwcnojMnYc/PlKFyC/NgbZnhVcwzfLrMPPreM=;
        b=Djw6QFtOeHoALtans64M98QZZnckUtooYCSbFvjOZ+vxgP1OD/X0CfhiTqDs2k+Cdm
         aHpKZ8EktwpCDjavzmd7Mc5TAGx4S/OAZutufrLjwH/sTGnbj753vJl9mz/fHMcaNp3J
         m/qcbHqNxJ8R9BVZ1uidLrjWL29l3Z/jJwDXFjmDxezhcC3Uq2P0b1RPzuWaITTcb0Aq
         Alr4VocJuXmBxqwTDzovcBKhFpipUBY3X/Uw3YDPKysk9z5RWHBug10/A7focoVxWM7c
         1TYv8ZDRJDoozPz0G70XEBSsgb1WqFFdCAFjaGyUsZzfVR/GpRjO+Q/hISuMr/wJzAsm
         wupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711255078; x=1711859878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FjIyFLwcnojMnYc/PlKFyC/NgbZnhVcwzfLrMPPreM=;
        b=kI/wehihM2d2TxGsK9LseHz07IAqtnd0NnVbFp7pcc+Msyx+JndnfIZR5El0QMK9T9
         pKPxFeVFo1tXjwBQNYo+7BGFvaU3S+BDZChYFAeiXEchy2EjAS20nPmMYWWPXG6Xoago
         bbS7Sfg+HZmnj57Vqos34J/1Q1jt/6QSqQh8knOf6iwQgGq5OHYzb6rlzn0iBPP8jB4D
         ltGMGZRLsJRHFjqA7HHxVENkh4InjIvqsiYpKlCIayzynMudx4oqgzGi0ys1RleL9ug0
         FhRnRizbt6zxZQxlfhlgdRaXrrblaYQFLADymYsVxQ7NVE4IcDj7MK8hzwZ/3pqUOXxa
         yK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIVBwaKq8brkUMXjBcaYmQmNd3AV8OOFl8VquLhxRr5eFxKm7yANueztchyvM7ByLzUtFOoDGJHdvoJ8+o2Oy5FKHP3fWWNofESANyWw9lB09IXFbms5MKMSr50w0MJ2zdVYgBqxQFLnfujWlfN939+sIe0Wq3Yf1lm2bCkcE0JqmK
X-Gm-Message-State: AOJu0YyakFAIiiD2XSPRLsC8n6EfilgFWD4/txNPQrdRKHTYFliAdeIH
	WBuPjhAvylnCiyOZ1Dygqd3h91db+9zfmbIAbnEc7HC1vZWD42e3kt9QXbRVMtIxVfjWfZFtRKo
	zF/GvJvY8FTXsLDmJcjumlJQBs68=
X-Google-Smtp-Source: AGHT+IFs5tXWv1XRnWaBCMTOcpc7RHHBXxQsZW3bM6Nw+leujRpHrWIXGmHjvLLyU4B9wZn26yTCSxqllOEkGAEK6H8=
X-Received: by 2002:a05:600c:5246:b0:414:630:26be with SMTP id
 fc6-20020a05600c524600b00414063026bemr2374402wmb.31.1711255077851; Sat, 23
 Mar 2024 21:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org> <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
 <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com> <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com>
In-Reply-To: <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 21:37:46 -0700
Message-ID: <CAADnVQ+5mSEW-LJwS30hED1cJeHOhqfCTKdBzYCcRd8EiVNvtA@mail.gmail.com>
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

On Sat, Mar 23, 2024 at 9:01=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sun, 24 Mar 2024 at 04:53, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2024 at 9:31=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.org>=
 wrote:
> > > >
> > > > We need to extend the bpf_timer API, but the way forward relies on =
kfuncs.
> > > > So make bpf_timer known for kfuncs from the verifier PoV
> > > >
> > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > >
> > > > ---
> > > >
> > > > changes in v5:
> > > > - also check for the reg offset
> > > >
> > > > changes in v4:
> > > > - enforce KF_ARG_PTR_TO_TIMER to be of type PTR_TO_MAP_VALUE
> > > >
> > > > new in v3 (split from v2 02/10)
> > > > ---
> > > >  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 63749ad5ac6b..24a604e26ec7 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -10826,6 +10826,7 @@ enum {
> > > >         KF_ARG_LIST_NODE_ID,
> > > >         KF_ARG_RB_ROOT_ID,
> > > >         KF_ARG_RB_NODE_ID,
> > > > +       KF_ARG_TIMER_ID,
> > > >  };
> > > >
> > > >  BTF_ID_LIST(kf_arg_btf_ids)
> > > > @@ -10834,6 +10835,7 @@ BTF_ID(struct, bpf_list_head)
> > > >  BTF_ID(struct, bpf_list_node)
> > > >  BTF_ID(struct, bpf_rb_root)
> > > >  BTF_ID(struct, bpf_rb_node)
> > > > +BTF_ID(struct, bpf_timer_kern)
> > > >
> > > >  static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
> > > >                                     const struct btf_param *arg, in=
t type)
> > > > @@ -10877,6 +10879,12 @@ static bool is_kfunc_arg_rbtree_node(const=
 struct btf *btf, const struct btf_par
> > > >         return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID)=
;
> > > >  }
> > > >
> > > > +static bool is_kfunc_arg_timer(const struct btf *btf, const struct=
 btf_param *arg)
> > > > +{
> > > > +       bool ret =3D __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER=
_ID);
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, co=
nst struct btf *btf,
> > > >                                   const struct btf_param *arg)
> > > >  {
> > > > @@ -10946,6 +10954,7 @@ enum kfunc_ptr_arg_type {
> > > >         KF_ARG_PTR_TO_NULL,
> > > >         KF_ARG_PTR_TO_CONST_STR,
> > > >         KF_ARG_PTR_TO_MAP,
> > > > +       KF_ARG_PTR_TO_TIMER,
> > > >  };
> > > >
> > > >  enum special_kfunc_type {
> > > > @@ -11102,6 +11111,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_=
env *env,
> > > >         if (is_kfunc_arg_map(meta->btf, &args[argno]))
> > > >                 return KF_ARG_PTR_TO_MAP;
> > > >
> > > > +       if (is_kfunc_arg_timer(meta->btf, &args[argno]))
> > > > +               return KF_ARG_PTR_TO_TIMER;
> > > > +
> > > >         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_i=
ds[base_type(reg->type)])) {
> > > >                 if (!btf_type_is_struct(ref_t)) {
> > > >                         verbose(env, "kernel function %s args#%d po=
inter type %s %s is not supported\n",
> > > > @@ -11735,6 +11747,7 @@ static int check_kfunc_args(struct bpf_veri=
fier_env *env, struct bpf_kfunc_call_
> > > >                 case KF_ARG_PTR_TO_CALLBACK:
> > > >                 case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> > > >                 case KF_ARG_PTR_TO_CONST_STR:
> > > > +               case KF_ARG_PTR_TO_TIMER:
> > > >                         /* Trusted by default */
> > > >                         break;
> > > >                 default:
> > > > @@ -12021,6 +12034,16 @@ static int check_kfunc_args(struct bpf_ver=
ifier_env *env, struct bpf_kfunc_call_
> > > >                         if (ret)
> > > >                                 return ret;
> > > >                         break;
> > > > +               case KF_ARG_PTR_TO_TIMER:
> > > > +                       if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > > > +                               verbose(env, "arg#%d doesn't point =
to a map value\n", i);
> > > > +                               return -EINVAL;
> > > > +                       }
> > > > +                       if (reg->off) {
> > > > +                               verbose(env, "arg#%d offset can not=
 be greater than 0\n", i);
> > > > +                               return -EINVAL;
> > > > +                       }
> > >
> > > This won't be correct. You don't really check whether the timer exist=
s
> > > at reg->off (and if you did, this would still restrict it to 0 offset=
,
> > > and not check the variable offset which would be non-zero). What I
> > > would suggest is calling process_timer_func (see how dynptr calls the
> > > same underlying process_dynptr_func to enforce type invariants). This
> > > would allow sharing the same checks and avoid bugs from creeping in.
> > > It does all checks wrt constant/variable offset and looking up the
> > > timer field offset and matching it against the one in the pointer.
> >
> > Observation is correct. The patch is buggy,
> > but the suggestion to follow process_dynptr_func() will lead
> > to unnecessary complexity.
> > dynptr-s are on stack with plenty of extra checks.
>
> The suggestion was to call process_timer_func, not process_dynptr_func.
>
> > In this case bpf_timer is in map_value.
> > Much simpler is to follow KF_ARG_PTR_TO_MAP approach.
>
> What I meant by the example was that dynptr handling does the same
> thing for kfuncs and helpers (using the same function), so timer
> arguments should do the same (i.e. use process_timer_func), which will
> do all checks for constant offset (ensuring var_off is tnum_is_const)
> and match it against btf_record->timer_off.

I don't follow. Please elaborate with a patch.
The var_off and off is a part of the bug, but it's not the biggest part of =
it.

