Return-Path: <linux-kselftest+bounces-25816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36613A2869D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC533A80EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267522A4FD;
	Wed,  5 Feb 2025 09:32:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFB229B36;
	Wed,  5 Feb 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747977; cv=none; b=SNv8RMQH1P890wy4FtxYskYgLEyDNUZnGHlBXi1OCdYeR/wLkH7l/DwHQx+jRH3261pZFJRfYFJoy5af9T3+pv4H3qrISJMEf64dxeUaKyZEv02UuJK5D1vJIChSqEpd6+hKjz+Be7bLcpIxM+oYOlPUuOLiWqunRvfXj9q8Nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747977; c=relaxed/simple;
	bh=Agdro3bOdf17QBDFrbIxaxuU8tpqb48A39LtZ8J0lz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b++lsuo2n2vflGxTzAjTaROX5ODLKQA5F7lfbHGMuoQvFwxdRGuAAHOojwKW6q3YrW/lB7FQQZdWRragvG/H417er4kXpdq6ZmkyVRNkmn8ejiey1prw7MN7MwxmJbB9Xb9oWl+MNajaVB3VQkbz29M/STBMBGvY5asVkJdRiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8622c3be2f4so1841219241.1;
        Wed, 05 Feb 2025 01:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738747972; x=1739352772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul7RXmOlLWXbmp66NuHARFMZryclEeLS4nT2u1OB7IY=;
        b=WH6A2bLIfKrd1934W1wbpDSG+G/Dx2cDacwm7/a54mkc0YsYWOE3cLK/5zq4/rurGk
         hWbUXN7SDomAvcIX0Exkd2HB8GvT0npAgp7gQd0WqgtW05GnEnG0Us1DgeQI3DBPpinH
         jZpUDJj+IB4i8VSFwdiQ4k4O2hYgkPnk0y5oBxKUqIX5KOvAyXFC5xceiwSloY92VIUQ
         cztaG6ygY+9NuNM8wkN3zfL8dgQPPCNd+Si9tnhuYK1MVGiPZdZwjzLVzmaxSK5ZY0AW
         w31ED8QGI4sHU6a+MX9YUz4JMy/wsLhIg8JRkB2Vwx8A8NZ7Glq28LIw4dxmK1w57b5x
         uF4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHiE11p0EUBDfsaU/AG1Uih3iBkyiKg14bdLX+aJhierdumSwuxxpzYp8wYQYQ7XpRcJ7N8Y+UIN+Uf5Q6DUX2@vger.kernel.org, AJvYcCXfOdpCv1+B7mqldPvZYxUwAdkxbyyRdMWBdavT7jsCg+TyCCgDyA/kJa0VHYRvqwWe1van14wfeic+s9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6Lq+whmjlqwOby0FovrsAgOS4gSWhkMMYXPgopEroyx2XGEd
	F67JnCQ/WdmbVDYN7L7lVNGJX0NiQEoX4rEkHMwYnZq8PZyKsISqmKquGuHX
X-Gm-Gg: ASbGncvfeJ/L5t/lcqCqpzbUdhWF2s2YvWQJ9k1dtpn/sDf1VBKZhohqPuTq+4fTUNg
	WhS7f2HVNTmTQg+6kOfn0g7u98eLQgXvVDe1wfXcWku00SM8S5t71sLSTFi+S7sliE1PpPlNJLP
	9Mwor5OFpmZ/ajO48wOPMmrCpPG1NztoTO3tt82Vdv2oU5U2V7yzGxxOW1BVnw1MEs+zyM4iQp2
	TDYU2xx/g7IdqEdNNY/hbGF/oTsgsUc+oN1RVVAaIKkOIokWjWtSdOn5jQ7RCJ6f/ThJP1AE4te
	F7oM93qVp0NhPCZWKi+Yx6LvchG/iAKF+RbrnkLsn+49GmNG8NxfRA==
X-Google-Smtp-Source: AGHT+IGTJwqmBadrTSYVc//qFq05/hI4SqXYs6NsgpZqKlk4YMypfU3Waw6UDiKtHsUDFDYeIql50w==
X-Received: by 2002:a05:6122:4f90:b0:518:8bfe:d5f0 with SMTP id 71dfb90a1353d-51f0c0bd78bmr1339989e0c.0.1738747972378;
        Wed, 05 Feb 2025 01:32:52 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1c1495bsm1768738e0c.20.2025.02.05.01.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 01:32:51 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afe4f1ce18so1847523137.3;
        Wed, 05 Feb 2025 01:32:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUItAjZZGPEHV4gQo342JmST2/456Ie2qrxcFIdAs3ez0w5Lt8/imXAMNY/WZDZxMxsio98n+64E2KqCtY=@vger.kernel.org, AJvYcCXFr9PQspbqR1EV5e+90WQ8qvUQqDQTkD7rCH+riyV6LdrR9XfnPFOHlLB4MYlmtyYY2Ucb55BJAuHWOmS7dd9t@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:4b9:bb3a:f5fc with SMTP id
 ada2fe7eead31-4ba478bb5b3mr1358546137.8.1738747971234; Wed, 05 Feb 2025
 01:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com> <20250204-printf-kunit-convert-v1-1-ecf1b846a4de@gmail.com>
In-Reply-To: <20250204-printf-kunit-convert-v1-1-ecf1b846a4de@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Feb 2025 10:32:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjv6TeaFmJMzPNG=dScTbR=i7CktkftR=ovgn2YWUN9Q@mail.gmail.com>
X-Gm-Features: AWEUYZmlNybqMOBIyOk1oXnDuzzkfZ-3MWvNFlAbQZAgj-9ELYuznLp7GCiQaxQ
Message-ID: <CAMuHMdVjv6TeaFmJMzPNG=dScTbR=i7CktkftR=ovgn2YWUN9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] printf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 20:38, Tamir Duberstein <tamird@gmail.com> wrote:
> Convert the printf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

>  arch/m68k/configs/amiga_defconfig         |   1 -
>  arch/m68k/configs/apollo_defconfig        |   1 -
>  arch/m68k/configs/atari_defconfig         |   1 -
>  arch/m68k/configs/bvme6000_defconfig      |   1 -
>  arch/m68k/configs/hp300_defconfig         |   1 -
>  arch/m68k/configs/mac_defconfig           |   1 -
>  arch/m68k/configs/multi_defconfig         |   1 -
>  arch/m68k/configs/mvme147_defconfig       |   1 -
>  arch/m68k/configs/mvme16x_defconfig       |   1 -
>  arch/m68k/configs/q40_defconfig           |   1 -
>  arch/m68k/configs/sun3_defconfig          |   1 -
>  arch/m68k/configs/sun3x_defconfig         |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

