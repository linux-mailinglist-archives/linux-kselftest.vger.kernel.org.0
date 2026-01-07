Return-Path: <linux-kselftest+bounces-48392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA181CFD489
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 11:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF651301EFA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85932C925;
	Wed,  7 Jan 2026 10:41:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C232BF3A
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782504; cv=none; b=NMHoGG7934eQJ3PbW9SuCwDYyuEPAWEDcQAzAOASYWlzxrhFskzDUxOu/FOzQnxkBt38VD0fmYnlsQn4wbHkQco1B3OGaPbaAgx914VSk3XHklHOl1+YE1rLlpAz+nBlXXDcJ1pDqzypDX7mkZvv2zbk5xJ5KIs5799NttLvxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782504; c=relaxed/simple;
	bh=3G+5WLxr801LfCb+fThLhWi0U+HQwk8IIODaVvQ7MIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIiwhU9wGC5xFmY36/kAkwo/pRJa1J5tTqFu3GCwTGbfvnjds7EUUp2UHy9wr6L4p2UoQrDiNfCyNQaDsw/fR2tbpW4wJT3dNriFGOwUtoc1/YdD8itL2KmmEg9lI6vDsDkgKYS9k0pIKbzO0EYev5Q1ONrJNxQ+q6dxzwq7AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55b4dafb425so407263e0c.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782501; x=1768387301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h26s9qxVzx6i94rryG+bS8z5szykJ6vgBViKfSRodKE=;
        b=jeECqHzOH2foKNN3aXqu8HLVSSKOv1/jLqwg8RwY8igEX5aBSzTPa14uc7fJEl7duQ
         zSfZdoEbzs1H4Ao+dTHJikVN14eGyDNUxOIJctcjYsfFq8D0WPwC3J/Djzxs9gIVVkBt
         0WrNnZARA3fuWgysMRSLtkvL0AYNwzbTowOHlJkHjuo8yK+zlEOFw9Yn/iw5krCQKWDH
         Z8uxxgz5NIyZDxGVXY02XC+4R5tlu83k9zZ0e1F08yvsW1fGT7Ga6BIy/ihqwM5ANmqK
         IfdGTogpRvbMDYDgq9kVQx6PUdGshFWPBh5DOHHFsOJIWXSD5KJ/N+pFjDv28d3CtFxt
         pN4g==
X-Forwarded-Encrypted: i=1; AJvYcCW8uy7F8+5DsgdKpvbJ4kN640zbtU37f9Ibkx6CELUzZnL6KlQ7D8qBzsZWaPA24y+fTIoDbb0q8xAR9DUJ7KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8luaxgigyDwpzYBCvvlQZpG4A+LLDZQmK6gm967Kyx1XqM1w
	0Zp+bbZmmgaAAZHu8evN0E7PCzuS0OkNcLX59JvrqlN+DR31YX99cJZaVsWHMd45
X-Gm-Gg: AY/fxX4hmJmC3n5I5UKN0bIrzDTZg1NTfUClHmcJ+TjNakLAEeVUw72r4PbAxvH39qz
	UtAki7JMsh76pIPDJNiD9E1mjgprmTA+W9ibNOMYuT192Y30cbjRLuYNXjMnTGJEwRtFZVRRTaJ
	NTOrn/fbVEUlKTEAXFXy1ROnczUSm7Dd3H0BaVlopbKGNMduxGGIWWZOd3vFNQIBH4Y0jAWkcez
	JRRpQL6W0b1TPnRJQpN/oSngJfEWkVIqzFdzpP3+KOuHmBgSQZWOUIYEVolLTw521F/PaaZuBnE
	ewP7dRl1lY4lVBHt8HIvYkjUIW1BKqcIAJxUz6ky646D3sV225v/Ktw4MZTjHZsMi8Z2euHGVzb
	5q9wnDRCxAm26O3yPpj2rgCRUj450v0rx3Foc4csgXZhYrnc/rvC1QVsLZ3UeHWwxYn+I+1pe9n
	pDJI8c5UhxmQuwpoB+neCudLzOlcKGMHI9G4qODvZtl0q+0BRmr+ly0o+u2Ac=
X-Google-Smtp-Source: AGHT+IF8bUzkbUV9Euu5dUPz2IfJx3RX4flb7A+E54D2T+3cvJpWfUKVV38Gn80780VBBG0RIw0oaw==
X-Received: by 2002:a05:6122:82a7:b0:54a:a2a3:b16b with SMTP id 71dfb90a1353d-5633ef0e427mr1405525e0c.3.1767782501460;
        Wed, 07 Jan 2026 02:41:41 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm2513528e0c.4.2026.01.07.02.41.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:41:40 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbde7f4341so479772137.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 02:41:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4W+y+6cVXkkPJCuqiPZPSydS1VuN6hKXL+F6QaKgtGGxVdrPztLf2ienUultmm4E9KSYuEjKWflQSBrURdHY=@vger.kernel.org
X-Received: by 2002:a05:6102:8005:b0:5db:f897:59f0 with SMTP id
 ada2fe7eead31-5ec75707799mr2055989137.11.1767782500553; Wed, 07 Jan 2026
 02:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107051903.35039-1-note351@hotmail.com>
In-Reply-To: <20260107051903.35039-1-note351@hotmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 11:41:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXE9MXq5S-3mqT-qtss5+azLswFo60VNWkgnvSxKPN1jg@mail.gmail.com>
X-Gm-Features: AQt7F2pMaD1jDd8BRMko41oPC03QZHC_adgAwyMwtUpWl0UGCj_r7vs5tDcFGvE
Message-ID: <CAMuHMdXE9MXq5S-3mqT-qtss5+azLswFo60VNWkgnvSxKPN1jg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/glob: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	davidgow@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kirchou@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Kir,

On Wed, 7 Jan 2026 at 06:19, Kir Chou <note351@hotmail.com> wrote:
> This patch converts the existing glob selftest (lib/globtest.c) to use
> the KUnit framework (lib/tests/glob_kunit.c).
>
> The new test:
>
> - Migrates all 64 test cases from the original test to the KUnit suite.
> - Removes the custom 'verbose' module parameter as KUnit handles logging.
> - Updates Kconfig.debug and Makefile to support the new KUnit test.
> - Updates Kconfig and Makefile to remove the original selftest.
> - Updates GLOB_SELFTEST to GLOB_KUNIT_TEST for arch/m68k/configs.
>
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
>
> ```
> CONFIG_KUNIT=y
> CONFIG_GLOB_KUNIT_TEST=y
> ```
>
> Signed-off-by: Kir Chou <note351@hotmail.com>
> ---
> v2:
>  - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
>    by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
> v3:
>  - Move lib/glob_kunit.c to lib/tests/glob_kunit.c.
>  - Update Makefile accordingly.
> ---
>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -

My
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]
on v2 is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

