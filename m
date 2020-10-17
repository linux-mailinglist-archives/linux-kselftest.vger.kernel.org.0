Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA6291046
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Oct 2020 08:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437265AbgJQG5h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Oct 2020 02:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437264AbgJQG5h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Oct 2020 02:57:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143AC061755
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 23:57:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b127so6926257wmb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 23:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnRU43BTptDRpIN8bvzam0YMojPLO4NiHc+r7XArR04=;
        b=H5D4RxAlQsRoXCM2xfoypQOCiQx1qvAHT+XC3aF/qh3tsjyx7uqnMi755LqLk8DgXr
         SIabfAwASrF/I/FKPrKOOBhsaZ4VJvbnxIs1xKongAXVC4nxVkQupmW3VSWoQeEST6BQ
         TVo8uBT9NO3k2O+AxrFv8D1Z4MNqaJ9f5UAolcchTfFAyzLwCppF24263vlZrUlvNC5s
         0I3qImCw9dweoPcjH4/fxLu0oMBjzjhwuocGBk9kDPlr3OT8wbd4JMK3A0BjqL2IeYPh
         IpcNuUTGx8fVUJomIY5gQY+ynWMgMMUNp2pKgKtX9gqmObwDjjHmXOGdRirw9LjlkXD3
         3etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnRU43BTptDRpIN8bvzam0YMojPLO4NiHc+r7XArR04=;
        b=m+2+zlspTnLAuPr24BZFfj98VAf6wuQj1c/OtDkujAmHR8CIACIhPZCyRZT19PxnJ6
         kU7VynK4IyEPLOC93WCw682MvuQftjjmz/CgcBMxciIz3f/b/BPcwpFOBU68IpYDZVpm
         6idJmgEJhLiZ7ZmH9/dTJ6Ibtc4DDyYO9CNJYebif92jQoSvvzvuFC1JoRLo0qbJlf12
         +Ilw51NOA3GEDxW//mWEctT6xDAZR2ipamPif9yN2XI2oajIe7GVDfQJv/s8MhmL5uS4
         9QLFi0jIoZUL0YtsyJd+FnOA/rc0f/Sit7bd62k08SEQONH3fgUY1mjB+4V17i48F4jy
         DmaA==
X-Gm-Message-State: AOAM532JZ3c/y+6DhSOs5MTg55MQpL5As/Uo6G4O9IK0OEA09yQTm1LF
        J8+UImxX8Uu5I2CtBVpTSSpIKq9chR4jT16qsVhf+A==
X-Google-Smtp-Source: ABdhPJxUlJAQQlXN8mOkRfSZeYe7seZYBGnHZRdLm9NNejRQwtpcLtx4TqAzDwEfA+ZPW3TO57YnS79H23KzoZqCqgA=
X-Received: by 2002:a1c:4904:: with SMTP id w4mr6809449wma.99.1602917854481;
 Fri, 16 Oct 2020 23:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
 <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
 <CABVgOSkA2mTpH7nXnL21zrAyi38xW_K=YnD85995u0+MLoDt5Q@mail.gmail.com> <20201016092956.GI4077@smile.fi.intel.com>
In-Reply-To: <20201016092956.GI4077@smile.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 17 Oct 2020 14:57:23 +0800
Message-ID: <CABVgOSkF43AfEPQHpNK5cHy4jcXpPJ8cRyCXJosOcc_w7q+1vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 16, 2020 at 01:02:20PM +0800, David Gow wrote:
> > On Fri, Oct 16, 2020 at 2:44 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Follow new file name convention for the KUnit tests.
> > > Since we have lib/*test*.c in a few variations,
> > > use 'kunit' suffix to distinguish usual test cases
> > > with KUnit-based ones.
> > >
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Thanks. This looks good to me from an "I tested it and it worked" and
> > a "matches the naming guidelines" point of view.
> >
> > (Since the naming documentation isn't actually in Linus' branch yet,
> > I'll drop a link to it here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/style.rst?h=kunit
> > )
> >
> > I'm not the test author though, and the naming doc does explicitly
> > leave the possibility of keeping the old filenames for tests if
> > there's a particularly good reason to (e.g., a lot depending on the
> > module name).
>
> Can you point out to this? Briefly looking into I haven't found that.

This was what was intended by the first "exemption" listed[1] at the
beginning of the document:
"It's recommended that you only deviate from these guidelines when:
[...] Porting tests to KUnit which are already known with an existing
name"

Admittedly, this test was originally a KUnit test, rather than a port
of another test, so the exact wording probably doesn't apply here, but
that's more an artefact of the naming guidelines landing after this
test did.

The goal here is really just to make sure that existing test modules
can be ported to KUnit without breaking existing users which may
depend on the name. It doesn't look like that applies for this test,
though.

Cheers,
-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/style.rst?h=kunit#n13
