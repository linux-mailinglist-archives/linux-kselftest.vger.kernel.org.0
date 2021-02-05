Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610E83118E6
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBFCt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhBFCks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:48 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3879CC08ED8B
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:46:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so5643400pga.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zX6LAEUW5s0QmD6Rf0/ICrn6zUgDH4EfSVtgD8vxVtM=;
        b=XOdIoEoA0TCo2VC5koKUT+D38+jOajZjJFXFv67KOql0VJa8wUDFyGeqILcAx0Et2t
         DVC+zcbGXSjkvRLVMA4M1Gv5UwQOagZqQuo0UvxVS85c/+v4lfEZcY4hBD7MhUsH5Mqb
         rn/u0MiGN9+UQFUvYSJnh6KMg1et7bE0JYs03B7PWU/8NsLbm0k1c7dICRwT/FqV2S6S
         20/fazmjPQgnV6rKg2zHGJnt4lJ2b18a8OPSUZFnAHfY4ldecdVv/k18kq9JblTRpDdV
         ZnARCkb9u039i95VXHmdN7Gp+YY+8q9waAeTe/s1q10wboUzIUbF5HLU2DglhG+CuBqe
         ndoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zX6LAEUW5s0QmD6Rf0/ICrn6zUgDH4EfSVtgD8vxVtM=;
        b=ez42NguU13Crc6vBOUuQ1bRjBK7xdSt1jiQHTco3kmKMIkL3E1NCSxlK6NrRaoX7ve
         iSsYd8dIP3WFVeGpBy/in2hsnKJM+inkcANwxdes6hvKubs89qjU32HC6MdrW8a6UoNZ
         iGrcegtVEQrzmYVyndtvPUqkb74TCklIv8U98pQpSA9aqiXHYpUHBEVF/2thIp9F4GGl
         lRN+TZcX1gs6Ca5nsuSvn36KXI6zGFkkQgIIN53h38pOOyY9xC+eNShXGEsE4mw6X2Tp
         Fj6NVjp4DxztB2kqN+XEt5BPXNSEmWWXySd70D2YPKeR/vLplhnR+svIgHSqBzHk54oJ
         PEwA==
X-Gm-Message-State: AOAM532duwZwNyTfEGm09psXjcYw0ngAZ3ouKRMm22RAE7hT0rwBu/b2
        nEbPKHDvIOJrT0vaP6PIt+9uwWsciNg2Wkfpf6VHtX+AFjkg0Q==
X-Google-Smtp-Source: ABdhPJyhbZ9wlJ7d0ptMYYcjYrTV/FfyHJS1usloc3G4rB2pxMh8pQ6bqkBCD6t9IwOLVyoH8HtrQK8+gP7L3fhECjw=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr6648996pgi.159.1612568818593;
 Fri, 05 Feb 2021 15:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20210201205514.3943096-1-dlatypov@google.com>
In-Reply-To: <20210201205514.3943096-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:46:47 -0800
Message-ID: <CAFd5g47zVi2eHDjCaSb1M7U6usK4sP9OM8T-YQgR6uZXooHtYg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: make kunit_tool accept optional path to
 .kunitconfig fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 1, 2021 at 12:55 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently running tests via KUnit tool means tweaking a .kunitconfig
> file, which you'd keep around locally and never commit.
> This changes makes it so users can pass in a path to a kunitconfig.
>
> One of the imagined use cases is having kunitconfig fragments in-tree
> to formalize interesting sets of tests for features/subsystems, e.g.
>   $ ./tools/testing/kunit/kunit.py run --kunticonfig=fs/ext4/kunitconfig
>
> For now, this hypothetical fs/ext4/kunitconfig would contain
>   CONFIG_KUNIT=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_KUNIT_TESTS=y
>
> At the moment, it's not hard to manually whip up this file, but as more
> and more tests get added, this will get tedious.
>
> It also opens the door to documenting how to run all the tests relevant
> to a specific subsystem or feature as a simple one-liner.
>
> This can be seen as an analogue to tools/testing/selftests/*/config
> But in the case of KUnit, the tests live in the same directory as the
> code-under-test, so it feels more natural to allow the kunitconfig
> fragments to live anywhere. (Though, people could create a separate
> directory if wanted; this patch imposes no restrictions on the path).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
