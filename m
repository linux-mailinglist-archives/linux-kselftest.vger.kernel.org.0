Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D13367985
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Apr 2021 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhDVFxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Apr 2021 01:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDVFxF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Apr 2021 01:53:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F87C06138B
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 22:52:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a1so50449076ljp.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlBZuZJpKddS9FWipfcldRHxE90gSWKH6VLNPWIbZE8=;
        b=Ks6R6vv0FBcBlp9a2wW2yDdhiiLJLLQK0Lo/kp3hPLkwEavVgTzWZtXdxf4cIbb8vN
         ZJ2hDv3AW+mHoi+8AFDZhxdLlcX1gcucrrEtBFKkciuSm3T4abyc7MF3PukHsg+Li4oi
         vdFpTu/acdgdfPYCHACnEjoZvhNCvhuQY4bAtqEW2uSKfUerWK4uP1c2LiX2bXTKEX7v
         W/rMC5px51jeRPTnhSuPNuEsp/C08yTeRDQ3l7dP4WLLxLOovjEYTa4C1LRbj4Pumwzy
         K94V7z7O/1/zmCJAVGEsTMsZKV1cACjI35udBd9W3LOFNP8T0snGEIEk/CN6pzCWQzrY
         bc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlBZuZJpKddS9FWipfcldRHxE90gSWKH6VLNPWIbZE8=;
        b=DuIftAsvzqEqncucykj2P4cgcA/GUqhkEbt0wKW6vU3DfHT0WX1jCHlSK6kJx+82F5
         pHrC39wqmjWGl0X7BoXhnVnzV5b6ZgbreEJhg6NrOwZrUFH3HvuKSLfmnwcmnrUeEgRf
         tinfD/E86CDjYi7ebGDnwDHQ7W2iJjtGUOrvuLBHgwoN8xetYU759/i96pOGPPryDtTO
         CWjJCUPaaOxnfmcK3iaheMYOiVpbUtpBd7k7UduYKQrHob3Gs3Q2lAvMVHFoTH6pINc8
         bKmEZR+t6fC0CSBKA73Q7Zs08bIYkCVP0hh/9BBA4vSdnXtKZVMMhRvpknxYKTXPtUIw
         ZyXQ==
X-Gm-Message-State: AOAM530/x1L9jfwqcr2BR3C9LeYtWoCDa8dZxjneAusIHunPD83x8rGj
        mc5ayF9r5C3HWPNOfm9KCFd/Ew8yzDu/V8XwZkAcXQ==
X-Google-Smtp-Source: ABdhPJzzJY1/4fopv99DhbVgWhXzB+zQA/jEPEBBQxiQYJFph/e27bdnDC1li1O1UFRvPwNTFVd72I3/oRm5YST4Lr8=
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr1291001ljp.89.1619070749681;
 Wed, 21 Apr 2021 22:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183222.2557747-1-dlatypov@google.com>
In-Reply-To: <20210421183222.2557747-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Apr 2021 13:52:17 +0800
Message-ID: <CABVgOS=3OcPK-s_PO9t87_ruaUq4d+AO0zuCC5SxRd3vC3Vxgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 22, 2021 at 2:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Functionally, this just means that the test output will be slightly
> changed and it'll now depend on CONFIG_KUNIT=y/m.
>
> It'll still run at boot time and can still be built as a loadable
> module.
>
> There was a pre-existing patch to convert this test that I found later,
> here [1]. Compared to [1], this patch doesn't rename files and uses
> KUnit features more heavily (i.e. does more than converting pr_err()
> calls to KUNIT_FAIL()).
>
> What this conversion gives us:
> * a shorter test thanks to KUnit's macros
> * a way to run this a bit more easily via kunit.py (and
> CONFIG_KUNIT_ALL_TESTS=y) [2]
> * a structured way of reporting pass/fail
> * uses kunit-managed allocations to avoid the risk of memory leaks
> * more descriptive error messages:
>   * i.e. it prints out which fields are invalid, what the expected
>   values are, etc.
>
> What this conversion does not do:
> * change the name of the file (and thus the name of the module)
> * change the name of the config option
>
> Leaving these as-is for now to minimize the impact to people wanting to
> run this test. IMO, that concern trumps following KUnit's style guide
> for both names, at least for now.
>
> [1] https://lore.kernel.org/linux-kselftest/20201015014616.309000-1-vitor@massaru.org/
> [2] Can be run via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_TEST_LIST_SORT=y
> EOF
>
> [16:55:56] Configuring KUnit Kernel ...
> [16:55:56] Building KUnit Kernel ...
> [16:56:29] Starting KUnit Kernel ...
> [16:56:32] ============================================================
> [16:56:32] ======== [PASSED] list_sort ========
> [16:56:32] [PASSED] list_sort_test
> [16:56:32] ============================================================
> [16:56:32] Testing complete. 1 tests run. 0 failed. 0 crashed.
> [16:56:32] Elapsed time: 35.668s total, 0.001s configuring, 32.725s building, 0.000s running
>
> Note: the build time is as after a `make mrproper`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me: I'm not an expert in the test, though, so I may
have missed something. I did run it, though, and it seemed to work
fine.

It's a shame the functions can no-longer be marked __init, but I think
the advantages of KUnit outweigh it, particularly since this is
unlikely to be being used in production.

(BTW: This doesn't appear to be posted as a reply to Patch 1/2, which
made it a bit trickier to find.)

This is
Tested-by: David Gow <davidgow@google.com>

-- David
