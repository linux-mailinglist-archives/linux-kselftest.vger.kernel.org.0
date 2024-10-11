Return-Path: <linux-kselftest+bounces-19528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418F999F81
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B12285EEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1320C46B;
	Fri, 11 Oct 2024 08:59:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657120A5E2;
	Fri, 11 Oct 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637173; cv=none; b=exKebqeEdnYFLIeV6QlFTpfIJSZ4W1w0hAXMGNF/TUE33TYyV/M+t/I9VVHAHmzaZhcZHjiT+N3kmHr3VosJTsehb11mDCerYqm65+ysOT12RFZG7SkKyrNLmkSpFBYEdBk+ANL8WiWH3rNKbXk6ETv99c+fIC79sa+XsBueAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637173; c=relaxed/simple;
	bh=nc6A17rnILQmIKKtpPcrAfjXVsbFKsUmfKWuYF0xYVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN0+vlW84s5pH3g5qVFxL3GrU6mX95VFY+4weKa4rvXbCgtkuf0B7sHHiG3Q7o3IkPCmBgCBRT3lpNtsWtXKhUJqMmzID1OgtsH1GKO12C4beoXI4FiK/LALxJmZ5tz8DtsYoOQnebAGKVpSg3oSMQZGf9yIxrpwyd+srChEMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso1549405276.0;
        Fri, 11 Oct 2024 01:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637170; x=1729241970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykzu39AKcXejuBpU5m8IW6q6EkpIRw0KjmH9pDXGNvg=;
        b=wJvLUQACSZCvvTrtQPVo+HjVjnskobDQGx3ex3xhndaV8r/Bko/nEzqtsypM08h07I
         c50injTVjV2j0C9t2Kh94rw+R3zA5/9m9r16abQDeQ6aeWP61nPaagcmgbHeIqx83+QU
         F8wcm/xE3CjWwxqpO/CrxtFMNF+z4V85JBzZkazWlWzKr5b0bOlpOLoq9/1L6KYbj9h/
         Z8R6+F9jI5V6BJsNN9y2SzXIs3i2oDbEBMgLrjIXdwYiE5SleHZNLwKvHos728ddRChZ
         MzKUqPznb6rzNRuhcZe0jsYZPt+TnDWfkjO+nGYOr2yljKNHlWAUseRABjRHx47ZjpNe
         WqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw+omKt28TArN6VTpBZuwYA/WPDpNs4EGRLXIAN3V8Lq6RR6z9YCs8RnPwhPVKNLtUDYVmyFBBjj4f9XRHXNeR@vger.kernel.org, AJvYcCWhJkl2V6ZAyQxajM9TRXS2//WQwnj/GpiskdwmXpd1KAarUJA0eknHXhb+IXs0KtJVufZQjiAxzjXNhlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+XQlq2WmyN7sc5X6rLieVCUbqb83CjLGywG2C3dSoP8qTPk7
	kt7AbUbPB6Vh2O/DKzFZPfiDHUk4bQTlFp05wiB32hNPyF0GOxUMdCRCO7v6uls=
X-Google-Smtp-Source: AGHT+IGMH2q+47yN8Dkhst+SljTukcdc9/T1V3uWHCt9F1/qVebmk2raQBWcGFq9HcyIUlFmhmVJ8Q==
X-Received: by 2002:a05:6902:13cf:b0:e29:1de:e1f4 with SMTP id 3f1490d57ef6-e2919dfb1d3mr1177124276.35.1728637169705;
        Fri, 11 Oct 2024 01:59:29 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c27d10sm5125147b3.99.2024.10.11.01.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:59:28 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e20a8141c7so16861957b3.0;
        Fri, 11 Oct 2024 01:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6mggg5M3tFw4jtWN7Xmbaq6AvKVUCEC+oADX5z66iKy+7g8uAAm7sIVQVFQs7Hm9PzgUVGuAMOXvxAd1tlBUf@vger.kernel.org, AJvYcCV7+fEe2g34FaT24n5l58skkGZE8XRdvnY5f9MJM3yCTZSnk67zF6UHEbM/rrZpMdgHCFUOoQgweFdgDjQ=@vger.kernel.org
X-Received: by 2002:a05:690c:397:b0:6e2:e22:12d9 with SMTP id
 00721157ae682-6e347b520d5mr11901267b3.35.1728637168527; Fri, 11 Oct 2024
 01:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com> <20241011072509.3068328-3-davidgow@google.com>
In-Reply-To: <20241011072509.3068328-3-davidgow@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2024 10:59:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
Message-ID: <CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib: math: Move kunit tests into tests/ subdir
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
	quic_jjohnson@quicinc.com, macro@orcam.me.uk, tpiepho@gmail.com, 
	ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Oct 11, 2024 at 9:31=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
> From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>
> This patch is a follow-up task from a discussion stemming from point 3
> in a recent patch introducing the int_pow kunit test [1] and
> documentation regarding kunit test style and nomenclature [2].
>
> Colocate all kunit test suites in lib/math/tests/ and
> follow recommended naming convention for files <suite>_kunit.c
> and kconfig entries CONFIG_<name>_KUNIT_TEST.
>
> Link: https://lore.kernel.org/all/CABVgOS=3D-vh5TqHFCq_jo=3Dffq8v_nGgr6Js=
PnOZag3e6+19ysxQ@mail.gmail.com/ [1]
> Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]
>
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> Acked-by: Nicolas Pitre <npitre@baylibre.com>
> [Rebased on top of mm-nonmm-unstable.]
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for your patch!

> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -619,7 +619,7 @@ CONFIG_KUNIT=3Dm
>  CONFIG_KUNIT_ALL_TESTS=3Dm
>  CONFIG_TEST_DHRY=3Dm
>  CONFIG_TEST_MIN_HEAP=3Dm
> -CONFIG_TEST_DIV64=3Dm
> +CONFIG_DIV64_KUNIT_TEST=3Dm
>  CONFIG_REED_SOLOMON_TEST=3Dm
>  CONFIG_ATOMIC64_SELFTEST=3Dm
>  CONFIG_ASYNC_RAID6_TEST=3Dm

[...]

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2296,7 +2296,7 @@ config TEST_SORT
>
>           If unsure, say N.
>
> -config TEST_DIV64
> +config DIV64_KUNIT_TEST
>         tristate "64bit/32bit division and modulo test"
>         depends on DEBUG_KERNEL || m
>         help
> @@ -2306,7 +2306,7 @@ config TEST_DIV64
>
>           If unsure, say N.
>
> -config TEST_MULDIV64
> +config MULDIV64_KUNIT_TEST
>         tristate "mul_u64_u64_div_u64() test"
>         depends on DEBUG_KERNEL || m
>         help

This conflicts with "[PATCH] m68k: defconfig: Update defconfigs for
v6.12-rc1"[1].  Of course the proper way forward would be to add
"default KUNIT_ALL_TESTS" to all tests that still lack it, so I can
just never queue that patch ;-)

> @@ -2993,7 +2993,7 @@ config TEST_OBJPOOL
>
>           If unsure, say N.
>
> -config INT_POW_TEST
> +config INT_POW_KUNIT_TEST
>         tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TE=
STS
>         depends on KUNIT
>         default KUNIT_ALL_TESTS

[1] https://lore.kernel.org/all/4092672cb64b86ec3f300b4cf0ea0c2db2b52e2e.17=
27699197.git.geert@linux-m68k.org/

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

