Return-Path: <linux-kselftest+bounces-29765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D355A70531
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E52168096
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026C1A3AB8;
	Tue, 25 Mar 2025 15:36:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84D8635E;
	Tue, 25 Mar 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917001; cv=none; b=DchVrM9l6tOft0aRexf7a/HkI77KiWFSannPhrbB/22mcRTSVWh0fKuiy9kIDqKtVZSXebcUpx6nJ8OM82x9fWHXlCxMya5Y8EWD9vBOUZhiGWs+mWmRh/k5RmQueOsHTq57+Cu7zdQ9xMIzFJdZnTQDmTz2csS8Kcn9HiOAs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917001; c=relaxed/simple;
	bh=lQGhDpTA02pg2SXSqztof85HVwIN4KdjwfWy9lQVkTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncUqwnBPKxQjvM+k378FPvDCnP8zBZheu6ZBrWaqI7Dh6gevnBmvbi2BLfuu4lDrSi6QsP5vEs9OJ/2UwgJ31LH8AseEM3PaAqoJw2phZaA3LeK9qD/IuIAsUJy3pfPabCamA7mrM8qat9TQfDEHPUk9p82xlKkNL+uDcdHNtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523edc385caso2301108e0c.3;
        Tue, 25 Mar 2025 08:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916998; x=1743521798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rg9s2GhxzbMU0JYpYKXzsavBxYRuo5kJ2cdSM+OjLA0=;
        b=WR3MtpB7tyQWT0DiK0WR8FgGqmeW3iU0+6xATHg83RkIAZyUO4QptRTJ9/u3GNAofO
         INhYYT/3P8TQUpn/vryXOrNgUTwrFQznjeH8y7gOkK1fJj20I96O93gVA3qfkaigYcUH
         c22DD8D3EZEvLqhkQKcUo2916nk7wzwqxTFwukpfj5Wxo6+7OERMGc39QE1sLbBWPNts
         qFg3cFahrGMpD8sUSvZo/ffWELsVKKx1TSiEvseV0FACsceRp2SQvBuL34S6Is6Usi5r
         IJBaIIM/SUJ3Dn5GLX3KdbsR7GePh9g5aLDaQqfkrSnwoP7DodV2nADpNy2PAfNb0qer
         QSlA==
X-Forwarded-Encrypted: i=1; AJvYcCUXD+SZMC2ZmAAwOj/IcAJIFg14GFTBSBOTuD5105ot4NTwkQ3kh8Q5D6ShLn7D2+6bORT98yVSxtRo1Bu/nG2WK20i@vger.kernel.org, AJvYcCUnTF42ZmJI9ZSwGD9wmDq3f8E+ijKxVmpiAdj6yRR2WOOdFnqWWmDD06RGbo0OKHzjklLyAv7brkI=@vger.kernel.org, AJvYcCV9zfqBc2VAX+Lj0T6UG24i3tGU0VjgNcAbwLiwS0Vt3QXyeIJmR2Www2aMFBaX5f5lf/Pfxcr0fXebx3rabX/C@vger.kernel.org, AJvYcCVfRewQc8VwD8OChtnlORSrYB6Ye1vR7UOS4cdyMlIpvF+FeA/PyjKPRCNvJn8jC1NtdkGC@vger.kernel.org, AJvYcCXEHvCp5akvBmBqf9JS1G5mHjLomgAMlJLlna5xTi12+o+NT7dd9oDQhDd99z+8NlAV1+a0IJeCkjZ7cMfz@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFa+U1mVUXj1z2aeFYzpCtUUKmO+qtwq3ZJYRCtah9o/t1EWa
	s6CExzQt8qPJRMnpq7ZDIRaCcZ4Afk1/3aQIdrF5hvRu0oGMUhM+ilbbocfj5nI=
X-Gm-Gg: ASbGncs+8q1uPeXl6tpKPvUAYj79sMCxIbVUeizfHlGQPIa88/R1qHnw4b5B1DaJV4y
	9g3QYyzbqaAhvEpDZAG7pel5nsBEKI70eccUyQnn3dO2A3wp9U2LzhM1hDtckwPew9u424TmofB
	m1yYA57w2icD6hg4iMOTllComn4q99LqlS2x6lobduXHzt4tXcHjon9qjkGRPydlpfpKJzj38WH
	N3uG4CByF0+loSJvojGO7dBOC6Ww27SgAFYbq3zo4uYkv6SvIB8hkpTeuWDqrDzoT+R8oknZIN2
	8s02hYioTfjzkAfpx2GofD7F6kb4EF/F/iYIyC5xFgxdhzKMjacBpoWuRkM2CyhJljS04Bjv9Ap
	eXVx9PYwPNl1f9sPs4A==
