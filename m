Return-Path: <linux-kselftest+bounces-25532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED0A2543F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4189F18857D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745271FBEA5;
	Mon,  3 Feb 2025 08:17:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7F1FBC9F;
	Mon,  3 Feb 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570664; cv=none; b=btRSRmmekQOLK/l/g7YN0wYwAry6mzKf4rsFsNcM9T9No5ajUwsyhZT1liNBwbZrT5WIaPAo3q9ZQWdGWbKDA8c7hPH8SP6NBk2EflvEGhF7hcguI8LNHhueJf5VJZnV4EHatmAB54txqLExd6+vc+jQMAREgnfr4R21RRbKnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570664; c=relaxed/simple;
	bh=8PXoE15wQ70wbPo2ZLqLkRjwLKtsDbG0KitAXePP6Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o34m2NhOHPLqQQXgHqITVOKxmPD2RjZG6sSqB3aKxnA+LIfqSNvaBGk2y36kpZ3Ck33H8B51r4JshoDOJFAI68DaPvuB5NeNMmnMySvBjmU8MCzs0sCCZOKoKMujW5zIpnEJv3u5KFRPX2maxsv1gywSX1gZFIsbtPuhxoHHk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85c5d4f3d58so732209241.3;
        Mon, 03 Feb 2025 00:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570659; x=1739175459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIvXo9RAM14dSFKA9Ie0SEL3egKUYJe1PQ0JpRzi4HI=;
        b=QN7qvr61xJ0jZ52abrbIZsLkGab1NwtJQazlCpHZdWCAyF7h8aq8S3SoCNRJ7fHH8y
         8v3d3p1uYc7tfbWRcfHlZOcKUF9WfACdLvyaG8dmWu4J206BYvWlnbb3QVsP8zNudbi1
         IBd6okdOrz3l4R5B5mSVQgemE4jsfdtLkn1Ni04XcQPvuyOqWOZPPuECluZ/XU5iq4+P
         hTne+0CYih2E5qmcPFqld5rxQLiia6NcJ4h8+CjqSpGlABUWQbnfa8+WIlMp2eL3DjFu
         Gvu9oOOWYOiOdWTO6wHRTDVOPUyu8q5z6ED0xEJwRj19NX0XpbLcQmUX+eio3dfJ8Opu
         RTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUORxxg1WUppRETYpoxM38TDI3S3aPdzQ2kIvmgmHsgf24sJ1fdrjmARNME5slbCAEiIHbyqbnVXybL1Pip8Q0+@vger.kernel.org, AJvYcCWkv9GH0/YVviOysIFzLaCzeeoA8rq4cNXyUX53RdSlLLaQRbPmhtqflhQflndAOitEjU4qvaGsrvMPqGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywax3GaMZOgixS/QPGAXLMStY/Yjxq5k7As8uMBbAHAP9NELPOt
	wJenurtzIfBWLSasm2TcvWozzAmr59zynZ8lYmPF+6z8SOpHWnSgYMkCAgjK
X-Gm-Gg: ASbGncufKFuMfueM5w5nrAE+vYtduBwRAqSraJL+LkGF8Uw0jZsZrJ6p8gmnhgfP94F
	m7fl4YcBTGdc3ZKB3tiL9N6VX7c++aEu5k6QSIlwiELBNdKzGsftbqwPHUIveX452wMQQZuOaQl
	i0JGcBb+/O5PkCFwCqZRXm64oH/Xt2CIJ6r6fK9bM3tJmOBwZi+9q3QZOV4hpPphfVsswd2qjdd
	L2yaEaOxEi8nAqA5kOY+TfZiPy3NB8yjm0t7Xmfst2zVasZCBP3UhXhjk0ZJ8VswNwrxWh5iDHW
	bvFImYskyCShUbcHmh4FoToZn0yAm/nmvI5xmN42a6AxjOjTgLK3XQ==
X-Google-Smtp-Source: AGHT+IFy5L4tV+Q6aiRXIqFdPlBFZ7bV6UTPixBuxGs2sjVx3yj2sI06roNavA9g6ceYzgldQhBjfw==
X-Received: by 2002:a05:6102:510f:b0:4af:d487:45f3 with SMTP id ada2fe7eead31-4b9a526cac2mr15277033137.23.1738570659122;
        Mon, 03 Feb 2025 00:17:39 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941f309dsm1592235241.32.2025.02.03.00.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:17:38 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4aff31b77e8so1612170137.1;
        Mon, 03 Feb 2025 00:17:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZ4mvLumRViwqWqTcI91mMaz9Pk7K02/qtcYjADeziEsyFjZKG7Cy2Bjcq/BL7ZRmGL4SeP/vT2LL+mRBpxGjm@vger.kernel.org, AJvYcCXrpM5ANJMcdyZLO+6tO2/dRFMj8KokTmLUC3+aOoG/t8jz+qqKa1YV9cKNso39n33qUfem1Bl2ZVzhcEk=@vger.kernel.org
X-Received: by 2002:a05:6102:b0a:b0:4af:4902:153e with SMTP id
 ada2fe7eead31-4b9a4f50f7dmr14529837137.9.1738570658420; Mon, 03 Feb 2025
 00:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
In-Reply-To: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Feb 2025 09:17:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvU6t2n_Cg4jsvRCLRpc10baeS4d-r83RGhYY5H-dypg@mail.gmail.com>
X-Gm-Features: AWEUYZlyniTPHJYCinC1O_uOLuUwbBOovxdNN8IVz7nd1y817ol7_8Kk0p_HMkY
Message-ID: <CAMuHMdVvU6t2n_Cg4jsvRCLRpc10baeS4d-r83RGhYY5H-dypg@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 16:48, Tamir Duberstein <tamird@gmail.com> wrote:
> Convert the scanf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> rename the file in accordance with usual kunit conventions nor does it
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
>
> I tested this using:
>
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf

Sounds way too complicated: "modprobe test_scanf" ;-)

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

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

