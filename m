Return-Path: <linux-kselftest+bounces-48303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F4CF8E5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EA173012EB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBC335541;
	Tue,  6 Jan 2026 14:54:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44943346AF
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711270; cv=none; b=M560LwuaDZwP18yI/ZjcYI7WUsIMarQYqC7YxLRr7IAVnPXc8ZzZsGgMcZwiUSExijkyHsE89tmypNbUyTXuTdnVe6MEFWtS4I6/otNjYPm3UgoAO7xeX2tADoAu5VxrgMqKJt3qmiwRHQjAyq5tYDfZVvQIYFM+lSsOJnnGS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711270; c=relaxed/simple;
	bh=sYRieGQto2KwSzwN81wE9A2McStIgbAIirRtXy5Ob2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8A7UVj0NCDx8gOI9hqhznd3zCSspuOua33r3lNGjj5ONRnGtSBZk01fWMTfBbKQRsKCmg38XIipfrAcFfI/qF1sf760VrJxI2vMJuSWqJrA75o30btbXXFUOFf+x4J2CfRutTYJkqHS0cFPU0BK50Xw6vElb5zLeFIOGgaG3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dfae681ff8so638042137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 06:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711267; x=1768316067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giANTfOeo2lVpD/gNzwTvuXqWYxEAV5F7Z9I913/RqY=;
        b=Ej9otWOROG6jRyerPV0qI8XFcTPJdse15bDuuDJ6DrqJRze/BPU0Kn70i+TNEuJcMS
         6KUSfv4RL9I+VckJMTs13FIJgAOPvvb0ISHvBiL/oql20fdLODDJQoqgJLF//oxpGoKY
         yl/nNaQ4INYtQtt0BILHgvj/4zek5kxNvyPuk9uLMZQiEyhg9c11QpyEFipjF05ORprh
         c26cQO92PHksGvbd5bNRMyJdVDxyMB+LAbjdUgIsZcHzl8uhQnlf3xkiU4FVgHSWvtF2
         RkIZqinAQtmeK+qleFn9paYqpBH2/S5Grc3Ghr3OA2e6NdelGeDXnhaCmDjGxxcGHqDl
         yZTw==
X-Forwarded-Encrypted: i=1; AJvYcCVU8nXn+43C5BJJXRULiV6mRyVJqgw1N6FvtiFQdfRroGUI1Bws8n6c/ip9BCOiQk+sHNma6fw0oEYVF6OOhJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIq9mxAB3v0rfvDYKfNjGVERBkXptarCUR+CSoUPI3PcbXgk0
	eNvggR+xSjP2dJ78ApHWrudIe4EWu7jm0qky/FGZ0p6f8aLeYWTB0NZJoPylWHnL
X-Gm-Gg: AY/fxX7MkOjd48R9DHos1yPtsTigPeG+kHTOAhzYFPH11Q4JczBYcAgc+4MNYBMqGoG
	9baLHL8E3dOaVrERNOqUR7IL90xvhN68Ur1N7lGEEiuci0RTmDE3gyO++/7s8x5hVCQetikR+NV
	8cv7xF36P5NcyM+or46UwaifKpPcs930WQYxcQVfKPmRaE5QfwNjgglB3t21XygTi8Rwcs+88Dg
	KMSyrTkXhB8QewBgNjkqcmWIWSdCPKypVHCYo4Fm5ByaK+o4YtjnSSCZ043naB8EvxBtY/ENov2
	C2NhIifPlQwpZVJvQj+EDlQ6wbM1yFIG6gvO7nAZ0aK9xs/ypQuICMgsqsNyAVPgQ1pcInGjGd1
	U7vcgcFHoVuMSrwbOxgg/GMuIGc7C1jXDsAY/9ioxTgrTk7xOp9gaPhGYNzFhjkztdMpKOZVWVm
	JE75TT6Cv1P5x3yQyY3W+8UNKy3FaJJsDYZ6Z8yUozYLg5zpB8
X-Google-Smtp-Source: AGHT+IF6P+pZQMCoLxK0uPwGooPf5rVeAjlkUea6g/isQRMcsNBaOrmqIij5oyfL3PXEcEiL5qlztw==
X-Received: by 2002:a05:6102:c52:b0:5dd:c568:d30d with SMTP id ada2fe7eead31-5ec744efdfemr1069055137.30.1767711266565;
        Tue, 06 Jan 2026 06:54:26 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772e0ce8sm650153137.12.2026.01.06.06.54.26
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 06:54:26 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-941063da73eso648984241.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 06:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbeDfIYhPsDkdduuALQiR4By7pD7m7wNH+AUlHAirS0GGgVX1EYhRAs9Ki8s8iEKYAiXOg2UyLmIHn0VA3gFo=@vger.kernel.org
X-Received: by 2002:a05:6102:3591:b0:5db:ebb4:fded with SMTP id
 ada2fe7eead31-5ec744aa62emr1034929137.25.1767711265069; Tue, 06 Jan 2026
 06:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106141057.91203-1-note351@hotmail.com>
In-Reply-To: <20260106141057.91203-1-note351@hotmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 15:54:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUDY0X1HWqNfLkihx4WcoxE8nwvYOt+E37YLNmmsW8B9A@mail.gmail.com>
X-Gm-Features: AQt7F2re0fku5BmOhZUSkoRzcKAe0YdMSOn0y686idIMdV0IZPXwkIoUXr-BBlo
Message-ID: <CAMuHMdUDY0X1HWqNfLkihx4WcoxE8nwvYOt+E37YLNmmsW8B9A@mail.gmail.com>
Subject: Re: [PATCH v2] lib/glob: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	davidgow@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kirchou@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 15:11, Kir Chou <note351@hotmail.com> wrote:
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
> ---
> v2:
>  - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
>    by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
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

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

