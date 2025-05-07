Return-Path: <linux-kselftest+bounces-32564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5CAADEB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3558188422B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B48259CB2;
	Wed,  7 May 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJWozJ2H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A4221FB3;
	Wed,  7 May 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619839; cv=none; b=jTtOXxaMe/uch/AO//8MIb+6N2Xm1iSnphAoqfz1lISYriEfSbYkspX83snH403Yk98qLZL9FJ4TQNUprwRzjzmsQJ6Oiq7m5kUUazMU1Vq+Nxh0P42OupeLD1+bOJWs6mMyUTEgl4sPzxmVRw0qC+bF8HSvCLQTpIa5GDIqqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619839; c=relaxed/simple;
	bh=+tyZGvu9GnVjrLuiIyr6ilOOdP2dGHfUKje1V0MzKKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmuiti5vY5kAHgx7rDHAXyPPCfwEyb/ylerGKlbnwrUg9BDXraaTgK+55c+xYor0ZlZ/pWKc0cVlSGBJE/ESXaNZKX2Ya5xtOZ4yd7AZpPr6LcsI0X66k4YxjEoh73BclaHcNm4KpAcyl5Hpfz3mvUoHFw1aV6S+O73FIPp5Vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJWozJ2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55769C4CEEB;
	Wed,  7 May 2025 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746619838;
	bh=+tyZGvu9GnVjrLuiIyr6ilOOdP2dGHfUKje1V0MzKKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LJWozJ2HqBbv3/C4a46T5qIYkv8ZiDtsW1yuLh0xtwHmcMb65TWzbo2rVZZsZ+Z/r
	 bxWQlXZ182eqLQJRF+d52l3mSVGnQZAoSPp6fNFwGP/DOaKUcYq2cQtfm1MR+4+odh
	 zb41JSB4vuLj11BWZcVdSU74znL4uooVgI/enOX2HlU/gQ/qix/FDg2zPr7Y6fLXq9
	 sxkzGMpy2EjCjj4TJUCOb72d/AgH2qRsNQTR76AgrZEJ6b+CKajBglDGoyLUQmuuCg
	 CDK9ls0VXebrXXkjU06hwUTemBDfqFLwacs63qczwDuPdUG5dZjS0jC7r/RemmEjOM
	 C/j79iPq5Snpg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3105ef2a071so70837111fa.1;
        Wed, 07 May 2025 05:10:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrofXmgctCuUVNuq+BNOKtEfpOIWMu1X504nyJwmHDqiTravuehfXnxgYu9naySW9KmEiIwAWun99XIi4=@vger.kernel.org, AJvYcCVNtWwRd2I8oOAk7ta0kTKGAKRHVesWZSILdRzQAKIfRLvZbJ2cA3ncOzzZ4At3dC1fm4pLpfXGAUbVX81YhW2W@vger.kernel.org, AJvYcCXKy/vchoHeRDo82Vv/EzMljqjH0LILVeVLkKQdZq36BLJk1qNc2MDut8Eev//9ztZjRqVBq9PxTdsiXzfa@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTG+rBlMrPblS8MDeuxd0LxZHGSQF25wxHtwwN7cHsMSXsnIj
	2vHBksm7xr0X94s1PMa6j/ZbFpukldLoJbhMofcliDAzXx/Eb+2QVxIpbmfWKfm+BxipOIJysj0
	u4JeU2TtP6DCjYyOkOuqJtAtESq8=
X-Google-Smtp-Source: AGHT+IEhOnKIW8Malmv/rXIb54yBHHePhpOVW2lpLBytQvNsR/jNwH/hb7ndGKk1lsTbL3LOydq29GJRGeEAIhrsjCY=
X-Received: by 2002:a05:651c:3134:b0:30c:5c6:91e0 with SMTP id
 38308e7fff4ca-326ad15e2d3mr11394041fa.2.1746619837058; Wed, 07 May 2025
 05:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502172459.14175-1-skhan@linuxfoundation.org>
 <20250506-accomplished-earthworm-from-valhalla-dbcbcc@l-nschier-aarch64> <0d27886e-5a3c-4073-a044-f6684de8333d@linuxfoundation.org>
In-Reply-To: <0d27886e-5a3c-4073-a044-f6684de8333d@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 7 May 2025 21:09:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiBqegnGEOoiayLz2SsyX8bQROGSgXQ7o-ZjcCuyCUew@mail.gmail.com>
X-Gm-Features: ATxdqUEKfhoizKUsGm35ZQH3MxleUrqdVI_H0HY9LRzFaEKtSUx52LtqKLyUyeQ
Message-ID: <CAK7LNARiBqegnGEOoiayLz2SsyX8bQROGSgXQ7o-ZjcCuyCUew@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use ARCH from compile.h in unclean source tree msg
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, nathan@kernel.org, brendan.higgins@linux.dev, 
	davidgow@google.com, rmoar@google.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:07=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/6/25 05:12, Nicolas Schier wrote:
