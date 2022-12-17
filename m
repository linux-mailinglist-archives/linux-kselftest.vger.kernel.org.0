Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778664F7BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 06:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLQFJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 00:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiLQFJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 00:09:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A3B6C716
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 21:09:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i7so4293174wrv.8
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 21:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDYnJGBhM5VrUDJCjc6PATa5BNNW24FWGhwz7O2VUXc=;
        b=k3R+xAcKLpJlOELwxDJJbBbzR0MuxQ1X5Xc/SJxPXsoS4wAMR2Rg1a59EmfGU8B4tk
         TgJzngqoPPD+tz2iW5BRaZbyH4TC8dN3pUFv91gD9Q805DjrWDnTbjYz+iYfS9EJR1L9
         VIQFyJ7aL59UTPBt+26qayATDT/Z/yJ23Gm4WCeuJL7QQGD2sYPW6lwNK8ZUSG5kXDtt
         OWbi9GiwrVD3Ed9ovAgueirkub0f01NkqdT4yDTfnzDgabYcwI5w4oRkw8MxU6HzLbeK
         X3qIJYc1WjT1ZGEDqCZaHKTdq13vnMIBfAFyNXDvWKQpYr0Rn1zKBFXHYa6JGaOJMEfe
         w/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDYnJGBhM5VrUDJCjc6PATa5BNNW24FWGhwz7O2VUXc=;
        b=qiRCcWaayir237dlAG6//JKiMvoX1eEa44BQW+o5ncD0p7b8DQF2fIEb4IBEN9qrIJ
         6Wehvo2h3oN5PZ2/b01nc2sC69/OFl4o1lPUJHu7fM9w+ux/izDDomlfqnyMfi2SCgFS
         4MzArQruKAli1Pc5K7qOeZmnS1RTaEVtDtYXaFC4/0BPFWjmS+puy45okvXoCfkqd10x
         iV/l4I5/1QJ9NP51tazdsknzpfLcTxs5/Wn/Sz5PtNR/XlHT+XZ8CrSeK90YazqVFwOO
         noOoqn60HO2zrVGx8krjv0IYJede2k0f2o7+xdhk59lEVIvWfRMDkPVzdIXv0aSCSaMX
         8gfA==
X-Gm-Message-State: ANoB5pkxdDr6C1I9m12heE280ylGRye1uqbDNcuEM4uiKbHWQnRZBG5I
        TWikr0dtxYnV8/7zeAipaPLCHLRz4chBUjVaWzjDMA==
X-Google-Smtp-Source: AA0mqf5pqh5WuMfQCOhgpK+CTTnF4ScfK4B4yK6Gj1sFkaZBwIxKBkrQ/MF+wBpxykKgGc5cNpQs0AZh3Yc3HpsU3KM=
X-Received: by 2002:a05:6000:16ca:b0:242:8bf7:27fe with SMTP id
 h10-20020a05600016ca00b002428bf727femr2134626wrf.278.1671253789220; Fri, 16
 Dec 2022 21:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com> <20221208061841.2186447-2-davidgow@google.com>
In-Reply-To: <20221208061841.2186447-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 17 Dec 2022 00:09:38 -0500
Message-ID: <CAFd5g46pmRtVo4Uga3wx4i9C11YRdyTVVdb-A9asrGngd5LRLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Expose 'static stub' API to redirect functions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 8, 2022 at 1:18 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a simple way of redirecting calls to functions by including a
> special prologue in the "real" function which checks to see if the
> replacement function should be called (and, if so, calls it).
>
> To redirect calls to a function, make the first (non-declaration) line
> of the function:
>
>         KUNIT_STATIC_STUB_REDIRECT(function_name, [function arguments]);
>
> (This will compile away to nothing if KUnit is not enabled, otherwise it
> will check if a redirection is active, call the replacement function,
> and return. This check is protected by a static branch, so has very
> little overhead when there are no KUnit tests running.)
>
> Calls to the real function can be redirected to a replacement using:
>
>         kunit_activate_static_stub(test, real_fn, replacement_fn);
>
> The redirection will only affect calls made from within the kthread of
> the current test, and will be automatically disabled when the test
> completes. It can also be manually disabled with
> kunit_deactivate_static_stub().
>
> The 'example' KUnit test suite has a more complete example.
>
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
