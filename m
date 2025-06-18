Return-Path: <linux-kselftest+bounces-35246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538BDADE080
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 03:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E6717C51D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0B18A6A5;
	Wed, 18 Jun 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf4hpB4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D5186294;
	Wed, 18 Jun 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209395; cv=none; b=O3ZspbkjQsZP5y98mY5UtnstbLBY4vHZy2q0SUbU99uWPDlm7KNIpwDUWqJjFuMz9E1DLy7dkZ4Mw3WL7qxEqQDmFuZBqm3AjcWDn9roMQyNAVa6P7iDP/bq/ErlB5cuDQJtbsxhGyO930omcNN70EEGJ8jxojd81oBLaxAg5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209395; c=relaxed/simple;
	bh=SBDJcf09SwcwG06z/rkKrsCcFxSZMbyKPtB+DVPGYhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZvXDo/kHFf5dYrB2id6FS9qqkQidMYD8Q9UL66nntmHakD0OkEPKv1bBMkjD7bVy5HOq9nnNXHb2qMrwlzL+AU/WEMMCETERVBhmfcgPxS0IYQ6dy5XWGdCP7GE2uXrNcCrT1SQ/jGECtH7cPj/DwtsMwCJyg5I5XiP2QPd8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf4hpB4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C92BC4CEF4;
	Wed, 18 Jun 2025 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750209395;
	bh=SBDJcf09SwcwG06z/rkKrsCcFxSZMbyKPtB+DVPGYhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wf4hpB4tJy8O25elPcp4jElL23bQfdMwbL9Fk3DmQrcmWBKK9JoS1aGKpV/gSEWpy
	 8yTAdqLARCWZNz18qgoio2PISfKsdbaB0z1DzTfJkSQKLCdEBuhnBIga8kmBrXGIg+
	 Ojl3wCJ/C9gfzhG0hnj2cdWK1YZ7r/cgmv5CGqOyTd15Wl6nyPwCcc7dduhxtcZGYa
	 GjaphDhlBvxuPa9vOFq7auClfHBnSr+lcZANi574+eM4D169J9HwYr9/diRwKWoVvx
	 C7wl8SyebWKZMYO62StGWDp4t+LWunxvD0TZUYU9qL5AwwNhC+5+ppZqPYvsdVEFGj
	 QEDF42xpUloGg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553bcba4ff8so3358872e87.2;
        Tue, 17 Jun 2025 18:16:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUljt6RYt1NXImKKctjMcw2aJiFpN0iCwOrtqVe4Oa6bCmpPoc9AmRPNCSxuFnkaf6aR2Lfq9UQyHoi7RR4@vger.kernel.org, AJvYcCVVsJ0k/tD80rqvK3kvPjlfkNo+oGvDz7b56XyhgvEWUiUvo2cx0Cy5+O6VeSkrDMeQ1uB4k4CwKtA=@vger.kernel.org, AJvYcCVXhkaYGbjq9VYr6++sg2iqn9gcqd/sqqlD/UsavkbDhLU0AU5wapHRg21kwWJLUs1tqmk77hbx4qnf+q9ycA6G@vger.kernel.org, AJvYcCWravQNrMct1F9N8BcHvkcFUCPdmrUFqnXBavH7CFyw8QvsDpk6Vevx1+iGjWg9Mqjde/HM5pDGIivRlNNR@vger.kernel.org, AJvYcCXPpEHT2uXcVH/GJQqPpnNUBFFiuHNR6uTfvkrUURX11gCkw9GmrVdIHUWRpJ5jep0mLERDpwDU3Kkp@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbo1V3dJ7W01KxCYIfohwUTJdjXMpGFvoeR+CiTgalwNwzVV5
	AB28Xn381WjioC/D4/9IPRZz2O4xqXyGEdts4Wo7Qm4sjnWQyhKoMSCAHnev2IvT8P0OFlGx/+A
	AIcO1tk1cg4112+cr1dk0hy7RYTpIPz4=
X-Google-Smtp-Source: AGHT+IFiIfr5F6VDkk3G3Oh9AbB4n2HtzYAJy/s+BIZll9kvq4oJWZgFM8XLjVs97si6LTR33fQZ3chGvUAjn7TxohA=
X-Received: by 2002:a05:6512:39d3:b0:553:3073:c38b with SMTP id
 2adb3069b0e04-553b6e734c9mr3786666e87.1.1750209393856; Tue, 17 Jun 2025
 18:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-4-55e3d148cbc6@linutronix.de>
 <CAK7LNAQUN3hWYh_1=LMzVp1Ddbq3W=yGHZ5__LbcfBajfuhscg@mail.gmail.com> <20250617095102-d3df1c46-3d51-4f77-af0a-8299f5e71ad9@linutronix.de>
