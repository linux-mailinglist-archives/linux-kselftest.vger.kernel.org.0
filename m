Return-Path: <linux-kselftest+bounces-21336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B721D9B9F37
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 12:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468411F21EE8
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58216E89B;
	Sat,  2 Nov 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu/RZCoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753414C7E;
	Sat,  2 Nov 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545858; cv=none; b=kbkrT2vQEVkQyKw1Y9vZ8nz+JtWankar6g7rS2rl0rAAR5Owz4dJLYhxDGj+T8t006HnJQzLOJMz9Iw7EYliUIFUFVvxWQBHiuLNaMCqzP46OytBbi5qpjCEH/1gTu13c+R/W7tyxLD8iae4hKqDsjly9jY7C8kjXCu0LiC27wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545858; c=relaxed/simple;
	bh=1HiQeVO6abpuobpSDVAWp3VL2IFlb3NJspVGsWPe9mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgGOxhdzTlloIPT8ErbFITrtgCFena9I6ApzstoNmO/oYQLP8NsrfBDbnf8o54eCDDUyQ7B/Shg9AXIL7HTkj9EH0sQ0fAL06EiXFr0ADvCC50AQNL85i3bgiMEBfcUCUjkR8gAiwkhxkOq71TrGPi6oliqMGaD7eqPah1ws1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu/RZCoU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso1948221fa.1;
        Sat, 02 Nov 2024 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730545852; x=1731150652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/tqvEh0nzKXD60SeICHyvO8BgzGUqBqF0ViGYOkYp4=;
        b=Lu/RZCoUwhI8kvUhqhETtjKAOlXwhI/eqZbyRkLBrSoCOh2oxmbUXWPQpjwkmYEa+A
         078MnEn111j8gLIqslVfs5v3rF7ktXy9nZde7A4Y1R0WXC6hSKH7IJaYQUqlJwA/nygS
         vnq35v+dG+mRgNSwfT8UwYz+L8zxJhtObrnyr34kkcm23CkiiHXGI8CJrVBXJOL3cwZa
         YfJrYv4ICiGkB/rF2lYSe216WaoIeO3ezVEHCg6aBdZ8jTSD3YgWXmotRQDJkwHvksXB
         MyfEMddQsxgd1WfeFa/FhdVN9qePYFLX+yxOjY4Ll16BO5f5lo+hTdKH0cUJCgdWEYvg
         HHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730545852; x=1731150652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/tqvEh0nzKXD60SeICHyvO8BgzGUqBqF0ViGYOkYp4=;
        b=KRGas6sRKPK/C5u23lX5nxqOo1dA6YwE+qlF6WmqZIaliJtlcuwoZGcNma5hJLROmr
         Oer9fO8CjOCABVU6cJ2qLtUXVPvnpGRwQDuXEnLLBDTIQqQZ+esS6qd45twinNU8fZsK
         c8xXk/MBKTa+QFphvbCqZdj+iRKXlTavOjaOLHMh1P12Kag52YVUPjpr8Y0GnPCn7LF5
         eju9BbKOY6GJx4MsqIpGYT/z6ghwk+HK5reto1io3hZV6jMvAFQAhWYLIq5gG1hbNidM
         cuqJjhqXloLiOH2JyQavVs7BVlKsjlqBEEXHblFF1TywxEucRdVRoth30YaE10NX06YW
         bZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiYVWgSyvkAkLevjTl94MhbNcX/B+PKP4ePswqHRVm4clX9YX3YhB6CJ5ZoN7TyGu2KhWrPHpy4Q6xQyPVID68@vger.kernel.org, AJvYcCWeJgBDo51s8Ie6ndGR0ujVRUovs8BSLwx3+kVGyPE/AHxzYtF5yEvJFoNOQ8YHA9yC4F2vtvewde8z8Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISpd+XpFvSabWK6PPmmEGhHwNB/VZVc3snEfmiOGs7M/Xev9C
	SgNncVv3JTivXcAzFrdObIiX2GbrRNDn2t9GplzYyk5KTG3wdU7Vfj42Wb2RY6bnk0gJEazBjgR
	NHwVKlXAJ3cSTzPw3zPMYqGQ52ii9iaSKHHI=
X-Google-Smtp-Source: AGHT+IHaq4f1q9nblyLN6lzVzoxGfBbqn7xeT4XSMn0KH9nfb6gLKLtNcWJI9BZ8mbbs0atzdxF2UXsms+JRY6mmxOM=
X-Received: by 2002:a05:651c:554:b0:2fa:d604:e519 with SMTP id
 38308e7fff4ca-2fedb7a2132mr54634711fa.11.1730545852255; Sat, 02 Nov 2024
 04:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
 <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com>
 <jhmonkl53vrgz3pjhbbopvrx6infgbezlsvba3luccrpwtnmtb@ptobfcxrr4ud>
 <CAJ-ks9m8AD2fon4Nxvc_S-DwY4TkRPHpq0icT0jPwCiCxy6Tqw@mail.gmail.com> <5d855199-d054-43f2-b209-23bbfa5f6d92@t-8ch.de>
