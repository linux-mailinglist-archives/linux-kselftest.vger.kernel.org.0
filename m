Return-Path: <linux-kselftest+bounces-22561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4F9DA383
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 09:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273EC166397
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59972176FB0;
	Wed, 27 Nov 2024 08:04:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB71272A6;
	Wed, 27 Nov 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694686; cv=none; b=XCcwXBs998O0TNVm2Qts8zjpWeiEo1FOKkwsGmekvUiVFbjG46Hhfubi3RwkplLc2LcXcoRupsf5hRhspO4qYRCSDxHZmE5vE3uw0ak+GmiDj/l7KcxfqKRwgVjaq8rwDqJTxW/JgtUACfqretQG/ZVd9mvSVn0+71dz77Y58Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694686; c=relaxed/simple;
	bh=SXMUsolydLhLlh0RYa90/Fp6yYGJOG2VlShDRyUu/0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcJ/MIOEZ34py2+alGlMyqeB0vbkQNljzZwIvdRCori58LUL+3K7YW8SdC8gIe3aD5XyGab0hQEkKyIEVOsTcrQ2F+fNwUIkVlvYFM63wA/b/4X1b0EFeldclRnHhuXTXngf3Tq8HXW879w5SJRe09gSaMiVRBu8P44UzcFT02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa53a971480so503452866b.1;
        Wed, 27 Nov 2024 00:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694677; x=1733299477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJwxTYx2memGrlAcayO/d+D9wemFJ5kB8ER25ZwyFGQ=;
        b=Fds54gQniJ4zFdwoD17IfiB5HeAV57PosFt12TKoJBM2SwgS3yJiWw4WDvKLzTAln/
         ANs7T6jSbYlxRDw0gbCRBPoxWO0fjBRT2/A8qN+//kxuG08UFu9Tq2OqQxScEGsndBqB
         r4jbgudanKmy6vSLY/zGsFvqas+ybPdEkLAthvv4wX3U/J1+UfT9vIe2JLYy8rHall8O
         lfR55U5XWUx15/PSULr39AvCQrZtjObNPJNaZsJuAobl6a7bsSUnXoVP4gZ8cNdCbr3d
         tsYzQRCkJFHeI9+yzdcar+okV7S17Xbj7a+P8uLUot0586e4gRWbyW+GRi7zEbiOzryE
         3p4A==
X-Forwarded-Encrypted: i=1; AJvYcCVLOWCEWY0b6S9VhvZpKalKmBB48ySO6QhKz1KeVwZ8kyMQkBRVE8jinY/1Y9g/bFR2pkUI628uYFhZwl5yd9s9dw==@vger.kernel.org, AJvYcCVvf9vOxzciEvh+X+IoTf43w7oFp2nI8t4Yvb+J6WAkQML0Brg8NIt+sfn5XB+pBXFffhCHzXxdzh9R@vger.kernel.org, AJvYcCVzPUzjClScKS29FypXvX3rERH88cDbLkwLpBHc2OlrHLGGCQucjBwwduI6QwRRO3i6gzhQjStMyYwmuIPK@vger.kernel.org, AJvYcCWZ5Bm0Vrztz/LNq4qoACPLT8nRYKThw7hKcrpSRMKh20+LtAUJvMoiwk5s0IpSoZHMguai5CNydAoYr14pFwmI@vger.kernel.org, AJvYcCWropiGdYISxAhwZJekx+qYKW20Iz6rIosM2lyz1bbhj3xgVGk135PydUjBy9VI45adpkrCyAn+f1MO/dE=@vger.kernel.org, AJvYcCXE2BAZLOwnVYKr+ZRSiH67xJE+RgixyhRTjahxisWzeQQh3/7POL5eUEtr2bgSQrhEXyoHZQPMoJaexDyAQKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNM8Fy3c98QfADlBDO1OQP2AVpLj6olJE42rrkLmu2fLzO7g6U
	pzHvKtQH8VYj8OOObMz7wo1ZCrNht8BxUfyWOSirrk0pPTTn/n7KRBuJGZiE3ViFMA==
