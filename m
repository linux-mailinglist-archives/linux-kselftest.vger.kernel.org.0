Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A894243F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 19:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhJFRYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJFRYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 13:24:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABAC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 10:22:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x4so2139005pln.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuFD3DjuAsecBQETsr19lKvC+u97mJmjB+UnZRmfCzg=;
        b=pC7j8eITFbGqLmwjrio4yjY/CCYQVie5jvH66MeBxVkW5gfU4x8W5aVLT2GxxNugxp
         Sq+rlPEX3g9WStsf5PLNDgOYnlZEwL8txN9bP8JZ1+xxu0t3Rbae2AmME/JcqZA3dCi1
         UHDMxl50lugiTXCpQ93Tyt6RbWM1XLoAjeWMvXSyme7Ed3o3LTgiGLovPsGKxiOAmZHf
         vUz29Wsvt9V62o7Dmh9LOMtvhAldAqwLg/sepf/306CXsybmwbJ7AutVydDymJZgrnOe
         t+Vp19ucgC3i8KumMcJ+kNUXC7XyW85G5bfqRldk6cV6dx/TvyESqPybsZOww09R2kCo
         ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuFD3DjuAsecBQETsr19lKvC+u97mJmjB+UnZRmfCzg=;
        b=ATmyzYzTdo7yh1i2tX2qhVGyGjAiEjJxNUoQSRDuL4XL9EeUTeXuRzwgSh9Q8nC+L9
         QgS8+BADUrXb+NO/sKw1qMjMrpcPZeZwDYCwU3jnu2ueKMioWFxDl/UeKXGPruGzhFW0
         7kiGGGkJrzSUFB+y+M42lDj5457Lwy2F57Guk1/PPbs+CLToPhxhQL7dlqASdXpqJWxP
         3771jqFNF5Oek/SQCP0D5qXhiyp+aK6uL7dxasaBa5hYpbgviMyypdRxL2nNvnR4qxE3
         tVMUyWDEt8yglP1OAMuhkMpBQezsuXyUAcJkqgjZmYPTm2dVhY97txXP7fscLRJxPZPk
         Y3mg==
X-Gm-Message-State: AOAM5330UjgO8K5u0QLz/aAZUptFPBQhWRAzcmm9Z8RpQCshj4P1kxVy
        oE17hLjZ9JqA2x9OGsWwuv1AKMdXE6eYoX3Qi081Zw==
X-Google-Smtp-Source: ABdhPJxrCy4jllWoM0mTHfBjDMShNYpfxu2qKtoN3zGIl418b5CzQx26hThBRjmoM4nTC66Beuw9UnPEPB629gWMf2g=
X-Received: by 2002:a17:90b:3552:: with SMTP id lt18mr12079130pjb.63.1633540937948;
 Wed, 06 Oct 2021 10:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-5-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:22:07 -0700
Message-ID: <CAFd5g455K5XLR2m0zHtfUQwVP+iNBumE0zp5T7-H1ncB+_BVmw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 30, 2021 at 3:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The new --run_isolated flag makes the tool boot the kernel once per
> suite or test, preventing leftover state from one suite to impact the
> other. This can be useful as a starting point to debugging test
> hermeticity issues.
>
> Note: it takes a lot longer, so people should not use it normally.
>
> Consider the following very simplified example:
>
>   bool disable_something_for_test = false;
>   void function_being_tested() {
>     ...
>     if (disable_something_for_test) return;
>     ...
>   }
>
>   static void test_before(struct kunit *test)
>   {
>     disable_something_for_test = true;
>     function_being_tested();
>     /* oops, we forgot to reset it back to false */
>   }
>
>   static void test_after(struct kunit *test)
>   {
>     /* oops, now "fixing" test_before can cause test_after to fail! */
>     function_being_tested();
>   }
>
> Presented like this, the issues are obvious, but it gets a lot more
> complicated to track down as the amount of test setup and helper
> functions increases.
>
> Another use case is memory corruption. It might not be surfaced as a
> failure/crash in the test case or suite that caused it. I've noticed in
> kunit's own unit tests, the 3rd suite after might be the one to finally
> crash after an out-of-bounds write, for example.
>
> Example usage:
>
> Per suite:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> ...
> Starting KUnit Kernel (1/7)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> ....
> Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/7)...
> ============================================================
> ======== [PASSED] kunit-try-catch-test ========
> ...
>
> Per test:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> Starting KUnit Kernel (1/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] filter_subsuite_test
> ...
>
> It works with filters as well:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> ...
> Starting KUnit Kernel (1/1)...
> ============================================================
> ======== [PASSED] example ========
> ...
>
> It also handles test filters, '*.*skip*' runs these 3 tests:
>   kunit_status.kunit_status_mark_skipped_test
>   example.example_skip_test
>   example.example_mark_skipped_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
