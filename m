Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54835AB92
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Apr 2021 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhDJHF7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Apr 2021 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhDJHF6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Apr 2021 03:05:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10EC061764
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Apr 2021 00:05:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x11so4784373qki.22
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Apr 2021 00:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=dg+DEOFhZoTD7YuipHSWP7rFu7usavK/AqGGNE1MsEo=;
        b=CqrubxNWGOqMFlWtCDFuYRI6BwZUxMbSwCv7+PwHNBuiJMSHErQvNPKR/lmbVirnET
         Cwj1Niebl2pa4buq50GDRQqm7XaAnw6CiLu4zm49mqzc6PBXcxA941EJNLm+ujvY71l/
         NPMko1wQE7sL8lOmkGR3Bb1SUu35/50R6kWzOTW8dMgbUJYyBVBEv/YmUUvbBm7KQ9dL
         Cl3L4ajgl9YYDbJdpXTm9sUgEboY36TW8WZU6tqF8G+dpYg4tAPH97G76P33PMI0g9IR
         cHXAxQu1Gt2aWM1EhJHMhIiGXs/io/FaD9b7iEVw0lVuS0iLozSf7/x96C8vu26klQAf
         BPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=dg+DEOFhZoTD7YuipHSWP7rFu7usavK/AqGGNE1MsEo=;
        b=dS949UsPvpYkDnvZi8IoSBWg2048zpdMSxGLRWFPD7wR2dLcI+ZYKJSq1Hl96wc42n
         lwrml7K/Xk00KY2d5iWlVUjMzNGvrs6CNegkQ9n8zrcmzOibk8lN5dEPjUVpOymesUWI
         MVTv6o3uHoL6ElAK+1SIrroVWhT3syrDPvURttJ2DSHB97ZH5khHQRyjsAudpraZaRZF
         vd1s5C1zFWvY8PcfjueCAwR5ezpMx19KoxRLzjQkRGHN3WM6dmTxzWjJNUhtBOZsriR1
         b5TgHs/BakHmpenVa7Mcdo6xS5GHegbNgjDmP0Zlr2DRSSgpmfnAIezbfRisjtUQkT4T
         7pWg==
X-Gm-Message-State: AOAM533SwEcCFefEliyYdENgw5rY5mHsMtuEm00xKr6FR8A1zzNb17w8
        +70hiLHy9mFHD9dcmsi8dHayFPzjuIha0g==
X-Google-Smtp-Source: ABdhPJyv/+jcJ6yI0cEvELtKheEfjqsjvXd0itiD/eULOlwWVf8f5xw+AYtcLhLzSmf9f6f6r4lhCc8eoQwJXQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:f493:fef7:82d5:5e83])
 (user=davidgow job=sendgmr) by 2002:a0c:f74d:: with SMTP id
 e13mr18725327qvo.8.1618038343525; Sat, 10 Apr 2021 00:05:43 -0700 (PDT)
Date:   Sat, 10 Apr 2021 00:05:30 -0700
Message-Id: <20210410070529.4113432-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH] Documentation: dev-tools: Add Testing Overview
From:   David Gow <davidgow@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-doc@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel now has a number of testing and debugging tools, and we've
seen a bit of confusion about what the differences between them are.

Add a basic documentation outlining the testing tools, when to use each,
and how they interact.

This is a pretty quick overview rather than the idealised "kernel
testing guide" that'd probably be optimal, but given the number of times
questions like "When do you use KUnit and when do you use Kselftest?"
are being asked, it seemed worth at least having something. Hopefully
this can form the basis for more detailed documentation later.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/index.rst            |   3 +
 Documentation/dev-tools/testing-overview.rst | 102 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/dev-tools/testing-overview.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 1b1cf4f5c9d9..f590e5860794 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -7,6 +7,8 @@ be used to work on the kernel. For now, the documents have =
been pulled
 together without any significant effort to integrate them into a coherent
 whole; patches welcome!
=20
+A brief overview of testing-specific tools can be found in :doc:`testing-o=
verview`.
+
 .. class:: toc-title
=20
 	   Table of contents
@@ -14,6 +16,7 @@ whole; patches welcome!
 .. toctree::
    :maxdepth: 2
=20
+   testing-overview
    coccinelle
    sparse
    kcov
diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/d=
ev-tools/testing-overview.rst
new file mode 100644
index 000000000000..8452adcb8608
--- /dev/null
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Kernel Testing Guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+There are a number of different tools for testing the Linux kernel, so kno=
wing
+when to use each of them can be a challenge. This document provides a roug=
h
+overview of their differences, and how they fit together.
+
+
+Writing and Running Tests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The bulk of kernel tests are written using either the :doc:`kselftest
+<kselftest>` or :doc:`KUnit <kunit/index>` frameworks. These both provide
+infrastructure to help make running tests and groups of tests easier, as w=
ell
+as providing helpers to aid in writing new tests.
+
+If you're looking to verify the behaviour of the Kernel =E2=80=94 particul=
arly specific
+parts of the kernel =E2=80=94 then you'll want to use `KUnit` or `kselftes=
t`.
+
+
+The Difference Between KUnit and kselftest
+------------------------------------------
+
+:doc:`KUnit <kunit/index>` is an entirely in-kernel system for "white box"
+testing: because test code is part of the kernel, it can access internal
+structures and functions which aren't exposed to userspace.
+
+`KUnit` tests therefore are best written against small, self-contained par=
ts
+of the kernel, which can be tested in isolation. This aligns well with the
+concept of Unit testing.
+
+For example, a KUnit test might test an individual kernel function (or eve=
n a
+single codepath through a function, such as an error handling case), rathe=
r
+than a feature as a whole.
+
+There is a KUnit test style guide which may give further pointers
+
+
+:doc:`kselftest <kselftest>`, on the other hand, is largely implemented in
+userspace, and tests are normal userspace scripts or programs.
+
+This makes it easier to write more complicated tests, or tests which need =
to
+manipulate the overall system state more (e.g., spawning processes, etc.).
+However, it's not possible to call kernel functions directly unless they'r=
e
+exposed to userspace (by a syscall, device, filesystem, etc.) Some tests t=
o
+also provide a kernel module which is loaded by the test, though for tests
+which run mostly or entirely within the kernel, `KUnit` may be the better =
tool.
+
+`kselftest` is therefore suited well to tests of whole features, as these =
will
+expose an interface to userspace, which can be tested, but not implementat=
ion
+details. This aligns well with 'system' or 'end-to-end' testing.
+
+
+Code Coverage Tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Linux Kernel supports two different code coverage mesurement tools. Th=
ese
+can be used to verify that a test is executing particular functions or lin=
es
+of code. This is useful for determining how much of the kernel is being te=
sted,
+and for finding corner-cases which are not covered by the appropriate test=
.
+
+:doc:`kcov` is a feature which can be built in to the kernel to allow
+capturing coverage on a per-task level. It's therefore useful for fuzzing =
and
+other situations where information about code executed during, for example=
, a
+single syscall is useful.
+
+:doc:`gcov` is GCC's coverage testing tool, which can be used with the ker=
nel
+to get global or per-module coverage. Unlike KCOV, it does not record per-=
task
+coverage. Coverage data can be read from debugfs, and interpreted using th=
e
+usual gcov tooling.
+
+
+Sanitizers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The kernel also supports a number of sanitizers, which attempt to detect
+classes of issues when the occur in a running kernel. These typically
+look for undefined behaviour of some kind, such as invalid memory accesses=
,
+concurrency issues such as data races, or other undefined behaviour like
+integer overflows.
+
+* :doc:`kmemleak` (Kmemleak) detects possible memory leaks.
+* :doc:`kasan` detects invalid memory accesses such as out-of-bounds and
+  use-after-free errors.
+* :doc:`ubsan` detects behaviour that is undefined by the C standard, like
+  integer overflows.
+* :doc:`kcsan` detects data races.
+* :doc:`kfence` is a low-overhead detector of memory issues, which is much
+  faster than KASAN and can be used in production.
+
+These tools tend to test the kernel as a whole, and do not "pass" like
+kselftest or KUnit tests. They can be combined with KUnit or kselftest by
+running tests on a kernel with a sanitizer enabled: you can then be sure
+that none of these errors are occurring during the test.
+
+Some of these sanitizers integrate with KUnit or kselftest and will
+automatically fail tests if an issue is detected by a sanitizer.
+
--=20
2.31.1.295.g9ea45b61b8-goog