X-Gm-Gg: ASbGncuT31G6ie8xVUktNfHvS8W7eThC+medP1hb+lu6+kUhiHGEOkKXLajR9vi7+VG
	lzg2y1fRefrZzXKGbT5BXAkQq5iGx1//N0wvIm7enX7awiWONxYEPrJOImbtpEjRKjDcaV/rx4I
	lM6I1JEI5NmKoa7lwYMa3d6phwmNqYr/uCbtRsph8eB1bWf9eYFvQMogBuhQBbhwoxpxBGsQqDl
	ta4UUjFDWaP6nKA6Pi57gNchrIAkkF+KBfINi0l1gJyQBpdtpqce2QR2yR2MTKZeTdtgEZyEgLY
	RiLrtBlueaW9
X-Google-Smtp-Source: AGHT+IH2ZFMUlwY9rPJbuBy7o4FAsS8SFcpcqgchzIerRi1sDz13OFZDxvtNt56KWdfEGWhFi5Mhww==
X-Received: by 2002:a17:907:784d:b0:aa5:2575:e76a with SMTP id a640c23a62f3a-aa580f2bc6cmr123462866b.13.1732694676729;
        Wed, 27 Nov 2024 00:04:36 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b3460d8sm675818566b.91.2024.11.27.00.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 00:04:34 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa549d9dffdso493993066b.2;
        Wed, 27 Nov 2024 00:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8rpD4sSnl/IJXl0iILhGx4aLY7OWomRTxETFj3WMr6vqVvc2wNSIvk5NqayI2GojJcwNgAjPhjj1re4e3847wWQ==@vger.kernel.org, AJvYcCVgjqSgmy00mgBqAXldFIT21W8+QCLHJIjRaxGANE1TYjysN7EHgBS7XdKm1MYLJcGrFeKDotiOjQvVcKxCBIXy@vger.kernel.org, AJvYcCVw58QsomuFFXVAg9aDDd8/JFzYOJmvopYac4kK/wzyP81Etk03ZeHO9KLYqwkyEqDMPQs7Ce3zhYGOPM7FEqo=@vger.kernel.org, AJvYcCWtEk/oYoMtUysECeCO7Ad3q+CD1oPmIBjlHmVQ1Sp05iIhMMCrtGhJ7DrdrEgB9HvKhoIBDAhNJ4sF@vger.kernel.org, AJvYcCXPXwBjUCITIYIu3AdfrKM4EKE8BWdc4Qw8U2TMq3hJnbmJTSs1aGU9dhj7n6cuDZP44+JkVGu0UwkY7Zc=@vger.kernel.org, AJvYcCXlHa/yMv8pcPq49oY8eNGUAzwcaYwwAQXyTz6VCHj3+yYG9jIZ16t1ZPH0Fz8mKwNd8o0puqDPHhmHyfSs@vger.kernel.org
X-Received: by 2002:a17:906:5a6b:b0:a99:fc3d:7c76 with SMTP id
 a640c23a62f3a-aa581057f64mr101384466b.37.1732694673930; Wed, 27 Nov 2024
 00:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020040200.939973-1-visitorckw@gmail.com> <20241020040200.939973-2-visitorckw@gmail.com>
 <CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com> <Z0aLFidHu/msXbXq@visitorckw-System-Product-Name>
In-Reply-To: <Z0aLFidHu/msXbXq@visitorckw-System-Product-Name>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 09:04:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVfQvA_d+ERuqRbd_aRVabUX4N=kKd+gc7RK+EArwi+w@mail.gmail.com>
Message-ID: <CAMuHMdUVfQvA_d+ERuqRbd_aRVabUX4N=kKd+gc7RK+EArwi+w@mail.gmail.com>
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

