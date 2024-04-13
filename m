Return-Path: <linux-kselftest+bounces-7895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006D8A3A15
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE01F22C41
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81554A24;
	Sat, 13 Apr 2024 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxWze/7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C4442C
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Apr 2024 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971174; cv=none; b=k38BWMcsJ53J0X7mKCzQ99D3bgrGkrk/eekyrJ780z3SG6Fvf4N1JYWCjwqbjH0X624ET0P1KbAqVn5uZ8ICHre57SF8rjLNmoCnsk0zl5nB2NyphDb6r5F3VS1QvB8Xx+RMSgwTctfHc3pWXzfpNe6/d/AINzpQSqpn4rGlGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971174; c=relaxed/simple;
	bh=OEitvC2FrqL37rYWsuz+CrthG2vyZds3lU22hU23Ms4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3VxYXVjXYZtm1BZbejwdh3LsVq9ogV+Hd5Fel/+4TpBXwrwPRI3+R4z1wbsQdY7LNc1kiz6GouFIvob8mxROvlxM+1KbL1hlYGBuKBw0tddje27+s5xUzAPb0dxdfta4dv7ZM79unCzn0mPuCM6YghEQXNhyIA2bzV0xPx4xgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxWze/7m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417f5268b12so13406095e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712971170; x=1713575970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/IhB4syrBzPuc+TLnwnm4IzK5ETGkVI6wWNl4QZk2s=;
        b=bxWze/7m6siWbecVXETc1pg/2Dy6N3PO9pjPHAstRlpShiRr3GWzEkSe2racMzx4Cr
         Gn1aYMrklca7zSChnla6h94q5WfD/5XL3txyXee8A330BycnaKVW8Qy3T2tpKwfroLmU
         gagS3L/ORozeyMtWj5vSHVpl3rJG0UHaBxTqhfeh1cTizIzaymB+CZKs6q/1tE1eWOC6
         lPTLFzYgLwb3ptR0uqfHIRbpWg6BFRr52LNB9eC9LJiW/lja8EjJxzD43yNstk7URawQ
         /Ads/qk1REJuYswLsIswi8Om5wzm+xBez84x7X4IuxCzwIvVThimH6SJpSl1tVLKrH6J
         ipnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712971170; x=1713575970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/IhB4syrBzPuc+TLnwnm4IzK5ETGkVI6wWNl4QZk2s=;
        b=FnhUCtUm0mS+dudJqHiw5t+jV2BR1DLT8mPABFiKBXQo+xxDY/9+MYuOZDDLSo4Nmv
         oIww7O5uV+p8FJtYb2KIoTToUbeHPk15ZQ9uSHOuCntOvc2OZJRZhqzDcxYAAdZyoi3H
         AjoXV/NgWmtzGObH6/ZXpQQ+CFgsCI5vFru13CxcyAKHA5hQ0B8A0AkvFEjx3y6RxH6O
         /SAHAo+b6533H65+zDjhRSSrdzMTyRoEbIxnjpHjrTMbK38sK3nL9Su5xB2W8Cr3waGx
         KCeqaaEoVOAf1qxVgWCS0x6CNXjtRkiotXgCwtH+tizjZAk7DzH1hCi/XgT7f8iLpv5L
         OnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWevC0CAxa10BCfkQs39cq8fSN9EiDRLM6FfZY+5z81zonl63N/W5ieFTp31LsvaAgtg7l0UCnxyGx3gWjIy/yLkOKp9/pd0tIwxHTo45oj
X-Gm-Message-State: AOJu0YyWINimE5vw1A9pAoCRKxU+o8PCbAycxSLVOajzJYdXFwGK8dlP
	QVoN1uwIsKhLeBgRBGOX9K9B/62whWCw4FG+ACfSq/cC9aDyl4PyxSIyeEcGWGLWDR+yYaWAj62
	2U7lGjD6tvr8WG5s2uc7+lWPMLyY0mBSqELKy
X-Google-Smtp-Source: AGHT+IFnKkdFnoWRrMBZGPIoxmpCyWfWDTE+DS0TPVLkuuLCQ5+jSOiE5DiDiCDbW2avq0dbP0QTZL0VdQ8BUYD3+G8=
X-Received: by 2002:a05:600c:3592:b0:416:2d39:bcc2 with SMTP id
 p18-20020a05600c359200b004162d39bcc2mr4788661wmq.29.1712971170172; Fri, 12
 Apr 2024 18:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-2-jrife@google.com>
 <5ad9aac3-6170-47cb-87be-b77d4425e31a@gmail.com>
