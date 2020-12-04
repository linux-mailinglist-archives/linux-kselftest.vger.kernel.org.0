Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D592CF3A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgLDSJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Dec 2020 13:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387782AbgLDSJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Dec 2020 13:09:12 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA93C061A52
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Dec 2020 10:08:32 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id z14so5994874ilm.10
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Dec 2020 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2y9rMaTERSSbE3OXGqqbUsdHNdPLIzXX1XRh3Jkau1k=;
        b=hkAoZhEqm+cFDrEHKCgOCGlY53/fkNmwKUKLaEWejjjD0Y8jEZ7z1Q6bgfhAoF8kZS
         Pv97SVv4FbUAnZJEGD5CWGEb2f68M0mfQVMsJMHdqMEDfeXQ2ybczOObDNzCqDVjvN6b
         SiAAZ8Eh9WxSenubdHzVl9HKkiwXbC1ZIsiB9Skjs034nuOjLe003uMuWpRdt38chuo1
         hm89QoH2iEUH5hJOEChfzgiXoc1DluQFtdUOo4lto+X9Qf2dlwMKBou18fGmvIo/xBym
         bwrD5yAeAihmeJjlOEmxlPAy7dZGZOmSoA280aHMV5E2amXTB4Ex7vHE6KuWdSgRJcJ1
         I+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2y9rMaTERSSbE3OXGqqbUsdHNdPLIzXX1XRh3Jkau1k=;
        b=rnxpfzbXESc18Yb57DSSQ3HblmlYVLspLc4ik1nYe20KzMM8bFY+v+vWvvqE+8FBG/
         eVf/L2fuj8SuoJtwYwamszN4SnlnPoW3EHaojcqp0bD8WIwfafTJ4RKjR2tyaFrXnH/s
         7Krfqws77i6SkvhJyA2iVKNGtZlhkg6NOz+0L1MdaSJb293MZBYwXV5cCZX3qBMCUFYW
         JFzZkXoDFvE+CwlRUpmfEBkwrk4YZ1rJxokOO4ZUESgLLKw1WsE6ZrEbFsXkfOFeDGTr
         ZaKJitg6RvPangBkhnEDpeDN+IiRozIY9T+B/tzW8i5v2waSr8Obv4ZdGzsreT07A1KE
         cazg==
X-Gm-Message-State: AOAM532n8hxRDPhBcK0uaKmI7wukMne6yYBmFJjYvtzwUbJQ8f4ae05C
        jGFHwbVDHBqqOMUqeeK10qOVgiDHNNq3ufMA99pixg==
X-Google-Smtp-Source: ABdhPJylHSF7vRowIeU00yP3tAwRQyuVs+VtC98SOYyu6nFDRYQ8VOjPM2UExmg/FfGAhMaZDd8PWNF4kX06ZoQI7w0=
X-Received: by 2002:a92:bf09:: with SMTP id z9mr7828239ilh.194.1607105311699;
 Fri, 04 Dec 2020 10:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com> <20201203194127.1813731-2-dlatypov@google.com>
 <CABVgOSnhcMB-xggP5u-p8UgtCR_roiqPuUUZC6nY1_48opf+Sw@mail.gmail.com>
In-Reply-To: <CABVgOSnhcMB-xggP5u-p8UgtCR_roiqPuUUZC6nY1_48opf+Sw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 4 Dec 2020 10:08:20 -0800
Message-ID: <CAGS_qxqTJRuB05GzzezCimyN-SnwC8VtwjSLCuLzQuf5g=iY4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: fix minor typing issue with None status
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

On Thu, Dec 3, 2020 at 8:17 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
>
> This seems good to me, but I have a few questions, particularly around
> the description.
>
> > The code to handle aggregating statuses didn't check that the status
> > actually got set.
>
> I don't understand what you mean here. Does this refer to
> Test{Case,Suite}::status potentially being None, and that not being
> supported properly in bubble_up_{suite_,test_case_,}errors(), or
> something else? Either way, I can't see any additional code to "check"
> that the status has been set. As far as I can tell everything except
> the default to SUCCESS is a no-op, or am I missing something?

mypy (rightly) sees the type is TestStatus or None and complains we
don't bother handling None, so we risk a crash in the tool.
The status will be none until we explicitly assign a value to it
later, which we always do currently, afaict.

This change just avoids that by giving it a default value to make mypy
happy, which shouldn't change behaviour at all right now.

There is no other (potential) behavioural change.

>
> > Default the value to SUCCESS.
>
> I'm a little iffy about defaulting this to success, but I think it's
> okay for now: the skip test support will eventually change this to a
> SKIPPED value.

Sounds good!

>
> >
> > This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
> > fail test suites if one of them is empty").
> >
> > Also slightly simplify the code and add type annotations.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Otherwise, the actual code changes all seem sensible, and it worked
> fine when I tested it, so:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
