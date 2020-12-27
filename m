Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE92E329F
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Dec 2020 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgL0T7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Dec 2020 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgL0T7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Dec 2020 14:59:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F35C061794
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Dec 2020 11:58:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so4695577plx.0
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Dec 2020 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW/iYK2VcE81PLeUXP3kHrt+P7vbEZ9B8Q/7YMGr9lw=;
        b=ukf1Cu8bYsW4fPUzCkURd04IN/uZMD7q4qHTi5qNnddkqRAnNZ5xFd+D/gPynfKR/A
         aZKhNwapqTpbRmt2v8uPA9ZIHxhgRYVxXOWhj5fADc/wAnLOVNzkHlUMKj4smWyrIxuS
         Psla4+ZenSDx+1sg4ZMCzOwtX+inSjF3FBjs8dU1X2HUP91gKM2Exzrlf+rLYqmhUQCm
         iobjVloS70jirh1S54W4KQMjYpWfGttV9gWn3/ULsJ6OcNRKmFNFY2WEJPU2VYUP9jZd
         mReYP5cYqlZ1k1CsqnsetIMIP2+h0O3NFd6yx7lZO2zUDBW9FqFzZ93zvD6i/CDc+Bzu
         VFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW/iYK2VcE81PLeUXP3kHrt+P7vbEZ9B8Q/7YMGr9lw=;
        b=ge9iE2m59Cko2K7LW0KsV7c/PY4RoPwdzYHMTGl+ehiC4ymC+GvqqXLM/vftW9ZTtR
         JQ23o8J9M6FL/S02EBtRmYCWPrj8a8qrWt3gSUo0nueEYGLBLAGoI6G26kyjW/1FXYZK
         QYCbEUVkuXeoaf8UvPLSem/i8//Po4qBLj03AaaWRgHdB5hs956KgSOC8wBsMXybyMF3
         jlwAoc6XlFEXaPW99iZhZxlibSRyXPqruJB28CCTar6aL3DqgnY8vNGNTbO3PyggVJWH
         StTtCvnD+eusx7A6wPOyHYe7Ud4yGSpf3AiNqJoFMgktIxirXK5sNePaY8y550Km4gCi
         07tg==
X-Gm-Message-State: AOAM531TQHhySTMrD0PCLixP7cx+snxivPhttchWutX4gtcx9tTnFT8p
        1QcSSvCnKOUYu/XrHG3OYUFl4riWAY7ViCouIH+QnA==
X-Google-Smtp-Source: ABdhPJzY7CS5ZVAb10no9hYvOU94FrqYjQmSQbpIsyaqBojvCTcqkR8TjeO1D3FZg7rHHMNEHkht7mbCJx90VjsBpNo=
X-Received: by 2002:a17:90a:6383:: with SMTP id f3mr17425269pjj.80.1609099109283;
 Sun, 27 Dec 2020 11:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20201221144302.GR4077@smile.fi.intel.com> <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com> <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com> <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com> <20201222133446.GG4077@smile.fi.intel.com>
In-Reply-To: <20201222133446.GG4077@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sun, 27 Dec 2020 11:58:18 -0800
Message-ID: <CAFd5g46UTq2MwzwCZB53ZyA3BuYV=PMcWfj-CtNn75SQZ0yheg@mail.gmail.com>
Subject: Re: kunit stopped working
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-um <linux-um@lists.infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 22, 2020 at 5:33 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 22, 2020 at 03:26:24PM +0800, David Gow wrote:
> > On Tue, Dec 22, 2020 at 9:43 AM David Gow <davidgow@google.com> wrote:
> > > On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
>
> ...
>
> > > > Guys, revert helps. I am open to test any solution you may propose, thanks!
>
> ...
>
> > I'll send this out properly as a patch to kunit_tool: while I still
> > think that the default console on UML shouldn't change, it probably
> > makes sense for KUnit to not rely on the default.
>
> Thanks for fast response. I have tested and answered to the patch.

Sorry all, I was and still am on vacation.

Looks like this was taken care of, nevertheless, I will make sure to
go and ACK David's fix.
