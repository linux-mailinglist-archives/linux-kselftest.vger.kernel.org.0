Return-Path: <linux-kselftest+bounces-26192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB68A2F36F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BC1881439
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052782580F3;
	Mon, 10 Feb 2025 16:27:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85552580D6;
	Mon, 10 Feb 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204842; cv=none; b=gA5fV+fOmpADKz/INsbYv9jw477c++rbeMSYbCkye4lidaarJJlxS89nZONO6PCVISsw5cnCErAA5xhV+akafTYQpBqaQly8Zu9I3hpdfmNmJ1T3afCQPVBPngwCgJB74IdaK1Ovr2E3iIqFwD52iizF/QdqJriJZMYg1iOixd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204842; c=relaxed/simple;
	bh=KuMe3+MDTwc+Rnc7r/9bMIaCdM012Bs1ibmPwlai+F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehXtWJ+qWbeTrI7tKV7+Zu53r6bDhJ7gg0EfAVRTsA3563C3zm164q2tiFkch0NWw/NSscm+nrIIjKOTS7c1Edk7BBccZ+4fkudNwHP/ExgMNuJqv9AxvS5Bu1OnU+RFkKnuh1bnNEl13O4gG3hBVeSIXYzSxgHKpOIAPV4IeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4affbb7ef2dso3457804137.0;
        Mon, 10 Feb 2025 08:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204839; x=1739809639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqbX4psAGJ/PrujVLmSoQSl1kgnOHwvpt/Be/t6GDZw=;
        b=h7CLDpsXt9pf4Qghv7YTCxRO194MSIQoChurMwRKEGveNuFVxCIJm49Uzais8rZYbs
         FewJBC4TwAUy70rsHhPKAEZ5hh2JsB8DlZm+Ix6e8eLJ5IUhAcKBhfqzk9IJ2oAV/bIu
         +tk/Q5aCUhZ3d5xRatMpAHHXr0K3RyhnsU51FCamU3iu6Wy2PXHIif/cKEF70rLtSAJ9
         LidpyT5zv3kLlagDCEIybj+MU66gLmXFVbV1u6DoTYAj+vr7oT+GLZYTu9t+CKSh0dIo
         ZhEoKQRUG8zW2etjHG0sHxpgrsZeM7S7roboGbW76xEH47FNQH4PogAkdEtSsWZJvpP9
         4CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtClXNNiJufwfuHwoS299grJUjPvMiSVwHpE3Le7rghspkcroNeT0jth4ouB5iUJA02R2kpViVUqaqGtr1Jtus@vger.kernel.org, AJvYcCXuNj9kgdNvX9v5NPBgp0XOFVBxhbfSOMH0FRLwpCP9t06y3ZOl8GXTQywQhrx9RQ2ZwErgoEaiscNTt8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCyVg9H2WGLPU/i86pp2+8sL9apJq9cdnjKVk01rrOVQUQ8r2
	co0gOYkUJpVct47tVUl4YhClVOZFawOTVtt27byZoo3CEGO0ZHdxFqHbI8jm
X-Gm-Gg: ASbGncufayU6qfO3Ys7lqsC6FJBOotlkAYF2Z7PSwG+sgg7G8Iot4atjV+Qzn2LFbof
	TLiZZWFeTmc5w610mO132f1ckLN4Lg+14lODuj3zRuCNgN+fjudhutDYXKk7zQ8GjFKiotMdBfR
	q9ZVUmcKlE+SFqymYP+GvVMkNSQ6Td8HojhT33p8tbhxrrwuYfFqPXkZNucb9kC2ztsM3JspPTV
	9G66TkNHyMudSVWeYCY6WTl+fTFxJwelTfgKscR0edplutUy1t14W7vaVjrvXSZ+tTCW+BYAdtQ
	dD0L3jMbRB9Rpix7UkWDZA+UaA70cL/QCZFYn78RjIkslIDOwOZXIw==
X-Google-Smtp-Source: AGHT+IGuxsDi8qW8F7BWVNEO/Pbjh0THpoKjO09AnXLhgrUUbLqtfnM0/M/Do5G/oTI8lLpt5ahBmw==
X-Received: by 2002:a05:6102:3046:b0:4b6:fdc6:dd04 with SMTP id ada2fe7eead31-4ba85ec477dmr10168353137.18.1739204839107;
        Mon, 10 Feb 2025 08:27:19 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bbbebc1fa0sm676139137.15.2025.02.10.08.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 08:27:17 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4affbb7ef2dso3457755137.0;
        Mon, 10 Feb 2025 08:27:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTxFqqk5qIhAiytInVz0JBy8P6fbWie48hOEd/q2/aGhmwOri/XaY9t9IN9bcXNsbBxhrGVKKhsGA/EZo=@vger.kernel.org, AJvYcCV2kMun0fPB6vS6d76FzQqjFYQ5+9sSOvuCjIca5U68ay9gEmfuAT8co3+lDTUnphW+pBqEb3/WNa9h1GtvH71m@vger.kernel.org
X-Received: by 2002:a05:6102:f0f:b0:4b2:ad82:133a with SMTP id
 ada2fe7eead31-4ba85f407a9mr9701403137.25.1739204837046; Mon, 10 Feb 2025
 08:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com> <20250210-scanf-kunit-convert-v5-2-8e64f3a7de99@gmail.com>
In-Reply-To: <20250210-scanf-kunit-convert-v5-2-8e64f3a7de99@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 17:27:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnqqffKUQ7+usXruWce8B0KdRxxO41zNY8bTfh-r5oHQ@mail.gmail.com>
X-Gm-Features: AWEUYZm2EYJA8ZA_5wFNdPwcX5XuV0_TVa-Ox5vT8RiMF4s-d-aO03s5oFok9fE
Message-ID: <CAMuHMdVnqqffKUQ7+usXruWce8B0KdRxxO41zNY8bTfh-r5oHQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] scanf: break kunit into test cases
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tamir,

On Mon, 10 Feb 2025 at 16:00, Tamir Duberstein <tamird@gmail.com> wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for your patch!

> --- a/lib/scanf_kunit.c
> +++ b/lib/scanf_kunit.c
> @@ -4,19 +4,14 @@
>   */
>
>  #include <kunit/test.h>
> -#include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/overflow.h>
> -#include <linux/printk.h>
>  #include <linux/prandom.h>
> -#include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>
>
>  #define BUF_SIZE 1024
>
> -static char *test_buffer;
> -static char *fmt_buffer;
> +static char test_buffer[BUF_SIZE];
> +static char fmt_buffer[BUF_SIZE];

Why? This wastes 2 KiB of memory when the test is not running.

>  static struct rnd_state rnd_state;
>
>  typedef void (*check_fn)(struct kunit *test, const void *check_data, const char *string,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

