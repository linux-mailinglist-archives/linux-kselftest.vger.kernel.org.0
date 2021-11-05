Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85042446A2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhKEUxv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhKEUxv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:53:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268BC061205
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 13:51:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t11so16975885ljh.6
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsqXxMPAEyayuWYNn2cn31F1D2jcff0K1QvBSthWMBM=;
        b=qOxV+6+MFUFLS2PS7gWTFOb+5OBR+cqySkvjy3obIuGHjHYU2+OPa1v0oH5ar3Momb
         1SfH9k7CtbWT3EoxFjVodUnvjUC7Sbd62Yd+tv89a35AM2Q477zcUc+DozAS/Lv/mS1y
         lPjneQGIlCtLwO6x6p+kHAIBo8KsK7JvzjcYBekIJDr5SvANWAhocb6d403cSVlvN9QE
         q691o0BWYl49mrnOtyAlBN8sa2c4x1HZTJezZCORUEHVarGNWj+9TGwDAqPQlnBVwyA9
         YMAgDh4A6AkxZeDLvFZC4h+oDYaqFL2h+lf/eYcRrNHxUzwl7RsJ5sTteaxm4LXmEV+V
         PFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsqXxMPAEyayuWYNn2cn31F1D2jcff0K1QvBSthWMBM=;
        b=Rum5l13PNN6J+FCQauWEKvJZt2UdhHAzvxyux5Nkdg479ITvtA5Nbkw5kbQmO3RreJ
         CvGy0aSeHCeSgQzdOULX0WP3TpMqmyjuOqrTdTvDbBUNkJ5wkl1eLnaYkL7O6KFTrcaT
         PUEktPuvy2l0xAJK0lK0X+j48Kf/q7BKRF/XX3GuUN4JDmsBaY4qMPU40vrVNl1JGObI
         5Ygkx25qTVAkNHJ+BZM7p0sy0q9K68fFqEPlEOFbJQNcnfQidihXmYnS39b5G3WME9i2
         3bbEI+QIgFPay2kTrwrWyeDXjNZByi5BpSqtBpCdypWACvdc5+XjvXa+z/qLrEaxZCEV
         GyNA==
X-Gm-Message-State: AOAM533IvDzg7lSUFUGGHi1raQzsLjk6A4xPWGAlzP39D1CV919LUCLv
        vjstscijjOAlH3YPGrAcH0F9NVCcTWngw2F91p40Kg==
X-Google-Smtp-Source: ABdhPJyscGR2faQ3WY30fi9rHtfREOCPhjZDAaOuuO8TE7pOhp1KBS3rpUKQlf4rPXLm+5TIIpFu3wdMSSP1pETACTo=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr64510854ljc.338.1636145469249;
 Fri, 05 Nov 2021 13:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
 <20211105163137.3324344-2-anders.roxell@linaro.org> <CAKwvOd=rRntVgYdqEeb=JAYo2iC-wVB3dkQWNvwdZdrYgt2s7Q@mail.gmail.com>
 <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
In-Reply-To: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:50:58 -0700
Message-ID: <CAKwvOdm=a7w0cQdynY2i5ST=xrfjzXVZcUniAoEyqC21oKPQsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 1:45 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Nov 5, 2021 at 9:35 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > When building selftests/timens with clang, the compiler warn about the
> > > function abs() see below:
> > >
> > > exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^
> > > exec.c:33:8: note: use function 'labs' instead
> > >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> > >                             ^~~
> > >                             labs
> >
> > Careful.
> >
> > Isn't the tv_sec member of `struct timespec` a `time_t` which is 32b
> > on 32b hosts and 64b on 64b hosts? If I'm recalling that correctly,
> > then this patch results in a harmless (though unnecessary) sign
> > extension for 32b targets. That should be fine, but someone like Arnd
> > should triple check if my concern is valid or not.
>
> It could actually be 'int', 'long' or 'long long' depending on the architecture
> and C library. Maybe we need a temporary variable of type 'long long'
> to hold the difference, and pass that to llabs()?

Yeah, that SGTM. Thanks for the review!
-- 
Thanks,
~Nick Desaulniers
