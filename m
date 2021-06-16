Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF43AA5FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhFPVQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 17:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVQ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 17:16:59 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC5C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 14:14:52 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b9so3599217ilr.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrgNeqOkkTdrdhyBNpvQQtJWwQhENKuchQIrlwc8tKU=;
        b=VTnq7Vu75liFI6CjS2vIrPQEgig1ZNxDf7DqxLSiWCUxYi0F13HDRuE2xGx5stP5gW
         yAt5D/Ngu6g8QwNOfRqvZ/9Rx0lIdhhstl1SdBsCLQF8vYf33Wzruaitg1Y1eq6c5lEU
         3F9g0GgDFNGaw5WqMNh5/1zGt8Nv5xKTl8lnzo5XZJSgZt1cLIAefRY+qS5JKguPXBrQ
         vsVs7pdngLs0Mn37ZLFGQutv407cS6nl9VL6C4sJua0auZKLcRCtf6zEJdGMetruzcFT
         IGVRcIGAKb7ZMllJX56B3RA47EZBgJVgdNzN/C8IC5u2+mQ0SApuJVCKqE5mPND0M12M
         Vwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrgNeqOkkTdrdhyBNpvQQtJWwQhENKuchQIrlwc8tKU=;
        b=qYD0kxkjbXx5KRtACz6cVlkdqVlHlGfxnBp/8OLPrz9HVwnvssIkfTlxWYIoj9onDZ
         jV3pE3kc4O2CC8bVra5I0wjNJuELN10g/r1+lXm3Mi6lpHaAfKreXU4rLNZ2OCjRHs5w
         6GEbqlBMPl/vD0+rGAe+fyqttLridGCTDGaRzcSIwyHKunSMLOPxF+2aqsM+K18HFZpt
         Ai98RmsQ7tqh+0PG1J1Dv+Mky5lW//gXHqs1X+JqLRh9tuCYR+tVKpy3PpqXRf3KjDbG
         hENZ9g2bgkDgfygOjjiE7fnX4KjlwYAL1o6xxaoeSBPX7eTAk/aOTXNQPEYxWN8HLHxS
         n3ww==
X-Gm-Message-State: AOAM530X59luIQkgbjHgNjkGMO6qkVJe6oOFauuGnu9p6ObPoRMeJmm4
        NHiMIx3aIQmEvRl7wNDLnzdAshk5hXpL2M2plHr7ww==
X-Google-Smtp-Source: ABdhPJzBIFKAF+xNj5SDh7qIzqW0EpoayuskAnuji6/AJpRQguVmEePBJyn4LKGht+WbpEtvejSOIs12FZyQlzXRQjQ=
X-Received: by 2002:a05:6e02:5aa:: with SMTP id k10mr1130180ils.136.1623878091970;
 Wed, 16 Jun 2021 14:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210616094033.18246-1-sj38.park@gmail.com>
In-Reply-To: <20210616094033.18246-1-sj38.park@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 16 Jun 2021 14:14:40 -0700
Message-ID: <CAGS_qxo4L+Z=Z4ZRQ+z6BP2A6v2two5WyjMmLfTE0a=e0y1OAg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Assert version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 16, 2021 at 2:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> Because it is supported on only >=3.7 Python, people using older Python
> will get below error:

Ah, we had been fine with just using 3.6 before this (and could have
dropped down to 3.5 with a few lines changed).

But 3.7 came out initially in 2018*, so I assume we're probably fine
to rely on that in kunit tool.
*https://www.python.org/downloads/release/python-370/

>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 20, in <module>
>         import kunit_kernel
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>         from __future__ import annotations
>         ^
>     SyntaxError: future feature annotations is not defined
>
> This commit adds a version assertion in 'kunit.py', so that people get
> more explicit error message like below:
>
>    Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 15, in <module>
>         assert sys.version_info >= (3, 7)
>     AssertionError
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  tools/testing/kunit/kunit.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index be8d8d4a4e08..748d88178506 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -12,6 +12,8 @@ import sys
>  import os
>  import time
>
> +assert sys.version_info >= (3, 7)

Do we perhaps want
  assert sys.version_info >= (3, 7), "Python version is too old"

Then the error message would be
  Traceback (most recent call last):
    File "./tools/testing/kunit/kunit.py", line 15, in <module>
      assert sys.version_info >= (3, 7), "Python version is too old"
  AssertionError: Python version is too old

I assume kernel devs know some Python, but not necessarily that
sys.version_info == "my python version"

> +
>  from collections import namedtuple
>  from enum import Enum, auto
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210616094033.18246-1-sj38.park%40gmail.com.
