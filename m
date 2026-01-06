Return-Path: <linux-kselftest+bounces-48284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820BECF8259
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2204307C4D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740932D42B;
	Tue,  6 Jan 2026 11:35:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDD327783
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699330; cv=none; b=pKz64oncpH6g8TNYftMeRVIMT26skAD8LpkBS/s3SOs9U/mz2CQ7KcrdTkegEmSQ6MvEQX5A7PtjxFDnqiSbwr4CsV94SCl15IR3anQwc58177vWfn4geca52NZNDuni0snbUrjIc0Vat632wi0FcY145mb8yx77reZLL7xZiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699330; c=relaxed/simple;
	bh=OMPnyCXHysXo8Y/2+HLO5SMh6hXlmDsZ+eTt28gD0Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9qCqIAFnEL5NEmfIXMlYJlrXFwKpM9GzOKCrhqctsShJdugWzw/1/1gq60x55REhslDSylrq9V9FlLdQBHasTWm5xmNu7SojFhXrnkyJJGbNIsal3nnxccalMKfEeELkiWiyOmSdOSKOrB+m/4FQ8WZ0TrZ3eE5MBTIJa/NNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so528569137.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 03:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699327; x=1768304127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UA9NFYbYiw26kYHfSbibg1KOzARBaUq2gzgFJeOxbE=;
        b=X/Tjd1YppZsQbLNoxqTJh1WjiT/z5/m7ep9pYmVogTwcKtetQS8C4d4tr1N4KnLsJq
         gvFSRwQycubOOlYoFsaKFtCU1K8XCaHK8AoukCOgz3rNsP1ilR97bCT+oL8T0ddqo635
         NqFkO2N4seldu03cY0BV5XngxB95OtyKDojE4rGyUalMabWds6d/CJlnIk2+fwuaDi/d
         hAHV/SlPiH5GgRcOzbPhF5nA+aARKu6njkhKZv7x2fQGW1kJ5r8pdZpXlgDFGHHovZFk
         M9ckZKobTIhGzWsoMG2ff86zWcpoKtgOPYDytCAU3kHKcT3uRKp40fMe0WTj7eF3HyBT
         PacA==
X-Forwarded-Encrypted: i=1; AJvYcCWEQZVwkNnUN2wTTPzYPTH4D6wjKST9M/sI5j/YtQnwulfZIXuOXgxci6OxGVA5YG6jPPhP7bUM5bx9iSzmuaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytksP5PBdIWNWwmihoF/d+E/JnXQtnT3vDO4IcncT6JkkWdSBh
	lJKYBRDBWAW+7RVflQ2e0sRCgyYh31VF9oRZiU6FuSNGv314N6UN73d7jHQkffth
X-Gm-Gg: AY/fxX6weOJUlLb2R/wYrE56hYimAkKne+m669SY6fIuvTPtpTz2g0v9DKLUEOak877
	R8zt2WA2a2HgeYR4voSlQgVJW8tw1iA7Rpj1zjJX6vYkcn8lUj8FSXo0QUIYF10paC7LW1K5B0S
	6riSJqReaxPr9AHXcMwt6DGsgjQGvi7O8GfA6iXj7/5AOUQEpklVtQNqGFUv8KYPIo2kWHoJRuK
	we3MdkdZRXUd+d+TtErM9hWBBr50t43nKZFUIOlBZP3t9UrUgseUh6gYTmjqWpeBhxTvLYBqoy+
	TMg3M5wqpKGbZT6ov8+8yCioRgHIc18jyHy9gl3TbTcf0BqyqXF8dL4WAfJDMgQBVnbolBJcE0Z
	j7e9AyCP8KR/czm8qziay3rbFYQZQGcZoSQrWE0fzeE7lrbwuIzgdeItYyZZVlh/vLvnjZ+d2tz
	wczNk/oxKh+p6u9m+3N0HwLBh+2qLXVyKbaVESpYY1w7EBdDAp
X-Google-Smtp-Source: AGHT+IF7KdG9ZohhpzP0Z+rV5FTm/jkcJ9/u/RAk8Yds8cRp3kB4n81y3OkS6k2Kf3LdpAE+9OVj1Q==
X-Received: by 2002:a05:6102:3f90:b0:5df:c4ec:661e with SMTP id ada2fe7eead31-5ec745a6bc0mr805911137.43.1767699327313;
        Tue, 06 Jan 2026 03:35:27 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec77004098sm534249137.1.2026.01.06.03.35.26
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 03:35:27 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5eb3c50c688so525864137.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 03:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9oSIarKl1VpiozBdS/VOX7oWSE6SG1Wim6ahCyONOAml+tl55O6Fna1NAC7cWvhX2BV/ix/PzmFqZ6odTXNw=@vger.kernel.org
X-Received: by 2002:a67:e710:0:b0:5df:af0f:30a0 with SMTP id
 ada2fe7eead31-5ec744e51b8mr793236137.29.1767699326350; Tue, 06 Jan 2026
 03:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105034836.59442-1-note351@hotmail.com>
In-Reply-To: <20260105034836.59442-1-note351@hotmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 12:35:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnAtySPPgLGKEv7k9TGR9XuRc6hFzQgdyv-xUSA+oYZQ@mail.gmail.com>
X-Gm-Features: AQt7F2pLDcPwsWH0X3JQ5EWEDYYjLieXDMTXPaYEirHsBQfGkp4hLpER75jAH34
Message-ID: <CAMuHMdXnAtySPPgLGKEv7k9TGR9XuRc6hFzQgdyv-xUSA+oYZQ@mail.gmail.com>
Subject: Re: [PATCH] lib/glob: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	davidgow@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kirchou@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Kir,

On Mon, 5 Jan 2026 at 04:53, Kir Chou <note351@hotmail.com> wrote:
> This patch converts the existing glob selftest (lib/globtest.c) to use
> the KUnit framework (lib/glob_kunit.c).
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

Thanks for your patch!

> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -600,7 +600,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_CRC_BENCHMARK=y
>  CONFIG_XZ_DEC_TEST=m
> -CONFIG_GLOB_SELFTEST=m
> +CONFIG_GLOB_KUNIT_TEST=m

This is not the correct location for CONFIG_GLOB_KUNIT_TEST.
Please run "make savedefconfig" and inspect the resulting defconfig
file.

However, given GLOB_KUNIT_TEST defaults to KUNIT_ALL_TESTS, which
is set to "m" in the m68k defconfigs, there is no need to add
"CONFIG_GLOB_KUNIT_TEST=m" at all.

>  # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TEST_LOCKUP=m

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

