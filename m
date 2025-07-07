Return-Path: <linux-kselftest+bounces-36708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C03AFB816
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22A11899645
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D32248A0;
	Mon,  7 Jul 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yXSUeo6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1542206B8
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903873; cv=none; b=N9HrJlkU2bwpAwT5NWXaom+wuFNYpS4vIBvWR5J3fJ/gNwGAP/C+uBo8ucSaFXa/I2OVZFu7Wj21dj9iqvJ0GqE4T9WZTLNT/Z+R6wdkrRJPQfKYcbDUJt/8tT7WMC2daN/A9YO+cd7vYT/ufTRdBwVYc0VduqXXOQxNqzOQJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903873; c=relaxed/simple;
	bh=9dqMKU9kD5/eafceZucMl7P3Pw/P/xDd4QQG8T/DT1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmBr9p0J0j6AaG01few4cAZ66mbjLBKW4xP3JmuM73dhGAbhGi4FBfDyTqWlsx6+ETq0JuYopMrHXg8SS9ebvYUmKPJE0R+ennWGqOK60P3iTwCYi9Di9Rc3LspyrxtH4sseXVvit6rcL4ZjFvDsBFylL8MGfcIDUewsf3oL/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yXSUeo6q; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f2aed4092so1005263241.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751903869; x=1752508669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2E5cIdhxg/ojvcvXGJB1lbbv+v+IiFh5kTQm4LE4vM=;
        b=yXSUeo6qzfZBRM9xaGrdQq/n0HUbHWYa6LcFI6csBOGAlElT3jOdCc753m1C9SlHEM
         4XQTP3n7YhAslPXs77BOlArqF0YYc0HsTlLZm8hRmbVnXQtyBq/p59+jJfEsY0YqrJqu
         jXPv6vGLkYnUAd3cxsXV1gI7vA3GKwQR306IAX4brAhgt2/q8joU2zhcaaeUt44Ma6hD
         fGkkgSYNWSj04wyNeCol9lMXq0e0JN1TQom0GBgUi6T2VB4F+Erxm4ptm4RYVQUR6ttw
         NddEyKeoFrO58R9K2O4RwkJVs/pROXFuuHpXjTayZ/+t1zDS5KhWLqIo/AdHzU6dGPWG
         +c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903869; x=1752508669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2E5cIdhxg/ojvcvXGJB1lbbv+v+IiFh5kTQm4LE4vM=;
        b=TQeSW3lzOxjznT7JJLqKWfCrZMUFEOS0n7mpx1n3+yVdzh0H5xcfsbUzjmLaeXHbdZ
         0OK8Pfjv0/jrCLH2/t+ca+FQbp2PDmfdBVVJhNHeP9XKmwfIJEcInw1+5t3+n0LcKM2P
         UnxESdnyAUxdjDHANPoAzhezNhO5IcxjeRoWRNqL17a6zmITHcn/jDJhx00AH1Ow+kI7
         8ieMJMAGxkuz62U472DMFrvBA3WmhYKfOAeGhn5UOeI9WAlsYN6sC0JZWAtdHtw3iGqg
         6m7HiI8XRka2YbAlCaPyCzafIonCiQflS8L9BiVnVCzLuZhJgg79aDb/hs89EsuXc+pT
         Lj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXX0PIS3dvAR/t3RGKMhUrVqnnh95xvLg6qmMPYgqGa1/7KvYMoEaGyp3Gf7CVNUkrT7P9/+kt8EaORscmCVms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Cw04GKeqlNx5k2HIo7BIG53d5SdOXV42mgM99W67KezZXYTp
	PBMz+6zae4RtvDBltK5FyWLP1B3SvTeJzwbpfRWZ5/YcijRWr28gfvcwm60Yx6YDBeqozh/obud
	gzR4zQCYq+frsspmyak7Ced9u9eeS3TwCl523P0pLpw==
X-Gm-Gg: ASbGncvyIXanrtlzMRr6GZsPvvMpjn0ABPyxkOFsmw6n5u+7jy7QoBKlo+878Yk8PZP
	EQfRav9R8Q0wna78EWeESxMA/n+A9t+cD1NRLTCcs2c9WIFmlR58vwHa9404G0AwuvLl52JIBXn
	CYHrk2WkIrzVI4V0GlFdo2Teml6dizJ7RoNOcxRBXqvmUW
X-Google-Smtp-Source: AGHT+IG83OaC97fyeBUFVcKnhoVFbQwxYmxWEbEawOKd8uVSosvhYb1MRRCRVFBcwLwnoYO9V/PkMpf2ALbHn8DuLnc=
X-Received: by 2002:a05:6102:ccd:b0:4eb:502c:569a with SMTP id
 ada2fe7eead31-4f305a51b80mr4786381137.9.1751903869005; Mon, 07 Jul 2025
 08:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703133601.1396848-1-jesse@rivosinc.com> <20250704-d2ca01be799a71427b5163f9@orel>
