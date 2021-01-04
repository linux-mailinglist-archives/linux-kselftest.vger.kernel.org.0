Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627192E9663
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jan 2021 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADNwl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jan 2021 08:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADNwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jan 2021 08:52:41 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94DC061574;
        Mon,  4 Jan 2021 05:52:01 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h186so16495489pfe.0;
        Mon, 04 Jan 2021 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbriYaIoB2gZ7KJStemV7yd1FR7KiYHvNufspjX4Jwo=;
        b=BgnsVUosO0vjAtrbET+oqFJlIZZj+E8h4z6p2o0QsdvjoItoxN81Rqf7/JBCx4H35q
         OFhwR/oLTcU5L+n2F3VduB4n2vcEmysZuPoAtvSy54hKhulCCe426+P1yb+JLuOFI4Rg
         3ban+hudPMNqe7XcCZ/iRKdmzoYMiA0pqq8zUteoUFj9v4zl8R52y54xZVsqmXB4yyA/
         SlCrey0KOcfbnisL2WE7G0l6VhpP2qLTdz0TzeD6uqc5jHoO0fbzrO1CcwygMeCeC+UJ
         Nivlt0FLz8RmcnenxqC+X0F1Ep72YsGdU5qgaUtQqXqCwEutP/T67ypdWYCV1HHEq+Gn
         cbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbriYaIoB2gZ7KJStemV7yd1FR7KiYHvNufspjX4Jwo=;
        b=cRLG7bcTWD1PDHhJV3t2INWTr2oyfGZ84EVuZAuGh46U1gXSdQdcCTA+OTbKyWTFPg
         pqkRXHoSARArLwVH5zpHC/IJjX2bwODLEnomrUXFUjTSoFO3sYa/c4QHT9TV8LgwuEAl
         JUQyIITEfWiUxagDtDANwbib8AeWlnuVe65SXurg2aGlTHgRWrJQJeoPwQhXMX+ow9Oz
         M9xy+u/EiKhofSnhrMo/NebsurIDjWj/cPKaf+fz/xeEYk+XyN+m1kcIRJtEKuDUOiHj
         FxqAzPhD6i1Jx9Na/QdSN6wjAv6aG0VeUo6gIMP+P+ix6E20TQbktN153778bgdyMrRp
         mfrw==
X-Gm-Message-State: AOAM532a79S9kXV+aqe6vsc2wtir/fnEmJ3aWEljIsxzuEO8QrNaPFl1
        06LOCz0AcqDHZJR9mkxFl9KBuoRfmXcqHVvLYYg=
X-Google-Smtp-Source: ABdhPJzeJE1s5+lD8qK/cO6QfdppxqAMocPdroUzpVX6DJFhF5TYYx6n2Dr/rkDLfvKkezFWN9YJedSTGC9q/fmtcW8=
X-Received: by 2002:a63:74b:: with SMTP id 72mr71354571pgh.4.1609768320749;
 Mon, 04 Jan 2021 05:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20210102022949.92304-1-warthog618@gmail.com> <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
 <20210103021725.GA6622@sol> <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
 <20210104015129.GA4939@sol>
In-Reply-To: <20210104015129.GA4939@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jan 2021 15:52:49 +0200
Message-ID: <CAHp75Vdd6yC=j+m7OOdP=M1j8Eoaayq8HSLF2fjVXcA0wiu9kQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test implementation
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 4, 2021 at 3:51 AM Kent Gibson <warthog618@gmail.com> wrote:
> On Sun, Jan 03, 2021 at 05:10:10PM +0200, Andy Shevchenko wrote:

...

> In this example it is the 508:
>
> # e.g. gpiochip0: GPIOs 508-511, parent: platform/gpio-mockup.0, gpio-mockup-A:
>
> So I'll use that - unless it is unreliable for some reason?

debugfs is not an ABI and tomorrow this can be changed without notice.

-- 
With Best Regards,
Andy Shevchenko
