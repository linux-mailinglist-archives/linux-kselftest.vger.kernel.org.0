Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4A3816B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 May 2021 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhEOH74 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 May 2021 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhEOH7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 May 2021 03:59:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FEC061756
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:58:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so1319407wrw.8
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sb+Uvk7S+Epr81Z3oq1J9tLMJ54eT1P3RS4wtBa+VaA=;
        b=i22YS9JY0DerpzTSFKA2mm7F30FDqr/ZVuB3lWpgLOlBp7XJknCVOEOh/4H9bQBuDF
         iI+sOdtcsAxa/rsDwQVs+rH1OozFkJPr9I+2dKYW1eSS+CRIzavghBFAfW/zlRGG406p
         k+xcbkeyZRhbLq4l0NYNU+LSAfLMVYqN0X4r0k+awiwdW07Xb6Xdo5oyKgiEYJA3Dmiz
         pjZjfA4slrrBGZ2Gi85d36d4YvEhM+PTcfWahmwjo61B9nCKY6yotVjuROewO3apFjXs
         1iE5GRYb/dUVPJQAPuR/qyH2eAynl/XbHLZSys5Bv0mlzYbpjshMHP1seHFlELg5sGNH
         H3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb+Uvk7S+Epr81Z3oq1J9tLMJ54eT1P3RS4wtBa+VaA=;
        b=Rxza296vYrJ91aThl0Hh41vde0HRUUpwsMJAu5aLFQhUHS/QEubfy+l4EtxG+ns5GG
         liPHsjgkNVyWeyAMcJGLFk0RVxu2Lx6gkC0kFXrRh8BZfaCJuKfqjwYGbUuzsec60Agf
         OjAtzVQBgSWxB7HMYjGa9JWDBQtusI0XVpc6WNU9iRkscuM+0PUm8gaGZJGpFQn592ft
         e60Mf5qrzG7PxR++cAaCMom6AZYO1ztXVF3h329O4Zp9VX8sUT3wtc9qXtiwyKRi5Otu
         MNSLYSlw2H9YNimxWekUx025MN2AL1UnhMb4waVcNk80unKxkx9nKgcPYAgY/dNwVso2
         GiuA==
X-Gm-Message-State: AOAM530ATR7AwE2EsU1D9PxlHaz2F63CnknAz21MxXFoMHqwZdvOncI4
        4ZkznWfpN2NL3fsYDbIl8qQQy9WCQFppaCcOAe+/fNL5bO6IzhuA
X-Google-Smtp-Source: ABdhPJwUj/Bu2PKrsWBkS8THepTJFh+cLbd9AKW+jyJHqapqle1ShUggMsSFPjo/pdtT5LcC3878h3ria9sJKOMPres=
X-Received: by 2002:adf:d08f:: with SMTP id y15mr13034941wrh.39.1621065521103;
 Sat, 15 May 2021 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com> <20210507213110.155492-3-brendanhiggins@google.com>
In-Reply-To: <20210507213110.155492-3-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 May 2021 15:58:29 +0800
Message-ID: <CABVgOS=ibhMG4o9nD+jjCZmNkF2A0KR9PTgzheEXR-MXC2AReA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] Documentation: Add kunit_shutdown to kernel-parameters.txt
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Looks good to me.

Reviewed-by: David Gow <davidgow@google.com>


>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5bcc229d31e24..bfd64c01698ba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2244,6 +2244,14 @@
>                         0: force disabled
>                         1: force enabled
>
> +       kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> +                       running built-in tests. Tests configured as modules will
> +                       not be run.
> +                       Default:        (flag not present) don't shutdown
> +                       poweroff:       poweroff the kernel after running tests
> +                       halt:           halt the kernel after running tests
> +                       reboot:         reboot the kernel after running tests
> +
>         kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>                         Default is 0 (don't ignore, but inject #GP)
>
> --
> 2.31.1.607.g51e8a6a459-goog
>