In-Reply-To: <20250704-d2ca01be799a71427b5163f9@orel>
From: Jesse Taube <jesse@rivosinc.com>
Date: Mon, 7 Jul 2025 08:57:37 -0700
X-Gm-Features: Ac12FXxNTb7nbFaguHzid07JIa3WSqwBPgoV0EUNKkJ16t72IZytygu-yOOQ0OE
Message-ID: <CALSpo=bieq=T8DZR9u=MeEs4w+6_fAshYcpVj4zC-zRhKkc6OA@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] riscv: lib: Add sbi-exit-code to configure
 and environment
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:17=E2=80=AFAM Andrew Jones <andrew.jones@linux.dev=
> wrote:
>
> On Thu, Jul 03, 2025 at 06:36:00AM -0700, Jesse Taube wrote:
> > Add --[enable|disable]-sbi-exit-code to configure script.
> > With the default value disabled.
> > Add a check for SBI_PASS_EXIT_CODE in the environment, so that passing
> > of the test status is configurable from both the
> > environment and the configure script
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> >  configure      | 11 +++++++++++
> >  lib/riscv/io.c | 12 +++++++++++-
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 20bf5042..7c949bdc 100755
> > --- a/configure
> > +++ b/configure
> > @@ -67,6 +67,7 @@ earlycon=3D
> >  console=3D
> >  efi=3D
> >  efi_direct=3D
> > +sbi_exit_code=3D0
> >  target_cpu=3D
> >
> >  # Enable -Werror by default for git repositories only (i.e. developer =
builds)
> > @@ -141,6 +142,9 @@ usage() {
> >                                  system and run from the UEFI shell. Ig=
nored when efi isn't enabled
> >                                  and defaults to enabled when efi is en=
abled for riscv64.
> >                                  (arm64 and riscv64 only)
> > +         --[enable|disable]-sbi-exit-code
> > +                                Enable or disable sending pass/fail ex=
it code to SBI SRST.
> > +                                (disabled by default, riscv only)
> >  EOF
> >      exit 1
> >  }
> > @@ -236,6 +240,12 @@ while [[ $optno -le $argc ]]; do
> >       --disable-efi-direct)
> >           efi_direct=3Dn
> >           ;;
> > +     --enable-sbi-exit-code)
> > +         sbi_exit_code=3D1
> > +         ;;
> > +     --disable-sbi-exit-code)
> > +         sbi_exit_code=3D0
> > +         ;;
> >       --enable-werror)
> >           werror=3D-Werror
> >           ;;
> > @@ -551,6 +561,7 @@ EOF
> >  elif [ "$arch" =3D "riscv32" ] || [ "$arch" =3D "riscv64" ]; then
> >      echo "#define CONFIG_UART_EARLY_BASE ${uart_early_addr}" >> lib/co=
nfig.h
> >      [ "$console" =3D "sbi" ] && echo "#define CONFIG_SBI_CONSOLE" >> l=
ib/config.h
> > +    echo "#define CONFIG_SBI_EXIT_CODE ${sbi_exit_code}" >> lib/config=
.h
> >      echo >> lib/config.h
> >  fi
> >  echo "#endif" >> lib/config.h
> > diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> > index b1163404..0e666009 100644
> > --- a/lib/riscv/io.c
> > +++ b/lib/riscv/io.c
> > @@ -162,8 +162,18 @@ void halt(int code);
> >
> >  void exit(int code)
> >  {
> > +     char *s =3D getenv("SBI_PASS_EXIT_CODE");
> > +     bool pass_exit =3D CONFIG_SBI_EXIT_CODE;
>
> This is the first case of what may become more common - a config variable
> which also has an env override. I think it may be good convention to
> name them the same, i.e. the env name would also be CONFIG_SBI_EXIT_CODE,
> unless you think that would be confusing for some reason?

I changed the name because the configure option seemed very long.
I will make them both SBI_EXIT_CODE. Should I add a macro to simplify
future uses
of a config variable which also has an env override.

>
> > +
> >       printf("\nEXIT: STATUS=3D%d\n", ((code) << 1) | 1);
> > -     sbi_shutdown(code =3D=3D 0);
> > +
> > +     if (s)
> > +             pass_exit =3D (*s =3D=3D '1' || *s =3D=3D 'y' || *s =3D=
=3D 'Y');
>
> We now have this logic in four places[1]. I think it's time we factor it,
> and it's counterpart "!(s && (*s =3D=3D '0' || *s =3D=3D 'n' || *s =3D=3D=
 'N'))"
> into a couple helper macros. I'm not sure where the best place for
> those macros to live is, though. I guess libcflat.h, but we really
> ought to split that thing apart someday...

Is lib/argv.h an ok place?
getenv is defined in lib/string.c which is interesting. I wonder if it
could be moved to lib/argv.c?

Thanks,
Jesse Taube
>
> [1]
>  - twice in lib/errata.h
>  - once in riscv/sbi-tests.ha
>  - and now here
>
> > +
> > +     if (pass_exit)
> > +             sbi_shutdown(code =3D=3D 0);
> > +     else
> > +             sbi_shutdown(true);
>
> nit: can be written more concisely as
>
>  sbi_shutdown(pass_exit ? code =3D=3D 0 : true)
>
> >       halt(code);
> >       __builtin_unreachable();
> >  }
> > --
> > 2.43.0
> >
>
> Thanks,
> drew

