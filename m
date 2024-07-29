Return-Path: <linux-kselftest+bounces-14390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE593FCCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B791F2110D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073F186E2A;
	Mon, 29 Jul 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxQSswtp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF118308E;
	Mon, 29 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275415; cv=none; b=CPDJKvMhyNYI3lJVvwFOcHzaqXZo99WQR9wYAnFUtbdixaYma5PUF9Ug4HSEO69p+iXQAgpcgekJpguY7alUksY7WbaL6UFjZTSrVJ1ZCLmvHJoLElVbm723QFocnDKG+DaqFT/Z/8uot2RWbsRCrG0NG7u8HjE8qqLkkGLjyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275415; c=relaxed/simple;
	bh=4NxwcVBogzSik6xO69vdbwmpbYw9mw6vWuiVUdTVbZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS98ckFC1leDucd9V7FdumRMjnQXgPU95ixa04c16P2i+KieysQcXK/0UtyI3vrsvRbE/nrl2VmDI1cNbXHjZHXa7x5ZGSymForUvSyfD2KVDcyiL+y/wQxzc41GGWDlFFCMDITWqH957p/bZGaQw/z5LnTZdne9I4HTnMO4bJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxQSswtp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc47abc040so19718115ad.0;
        Mon, 29 Jul 2024 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275413; x=1722880213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAoutELpgZ2/FASGl5RA7ci/ysqoxbX9zpw9T21SN8g=;
        b=JxQSswtpIzzSZ/JcAlsVvL7kONtai10EDx/auO63g1NA8JcrM43tfh5KZyEp5Mb1+l
         2WJmnBK/Jba2AJPCw/sF6twvkqI1Ir2qZT54BNLjr46mZjR14AkQ43OCTOzgrdjhKItu
         gB5xoEGMJiA/YH9+AKIdk4NhWtOcIllVbbPuHPNd9jvNOjF44lqKBJQDonD6UYm/xVD+
         +TSOZVv6fAwbZGwleF+8H614dA6WW+jEL7fsVLfvxMZlOYX3uSzTQv4hLTk4dNBtA1rd
         Z28O/lUHtSK+kZljsst7aH+bZyGLNsnmNUmQ7vPiwZyzuDgwhyqiTtF0z3/a43bDvbDh
         HySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275413; x=1722880213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAoutELpgZ2/FASGl5RA7ci/ysqoxbX9zpw9T21SN8g=;
        b=jRoGHQg8NVjiKl+eqp2gIRczdoSTWZFinNWob98y9hlhEzHvRy73WTtgK1MKQ9PJjV
         4xswjUjCd4yH2mKFcCuggdQ32tYht5R9VnoV0b+EwDLJTLidNvJclFyDHiTUYnoTZwqU
         mJoWwKVnukcHK8omGDLmavjJq3U9ZcsWvDS1XBSDWc+gJdz6vYSjNGpTJ2YCThiS+g3d
         4db3elOoFMN7zo2damKQ7x0+wVWfEVgQBeXPnFTE3hKeAL38Q67fuUcdkHJr6zjFBIKP
         lORZZjlErmRiaR66Fa1R1/vQkEBIwAGYa3+gSQuTWlznw0jFrcTLdq63mr+Wt48m604x
         Y/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUeirlNveTfxTQVLAl7TCWPWJcuuKI0syVrbkK2Jt/tV3b3CDXgxR8adf+3CBV3USrv8zavG6nyRMkY4d4TXu2iD2XKS5GYZuFrcL4+covka9G5yDUnuGOAnvGgygFxsjj66vQgPJ37
X-Gm-Message-State: AOJu0YxTQ9afnVXcgIYsfqTO54kqZL4ZJ5w4ZBj9KabYHQGCurKDoOJT
	QjIIoecVN3R+rMz2SruNldaqmNcrlFwvETlGbPetf4qosplEd9rkvVlHO64dWHlgiX3NBMQwRtZ
	Vr9+68Tg9ah1dRMkpyFQZ2W+dqzQ=
