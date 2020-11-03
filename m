Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299612A44C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgKCMFf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgKCMFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 07:05:35 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA1C0613D1;
        Tue,  3 Nov 2020 04:05:35 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a200so13990772pfa.10;
        Tue, 03 Nov 2020 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoUtQrJSQRYVKiicQfT9b8FMAZeeb+zxod1LbaNVVzE=;
        b=WM+YtojMtExY2bSx1rZgI2jNzAxVBzt+gQy5d6FlFB2ZQ2+tYra7w3xUImdiB+4aCf
         74xlNxvl1zafd+USLWhF854/j/ZmXaeNwS2v68wzLERsUozQD9eavP6APlj9hD/95GCf
         e5WhrwGzr9L0hAv7c8dBT4ZJAZ1AZkXA0byYWy7vGhF6pkyEQBvC0gk7Zya6rn5Gitmx
         0QouET8V/OMgrTYTGYgfO4eYvYyRBauKwGxZuULll1gOABkJJO547wTYFsrCF8wTZsl+
         7T0XRiHLRwTWQbA9BYv4YkX+abx1uCKY4dleuVBYPVruBvQi1tKqVeKpHfCUPUfRPq0L
         VEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoUtQrJSQRYVKiicQfT9b8FMAZeeb+zxod1LbaNVVzE=;
        b=Hi67p+bKa0um10GaSYgG5EcnVgkZ+4e6tctuxMVNfGR59+whH+K+P5cP2f+zpbffgj
         lU6aRz4HCFBiSU/0ib8ks3hEbsXV7xgL8pTMQ87ljNbwRe7BDDcidNtYJGWJGTJnKICX
         q9p+sJpIayVjcNltNicpfxg81jrZfTvWtNiQqwdo4FJuyerjeKyj30dutjYbSw26t9vF
         3M93rYr/IXtA6MxBjcDFTNtdv5HhBjVYU2jXQ67Ew69vw7zd8RY26ZX+3Bc1dh9CwMKy
         FLr1gbcyZkrCNF0OciK6XDQxg7tFTdIYzF6Ek9hlnslG6tJGRAHBFkU42Rw2JeY3+VMe
         QSxw==
X-Gm-Message-State: AOAM530AOW4WsMtEMXAnw/JJ3uY+kxa+teOAOBqy3/r1YWbh+Ub5y5sn
        o30yoWYHTY53uNMHmPNkrkemim+utMq2Mp4n/+k=
X-Google-Smtp-Source: ABdhPJxUO60AuqbTEpZJUSjqUhnIPjXMPgP8GNKeKA0lClIJQEIZVlsw/a1hRyj6/h1KU1n4Q3C6NkqxI7vqhDJ0z/0=
X-Received: by 2002:a05:6a00:850:b029:18a:a8ce:d346 with SMTP id
 q16-20020a056a000850b029018aa8ced346mr16078623pfk.73.1604405134945; Tue, 03
 Nov 2020 04:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20201103111049.51916-1-98.arpi@gmail.com> <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com>
In-Reply-To: <20201103115223.GA268796@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Nov 2020 14:06:23 +0200
Message-ID: <CAHp75Vcw8Hyaks9ZbRfz7HhBzPM2cJxR4ypye5PwcZqY9rsYhA@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 3, 2020 at 1:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 03, 2020 at 01:33:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:

...

> > Better, indeed.
> >
> > But can be this improved to have a cumulative statistics, like showing only
> > number of total, succeeded, failed with details of the latter ones?
>
> Is that the proper test output format?  We have a standard...

I dunno. I'm asking...
We have few possibilities here: a) let it go like above, b) use the
cumulative statistics, c) if there is no such available, implement and
use it, d) ...

-- 
With Best Regards,
Andy Shevchenko
