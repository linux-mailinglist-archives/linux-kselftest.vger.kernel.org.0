Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5A352FD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDBTfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhDBTfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:35:13 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F4C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:35:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id c18so1551803iln.7
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBqlmfmBZlgpLqBL3SMy547Si+woT6C4nrftJlSxtCY=;
        b=Y3tiXPLIlb1lzWlsyUDHVY5DWAWMiQp5Txnbbu7BoQamrR1AxQ8fD6q+OwD6rLf79u
         PzXXkyD+oalp0xFMENBsEhqsYV9uhmRm2PbxVZuMy5B4kTWdE+vkaDOYbhltLyGb6HRR
         +3HH7tZYVpM56s1nIucsyDv2u6w1JKb7CUuvRLSIEyY6Ii+mRgQ6QFgP17NGhhSiD8/v
         CCIo93CW7R64xRId3SkW0ubYkMLnJkr/sNFsekJqHW7hepxP+DiSVg2jAU+PNsSAnKl+
         W/7/WFyiQVXRFo7b0FdHanJEr+h8WAvcjb97NmM0eNZkPLV9BIWmUhZGi29QTNQAI3EC
         3c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBqlmfmBZlgpLqBL3SMy547Si+woT6C4nrftJlSxtCY=;
        b=fEIu4+svBDw6iOVhjbVtxlg5SIwdry+0fZLE8kSSK/baQVmDDmC8X0tDb1ig/Rv8Uk
         f4Du+eyLtfRkUV+6SuhgfXGErJiL6kntc9C1xMNCsGarOtmK00kLd5sOMLP9kzt+Xh7v
         xOvErVy8P3TSgDZR4/FnjCGhtt+yDjeE7rrflVMqDVBSUWpHVgXU4orbpk/mMP99Fast
         1YFSxam+u2w1pulXFVKNXcOK/P6v5i+D2/k9vSXqoh+JiMJHYBz5Gyv2pFArMkwHh9sg
         zaHVYsAURpwdGLXL+nzxBWAb2h20cXvKg/f2H+w3fko3ABMpm+fiWbUK61SlXocWKI0T
         tgcQ==
X-Gm-Message-State: AOAM532Kx5ybOGhBp5YTvTUJ4VxMsfUMb6yc4ln+gx0atmEPp7bQNuXV
        V8kcDxybmkTep8wolIX5fQkWehxvbTsOXJ5lmdQ3+A==
X-Google-Smtp-Source: ABdhPJzHqBBDYpgyx1WUONYHlQnPh/L3qvcOipT8l+cgDuynaIlhcoA99kAIy0pHZeEalzvjKi9AoXgX6fHVa8kg6iA=
X-Received: by 2002:a92:c24c:: with SMTP id k12mr11564544ilo.75.1617392110956;
 Fri, 02 Apr 2021 12:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210205221808.1966010-1-dlatypov@google.com> <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
 <9f5df593-6584-b7d4-3b6e-ad77ee6f8760@linuxfoundation.org>
 <CAGS_qxqE9btMn639uCgDoiqO6PNnNJzqyLA4Vj+b6Ccjhpkbfg@mail.gmail.com> <ec95c1b5-7273-9f0b-ad1f-f41e818eaf6f@linuxfoundation.org>
In-Reply-To: <ec95c1b5-7273-9f0b-ad1f-f41e818eaf6f@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Apr 2021 12:34:59 -0700
Message-ID: <CAGS_qxoZ5PyU7pdWB+TEO85JTXptHcXUk6Gc3BYHHOuMpPTEtQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 2, 2021 at 12:19 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/2/21 1:09 PM, Daniel Latypov wrote:
> > On Fri, Apr 2, 2021 at 10:47 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 4/2/21 3:35 AM, Brendan Higgins wrote:
> >>> On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
> >>>>
> >>>> Before:
> >>>>>    Expected str == "world", but
> >>>>>        str == hello
> >>>>>        "world" == world
> >>>>
> >>>> After:
> >>>>>    Expected str == "world", but
> >>>>>        str == "hello"
> >>>> <we don't need to tell the user that "world" == "world">
> >>>>
> >>>> Note: like the literal ellision for integers, this doesn't handle the
> >>>> case of
> >>>>     KUNIT_EXPECT_STREQ(test, "hello", "world")
> >>>> since we don't expect it to realistically happen in checked in tests.
> >>>> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
> >>>>
> >>>> In that case, you'd get:
> >>>>>    Expected "hello" == "world", but
> >>>> <output for next failure>
> >>>>
> >>>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >>>
> >>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >>>
> >>
> >> Hi Daniel,
> >>
> >> Please run checkpatch on your patches in the future. I am seeing
> >> a few checkpatch readability type improvements that can be made.
> >>
> >> Please make changes and send v2 with Brendan's Reviewed-by.
> >
> > Are there some flags you'd like me to pass to checkpatch?
> >
> > $ ./scripts/checkpatch.pl --git HEAD
> > total: 0 errors, 0 warnings, 42 lines checked
> >
>
> My commit script uses --strict which shows readability errors.

Oh neat, TIL.
I'll make sure to use that in the future, thanks!

v2: https://lore.kernel.org/linux-kselftest/20210402193357.819176-1-dlatypov@google.com/

>
> > Commit f66884e8b831 ("kunit: make KUNIT_EXPECT_STREQ() quote values,
> > don't print literals") has no obvious style problems and is ready for
> > submission.
> >
> > I just rebased onto linus/master again since I know checkpatch.pl's
> > default behavior had changed recently, but I didn't see any errors
> > there.
> >
> > I know this commit made some lines go just over 80 characters, so
> > $ ./scripts/checkpatch.pl --max-line-length=80 --git HEAD
> > ...
> > total: 0 errors, 4 warnings, 42 lines checked
> >
>
> Don't worry about line wrap warns. I just ignore them. :)
>
> thanks,
> -- Shuah
>
>
>
