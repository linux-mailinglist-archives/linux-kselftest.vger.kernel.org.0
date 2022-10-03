Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6C5F3608
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJCTDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJCTDX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 15:03:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EC2D75D
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Oct 2022 12:03:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l22so14442768edj.5
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Oct 2022 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ME1oTRsKwcRu7pn4CZOREj68nEw1ojk/ZGR5xxUk3Sg=;
        b=OH+1O0yBwvwn63HKW65OnVIOZQaonjRKJTCdSGeVuP5d1mzORL/by5EYWtrNl+DiRV
         H/iv0rwX4Akil6x2X/fNwZSzNVfEbtiYH/Jzfpn9rh63p7N90ximWOclhYH8YRQVsyJZ
         HxdKryNPruy7rMvoXh0wntcTdNLx/+mfL9Qx+H2a9HzTL092YWHBax3tds1GJkB7hnR8
         0h0oCxEe0t6m5oQVNq1wrjs7KyGy7KA3pyI5HHRdpQyfZuKhxvu37VuDjQpP66u7H0Te
         vL9kneYYgcGNk8/hNOSCXy7A4bp4JOXViCuAoYJ3Isfp5+yUJQle0HOBrfhtsqWq25Vf
         9qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ME1oTRsKwcRu7pn4CZOREj68nEw1ojk/ZGR5xxUk3Sg=;
        b=YPaaptt9toO/NtEWQXjH88SPrp7zeZkIq3a8iDZTafLajxd4dkBEsWWh+5nsuSoDAS
         XE/CtpZVbfQL9cJCaYRt+/9N3xY99tL4rjz135NU62CkfIS8L6S0237JmhmbkueY90Ex
         jWI0Io93oDJsfLrbEsRXxt7kGr/ujs6HZNISJB4gEP+iVyhS5DrmU4gEPJEXmSJtwxzx
         7MbIC61ClXP6brlSCyx0LocNZ7V6DXYlszODBDgtskLPEWQhyQQNZecI9Wnen0K+BtbD
         4+sv7VrQydQXru8nD43qIymrHdfP2OaBLmUfIraZfm5ETnUcFX1nSQ4ms4juBCrvUY3F
         AMPQ==
X-Gm-Message-State: ACrzQf3fTvAY9U9OJ1YzXWoGC4qyoDextL6iMDl1A7b1ewyep6vEQRCx
        NCHgZVlebOuPGSw8JPG887bdNYl+xhbIa/EbVENT1g==
X-Google-Smtp-Source: AMsMyM5+0XjUg+rbqjU1P9AGeVmXKI+ReO0zH3sXaihrG7wezbdK7msUP9IIJnkX6tV1MVdR66IeKMH4WYdW9tY2XVE=
X-Received: by 2002:a05:6402:540d:b0:450:bda7:f76e with SMTP id
 ev13-20020a056402540d00b00450bda7f76emr20009652edb.249.1664823799850; Mon, 03
 Oct 2022 12:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220910212804.670622-1-davidgow@google.com> <CAF-60z0Tmr_DkJumaT6O84EQoR_XEJVYaT2TTYcwGFfJETD1KA@mail.gmail.com>
In-Reply-To: <CAF-60z0Tmr_DkJumaT6O84EQoR_XEJVYaT2TTYcwGFfJETD1KA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 Oct 2022 12:03:08 -0700
Message-ID: <CAGS_qxqWnu8V3Rj=v7z-M+LfNYyEciMtxUBS=5KBeAb8SC_D7A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] kunit: Support redirecting function calls
To:     Joe Fradley <joefradley@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 8:59 AM Joe Fradley <joefradley@google.com> wrote:
> Regarding the implementation, could there be more granualitary in the
> activation of these stubs? Considering there's a small amount overhead
> for these stubs when CONFIG_KUNIT is enabled, a developer's environment
> could be adversely affected when they're testing a completely different
> area that doesn't require mocks.
>
> Maybe only activate these with CONFIG_KUNIT_FTRACE_STUBS and
> CONFIG_KUNIT_STATIC_STUBS respectively?

Just to clarify, for ftrace, there shouldn't be overhead unless a stub is used.
So it's not relevant for the following discussion.

But for "static stubs", KUNIT_STATIC_STUB_REDIRECT() checks for
current->kunit_test and kunit_find_resource() call to look for
potential stubs.

The current->kunit_test overhead should go away if we use a static key
[1] instead to track if KUnit is running.
David has a patch he's working on to do just that.
So the overhead for Android when tests aren't running should mostly vanish.

But there's still overhead when you *are* running tests.
As you pointed out, all KUNIT_STATIC_STUB_REDIRECT() callsites will
have overhead, even in functions you never intend to stub out.
I.e. there's an O(n) scan of the resource list for potential stubs
_for every single call_.

We could add a CONFIG_KUNIT_STATIC_STUBS option and have
KUNIT_STATIC_STUB_REDIRECT() be a no-op in that case.
But if you have it turned on, then all the overhead comes back, even
for functions you don't care to test.
And given the goal is that this feature be useful and ubiquitous
enough, that would be the steady state.

I feel like we'd need to wait to see how this feature gets used to determine
1) if we should try and reduce the overhead
2) how we go about doing so (e.g. separate list for stubs, static
keys, hash-based lookups of stubs, etc.)

If people are mostly going to use ftrace, then this might not be worth
trying to address.

[1] https://docs.kernel.org/staging/static-keys.html

Daniel
