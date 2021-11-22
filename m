Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B397458BE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhKVKAT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 05:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhKVKAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 05:00:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB9DC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 01:57:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so62484625edr.5
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTSYVLeh/yXoJu2Zf4MZKwy5izFdU2MnMx2Yvekckkg=;
        b=WYzfylaxM2cUnx+ATjtwY2j0ElBwvtd5QyE0/ztAl98zf0T+l7suWoxZQOPGqsVOOz
         Ouf23dR0fBWTiAuWV+d9KFWphlpbN40dAQ2j9DVptkdLIQzkToWqTYUrvRx6qI1BWkze
         ajuPNB6SgdICdKiM4VwSpJGio2UFjb2H65xoyyi6qPgU8bSXfaWF8h4Earrv7pOHYh67
         brHBEqJCgSxnPzAIBRP3s9uhj5CmWDbmL1r6HFrfNUUBKOACDCbNdliXBl5bNKmjJ7KW
         zAQMuJWXnY3czYb0xlUBBicgXjXye+f2PQXjikvQr+yXW5AlZvy3FbJFa9dVQQYcMvoc
         Gg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTSYVLeh/yXoJu2Zf4MZKwy5izFdU2MnMx2Yvekckkg=;
        b=qP+d9M3iyg7Itm4518bQiK8LZAOuWZZG6W5FwEv/RLfgh3wRd9BXEKlGKsF7sVUL8U
         2McjKfk3hleCEA0KjLh4wWeIENEgIhUfr+h5odcO3/kzoSF7CGOiIBzfw9Hez09Bw0a0
         89qSBOBoZUqPu56lo9E8yDnEYsNgmMdekZvxSVsTIg3cjtbvcDphiSi6cat9LrcxASmq
         afxK9Ys6xclCxVofEaGgFBOB6KoKknqbc8SbB+FtvSefKos3ldo6zLqP5lvUonfTPgvJ
         bp8aDW4DsMcMEE6OCfHmYXA28SwbAvPwGjQp5pqG0maNhFldvsQr2O/rF4UspI6qkbgq
         2O5A==
X-Gm-Message-State: AOAM5301qWTDufg/w6GggIxQC3yyhPBbrJ4QRogUEqC/ODyGHYPIOZEX
        3GA+zd7jyCZ1r2uL6hwVRPwkB0WVmxXC1TLvJ514n95aLyuVow==
X-Google-Smtp-Source: ABdhPJwTYtcGZ5yqcOmIyTe+ojQ5tNYK7OL2XSCnAAVWmc/tXIguj1fKYRNX2ETGv64xWB9ML3i7Mhl7Y3fbi/umBhE=
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr63158558edb.52.1637575029592;
 Mon, 22 Nov 2021 01:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20211118145142.14519-1-brgl@bgdev.pl> <CACRpkdbn=govgPeiEEtVF_+bMYD1Oi1yC+diZ2-owO4O6-oCwg@mail.gmail.com>
In-Reply-To: <CACRpkdbn=govgPeiEEtVF_+bMYD1Oi1yC+diZ2-owO4O6-oCwg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 22 Nov 2021 10:56:58 +0100
Message-ID: <CAMRc=MfRN_jcyEo0MFUyrxvyrsuMPf0a=fPfWh46+_9Hn0jxhw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 22, 2021 at 1:02 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Nov 18, 2021 at 3:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > v8 -> v9:
> > - dropped the patches implementing committable-items and reworked the
> >   driver to not use them
> > - reworked the gpio-line-names property and configuring specific lines
> >   in general
> > - many smaller tweaks here and there
>
> The series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Let's go with this.
>
> Yours,
> Linus Walleij

Thanks but Kent and Andy are right, I'm about to send another version
that synchronously waits during `echo 1 > live` for the device to come
on-line.

Bart
