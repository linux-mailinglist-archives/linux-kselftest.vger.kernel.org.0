Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800D929FD03
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 06:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJ3FY6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 01:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3FY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 01:24:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56478C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 22:24:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so5443170ilh.11
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmMwQ8b55cUdayZvKYDJthFQ/LoSw2w1EcxeNL4OYcs=;
        b=iwQyLSzpHg/fSGBBOvHQ7AebPJ9cDXSz+3APoggXro3e6RqW4lYDdtPUX1+GdogWT4
         CEykeB0V7LaWqNniBdK88FmznGPeU+StD/zmUZvvMsElTYWk2ojvE8tpWtbnuWp3KwFh
         WnSHs7JhQtUd8M0QaBdcVH46YAClF5UicuuhHZyOpXQeE57YAReA7AkurXCcYzNSvde0
         tP5trblzCjLMuzwtBD0h8ZKF3fiy8HLtwvaEygGWbDGgfg9+nHaOTCWcUjjy914wSojY
         5RYFPPLGDm+naHOBBUJ11PFN8w1SjoF/fH339AulsgVX2ige4kyzAVJr0hWVtCQ6aeBa
         n+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmMwQ8b55cUdayZvKYDJthFQ/LoSw2w1EcxeNL4OYcs=;
        b=AJn3UjI6Lf3a3QIwkRdODxlAYj5EeHI3V9ZrLn55r0+/pdMFT10N1lYQGCKgHbVLGU
         w9M7ZZ+WzH5PoJKkt8tTJFWNavYxnse2iYoYlxwQhbpGuBtbcdNo8rQsq8qBgUmcM6LW
         g48KjqPxGEhjOGwaUk1zASB94VlNi9XHMpnMcx4oNsnR9UYM7H35xzDT279zvX1ZGTWj
         jqw1sVJl/OBQrn14CNm6hNGCi3aWz2iuKq6Yu5TSVXQs+VKXkLPfc2q2eqO5r7wAMAeI
         9eMnAAQQOhJRnmErbBIu6KHY0zpFAS1svCHrk9Ull3tNlC+MMgSM6XnkGrMgTywGlQBG
         G6Eg==
X-Gm-Message-State: AOAM533nxnCk+IoEkWA7kJWCmZv5JwxAExTK2Fen69xN8MPRRVztovNQ
        c1gG1c06V7wM1YPnTD77Maj3tpPdhjXVjutRsgzgmw==
X-Google-Smtp-Source: ABdhPJzaanR4CgFbc03oJFpky18iVumfvVzkCYtCPFtLD3bf0c6h3u0Ous9bPnH+4HImwAZMVkk1jULVCOGyQIJw7AA=
X-Received: by 2002:a05:6e02:1310:: with SMTP id g16mr684884ilr.110.1604035497455;
 Thu, 29 Oct 2020 22:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201021220752.418832-1-dlatypov@google.com> <CABVgOSkXfWihPN5-1dPn2BstpJ7eiG1Qj=cg5EL2oEhv=YHj4g@mail.gmail.com>
In-Reply-To: <CABVgOSkXfWihPN5-1dPn2BstpJ7eiG1Qj=cg5EL2oEhv=YHj4g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 29 Oct 2020 22:24:46 -0700
Message-ID: <CAGS_qxrUkCaG6D+Kj-x2NjSdc-_KMg29-ncD3kqyBqgN8LR6Jg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix pre-existing python type annotation errors
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

On Thu, Oct 29, 2020 at 7:56 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 6:08 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The code uses annotations, but they aren't accurate.
> > Note that type checking in python is a separate process, running
> > `kunit.py run` will not check and complain about invalid types at
> > runtime.
> >
> > Fix pre-existing issues found by running a type checker
> > $ mypy *.py
> >
> > All but one of these were returning `None` without denoting this
> > properly (via `Optional[Type]`).
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I'm not going to pretend to really understand python annotations
> completely, but this all seems correct from what I know of the code,
> and I was able to install mypy and verify the issues were fixed.
>
> Clearly, if we're going to have type annotations here, we should be
> verifying the code against them. Is there a way we could get python
> itself to verify this code when the script runs, rather than have to
> use mypy as a tool to verify it separately? Otherwise, maybe we can

Type annotations are https://www.python.org/dev/peps/pep-0484/
There isn't support for python itself to type check and it calls out
(only) mypy by name as a type-checker.

I don't have a good answer for how we prevent them from bitrotting :/

> run it automatically from the kunit_tool_test.py unit tests or
> something similar?

I don't think it's possible to do so cleanly.

E.g. I don't know python that well, but here's my guess at what it'd
have to look like:
* We have to assume mypy is installed
* dynamically loading the module inside a `try` (so we don't break
users who don't have it)
* figure out what func is the entry point to mypy and call it on
"./kunit.py" somehow

>
> Regardless, this is
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
