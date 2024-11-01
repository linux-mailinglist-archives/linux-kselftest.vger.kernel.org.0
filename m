Return-Path: <linux-kselftest+bounces-21302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E39B93BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475FF1F217F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429791A256C;
	Fri,  1 Nov 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guPzqbm+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76919DF53;
	Fri,  1 Nov 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472617; cv=none; b=iclsVVIW1XPdTP+GjZuzpW1mZ3CoW+7xEKXDJzkY42sbWwDrZMZMpCuk59m2RBsc006Tqx2/e6nubAdq3qBAANoxG+6Z7bKoTdbYB9+dfMr9e1+PEAXK12qS/vDsUEapuWUA6dz4WdhSboNPvhob/UsUWKkPEkcYZaJ9mOmK9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472617; c=relaxed/simple;
	bh=ljeC521u4evp5cZBupSeKdyQnELeagQB8AYdKxuvGF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKy5x/aIsbg8dg3mtzvyadjpPqIAjFd7PcYGkrUDzRbg2XkqGY6nBRJhKuTvzgTJ1Lv6YXYR69ESbpBwA+XKiD7jk/WYqYuU0yWPb6Z+JR8UeKAtVRZ1aZQZrOfcUy5ToHSvnAJoa96H9N/cKnNBPSMsI5IVKsaHr5uagXSMJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guPzqbm+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so18609901fa.1;
        Fri, 01 Nov 2024 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472613; x=1731077413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9hJYuNrDZmqlVcyIK/zA2RvDFZ2InchFcFx47BVpnR4=;
        b=guPzqbm+lxMdsuKq2joiUhlDDcDkj0YnZcT7Znk7KR/EQgwdL8fUsvbY4TqQWNRLDv
         stp0BKhTk8EJM+Z4muy9J+5fmR0X8hKctiso735yCY+FACYK7RRUbwViENmtwzNgBhNS
         T29XgjGGFIL62Lg2HaRKdQVzvn0ylSbqjBW3Hgb7YRr7H9FXafl7IJhaQav10Y92SVoJ
         f8YJGQI0OeZLvaw9PpEhWLxD/Zyazxf0S3/Ly3duWs06VDQFX8FsfUcLysAb1IipsTAN
         65PQTRvX9JQoyNmDB1Iw8pde619ndzb3WrS6OoHIUgLDz/fGTL8DQuSOHNugJpXy0Fnm
         WLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472613; x=1731077413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hJYuNrDZmqlVcyIK/zA2RvDFZ2InchFcFx47BVpnR4=;
        b=evtSVbx6h5nw73Lgjq70KHNXMD0XaUbHFFYQ7WliQ0teUHzz7qP7IM8efbOsYUw9fY
         MI+hoPzYqohiqN6hChaRriR0UTRF5xVveIYuDWEorjNjEM41CNdnSszw5+EiWHJV9+j5
         /zAOYsxRxgx7JiO3EUgkj5gzLJY1Y8KEW+VgbJ6ATI6L1zTQQRRMi0wv0VqDHYIjUOki
         /zxESzNiAg3LIA9j9JuCj5qu9VrDv8jT8ERXvWoHeZz44JSeD/4kp/qMDzCxbe3ZB1Yi
         oT4+PrZGgYIghu19XxhklJz3OWEpB9MjpteT5eh5yUnuhpDbgPwhURD3bsIosxnsqmLN
         /lLw==
X-Forwarded-Encrypted: i=1; AJvYcCUQqPXLUDslEANeQQ++8Ic+R27LN8p7CflV/p1bJ1Ae34KBz7TTa0EJMIUy47uP6doinYeXHd4PAVhkpr6TfHZ4@vger.kernel.org, AJvYcCXt61HRPyprUO+MCijEatVqgj1Gdg0niiFgqRusGNQqojYr/lJOCrKMNpixboAQ0/R9U0UD8mVkd7CWNsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdGrFtB7hzWwcfXJT6varknJv+2EDvcDSZ+1eOTB49/EORXZ+
	n3ul0d5FseyYPaXXy5nJgha/zSbuM5mcs/jmcXHDdy73XVCAra8xAYQVYj9ErpBWyzDzKziRrQY
	EgNIqovC05m59dCjrwAu5NSCb8HNjSRCVvSk=
