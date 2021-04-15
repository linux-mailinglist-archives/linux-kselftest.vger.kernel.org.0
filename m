Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4773601C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhDOFlO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 01:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhDOFlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 01:41:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537CC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 22:40:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e9so1614030ybq.22
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Jw57YJtm3Q/Ozu8YHxC0uN3JKwkHNeAwwOcyb9QIpMc=;
        b=TZZznNXv1gQh5v8XxnjJjiIib5D1Cy6i7i1xeGf4VIE2hN60IzBjf+e1xVbJHgyLqu
         D9hIgVPH6PtkDCUQMjtF87uyVzEqg9f2qJcmRXKvfx5ZE8pHmOQ4FOveokP5HaYMePmK
         CrF724powwFEaihKsBHA9CU2kXtOMxkUYT4OjgmuMGDrAykWg5vc6xhbDud7nSbS2UYd
         aPAb8ZfzujEI6Bt2NIbPWlHFncGN+euFPqK7FjaYMSEQXK4/ZOPa88Hzgv16zxnCYK4F
         XsCA6VXyvACljBBITV9hQN7xrOsMKua5R6LLzrE2Iahi9aTqTpbteofs3nGjslFhzsm1
         iByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Jw57YJtm3Q/Ozu8YHxC0uN3JKwkHNeAwwOcyb9QIpMc=;
        b=me3XUE7LoRrb18XtzB3RLyBTxDUkA/Yp05TosUEy68gNeU3/2rqjkDxHA70DsNzLQv
         pMr4qVmy0uXr2m9BnYDdPzpxNPaniXaU+v10lwN1EQlj5FsJmGWZQPQUOuukaM6vA8VA
         qlquO320A0l5IkjCaESs9vkzt+DaQ9p6WjB+61ZvPzWmKel8pzEUMlA60Gt43Be1KSTH
         v0n4dyLb2Orjgu35MkY7gez1lfTUS27ADLxGVWW3ISZ7bTn3AAv2WVGEOnvqJFH5E8l2
         jyVDXmcQ4SWO3xY9tJVbWQZUUrHiDgNgTNZqVUSRMLsivjTjbjO8K061tcfCYSrrkqT6
         dUWg==
X-Gm-Message-State: AOAM531U2kMyQierqQa4GlNPb6XtA5+nce/urknhD2BAktq1UFy4kTe8
        PAbVUMwboq7xUA15ZZBsGaKrDlooArF/wg==
X-Google-Smtp-Source: ABdhPJxEHmxBvUfnU4q4nijbRCAXrZ8CptI8Si0HP1n/+6oPHEBAsOzq+UJGXCBMcjRnrd1ABqKs1QoAQ+TG5A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:1cee:9df3:58b2:13ce])
 (user=davidgow job=sendgmr) by 2002:a25:b746:: with SMTP id
 e6mr2336118ybm.187.1618465245572; Wed, 14 Apr 2021 22:40:45 -0700 (PDT)
Date:   Wed, 14 Apr 2021 22:40:36 -0700
Message-Id: <20210415054036.581117-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v3] Documentation: dev-tools: Add Testing Overview
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
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Thanks again. Assuming no-one has any objections, I think this is good
to go.

-- David

Changes since v2:
https://lore.kernel.org/linux-kselftest/20210414081428.337494-1-davidgow@go=
ogle.com/
- A few typo fixes (Thanks Daniel)
- Reworded description of dynamic analysis tools.
- Updated dev-tools index page to not use ':doc:' syntax, but to provide
  a path instead.
- Added Marco and Daniel's Reviewed-by tags.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210410070529.4113432-1-davidgow@g=
oogle.com/
- Note KUnit's speed and that one should provide selftests for syscalls
- Mention lockdep as a Dynamic Analysis Tool
- Refer to "Dynamic Analysis Tools" instead of "Sanitizers"
- A number of minor formatting tweaks and rewordings for clarity

 Documentation/dev-tools/index.rst            |   4 +
 Documentation/dev-tools/testing-overview.rst | 117 +++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/dev-tools/testing-overview.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/in=
dex.rst
index 1b1cf4f5c9d9..929d916ffd4c 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -7,6 +7,9 @@ be used to work on the kernel. For now, the documents have =
been pulled
 together without any significant effort to integrate them into a coherent
 whole; patches welcome!
=20
+A brief overview of testing-specific tools can be found in
+Documentation/dev-tools/testing-overview.rst
+
 .. class:: toc-title
=20
 	   Table of contents
