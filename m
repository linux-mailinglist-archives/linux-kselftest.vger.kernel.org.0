Return-Path: <linux-kselftest+bounces-26152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD482A2E5AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E61718840AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D01AF0AF;
	Mon, 10 Feb 2025 07:43:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A01B81C1;
	Mon, 10 Feb 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173395; cv=none; b=B546dhucj3Cut6jOhjhBPvhaXa9kENHo4rWFLWe4iXkwwPvpZGx5d9/15K8md2eK9p0lYfAhalo8B2umioWwjmFb9SlOgiFEuojfssQMhNVsBrlpSEY4wxHBkScNYTeiuqlNQIEjLXfkcKSeEVySmgHNBjJbE3ITePBcrcsGSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173395; c=relaxed/simple;
	bh=CwIlx4OEEN9ZRtZ1QafElHuN1i+vBGr8+n1N88C+kBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD39baQMwUz3cA3reneij1TsHEOUAi/7VESVbdB8x+E36hFkeHUX7eogK/IfQWlN/q9O2r5UCxYWZhG6HXNwai++5COx/ANrtZI9131OjMSFn95eNq3NJ8WDWpzdCP1QE9hHm92zBQFJB7j59P3IX2P8eLgoBBHqXSYi2Vx1Lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4ba7ab22192so1147639137.3;
        Sun, 09 Feb 2025 23:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173390; x=1739778190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1HAXrO7siUncPkj5ofDqgDnxHSc+KQ8zsK7WabjOVA=;
        b=YHv39RZC16u+THXZIQfxOXZ+RSLWhlhhq6vggKqrZ9XlCZlEFTW5KMq6eQBZn+4U0o
         wpoRVldWP572kwgEiQ7mG1VgicjLh78WjVwyhkE65w7SMmfFgvOJA1Qxdu/cRiYdnNuf
         uAKRoRMU34myyUJ1q62iPFZWMhXi1loEzoM7fJjrsfriFS9BMQwp8x22ezL0cekhZYJD
         6/JhBzBpBCzTZ2Chf9gdzOjrnMMf5aZ7xdh3e4P6HnU/OUvQzkEZ1PW0GYfExSv9HDNh
         5GJ/dicXXSpZMQehKIdvhA5rj3n/xMvhipUmiRzMMRtTvruy+1sWuHe/YOQvT4rxVcvg
         ZWOg==
X-Forwarded-Encrypted: i=1; AJvYcCVX7FCG8MRw4r3kRMc4M6S7dxJ8PTu3m41aIAzCduKWjFwHnTANY1+7mDmVS5QdjU1sw2DduU/kqQP8J1BjDfEY@vger.kernel.org, AJvYcCWyJo8sOGgNoNAYRn4Z57rNuBVrk/lf3H+XYTxyeOEPglaOwOmcJV7KtbkuyYekm1ihHnAD4m+JxBquRcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cGozk3/wSgj9BpRNbbJOVuaBmwZLniIR6sSfEuVJFjCrSOq3
	jY0r0kXgcthd/oIhnrL7cWSCk7RB4B0QcSTHwxpRLUsuJnp3CYlHXl9Pw3v1
X-Gm-Gg: ASbGncvumH1rn5Mfmx5S60meMNgDI9NDViE2ZOrag1h28YgeIrWpJQoVZkHZixSkss/
	qjKF2PoYVH0acVlWanpNXHN4yvyBaQDJCtSXLUxjyYFxSUML0BComkLkswlEY1zw6gY6N4Eb30N
	ZZwaBS5HqWeDuCdczAoEoEaXJ0WgTvO51Ea6/1LiaE5D4Mbvnwi3aaGx31VyhDJZR6N6bxITSMv
	VfoXb5/3Qc6zy+Cuus8csRFCeYsENtnTQt7Y7C11x7PwldrYhHWXBu5/7f+FoPiVzITXGsLDJ7M
	kiXQu/4RZwijMx6ECprz4ec8A68hqiaHL0nNqkmT0Up/+cxipd/HDQ==
X-Google-Smtp-Source: AGHT+IGBa9RI5GShp+kMzyR/WJfamOAjBJGz5C4qSuytDyCEJhfu8DcJafeaiv9S3G/Z1VA/5dktwA==
X-Received: by 2002:a05:6102:f0f:b0:4b6:5e0f:6ddc with SMTP id ada2fe7eead31-4ba85e8a3c6mr7306942137.14.1739173389922;
        Sun, 09 Feb 2025 23:43:09 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bb0642e670sm848025137.10.2025.02.09.23.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 23:43:09 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4bbc406499fso217211137.1;
        Sun, 09 Feb 2025 23:43:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdFbFTkPudO5WBcZaPJLgjjQCiYFFkTRbnwIuOt7i6pywTWEjXaIyU0pSSrN+9Yf2RBPAz01qQ7/Rf9CS0jTLJ@vger.kernel.org, AJvYcCXwR8KfY3rxpEqQIIq2gFc4wX/CDaPsMW6FGRuEDTfDnXzMFfaZQDc7P5F5WCCqZL6zHrV66uk1A93EXZg=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:4bb:c24b:b623 with SMTP id
 ada2fe7eead31-4bbc24bc2e1mr2033659137.19.1739173388892; Sun, 09 Feb 2025
 23:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com> <20250207-bitmap-kunit-convert-v1-2-c520675343b6@gmail.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-2-c520675343b6@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 08:42:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ5vbhWsJgsGUny=9b4p0cvML+GkLJ=BmWnG9Q6FE78A@mail.gmail.com>
X-Gm-Features: AWEUYZkkTrEuq6WMVMpODBTYSjpUaxRBgiMamGpu9Ed_-WnWv5jDfkFeFpfmlCY
Message-ID: <CAMuHMdXQ5vbhWsJgsGUny=9b4p0cvML+GkLJ=BmWnG9Q6FE78A@mail.gmail.com>
Subject: Re: [PATCH 2/3] bitmap: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 21:14, Tamir Duberstein <tamird@gmail.com> wrote:
> Convert the bitmap() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

>  arch/m68k/configs/amiga_defconfig     |   1 -
>  arch/m68k/configs/apollo_defconfig    |   1 -
>  arch/m68k/configs/atari_defconfig     |   1 -
>  arch/m68k/configs/bvme6000_defconfig  |   1 -
>  arch/m68k/configs/hp300_defconfig     |   1 -
>  arch/m68k/configs/mac_defconfig       |   1 -
>  arch/m68k/configs/multi_defconfig     |   1 -
>  arch/m68k/configs/mvme147_defconfig   |   1 -
>  arch/m68k/configs/mvme16x_defconfig   |   1 -
>  arch/m68k/configs/q40_defconfig       |   1 -
>  arch/m68k/configs/sun3_defconfig      |   1 -
>  arch/m68k/configs/sun3x_defconfig     |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

