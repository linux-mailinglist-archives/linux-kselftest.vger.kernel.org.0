Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403444469F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhKEUsb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhKEUs2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4820F61372;
        Fri,  5 Nov 2021 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636145148;
        bh=mbkrqX49D8pvCsH1aYAfKqkgRYkCne50RDuP81HnW7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X1QCIDMOpF/j4JsFMp9QbVW+hb765FKHzOPgW/k7AZIfQ6mQOmnfvVlcEZX24Sl/p
         3lSwTJTnduXcZNtJcTxfJkTIKXIu4/TRYuqCSdbEZKjWHy/fYKyVlILbZmqV1E7XLq
         wUhERcMGmrqRpIndKgMBr7XXEJogaTOdT8wYuIB+BW7Ey83+yr9wiE11HatmtCfiFr
         VpHYVNBcTubzYdCBI7uAPipMbmRfThzFpvWynOik6cROL4fpJvPsUUWa5EA+XpBfuK
         FQ4gOxbD5LMIDky9WLplrxla3ynOUMPvwHrGOAv1r8aI3AXp7TFWh3aawMkEC4TXFP
         fQhRTddtd1MKg==
Received: by mail-wr1-f54.google.com with SMTP id d24so15658407wra.0;
        Fri, 05 Nov 2021 13:45:48 -0700 (PDT)
X-Gm-Message-State: AOAM531TjcZZVftOmy5VcMznS68JLp6AFL23hymA32+v/iyTXAAYpDqm
        tUtU39Z3S4D8Ev01O/RVfh/yAZ6T8p7eVKUx2OE=
X-Google-Smtp-Source: ABdhPJwYYHCIQ5b6GvuGVOKrx9JsbQ4IGmE0F25KFAMebt371XDu28fdt4XzAsUVYK/ecp40hA94FfXPeSlX5tSrZv4=
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr64789976wrx.71.1636145146801;
 Fri, 05 Nov 2021 13:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
 <20211105163137.3324344-2-anders.roxell@linaro.org> <CAKwvOd=rRntVgYdqEeb=JAYo2iC-wVB3dkQWNvwdZdrYgt2s7Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=rRntVgYdqEeb=JAYo2iC-wVB3dkQWNvwdZdrYgt2s7Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Nov 2021 21:45:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
Message-ID: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Nov 5, 2021 at 9:35 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When building selftests/timens with clang, the compiler warn about the
> > function abs() see below:
> >
> > exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
> >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> >                             ^
> > exec.c:33:8: note: use function 'labs' instead
> >                         if (abs(tst.tv_sec - now.tv_sec) > 5)
> >                             ^~~
> >                             labs
>
> Careful.
>
> Isn't the tv_sec member of `struct timespec` a `time_t` which is 32b
> on 32b hosts and 64b on 64b hosts? If I'm recalling that correctly,
> then this patch results in a harmless (though unnecessary) sign
> extension for 32b targets. That should be fine, but someone like Arnd
> should triple check if my concern is valid or not.

It could actually be 'int', 'long' or 'long long' depending on the architecture
and C library. Maybe we need a temporary variable of type 'long long'
to hold the difference, and pass that to llabs()?

       Arnd
