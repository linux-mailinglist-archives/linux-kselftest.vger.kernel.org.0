Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC45D443833
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBWHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBWHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 18:07:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24465C061203
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 15:04:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o8so2450860edc.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4F13XQgVfHrFjDyFI3dMs7NsVDxr8/9oSk7fc0QDng=;
        b=P4nJjt/fXf671D9eUvZ9+y2bS+QDywI1rCVkTQODwOQV83TwA4krXZ7DTRv5643PYu
         nMXoWLhAOqQBTli5Xrp/KuciRht6NbwzCpTkhpKUxgRFTYGZqdUrZatUog5rJSs2lgfX
         H6N6qANOFFyiXZvTthW1CuCVJ0KXY4zPBZuHt48oUWyz7Ayj3g9Ooc4FgS6CFJV6h5CY
         Lbmoz5D1O8xBo+glIM6hvtuQctVF6/T2kHB1n8bmxK8tALLMaAH9NRZb2/MkJ+mLParS
         RIDHAd2t3NPegMZM91FO1Zejd4HVII8jRLkmTu7iNKMf59bppokv5o2c09jEw+LX5pn8
         v4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4F13XQgVfHrFjDyFI3dMs7NsVDxr8/9oSk7fc0QDng=;
        b=J3dd1baEbKq6h0bh09ykqg2q1klzTWvjbdi5Si8fHhpxNtng5gbUESmOqWVtZ61ZJJ
         5wNcbfQdI3SGoXof0+RvuZOwI7WCqCcemmMZGdfVOZV+lMC0LUdksytHAxzho1/1KZVr
         7JpMJIL958c2KIxa3puCgSBBfxR9n4yGyeaNMWxhupMoUP7paBlfoHJBvCv441GKhlpR
         ZfqCdvsF74fL/RlDlNCEdkZSROVk2Qcvn7ncjVuN/uq8q9BDAm77aMkQI2SiInMIRbJy
         MXYwYlLouveOdHwUPnrzhp9a2uvUTQy/1/cNbLE7yqh1FVIY+RSU2cGifuCGzQV8WRRR
         BFJw==
X-Gm-Message-State: AOAM533WHu+5P+RG8rJ7yLYIoHvuuXOIcpDe7TV8UphLsiMgzFoThInB
        parUrzJ6cDpnsSClRqE6Gh2YikGMItPGSZ6zuzb6Rg==
X-Google-Smtp-Source: ABdhPJzTazRGBk5tHZ5IA/YT481aZrqOv2RHiiBDcFVRQOVYSiPeM5kCIsHtyEdCdFkGD1Yr28LrnfqmQq+gR6UCRoM=
X-Received: by 2002:a05:6402:1e8e:: with SMTP id f14mr20147051edf.250.1635890686722;
 Tue, 02 Nov 2021 15:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211029114312.1921603-1-anders.roxell@linaro.org>
 <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org> <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
In-Reply-To: <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 2 Nov 2021 23:04:35 +0100
Message-ID: <CADYN=9+iueC3rJ4=32OM9rOUDLLmvcKY-y_By4hwAj1+9gxRiQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 30 Oct 2021 at 00:08, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 11:19 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > On 10/29/21 5:43 AM, Anders Roxell wrote:
> > > When building kselftests/capabilities the following warning shows up:
> > >
> > > clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> > > test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > test_execve.c:136:9: note: uninitialized use occurs here
> > >          return have_outer_privilege;
> > >                 ^~~~~~~~~~~~~~~~~~~~
> > > test_execve.c:121:9: note: remove the 'if' if its condition is always true
> > >          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
> > >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
> > >          bool have_outer_privilege;
> > >                                   ^
> > >                                    = false
> > >
> > > Rework so all the ksft_exit_*() functions have attribue
> > > '__attribute__((noreturn))' so the compiler knows that there wont be
> > > any return from the function. That said, without
> > > '__attribute__((noreturn))' the compiler warns about the above issue
> > > since it thinks that it will get back from the ksft_exit_skip()
> > > function, which it wont.
> > > Cleaning up the callers that rely on ksft_exit_*() return code, since
> > > the functions ksft_exit_*() have never returned anything.
> > >
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > Lot of changes to fix this warning. Is this necessary? I would
> > like to explore if there is an easier and localized change that
> > can fix the problem.
>
> via `man 3 exit`:
> ```
> The  exit() function causes normal process termination ...
> ...
> RETURN VALUE
>        The exit() function does not return.
> ```
> so seeing `ksft_exit_pass`, `ksft_exit_fail`, `ksft_exit_fail_msg`,
> `ksft_exit_xfail`, `ksft_exit_xpass`, and `ksft_exit_skip` all
> unconditional call `exit` yet return an `int` looks wrong to me on
> first glance. So on that point this patch and its resulting diffstat
> LGTM.

I'll respin the patch with these changes only.

>
> That said, there are many changes that explicitly call `ksft_exit`
> with an expression; are those setting the correct exit code? Note that
> ksft_exit_pass is calling exit with KSFT_PASS which is 0.  So some of
> the negations don't look quite correct to me.  For example:
>
> -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> +       ksft_exit(!ksft_get_fail_cnt());
>
> so if ksft_get_fail_cnt() returns 0, then we were calling
> ksft_exit_pass() which exited with 0. Now we'd be exiting with 1?

oh, right, thank you for your review.
I will drop all the 'ksft_exit()' changes, they should be fixed and go
in as separete patches.


Cheers,
Anders
