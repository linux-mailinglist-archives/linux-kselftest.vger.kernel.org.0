Return-Path: <linux-kselftest+bounces-26176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E7A2F058
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6747A2693
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC922DFAD;
	Mon, 10 Feb 2025 14:52:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342522253B0;
	Mon, 10 Feb 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199163; cv=none; b=ZFDDClUdX2H7PWS5ESsBmAHH/h5bprYmg+D8D4kzF94htGDc6H7MxtJmVSKjCqw3s54r8O1rABpkHcrj5iNkVA3E2g9Y8Oy0y0SURSrORu6WGZF4NzBvyoJXcgxFhU1UbxKC4Qr1bSbs6Qxt8vgduf2+3VgqY7mXCXiDqCGNbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199163; c=relaxed/simple;
	bh=wda1mNMZX4KbseNBkq3rXwGn7M4th8PLAawTHL22Dew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcIOxM8QpnP23+rEvZkZgzANLicEO1BUZVcAcbFOsPaNEfD5XkgYgs1DK14rYfHibtIcl3x/dqFtK4wHleQFeFLhGEf2x6KQTCoT7LW6Lew6XITnxC03LrPc3HHt6OywDShaYVLJWysaXsXBH/OW7BQp47Eo+VeW52kgUDfndHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb18130f9so1212217e0c.3;
        Mon, 10 Feb 2025 06:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199158; x=1739803958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u703hN5aY5SqOZOgV7UZtvwsQZeKBEWLZawWzSIr9eM=;
        b=FWZCWTDiM7b0HYNTyY7kpYdPHYsv/ViFHuYZ3Glhmpna9dRxUorlofXqkjh6N3JTHM
         lKZJ6mwCGIgvzRygFq63SDeXfwF5r8wFjzn0w/jsGv4fQF5arhrpIkdNDsgH9QIDIjJj
         1J9xmPTTcyKJPSSVYS0nx5LYZ3Oifu53v7Gh2Ps4yQgsQqHVQD5N9dN6c7fa543+nTbz
         VqnWFBq/r64aZ/lUhdELYLeD7JLBdSg6b+HYtf8aKlRouLM/U3pqdz2T4Vwoye/4slgh
         FZBjV/XtMmL56dY3zpHdd+hXFCmUZXkwX6hrb1GjPfiI+Wbkfsu8yYltMGXPgCcbLhbL
         AuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURYkCOFaRTPSqPTxQPaoTRhWVtZ0IxDfutGBMPyd69qw86Z/B+TncXJbmaLEIIbIAUF++Qw1L6MsxlXmI=@vger.kernel.org, AJvYcCVfPiaRYlhjU4l/CnS2p0lsG9Ik2xaANCiBelXlvIwoip/R79FGNfXMh97Aax0jveVX8JnZ595YPWhl7XbX/n3n@vger.kernel.org
X-Gm-Message-State: AOJu0YwcPjzd/Q5NzySU8u36lcLM63NzrVUaKTFFBlMtYddnihjE8LdA
	++v2IDR6h4HXsgLq75VwPPILY4akdgAXk8gzzIxmJ3a1cfhGfDBwYQh/x2MU
X-Gm-Gg: ASbGncv3BzNH1IcpcC0/TJ3rQMrKolNT0XPOvxWigLbpsLXM3pzxj0bcaOGHrV7BEXx
	7I/EOqZwM5c+YSQKEGaLOJDsfwob6Bva7oj3PCEsGI945Unh7nkWZhfLy00IiwwD01Qd1fDQgq2
	nrszaILKY5nKIRWK/DbeABkkaBEru1o17E2eTR2a26XjbVP3DRHhfhGZoeeTt3BxrOkWcRdfRp8
	glG75wRHmSgyp0Zi1JA3/RM5la0ceoSehMIGtceSEwqJOwT0zozPubuu37u+DhG39EljAfy5Guw
	e8zSktLuFx1k2MYdYOVCMp6tFaeZPyU4TU5n+zZj/hIPxXsicntxZg==
X-Google-Smtp-Source: AGHT+IEQYr1ky3o2AX0q0vGPIYeg+C2FIiPYZokvRP7ecSZ6K05Xj7kkAfZHR5UUFUvpxCfc4Qir+w==
X-Received: by 2002:a05:6122:30ac:b0:518:8bfe:d5f0 with SMTP id 71dfb90a1353d-52056f33161mr110227e0c.0.1739199158243;
        Mon, 10 Feb 2025 06:52:38 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5204eb4396esm143222e0c.43.2025.02.10.06.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 06:52:37 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4bbc406499fso324745137.1;
        Mon, 10 Feb 2025 06:52:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjsj+zUQ6AJR46YX+9opvJPxIuDcU7WP6rkjbPvQ/XVLOQnP1pfUYfwcYriP2xOIoq7QHfocOawGkUFIg=@vger.kernel.org, AJvYcCV4730TF/rJh4riNPJ5ff9BflepwIQXZIprKG0/oBVARWuYWiCuHjVtyqyG1VMTcGRGDlDOgeuyxEcXjkTJCtxi@vger.kernel.org
X-Received: by 2002:a05:6102:151a:b0:4bb:cf25:c5a7 with SMTP id
 ada2fe7eead31-4bbcf25c92fmr1968497137.7.1739199156936; Mon, 10 Feb 2025
 06:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
 <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
 <87tt92q7hw.fsf@prevas.dk> <CAJ-ks9=SEBCZiuq2YE3Uj5wJ4Pv+78W-VBTeV7CSzLYJZqsR8Q@mail.gmail.com>
In-Reply-To: <CAJ-ks9=SEBCZiuq2YE3Uj5wJ4Pv+78W-VBTeV7CSzLYJZqsR8Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 15:52:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSprzzCBTBM+w39FN+OudEYPT_SX6BOMSus+8NLvZNVA@mail.gmail.com>
X-Gm-Features: AWEUYZnbQ7L8tglpj5Mx35LbIIF1lFB7ko_RSeqwpqDtti_3gf22adqXaIDCR7Q
Message-ID: <CAMuHMdXSprzzCBTBM+w39FN+OudEYPT_SX6BOMSus+8NLvZNVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] printf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arpitha Raghunandan <98.arpi@gmail.com>, 
	David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tamir,

On Mon, 10 Feb 2025 at 15:37, Tamir Duberstein <tamird@gmail.com> wrote:
> On Mon, Feb 10, 2025 at 8:01=E2=80=AFAM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > [...]
> >
> > If/when you do re-roll a v3, can you split the defconfig changes off to
> > a separate patch? It's a little annoying to scroll through all those
> > mechanical one-liner diffs to get to the actual changes.
>
> Yep. I'll split them into one for m68k and another for powerpc. Geert,
> I'll move your Acked-by to the m68k patch.

Fine for me!

Alternatively, you could just drop them. I do refresh the m68k
defconfigs after every kernel release, but these updates only go
upstream one cycle later.  In this case that doesn't matter at all.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

