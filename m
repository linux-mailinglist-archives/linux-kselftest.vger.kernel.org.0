Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66F26AAF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIORno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgIORms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 13:42:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0CC06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 10:42:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so4030762lfr.4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nYcbfWZAApGs9MKHeuMMDYKDYJP/KjXcIMY7yTiRjk=;
        b=hFeX95/TT9jtwZAL/DonKpuMHGRk/7SCmZequDM1VaRmacKDQZY4lc39NgOcx0VujL
         ul3l8yb5Ugprhwk3dogs1JqCkfr90spWSTqKGkSLsF9w3lXrIygeRUDRxh1yw1QSoeb3
         vUCYW8AmUQyz6zbxknLrsvz9nPCTdNe9Dcd+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nYcbfWZAApGs9MKHeuMMDYKDYJP/KjXcIMY7yTiRjk=;
        b=eAzCXLCqlt2p0kRV13RQuOB0a2vj9hydrunoN1u4aqwahF/IkFKZ77oMwKexT3wQdR
         MeD4vdY84UIWsEeo2zZBp8IYXMyw96HKs7GGwR95M05D0QW3qwRD+FVdfYX3Vu6OMtug
         0WYv5D9hUlLEz59LO8eqhLQMA0vslgHxVoTz9mOkaaOtvHP2VsjZMWE0PFpwgSljG82p
         uaS4JEaeklWLhS0HwmsGG5k/RMOityMsXO4G5Gdxf83gz7OR1FpntJe3tUIS18UshkIo
         39mX/v/xxg68l0aYwCDPH4LWo/0BDw3ScJ7N1sr+ewJZfDyUS6F/EX1Zzgo6cusqV92/
         CqVw==
X-Gm-Message-State: AOAM533tkFljiswTZ0QqBgeq5BpBZhVeCUHjFvXTD349amehD8yWwm0Y
        opIid+dwQ+P0LzRx5Ad5hCah88JTHOBuvQ==
X-Google-Smtp-Source: ABdhPJxyBG9X2cHC5YL11s5uX2uViOmdkI8nXJNeaICykVuiIB338NQbXhnnGAfY4LOSzkM/jpzF3Q==
X-Received: by 2002:a19:cc43:: with SMTP id c64mr6857125lfg.123.1600191765811;
        Tue, 15 Sep 2020 10:42:45 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f19sm4518624lfs.85.2020.09.15.10.42.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:42:45 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r24so3604290ljm.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 10:42:45 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr6798322lfg.344.1600191336149;
 Tue, 15 Sep 2020 10:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87bli75t7v.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 10:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Message-ID: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> OTOH, having a working 'preemptible()' or maybe better named
> 'can_schedule()' check makes tons of sense to make decisions about
> allocation modes or other things.

No. I think that those kinds of decisions about actual behavior are
always simply fundamentally wrong.

Note that this is very different from having warnings about invalid
use. THAT is correct. It may not warn in all configurations, but that
doesn't matter: what matters is that it warns in common enough
configurations that developers will catch it.

So having a warning in "might_sleep()" that doesn't always trigger,
because you have a limited configuration that can't even detect the
situation, that's fine and dandy and intentional.

But having code like

       if (can_schedule())
           .. do something different ..

is fundamentally complete and utter garbage.

It's one thing if you test for "am I in hardware interrupt context".
Those tests aren't great either, but at least they make sense.

But a driver - or some library routine - making a difference based on
some nebulous "can I schedule" is fundamentally and basically WRONG.

If some code changes behavior, it needs to be explicit to the *caller*
of that code.

So this is why GFP_ATOMIC is fine, but "if (!can_schedule())
do_something_atomic()" is pure shite.

And I am not IN THE LEAST interested in trying to help people doing
pure shite. We need to fix them. Like the crypto code is getting
fixed.

                   Linus
