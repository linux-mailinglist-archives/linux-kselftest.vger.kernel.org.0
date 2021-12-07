Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9928C46C7E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbhLGXCR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 18:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbhLGXCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 18:02:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BEC061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:58:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so295309plg.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoM1pVINkMLD60gxA8TI/pZmmvMgShnXtiUKe3CgEzs=;
        b=YqPCePVbTajCZ5c50XbOPpPapYky9JCDNgiYPjrpdZGVMZsvoODGmkimetIQARRt7I
         fpfley0T0kc3rFG0Gabis6709qQ6D676+qJifId8SKf79z7wlRq008xGKS+e/wt6fqNl
         yP3L9JGyVafRaIonrAkOLKtFxgloUvyLDsG+gO7GXvQ1Vcp7geNvvNXOB6S/v2Uh0A8F
         1EH5zpRB31GJkR3roA+dqmHjYBq49LHX/TcmldPqvsiezWIBCypBgXudSIw5u+Klt7fK
         sPQTwTrnseZf9nTM/7gbS9BWQHgQ3GpMjTLV0CSGtOSxxrEbqi3CtEOA/UCr2ql57lyF
         wG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoM1pVINkMLD60gxA8TI/pZmmvMgShnXtiUKe3CgEzs=;
        b=CVB/vQdNYuyGvweJStDRCYJ6RQiIZQRO+Y+y5RjQRSwefG5pisCKj7JrnR0k1ZOdSC
         wDGCGqo2z5/UOC/CBdVaPDj/cdXy4dKI5zLj6jYPzqfc0wRknC3kd2Sx2kKf3Mx9Tdeb
         9g2vUrOINCqhylyCtWjIZS0q9FKmUgJSdkGv8knzA6dd+2evTTbuN4COup4ZlZUiSP8B
         k0b56vuvFNMtDLlXTYtOsYlPve2NbjHqbFCQQrEypCbe3UVvbqQchxuSfy4PYTamVRTC
         AJStfZjyiT4wSd1FxrGhrliNyCeuZK0TgRCLRvrI2XLLOPmTHicRLmuXOUHHVpjEd4pG
         c1iQ==
X-Gm-Message-State: AOAM532g44bz+fplwPRrhN3P883aaCGHH5Jv+T+yjhdMeHhpYtg4ivkB
        aVISZFAUbz/VyW1nY7B8whuGDJImvLfUs+cYO7pEjA==
X-Google-Smtp-Source: ABdhPJwrtiDMh+jI+v/37kJDmwUCRtE0nGiX1/JKs55GKW5kLOw6pjF4lPrTwosOfwHyxpP0wzP6Wt7HLNiSebX2uhM=
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr2694893pjb.198.1638917925412;
 Tue, 07 Dec 2021 14:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20211120032401.2305447-1-dlatypov@google.com>
In-Reply-To: <20211120032401.2305447-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:58:34 -0500
Message-ID: <CAFd5g443R4OU4vspOh2yqu=7FBtUaxMbsd_tpr8ZnND1CJveCA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: suggest using decode_stacktrace.sh on kernel crash
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 10:24 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit.py isn't very clear that
> 1) it stashes a copy of the unparsed output in $BUILD_DIR/test.log
> 2) it sets $BUILD_DIR=.kunit by default
>
> So it's trickier than it should be for a user to come up with the right
> command to do so.
>
> Make kunit.py print out a command for this if
> a) we saw a test case crash
> b) we only ran one kernel (test.log only contains output from the last)
>
> Example suggested command:
> $ scripts/decode_stacktrace.sh .kunit/vmlinux .kunit < .kunit/test.log | tee .kunit/decoded.log | ./tools/testing/kunit/kunit.py parse
>
> Without debug info a user might see something like
> [14:11:25] Call Trace:
> [14:11:25] ? kunit_binary_assert_format (:?)
> [14:11:25] kunit_try_run_case (test.c:?)
> [14:11:25] ? __kthread_parkme (kthread.c:?)
> [14:11:25] kunit_generic_run_threadfn_adapter (try-catch.c:?)
> [14:11:25] ? kunit_generic_run_threadfn_adapter (try-catch.c:?)
> [14:11:25] kthread (kthread.c:?)
> [14:11:25] new_thread_handler (:?)
> [14:11:25] [CRASHED]
>
> `tee` is in GNU coreutils, so it seems fine to add that into the
> pipeline by default, that way users can inspect the otuput in more
> detail.
>
> Note: to turn on debug info, users would need to do something like
> $ echo -e 'CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y' >> .kunit/.kunitconfig
> $ ./tools/testing/kunit/kunit.py config
> $ ./tools/testing/kunit/kunit.py build
> $ <then run decode_stacktrace.sh now vmlinux is updated>
>
> This feels too clunky to include in the instructions.
> With --kconfig_add [1], it would become a bit less painful.
>
> [1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
