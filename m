Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976194A02A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 22:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiA1V1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 16:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbiA1V1Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 16:27:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0EC061714
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 13:27:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r59so7608521pjg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BstT/Nbt3MI2dru2W9T6xWAwyUw0xClca5K9dP8OMlI=;
        b=iBrSApDLmp0ob8yP+f6nZttYwwTgQD6Z6ydFvMo0ZIWknm3IhYzIiDlMRP4PT7Pnsr
         DVNwGnS9VhpW9fAJNzyNpvDgOCk909OhTnDW9oJDeTtpCLpG0cD5T47tDNJlNFR7FWms
         MT7Z/COaK6wwhvAZg+L0jwnP+qXkLGebvPcBxHV6l8uAYyHfyFa/3Jtv/SkBZkoOT2e4
         Zec4M1yLGbWKmb+SNcL/GubTuEVnvk7rkBRjGkirz08RRoTWhbpG4eaIT4PZdDzzg2rA
         MfxZ2B8qi+FpcI1ikwwvdIPA1YOn2XZT3GTkaXrBq7N1lvmOgtH4vYKKIe0BS7lMK3Va
         uS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BstT/Nbt3MI2dru2W9T6xWAwyUw0xClca5K9dP8OMlI=;
        b=7TA1/zIqI9bD/2M8a3x+aeHrNFMdTkVeSUpvwA+3TdEUtcbbDfeAszExfdLh4Caze8
         cWwn9pAd8+1aRnur8oxv964gh4FNGrHssnj0l9g4W9XrIFLcGGQvzonDUn5kQ/Ys6+2A
         csuHULg7BhKF17yoORyuMToPK4TwzLIoE8CP2f98FZsh2I7xvXOBrAZB9XrfZ+3Qvjvx
         7+fSyUqz6pg1t6YWYlAmlbmXbn9nbTNnLONtItxG5sXoRfgyJJLqytIROHgIC4etlFTh
         r2PJ/GxtaBPezVNIVsd38EUt/Ug135ZmeFi/ExYL/706HEimvzaTf2xl9wI0U3Ffm1Q2
         W+7Q==
X-Gm-Message-State: AOAM530WXJjxIaZ3ZnjTZ6WJSWPb37ltO3NjZBQhiORw1B0SSE9/A5Qr
        1BcKGj85DfMFEvkXbJXFUXRKovYL+qsxojCeOGNowQ==
X-Google-Smtp-Source: ABdhPJx7NwvP5XlHjebOh7PFpV+CrZSWAcRC9Nb8gN4ufJz0/29/ZJjy4h4crUGtUR0qUrzyAOADMD0d679g06NRs1Y=
X-Received: by 2002:a17:903:187:: with SMTP id z7mr10311618plg.123.1643405243887;
 Fri, 28 Jan 2022 13:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20211013191320.2490913-1-dlatypov@google.com> <CAFd5g47=aO3e8d4_GGcgY9BK43Z0Oo6SGD-2e5rJDp5r3k4XXQ@mail.gmail.com>
 <CAGS_qxoziNGNVpsUfvUfOReADY0PdriV2gJJ7+LUzzd+7BU-Ow@mail.gmail.com>
 <0f85025124359304c8a2a97d007b66d5655645c1.camel@codeconstruct.com.au> <CAGS_qxpvX74vnAGhC=TAxFy1NT3mXB0S3AHUZvK2FA59hDijxA@mail.gmail.com>
In-Reply-To: <CAGS_qxpvX74vnAGhC=TAxFy1NT3mXB0S3AHUZvK2FA59hDijxA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jan 2022 16:27:12 -0500
Message-ID: <CAFd5g47mYnqyu0DBJmxHjVcdTfc5ig-X6P9wu4bLYw+FhqaYCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in executor
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 4:19 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Oct 13, 2021 at 6:55 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> > Resulting in the .kunit_test_suites section just being a set of
> > contiguous pointers to struct kunit_suite. We get the number of suites
> > from the section size.
>
> <snip>
>
> >
> > That was my thinking, anyway. I think it probably makes sense to do that
> > cleanup after the section patch, as that means we don't need any
> > post-processing on the suites arrays.
>
> To be honest, I'm actually tempted to pay the cost of postprocessing
> and proposing a change like this for real.
> Going from kunit_suite*** to ** shaves off a lot of code from the unit
> test and the filtering code path.
>
> Specifically I'm thinking this can go into the kunit branch,
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
> Then when we have the series reworking modules, one of two things can happen.
> 1. if we get to kunit_suite** with null-terminated arrays, fixing the
> executor just means dropping the post-processing step.
> 2. If we get to kunit_suite* as mentioned above, then there'll be a
> bit more work, but not as much.
>
> Alternatively, I can wait and send you an updated version of this
> patch to include at the start of your series like
> PATCH 1/x: this patch with post-processing, using either * or **
> ...
> PATCH x/x: final rework, and drop the postprocessing
>
> It's just that the prospect of submitting a patch that reduces so much
> code makes me eager to try and get it submitted :)

I agree. Honestly, just changing the type signature from `struct
kunit_suite * const * const *` to `struct kunit_suite * const *` in
the suite_set struct sells me on this. I missed this before, but now
that I am aware of this, I would like to see it go in soon.

> Brendan and David seem ok with paying the bit of runtime overhead for
> post-processing, esp. if we time it so this patch lands in the same

I'm absolutely fine with it. We are nowhere near the point where that
matters at all.

> Linux release as the module rework.
> But I can hold off if it'll make your life more difficult.

Also agree. I am excited to see Jeremy's new module code. I don't want
to make his life any harder than it already is ;-)

> >
> > Cheers,
> >
> >
> > Jeremy