In-Reply-To: <5ad9aac3-6170-47cb-87be-b77d4425e31a@gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Fri, 12 Apr 2024 18:19:16 -0700
Message-ID: <CADKFtnRrOjV3fPRWnkVyk2svxx1uMaHVAOOo_+sAmvozz9BH9Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] selftests/bpf: Fix bind program for big
 endian systems
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kui-Feng,

You are right. Maybe simply "load_word" and "load_byte" would be a
better name here. WDYT?

-Jordan


On Fri, Apr 12, 2024 at 6:01=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 4/12/24 09:52, Jordan Rife wrote:
> > Without this fix, the bind4 and bind6 programs will reject bind attempt=
s
> > on big endian systems. This patch ensures that CI tests pass for the
> > s390x architecture.
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >   .../testing/selftests/bpf/progs/bind4_prog.c  | 18 ++++++++++--------
> >   .../testing/selftests/bpf/progs/bind6_prog.c  | 18 ++++++++++--------
> >   tools/testing/selftests/bpf/progs/bind_prog.h | 19 ++++++++++++++++++=
+
> >   3 files changed, 39 insertions(+), 16 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/tes=
ting/selftests/bpf/progs/bind4_prog.c
> > index a487f60b73ac4..2bc052ecb6eef 100644
> > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > @@ -12,6 +12,8 @@
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_endian.h>
> >
> > +#include "bind_prog.h"
> > +
> >   #define SERV4_IP            0xc0a801feU /* 192.168.1.254 */
> >   #define SERV4_PORT          4040
> >   #define SERV4_REWRITE_IP    0x7f000001U /* 127.0.0.1 */
> > @@ -118,23 +120,23 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
> >
> >       // u8 narrow loads:
> >       user_ip4 =3D 0;
> > -     user_ip4 |=3D ((volatile __u8 *)&ctx->user_ip4)[0] << 0;
> > -     user_ip4 |=3D ((volatile __u8 *)&ctx->user_ip4)[1] << 8;
> > -     user_ip4 |=3D ((volatile __u8 *)&ctx->user_ip4)[2] << 16;
> > -     user_ip4 |=3D ((volatile __u8 *)&ctx->user_ip4)[3] << 24;
> > +     user_ip4 |=3D load_byte_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
> > +     user_ip4 |=3D load_byte_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
> > +     user_ip4 |=3D load_byte_ntoh(ctx->user_ip4, 2, sizeof(user_ip4));
> > +     user_ip4 |=3D load_byte_ntoh(ctx->user_ip4, 3, sizeof(user_ip4));
> >       if (ctx->user_ip4 !=3D user_ip4)
> >               return 0;
> >
> >       user_port =3D 0;
> > -     user_port |=3D ((volatile __u8 *)&ctx->user_port)[0] << 0;
> > -     user_port |=3D ((volatile __u8 *)&ctx->user_port)[1] << 8;
> > +     user_port |=3D load_byte_ntoh(ctx->user_port, 0, sizeof(user_port=
));
> > +     user_port |=3D load_byte_ntoh(ctx->user_port, 1, sizeof(user_port=
));
> >       if (ctx->user_port !=3D user_port)
> >               return 0;
> >
> >       // u16 narrow loads:
> >       user_ip4 =3D 0;
> > -     user_ip4 |=3D ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
> > -     user_ip4 |=3D ((volatile __u16 *)&ctx->user_ip4)[1] << 16;
> > +     user_ip4 |=3D load_word_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
> > +     user_ip4 |=3D load_word_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
> >       if (ctx->user_ip4 !=3D user_ip4)
> >               return 0;
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/tes=
ting/selftests/bpf/progs/bind6_prog.c
> > index d62cd9e9cf0ea..194583e3375bf 100644
> > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > @@ -12,6 +12,8 @@
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_endian.h>
> >
> > +#include "bind_prog.h"
> > +
> >   #define SERV6_IP_0          0xfaceb00c /* face:b00c:1234:5678::abcd *=
/
> >   #define SERV6_IP_1          0x12345678
> >   #define SERV6_IP_2          0x00000000
> > @@ -129,25 +131,25 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
> >       // u8 narrow loads:
> >       for (i =3D 0; i < 4; i++) {
> >               user_ip6 =3D 0;
> > -             user_ip6 |=3D ((volatile __u8 *)&ctx->user_ip6[i])[0] << =
0;
> > -             user_ip6 |=3D ((volatile __u8 *)&ctx->user_ip6[i])[1] << =
8;
> > -             user_ip6 |=3D ((volatile __u8 *)&ctx->user_ip6[i])[2] << =
16;
> > -             user_ip6 |=3D ((volatile __u8 *)&ctx->user_ip6[i])[3] << =
24;
> > +             user_ip6 |=3D load_byte_ntoh(ctx->user_ip6[i], 0, sizeof(=
user_ip6));
> > +             user_ip6 |=3D load_byte_ntoh(ctx->user_ip6[i], 1, sizeof(=
user_ip6));
> > +             user_ip6 |=3D load_byte_ntoh(ctx->user_ip6[i], 2, sizeof(=
user_ip6));
> > +             user_ip6 |=3D load_byte_ntoh(ctx->user_ip6[i], 3, sizeof(=
user_ip6));
> >               if (ctx->user_ip6[i] !=3D user_ip6)
> >                       return 0;
> >       }
> >
> >       user_port =3D 0;
> > -     user_port |=3D ((volatile __u8 *)&ctx->user_port)[0] << 0;
> > -     user_port |=3D ((volatile __u8 *)&ctx->user_port)[1] << 8;
> > +     user_port |=3D load_byte_ntoh(ctx->user_port, 0, sizeof(user_port=
));
> > +     user_port |=3D load_byte_ntoh(ctx->user_port, 1, sizeof(user_port=
));
> >       if (ctx->user_port !=3D user_port)
> >               return 0;
> >
> >       // u16 narrow loads:
> >       for (i =3D 0; i < 4; i++) {
> >               user_ip6 =3D 0;
> > -             user_ip6 |=3D ((volatile __u16 *)&ctx->user_ip6[i])[0] <<=
 0;
> > -             user_ip6 |=3D ((volatile __u16 *)&ctx->user_ip6[i])[1] <<=
 16;
> > +             user_ip6 |=3D load_word_ntoh(ctx->user_ip6[i], 0, sizeof(=
user_ip6));
> > +             user_ip6 |=3D load_word_ntoh(ctx->user_ip6[i], 1, sizeof(=
user_ip6));
> >               if (ctx->user_ip6[i] !=3D user_ip6)
> >                       return 0;
> >       }
> > diff --git a/tools/testing/selftests/bpf/progs/bind_prog.h b/tools/test=
ing/selftests/bpf/progs/bind_prog.h
> > new file mode 100644
> > index 0000000000000..0fdc466aec346
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bind_prog.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __BIND_PROG_H__
> > +#define __BIND_PROG_H__
> > +
> > +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> > +#define load_byte_ntoh(src, b, s) \
> > +     (((volatile __u8 *)&(src))[b] << 8 * b)
> > +#define load_word_ntoh(src, w, s) \
> > +     (((volatile __u16 *)&(src))[w] << 16 * w)
> > +#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > +#define load_byte_ntoh(src, b, s) \
> > +     (((volatile __u8 *)&(src))[(b) + (sizeof(src) - (s))] << 8 * ((s)=
 - (b) - 1))
> > +#define load_word_ntoh(src, w, s) \
> > +     (((volatile __u16 *)&(src))[w] << 16 * (((s) / 2) - (w) - 1))
> These names, load_byte_ntoh() and load_word_ntoh(), are miss-leading.
>
> They don't actually do byte-order conversion from network order to host
> order. Network order is big endian. 0xdeadbeef in u32 should be stored
> as the sequence of
>
>    0xde, 0xad, 0xbe, 0xef
>
> The little endian implementation of load_word_ntoh() provided here will
> return 0xadde and 0xefbe0000. However, a network order to host order
> conversion should return 0xbeef and 0xdead0000 for little endian.
>
> The little endian implementation of load_byte_ntoh() here returns 0xde,
> 0xad00, 0xbe0000, and 0xef000000. However, a network to host order
> conversion should return 0xef, 0xbe00, 0xad0000, and 0xde00000.
>
> So, they just access raw data following the host byte order, not
> providing any byte order conversion.
>
>
> > +#else
> > +# error "Fix your compiler's __BYTE_ORDER__?!"
> > +#endif
> > +
> > +#endif

