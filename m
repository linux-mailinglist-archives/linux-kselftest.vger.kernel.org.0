Return-Path: <linux-kselftest+bounces-19064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB99990F6B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B11428219E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7781DF720;
	Fri,  4 Oct 2024 19:00:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFF12F375;
	Fri,  4 Oct 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068420; cv=none; b=JfkYR28cg+2AudU0TDgTOCE0yUQ3duKG3+/qv1JlbKogUAaY8wPJvWVfL5+l7lkLR5SVWmfUOjq33qdJkC+gJZ6W+iHdpDz0QaY//KUsRL/EivE/P/E+2bYh5QYa1vTDQGDjMoS/AXx1ssWBi58hcVhX0KxUYhg0d+Ui+Act1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068420; c=relaxed/simple;
	bh=SOKYJYKzZbDHyOEtbIb1irA4DK+VBkWWqh78oJuf3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmwle0jRb8lDg8Lk4cv98GMg9YDXYMatyk/opYrOUwjRAWTzsdBQUmKSeVNVxyTKHFKNtNaUScwADGcVd0/wEDdFSX3rJIp4D2cN2M6ISzZx6Mb5qdj0HD4CItSdpbqhI6Ji97xxnkUXb8z0qr45VHKmlZAZOoyuOVmRsUgrOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb3ba0a9a2so15504126d6.2;
        Fri, 04 Oct 2024 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068417; x=1728673217;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkxm/OHPet7Zjw6QCsjdjVbVeK6Q7QSnuwybW1OxgWc=;
        b=kdJEdvvy7lfWMTwmE8BnmKpslvbA/PCH5hgpATtcPrYZcEoWPLxE2PSxTcPG/HKyUo
         hPrC4tcL9QiDrvCWZB7EqSBmZf0/ug9DYh6O6vIQ99NRGFCzwUknlV1uBSPit9cjIsFs
         NGPVz9onvza8WlIR11938D9NlckOKSnqQhOAvWTdbxzNrUH/nubvkaHgYriYdI8I2pjC
         /qmv+/sKOTPITOZfP/uvHgSHY/CyenjdxedMRKKfzoRecgPk/eaiya5Cgjnd/QFATgb4
         8oioNyg+tD+ugRrFGmGFGNmhP8JC4z8JV4iz3WkKb3GNJjG1WiorUonMp6maUhaZxJ6M
         uBww==
X-Forwarded-Encrypted: i=1; AJvYcCVInmUXG0pwjImXgINzxopwjoh6GO9kPeufV/kFE7Iu9d688EfDpnF/V3Ty7iQQ+0rA0Co=@vger.kernel.org, AJvYcCVZM9BhbejM7TDUkw2ixs9bE1M1AJEHMfNyUbe14Hlsh/SA76UnFdaukzueGg13edQfsf0A30OdP2rSdGG5@vger.kernel.org, AJvYcCVeuGNjcWrburpGgySKY2rEv6qBXSdpg2OxcWhl3vBaPVJ9n/shdTlIKMD47262On/h8qkc3q3jp/qMELwaCgGj@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdzfANL4DujAVrGfyDlk5MkpxKn8jdEUGWBYMNi2YnCYXfNed
	Pc3iZ+KTZym2qZZGqMdQ3uuI1vhPnOrgc8jxabLcdC2PvNj5AoBS
X-Google-Smtp-Source: AGHT+IHwmWhUNZLoKBZBzrHAuiK/CRzNPe6zvX+k5dVAbJhsyyQHmJcbtMkjFYFKuTouPQicMUcpxw==
X-Received: by 2002:a05:6214:5503:b0:6c3:5833:260f with SMTP id 6a1803df08f44-6cb9a4eafe7mr45102326d6.39.1728068416859;
        Fri, 04 Oct 2024 12:00:16 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba47512bdsm1688556d6.88.2024.10.04.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:00:15 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:00:13 -0500
From: David Vernet <void@manifault.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest
 target
Message-ID: <20241004190013.GB56767@maniforge>
References: <20241004094247.795385-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xuk+u8UxomGOBld1"
Content-Disposition: inline
In-Reply-To: <20241004094247.795385-1-bjorn@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--xuk+u8UxomGOBld1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 11:42:46AM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

Thanks a lot Bj=F6rn for working on this.

> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
>=20
> When building the kselftest suite, e.g.:
>=20
>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- \
>     SKIP_TARGETS=3D"" O=3D/output/foo -C tools/testing/selftests install
>=20
> The expectation is that the sched_ext is included, cross-built, and
> placed into /output/foo.
>=20
> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest.
>=20
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> ---
>  tools/testing/selftests/Makefile           |  1 +
>  tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
>  2 files changed, 41 insertions(+), 19 deletions(-)
>=20
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index b38199965f99..20ee8a0b795c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -88,6 +88,7 @@ TARGETS +=3D rlimits
>  TARGETS +=3D rseq
>  TARGETS +=3D rtc
>  TARGETS +=3D rust
> +TARGETS +=3D sched_ext
>  TARGETS +=3D seccomp
>  TARGETS +=3D sgx
>  TARGETS +=3D sigaltstack
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/s=
elftests/sched_ext/Makefile
> index 0754a2c110a1..66467a99184d 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -13,14 +13,8 @@ LLVM_SUFFIX :=3D $(LLVM)
>  endif
> =20
>  CC :=3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
> -else
> -CC :=3D gcc

Given that we're including ../lib.mk, can we just get rid of this whole blo=
ck?

>  endif # LLVM
> =20
> -ifneq ($(CROSS_COMPILE),)
> -$(error CROSS_COMPILE not supported for scx selftests)
> -endif # CROSS_COMPILE
> -
>  CURDIR :=3D $(abspath .)
>  REPOROOT :=3D $(abspath ../../../..)
>  TOOLSDIR :=3D $(REPOROOT)/tools
> @@ -34,18 +28,39 @@ GENHDR :=3D $(GENDIR)/autoconf.h
>  SCXTOOLSDIR :=3D $(TOOLSDIR)/sched_ext
>  SCXTOOLSINCDIR :=3D $(TOOLSDIR)/sched_ext/include
> =20
> -OUTPUT_DIR :=3D $(CURDIR)/build
> +ifeq (,$(OUTPUT))
> +OUTPUT :=3D $(CURDIR)/build
> +RUNNER_DIR :=3D $(CURDIR)
> +else
> +OUTPUT_DIR :=3D $(OUTPUT)

This breaks if you use make from the selftests/sched_ext directory.  AFAICT=
 it
looks like OUTPUT is always set in ../lib.mk, so we always go to the OUTPUT=
_DIR
:=3D $(CURDIR) branch. Because of that, running `make clean` will delete the
whole sched_ext selftests directory. Also, did you mean for the first branc=
h to
be:

+OUTPUT_DIR :=3D $(CURDIR)/build

as opposed to:

> +OUTPUT :=3D $(CURDIR)/build

[...]

Thanks,
David

--xuk+u8UxomGOBld1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwA7PQAKCRBZ5LhpZcTz
ZPoZAP9bSuKYYs994wmUp8WMfOXDiFGe8xsav/5htQkIbRVslwD+OudAqVtsa2Qe
PbwPgF0KtahM0Aa0bMGJ3l9vyX7aTAw=
=t/6n
-----END PGP SIGNATURE-----

--xuk+u8UxomGOBld1--

