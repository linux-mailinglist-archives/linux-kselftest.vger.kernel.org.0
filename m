Return-Path: <linux-kselftest+bounces-32553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1AAAD7DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488304E73C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3422258F;
	Wed,  7 May 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbMfKx3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E35214A6A;
	Wed,  7 May 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602620; cv=none; b=jp0UY8qnchS4lI8tHA6RJSBe3wGRDZJcdQxvKtTkWlMxTK8LfSCXOb1W3mW8MGb4Fzrk4/cfkGqYqmrmntFjxRzjTlKkqTkCrYWSdPvy8DMzvsO/n6sSuV/9KJCoubGh0AmRwz44sXF7YJvlCBSl/6xAT7VgEggermdCmIXvq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602620; c=relaxed/simple;
	bh=qkGjS0Z3odcYi1PQ5ov0nb2bIthIXGOvZtKQbulKMgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYVcda7EVRjFy+quCM9o5uERXcWJ28s0HUQNiu51WZNMrHG44M9WoLU3fIfYPNeGmYllqRRMIh9krk+Wp/blxb4KP6FEP/Fa4yNz5n7tnGkURjpcdmjqcChC0P+xYBQ+rALW5bJ2FFkAoTlTIVJR4mYbWM1FDVCdkKglMQ+WwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbMfKx3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CD5C4CEEF;
	Wed,  7 May 2025 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746602619;
	bh=qkGjS0Z3odcYi1PQ5ov0nb2bIthIXGOvZtKQbulKMgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XbMfKx3F4nwYvKQmWyeRJlpxdlwZYjTKpSrY1V3CWsQIUdipNE5L0LA6X3HCzgiSf
	 kv2yiO8GeobRwg8EW+c6+eVTwM2S8vlm53olgQCgXN+HwelqMw8W4QzB/KDvtg8v9l
	 nO2EUUVZyUrNk+ZfhJH408jjZ6+0UleDBwdaTNY4pC8I9o2OVRY+dCGKOFb4lxO27v
	 3TneaBr3ErkcvmaM8sWr1pcoue1Pa9x4gHEqfh+HVUqpuD43QSmZXQ9Ke5Knvv1pye
	 xFjgHjU99JoTLWu9ME3RebpZK5q6qi9b6RJ+IsxIHkvYYDTLz8AwCOaLBUliuOrsyJ
	 tc3IpOZHcpPyA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so58842591fa.2;
        Wed, 07 May 2025 00:23:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrQZbCJ7KWymqngJlNOo76eFH/QeiEftQLveczOf0pOFC3JhQxMkLC7eQprA7QC4/9Q5bOglxi0RV8Sf29@vger.kernel.org, AJvYcCWYlvfLJzClce8gpaYw58hS1dSu7+RgO22XTDIdButLakgThenS7+Wcz7xVsc5KThuaYp/hzae/AJxIqaM=@vger.kernel.org, AJvYcCXSn/WdRf0Y1pFR/UHmnv3/K6m7HF3xtcfPA9L3XFcDx03VEqrb9VpjhesiIxS6iK41KbFZNGNbc5mqoPnZkaPB@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhDBoamJs0BK7mtnTQlLlPCMXjT1IPtU+PRfX0LODmpMdKN9z
	pK7n3aE9F/qekYI+Em22/18pKc9csaTW1mrN0q8giiHoR/XKTDVl4JUunMqVV20EkMjS95V5OkC
	1v0llSQNI4ZujBcWJSJsn1PBI5QY=
X-Google-Smtp-Source: AGHT+IFdlxY48etyNtgMqb1VqL8Rny+QaAdqbf+HnVsBM8Ejm77bbWlRP/LMsPSDlMQIUpw5DHD6b8SV4CjljQDFSqQ=
X-Received: by 2002:a2e:a5c3:0:b0:30b:ecd6:b9d1 with SMTP id
 38308e7fff4ca-326ad33bbf2mr7318911fa.25.1746602618199; Wed, 07 May 2025
 00:23:38 -0700 (PDT)
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
Date: Wed, 7 May 2025 16:23:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTE62vNgW5bMhh8rA3=eDO5WoGGvt0N0AkNn3DFGR4bA@mail.gmail.com>
X-Gm-Features: ATxdqUElAFytn6rvTT7qH9uTADNnS3x-U4Y43h0T88Kk-MUKkGagJQalFhkryXQ
Message-ID: <CAK7LNATTE62vNgW5bMhh8rA3=eDO5WoGGvt0N0AkNn3DFGR4bA@mail.gmail.com>
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


I do not think this patch makes sense.

Kbuild correctly detects that "the source tree is not clean enough
to build with ARCH=3Dum", and displays the following message:
  ***
  *** The source tree is not clean, please run 'make ARCH=3Dum mrproper'
  *** in /linux/linux_srcdir
  ***

This is absolutely correct.


The real issue is that "make ARCH=3Dum mrproper"
does not properly clean the source tree.



--=20
Best Regards
Masahiro Yamada

