Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF11CBDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfENP25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 11:28:57 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38280 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENP25 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 11:28:57 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so14294512ywe.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgI1lxxRy3tW5Q4wcQtRdbO4LBuddKeTRINCixKWoDo=;
        b=qFt7dt45CKK2hAuTOdeaeqd/L33QjuWTPdGviNr3VawTo5GC8F9MZxplowjk67nPOI
         p29luIWDSUdD3wivqjKUyumclT/yFMYDLyzuLPLMyUw3bJY/KHmX7yZxll6g0b+mVQeT
         E7Z3PEIRJqRTU3Y/+EWJ4ifLEFbSk3GPcdICx1F0T+lwA1AThpkuJ5vPMclZtJVbKV9E
         xIxoxov1h5AgGS3Ji2KtxDqYEErEamuFkEGZV8lhoOFMf1LVK/DIuZoJqR/QtIjffcjP
         rh+OabqGy/6Nlk2m9Y/eaQiIAYsb10B+KlwY+7laH8tnHiXIt/TstiH1qCfPcqe4hRv1
         Pwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgI1lxxRy3tW5Q4wcQtRdbO4LBuddKeTRINCixKWoDo=;
        b=sENZcxfuxUJ+n+OziA0EzFzTJHvgceN7j2duiWF7/YSjQJvcZCw/oWjcMIjr92aOXm
         V280sPyqi4uF9RP4KEddG/2Nz7j/fEcNSqmCnR7RRAM4e2NVyL861nxgijSC+/ok5W/x
         PT2Phc6ceNU0xbAIQUJdBuGhT1jcyb9yd+I1mZjj+u7jT7+qushOVBm9xXYF+aPFybnf
         b57/A26xpQH9J/+cvBIXjuu0juRO61wxtM0tqxc3FMPSLa6OLLEnvEPk74Ubbpqkfb3H
         xfL9ZWoQsWSfaQrknk80CZktcVDs9In4IAdp0VrDhxOW5O+4IRXPbNMahCFRyGJwg27u
         xoDg==
X-Gm-Message-State: APjAAAUGwzhaCpILEV20PCPQcfSqxOExxLhdfYEEB4lzBeamLS3lGIPV
        C4yJ3U+48dbimlBY5SY00IRb6Vtu5qfjy4GLo/Kje1eJUDxfHA==
X-Google-Smtp-Source: APXvYqxwBHXPJjOHHEGyUDUqbBfn3iwEKxY9mYW3CG20xgX+QP9LDeekQsBifZO3vxQCs/k2OJu1UrCcCBKRLIxnFb8=
X-Received: by 2002:a25:b948:: with SMTP id s8mr17396862ybm.325.1557847736552;
 Tue, 14 May 2019 08:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc> <201905110746.D6C85E86F6@keescook>
In-Reply-To: <201905110746.D6C85E86F6@keescook>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 14 May 2019 17:28:45 +0200
Message-ID: <CADYN=9+nwM4Kw-PWHHDpQ5hpf=N5N8Ewy=h7Y2RTyO5Kwak88A@mail.gmail.com>
Subject: Re: next-20190510 kselftest results
To:     Kees Cook <keescook@chromium.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 11 May 2019 at 16:51, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, May 11, 2019 at 10:14:57AM +0000, ci_notify@linaro.org wrote:
> > Summary
> > ------------------------------------------------------------------------
> > kernel: 5.1.0
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > git branch: master
> > git commit: a802303934b3bd4df6e2fc8bf2e4ebced1c37556
> > git describe: next-20190510
> > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190510
> >
> > Regressions (compared to build next-20190509)
> > ------------------------------------------------------------------------
> > No regressions
> >
> > Fixes (compared to build next-20190509)
> > ------------------------------------------------------------------------
> > No fixes
> >
> > In total:
> > ------------------------------------------------------------------------
> > Ran 12 total tests in the following environments and test suites.
> > pass 11
> > fail 1
> > xfail 0
> > skip 0
> >
> > Environments
> > --------------
> > - dragonboard-410c - arm64
> > - hi6220-hikey - arm64
> > - i386
> > - juno-r2 - arm64
> > - qemu_arm
> > - qemu_arm64
> > - qemu_i386
> > - qemu_x86_64
> > - x15 - arm
> > - x86_64
> >
> > Test Suites
> > -----------
> > * boot-lkft-kselftests-master-519
>
> What counts as a "pass" for this? I looked at the x86_64 log, and there are lots of kselftest failures, but the dashboard counts it as a "pass"?

The boot is passed when the auto-login-action in suite 'lava' is passed [1].

There's is two issues:
1. We had a way that changed the run_kselftest.sh file in order to
skip tests that hanged (that results in no test output from the run)
various boards. Since the new change to kselftest, the patch to
run_kselftest.sh got added that breaks our way to skip the tests and
kernel hangs.
2. The way we parse the output doesn't match the new output format.

We will turn off the "next-* kselftest restults" until we have
resolved this issue.

Cheers,
Anders

>
> $ wget https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190510/testrun/716064/log
> $ grep '^ok ' log | wc -l
> 60
> $ grep '^not ok' log | grep -iv '# SKIP' | wc -l
> 30
> $ grep -i '^not ok.*# SKIP' log | wc -l
> 18
>
> 60 pass, 30 fail, 18 skip
>

[1] https://lkft.validation.linaro.org/results/testcase/141157606