X-Google-Smtp-Source: AGHT+IFBNoQDtRZGqjnnu3M3m2DBMWZp4QMOg2nQtXviEZdBxZFbnw3mVIQmVQTtI+CJ7vju/lUJDw==
X-Received: by 2002:a05:6122:4312:b0:518:865e:d177 with SMTP id 71dfb90a1353d-525a8560bc1mr12001534e0c.9.1742916998084;
        Tue, 25 Mar 2025 08:36:38 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f3a3f6esm2078313241.11.2025.03.25.08.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:36:37 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d69774081so2483414241.0;
        Tue, 25 Mar 2025 08:36:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1bnQctZBes+NBe5tPxOM2lFpWn803hpO7YTvTfza93Kr7xOXn1+8uY7UUxnzStpYiySUeyWt4OspLhJdFJ1OefSbP@vger.kernel.org, AJvYcCWA/TdUOkW34smvSDRSjL4Ju+Py+VDFy27OeApRSoKH+5Oizqn0axTDHI5qcSZevAmIHmk/yBTX+zV+FYTx@vger.kernel.org, AJvYcCWC86aiWICremCZBZzzZcvQC0uWR7PKx4KyK/XZuEq1kyLNgDn7kuBCN2Mm8mut3Jb6lmLK@vger.kernel.org, AJvYcCXJkMQp4Qi+wAVcMGhlqkOEOatJAb7NXIhkWqpocdy7AibPojLNTV74CwVrheKuS623e+VTRn+wrbqMSHID3WIE@vger.kernel.org, AJvYcCXoIx7MVLNavdI6D1MF2Me53j7n/PUIhequvaOcXSILl99nj1Dfj2goOhVDO2OOBQ5Yux6rvsfDWs8=@vger.kernel.org
X-Received: by 2002:a05:6102:c92:b0:4c1:9439:f70 with SMTP id
 ada2fe7eead31-4c50d4b8f63mr12298813137.6.1742916997318; Tue, 25 Mar 2025
 08:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219153938.24966-1-boqun.feng@gmail.com> <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
 <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop> <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
 <b4ac95ce-7cfd-4d31-aa7d-54ef04f4ae24@paulmck-laptop>
In-Reply-To: <b4ac95ce-7cfd-4d31-aa7d-54ef04f4ae24@paulmck-laptop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 16:36:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsuKMLrg5qmS3oTAWfv3Ph34Hq5jeid974+RoTAR2Rkw@mail.gmail.com>
X-Gm-Features: AQ5f1JrYtc3XhYgX4YuVml3CpXoCyQpmzApZic48oP74LpqYdOUZOpuYsHWB5oU
Message-ID: <CAMuHMdXsuKMLrg5qmS3oTAWfv3Ph34Hq5jeid974+RoTAR2Rkw@mail.gmail.com>
Subject: Re: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Huth <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Valentin Schneider <vschneid@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Tue, 25 Mar 2025 at 16:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> commit 2245ef8605a80726548253d885b4cadd97f69f3b
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Mar 25 07:31:45 2025 -0700
>
>     srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
>
>     The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
>     the SRCU code paths that accommodate architectures that do not have
>     NMI-safe per-CPU operations, that is, those architectures that do not
>     select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
>     is a specialized Kconfig option that is not intended for casual users.
>
>     This commit therefore hides it behind the RCU_EXPERT Kconfig option.
>     Given that this new FORCE_NEED_SRCU_NMI_SAFE Kconfig option has no effect
>     unless the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option is also selected,
>     it also depends on this Kconfig option.
>
>     [ paulmck: Apply Geert Uytterhoeven feedback. ]
>
>     Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index b3f985d41717a..ceaf6594f634c 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -68,6 +68,8 @@ config TREE_SRCU
>  config FORCE_NEED_SRCU_NMI_SAFE
>         bool "Force selection of NEED_SRCU_NMI_SAFE"
>         depends on !TINY_SRCU
> +       depends on RCU_EXPERT
> +       depends on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>         select NEED_SRCU_NMI_SAFE
>         default n
>         help

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

