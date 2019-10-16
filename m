Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82312D9BEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbfJPUsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 16:48:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfJPUsp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 16:48:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so129677pfb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYN7JdwSAE7xHzfhopvvAQjdWh/Lx0v9lAUmGnJ0U1A=;
        b=P5dHrRuDil3iEngAsHPxvi7wPnXTBVbAKDphzKs+M9AZWEGI5ynkR9mKkQuLOMdM/k
         Q+QyZbfTgoAeHyWXBRG0hq/B18WnurwtIETFwXPagudINItfLFP5YZBuZk1RRYJ+K08j
         u5BSYVcQb7HcAewSUaAnCMAv9xUw6sJYVmDPgcFxltqeA/n1DkAEF/dh8/GUhI4Oop6U
         cYIDoQuzxiShYw8bHKyQcZ3V326qmXQq7VM3V1ICt7VQIqz6JtU9sp5Do1Xfwh0X4Z3/
         ZQze6T1VnxdRcdz1jWS2Bj9LJFcg74up8LnbChXBEwT9nK2fmR+WaU8IGXF+wYXs6oqz
         pEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYN7JdwSAE7xHzfhopvvAQjdWh/Lx0v9lAUmGnJ0U1A=;
        b=d4Ws1JrmUtcfO4zpFdRGo2COVqH9Qk6ViOcvW0GJpEXhh8uTKSFXvPyy/gP9apqcOF
         qx9FeZ2av3Hncyn0UhghXQYJiMg050SbQjRZKXCYZTiXjcMPlCy58Bc7vIbkjl9m0vbo
         pcIQgnMQwvWgsVD4ZtydvjGET/PLGDYE0/XbVRV4XzLtfZWWwk9uI5y0fxXxa0swRken
         cH3XIy+vf/2C+D7GcnFEzaU4XDq1wo21TYgedRlcCDseb4XOoeWhHVOOxkK76qZcAvM9
         zBFXMfAFpEKcTpEYMI2TGBLzV7bsKhmXFE+BmF7mg6O1roPpR8f2zWkYEkjMvdSUJiyJ
         XDIw==
X-Gm-Message-State: APjAAAXtF4/50cRRt8rzv8nqvUEmEydxo05x98/UM+9hyQYbvLLzuR9p
        SST1DEKThkZS3SZzXmiIrgUpAB+vdkxrH5C3IaaZbg==
X-Google-Smtp-Source: APXvYqwEyDaRLVpiAaixXq0Yn5GYXEushNQETJprRuecNWkYQysHPXYClGXXGmgv1luDfirwbBvejTJl5+GqGtbIH44=
X-Received: by 2002:a65:6091:: with SMTP id t17mr81764pgu.159.1571258924311;
 Wed, 16 Oct 2019 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191010185631.26541-1-davidgow@google.com> <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
 <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com> <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
In-Reply-To: <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 13:48:33 -0700
Message-ID: <CAFd5g46tNs=E5+_H4H9_aSwPJ7XVbCLTUSH6JYmmFK3QxW6Vdg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for the
 'list' doubly linked list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 11 Oct 2019 14:37:25 -0700 David Gow <davidgow@google.com> wrote:
>
> > On Fri, Oct 11, 2019 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > <looks at kunit>
> > >
> > > Given that everything runs at late_initcall time, shouldn't everything
> > > be __init, __initdata etc so all the code and data doesn't hang around
> > > for ever?
> > >
> >
> > That's an interesting point. We haven't done this for KUnit tests to
> > date, and there is certainly a possibility down the line that we may
> > want to be able to run these tests in other circumstances. (There's
> > some work being done to allow KUnit and KUnit tests to be built as
> > modules here: https://lkml.org/lkml/2019/10/8/628 for example.) Maybe
> > it'd be worth having macros which wrap __init/__initdata etc as a way
> > of futureproofing tests against such a change?
> >
> > Either way, I suspect this is something that should probably be
> > considered for KUnit as a whole, rather than on a test-by-test basis.
>
> Sure, a new set of macros for this makes sense.  Can be retrofitted any
> time.
>
> There might be a way of loading all of list_test.o into a discardable
> section at link time instead of sprinkling annotation all over the .c
> code.

I created a bug to track this here:
https://bugzilla.kernel.org/show_bug.cgi?id=205217
