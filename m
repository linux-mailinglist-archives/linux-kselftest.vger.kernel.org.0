Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B197A440551
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Oct 2021 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJ2WLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhJ2WLa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 18:11:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1EC061714
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 15:09:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u21so23659310lff.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=di/e3U69r52jrUeczVhaYDryYZW3gCVqBTzf643dQXA=;
        b=siBSBhQHt2JQUMIuCfPk5GMcIJNl0sLVLxcKN3UsD4tXyGsgH3WEWmSLRrAU/CgOkw
         m1nBFpfcWScothbQo3334805jUCqyZQ8DCMDfGtkall3bc49XmL233VpH2q3j/+xFte9
         H0r15nSoS9F9GuF7B63uNxW+7Ro8dcavpFMfm7bhQMo2Vvfgp4TWW+3M9JUoM38dNugs
         rstEr9hxp9UEYR0ROMJpxTgiGN4DOplGQ1NzWvKr4b35mAULO00ymFwtPcIDnTsEKn8m
         jxt9g64HfQr5nudTmSAfnlxV2b9aUfDlhUqiT38vVaxq1IY+t4Pgy66YeliSwD0dFHmd
         Zy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=di/e3U69r52jrUeczVhaYDryYZW3gCVqBTzf643dQXA=;
        b=rMUXlIjvYeKCf7R/6oeKqTnbQ6+qKjXoQheCZ1JIp1LES3rx73zjxVklkoTEUcBFHj
         40e0kMSqb2KOeHmFTkOkGMDX1lFqRH6DB7nDAKasEFa+8AWZol0+4wO4BYV5ouT4wgTT
         5INpQ9mkaMzjKeO4E5QSY4v+DmpRTrCdY2rCnhbM3Q7OBQWqjICQ0ecApM+BqoB5v4/F
         gKLbr3/AABugwbDfBWUmuQZxZH7iYl0PLpc1V0h++5DmlxDRZrNyjT79+R2M4epkWoto
         1rqhfPlMu+q3n6K8DWWGk/z/Z6sg1OkluBNhnhLVrD8Lq2vGvHMizwi5r2VMWVNbk+8o
         QivQ==
X-Gm-Message-State: AOAM530LddIdZhZgalwc7CeYuVdVDgDIIrsn5kWEWibfq5MTYYPS/KYG
        Prg+IOEnpp7kzrHvT+KuT2S1Eta8yN1oSsmsyMOJLQ==
X-Google-Smtp-Source: ABdhPJwmyW+e4e+AUcbzMdhS2DXM0GnCOpIZOeUkkp5Q1k3OVptGZfyDFzZPb93dXqg7+B8HDftbWq2U+Ey5QM7jG4M=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr12990042lfv.651.1635545339252;
 Fri, 29 Oct 2021 15:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211029114312.1921603-1-anders.roxell@linaro.org> <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
In-Reply-To: <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Oct 2021 15:08:48 -0700
Message-ID: <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 29, 2021 at 11:19 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/29/21 5:43 AM, Anders Roxell wrote:
> > When building kselftests/capabilities the following warning shows up:
> >
> > clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> > test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > test_execve.c:136:9: note: uninitialized use occurs here
> >          return have_outer_privilege;
> >                 ^~~~~~~~~~~~~~~~~~~~
> > test_execve.c:121:9: note: remove the 'if' if its condition is always true
> >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
> >          bool have_outer_privilege;
> >                                   ^
> >                                    = false
> >
> > Rework so all the ksft_exit_*() functions have attribue
> > '__attribute__((noreturn))' so the compiler knows that there wont be
> > any return from the function. That said, without
> > '__attribute__((noreturn))' the compiler warns about the above issue
> > since it thinks that it will get back from the ksft_exit_skip()
> > function, which it wont.
> > Cleaning up the callers that rely on ksft_exit_*() return code, since
> > the functions ksft_exit_*() have never returned anything.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Lot of changes to fix this warning. Is this necessary? I would
> like to explore if there is an easier and localized change that
> can fix the problem.

via `man 3 exit`:
```
The  exit() function causes normal process termination ...
...
RETURN VALUE
       The exit() function does not return.
```
so seeing `ksft_exit_pass`, `ksft_exit_fail`, `ksft_exit_fail_msg`,
`ksft_exit_xfail`, `ksft_exit_xpass`, and `ksft_exit_skip` all
unconditional call `exit` yet return an `int` looks wrong to me on
first glance. So on that point this patch and its resulting diffstat
LGTM.

That said, there are many changes that explicitly call `ksft_exit`
with an expression; are those setting the correct exit code? Note that
ksft_exit_pass is calling exit with KSFT_PASS which is 0.  So some of
the negations don't look quite correct to me.  For example:

-       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
+       ksft_exit(!ksft_get_fail_cnt());

so if ksft_get_fail_cnt() returns 0, then we were calling
ksft_exit_pass() which exited with 0. Now we'd be exiting with 1?
-- 
Thanks,
~Nick Desaulniers
