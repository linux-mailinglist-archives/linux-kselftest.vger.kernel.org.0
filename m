Return-Path: <linux-kselftest+bounces-44856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79828C38643
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 00:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4929A4E03D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E82F6170;
	Wed,  5 Nov 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ixblNQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C302D7DD9
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386211; cv=none; b=prkknv26YQGnMtVuQxlnGg//VJF2akurgGOe3WQzsxslCdffkMyYbkrL4S6uIuRtZQR0c8dZG0QIrKtbOkRE/Rf/M0y91ygtmHPfbOnZ9i8qTZAux9D7coY0fOBXh/Fa3l0FGQy7BgHlGGUIXgGXFEGkmXOb3i0HunvotL15awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386211; c=relaxed/simple;
	bh=Ak0a/MofXeKeQ+l3St4/37wwo2EI1oYqy7US8b0zxnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTWbEDBAE88H4LWRM0SzakFS7rLG1s88YWo96ZF7n92nzRWvOCwCjgDB+/0sg2deolnErTqGkM50k13FBdkl2LKAIh5R8OBIjPSxoyzr/RsZ+B9KmYBhDJiwN/dv99KMeC3dGNXqiCMnmoy8FDV0s2J8kAChjwgj9zzIyQ1pYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ixblNQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c19b5de4so288402f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762386207; x=1762991007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=N3ixblNQvBxpfJ6LwigQOd6qlBzlThhsyTAAjhyiAU1g6RZQvrm1pXEtma51wD5dqH
         3VAuloJDwk3o0HuVegYYfokIC2/S+J+lZCvpe+iJ0V1YZ5xsiwN6SZKQDmR7qK6xaxiC
         KkOO2dD+Gg9rJl3872bVYN1dQLgArfal6b1pQQEMfUVuxOej4t6wR808ekACKRwJFwTk
         EJ90KVGfHGTG8YGtAt6yJz7QcplgoHsq4V3wJ1CqvREsJtrd97mTeeMGyKmRNoOQQoQw
         Rj7xa4bB1e7R+rkvd3FfSzAxJbDEVPfDzbsdN4WS/04+jMB/rZJuA0P5j+xJqOsbFu66
         pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762386207; x=1762991007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=Q8iKCHbLQ4c5ESbltC9ev6Oi0Vza/7hZz3jKu7UxtFcnJI5pzfTe8/Q7FReCgJkdVl
         bSs+vq5HGxjCvEJmNDnWPteamm0QbQsWlkWEJSowQjlf9bkRTsnMYvfrjhRK5+Mo/pKW
         X472UC6DbArLPaVCzt5uFnI4M2iuDtGTHrip7iV9mBq71YcDAYgHy1lA7mHPCwvx8uRc
         WjWVFcHK2iuGCynA+5aob25GH4XKTUXwyw6V3OO10Z6Ik0vteQmdmspTGRbSaPb5okxu
         +ZiF3NnDXHtUZ7FlVBxwZCv74i34v6POjwG3VDvfZWYc1NlEHCk1cFINjel486Z4nqRw
         8gYg==
X-Forwarded-Encrypted: i=1; AJvYcCXzXeMQgxMweRUcpLPke+WF5wMfk/OjNl9lbG3u4szUg60d9QPLbKzHaMwH1rDVYZACGofgVZ89ucclzuYx1EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIHReH+2X7zUpNbARwpORcRFIfNG31p3Ose+XR/ugYIyB+FHh
	Ueivv6Fj1xWUF130p0d65emmckOAM7DZ0GeJNcY7u2ezfpagY4TNWunMfP2tuevL7iEOmrXYdUG
	hoxAMNUheMCnFboAFxMHlaSvfxEBXwfU=
