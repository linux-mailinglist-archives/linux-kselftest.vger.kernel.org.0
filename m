Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC723C199
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 23:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHDVia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHDVia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 17:38:30 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A914C06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 14:38:30 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z18so11258066otk.6
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltGWhVbBQmoMJQxXzeUdQQN1MfVzQ7ab4b8nH39r8L0=;
        b=B9eGnGTcjww04rHKTPDCcTONe4cq8snHL3pSdZOCwVy1vlvh9AVH8UPknxhUOl+J4b
         5PE0tmI9oWfn0+O+CDKoM6HFoD8EOHbHn7I1KH6zNLvoRvaFTnPG0JVJinKcLuXr7lay
         2JeaBaXqqwE1JBIodxMnkLmgCeMSHIQQEB4vphbnPkp2lX14N6qJm7FW1lSjPDxIzLv4
         wz4Nm49vaPQ4EoGsau1/fn8iHg4FWY91uw5XT31aq4pezYHcAkqDg/iirJ8fugSOowLH
         V0CLuGCqREbAFCGbXq3b03XucmMJL2Re1syLku+bJuLYwiCKRhLzNlapAGY0ngGN2Yjy
         O0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltGWhVbBQmoMJQxXzeUdQQN1MfVzQ7ab4b8nH39r8L0=;
        b=Qn15hsdgfnL7jzjnslmjUNUY6VgzuUf//RcRKXZnv2YkCUa+T+wxYQQucy4rf+ZzVP
         uxXweLPyy/MXqKwqioFRB02OmOXnoyK421kt1rLIrFEtePCfMsXjjd+Vrmu/HvPqQIix
         1iI1HhhYD7KJsKIukNY5ACd8sCJPVj+zQg8DuqscrpF5BHYcANbaTPTwOa7xBwP5K0K9
         shX5K9ehXXQCGXqwScOPEDLP5af2+/2eD5Yk/upi5yYr4EoCBX1iJ8M1rO7w5uowgocB
         HTQ5LvEwVTacdqGl3zDTCxKMMLluGWk4RR6Cfg1K7iz6bG3k0N4h8q7C2aTeeUHbzSY2
         DOkg==
X-Gm-Message-State: AOAM533exuWhLL+WNOOWR37d8Ln4jGlYPHh0jsTOl81OO/JODDxHX4Fq
        5n7m4/34//4j0kjZEuz8OTgAhhC+DyrCCnufpKQCgg==
X-Google-Smtp-Source: ABdhPJz94pvA7KXC3a6ccaxQ/g1lxKtRWKR7xfxabIEVOdCrrJeT+1+32hIwUzPt6U5xruhbBC5UqyCmlkYppx2GAac=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr59096oth.221.1596577109734;
 Tue, 04 Aug 2020 14:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200318024215.5270-1-po-hsu.lin@canonical.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 4 Aug 2020 14:38:17 -0700
Message-ID: <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, joe.lawrence@redhat.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 17, 2020 at 7:42 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The following 4 tests in timers can take longer than the default 45
> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
> Add 45 second timeout per test") to run:
>   * nsleep-lat - 2m7.350s
>   * set-timer-lat - 2m0.66s
>   * inconsistency-check - 1m45.074s
>   * raw_skew - 2m0.013s
>
> Thus they will be marked as failed with the current 45s setting:
>   not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>   not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>   not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>   not ok 7 selftests: timers: raw_skew # TIMEOUT
>
> Disable the timeout setting for timers can make these tests finish
> properly:
>   ok 3 selftests: timers: nsleep-lat
>   ok 4 selftests: timers: set-timer-lat
>   ok 6 selftests: timers: inconsistency-check
>   ok 7 selftests: timers: raw_skew
>
> https://bugs.launchpad.net/bugs/1864626
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/timers/Makefile | 1 +
>  tools/testing/selftests/timers/settings | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/timers/settings
>
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7c..0e73a16 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>
>  TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>
> +TEST_FILES := settings
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> --

Apologies for missing this before.  I've not tested with this, but it
sounds sane to me. A number of the timekeeping tests do take a while
to run.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
