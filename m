Return-Path: <linux-kselftest+bounces-26183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DCA2F19F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5161886748
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36057246354;
	Mon, 10 Feb 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRs2/Jqk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C824394B;
	Mon, 10 Feb 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201097; cv=none; b=FQZaf7ZTyIll7SAt7dsgQ+5wkXIDpIvBnzoxkj1Wlpe9dFeZtR9Pkhisi8ldqZ4rOaAotVJQpefR68qNOBle0J2IkifHtHqTxpqvNbty/r+6nKuVFU6yL1AR+rZMU0fWTwMfF5v5t7+u3WIHh5O0Ss9Xxy7/6Wg+bWDJi44ktNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201097; c=relaxed/simple;
	bh=k0Q07bztCWaLShrvCVnk5v5klW2CE4eQ9OXgFiMJKg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er1DpP2uF0BNBnPw8AGtoHBpggRYQbPmO0RpkPfsexKxOh7c7wo3K1F3CZ7fgTRmG5SKZvLHuGAq6Qwnbut9XmpWo/y9On8ReJNS5SAeDKLNkaf8D29FlSkNXKpurdDzqndmWKl2TPk5UpHLDr2qa5+1fw55jmWOqbgqqkHloz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRs2/Jqk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450475df18so2278271e87.2;
        Mon, 10 Feb 2025 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739201093; x=1739805893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw/InAfIa+4VxZwR9v/Nmox0XsF22Sii//CtbSK6F3o=;
        b=LRs2/JqkfY9ohfq5XiiSYFWpQeiWk/Y9QqxXG4E+ITc5ZzOPkhSdIdA8kcffIrwY54
         8HdQR9oYsLh2CCWRaBbJi/bS6JyR2cC7MuLFlurb6Uit2fMXyMaEMImHQ0XgX80sem2/
         Sk2WcAN9PQKpi5twC3ZeQatEXhMt8s7BH2RK0O/WhaCCueELO1BPIeMYJAK3C3j9V4s9
         OdH2D9o2hjH1kkWYCbm57uoZlKaTeHp7DRaL1hW+WhYv4+7+j+rTsmBeUf2oPVAne9lT
         TvT/Q+4fqZHQycusrSUgMjMAGiIDm/EQjVVANKTsB7Dma1I3fybqAZ77Ke2D+0WNhv49
         ylqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739201093; x=1739805893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw/InAfIa+4VxZwR9v/Nmox0XsF22Sii//CtbSK6F3o=;
        b=lZyIbhNWeCkZ3Nmn6MgyAPuWrLK9ddLZ8JBJ4vzkWxw+gS9vfHpO4pLKi0qWqrbLUk
         nowUPgtHAASlm5F0mhWk8uk/8tyzNN5CcIp4SkxUvuUaRr7ssnsNiWoeN1tDZvOEJCYo
         kHpGjmRP8qAx0HwZ75QGKojbD+rYyKjS3pgqROlGvfeUg3aEjFpy24IDAB5FJFekDeue
         vNfdLt1iTctieOW1ojvGwdO+rMEhLokhvLtozcevF56inDRbPdRIPebyVnYEyvHa2tG3
         jjqCIfxHZtnUP01JU/22PLyz6ccuKV+B5NNEK/VlBqEwN1FdrfaXDfHAAhRUb71KYc+a
         9lJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJvOU79W8+G7zCXkErpbocUoJrt5B0eE1WNfk2w6Uj+3L7qksJ8vBR/wF1jbBm6vS8lR+CN3mNRuarolQ=@vger.kernel.org, AJvYcCUpNnZnVM4O6oEh6asqPbNJ42Lme0ON2HXJGXPMQHieynFS+9KM9HEP7lCyo3HvSwpXjtEfFanOKxMym9AJ10QC@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSQWMVqNfB1KXYiqXOxTvNE5A/TnccqycfogpQjBQpwtl+rSt
	AWwUwCdqHGOZnQdAEOeZmrU+eXbb2ANOZLbU5u7k8LU5Vn3VnlIwa/QrGHsjxuKWE8k5V0ETcUB
	ndxug0wL1sEUsJLonJuV5G3+NaVE=
X-Gm-Gg: ASbGncu+2Yy4qNtUFzkk9q0299avUredzMzI5XUqa4cdge1y45+++UjCeSlkGRltJdq
	lzxFFU563qBdk1cJFzrCfHOf74f60vAyo8lTV3/wdniEeUF2DBgV80tb2K7l6h9+Uq0ei/yGY67
	QteblnR7w3YoZl
X-Google-Smtp-Source: AGHT+IGoSMh7EH4P9+LGVzbole39Xjp1jW9oVRbrWhcgDzpzPQbXU73CsYFIUn4K0Tnn4K8JxHUmrG1S/UH8NdF/4lI=
X-Received: by 2002:a05:6512:10c3:b0:545:d54:2ec6 with SMTP id
 2adb3069b0e04-5450d542fe1mr905821e87.2.1739201093038; Mon, 10 Feb 2025
 07:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com> <20250210-scanf-kunit-convert-v5-1-8e64f3a7de99@gmail.com>
In-Reply-To: <20250210-scanf-kunit-convert-v5-1-8e64f3a7de99@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 10:24:16 -0500
X-Gm-Features: AWEUYZmZqsNUlFRzk2-hf5j7H49pYmWgDbwExh4tyVgzqVtFfS61cOxhR4flJk4
Message-ID: <CAJ-ks9mE21a4tNn8yp6vUy-iME4fxngDEr+2xLWj6Bk7dOXFYg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] scanf: convert self-test to KUnit
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:00=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Convert the scanf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  MAINTAINERS                          |   2 +-
>  lib/Kconfig.debug                    |  12 +-
>  lib/Makefile                         |   2 +-
>  lib/{test_scanf.c =3D> scanf_kunit.c}  | 228 ++++++++++++++++-----------=
--------
>  tools/testing/selftests/lib/Makefile |   2 +-
>  tools/testing/selftests/lib/config   |   1 -
>  tools/testing/selftests/lib/scanf.sh |   4 -
>  7 files changed, 118 insertions(+), 133 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..ab1d90c66c02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25411,8 +25411,8 @@ R:      Sergey Senozhatsky <senozhatsky@chromium.=
org>
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.gi=
t
>  F:     Documentation/core-api/printk-formats.rst
> +F:     lib/scanf_kunit.c
>  F:     lib/test_printf.c
> -F:     lib/test_scanf.c
>  F:     lib/vsprintf.c
>
>  VT1211 HARDWARE MONITOR DRIVER
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..d35b60203856 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2427,6 +2427,15 @@ config ASYNC_RAID6_TEST
>  config TEST_HEXDUMP
>         tristate "Test functions located in the hexdump module at runtime=
"
>
> +config SCANF_KUNIT_TEST
> +       tristate "KUnit test scanf() family of functions at runtime" if !=
KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this option to test the scanf functions at boot.
> +
> +         If unsure, say N.

Ugh, I meant to change this "at boot" to "at runtime".

Petr, if you are willing to take this through printf and apply this
tiny edit, I'd really appreciate it.

