Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8C2A326E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgKBSAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKBSAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 13:00:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8EC0617A6
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Nov 2020 10:00:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o129so11790222pfb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCS8+Foym0V3+0lDcQEbg6YNaDy+BKQJweT9xWhLD6U=;
        b=WRYlpH7a96POABS9s0MQrALwydcOMlPt3dJUSkIW1s+A3yFw6H1Aic3HU+Sy7qFQpc
         vmL9BB6rwGKUex2Xw/uwpzkeoBDP80Qc7R25CGCks0ZNYA9zEZpudFs6SajrK/+CUz/E
         xGcjt3lg2iTT/50AHF0h90Wow3/dAvEVQtEKOxesCYYZtNYvfaexobSiUTsQRRcR+Z8v
         XChiuVDzYKdGt51m/Qson+1W8tU/PKrHb9feBpiHA9a2mAJSpbiFOe5JeT4dUSO90q6v
         //LGaw2txuHywdVHc4+xfOzHlHJifppn4x3UEYjNnM30SEdWA8XuX0LRo5bCcR1sFmVz
         Bmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCS8+Foym0V3+0lDcQEbg6YNaDy+BKQJweT9xWhLD6U=;
        b=fZJWCZSvIiAHp4b4768dcbi9x8/cORRZrObiVUwO6JyJ94XB6DL64kJPfpuVxFq3sI
         Qzigp54rXE976Mkl8iOEjHUbLgc/pqPeAcWidf6K6wbr99Itf9FL+DaowIUJCrebrtUk
         +bDIF7hemfcLBUPsZFyPM4KUkZz/aouDrtKRuZDwDfZIbe4llELJloFC3N/qLUsHeBFb
         iIp+uvrSW3hfRUEpf7H7tnXjwG0GdYLL5iT7xk5gdTZKitdvuADM+Wg+eGmGxhD4uJdL
         SO1VFrdPnIu/LJfuiy38dOqEU5bGXmgxXq3hbOJUzkJwvhQ/9MTKOwj4yD4KBf/Cs112
         qSXg==
X-Gm-Message-State: AOAM533v0XZ0o76DNqPdD98qvPsaS6BrdhebfEBjSvpGAX2j+BiZws7q
        L0fOLmkHING05TvglEhZaZmV6nJX6l+753I8f51Ddw==
X-Google-Smtp-Source: ABdhPJywSgxMdnM1FRrYcgCzQSM1DiB2wRZWCaPsou6QXTFAY8X8jeHj6iUML+/rYs26RFWYkhsL131C0UNB3hwW6iw=
X-Received: by 2002:a17:90a:de94:: with SMTP id n20mr6747196pjv.217.1604340039685;
 Mon, 02 Nov 2020 10:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Nov 2020 10:00:28 -0800
Message-ID: <CAFd5g45kdj8mTqStN6hreJEaa47z3+2ZXQDnzZ=Nz6vA50x=Gg@mail.gmail.com>
Subject: Re: [RFC v2 00/12] kunit: introduce class mocking support.
To:     Daniel Latypov <dlatypov@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Joel Stanley +Daniel Vetter

If I remember correctly, both of you said you were interested in
mocking on KUnit. This RFC only has some of the mocking features that
I mentioned previously, but I would still like to get your thoughts.

