Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAAA35EF57
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Apr 2021 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbhDNIPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349992AbhDNIPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 04:15:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2792C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 01:15:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w30so578036qvf.23
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=AgMaVIscO++7auf6j4FLvgrPACtR9LdIw5C1d+MACFs=;
        b=ff4pFRJqwVZW8nsKGLkvzB4oHNxsMvh2embvkpElPGEOJsCCU0wEgWoXEB2JDRD765
         z8e4cjzxAZbqFC3i8wgnv8tbqXqIZYmF8vD301f1coqJvpCKb8eFbktRg1+WrJHW3Ouc
         qWy/rWB2HjxCrG/+MTRBfJ2yCXdr3fB98p8nX6kRNAO69qTwIgcYivzwKO7FgxCURqny
         ti/tshk++i15GDO99bWrLNvt/HcJONBRJwIqUZ7oWw+oTaUFPBR1qYdHUleqyXTDoY2V
         xTn7B8htI+2KdumXaWrbNIBRXkNTUtvigLefukSXUigsSqwydJ50kx110u3IJAXWyTFk
         SV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=AgMaVIscO++7auf6j4FLvgrPACtR9LdIw5C1d+MACFs=;
        b=aO6qUBQHTB1lqKD64pZtjVdO1ZqW7QwlbLDkUFl27w/uu/kHLgSUPJVeSPkR+V7w9c
         YhnA86rQiEaSckWony5o5Bp8f3reSxxBFhKngq9eTs2ktqDQh5y6kCGhnjsEfjLweyHk
         rQIwR5Pk3qLpt8j00tbHDcc4uFoGogzGMD0am1R1lB2zPDBY6EeY95XgClF53m1rHG5g
         IFTuYEn/66T3fKCSBBl+vX0d9q2qwwMipwLtvvoitzxlHAevXbaU5MUdd4k9pfSoWbiI
         NMzlh/eRMeFItr/Hu6E9u38e0l8VhckfOZ2ymXHtE92OH5uNToKfwv7RiVH8ecBcubV8
         KFiw==
X-Gm-Message-State: AOAM530mIiI30o8gqZPkRBgOAl5qdpvSzmlqrbsBkQbGvQlT1TsY8Xhw
        ud4iK/hQxMeUTCKNWtb7QBXaU5V6umHYqg==
X-Google-Smtp-Source: ABdhPJyabAs4UuXw1jcjxpjLl3apM8l1LDZJ7sbIT+HdhZzAVluRCmTDonUBQFOw/YrIdzycEi12sUgV0yKYmA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:d6a:902e:c89c:e274])
 (user=davidgow job=sendgmr) by 2002:a05:6214:252d:: with SMTP id
 gg13mr19433456qvb.24.1618388125955; Wed, 14 Apr 2021 01:15:25 -0700 (PDT)
Date:   Wed, 14 Apr 2021 01:14:29 -0700
Message-Id: <20210414081428.337494-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2] Documentation: dev-tools: Add Testing Overview
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
Thanks, everyone, for the comments on the doc. I've made a few of the
suggested changes. Please let me know what you think!

-- David

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210410070529.4113432-1-davidgow@g=
oogle.com/
- Note KUnit's speed and that one should provide selftests for syscalls
- Mention lockdep as a Dynamic Analysis Tool
- Refer to "Dynamic Analysis Tools" instead of "Sanitizers"
- A number of minor formatting tweaks and rewordings for clarity.

Not changed:
- I haven't included an exhaustive list of differences, advantages, etc,
  between KUnit and kselftest: for now, the doc continues to focus on
  the difference between 'in-kernel' and 'userspace' testing here.
- Similarly, I'm not linking out to docs defining and describing "Unit"
  tests versus "End-to-end" tests. None of the existing documentation
  elsewhere quite matches what we do in the kernel perfectly, so it
  seems less confusing to focus on the 'in-kernel'/'userspace'
  distinction, and leave other definitions as a passing mention for
  those who are already familiar with the concepts.
- I haven't linked to any talk videos here: a few of them are linked on
  (e.g.) the KUnit webpage, but I wanted to keep the Kernel documentation
  more self-contained for now. No objection to adding them in a follow-up
  patch if people feel strongly about it, though.
- The link from index.rst to this doc is unchanged. I personally think
  that the link is prominent enough there: it's the first link, and
  shows up a few times. One possibility if people disagreed would be to
  merge this page with the index, but given not all dev-tools are going
  to be testing-related, it seemed a bit arrogant. :-)

 Documentation/dev-tools/index.rst            |   3 +
 Documentation/dev-tools/testing-overview.rst | 117 +++++++++++++++++++
 2 files changed, 120 insertions(+)
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
index 000000000000..ce36a8cdf6b5
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
mhow
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
+detect classes of issues when the occur in a running kernel. These typical=
ly
+look for undefined behaviour of some kind, such as invalid memory accesses=
,
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
+running tests on a kernel with a sanitizer enabled: you can then be sure
+that none of these errors are occurring during the test.
+
+Some of these tools integrate with KUnit or kselftest and will
+automatically fail tests if an issue is detected.
+
--=20
2.31.1.295.g9ea45b61b8-goog

