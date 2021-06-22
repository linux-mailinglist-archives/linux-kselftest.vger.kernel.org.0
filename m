Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC23B1098
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 01:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhFVXbD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Jun 2021 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXbD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Jun 2021 19:31:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FCC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 16:28:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b14so1106160iow.13
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPkqmTODcvr4WgFhtXMV/bmKQtzCPSOCAM1LvuXyGzk=;
        b=YO7c5TAaCCqEuN7liNrVb7535wuDyHh9HyLjpzAmgohl8XMPL6t0tYIj9kM+x6+aU5
         p+KcSx2cvKS714uc9vbJpcGpLhf/DIUjmPFzeFoWE5T0j73vaBlFwb7UzF3MyeKRGbNE
         Bo6vGFotf935bp+brvd0+fSloz20P3/oiRBrFlQqUMJLQiCTeRDXe4oI6FaMpqZpI1+B
         PipCMqI9pSGAF27kjAduurWT+Nxtybbh07bs4YTV0Uawnd/ubjogggBehxmI/TGwF6Mf
         uimddpvRmPZA6GKh2u2rfVKlpORkfJ8yFCsNgzjSJXo3hyw6h9lJwPcv735uLBnYBpbo
         ETFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPkqmTODcvr4WgFhtXMV/bmKQtzCPSOCAM1LvuXyGzk=;
        b=m8pzTe6a6lhbo8W1XLx2z7AVvTLhcR0dGDeiPWrsYAcMobYlzIseq1/OHj2UBUfpMf
         GgcXTZGbrv+BRX11UfeJG7nrfACrhAGPtXNjfKenf4gcYbN5SkgzprGpii+E5J04soex
         Y72QvOsYKPBZN8YLAT3M+87nxy0pUjeIdiqcVt9IEf1l4vnoxL1dlITws/0G5UDa7SYF
         B9hO9eL4obZUlHvyystd/unO6NoZxFiTjE/4DQmschexvCiA3SeU5w1F4i3bYuHsCQZH
         CBRA4B50LP9G/IhhlDshvt0DPUC30UxvaxnBijDnmA/PYBverHPHOl+tnT5iaJ6Ofy9T
         r6ow==
X-Gm-Message-State: AOAM533XsS0/Acvzw1YaUM/F/vI2aI8wOE92XcZZAOG/3j8aXemxzfdP
        a49SIMMy/kZs88X0MB/Ti4ZfABxCu2SogxhmTGe9mg==
X-Google-Smtp-Source: ABdhPJw1MAtabJ70l1o+6QIv09JoWg8EQ6BBbTs521uGPuBhKD3di5bQmok1rs820Qb1QlIm5tggrkOXvFnxH0cLoBI=
X-Received: by 2002:a5d:9d55:: with SMTP id k21mr4649098iok.57.1624404526263;
 Tue, 22 Jun 2021 16:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210617073937.16281-1-sjpark@amazon.de> <20210617074638.16583-1-sjpark@amazon.de>
In-Reply-To: <20210617074638.16583-1-sjpark@amazon.de>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 22 Jun 2021 16:28:34 -0700
Message-ID: <CAGS_qxofnnP7Ju15iaZ_Szr+aqmHNxU51Kiv723bkd8w9g+Jkg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> Because it is supported on only >=3.7 Python, people using older Python
> will get below error:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 20, in <module>
>         import kunit_kernel
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>         from __future__ import annotations

Chatted offline with David about this.
He was thinking if we could instead drop the minimal version back to 3.6.

I think we can do so, see below.
Perhaps we should drop the import and then chain this patch on top of
that, specifying a minimum version of 3.6?

Checking out https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit-fixes

The offending "annotations" import is related to type annotations.
Specifically https://www.python.org/dev/peps/pep-0563/

So let's see how the two most popular typecheckers fare.

pytype is happy with or without import.
mypy has the same issues with or without the import.

$ mypy tools/testing/kunit/*.py
tools/testing/kunit/kunit_kernel.py:227: error: Item "_Loader" of
"Optional[_Loader]" has no attribute "exec_module"
tools/testing/kunit/kunit_kernel.py:227: error: Item "None" of
"Optional[_Loader]" has no attribute "exec_module"
tools/testing/kunit/kunit_kernel.py:228: error: Module has no
attribute "QEMU_ARCH"
tools/testing/kunit/kunit_kernel.py:229: error: Module has no
attribute "QEMU_ARCH"

So clearly it's not doing anything for them.

Taking a look over 87c9c1631788 ("kunit: tool: add support for QEMU")
next then...
I don't see anything that would warrant the import, so we should
probably drop it.

In that case, the minimum supported version should drop back down to 3.6.
We use enum.auto, which is from 3.6
https://docs.python.org/3/library/enum.html#enum.auto

We could consider stopping using that, and I think we might be then
3.5-compatible.
Maybe we have a chain of 3 patches then, drop the import, drop auto,
and then add in a >=3.5 version check?

>         ^
>     SyntaxError: future feature annotations is not defined
>
> This commit adds a version assertion in 'kunit.py', so that people get
> more explicit error message like below:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 15, in <module>
>         assert sys.version_info >= (3, 7), "Python version is too old"
>     AssertionError: Python version is too old
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> Changes from v1
> - Add assertion failure message (Daniel Latypov)
> - Add Acked-by: Daniel Latypov <dlatypov@google.com>
>
>  tools/testing/kunit/kunit.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index be8d8d4a4e08..6276ce0c0196 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -12,6 +12,8 @@ import sys
>  import os
>  import time
>
> +assert sys.version_info >= (3, 7), "Python version is too old"
> +
>  from collections import namedtuple
>  from enum import Enum, auto
>
> --
> 2.17.1
>
