Return-Path: <linux-kselftest+bounces-1927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AA8135C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 17:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EAC280DB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788495F1C7;
	Thu, 14 Dec 2023 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoV+v3N7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C911A;
	Thu, 14 Dec 2023 08:09:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-a22ed5f0440so432018966b.1;
        Thu, 14 Dec 2023 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702570153; x=1703174953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irrGSo/jXwM5O23C0Oho2ggjcoMi5gY8zL2PFLKo9UM=;
        b=GoV+v3N7S8oYd+BUHRx/upiZGCx7B7MeiXfKpNNtiqkTaT+DSIu2hdmOtGfFVjlUj/
         7hUobDR2nGCvm6upMNWLodK5QgYTQ3FEk6mWkxsz4Qrn43M00zOiOuDEraoCwMXNfoWS
         HwVc2w7mZZZ/pZFxEoViHxgBQI+d6OHzQybQjB8YWcHRY90wAFm17CuLB+k/1JkUoPqm
         2+J5RBkq5KlKe1jp8xRJsFbPXuX7JAc9DveIOFBzfqDH/pmCyAvhri8GT2QKlTI5pUgQ
         vMDUA4tUjbsYfbE/AjfamSjOWbnaiX/tMbEuddI6OB4LC4uP5+/1ErsLbFMJnbw0Rcn2
         CQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570153; x=1703174953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irrGSo/jXwM5O23C0Oho2ggjcoMi5gY8zL2PFLKo9UM=;
        b=RJEoR90WNJzMkuQEJn6611jhuDAlR2TZfcXczjYijaZT6NuOc8VJJ4xCY5UcJSOM/3
         6wVY8MpN09jY1xMq+I5GWMfBEriCzW4fXvEtEq7s3yzeCi2KFypFy1F3oH2TNzRAv8La
         NdoHYqZcWbHvzqlurEq5SrrlgG+7At5tmh9L7aea0r2R7jnuipVBCr/DdZ4dOPXGB/yZ
         VJi8xS+nxNTmzvjTqcLvU9QZxRRVZbGY7AbXTIvp/wwqBkq98KrW5Db52sosaMPzlwRQ
         jtRz1Ti+YJxvh4pRJi7TxTgufx9rAl4qVX39lvLvz7N3buvARpsFevmi51DIngSSL1Dy
         1PhQ==
X-Gm-Message-State: AOJu0Yy3scacbMTFTAfjk8c6MHRcYpAclSnmHypuMKReZZ9doeQZVxyH
	jLiNRCvpeRXUIwVsl8Vr0TiHicarkEYx3vf56bg=
X-Google-Smtp-Source: AGHT+IENI0HNmvdbNULgPNNLZ/eA4DESJkfB4cHcMwDI9OQv5r6Ak0AeXkJm3wi9I0msfKOpdb/nIW92jw5kFlUjQgU=
X-Received: by 2002:a17:906:1708:b0:a19:a19b:4238 with SMTP id
 c8-20020a170906170800b00a19a19b4238mr3098200eje.163.1702570153479; Thu, 14
 Dec 2023 08:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
 <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso> <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
In-Reply-To: <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 14 Dec 2023 17:08:36 +0100
Message-ID: <CAP01T76ZtehyRidmnV5A0p3LCyjw6Q4sjRH6ZhczgGn1ap-x_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, davem@davemloft.net, 
	shuah@kernel.org, ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	andrii@kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 at 00:49, Eyal Birger <eyal.birger@gmail.com> wrote:
>
> On Wed, Dec 13, 2023 at 3:15=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > [...]
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b=
/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > index c0dd38616562..f00dba85ac5d 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > @@ -8,8 +8,9 @@
> > > >   */
> > > >  #include "vmlinux.h"
> > > >  #include <bpf/bpf_core_read.h>
> > > > -#include <bpf/bpf_helpers.h>
> > > >  #include <bpf/bpf_endian.h>
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include "bpf_experimental.h"
> > > >  #include "bpf_kfuncs.h"
> > > >  #include "bpf_tracing_net.h"
> > > >
> > > > @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > >         opts.family =3D AF_INET;
> > > >
> > > >         x =3D bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > -       if (!x || opts.error)
> > > > +       if (!x)
> > > >                 goto out;
> > > > +       bpf_assert_with(opts.error =3D=3D 0, XDP_PASS);
> > > >
> > > >         if (!x->replay_esn)
> > > >                 goto out;
> > > >
> > > > results in:
> > > >
> > > > 57: (b7) r1 =3D 2                       ; R1_w=3D2 refs=3D5
> > > > 58: (85) call bpf_throw#115436
> > > > calling kernel function bpf_throw is not allowed
> > > >
> > >
> > > I think this might be because bpf_throw is not registered for use by
> > > BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
> > > this program type as well, since it's already done for TC.
> >
> > Ah yeah, that was it.
> >
> > >
> > > > It looks like the above error comes from verifier.c:fetch_kfunc_met=
a,
> > > > but I can run the exceptions selftests just fine with the same bzIm=
age.
> > > > So I'm thinking it's not a kfunc registration or BTF issue.
> > > >
> > > > Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
> > > >
> > >
> > > Yes, even once you enable this, this will fail for now. I am sending
> > > out a series later this week that enables bpf_throw with acquired
> > > references, but until then may I suggest the following:
> > >
> > > #define bpf_assert_if(cond) for (int ___i =3D 0, ___j =3D (cond); !(_=
__j) \
> > > && !___j; bpf_throw(), ___i++)
> > >
> > > This will allow you to insert some cleanup code with an assertion.
> > > Then in my series, I will convert this temporary bpf_assert_if back t=
o
> > > the normal bpf_assert.
> > >
> > > It would look like:
> > > bpf_assert_if(opts.error =3D=3D 0) {
> > >   // Execute if assertion failed
> > >   bpf_xdp_xfrm_state_release(x);
> > > }
> > >
> > > Likewise for bpf_assert_with_if, you get the idea.
> >
> > I gave it a try and I'm getting this compile error:
> >
> >         progs/test_tunnel_kern.c:996:2: error: variable '___j' used in =
loop condition not modified in loop body [-Werror,-Wfor-loop-analysis]
> >                 bpf_assert_with_if(opts.error =3D=3D 0, XDP_PASS) {
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         /home/dxu/dev/linux/tools/testing/selftests/bpf/bpf_experimenta=
l.h:295:38: note: expanded from macro 'bpf_assert_with_if'
> >                 for (int ___i =3D 0, ___j =3D (cond); !(___j) && !___j;=
 bpf_throw(value), ___i++)
> >                                                     ^~~~      ~~~~
> >         1 error generated.
> >         make: *** [Makefile:618: /home/dxu/dev/linux/tools/testing/self=
tests/bpf/test_tunnel_kern.bpf.o] Error 1
> >
> > Seems like the compiler is being clever.
>
> It looks like ___j is used twice - maybe it was meant to be ___i? i.e.:
>
>    for (int ___i =3D 0, ___j =3D (cond); !(___j) && !___i; bpf_throw(valu=
e), ___i++)
>

Ah, yes, that's a typo. Eyal is right, it should be ___i.

