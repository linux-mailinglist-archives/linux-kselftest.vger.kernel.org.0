Return-Path: <linux-kselftest+bounces-35245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D65ADE079
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 03:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE79D189C37D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510401624FE;
	Wed, 18 Jun 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ORsYPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7CF9C1;
	Wed, 18 Jun 2025 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209286; cv=none; b=n77lBI2LqHivJWsyCmf+zRQ/iwQ2oJ1gK76zCIGQ2T/xDQFEkowhHjdnUkTpTFvhTG1pt5WCoVst3XfBiWl0lpxqKMM+6zX5S7GuomTsM8iJcnnJ4eM9m6QttXqKQ3To+ULGXJmHhArgoam1UAnkr633CK84xJ0tDgAI/2s+CzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209286; c=relaxed/simple;
	bh=h2YputM22TLsFmaGuZOmTSbK7C6G8IcXF/esgzdBeMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJrfryJUWY0hP4fs2idSyMZFKHCbt6UrEXclohaVUK0gevQLVrLsibDxV2RZKVMHY0TUY99LGnw7U10JycMp1DNcXMVHbH0WsBaf9/QAybuaZy3tgheYFK1eiIBxjM1kPuDfFVVeUVyhXVRbXgxYwsSpN1/0COlhETkg8/2TLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ORsYPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AAFC4CEF6;
	Wed, 18 Jun 2025 01:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750209285;
	bh=h2YputM22TLsFmaGuZOmTSbK7C6G8IcXF/esgzdBeMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2ORsYPKEf7Szaa3wjBCMWTtOLGDSCQvsfp9Bq5p3ne+H0+0t9jML5uuyaThHtceQ
	 Au5EvYAGNKSbukyDT5ZaoQXt92ToLL6dDSd+kVocG9cg3OtLfHAOj8WwGZ6tp2Mjx3
	 7DpgnMHpCU4SPSGkMwRC7AlzbZfuwYfEGHlCmUDvRSxL649gwsEjx61Jrujheo7rTp
	 qJ0m/s1OPMMJKW0Fm8sMTLdBFtzIuia2f/5YFBxLoaFla3VMVr7uCX2/29W+xwpeQU
	 QpXYUNz+RV2tVCo4jZsHYSPpdOFbcRPkh9Tj8SiJnNt/iCCptbBmLINW2ONw5bxPOp
	 1fkWuhAiISscA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso3944634e87.1;
        Tue, 17 Jun 2025 18:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr463HkX/HFYWwmWqS9woWwzRcfspfxJGBzDFoTNMr1n9KmFmsL5LAmHlsCvdjlhr23CLZOVs352I=@vger.kernel.org, AJvYcCVHYO9OFxaaWHNM2cauB42818Tf5UM9hjbPUPnOAlULCLwu+yObuaiHci9Mnir0pQ9pFcd6A5Uz9eQr4bw1@vger.kernel.org, AJvYcCVXn/MClVqyT8Z/lbfxbg8IlqMJ9hWroVt9Mk/s1AakhDr4jwFMDWXnpiqJfzTiJ6KgiRzcQBiXuoXx@vger.kernel.org, AJvYcCWI83DaMlda8JCbKF5uUHekLmd35JG5OtjdWZ3tAcEc4bZMOgek9REvUutjf2+lD9dM48I/GNnmFqQ2bEDA@vger.kernel.org, AJvYcCWRoOya3tyvJo7A+Tz2okzmOP0lvAI3ZcMB06GLWCnfPAsLdRjGDqsN22kYeWKaTBxyb7ORfrvTlnLUDRNMHVmG@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5cPXBQIMDBwCM8sPhmFBRfYaoIbjN+a7xWfqrLzzOCyQQCZt
	QKV1WHTD0nuUkvli++1I6sHye9V+sBFLi4CLDWyJ5D/PjdlVhvjukZqMdvP9ILp8yVtz51+uGE9
	6BmBg+R/aYSrZZwoUxEJDUQzhbJ8cbNI=
X-Google-Smtp-Source: AGHT+IE7MRJL1Yw0xIAiT0g6qe8cPzPnAw/z8vD2sHRVWPnU9T42hH7IJfTK5kp8NNXpkwOUOaUNXTzluaBXDYEml0s=
X-Received: by 2002:a05:6512:3b8b:b0:553:2ed1:ab1e with SMTP id
 2adb3069b0e04-553b6f4cc5cmr3710057e87.46.1750209284091; Tue, 17 Jun 2025
 18:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-2-55e3d148cbc6@linutronix.de>
 <CAK7LNATuk_tpDAq07e5oSU4FptRO_88Oxh2=W=3YmBotbGuU5g@mail.gmail.com> <20250617093523-e7f54d95-96d0-4411-92d6-dd80fe84ee98@linutronix.de>
In-Reply-To: <20250617093523-e7f54d95-96d0-4411-92d6-dd80fe84ee98@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 18 Jun 2025 10:14:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARr-ypWkNR52-my2WJFQ3b26EGV===J8b1MROLuf31oRw@mail.gmail.com>
X-Gm-Features: AX0GCFv7u6eSzDMgQ1fz3QLMoGrvpETTxg10qNUIysrWURln8hEL4ilzYDnFugA
Message-ID: <CAK7LNARr-ypWkNR52-my2WJFQ3b26EGV===J8b1MROLuf31oRw@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] kbuild: userprogs: also inherit byte order and
 ABI from kernel
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 4:39=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Mon, Jun 16, 2025 at 11:49:41PM +0900, Masahiro Yamada wrote:
> > On Wed, Jun 11, 2025 at 4:38=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > Make sure the byte order and ABI of the userprogs matches the one of =
the
> > > kernel, similar to how the bit size is handled.
> > > Otherwise the userprogs may not be executable.
> > > This happens for example on powerpc little endian, or riscv32.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > > ---
> > >  Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5=
610e45a2807dfa257f4 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
> > >  LDFLAGS_vmlinux        +=3D --emit-relocs --discard-none
> > >  endif
> > >
> > > -# Align the bit size of userspace programs with the kernel
> > > -USERFLAGS_FROM_KERNEL :=3D -m32 -m64 --target=3D%
> > > +# Align the bit size, byte order and architecture of userspace progr=
ams with the kernel
> > > +USERFLAGS_FROM_KERNEL :=3D -m32 -m64 -mlittle-endian -mbig-endian --=
target=3D% -march=3D% -mabi=3D%
> > >  KBUILD_USERCFLAGS  +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_=
CPPFLAGS) $(KBUILD_CFLAGS))
> > >  KBUILD_USERLDFLAGS +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_=
CPPFLAGS) $(KBUILD_CFLAGS))
> >
> >
> > Why didn't you do like this?
> >
> > USERFLAGS_FROM_KERNEL :=3D $(filter -m32 -m64 -mlittle-endian
> > -mbig-endian --target=3D% -march=3D% -mabi=3D%, $(KBUILD_CPPFLAGS)
> > $(KBUILD_CFLAGS))
> > KBUILD_USERCFLAGS  +=3D $(USERFLAGS_FROM_KERNEL)
> > KBUILD_USERLDFLAGS +=3D $(USERFLAGS_FROM_KERNEL)
>
> The idea was to keep the USERFLAGS_FROM_KERNEL line free of clutter, as i=
t is
> probably going to change more often. To improve reviewability and gain so=
me
> available horizontal space in case it should be needed at some point.
>
> If you prefer the other layout I'll be happy to switch it around.


$(filter ... $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))

is duplicated in the two lines.

That is the reason for my suggestion.



--=20
Best Regards
Masahiro Yamada

