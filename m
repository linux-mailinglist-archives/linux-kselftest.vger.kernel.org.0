Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43FE35FDBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 00:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhDNWXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhDNWXW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 18:23:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECBC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 15:23:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d5so12794637iof.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNT3NufKrIUcs5+uF24MnkRa6AH9RGOV3n+FhV4AzIg=;
        b=jpC/Ewq35qcb9hDK/ZzGYMsPxIk+MOJTOKhmjhCsLaj1I0NDFUP/L8so4AOOn40/Ct
         M8/7T62ZEkmyuhQ75BR0/ey+nC8wkHIUYVayd5Bc2ji/40fh6KhsZ60OXYnLgRTbno60
         7c6hwgYGKu0+8kBgHW0MziCsM6hKjfb5oWymkmqsIC/FERkqxZeIz2FsiI/Ulg6IdzCV
         VGBKWjuI/782ajBeBc6YhxkEbCfiFf4cG6vqlJFtgiUMT3ckotvhOWu+FLb4Gkg6Hyh6
         XTgq5XT8Q95RUtWzDDntbOhuKoT7M412v37c+SZtPjKWTaw4awd4/IO4Wu8AlwNz0qUa
         h1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNT3NufKrIUcs5+uF24MnkRa6AH9RGOV3n+FhV4AzIg=;
        b=kCAouoXC3tqrq/u+UeUeaCuper5y8oZV1mDJZcAgQGBila2G6cyY8/+m7mXNEcq1S0
         9ynlV6JqQRThA1u96FPPpjL2t6dhPdOuX0OWV9x5FFwWsp7sU/hKxZ5+yqVuJhHC0FDL
         21i8JWKfIupS9ur1NGNxFqKqn8jlzNdEMqhSWcOWqIrp+PCAjkq+HSmNJ7nl3u4jEnOp
         0xGloHAYqVVxdudmh14eJB7L+/DtYlfrECs12zYtpZ2AcZEEGzw733X+ml7kYw9XLs/5
         PMMXqaPtNbq3X7kbZM8SWfkbbiUHT5bdUu8JNWK0T+aETDqaQnJlhxcZCRMZSH9ewaQj
         KiCg==
X-Gm-Message-State: AOAM533NMHYTykxiQWiRXtP5WhL26DHOssT3FSCnQL0JP5VHxXBm0Dl/
        oJnP/01Wux29wlTmNBBG/+oxxkQuSnCkzeQnny0eiQ==
X-Google-Smtp-Source: ABdhPJyXwtUg9Lud+Sx/M24/ZqjT8ivP4osMv+mVhBeNoiEcRIj9NNBtKWO8MyLAIjeC4kOVtKWUcXLpskZKx4B6pBI=
X-Received: by 2002:a05:6638:204f:: with SMTP id t15mr134633jaj.75.1618438979587;
 Wed, 14 Apr 2021 15:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210414004518.1116248-1-dlatypov@google.com> <CABVgOSm6VY_vVvjryYc8eAvw7QcNuisP1iesdw4s3Td4Dxo1aw@mail.gmail.com>
In-Reply-To: <CABVgOSm6VY_vVvjryYc8eAvw7QcNuisP1iesdw4s3Td4Dxo1aw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 14 Apr 2021 15:22:48 -0700
Message-ID: <CAGS_qxrVmVK3sOuNR6AMu6-Xyw_wdd0MQD-YiFVXcD=bkTmr0A@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: kunit: add tips for running KUnit
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 13, 2021 at 9:22 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Apr 14, 2021 at 8:45 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This is long overdue.
> >
> > There are several things that aren't nailed down (in-tree
> > .kunitconfig's), or partially broken (GCOV on UML), but having them
> > documented, warts and all, is better than having nothing.
> >
> > This covers a bunch of the more recent features
> > * kunit_filter_glob
> > * kunit.py run --kunitconfig
> > * slightly more detail on building tests as modules
> > * CONFIG_KUNIT_DEBUGFS
> >
> > By my count, the only headline features now not mentioned are the KASAN
> > integration and KernelCI json output support (kunit.py run --json).
> >
> > And then it also discusses how to get code coverage reports under UML
> > and non-UML since this is a question people have repeatedly asked.
> >
> > Non-UML coverage collection is no different from normal, but we should
> > probably explicitly call this out.
> >
> > As for UML, I was able to get it working again with two small hacks.*
> > E.g. with CONFIG_KUNIT=y && CONFIG_KUNIT_ALL_TESTS=y
> >   Overall coverage rate:
> >     lines......: 15.1% (18294 of 120776 lines)
> >     functions..: 16.8% (1860 of 11050 functions)
> >
> > Note: this doesn't document --alltests since this is not stable yet.
> > Hopefully being run more frequently as part of KernelCI will help...
> >
> > *Using gcc/gcov-6 and not using uml_abort() in os_dump_core().
> > I've documented these hacks in "Notes" but left TODOs for
> > brendanhiggins@google.com who tracked down the runtime issue in GCC.
> > To be clear: these are not issues specific to KUnit, but rather to UML.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I'm very happy with this now: all my issues with the previous versions
> are addressed. I'm particularly excited to have code coverage
> documented somewhere.

I just realized I forgot to commit the updated wording you requested
wrt uml_abort() in the patch itself.
Sending a v4 now.

>
> Assuming Brendan's happy with the TODOs being there, I think this is
> ready to go.
>
> I also built this with Sphinx and gave it a quick look, and it all
> looks good there as well.
>
> Therefore, this is:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
