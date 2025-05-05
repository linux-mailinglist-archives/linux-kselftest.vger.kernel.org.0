Return-Path: <linux-kselftest+bounces-32340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F54AA937E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E17E188C722
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281B22DF80;
	Mon,  5 May 2025 12:44:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8131DA60D;
	Mon,  5 May 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449061; cv=none; b=HJr+/MxmrVxM9bFxWKB5ggUX8q3Z1t9oZt0oLpK/c7m0m0Tjw3mtYWhinPWsf59da1vkxj8z0xeGyuQJsFh60VvOc1yz8P+kjMOD5csdYgCbOhicKQujEFiQCTyqvb0VmZVS1ciRftI1bI29hoe/wI9tXiGZcT8D/DG1Dj1Ssr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449061; c=relaxed/simple;
	bh=AVoCeShxBb6FZXMPpMt8tJ9Ezoj2QImbnAyTkqsRjiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sv4rtI7rAhh8VCuXacKoa3+bf7AK+LmUNfyUKxEJ6Syfx88yRDkUyyvV0EL5h0sOOgz15w2OJYFNGTcKq4PzRFDXO42Jk9qAFeNu0fM3p9tjVg8ZmC0sEiJdBkngND4svOzNxn7bAYwneyJ+3bHpgNZPmUSMAfQ7vHvp4kCmADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4dad6cc2be0so1255934137.1;
        Mon, 05 May 2025 05:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449056; x=1747053856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHrq3YK4FJCt494t/A4Dk+lbDn5Gt4FqFjZ7+uK22e8=;
        b=DahgN3KKsq4fIaNBjEjzkpDbf0BThLVNW9OhirCr+nMpoFx22D2HrvHEWw6RKLkHba
         m5D3oKv56PTqYkiZKLc4E2X9T0hU/zaC3jUBGEdcNzy41U8jp89DMq/LeX/WJ76s4mDi
         h/jxR0bEkJHJJn6KyGMLBgqcLkVq/DSWbzRnCKlrS/qP4MLhnzgV1W3hhcOuM9yIojko
         VZiZMFmko2eGDA8PiNMBLI46ia8bip3/tw8+jxj2inswm2mrGo2qlz4MnHO4HcF40aZF
         wiuj61SNxkzmM2HmTKW/nvGQpiMNIA+NIv8lSXELsCIyqI80h0D5zkldmeTP0C69U2aK
         KnYw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLQjjhM7C13HGBUhTH+u7j8r2ZDSaalXkK/TPbMx5GgCB8Uus4lgFNyIxkNLPeU2efRPoMKlz23Wch4IpcpLM@vger.kernel.org, AJvYcCVRN8h53hwO18KCEUQ17M1dRGblrxCXqK7m4qB3nn3lE1yA4z0N0N5pDEgEM3cjXNe8FyAIzYlUuWARrg==@vger.kernel.org, AJvYcCVguIHUBnTvLdR3BM9kw/i5BE8gZcmhDVrJwcktFkVk3KREFFlwXdK/THk4ko3TgHHfWgr8on6NJKQYlh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXD9tkEXnmQmIDlLmxeHnqSP74DlbLguaZJKliFPWJHi2xaoC
	jz/6X52WLH1KvBVgSoiVN4k2/CNfKs/yN8cUdq1It3d0WDSnttFim6QJ4Yav
X-Gm-Gg: ASbGnctDJpMB/WSjniQoyZAk4mmn0k3NqB7eeLqv3xo+TEQwXFRzwg5eQCSzYYznSO0
	Z3/6n4tqzLrC1/B1In9ShbX63yV7SKV9EIUyEMmIsWimPyICLwM739P6qC655lS+cOMsPJucMDO
	1K/OU38L+N7cqAVx3H6K40Yo+PsHOvyOVaHfdioaEeJeW1HjRo8SP7YSN6Q/S9+eRYa0oDUhL3A
	BQMmFfcQMdSVXQpq99DdsEQgkPH4EyUgTuwWijGu8chsSfJrUuxZlHlOTTEW1qqIakqzL2GafNo
	pJmGUa0lmcrLyv70VkjAoDswvHlf6UTfaQk1dT/uKML9EQbM42fD5eCqIIJdjbRmlrpzS4/CVvS
	sqSOUTiGdhkXyZQ==
