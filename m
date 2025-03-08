Return-Path: <linux-kselftest+bounces-28540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20915A57A41
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 13:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2CB188FF5E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FD1BD007;
	Sat,  8 Mar 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZkXQqml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827F1B040B;
	Sat,  8 Mar 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438327; cv=none; b=AIX91d1PLIpW50F+QmWAFStkwfDBO1Ck7DBAJ3ZhXmhL/ze4spHf+iI/d5eS8jXle/A8SynurnZfS1p2dSz2N8i7uo3hPQdJ6j5OoFkFcCIOPQucWVC7iD+RYcGHEx27q3qH/RZ1Iu+ZszWNt7JoKAgrs00QdaAUihyHAXsvKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438327; c=relaxed/simple;
	bh=ljcSe8icqYARGbv2/xhAvm/DCpz0wTGWoW545h+pz7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bafYscWi/iJDggG5ZoOhVVt4ILnHoD6DNqwPcji41Gf4CEp+O1Ldx5gzJHpOw/59OUssVk+IONt5avW76HSAWGiaXB+4ZY9f3crhzNBkINI2v6jOC4XB7mVVnRNcAvHwmnUDM3btzxVq5jsYhZsDMM7Sco8vk9tx2IvL7HvO1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZkXQqml; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3061513d353so30829811fa.2;
        Sat, 08 Mar 2025 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741438324; x=1742043124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljcSe8icqYARGbv2/xhAvm/DCpz0wTGWoW545h+pz7A=;
        b=SZkXQqmlbfk+OwOmVB4I/lPj9ZKJDYzGYOfbd+EQtrMZfOC6ZdxiR1gevRxlP+HQDI
         r1P67B5pDfAKu3vtjXH6tJ1t2OmV+FPNA2Ba0AIjp5UCxmpxH3H5wo8zRnhPW4ydgH5K
         2253GfEr1FRth0Fqu2MyBA4Lgy+2k4TkqT40u2UD2MTjyA0/XBAJOE3Rufn9DRfEvbb5
         MpmxaenOl1L6TBysZk3V6bRHzrgkXsJdozG3jNygjsp++c5z4R/h4lPm0bu+m+wSm9PJ
         9XusM2mM/Fq7D0uTkaco/z+I7Qxj+fgtstp1y5bjhf/i9Bzt8F7YRGNCoImageNvpa+I
         ckHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741438324; x=1742043124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljcSe8icqYARGbv2/xhAvm/DCpz0wTGWoW545h+pz7A=;
        b=RcrLBea1ps/Fw3QmFXnhJA+6oX0He7TaFTFjfOuyD3Zb+7z+pO8DOc84fOCwdIfqg7
         aLg4L3VEYxhP8VV4W2aIHQSQY4NgJ6LZV6sgmYlBxkVrsFZcA4/vf2rhlRAlUosfSL2M
         Mewt5Nky32BDDevdsajD4afpzlYIqMDy/eundbVmSiiaHI7eQLF7Fdx0qI50DqDlbG62
         8zKRtGUBSVJoHYEc/NUK2IF3rDPOPyASZQyWnfoiLfMytVMLAq80KbyOWqV6uXInF32Y
         VMs+2DeR/AuJcc+6uWzBGnSUPeSiOqoi4Yf8/7FKJfnchsRf/Z5Oh5eXHckhscTHjZrY
         tvsg==
X-Forwarded-Encrypted: i=1; AJvYcCUM+Dj5VT/3SzyBhL+AgFLJDMgvkbiH/m/pg0SSZn7wL7e909+4zoidyMY7SHrnRC8eXgAr8dvwPa4=@vger.kernel.org, AJvYcCVIB27o5lEBObdQjwUccKkV1U6mD4qirAFzGPgcfQSZNauaoIUNqKhyfilpqsdfYfmwLI8ygCkfIcOBeul/@vger.kernel.org, AJvYcCVKmr49xmJYTPI5Yd69KZQK6QR9uwXrIkB5eNfjs9nlmKZxK7X4WlWRaU6wn5vzo29Z14c3xtUyC5KF@vger.kernel.org, AJvYcCWEFKOQ+fxxpc5vW6k4r8TwUcJwSJ5M6tdRC5SKQJNuTS2pTYO5YD8spCTbBBNGXqRY0na4k57oVYj1c3g8JPGP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hXE27kVUVavWpKWr5P5aQC0dOZT1VWZgmS5Fv7JbPS/ooMW5
	OHcsSfjPEZtjjMXmf8xhd91JdqYwbati4BeTTlvFBFoDnLcwuNeYOCB0nHkU6rRFXbn7YGoRbCi
	fwmx4zu0fJ0GQt2/NvWAdC/9HTmc=
X-Gm-Gg: ASbGncvGL1NWlS3m1QVJIle4o+HPzomi3miKrLaUwaASyv8j2E7XrG7dMNhTFjLS5em
	TQl2C5vrZCUN28RyrN0NqlyOY+BVxuC9yOwNnmz1sIWbc8fv2z1tBora+rayF7TZbbAN7V/C7V0
	DP4O3BFcqV3KgV3efjqVYEj4eAJme6J8KuAekBtcxMtXR4IqsbsFVI5iKQliK3
X-Google-Smtp-Source: AGHT+IHdstqcViUgKKVj/dxOVnnCRmRtk0n+Jmb8EXvBPRxEstCxyV8oevucwu1Qdxz344u8wFGVHkGcozJRwQRyjxo=
X-Received: by 2002:a2e:a495:0:b0:30b:aabf:fc4 with SMTP id
 38308e7fff4ca-30bf4535ca8mr20702861fa.21.1741438323386; Sat, 08 Mar 2025
 04:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com> <202503072046.34DAF614E6@keescook>
In-Reply-To: <202503072046.34DAF614E6@keescook>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Mar 2025 07:51:27 -0500
X-Gm-Features: AQ5f1JrzFDCikkubFSehWJW1k-o-BEpIkGHx4XfrgD5nfeGf55hOd06bCk68tB8
Message-ID: <CAJ-ks9kTO-u+Wqp0K-vdMLAs08fBeoovSeb_pGkMjSHFnBKysA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:49=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Mar 07, 2025 at 05:08:55PM -0500, Tamir Duberstein wrote:
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and scanf), the rest having been converted to KUnit.
> >
> > I tested this using:
> >
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1=
 printf
> >
> > I have also sent out a series converting scanf[0].
> >
> > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386=
d7c3ee714@gmail.com/T/#u [0]
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > Changes in v6:
> > - Use __printf correctly on `__test`. (Petr Mladek)
> > - Rebase on linux-next.
>
> Thanks for doing this!
>
> If Petr, Rasmus, Andy, and/or others Ack this I can carry it in my
> "lib/ kunit tests move to lib/tests/" tree, as that's where all the
> infrastructure in lib/tests/ exists.

I think the plan is to take it through the printk tree. We're still
working on it, here's v6:
https://lore.kernel.org/all/20250307-printf-kunit-convert-v6-0-4d85c361c241=
@gmail.com/
where I've rebased and put the test in lib/tests.