In-Reply-To: <20250617095102-d3df1c46-3d51-4f77-af0a-8299f5e71ad9@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 18 Jun 2025 10:15:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASe0aQdO1m6sUQXEkYxgXT+_2xOVnX4x4f4V4adpaeZ0w@mail.gmail.com>
X-Gm-Features: AX0GCFvJl9wi9pNxHMzc9efbA-PWAwWgE5oc_vBzkXhWJDp4BubPAbGKLKZ0oL4
Message-ID: <CAK7LNASe0aQdO1m6sUQXEkYxgXT+_2xOVnX4x4f4V4adpaeZ0w@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] kbuild: userprogs: add nolibc support
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

On Tue, Jun 17, 2025 at 4:59=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Jun 17, 2025 at 12:35:07AM +0900, Masahiro Yamada wrote:
> > On Wed, Jun 11, 2025 at 4:38=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > Userprogs are built with the regular kernel compiler $CC.
> > > A kernel compiler does not necessarily contain a libc which is requir=
ed
> > > for a normal userspace application.
> > > However the kernel tree does contain a minimal libc implementation
> > > "nolibc" which can be used to build userspace applications.
> > >
> > > Introduce support to build userprogs against nolibc instead of the
> > > default libc of the compiler, which may not exist.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > >
> > > ---
> > > This could probably be moved out of the generic kbuild makefiles.
> > > I think the ergonimics would suffer and this functionality could be
> > > used by other users of userprogs.
> > >
> > > Also this does currently not support out-of-tree builds.
> > > For that tools/include/nolibc/*.h and usr/include/*.h would need to b=
e
> > > installed into the build directory.
>
> <snip>
>
> > > --- a/scripts/Makefile.userprogs
> > > +++ b/scripts/Makefile.userprogs
> > > @@ -16,10 +16,17 @@ user-csingle        :=3D $(addprefix $(obj)/, $(u=
ser-csingle))
> > >  user-cmulti    :=3D $(addprefix $(obj)/, $(user-cmulti))
> > >  user-cobjs     :=3D $(addprefix $(obj)/, $(user-cobjs))
> > >
> > > +user_nolibc_ccflags :=3D -nostdlib -nostdinc -static -fno-ident -fno=
-asynchronous-unwind-tables \
> > > +                     -ffreestanding -fno-stack-protector \
> > > +                     -isystem $(objtree)/usr/include -include $(srct=
ree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc=
/
> >
> > The tools/ directory is a different world, and Kbuild scripts do not kn=
ow
> > anything about it.
>
> Ack.
>
> How does this statement affect the next patch which creates
> tools/include/nolibc/Kconfig.nolibc ?
> Is it fine to create the Kconfig file in tools/ or should I move it?
> I do want to maintain this file as part of nolibc and not KUnit.
> The possibilities I see are init/Kconfig.nolibc or lib/Kconfig.nolibc.

Personally I like init/Kconfig.nolibc.
(I am even fine with adding this new entry to init/Kconfig)
But, this file is not what I maintain. It is up to you after all.



> > And, you do not need to implement this in scripts/Makefile.userprogs
> > because you can move this to lib/kunit/Makefile.kunit-uapi or somewhere=
.
>
> Understood. This is not unexpected, as hinted in the commit message.

One existing example is lib/vdso/Makefile.include, which is included
from multiple Makefiles.





> > > +user_nolibc_ldflags :=3D -nostdlib -nostdinc -static
> > > +
> > >  user_ccflags   =3D -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(usercc=
flags) \
> > > -                       $($(target-stem)-userccflags)
> > > -user_ldflags   =3D $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-s=
tem)-userldflags)
> > > -user_ldlibs    =3D $(userldlibs) $($(target-stem)-userldlibs)
> > > +                       $($(target-stem)-userccflags) $(if $($(target=
-stem)-nolibc),$(user_nolibc_ccflags))
> > > +user_ldflags   =3D $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-s=
tem)-userldflags) \
> > > +                       $(if $($(target-stem)-nolibc),$(user_nolibc_l=
dflags))
> > > +user_ldlibs    =3D $(userldlibs) $($(target-stem)-userldlibs) \
> > > +                       $(if $($(target-stem)-nolibc),$(user_nolibc_l=
dlibs))
> > >
> > >  # Create an executable from a single .c file
> > >  quiet_cmd_user_cc_c =3D CC [U]  $@
>
>
> Thomas


--
Best Regards
Masahiro Yamada

