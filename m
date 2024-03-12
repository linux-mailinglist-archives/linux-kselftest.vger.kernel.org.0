Return-Path: <linux-kselftest+bounces-6244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B75878CBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CF71C21039
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A653A1;
	Tue, 12 Mar 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cXcf1zwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3F1C17
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209148; cv=none; b=cN6Mkg+VbJmqq1mYMb5UpI5UyILvr7k4wrzmnZPasC1EjnTa1ABbc7lGh2WRSKFplKsEE1Wt/u+wcO61ssrKxAE9R1dKO+jRol/1uImg9EC2KKDixMhpvTN8xonNLI/iJIAD0L3MIq/RLz3zOhPNoqKfTbjnZvkyn+7Cgj5lirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209148; c=relaxed/simple;
	bh=u+cghnX8IkuhizDm1mtP5lcke/YetyNGJY33fxG2Q9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjrWwyVsOWsuCV5y/HPHnO0QdlbOwG2iO7gXYRQEjH8xJj1VTQ1ZLfJqK9UtqPqSLy7FcMsVm0pEu49Yj6yboChZDpx8Jtq7MTlmPspyEVTkPazAMHn5Cf+pzd6jOOk4K3qP72CX6UF7BI4Ob5slbewKB2BFNYW/tTXf6WpEglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cXcf1zwv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so2225947a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710209146; x=1710813946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuFUN/hOP8k7Y+FzC49ZRi5HcBAhtMCwCDKyd6VJ7Rk=;
        b=cXcf1zwveq2BZWd/hk/hHFZ2bcBAjvdrll3461JJbiXfEV9/3pMGWlPuG/pNBmFeWn
         efLes1S0DvG6ddCay1haGI+KNrUIGrvHtaGEQn2QwONhSa59Vtp7qwluT7qkTkskd1bt
         ZEVE1tLa/71CjFipBFpNl4IIiO1ydlP+FnQGuct76Bj2d7vsiG2rcaoD+Yac0BDlhTmC
         jOVjwt/UyyYGtGxS+6Ipa4w1EyBEixkiT8ksDCT7lM/4fPpepGC7JuMD+KQLUGUN5CFr
         yL4YcFEjbwIvbbEI22rhvTobOMG7tWg+ce70c1y+mivokvwmGYcIurpPA9a2Hg/LdMC5
         E81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710209146; x=1710813946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuFUN/hOP8k7Y+FzC49ZRi5HcBAhtMCwCDKyd6VJ7Rk=;
        b=kBdHllHKTlCl67f5CtfasUvS6MA9uw7Gj49E1NsaH2t1Ifs/cbjgjvzD9kYCH8TmOT
         GiHtbvyZCGo4nzgbrj7N9GuA91dZeMkJAmSu2r66ttnWOp7Y8ybvcjVQATrCSy5K+x6H
         gDfRq1TlQiwdV6yyyV6IPq7ctBTXEV+1ezY5ESBmRaJT+jISyxGUVKhLxRKOUiSWMvj+
         yvScJUYg5lYd3mrW+XG1Bxs+PCkTczRFcVi6Gkw8Tc8t+HBy4piPmToifggqeSwJKn9h
         4+e7qTCr2JHHh4FFM1vpYD8xn/k9/kPlGVPTFZl7TSL+490pVhROcolGizt4rHhHEvro
         Wjqw==
X-Forwarded-Encrypted: i=1; AJvYcCVsH/QidlAE6g6gPS5AkDBnyRqOJ9k83haEGhqb1y40fOpWiaor/EbHj+bCDnU8KBu7sAzsWJGOlb8gciSVtYEGWIbK8z1qOllFlbT5gu/6
X-Gm-Message-State: AOJu0YxjPP+HUVT+HAi3xuD+rkFGodFvzpfmsiFP7UfijBRj1gdjbmKS
	Enzj9u7BTqH2PYq1+R5UhsfDk5/OlVMxSTGRleoQwvZUrzavCOWxdgmhHEVOgujExtroj9b57Gm
	a1gXO7lHXJQ5clCqgTz5P1yVTSLmMCxK9nBa4AQ==