On Mon, Oct 12, 2020 at 3:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> # Background
> KUnit currently lacks any first-class support for mocking.
> For an overview and discussion on the pros and cons, see
> https://martinfowler.com/articles/mocksArentStubs.html
>
> This patch set introduces the basic machinery needed for mocking:
> setting and validating expectations, setting default actions, etc.
>
> Using that basic infrastructure, we add macros for "class mocking", as
> it's probably the easiest type of mocking to start with.
>
> ## Class mocking
>
> By "class mocking", we're referring mocking out function pointers stored
> in structs like:
>   struct sender {
>         int (*send)(struct sender *sender, int data);
>   };
> or in ops structs
>   struct sender {
>         struct send_ops *ops; // contains `send`
>   };
>
> After the necessary DEFINE_* macros, we can then write code like
>   struct MOCK(sender) mock_sender = CONSTRUCT_MOCK(sender, test);
>
>   /* Fake an error for a specific input. */
>   handle = KUNIT_EXPECT_CALL(send(<omitted>, kunit_int_eq(42)));
>   handle->action = kunit_int_return(test, -EINVAL);
>
>   /* Pass the mocked object to some code under test. */
>   KUNIT_EXPECT_EQ(test, -EINVAL, send_message(...));
>
> I.e. the goal is to make it easier to test
> 1) with less dependencies (we don't need to setup a real `sender`)
> 2) unusual/error conditions more easily.
>
> In the future, we hope to build upon this to support mocking in more
> contexts, e.g. standalone funcs, etc.
>
> # TODOs
>
> ## Naming
> This introduces a number of new macros for dealing with mocks,
> e.g:
>   DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
>                            RETURNS(int),
>                            PARAMS(struct example *, int));
>   ...
>   KUNIT_EXPECT_CALL(foo(mock_get_ctrl(mock_example), ...);
> For consistency, we could prefix everything with KUNIT, e.g.
> `KUNIT_DEFINE_STRUCT_CLASS_MOCK` and `kunit_mock_get_ctrl`, but it feels
> like the names might be long enough that they would hinder readability.
>
> ## Usage
> For now the only use of class mocking is in kunit-example-test.c
> As part of changing this from an RFC to a real patch set, we're hoping
> to include at least one example.
>
> Pointers to bits of code where this would be useful that aren't too
> hairy would be appreciated.
> E.g. could easily add a test for tools/perf/ui/progress.h, e.g. that
> ui_progress__init() calls ui_progress_ops.init(), but that likely isn't
> useful to anyone.
>
> ---
> v2:
> * Pass `struct kunit *` to mock init's to allow allocating ops structs.
> * Update kunit-example-test.cc to do so as a more realistic example.
> v1: https://lore.kernel.org/linux-kselftest/20200918183114.2571146-1-dlatypov@google.com/
> ---
>
> Brendan Higgins (9):
>   kunit: test: add kunit_stream a std::stream like logger
>   kunit: test: add concept of post conditions
>   checkpatch: add support for struct MOCK(foo) syntax
>   kunit: mock: add parameter list manipulation macros
>   kunit: mock: add internal mock infrastructure
>   kunit: mock: add basic matchers and actions
>   kunit: mock: add class mocking support
>   kunit: mock: add struct param matcher
>   kunit: mock: implement nice, strict and naggy mock distinctions
>
> Daniel Latypov (2):
>   Revert "kunit: move string-stream.h to lib/kunit"
>   kunit: expose kunit_set_failure() for use by mocking
>
> Marcelo Schmitt (1):
>   kunit: mock: add macro machinery to pick correct format args
>
>  include/kunit/assert.h                 |   3 +-
>  include/kunit/kunit-stream.h           |  94 +++
>  include/kunit/mock.h                   | 902 +++++++++++++++++++++++++
>  include/kunit/params.h                 | 305 +++++++++
>  {lib => include}/kunit/string-stream.h |   2 +
>  include/kunit/test.h                   |   9 +
>  lib/kunit/Makefile                     |   9 +-
>  lib/kunit/assert.c                     |   2 -
>  lib/kunit/common-mocks.c               | 409 +++++++++++
>  lib/kunit/kunit-example-test.c         |  98 +++
>  lib/kunit/kunit-stream.c               | 110 +++
>  lib/kunit/mock-macro-test.c            | 241 +++++++
>  lib/kunit/mock-test.c                  | 531 +++++++++++++++
>  lib/kunit/mock.c                       | 370 ++++++++++
>  lib/kunit/string-stream-test.c         |   3 +-
>  lib/kunit/string-stream.c              |   5 +-
>  lib/kunit/test.c                       |  15 +-
>  scripts/checkpatch.pl                  |   4 +
>  18 files changed, 3099 insertions(+), 13 deletions(-)
>  create mode 100644 include/kunit/kunit-stream.h
>  create mode 100644 include/kunit/mock.h
>  create mode 100644 include/kunit/params.h
>  rename {lib => include}/kunit/string-stream.h (95%)
>  create mode 100644 lib/kunit/common-mocks.c
>  create mode 100644 lib/kunit/kunit-stream.c
>  create mode 100644 lib/kunit/mock-macro-test.c
>  create mode 100644 lib/kunit/mock-test.c
>  create mode 100644 lib/kunit/mock.c
>
>
> base-commit: 10b82d5176488acee2820e5a2cf0f2ec5c3488b6
> --
> 2.28.0.1011.ga647a8990f-goog
>
