Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6E1E420
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfENVtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 17:49:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45317 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENVtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 17:49:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so365818ywa.12
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2019 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+9TCAe1fMVTMqx0AuhLQptuUwnNa+S9Uw1MBQQeqXQ=;
        b=FYPqHhHphXNHBBgx+uM0Ba+cRfG4HYqaeZXEqRFzNjSuQVvKnp0CmHQM2PzIFyPTHu
         RcEZSb/k7H6Svl7m/MDuBLWx9uRgLMDVQE0oVFJosMytGISr0qVSCYaswqKQ+fr6r8FJ
         ZDmR7nBbj5i2ps0u8NqH/E9F7aI2PR5YdNyubCpRhYViZIvO8+Yhb2ZRDDi3dkCCy4sv
         ng1GUcivwZ4NwtEtKXyPZzAYIECYDzRwAGR3AmRyX5YY77NCKRZmvnNQV+IMnONtXltw
         KmRQZ6UpWN5cpmUD4Rdt9weFO/XC6pjm9zE2ERfpmt7mvh8P7pNo5YaW1WGbGUII6xbt
         fgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+9TCAe1fMVTMqx0AuhLQptuUwnNa+S9Uw1MBQQeqXQ=;
        b=qqsP3Tp20q31ry/dMMbR6q99N9rEFwLeBXW4dUxg2V2kYDbrVSzNrrET/7b0LT44GL
         9u1Ctaz+32ncZX/Q5nlqrXowZd1mfc5R+ZeyMOeWencSKeWMb5JpmGovsQOppHsLPuWh
         h0jwgtmDK7YHxZMZWIWT/sI+MXpreDbMbMRbTl8wxxFFVYMwh5nG/7Vve5j02QOj/ak8
         SkLWVUwD2m1BZGdldGDybMvQt6ia/6CHVXPtQlHBBWy72VfJEpPQaoYWGQO96i3wKfvU
         ilzfxUUlSY/fMQZY88PM2PQgu0LGHz0QiSbQnKRcwlHDOwDHaC/9nLta8Ex5Vvg3VOHm
         KHkw==
X-Gm-Message-State: APjAAAWYzmChZEaXhgXTJ7LEYOlqlTO0vbu5WAMynb63OvxM5BMdKjxK
        IOSM5kQr5PL+KA+CJgw2hTcnM5+5idSycPk4hbwz1JeeRRk=
X-Google-Smtp-Source: APXvYqzJFBhFZddQC/Ou5a+IcTVdcrf/2uPjpAPPcWKtzo3ZvnoN4ivLE/N/oJGjEWFhls6JxYUbb+jA/fld4CeSDQQ=
X-Received: by 2002:a0d:e785:: with SMTP id q127mr18949682ywe.204.1557870588545;
 Tue, 14 May 2019 14:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc>
 <201905110746.D6C85E86F6@keescook> <CADYN=9+nwM4Kw-PWHHDpQ5hpf=N5N8Ewy=h7Y2RTyO5Kwak88A@mail.gmail.com>
 <201905140843.B972AA13B6@keescook>
In-Reply-To: <201905140843.B972AA13B6@keescook>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 14 May 2019 23:49:37 +0200
Message-ID: <CADYN=9KaDW8vYC7FancbcRcDc4pfMozXqoGQGB3V=RxgQZBK4w@mail.gmail.com>
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

On Tue, 14 May 2019 at 17:46, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 14, 2019 at 05:28:45PM +0200, Anders Roxell wrote:
> > On Sat, 11 May 2019 at 16:51, Kees Cook <keescook@chromium.org> wrote:
> > > > Test Suites
> > > > -----------
> > > > * boot-lkft-kselftests-master-519
> > >
> > > What counts as a "pass" for this? I looked at the x86_64 log, and there are lots of kselftest failures, but the dashboard counts it as a "pass"?
> >
> > The boot is passed when the auto-login-action in suite 'lava' is passed [1].
> >
> > There's is two issues:
> > 1. We had a way that changed the run_kselftest.sh file in order to
> > skip tests that hanged (that results in no test output from the run)
> > various boards. Since the new change to kselftest, the patch to
> > run_kselftest.sh got added that breaks our way to skip the tests and
> > kernel hangs.

aha, right that's awesome.
So its only scripts that we have to skip now then.

>
> There's a fix in -next that adds an "alarm" check now so no tests should ever hang for more than 30 seconds now:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?id=a745f7af3cbd04b9c9c9e803429e1c20775b538d
>
> > 2. The way we parse the output doesn't match the new output format.
> >
> > We will turn off the "next-* kselftest restults" until we have
> > resolved this issue.
>
> I'd prefer to keep the tests running -- they're still valuable logs to
> have. I was just curious about the specific reporting. As long as the
> issue is known, that's fine. No need to disable it entirely. :)

We will still run the tests on next, the plan is just to stop sending
reports until we have the parsing fixed.

Cheers,
Anders

>
> --
> Kees Cook