X-Gm-Gg: ASbGncsGwp8OtSFQa/3xaqoMUTkoH4fCe8qC3QgxYB2faFzTgikPTwxs6EpFYNnwYZV
	037rVAaPc7iLYjSYWNc0YwMYypj6i3MsJZ2+VumNOBE9t/QhpEGQd2b0N7tQmHb0vZushIS6nM6
	Jv2t/VWu114elc9Zh14Cqoi14f4UsYkf58p2xWcQe+KJOVu7c4Ne/hs7HBHywwqhxxlWKbvisJY
	BGAKEWxwfGVfpUj9d9QuM1r9gqx3g8etyaWhVN565ju9dqOuj4r3FpZSw/2M5BAK02rdCrk2Hin
	3Ny/waGwq4omVsfHXA==
X-Google-Smtp-Source: AGHT+IHy2tfHNgJ6cQpCodGNfGYWTZ5F1i/eU0t3ocsIu6em6NiXgoAdtiWwWZT/GQIXmPMwErZiV6BOsWuGXGX8nJc=
X-Received: by 2002:a05:6000:230e:b0:429:d170:b3ac with SMTP id
 ffacd0b85a97d-429e32dd82cmr5292052f8f.13.1762386207144; Wed, 05 Nov 2025
 15:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com> <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
In-Reply-To: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:43:15 -0800
X-Gm-Features: AWmQ_bndYwW94kW--NSZQuJg-9ElD91TnXSYs-Z0mmovjayEfLI3uc8pkBOaK5I
Message-ID: <CAADnVQL91xsujXt4GWjgCYC+PdBC-2ZH6GqefXws_YHiL7B7Sg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse=
.com> wrote:
> > > > >
> > > > > The netif_receive_skb BPF program used in snprintf_btf test still=
 uses
> > > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper=
 is
> > > > > available and provides the same functionality.
> > > > >
> > > > > This commit refactors the test to use the bpf_strncmp helper, rem=
oving
> > > > > the redundant custom implementation.
> > > > >
> > > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > > ---
> > > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------=
------
> > > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.=
c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > @@ -31,19 +31,6 @@ struct {
> > > > >         __type(value, char[STRSIZE]);
> > > > >  } strdata SEC(".maps");
> > > > >
> > > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > > -{
> > > > > -       const unsigned char *s1 =3D m1;
> > > > > -       const unsigned char *s2 =3D m2;
> > > > > -       int i, delta =3D 0;
> > > > > -
> > > > > -       for (i =3D 0; i < len; i++) {
> > > > > -               delta =3D s1[i] - s2[i];
> > > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > > -                       break;
> > > > > -       }
> > > > > -       return delta;
> > > > > -}
> > > > >
> > > > >  #if __has_builtin(__builtin_btf_type_id)
> > > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)    =
               \
> > > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void=
 *m2, size_t len)
> > > > >                                        &_ptr, sizeof(_ptr), _hfla=
gs);   \
> > > > >                 if (ret)                                         =
       \
> > > > >                         break;                                   =
       \
> > > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_S=
TRSIZE); \
> > > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _exp=
ectedval); \
> > > >
> > > > Though it's equivalent, the point of the test is to be heavy
> > > > for the verifier with open coded __strncmp().
> > > >
> > > > pw-bot: cr
> > >
> > > I double checked that before acking, the test was added as a part of =
[1].
> > > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > > And it's not that heavy in terms of instructions budget:
> > >
> > > File                     Program                  Verdict  Insns  Sta=
tes
> > > -----------------------  -----------------------  -------  -----  ---=
---
> > > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     =
629
> >
> > Is this before or after?
> > What is the % decrease in insn_processed?
> > I'd like to better understand the impact of the change.
>
> That's before, after the change it is as follows:
>
> File                     Program                  Verdict  Insns  States
> -----------------------  -----------------------  -------  -----  ------
> netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
> -----------------------  -----------------------  -------  -----  ------
>
> So, the overall impact is 18K -> 4K instructions processed.

It's large enough impact for the verifier.
I agree that the test was mainly focusing on testing
bpf_snprintf_btf(), but it has a nice side effect by testing
bounded loops too.
I prefer to keep it as-is.

