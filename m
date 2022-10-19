Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F71604949
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJSOeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiJSOdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 10:33:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA42159A07;
        Wed, 19 Oct 2022 07:18:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 8so10767318qka.1;
        Wed, 19 Oct 2022 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cknIal1Dqn0NuUAETBIEQ0lkMDHrEUKWbBRZZcSw1O0=;
        b=orl3WtaDUNcCVULI1fi76dsgEpQKIF0G7LTX3izYm28mr8jzmmUbBsZXMKVAEqJZxl
         9UokjFoKhOnsPeZto0hchT9sGCBY5MNhrO+zFqeoZ6DeraDl4WqSiK7qVOdCTXiEjTcs
         YSqlFNsNc1cXt3F2AT522djFUeXczOgztyZjbmN/SQCWXxoN3JuUhUzbFfkp2he/K0q6
         +6T6vae37EAuX7dNTC6j6DPbZf96EGjUl1U555sZIvvGSA5bIKwrLXr3Cx8MPZ3orUUN
         Hda6Rp6RISqHOKYTBCyjtsn1qD9IzEJAAtaEeDeaa+uMJIlMiKe5cQGexlqa2NigJZ74
         Ix1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cknIal1Dqn0NuUAETBIEQ0lkMDHrEUKWbBRZZcSw1O0=;
        b=XA29hhfKs9NnmMdrtWbS2LP25PbuGkNHpCLsR9JVGGW5QQQK0AT8DM1rL9S828Rp7I
         FMrjk+3OJAkhLi8nRFPGm4uE+2dKXwN5MSYHz29yBprOT9tasjnz38bY1SdvR2IP0Ub1
         HVtNJgUL3fobb56ADv+ixSRsFpm6uHyLyTQm3Y7NN8YZ+HuGX/zjbjnpT4GzJjkfjWBL
         hFN8FYSWmyuc+nMqWZ1+hsZeZvmWIHPyo0g+/4cWI8bbTMisZ4agMt5yDjRhXqygr5wI
         aK58pZNBWlNS08h7Q0b8A2mVWsszWgXGG2PptM7Vn8Dd11Ov45922EvpLaeFeO8D3yUH
         IDNg==
X-Gm-Message-State: ACrzQf3h+AQY9dN6QGRO+mTgTtSjHbR5+TxQ+jA4O2mveHwZJeeINKOc
        81hG2/gXMnaNY2j27fDTiDXFID3Dcb3wHLFA0yc=
X-Google-Smtp-Source: AMsMyM7p0PqU27XQdSypuWEjEDwSsJpxQKotFiEysDCDwzPck6pY+ftPfRp5TQ4uCqheYH/bz+aKWZoYJONuAwGz45A=
X-Received: by 2002:a37:b2c5:0:b0:6df:f8d6:6ea0 with SMTP id
 b188-20020a37b2c5000000b006dff8d66ea0mr5676134qkf.386.1666189080171; Wed, 19
 Oct 2022 07:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221019085747.3810920-1-davidgow@google.com>
In-Reply-To: <20221019085747.3810920-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 19 Oct 2022 16:17:49 +0200
Message-ID: <CA+fCnZdPwjThjY7fd7vBkMzS1eFXySR2AKrDK8weJ3p25fzS3g@mail.gmail.com>
Subject: Re: [PATCH] kasan: Enable KUnit integration whenever CONFIG_KUNIT is enabled
To:     David Gow <davidgow@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 19, 2022 at 10:58 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Enable the KASAN/KUnit integration even when the KASAN tests are
> disabled, as it's useful for testing other things under KASAN.
> Essentially, this reverts commit 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT").
>
> To mitigate the performance impact slightly, add a likely() to the check
> for a currently running test.
>
> There's more we can do for performance if/when it becomes more of a
> problem, such as only enabling the "expect a KASAN failure" support wif
> the KASAN tests are enabled, or putting the whole thing behind a "kunit
> tests are running" static branch (which I do plan to do eventually).
>
> Fixes: 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Basically, hiding the KASAN/KUnit integration broke being able to just
> pass --kconfig_add CONFIG_KASAN=y to kunit_tool to enable KASAN
> integration. We didn't notice this, because usually
> CONFIG_KUNIT_ALL_TESTS is enabled, which in turn enables
> CONFIG_KASAN_KUNIT_TEST. However, using a separate .kunitconfig might
> result in failures being missed.
>
> Take, for example:
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y \
>         --kunitconfig drivers/gpu/drm/tests
>
> This should run the drm tests with KASAN enabled, but even if there's a
> KASAN failure (such as the one fixed by [1]), kunit_tool will report
> success.

Hi David,

How does KUnit detect a KASAN failure for other tests than the KASAN
ones? I thought this was only implemented for KASAN tests. At least, I
don't see any code querying kunit_kasan_status outside of KASAN tests.

I'm currently switching KASAN tests from using KUnit resources to
console tracepoints [1], and those patches will be in conflict with
yours.

Thanks!

[1] https://lore.kernel.org/linux-mm/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/
