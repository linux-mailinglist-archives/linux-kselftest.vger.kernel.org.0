Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201949D49F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 22:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiAZVio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 16:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiAZVin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 16:38:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6FC06173B
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 13:38:43 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y27so893906pfa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lD+IeXw2g3SnEFxxFA4tPs2Gg+BBC68wNzC39s+tbCM=;
        b=g0V6+9+eAxLohg+otzC6p3X+pNpL0yR/rmt8gVDtaGXP6CRU88RuMCvIIzAUGX7DPr
         /yOr+771CdzmvistWwFyguhIoaIJH+AC1ufY5Vd1IEjfjpxwRAA08P+kjWBGUF4VsNis
         TVMhLX9wF+TzBkTnFpFIZ0RtPK1qWEhWgfzW2agGJlpBR5cRhuPVRJBQxuaUzN7u6VZh
         qXZl+9wP/xYb4dQYwnySO/CCGuMfBPzijp4KgJXjatUVKkGsEVtrInoswg0MG74iOxxc
         e55fcHJmaEQCiGS0B876dh8n0K2oQYkDCfRSVp2xDsAZmIiaesqmAWcHyqGwZL8tsKI4
         0RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lD+IeXw2g3SnEFxxFA4tPs2Gg+BBC68wNzC39s+tbCM=;
        b=gdtH9qRhWpmS9bAi8BGxDRl7OnsiINMVHtfcwFw8FhIJIKPje6NP2PZEF34EXSrpiA
         UvO8Pi5MtJjhoDXQZ/f/fp+zbp2OEO9vZMb6wlGyYNLcc7TeX+YoYxim70hKnjdu/qxA
         KqdnvCCvFhIi93xsUIn9ci58UiinRg2gKk1wHyPvcI0Lc5WvI4num8gqzppdMqbwGClf
         agxvCk7vG4B/PLwuuf+nkdaaHuBvyk0TgNV6zmcGur0JV1xY+7nV8Lz0frNex1lXHCqb
         gGMGNdGSAqZ0AjkcbDTYVe7M/LWABqiX9HvFTaI1egyHS3rHIGjWglpAf7olvUf9M9sE
         xsxg==
X-Gm-Message-State: AOAM5332s9LMBWk2XBYMxMaa0DlReF5rDB11X206j0dCg5CauAXSIZek
        kyPl7l0U9OmwHt6E2vFx7Spr/KzPG/5EUrKnvwdFrA==
X-Google-Smtp-Source: ABdhPJxhUyY6fvWRkImec6LsPebj7DYp9opvIlGnXwWGuUtCS+f1D8i0ONWseFOnAO+6CvzSBcTgPcZuIPIGIG0g8gE=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr261428pfu.3.1643233122805;
 Wed, 26 Jan 2022 13:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com> <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
In-Reply-To: <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jan 2022 16:38:31 -0500
Message-ID: <CAFd5g44B3aUY1k7n7c9066-McW0Rm=48H4ArUK2VbXB798e=BA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 2:55 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > That being said, I can live with the current solution, but'd ideally
> > > like a comment or something to make the return value Tuple a bit more
> > > obvious.
> >
> > A comment to explain that Tuple == multiple return values from a func?
> > Or something else?
>
> Friendly ping.
> Do we want a comment like this?
>
> # Note: Python uses tuples internally for multiple return values
> def foo() -> Tuple[int, int]
>    return 0, 1

I don't feel that's necessary. I think the use of tuple return types
in Python is fairly common and don't require a comment, but I don't
feel strongly about it either way.

> I can go ahead and add that and send a v2 out.
>
> FYI,  if you do this in a REPL
> >>> a = foo()
> >>> type(a)
> <class 'tuple'>
>
> The syntax for `a, b = foo()` is just using Python's unpacking feature, i.e.
> b, c = (1, 2)
>
> So it's all just syntactic sugar around tuples.
>
> >
> > Also ah, I thought we had more instances of multiple return in kunit.py.
> > Looks like the only other is get_source_tree_ops_from_qemu_config().
> > isolate_ktap_output() technically shows this off as well, but via yields.
> >
> > >
> > > Thoughts?

Personally, I think the change as is.
