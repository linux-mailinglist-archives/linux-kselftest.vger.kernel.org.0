Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5122B5551
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 00:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKPXnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 18:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKPXnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 18:43:41 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58778C0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 15:43:41 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so22191429ljf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Nov 2020 15:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW+0XZhte9icnMhLFasxijbbn2qgUsoEEZqRZSfWHnQ=;
        b=P4+Yfq4KZhKzMA3z3G5uqBTu8TWDjzQHsVSDz0iPdvVRRqKRzlsgtDSFtZs91FqeDD
         k9UvENPUY5qeY2d9Opg2n8EVSaMxkOaqIAiBig2mjK6CQzYohWskFzV9Aiza/7vyBTcy
         pwVhMlWJXyvQiHtZz7WOjOU+YXc7iUKD+dS+td6nPUYjGR+MlXDCEhBCxzOZ08Z8c+dq
         cAe2Lta0qSRIjfCa1Tv6jD9JY1B3x9VzgByor8j3kCXfPetKBwo7heLGiyq930rC3K0c
         Of/NHVxvd7bMh3jc57GUJj0cCSrgVvjvke/LTFwQmkLZLG8QcOXBDbu9tOwS0ZVjAjRy
         RvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW+0XZhte9icnMhLFasxijbbn2qgUsoEEZqRZSfWHnQ=;
        b=KItb9RrvNhNzFOi/nYTphQm6bNNx2M1yxp9IoslRn3zhTF5Yg5FFOmT/ZQ2ZJmduCX
         xTn3GAOIfCOZh0bGpj07YwEPhImdrsUVO3TuwAwkNafvr+SjVTPzsjWUf0i3XXPoOObc
         zGAu8nQW04e8YUCq/u+XSJ3oYFTU90uAuXgrwTzNlXPSH24HqZbQhCcyQ0RtODkCcmdu
         jOcPivQGeHaB9ycCAZUcdMkRTEqaaVKcYbLcTTdaLX5Qk4ml2BTvEc3xrtwOqBn4qrS3
         xYNdmBQmZ8wWGHtvV6bTRJ/JFUNWeccPMAe/Bg+sRvOp1riSkmZ6vA/Mb0Zy1ApZMGLZ
         9tGg==
X-Gm-Message-State: AOAM531KyhClNvjwUcqUupZQkD+CN6+Ptho46j15CoK1u1EtD9QQ5l06
        tCOtkGsc+Jtp0gamSkD07TQjpZJ9Y+1pefbNjLawhg==
X-Google-Smtp-Source: ABdhPJwt/DF5Nq8FjJnZlS9ljoZ3JmEmdc3njRhP3Y3IRCsZ7Gqd5PXm4ybvasa7Zxb6sCzOdyd/POP13Or7ZhjyOHU=
X-Received: by 2002:a2e:8504:: with SMTP id j4mr627919lji.169.1605570219582;
 Mon, 16 Nov 2020 15:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
 <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
 <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
 <20201116095309.GR4077@smile.fi.intel.com> <20201116104131.GV4077@smile.fi.intel.com>
In-Reply-To: <20201116104131.GV4077@smile.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Nov 2020 07:43:28 +0800
Message-ID: <CABVgOS=2qKw6OBSWMnAMf5un3akkoWej=98zTd=e1dgpqnGTGQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] lib/cmdline_kunit: Add a new test suite for
 cmdline API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 6:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 16, 2020 at 11:53:09AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 12, 2020 at 07:10:25PM -0800, Andrew Morton wrote:
> > > On Thu, 12 Nov 2020 20:07:32 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > Test get_option() for a starter which is provided by cmdline.c.
> > > >
> > > > ...
> > > >
> > > >  lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
> >
> > First of all, thanks for taking care of this!
> >
> > > The spectacular warning storm which this produces makes me wonder if
> > > you sent the correct version?  I mean, the cmdline_test_values[]
> > > definition wasn't even close.
> >
> > This now puzzles me, what happened. I will check my branches, because certainly
> > I was not only compiled that, but actually run those test cases.
>
> David, Brendan, can we somehow make those warnings visible when run test suite
> via kunit Python wrapper?

There's a patch in the kunit-fixes branch which should fix this this:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=390881448b1ff1e9d82896abbbda7cdb8e0be27c

>
> It seems to me that I run test cases only via wrapper and I have got no
> warnings which are ones that must be fixed before submission. It's actual
> disadvantage of the framework (use of it via wrapper) that makes me feel
> like I would rather not hurry up with KUnit.

Yeah: it's a pain, and I've been hit by it a couple of times recently,
too. If you're not able to pick up the changes in the kunit-fixes
branch above, then it's definitely best to also manually build a
kernel to get the build logs.

In any case, that fix should be merged for 5.10.

Sorry for the inconvenience!
-- David
