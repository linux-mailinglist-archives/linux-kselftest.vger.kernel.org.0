Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F726E547
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 21:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIQTRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgIQQSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 12:18:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B5C06178B
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 08:53:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so1508087pjg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bpeJmfLaUdJUdRQCC+1Kkaahik9MfGdV1JCQQN+ftA=;
        b=wPTmRKV7mzIGoyC0/19DkfpvYXemkGgKI/iGQM4Fdiinvf2NCxAs3ZEabWCfux8ImY
         hXmIzcCLXR8o7A+rE2lXB7YLN54APTzj4nLGIm2uKgAe3LG7522D/4ELuDr4tRrFYIId
         r/ZH7sFBXdUXoS3kthIR3gCxRTi6d5xQBFRVY5+3dB/Eo0YjyqH5fN6bN48VyLHIuqKf
         BoyVePZutG74g2JLDexWawC2CbQv5WropMXHekT3PAOQldXFUWFJn/O3xbEBo2G2yCwZ
         SAkjfNu/giXR8pqEJC5bA0W3tV+9Z1S6qE1N0qK03UURdLzrS+12648xIa3dfCvTKFEt
         b11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bpeJmfLaUdJUdRQCC+1Kkaahik9MfGdV1JCQQN+ftA=;
        b=CeMyCu8Adop12ChWpH14YwsfBqEUttcx3vk4Ir24lKErkIvTY5MjLWLwsLHrb5Ojob
         jCyNFvUEXgrU7rfILwZKqr9GnK2OIGEOCUBAykl/D0pHNj80Y5D5hvWZYiy1haM0Ha7Y
         oBzsMpMfxIluKKiNQ9kVXP65jkCBb20tksp7KFMJmaHH36n/pxH/cmUlHsWqNj1JPTGF
         xPGDOMB4KkuKXhiasMnUL6TH+Xa/H1rWXG0k9/Uuej+AJ/dmBmOziZIIDbbLIBhW/M0a
         ImvCqh7KBJVpYLMaNfJFN1yhdVVmiQIgq+iaxeLc3pKEUkqKNoPgB8pHZZIeHL064Ofk
         Lu0A==
X-Gm-Message-State: AOAM530qAbW2sF8S7I5S1qWD05J0NoKoMFnUfNyMHaoN7jT5Ee4WjPQ7
        EruNalBNnDd/7pEiWAXhTYVp2aQ51/ldRCv9WK+gfw==
X-Google-Smtp-Source: ABdhPJzxBD08XLMZ/eMtjTIwg6DpVlX5XjkQM77G7WqyVfiLwHULJwFyZzC5fFdye7ihxhxIu1whj65ca14QsM1AhSU=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr8923866pjx.90.1600357982512;
 Thu, 17 Sep 2020 08:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <0100017492de8180-c524cff4-bd4e-4777-9f33-7e1da2c986d2-000000@email.amazonses.com>
 <CANKHsTfyE64ygNB0H0Nx=P63D-kqYa6aGOXS6ZmNUspLJJtS=Q@mail.gmail.com> <f9144c49-d39a-af67-2a5a-3828b86ea86c@linuxfoundation.org>
In-Reply-To: <f9144c49-d39a-af67-2a5a-3828b86ea86c@linuxfoundation.org>
From:   Justin Cook <justin.cook@linaro.org>
Date:   Thu, 17 Sep 2020 10:52:51 -0500
Message-ID: <CANKHsTeOix88zT=d1ywROXXXZRxYnYOEzRQDJGJgoh4DVbnPjQ@mail.gmail.com>
Subject: Re: [REGRESSION] kselftest: next-20200915
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     LKFT <lkft@linaro.org>, lkft-triage@lists.linaro.org,
        linux-kselftest@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

The report sent was meant to be a general summary, rather than a deep
dive, of the results. Most of that information can be gathered by
viewing the test details.

>     * Test details:
>     https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915

If you open that link in a web browser, there are a number of ways to
dig down into the results. If you have questions about the best ways
to do this, please let me know.

Maybe that isn't the best way? I'm very open to feedback. I just tried
to best copy the previous report that was being sent out to start.

Please feel free to ask any questions you have or provide me with
feedback. I'm here to help.

Thanks,

Justin

On Tue, 15 Sep 2020 at 15:18, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/15/20 11:52 AM, Justin Cook wrote:
> > Hello,
> >
> > Linaro had previously been sending out a report based on our testing of
> > the linux kernel using kselftest. We paused sending that report to fix a
> > few issues. We are now continuing the process, starting with this report.
> >
> > If you have any questions, comments, feedback, or concerns please email
> > lkft@linaro.org <mailto:lkft@linaro.org>.
> >
> > Thanks,
> >
> > Justin
> >
>
> Hi Justin,
>
> Thanks for the report. It would be nice to see the reports. However, it
> is hard for me to determine which tests failed and why.
>
> > On Tue, 15 Sep 2020 at 12:44, LKFT <lkft@linaro.org
> > <mailto:lkft@linaro.org>> wrote:
> >
> >     ## Kernel
> >     * kernel: 5.9.0-rc5
> >     * git repo:
> >     ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git',
> >     'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
> >     * git branch: master
> >     * git commit: 6b02addb1d1748d21dd1261e46029b264be4e5a0
> >     * git describe: next-20200915
> >     * Test details:
> >     https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915
> >
> >     ## Regressions (compared to build next-20200914)
> >
> >     juno-r2:
> >        kselftest:
> >          * memfd_memfd_test
> >
> >     x86:
> >        kselftest-vsyscall-mode-native:
> >          * kvm_vmx_preemption_timer_test
>
> I looked for the above two failures to start with since these
> are regressions and couldn't find them.
>
> Are the regressions tied to new commits in linux-next from the
> mm and kvm trees?
>
> thanks,
> -- Shuah
>
