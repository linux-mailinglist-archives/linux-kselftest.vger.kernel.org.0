Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED010274DCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgIWAY6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgIWAY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 20:24:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F10C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 17:24:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q5so12594730ilj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22z2o3zRVcc0e/vm/tTsJvCKG6pWnKo32sxDAjGNRQM=;
        b=MFiycCcSrtEORo7U7YiSmkKWaWvAD/zh9ujSqXbN4v5DFcDYaJRjK0IQm6ujQi9sCC
         TPP60v9Dl4aPkOLFQtsUpLS6YiwX9rs/zk3OrXfEDCyYYgy+LbrsW8dFHo6Gs3ChJvgW
         ztTZEdcCaA6+8LJF0dcRUQREzfu75m4n+mlYt07H0dcLVu4FKgJTIgthDlu4FtQ2ChnK
         dbCYpR9pAzwT5e3N0s4/G16njOk34wuqjddwY+FHBLpqGxGq0mcPnwkDq1yhngzSz5AW
         oc+yl6jgLd2f3HFMC5yhPi+jUNuFJWogVGjFkchAElepMHjdOQ7REii+PZoIf/dw35R4
         tGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22z2o3zRVcc0e/vm/tTsJvCKG6pWnKo32sxDAjGNRQM=;
        b=VYc5HGpcseVt37K2eZQo594UP0RF+0edzeT2JqbLuteexBOQVr3FGsvThFfaGf2BJq
         gUIiFsC5TTKhgSlmjKNLRh6PwayRNtjKPgG5d4mxzdlnUokb9UR5Zog3rF/VAvYn4f5q
         o5U0OtqQpIdQXhzcQUajbD6aP04dWmcu9dczX0iBvZSWugCEQwIt7mXk34L9dNvSNXlA
         3CwgoFiNb9747h1e2p796D8Jg4P7HtQ7G22mAOGZxF1f7euOklHDsK7mYxgNlfNDdmC5
         xk6qk2mkKE8LDpRYTz7gme5avYFvouTd70Ep5b5Bg19lk83Nqzv9r06RrnGFEfdvyYJV
         gDhQ==
X-Gm-Message-State: AOAM533Uqb3srrZpCP3znPbu9mZ4a9yfeJe7QfM+kxki/QqTNjQjg5Wq
        yuuXpAnd+hA5dA6lgW4E1UvQWW9kDwcIavZGIM4dTg==
X-Google-Smtp-Source: ABdhPJyw9neovCgdyECzhy9QuZZ8H8mcTDuJf6HFH2RwiTq8+oM8g5VpzRB7BvCtHJbyT6YmH5WL8Zuy4CmtU8DpxQY=
X-Received: by 2002:a92:9943:: with SMTP id p64mr6499555ili.295.1600820696350;
 Tue, 22 Sep 2020 17:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 22 Sep 2020 17:24:44 -0700
Message-ID: <CAGS_qxpt1NLhh=XEKLCNEayTmB4ZhjOY32XjmL1YRPDnYVvYMw@mail.gmail.com>
Subject: Re: [RFC v1 00/12] kunit: introduce class mocking support.
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 18, 2020 at 11:31 AM Daniel Latypov <dlatypov@google.com> wrote:
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

Discussed this offline a bit with Brendan and David.
The requirement that the first argument is a `sender *` means this
doesn't work for a few common cases.

E.g. ops structs don't usually have funcs that take `XXX_ops *`
`pci_ops` all take a `struct pci_bus *`, which at least contains a
`struct pci_ops*`.

Why does this matter?
We need to stash a  `struct mock` somewhere to store expectations.
For this version of class mocking (in patch 10), we've assumed we could have

struct MOCK(sender) {
         struct mock ctrl;
         struct sender trgt; //&trgt assumed to be the first param
}

Then we can always use `container_of(sender)` to get the MOCK(sender)
which holds `ctrl`.
But if the first parameter isn't a `struct sender*`, this trick
obviously doesn't work.

So to support something like pci_ops, we'd need another approach to
stash `ctrl`.

After thinking a bit more, we could perhaps decouple the first param
from the mocked struct.
Using pci_ops as the example:

struct MOCK(pci_ops) {
         struct mock ctrl;
         struct pci_bus *self; // this is the first param. Using
python terminology here.
         struct pci_ops trgt; // continue to store this, as this holds
the function pointers
}

// Name of this func is currently based on the class we're mocking
static inline struct mock *from_pci_ops_to_mock(
  const struct pci_bus *self)
{
          return mock_get_ctrl(container_of(self, struct MOCK(pci_ops), self));
}

// then in tests, we'd need something like
struct pci_bus bus;
bus.ops = mock_get_trgt(mock_ops);
mock_ops.self = &bus;


Do others have thoughts/opinions?

After grepping around for examples, I'm struck by how the number of
outliers there are.
E.g. most take a `struct thing *` as the first param, but cfspi_ifc in
caif_spi.h opts to take that as the last parameter.
And others take a different mix of structs for each function.

But it feels like a decoupled self / struct-holding-func-pointers
approach should be generic enough, as far as I can tell.
The more exotic types will probably have to remain unsupported.

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
>  lib/kunit/kunit-example-test.c         |  90 +++
>  lib/kunit/kunit-stream.c               | 110 +++
>  lib/kunit/mock-macro-test.c            | 241 +++++++
>  lib/kunit/mock-test.c                  | 531 +++++++++++++++
>  lib/kunit/mock.c                       | 370 ++++++++++
>  lib/kunit/string-stream-test.c         |   3 +-
>  lib/kunit/string-stream.c              |   5 +-
>  lib/kunit/test.c                       |  15 +-
>  scripts/checkpatch.pl                  |   4 +
>  18 files changed, 3091 insertions(+), 13 deletions(-)
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
> 2.28.0.681.g6f77f65b4e-goog
>
