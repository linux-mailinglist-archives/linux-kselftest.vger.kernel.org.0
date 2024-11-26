Return-Path: <linux-kselftest+bounces-22535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C79D9887
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC92841CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185FC1D5171;
	Tue, 26 Nov 2024 13:27:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA81D47D2;
	Tue, 26 Nov 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627650; cv=none; b=QvPaKvcJAxEQl+IIYJX78Ze+jJcGMflqQVWtHHEGyMJUqIsNr33UBYqthp64jfPCKAJ/6f/fui8aATlGCt4TulsFs07U8cH+z+PaNLqVNdGBLQfa9YxTJsySkY8uHsa+5UECgfXuolSLeThAxeUGN1q97H9ExANBY3mQXwtirSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627650; c=relaxed/simple;
	bh=kB14QwEsljC+Ih1ESFLNWeIU3yAv12TYYWftsJsDocU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIALUs60UqUAKGMwjYegKJ2q+MRTg/PIsY/Z0yWT84vvtHuBfc9tILIcoLhsVRsQR6Aai4i7rLDLX76CPx5enWfDUpcSIeXxF2DJfwkZiys7L94mG30+SayIE2mAJtdsey2N94EUc+8lf4ISKVnj8MUAQTZ4KXvnn3vlqok140Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eebae6f013so57425817b3.0;
        Tue, 26 Nov 2024 05:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627647; x=1733232447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdSJmr80vU+P2PQ4iahpq7fx/jHhWG8mOuWEpt3bZZI=;
        b=j7/Lw2C1T0DD+h7tLbug1n2miFbzTRfbg50jUMRIPBkAq/Y8RMZb+Bw7+P6P9Cs0sn
         80mjGvjD5v8olabMSAUuO9INRxW+Qw75+1CAYyuhl6DQ0e6Zx0/Q0zVRrA1ADSrf+Rr9
         Ahmy2UOToVutM+yITwRVxXvbbnb2DgueMK/KMhtCjfPbc7olBQNqcd9jhS6CikEvnNWE
         1WyaxznxvI7oS3jipGxMGOUGxdK5Qg7mCcc515YqNIzxQYhvqNj4d9CeXs51Hl1dbV6D
         9iUs4CwJCjuo5Qlb0TdNRYWZIex3VSzrCO5+rk4t3VtWSgRSmB3I6VXYLloD+2RkpcK7
         Uhbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4dFcK1FEf/YM6LqcAGSXAtdBNGPDB15AtDAutjwf1/qUOIdocWTgma3WGY37ZqAWATTeyXQGTVi85aaU8N90=@vger.kernel.org, AJvYcCUN44AT3lg0nEQ3/p0O4oT2aq2HFh4t2ll8NcAE1xKUiVoRw9CI/Ejf9hk4DXI5mLUG/DxaNQQtXMLx8vU=@vger.kernel.org, AJvYcCUnDUpNEv1+71VeDeBohmuJA4MDFB6z3t1ZOtL+9d8LqFc5QlYNzsUHI7Rp8oBVc9d7S6o/0/rg2CLuexakXbyakA==@vger.kernel.org, AJvYcCWLQc5DFEE/yke+akJpm1C5oz0pxK4a5Ta5kCX40hXBXabuJS8FAywyyaVVUz9lL4tDOrRi/369XJtr@vger.kernel.org, AJvYcCWfMjcNAqMrmp+MorxKOQZbQ0iskLDrmh+u4N9dyoTYcvPMIC9zQU6mwxzMqKAdviKu+YagoK5HwBlQpUdD@vger.kernel.org, AJvYcCWvC8WdQz1jzbCQUC8sSZmMSjBzS327pwxDb5uZAv2apDGdgJENsI0R0pbW4KFhnQwfrBVAeQqfY8Si+UCzX+2W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/CeNClzXI2IyPuau0fuo4mF71uoJn5eRneYTDd8C+etG1Ptx
	aaxkEUdaHO9AsK6BxBidPeB+NaH+yPxUvVQPmsxPwoLnmAoym8dQ82qp0Y9t
X-Gm-Gg: ASbGnctYGa63TPPUnOuQWTOfiVdUwXyxd4T9RfDNd6SFOs1077otuapvnzzpqtOXFG1
	YDyR8bdk169mYHzy7FzYD+lRWd9HIN4CPR9lMO+HApnBkgPfL1H75CiuGDXeqQ9JWKvZiSVIetp
	K1VPEuoRFNv6vQMOZkIKBYgm/ef2gE+z6wEr/4xivwUNvZxWnYgW4dmu8qKpOxY9uH5F0cMfSwA
	6RsSvMMMmxYQm0R0mgJNf1t7hopFR3ujkCObejd9VfVa70PIZsWGmoUN6qtoVDimfKrxtVKLq3V
	xLXYq/DOG0aa/axp
