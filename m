Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD94F1C94
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiDDV2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380478AbiDDUQ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 16:16:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665A33A3E
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 13:14:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l26so6010049ejx.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Apr 2022 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUUk7OFCSPCB5GyGNVhqhstLIqQ+gg7+gCRlD8LRTzg=;
        b=evtN5Ymd6TUeFnb88vq4kB2tzMaxcWuJAb0Z1RzjYNSPtsqBwLoL2ReibbsSubwZyZ
         lh1S9mxuRJa2tblZsu2gXft4+zXX74RF/J+IiGBdnVpqMF4NzbaQyS4cxq/11TcFZXL+
         fToGIqANbKUxPohGySwdFySUlPUZSa5IiDn2uZ0VcjA4hIFUo+VblH3bPSIo00pHUuWW
         WtTQ0wJVAdur1KpycS//D20rhKZwZKRypoYyW2agHq6ha1kieGsIh9S8z5iqvRaUaTSP
         wUEc2kvqdCfPnSWQpcKLV3HcVjtKVgt8hye6T6WvE2yff24mDnIjgOR6FCfh3x311VTQ
         UWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUUk7OFCSPCB5GyGNVhqhstLIqQ+gg7+gCRlD8LRTzg=;
        b=e/gHQVJ1QMNDsw8JKnWXUlvCQVxJ7qIPNlfWm9DQDi1rQyBgZcuDEu3LERX7WhkvFL
         255PygGc7ZTuuYNxh7NNtlES3zUx1uetSJtbmt47+rVsr5mo4Gq4T3KU3aCahjzS8wbY
         y07l5kYqKhRArYkdh4bxHVwgpdMR0mxIg4M1UGyHHp50o6IWVe7EeTNSnk14BG4D6efk
         2ol/nBVHNZrjItcND1r6HTZJfLpRDWxixZ+jx/rrOWCAiSKQ+q+WaLtMA+oY3Z0Lub6V
         iiTwvBum543CZTMNZYt/Sm1XbY4Q/pxJusrTyaDNp7ukK+3gnyy8Y2ZstGl1zsOQAUpg
         Tp2A==
X-Gm-Message-State: AOAM532U66Hi2FuOV74C9nnZb6xXEj6cNerrV7DS5Lkb1RjMow1yF76Q
        W8X85ftNtmcFLz2VwlEbpBRP1OXRoZ3KEOT+q6ddBQ==
X-Google-Smtp-Source: ABdhPJxJWvLMKxuKPIlv4rL1p5904YgP+ll/m5WadMWg254EBW9hdE6W6p2VGRA3U7JM9nJJvG6svwFW7XSdYsrfFLw=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr1803033ejc.668.1649103270301; Mon, 04
 Apr 2022 13:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 16:14:19 -0400
Message-ID: <CAFd5g47p-1OAM8fgUdTCUTJ+5Tj0+wPfTgiNVQ_VccbLjUYyWg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Steve Muckle - since I think this might affect things he is working on.

On Thu, Mar 17, 2022 at 10:13 PM David Gow <davidgow@google.com> wrote:
>
> When writing tests, it'd often be very useful to be able to intercept
> calls to a function in the code being tested and replace it with a
> test-specific stub. This has always been an obviously missing piece of
> KUnit, and the solutions always involve some tradeoffs with cleanliness,
> performance, or impact on non-test code. See the folowing document for
> some of the challenges:
> https://kunit.dev/mocking.html
>
> This series consists of two prototype patches which add support for this
> sort of redirection to KUnit tests:
>
> 1: static_stub: Any function which might want to be intercepted adds a
> call to a macro which checks if a test has redirected calls to it, and
> calls the corresponding replacement.
>
> 2: ftrace_stub: Functions are intercepted using ftrace and livepatch.
> This doesn't require adding a new prologue to each function being
> replaced, but does have more dependencies (which restricts it to a small
> number of architectures, not including UML), and doesn't work well with
> inline functions.
>
> The API for both implementations is very similar, so it should be easy
> to migrate from one to the other if necessary.  Both of these
> implementations restrict the redirection to the test context: it is
> automatically undone after the KUnit test completes, and does not affect
> calls in other threads. If CONFIG_KUNIT is not enabled, there should be
> no overhead in either implementation.
>
> Does either (or both) of these features sound useful, and is this
> sort-of API the right model? (Personally, I think there's a reasonable
> scope for both.) Is anything obviously missing or wrong? Do the names,
> descriptions etc. make any sense?
>
> Note that these patches are definitely still at the "prototype" level,
> and things like error-handling, documentation, and testing are still
> pretty sparse. There is also quite a bit of room for optimisation.
> These'll all be improved for v1 if the concept seems good.
>
> Cheers,
> -- David
>
> Daniel Latypov (1):
>   kunit: expose ftrace-based API for stubbing out functions during tests
>
> David Gow (1):
>   kunit: Expose 'static stub' API to redirect functions
>
>  include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
>  include/kunit/static_stub.h         | 106 +++++++++++++++++++++
>  lib/kunit/Kconfig                   |  11 +++
>  lib/kunit/Makefile                  |   5 +
>  lib/kunit/ftrace_stub.c             | 138 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c      |  64 +++++++++++++
>  lib/kunit/static_stub.c             | 125 +++++++++++++++++++++++++
>  lib/kunit/stubs_example.kunitconfig |  11 +++
>  8 files changed, 544 insertions(+)
>  create mode 100644 include/kunit/ftrace_stub.h
>  create mode 100644 include/kunit/static_stub.h
>  create mode 100644 lib/kunit/ftrace_stub.c
>  create mode 100644 lib/kunit/static_stub.c
>  create mode 100644 lib/kunit/stubs_example.kunitconfig
>
> --
> 2.35.1.894.gb6a874cedc-goog
>
