Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9D322574
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 06:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBWFjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 00:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBWFjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 00:39:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC8C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 21:38:40 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o16so57053884ljj.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 21:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoz9ruMyGlyHp0Dux5TOabse5pDK13RiWfyTntkpE9k=;
        b=nRWf8ohTY81ID4OOn/y0ijqzLx+G+HyUob9gT0Bzn3SmJxgY8uQk8RljshQadg1i+Z
         yFX7ZnEpsQ21+T1glSTVqoTLXFXVH9m8WXGbzaX92tIUcXO2J93mktG4/TFSj2l5JUwg
         v2+vweeSa0ceTIdPmchWgHY1Yp22+ZrwO2Gf9eeyV9w89ZLm+WYTW6XJAUa+ZGtp6Omj
         PnS+m/9KgtwXll2AQK390ka6b0RZi+QLrwOe9+PaKMlivFQurZelN5s2w65iF2mAxCAR
         6/QqQZgTonNpGUohBPcs9eJTKCuYjP3DJ/fQBDyKmCsC65feKSy6/dcX1bnNObO1VmWn
         8iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoz9ruMyGlyHp0Dux5TOabse5pDK13RiWfyTntkpE9k=;
        b=CysXN8f0uEqf7ZpebNp+DTaN3XZT0VacgV7FJYEKfui3nu4q+4L2+32WXitbMmpKZE
         siERXPOGLZVU2Ns63i9iEpTCH7m6W1JB7ygE/HkyYr09oeF5EuePCyrRay5WOJx4U6Tt
         rOVOD5VzwJCEDtEu4mo+CWnzXfRxyk1VnnqjXHUd9xKsnr/nyvj8UN4g1KbwfRhWR+Pz
         srEFvR1mevtvgSrmpEQaVR8iXCFmjnAd01S5VhusIIKKrGO6m+yHbywAOSIo+ms10SIN
         728TMRLq3aeyRhpappidY31aQp4BUTb32KCy6wK8NGIu8tfsrFNVeFMxjZYBCyeuV0Lu
         hcUw==
X-Gm-Message-State: AOAM530JSpfSnSzVWTT0usBep5SnzAwCmTo+hvEUJCBX0Nn2Iood64Lp
        ussNk1fftclJwa8q1qFsQmVU3PuEPHnamvENvR/dDs7R9kR2RAm6
X-Google-Smtp-Source: ABdhPJzVkmlPfVBMcdf6U1j6JvbcnHFdFgnjdsxqlwOLxaVOKcc+QDqV/ZsMA+jlNsu0Vjq7zCHr83nliV6qZ6nk4oY=
X-Received: by 2002:a2e:8656:: with SMTP id i22mr10243200ljj.245.1614058718700;
 Mon, 22 Feb 2021 21:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20210222225241.201145-1-dlatypov@google.com>
In-Reply-To: <20210222225241.201145-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 23 Feb 2021 13:38:27 +0800
Message-ID: <CABVgOSk0G7xzoOjnz-oReDER7_e6V+j6fH63FdN8O40_8fNzGA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 23, 2021 at 6:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> TL;DR
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
>
> Per suggestion from Ted [1], we can reduce the amount of typing by
> assuming a convention that these files are named '.kunitconfig'.
>
> In the case of [1], we now have
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
>
> Also add in such a fragment for kunit itself so we can give that as an
> example more close to home (and thus less likely to be accidentally
> broken).
>
> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks! I really like this.

I'd assumed we'd check if the path exists, and fall back to appending
".kunitconfig", but checking if it's a directory is better.

I tried this out with all the different combinations I could think of,
and it works well.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/.kunitconfig                 | 3 +++
>  tools/testing/kunit/kunit.py           | 4 +++-
>  tools/testing/kunit/kunit_kernel.py    | 2 ++
>  tools/testing/kunit/kunit_tool_test.py | 6 ++++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
>  create mode 100644 lib/kunit/.kunitconfig
>
> diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
> new file mode 100644
> index 000000000000..9235b7d42d38
> --- /dev/null
> +++ b/lib/kunit/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_TEST=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index d5144fcb03ac..5da8fb3762f9 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -184,7 +184,9 @@ def add_common_opts(parser) -> None:
>                             help='Run all KUnit tests through allyesconfig',
>                             action='store_true')
>         parser.add_argument('--kunitconfig',
> -                            help='Path to Kconfig fragment that enables KUnit tests',
> +                            help='Path to Kconfig fragment that enables KUnit tests.'
> +                            ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
> +                            'will get  automatically appended.',
>                              metavar='kunitconfig')
>
>  def add_build_opts(parser) -> None:
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index f309a33256cd..89a7d4024e87 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -132,6 +132,8 @@ class LinuxSourceTree(object):
>                         return
>
>                 if kunitconfig_path:
> +                       if os.path.isdir(kunitconfig_path):
> +                               kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
>                         if not os.path.exists(kunitconfig_path):
>                                 raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
>                 else:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 1ad3049e9069..2e809dd956a7 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -251,6 +251,12 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                 with tempfile.NamedTemporaryFile('wt') as kunitconfig:
>                         tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
>
> +       def test_dir_kunitconfig(self):
> +               with tempfile.TemporaryDirectory('') as dir:
> +                       with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
> +                               pass
> +                       tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> +
>         # TODO: add more test cases.
>
>
>
> base-commit: b12b47249688915e987a9a2a393b522f86f6b7ab
> --
> 2.30.0.617.g56c4b15f3c-goog
>