> > On Fri, 02 May 2025, Shuah Khan wrote:
> >
> >> When make finds the source tree unclean, it prints a message to run
> >> "make ARCH=3Dx86_64 mrproper" message using the ARCH from the command
> >> line. The ARCH specified in the command line could be different from
> >> the ARCH of the existing build in the source tree.
> >>
> >> This could cause problems in regular kernel build and kunit workflows.
> >>
> >> Regular workflow:
> >>
> >> - Build x86_64 kernel
> >>      $ make ARCH=3Dx86_64
> >> - Try building another arch kernel out of tree with O=3D
> >>      $ make ARCH=3Dum O=3D/linux/build
> >> - kbuild detects source tree is unclean
> >>
> >>    ***
> >>    *** The source tree is not clean, please run 'make ARCH=3Dum mrprop=
er'
> >>    *** in /linux/linux_srcdir
> >>    ***
> >>
> >> - Clean source tree as suggested by kbuild
> >>      $ make ARCH=3Dum mrproper
> >> - Source clean appears to be clean, but it leaves behind generated hea=
der
> >>    files under arch/x86
> >>      arch/x86/realmode/rm/pasyms.h
> >>
> >> A subsequent x86_64e build fails with
> >>    "undefined symbol sev_es_trampoline_start referenced ..."
> >>
> >> kunit workflow runs into this issue:
> >>
> >> - Build x86_64 kernel
> >> - Run kunit tests:  it tries to build for user specified ARCH or uml
> >>    as default:
> >>      $ ./tools/testing/kunit/kunit.py run
> >>
> >> - kbuild detects unclean source tree
> >>
> >>    ***
> >>    *** The source tree is not clean, please run 'make ARCH=3Dum mrprop=
er'
> >>    *** in /linux/linux_6.15
> >>    ***
> >>
> >> - Clean source tree as suggested by kbuild
> >>      $ make ARCH=3Dum mrproper
> >> - Source clean appears to be clean, but it leaves behind generated hea=
der
> >>    files under arch/x86
> >>
> >> The problem shows when user tries to run tests on ARCH=3Dx86_64:
> >>
> >>      $ ./tools/testing/kunit/kunit.py run ARCH=3Dx86_64
> >>
> >>      "undefined symbol sev_es_trampoline_start referenced ..."
> >>
> >> Build trips on arch/x86/realmode/rm/pasyms.h left behind by a prior
> >> x86_64 build.
> >>
> >> Problems related to partially cleaned source tree are hard to debug.
> >> Change Makefile to unclean source logic to use ARCH from compile.h
> >> UTS_MACHINE string. With this change kbuild prints:
> >>
> >>      $ ./tools/testing/kunit/kunit.py run
> >>
> >>    ***
> >>    *** The source tree is not clean, please run 'make ARCH=3Dx86_64 mr=
proper'
> >>    *** in /linux/linux_6.15
> >>    ***
> >>
> >> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> >> ---
> >>   Makefile | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 5aa9ee52a765..7ee29136b4da 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -674,7 +674,7 @@ ifeq ($(KBUILD_EXTMOD),)
> >>               -d $(srctree)/include/config -o \
> >>               -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then =
\
>
> Would it make sense to check for include/generated as a catch all?
>
> >>              echo >&2 "***"; \
> >> -            echo >&2 "*** The source tree is not clean, please run 'm=
ake$(if $(findstring command line, $(origin ARCH)), ARCH=3D$(ARCH)) mrprope=
r'"; \
> >> +            echo >&2 "*** The source tree is not clean, please run 'm=
ake ARCH=3D$(shell grep UTS_MACHINE $(srctree)/include/generated/compile.h =
| cut -d '"' -f 2) mrproper'"; \
> >
> > Please 'grep' option '-s'.
> >
> > There are some (rare) occassions, when there is no include/generated/co=
mpile.h
> > but still the source tree will be considered to be dirty:
>
> I considered adding a check for not finding include/generated/compile.h
> and figured if include/config is found we are probably safe.
>
> I will fix that.

Does this fix your issue?

https://patchwork.kernel.org/project/linux-kbuild/patch/20250507074936.4866=
48-1-masahiroy@kernel.org/




--=20
Best Regards
Masahiro Yamada