X-Google-Smtp-Source: AGHT+IF0WyYVLRMqbAbNjbiNEwXcYruNNPa78bRdIpKnuRBjtBqbGNQqz6kUmi5cKSh3oZKwaTTzkPnN9f3bSgCjkEM=
X-Received: by 2002:a17:90b:46d3:b0:29b:ae33:6ef2 with SMTP id
 jx19-20020a17090b46d300b0029bae336ef2mr6174052pjb.38.1710209146474; Mon, 11
 Mar 2024 19:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-8-dongmenglong.8@bytedance.com> <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
In-Reply-To: <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:05:35 +0800
Message-ID: <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if
 program of multi-link tracing existing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > By default, the kernel btf that we load during loading program will be
> > freed after the programs are loaded in bpf_object_load(). However, we
> > still need to use these btf for tracing of multi-link during attaching.
> > Therefore, we don't free the btfs until the bpf object is closed if any
> > bpf programs of the type multi-link tracing exist.
> >
> > Meanwhile, introduce the new api bpf_object__free_btf() to manually fre=
e
> > the btfs after attaching.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++----------
> >  tools/lib/bpf/libbpf.h   |  2 ++
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 38 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 567ad367e7aa..fd5428494a7e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8267,6 +8267,39 @@ static int bpf_object_prepare_struct_ops(struct =
bpf_object *obj)
> >         return 0;
> >  }
> >
> > +void bpf_object__free_btfs(struct bpf_object *obj)
> > +{
> > +       int i;
> > +
> > +       /* clean up module BTFs */
> > +       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> > +               close(obj->btf_modules[i].fd);
> > +               btf__free(obj->btf_modules[i].btf);
> > +               free(obj->btf_modules[i].name);
> > +       }
> > +       free(obj->btf_modules);
> > +       obj->btf_modules =3D NULL;
> > +       obj->btf_module_cnt =3D 0;
> > +
> > +       /* clean up vmlinux BTF */
> > +       btf__free(obj->btf_vmlinux);
> > +       obj->btf_vmlinux =3D NULL;
> > +}
> > +
> > +static void bpf_object_early_free_btf(struct bpf_object *obj)
> > +{
> > +       struct bpf_program *prog;
> > +
> > +       bpf_object__for_each_program(prog, obj) {
> > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY_=
MULTI ||
> > +                   prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT_M=
ULTI ||
> > +                   prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN=
_MULTI)
> > +                       return;
> > +       }
> > +
> > +       bpf_object__free_btfs(obj);
> > +}
> > +
> >  static int bpf_object_load(struct bpf_object *obj, int extra_log_level=
, const char *target_btf_path)
> >  {
> >         int err, i;
> > @@ -8307,18 +8340,7 @@ static int bpf_object_load(struct bpf_object *ob=
j, int extra_log_level, const ch
> >         /* clean up fd_array */
> >         zfree(&obj->fd_array);
> >
> > -       /* clean up module BTFs */
> > -       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> > -               close(obj->btf_modules[i].fd);
> > -               btf__free(obj->btf_modules[i].btf);
> > -               free(obj->btf_modules[i].name);
> > -       }
> > -       free(obj->btf_modules);
> > -
> > -       /* clean up vmlinux BTF */
> > -       btf__free(obj->btf_vmlinux);
> > -       obj->btf_vmlinux =3D NULL;
> > -
> > +       bpf_object_early_free_btf(obj);
> >         obj->loaded =3D true; /* doesn't matter if successfully or not =
*/
> >
> >         if (err)
> > @@ -8791,6 +8813,7 @@ void bpf_object__close(struct bpf_object *obj)
> >         usdt_manager_free(obj->usdt_man);
> >         obj->usdt_man =3D NULL;
> >
> > +       bpf_object__free_btfs(obj);
> >         bpf_gen__free(obj->gen_loader);
> >         bpf_object__elf_finish(obj);
> >         bpf_object_unload(obj);
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 5723cbbfcc41..c41a909ea4c1 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -299,6 +299,8 @@ LIBBPF_API struct bpf_program *
> >  bpf_object__find_program_by_name(const struct bpf_object *obj,
> >                                  const char *name);
> >
> > +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> > +
>
> It shouldn't be exported.
> libbpf should clean it up when bpf_object is freed.

Yes, libbpf will clean up the btfs when bpf_object is freed in
this commit. And I'm trying to offer a way to early free the btfs
by the users manual to reduce the memory usage. Or, the
btfs that we opened will keep existing until we close the
bpf_object.

This is optional, I can remove it if you prefer.

Thanks!
Menglong Dong

