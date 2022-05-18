Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2E52BF23
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiERPgd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiERPgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:36:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E42E68
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:36:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p139so4288706ybc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kF21wFqfnoIq6E9PfI/et5u3jsgWYenFv/GCYPgvGFo=;
        b=Dl7ZXvqHdkFHHfpvPRKwaSX9HtbIFsnA21kFfVReO/FlBq0NbxcIE7HBg0ZK/1twUl
         N0b86zqrVuzFvLSsrs9zmnEs85rt8x2jgnyJ6R8mbOIgXj16mnv5EL4B345okCAbSjd8
         JPlreGY/K69hPfE85mXC597DnPJ982ZbK7cCx6WDzIBzHaa2BOM/GMdk/bNYbNWUiNTX
         Vg6xaMEso5yqYJ2yLz04zbRL9ovtAMbij0fbgo/shCrWZrqR9+cP0OvCRNCpon9cVimc
         G4vBZHgmIc7xt/fEuY1J4idjTmWhAXDvR6hr2PZE1j2w1iChgxpcG1aPZOKRhbQ9wOFc
         ikIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kF21wFqfnoIq6E9PfI/et5u3jsgWYenFv/GCYPgvGFo=;
        b=0Co8gRtaLiLtCcAw6PdF0nJNFTiXZ4rcKHiWFUi9pRAWbTh+pG599TDi640MQxs3ew
         RTTM5lkpjOonuDAz5zKACt7Aah4oY9HB65iYMgJFOrhOHJkoXMk53fNY6nhtSk0rAlgK
         7FzZmsP5UXV6QvDpUiWk8zXf7e2gqUFkbJbsU8w1HxGVMaZLM5Y0O9XdAAYdrfou9NHR
         AQ1DaQttf5Q8ykuTkkEiOfJYC17ufKVY2hKh6GjJdszaGoBEVozR5+KWRVWwIYP23RU7
         PUBHTn5yaUvJjeQOv5Q0Zm76FyRh27IHtJ7f4bh4Ywu/Lrr8kv6ge50Ou5wNiX7IZFLG
         j+Pw==
X-Gm-Message-State: AOAM532dI/WdEQzkPHF7ut9/B0h/SwkH5Rilhn3mMzpFWK0iQ41qJbz5
        qRq0IlOgzzYROPrWn+zeV9kMIcvUatmczSQ/bU7VYw==
X-Google-Smtp-Source: ABdhPJwG02uHnQK4LGyyxI05x6DXQeuqD7zYnQ4JVQKs+mGZyUa2XmGgof24y4NzNhTTv5jQFZHm/J/CT4HJkQgJCPM=
X-Received: by 2002:a25:2d4b:0:b0:64d:a722:b4ae with SMTP id
 s11-20020a252d4b000000b0064da722b4aemr180011ybe.87.1652888176675; Wed, 18 May
 2022 08:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
In-Reply-To: <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 18 May 2022 17:35:40 +0200
Message-ID: <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 18 May 2022 at 17:31, Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, May 18, 2022 at 12:32 AM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> > 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> > setup, so this is the best bet for testing things like KCSAN, which
> > require a multicore/multi-cpu system.
> >
> > The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> > KCSAN to run with a nontrivial number of worker threads, while still
> > working relatively quickly on older machines.
> >
>
> Since it's arbitrary, I somewhat prefer the idea of leaving up
> entirely to the caller
> i.e.
> $ kunit.py run --kconfig_add=CONFIG_SMP=y --qemu_args '-smp 8'
>
> We could add CONFIG_SMP=y to the default qemu_configs/*.py and do
> $ kunit.py run --qemu_args '-smp 8'
> but I'd prefer the first, even if it is more verbose.
>
> Marco, does this seem reasonable from your perspective?

Either way works. But I wouldn't mind a sane default though, where
that default can be overridden with custom number of CPUs.

> I think that a new --qemu_args would be generically useful for adhoc
> use and light enough that people won't need to add qemu_configs much.
> E.g. I can see people wanting multiple NUMA nodes, a specific -cpu, and so on.
