Return-Path: <linux-kselftest+bounces-21468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA499BD61E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C26B220D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49930212F07;
	Tue,  5 Nov 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI1Cm7Xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE101E25FD;
	Tue,  5 Nov 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836334; cv=none; b=JRWS94d9wUg/IQ0LSUWA1e1uM6P2hoP6gciKgBk2cilXvyiBXIqf3PH4CG0fUUihtFYWqIcerVbrtgvAo9ncxbEQQmWiDwxrefF3fWbHv45k2JmWw4n4HV0tV8NqYaD+H4cgqiSaBSEnoFdS98kgQgii52Y6HyvjE7SzPuLraNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836334; c=relaxed/simple;
	bh=LPKF03atCTCrKcos+7YwqpjNd1ViksquHbsZ60LIIE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPq4RwiXABh0R1Xt+BC7gmVvMmxr4/2f2EP05zr60E6gz45/Y9O2JQw6cXOoo6ifdRp1Y+RajmZZiFnoYnJsAHIyj3ot4r4GfX+z2KYQGczA0XKX6m7Z/BmGNOQNWYlJiiTMFtIXaJTjvICSSy9yX9aJg5M9fow0+TN58uOVo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI1Cm7Xt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so55670501fa.0;
        Tue, 05 Nov 2024 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730836331; x=1731441131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWoAPKRjNa7zAKKPU5n6zemxViQkVRga91S8P7RCLT8=;
        b=GI1Cm7XtFZ4ZtPD8ImBcWorSdFvRUMEvyv3D0o9415z7DEGw2IjoDkGkIxBoPcRUiO
         cHi4y4jSpRW+aBE1LGzdvWp3MXY55GU6UVjgN52nF/oHKdt/YcMoOxNSkjaj2hVcjviP
         Nhf6Y80MOXT194mlPAE3bl3S1uJQeRjhoQONLgT2ARdtXG6tWWUUu1BTcKvZEG1BmcQa
         /YsWrj5T8z1qTlMmQxfgCCAtSiO+QOPjV9ZGE8kcGtqXLiPIDamagvRU3FF1v7L6y3B3
         bXYymoEUSndt16FGiwU8CQaou11B8kJlLwO1aKN55Yz4r9Y0glxZEGxkNN6JgYd2N++J
         rMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836331; x=1731441131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWoAPKRjNa7zAKKPU5n6zemxViQkVRga91S8P7RCLT8=;
        b=IErSrb0vNVv8jVtBGMHg9qVyRzn3M/iJctw2Q7yvJbZj9tPEkUaflExvalzf+FwQZZ
         vMyEOyot3Q1rd54lXNojuPSiXnj4hQIiGLKiBR4lpUwdoUEwcmQ3diNIcFrhPrs4H/JR
         5fc5EvSLqIk04syOLF6zSXbs0vaYTC9D/5K9InNLo4Ih+xHQaaPB5eH/W1g/ei/bzVxw
         jseK3Zr3jj0SV8Dx4buV2kmi3aHj4YI5cXHKZ10jayBjH+WsrdQp+7Mw6MYP6+Op6vVy
         4b2HYaHn3NI89KOT/bg7GIj5rX83gYVW3CUEAsSNpGD5OUBnfTNlFi5k2W9MoRXd3Fnu
         ErQA==
X-Forwarded-Encrypted: i=1; AJvYcCVx5aMTtyjYm0oSb7D7E9xBwW/dMuuZ7ysikh9HcewJlqVgYbgWhYkTZNGL94uqB6pmr6vYM5vlE44k3gOO8kkC@vger.kernel.org, AJvYcCXm2PERu7VbsV55C6tuMtrICQsoBYEBj2H5i6IdMrUVIBzsUaC0Uxqq1VsN/ZXDW5b9uKsSZN+jF86ekEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyda0t/CE60IWZ9D8NGltryIysPW8eT6e/oaRWCt6pCAjwuXdfG
	Xr18ElyKOSCvElndZtCUxdqniAFsj0Qf6uONgL8HGtclRAFjsXVvQCLqVHZgBPsvk2WqzPsNI32
	QQrH+5Kf4aauljoAybFMrFjwO08w=
X-Google-Smtp-Source: AGHT+IHxl8JlCjTYJJa13IIP2d9eLW8BnMWSthEqSmW9YF14KRL5jSplkOH6i+0ZMmav8L6shUy5jZmEdmwLNlRr5cU=
X-Received: by 2002:a2e:751:0:b0:2ef:21b3:cdef with SMTP id
 38308e7fff4ca-2fcbdfdb091mr143148921fa.25.1730836330262; Tue, 05 Nov 2024
 11:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
 <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com> <4e57a6e6-f10c-4a35-88e7-ab4749f7e329@arm.com>
