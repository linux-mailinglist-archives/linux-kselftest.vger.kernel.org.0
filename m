Return-Path: <linux-kselftest+bounces-39419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512CB2EAD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA55C8141
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BEC244687;
	Thu, 21 Aug 2025 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCZUR5HI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0313243951;
	Thu, 21 Aug 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740385; cv=none; b=j7UqI39MYdQU6yjNIINhYp3XsMjln8a1KgCj5Gj0I7tMIFIGe0dkjXv9IuHBrBbloms9J7uGB3aN9kSzP5pnydvZGlE5RThmqbtDH0BumZUxgbx22/pA0EY8jRKO5O6fXSvvXzghKmyk9qcMWQ+bUBoasFZQS3YrrdKX+4rBt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740385; c=relaxed/simple;
	bh=kSDSfek91jsHl7FrJyM0gLyKBh6BqcNAxcjQLYi4lr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZA/AC+x6guEFid1D11m1qv1HmxW0kEmxIRg4QJ42bhkQNjeYXzOM+Lz2pJena1a4ZP8JxYMWgQrPoa4MfMDqy32jdbn6IXSkDkrELNKrQ91bvpq611Q1yAUzavq8ZlS2KvvQoXmCkkHiGsHLKwVvZOaqKXO690fCnXwcrzhK8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCZUR5HI; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d6083cc69so3920597b3.2;
        Wed, 20 Aug 2025 18:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740382; x=1756345182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebI6Za89uQY5Wc3NtaCHo2kvrIsvdUGpm5geS336IaY=;
        b=BCZUR5HIRYVCwWBt+JlNeUoB4hkWonQUkO5ptgiQg5bhCAOg1naSBQdKj1JY7IbgZD
         Er1oOBvai9Fcw0GUXHQIgkIzBUR9ZxIc1UmII8HmR2Was2vqgZm5CoPPIlPYac4VM8h5
         0e//StOonDEIXR6Pt02ByixOOyuDWcf702XZYAkcdaJK/7FIXhhzhFDzMUL/o5Gbcdc4
         dysTU6cxWxzi14Njkv2nQISo6x8VRFwMhfHGpxxh9k+vkEC+j0F/e2wd10UHBUBlhGKJ
         m+PQplZe+t3XnSQOtQhUF6XY1f+3CeGoF9luPH13Sp2mnPg24lUEsbYP/KHbYDyqu56Z
         W9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740382; x=1756345182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebI6Za89uQY5Wc3NtaCHo2kvrIsvdUGpm5geS336IaY=;
        b=jswEQrZtfIyyYMZ9Pw+OWLJkspvzi0wIAdFJe/+2uFuP57QK+b2rZFyvMW+ENPqaki
         9cYkAfuCMBH30z5un31/cspOjmOpy2QkpUjza6CsSk8C5sCGl3jf7vWY8Nf8XmMvrzLO
         6cf10Joc0xSq2aN5j70rexr+2s+sf3XXm59UH4PXc98NOYDxWZYuM5Bf79YJH34Xq6IB
         UosZu5L/61rnI/VluUy4Rt4ADw32f09Wf4JDiTqbdZw+CEd7WgT7e7g6x+1HblKsVrJ4
         T8Kdf0gxrlQS+Z5d8awtZ7Q2N71fxE5dK8BAMnXpl4luHfDc9rOr6S7c53U1fG5Zf4Gy
         tcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRnl6HXAQ/98oWJKLp2ZIriKnGHr5TpKC/hvThyzVkI3WtjIjM/JVVSQnahTSgr/NCa+s2A3USLnd2i99AID5@vger.kernel.org, AJvYcCVUS6Cc3RCukXs5QkOEvpv2+PFW55tHFJosxbj1AJIFVo6LpHij+vMevITBpz1OrqnCvms=@vger.kernel.org, AJvYcCWgxi2CnkfdJIaXQaWVw0e1XO8sne9k5y2iCfmyGJWB7UV8nMewmLvqTgWXE52+d0yJ+v7GMqE1@vger.kernel.org, AJvYcCXkDODRKhK5C/ux2alzmC0Ai4TfTGM8uHy8q81Pl83+fG6E/SqqIIq6di1IZfQJyvrUQiEAUTmiU3S0WWOg@vger.kernel.org
