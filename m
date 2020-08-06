Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E723D8EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgHFJxg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgHFJxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 05:53:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E70C06179E;
        Thu,  6 Aug 2020 02:53:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so4501581pje.0;
        Thu, 06 Aug 2020 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXSnxxCYD2md6x19BIcV4dv3O6O3P24XFKvfPThGQJo=;
        b=XiWGQvg9Bit4nzKJF4qTwKdmAD1Q2E8m0XLXObi9vRO8M1t4VdTiK64oHbv/HyOTvg
         Iph0ndBegJGa710ZTHuhZ+ZoFOjKdukKozcCicBgLXX3y6uliKL/WS9BOsbd6KMTNBYV
         +nEGz4/MJztzxsjdU/7KBRNvEeW9+FJvkqwX5EIGlY58knyzPMbs/i/pkxxlRStNhW01
         u7mJDA/obpT1Enlojzjpv/fmkrEJ9Ni+5i1QasAQ8DjJ7xYVjUF1+dZQi3PfCMhkOGLq
         y6MLVqLBGMJKSb8/DYc6unpKl++YUtTzIvAXUpCK53ktVcgNw5a/VRRZUvPZh4Xo/Qsh
         vKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXSnxxCYD2md6x19BIcV4dv3O6O3P24XFKvfPThGQJo=;
        b=Xci9mUnh53DfhQBoD4g9N+XPdnKygI9R/+eQdjm250Hbu6If1r0TaAzzMciVukEnLN
         VtplrWDjsBWFZ49tlYQWts44XEj3fC431wFdrqSeYWymcRoNUPMBp+CooXsLFt3rJRqC
         XK9Sq76p8c/OHSZ95rb5dR9j1zpJkzKYsl+H+zpYEskbsZdOepWVHUZ1QPFCIIPq0KSE
         v0+dWwbMdUJAZGTLe9UEuXd4NPyjCEZarm3fyMzrE3sPLqz19/DcNFZPon2eWtJCLXCj
         4tPJcUKQkEHC7narV0y7ZhGD0WO+3AaY3apyc0tj6KxgZ0nM107R63eQrT+aZ3+jlfG+
         dQFQ==
X-Gm-Message-State: AOAM533GmHenOw8XryrAnzUduUC3YQkl++ptu+DGoGfWifdD1rDaLnaG
        N5EIYJru4zKVCHtUBJtLsXCB6rnk2U1a6J/k+mw=
X-Google-Smtp-Source: ABdhPJzZw1D9NdNDiy6amHPeR9pus0fXPnyBQGsA7oVjd8LW6an5Aly4sIaPIHNzyMhPT2bcLdXfSKW/9XHV18gYBRo=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr7815995pjb.129.1596707593391;
 Thu, 06 Aug 2020 02:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200806094440.14962-1-98.arpi@gmail.com>
In-Reply-To: <20200806094440.14962-1-98.arpi@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Aug 2020 12:52:57 +0300
Message-ID: <CAHp75Vdpyr=LiOsjgoJ1YscrvFwivtfg58dePtF9aQDYp6V9-A@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_hexdump.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 6, 2020 at 12:48 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Converts test lib/test_hexdump.c to KUnit.
> More information about KUnit can be found at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> KUnit provides a common framework for unit tests in the kernel.

> -config TEST_HEXDUMP
> -       tristate "Test functions located in the hexdump module at runtime"

We have a nice collection of tests starting with TEST_ in the
configuration, now it's gone.
I'm strongly against this change.
Code itself okay, but without addressing above - NAK.

-- 
With Best Regards,
Andy Shevchenko
