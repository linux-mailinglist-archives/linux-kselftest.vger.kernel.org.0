Return-Path: <linux-kselftest+bounces-27978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C295A4B3AB
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 18:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F91188DCDA
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322C1E5B9B;
	Sun,  2 Mar 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8BFewXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D5192B86;
	Sun,  2 Mar 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935223; cv=none; b=YiG9L0CcEuAkXEzrAvZNDuE72nf0IWSQBmKvOsx2VHp74dEKC5NSH2qRzfA5zEtB0acg5AimwapSSHTK9teRxY5zbZOetVRp1fAhrRC76CKzwy3eil/D88U/ikF+FSFPB0JAbduygVcfWX4byYPYmhy9caf93WSz2tWkq54S41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935223; c=relaxed/simple;
	bh=EReg4R5/Rp429iFWUy0ALvUUqMENRJdRYvt/qHX8jYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzUMHwQxfHeiCBHl2WkP1z98WqQJzHA9HDa5I5O/uR5kztJrRHzEzHg5skWP+UwNZ9nfFQmgrVLrztxQykdqI4QhMmhcaj+mqPwBe1WkPrCPJ4dRafUkLwSTgXLiaUDZvaKMjHbr3kcZ2cs4f+HFxe074LFv78ESFrqmb0Q0yKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8BFewXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D348C4CEED;
	Sun,  2 Mar 2025 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740935222;
	bh=EReg4R5/Rp429iFWUy0ALvUUqMENRJdRYvt/qHX8jYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k8BFewXmjp8nr15qQirwsCwOZB3jMil0eAlxngKkih998mTPPE6ah3XhuWSfFGYdP
	 qhpl8LI2kbsUptMjsCOoe30FJbkHvCX6yKiDXcemoNf2HnYBsRr0HjJD2Xg0B+lMIH
	 pFifxnqAdbZ+cyNVPjW52ruRW/meyVyk2CN6nUH1189E/JquvUHXRucVVm2ZbYwkc9
	 Jxb8dPt4eI/jHLGOXo0A5QUR0GDo5jzqWA5dfPhhopYZXhw3lHABl/BadE0rv35maT
	 urWdhXEn+zh6sziG+CIfQsrzOQNxbvnNnDBUW5m8kgedWoZ3j+cJDLwO0Ien0NsLhO
	 Nfie3IN2JQeiw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54959d1a856so1150288e87.1;
        Sun, 02 Mar 2025 09:07:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpzu8rCJlH8OMbuEJDX1eeLJc829ygAgN7sEvXfoRWRofPKmru+UYZhjh/ZILoFZbBWN5gbJXvniz8kSb6@vger.kernel.org, AJvYcCW53erx15DFJIiTaFskxSRVUTWFenG+i+nQ9OO6HBB3UK3Q/4DNSxt/LpUVzC28JDtE+Q8+aepLs58kLpye@vger.kernel.org, AJvYcCXH2vuBIAAeAZYCbxxUh1tygAi+Lggn/erO8F11nKslt8gQA6cdNi266mQh1JH08cNsbeEHcV/tXyqL1R67fox0@vger.kernel.org, AJvYcCXxIiEo2+vr98jer+LeuV/rgWYmg2RULIMFHmtw1qbI6+jJYJ1P0wqFy2f39BUm1llDSF4hyRtEp7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwK0fSj+P/AVz5KYdMhlHjD8WX2nsPMkD3eKf0RGuWn/IxkmI
	Q1zbSLIHm7uGQCydTsS0Gch+tvKc6bpv89Kt6T8YMw3ghmYiGLapCY3vaL4H2OM1Z8poq3BTBke
	mKNwmn2pb75B0XHChca0tRnYY4Ls=
X-Google-Smtp-Source: AGHT+IElir4UZRbh6eakWHMwCbyJlB7kh1ylQHUkoTBffXIliqE/rAepGuSMYTfMVuTavoDbfUsApRL1WGX5Kxd1U8Q=
X-Received: by 2002:a05:6512:15a8:b0:545:81b:1516 with SMTP id
 2adb3069b0e04-5494c3283e2mr3854026e87.15.1740935220916; Sun, 02 Mar 2025
 09:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de> <20250217-kunit-kselftests-v1-1-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-1-42b4524c3b0a@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 3 Mar 2025 02:06:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASz86AM+zBo=7Jhvj4UOP0qDPKfq7XhN6FqHhx=rM3HwQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpYL88anSF5LNOcGhAezBfNqBNhOtM15GS3TKKB_NXTOGu8UPIseDNH6Pk
Message-ID: <CAK7LNASz86AM+zBo=7Jhvj4UOP0qDPKfq7XhN6FqHhx=rM3HwQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] kconfig: implement CONFIG_HEADERS_INSTALL for
 Usermode Linux
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Joe Perches <joe@perches.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To: Joe Perches for checkpatch.pl input


On Mon, Feb 17, 2025 at 8:00=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> userprogs sometimes need access to UAPI headers.
> This is currently not possible for Usermode Linux, as UM is only
> a pseudo architecture built on top of a regular architecture and does
> not have its own UAPI.
> Instead use the UAPI headers from the underlying regular architecture.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile          | 5 ++++-
>  lib/Kconfig.debug | 1 -
>  2 files changed, 4 insertions(+), 2 deletions(-)


Can we add some checks to scripts/checkpatch.pl
for inappropriate commit subject prefixes?

I really want to see "kconfig:" used in the subject only
for changes under scripts/kconfig/.

I wonder if scripts/checkpatch.pl shows a warning
if "kconfig:" is used in the subject but nothing
under scripts/kconfig/ is changed.

People incorrectly use "kconfig:" prefix for random
"Kconfig"  file changes. I am fed up with pointing out
this silly stuff.

Apparently, this patch is not related to Kconfig at all.















>
> diff --git a/Makefile b/Makefile
> index b4c208ae4041c1f4e32c2a158322422ce7353d06..275185d2ff5d3dc99bd7982ab=
d1de85af0b9621a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1357,9 +1357,12 @@ hdr-inst :=3D -f $(srctree)/scripts/Makefile.heade=
rsinst obj
>
>  PHONY +=3D headers
>  headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archs=
cripts
> -       $(if $(filter um, $(SRCARCH)), $(error Headers not exportable for=
 UML))
> +ifdef HEADER_ARCH
> +       $(Q)$(MAKE) -f $(srctree)/Makefile HEADER_ARCH=3D SRCARCH=3D$(HEA=
DER_ARCH) headers
> +else
>         $(Q)$(MAKE) $(hdr-inst)=3Dinclude/uapi
>         $(Q)$(MAKE) $(hdr-inst)=3Darch/$(SRCARCH)/include/uapi
> +endif
>
>  ifdef CONFIG_HEADERS_INSTALL
>  prepare: headers
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06f6e3f7beec4bd086c00b412c83ac..60026c8388db82c0055ccd8b8=
ac8789d6b939b62 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -473,7 +473,6 @@ config READABLE_ASM
>
>  config HEADERS_INSTALL
>         bool "Install uapi headers to usr/include"
> -       depends on !UML
>         help
>           This option will install uapi headers (headers exported to user=
-space)
>           into the usr/include directory for use during the kernel build.
>
> --
> 2.48.1
>


--
Best Regards
Masahiro Yamada

