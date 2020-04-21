Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD11B2B5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDUPjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUPjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 11:39:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC52C061A10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so1479391pje.5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mmoGh7NbU2I6i6mTnfpxZZ+azD3XtCswEGTNXCLuyA=;
        b=QGgo4tZ7skjSV+mL+s3apHVRj1cNzDRfziKAXEk/Ph5dhpMbSxC6LSaVrBDyOosNOK
         STKijhMpCZRlfYKcDyKnjKpDuEHgukjsG9QksyLsh5tsPHAPKnt4bap11a7mmVPNCeHk
         kuWjNX41klD3xtfSylSX8LTC+fZOmuDBCrXcPO4f4CdRE/jS7WJ/cp39nzoEn7PUccHx
         TrpoAUzxh06+NnuC5LnWIpvkQlA7I/fkXcnLdtOil2mnUCUohVyB1FYcc6g+yFf8C4Qe
         1yuzm/rPeZYK0RCv0VwfkhwwK0vPV6pAkaCnEBAAl71uN+PquwZPGfK3Bljp7QkApEUm
         4MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mmoGh7NbU2I6i6mTnfpxZZ+azD3XtCswEGTNXCLuyA=;
        b=Y7Lctjy2M+bKMfD0UXUzhRIF1w1HUFo252Z1SCkgK+sXjin7B9RtVJlTU8dS640imN
         ZYzDBz2tjy66SrFuRLpsd80ZPmTTVC3liUIw+bkKUZu0addo8++GA7IjanZVLfscxZtT
         +qBZWxz6p3rlV8Jtz06LZCPFpnOI7vFWndeDeZiusZiyKfa7qqgmtPaLgoD/qV2nrF9g
         REDONgUFw0m2dCoKNCobKBpwCAc0mpETqLIH4JOqGxAq7rBuEB/Wq7xsf2c0HFHlpQet
         t+B7ejHwacarWMECHy8K5Et9uB+67KU3KPZWrjxh0xu/3lCFYjdiHlGRp0cEkdqw0Gka
         8tnw==
X-Gm-Message-State: AGi0Puby1HDhPtf3vyZJToAVTK6vP94tdeddvHuEosz06LPQIWuzzfBr
        SqbHYXBhGwrUladdvZlqZIoa+33nbyPZijoNpj/inA==
X-Google-Smtp-Source: APiQypJzBHkISyaNz7vwdfY/AkaRhLOXFBDWiH/NMWMtB4A2nC8aZl7bqmoYjFzGBpD6t1rKnGOME089iTi7pJ+kTj0=
X-Received: by 2002:a17:90a:8c93:: with SMTP id b19mr6142175pjo.90.1587483579220;
 Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com> <20200418031833.234942-6-davidgow@google.com>
In-Reply-To: <20200418031833.234942-6-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 21 Apr 2020 17:39:28 +0200
Message-ID: <CAAeHK+xBnxfmS7Q6oY94JRqzVtSzpUpWtsM3u+1S5kixJfZ+yw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 5:19 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> KASAN errors will currently trigger a panic when panic_on_warn is set.
> This renders kasan_multishot useless, as further KASAN errors won't be
> reported if the kernel has already paniced. By making kasan_multishot
> disable this behaviour for KASAN errors, we can still have the benefits
> of panic_on_warn for non-KASAN warnings, yet be able to use
> kasan_multishot.
>
> This is particularly important when running KASAN tests, which need to
> trigger multiple KASAN errors: previously these would panic the system
> if panic_on_warn was set, now they can run (and will panic the system
> should non-KASAN warnings show up).
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0c206bbf9cb3..79fe23bd4f60 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -94,7 +94,7 @@ static void end_report(unsigned long *flags)
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irqrestore(&report_lock, *flags);
> -       if (panic_on_warn) {
> +       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
>                 /*
>                  * This thread may hit another WARN() in the panic path.
>                  * Resetting this prevents additional WARN() from panicking the
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200418031833.234942-6-davidgow%40google.com.