On Wed, Nov 27, 2024 at 3:59=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
> On Tue, Nov 26, 2024 at 02:27:09PM +0100, Geert Uytterhoeven wrote:
> > On Sun, Oct 20, 2024 at 6:02=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail=
.com> wrote:
> > > All current min heap API functions are marked with '__always_inline'.
> > > However, as the number of users increases, inlining these functions
> > > everywhere leads to a increase in kernel size.
> > >
> > > In performance-critical paths, such as when perf events are enabled a=
nd
> > > min heap functions are called on every context switch, it is importan=
t
> > > to retain the inline versions for optimal performance. To balance thi=
s,
> > > the original inline functions are kept, and additional non-inline
> > > versions of the functions have been added in lib/min_heap.c.
> > >
> > > Link: https://lore.kernel.org/20240522161048.8d8bbc7b153b4ecd92c50666=
@linux-foundation.org
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > Thanks for your patch, which is now commit 92a8b224b833e82d
> > ("lib/min_heap: introduce non-inline versions of min heap API
> > functions") upstream.
> >
> > > --- a/include/linux/min_heap.h
> > > +++ b/include/linux/min_heap.h
> >
> > > @@ -50,33 +50,33 @@ void __min_heap_init(min_heap_char *heap, void *d=
ata, int size)
> > >                 heap->data =3D heap->preallocated;
> > >  }
> > >
> > > -#define min_heap_init(_heap, _data, _size)     \
> > > -       __min_heap_init((min_heap_char *)_heap, _data, _size)
> > > +#define min_heap_init_inline(_heap, _data, _size)      \
> > > +       __min_heap_init_inline((min_heap_char *)_heap, _data, _size)
> >
> > Casting macro parameters without any further checks prevents the
> > compiler from detecting silly mistakes.  Would it be possible to
> > add safety-nets here and below, using e.g. container_of() or typeof()
> > checks?
>
> IIUC, the concern is that passing a pointer that is not of type
> min_heap might lead to compiler errors being missed. To address this,

Exactly.

> one possible solution could be to expand the members of struct min_heap
> into individual parameters for the function.
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index e781727c8916..ebd577003f0b 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -207,18 +207,20 @@ static size_t parent(size_t i, unsigned int lsbit, =
size_t size)
>
>  /* Initialize a min-heap. */
>  static __always_inline
> -void __min_heap_init_inline(min_heap_char *heap, void *data, int size)
> +void __min_heap_init_inline(int *heap_nr, int *heap_size, void **heap_da=
ta,
> +                           void *heap_preallocated, void *data, int size=
)
>  {

Which means all functions and users must be updated now, and possibly
again in the future (when there is ever a need to change the struct).

> Alternatively, we could use container_of() for type safety.
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index e781727c8916..fb96b1b82fb0 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -218,7 +218,7 @@ void __min_heap_init_inline(min_heap_char *heap, void=
 *data, int size)
>  }
>
>  #define min_heap_init_inline(_heap, _data, _size)      \
> -       __min_heap_init_inline((min_heap_char *)_heap, _data, _size)
> +       __min_heap_init_inline(container_of(&(_heap)->nr, min_heap_char, =
nr), _data, _size)
>
>  /* Get the minimum element from the heap. */
>  static __always_inline
>
> The first approach has better readability, while the second minimizes
> the changes needed. Please let me know your thoughts.

container_of() is a well-known idiom in the Linux kernel, so I would go
for this solution, for min_heap_init_inline() and all other functions
currently using such a cast.

> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -777,3 +777,6 @@ config POLYNOMIAL
> > >
> > >  config FIRMWARE_TABLE
> > >         bool
> > > +
> > > +config MIN_HEAP
> > > +       bool
> >
> > Perhaps tristate? See also below.
> >
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2279,6 +2279,7 @@ config TEST_LIST_SORT
> > >  config TEST_MIN_HEAP
> > >         tristate "Min heap test"
> > >         depends on DEBUG_KERNEL || m
> > > +       select MIN_HEAP
> >
> > Ideally, tests should not select functionality, to prevent increasing t=
he
> > attack vector by merely enabling (modular) tests.
> >
> Makes sense. Thanks for catching this.
>
> > In this particular case, just using "depends on MIN_HEAP" is not an
> > option, as MIN_HEAP is not user-visible, and thus cannot be enabled
> > by the user on its own.  However, making MIN_HEAP tristate could be
> > a first step for the modular case.
> >
> > The builtin case is harder to fix, as e.g.
> >
> >         depends on MIN_HEAP || COMPILE_TEST
> >         select MIN_HEAP if COMPILE_TEST
> >
> > would still trigger a recursive dependency error.
> >
> > Alternatively, the test could just keep on using the inline variants,
> > unless CONFIG_MIN_HEAP=3Dy? Or event test both for the latter?
> >
> I think that having min_heap_test continue using the inline variants
> might be the simplest solution?

As lib/min_heap.c contains just wrappers around the inline functions,
that would be fine for me.  If/when lib/min_heap.c gains more
functionality, tests for that can be added to lib/test_min_heap.c
inside an #ifdef CONFIG_MIN_HEAP/#endif block.

Thanks!

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

