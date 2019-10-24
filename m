Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB87E3241
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJXMZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 08:25:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39778 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfJXMZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 08:25:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so24807666ljj.6
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=adol8S9hOxML1scHhb17+LQ7Zb/MNnz753gj6k4Cyjo=;
        b=qVRG8QJJTtxJeGanHOy/aDk4HpSZj7x6tk2m9OUebxLDrKM0sO8VVD/NGp2ykQQC7z
         JP83A5lIznjuGNnql4zk2Ty9OJ/zpo79NVe9VSfI77/598GliyqTi4YoxGMZ6ps3OmAh
         ghRNub/G9H6UNiGQX3raswXHBDMkDDFkZ3oqhIbzWg9beTmNgvfZrLASd+O5oMLHJTuc
         0xbPPqhEE+0cLCMbf4jBCwm9qSlMTBW3bZ3QZYUnVABzO5GirkpuPNGTLjT0VAgoCnMG
         7413gG7TLHNDeBAygzXhB0MWaR7fSJ37MJrbAeEjlwQATFDEcmSQmGkunUmXbWGm1ItI
         aD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=adol8S9hOxML1scHhb17+LQ7Zb/MNnz753gj6k4Cyjo=;
        b=kXpO7VexYLv0RO+jqJ1jQkTPgTuhmIFIHhF9cRkJ5pA+/nSbu089/a7c/yaNAgvAmd
         vtNcv1tBUUxm/uMx3pId6AjUcCUseR2HuFxNlzaB4/76FGLE4AUxOV+7iN0I4XS3zton
         lVQ7jMeNIwAmh4MWnGAlEq5clMKbJysl+lLd1iuhEAV1qj8NyGpg754PHS8r8QGYjNIw
         1aLvxuMhzsH4XziUP0NLa1I1aDl0wZr0Mv4I7ic3+1J62JgWELWxPf8XDNt8wfgzmr44
         TfQBxh6uM3E0WxiiAWtXf1jPSbFMjF0FC43YH8h5rIc8a7TaU/ej548X/94lcQd4gDbK
         IGMg==
X-Gm-Message-State: APjAAAUUdo4VOd27esacoG3bnHHYZprpS1fWjFJebnKGCFcXma2XyqEd
        yGGuvlsxAzLsT1kB7n90mKXNiUmDxOulPFj2U83noQ==
X-Google-Smtp-Source: APXvYqwBQU9wb57A2cbLafEN+WIwgbvalFplJbG+u5lbyIPFmwiEr/eG21wndPdsaDk4Zfb1Rfg/g7/9nSyZE66Ffsc=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr26017429lji.236.1571919941701;
 Thu, 24 Oct 2019 05:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <312839085.10341.1571900438441.JavaMail.javamailuser@localhost> <cb6b01a2-11a6-b33d-98cc-dea60933aff0@arm.com>
In-Reply-To: <cb6b01a2-11a6-b33d-98cc-dea60933aff0@arm.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 24 Oct 2019 07:25:30 -0500
Message-ID: <CAEUSe7-9rPrVnJcUV2_OAdyO1K5K772vgjE0Fd2Sv1BwospB3Q@mail.gmail.com>
Subject: Re: next-20191024 kselftest results
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     lkft-triage@lists.linaro.org, Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Thu, 24 Oct 2019 at 05:49, Cristian Marussi <cristian.marussi@arm.com> w=
rote:
>
> Hi
>
> On 24/10/2019 08:00, ci_notify@linaro.org wrote:
> > Summary
> > -----------------------------------------------------------------------=
-
> > kernel: 5.4.0-rc4
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> > git branch: master
> > git commit: 12d61c6996999e6562cbbed5f270d572248a11c5
> > git describe: next-20191024
> > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/ne=
xt-20191024
> >
> > Regressions (compared to build next-20191023)
> > -----------------------------------------------------------------------=
-
> > No regressions
> >
> > Fixes (compared to build next-20191023)
> > -----------------------------------------------------------------------=
-
> > No fixes
> >
> > In total:
> > -----------------------------------------------------------------------=
-
> > Ran 0 total tests in the following environments and test suites.
> > pass 0
> > fail 0
> > xfail 0
> > skip 0
> >
>
> It seems that my previous patch meant to ease kselftest in CI:
>
> [PATCH v2 2/2] kselftest: exclude failed TARGETS from runlist
> https://lore.kernel.org/linux-kselftest/20190926175219.29805-3-cristian.m=
arussi@arm.com/
>
> contained a subtle bug that killed it worldwide indeed :<
> it should have been fixed already by Prabhakar Kushwaha in:

This is due to another problem: Perf not building since next-20191022;
because Perf fails to build, the entire pipeline is stopped. We have
reported this already but it seems to not be reproducible outside our
environment. I believe there is more than one problem there:
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
tools/perf/check-headers.sh#n32

Hopefully we'll have these report back soon!

Thanks for your patience and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org



> [PATCH][v3] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
> https://lore.kernel.org/linux-kselftest/1571750829-28944-1-git-send-email=
-pkushwaha@marvell.com/T/#u
>
> Thanks for the patience...
>
> Cristian
>
>
> > Environments
> > --------------
> > - dragonboard-410c - arm64
> > - hi6220-hikey - arm64
> > - i386
> > - juno-r2 - arm64
> > - x15 - arm
> > - x86_64
> >
> > Test Suites
> > -----------
> >
> >
> > Failures
> > -----------------------------------------------------------------------=
-
> >
> > i386:
> >
> > x86:
> >
> > x15:
> >
> > juno-r2:
> >
> > dragonboard-410c:
> >
> > hi6220-hikey:
> >
> >
> > Skips
> > -----------------------------------------------------------------------=
-
> > No skips
> >
> >
>
