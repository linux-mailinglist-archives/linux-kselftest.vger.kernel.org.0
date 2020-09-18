Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831EF270407
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRSbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIRSbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:31:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10947C0613CF
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:31:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x10so6291361ybj.19
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=DeXDuUtT3ERKXFaZ9czxvy+mnBXL+Q8IuCQwjq+CRG8=;
        b=tYG3PAYZyuB+gJ3pWzCBZjfjLT7d3sDXpWSyPtQyYeyLXbJJdrq7j17QtuNuEnRNQK
         IoQPWyuyfJu0OjMWuVEZ3facRh9WgLXK/LaSau4Lr7k7NniMv9zbCTlIVG97Sk/AfBL4
         h8aXdmxAt4XTx3fN2q4B6CbR6UBeJwQnK414FyTcSaxYCRFq3W372Rk2dN1c5o0X4KL4
         dQ4QuHO9X6DMhD7Bc64aEBZBr1ItgdUrDyjir04eLWfbeA367LTSSNJ13blp4tATY/oy
         2hj3B4F+I1vV8xxONGAtRoDDu/Wu95tueyvoAAEro2UQx45pGSkKUY1Lws5gYc3/H70A
         gyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=DeXDuUtT3ERKXFaZ9czxvy+mnBXL+Q8IuCQwjq+CRG8=;
        b=EGcot9KbWIhywWVZzXVtlCEm5W1UGKQDBSvyR2VRxMEbqU4xYGH+q0FMULZm4MOSAM
         GF/Dj0pdKOES45i/2Vh/mSJPVO4vwcpIqOoMOQtib9Fu1yh+00NJp8VPK31Ookv1JcaO
         yBmHAPhH9Zh7xroAoTz0uMQc2gtxDOxJV0r1G2Y/hPWVuwhtF1diQR0Yo4iCyrBpo6R9
         eNiUaRUuXb+n5zuxd1XG6hYrULcekf3nT4OiJ7afTGt+XwpRybtguvJvnRY1qdkhcSrb
         ewLr1C9PceDEYq/AADYA/2wWjSrOOsN0A/zqdmCXX4ONhK1ipjNqYGxAKGn6toTfkNr1
         trzg==
X-Gm-Message-State: AOAM530TrLQSwlG5ZldFuCn9/VUQxZ+F93jM9qBvkvZzcf2srRpTx/eu
        S5C8cONFxmy/9wQD8uPBX0XJypvnHAftNw==
X-Google-Smtp-Source: ABdhPJxj54cIniYTUS8GJ7IQ2SLQ8DyD9JSQR5BoXLZT7An3oX7WrlY1DKW/CX0tANCLPN/uegZLvvRSbKJHJw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:df13:: with SMTP id
 w19mr18988278ybg.145.1600453901181; Fri, 18 Sep 2020 11:31:41 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:02 -0700
Message-Id: <20200918183114.2571146-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 00/12] kunit: introduce class mocking support.
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

# Background
KUnit currently lacks any first-class support for mocking.
For an overview and discussion on the pros and cons, see
https://martinfowler.com/articles/mocksArentStubs.html

This patch set introduces the basic machinery needed for mocking:
setting and validating expectations, setting default actions, etc.

Using that basic infrastructure, we add macros for "class mocking", as
it's probably the easiest type of mocking to start with.

## Class mocking

By "class mocking", we're referring mocking out function pointers stored
in structs like:
  struct sender {
  	int (*send)(struct sender *sender, int data);
  };

After the necessary DEFINE_* macros, we can then write code like
  struct MOCK(sender) mock_sender = CONSTRUCT_MOCK(sender, test);

  /* Fake an error for a specific input. */
  handle = KUNIT_EXPECT_CALL(send(<omitted>, kunit_int_eq(42)));
  handle->action = kunit_int_return(test, -EINVAL);

  /* Pass the mocked object to some code under test. */
  KUNIT_EXPECT_EQ(test, -EINVAL, send_message(...));

I.e. the goal is to make it easier to test
1) with less dependencies (we don't need to setup a real `sender`)
2) unusual/error conditions more easily.

In the future, we hope to build upon this to support mocking in more
contexts, e.g. standalone funcs, etc.

# TODOs

## Naming
This introduces a number of new macros for dealing with mocks,
e.g:
  DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
                           RETURNS(int),
                           PARAMS(struct example *, int));
  ...
  KUNIT_EXPECT_CALL(foo(mock_get_ctrl(mock_example), ...);
For consistency, we could prefix everything with KUNIT, e.g.
`KUNIT_DEFINE_STRUCT_CLASS_MOCK` and `kunit_mock_get_ctrl`, but it feels
like the names might be long enough that they would hinder readability.

## Usage
For now the only use of class mocking is in kunit-example-test.c
As part of changing this from an RFC to a real patch set, we're hoping
to include at least one example.

Pointers to bits of code where this would be useful that aren't too
hairy would be appreciated.
E.g. could easily add a test for tools/perf/ui/progress.h, e.g. that
ui_progress__init() calls ui_progress_ops.init(), but that likely isn't
useful to anyone.


Brendan Higgins (9):
  kunit: test: add kunit_stream a std::stream like logger
  kunit: test: add concept of post conditions
  checkpatch: add support for struct MOCK(foo) syntax
  kunit: mock: add parameter list manipulation macros
  kunit: mock: add internal mock infrastructure
  kunit: mock: add basic matchers and actions
  kunit: mock: add class mocking support
  kunit: mock: add struct param matcher
  kunit: mock: implement nice, strict and naggy mock distinctions

Daniel Latypov (2):
  Revert "kunit: move string-stream.h to lib/kunit"
  kunit: expose kunit_set_failure() for use by mocking

Marcelo Schmitt (1):
  kunit: mock: add macro machinery to pick correct format args

 include/kunit/assert.h                 |   3 +-
 include/kunit/kunit-stream.h           |  94 +++
 include/kunit/mock.h                   | 902 +++++++++++++++++++++++++
 include/kunit/params.h                 | 305 +++++++++
 {lib => include}/kunit/string-stream.h |   2 +
 include/kunit/test.h                   |   9 +
 lib/kunit/Makefile                     |   9 +-
 lib/kunit/assert.c                     |   2 -
 lib/kunit/common-mocks.c               | 409 +++++++++++
 lib/kunit/kunit-example-test.c         |  90 +++
 lib/kunit/kunit-stream.c               | 110 +++
 lib/kunit/mock-macro-test.c            | 241 +++++++
 lib/kunit/mock-test.c                  | 531 +++++++++++++++
 lib/kunit/mock.c                       | 370 ++++++++++
 lib/kunit/string-stream-test.c         |   3 +-
 lib/kunit/string-stream.c              |   5 +-
 lib/kunit/test.c                       |  15 +-
 scripts/checkpatch.pl                  |   4 +
 18 files changed, 3091 insertions(+), 13 deletions(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 include/kunit/mock.h
 create mode 100644 include/kunit/params.h
 rename {lib => include}/kunit/string-stream.h (95%)
 create mode 100644 lib/kunit/common-mocks.c
 create mode 100644 lib/kunit/kunit-stream.c
 create mode 100644 lib/kunit/mock-macro-test.c
 create mode 100644 lib/kunit/mock-test.c
 create mode 100644 lib/kunit/mock.c


base-commit: 10b82d5176488acee2820e5a2cf0f2ec5c3488b6
-- 
2.28.0.681.g6f77f65b4e-goog