X-Google-Smtp-Source: AGHT+IEU7w+iQBaxVEpuVxQiYxuZJz6AN66EtR8TI0rlVs459R3/WIFwJpdtGv3oJRYiwRN+nKXjXg==
X-Received: by 2002:a05:690c:690e:b0:6ee:d9a3:c85a with SMTP id 00721157ae682-6eee0a26568mr137840547b3.27.1732627645299;
        Tue, 26 Nov 2024 05:27:25 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee009cb80sm22674607b3.117.2024.11.26.05.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 05:27:23 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eebae6f013so57424537b3.0;
        Tue, 26 Nov 2024 05:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHUZ5Z9nkes+JDwwL6K40DlxVaPP4qTnNNq+xt88ormFiKMcLZjUvK/PGbj6mmYNTMvVxzBQTrWWVPqCE2nPSadA==@vger.kernel.org, AJvYcCUaz+4uQFe4DU9QJdq+AhTMo4VpWq8IbaAAfTUTRddhRgJF/WNd+FVqLmPyRO0qgb7Mpr+LJKo6tOk+@vger.kernel.org, AJvYcCWaZGV9GHV6WJf4jBRhBHPMmyjb4hG4l0xJ4J0sS0892/7T3P951dWIWyvVddsRGOmZW7rpyDrlSsAXL0+C2UKn@vger.kernel.org, AJvYcCWpp7codf5NJZDrQPf0j9k0yHYfNic9JKnU3H7G0bmFlqJhyoJmIRG0ol+kroXp3hZV6o0Do364PnurywQY@vger.kernel.org, AJvYcCXm0bMAo4OuUokLXaUI1AG0BODTkdoOg/uOyBKJ8r304SHzBgjn9sDzgSKAc42KVvH5SH2sIuGCYNdg0pQ=@vger.kernel.org, AJvYcCXvYKfHEC+DDZcLEmvVF7I9dnTJ3T6YS7IOpO67hFUFV8NTCoEybyClVJPrca6cUv5jS1ANDOlf6IY8Aj7WdSs=@vger.kernel.org
X-Received: by 2002:a0d:d303:0:b0:6ea:807c:bbaa with SMTP id
 00721157ae682-6eee08825d3mr111480937b3.5.1732627641261; Tue, 26 Nov 2024
 05:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020040200.939973-1-visitorckw@gmail.com> <20241020040200.939973-2-visitorckw@gmail.com>
In-Reply-To: <20241020040200.939973-2-visitorckw@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Nov 2024 14:27:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com>
Message-ID: <CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] lib/min_heap: Introduce non-inline versions of
 min heap API functions
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	corbet@lwn.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, willy@infradead.org, 
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuan-Wei,

On Sun, Oct 20, 2024 at 6:02=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
> All current min heap API functions are marked with '__always_inline'.
> However, as the number of users increases, inlining these functions
> everywhere leads to a increase in kernel size.
>
> In performance-critical paths, such as when perf events are enabled and
> min heap functions are called on every context switch, it is important
> to retain the inline versions for optimal performance. To balance this,
> the original inline functions are kept, and additional non-inline
> versions of the functions have been added in lib/min_heap.c.
>
> Link: https://lore.kernel.org/20240522161048.8d8bbc7b153b4ecd92c50666@lin=
ux-foundation.org
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thanks for your patch, which is now commit 92a8b224b833e82d
("lib/min_heap: introduce non-inline versions of min heap API
functions") upstream.

> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h

> @@ -50,33 +50,33 @@ void __min_heap_init(min_heap_char *heap, void *data,=
 int size)
>                 heap->data =3D heap->preallocated;
>  }
>
> -#define min_heap_init(_heap, _data, _size)     \
> -       __min_heap_init((min_heap_char *)_heap, _data, _size)
> +#define min_heap_init_inline(_heap, _data, _size)      \
> +       __min_heap_init_inline((min_heap_char *)_heap, _data, _size)

Casting macro parameters without any further checks prevents the
compiler from detecting silly mistakes.  Would it be possible to
add safety-nets here and below, using e.g. container_of() or typeof()
checks?

> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -777,3 +777,6 @@ config POLYNOMIAL
>
>  config FIRMWARE_TABLE
>         bool
> +
> +config MIN_HEAP
> +       bool

Perhaps tristate? See also below.

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2279,6 +2279,7 @@ config TEST_LIST_SORT
>  config TEST_MIN_HEAP
>         tristate "Min heap test"
>         depends on DEBUG_KERNEL || m
> +       select MIN_HEAP

Ideally, tests should not select functionality, to prevent increasing the
attack vector by merely enabling (modular) tests.

In this particular case, just using "depends on MIN_HEAP" is not an
option, as MIN_HEAP is not user-visible, and thus cannot be enabled
by the user on its own.  However, making MIN_HEAP tristate could be
a first step for the modular case.

The builtin case is harder to fix, as e.g.

        depends on MIN_HEAP || COMPILE_TEST
        select MIN_HEAP if COMPILE_TEST

would still trigger a recursive dependency error.

Alternatively, the test could just keep on using the inline variants,
unless CONFIG_MIN_HEAP=3Dy? Or event test both for the latter?

>         help
>           Enable this to turn on min heap function tests. This test is
>           executed only once during system boot (so affects only boot tim=
e),

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