X-Gm-Message-State: AOJu0YwHznvrgoA4Z+bA4YIUDDzmG+fppU+NE2vHexGAzVQHHuVNY+/r
	3rkRxVsZ1aB+4ovyFwPSvDWIKI4tHAw8QK/T7MS2D0A7X79qtjIdUXy+od1hdiOQdxAX6RI4nN0
	bJAr04NGJbyuwXzL+L1DGuedbzHBS7pQ=
X-Gm-Gg: ASbGncuAgfoiPwosmez67whP3jRMq4OfsP2QTw0isQJq0E7V2jeKYHgyd18KY9pmpkv
	maGtpiY3PZTth8X7ZvETUTtwkNFTevy5OeKxMSG/1OxQ48nK72LKRnQEYU8zeUd5BpmRWVXrR8A
	JZeHEXw9tjGDD8xO817yovIR1lcnzRGA0T5TQAFQ2RZ3wsM7XKpf4QaNPJT75LFDlRNGz+uzeOk
	JKl41DHQNU=
X-Google-Smtp-Source: AGHT+IGfNVSG+YcsbP05U+7tIuANEtQ3x/KgCgdmjsd6mkdSCWkbsC/b2aHy2e+JJzoZ3OamVVaeaFd9iZgnbQ6z6cY=
X-Received: by 2002:a05:690c:30d:b0:71b:9213:a75d with SMTP id
 00721157ae682-71fc8899224mr12037257b3.18.1755740382464; Wed, 20 Aug 2025
 18:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819033956.59164-1-dongml2@chinatelecom.cn>
 <20250819033956.59164-3-dongml2@chinatelecom.cn> <CAEf4BzZBztC69GFDuA4YJHPmWOXuq3+tSNMspPNA3tksGaEi=A@mail.gmail.com>
In-Reply-To: <CAEf4BzZBztC69GFDuA4YJHPmWOXuq3+tSNMspPNA3tksGaEi=A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 21 Aug 2025 09:39:31 +0800
X-Gm-Features: Ac12FXzswgjQ95dJXpbKnIm6pNkHCGVkejzRiQftM1aigpT1SzLiC1ZO-IiEQUM
Message-ID: <CADxym3bjmC3d1d3_CKd2DqFB4P_LYK_FwXUXFcKsYcJ6=smfAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: skip recursive functions for kprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:47=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 18, 2025 at 8:40=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Some functions is recursive for the kprobe_multi and impact the benchma=
rk
> > results. So just skip them.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testin=
g/selftests/bpf/trace_helpers.c
> > index d24baf244d1f..9da9da51b132 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.c
> > +++ b/tools/testing/selftests/bpf/trace_helpers.c
> > @@ -559,6 +559,22 @@ static bool skip_entry(char *name)
> >         if (!strncmp(name, "__ftrace_invalid_address__",
> >                      sizeof("__ftrace_invalid_address__") - 1))
> >                 return true;
> > +
> > +       if (!strcmp(name, "migrate_disable"))
> > +               return true;
> > +       if (!strcmp(name, "migrate_enable"))
> > +               return true;
> > +       if (!strcmp(name, "rcu_read_unlock_strict"))
> > +               return true;
> > +       if (!strcmp(name, "preempt_count_add"))
> > +               return true;
> > +       if (!strcmp(name, "preempt_count_sub"))
> > +               return true;
> > +       if (!strcmp(name, "__rcu_read_lock"))
> > +               return true;
> > +       if (!strcmp(name, "__rcu_read_unlock"))
> > +               return true;
> > +
>
> static const char *trace_blacklist[] =3D {
>     "migrate_disable",
>     "migrate_enable",
>     ...
> };
>
> it's not like it's one or two functions where copy-pasting strcmp might b=
e fine

OK!

>
> pw-bot: cr
>
>
> >         return false;
> >  }
> >
> > --
> > 2.50.1
> >

