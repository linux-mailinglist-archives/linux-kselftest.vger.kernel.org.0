Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3664A55F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 05:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiBAEfk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 23:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiBAEfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 23:35:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E5C06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 20:35:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n40-20020a05600c3ba800b00353958feb16so539700wms.1
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+o1HhmhOYMcydfOnh8AY93cuxdP17P1TGCtSIC0GtY=;
        b=FeS7SD7lgm4cKhg7aFKeoGaC9NPFeUiSr3Hihj0CFFM5fwE1dO/NpzBbbxupDTtMCa
         gr8/CiTNpZ0LGBSXv/3ZVsr4ID2XUEGt/SWJ5yvNALNPnPEZrHBvWAy9VhDUaDQzpVKQ
         Wh2IAEXwPkH1LXtidtJ4oFHx2NeVtbbC3TS+4kg5246tmcWOSQIW65K7s4kuYr88IWJr
         XSmU1zHw5Dya9N7dq77mBE3P9/hy6CFWCttAychZAGjqLQKcrvUiR8B7O/C38IcbT0Kv
         rQfO3x1ugEATXQgKnMgxhXEELfTo41x25dSIGKOx/EZIUjgR8vQ7XDKdwBx2DT2YNpSa
         VX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+o1HhmhOYMcydfOnh8AY93cuxdP17P1TGCtSIC0GtY=;
        b=4zfUli3shZX/Q15znu4QrULaQ+PUrqC6qXJIAonhSE5DzRBoKfVY8jSK2k2/JHyFwz
         ybtgbceY2G81CG+TGUEWYZspz5+Jbhe9vCX3/1pYYQj6949Wl22qLsBzlC3fy8rhD8jm
         9cpVqu5zdZMb63jMcL08asMzpgmBw5nn68tFyC0092UqIJQgxxoYbO8eXEwvWgN/21Op
         gN+dlnIbNWRoxYjQq8hC3RGVq8XrwBXxK7ol7TsGWnO9jslRcDoE/NlfUdY1rTuaZC8z
         /DeDLZLlPOlWjW96voMyGF0e7dg70oCpNkFHv18MpEFif1hXajy4ua+KR79qqd9crgmg
         za8Q==
X-Gm-Message-State: AOAM533XdoCPRnHY++rPXrBMRWSnHKZ5J1c7hPfqfprMDWH4TMwYlK/H
        ox7ZABHzRLOq3Nxp+S/1kno/bNzvgPVi0cA1c4udyQ==
X-Google-Smtp-Source: ABdhPJz7mkKzeYnPL8PE3/yG00xKmn0ykg7wMcBgAlQwbkXXJAXG2O3onBXXt/PQF1v/Vv82t7p2xOcDVVS3v3jolOs=
X-Received: by 2002:a1c:4645:: with SMTP id t66mr151794wma.39.1643690138461;
 Mon, 31 Jan 2022 20:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20220131212341.1082577-1-dlatypov@google.com>
In-Reply-To: <20220131212341.1082577-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Feb 2022 12:35:27 +0800
Message-ID: <CABVgOSm-t2qs8c4b6+xw1O8V8DfUPXEZV4ahjyLoqwQFSjJp1g@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: fix path to .kunitconfig in start.rst
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 1, 2022 at 5:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
> the default --build_dir, which had the side effect of making
> `.kunitconfig` move to `.kunit/.kunitconfig`.
>
> However, the first few lines of kunit/start.rst never got updated, oops.
>
> Fix this by telling people to run kunit.py first, which will
> automatically generate the .kunit directory and .kunitconfig file, and
> then edit the file manually as desired.
>
> Reported-by: Yifan Yuan <alpc_metic@live.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> v1 -> v2: rebase onto 5.17 (had the kunit docs rewrite)
> ---

Looks good: this was definitely confusing. And (my version of) sphinx
doesn't complain, which is reassuring.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/start.rst | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index ad168d16968f..867a4bba6bf6 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -41,13 +41,18 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
>         CONFIG_MSDOS_FS=y
>         CONFIG_FAT_KUNIT_TEST=y
>
> -1. A good starting point for the ``.kunitconfig``, is the KUnit default
> -   config. Run the command:
> +1. A good starting point for the ``.kunitconfig`` is the KUnit default config.
> +   You can generate it by running:
>
>  .. code-block:: bash
>
>         cd $PATH_TO_LINUX_REPO
> -       cp tools/testing/kunit/configs/default.config .kunitconfig
> +       tools/testing/kunit/kunit.py config
> +       cat .kunit/.kunitconfig
> +
> +.. note ::
> +   ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
> +   ``.kunit`` by default.
>
>  .. note ::
>     You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
>
> base-commit: c2741453478badf571ef020d160053e8d5e1ba94
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
