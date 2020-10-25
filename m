Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD722981B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415765AbgJYMib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 08:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392429AbgJYMia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 08:38:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A46C0613CE;
        Sun, 25 Oct 2020 05:38:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j5so3357161plk.7;
        Sun, 25 Oct 2020 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvuSDo2wkE4QwOENh8boyLlP4PQz8fyvgGKS3pbuxLw=;
        b=p8dQBhRkN7fEu+O1NeZ4Xa+o73YiAbgZRasX+99jvsgirWRrEOVNpP7cNFzQBV1ej4
         2yKfOCiJbHBFbSfeJL9eLJdKGeYPtNn3YQLKvJrrjQ1ppj4OlCR7oHYutNr+JenXWiuv
         aKNpIA8usS4sSxh+VhqWnEvjE9VeMFW6334nns9Ooffb6A7GOwRrY0uknwFiL+K5mX5i
         PsvxFI9yR1TNyUVhfhEIb3fkD+j8yZiyIjRLADqgR7gcxsvxoe7uDRnc3lZtaDewPiS+
         h9Ve59Ul9ji3VvEDomkSf6l7Md438NCLLh+ZOm83oYeNxB5oUiipDtuTYneR4oTF+ATF
         n2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvuSDo2wkE4QwOENh8boyLlP4PQz8fyvgGKS3pbuxLw=;
        b=UyDAuC0c91j0v/uVaR8C7e530FiMY7VjZ2U3zCLpdO3v85PemZzmq/GGBONZJFvy99
         2tXtBmP6ps1wVlI8gE0+YkNVqTL+Iju/i1wE555WxM7zaWPXC19A/WSXITJAlloK1sYg
         cSIc74DVznxgBJggdJzvFIR4IoqVsN7DTyGhz7e2edCwzoB0BAAzawRTtwOxTqsQjm48
         hr6uEPCBnbdxKdtF6W6tLI/V7m6MMeHwnXa1dEmPlUB1uW8FmCWEE4bW/L/ZFFHFMZFo
         XsCrDmabyoecIheYPckwyzy+o01kMN8kBrn0Gu2w0eRJED243uMcg0zWizo/2OMkW0wN
         SJ6g==
X-Gm-Message-State: AOAM532VxtrIFwTRoMkKCMU/et6EPIzB5+h2Vdri9WaEX2naRhsOLp5V
        Axms06MEpQLhtgMd5blXvq1oKI5uwwGG+O8Q4ws=
X-Google-Smtp-Source: ABdhPJw6EPtQqi2auFy61TxpN2g6nCTZxCBfBMdZEJBnxR41xBu40iSeXHfknEXojy0kMHOCOFIkhvaaQYW4yrijlyo=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr4532185plt.17.1603629509336; Sun, 25 Oct
 2020 05:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201022151349.47436-1-98.arpi@gmail.com> <20201023173108.GG32486@alley>
In-Reply-To: <20201023173108.GG32486@alley>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Oct 2020 14:38:13 +0200
Message-ID: <CAHp75VeEcb3CtQWeZXQz-UFMgqL6ERwDjudPmcCCNJgHesb3pg@mail.gmail.com>
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
To:     Petr Mladek <pmladek@suse.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 24, 2020 at 2:07 AM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2020-10-22 20:43:49, Arpitha Raghunandan wrote:
> > Convert test lib/test_printf.c to KUnit. More information about

...

> > not ok 1 - printf-kunit-test
>
> > --- a/lib/test_printf.c
> > +++ b/lib/printf_kunit.c
>
> There is no standard at the moment.

JFYI: from v5.10-rc1 it is expected to have documentation clarifying
the naming scheme. Also there is a pending series [1] to move KUnit
based test cases to the defined schema.

> Please, either unify names of all the above modules or keep test_printf.c

[1]: https://lore.kernel.org/linux-kselftest/20201016110836.52613-1-andriy.shevchenko@linux.intel.com/


-- 
With Best Regards,
Andy Shevchenko