X-Google-Smtp-Source: AGHT+IGboS1bVHejmTCvBG6IE1kVkc536EIJuZQgY1lyO4jTUwb9mKEWKLIJlCQlwLWLbgxZhuMzFQ==
X-Received: by 2002:a05:6102:a9d:b0:4db:154b:cb3b with SMTP id ada2fe7eead31-4db154bd024mr1933564137.3.1746449055837;
        Mon, 05 May 2025 05:44:15 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780afea1b7sm1284296241.7.2025.05.05.05.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 05:44:15 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1070057241.0;
        Mon, 05 May 2025 05:44:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPbjrq/GnGzQcZf21WvR0j1Qhl3wIbLF1rlq8N8WqqQ+G8ZlLr+yqJEVCuQMME5UUOdeY/BTfrYRGkAQ==@vger.kernel.org, AJvYcCVliRWPaSjsFcLcuYI3/YAVherxunU/niYGC8g5vFm4PlpBaevDc2DXvFgAmx8IYaCokRIoKfdSDBThKyY=@vger.kernel.org, AJvYcCX2yva9YNZ3aFTwBO117MAasqWSTG/DEO1hTe1F0X+dcUj6B6FFiT5RSIXvqWPzDQoUAO279HOAxLm0XW1Bwlrd@vger.kernel.org
X-Received: by 2002:a05:6102:5682:b0:4c1:91e0:d5d6 with SMTP id
 ada2fe7eead31-4db14816e09mr2814859137.12.1746449055262; Mon, 05 May 2025
 05:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430-misc-test-fixup-v1-1-6f39ed6c733d@igalia.com>
 <CAMuHMdUk4UqmZV9zyzRz3S6n6+6vRQOcFymR_5J1A=JxAXUsSw@mail.gmail.com> <aBirQvBkvKhnTLYR@quatroqueijos>
In-Reply-To: <aBirQvBkvKhnTLYR@quatroqueijos>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 May 2025 14:44:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBufNGQ03Mi2s5h2-kfxP1ULHc7w=dRuwEeqN_EFxbhQ@mail.gmail.com>
X-Gm-Features: ATxdqUFEkMyCrzw0cGxZkDrTrnU9Pfnoah9QGxyC2B2aIe6akE3f14AsVyuD-AM
Message-ID: <CAMuHMdVBufNGQ03Mi2s5h2-kfxP1ULHc7w=dRuwEeqN_EFxbhQ@mail.gmail.com>
Subject: Re: [PATCH] char: misc: make miscdevice unit test built-in only
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, kernel-dev@igalia.com, 
	kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thadeu,

CC kunit

On Mon, 5 May 2025 at 14:13, Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
> On Mon, May 05, 2025 at 09:21:15AM +0200, Geert Uytterhoeven wrote:
> > On Wed, 30 Apr 2025 at 18:53, Thadeu Lima de Souza Cascardo
> > <cascardo@igalia.com> wrote:
> > > Since it uses __init symbols, it cannot be a module. Builds with
> > > CONFIG_TEST_MISC_MINOR=m will fail with:
> > >
> > > ERROR: modpost: "init_mknod" [drivers/misc/misc_minor_kunit.ko] undefined!
> > > ERROR: modpost: "init_unlink" [drivers/misc/misc_minor_kunit.ko] undefined!
> > >
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Closes: https://lore.kernel.org/linux-next/20250429155404.2b6fe5b1@canb.auug.org.au/
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202504160338.BjUL3Owb-lkp@intel.com/
> > > Fixes: 45f0de4f8dc3 ("char: misc: add test cases")
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >
> > Thanks for your patch, which is now commit 20acf4dd46e4c090 ("char:
> > misc: make miscdevice unit test built-in only") in char-misc-next.
> >
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2512,7 +2512,7 @@ config TEST_IDA
> > >         tristate "Perform selftest on IDA functions"
> > >
> > >  config TEST_MISC_MINOR
> > > -       tristate "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> > > +       bool "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> > >         depends on KUNIT
> > >         default KUNIT_ALL_TESTS
> >
> > This means "default y" if KUNIT_ALL_TESTS=m, which is IMHO not
> > what we want.
>
> The precedent for other kunit config options that are bool is that they use
> "default KUNIT_ALL_TESTS".

Seems like you are right.  Looks like none of the boolean ones can
be enabled on m68k, which is where I run most of the tests, so I never
noticed before :-(

> It makes sense that if you choose to build all tests, you would not skip
> the ones that cannot be built as a module.

You can still enable the test manually if you want.
But I think it should not be enabled by default when all other tests
that can be modular are built as modules.  Unlike for modular tests,
enabling builtin tests by default does impact the base kernel.

> > Perhaps
> >
> >     default KUNIT_ALL_TESTS=y
> >
> > ?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

