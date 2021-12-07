Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B646C440
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 21:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLGUPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 15:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLGUPX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 15:15:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13AC061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 12:11:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so329630pjq.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCAgM8slb4K09PKhqmBF079Y70RCQ4lbYveDYt8lCQ4=;
        b=JBR3p2w0p1REi7da+Y/qkO1BXVmBH0+BCWLImomUaJ7EKiJmnhNJtSVzpsoYLwMel4
         BsS0T/vnC5+kOWm1LfOdhVLxGX2/3iqiiC5bvw3ggxRzyPn2oxGUPBk7oMFh41kCbQZA
         AMkUxJoKjz4o266CF3rOAZKMy+lF06RvT4Qu4GthXQKgNg7Ww/P8mAqCy8ubHScSVmwx
         TkJYZygEg/R/ZkaVJRZeONJ4XOI40XDXT2zlO43m3ZOvCVVGPqGeV7NZAryi4wOZCdBU
         Hyp4TnaTamGe9+vlx6BRw9HT7MDnCpA5RpLUr0JsZR0Mbi2VsaoIFwsjM8IiJ/GD7Cvd
         7Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCAgM8slb4K09PKhqmBF079Y70RCQ4lbYveDYt8lCQ4=;
        b=0h/4Lp7aPf4NfffDakSo4U/eVBGA3baD3/v5wsCvvLH90lEg3eiqoxx4dLWS4Bsd5R
         RxgHQQ3cahQ2QCZeM+Zq+yj61kYLsrsmP6Tj54YrQTWv3L1/EOyobxbmma1YI5e3LTAr
         i+H94xhB9q4ihCzxT7peRvHSdLzf9qZCbp77TzkWGv0OgbdhqvJcqRlCFnHiJ2OYEASw
         thxTxU+fjP5ejNSq/XIR5thVyYGwvY0+4AX0ydeBgYY/RtJaRNEDKAsYOr9Ss5DV2PDw
         JGNvHOS2sCZ6ccF03/XDn1CS7K7xDr6USBUlwu4dXfredWmiDSq8bfDtnKmbad7HwE6k
         NT4w==
X-Gm-Message-State: AOAM532K6iTZmB5iAUDrtNo2Qli7iECYoBYhfzoh1y4il2KxKysLrGn6
        Yx1jlo602m4V433WJy09CMEbYsl/TDSwdA77M0VZ4Q==
X-Google-Smtp-Source: ABdhPJznZcB66MJzIdr4SBIn0glBslWQ/qbV4M3Bz7VKmHOvu3WKhcA4xfGI4Mvw0tzHQuTxHeE4UBpMzK4v7lxYXxc=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr1656289pjb.63.1638907911981;
 Tue, 07 Dec 2021 12:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20211103042228.586967-1-dlatypov@google.com>
In-Reply-To: <20211103042228.586967-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:11:40 -0500
Message-ID: <CAFd5g47oPHSEYkp6fC0f-d2NaJ8vDRnS1-A-3tO9=V62n_UmtA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: add run_checks.py script to validate kunit changes
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 3, 2021 at 12:22 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This formalizes the checks KUnit maintainers have been running (or in
> other cases: forgetting to run).
>
> This script also runs them all in parallel to minimize friction (pytype
> can be fairly slow, but not slower than running kunit.py).
>
> Example output:
> $ ./tools/testing/kunit/run_checks.py
> Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
> kunit_tool_test.py: PASSED
> mypy: PASSED
> pytype: PASSED
> kunit smoke test: PASSED
>
> On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
> E.g. adding in a type-checking error:
>   mypy: FAILED
>   > kunit.py:54: error: Name 'nonexistent_function' is not defined
>   > Found 1 error in 1 file (checked 8 source files)
>
> mypy and pytype are two Python type-checkers and must be installed.
> This file treats them as optional and will mark them as SKIPPED if not
> installed.
>
> This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
> KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
> play nicely together.
>
> It uses --build_dir=kunit_run_checks so as not to clobber the default
> build_dir, which helps make it faster by reducing the need to rebuild,
> esp. if you're been passing in --arch instead of using UML.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
