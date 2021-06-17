Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEF3AADD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhFQHmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQHmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 03:42:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F01C061574;
        Thu, 17 Jun 2021 00:39:46 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j62so2173287qke.10;
        Thu, 17 Jun 2021 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=ED2e7Wgol5pRGJlXkx0YLNBo6OPWV74DLlbsM0kwoRE=;
        b=tIjQxXZKcQpI+3A7PE8/2BctELfZdYi+TsZ7DiAtYr9AQVBJFXdj1hlRTKlj+cV+Cu
         uLErhf7rbzXCGFeCsyu1eVtUebHvQJntOzGJHUyIzGgkzS3TPYSV7vDfGEWf+vu9n2sJ
         I0UwTeYmYWTWvvlLjvkriAP4YMqF8gbae4PMeFGPPk1B3RlgyKhvjoCewNhFwXHWXVUR
         On30GIb5Adqxkw9K0noWztie7q257TQax7/mu8PDWVI6c350JQFiAT9H4IMESMTcd7Gr
         JB7TfIsZm3GJLKvrw4jcX1wZ6yKBQQTPSqsFUz5+MWG8CpYnOdUJxGYSugRCvnrXZBIS
         IOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=ED2e7Wgol5pRGJlXkx0YLNBo6OPWV74DLlbsM0kwoRE=;
        b=UqXzA4qhMipIFg6nD4YQvAuwllWAp637nSr8V7bO5hTfuxUcKTpBIoT61UEuYjnf7f
         4Z2lQ+Lm6tkR/19hLjhE8hWMnJbgfr5yggwIs1RufrKTvU6dor7og4Hlh8vmfay3eCij
         ckLTwVD/jaba7GuIT9dvILfM76ocOjZ+u3Dq4Fpo2Yj8kcSDrel5Az0OV+larAblG5O2
         kQmqWJtjN8r1a/fqJbIhzMJLicwROYHw55x4aNiKmtVMDhQ4YT95ld/tu+iRoq4lTYtW
         QxdmUMjf6A8BtHwCK9F81xipYcdlUEUEObp/N2oZCl54ShlBpyHnJ5UaGD6/fnLF+G1Q
         dGfg==
X-Gm-Message-State: AOAM533FARqY+oe31JiJWKDjm5pygqXwCAKEtQK4AUJRZFPu16ZOg00h
        5j529TiSIJIFFMGptZ6y6d8=
X-Google-Smtp-Source: ABdhPJxUBdHMvAlK101DOEVIKZnbdV1KBtEJ1OZvmk6KlIUL4dLFidBEceCj820krwupxVYeRTcZ6w==
X-Received: by 2002:a37:684c:: with SMTP id d73mr2372805qkc.35.1623915585608;
        Thu, 17 Jun 2021 00:39:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id y195sm1234580qkb.69.2021.06.17.00.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:39:44 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] kunit: tool: Assert version requirement
Date:   Thu, 17 Jun 2021 07:39:37 +0000
Message-Id: <20210617073937.16281-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGS_qxo4L+Z=Z4ZRQ+z6BP2A6v2two5WyjMmLfTE0a=e0y1OAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Daniel,

On Wed, 16 Jun 2021 14:14:40 -0700 Daniel Latypov <dlatypov@google.com> wrote:

> On Wed, Jun 16, 2021 at 2:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> > tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> > Because it is supported on only >=3.7 Python, people using older Python
> > will get below error:
> 
> Ah, we had been fine with just using 3.6 before this (and could have
> dropped down to 3.5 with a few lines changed).
> 
> But 3.7 came out initially in 2018*, so I assume we're probably fine
> to rely on that in kunit tool.
> *https://www.python.org/downloads/release/python-370/

Agreed.

> 
> >
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 20, in <module>
> >         import kunit_kernel
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
> >         from __future__ import annotations
> >         ^
> >     SyntaxError: future feature annotations is not defined
> >
> > This commit adds a version assertion in 'kunit.py', so that people get
> > more explicit error message like below:
> >
> >    Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 15, in <module>
> >         assert sys.version_info >= (3, 7)
> >     AssertionError
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>

Thank you! :)

> 
> > ---
> >  tools/testing/kunit/kunit.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index be8d8d4a4e08..748d88178506 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -12,6 +12,8 @@ import sys
> >  import os
> >  import time
> >
> > +assert sys.version_info >= (3, 7)
> 
> Do we perhaps want
>   assert sys.version_info >= (3, 7), "Python version is too old"
> 
> Then the error message would be
>   Traceback (most recent call last):
>     File "./tools/testing/kunit/kunit.py", line 15, in <module>
>       assert sys.version_info >= (3, 7), "Python version is too old"
>   AssertionError: Python version is too old

That looks easier to understand.  I will post v2 in reply to this.


Thanks,
SeongJae Park

> 
> I assume kernel devs know some Python, but not necessarily that
> sys.version_info == "my python version"
> 
> > +
> >  from collections import namedtuple
> >  from enum import Enum, auto
> >
> > --
> > 2.17.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210616094033.18246-1-sj38.park%40gmail.com.