In-Reply-To: <4e57a6e6-f10c-4a35-88e7-ab4749f7e329@arm.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 5 Nov 2024 15:51:34 -0400
Message-ID: <CAJ-ks9kEM2NkS4i9D+R=gsqSRpQSWSPFwFsVuzfQ+6CaX2LJNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: enable hardware acceleration when available
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:36=E2=80=AFAM Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
>
> On 02/11/2024 12:09, Tamir Duberstein wrote:
> > Use KVM or HVF if supported by the QEMU binary and available on the
> > system.
> >
> > This produces a nice improvement on my Apple M3 Pro running macOS 14.7:
> >
> > Before:
> > ./tools/testing/kunit/kunit.py exec --arch arm64
> > [HH:MM:SS] Elapsed time: 10.145s
> >
> > After:
> > ./tools/testing/kunit/kunit.py exec --arch arm64
> > [HH:MM:SS] Elapsed time: 1.773s
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  tools/testing/kunit/kunit_kernel.py       | 3 +++
> >  tools/testing/kunit/qemu_configs/arm64.py | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/=
kunit_kernel.py
> > index 61931c4926fd6645f2c62dd13f9842a432ec4167..3146acb884ecf0bcff94d59=
38535aabd4486fe82 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -123,6 +123,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTree=
Operations):
> >                               '-append', ' '.join(params + [self._kerne=
l_command_line]),
> >                               '-no-reboot',
> >                               '-nographic',
> > +                             '-accel', 'kvm',
> > +                             '-accel', 'hvf',
> > +                             '-accel', 'tcg',
> >                               '-serial', self._serial] + self._extra_qe=
mu_params
> >               # Note: shlex.join() does what we want, but requires pyth=
on 3.8+.
> >               print('Running tests with:\n$', ' '.join(shlex.quote(arg)=
 for arg in qemu_command))
> > diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/=
kunit/qemu_configs/arm64.py
> > index d3ff27024755411441f910799be30399295c9541..5c44d3a87e6dd2cd6b08613=
8186a277a1473585b 100644
> > --- a/tools/testing/kunit/qemu_configs/arm64.py
> > +++ b/tools/testing/kunit/qemu_configs/arm64.py
> > @@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> >                          qemu_arch=3D'aarch64',
> >                          kernel_path=3D'arch/arm64/boot/Image.gz',
> >                          kernel_command_line=3D'console=3DttyAMA0',
> > -                        extra_qemu_params=3D['-machine', 'virt', '-cpu=
', 'max,pauth-impdef=3Don'])
> > +                        extra_qemu_params=3D['-machine', 'virt', '-cpu=
', 'max'])
>
> Would it be possible to keep 'pauth-impdef=3Don' for TCG emulation? Other=
wise
> performance regresses by about 20%.
>
> Before this patch:
> ./tools/testing/kunit/kunit.py exec --arch=3Darm64 --cross_compile=3Daarc=
h64-linux-
> [11:03:38] Elapsed time: 15.494s
>
> After this patch:
> ./tools/testing/kunit/kunit.py exec --arch=3Darm64 --cross_compile=3Daarc=
h64-linux-
> [11:10:47] Elapsed time: 19.099s
>
> Thanks,
> Kristina

Hi Kristina, thanks for pointing that out. I'm able to reproduce the
regression. I poked around and I can't find a way to enable
`pauth-impdef` only for TCG, and the problem is that enabling it
globally produces:

tools/testing/kunit/kunit.py exec --arch arm64 --make_options LLVM=3D1
--raw_output=3Dall
[15:34:05] Starting KUnit Kernel (1/1)...
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel
.kunit/arch/arm64/boot/Image.gz -append 'kunit.enable=3D1
console=3DttyAMA0 kunit_shutdown=3Dreboot' -no-reboot -nographic -accel
kvm -accel hvf -accel tcg -serial stdio -machine virt -cpu
max,pauth-impdef=3Don
qemu-system-aarch64: -accel kvm: invalid accelerator kvm
qemu-system-aarch64: falling back to HVF
qemu-system-aarch64: can't apply global max-arm-cpu.pauth-impdef=3Don:
Property 'max-arm-cpu.pauth-impdef' not found

This behavior is at least somewhat intentional[0]. I have filed a bug
with qemu[1]. If someone can conceive of a way to achieve this, I'd be
delighted to send a v3.

Link: https://gitlab.com/qemu-project/qemu/-/commit/92d6528dbb20c6aec4022df=
d63c7ffee44f19f77
[0]
Link: https://gitlab.com/qemu-project/qemu/-/issues/2656 [1]

