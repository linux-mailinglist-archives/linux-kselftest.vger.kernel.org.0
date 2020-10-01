Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE427F8F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAFOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 01:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJAFOH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 01:14:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB8C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:14:07 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id k13so1143996oor.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhERQZh6diFhV3SJ8DG5mSXhB50dMWp+CwSZp5o02Lo=;
        b=kymtirw2PgNXq8PIVui+ydpCSZaECut8qe5YGYcdMDANnh6OKLtQ4kHQb0Rz2ZMkhP
         F/F6w5rqN265K1y600K9iBTU+MxH/JOyM6msApRrqwtC5aXL1mnqyOurmrK1OUjv5Gm3
         nu6TFABC51h/P4XTo/ey+NgN+n94ASYgjMf16JrNlR8xrBmCnh0kMJU0k+jKbcJFBwJL
         hnf/dikruR3VKsuBKjw2pUuuK/daIsYkHpH4u8ZLAA8tIki1rl2MvoeNAjUMwrTHyzKm
         V2IukplsHjTQHc5wwHE7W7k5Uey2YWVmudwp2AcjTBz4U8QmvgdHYOwr2BxrTgRMKthe
         TPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhERQZh6diFhV3SJ8DG5mSXhB50dMWp+CwSZp5o02Lo=;
        b=cczH65etaLFw6eH+bmluVFV1Odfu0sJyTOOPB6LSrX/9PSiKQledJ4fstfJnLAc5O2
         7W8X/Q6NYOk5MUzcONvkvCJnjnau6TeK+f/n5EPKFWoNKnLZWf/VAQ76XYF56WKwEth4
         MHFqLh9DSS+IW91AMTmcmsaukaLO8CkuRRP/+RXH5y6EuR+IkPnmpw1mr6f0g2xMDm8R
         SY3taE9VYrIaAnDqVC3FGPQDisTHrNdj8MwJVojY5+MzYoEFgP2/1ALxlqMJ5pNIOZ3Q
         kbj+dO2vMmfz4uScNHISsndvTahrQbWLGaEHBfjW8/WAof26kN5duFOSJUa/lTqVcYQg
         jbSA==
X-Gm-Message-State: AOAM53396YrCaa5pG8oM6G74c1GlmT1jTZFj4cLxWkSImsY9f9Qtax0m
        9AJZaYx1c+NIZTKX13r8wOBTMDbVQeDCR+AR3A7vxw==
X-Google-Smtp-Source: ABdhPJx+IDn3sYkvcPvZmlD9Kp9hsWRRiJTst2phVq+L2CAy9g+5kmxW+ag+gf6CjMUZzwpSxRpC2sec1qhZnbs777M=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr4389788ooa.1.1601529246600;
 Wed, 30 Sep 2020 22:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200928202650.2530280-1-keescook@chromium.org> <20200928202650.2530280-4-keescook@chromium.org>
In-Reply-To: <20200928202650.2530280-4-keescook@chromium.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Oct 2020 10:43:55 +0530
Message-ID: <CA+G9fYumUQ5Dr2Sbv=cAB0=cpvi4QA-=pDvLnt5t2Df4KYwMJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: dev-tools: kselftest.rst: Update examples and paths
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Sep 2020 at 01:56, Kees Cook <keescook@chromium.org> wrote:
>
> Update the installation commands and path details, detail the new
> options available in the run_kselftests.sh script.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
>  Documentation/dev-tools/kselftest.rst | 35 +++++++++++++++++----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 469d115a95f1..a901def730d9 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -125,32 +125,41 @@ Note that some tests will require root privileges.
>  Install selftests
>  =================
>
> -You can use the kselftest_install.sh tool to install selftests in the
> -default location, which is tools/testing/selftests/kselftest, or in a
> -user specified location.
> +You can use the "install" target of "make" (which calls the `kselftest_install.sh`
> +tool) to install selftests in the default location (`tools/testing/selftests/kselftest_install`),
> +or in a user specified location via the `INSTALL_PATH` "make" variable.
>
>  To install selftests in default location::
>
> -   $ cd tools/testing/selftests
> -   $ ./kselftest_install.sh
> +   $ make -C tools/testing/selftests install
>
>  To install selftests in a user specified location::
>
> -   $ cd tools/testing/selftests
> -   $ ./kselftest_install.sh install_dir
> +   $ make -C tools/testing/selftests install INSTALL_PATH=/some/other/path
>
>  Running installed selftests
>  ===========================
>
> -Kselftest install as well as the Kselftest tarball provide a script
> -named "run_kselftest.sh" to run the tests.
> +Found in the install directory, as well as in the Kselftest tarball,
> +is a script named `run_kselftest.sh` to run the tests.
>
>  You can simply do the following to run the installed Kselftests. Please
>  note some tests will require root privileges::
>
> -   $ cd kselftest
> +   $ cd kselftest_install
>     $ ./run_kselftest.sh
>
> +To see the list of available tests, the `-l` option can be used::
> +
> +   $ ./run_kselftest.sh -l
> +
> +The `-c` option can be used to run all the tests from a test collection, or
> +the `-t` option for specific single tests. Either can be used multiple times::
> +
> +   $ ./run_kselftest.sh -c bpf -c seccomp -t timers:posix_timers -t timer:nanosleep
> +
> +For other features see the script usage output, seen with the `-h` option.
> +
>  Packaging selftests
>  ===================
>
> @@ -160,9 +169,9 @@ different system. To package selftests, run::
>     $ make -C tools/testing/selftests gen_tar
>
>  This generates a tarball in the `INSTALL_PATH/kselftest-packages` directory. By
> -default, `.gz` format is used. The tar format can be overridden by specifying
> -a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_ option
> -is supported, such as::
> +default, `.gz` format is used. The tar compression format can be overridden by
> +specifying a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_
> +option is supported, such as::
>
>      $ make -C tools/testing/selftests gen_tar FORMAT=.xz
>
> --
> 2.25.1
>

- Naresh