X-Google-Smtp-Source: AGHT+IGFLZSNiICgjAOj5BzvClatyHo1q6xPc2fzZwASomksDcKDY4rt0uQqp7EtXlR/7Pb2l3QGV5JanPMBEzDMOVM=
X-Received: by 2002:a2e:be20:0:b0:2fb:3a12:a582 with SMTP id
 38308e7fff4ca-2fcbe004c83mr117643281fa.23.1730472612781; Fri, 01 Nov 2024
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
 <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com> <jhmonkl53vrgz3pjhbbopvrx6infgbezlsvba3luccrpwtnmtb@ptobfcxrr4ud>
In-Reply-To: <jhmonkl53vrgz3pjhbbopvrx6infgbezlsvba3luccrpwtnmtb@ptobfcxrr4ud>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 1 Nov 2024 10:49:36 -0400
Message-ID: <CAJ-ks9m8AD2fon4Nxvc_S-DwY4TkRPHpq0icT0jPwCiCxy6Tqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: enable hardware acceleration when available
To: Alyssa Ross <hi@alyssa.is>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 1, 2024, 09:52 Alyssa Ross <hi@alyssa.is> wrote:
>
> On Fri, Oct 25, 2024 at 05:03:54PM -0400, Tamir Duberstein wrote:
> > @@ -124,6 +125,29 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> >                               '-no-reboot',
> >                               '-nographic',
> >                               '-serial', self._serial] + self._extra_qemu_params
> > +             accelerators = {
> > +                     line.strip()
> > +                     for line in subprocess.check_output([qemu_binary, "-accel", "help"], text=True).splitlines()
> > +                     if line and line.islower()
> > +             }
> > +             if 'kvm' in accelerators:
> > +                     try:
> > +                             with open('/dev/kvm', 'rb+'):
> > +                                     qemu_command.extend(['-accel', 'kvm'])
> > +                     except OSError as e:
> > +                             print(e)
> > +             elif 'hvf' in accelerators:
> > +                     try:
> > +                             for line in subprocess.check_output(['sysctl', 'kern.hv_support'], text=True).splitlines():
> > +                                     if not line:
> > +                                             continue
> > +                                     key, value = line.split(':')
> > +                                     if key == 'kern.hv_support' and bool(value):
> > +                                             qemu_command.extend(['-accel', 'hvf'])
> > +                                             break
> > +                     except subprocess.CalledProcessError as e:
> > +                             print(e)
> > +
>
> QEMU supports falling back if one accelerator is not available, if you
> specify multiple like -accel kvm:tcg.  Couldn't you rely on that rather
> than re-implementing the availability checks here?

Have you ever used that? Here's what I get when I try:

tamird@Tamirs-MacBook-Pro linux % tools/testing/kunit/kunit.py run
--arch arm64 --make_options LLVM=1 --raw_output=all
[10:45:03] Configuring KUnit Kernel ...
[10:45:03] Building KUnit Kernel ...
Populating config with:
$ make ARCH=arm64 O=.kunit olddefconfig LLVM=1
Building with:
$ make all compile_commands.json ARCH=arm64 O=.kunit --jobs=12 LLVM=1
[10:45:07] Starting KUnit Kernel (1/1)...
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel
.kunit/arch/arm64/boot/Image.gz -append 'kunit.enable=1
console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial
stdio -accel kvm:tcg -machine virt -cpu max
qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg

The same thing happens with hvf:kvm:tcg or just hvf:tcg.

I also can't find this in the documentation.
Tamir

