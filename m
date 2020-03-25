Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4B192E49
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYQeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 12:34:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgCYQeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 12:34:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so1002740plm.4
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/mwcS2k49Q8FtkpWy9oWS3FImYCLq2+zg7rNJhSOZg=;
        b=cCxSv0lUkGe2EkApXp9qAszTvolABAR+7z9AuUMmHhvDbeRZpWR6Q0bYuAPqFUF6Zp
         jAqjCTAjkGIbSmWBIMSVXhJN66nTO6w4p8bJGqbMGN0RHan4V/rN4nSpCoCZW/+IZ6Lb
         BapU1uUUBkAzcg6RjyW9DQk9sAa9zz9BVA+3jFW4plA85kvU4GJN2702eW4e7McqWvGD
         vqNc4jpN6Islq1dfjZ+sI3gFRBxhl9R7Wxh+vHtiJsDfeEADMZK5MKd2zrcYY7mHxonR
         FLL/P9nRwVdwkoJlihPemv1VYENWVfU4m5DOYZYY4ZipQAOx0dPlpJrEcWA7pK8BdsOj
         UcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/mwcS2k49Q8FtkpWy9oWS3FImYCLq2+zg7rNJhSOZg=;
        b=tG0Kn2OxktKSGXa4ajX359vpwS/9RgTA4ZOMGr8MPUpPwQZWpSqvg1HcH27FUwFZeH
         WfcQJCF5qdXEY40fVYvfEA32shaXWaakWPABPpIbTsLAwAnb0oFbpGIgHd1RuuAquhlz
         Ba6CJmvuLPbcBcnmanPl83SMfFk83cOWbyqjc4sL2+HnPHFjhl2vj+QaDhr9ukU4vwIP
         GIpDavz5LW7aeRaPXDF26n9OIsBscjlCajFh8NNLEexb1fKBPt0ygTgwpbPTYlzH2omn
         Rrlcr4dSYUHtwZbrjVGRwMP5N0MV7d59HE9qrFJktaNSvlJpdS+CGABCNgQVIX8hTvwf
         dTMA==
X-Gm-Message-State: ANhLgQ34RbtLvr/wiyMAEr+WmKL/mmnrV4PvcTaTs7BN3mI3qx69xAGC
        Nt/r757jzpqczzCywNYp3hgnD3/QB6HDoyqi3i48Nw==
X-Google-Smtp-Source: ADFU+vtCxCivYqNY8mO/9aWa/cKHkQkKuRGcuG8inKcGrdz+TlM7ovpnPxVq4LLDz6GsobBMJqt1oTu+L8Xs6yWLSDM=
X-Received: by 2002:a17:90a:32c5:: with SMTP id l63mr4814987pjb.47.1585154043671;
 Wed, 25 Mar 2020 09:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191121235058.21653-1-davidgow@google.com> <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
 <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
In-Reply-To: <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 25 Mar 2020 09:33:52 -0700
Message-ID: <CAFd5g44ZNv-BP_t6M1EWQjXbgBYsA0+oBZ_-nTAmZbE4GNWgpQ@mail.gmail.com>
Subject: Re: [PATCH kselftest/test] kunit: Always print actual pointer values
 in asserts
To:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 24, 2020 at 8:33 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 3:44 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 3:51 PM David Gow <davidgow@google.com> wrote:
> > >
> > > KUnit assertions and expectations will print the values being tested. If
> > > these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
> > > pointers are currently printed with the %pK format specifier, which -- to
> > > prevent information leaks which may compromise, e.g., ASLR -- are often
> > > either hashed or replaced with ____ptrval____ or similar, making debugging
> > > tests difficult.
> > >
> > > By replacing %pK with %px as Documentation/core-api/printk-formats.rst
> > > suggests, we disable this security feature for KUnit assertions and
> > > expectations, allowing the actual pointer values to be printed. Given
> > > that KUnit is not intended for use in production kernels, and the
> > > pointers are only printed on failing tests, this seems like a worthwhile
> > > tradeoff.
> >
> > I agree. However, I also remember that others in the past yelled at me
> > for assuming that KUnit would not be built into production kernels.
> >
> > I feel like +Kees Cook would have a good opinion on this (or will at
> > least CC the right people).
> >
>
> I'm tempted to take the silence as a sign that no-one is upset by
> this. Otherwise, consider this a gentle reminder to file any
> objections you may have. :-)
>
> Otherwise, I've confirmed that this still applies cleanly to the
> latest linux-kselftest/kunit branch, so -- assuming there are no
> last-minute objections -- this ought to be ready to go.

Shuah, can you pick this up for 5.7?
