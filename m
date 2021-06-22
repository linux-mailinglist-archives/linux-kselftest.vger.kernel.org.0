Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A03B10D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 01:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFVX5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Jun 2021 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFVX5w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Jun 2021 19:57:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB4C061756
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 16:55:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o5so1223190iob.4
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUWFjpT6YBkCLpvFT4HlZ6tYk9tWHjZGUxJiYySq8UQ=;
        b=tJW+1cmKXb+HRi7bCn0UUwncLAc6B7cb2Rw5rhQqmAzgfCl2EiZOlnMpxyOkTiBdGr
         UGvkc+bRKGT3mGJCwHtxTk7bsFGCpC8dWzHobRvz4ot4LrCTweU8HXsK1bHpzrHjzlQQ
         4hGtBH1007HFOjQKfB2GCO5aTSWJdk55eZ1DT0JxIqQsiemxl2YSYA9p8pk7UXPT4qiR
         rpxMqUJSC8HdayjX2whg8n5stLkBzEiEGN9wOQqkoj70sfy30WriYATJGGWMfNLJLRAK
         JkhaGRBVGJt6ER19bkkB++FkbRTo665/fpLZpgig0fifr8eu3TkL/ZsbDV3M4BNEId9r
         /INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUWFjpT6YBkCLpvFT4HlZ6tYk9tWHjZGUxJiYySq8UQ=;
        b=JQ9ry4zNpZwP/JP84GD46SUxWJP6vZTE+plqw9lLv9Unc3ei9hj993NjS/t2otq6Dd
         T/rUqsdfboC2MBr+lRDroq9YxYtgGEODw8CMoM+IchivYFGKrTXOdjP4417Y5osuJcKB
         RyDKMFMYDWdle1YE0hQ0YEMPqIQFDdIpU0pRYyM0YZAgyReRE/kv6WASBHndMlO8PX87
         BE0c/lXpEzx25tBe/4XZX7j2ND6NwSsjDnN3j0ibddF2CGT90sU5z5X+bMLf8gjY+YWg
         MjDQkBba+EItwWL5bVxB/5PGrEPGC5d+ho7FHWSV5Ww9myKER/T4LNL06CB38TOBSwOU
         zz8A==
X-Gm-Message-State: AOAM530NgpR27qFeFAVdVmRRyrT5FaaGX41SUtUX8HRb/FYYdJMsn8HD
        TgzmZ4PgJ+ll5UrvGJZyxSSraoTg/TPnsQA4Iv8sKg==
X-Google-Smtp-Source: ABdhPJw754OL9sHKekBMhtUG4nG4roseEc/8AHs1V3pNEL5tlhRzCdZMjH0uDo5MWjBzZHWtyVfKT4mWfhWspHUUnrI=
X-Received: by 2002:a05:6638:110e:: with SMTP id n14mr6247711jal.4.1624406133636;
 Tue, 22 Jun 2021 16:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210617073937.16281-1-sjpark@amazon.de> <20210617074638.16583-1-sjpark@amazon.de>
 <CAGS_qxofnnP7Ju15iaZ_Szr+aqmHNxU51Kiv723bkd8w9g+Jkg@mail.gmail.com>
In-Reply-To: <CAGS_qxofnnP7Ju15iaZ_Szr+aqmHNxU51Kiv723bkd8w9g+Jkg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 22 Jun 2021 16:55:21 -0700
Message-ID: <CAGS_qxoPq1f+dcaf43xyjbDhW-ASG3gZez-b0Pv_s17JU3hePw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 22, 2021 at 4:28 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> > tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> > Because it is supported on only >=3.7 Python, people using older Python
> > will get below error:
> >
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 20, in <module>
> >         import kunit_kernel
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
> >         from __future__ import annotations
>
> Chatted offline with David about this.
> He was thinking if we could instead drop the minimal version back to 3.6.
>
> I think we can do so, see below.
> Perhaps we should drop the import and then chain this patch on top of
> that, specifying a minimum version of 3.6?

Actually, now I've gotten python3.6 installed on my machine, I see we
have another issue.

We pass text=true to subprocess.
That didn't exist back in 3.6, see
https://docs.python.org/3.6/library/subprocess.html

We can workaround that, but there's more chance of subtle bugs that
I'd rather we don't touch it.

>
> Checking out https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit-fixes
>
> The offending "annotations" import is related to type annotations.
> Specifically https://www.python.org/dev/peps/pep-0563/
>
> So let's see how the two most popular typecheckers fare.
>
> pytype is happy with or without import.
> mypy has the same issues with or without the import.
>
> $ mypy tools/testing/kunit/*.py
> tools/testing/kunit/kunit_kernel.py:227: error: Item "_Loader" of
> "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:227: error: Item "None" of
> "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:228: error: Module has no
> attribute "QEMU_ARCH"
> tools/testing/kunit/kunit_kernel.py:229: error: Module has no
> attribute "QEMU_ARCH"
>
> So clearly it's not doing anything for them.
>
> Taking a look over 87c9c1631788 ("kunit: tool: add support for QEMU")
> next then...
> I don't see anything that would warrant the import, so we should
> probably drop it.

Also, using 3.6 now I have it installed, I found what it was added for.
But it doesn't need to be there.

This patch drops it and makes things work, afaict:
diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index e1951fa60027..5987d5b1b874 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,15 +6,13 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>

-from __future__ import annotations
 import importlib.util
 import logging
 import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator
-from typing import Optional
+from typing import Iterator, Optional, Tuple

 from contextlib import ExitStack

@@ -208,7 +206,7 @@ def get_source_tree_ops(arch: str, cross_compile:
Optional[str]) -> LinuxSourceT
                raise ConfigError(arch + ' is not a valid arch')

 def get_source_tree_ops_from_qemu_config(config_path: str,
-                                        cross_compile: Optional[str]) -> tuple[
+                                        cross_compile: Optional[str]) -> Tuple[
                                                         str,
LinuxSourceTreeOperations]:
        # The module name/path has very little to do with where the actual file
        # exists (I learned this through experimentation and could not find it

>
> In that case, the minimum supported version should drop back down to 3.6.
> We use enum.auto, which is from 3.6
> https://docs.python.org/3/library/enum.html#enum.auto
>
> We could consider stopping using that, and I think we might be then
> 3.5-compatible.
> Maybe we have a chain of 3 patches then, drop the import, drop auto,
> and then add in a >=3.5 version check?
>
> >         ^
> >     SyntaxError: future feature annotations is not defined
> >
> > This commit adds a version assertion in 'kunit.py', so that people get
> > more explicit error message like below:
> >
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 15, in <module>
> >         assert sys.version_info >= (3, 7), "Python version is too old"
> >     AssertionError: Python version is too old
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Acked-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

As mentioned above, we do actually need 3.7, and not just for the extra import.
Now I know that, I feel more strongly that this patch should go in, as-is.

> > ---
> >
> > Changes from v1
> > - Add assertion failure message (Daniel Latypov)
> > - Add Acked-by: Daniel Latypov <dlatypov@google.com>
> >
> >  tools/testing/kunit/kunit.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index be8d8d4a4e08..6276ce0c0196 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -12,6 +12,8 @@ import sys
> >  import os
> >  import time
> >
> > +assert sys.version_info >= (3, 7), "Python version is too old"
> > +
> >  from collections import namedtuple
> >  from enum import Enum, auto
> >
> > --
> > 2.17.1
> >
