Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCE52A0D25
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJ3SMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3SMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 14:12:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F951C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 11:12:23 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q1so7294575ilt.6
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMmkVHvpx+9c4Kcbr1IxBNO0GDjjw4+qKABw3ISg6v4=;
        b=N5gZbgf19kF710L7m95j69NTDI9+S+/kt13dqsXKEGtqdmahszO6q+LxyMf6h0vNgW
         /AYw4tKsShDI3vrPxwnfaD8K7Uwrb7eKS/K6uIDp5XH1ogWWuaDPb/23l2pPjCrSsFn9
         MDHIxBT/lIYsv4BZCiJR1BEWDyDGfpi/nDaTTK7peWScbMM62KSxdPvCHAW0W8YRqmEB
         yMBj3QxFi3n10BOUyGJr0Yfg9MDNaOKB+2pmZpilKinnsVq+/1T6H2FeDyUK90TBMB3C
         zW++2tZdRiwnBJYdnp1j7yvtksHermYsihxmjFpCKXy9sZfcOLb+xzOC8rMobVki575Q
         Lc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMmkVHvpx+9c4Kcbr1IxBNO0GDjjw4+qKABw3ISg6v4=;
        b=YRhP/Zcxp4Rh2JFiP4aEg226AK5U1D7DSJksl96RPFrmJQyJRXm7yhioqxRoYSiUT9
         PWnSFdPu3VD9wimj9R3WKsuKrvKFwJtzZb/t++RN9Qu/UOS/VULCZjjzyKKFOSzfPsia
         rotsoY+DU1613lNiYPqd0zrvmMdqeUecgvNkBrW3wyMwxcBeroKrwq0+aXp46VjJaxsp
         yOpChFJutKX02BzkxAbOhL2Ko1vDcFJ84Fb5qDFdtZLBf6T6O0gnXsazrtZeyxiODn8f
         2TzbRlztb3V3SXrDTmdrY1WSoWr2EbAH6DdEdBN9Is5bsvJoRbfSa0uEk9Ap3QyPJpGD
         WztQ==
X-Gm-Message-State: AOAM530gKKSBo8Dn5xBe+g+UyZzNbvhLRX7YYKUedOFS+DoHWex1Ywq7
        sKzFiObkoB7epiKEZd7lK7D0XS1jntrkUWjHOUjpTw==
X-Google-Smtp-Source: ABdhPJz3s35TYiyIyaR/Sj8G36G1w0m+9fA+LMFiGCfrE81FXWx7wZAKort7SOId47vTRR1GdgofSZXFpFye4lMiv4U=
X-Received: by 2002:a92:cd0e:: with SMTP id z14mr2732005iln.135.1604081542237;
 Fri, 30 Oct 2020 11:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030061655.162839-1-dlatypov@google.com> <CABVgOSkn1n-N50YZr7aNTgAGxkj7zkZO31B16Ji88OxM8m2WPQ@mail.gmail.com>
In-Reply-To: <CABVgOSkn1n-N50YZr7aNTgAGxkj7zkZO31B16Ji88OxM8m2WPQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 30 Oct 2020 11:12:11 -0700
Message-ID: <CAGS_qxpr1XiqcGPcfxnsAuxqnyJ0K+0UF-q146oQjsQqyHbm9g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --raw_output to actually show output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 30, 2020 at 12:23 AM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 2:17 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently --raw_output means nothing gets shown.
> > Why?
> > Because `raw_output()` has a `yield` and therefore is a generator, which
> > means it only executes when you ask it for a value.
> >
> > Given no one actually is using it as a generator (checked via the added
> > type annotation), drop the yield so we actually print the output.
> >
> > Also strip off the trailing \n (and any other whitespace) to avoid
> >   [<601d6d3a>] ? printk+0x0/0x9b
> >
> >   [<601e5058>] ? kernel_init+0x23/0x14b
> >
> >   [<600170d2>] ? new_thread_handler+0x82/0xc0
> > making the output unreadable.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> The bug where --raw_output doesn't show anything is already fixed[1],
> but it does still show the extra newlines.

I'm not sure how I missed that, sorry for the noise.

>
> Maybe it's worth making just the newline fix, and rolling it into the
> other patch[2] handling newlines?

Sounds good.

>
> Cheers,
> -- David
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=3023d8ff3fc60e5d32dc1d05f99ad6ffa12b0033
> [2]: https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/