In-Reply-To: <5d855199-d054-43f2-b209-23bbfa5f6d92@t-8ch.de>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 2 Nov 2024 07:10:16 -0400
Message-ID: <CAJ-ks9n4CpOEgHd9383JRWUJrUjSVshquHxUiiKSsQrC8KqX_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: enable hardware acceleration when available
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Alyssa Ross <hi@alyssa.is>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 11:23=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2024-11-01 10:49:36-0400, Tamir Duberstein wrote:
> > On Fri, Nov 1, 2024, 09:52 Alyssa Ross <hi@alyssa.is> wrote:
> > >
> > > On Fri, Oct 25, 2024 at 05:03:54PM -0400, Tamir Duberstein wrote:
> > > > @@ -124,6 +125,29 @@ class LinuxSourceTreeOperationsQemu(LinuxSourc=
eTreeOperations):
> > > >                               '-no-reboot',
> > > >                               '-nographic',
> > > >                               '-serial', self._serial] + self._extr=
a_qemu_params
> > > > +             accelerators =3D {
> > > > +                     line.strip()
> > > > +                     for line in subprocess.check_output([qemu_bin=
ary, "-accel", "help"], text=3DTrue).splitlines()
> > > > +                     if line and line.islower()
> > > > +             }
> > > > +             if 'kvm' in accelerators:
> > > > +                     try:
> > > > +                             with open('/dev/kvm', 'rb+'):
> > > > +                                     qemu_command.extend(['-accel'=
, 'kvm'])
> > > > +                     except OSError as e:
> > > > +                             print(e)
> > > > +             elif 'hvf' in accelerators:
> > > > +                     try:
> > > > +                             for line in subprocess.check_output([=
'sysctl', 'kern.hv_support'], text=3DTrue).splitlines():
> > > > +                                     if not line:
> > > > +                                             continue
> > > > +                                     key, value =3D line.split(':'=
)
> > > > +                                     if key =3D=3D 'kern.hv_suppor=
t' and bool(value):
> > > > +                                             qemu_command.extend([=
'-accel', 'hvf'])
> > > > +                                             break
> > > > +                     except subprocess.CalledProcessError as e:
> > > > +                             print(e)
> > > > +
> > >
> > > QEMU supports falling back if one accelerator is not available, if yo=
u
> > > specify multiple like -accel kvm:tcg.  Couldn't you rely on that rath=
er
> > > than re-implementing the availability checks here?
> >
> > Have you ever used that? Here's what I get when I try:
> >
> > tamird@Tamirs-MacBook-Pro linux % tools/testing/kunit/kunit.py run
> > --arch arm64 --make_options LLVM=3D1 --raw_output=3Dall
> > [10:45:03] Configuring KUnit Kernel ...
> > [10:45:03] Building KUnit Kernel ...
> > Populating config with:
> > $ make ARCH=3Darm64 O=3D.kunit olddefconfig LLVM=3D1
> > Building with:
> > $ make all compile_commands.json ARCH=3Darm64 O=3D.kunit --jobs=3D12 LL=
VM=3D1
> > [10:45:07] Starting KUnit Kernel (1/1)...
> > Running tests with:
> > $ qemu-system-aarch64 -nodefaults -m 1024 -kernel
> > .kunit/arch/arm64/boot/Image.gz -append 'kunit.enable=3D1
> > console=3DttyAMA0 kunit_shutdown=3Dreboot' -no-reboot -nographic -seria=
l
> > stdio -accel kvm:tcg -machine virt -cpu max
> > qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg
> >
> > The same thing happens with hvf:kvm:tcg or just hvf:tcg.
>
> That syntax is for -machine accel=3Dhvf:kvm:tcg.
> But you can also specify -accel multiple times.
>
> > I also can't find this in the documentation.
>
> -accel name[,prop=3Dvalue[,...]]
>       This  is used to enable an accelerator. [..]
>       If there is more than one accelerator specified,
>       the next one is used if the previous one fails to initialize.
>
> -machine [type=3D]name[,prop=3Dvalue[,...]]
>       Supported machine properties are:
>
>       accel=3Daccels1[:accels2[:...]]
>              [..]
>              If there is more than one accelerator specified,
>              the next one is used if the  previous one fails to initializ=
e.
>
>
> Thomas

Nice, thank you. These details seem to appear only in the docs[0] and
not in the output of `--help`. I'll make that change in v2.

Link: https://www.qemu.org/docs/master/system/invocation.html [0]


Tamir

