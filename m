Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8A3881F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhERVQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 17:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhERVQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 17:16:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D099C06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 14:15:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso527244pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C43/i5T89+Z7YHAazX11QPS1qt3iN5sh35aKnQ1xBXc=;
        b=L3SbeGKHfRXdqFWSY/DjtKEhkdISuPfaf1/glYzvtU6a0s3YUDaXW/V2vSONOb9az5
         ar6USRpYYzyUHUvBCVpIXy01hUckq3toF9CEzNTqevyNlVn0oaKwy04ztEZY9s9KVohr
         c+L2SCmGjU987rGITNpj8OFctyth8m4DBrzM3AjVvqKnRJPj2ePJv+ZquXgm75JlYm4s
         xYwZ0mmw3xwdp9IRqnb/g9tzuw3sTUp3KaPMDh8Yr02zbRwiXCDLS4ztVL9K85hvh+b5
         sgBK4fQ1EYBraCdirQ1/Cag9AIQBaI4q1QZ3yzlJnPRibfQ1zVbGu/aRSkArBtdmT2v4
         xsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C43/i5T89+Z7YHAazX11QPS1qt3iN5sh35aKnQ1xBXc=;
        b=b2QPFCmZEGaubhd39VHnTnXyjvPtBYKZ4oNYNRJBbV3YiO9NPf8g9kLzQlNGfqwjTS
         TOLcd6Q7/C5gsv3/PzwnFW6U+qJyDRL7AXwJ5EFr1j9veSG1sPh03eT8fT9UqOzpA7p/
         hh9JzyZj6UVUwJfvzAXBsmZgstPTfisEfUMPJTDgZhlaxU+tI7giOMkwhd7EQ8Lb8x2J
         Mh+srh243xCe/qkMABSzyNF7JOgETyS/SBGVKhGQqaBLQ++7ziqlnhIKQwaVOAt8R5WY
         qX/pMyyDQk76jE6CP6lHDCyTNYUwzihqlsVmISr7degsY7qzWrI15z6+tLcz5drXB8A0
         OGJQ==
X-Gm-Message-State: AOAM5325Yx0wAB5pQQIhReQMQoOzleAf4rTMc1X5UcB3Ud14Qh8/5Oif
        YoxFoTWUPvLwRVYMWShf55OTObiGbwp3RNKLFrNbtg==
X-Google-Smtp-Source: ABdhPJyoobLYnIWbWswtFV+hnCncsmdZCqoP03K67oJ14BVc7qPq4WxTKk04oRtwVQhRoxIz0t3Q99bKTrl82//++vs=
X-Received: by 2002:a17:90a:7306:: with SMTP id m6mr7191995pjk.217.1621372516465;
 Tue, 18 May 2021 14:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210518035825.1885357-1-davidgow@google.com>
In-Reply-To: <20210518035825.1885357-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 May 2021 14:15:05 -0700
Message-ID: <CAFd5g47kTYkUudpOTFW6k24yJWzgBQ63-ycksOYhqkhAW2P8kQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 17, 2021 at 8:58 PM David Gow <davidgow@google.com> wrote:
>
> Make the default .kunitconfig (specified in
> arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
> default. KUNIT_ALL_TESTS runs all tests which have satisfied
> dependencies in the current .config (which would be the architecture
> defconfig).
>
> Currently, the default .kunitconfig enables only the example tests and
> KUnit's own tests. While this does provide a good example of what a
> .kunitconfig for running a few individual tests should look like, it
> does mean that kunit_tool runs a pretty paltry collection of tests by
> default.
>
> A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
> instead of 14.
>
> Signed-off-by: David Gow <davidgow@google.com>

I am totally on board with what you want to do here, but I have one
minor issue below.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/configs/kunit_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> index 9235b7d42d38..becf3432a375 100644
> --- a/arch/um/configs/kunit_defconfig
> +++ b/arch/um/configs/kunit_defconfig

Could we also apply this to
tools/testing/kunit/configs/all_tests.config ? The contents of the
file are identical, and I think are supposed to be for the same
purpose.

> @@ -1,3 +1,2 @@
>  CONFIG_KUNIT=y
> -CONFIG_KUNIT_TEST=y
> -CONFIG_KUNIT_EXAMPLE_TEST=y
> +CONFIG_KUNIT_ALL_TESTS=y
> --
> 2.31.1.751.gd2f1c929bd-goog
>