@@ -14,6 +17,7 @@ whole; patches welcome!
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
index 000000000000..b5b46709969c
--- /dev/null
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -0,0 +1,117 @@
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
+The bulk of kernel tests are written using either the kselftest or KUnit
+frameworks. These both provide infrastructure to help make running tests a=
nd
+groups of tests easier, as well as providing helpers to aid in writing new
+tests.
+
+If you're looking to verify the behaviour of the Kernel =E2=80=94 particul=
arly specific
+parts of the kernel =E2=80=94 then you'll want to use KUnit or kselftest.
+
+
+The Difference Between KUnit and kselftest
+------------------------------------------
+
+KUnit (Documentation/dev-tools/kunit/index.rst) is an entirely in-kernel s=
ystem
+for "white box" testing: because test code is part of the kernel, it can a=
ccess
+internal structures and functions which aren't exposed to userspace.
+
+KUnit tests therefore are best written against small, self-contained parts
+of the kernel, which can be tested in isolation. This aligns well with the
+concept of 'unit' testing.
+
+For example, a KUnit test might test an individual kernel function (or eve=
n a
+single codepath through a function, such as an error handling case), rathe=
r
+than a feature as a whole.
+
+This also makes KUnit tests very fast to build and run, allowing them to b=
e
+run frequently as part of the development process.
+
+There is a KUnit test style guide which may give further pointers in
+Documentation/dev-tools/kunit/style.rst
+
+
+kselftest (Documentation/dev-tools/kselftest.rst), on the other hand, is
+largely implemented in userspace, and tests are normal userspace scripts o=
r
+programs.
+
+This makes it easier to write more complicated tests, or tests which need =
to
+manipulate the overall system state more (e.g., spawning processes, etc.).
+However, it's not possible to call kernel functions directly from kselftes=
t.
+This means that only kernel functionality which is exposed to userspace so=
mehow
+(e.g. by a syscall, device, filesystem, etc.) can be tested with kselftest=
.  To
+work around this, some tests include a companion kernel module which expos=
es
+more information or functionality. If a test runs mostly or entirely withi=
n the
+kernel, however,  KUnit may be the more appropriate tool.
+
+kselftest is therefore suited well to tests of whole features, as these wi=
ll
+expose an interface to userspace, which can be tested, but not implementat=
ion
+details. This aligns well with 'system' or 'end-to-end' testing.
+
+For example, all new system calls should be accompanied by kselftest tests=
.
+
+Code Coverage Tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Linux Kernel supports two different code coverage measurement tools. T=
hese
+can be used to verify that a test is executing particular functions or lin=
es
+of code. This is useful for determining how much of the kernel is being te=
sted,
+and for finding corner-cases which are not covered by the appropriate test=
.
+
+:doc:`gcov` is GCC's coverage testing tool, which can be used with the ker=
nel
+to get global or per-module coverage. Unlike KCOV, it does not record per-=
task
+coverage. Coverage data can be read from debugfs, and interpreted using th=
e
+usual gcov tooling.
+
+:doc:`kcov` is a feature which can be built in to the kernel to allow
+capturing coverage on a per-task level. It's therefore useful for fuzzing =
and
+other situations where information about code executed during, for example=
, a
+single syscall is useful.
+
+
+Dynamic Analysis Tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The kernel also supports a number of dynamic analysis tools, which attempt=
 to
+detect classes of issues when they occur in a running kernel. These typica=
lly
+each look for a different class of bugs, such as invalid memory accesses,
+concurrency issues such as data races, or other undefined behaviour like
+integer overflows.
+
+Some of these tools are listed below:
+
+* kmemleak detects possible memory leaks. See
+  Documentation/dev-tools/kmemleak.rst
+* KASAN detects invalid memory accesses such as out-of-bounds and
+  use-after-free errors. See Documentation/dev-tools/kasan.rst
+* UBSAN detects behaviour that is undefined by the C standard, like intege=
r
+  overflows. See Documentation/dev-tools/ubsan.rst
+* KCSAN detects data races. See Documentation/dev-tools/kcsan.rst
+* KFENCE is a low-overhead detector of memory issues, which is much faster=
 than
+  KASAN and can be used in production. See Documentation/dev-tools/kfence.=
rst
+* lockdep is a locking correctness validator. See
+  Documentation/locking/lockdep-design.rst
+* There are several other pieces of debug instrumentation in the kernel, m=
any
+  of which can be found in lib/Kconfig.debug
+
+These tools tend to test the kernel as a whole, and do not "pass" like
+kselftest or KUnit tests. They can be combined with KUnit or kselftest by
+running tests on a kernel with these tools enabled: you can then be sure
+that none of these errors are occurring during the test.
+
+Some of these tools integrate with KUnit or kselftest and will
+automatically fail tests if an issue is detected.
+
--=20
2.31.1.295.g9ea45b61b8-goog