X-Google-Smtp-Source: AGHT+IGZqRO9NZIOCVBvZjihR0C8pKyNA/UI0jFzDvw6s5kRemVbmspr1aBwSYcQp8n8GJEgoZ360Bchze0f0yKTduc=
X-Received: by 2002:a17:90a:c17:b0:2cf:c2da:771d with SMTP id
 98e67ed59e1d1-2cfc2da7f13mr1652785a91.25.1722275413218; Mon, 29 Jul 2024
 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721903630.git.tony.ambardar@gmail.com> <472c94bd42cda20154a26ef384b73488abf026c0.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4Bza_y15T4gU=Kiu2d+RbWpxEzrLe6T71bCpK383xHD8JMg@mail.gmail.com> <ZqRt8jdbWj6oQHov@kodidev-ubuntu>
In-Reply-To: <ZqRt8jdbWj6oQHov@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 10:50:01 -0700
Message-ID: <CAEf4Bzaj-YZaXco2EAsMhneqinLgukDepeN63Xt8cC9GTbRVxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: Fix compile if backtrace
 support missing in libc
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:48=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> On Thu, Jul 25, 2024 at 01:22:37PM -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 25, 2024 at 3:39=E2=80=AFAM Tony Ambardar <tony.ambardar@gm=
ail.com> wrote:
> > >
> > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > >
> > > Use backtrace functions only with glibc and otherwise provide stubs i=
n
> > > test_progs.c. This avoids compile errors (e.g. with musl libc) like:
> > >
> > >   test_progs.c:13:10: fatal error: execinfo.h: No such file or direct=
ory
> > >      13 | #include <execinfo.h> /* backtrace */
> > >         |          ^~~~~~~~~~~~
> > >   test_progs.c: In function 'crash_handler':
> > >   test_progs.c:1034:14: error: implicit declaration of function 'back=
trace' [-Werror=3Dimplicit-function-declaration]
> > >    1034 |         sz =3D backtrace(bt, ARRAY_SIZE(bt));
> > >         |              ^~~~~~~~~
> > >   test_progs.c:1045:9: error: implicit declaration of function 'backt=
race_symbols_fd' [-Werror=3Dimplicit-function-declaration]
> > >    1045 |         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
> > >         |         ^~~~~~~~~~~~~~~~~~~~
> > >
> > > Fixes: 9fb156bb82a3 ("selftests/bpf: Print backtrace on SIGSEGV in te=
st_progs")
> > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_progs.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing=
/selftests/bpf/test_progs.c
> > > index 60c5ec0f6abf..f6cfc6a8e8f0 100644
> > > --- a/tools/testing/selftests/bpf/test_progs.c
> > > +++ b/tools/testing/selftests/bpf/test_progs.c
> > > @@ -10,7 +10,6 @@
> > >  #include <sched.h>
> > >  #include <signal.h>
> > >  #include <string.h>
> > > -#include <execinfo.h> /* backtrace */
> > >  #include <sys/sysinfo.h> /* get_nprocs */
> > >  #include <netinet/in.h>
> > >  #include <sys/select.h>
> > > @@ -19,6 +18,14 @@
> > >  #include <bpf/btf.h>
> > >  #include "json_writer.h"
> > >
> > > +#ifdef __GLIBC__
> > > +#include <execinfo.h> /* backtrace */
> > > +#else
> > > +#define backtrace(...) (0)
> > > +#define backtrace_symbols_fd(bt, sz, fd) \
> > > +       dprintf(fd, "<backtrace not supported>\n", bt, sz)
> > > +#endif
> >
> > First, let's define backtrace() and backtrace_symbols_fd() as proper
> > functions, not a macro?
> >
> > And second, what if we then make those functions __weak, so they
> > provide default implementations if libc doesn't provide those
> > functions?
> >
> > This parts seems unavoidable, though:
> >
> > #ifdef __GLIBC__
> > #include <execinfo.h>
> > #endif
> >
>
> I agree that would be cleaner, will work on a v2 with this.
>

v2 looks good, thanks

> Out of curiosity, I saw that tools/build includes feature-detection code
> (incl backtrace) and wondered if selftests/bpf ever used this facility?

I don't remember, tbh, it might have at some point in the past.

> >
> > > +
> > >  static bool verbose(void)
> > >  {
> > >         return env.verbosity > VERBOSE_NONE;
> > > --
> > > 2.34.1
> > >

